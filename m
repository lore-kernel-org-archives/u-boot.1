Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEB7D462B9
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 15:10:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F1308959A;
	Wed, 13 Nov 2024 16:10:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hMthygQm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E360689021; Wed, 13 Nov 2024 16:10:12 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C76B08959A
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 16:10:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a70315d38dso11907265ab.0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 07:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731510609; x=1732115409; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vTPDLE/T6Ad2Vmomi/v6GFKTFha5+3wxQwLkFItLYKg=;
 b=hMthygQmARQyKGRKOFCdy1A9AQqrmFU434QsX03nn2rN7M+anEsFBWMxcnrijFZCea
 MX9DIPHqUnoRbzn3eWClTLDlFpdy/9e2hMYAvoDAZ7/U3NWrDjuHPWP/OxomEfFZQFyu
 YzU6mE2BDIMCPsHlWws9KCTbOzD9tI9+viT+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731510609; x=1732115409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vTPDLE/T6Ad2Vmomi/v6GFKTFha5+3wxQwLkFItLYKg=;
 b=syqmeY+rIS/3dcsPDgJKrLFWRYCbglYnMXn9CawbfKv8vgk4DojrLBgaIG2V1PxQKB
 Q/Kk1jgXos6H5kKCsZxckiUW3Y/BCUbTtQdHpj3jnBKPxmM6Kyvm7bC3v5QLpHAmqmKg
 R8hHSDDqFudJbw/qm3Qv0CoOuLXwhy116b3eu33h9n8aVYbUrZ5vSLo1VO4fHVkqQ5R9
 Skscsm8uTx7z5i/k0PeR12z1Uqv47nboP1rbKkSBE1U4jncLBy6XEwaAziUIPtQyF75O
 PnZFMnmZ1XQASGva1Yjiwvb26CIuv3Od+7Iid9efrVtjI4CT2hnoNYk4lVod1hDyVZEv
 54aQ==
X-Gm-Message-State: AOJu0Yw4d4+AYuYtiimzNHCrrBOwcEyBbg1Cirr1UC7pffMf+UZ/zgtg
 QdxF4KkFZBBO3HfdavT3gyjmO7diNpDPnx3Xp+rS31h7gjw5opCZoHj5OF+/sQFaMOdtVbZZzTc
 =
X-Google-Smtp-Source: AGHT+IF7UznytYSCmotZAGPj5smybuRekpfZf2Ku5CxSlEI/AJwPfFdZ8ii8yBvYVx1MPmHMmO7g7w==
X-Received: by 2002:a92:c264:0:b0:3a0:a71b:75e5 with SMTP id
 e9e14a558f8ab-3a6f1a039damr230848225ab.7.1731510608873; 
 Wed, 13 Nov 2024 07:10:08 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a719d6b62fsm2710105ab.18.2024.11.13.07.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:10:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Alex Shumsky <alexthreed@gmail.com>,
 Bryan Brattlof <bb@ti.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Janne Grunau <j@jannau.net>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>,
 Ramon Fried <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 7/8] env: Provide a work-around for unquoting fdtfile
Date: Wed, 13 Nov 2024 08:09:37 -0700
Message-Id: <20241113150938.1534931-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113150938.1534931-1-sjg@chromium.org>
References: <20241113150938.1534931-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Some boards use a CONFIG option to specify the value of this variable.
This is normally handled by efi_get_distro_fdt_name() but in the case
of sunxi this does not work, since 'soc' is sunxi, but the files are
in the allwinner directory.

Provide a work-around for this particular case.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Fix 'supressed' typo
- Use backquotes to highlight DEFAULT_DEVICE_TREE

 Makefile                  |  1 +
 doc/usage/environment.rst | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Makefile b/Makefile
index 81b73a1d8d9..07529e0bc4f 100644
--- a/Makefile
+++ b/Makefile
@@ -1861,6 +1861,7 @@ quiet_cmd_gen_envp = ENVP    $@
 		$(CPP) -P $(cpp_flags) -x assembler-with-cpp -undef \
 			-D__ASSEMBLY__ \
 			-D__UBOOT_CONFIG__ \
+			-DDEFAULT_DEVICE_TREE=$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE)) \
 			-I . -I include -I $(srctree)/include \
 			-include linux/kconfig.h -include include/config.h \
 			-I$(srctree)/arch/$(ARCH)/include \
diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
index 7bd9ffce8d8..1ab3ee7ced9 100644
--- a/doc/usage/environment.rst
+++ b/doc/usage/environment.rst
@@ -87,6 +87,18 @@ settings. For example::
 
    #include <env/ti/mmc.env>
 
+Quotes are not suppressed, for example::
+
+    fdtfile=CONFIG_DEFAULT_DEVICE_TREE.dtb
+    # produces: fdtfile="sun7i-a20-pcduino3.dtb"
+
+For this particular issue you can use ``DEFAULT_DEVICE_TREE`` instead::
+
+    fdtfile=DEFAULT_DEVICE_TREE.dtb
+    # produces: fdtfile=sun7i-a20-pcduino3.dtb
+
+There is no general way to remove quotes.
+
 If CONFIG_ENV_SOURCE_FILE is empty and the default filename is not present, then
 the old-style C environment is used instead. See below.
 
-- 
2.34.1


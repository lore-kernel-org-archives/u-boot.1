Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF65C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5580588D1B;
	Mon,  2 Sep 2024 00:27:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CuRIh4or";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D1B0889FC; Mon,  2 Sep 2024 00:27:53 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0719388CF0
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:27:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-82a245753bfso121721239f.3
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229669; x=1725834469; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ppXySfOHv1nMJoKJ+QM6YwRuhCi4lZtlTlLoTXhR4ds=;
 b=CuRIh4or47kCEoFvwxeKosxLdL6uke/K6iauNmcxNSX4fkp1nXZCYraeoOnrbrMRbt
 S4ixIDioJRfv4wr+uOL8Kl0GLB5H+UQeNrgbYGnvFHd5S2mBISq3TP4wDr/EeqTYZYBb
 NeRaH7IoIkOux7ffLxvzJRMYaOYI9B6A8XjYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229669; x=1725834469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ppXySfOHv1nMJoKJ+QM6YwRuhCi4lZtlTlLoTXhR4ds=;
 b=s4MI1+179PCiHL2g/DIcPL0gZKpfoP4Xcx4YeHgAG2ndlnzMwd1hA5nl0TIWcacMsi
 2FymqMiGx9SGfzX8io8ICYnsjURdko3DhnHzYZMU/bpTQj+yYMSLi1ejk3zTfP3fNgpV
 8Ytoamek412i9ec0GtSfRAmDM1fGIqxpTsmJOid1ORvzaeXdJRl+AaC6VTxdxo/MK3HH
 YI5w6gKARZooG8DOpmiIAZv0hzNDubuRfVVZ5S+VvuYsqKEbnthnrIgY0Z4Cc2ayednf
 o3wNxo67ak8H48VHGPCzXoxkaFZoesWkqRnT2oBqVq9obTb4QdPTSNBo+ex8IWfgZoZT
 mbPw==
X-Gm-Message-State: AOJu0YyebchWRrd+JdlKpjVVejKH6lieC5sOZnutjmSCuD4RJINMrv7d
 +OK/EEeV1XjALG7PxHo0D4Q7QJTgstXcPtEGvHD0Xe86REkPsTj5qdJLqAZnuNjM1mBR9tvjcRE
 =
X-Google-Smtp-Source: AGHT+IEizC4EZukcmX12UdohIIx4Erm4KnvocAZqKGqjsrRNuMa2Rgq2VwG/ecDvB34ZW3uNj8Qb2g==
X-Received: by 2002:a05:6602:3413:b0:82a:1cdf:2c37 with SMTP id
 ca18e2360f4ac-82a1cdf3607mr1457243639f.12.1725229669201; 
 Sun, 01 Sep 2024 15:27:49 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2e17bb4sm1866981173.82.2024.09.01.15.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:27:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>
Subject: [PATCH v3 7/8] env: Provide a work-around for unquoting fdtfile
Date: Sun,  1 Sep 2024 16:27:33 -0600
Message-Id: <20240901222734.462334-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901222734.462334-1-sjg@chromium.org>
References: <20240901222734.462334-1-sjg@chromium.org>
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

Changes in v3:
- Fix 'supressed' typo
- Use backquotes to highlight DEFAULT_DEVICE_TREE

 Makefile                  |  1 +
 doc/usage/environment.rst | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Makefile b/Makefile
index 9a52cc8d0b4..2452a916244 100644
--- a/Makefile
+++ b/Makefile
@@ -1844,6 +1844,7 @@ quiet_cmd_gen_envp = ENVP    $@
 		$(CPP) -P $(cpp_flags) -x assembler-with-cpp -undef \
 			-D__ASSEMBLY__ \
 			-D__UBOOT_CONFIG__ \
+			-DDEFAULT_DEVICE_TREE=$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE)) \
 			-I . -I include -I $(srctree)/include \
 			-include linux/kconfig.h -include include/config.h \
 			-I$(srctree)/arch/$(ARCH)/include \
diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
index cc33d3ec0f2..379125a1982 100644
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


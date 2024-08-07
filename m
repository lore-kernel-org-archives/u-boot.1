Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEBAC52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 20:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5827888C8E;
	Wed,  7 Aug 2024 22:50:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BMcS0ucF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C561388BE9; Wed,  7 Aug 2024 22:50:47 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9D3B88C02
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 22:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-39b2da8537dso4463805ab.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 13:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723063844; x=1723668644; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pvCEEbTgKJezwSYpYVlch+PBynaVh4AIMuVWwBauv6Y=;
 b=BMcS0ucF49bSn9VlhXJphYafgaS6Ay0McqahlElrTYS/oC8EdzdxsjhvS/p1QutI0r
 PvU48jCDvJGS2BUueYuxAb4zltoBrtpcda8NpFWKbMZSA7ri8W1WYgxakLHbYOvsw4dx
 9FgJENAQvjrmFwgEy1/gu2bs2kVclmtYMhGDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723063844; x=1723668644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pvCEEbTgKJezwSYpYVlch+PBynaVh4AIMuVWwBauv6Y=;
 b=cQwpDXHbHo9ezjxNbjPPJyO6GW7h9XkgnCeBBe1VEBkt5awi6lN/L9FIBAPp1ahbSc
 KiN/TsdHLUQP63b7yYAFtxwKrgEBS/wEAvZrp76w5bP6DYOb9R/ARdotQWiaGX/LUiy2
 6sZZ/cYwaQ7vwqHThRJK5HzEPIMfq1Hj2DCC5UzSJIdZCfByA/W9WHsduo1YmRxgRwCm
 4/O4N24KNLDZ/dMmgf2XhUTf0p5eDtVvWnzSJNbjcMCn/uhwRcDv8iCl/vs0a8I7KT06
 Neww4n/A6iN0Hnb2NhLPOtVeq1ZXmsnx97lZMCOcKTVIU9xwaHW65AgiJdyQwpOvDXRR
 +mXw==
X-Gm-Message-State: AOJu0Yz1k+OGHZOamMFbX1GTU0ZxshXdeYI3Jnq6TXXRv5LxiA+0AoFu
 4Js80lJKLIRlfbAhcYHIASGmvtONHaORJiuaj3w2LO/pLktihf8II3uZaE4NLlutr86C3UIGA4w
 =
X-Google-Smtp-Source: AGHT+IGWfLBilwtOq7o4q7Qzt93Ke6aVAWLFlR+TamZcmBDs466LZPiMKkRTstW3eSb0IwrUIH3imA==
X-Received: by 2002:a05:6e02:1b06:b0:399:4525:c2bc with SMTP id
 e9e14a558f8ab-39b545654e7mr30672385ab.10.1723063844310; 
 Wed, 07 Aug 2024 13:50:44 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d6988421sm2912581173.32.2024.08.07.13.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 13:50:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Janne Grunau <j@jannau.net>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 5/6] env: Provide a work-around for unquoting fdtfile
Date: Wed,  7 Aug 2024 14:50:31 -0600
Message-Id: <20240807205032.3745680-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807205032.3745680-1-sjg@chromium.org>
References: <20240807205032.3745680-1-sjg@chromium.org>
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

 Makefile                  |  1 +
 doc/usage/environment.rst | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Makefile b/Makefile
index 2861b4d1402..8ea3308160f 100644
--- a/Makefile
+++ b/Makefile
@@ -1842,6 +1842,7 @@ quiet_cmd_gen_envp = ENVP    $@
 		$(CPP) -P $(CFLAGS) -x assembler-with-cpp -undef \
 			-D__ASSEMBLY__ \
 			-D__UBOOT_CONFIG__ \
+			-DDEFAULT_DEVICE_TREE=$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE)) \
 			-I . -I include -I $(srctree)/include \
 			-include linux/kconfig.h -include include/config.h \
 			-I$(srctree)/arch/$(ARCH)/include \
diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
index cc33d3ec0f2..eaebf61742a 100644
--- a/doc/usage/environment.rst
+++ b/doc/usage/environment.rst
@@ -87,6 +87,18 @@ settings. For example::
 
    #include <env/ti/mmc.env>
 
+Quotes are not supressed, for example::
+
+    fdtfile=CONFIG_DEFAULT_DEVICE_TREE.dtb
+    # produces: fdtfile="sun7i-a20-pcduino3.dtb"
+
+For this particular issue you can use DEFAULT_DEVICE_TREE instead::
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


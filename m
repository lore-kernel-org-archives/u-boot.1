Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1C6CDB465
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F17486E84;
	Thu, 12 Oct 2023 04:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GsRyqznX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 629BA86E69; Thu, 12 Oct 2023 04:00:09 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 576FA86E47
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-776f84c6cc7so29332785a.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075799; x=1697680599; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCXFzbuxJr2N8yNhXYYi1pKmux+ElD7fZsgZbcw+MDM=;
 b=GsRyqznXBdYLGGn3E0e7k5AdJOVU1s6px1RpyH8Ooc4hrbRHArb+MgZl6evosZEbHO
 Z6PBF+FzmvkiAu4CfoKKNfm83m21yyV52MxGADoofL2Sp/OvwEqMt+LL52eMgBXLMSTj
 H2O1VjPeHT2FCe7wefdUvrteB2AW7PU1DCfiWrmh1TdkJMe78oa1/W64sUmOgfQEbuU6
 t+ldtf+09bSJu+XTdI5c5gXaUNpCedBdL3mkgc2O9VVIdn2kTTRU2TyCl/y8JdsVKY8w
 8jVXSJlDWpaTfONTCJywB9oXeV7zH4T7JGPQk2kXZrPQKIrPv/0dQxeFr/Mj3J94twE+
 omxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075799; x=1697680599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RCXFzbuxJr2N8yNhXYYi1pKmux+ElD7fZsgZbcw+MDM=;
 b=Bw0P7qSeSoxAoO0jvsbPM4Kc/gUDrcmRnVP6BxQLYFEk9bW7RHu23VZLSENp1rphIf
 HK37xQIwuntvj9bPdkC/zRyeb7woKKijuQn1HiREadYpztl5LABlToYFeoG0w4/fhFWB
 jhdQFC0GrfwdUUs82UVeancISC2kEm9OupiA+ljNO1jTMAUeViEhSx5SAl24vOGvrz+1
 FiBOMFOyTdomqsnaOYG3kO7y222Y0KicNp+1TW3WGL4dyo0nzuSqnc92+aq89XlnwrpK
 kXcwTXhcT6++ytN9iK/HN01UeyasA+yhdsvUjH36F5J02ueKNqjWTYod/PEkwq4oU+NO
 HG3A==
X-Gm-Message-State: AOJu0YwH01oa7PQ8+fGw041tvLI3/Shk1MdqUixopeITXXLw3rnDTbHr
 zD0+CW2VOoBtIjKgWgrS2yNpc2LBoyLB8Q==
X-Google-Smtp-Source: AGHT+IHdgwkY7davHVPXYFDNU4e32uZAArJZN0Nrc8DtLxCt5v6Y17kNjpXt8AzUR24Ry//1jiNwog==
X-Received: by 2002:a05:620a:46a3:b0:767:261d:1ef6 with SMTP id
 bq35-20020a05620a46a300b00767261d1ef6mr27179537qkb.59.1697075799285; 
 Wed, 11 Oct 2023 18:56:39 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 v9-20020ae9e309000000b0076d25b11b62sm5659787qkf.38.2023.10.11.18.56.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 18:56:38 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Heiko Schocher <hs@denx.de>
Subject: [PATCH 09/26] spl: Allow enabling SPL_OF_REAL and SPL_OF_PLATDATA at
 the same time
Date: Wed, 11 Oct 2023 21:56:09 -0400
Message-Id: <20231012015626.3487451-10-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231012015626.3487451-1-seanga2@gmail.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
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

Sandbox unit tests in U-Boot proper load a test device tree to have some
devices to work with. In order to do the same in SPL, we must enable
SPL_OF_REAL. However, we already have SPL_OF_PLATDATA enabled. When
generating platdata from a devicetree, it is expected that we will not need
devicetree access functions (even though SPL_OF_CONTROL is enabled). This
expectation does not hold for sandbox, so allow user control of
SPL_OF_REAL.

There are several places in the tree where conditions involving OF_PLATDATA
or OF_REAL no longer function correctly when both of these options can be
selected at the same time. Adjust these conditions accordingly.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 drivers/core/Makefile               | 1 +
 drivers/i2c/i2c-emul-uclass.c       | 2 +-
 drivers/serial/sandbox.c            | 2 +-
 drivers/sysreset/sysreset_sandbox.c | 2 +-
 dts/Kconfig                         | 8 +++++---
 test/test-main.c                    | 2 +-
 6 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/core/Makefile b/drivers/core/Makefile
index bce0a3f65cb..acbd2bf2cef 100644
--- a/drivers/core/Makefile
+++ b/drivers/core/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_$(SPL_)OF_LIVE) += of_access.o of_addr.o
 ifndef CONFIG_DM_DEV_READ_INLINE
 obj-$(CONFIG_OF_CONTROL) += read.o
 endif
+obj-$(CONFIG_$(SPL_)OF_PLATDATA) += read.o
 obj-$(CONFIG_OF_CONTROL) += of_extra.o ofnode.o read_extra.o
 
 ccflags-$(CONFIG_DM_DEBUG) += -DDEBUG
diff --git a/drivers/i2c/i2c-emul-uclass.c b/drivers/i2c/i2c-emul-uclass.c
index 1107cf309fc..d421ddfcbe2 100644
--- a/drivers/i2c/i2c-emul-uclass.c
+++ b/drivers/i2c/i2c-emul-uclass.c
@@ -46,7 +46,7 @@ int i2c_emul_find(struct udevice *dev, struct udevice **emulp)
 	struct udevice *emul;
 	int ret;
 
-	if (!CONFIG_IS_ENABLED(OF_PLATDATA)) {
+	if (CONFIG_IS_ENABLED(OF_REAL)) {
 		ret = uclass_find_device_by_phandle(UCLASS_I2C_EMUL, dev,
 						    "sandbox,emul", &emul);
 	} else {
diff --git a/drivers/serial/sandbox.c b/drivers/serial/sandbox.c
index f4003811ee7..f6ac3d22852 100644
--- a/drivers/serial/sandbox.c
+++ b/drivers/serial/sandbox.c
@@ -280,7 +280,7 @@ U_BOOT_DRIVER(sandbox_serial) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-#if CONFIG_IS_ENABLED(OF_REAL)
+#if CONFIG_IS_ENABLED(OF_REAL) && !CONFIG_IS_ENABLED(OF_PLATDATA)
 static const struct sandbox_serial_plat platdata_non_fdt = {
 	.colour = -1,
 };
diff --git a/drivers/sysreset/sysreset_sandbox.c b/drivers/sysreset/sysreset_sandbox.c
index 3750c60b9b9..f485a135299 100644
--- a/drivers/sysreset/sysreset_sandbox.c
+++ b/drivers/sysreset/sysreset_sandbox.c
@@ -132,7 +132,7 @@ U_BOOT_DRIVER(warm_sysreset_sandbox) = {
 	.ops		= &sandbox_warm_sysreset_ops,
 };
 
-#if CONFIG_IS_ENABLED(OF_REAL)
+#if CONFIG_IS_ENABLED(OF_REAL) && !CONFIG_IS_ENABLED(OF_PLATDATA)
 /* This is here in case we don't have a device tree */
 U_BOOT_DRVINFO(sysreset_sandbox_non_fdt) = {
 	.name = "sysreset_sandbox",
diff --git a/dts/Kconfig b/dts/Kconfig
index 9152f5885e9..c6fb193ca89 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -410,12 +410,14 @@ config SPL_OF_PLATDATA
 	  declarations for each node. See of-plat.txt for more information.
 
 config SPL_OF_REAL
-	bool
+	bool "Support a real devicetree in SPL"
+	depends on SPL_OF_CONTROL
+	select SPL_OF_LIBFDT
 	help
 	  Indicates that a real devicetree is available which can be accessed
 	  at runtime. This means that dev_read_...() functions can be used to
-	  read data from the devicetree for each device. This is true if
-	  SPL_OF_CONTROL is enabled and not SPL_OF_PLATDATA
+	  read data from the devicetree for each device. You do not need to
+	  enable this option if you have enabled SPL_OF_PLATDATA.
 
 if SPL_OF_PLATDATA
 
diff --git a/test/test-main.c b/test/test-main.c
index edb20bc4b9c..b7015d9f38d 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -303,7 +303,7 @@ static int test_pre_run(struct unit_test_state *uts, struct unit_test *test)
 	if (test->flags & UT_TESTF_PROBE_TEST)
 		ut_assertok(do_autoprobe(uts));
 
-	if (!CONFIG_IS_ENABLED(OF_PLATDATA) &&
+	if (CONFIG_IS_ENABLED(OF_REAL) &&
 	    (test->flags & UT_TESTF_SCAN_FDT)) {
 		/*
 		 * only set this if we know the ethernet uclass will be created
-- 
2.37.1


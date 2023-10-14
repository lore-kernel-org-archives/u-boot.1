Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496DBCDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:49:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CA2A86EF6;
	Sun, 15 Oct 2023 09:23:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TsFAAnr6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 766A086EF6; Sun, 15 Oct 2023 09:23:41 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68E8B86F0B
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7741c2fae49so249710085a.0
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697354588; x=1697959388; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F4Iw0UZxZRLT7EjYaV4XtTyTfUZpRkPf1u/cWqAXjVU=;
 b=TsFAAnr63w0g3gTllbqb+/AA3YMNKl1WkJry5pMUbkNLSbzJlFGqrRYkNXpdWdqzcb
 zse8yz8+Tk1emNif91f0mtyfOiZCb8Ni+M6IYByrVNgn1sr4IuPqIP5pLSBr/d8uWwSQ
 dgpqcjj3A28d2JLYQDzLZpNmvue5nDHtfrxqyCHqKh2sIl2pI7dULQrU99ZKHRun27rC
 QfmG2E7tooa2s1iqGlrkrMTFG1f3Y2jOn7OMu5DyHUWQTN1OVQproRH/20H/wC/aQZ40
 ynrGz/upOkDWzehRLZv0YmOI450+/EDGBY+geG4GU51THJRJcUy/+ghl/4HjVuOY0yC+
 Vswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697354588; x=1697959388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F4Iw0UZxZRLT7EjYaV4XtTyTfUZpRkPf1u/cWqAXjVU=;
 b=hAFAdILBKM9SXqCZH/NcVMQurf5ZXf4GM1eOY4oKV3ELk1XsZllpYq5czsQyzUus/T
 yBoxf+5rcPgw3BHp1i0kwBvXVQmzOvIdQ4AlijvXUkOwJKP4duvw8QFBsXjx7iIuxRJX
 yM2GggRF9dWmEYGCEcPfc0EJVd5tu23NfEA3d0H24Ne43a8jx9116zPje/lETkzRBblb
 vqPRztRaR9TEhu/3MMG6+wlafuDjphROB5ZvY6gU37OF26eFha/bAoxssI0CdckBQSBx
 +vSqhS31vjUtqJa3qPt5sNmeS77B+Afdu0DSOalD0mZYC/MxTY2S6CFjrkiQ98mjR5wE
 V/Iw==
X-Gm-Message-State: AOJu0YzyUY/XE/weWJIvE5s4h3v6wkZ9Ee+dCIl7Gh+RUHW27+RQ56q0
 TXmUN2C7hTsDSHKTKL5hf6GgYuPNHGCfgA==
X-Google-Smtp-Source: AGHT+IEwDRtI8P0VqOAaq2v+BdQHQwWjdKrWZOsMlDl+iFLyFoDu3eaGedW/QM38GW//J0C5n9qPKQ==
X-Received: by 2002:a05:620a:24cf:b0:775:c0b9:2a9d with SMTP id
 m15-20020a05620a24cf00b00775c0b92a9dmr36079339qkn.57.1697316499671; 
 Sat, 14 Oct 2023 13:48:19 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 pa5-20020a05620a830500b00767d6ec578csm1713958qkn.20.2023.10.14.13.48.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 13:48:19 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>, Heiko Schocher <hs@denx.de>
Subject: [PATCH v2 10/29] spl: Allow enabling SPL_OF_REAL and SPL_OF_PLATDATA
 at the same time
Date: Sat, 14 Oct 2023 16:47:46 -0400
Message-Id: <20231014204805.439009-11-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231014204805.439009-1-seanga2@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Hide SPL_OF_REAL unless SANDBOX is enabled

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
index 9152f5885e9..00c0aeff893 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -410,12 +410,14 @@ config SPL_OF_PLATDATA
 	  declarations for each node. See of-plat.txt for more information.
 
 config SPL_OF_REAL
-	bool
+	bool "Support a real devicetree in SPL" if SANDBOX
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


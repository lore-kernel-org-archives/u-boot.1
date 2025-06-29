Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394BEC7EE30
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 11:02:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5065E82F35;
	Sun, 29 Jun 2025 13:02:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iEo/QgUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEE5382E5A; Sun, 29 Jun 2025 13:02:22 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0B5F8277D
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 13:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-55511c3e203so1173000e87.3
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 04:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751194936; x=1751799736; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Weq2Xiwa33SZC3BX8ZDwMHpougeq6yI/sFWSSPKDjsQ=;
 b=iEo/QgUZiMyhShyn0nm5gJT1pWp29ESYGsYsfDVvNFuIJDbff/9jOdam12GS4H0RrL
 rLwUOktaP9Aia1AkwNR1I99B/ihWO0LJQIWSSn+nX4Ig1pZX0KItc5oNCkW5BENtpldF
 mREebS7lWseVdqe5kdq1UPQSLs4x35fzVGU8vySCyEqy04LPm8ljbd8bzK4MqRbq14n2
 r7moix0Cxrlc87WiuH3vBrUDw0Y3SmtnTMflZX2cYll8OvF5CNIJGbxwERrQRX7mZZws
 6i+VsEeKJl3OCUdOFQ9wlGgE5J2QA+4ZfJkyPTaAdO0FBQ+8ohFy1gyiXelieeZ/5W0i
 Ledw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751194936; x=1751799736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Weq2Xiwa33SZC3BX8ZDwMHpougeq6yI/sFWSSPKDjsQ=;
 b=ChRpfuxqrSqxBD2eB9kE2eBpgGXeiNH7O5/WvL23SDJWfGm/kwKAP7oQx0YiJ0/n1/
 Di6qS7pIA5Rb49S3di3eaxPg8GjDj6NaoGW2+mK15HQBqiCRLXvLh5gE+5EjZD6q/CX1
 xOO4h8WwWx3CxN8cVh/3yUYLYc+ZiR3Rvr1AldceY48tXxDbStrQJGcKyAaB14OfFH+w
 MKh4+EzIGuRNK//aAD5XDDIdChDGFKUiMtj6ox3dmMeNRe5RenCgADLO4wGUdTxBdOPU
 KwMOYJuzy+P3THL7W+Uo42R5PIhAm0q2gEPFpSDJUN/J8FYvOe2IKyAqtjPtRYbGGphF
 Z88Q==
X-Gm-Message-State: AOJu0Yyxn97NjICxfpz9+hIdjvfQ6HE+d1LiWaez3NjMFH2aNjHl/5IN
 QiwnUwd2zSYW+4Es8FglA1JtU57jQpd9VRg7McTUmjeuQ0mgF7ysZAzY
X-Gm-Gg: ASbGncsFyXXkJ5ZPYoAtlM2azUa4om/4ZoJt3EW3Bnk7VgEOQF7kKixVmMfJv0YXguu
 yo0AM0lpNgaXiFZ0KhXJfe4Tq5VkCnvyUhH19ghO0K0Hz7b5VIVlodUC3JhsiCKV3PN+VVGdYfy
 H+oiFl8hAfcPDazV80Livo5JDj+SyWBlyIgbxVfoRO28VLjasSamo0gOw5rAzI+xfWqu7THFwM1
 DO4/iiLkm2Sx2z/W52mhXzY79W1d/a9xq0xno0tM8lkK7GYzh62f8BzPCTQ4KyJI62wGpK3jilW
 iBlNP1H2VSamSK/v3JNf3/ZAjx2FsjIs5Uys556tON9AQ0N28xTggQ==
X-Google-Smtp-Source: AGHT+IEEOOLl6llCRGFgW/zGLO4xkSze2e5TY1IdwyyKE4oKK7Hn9/b2U58nejyPJ8yVfQxYWkTjcg==
X-Received: by 2002:a05:6512:33cd:b0:553:a32a:6ca with SMTP id
 2adb3069b0e04-5550b897588mr3959750e87.32.1751194935807; 
 Sun, 29 Jun 2025 04:02:15 -0700 (PDT)
Received: from xeon.. ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5550b24028esm1090621e87.19.2025.06.29.04.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 04:02:15 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Ion Agorria <ion@agorria.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/6] ARM: tegra: Relocate fuse code from warmboot file
Date: Sun, 29 Jun 2025 14:01:58 +0300
Message-ID: <20250629110203.25086-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250629110203.25086-1-clamor95@gmail.com>
References: <20250629110203.25086-1-clamor95@gmail.com>
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

From: Ion Agorria <ion@agorria.com>

Move a set of helpers used in warmboot code to more appropriate AP and FUSE
locations.

Signed-off-by: Ion Agorria <ion@agorria.com>
---
 arch/arm/include/asm/arch-tegra/ap.h       |  7 ++
 arch/arm/include/asm/arch-tegra/fuse.h     | 21 ++++++
 arch/arm/include/asm/arch-tegra/warmboot.h |  6 --
 arch/arm/mach-tegra/ap.c                   |  8 +++
 arch/arm/mach-tegra/cpu.h                  |  1 +
 arch/arm/mach-tegra/fuse.c                 | 63 +++++++++++++++++-
 arch/arm/mach-tegra/tegra20/warmboot.c     | 75 +---------------------
 7 files changed, 98 insertions(+), 83 deletions(-)

diff --git a/arch/arm/include/asm/arch-tegra/ap.h b/arch/arm/include/asm/arch-tegra/ap.h
index b922b2d30ea..295c3287737 100644
--- a/arch/arm/include/asm/arch-tegra/ap.h
+++ b/arch/arm/include/asm/arch-tegra/ap.h
@@ -54,6 +54,13 @@ int tegra_get_chip_sku(void);
  */
 int tegra_get_chip(void);
 
+/**
+ * Returns the pure SOC major version from the HIDREV register
+ *
+ * Return:	SOC major version
+ */
+u32 tegra_get_major_version(void);
+
 /**
  * Returns the SKU ID from the sku_info register
  *
diff --git a/arch/arm/include/asm/arch-tegra/fuse.h b/arch/arm/include/asm/arch-tegra/fuse.h
index f3f2ad8e3f2..631ebbb283c 100644
--- a/arch/arm/include/asm/arch-tegra/fuse.h
+++ b/arch/arm/include/asm/arch-tegra/fuse.h
@@ -17,8 +17,22 @@ struct fuse_regs {
 	u32 fa;				/* 0x148: FUSE_FA */
 	u32 reserved3[21];		/* 0x14C - 0x19C: */
 	u32 security_mode;		/* 0x1A0: FUSE_SECURITY_MODE */
+	u32 sbk[4];			/* 0x1A4 - 0x1B4 */
 };
 
+/* Defines the supported operating modes */
+enum fuse_operating_mode {
+	MODE_UNDEFINED = 0,
+	MODE_PRODUCTION = 3,
+	MODE_ODM_PRODUCTION_SECURE = 4,
+	MODE_ODM_PRODUCTION_OPEN = 5,
+};
+
+/**
+ * Initializes fuse hardware
+ */
+void tegra_fuse_init(void);
+
 /**
  * Calculate SoC UID
  *
@@ -26,4 +40,11 @@ struct fuse_regs {
  */
 unsigned long long tegra_chip_uid(void);
 
+/**
+ * Gives the current operating mode from fuses
+ *
+ * @return current operating mode
+ */
+enum fuse_operating_mode tegra_fuse_get_operation_mode(void);
+
 #endif	/* ifndef _FUSE_H_ */
diff --git a/arch/arm/include/asm/arch-tegra/warmboot.h b/arch/arm/include/asm/arch-tegra/warmboot.h
index 9a53456370f..402f93aac48 100644
--- a/arch/arm/include/asm/arch-tegra/warmboot.h
+++ b/arch/arm/include/asm/arch-tegra/warmboot.h
@@ -10,12 +10,6 @@
 #define STRAP_OPT_A_RAM_CODE_SHIFT	4
 #define STRAP_OPT_A_RAM_CODE_MASK	(0xf << STRAP_OPT_A_RAM_CODE_SHIFT)
 
-/* Defines the supported operating modes */
-enum fuse_operating_mode {
-	MODE_PRODUCTION = 3,
-	MODE_UNDEFINED,
-};
-
 /* Defines the CMAC-AES-128 hash length in 32 bit words. (128 bits = 4 words) */
 enum {
 	HASH_LENGTH = 4
diff --git a/arch/arm/mach-tegra/ap.c b/arch/arm/mach-tegra/ap.c
index f35bdba4d48..a7938ed7910 100644
--- a/arch/arm/mach-tegra/ap.c
+++ b/arch/arm/mach-tegra/ap.c
@@ -37,6 +37,14 @@ int tegra_get_chip(void)
 	return rev;
 }
 
+u32 tegra_get_major_version(void)
+{
+	struct apb_misc_gp_ctlr *gp =
+		(struct apb_misc_gp_ctlr *)NV_PA_APB_MISC_GP_BASE;
+
+	return (readl(&gp->hidrev) & HIDREV_MAJORPREV_MASK) >> HIDREV_MAJORPREV_SHIFT;
+}
+
 int tegra_get_sku_info(void)
 {
 	int sku_id;
diff --git a/arch/arm/mach-tegra/cpu.h b/arch/arm/mach-tegra/cpu.h
index 006aae3d070..5477423f4d0 100644
--- a/arch/arm/mach-tegra/cpu.h
+++ b/arch/arm/mach-tegra/cpu.h
@@ -71,6 +71,7 @@ void powerup_cpu(void);
 void reset_A9_cpu(int reset);
 void start_cpu(u32 reset_vector);
 int tegra_get_chip(void);
+u32 tegra_get_major_version(void);
 int tegra_get_sku_info(void);
 int tegra_get_chip_sku(void);
 void adjust_pllp_out_freqs(void);
diff --git a/arch/arm/mach-tegra/fuse.c b/arch/arm/mach-tegra/fuse.c
index e9b5259ac70..abdf6504161 100644
--- a/arch/arm/mach-tegra/fuse.c
+++ b/arch/arm/mach-tegra/fuse.c
@@ -39,7 +39,7 @@ static u32 tegra_fuse_readl(unsigned long offset)
 	return readl(NV_PA_FUSE_BASE + offset);
 }
 
-static void tegra_fuse_init(void)
+void tegra_fuse_init(void)
 {
 	u32 reg;
 
@@ -49,8 +49,11 @@ static void tegra_fuse_init(void)
 	 * this bit fuse region will not work.
 	 */
 	reg = readl_relaxed(NV_PA_CLK_RST_BASE + 0x48);
-	reg |= BIT(28);
-	writel(reg, NV_PA_CLK_RST_BASE + 0x48);
+
+	if (reg & BIT(28))
+		return;
+
+	writel(reg | BIT(28), NV_PA_CLK_RST_BASE + 0x48);
 
 	clock_enable(PERIPH_ID_FUSE);
 	udelay(2);
@@ -148,3 +151,57 @@ unsigned long long tegra_chip_uid(void)
 
 	return uid;
 }
+
+static int tegra_is_production_mode_fuse_set(struct fuse_regs *fuse)
+{
+	return readl(&fuse->production_mode);
+}
+
+static int tegra_is_odm_production_mode_fuse_set(struct fuse_regs *fuse)
+{
+	return readl(&fuse->security_mode);
+}
+
+static int tegra_is_failure_analysis_mode(struct fuse_regs *fuse)
+{
+	return readl(&fuse->fa);
+}
+
+static int tegra_is_sbk_zeroes(struct fuse_regs *fuse)
+{
+	int i;
+
+	for (i = 0; i < 4; i++)
+		if (readl(&fuse->sbk[i]))
+			return 0;
+
+	return 1;
+}
+
+static int tegra_is_production_mode(struct fuse_regs *fuse)
+{
+	if (!tegra_get_major_version())
+		return 1;
+
+	return !tegra_is_failure_analysis_mode(fuse) &&
+	       tegra_is_production_mode_fuse_set(fuse);
+}
+
+enum fuse_operating_mode tegra_fuse_get_operation_mode(void)
+{
+	struct fuse_regs *fuse = (struct fuse_regs *)NV_PA_FUSE_BASE;
+
+	tegra_fuse_init();
+
+	if (tegra_is_production_mode(fuse)) {
+		if (!tegra_is_odm_production_mode_fuse_set(fuse))
+			return MODE_PRODUCTION;
+		else
+			if (tegra_is_sbk_zeroes(fuse))
+				return MODE_ODM_PRODUCTION_OPEN;
+			else
+				return MODE_ODM_PRODUCTION_SECURE;
+	}
+
+	return MODE_UNDEFINED;
+}
diff --git a/arch/arm/mach-tegra/tegra20/warmboot.c b/arch/arm/mach-tegra/tegra20/warmboot.c
index 18034c83a1c..059388f7231 100644
--- a/arch/arm/mach-tegra/tegra20/warmboot.c
+++ b/arch/arm/mach-tegra/tegra20/warmboot.c
@@ -182,83 +182,10 @@ int warmboot_save_sdram_params(void)
 	return 0;
 }
 
-static u32 get_major_version(void)
-{
-	u32 major_id;
-	struct apb_misc_gp_ctlr *gp =
-		(struct apb_misc_gp_ctlr *)NV_PA_APB_MISC_GP_BASE;
-
-	major_id = (readl(&gp->hidrev) & HIDREV_MAJORPREV_MASK) >>
-			HIDREV_MAJORPREV_SHIFT;
-	return major_id;
-}
-
-static int is_production_mode_fuse_set(struct fuse_regs *fuse)
-{
-	return readl(&fuse->production_mode);
-}
-
-static int is_odm_production_mode_fuse_set(struct fuse_regs *fuse)
-{
-	return readl(&fuse->security_mode);
-}
-
-static int is_failure_analysis_mode(struct fuse_regs *fuse)
-{
-	return readl(&fuse->fa);
-}
-
-static int ap20_is_odm_production_mode(void)
-{
-	struct fuse_regs *fuse = (struct fuse_regs *)NV_PA_FUSE_BASE;
-
-	if (!is_failure_analysis_mode(fuse) &&
-	    is_odm_production_mode_fuse_set(fuse))
-		return 1;
-	else
-		return 0;
-}
-
-static int ap20_is_production_mode(void)
-{
-	struct fuse_regs *fuse = (struct fuse_regs *)NV_PA_FUSE_BASE;
-
-	if (get_major_version() == 0)
-		return 1;
-
-	if (!is_failure_analysis_mode(fuse) &&
-	    is_production_mode_fuse_set(fuse) &&
-	    !is_odm_production_mode_fuse_set(fuse))
-		return 1;
-	else
-		return 0;
-}
-
-static enum fuse_operating_mode fuse_get_operation_mode(void)
-{
-	u32 chip_id;
-	struct apb_misc_gp_ctlr *gp =
-		(struct apb_misc_gp_ctlr *)NV_PA_APB_MISC_GP_BASE;
-
-	chip_id = (readl(&gp->hidrev) & HIDREV_CHIPID_MASK) >>
-			HIDREV_CHIPID_SHIFT;
-	if (chip_id == CHIPID_TEGRA20) {
-		if (ap20_is_odm_production_mode()) {
-			printf("!! odm_production_mode is not supported !!\n");
-			return MODE_UNDEFINED;
-		} else
-			if (ap20_is_production_mode())
-				return MODE_PRODUCTION;
-			else
-				return MODE_UNDEFINED;
-	}
-	return MODE_UNDEFINED;
-}
-
 static void determine_crypto_options(int *is_encrypted, int *is_signed,
 				     int *use_zero_key)
 {
-	switch (fuse_get_operation_mode()) {
+	switch (tegra_fuse_get_operation_mode()) {
 	case MODE_PRODUCTION:
 		*is_encrypted = 0;
 		*is_signed = 1;
-- 
2.48.1


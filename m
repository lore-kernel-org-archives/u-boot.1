Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3D9C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 12:22:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AB6B8708A;
	Sat,  4 Nov 2023 13:20:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lrK5fVvU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 832EA87123; Sat,  4 Nov 2023 07:23:18 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F128A87114
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 07:23:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=iuncuim@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c5b7764016so37168731fa.1
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 23:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699078995; x=1699683795; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gT3s3fv4y+oUVcJhQvo7kdM7PbIM5Y8CKB9grAQgNJk=;
 b=lrK5fVvU61srL635uSRI1D1+N2nZmNX4ZdPguNkPYdyx2z3mFdhKUcuvUFKS6Dw2WB
 k8jQov2Q1yLtIxdhyi4536PmVUj4APUu08Ff+97Q25NL2dIQmA5THuuTZpDTot9UtD/6
 BckhUp/EnHc9tzSWpZGbego9xh3e0mQtxE8zF6CCzIscPFwrClviwH0qunFaZaidoo69
 LGeugHoIYBnWDN0a+hx/rXUiJZ2NC/+oh6nqnTX9G9eX3yCpn50VAHe1GlKm1nDueVfu
 OuRGXRjuz2Z0cwVYvn0zWtSYtBWvm/deMtiqL5qjGGbwSoTXHl09R2eBtk2KAHeJ3va5
 7IlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699078995; x=1699683795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gT3s3fv4y+oUVcJhQvo7kdM7PbIM5Y8CKB9grAQgNJk=;
 b=a9DZckudLyyLqsepD/DJUm1MLbErjt7YIFRZPQ2g+zuo73wWGSvngk8GdtJ69U399X
 y/TwtU26+vGwTrnArX8xs0PGsFhCqHMrEXCsT0e+I+wnVnXHNu5szrLf7cZBnUY5v+eb
 UPQ4zBgmJsQe9IPO0cuxdmka4fy4H6Zr3xLyZCgAPYE33mhFk6Xr2pMMyMXhewPAEinG
 03Ds3zHVc6ySuFeMvLwVQlndmp/9ru5O6nBS5dYgVhNqFK9WtXBQ4/nowaYuO8XPl3wE
 E8X32GvcOoewM/CsMcH+8mLTZFUMkqV/3j1a9SOoRuL4lNHFGhFPyyHr36frQrCBVdty
 vqYg==
X-Gm-Message-State: AOJu0YwEfhWsWeMtSLFzfbFntNSc7BYdCcTn2bJv2jpYrbsnXK8atoqq
 Hk/tMhpju4RkJdA2GpZe/6R8Y48yF7g=
X-Google-Smtp-Source: AGHT+IFuWZkpUCOR3Z7U3Fm8y62okpBX8Rd1z8voYci/KsQsbShtbg7JzmoVHgL2MfcMEnQScD2O7A==
X-Received: by 2002:a2e:9ed4:0:b0:2c6:f173:7d90 with SMTP id
 h20-20020a2e9ed4000000b002c6f1737d90mr5296237ljk.12.1699078994863; 
 Fri, 03 Nov 2023 23:23:14 -0700 (PDT)
Received: from SerialExperiment.lan ([46.251.193.172])
 by smtp.gmail.com with ESMTPSA id
 b18-20020a05651c033200b002bcdbfe36a1sm426123ljp.84.2023.11.03.23.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 23:23:14 -0700 (PDT)
From: Mikhail Kalashnikov <iuncuim@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v3 1/1] sunxi: H616: add LPDDR4 DRAM support
Date: Sat,  4 Nov 2023 09:22:48 +0300
Message-ID: <20231104062248.32938-2-iuncuim@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231104062248.32938-1-iuncuim@gmail.com>
References: <20231104062248.32938-1-iuncuim@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 04 Nov 2023 13:20:38 +0100
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

From: iuncuim <iuncuim@gmail.com>

The H616 SoC family has support for several types of DRAM: DDR3,
LPDDR3, DDR4 and LPDDR4.
At the moment, the driver only supports DDR3 and LPDDR3 memory.
Let's extend the driver to support the LPDDR4 memory. This type
of memory widely used in device with T507(-H) SoC and new orangepi
zero3 with H618.
The compatibility with T507 is not yet complete, because there
is difference in the phy_init array.
The LPDDR4-2133 timings correspond to DRAM Rayson RS1G32LO4D2BDS-53BT
found on the NOR SPI from the Orangepi Zero 3 4GB.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>

---
 .../include/asm/arch-sunxi/dram_sun50i_h616.h |   2 +
 arch/arm/mach-sunxi/Kconfig                   |  17 ++
 arch/arm/mach-sunxi/dram_sun50i_h616.c        | 197 ++++++++++++++----
 arch/arm/mach-sunxi/dram_timings/Makefile     |   1 +
 .../dram_timings/h616_lpddr4_2133.c           |  95 +++++++++
 5 files changed, 277 insertions(+), 35 deletions(-)
 create mode 100644 arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c

diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
index 11774deded..a8fdda124a 100644
--- a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
+++ b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
@@ -130,6 +130,7 @@ check_member(sunxi_mctl_ctl_reg, unk_0x4240, 0x4240);
 #define MSTR_DEVICETYPE_LPDDR2	BIT(2)
 #define MSTR_DEVICETYPE_LPDDR3	BIT(3)
 #define MSTR_DEVICETYPE_DDR4	BIT(4)
+#define MSTR_DEVICETYPE_LPDDR4	BIT(5)
 #define MSTR_DEVICETYPE_MASK	GENMASK(5, 0)
 #define MSTR_2TMODE		BIT(10)
 #define MSTR_BUSWIDTH_FULL	(0 << 12)
@@ -154,6 +155,7 @@ struct dram_para {
 	u32 odt_en;
 	u32 tpr0;
 	u32 tpr2;
+	u32 tpr6;
 	u32 tpr10;
 	u32 tpr11;
 	u32 tpr12;
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 9d5df2c102..e65bcb36a2 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -85,6 +85,12 @@ config DRAM_SUN50I_H616_TPR2
 	help
 	  TPR2 value from vendor DRAM settings.
 
+config DRAM_SUN50I_H616_TPR6
+	hex "H616 DRAM TPR6 parameter"
+	default 0x3300c080
+	help
+	  TPR6 value from vendor DRAM settings.
+
 config DRAM_SUN50I_H616_TPR10
 	hex "H616 DRAM TPR10 parameter"
 	help
@@ -441,6 +447,9 @@ config SUNXI_DRAM_DDR2
 config SUNXI_DRAM_LPDDR3
 	bool
 
+config SUNXI_DRAM_LPDDR4
+	bool
+
 choice
 	prompt "DRAM Type and Timing"
 	default SUNXI_DRAM_DDR3_1333 if !MACH_SUN8I_V3S
@@ -484,6 +493,14 @@ config SUNXI_DRAM_H616_LPDDR3
 	  This option is the LPDDR3 timing used by the stock boot0 by
 	  Allwinner.
 
+config SUNXI_DRAM_H616_LPDDR4
+	bool "LPDDR4 DRAM chips on the H616 DRAM controller"
+	select SUNXI_DRAM_LPDDR4
+	depends on DRAM_SUN50I_H616
+	help
+	  This option is the LPDDR4 timing used by the stock boot0 by
+	  Allwinner.
+
 config SUNXI_DRAM_H616_DDR3_1333
 	bool "DDR3-1333 boot0 timings on the H616 DRAM controller"
 	select SUNXI_DRAM_DDR3
diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index ba5659d409..185f35850a 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -238,6 +238,11 @@ static const u8 phy_init[] = {
 	0x08, 0x01, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
 	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x07,
 	0x17, 0x19, 0x1a
+#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR4)
+	0x02, 0x00, 0x17, 0x05, 0x04, 0x19, 0x06, 0x07,
+	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x01,
+	0x18, 0x03, 0x1a
 #endif
 };
 
@@ -246,8 +251,13 @@ static void mctl_phy_configure_odt(const struct dram_para *para)
 {
 	uint32_t val_lo, val_hi;
 
+	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x390, BIT(5), BIT(4));
+	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x3d0, BIT(5), BIT(4));
+	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x410, BIT(5), BIT(4));
+	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x450, BIT(5), BIT(4));
+
 	val_lo = para->dx_dri;
-	val_hi = para->dx_dri;
+	val_hi = (para->type == SUNXI_DRAM_TYPE_LPDDR4) ? 0x04040404 : para->dx_dri;
 	writel_relaxed(MASK_BYTE(val_lo, 0), SUNXI_DRAM_PHY0_BASE + 0x388);
 	writel_relaxed(MASK_BYTE(val_hi, 0), SUNXI_DRAM_PHY0_BASE + 0x38c);
 	writel_relaxed(MASK_BYTE(val_lo, 1), SUNXI_DRAM_PHY0_BASE + 0x3c8);
@@ -265,7 +275,7 @@ static void mctl_phy_configure_odt(const struct dram_para *para)
 	writel_relaxed(MASK_BYTE(val_hi, 1), SUNXI_DRAM_PHY0_BASE + 0x34c);
 
 	val_lo = (para->type == SUNXI_DRAM_TYPE_LPDDR3) ? 0 : para->dx_odt;
-	val_hi = para->dx_odt;
+	val_hi = (para->type == SUNXI_DRAM_TYPE_LPDDR4) ? 0 : para->dx_odt;
 	writel_relaxed(MASK_BYTE(val_lo, 0), SUNXI_DRAM_PHY0_BASE + 0x380);
 	writel_relaxed(MASK_BYTE(val_hi, 0), SUNXI_DRAM_PHY0_BASE + 0x384);
 	writel_relaxed(MASK_BYTE(val_lo, 1), SUNXI_DRAM_PHY0_BASE + 0x3c0);
@@ -578,6 +588,8 @@ static void mctl_phy_bit_delay_compensation(const struct dram_para *para)
 		clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x60, 1);
 		setbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 8);
 		clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x190, 0x10);
+		if (para->type == SUNXI_DRAM_TYPE_LPDDR4)
+			clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x4, 0x80);
 
 		if (para->tpr10 & BIT(30))
 			val = para->tpr11 & 0x3f;
@@ -791,8 +803,9 @@ static void mctl_phy_ca_bit_delay_compensation(const struct dram_para *para,
 	writel(val, SUNXI_DRAM_PHY0_BASE + 0x7e0);
 	writel(val, SUNXI_DRAM_PHY0_BASE + 0x7f4);
 
-	if (para->type == SUNXI_DRAM_TYPE_DDR3) {
-		val = (para->tpr10 >> 7) & 0x1e;
+	val = (para->tpr10 >> 7) & 0x1e;
+	switch (para->type) {
+	case SUNXI_DRAM_TYPE_DDR3:
 		if (para->tpr2 & 1) {
 			writel(val, SUNXI_DRAM_PHY0_BASE + 0x794);
 			if (config->ranks == 2) {
@@ -818,8 +831,8 @@ static void mctl_phy_ca_bit_delay_compensation(const struct dram_para *para,
 				writel(val, SUNXI_DRAM_PHY0_BASE + 0x7b8);
 			}
 		}
-	} else if (para->type == SUNXI_DRAM_TYPE_LPDDR3) {
-		val = (para->tpr10 >> 7) & 0x1e;
+		break;
+	case SUNXI_DRAM_TYPE_LPDDR3:
 		if (para->tpr2 & 1) {
 			writel(val, SUNXI_DRAM_PHY0_BASE + 0x7a0);
 			if (config->ranks == 2) {
@@ -833,7 +846,18 @@ static void mctl_phy_ca_bit_delay_compensation(const struct dram_para *para,
 				writel(val, SUNXI_DRAM_PHY0_BASE + 0x7f8);
 			}
 		}
-	}
+		break;
+	case SUNXI_DRAM_TYPE_LPDDR4:
+		if (para->tpr2 & 1) {
+			writel(val, SUNXI_DRAM_PHY0_BASE + 0x788);
+		} else {
+			writel(val, SUNXI_DRAM_PHY0_BASE + 0x794);
+		};
+		break;
+	case SUNXI_DRAM_TYPE_DDR4:
+	default:
+		panic("This DRAM setup is currently not supported.\n");
+	};
 }
 
 static bool mctl_phy_init(const struct dram_para *para,
@@ -846,30 +870,42 @@ static bool mctl_phy_init(const struct dram_para *para,
 	u32 val, val2, *ptr, mr0, mr2;
 	int i;
 
+	if (para->type == SUNXI_DRAM_TYPE_LPDDR4)
+		clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x4,0x80);
+
 	if (config->bus_full_width)
 		val = 0xf;
 	else
 		val = 3;
 	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x3c, 0xf, val);
 
-	if (para->tpr2 & 0x100) {
-		if (para->type == SUNXI_DRAM_TYPE_DDR3) {
+	switch (para->type) {
+	case SUNXI_DRAM_TYPE_DDR3:
+		if (para->tpr2 & 0x100) {
 			val = 9;
 			val2 = 7;
-		} else if (para->type == SUNXI_DRAM_TYPE_LPDDR3) {
-			// untested setup: use some values for now
-			val = 14;
-			val2 = 8;
-		}
-	} else {
-		if (para->type == SUNXI_DRAM_TYPE_DDR3) {
+		} else {
 			val = 13;
 			val2 = 9;
-		} else if (para->type == SUNXI_DRAM_TYPE_LPDDR3) {
+		}
+		break;
+	case SUNXI_DRAM_TYPE_LPDDR3:
+		if (para->tpr2 & 0x100) {
+			val = 12;
+			val2 = 6;
+		} else {
 			val = 14;
 			val2 = 8;
 		}
-	}
+		break;
+	case SUNXI_DRAM_TYPE_LPDDR4:
+		val = 20;
+		val2 = 10;
+		break;
+	case SUNXI_DRAM_TYPE_DDR4:
+	default:
+		panic("This DRAM setup is currently not supported.\n");
+	};
 
 	writel(val, SUNXI_DRAM_PHY0_BASE + 0x14);
 	writel(val, SUNXI_DRAM_PHY0_BASE + 0x35c);
@@ -893,19 +929,40 @@ static bool mctl_phy_init(const struct dram_para *para,
 	if (para->tpr10 & TPR10_CA_BIT_DELAY)
 		mctl_phy_ca_bit_delay_compensation(para, config);
 
-	if (para->type == SUNXI_DRAM_TYPE_DDR3)
-		val = 0x80;
-	else if (para->type == SUNXI_DRAM_TYPE_LPDDR3)
-		val = 0xc0;
+	switch (para->type) {
+	case SUNXI_DRAM_TYPE_DDR3:
+		val = para->tpr6 & 0xff;
+		break;
+	case SUNXI_DRAM_TYPE_LPDDR3:
+		val = para->tpr6 >> 8 & 0xff;
+		break;
+	case SUNXI_DRAM_TYPE_LPDDR4:
+		val = para->tpr6 >> 24 & 0xff;
+		break;
+	case SUNXI_DRAM_TYPE_DDR4:
+	default:
+		panic("This DRAM setup is currently not supported.\n");
+	};
+
 	writel(val, SUNXI_DRAM_PHY0_BASE + 0x3dc);
 	writel(val, SUNXI_DRAM_PHY0_BASE + 0x45c);
 
 	mctl_phy_configure_odt(para);
 
-	if (para->type == SUNXI_DRAM_TYPE_DDR3)
+	switch (para->type) {
+	case SUNXI_DRAM_TYPE_DDR3:
 		val = 0x0a;
-	else if (para->type == SUNXI_DRAM_TYPE_LPDDR3)
+		break;
+	case SUNXI_DRAM_TYPE_LPDDR3:
 		val = 0x0b;
+		break;
+	case SUNXI_DRAM_TYPE_LPDDR4:
+		val = 0x0d;
+		break;
+	case SUNXI_DRAM_TYPE_DDR4:
+	default:
+		panic("This DRAM setup is currently not supported.\n");
+	};
 	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 4, 0x7, val);
 
 	if (para->clk <= 672)
@@ -955,8 +1012,8 @@ static bool mctl_phy_init(const struct dram_para *para,
 		mr0 = 0x1f14;
 		mr2 = 0x20;
 	}
-
-	if (para->type == SUNXI_DRAM_TYPE_DDR3) {
+	switch (para->type) {
+	case SUNXI_DRAM_TYPE_DDR3:
 		writel(mr0, &mctl_ctl->mrctrl1);
 		writel(0x80000030, &mctl_ctl->mrctrl0);
 		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
@@ -972,7 +1029,8 @@ static bool mctl_phy_init(const struct dram_para *para,
 		writel(0, &mctl_ctl->mrctrl1);
 		writel(0x80003030, &mctl_ctl->mrctrl0);
 		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
-	} else if (para->type == SUNXI_DRAM_TYPE_LPDDR3) {
+		break;
+	case SUNXI_DRAM_TYPE_LPDDR3:
 		writel(mr0, &mctl_ctl->mrctrl1);
 		writel(0x800000f0, &mctl_ctl->mrctrl0);
 		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
@@ -988,7 +1046,48 @@ static bool mctl_phy_init(const struct dram_para *para,
 		writel(0x301, &mctl_ctl->mrctrl1);
 		writel(0x800000f0, &mctl_ctl->mrctrl0);
 		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
-	}
+		break;
+	case SUNXI_DRAM_TYPE_LPDDR4:
+		writel(0x0, &mctl_ctl->mrctrl1);
+		writel(0x80000030, &mctl_ctl->mrctrl0);
+		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
+
+		writel(0x134, &mctl_ctl->mrctrl1);
+		writel(0x80000030, &mctl_ctl->mrctrl0);
+		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
+
+		writel(0x21b, &mctl_ctl->mrctrl1);
+		writel(0x80000030, &mctl_ctl->mrctrl0);
+		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
+
+		writel(0x333, &mctl_ctl->mrctrl1);
+		writel(0x80000030, &mctl_ctl->mrctrl0);
+		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
+
+		writel(0x403, &mctl_ctl->mrctrl1);
+		writel(0x80000030, &mctl_ctl->mrctrl0);
+		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
+
+		writel(0xb04, &mctl_ctl->mrctrl1);
+		writel(0x80000030, &mctl_ctl->mrctrl0);
+		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
+
+		writel(0xc72, &mctl_ctl->mrctrl1);
+		writel(0x80000030, &mctl_ctl->mrctrl0);
+		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
+
+		writel(0xe09, &mctl_ctl->mrctrl1);
+		writel(0x80000030, &mctl_ctl->mrctrl0);
+		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
+
+		writel(0x1624, &mctl_ctl->mrctrl1);
+		writel(0x80000030, &mctl_ctl->mrctrl0);
+		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
+		break;
+	case SUNXI_DRAM_TYPE_DDR4:
+	default:
+		panic("This DRAM setup is currently not supported.\n");
+	};
 
 	writel(0, SUNXI_DRAM_PHY0_BASE + 0x54);
 
@@ -1057,17 +1156,29 @@ static bool mctl_ctrl_init(const struct dram_para *para,
 
 	setbits_le32(&mctl_com->unk_0x008, 0xff00);
 
+	if (para->type == SUNXI_DRAM_TYPE_LPDDR4)
+		writel(1, SUNXI_DRAM_COM_BASE + 0x50);
 	clrsetbits_le32(&mctl_ctl->sched[0], 0xff00, 0x3000);
 
 	writel(0, &mctl_ctl->hwlpctl);
 
 	setbits_le32(&mctl_com->unk_0x008, 0xff00);
 
-	reg_val = MSTR_BURST_LENGTH(8) | MSTR_ACTIVE_RANKS(config->ranks);
-	if (para->type == SUNXI_DRAM_TYPE_DDR3)
-		reg_val |= MSTR_DEVICETYPE_DDR3 | MSTR_2TMODE;
-	else if (para->type == SUNXI_DRAM_TYPE_LPDDR3)
-		reg_val |= MSTR_DEVICETYPE_LPDDR3;
+	reg_val = MSTR_ACTIVE_RANKS(config->ranks);
+	switch (para->type) {
+	case SUNXI_DRAM_TYPE_DDR3:
+		reg_val |= MSTR_BURST_LENGTH(8) | MSTR_DEVICETYPE_DDR3 | MSTR_2TMODE;
+		break;
+	case SUNXI_DRAM_TYPE_LPDDR3:
+		reg_val |= MSTR_BURST_LENGTH(8) | MSTR_DEVICETYPE_LPDDR3;
+		break;
+	case SUNXI_DRAM_TYPE_LPDDR4:
+		reg_val |= MSTR_BURST_LENGTH(16) | MSTR_DEVICETYPE_LPDDR4;
+		break;
+	case SUNXI_DRAM_TYPE_DDR4:
+	default:
+		panic("This DRAM setup is currently not supported.\n");
+	};
 	if (config->bus_full_width)
 		reg_val |= MSTR_BUSWIDTH_FULL;
 	else
@@ -1079,10 +1190,20 @@ static bool mctl_ctrl_init(const struct dram_para *para,
 	else
 		writel(0x0201, &mctl_ctl->odtmap);
 
-	if (para->type == SUNXI_DRAM_TYPE_DDR3)
+	switch (para->type) {
+	case SUNXI_DRAM_TYPE_DDR3:
 		reg_val = 0x06000400;
-	else if (para->type == SUNXI_DRAM_TYPE_LPDDR3)
+		break;
+	case SUNXI_DRAM_TYPE_LPDDR3:
 		reg_val = 0x09020400;
+		break;
+	case SUNXI_DRAM_TYPE_LPDDR4:
+		reg_val = 0x04000400;
+		break;
+	case SUNXI_DRAM_TYPE_DDR4:
+	default:
+		panic("This DRAM setup is currently not supported.\n");
+	};
 	writel(reg_val, &mctl_ctl->odtcfg);
 	writel(reg_val, &mctl_ctl->unk_0x2240);
 	writel(reg_val, &mctl_ctl->unk_0x3240);
@@ -1102,6 +1223,9 @@ static bool mctl_ctrl_init(const struct dram_para *para,
 	setbits_le32(&mctl_ctl->unk_0x3180, BIT(31) | BIT(30));
 	setbits_le32(&mctl_ctl->unk_0x4180, BIT(31) | BIT(30));
 
+	if (para->type == SUNXI_DRAM_TYPE_LPDDR4)
+		setbits_le32(&mctl_ctl->dbictl, 1);
+
 	setbits_le32(&mctl_ctl->rfshctl3, BIT(0));
 	clrbits_le32(&mctl_ctl->dfimisc, BIT(0));
 
@@ -1224,6 +1348,8 @@ static const struct dram_para para = {
 	.type = SUNXI_DRAM_TYPE_DDR3,
 #elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR3)
 	.type = SUNXI_DRAM_TYPE_LPDDR3,
+#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR4)
+	.type = SUNXI_DRAM_TYPE_LPDDR4,
 #endif
 	.dx_odt = CONFIG_DRAM_SUN50I_H616_DX_ODT,
 	.dx_dri = CONFIG_DRAM_SUN50I_H616_DX_DRI,
@@ -1231,6 +1357,7 @@ static const struct dram_para para = {
 	.odt_en = CONFIG_DRAM_SUN50I_H616_ODT_EN,
 	.tpr0 = CONFIG_DRAM_SUN50I_H616_TPR0,
 	.tpr2 = CONFIG_DRAM_SUN50I_H616_TPR2,
+	.tpr6 = CONFIG_DRAM_SUN50I_H616_TPR6,
 	.tpr10 = CONFIG_DRAM_SUN50I_H616_TPR10,
 	.tpr11 = CONFIG_DRAM_SUN50I_H616_TPR11,
 	.tpr12 = CONFIG_DRAM_SUN50I_H616_TPR12,
diff --git a/arch/arm/mach-sunxi/dram_timings/Makefile b/arch/arm/mach-sunxi/dram_timings/Makefile
index 8bfd99448a..5f20341924 100644
--- a/arch/arm/mach-sunxi/dram_timings/Makefile
+++ b/arch/arm/mach-sunxi/dram_timings/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_SUNXI_DRAM_H6_LPDDR3)	+= h6_lpddr3.o
 obj-$(CONFIG_SUNXI_DRAM_H6_DDR3_1333)	+= h6_ddr3_1333.o
 obj-$(CONFIG_SUNXI_DRAM_H616_DDR3_1333)	+= h616_ddr3_1333.o
 obj-$(CONFIG_SUNXI_DRAM_H616_LPDDR3)	+= h616_lpddr3.o
+obj-$(CONFIG_SUNXI_DRAM_H616_LPDDR4)	+= h616_lpddr4_2133.o
diff --git a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
new file mode 100644
index 0000000000..c11cb8678f
--- /dev/null
+++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
@@ -0,0 +1,95 @@
+/*
+ * sun50i H616 LPDDR4-2133 timings, as programmed by Allwinner's boot0
+ * for orangepi zero3 with the H618 and LPDDR4 memory.
+ *
+ * (C) Copyright 2023 Mikhail Kalashnikov <iuncuim@gmail.com>
+ *   Based on H6 DDR3 timings:
+ *   (C) Copyright 2020 Jernej Skrabec <jernej.skrabec@siol.net>
+ *
+ * SPDX-License-Identifier:	GPL-2.0+
+ */
+
+#include <common.h>
+#include <asm/arch/dram.h>
+#include <asm/arch/cpu.h>
+
+void mctl_set_timing_params(const struct dram_para *para)
+{
+	struct sunxi_mctl_ctl_reg * const mctl_ctl =
+			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
+
+	u8 tccd		= 4;
+	u8 tfaw		= ns_to_t(40);
+	u8 trrd		= max(ns_to_t(10), 2);
+	u8 trcd		= max(ns_to_t(18), 2);
+	u8 trc		= ns_to_t(65);
+	u8 txp		= max(ns_to_t(8), 2);
+	u8 trtp		= max(ns_to_t(8), 4);
+	u8 trp		= ns_to_t(21);
+	u8 tras		= ns_to_t(42);
+	u16 trefi	= ns_to_t(3904) / 32;
+	u16 trfc	= ns_to_t(280);
+	u16 txsr	= ns_to_t(190);
+
+	u8 tmrw		= max(ns_to_t(14), 5);
+	u8 tmrd		= tmrw;
+	u8 tmod		= 12;
+	u8 tcke		= max(ns_to_t(15), 2);
+	u8 tcksrx	= max(ns_to_t(2), 2);
+	u8 tcksre	= max(ns_to_t(5), 2);
+	u8 tckesr	= tcke;
+	u8 trasmax	= (trefi * 9) / 32;
+	u8 txs		= 4;
+	u8 txsdll	= 16;
+	u8 txsabort	= 4;
+	u8 txsfast	= 4;
+	u8 tcl		= 10;
+	u8 tcwl		= 5;
+	u8 t_rdata_en	= 17;
+	u8 tphy_wrlat	= 5;
+
+	u8 twtp		= 24;
+	u8 twr2rd	= max(trrd, (u8)4) + 14;
+	u8 trd2wr	= (ns_to_t(4) + 17) - ns_to_t(1);
+
+	/* set DRAM timing */
+	writel((twtp << 24) | (tfaw << 16) | (trasmax << 8) | tras,
+	       &mctl_ctl->dramtmg[0]);
+	writel((txp << 16) | (trtp << 8) | trc, &mctl_ctl->dramtmg[1]);
+	writel((tcwl << 24) | (tcl << 16) | (trd2wr << 8) | twr2rd,
+	       &mctl_ctl->dramtmg[2]);
+	writel((tmrw << 20) | (tmrd << 12) | tmod, &mctl_ctl->dramtmg[3]);
+	writel((trcd << 24) | (tccd << 16) | (trrd << 8) | trp,
+	       &mctl_ctl->dramtmg[4]);
+	writel((tcksrx << 24) | (tcksre << 16) | (tckesr << 8) | tcke,
+	       &mctl_ctl->dramtmg[5]);
+	/* Value suggested by ZynqMP manual and used by libdram */
+	writel((txp + 2) | 0x02020000, &mctl_ctl->dramtmg[6]);
+	writel((txsfast << 24) | (txsabort << 16) | (txsdll << 8) | txs,
+	       &mctl_ctl->dramtmg[8]);
+	writel(0x00020208, &mctl_ctl->dramtmg[9]);
+	writel(0xE0C05, &mctl_ctl->dramtmg[10]);
+	writel(0x440C021C, &mctl_ctl->dramtmg[11]);
+	writel(8, &mctl_ctl->dramtmg[12]);
+	writel(0xA100002, &mctl_ctl->dramtmg[13]);
+	writel(txsr, &mctl_ctl->dramtmg[14]);
+
+	clrsetbits_le32(&mctl_ctl->init[0], 0xC0000FFF, 0x3f0);
+	writel(0x01f20000, &mctl_ctl->init[1]);
+	writel(0x00000d05, &mctl_ctl->init[2]);
+	writel(0, &mctl_ctl->dfimisc);
+	writel(0x0034001b, &mctl_ctl->init[3]);
+	writel(0x00330000, &mctl_ctl->init[4]);
+	writel(0x00040072, &mctl_ctl->init[6]);
+	writel(0x00240009, &mctl_ctl->init[7]);
+
+	clrsetbits_le32(&mctl_ctl->rankctl, 0xff0, 0x660);
+
+	/* Configure DFI timing */
+	writel(tphy_wrlat | 0x2000000 | (t_rdata_en << 16) | 0x808000,
+	       &mctl_ctl->dfitmg0);
+	writel(0x100202, &mctl_ctl->dfitmg1);
+
+	/* set refresh timing */
+	writel((trefi << 16) | trfc, &mctl_ctl->rfshtmg);
+}
-- 
2.42.0


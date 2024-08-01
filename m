Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F60C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 22:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15BC688B8F;
	Fri,  2 Aug 2024 00:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="goRcUJBa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11B1988B6C; Fri,  2 Aug 2024 00:57:49 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC2CF889D2
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 00:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5c669a0b5d1so5093903eaf.3
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 15:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722553064; x=1723157864; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8bGfDDF+TnwoO7pmORiTtnnJhBsSsOcshxlBa3Ix7uU=;
 b=goRcUJBac96SejIBkZZORdO9J9L6Q6ndeVtRB0HkuqSpqNPpRnb6ZuC2lpayJ/AwuE
 bHLxanpIE88eOHsYrmZPtp9O4ySrSgg08ON9LVr94tlwjVkAwqsUjDyXAIB1XRzG1s9p
 vOm/H2CxtZVv+frFESgOci40J5jnnXm8lBy6kQHueYdknEMBpL8oUhs8MFcQRhra+dOT
 crhrS+B5TI9NGGaO3pIOTQCYehnnZJvf0nN4ZvFv10mAsdtr5dEBzTQqVwkBktSnOXTE
 ts8n2s06R3l86HsoGxDv4PWTvOvPPgHxXPFDInipXtGu6qHd6DdRRTbfWQODaOyFJrJY
 5T1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722553064; x=1723157864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8bGfDDF+TnwoO7pmORiTtnnJhBsSsOcshxlBa3Ix7uU=;
 b=kEZkL6ivHriZpuDw1O26MeKYLgjLBa/0l667SJK8qdf3h/8sIUVcbnCGK+6oXiAeWK
 vShU8h6ET+YSXGrUkC80FDKpAm6ECSloA96ysqVzRDTmwbBB7kmd+dMWKRaGWsEU6gYO
 RQmnDHFtMVxt/yxw21fTiYnO2+q57htHwDvV2afidcdrdY6egGDh4FFaarVvbDlnqbC9
 QmlvtvOdcuNnCBT5br6jzwUPvMvprqkVpFJO7DtfuEeBGNpeihbbE3MJFwFIMH9BrB0S
 6Ugl2Lq68zSbwIzlSjmDtjVepCdjf37M9zSMjCqHsuOKZbc4D1hrjjK2eZwlzUtgOL0S
 qCTA==
X-Gm-Message-State: AOJu0Yx58cs1OD+wyDdWuhP+o+HKRZR+aZvQaQ2sDOs049swU6bgShSr
 6MlSlj5h3ennyG5CQT5yvQE+ZQ5/ib3nZUqsPoz377kR/jhAHA0LN6AyYg==
X-Google-Smtp-Source: AGHT+IFBeWXQGGrJZEbwOoCIIMPl2ARGUsp0ZHCpT3z8eUy8DvS1cKmI5ThFNzmSfO2RVvHBye3Apw==
X-Received: by 2002:a05:6870:9a20:b0:25d:f8fa:b535 with SMTP id
 586e51a60fabf-26891aa8695mr2103720fac.6.1722553064406; 
 Thu, 01 Aug 2024 15:57:44 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a67b515sm58039fac.50.2024.08.01.15.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 15:57:44 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 3/9] sunxi: H616: dram: LPDDR4: adjust settings
Date: Thu,  1 Aug 2024 17:55:13 -0500
Message-Id: <20240801225519.336667-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801225519.336667-1-macroalpha82@gmail.com>
References: <20240801225519.336667-1-macroalpha82@gmail.com>
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

From: Jernej Skrabec <jernej.skrabec@gmail.com>

Adjust H616 LPDDR4 DRAM settings to be in line with vendor driver.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Tested-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/mach-sunxi/dram_sun50i_h616.c        | 35 +++++++++++++------
 .../dram_timings/h616_lpddr4_2133.c           |  2 +-
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index a20264d8b4..b6638c519e 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -293,14 +293,22 @@ static void mctl_phy_configure_odt(const struct dram_para *para)
 	dmb();
 }
 
-static bool mctl_phy_write_leveling(const struct dram_config *config)
+static bool mctl_phy_write_leveling(const struct dram_para *para,
+				    const struct dram_config *config)
 {
 	bool result = true;
 	u32 val;
 
 	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 0xc0, 0x80);
-	writel(4, SUNXI_DRAM_PHY0_BASE + 0xc);
-	writel(0x40, SUNXI_DRAM_PHY0_BASE + 0x10);
+
+	if (para->type == SUNXI_DRAM_TYPE_LPDDR4) {
+		/* MR2 value */
+		writel(0x1b, SUNXI_DRAM_PHY0_BASE + 0xc);
+		writel(0, SUNXI_DRAM_PHY0_BASE + 0x10);
+	} else {
+		writel(4, SUNXI_DRAM_PHY0_BASE + 0xc);
+		writel(0x40, SUNXI_DRAM_PHY0_BASE + 0x10);
+	}
 
 	setbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 4);
 
@@ -859,9 +867,9 @@ static void mctl_phy_ca_bit_delay_compensation(const struct dram_para *para,
 		}
 		break;
 	case SUNXI_DRAM_TYPE_LPDDR4:
-		if (para->tpr2 & 1) {
-			writel(val, SUNXI_DRAM_PHY0_BASE + 0x788);
-		} else {
+		writel(val, SUNXI_DRAM_PHY0_BASE + 0x788);
+		if (config->ranks == 2) {
+			val = (para->tpr10 >> 11) & 0x1e;
 			writel(val, SUNXI_DRAM_PHY0_BASE + 0x794);
 		};
 		break;
@@ -949,6 +957,8 @@ static bool mctl_phy_init(const struct dram_para *para,
 		break;
 	case SUNXI_DRAM_TYPE_LPDDR4:
 		val = para->tpr6 >> 24 & 0xff;
+		if (!val)
+			val = 0x33;
 		break;
 	case SUNXI_DRAM_TYPE_DDR4:
 	default:
@@ -1080,19 +1090,27 @@ static bool mctl_phy_init(const struct dram_para *para,
 		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
 
 		writel(0xb04, &mctl_ctl->mrctrl1);
+		udelay(10);
 		writel(0x80000030, &mctl_ctl->mrctrl0);
+		udelay(10);
 		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
 
 		writel(0xc72, &mctl_ctl->mrctrl1);
+		udelay(10);
 		writel(0x80000030, &mctl_ctl->mrctrl0);
+		udelay(10);
 		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
 
 		writel(0xe09, &mctl_ctl->mrctrl1);
+		udelay(10);
 		writel(0x80000030, &mctl_ctl->mrctrl0);
+		udelay(10);
 		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
 
 		writel(0x1624, &mctl_ctl->mrctrl1);
+		udelay(10);
 		writel(0x80000030, &mctl_ctl->mrctrl0);
+		udelay(10);
 		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
 		break;
 	case SUNXI_DRAM_TYPE_DDR4:
@@ -1108,7 +1126,7 @@ static bool mctl_phy_init(const struct dram_para *para,
 
 	if (para->tpr10 & TPR10_WRITE_LEVELING) {
 		for (i = 0; i < 5; i++)
-			if (mctl_phy_write_leveling(config))
+			if (mctl_phy_write_leveling(para, config))
 				break;
 		if (i == 5) {
 			debug("write leveling failed!\n");
@@ -1234,9 +1252,6 @@ static bool mctl_ctrl_init(const struct dram_para *para,
 	setbits_le32(&mctl_ctl->unk_0x3180, BIT(31) | BIT(30));
 	setbits_le32(&mctl_ctl->unk_0x4180, BIT(31) | BIT(30));
 
-	if (para->type == SUNXI_DRAM_TYPE_LPDDR4)
-		setbits_le32(&mctl_ctl->dbictl, 0x1);
-
 	setbits_le32(&mctl_ctl->rfshctl3, BIT(0));
 	clrbits_le32(&mctl_ctl->dfimisc, BIT(0));
 
diff --git a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
index e6446b9180..6f5c4acbd6 100644
--- a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
+++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
@@ -23,7 +23,7 @@ void mctl_set_timing_params(const struct dram_para *para)
 	u8 trcd		= max(ns_to_t(18), 2);
 	u8 trc		= ns_to_t(65);
 	u8 txp		= max(ns_to_t(8), 2);
-	u8 trtp		= max(ns_to_t(8), 4);
+	u8 trtp		= 4;
 	u8 trp		= ns_to_t(21);
 	u8 tras		= ns_to_t(42);
 	u16 trefi	= ns_to_t(3904) / 32;
-- 
2.34.1


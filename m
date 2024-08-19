Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C600FC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 15:02:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31E6F88CE1;
	Mon, 19 Aug 2024 17:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FuxHE0jy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C569871C7; Mon, 19 Aug 2024 17:02:05 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 165BA87B84
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 17:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2702ed1054fso1039025fac.3
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 08:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724079722; x=1724684522; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8PH9F1VBK3kWNUHiqkBLlRVWB0H6/h7ZsBfedPxrAx0=;
 b=FuxHE0jylLRb1Bz4r9q9YPloDxeNJk71cYhuEry4qXKYEMPyRF3wR5BzyHlYUhMuXC
 P7EFf/9r7EB665GSBdquKEQXjippFQSlfn8O6fBKV/2dZW/wDfRDG81yoscHadQ7IFj+
 VIbYYz2mOZhisKJIaPs1pgOr8B91xxPzo6YmnNx2dv2YHsy32V71oiWAO1jS+WJa5Gda
 UztW2EvvQN++QyTmpGwI8afLzpWySHSUJAoJISURvYKHsO2lhgPa68OFimvjK5iRzqaU
 f4ZDqFyho5DgyjltZ2tdfWNZg/9DO2m+VYO1DMWAhac/fqFBFb6nnoNHMZiPlu1RGf82
 sC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724079722; x=1724684522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8PH9F1VBK3kWNUHiqkBLlRVWB0H6/h7ZsBfedPxrAx0=;
 b=qa/JlsUKF2tSeEPVFrXWDyQwRBW24fOEeeEHn0qa5Qn1NUHUBklyhxYdqxmk05uRzc
 gLGDT4KKyYVFgF68mhVG+I58YFIQ6APPhHSy8vr8ZPJLsDaS5aw5q1WGL+RcPKIl7GpL
 ffZcFy5mUAJa+8lvrn2QD1XVoXysosboQlwW06I3/M196SQZSMGmtR3/8dGWStnaADpZ
 mVI2XBHO/4LEPWmD7wAAOmhKbascc+L5O6rJ9u2YDB1FOp9hIomuBGTjLB3w297Pg0Ey
 kdf8eriqGwMoFq/UjG0XaVt3zS3vuAZ0QyDXgoKwVk2ZfCecvV2okPZ+QMrtdKZWJheq
 6qOQ==
X-Gm-Message-State: AOJu0Yzifl+FzUqppZ0Mq3BgWPbc8RfAil/NGH4YcJEYDPxiZcqAk/ef
 n8y7eghUvPo6ISXgIC3lRot6/bE43AksQZnKeltKO9uxI+5m5gxO4lf/1A==
X-Google-Smtp-Source: AGHT+IHcgrH8A2XuEKWQfINMNP2BRnxJ4x0jSbXjW2MyO1GB+sMBEYg0l+JWwbrpHEcQbpWAAuR42g==
X-Received: by 2002:a05:6870:470c:b0:25d:f0ba:eab7 with SMTP id
 586e51a60fabf-2701c37eac4mr13785703fac.18.1724079721580; 
 Mon, 19 Aug 2024 08:02:01 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-27004432d18sm2945189fac.7.2024.08.19.08.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 08:02:01 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com, iuncuim@gmail.com,
 sumit.garg@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 1/9] sunxi: H616: dram: LPDDR4: adjust settings
Date: Mon, 19 Aug 2024 09:59:30 -0500
Message-Id: <20240819145938.503221-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819145938.503221-1-macroalpha82@gmail.com>
References: <20240819145938.503221-1-macroalpha82@gmail.com>
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
 arch/arm/mach-sunxi/dram_sun50i_h616.c        | 33 +++++++++++++------
 .../dram_timings/h616_lpddr4_2133.c           |  2 +-
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index 37c139e0ee..5be2887a06 100644
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
@@ -1080,19 +1088,27 @@ static bool mctl_phy_init(const struct dram_para *para,
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
@@ -1108,7 +1124,7 @@ static bool mctl_phy_init(const struct dram_para *para,
 
 	if (para->tpr10 & TPR10_WRITE_LEVELING) {
 		for (i = 0; i < 5; i++)
-			if (mctl_phy_write_leveling(config))
+			if (mctl_phy_write_leveling(para, config))
 				break;
 		if (i == 5) {
 			debug("write leveling failed!\n");
@@ -1234,9 +1250,6 @@ static bool mctl_ctrl_init(const struct dram_para *para,
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


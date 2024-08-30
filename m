Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1360CA1008
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 15:57:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D146E88C51;
	Fri, 30 Aug 2024 17:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JoFVwkCA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9660188C72; Fri, 30 Aug 2024 17:57:41 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69AFE88C45
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 17:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7093efbade6so1334820a34.2
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 08:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725033458; x=1725638258; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8PH9F1VBK3kWNUHiqkBLlRVWB0H6/h7ZsBfedPxrAx0=;
 b=JoFVwkCA0ZJTG6AWU7030XCr50fWehSanOGdW5NeTKYKkrp+VdJEZCEZKFSVXIobqI
 eS9TwiYJWYg0oSiRZdMnm6PqssHFhBwLmlIcwEwXG5VvgUDUjIQ7i4PwOq0ADsBLHtpo
 jjQs0jN9YtUDn/jZqtiX1JPtxUm/XSsplcdFD2+XEV6EueAyd4lwnxvfh5lY4SGGRU3X
 h6rhJb6hpK+XTkJGUgtymsmuMgDm7gG+cOpnXDj3Dhcey94Apv9XMkA6prXxQva5xd9E
 KjIFc/lVg3bcQF+CAfhTs7Kd1cSE6Y+p9RYRR4myoDvjMvx6a3hzrVc9wgmTcQxbuUVA
 5Odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725033458; x=1725638258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8PH9F1VBK3kWNUHiqkBLlRVWB0H6/h7ZsBfedPxrAx0=;
 b=bIlJVJU7C1ufzOsQLfhBLNuLmyYwib+Z7JR9GvX4AuAOqWATGqxstLCGeaNs4oH0sa
 REjg0sOudRK+FP8dLBfl3g+MKAdA7GTsFNysgAAAX+4rcg5+BvrvGpgZ4YMhz/olYnmE
 65dJE+dvC9RmO8pFECfl4xbZFPmVTbpXcl7xjOSxpXfz5mxEjTWBYlJVqUd71LjhV5dD
 +nLzlu2JsHnOB4wMWr3mWqPPReUpOM/52yKG/PmkcvmW5M6a1dc/xEhLw4OCobGGTW/+
 Zf3TCoMtQ0B16Goktx0DbdKuV1skyReANDNVzGv0iK5YwhagUOwimSsY0HT5MHZVxO+M
 g8Tg==
X-Gm-Message-State: AOJu0YyL2KXz+fkEds1x8/4EXzHJZO2MGOSS0ma49yxVeJwa8P+GKKXO
 qQ3InPAPbp4PqOSAhAmv8QSyNBQWDx4vOJqUIBo79ZM7j72aZbOf/VbyZA==
X-Google-Smtp-Source: AGHT+IGQOd6xaZQNUqGgXFdh+QmOqYA5hbWkHjfu4QguedCJ0aaLN6r2YvXOPiDIhTy4ZtP27LGYjg==
X-Received: by 2002:a05:6830:6d08:b0:70a:988a:b5fd with SMTP id
 46e09a7af769-70f5c406907mr9162543a34.24.1725033458008; 
 Fri, 30 Aug 2024 08:57:38 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70f671a8630sm490092a34.51.2024.08.30.08.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 08:57:37 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com, iuncuim@gmail.com,
 sumit.garg@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 1/9] sunxi: H616: dram: LPDDR4: adjust settings
Date: Fri, 30 Aug 2024 10:55:06 -0500
Message-Id: <20240830155514.481410-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830155514.481410-1-macroalpha82@gmail.com>
References: <20240830155514.481410-1-macroalpha82@gmail.com>
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


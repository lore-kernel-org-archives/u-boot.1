Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2239BC52D7C
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 15:02:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B48A87B84;
	Mon, 19 Aug 2024 17:02:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BRlTVdk0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE01A88CE9; Mon, 19 Aug 2024 17:02:06 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2C9688CA0
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 17:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3db16129143so2345699b6e.0
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 08:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724079722; x=1724684522; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lncLCU7aTj1amHcX2H/VFllgDBgYGr8WJkwU+3jD/qo=;
 b=BRlTVdk0fVVc5EuKxpnv7gtxjT1ha5Aqe08ab8r3bqki1wYRy0SQjY6KE9m6hdzliI
 A+NGGcX1VJu9CQBzDwCWFz9614pRUJNJU5q9u5tBL5CZ9Me9AHyZwZ7bApWV+MCkLHCL
 ceH8dC7dyQCI/325bGCSuRtDlgQrWXvFIbxCrOQZccBuk/l4reov1ycyQlhbrmWElNwc
 CJADJm+rj1D3629CRfavoEpIY+RdqWmjOxFpsY0Rysk9FkHpP6R2y0R+aWa1dI3lLvVM
 ihnYS565dP+N1KVwr3AzPkOxqsOsQAhdEC3HhcorESumtnKbHZyg0sFExyl3hqcaEI/e
 sxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724079722; x=1724684522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lncLCU7aTj1amHcX2H/VFllgDBgYGr8WJkwU+3jD/qo=;
 b=pTatFDMQr8CXqhqUcAbn1UVSbcsD1fhnxIJ3vmlELgO9ibhJKda0GPe22wJ+z6y6rR
 boEEAE83laHxO6o0VUOLNUpxZ/OQnis2vPDgtrj3+y+ZKLIhftsC3D43by5u2dT1tCjB
 oLxX7WbLuXLqeG+BeFFmqtG08HDhNEvZd07aUQ1OHH9jKyWkeTN2fwywZziV/HCrKbaK
 U1YarAn0ez5JAs8gz0gRE/itOIaA0kgvjanT10fSnlo/BmNrsg3SoZU3pgZjn1/7T2w6
 ZjUVPNrXlMn6JQoh3zY4hpv6e6pTe1UkREkW38POnGGwq8ZjjBvEezsyBZEgcWdnxvNA
 6AOA==
X-Gm-Message-State: AOJu0YzgUkjANgEKqdpQr23nH1Rwxnc+AJQW0lMeMQjCwEN95el+IDxk
 UO8AVx1leWnphZW0a7mffrdUgwrRkfTollRZYwH0flMpJuu/CpkYYUcb3A==
X-Google-Smtp-Source: AGHT+IElfWs4izjdWHCoYG2iUXY05Ry2eoPFtvMiRrlFsHToq2lwUngUPyjfqgtXS5hwBjqAcFgQCw==
X-Received: by 2002:a05:6870:9a8a:b0:25d:fab0:b6f4 with SMTP id
 586e51a60fabf-27033f211f5mr7726117fac.1.1724079722384; 
 Mon, 19 Aug 2024 08:02:02 -0700 (PDT)
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
Subject: [PATCH V2 2/9] sunxi: H616: DRAM: Add alternative pin mapping
Date: Mon, 19 Aug 2024 09:59:31 -0500
Message-Id: <20240819145938.503221-3-macroalpha82@gmail.com>
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

It seems that different dies need different PHY pin mapping. Select
alternatives based on "bond ID".

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Tested-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/mach-sunxi/dram_sun50i_h616.c | 59 +++++++++++++++++++-------
 1 file changed, 44 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index 5be2887a06..dfaa270d96 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -225,22 +225,43 @@ static void mctl_set_addrmap(const struct dram_config *config)
 	mctl_ctl->addrmap[8] = 0x3F3F;
 }
 
-static const u8 phy_init[] = {
+static const u8 phy_addr_maps[2][27] = {
 #ifdef CONFIG_SUNXI_DRAM_H616_DDR3_1333
-	0x07, 0x0b, 0x02, 0x16, 0x0d, 0x0e, 0x14, 0x19,
-	0x0a, 0x15, 0x03, 0x13, 0x04, 0x0c, 0x10, 0x06,
-	0x0f, 0x11, 0x1a, 0x01, 0x12, 0x17, 0x00, 0x08,
-	0x09, 0x05, 0x18
+	{
+		0x07, 0x0b, 0x02, 0x16, 0x0d, 0x0e, 0x14, 0x19,
+		0x0a, 0x15, 0x03, 0x13, 0x04, 0x0c, 0x10, 0x06,
+		0x0f, 0x11, 0x1a, 0x01, 0x12, 0x17, 0x00, 0x08,
+		0x09, 0x05, 0x18
+	}, {
+		0x08, 0x02, 0x12, 0x05, 0x15, 0x17, 0x18, 0x0b,
+		0x14, 0x07, 0x04, 0x13, 0x0c, 0x00, 0x16, 0x1a,
+		0x0a, 0x11, 0x03, 0x10, 0x0e, 0x01, 0x0d, 0x19,
+		0x06, 0x09, 0x0f
+	}
 #elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR3)
-	0x18, 0x06, 0x00, 0x05, 0x04, 0x03, 0x09, 0x02,
-	0x08, 0x01, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
-	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x07,
-	0x17, 0x19, 0x1a
+	{
+		0x18, 0x06, 0x00, 0x05, 0x04, 0x03, 0x09, 0x02,
+		0x08, 0x01, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+		0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x07,
+		0x17, 0x19, 0x1a
+	}, {
+		0x18, 0x00, 0x04, 0x09, 0x06, 0x05, 0x02, 0x19,
+		0x17, 0x03, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+		0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x07,
+		0x08, 0x01, 0x1a
+	}
 #elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR4)
-	0x02, 0x00, 0x17, 0x05, 0x04, 0x19, 0x06, 0x07,
-	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
-	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x01,
-	0x18, 0x03, 0x1a
+	{
+		0x02, 0x00, 0x17, 0x05, 0x04, 0x19, 0x06, 0x07,
+		0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+		0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x01,
+		0x18, 0x03, 0x1a
+	}, {
+		0x03, 0x00, 0x17, 0x05, 0x02, 0x19, 0x06, 0x07,
+		0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+		0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x01,
+		0x18, 0x04, 0x1a
+	}
 #endif
 };
 
@@ -887,6 +908,7 @@ static bool mctl_phy_init(const struct dram_para *para,
 	struct sunxi_mctl_ctl_reg * const mctl_ctl =
 			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
 	u32 val, val2, *ptr, mr0, mr2;
+	const u8 *map;
 	int i;
 
 	if (para->type == SUNXI_DRAM_TYPE_LPDDR4)
@@ -942,8 +964,15 @@ static bool mctl_phy_init(const struct dram_para *para,
 	writel(val2, SUNXI_DRAM_PHY0_BASE + 0x37c);
 
 	ptr = (u32 *)(SUNXI_DRAM_PHY0_BASE + 0xc0);
-	for (i = 0; i < ARRAY_SIZE(phy_init); i++)
-		writel(phy_init[i], &ptr[i]);
+	val = readl(SUNXI_SID_BASE);
+	if (((val & 0xfbff) == 0x5000) ||
+	    ((val & 0xfeff) == 0x5c00) ||
+	    ((val & 0xf7ff) == 0x2000))
+		map = phy_addr_maps[0];
+	else
+		map = phy_addr_maps[1];
+	for (i = 0; i < ARRAY_SIZE(phy_addr_maps[0]); i++)
+		writel(map[i], &ptr[i]);
 
 	if (para->tpr10 & TPR10_CA_BIT_DELAY)
 		mctl_phy_ca_bit_delay_compensation(para, config);
-- 
2.34.1


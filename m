Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D877AC27C53
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 18:22:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2974787F51;
	Sat, 22 Jun 2024 20:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=edgeble-ai.20230601.gappssmtp.com header.i=@edgeble-ai.20230601.gappssmtp.com header.b="f42O4x6E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF09588001; Sat, 22 Jun 2024 20:22:03 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 974C287D14
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 20:22:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=jagan@edgeble.ai
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f9a78c6c5dso25358465ad.1
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 11:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edgeble-ai.20230601.gappssmtp.com; s=20230601; t=1719080520; x=1719685320;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D/l4LkaduINnPL+z0weBnhKvpEc4/vTP1TtPj16QSsw=;
 b=f42O4x6EK3vzbxdMLqIgFBJrgUaNfkIy0BdeQqnZSI/z8k8TsHx0O5U/HYxePTvuMy
 vaOUuMBKOG298PiEO9uqXdgIQPPalSLb9xLUV/X4F/f/JzpneiVzvrdaMnGOIckeMwLl
 EB6SY5BIo/4qmtwBBtDEx+fwMm7LLoncvi8hWfhekZXZGT73wpF/5OfReTAjZecT6Lxj
 RckOstbRO2sYMt/xenShqRBTvXHhuLGFORzsGOK3/BxlhETmQMLkf36nOiiBz1mwTkDp
 7Dksd1jZ/KMn2SdgFXywOQDK788xc//afdgGxUBZVTeJwsB9m07QV4/nb56eXV4aaaWO
 7Dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719080520; x=1719685320;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D/l4LkaduINnPL+z0weBnhKvpEc4/vTP1TtPj16QSsw=;
 b=OnNXaz+4wAqCJ4cHAa2YuEjyBzCR3894OqSVueMawFK7yJWeqRFH2S0/hbC1vyxIVK
 vHgxLoFeT3w6ARCUfMinq44jNtdHIcADqBrQ1BfgAlVIkfNzwuayUrL8FsozKElFHg66
 zOh8/Wg3P/r01oGqlYkQcNp9i/MrUwwmYeVj9jf8C6wI7/vyEdhHPXmO42nQzG0ge2Fi
 8KfYvzbHCZ/zs7zGq+w5dzXavsoXPNDEidPYF1NV0h3I4Q6gWMR8cHR39vD6c6Iwyhx4
 BgMxhB0Q5kopcjxM7PMcOoE7LCNdcC9XJxWs3sdMpHEjM8A1bA7ZH/75fsn+qnQn/UdC
 dEbQ==
X-Gm-Message-State: AOJu0YyiFtNcTuOHv0UsYZ8XUcjmVWxE+bKt83dK2M5085SYX/RxuCnX
 EkuYVvxrfbFemE0r0FNy3ktSrp4XZVTuCSd5OV4ZghZauFQlPXbkAyBMzKNsBB16QhrWHUsWBhE
 YXAE=
X-Google-Smtp-Source: AGHT+IG1DU7wwZSFu7bPciKPyn3YF4AcmcJ+uLsXmu8k8P1362juOXoWdxSYgJGNSKRlFWDqXR3oZw==
X-Received: by 2002:a17:902:c406:b0:1f9:fe4c:9d9b with SMTP id
 d9443c01a7336-1fa23f1f2f4mr7124995ad.56.1719080520010; 
 Sat, 22 Jun 2024 11:22:00 -0700 (PDT)
Received: from tops-ThinkPad-E14-Gen-5..
 ([2405:201:c00a:a208:f853:3d75:690f:5f86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb326336sm33886625ad.103.2024.06.22.11.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 11:21:59 -0700 (PDT)
From: Jagan Teki <jagan@edgeble.ai>
To: Kever Yang <kever.yang@rock-chips.com>,
	Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Da Xue <da@libretech.co>,
 Jagan Teki <jagan@edgeble.ai>, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH] phy: rockchip: inno-hdmi: Fix missing readl base addr
Date: Sat, 22 Jun 2024 23:51:49 +0530
Message-Id: <20240622182149.28416-1-jagan@edgeble.ai>
X-Mailer: git-send-email 2.34.1
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

inno_poll passes the reg offset that is used by readl_poll_sleep_timeout
without any base addr.

Fix it.

Bug:
inno_hdmi_phy phy@ff430000: Pre-PLL locking failed
inno_hdmi_phy phy@ff430000: PHY: Failed to power on phy@ff430000: -110.
failed to power on phy (ret=-110)
inno_hdmi_phy phy@ff430000: Pre-PLL locking failed
inno_hdmi_phy phy@ff430000: PHY: Failed to power on phy@ff430000: -110.
failed to power on phy (ret=-110)

Fixes: aa2271184603 ("phy: rockchip: Add Rockchip INNO HDMI PHY driver")
Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
index 3bb1a254ff..7459779dff 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
@@ -432,8 +432,8 @@ static inline void inno_update_bits(struct inno_hdmi_phy *inno, u8 reg,
 	inno_write(inno, reg, tmp);
 }
 
-#define inno_poll(reg, val, cond, sleep_us, timeout_us) \
-	readl_poll_sleep_timeout((reg) * 4, val, cond, sleep_us, timeout_us)
+#define inno_poll(inno, reg, val, cond, sleep_us, timeout_us) \
+	readl_poll_sleep_timeout((inno)->regs + ((reg) * 4), val, cond, sleep_us, timeout_us)
 
 static unsigned long inno_hdmi_phy_get_tmdsclk(struct inno_hdmi_phy *inno,
 					       unsigned long rate)
@@ -575,7 +575,7 @@ inno_hdmi_phy_rk3328_clk_set_rate(struct phy *phy,
 	inno_update_bits(inno, 0xa0, RK3328_PRE_PLL_POWER_DOWN, 0);
 
 	/* Wait for Pre-PLL lock */
-	ret = inno_poll(0xa9, val, val & RK3328_PRE_PLL_LOCK_STATUS,
+	ret = inno_poll(inno, 0xa9, val, val & RK3328_PRE_PLL_LOCK_STATUS,
 			1000, 10000);
 	if (ret) {
 		dev_err(phy->dev, "Pre-PLL locking failed\n");
@@ -674,7 +674,7 @@ inno_hdmi_phy_rk3328_power_on(struct phy *phy,
 			 RK3328_TMDS_DRIVER_ENABLE);
 
 	/* Wait for post PLL lock */
-	ret = inno_poll(0xaf, v, v & RK3328_POST_PLL_LOCK_STATUS,
+	ret = inno_poll(inno, 0xaf, v, v & RK3328_POST_PLL_LOCK_STATUS,
 			1000, 10000);
 	if (ret) {
 		dev_err(phy->dev, "Post-PLL locking failed\n");
-- 
2.34.1


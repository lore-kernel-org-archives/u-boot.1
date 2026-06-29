Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA139C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 18:21:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 096C784A7D;
	Mon, 29 Jun 2026 20:20:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YoaxkFgy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DD0E84A75; Mon, 29 Jun 2026 20:20:47 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BB0D84A4D
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 20:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andreas.zdziarstek@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493b7612475so3018915e9.3
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 11:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782757245; x=1783362045; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CHaI/tqqREe47a7Q47dEK1sWWeF7ypGS8ImD27EHe3w=;
 b=YoaxkFgyGNFw5Q5Fi4AQOaFJYMBwK13HOq6EsoN+wvcMHgLoIA0h6WM7vVPLG2jJhi
 8ah5tPC3tWBijUzToeprxrUlxGeF4e9Pntqm4+lTiorUiknV9cNBX17Lvl3JQREH3Bdr
 wyAMgYiCsCeJArNNDh0UqLyfttXf5mkc8GsLnFkNt9mYOp2isOzrs6aA9FdFzr9Bn+p4
 bYcQ1+2MR0bF8cOFiMuLiEu+tcMkN3YUa12nmAANEmDFMBL5LIjp7WuJG+L649crweo9
 8MBoDKksIHEi5BI2pBeHHbF47Y8zf0TFDWcUk7sX4QyFqRvhuxyaQeskCbBo665oxtP1
 48Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782757245; x=1783362045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CHaI/tqqREe47a7Q47dEK1sWWeF7ypGS8ImD27EHe3w=;
 b=o3MCHpU9+oKcttix0gLajfJ0fI14lxRnPWVwWTnIoA7VH/chl8cwmES/6UIrSgpHFa
 FSo/s/htP6bho4RITHzfeQRcC78h0IQCRg2Me2TeggAXeuRUvtK6UJCSBTXILExJ0ykH
 BZ8RD9ey8MhZoC79XCVSR36tGoflVqzBJ8Wp6uXJjDYiGMyabii79FaKNYJDrEaYtCxm
 SSr8hPpRCdIzIoAGHA1lDvD6G7DDQU/5MwRQUlZjOhfMQDHctBJE+vmU+ljwD1rEOwEF
 FH9pPq1itt429Ekj0RmWR8dobn57Wawl6LBgB5uPSIzuYCOX1Wg3lMsR+fV93TT/+pFW
 XV+w==
X-Gm-Message-State: AOJu0Yym0MdUZysgQk6Cs+f7KEe7h1HTqPt8za8dLirJGI4q7qLEYS4X
 6IFA9H+DE8553sXGKyulAElCoWyVAhg7EBCtJ+lGcHb/VZt7TvqTbo+5Xv7gJB/7
X-Gm-Gg: AfdE7cmsABL9jZ3BUXhU+/kHm5ATnzgaFpdeF3lqY52u12o/5ThRXk0sDfNid1SCy9E
 k8IiOw/lbxWcjvD2BptTSqPdKvuCT95XPafwu1z0ccUjFCcBRTJw5VNO9SugDaQbzQ/X8UfqhZD
 +CZN/c0gt+Ac3W5UAereDAyxt8a0K8CP1kmZm8om8X1b7Nd9wz2/2W0aJE3mDeWpKZ2zENGnjPr
 k48rH3v6ZYGfnypCe/KCN+cLXXkb3OBz2F/prB+13vbK35Wp/sJAXTtUzbsH2MN1+y0g3/PZMaa
 evZ1i0MZYfkqt8ESBuwCWiLg9vN0foonD0086chqKteTx70NPQldPoQ86GLmukGG6IHAMJeX2AP
 gF7XNJg5KWhWQst++5XbOurggrQToVD+kp51EfaR3d2vDPd3T9TSptYNruQydPSkfdFhY71xGKs
 06RWP6b0VYC35Msv5axMEDWtGxNvr5iKVSxj3uMGRAYt5yhNoumSs8P99pPLIvVkE=
X-Received: by 2002:a05:600c:c4a8:b0:492:6efc:7c60 with SMTP id
 5b1f17b1804b1-493b82b556emr11690515e9.28.1782757244618; 
 Mon, 29 Jun 2026 11:20:44 -0700 (PDT)
Received: from turbine.fritz.box (p5784ea85.dip0.t-ipconnect.de.
 [87.132.234.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926c2954efsm219567015e9.2.2026.06.29.11.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 11:20:44 -0700 (PDT)
From: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, jonas@kwiboo.se, quentin.schulz@cherry.de,
 Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Subject: [PATCH v3 2/3] rockchip: rk3568: make the TSADC trigger a first
 global reset
Date: Mon, 29 Jun 2026 20:20:11 +0200
Message-ID: <20260629182012.1508336-3-andreas.zdziarstek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629182012.1508336-1-andreas.zdziarstek@gmail.com>
References: <20260629182012.1508336-1-andreas.zdziarstek@gmail.com>
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

Same rationale as the watchdog: the default second global reset leaves
the SoC hung. Set the TSADC to the first global reset as well, so a
thermal shutdown reliably resets the whole SoC.

Signed-off-by: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
---
 arch/arm/mach-rockchip/rk3568/rk3568.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
index 8bed529a5c1..5e6f79450db 100644
--- a/arch/arm/mach-rockchip/rk3568/rk3568.c
+++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
@@ -40,6 +40,7 @@
 
 #define CRU_BASE		0xfdd20000
 #define WDT_GLB_SRST_CTRL	BIT(1)
+#define TSADC_GLB_SRST_CTRL	BIT(0)
 
 /* PMU_GRF_GPIO0D_IOMUX_L */
 enum {
@@ -152,8 +153,9 @@ int arch_cpu_init(void)
 	writel((PMU_PD_VO_DWN_ENA << 16),
 	       PMU_BASE_ADDR + PMU_PWR_GATE_SFTCON);
 
-	/* Make WDT trigger a first global reset */
-	setbits_le32(&cru->glb_rst_con, WDT_GLB_SRST_CTRL);
+	/* Make WDT and TSADC trigger a first global reset */
+	setbits_le32(&cru->glb_rst_con,
+		     WDT_GLB_SRST_CTRL | TSADC_GLB_SRST_CTRL);
 #endif
 	return 0;
 }
-- 
2.53.0


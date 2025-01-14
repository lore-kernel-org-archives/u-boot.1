Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004DDC02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 05:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53AB9806B7;
	Tue, 14 Jan 2025 06:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hDzoPu6K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 323D08060C; Tue, 14 Jan 2025 06:26:28 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9BC880657
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 06:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anarsoul@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2161eb94cceso61502275ad.2
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 21:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736832384; x=1737437184; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yl0Oz+i8/GFuHt4UW+02z1VdDrTrMrlRs4OVsqCVGxo=;
 b=hDzoPu6K8SuQoARSixGA5HIEkbWBOGU93W7bYUgCUG/lTzRJ8VXN9Ct54/+IvOudDk
 AVSWRVR+t8dY8ajwuXnJqULwhJIxDvfjvI2PKvQsXm7qxGC5Wz672Hq2NNrEW8oyprFW
 SQ2Cq0611obbGki+Hm6EB/3YfLoIQ1Y1afIv6FgddMgaUSX1ABcYiCrLCmkarUUDrt3i
 g8ZyAC2u2iPLhpdt1TqyYje+gt3wCM4YwUM4xAu+sz6/SreNdPAmvFx/cpKmqRvaTREN
 jo+dM9V5l4zlfmmlLUChpyBPLO8Wt067zLD/4sElxvUeBOafwEFxp1OZAWCyGWD41rOb
 ZGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736832384; x=1737437184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yl0Oz+i8/GFuHt4UW+02z1VdDrTrMrlRs4OVsqCVGxo=;
 b=qTwIF+CKnOFRIk0Fcoe78MgNIV3l612qd5y7n8ItazyJL3u+FM3wOKAkPf5lobHqJq
 pMTuo6POjvbxCYpObk0liACWczmxdqAJAWlnrq4mm59u1CKhwXKQd1BdQYzYyT+1yvFi
 h0q6D1u9LPGqzALWr0yEX2FZCDMW7bVs1iNRZDCWob/OHIFg75VHzOnqZXpci5tzIr7Q
 KxNuhxJMP+GHqlNPmikxxtRGQALFHIobCoF2Fs4IAfqSdInFsYbpFXGrOLy9BmonAk4N
 1gMiaEuf8nEQ20c2YuFUHKXrDAvykAg0r5PthbIBdxd9bT9TF4JJnV7iL+JfjuQPXuCO
 SzYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDyfs76zyaeexMZ5ELGbbN4TuV6SzBW+jqmY1HPAG60P4S3MJAQR8rmnENYFUKYozHci4o1Ls=@lists.denx.de
X-Gm-Message-State: AOJu0Yzd006+x+ZDVkZ5lVe1b9fITK6ST48L134hmyUWvDDB7wrOEBLG
 KnXMexj1Va/wQ3CqFIIC3BN01yaHhkIITxThlar52VwxWn7aswy8
X-Gm-Gg: ASbGncukra0Ka3feCvk2j3IJ+IX1JSnGVLU/giKewlFTxxCRRYyI1dh77pmi1/0wZRa
 ncrEq8RNo95wxxasFAqfmunQRooOrTftdlMQ1UauwjBMGHO77XX+IWpL1hFffBN3FdNmXYxVo5e
 plnt3BQoQ15S6WtYw2MyoCVH3K1b+1Zw0uJZyz/9YcNyZiHlAMmEZ/BY4uakQSf/CDaNake5MAk
 b9XSydGe9LnY6QFpeGdGKtWW+P9CFCR1L6oCahC8te6xxWjnw==
X-Google-Smtp-Source: AGHT+IEPQ2T3pJVTJlwM2Yz+w2Xcge5u72D8V1XoqWEkGXIVcGerbqHI0NSjXvAis4cBybkK5CCgwA==
X-Received: by 2002:a05:6a20:2447:b0:1ea:e7e6:f94b with SMTP id
 adf61e73a8af0-1eae7e71661mr9897880637.34.1736832384076; 
 Mon, 13 Jan 2025 21:26:24 -0800 (PST)
Received: from anarsoul-xps15.lan ([2604:3d08:7780:1ca9::398])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d40548922sm6713357b3a.30.2025.01.13.21.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 21:26:23 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Anatolij Gustschin <agust@denx.de>,
 Dragan Simic <dsimic@manjaro.org>, Chen-Yu Tsai <wens@csie.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Jagan Teki <jagan@edgeble.ai>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 2/3] video: rockchip: rk3328: filter unsupported modes
Date: Mon, 13 Jan 2025 21:24:20 -0800
Message-ID: <20250114052548.763611-2-anarsoul@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114052548.763611-1-anarsoul@gmail.com>
References: <20250114052548.763611-1-anarsoul@gmail.com>
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

While RK3328 is capable of 4K resolution, dw-hdmi driver in u-boot
seems to have some issue with 4K. 1440p or lower works fine.

Limit max resolution by 2560x1440x60Hz, by filtering the modes with
pixel clock > 297MHz

Fixes: f3ea872970d603 ("video: rockchip: Add rk3328 hdmi support")
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/video/rockchip/rk3328_hdmi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/video/rockchip/rk3328_hdmi.c b/drivers/video/rockchip/rk3328_hdmi.c
index 763669c09be..d02c58c44c5 100644
--- a/drivers/video/rockchip/rk3328_hdmi.c
+++ b/drivers/video/rockchip/rk3328_hdmi.c
@@ -105,9 +105,16 @@ static int rk3328_hdmi_probe(struct udevice *dev)
 	return 0;
 }
 
+static bool rk3328_hdmi_mode_valid(struct udevice *dev,
+				   const struct display_timing *timing)
+{
+	return timing->pixelclock.typ <= 297000000;
+}
+
 static const struct dm_display_ops rk3328_hdmi_ops = {
 	.read_edid = rk_hdmi_read_edid,
 	.enable = rk3328_hdmi_enable,
+	.mode_valid = rk3328_hdmi_mode_valid,
 };
 
 static const struct udevice_id rk3328_hdmi_ids[] = {
-- 
2.47.1


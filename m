Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC07C83038
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:07:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B5D382E9A;
	Wed,  2 Jul 2025 03:05:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UjcXLcLi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CCA183095; Wed,  2 Jul 2025 03:05:41 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ADF082E9A
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:05:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4079f80ff0fso4241022b6e.1
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418338; x=1752023138; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UTeZuqwmrEzU6qKjaBiAB9jALSwsPIWuJRlbxet3XoI=;
 b=UjcXLcLiMheJYBdNZOUfgBUuQgd+mbPNPXG4anaQ+WR32haUjFu8zUs4w3on+l+Pa8
 VLGbn0edUqb8bWIkz/RcqCq9iAmwk+cBtQ2TnSwxwbbPGbMqYaSYI5s9JHzi59MSTWx+
 jw2W617CAY4uyXWmOGzvnrFCw3PFCrQsQsFZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418338; x=1752023138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UTeZuqwmrEzU6qKjaBiAB9jALSwsPIWuJRlbxet3XoI=;
 b=sGdH+TWy6NKbJ9lpYicmarFeGXUI5n/YH4n6WSC6Z6ao52Lj0k7rUmra1CzpJQcOsR
 /7pbZuVSEC+iLxTtKc1iIE3v5PANp5L9Sgjsq/eyxDnFd8shNdiT8LCBHLbgox8VpbbF
 7JbMqpKI+jzoPGMm4NZF6KEVkPs04hbfxK3+W21EtOfl1x+GhdlaQ9W5XMq0nqaA4BSg
 StmNcIJ1aBWgba9+pvWpzZ/Wm9F5cvyKngSbIvHBxCjsgQy3rMGnphDxDtZeURq3wrO6
 BNoOrsJjmOV5iCaCy2oyHQYBLUy9PQ+bN6bRGS7q9c9g1JFGsJUPwPrc1s89hv2HrLYe
 W/rw==
X-Gm-Message-State: AOJu0Yx+adkoaZ9QqmWhpg8HAJIpxbUY5qgLg++MgJVmYapp/oL8opmU
 TJ0vdmbddUUSZKz/DqvGdITieYUZklBh7H85nR0kP7yKddUsHjdUOsNszGCTzkbQjRXEspOSDHk
 F2awCRX8=
X-Gm-Gg: ASbGncs4TuvE1kFTxl0COob+4l8o/cOYm/3rpx20p5nZOHt/U1psdXKI1H5TxFsFnou
 K4WZ8KsRj9pnZmHoZNUzwezITPCNjLc2+1AwnF9puAmcGVatgYxoznb05x928ixF8ztUFgf1iws
 qc9/nkfaOeiYa2JjAqhU9SUaqvmi0ocVwb9F0PJRkyZRdjdUXWcAL2dYjhy1CLCByMqLxcL1A0/
 XMqU3v0XqJ/DZeTq9Rhg53XGo5JlW8y42IFGpsKeiMVxvS4y+ehmr5f02/ZF/hzcFIzJ+FiROTM
 6YQSnBgH8wuG4vlaOeWXb/ehOMCh1VvCHUBoqeU4FwRvLmmlGRh271obls7AXNypA1b+iSV728l
 UoE0qB4fNWuGPSnG8Z2TA9rM=
X-Google-Smtp-Source: AGHT+IGA+6AGJIbV1YGiqD54KK1vTYI09sn+tJa6cXWrpVRpiyRMghnI8eWU4dCpPUctCSs7kda5uw==
X-Received: by 2002:a05:6808:4f1f:b0:406:69b5:36da with SMTP id
 5614622812f47-40b8aabd9f3mr525837b6e.16.1751418337838; 
 Tue, 01 Jul 2025 18:05:37 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b324054a2sm2377372b6e.31.2025.07.01.18.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:05:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 2/3] clk: clk-cdce9xx.c: Change from u32 to ulong for addresses
Date: Tue,  1 Jul 2025 19:05:34 -0600
Message-ID: <20250702010535.19250-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702010535.19250-1-trini@konsulko.com>
References: <20250702010535.19250-1-trini@konsulko.com>
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

For 32/64bit correctness, we need to use ulong and not u32 for casting
for addresses.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Sean Anderson <seanga2@gmail.com>
---
 drivers/clk/clk-cdce9xx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-cdce9xx.c b/drivers/clk/clk-cdce9xx.c
index e5f74e714d54..afb997c06be5 100644
--- a/drivers/clk/clk-cdce9xx.c
+++ b/drivers/clk/clk-cdce9xx.c
@@ -103,7 +103,7 @@ static int cdce9xx_clk_probe(struct udevice *dev)
 	u32 val;
 	struct clk clk;
 
-	val = (u32)dev_read_addr_ptr(dev);
+	val = (ulong)dev_read_addr_ptr(dev);
 
 	ret = i2c_get_chip(dev->parent, val, 1, &data->i2c);
 	if (ret) {
@@ -226,10 +226,10 @@ static ulong cdce9xx_clk_set_rate(struct clk *clk, ulong rate)
 }
 
 static const struct udevice_id cdce9xx_clk_of_match[] = {
-	{ .compatible = "ti,cdce913", .data = (u32)&cdce913_chip_info },
-	{ .compatible = "ti,cdce925", .data = (u32)&cdce925_chip_info },
-	{ .compatible = "ti,cdce937", .data = (u32)&cdce937_chip_info },
-	{ .compatible = "ti,cdce949", .data = (u32)&cdce949_chip_info },
+	{ .compatible = "ti,cdce913", .data = (ulong)&cdce913_chip_info },
+	{ .compatible = "ti,cdce925", .data = (ulong)&cdce925_chip_info },
+	{ .compatible = "ti,cdce937", .data = (ulong)&cdce937_chip_info },
+	{ .compatible = "ti,cdce949", .data = (ulong)&cdce949_chip_info },
 	{ /* sentinel */ },
 };
 
-- 
2.43.0


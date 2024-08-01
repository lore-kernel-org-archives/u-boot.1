Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F12C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 22:59:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A870388BA9;
	Fri,  2 Aug 2024 00:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HXSN//n4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE72588B23; Fri,  2 Aug 2024 00:57:51 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C84CE88B58
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 00:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-26106ec9336so4148098fac.2
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 15:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722553067; x=1723157867; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a2wlPwPd+/xFVtIqIkl4qLfs8MeBi7Imh69A0gAyaKE=;
 b=HXSN//n4qBkR1rxPTjhYeEXvDJyBScK5Q1p88mnRQn27lLaEk6JyBHTS2sRgAeFTGz
 1wsQDGJKGUAbmihA09w4OPoiVv2Sviy8lkQC9iCbUvOXOsEMHuJdBBJEiftAcLyaz6xL
 FH7v0m6cKvjpp3rPhEwD5tpAh3rN5B3DsLl3ny7mQ/gEve1eEH4Dc8b2LjUZSG1GdVzz
 YuBc1rG2+m+ppiET7sUetuobps/qoc8dctBl20Ukg8xMmfUGoVVoo8sMGqF1FH4DJPIC
 5OKQb5qmCJYDJtqAhKJ168oVWWrDilSB+sVRa8LBsP3kWq50EHOiU1ycDw/2Y3Nn+FFG
 LBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722553067; x=1723157867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a2wlPwPd+/xFVtIqIkl4qLfs8MeBi7Imh69A0gAyaKE=;
 b=sKgpGe6thgTMYDAnYwVfyMehYnPaJwmXSQ/+TtTs46D8pDTm8kj3vpZYYZYizNHJE5
 cxTGl5XsTlKNLlCY6Gy2FtVl+1P3R9l8hYFMO93WlXk2vvtfXiQqmaUQroU2jxeHktW1
 cEguIEzA9dKpqg7IFziV3I7ir493D4zhox2Q3OY1KlbwMB+Tp/BvE+WosbM7jVEME8HD
 /fiKxX7TYbZyaL9IBdK5+B9n96FoVyJKXJHk0udK0c0TIeKWccFJo1EYRInyLnE+biHj
 OOu4r5Bn5siSS71lh6Z8DtcrX15jFjY7HZxF8zdqAX2OsP+IwJsTmx8a18SwZRtrdZ+U
 MUiA==
X-Gm-Message-State: AOJu0YxcfqfP/HSK2bK/jLrtuwYg8I2Eh4fU/PUyDWfAQkCtdRvl+Jrx
 xqkWqFubsufCOqceJ5CaKBPLI9YDg74ql1sBbWO1gOUx4gtWZwLK9XCw2Q==
X-Google-Smtp-Source: AGHT+IHJMVtu2w+QtIXn2w/JQD06pQIQvo/E9NC5on0zloXBHx/MUHEHo4k1/T0bAwvKtrLBHxTBLg==
X-Received: by 2002:a05:6870:a99d:b0:260:8f6d:f01f with SMTP id
 586e51a60fabf-26891e93234mr1816737fac.39.1722553067269; 
 Thu, 01 Aug 2024 15:57:47 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a67b515sm58039fac.50.2024.08.01.15.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 15:57:46 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 7/9] sunxi: H616: dram: Update mbus priorities
Date: Thu,  1 Aug 2024 17:55:17 -0500
Message-Id: <20240801225519.336667-8-macroalpha82@gmail.com>
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

CSI1 channel (22) is missing and IOMMU (25) has priority flag set in
vendor bootloader. Fix that.

While at it, replace bandwidth flag with priority since original flag has
always value "true".

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Tested-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/mach-sunxi/dram_sun50i_h616.c | 41 +++++++++++++-------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index 3075d9c80d..d2380a3531 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -55,8 +55,8 @@ static void mbus_configure_port(u8 port,
 	writel_relaxed(cfg1, &mctl_com->master[port].cfg1);
 }
 
-#define MBUS_CONF(port, bwlimit, qos, acs, bwl0, bwl1, bwl2)	\
-	mbus_configure_port(port, bwlimit, false, \
+#define MBUS_CONF(port, priority, qos, acs, bwl0, bwl1, bwl2)	\
+	mbus_configure_port(port, true, priority, \
 			    MBUS_QOS_ ## qos, 0, acs, bwl0, bwl1, bwl2)
 
 static void mctl_set_master_priority(void)
@@ -68,24 +68,25 @@ static void mctl_set_master_priority(void)
 	writel(399, &mctl_com->tmr);
 	writel(BIT(16), &mctl_com->bwcr);
 
-	MBUS_CONF( 0, true, HIGHEST, 0,  256,  128,  100);
-	MBUS_CONF( 1, true,    HIGH, 0, 1536, 1400,  256);
-	MBUS_CONF( 2, true, HIGHEST, 0,  512,  256,   96);
-	MBUS_CONF( 3, true,    HIGH, 0,  256,  100,   80);
-	MBUS_CONF( 4, true,    HIGH, 2, 8192, 5500, 5000);
-	MBUS_CONF( 5, true,    HIGH, 2,  100,   64,   32);
-	MBUS_CONF( 6, true,    HIGH, 2,  100,   64,   32);
-	MBUS_CONF( 8, true,    HIGH, 0,  256,  128,   64);
-	MBUS_CONF(11, true,    HIGH, 0,  256,  128,  100);
-	MBUS_CONF(14, true,    HIGH, 0, 1024,  256,   64);
-	MBUS_CONF(16, true, HIGHEST, 6, 8192, 2800, 2400);
-	MBUS_CONF(21, true, HIGHEST, 6, 2048,  768,  512);
-	MBUS_CONF(25, true, HIGHEST, 0,  100,   64,   32);
-	MBUS_CONF(26, true,    HIGH, 2, 8192, 5500, 5000);
-	MBUS_CONF(37, true,    HIGH, 0,  256,  128,   64);
-	MBUS_CONF(38, true,    HIGH, 2,  100,   64,   32);
-	MBUS_CONF(39, true,    HIGH, 2, 8192, 5500, 5000);
-	MBUS_CONF(40, true,    HIGH, 2,  100,   64,   32);
+	MBUS_CONF(0, false, HIGHEST, 0,  256,  128,  100);
+	MBUS_CONF(1, false,    HIGH, 0, 1536, 1400,  256);
+	MBUS_CONF(2, false, HIGHEST, 0,  512,  256,   96);
+	MBUS_CONF(3, false,    HIGH, 0,  256,  100,   80);
+	MBUS_CONF(4, false,    HIGH, 2, 8192, 5500, 5000);
+	MBUS_CONF(5, false,    HIGH, 2,  100,   64,   32);
+	MBUS_CONF(6, false,    HIGH, 2,  100,   64,   32);
+	MBUS_CONF(8, false,    HIGH, 0,  256,  128,   64);
+	MBUS_CONF(11, false,    HIGH, 0,  256,  128,  100);
+	MBUS_CONF(14, false,    HIGH, 0, 1024,  256,   64);
+	MBUS_CONF(16, false, HIGHEST, 6, 8192, 2800, 2400);
+	MBUS_CONF(21, false, HIGHEST, 6, 2048,  768,  512);
+	MBUS_CONF(22, false,    HIGH, 0,  256,  128,  100);
+	MBUS_CONF(25, true,  HIGHEST, 0,  100,   64,   32);
+	MBUS_CONF(26, false,    HIGH, 2, 8192, 5500, 5000);
+	MBUS_CONF(37, false,    HIGH, 0,  256,  128,   64);
+	MBUS_CONF(38, false,    HIGH, 2,  100,   64,   32);
+	MBUS_CONF(39, false,    HIGH, 2, 8192, 5500, 5000);
+	MBUS_CONF(40, false,    HIGH, 2,  100,   64,   32);
 
 	dmb();
 }
-- 
2.34.1


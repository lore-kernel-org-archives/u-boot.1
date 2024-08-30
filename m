Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1C6CA1008
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 15:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CEF388CF3;
	Fri, 30 Aug 2024 17:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PMmzs2uy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 434E788C9C; Fri, 30 Aug 2024 17:57:45 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1094888C4D
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 17:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-70f65cad4b8so624904a34.0
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725033462; x=1725638262; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AssYWMbHFN8tdCn1r57ryZidzz1hchum9dNphDQAZ40=;
 b=PMmzs2uyy9hCNjiRK9HJ1RxY/rSIDS3dlxD7Gd65TrKnYAbIx7I7wFc0VWhUqa7CDt
 Rbbbpuhnf5eAej1jEOMBVr1utlM+LtX0BEee7x/7zzRFlOv4NkWxuDzslfoILNsqSuE7
 cqms0BPx8KSQ/95qEqeGJfmUWiLntaCceuWzLJ2vzS46zsDkC8vrygjyn0xTkCPcTlf7
 X1XHTolxlYqktzsjtByZa4A8EhbX7P8LBS8H6jZe7pQ8TkoUfnFgqKitXE3EX9lv2n22
 NKRgU8U1+VP+5/jXodld4MrRhimBUgHiC33/8ndcmDMucLB2Ah3OblSw8+arBuavPILb
 4VNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725033462; x=1725638262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AssYWMbHFN8tdCn1r57ryZidzz1hchum9dNphDQAZ40=;
 b=X1pTifY5EZ/C3VSynINGdg82DqwHWqsevPGoYYoLN64eBfPw/CuGN6soeD0qpLi9aT
 hPq/IhxG66Y/8GOTtUxwYxTrxSHEIjqhSUdfTcVo/pXhfBbRtYSd9LqMxCv83WC/D7Nr
 h40rZk5EZxutl6LXYuTTD7OnRz0rjnbZ9Uk8Oj+tQ2re2reG8ha3hI8Hfj4cz8x0fw/d
 ZD3CFhiaR8vv6/FUvP3l4jA0XduV1itUGvyTSIZuMphG5sBsT9uHDo8DXLnLFudtkVY9
 j4yjiksENYVQhkQzxUX0K4V/AY2GZoViga83iDBoIQ6Za+FfKOS1GxhDSWHoG2dcarPj
 LbmQ==
X-Gm-Message-State: AOJu0YwDRh8fBGww3ZKp9UY+ZA3H/6cEtAb+6cK0N4GJRkRzr3pGowzv
 Ng3J5Yjwf7hGwofrTQqiKSI/tPJCMyKiGxhyWE2n5f6GBkP7utZ1go5kew==
X-Google-Smtp-Source: AGHT+IHoKp+AAk5rjRIe35HAwAj0B13fy69idHtsqD0pHkzuqgX9El/+AHGMWn7I+L09TNDV0KvY4w==
X-Received: by 2002:a05:6830:4990:b0:703:6cde:1cb9 with SMTP id
 46e09a7af769-70f67f2d740mr1491462a34.13.1725033461661; 
 Fri, 30 Aug 2024 08:57:41 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70f671a8630sm490092a34.51.2024.08.30.08.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 08:57:41 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com, iuncuim@gmail.com,
 sumit.garg@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 5/9] sunxi: H616: dram: Update mbus priorities
Date: Fri, 30 Aug 2024 10:55:10 -0500
Message-Id: <20240830155514.481410-6-macroalpha82@gmail.com>
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
index 4782e6fe38..863c4f1d7a 100644
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


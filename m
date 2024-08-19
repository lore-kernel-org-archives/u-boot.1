Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E559BC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 15:03:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC9BE88CF5;
	Mon, 19 Aug 2024 17:02:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HQSWQnkl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A99DA88ADB; Mon, 19 Aug 2024 17:02:08 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 453D988CE6
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 17:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5d5af7ae388so2357158eaf.0
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 08:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724079725; x=1724684525; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6mPa4OuabQeX2loaQ2kTd5kAkhyoVHYBr7+w8aNFRWs=;
 b=HQSWQnkljIEhxIGMBE/qVTBN6vsGjttU0AO/LVGapYls8dzwwqlmaPMQRH50VLQzaB
 tkt1NERskgroOotMinIj0ypzDsYXdAiOlSm0pAvgFl3DWl7p6yZFpdS/StrG3jUXhpaX
 DRXgMhOMDONPGjGMMcFw36n6/IZqnHaBbnJ7cDaVLmEthZ+TCRTWKVZz2uVM1xfDX0eH
 O0ZmEy1VSTMP++8uc2WYTUtg3DeNeVq7mVveg1W+x/2Q6Pq5Jqe8ZCIY528bVEYlL+Nl
 gUY67w6RwwzkUW8ihyIgetchQMvXm2Tn+wRR8e22nMMevdkxe4v7k8pJTJDhgBUdh9Hs
 EPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724079725; x=1724684525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6mPa4OuabQeX2loaQ2kTd5kAkhyoVHYBr7+w8aNFRWs=;
 b=AzdJsDKWBc7RA12Yhl0Rkyv/KzzsGeNjwiS9kX80mrRxCHZK7AopieiglRgYZxECeL
 +nJYzrOKWFQ7tqhVaBDmAJCgsFDkRwKLP3t6whpDRxX9Pu4aDGfs3uOseo6qGOzQqN80
 +4k07JkYkOw3WKcc2v4+qU6qVR3s/uMZqtJia2uDAYzW6J4Djnk3BQul5aJ7UByGJOB1
 pir3wOCdpJBH0pwYeTzrMXo09sdw9B0CjdlJMbOUjz/0V9eOKsrJNKwWlbMxl4h3k0bH
 vEjVNHDz6661qDqUglYQmqRPRKRO5ksFKFs8Ko8/XtGZkl5hFG51Ia1/a5Gu/LnnoF/T
 RpNQ==
X-Gm-Message-State: AOJu0YyYokefWR2YY7yqz5odPdOASicsxWlTctX3adWiHfauDsr+HsRZ
 UrRSO4x8ShFchXRZXp5vbNFD/ta/K6e//1yoZ2xwzpk0+ODx2zqaO0OeJg==
X-Google-Smtp-Source: AGHT+IGZpnZo9P16/vc058+NnPmp59Pg73KCKQX6xzc5LUM7CgXV5SIVPyvZWTa3APl8AVZImtwZ3Q==
X-Received: by 2002:a05:6870:3290:b0:260:27c6:48b6 with SMTP id
 586e51a60fabf-2701db7c1a0mr4838781fac.8.1724079724613; 
 Mon, 19 Aug 2024 08:02:04 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-27004432d18sm2945189fac.7.2024.08.19.08.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 08:02:04 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com, iuncuim@gmail.com,
 sumit.garg@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 5/9] sunxi: H616: dram: Update mbus priorities
Date: Mon, 19 Aug 2024 09:59:34 -0500
Message-Id: <20240819145938.503221-6-macroalpha82@gmail.com>
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
index 2f2776ce35..c0bcf2eec7 100644
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


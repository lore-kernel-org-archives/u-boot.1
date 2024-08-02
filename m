Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFA6C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CFD088C0F;
	Fri,  2 Aug 2024 21:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fDF1g/uU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAE4F88C13; Fri,  2 Aug 2024 21:52:06 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D65AA88C4F
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:52:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-368440b073bso2299760f8f.0
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722628323; x=1723233123; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tnTo+hdD4tBsawHFt8O2ho//PArMPoaxDVt+kUP4aTQ=;
 b=fDF1g/uU+s3aUGnjhWdOw606jXj9jngCm3MmIgu2pL7cb1+PuzL26nanHhaGE9nNiG
 xVu0H0X6qCrvhiJfdD7RgVI555SVT7RU8C6upzEIi6s1t8gxpMLRI3010Sww/bP+Z90K
 BW7QxaTRkU9WPq4eZeSLkc+VQHD1oZF2qx6kYmqUttCyL1Um5rsVRngKipmiErS/OPB1
 o905CjJ52HNc2S1JHQNxDbfGSsNmlHFVhPZrDHCAACVYuPWHBKp/w9BPRUTFn9lUgeTj
 TGJpfoagnvBZpswXXW7kn5C8+CwrFGv87PDadRAhgGsTGkWKY3PBKXNBN5hjfxjaZ3Om
 lS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722628323; x=1723233123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tnTo+hdD4tBsawHFt8O2ho//PArMPoaxDVt+kUP4aTQ=;
 b=dU9JddxvJSxxr8LFSYqP2Fpt5KagnbqtVxNWwZ+nDdbD7l2NEVBJW0fdiWgb/ieWwS
 2i7j9KXNyeKyh08YyErqp9/D65rAqodE+4s3ISPKiNyLgdmomtaikZZZGR+NR11Yq4dD
 QM1W8Em9Q3f0GT082zGHU98cDG4pbTrlltBgOId5VbnbqJm2dE+Nw5y0MXdebJKjjDxY
 0LJhBwYr6gOMz8qlcpPay0RdvAVhzfsPrJ74VxId/EK0MllLH1llBoyR+7YU3IqBiZEc
 FLVWWNg7k49mHHWXXqhPid+vF7c06FljzRps8TeY8saFhqY8++89dlpaigTGmIptGjn6
 sd/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ8RpQqimEzXHYRl9bxtBtyzySCLVmTBvhICunUn149McJ4nVHqBf2G14EpXh1Vx7+ON/nszUPU+ym4yEZhLthRM6IUg==
X-Gm-Message-State: AOJu0YxmnkCqd8YFiCejOeTPv7LO7+ilimu6dhjjpR2wIJgKI89FK/8k
 stRCuaIyeBbCM+GDafb2xH/jgQfrGhGscU7QDT4g1ddKYH5T4qCF
X-Google-Smtp-Source: AGHT+IGxCcQlFxwRvFI5W+Xv2uW45ioKcBJT9vTEdc8W+6fSJTs+ZNtFLd0YHPe0Ul/VkZznJ20Z3A==
X-Received: by 2002:adf:f588:0:b0:360:70e3:ef2b with SMTP id
 ffacd0b85a97d-36bbbecb238mr3229083f8f.26.1722628323151; 
 Fri, 02 Aug 2024 12:52:03 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36bbd06d03fsm2643344f8f.91.2024.08.02.12.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:52:02 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 6/8] clk: mediatek: mt7622: add missing clock PERI_UART4_PD
Date: Fri,  2 Aug 2024 15:48:30 +0200
Message-ID: <20240802134835.24006-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802134835.24006-1-ansuelsmth@gmail.com>
References: <20240802134835.24006-1-ansuelsmth@gmail.com>
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

Add missing clock PERI_UART4_PD for peri clock gates. This is needed to
match upstream linux clk ID in preparation for OF_UPSTREAM.
Also convert infracfg to mux + gate implementation as now we have mux on
top of gates.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7622.c      |  1 +
 include/dt-bindings/clock/mt7622-clk.h | 25 +++++++++++++------------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 0da7a848163..5df62e64c9a 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -472,6 +472,7 @@ static const struct mtk_gate peri_cgs[] = {
 	GATE_PERI0(CLK_PERI_UART1_PD, CLK_TOP_AXI_SEL, 18),
 	GATE_PERI0(CLK_PERI_UART2_PD, CLK_TOP_AXI_SEL, 19),
 	GATE_PERI0(CLK_PERI_UART3_PD, CLK_TOP_AXI_SEL, 20),
+	GATE_PERI0(CLK_PERI_UART4_PD, CLK_TOP_AXI_SEL, 21),
 	GATE_PERI0(CLK_PERI_BTIF_PD, CLK_TOP_AXI_SEL, 22),
 	GATE_PERI0(CLK_PERI_I2C0_PD, CLK_TOP_AXI_SEL, 23),
 	GATE_PERI0(CLK_PERI_I2C1_PD, CLK_TOP_AXI_SEL, 24),
diff --git a/include/dt-bindings/clock/mt7622-clk.h b/include/dt-bindings/clock/mt7622-clk.h
index 0820fab0a22..4b6501c1020 100644
--- a/include/dt-bindings/clock/mt7622-clk.h
+++ b/include/dt-bindings/clock/mt7622-clk.h
@@ -146,18 +146,19 @@
 #define CLK_PERI_UART1_PD		13
 #define CLK_PERI_UART2_PD		14
 #define CLK_PERI_UART3_PD		15
-#define CLK_PERI_BTIF_PD		16
-#define CLK_PERI_I2C0_PD		17
-#define CLK_PERI_I2C1_PD		18
-#define CLK_PERI_I2C2_PD		19
-#define CLK_PERI_SPI1_PD		20
-#define CLK_PERI_AUXADC_PD		21
-#define CLK_PERI_SPI0_PD		22
-#define CLK_PERI_SNFI_PD		23
-#define CLK_PERI_NFI_PD			24
-#define CLK_PERI_NFIECC_PD		25
-#define CLK_PERI_FLASH_PD		26
-#define CLK_PERI_IRTX_PD		27
+#define CLK_PERI_UART4_PD		16
+#define CLK_PERI_BTIF_PD		17
+#define CLK_PERI_I2C0_PD		18
+#define CLK_PERI_I2C1_PD		19
+#define CLK_PERI_I2C2_PD		20
+#define CLK_PERI_SPI1_PD		21
+#define CLK_PERI_AUXADC_PD		22
+#define CLK_PERI_SPI0_PD		23
+#define CLK_PERI_SNFI_PD		24
+#define CLK_PERI_NFI_PD			25
+#define CLK_PERI_NFIECC_PD		26
+#define CLK_PERI_FLASH_PD		27
+#define CLK_PERI_IRTX_PD		28
 
 /* APMIXEDSYS */
 
-- 
2.45.2


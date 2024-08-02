Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D45CC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:57:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C9D888C2F;
	Fri,  2 Aug 2024 21:56:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UhkbwyOl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D35488C6A; Fri,  2 Aug 2024 21:56:39 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0BD088C36
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:56:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-428e0d184b4so16146885e9.2
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722628596; x=1723233396; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zUwxp90/MEx06lhOUj/Ney8+BuEg/9FiX31Dy0NtLKw=;
 b=UhkbwyOllT7CeNZ5eTrQzBPNtvileDhYNXcj31YTnCXtwQN1qHtmdldPeTPb9HurkO
 Pe6gunifELj0CSWrfXaVp020Grs37qThBVgS2AgXRmmisFVqEhgDXrzvkVooDt4et/2h
 37mphW0jU2RUSCKa3GwwQLbq2sa/3TyZTxMLS3EYQNzFBiXabhMLF3Gdu1VEjfiF8vPS
 A1F+q2PjnGszWBVnRD7kfyrZ8yJ2S2X5B9Qrqe7vk6LpEMIrjMoDmdQFz32k2dYa111G
 X5Aue0LY/oEdU1v9ASKQ1FGRchvGNI+W11LWsMy8epHrnV9BOZWdpEmP7S3QXpBkr6D+
 Us3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722628596; x=1723233396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zUwxp90/MEx06lhOUj/Ney8+BuEg/9FiX31Dy0NtLKw=;
 b=NP7uBXCnVcXsXGwcfvPLNCbP+GNwH9CKIMwgox1oqjckA4dZ8wCvsB6iNT8hvTz8g5
 fV5ki3gwNePjOcTGj88O7vDR8f6Bh2dgaz2DPkNkfJfhqr35WPJQdISdXyfcM7UKVDGN
 dC9P2In2ppHd8rFaX98HpQoBzlaUcyPkHQ5JSDXM9n5KfDZneFFYBGzNps5si21dKtCu
 eXJx7ZFwwmKGCY2sdRhQrrkH7VXEG/OXvWlKxefZ1NVq5UAuEeIwu8CDjRA7d3Hg4Rx6
 bcLPKqRdeszyi2T34zuVFQMHUtzMk6OCka0kfArpa9WbsYzQfDTmnNPlBKVzopb2zQO4
 u8ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUehoA0d7gsWAUuV7S3O2fYm48xWpf5OySzG7IywcxN/ZQrsoL5ZOEbykTm1ARDmMev/pMCRf0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx75gnlUgLe2gWNgE6K/fanYGZ/0s836kCdJ4ERT5OTUlOPuoeB
 EMYpUyJmnfcLNJQqUwhd0YC980PJYjuKBi9JvKuwZnsTCaWGALoo
X-Google-Smtp-Source: AGHT+IHD1W+zhV0KAVi/wb1aQMhsHuKbGaPt3OJ9bxOazTquzxLkVbHJ83PxJAetBEmaTT+Cq1ckvA==
X-Received: by 2002:a05:600c:524e:b0:426:51ce:bb14 with SMTP id
 5b1f17b1804b1-428e6b7f4abmr27520865e9.30.1722628596229; 
 Fri, 02 Aug 2024 12:56:36 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428e6e01d0asm43350485e9.16.2024.08.02.12.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:56:35 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Crispin John <john@phrozen.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH 04/14] clk: mediatek: mt7981: fix wrong clock definition for
 spi2
Date: Fri,  2 Aug 2024 15:53:05 +0200
Message-ID: <20240802135326.25303-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802135326.25303-1-ansuelsmth@gmail.com>
References: <20240802135326.25303-1-ansuelsmth@gmail.com>
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

Fix wrong clock definition for spi2 node as they reference spi0 clock
instead of spi2.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/mt7981.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/mt7981.dtsi b/arch/arm/dts/mt7981.dtsi
index 1056667ba65..131adc00a56 100644
--- a/arch/arm/dts/mt7981.dtsi
+++ b/arch/arm/dts/mt7981.dtsi
@@ -286,10 +286,10 @@
 	spi2: spi@11009000 {
 		compatible = "mediatek,ipm-spi";
 		reg = <0x11009000 0x100>;
-		clocks = <&infracfg_ao CK_INFRA_SPI0_CK>,
+		clocks = <&infracfg_ao CK_INFRA_SPI2_CK>,
 			 <&topckgen CK_TOP_SPI_SEL>;
 		assigned-clocks = <&topckgen CK_TOP_SPI_SEL>,
-				  <&infracfg CK_INFRA_SPI0_SEL>;
+				  <&infracfg CK_INFRA_SPI2_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_CB_M_D2>,
 					 <&topckgen CK_INFRA_ISPI0>;
 		clock-names = "sel-clk", "spi-clk";
-- 
2.45.2


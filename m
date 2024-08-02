Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CE6C3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4041D88C36;
	Fri,  2 Aug 2024 21:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pmjm0dRT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E2CF88C2F; Fri,  2 Aug 2024 21:56:40 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 301F588C4C
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4257d5fc9b7so75914555e9.2
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722628598; x=1723233398; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KwgE/DwoMkkYLq+BnoMP5gt5Mhab3Lja2XZVGTvvmRI=;
 b=Pmjm0dRTHVQY1DpTMl6qkT26ISoT588RRCLFKc+gtPUJsi1dOv7abKGFm9MoDJAQXi
 7Vqhh1Tt7JuHXmFdzsYQ7tsm6Qjdvr7La2CzjKDmjhcrkB+Bpp6ZFsIBK/6x1x5zu3/G
 Gz3yzIT/pulqhXd/yvONpB7vq0zRgjtt/5Tzj+4eacxr6xJB4JS4tmxxE5cMWlVjKkzU
 N0rNaeUWLmDfEWduvhjxCW0bKxB7+zik9WJVvNLZ4JmsWSyZIP9gLr1XDMqCoq2IWIz1
 ZkO72qfhYuq8D81VUuzTm0EFJB81/xguCLpUGRpWsOE1KIC81o1hMHdWksfdGN13/MnT
 oRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722628598; x=1723233398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KwgE/DwoMkkYLq+BnoMP5gt5Mhab3Lja2XZVGTvvmRI=;
 b=KwHaZAQGYDe1iPGeJj+bAZojcrith69hltHuuyqInzQVEAu4mUmEIkIjsM2J1nQdJt
 6nlyrQkRljw3E9uUJeAgftZax83dHbsZuGPFZ7sVRlXInf9kaVK3pUgLG5CCeJtrQp9W
 RXqAdG1arJ1JYjaMCFzNR61YPVOplOPz73Gg8ERmYjlEsXEiEI7uGb4sjb4eCO3H9xoJ
 SwqEQxdFtn1+VlxeP3G3b6k2DLbts3nmen4MGTlvNV7RJu6QEYF+zw6zKZjxJtCdR8dw
 gAOe11t0izESGt+EKmKJDF0oj0nS3WJpoe4pKJxz8r4BF+WCkiu+yfEPX7mC8qTpdCI3
 4mnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq6/mrKwL3Kh/LSjA+god+YQm2TmAfCgzYj2AxSTLESqgGyX3rIrRbjUTepQX9Px8LyAAQfADMCbUrHSvMGxurDC4inw==
X-Gm-Message-State: AOJu0Yz3sw1WLi0t/YjLyljOYFUPDfjR3Pg+N/CWRxm7093GhoRHo//3
 PCGk5CZkoXOUnlheasOAVyHejtEhpBJjn26TBkkNA9++XMPXZjpv
X-Google-Smtp-Source: AGHT+IHxSLQ9SmOtCLQ8/yvrfkcfdiC0Bz9zJaoowpOm3882ZXgd9C0okRKHJJMk3NfHarQois4nSw==
X-Received: by 2002:a05:600c:524e:b0:426:63f1:9a1b with SMTP id
 5b1f17b1804b1-428e6b9547dmr35366715e9.33.1722628597549; 
 Fri, 02 Aug 2024 12:56:37 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428e6e01d0asm43350485e9.16.2024.08.02.12.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:56:37 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Crispin John <john@phrozen.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH 05/14] clk: mediatek: mt7981: add missing clock for spi1 node
Date: Fri,  2 Aug 2024 15:53:06 +0200
Message-ID: <20240802135326.25303-6-ansuelsmth@gmail.com>
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

Add missing clock for spi1 node. Clocks taken from upstream clock
definition and clock mux.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/mt7981.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/dts/mt7981.dtsi b/arch/arm/dts/mt7981.dtsi
index 131adc00a56..d80eceb8d4c 100644
--- a/arch/arm/dts/mt7981.dtsi
+++ b/arch/arm/dts/mt7981.dtsi
@@ -280,6 +280,13 @@
 		compatible = "mediatek,ipm-spi";
 		reg = <0x1100b000 0x100>;
 		interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&infracfg_ao CK_INFRA_SPI1_CK>,
+			 <&topckgen CK_TOP_SPIM_MST_SEL>;
+		assigned-clocks = <&topckgen CK_TOP_SPIM_MST_SEL>,
+				  <&infracfg CK_INFRA_SPI1_SEL>;
+		assigned-clock-parents = <&topckgen CK_TOP_CB_M_D2>,
+					 <&topckgen CK_INFRA_ISPI1>;
+		clock-names = "sel-clk", "spi-clk";
 		status = "disabled";
 	};
 
-- 
2.45.2


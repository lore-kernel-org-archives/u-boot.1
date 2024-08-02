Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB15CC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:52:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBF6288C4C;
	Fri,  2 Aug 2024 21:52:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eD47b4ui";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 691EB88C40; Fri,  2 Aug 2024 21:52:02 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3786F88C2A
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-368f92df172so4263879f8f.2
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722628320; x=1723233120; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bXrki54RVcmmjktEkchfr8DNQEZvOA5hURHgspdveNc=;
 b=eD47b4uiw/HJzW5LTv1xRHr/9X7G/S9Q7jquXvGu+0E/1aC20DKWSBf6uXCv2dIcpr
 ASmw0C1N7/Q7gkqTLH0dKHK4UxN3DoYG0/ZFvVZKwSzBjS9Ex0ZkLh8Hq1Mfnnl2cJ7D
 /zve6D0AGIhY8zfA1yjWJUOliUPa2JM78qD32eGSVX4p5fVWe4kRcU6JWKplS3cM9c5O
 l6nfOb7hqoxEsrwY2EIMtN36pYbsfFtavUjXejS94+Ydvw6IicYYMsnenPLlHBwjUkV5
 BlvWFivoydmYvJ0RUQemwZK2Rxn9BeQHq0K4+yReo1gPgfoU+vpnDA3JVsOnYBVolHqr
 zZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722628320; x=1723233120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bXrki54RVcmmjktEkchfr8DNQEZvOA5hURHgspdveNc=;
 b=c6n/XdsEYMLiKOBQLXbPdW1ggdI1JSFPXXFvP2gtmdsbuICyylU/CyNgk2+OylFsiq
 71Y0FYqC5izH+I+sC4TgIUB0UnUsAcjaeGxfu7dJ9LN1lCE75Q7KUL/gfiD3ZWR1N67u
 FR8Bt3ru4xaRCmZ/l1zdtwasdYQ83ROtPwgkIItur0pHkcvK8bOG8Wrqs6Ztch4Y77x3
 DwRsiDNT3f/C81kf+3Nr4BmwXloLaZcfrCmAmCoeckhm0ZOIGB+OM2qzmM2sd5m8CBJ7
 TgyDMHTy2D2dbxADeZWGQVi1fYJRldwQ7F73wf3RHtA4YR/QuUrOAB+RaqV4Ima+A2pd
 p5+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxFutfKaXSzKVkz1ePxMfLrHuwzwCEVner14EdMCAO6sT1hDwA5/l2m8wPAgbXr4RkBdcAYr8S62DYkIfaJbTJ0EoDhw==
X-Gm-Message-State: AOJu0Yw4aLvd7AZEqQAcU+8l/QN5Q2kmzznic+risMzfssjLhZenE88s
 AagOJiHTM/Pvoc+1v+1gluwT2+kdcYEBuGympmHLhpllGoTlyzAn
X-Google-Smtp-Source: AGHT+IE3mX59zBZyTTeScfmNZjajG0K+kK9rZAXoH9gMIeXj5tN3BbjFDQYXO2g++oV8pQGvd1bDpw==
X-Received: by 2002:a05:6000:c0c:b0:368:420e:b7a4 with SMTP id
 ffacd0b85a97d-36bbc0a750bmr3016055f8f.4.1722628319607; 
 Fri, 02 Aug 2024 12:51:59 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36bbd06d03fsm2643344f8f.91.2024.08.02.12.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:51:59 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 3/8] clk: mediatek: mt7622: move INFRA_TRNG to the bottom
Date: Fri,  2 Aug 2024 15:48:27 +0200
Message-ID: <20240802134835.24006-4-ansuelsmth@gmail.com>
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

Move INFRA_TRNG clock to the bottom of the clk ID to match upstream
linux order. This is in preparation of OF_UPSTREAM.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7622.c      |  2 +-
 include/dt-bindings/clock/mt7622-clk.h | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 4a7c5faff1a..8f173b79453 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -382,11 +382,11 @@ static const struct mtk_gate_regs infra_cg_regs = {
 
 static const struct mtk_gate infra_cgs[] = {
 	GATE_INFRA(CLK_INFRA_DBGCLK_PD, CLK_TOP_AXI_SEL, 0),
-	GATE_INFRA(CLK_INFRA_TRNG, CLK_TOP_AXI_SEL, 2),
 	GATE_INFRA(CLK_INFRA_AUDIO_PD, CLK_TOP_AUD_INTBUS_SEL, 5),
 	GATE_INFRA(CLK_INFRA_IRRX_PD, CLK_TOP_IRRX_SEL, 16),
 	GATE_INFRA(CLK_INFRA_APXGPT_PD, CLK_TOP_F10M_REF_SEL, 18),
 	GATE_INFRA(CLK_INFRA_PMIC_PD, CLK_TOP_PMICSPI_SEL, 22),
+	GATE_INFRA(CLK_INFRA_TRNG, CLK_TOP_AXI_SEL, 2),
 };
 
 /* pericfg */
diff --git a/include/dt-bindings/clock/mt7622-clk.h b/include/dt-bindings/clock/mt7622-clk.h
index 78804f40307..2f36abcf8ae 100644
--- a/include/dt-bindings/clock/mt7622-clk.h
+++ b/include/dt-bindings/clock/mt7622-clk.h
@@ -121,11 +121,11 @@
 /* INFRACFG */
 
 #define CLK_INFRA_DBGCLK_PD		0
-#define CLK_INFRA_TRNG			1
-#define CLK_INFRA_AUDIO_PD		2
-#define CLK_INFRA_IRRX_PD		3
-#define CLK_INFRA_APXGPT_PD		4
-#define CLK_INFRA_PMIC_PD		5
+#define CLK_INFRA_AUDIO_PD		1
+#define CLK_INFRA_IRRX_PD		2
+#define CLK_INFRA_APXGPT_PD		3
+#define CLK_INFRA_PMIC_PD		4
+#define CLK_INFRA_TRNG			5
 
 /* PERICFG */
 
-- 
2.45.2


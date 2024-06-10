Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF92C27C53
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 00:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66D28883E7;
	Mon, 10 Jun 2024 02:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l0GH6X9g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7F6788241; Mon, 10 Jun 2024 02:35:06 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4FA3883E7
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 02:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7041053c0fdso1557332b3a.3
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 17:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717979702; x=1718584502; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XyYlkMOzICxM/ei4CJY00ZtwSfcWijK6zdJztRDqq5I=;
 b=l0GH6X9gn2b2ZhnX9MIe2FqmWVUTC0Z6EmahNDwMhkGdmIXQVlByZDGR9dXgQxp94i
 aDbsVeGh5eI5pIur10O66QCwG+Jts0Y9IgNh0/3yj7PIu1OiZZ+tj7h/OOYSO3yfdAK0
 mlv+jnvShBomexangjxmZOZ/lbomhPhnZe+oUKkHtVTkxDJ/yCqbAnvo0IQWYlxv+xQU
 YEAJWCx5js/uTLGeRGcRm8zyLWhTCWhHs4oibE1emWlNUhGfMxwFgsmAzjO0FZ/MIUDy
 QlYpFbcSStQkHNdaKL7uspxoKRjvWzeY4usaDi/ilc5IGHXnXJCGvsmnQy/D8eWMJyg/
 Wl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717979702; x=1718584502;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XyYlkMOzICxM/ei4CJY00ZtwSfcWijK6zdJztRDqq5I=;
 b=c6WqursDORsT2JggNTuI/wLcCyKCprESLfzKGW+1Y2dxRHRjN/A4IlGttvH03zRojS
 VMvBuMSC2pWoypFrfbBK3jhRqwthFCunDIi2ksdTF+9K+BLK6pfuM06I38OYVPI/waI/
 xN7Jq4wtHe3mMPQOntgl3OEhT3lrcZmtzqkk+Ew4JbVcfqjJUf16sfadV1pJ460J2a2c
 l1UCal5icakEQmQz+ChhqbfHDWaJGfpFy/Hvosj634ejmA+YrPgBYfr1/749Ywky2qF0
 FPZh8uabRDucvv4JsJNTDWPUVP3wxEHkqpHoY2B7BmY/SHnv2O0VTevP59VVqRbzvoYG
 H+mw==
X-Gm-Message-State: AOJu0YzwW1Cu3eGlDtubGRtc/LZki8oZXE8KQHZVXZtzEqdX01+ZIokY
 ZUYU2i0/onsIEDuFOhH18KRKBwHXwk3gDs4C9L/AgbA3ym3mCPoIU+hGmg==
X-Google-Smtp-Source: AGHT+IHwVt9GMpunDEHV6ftN1r2EqrYAHxnYBs9Y7rndd58TMV96KQ1LLEVOLFg50wr57ZJgIF4+sw==
X-Received: by 2002:a05:6a00:14c2:b0:705:9748:7ba9 with SMTP id
 d2e1a72fcca58-70597487fcemr1377238b3a.0.1717979702046; 
 Sun, 09 Jun 2024 17:35:02 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7042ee09f0csm2163135b3a.137.2024.06.09.17.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 17:35:01 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>,
	Stefan Roese <sr@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH] arm: dts: mvebu: Update DTS for Thecus N2350 board
Date: Sun,  9 Jun 2024 17:34:31 -0700
Message-Id: <20240610003431.14148-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.2
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

- Change the spi-max-frequency to 50000000 (50 Mhz). According to the
data sheet[1], the MX25L3205D max frequency is 86 Mhz. Using 50 Mhz in
the DTS to ensure u-boot is consistent with what Linux kernel expected.
- Update GPIO fan to conform to the latest DT binding.

[1] MX25L3205D-MX25L1605D-MX25L6405D-Macronix-MX25L3205DM2I-12G-datasheet.pdf

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 arch/arm/dts/armada-385-thecus-n2350.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/dts/armada-385-thecus-n2350.dts b/arch/arm/dts/armada-385-thecus-n2350.dts
index 253cf01130..fdaa444e51 100644
--- a/arch/arm/dts/armada-385-thecus-n2350.dts
+++ b/arch/arm/dts/armada-385-thecus-n2350.dts
@@ -2,7 +2,7 @@
 /*
  * Device Tree file for Thecus N2350 board
  *
- * Copyright (C) 2018-2023 Tony Dinh <mibodhi@gmail.com>
+ * Copyright (C) 2018-2024 Tony Dinh <mibodhi@gmail.com>
  * Copyright (C) 2018 Manuel Jung <manuel.jung@hotmail.com>
  */
 
@@ -143,9 +143,9 @@
 	fan {
 		compatible = "gpio-fan";
 		gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
-		gpio-fan,speed-map = <	  0  0
-					600  1
-					3000 2 >;
+		gpio-fan,speed-map = <	  0  0>,
+					<600  1>,
+					<3000 2 >;
 		pinctrl-0 = <&pmx_fan>;
 		pinctrl-names = "default";
 	};
@@ -415,7 +415,7 @@
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 
-		spi-max-frequency = <108000000>;
+		spi-max-frequency = <50000000>;
 		spi-cpha;
 
 		partition@0 {
-- 
2.39.2


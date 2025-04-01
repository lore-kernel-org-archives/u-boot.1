Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E3FC36008
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 07:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0662981E6C;
	Tue,  1 Apr 2025 09:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RW0EH8Aj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9542881F0D; Tue,  1 Apr 2025 09:01:36 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A529081DE3
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 09:01:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso57244965e9.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 00:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1743490892; x=1744095692;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aKT0Cu/By76Hhujbb5ado8LtBC72J3w7y5Yed87n07U=;
 b=RW0EH8AjO1d4zFRYA4gGPiJrvPz3Z7jD163pqqESI7SwjZSD8R45wegc7tDB8db+9L
 NgomDVw2MfzakjP1EGgy8OkExhw/UOdKzTDR0iJgZcCSRnH9QnAXJBaFzIJ6BgZ4qgpd
 5ujTV1ZRGb6ZTIyNKyuQ/MQim53i3+Q4m091E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743490892; x=1744095692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aKT0Cu/By76Hhujbb5ado8LtBC72J3w7y5Yed87n07U=;
 b=Pg54ade6lSdFmJj7NSy4KsJduY8icZ5J5N5uVfhP70qwC3DBmIL2M4WLGXG0N8AhMD
 szR7P38g+7Qwy130bbikwUUQ4VLr4KpJsYjJZPZ1ID/bDRmn3WEwzOKtcOwB650c3gI5
 aqzbSX/LnMKU9LRNHc39rTn1/zO5utz+wN4Me7LoLYAP2xDBn60jUdSLY/I5uL5SlA88
 fjBhWcohwJigcjq8+EjhxjXH1xDiNmgUKJqGcCRhTa8YvFZhVMDoUrzuht66kFRtppFU
 Ddks+P+BvL1AmKFq7LLc0UHARMNJ2S7pf/3dxhXLiclwEr42W+w3wZAjmwP9qLsMj8E+
 gIsw==
X-Gm-Message-State: AOJu0YyFgRyCVgGVPC+iJic4IGzUQZapm5cpcdUhNsTvSy6IBCHXMmTA
 TM8KKUXyK/eGLPdNoQ9mKstFV4XThLArwTwYB+8BR6oTyXj0KYcyPaDys+hjFeWK+X/E9RenwIk
 0
X-Gm-Gg: ASbGncs3b/G6gyKIXqASLhpeKxO7yOxr003J86Ii+Ee1RO4AwbQ5o0TCGilZcDKKK+w
 /HS2cXkqvNZhxWqpbKXK8N82ZlVZUyGLy4Mec+m4wdDOcU81wkjGU6V5a9ipFiPoeaEPPNpaf9G
 Ct8IsZHzFwq932+ZLObpxuhz96mVEMx7x/7G0lVDgiCsV153ZS/vyoUynWFyFvEHqOZds+OtD9b
 j90CnHzp/+p9O/bEg5le+RvZV+EheZSlgp0+UZVcviQSIgbGtjQFfj+gBDlYDbiC8/4/4uwmvDQ
 d56s74qgOAnKK4DP0BJRA9lmoZ5kd9OLcfpWWRLAlpjlhORhNlwoLmvU+RGWcbk5DPZ03fHgmh+
 5HHRUoNAoqw==
X-Google-Smtp-Source: AGHT+IFdnn8EQSDn46OyHfX9Qy22z2Hd5nmFYeddCRXTwn1pwVyy62D0yBEh1wYjy7TP2xYW1M8fuQ==
X-Received: by 2002:a5d:64ee:0:b0:391:2fe4:de0a with SMTP id
 ffacd0b85a97d-39c120ccabfmr10167645f8f.2.1743490891794; 
 Tue, 01 Apr 2025 00:01:31 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.40.230])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66b015sm13701760f8f.54.2025.04.01.00.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 00:01:31 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 2/6] ARM: dts: stm32: rename mmc_vcard to vcc-3v3 on
 stm32f769-disco
Date: Tue,  1 Apr 2025 09:00:53 +0200
Message-ID: <20250401070125.3705126-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401070125.3705126-1-dario.binacchi@amarulasolutions.com>
References: <20250401070125.3705126-1-dario.binacchi@amarulasolutions.com>
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

[backport from Linux commit f1317928fa03203929665af61e6d9ac0e29ea84d]

In the schematics of document UM2033, the power supply for the micro SD
card is the same 3v3 voltage that is used to power other devices on the
board. By generalizing the name of the voltage regulator, it can be
referenced by other nodes in the device tree without creating
misunderstandings.

This patch is preparatory for future developments.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

Changes in v2:
- Add Reviewed-by tag of Patrice Chotard

 arch/arm/dts/stm32f769-disco.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/stm32f769-disco.dts b/arch/arm/dts/stm32f769-disco.dts
index ad1b442055e1..b4e240a8e3eb 100644
--- a/arch/arm/dts/stm32f769-disco.dts
+++ b/arch/arm/dts/stm32f769-disco.dts
@@ -56,9 +56,9 @@
 		clock-names = "main_clk";
 	};
 
-	mmc_vcard: mmc_vcard {
+	vcc_3v3: vcc-3v3 {
 		compatible = "regulator-fixed";
-		regulator-name = "mmc_vcard";
+		regulator-name = "vcc_3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
@@ -96,7 +96,7 @@
 
 &sdio2 {
 	status = "okay";
-	vmmc-supply = <&mmc_vcard>;
+	vmmc-supply = <&vcc_3v3>;
 	cd-gpios = <&gpioi 15 GPIO_ACTIVE_LOW>;
 	broken-cd;
 	pinctrl-names = "default", "opendrain";
-- 
2.43.0


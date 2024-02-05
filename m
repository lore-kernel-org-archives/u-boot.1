Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C359C48292
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 18:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4541187B98;
	Mon,  5 Feb 2024 19:59:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f8JuIZhc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF09287B98; Mon,  5 Feb 2024 19:59:04 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A410879AF
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 19:59:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3bfcbfbfd92so10117b6e.2
 for <u-boot@lists.denx.de>; Mon, 05 Feb 2024 10:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707159540; x=1707764340; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1motExGwroWKH3vgZfR/Cw1ttlp4dkKkXyriFyrpX0A=;
 b=f8JuIZhcvHP4bZ/bmA+rGkU25DoeVXQXc1U9CLQJzi6O4z7EnSbr2Wryi2GIqKrlyZ
 EAY+JboRGxrPlDldPGgINM+MaJ8E+XJp30YMOMkSyi5Al3BEqtR9jKNyI4pfPJN473QC
 uFbIht7qQPNbx4LHYlmfqrYIGSMi6gviOK1phUf16LrsmE4X3zKVno/X0Eh550pSmPum
 ElKMzYA3Qto/C8nlRnazTTfdks/7254P54paHqcHu3N57eHx8rQ2vYF9jZtW8fkWxrNJ
 WzXAOri+KTLhoABQoScYx07eyEttt58DMt4JJUE/FSo0lXXPZAtupjbqQvWZDuBonUeB
 1bBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707159540; x=1707764340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1motExGwroWKH3vgZfR/Cw1ttlp4dkKkXyriFyrpX0A=;
 b=sQ5DeLDjDD1Vq8nwfAxuG7jTwg71XzddAh0RfahIfQiCFU2axE1lqynuOZ8kbVlWpt
 a141Jkh4AWptwbW9NyCv0HbeoRGajgfae6+ReHO5nAAwnMwbRDyz9TuzdNBWj8niFTRK
 w6JBi7YhUnk5T4y8d2BnemyZgBzDnSKLEHNgWPw3jGuqlVoBmV9eqb16SRmjqJmM3lcP
 TOENrGjx8T9ABwL0d8s+85qPjsDifqGQgovBYqgPoJmbyPETh8QxOz16d8bJpvoxCexY
 UU0mF8hRJOOUVhuwKoxMprQUr6+UNIfUlGoFmXuz8g7EP8LLDQ257p9vfJqe/G510BE6
 yWaw==
X-Gm-Message-State: AOJu0YzVNOZtG7x0sYrwa/Mt4c4x4yjkAb94Hf3agw+EpqfOd+SPS+gM
 f3noU9mMNgSuWVvJoudAav+CBc+de4u7+qM7kTl8oTu/YMoUM993VK9DEy8T
X-Google-Smtp-Source: AGHT+IH49LqAWjjW08Pdmo6KGl82fFI3RLNuxVDuhnHrQ/SCZEUakivd54eUYRCiUSYQT5QtD6tsbw==
X-Received: by 2002:a05:6808:10c9:b0:3be:4522:43c9 with SMTP id
 s9-20020a05680810c900b003be452243c9mr567433ois.10.1707159540433; 
 Mon, 05 Feb 2024 10:59:00 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXUnUadryC27KMaSXNkl8fDtABqBkqLqd7ioYvq+k6c+J6McyVvvc33KA3ZhrfTscGzhxHQaD2JkPJjN0060bPJRfNO17KS9rqNtLt4t9qPrnlTBNuJzZyyOSmi2jlqX7KD85AwSE81gKrBJMyZk6sjVDbO7CrNgMh9Ev1/AoK+GV44QSoWhBZt2FDz3rIX+FqjpnqufzEbp+c7o5bdCtVh
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 cn22-20020a056808351600b003bfdfc7e5d6sm65692oib.42.2024.02.05.10.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 10:59:00 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 jonas@kwiboo.se, jagan@amarulasolutions.com,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 1/4] arm: dts: rockchip: rk3566: Remove unnecessary clks from
 rgxx3
Date: Mon,  5 Feb 2024 12:58:52 -0600
Message-Id: <20240205185855.21508-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205185855.21508-1-macroalpha82@gmail.com>
References: <20240205185855.21508-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Remove unnecessary clock frequency defines from the RGxx3 u-boot dts.
Move the necessary defines to the RGxx3 main dts file.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi | 31 -------------------
 arch/arm/dts/rk3566-anbernic-rgxx3.dts        |  7 +++++
 2 files changed, 7 insertions(+), 31 deletions(-)

diff --git a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
index f986e1941e..ef4f81500b 100644
--- a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
+++ b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
@@ -15,37 +15,6 @@
 	};
 };
 
-&cru {
-	assigned-clocks =
-			<&pmucru CLK_RTC_32K>,
-			<&pmucru PLL_PPLL>,
-			<&pmucru PCLK_PMU>, <&cru PLL_CPLL>,
-			<&cru PLL_GPLL>,
-			<&cru ACLK_BUS>, <&cru PCLK_BUS>,
-			<&cru ACLK_TOP_HIGH>, <&cru ACLK_TOP_LOW>,
-			<&cru HCLK_TOP>, <&cru PCLK_TOP>,
-			<&cru ACLK_PERIMID>, <&cru HCLK_PERIMID>,
-			<&cru CPLL_500M>, <&cru CPLL_333M>,
-			<&cru CPLL_250M>, <&cru CPLL_125M>,
-			<&cru CPLL_100M>, <&cru CPLL_62P5M>,
-			<&cru CPLL_50M>, <&cru CPLL_25M>;
-		assigned-clock-rates =
-			<32768>,
-			<200000000>,
-			<100000000>, <1000000000>,
-			<1188000000>,
-			<150000000>, <100000000>,
-			<500000000>, <400000000>,
-			<150000000>, <100000000>,
-			<300000000>, <150000000>,
-			<500000000>, <333333333>,
-			<250000000>, <125000000>,
-			<100000000>, <62500000>,
-			<50000000>, <25000000>;
-		assigned-clock-parents =
-			<&pmucru CLK_RTC32K_FRAC>;
-};
-
 &dsi_dphy0 {
 	status = "okay";
 };
diff --git a/arch/arm/dts/rk3566-anbernic-rgxx3.dts b/arch/arm/dts/rk3566-anbernic-rgxx3.dts
index 404dddfafb..9e0aa9e63b 100644
--- a/arch/arm/dts/rk3566-anbernic-rgxx3.dts
+++ b/arch/arm/dts/rk3566-anbernic-rgxx3.dts
@@ -16,3 +16,10 @@
 		     "anbernic,rg353v", "anbernic,rg353vs",
 		     "anbernic,rg503", "rockchip,rk3566";
 };
+
+&cru {
+	assigned-clocks = <&pmucru CLK_RTC_32K>, <&cru PLL_GPLL>,
+			  <&pmucru PLL_PPLL>, <&cru PLL_VPLL>;
+	assigned-clock-rates = <32768>, <1200000000>,
+			       <200000000>, <241500000>;
+};
-- 
2.34.1


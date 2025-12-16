Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1714D5C0C4
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 02:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85456836AC;
	Tue, 16 Dec 2025 03:48:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hWoAr0q5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FFDB83710; Tue, 16 Dec 2025 03:48:23 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CB2D8036B
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 03:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7f121c00dedso5047454b3a.0
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 18:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765853300; x=1766458100; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b8s4PT8qbwXEX3PcoczDcuaPaShow5bVhkHCg3Kg6vI=;
 b=hWoAr0q5EAQdBoDAS7ktWChelb9Ev07uxTwzmE2A/Ee0n+U65ZKsonrR274MrADjvP
 S/LI/qlA3nfPs1r2kVz47n15c7xJGgD3QtVek1uhgi8pUMg7kDtqYEnrwSMMCxgisNTW
 zY3rFZr3oMxRn/b1o9YIqPto7tSsZ2k+6wZYudmyBg4we5ZwxzdOEUJHFeN43FRsh9V+
 KWAk4ov4+tW21BJFYDgjpiNaZdL0+eWvyTzGHCjBFZwpgmO6avY/CPPmoa4AuE9NRd2l
 4o3FsSwBN0yK3QCWQP9Kh/x6TA/S2gABkBM/uNwkF2NMngNVh0tbwTZZHDaTQOaFaWBm
 zFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765853300; x=1766458100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b8s4PT8qbwXEX3PcoczDcuaPaShow5bVhkHCg3Kg6vI=;
 b=Hmzccgobw9cFpwYkN6kOlSgmU35TkjBuCBPAwXVNpzDOEaA5+xdXZ4mxgNtR13scyg
 SYogxijYhlf5wDCGxVVUCWMBQLni+Kjq7JDj0TbCooElBJbuxbxSq6OVmS7Tq3V90fEx
 NVM1Vq/47LKpoV9dMcoq8qJJaJH9SPHi7ZLEbjmNQ+7CvC2W7tgdCSFA0hewwVU5HHc1
 GwuWLZI7Q6ry+LYmgbTK4YCiXouyBnOQlUFzu1uVUk9nHpPcuDndybvseXudPFyKCinm
 ZwCR50ZyD3lePTqQQJVeel70uUTEyfBplJA1MeILZIM2+uk9yJMz990BnlvyH5c/O1ea
 4CnA==
X-Gm-Message-State: AOJu0YxNrDi/mYYzF2QOstT8d6HRyb/gikpbIEG7eyOlLQ7/tZo0deO+
 lznQDM1/lc3NFnJxmru+XzOsez7fcUm14P/4/D00TvX5cD+eb13RIsjn
X-Gm-Gg: AY/fxX4bLEfJUA/+KDFmi6uWgNl7Y2NKkCUBRCaNgu3PlP4ZWcfJXoVWCkBc0Scv+mP
 GQrZjLGNGlqhp2dA/FoF2FtLMIn/xn+mkuyKGgNflwyfAfZchMlyxg+12AZaguU1eWjS77uq8DZ
 1ivdjVhtdXjypanYKy1F7YhKP7jzeU8dO5YYSOYybXSPx2eYY1SfOBdaKZR3RNnKq8nAhupagtC
 CJyhfxfF+l585oPltYhiPrW6oEpnBGhmELFmN6s6z45/lqKl05J64c0MaDTV0bzPZHIaKthhKPZ
 dloR+N/zAm+G5uU4nuR7AeHh1teLPbjFdEWSFI2mknrgfNuayap3zA6iYGKTb/m22dRslR/z7/b
 0keMy4r16mNKLUGkQjh7DxhpK11xrxRyTvjnGrqfmLP81vhITav5jc/Iu4Ofc6AI4r39rqLuTHe
 CPYv13xgFLkDO6xxKWWkBndw==
X-Google-Smtp-Source: AGHT+IEpnTbtEsshBTUDVB543NMHE7kgRX/PLK9zugBJwTRM/RRlJjIJM00B0D4V83jN12alqJ3qjg==
X-Received: by 2002:a05:6a20:158b:b0:33c:2154:d4f4 with SMTP id
 adf61e73a8af0-369af813c0bmr13568176637.49.1765853299734; 
 Mon, 15 Dec 2025 18:48:19 -0800 (PST)
Received: from cs20-buildserver.. ([2402:7500:502:d4da:9fd1:87b1:de1a:188c])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c0c26eb1d05sm13401606a12.13.2025.12.15.18.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 18:48:19 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	jim.t90615@gmail.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 6/6] arm: dts: Add SGPIO node in dts
Date: Tue, 16 Dec 2025 10:47:29 +0800
Message-Id: <20251216024729.1031306-7-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251216024729.1031306-1-JJLIU0@nuvoton.com>
References: <20251216024729.1031306-1-JJLIU0@nuvoton.com>
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

Add SGPIO node in dts

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi | 30 ++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi b/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi
index cb57e1bcfd8..9b5f1906802 100644
--- a/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi
+++ b/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi
@@ -395,6 +395,36 @@
 				gpio-bank-name = "gpio7";
 			};
 
+			gpio8: sgpio1@101000 {
+				compatible = "nuvoton,npcm845-sgpio";
+				reg = <0x101000 0x200>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&iox1_pins>;
+				syscon-rst = <&rstc>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				gpio-bank-name = "gpio8";
+				nuvoton,input-ngpios = <0>;
+				nuvoton,output-ngpios = <0>;
+			};
+
+			gpio9: sgpio2@102000 {
+				compatible = "nuvoton,npcm845-sgpio";
+				reg = <0x102000 0x200>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&iox2_pins>;
+				syscon-rst = <&rstc>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				gpio-bank-name = "gpio9";
+				nuvoton,input-ngpios = <8>;
+				nuvoton,output-ngpios = <8>;
+			};
+
 			rng: rng@b000 {
 				compatible = "nuvoton,npcm845-rng";
 				reg = <0xb000 0x8>;
-- 
2.34.1


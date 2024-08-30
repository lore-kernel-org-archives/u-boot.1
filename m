Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0DCCA1008
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 15:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5754C88C47;
	Fri, 30 Aug 2024 17:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GCEw1i6D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0E4288CEA; Fri, 30 Aug 2024 17:57:46 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97B5188C90
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 17:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5d5e97b8a22so1111784eaf.2
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 08:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725033463; x=1725638263; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NrgfAHom+R5ffS5XA8s7S+oDhg2omeL54jrvieS25sU=;
 b=GCEw1i6DDlWjisipvb3aEyILZf+FRqD2vuvZ0A/O4flPtpRP3F+g2PwJgcVH9wat1M
 Aj5XdC2mM/Nz0MtngcRwEy6u39TdwbZwcBe/El6fO3GIDtT2ezlLkeFAyeaGxGj6TeoI
 arWP2+40TINYK9IHvu7Cbs6kWKOSDs9IFw7TiCOzAl69h+KfXBi5CB7NCfTjGuskXLzF
 3YaLZe/mfRgx2zqvyTANrS7rPg612Zxlaw7RFJuQsTFTij28VdxaOa/QMy4OZSkYzrJ8
 decn45QqhchSTpaVVx7td9ZGMMdjNxT9ax7E4AODEzMDGYuFk0CN2j9SjhoMS41+LlXt
 dFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725033463; x=1725638263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NrgfAHom+R5ffS5XA8s7S+oDhg2omeL54jrvieS25sU=;
 b=pOh5x8lRPjIOnMgvvw7SvN+Lk/8GinkhlnvBiiNx2SVo5Nk2Pa0fqO2FJ+G1ix8WH8
 I4lP1km7aOUC2S+fUlIQLr4RO3MI7/JH3dea9eiD61/977X42MVREXnamsVxr581HWof
 mGSB5dfKjtJyEWYsGCRpKem00oHBdbIEs/r4sJA3ra3mjzB37sRgzLy8jd0Ikdne+R++
 lLXhHFEDl9TMeq5vLz261V6XjhvF5dKyO7n7Zt8K/EQ36fhr2RLJ/6uzORjWc2qCQu54
 Gj54EIatIBJgr65vajtsby5QY+5mC5Cy/3TlgcrvgQFCfiUwymF22pGch7wfDDEKAHPX
 vASQ==
X-Gm-Message-State: AOJu0YwrIZoa0djKW+buDa6JSYR/couyMuLV9z5fARX1p1nshQrkHxNP
 MsVIjl3mzO+EdN92eVxAneee3mHFR3RSzafoqwRURxXn7NY5Vp/eS4NlQQ==
X-Google-Smtp-Source: AGHT+IHi5S1RuAU74YwXHmR3DVobnlIrej+boFSl/OpLYDG/OSpdaU7VTCuoN4dFtkesIqLW6lcYWA==
X-Received: by 2002:a05:6870:2055:b0:267:df02:f7c0 with SMTP id
 586e51a60fabf-277902c5471mr6322765fac.33.1725033463213; 
 Fri, 30 Aug 2024 08:57:43 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70f671a8630sm490092a34.51.2024.08.30.08.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 08:57:42 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com, iuncuim@gmail.com,
 sumit.garg@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 7/9] arm64: dts: allwinner: h616: Add r_i2c pinctrl nodes
Date: Fri, 30 Aug 2024 10:55:12 -0500
Message-Id: <20240830155514.481410-8-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Add pinctrl nodes for the r_i2c node. Without the pinmux defined the
r_i2c bus may fail to work, possibly if the bootloader uses rsb mode
for the PMIC.

Link: https://lore.kernel.org/linux-sunxi/172252952262.1669767.7675865282122079154.b4-ty@csie.org/

[ upstream commit: 7c9ea4ab76176f65f4f55aa144f9145a4bccaacb ]

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/dts/sun50i-h616.dtsi                     | 2 ++
 dts/upstream/src/arm64/allwinner/sun50i-h616.dtsi | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/dts/sun50i-h616.dtsi b/arch/arm/dts/sun50i-h616.dtsi
index 921d5f61d8..41f2c23e07 100644
--- a/arch/arm/dts/sun50i-h616.dtsi
+++ b/arch/arm/dts/sun50i-h616.dtsi
@@ -836,6 +836,8 @@
 			clocks = <&r_ccu CLK_R_APB2_I2C>;
 			dmas = <&dma 48>, <&dma 48>;
 			dma-names = "rx", "tx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_i2c_pins>;
 			resets = <&r_ccu RST_R_APB2_I2C>;
 			status = "disabled";
 			#address-cells = <1>;
diff --git a/dts/upstream/src/arm64/allwinner/sun50i-h616.dtsi b/dts/upstream/src/arm64/allwinner/sun50i-h616.dtsi
index 921d5f61d8..41f2c23e07 100644
--- a/dts/upstream/src/arm64/allwinner/sun50i-h616.dtsi
+++ b/dts/upstream/src/arm64/allwinner/sun50i-h616.dtsi
@@ -836,6 +836,8 @@
 			clocks = <&r_ccu CLK_R_APB2_I2C>;
 			dmas = <&dma 48>, <&dma 48>;
 			dma-names = "rx", "tx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_i2c_pins>;
 			resets = <&r_ccu RST_R_APB2_I2C>;
 			status = "disabled";
 			#address-cells = <1>;
-- 
2.34.1


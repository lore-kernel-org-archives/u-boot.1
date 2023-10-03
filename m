Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D03E776FC
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 03:58:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FA14871A2;
	Tue,  3 Oct 2023 05:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C1mwGlx8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3A1C87196; Tue,  3 Oct 2023 05:58:16 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BEE486DD9
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 05:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-564af0ac494so273423a12.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 20:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696305492; x=1696910292; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SQ8ypgUFZybTlNrrx2mMHZ5s7ZjZ4s7stSolC3AZ7MM=;
 b=C1mwGlx8Ss3GtrVlvSN035i5UM7gAxaS6MTfNvwuPM0BNAOG0xeK42xT09RY1BMbcM
 6gVFWMrFAj7+bZVwIBeuYpssd9LU2MiQY7o3hoaEMv3UOSRFI3kuyf+wbU1nvtY+1elQ
 UbTulM3Lz1k3l1OepxIhSUI76BuPe+c/wIjYx1owfGCXn4SWiS4q/Op0nMSPqRS10CZl
 6IUlSc294JocWjSZnYBARKdAZ9opOp60zht0D14iTWKhDmEXNUnfuIO4jW67ZvMBWr3f
 k1VHbbsqfiGk5x8xLaXf9qrwdr4f6jqWvhDn7OvRN2wXoIBrNvDDOIpYbnyfGA6q03+o
 TZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696305492; x=1696910292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SQ8ypgUFZybTlNrrx2mMHZ5s7ZjZ4s7stSolC3AZ7MM=;
 b=eXaun9hs9WV9MXLo/+O5NpoxYkVYZd74+ccTFwzklqzz51leNLVj4xnXIZARCT1gN3
 uGb/QG1L3NPH3vVnJKQEmqae2kLGVq9W7jQXqm65d3Aeq/+mk5VlzcBN/bJBQqStn63S
 pjBmkIaFcC4Icj5+wr6rsBHPMf/AsgrBj+XGRJERkBhgpgvA4hM0kr3szY2D7MBvA0Jj
 p+r7U5pObEnx0ExlHP3DPqlAeXltPWVLNh2wqn/Z4B4LrC5rnxPxW2gdmVJTOVB/3zJw
 Pr1U5+yJqik/2nhxwUd7DHelpIGQ1HsBUlp7+eJSHDtbx7bJJNmeL1wJDTt7IZ0pba9A
 T5jw==
X-Gm-Message-State: AOJu0YyWuXOQOAlJpy6EuHjrilMA81T9wmR4cVstnjjXzYc+a/JwzJMP
 0IxNGcn5a15aheG3sSbAvFUk8yDM/eJUmA==
X-Google-Smtp-Source: AGHT+IGYrnoYcndi+UmCbO0undI0xSTsbmpPF00PVTWH7XFISjbbG5MdelL2VY6nqqZ8bdxWEUKPYA==
X-Received: by 2002:a05:6a21:7785:b0:153:919e:18ce with SMTP id
 bd5-20020a056a21778500b00153919e18cemr12838631pzc.48.1696305492317; 
 Mon, 02 Oct 2023 20:58:12 -0700 (PDT)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:f6be:e369:f897:f543])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a17090341c200b001b86492d724sm270112ple.223.2023.10.02.20.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 20:58:11 -0700 (PDT)
From: Chris Packham <judge.packham@gmail.com>
To: u-boot@lists.denx.de
Cc: Chris Packham <judge.packham@gmail.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Stefan Roese <sr@denx.de>
Subject: [PATCH 2/2] Revert "arm: mvebu: x240: Use i2c-gpio instead of built
 in controller"
Date: Tue,  3 Oct 2023 16:57:39 +1300
Message-ID: <20231003035800.2626121-2-judge.packham@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003035800.2626121-1-judge.packham@gmail.com>
References: <20231003035800.2626121-1-judge.packham@gmail.com>
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

This reverts commit 5c1c6b7306f2b4c0fd50c7cb5d757e245b93606e. The reason
for switching to i2c-gpio was due to an issue we were seeing in the
Linux kernel where the CPU would lock up on certain adverse I2C bus
conditions. We were never able to reproduce the lockup in U-Boot but
assumed that was probably just luck.

Since then we have discovered that the lock up was due to the I2C
transaction offload engine in the I2C controller not coping with the
adverse bus conditions (basically it thinks there's another master and
waits for a STOP condition that never comes). U-Boot doesn't use the I2C
offload feature so is not susceptible to the lockup.

We can therefore safely return to using the built-in I2C controller.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

 arch/arm/dts/ac5-98dx35xx-atl-x240.dts | 30 ++++++--------------------
 configs/x240_defconfig                 |  1 -
 2 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/arch/arm/dts/ac5-98dx35xx-atl-x240.dts b/arch/arm/dts/ac5-98dx35xx-atl-x240.dts
index c19b25925ba2..820ec18b4355 100644
--- a/arch/arm/dts/ac5-98dx35xx-atl-x240.dts
+++ b/arch/arm/dts/ac5-98dx35xx-atl-x240.dts
@@ -16,7 +16,7 @@
 		gpio0 = &gpio0;
 		gpio1 = &gpio1;
 		spi0 = &spi0;
-		i2c0 = &i2cgpio;
+		i2c0 = &i2c0;
 		usb0 = &usb0;
 		pinctrl0 = &pinctrl0;
 	};
@@ -40,19 +40,6 @@
 			default-state = "on";
 		};
 	};
-
-	i2cgpio: i2c-gpio-0 {
-			compatible = "i2c-gpio";
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			pinctrl-names = "default";
-			pinctrl-0 =  <&i2c0_gpio>;
-			scl-gpios = <&gpio0 26 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-			sda-gpios = <&gpio0 27 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-			i2c-gpio,delay-us = <2>;
-			status = "okay";
-		 };
 };
 
 &nand {
@@ -83,7 +70,9 @@
 	status = "okay";
 };
 
-&i2cgpio {
+&i2c0 {
+	status = "okay";
+
 	mux@71 {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -188,8 +177,8 @@
 	 * LED_OE_N              [23]
 	 * USB_PWR_FLT_N         [24]
 	 * SFP_INT_N             [25]
-	 * I2C0_SCL              [26] (GPIO)
-	 * I2C0_SDA              [27] (GPIO)
+	 * I2C0_SCL              [26]
+	 * I2C0_SDA              [27]
 	 * USB_EN                [28]
 	 * MONITOR_INT_N         [29]
 	 * XM1_MDC               [30]
@@ -212,7 +201,7 @@
 	/*	     0    1    2    3    4    5    6    7    8    9 */
 	pin-func = < 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff
 		     0xff 0xff 1    1    1    1    0xff 0xff 0    0
-		     0    0    0    0    0    0    0xff 0xff 0    0
+		     0    0    0    0    0    0    1    1    0    0
 		     1    1    1    1    0    0    0    0    0    0
 		     0    0    0    1    1    1    >;
 
@@ -220,9 +209,4 @@
 		marvell,pins = <0 1 2 3 4 5 6 7 8 9 10 11 16 17>;
 		marvell,function = <2>;
 	};
-
-	i2c0_gpio: i2c0-gpio-pins {
-		marvell,pins = <26 27>;
-		marvell,function = <0>;
-	};
 };
diff --git a/configs/x240_defconfig b/configs/x240_defconfig
index 0d5a19df25aa..4b1a761a9086 100644
--- a/configs/x240_defconfig
+++ b/configs/x240_defconfig
@@ -42,7 +42,6 @@ CONFIG_CLK_MVEBU=y
 CONFIG_GPIO_HOG=y
 CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
-CONFIG_DM_I2C_GPIO=y
 CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PCA954x=y
-- 
2.42.0


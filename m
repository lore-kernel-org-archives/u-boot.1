Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7216F43697
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6510B84462;
	Fri, 17 Apr 2026 14:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B6brzL27";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DDD884222; Thu, 16 Apr 2026 17:20:22 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 032958420C
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 17:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-8dbbc6c16b2so114332185a.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 08:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776352819; x=1776957619; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ICE6Uu31Z3+Oim2GsebNaxOF5NTenlaIE0sod4H9L94=;
 b=B6brzL27gYfDEdk+HU43ge6Wi2WiQT0Dc+jhyW97/pwGhMsoO/y4JdznwhzDQBVG77
 VaS17R2NjCHK6o+WvnZVps4a600sFdAl+y/RiFVfwuy1wOdyh/Vlp0eOk3d0q0D7WZJK
 dn7FCWItYn7fK5qPve2NIIBjCuRzYU2OOvRsuKKzv9ZSY6ryF+lhcdPay6H38j9AlFpQ
 YysjU2KaVqo3d9ylOp15xD8DeazG8DSAj1jJ+74KssS12Eu2frdbBj80ej6Ib6jvqobB
 79JBHYWwXNzuHctdvLST/Xc2BM95e0FKGOqJBKp2iXWfSGFeRGEo37VyYZdD/+5m94Nc
 XX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776352819; x=1776957619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ICE6Uu31Z3+Oim2GsebNaxOF5NTenlaIE0sod4H9L94=;
 b=ZFGB1+QNxA42DmvWaiFGMnJD+tDaG2BJXLvU6FbR0kmWgGYXFDVw6tImEdzXON9AN2
 yYxOyKjPPWBNe/D8kPGU1HX9+2QNHpCfMvS+nWvkNi4rXH+chv2eOsiOHhHCoRETKhWq
 YwEIabRG1swxTG5QYSANw4DCe7qtTibHH+6IW6oWgM/AonZvM7Xg71NgoeHjVdRoQD21
 2cuh8GNxrAStrctLEIIWtWEQ9BwzYsrVVKkdJzlLuplRE1IS0NGUboYOr8tvMkarJCr+
 F4iiIIlxyOFlQqpflFX76XifXDHbfYRmGboijFg+JtIQOmtJD1DCMQHgMyDX3+HToAoX
 WBPQ==
X-Gm-Message-State: AOJu0Yx2u4eva2JRwHroCIRJrp07tzu6dgD8UlrkXQaoLIBAwQbeKqgZ
 wzpjv3+IgOEpQ8nDONO4sidG8yDY7+uCYpUARCTunnBKy/5lBU1AkmxfoLEZE8ve
X-Gm-Gg: AeBDievCrVzGR9kHg1hniAtEEwvYqrl9nO7SN04qOlMbc+Jj5n3YITzSTsoCRF2s5Dj
 mX05RN/kinBuvoiy+KwrN1dltkOp4eISYnog6CPD/Rhb5c5++l8CISlhWFSkLCTKjx4n1VeyD50
 N/LnN3aSSaiDirYO3yqP8hTpjE3dgeNmbsNt9NFAZg8UntwntWySM+95ZVeGlDZzTZ6DciX+ME0
 PRbTNhzHsbWN0vs2GaEiDpoZ/efrsK0DAln3I+EGinHLwmX8mCOGQnMkylyGVpQ8OLMW4MJDa9P
 rB2ajP1bnBt/XJhZiBrkVBNj1BsOxYUjVWGqjgvHNfEnedtsDqkpvC5dv/h69eFsuIGDgIRwjR5
 ikQt1VzL2dhNBllGBG27u8YQp17UmaFVV7Oy0jo3/80J/bidR06S77MnG4bGHEKlsIQ+qaH6ekm
 VxjG+a3FcEoTxhhiWlFZtBiOMuKXn+6jKQYa3AhSnhgmkK
X-Received: by 2002:a05:620a:1707:b0:8cd:9281:6be9 with SMTP id
 af79cd13be357-8e5de474d32mr569326385a.31.1776352818612; 
 Thu, 16 Apr 2026 08:20:18 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6c93b7e2sm38561586d6.8.2026.04.16.08.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 08:20:18 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [RESEND v4 06/14] mach-sc5xx: Remove preliminary binman support
Date: Thu, 16 Apr 2026 11:19:41 -0400
Message-Id: <78daf6fd00f9f73f8fa9d3d2f86a9482b585035a.1776344788.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1776344788.git.jcethrid@gmail.com>
References: <cover.1776344788.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:44:25 +0200
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

From: Caleb Ethridge <caleb.ethridge@analog.com>

Remove preliminary binman support from all sc5xx ADSP boards.
Full support was never added because it was unused.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 arch/arm/dts/sc5xx.dtsi     | 41 -------------------------------------
 arch/arm/mach-sc5xx/Kconfig | 33 -----------------------------
 2 files changed, 74 deletions(-)

diff --git a/arch/arm/dts/sc5xx.dtsi b/arch/arm/dts/sc5xx.dtsi
index 9d346ae62e0..072631e34f7 100644
--- a/arch/arm/dts/sc5xx.dtsi
+++ b/arch/arm/dts/sc5xx.dtsi
@@ -25,47 +25,6 @@
 		bootph-pre-ram;
 	};
 
-#ifdef CONFIG_SC5XX_USE_BINMAN
-	binman {
-		filename = CONFIG_SC5XX_BINMAN_FILENAME;
-		stage1-boot {
-			offset = <CONFIG_SC5XX_UBOOT_SPL_OFFSET>;
-			type = "blob-ext";
-			filename = "spl/u-boot-spl.ldr";
-		};
-
-		/* since falcon mode can jump from SPL to OS directly
-		 * full u-boot is optional
-		 *
-		 * @todo: review if we can say this given support has
-		 * not yet been upstreamed. Otherwise we might have to
-		 * invoke binman only for full u-boot.
-		 */
-		stage2-boot {
-			offset = <CONFIG_SC5XX_UBOOT_OFFSET>;
-			type = "blob-ext";
-			filename = "u-boot.ldr";
-			optional;
-		};
-
-#ifdef CONFIG_SC5XX_FITIMAGE_NAME
-		fitImage {
-			offset = <CONFIG_SC5XX_FITIMAGE_OFFSET>;
-			type = "blob-ext";
-			filename = CONFIG_SC5XX_FITIMAGE_NAME;
-		};
-#endif
-
-#ifdef CONFIG_SC5XX_ROOTFS_NAME
-		rfs {
-			offset = <CONFIG_SC5XX_ROOTFS_OFFSET>;
-			type = "blob-ext";
-			filename = CONFIG_SC5XX_ROOTFS_NAME;
-		};
-#endif
-	};
-#endif
-
 	clocks {
 		dummy: dummy {
 			compatible = "fixed-clock";
diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
index cfa7ed46a82..70fab57fb3c 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -146,39 +146,6 @@ config SC5XX_LOADADDR
 	help
 	  The default load address for u-boot.
 
-menu "Binman configuration"
-config SC5XX_USE_BINMAN
-	bool "Use binman for final image"
-	select BINMAN
-	help
-	  If you wish to use binman to assemble an image, say 'Y' here.
-	  This will enable binman-specific sections in the device tree.
-
-config SC5XX_BINMAN_FILENAME
-	string "Image name"
-	default "sc5xx-image.img"
-	depends on SC5XX_USE_BINMAN
-	help
-	  The name of the image that will be created by binman.
-	  This is used to create the final image.
-
-config SC5XX_FITIMAGE_NAME
-	string "FitImage name"
-	default "fitImage"
-	depends on SC5XX_USE_BINMAN
-	help
-	  The name of the fitImage to be packed by binman.
-	  This is used to create the final image.
-
-config SC5XX_ROOTFS_NAME
-	string "RootFS name"
-	default "rootfs"
-	depends on SC5XX_USE_BINMAN
-	help
-	  The name of the rootfs to be packed by binman.
-	  This is used to create the final image.
-endmenu
-
 config ADI_IMAGE
 	string "ADI fitImage type"
 	help
-- 
2.34.1


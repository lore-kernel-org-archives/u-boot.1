Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132C81098782
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 13:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 488A38405A;
	Fri, 20 Mar 2026 14:06:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Uj5LNY5n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE3EF83D71; Fri, 20 Mar 2026 13:52:49 +0100 (CET)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7FA983CEA
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:52:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-8cfc795ca97so69630585a.0
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 05:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774011166; x=1774615966; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q/KH2tpFhJzaixNSsS/FoNj19VlWMlwakz8LBcvpRJg=;
 b=Uj5LNY5nX+A8a+V7OJma1k/wqg4PjL83lVGWElhMrJwKjswUxlwZtJjEk2xCKb/EW4
 p5h/A1WAfJDrWFk45kG0nuj+aMVaDwy2I6GSQ492g8DJZR9J3qxsbyHQjCMdNYTwJl2t
 hl5C9GHAFrNTWgLmSJ57qwp0tGdNHWs2U5K0JS3KsrYMQ9butWgtTiwlSZ7vbpwhxJAP
 ZmaywNSwKwbGtlRIjPUutrTidNaEySmJxw4ccKN0AO1y/vbnqYzsTb89rGh1BB5GbDRq
 e/D4AoHbzpIcY9Dz8sVub3Z1k/dpY1cSBKc5m5GfBdcqAjHQ3dFLED4tt0cxqEpXWSSj
 uyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011166; x=1774615966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q/KH2tpFhJzaixNSsS/FoNj19VlWMlwakz8LBcvpRJg=;
 b=r6caAQJO76mENmHymI9qxQzUHG4cbwE+KZflXUJnfvwBAt2l4wLYxG4cxTZYdTfInE
 PMBW35A4GcjU+DgVyVy1/gQHDTS7VxUliv10OLChnyCt9Nw1yJOJdGR/3DRma4gh4F1y
 yC+wHMvPJh4/7thBKFJu+VIdSZ5amwFqUWDY9bhwfBqimcFupMJnrQuuAKHD8rka4T3N
 E4khpgvzJYub413wOFJ9SkDnv1hI1bSMQRdcdF5EL27n9/Itnc7iPhyXLSXjoNQcrQKX
 K53ae9RZRKs+fynjCG0/hqVEZJV6SMS+6YtepFVjdqEXWLFNH4v1oyToBIqv/nvQKJee
 xj8w==
X-Gm-Message-State: AOJu0YxI1WQ7Vvjg3tq6Qju92s1NNxpJJag79NwmCRNxM+Un5LC7vT5i
 cguva3wOdNH6RB3d15gZVn23dm3K0gqvCpFbVR/2TL5Q85ZaeX9gGPj4UOTwnVeZHe/dkw==
X-Gm-Gg: ATEYQzyuE2RMOQQ09E4+xkrST7vk1xiFnYV0n3OyixSpEnjbYatdDu+BRYeAiOKIQrC
 YwDIlqdUi/XYkGGu11DbOKnq/EfhN6PjbENcy5Fhpza7jj626i8p1KYGD27BYBY8rMtkUhSY7Bm
 wBtcKgVzJwi6DLs0lEx8WjQ+avnLjSG/an//5ahkrqlkqYD4+RitK5Hy/WXyevCzD7jgkVY9fQy
 uTqXhU7tKRh9twLAOObAyi5LdhCiQKPFjvWXWDqWo/oopuwsetMPq0Z+7PrbvX45lRNmFpeE9LV
 oO7hCC4k6kIs42PTrPnGC5mAKrzOHhJrX9OMnXeFg4XnVnmQhT14HJC/4w+Qc4dwUhP2O+MX158
 g0xVpQUkZiH10b0bGOTuIrKa/UMJ8Sop84Av5v0P30HiO/pblAP0cPDxeeF/k+uUlVzA2c8vDYu
 gZ2HFmgvhBdLZHgftE37a0gUNP2cpK2XQcVw==
X-Received: by 2002:ad4:5746:0:b0:89c:5c95:eeea with SMTP id
 6a1803df08f44-89c85a1aae8mr38891226d6.20.1774011166246; 
 Fri, 20 Mar 2026 05:52:46 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c8537c3b5sm19168166d6.47.2026.03.20.05.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 05:52:45 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, philip@philipmolloy.com, trini@konsulko.com,
 linux@analog.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH 06/11] mach-sc5xx: Remove preliminary binman support
Date: Fri, 20 Mar 2026 08:50:21 -0400
Message-Id: <721c9c2562411461b64b1819c0965813eeca5888.1774008927.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1774008927.git.jcethrid@gmail.com>
References: <cover.1774008927.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Mar 2026 14:06:14 +0100
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
index 774c69091ee..276d173912a 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -143,39 +143,6 @@ config SC5XX_LOADADDR
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


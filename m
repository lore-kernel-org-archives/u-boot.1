Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7599710F284A
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 16:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD56384088;
	Fri, 27 Mar 2026 17:24:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eOSvuX5g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 006FE83FA3; Fri, 27 Mar 2026 14:51:52 +0100 (CET)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC01A83E7A
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 14:51:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x843.google.com with SMTP id
 d75a77b69052e-505a1789a27so11442051cf.3
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 06:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774619508; x=1775224308; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q/KH2tpFhJzaixNSsS/FoNj19VlWMlwakz8LBcvpRJg=;
 b=eOSvuX5gv2TZj6QZSobqC5izrOYhbE03yGp2me3IoiUDYPwRLqHmaYWc57kuruKHaT
 h39L/tt7ztQ5URPsFzWAd72oRBAR2NbId0T/4xsQC+IYlPIxzXxsn1nKuprOEM2/V5gC
 2lbB3MZ2YsR+117LVl0q86du4HeqlsBsyG5o6/ZfTaN8p3v36cg9yl3kdBpQY/dsOHD8
 1uB56FZuaSo0XOt9lMmO+57GAGpeMUIvApnx4RqCLLNDiZnwwNLZ+LhbjauIrFeHcntx
 Cpbc50wc7ly3Fet+Fti9B/N75TOB2glzaxH95man4OtFLOIEhnWT6mq/RcMBipL66uQq
 IZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774619508; x=1775224308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q/KH2tpFhJzaixNSsS/FoNj19VlWMlwakz8LBcvpRJg=;
 b=AYwJHTppkz6AYBRrEjzaPupeLrZKKeKj6rX6K79a7vkhXR3eXi1psyioldsfhtjUzu
 W26wzYDZeGcsMbn5DFvNtxHYlpWSSlipspMHpwOnnNJlPXZE13LLnKP1xjc076G7tSNm
 HRGuiB0QEFHZvv9fEt3lauGNABpm8QjJWHwtjDu+1Hm9f81tlj6EwZHqCQPEn2d/HE5m
 0ldtMSMEGHel2Eon/tJ0D9J2ZjOYcRLmKxXxn9kF/JaqvMslHczsaSp5LvJMdf0fwzWj
 zczaxFyyzOnPMF15MIJ6rczcuuPU31T36pgj/MkY78Rxbpr31PySp17/ftKtjGXanAvN
 6/Hw==
X-Gm-Message-State: AOJu0YydR4G/KVj3pkk4B9VAVwYucoDZCjM5dKLmq6RQPyWutNK15BrE
 Hh7UylDQZb2bR/go/dwoZBEozRVE3s7DJDKcJIQcC0O0r25vLLVqcBu2AnLNeG0g
X-Gm-Gg: ATEYQzwJW9g5a1abErzq+IC895pw6NfcHjLMkxCdBPdzavfkhy7Dg8wUQ9WTH6oPG50
 KsGxQ5/7S245OrHPYUOXNIHEXfO3bfU+5WLhjjuAdThKR/n1HlDVRWW6XhTUxfwHBwUR8jBhwrm
 8jZGH8m9OsHcG9RR5B7pQjAdH6QsEj/pg1K+c3EZKawCymaQ7Q4vwnl9ja50j1RxVM0HFwULcas
 IkcK/EYvrO0/zVki5Oj93ix+NeW8HsX3XqrC4zqsMideekYB80U4ugpn9AuIKGOoBmLX0gIWn5F
 cBUNj3vITTmxMoXYsTeNNM4ThIHOtwBHeiJOXKErrYslO6A+YMClB9onjJxTWaFqXqHRzip2g3B
 rTwO/Sg/rUi36kGw8tbXq1cb2QzYqdyVNHKUXn3IKWpnoZQITdWYMcrXSuJlJR8Nqa4xcXxsgxX
 ycmWXFNvvkgixrOic4O38OjK+HtYMLVhqzgw==
X-Received: by 2002:ac8:5744:0:b0:509:45fc:c88c with SMTP id
 d75a77b69052e-50ba3836f51mr35765211cf.19.1774619508519; 
 Fri, 27 Mar 2026 06:51:48 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89cd588969dsm48691356d6.12.2026.03.27.06.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 06:51:48 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v2 06/13] mach-sc5xx: Remove preliminary binman support
Date: Fri, 27 Mar 2026 09:49:21 -0400
Message-Id: <83ccfceb891bc6c5388deea06a0600575c77be45.1774618658.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1774618658.git.jcethrid@gmail.com>
References: <cover.1774618658.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Mar 2026 17:24:39 +0100
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


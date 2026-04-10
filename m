Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23384E99058
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 07:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6A5184207;
	Sat, 11 Apr 2026 09:09:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dKQH99Aw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 017638418C; Fri, 10 Apr 2026 15:58:42 +0200 (CEST)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF8518414B
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x844.google.com with SMTP id
 d75a77b69052e-50bbc41677dso27865411cf.0
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775829519; x=1776434319; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ICE6Uu31Z3+Oim2GsebNaxOF5NTenlaIE0sod4H9L94=;
 b=dKQH99AwnrSrlkaEhz3dh1O+SpafT8TSNCApP+hCis2RsV8d7cGR1SMc3/DvWoVFia
 QauqovJFeMynYzE3AgZnTF7BMULD/6fwg+DP3gn+Ybbhnd/faHKh3ycUkeCOABmRt6al
 rfOMipUyOLWdxtVN4wQkNKuqCm6nsUvN53Fu7y/JY4kJY7HaNMwLVSqEJl96yl15LivR
 4opCEyrQ9G5kFJiHTzm88QDwzpgu5PumC7OOsimkH9RtHchzTlxhLNXJeMwsecPyZBRJ
 NYty9hbjXOuQFUz12NfvuQDYtXCVDQeGU5MzXqpE6HyVJFNP4QCZHlal0ryrOHh3WmKk
 dJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775829519; x=1776434319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ICE6Uu31Z3+Oim2GsebNaxOF5NTenlaIE0sod4H9L94=;
 b=WbbkfpSPNUjHHh7YoxD3iXELfDKArdXw2j78agMR35LBUDMHwYTrsgxfOuC+2amu6Q
 gUCrxtlDvODoCnV7yAGSpRzEej9nWqBksuYTMl7c9vcncD9kJ0IEGlGIGbQiaDL8BGBN
 24c6xmUYLVooNRe6feMSAYAuM0aYb1GMlbUPYCwodrCBluVePJs2B2M2M6eOdNHVi1ni
 o/XgFYmIksk98qA8ayIgMGOY2DEZr+4wAbh/IC1zF/qLyP36wt21IOdkYrZ5zOW1/OKA
 M/YJ5z0k/4rFPmcIdNS3l3fdh/Ey8BG8rJ1A6FzYJyyi6BCGRDxbzYOh/vRpLFA4TJ2D
 B20g==
X-Gm-Message-State: AOJu0Yyma29DvUysOG72k1X7Upf4oXbZ0Csy9FYN3XSnkrL4PpVEbgs6
 sPO+W5pPGuoeBjSKn2GRaFVOe3QTfV4HBVwk4qn4O4WIrbWuei66LmNWASu+5sOc
X-Gm-Gg: AeBDietKQr1jX/U3xmaNMge8Bmc8FpYHFjXLhvv3m3JZQum3YPhiRHFmhTVHL3GvvrO
 +E8Qj0Y0MzV143ZqlyrEySDc4uzi1iMnIoXddcQaJlmGnJXQjzNVzofRLKYXu5i52f4lYfBz6s/
 9VDsO9KsQBMi0/Tl4XstuVOU/Hv7xrm5h2VVUWDWoPAYjgxGeFA1XxQU8KYDfC+xoHcy4auY4kX
 f5FUSb8q7SdKiRwMJVagtOR91EGqKV7QLRljsR1LsIT3gPEDbz8+CxPmAuV+Y8ZW3ILxtp9ptLD
 npBGUujkAeAADA9PUJmNX5+d2FqgdUcZfyMQjp0KZvIzkbB+ALRJmEdxrtK3+hD11t9rzVwbKYC
 +WYJ28IQ2lzpdtVhkHe7zymj6HwSBfu9VVY7GMU5alYrjXYmE1A4rqYiR4ILMc0nK3NsAsBkT+3
 D4k4mzIk1oPe3JsPc5M0IpdYUQ2CvyKGnV0Q==
X-Received: by 2002:ac8:5c90:0:b0:50b:501e:152f with SMTP id
 d75a77b69052e-50dd5d5a613mr54888881cf.59.1775829518491; 
 Fri, 10 Apr 2026 06:58:38 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50dd53f9c16sm21723141cf.11.2026.04.10.06.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:58:38 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v4 06/14] mach-sc5xx: Remove preliminary binman support
Date: Fri, 10 Apr 2026 09:58:01 -0400
Message-Id: <6a67b9f84853b2f06992b294e023e8fe20464054.1775829166.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775829166.git.jcethrid@gmail.com>
References: <cover.1775829166.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 11 Apr 2026 09:08:55 +0200
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


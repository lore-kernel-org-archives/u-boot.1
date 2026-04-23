Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A81FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:08:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10B798455B;
	Sat, 25 Apr 2026 20:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zuo2k8pd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA2DF84319; Sat, 25 Apr 2026 20:02:06 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91BBA80087
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 20:02:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-8ef2118b478so511263985a.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 11:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777140123; x=1777744923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ICE6Uu31Z3+Oim2GsebNaxOF5NTenlaIE0sod4H9L94=;
 b=Zuo2k8pdO8bg95e7BjnIHkXalPrXMZ+hr5iNRijqi7+XzVUb8QlrkXmGem+it5Xs39
 R5V0CD+Ykr2D+dpoqWS4rLVBNHql0CrRjRmBHpg2BFlL8/dVd1KTJbiob+1iRsUApLUl
 sLDbpZjcevyRhxvakOSCJhW8o9hLpsn9rTt/P0eyBHnnFDoXdMyZt9B+rSsHh+ToiQhx
 DqoA3/L0YRGVJ/SHqcKGwX6wztIPc7eFLHcXNT9bbuj2Ok+tUPyQwrtSPCMxkLOCp/Sh
 8qHwPh8GlnB4sEjijcGd1BBm/FuBSkO6YGnbioVklPYnVPou6yBTywayzC84He4r946f
 9rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777140123; x=1777744923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ICE6Uu31Z3+Oim2GsebNaxOF5NTenlaIE0sod4H9L94=;
 b=BHLoPgpE0yXJwrdr8aohiLasTXBpp6yCJ/qdIhijnk6MjTnb5zlu9qbt2OPYn9dlwt
 tnGEfLPzWwj/1vXCehaalES5DwOgfUA4Z948NEo4YjzBQ4KoHCrseopTSgxX2Hht2KkY
 gO7jiuXAhFtWJdfI/owninZs2aY0fHtnBMMome78WdmGxAXyx8oiAlXAS5+574uAmI3F
 v8wLEzZHrxKg+/Y4AdwIz4/DIux8G/z0vB42TY7G8OE3d70KBI2m9Fz6zJC8CcHDa6Us
 D99qglMfd5siZbxZMvkRRaFfvoMiQ3vt03lGd0xoWjYzBi7XrrJDEdLSSMBWciGZEbsa
 XoBA==
X-Gm-Message-State: AOJu0YyWtSxtEpyPTU4/PJOayUHoJjp2ndCM4KaVujt5eUjDg0zwC6nv
 sJ8iOn8Ot8R2V2qhFpVhGqUs7+Q5J6TtHyZtDcvXoKW0UKz24l9mpYF5oKMAYBy3
X-Gm-Gg: AeBDiesdOQix3Us4Ozxbfk3l90pUPDQcYlDdZCSCdbUbC4Z5FllOCNWt2BdInCq1Uer
 QjJ5kiGr+Rd1MEpVsvgkDu4NyEMusOFBVBUFjEIHa5aWw4nodUt6mRxGxQNKoO7mLNzlOjaYV7y
 bnKrlJweXNwdoNsiX0oyv28QKKWrmf/OwlNFxuEJUJtMbhWRIdJo/+lxW9ip/KhWtR1hOO69U1r
 pFvYCJj0ihGuO3296s+yvwNLSFvCiGTGhbMQES1yFrifEq8mpk3RcjsBXqkcGI1K3kfN0AXorJS
 TZ/P+DrNE919fI/iF7GhNiS7i3IBOoVkVeumnsEJdNoFw1Rl3y8dY2P1W/voISYCKV/9fCUZWPI
 yHLlNf6CQJ4rRBqk5iHllBr6ELuzoGTcuyCacP0JIZkYfeJkg2ZN+CR0+kjjM2dYQC6aAXxYIJP
 zuDTcVT0C1PueMXHgVTuIU3sFKI9qUKhbCC8J7LMdJpXE0
X-Received: by 2002:a05:6214:4019:b0:8ae:5fcc:ebc3 with SMTP id
 6a1803df08f44-8b02813ae15mr422539426d6.38.1776954347097; 
 Thu, 23 Apr 2026 07:25:47 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02aa4f1f9sm157183266d6.0.2026.04.23.07.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 07:25:46 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, sjg@chromium.org,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v5 06/15] mach-sc5xx: Remove preliminary binman support
Date: Thu, 23 Apr 2026 10:24:41 -0400
Message-Id: <650457e35a26c26601053a00dcb09e33cb8f151c.1776954004.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1776954004.git.jcethrid@gmail.com>
References: <cover.1776954004.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:03:18 +0200
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


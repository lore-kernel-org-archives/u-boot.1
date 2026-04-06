Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E922F46C79
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 19:47:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B3E684148;
	Mon,  6 Apr 2026 21:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="irpS+zSO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80C068352B; Mon,  6 Apr 2026 21:21:36 +0200 (CEST)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65B5D83EC6
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 21:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-89cda8de641so52973266d6.0
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 12:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775503293; x=1776108093; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C0obab1g/FzzH+pM81bZeuGKyxqOViFAPHDGRpSKfLk=;
 b=irpS+zSOrbyEKeU1J4rSJTLy57YFUH4Ksth3pQitFBXVufQTGZAQiXnwU5b2zz3ntz
 dJIkYI8HGMGeTlDSb8FI1sZsiUt9cDaj4hcaSG7blFMATSfWxwxZID8MgcFGVc1DAMpa
 ens81h5s2mb0EY/cvYzi0goL08B33aOvMF2B+3+l3mCqfi/fcLBSX6yPxuzEZVSAIZRO
 oTyPZ/YbLyCLXXjy6Pdveerhoui3P3/q3nufMRYDN8IZUyfl7HwNQtvBqwy9Z3iR62z6
 r50qWl704Qy9yKYcgcgw1c7Eu3j/D3HTh9Gq843ICXue9u3ptRC3Q1TLq3EIDsm2q4AY
 yUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775503293; x=1776108093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C0obab1g/FzzH+pM81bZeuGKyxqOViFAPHDGRpSKfLk=;
 b=CRK6BFFtrHgIXh95bGfLgX55u4z8H2q6f76Qztx+9FmIBTi5Vj4AwwXTTpRTtiK1fP
 kxeOyQ+wjQyL19M+IsTAdSWUtAtdU+fKN7Ejb6Lui/D5XrFgARx7K/RgiJYjwXfgqkD1
 4aWkTkVKe6g8FMjNVtlzLz8X4cWV9g/WMGGB3rQX+PYb5/jbwQNvKO78QI1/Tzk/GU9v
 K8Cqs4p0zdAws6ONJ9YtaTMyk/6JV/v6pwLi4ZtttmHCdAapjLOsAlFHzY0354XlVoSS
 n0IPqWb4Rq6iIBlfsr8SEhLOfqY+NORaUyWUt9RAoIbPf8cd15S29oVnkcDWvrO6CvjC
 sqzQ==
X-Gm-Message-State: AOJu0Ywfdy68tLWpnUJZL5h+Uj4JOFAYlHpwtmshGsMk5cpykjN4ho/n
 cq0sHkcyb5VrSixVaxF2Mcsxs3r0XtoloJXq+QXJIBmkYh6mEah5qEZIiXHmdZZt
X-Gm-Gg: AeBDieuXppxFfSmjAOWE5OT/0IjXSUemWImUi+5v76Y/8zbSPGk04C7VubJY8fYt1iF
 pLbCrvfE4jZcsnA/BsNZpCy4AAum5n8WDwSymnhGCkGYfbNAEj1PejTzCBRIM/WWcoSe+0FXT/J
 J0df/jCiO07KBH1MFnjH4x0LZN+4foWGr9RcmQV9+B7IwsFcHfDz28sgxAFKR0xRsAccf0Pw00w
 t8d7+ijsugtQGPM/qWZgtXiXRzeWg4qfi08ddOsTyNpYBPQ3hFtdQT1Y7mMJ7KIquNeenUrWokt
 jruUejMMNghTiLySoYBshKqbrU5eDf1nz3JA80TkPYnKKnuRNZyPaLbus6lFblhM1DTQ386LuSO
 5MQ8rGZiRdCpa81fD42G2+epWwTD4xJMeoTDFqs0EXvr3pGGRi9EigO5iKj09XBVymSuxzzS4fs
 /CXpdLpNMpCk+2vV07DqqWXDSV83YYtCIa9A==
X-Received: by 2002:a05:6214:498d:b0:8a6:f065:3ef9 with SMTP id
 6a1803df08f44-8a7026ae2c5mr246196506d6.15.1775503293115; 
 Mon, 06 Apr 2026 12:21:33 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8a596e03dc6sm150191166d6.34.2026.04.06.12.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 12:21:32 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v3 06/13] mach-sc5xx: Remove preliminary binman support
Date: Mon,  6 Apr 2026 15:06:08 -0400
Message-Id: <958cd7efcb64d11f3e31ec70f51a99703622687a.1775500819.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775500819.git.jcethrid@gmail.com>
References: <cover.1775500819.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 06 Apr 2026 21:46:28 +0200
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
index 1486656b36b..cae5e4ea5d6 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -144,39 +144,6 @@ config SC5XX_LOADADDR
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


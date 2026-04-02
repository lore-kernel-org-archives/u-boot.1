Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A27D6AAE7
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 15:48:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34BBA84148;
	Thu,  2 Apr 2026 17:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gFcUHiD0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB86E840CB; Thu,  2 Apr 2026 17:29:05 +0200 (CEST)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C481E84020
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 17:28:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qk1-x744.google.com with SMTP id
 af79cd13be357-8d00cf835b7so135262185a.1
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 08:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775143738; x=1775748538; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C0obab1g/FzzH+pM81bZeuGKyxqOViFAPHDGRpSKfLk=;
 b=gFcUHiD0iZ6bdB+GKvwtXtEuU1DslaMUIgxZPSIgU2qJedzhvYN0OOJs+RFHxzNwot
 94l/Pjb71zoVxZes8KFo8O38p4IFxduRqrUypFVPGifE4lfpntcqwW3PDQfx1rOnMCAH
 8lQjonwR1snZQAxcHeMiF4eLQzlY5eDU+NgIysqVz/YVjDHv0a5PNLa43Tbt2QUwjska
 rd6QyX0pvMtk7U7lZ/bqBv1RcThxSmVZXRsk78hrATSHCFEfE/38f7Urf35Xcl2YGheM
 T6pSs+T/UOarEEfR0f1YlxP28RGTGmIVc1ZiquWiOGJEP9gFOtDEMbBmgyoc5BUnEvI+
 ta0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775143738; x=1775748538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C0obab1g/FzzH+pM81bZeuGKyxqOViFAPHDGRpSKfLk=;
 b=XcWBGLAy01BbRbqvMs0WY0Sscppi5vqi0gGyyIujEMZrK+qDpmBd7R1P4auuRFqeeA
 SrrY4ZWnuSzokXC6zVyF/3qvjrt0OD4GNdprBLdIAhwAmN2Nxs5Hiz5OeZHpGHgvm9CE
 BxBkMDUv9p8pccR4zCFaofylAwlHbiIa2YjPFkrlM7B71kFjpTiHcdYdWsn14PMm8Uy3
 /0n1kDR+KL5cCYzYsFm3j6y2zITM7GhN5PaCBO9ABrRABq8T3e4CjyFLc6+j5j/ErjNF
 SqLoqDngS44bSRAmDtphyu89XaYaGqmJrlMPZFDQNCQ24TNCWW0cogZ6znHdIEXUYdnq
 uI1w==
X-Gm-Message-State: AOJu0YxfKZnJXCc+UYYJiTnMt9xL40s3Vs7ecDhREFkOHxU+Q8gshiLL
 2CrZU4OraucFv6VXNpSRVo/jCpsh3V3grn4SHPay47gubQuDffDv3RbZoctACm2E
X-Gm-Gg: ATEYQzy8yjUnIROTJdMeVfC+lUU1igdyKA+R6rKxXXDmgqSeJNGstASMfhz1mKJRWE8
 vaJ2lONYJD/4IMQdV7Y9U07juxwYraC2/r4k0ILXu1o855rWPg85lGRyi92i+qpfWkicu5L7m8C
 Ix8zneSb5AdEd+T8N+GqD4hyk9TNfhkxpIb30Z+TIwr2eXLOtg7H/MIoJgD0e0+mXx14bnZnUvq
 k8d0+k4Bn0P3zFRUWpam7PDNLqBxnc6GoBu5PkLGXt2wwuiLMhnfNTc5VcQjW158H2uu8q/PIu5
 VIuO0IA0Zbz80brZnObyyUwxZqeWb0F+tc4bZ0/jA9Wk0+7ccBdVI6FJ0UPp2mNocZdPSRfKk9C
 6yoHOQT32iCtORjHmT3wRsOPr1HArtT4kL+cwhBSFJIpJfC5dNK17AzOZQ9VCucXedKh9G6JwB9
 6EFaYPD1DX6OjFz0Nuz5Zx/IntDUJa740+HA==
X-Received: by 2002:a05:620a:711a:b0:8b2:f29e:3af8 with SMTP id
 af79cd13be357-8d1b5c4d45fmr1126138385a.59.1775143738571; 
 Thu, 02 Apr 2026 08:28:58 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a5393a07sm239037485a.4.2026.04.02.08.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 08:28:58 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [RESEND v2 06/13] mach-sc5xx: Remove preliminary binman support
Date: Thu,  2 Apr 2026 11:28:29 -0400
Message-Id: <e36fc142dff4879962757fa85a1aae986bc99e68.1775143241.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775143241.git.jcethrid@gmail.com>
References: <cover.1775143241.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Apr 2026 17:48:00 +0200
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


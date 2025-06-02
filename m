Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8719DC5B555
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 19:47:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD92D828F8;
	Mon,  2 Jun 2025 21:47:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VmuoYNjC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FE4F82145; Mon,  2 Jun 2025 21:47:09 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C96E980F9C
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 21:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e8134dee405so1819206276.1
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 12:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748893625; x=1749498425; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gb+xuV4DyIO/E+Q2P2gOXIAb1BnRVc4w43VaTMpssFQ=;
 b=VmuoYNjChBtkXI1Mv0HpZi3LWwfg9RicfuLL0TcNyizOUbW5aBzLoZuyIV4HfIi2WI
 s/1eI3qF/OiJdC9lZrrVqI0v9IZRiyFJOIWcQnctgqriluNhT0hTaHNsSygIVQkepvJD
 g4gGn+Yu4jxHx8VXQk6z/u9lAjDHWYg+jBHOkofZbmHSZ1Z5IxWMAIy3kpwa+0tyLMB8
 KXy5MwX+uR2EedLmE+4jcEOvq5AhG/ksj+WG8AU3ddlkbR1QjrrpQA/Pb73Tf/UyT7PB
 2EuobesrRPXfz6yp624oa9iS+NJeJj29+bO+ZGtoZKLLc5TXpw+shU67hD1xm4gFljnD
 XSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748893625; x=1749498425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gb+xuV4DyIO/E+Q2P2gOXIAb1BnRVc4w43VaTMpssFQ=;
 b=r8vsC6azSgAwe7EgPfEHMkzlDoAFlTAyNQf11MlVfRy+58nF6MeKQZBsJTy21VPfhw
 XvYtwetjwAEhLYbLidvBI6w/ela8Zs0X1k8jhH3rCCpzT+FDpDKuVkPKiCXf+RNZNKY7
 U44uLPHYfuQOMC0kx+bvY+Oabco9UqVuAeyoRrqDACe60GxRiysc3dUKCb1QtVKy+HN/
 aKh3pWbMdURdlNDlQ8Cmoz2imXqxLOnpAcpgtUr5TsnAkb4mRY0M6AcrxER1lwgY8uxY
 S0Y3zbfSwL38+jlFGRanGW11GFGJRuaZ/lDu1HF/C/hHn+1nKcHZBWkrT3zWVg4kUYq8
 J28w==
X-Gm-Message-State: AOJu0Yy1IxBxUR+Z8t7NowMxwaLbW1rOnVtrK5qE4nPF/sEY03cyM/Ny
 Cd1EO1yAAbuPwpcbo2GYxH+J41/FO0vI/FUyzsQ6X3Jyno/CWg7DVG/4NgXN
X-Gm-Gg: ASbGncuGY446Yk5INupHBKjMBP83bbBHOZcqvi0jTADZgtQuxIRXtU70ky1ogHzaT+f
 Y3X8dDTdiOGs9ajX9CWBZObt8wN25R75YF4q336DXri0HCMRTpbrOXeVRGzA9VKhtxoW6PMA0KR
 WWALbb259MTkdoqD7+44usnrCB3AvwNTpik+o/aBGIikYi3WA7ZADF+ZJgrimvA1nWZD2uIPHLR
 qE8xZuVaXPDZd4NENNSkKkfYAxpPF+PRkozNPlq2ZmMfw+2UpDzDzBSxK3tZeiWPdtjUexNaIgS
 nkpw9RdkUZbZz+5KRupC09rtLcO2FJBUzyBz4b4Tmz8Yex9Q3vKarXQQ2T1aLL7I1hA=
X-Google-Smtp-Source: AGHT+IGSxOYEvN1B+A2WfqyL3jTOfiwGdWuGF+GkwgisFCr4TMxVZ/xj9pBJAKa7uhqgdc/DVHhkEQ==
X-Received: by 2002:a05:690c:f87:b0:70e:2b60:1562 with SMTP id
 00721157ae682-71097c56f6bmr138942927b3.16.1748893625057; 
 Mon, 02 Jun 2025 12:47:05 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-70f8ac0f452sm21902867b3.51.2025.06.02.12.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 12:47:04 -0700 (PDT)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Utsav Agarwal <utsav.agarwal@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Subject: [PATCH 02/10] mach-sc5xx: Add binman support
Date: Mon,  2 Jun 2025 15:44:40 -0400
Message-ID: <20250602194507.15159-3-malysagreg@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250602194507.15159-1-malysagreg@gmail.com>
References: <20250602194507.15159-1-malysagreg@gmail.com>
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

From: Utsav Agarwal <utsav.agarwal@analog.com>

Binman is optionally supported for Analog Devices sc5xx if Yocto is not
being used to create and assemble system images. The spl LDR is
generated locally but other artifacts such as kernel FIT image, stage 2
bootloader LDR, and root file system are built externally and must be
supplied to binman if used.

Binman is enabled by selecting the SC5XX_USE_BINMAN config symbol and
the image structure is included in the shared sc5xx device tree.

Signed-off-by: Greg Malysa <malysagreg@gmail.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
---

 arch/arm/dts/sc5xx.dtsi     | 52 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-sc5xx/Kconfig | 33 +++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/arch/arm/dts/sc5xx.dtsi b/arch/arm/dts/sc5xx.dtsi
index 3f440dac29f..b4de1b51bb9 100644
--- a/arch/arm/dts/sc5xx.dtsi
+++ b/arch/arm/dts/sc5xx.dtsi
@@ -10,6 +10,58 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	chosen {
+		stdout-path = "serial0:115200";
+		bootph-pre-ram;
+	};
+
+	aliases {
+		spi2 = "/spi2";
+		serial0 = &uart0;
+		bootph-pre-ram;
+	};
+
+#ifdef CONFIG_SC5XX_USE_BINMAN
+	binman {
+		filename = CONFIG_SC5XX_BINMAN_FILENAME;
+		stage1-boot {
+			offset = <CONFIG_SC5XX_UBOOT_SPL_OFFSET>;
+			type = "blob-ext";
+			filename = "spl/u-boot-spl.ldr";
+		};
+
+		/* since falcon mode can jump from SPL to OS directly
+		 * full u-boot is optional
+		 *
+		 * @todo: review if we can say this given support has
+		 * not yet been upstreamed. Otherwise we might have to
+		 * invoke binman only for full u-boot.
+		 */
+		stage2-boot {
+			offset = <CONFIG_SC5XX_UBOOT_OFFSET>;
+			type = "blob-ext";
+			filename = "u-boot.ldr";
+			optional;
+		};
+
+#ifdef CONFIG_SC5XX_FITIMAGE_NAME
+		fitImage {
+			offset = <CONFIG_SC5XX_FITIMAGE_OFFSET>;
+			type = "blob-ext";
+			filename = CONFIG_SC5XX_FITIMAGE_NAME;
+		};
+#endif
+
+#ifdef CONFIG_SC5XX_ROOTFS_NAME
+		rfs {
+			offset = <CONFIG_SC5XX_ROOTFS_OFFSET>;
+			type = "blob-ext";
+			filename = CONFIG_SC5XX_ROOTFS_NAME;
+		};
+#endif
+	};
+#endif
+
 	clocks {
 		sys_clkin0: sys_clkin0 {
 			compatible = "fixed-clock";
diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
index 70c7e5e0631..a75c4207f52 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -147,6 +147,39 @@ config SC5XX_LOADADDR
 	help
 	  The default load address for u-boot.
 
+menu "Binman configuration"
+config SC5XX_USE_BINMAN
+	bool "Use binman for final image"
+	select BINMAN
+	help
+	  If you wish to use binman to assemble an image, say 'Y' here.
+	  This will enable binman-specific sections in the device tree.
+
+config SC5XX_BINMAN_FILENAME
+	string "Image name"
+	default "sc5xx-image.img"
+	depends on SC5XX_USE_BINMAN
+	help
+	  The name of the image that will be created by binman.
+	  This is used to create the final image.
+
+config SC5XX_FITIMAGE_NAME
+	string "FitImage name"
+	default "fitImage"
+	depends on SC5XX_USE_BINMAN
+	help
+	  The name of the fitImage to be packed by binman.
+	  This is used to create the final image.
+
+config SC5XX_ROOTFS_NAME
+	string "RootFS name"
+	default "rootfs"
+	depends on SC5XX_USE_BINMAN
+	help
+	  The name of the rootfs to be packed by binman.
+	  This is used to create the final image.
+endmenu
+
 config ADI_IMAGE
 	string "ADI fitImage type"
 	help
-- 
2.45.2


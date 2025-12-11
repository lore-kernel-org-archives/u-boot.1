Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D188D41C01
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 08:06:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A180683CE3;
	Thu, 11 Dec 2025 09:05:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NLGkQ9mU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCBFA83C9F; Thu, 11 Dec 2025 09:05:53 +0100 (CET)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B574A83C94
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 09:05:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-6432842cafdso601063d50.2
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 00:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765440350; x=1766045150; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kOLvYABW607VGNhbGGH6i0LCrzafdHBVhMM2AMxPgak=;
 b=NLGkQ9mUqmrCLnrvQlhIqOuWfSoeMWBB1vt/a1GfpRIk/wpkX3Ypu/etoMI7VdGsCu
 y/2D9mYmr/Convb1wM+lqBHvYyjmbhBRCHWEBl+RGeAmdACKSK01urFxvZVNDA6VTPqK
 Ke+VWhv91sQhSq++jBOw6C9SXyYQGKYeVjCOOINvpDxPGXvFVUL0sWGtBfXCjXRAkcQ2
 mTYEH8dke5ZV1iA0N+F7BtZ3pvPCVSEJWVugFBX59XBOsmhGVJh6ip1v1mMIDhOUFmmZ
 9AMlnSeRApSGSE7fd6NejQ37USnPXJiOMbxsGxpGH9cOnvsU7D+Ri2NMOaU2o+i3/T2b
 5X+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765440350; x=1766045150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kOLvYABW607VGNhbGGH6i0LCrzafdHBVhMM2AMxPgak=;
 b=gd6QLC2MqoMoBbHIrHc6BMwOhRdgBor1weuOY1xnx/M7m9hrNAVjlejj2w4AGX/Wl6
 IJUmzrgzQ/7sdIkeqIYXcqwcke7mbE4ioMdlHJYBCxI6xSFsirh+QnEDVKWLgQVxlG8o
 W2G3I8g7Zk8UN9eVk5iu7eK40icqIxfdUXJuDOBeOEUd9J0ElHI1wJ724dc1ytVx2vbm
 YI6XXlH54i4FVUoUJ+TC61/+Q0v4LPvnm6YmAlmDZdKWmXRouU8T2xNA3HAZ0CpZtBGo
 i761BBRRIylCB4KRx01v6WT9Wq6aJ0Bl5AfMANel/aPrlZpFu4zpzocuNNeu9WQIpwDh
 dYNA==
X-Gm-Message-State: AOJu0Yw1WcPBbi6tWoUhDrnOIORUo7vgHwwXib63+9A0HTByazWHi3+Z
 pwDxH48mpDFWV+/qjvUon4gkFA0+9j+pL9+jVdoncVl6Ynx254L0suXL4cc5
X-Gm-Gg: AY/fxX4zpoWXbNlbFn/vNIO5wmvPvowRQOQMVLmfirYc0PGOypa95weLyr2x7zdHBcK
 7J3DvVeTbFaBPv/YOEo/L1dbO9bpLpOrNUlaKhtIy2AdRdQrQah7pO+q2v1JTEubKMl08umIMoJ
 wnyKsR9JcFthd4BvcbEjSQ4Vzqn78TLUwu1zGnttvdnq/7oOGgr7etfOe+EByKeqfkWcPajIVo9
 AmC0QsonigmShuvFL+AE0qZ2kBFqb6F1egBnP9opKkQJ5szBr3Wsa6sjBsH4aC3q9wIZwJRYatl
 tPF20v+PHggnv9uM2N6QxuA02fXyzJTq9usSh1GCl/p0wIVuLgiqPLCr/wFBeRWgqwISn82r10X
 JZy+pMenUoKahgpBXNWD30EpS52EzX0uq2coJdqbx8fDlCLp4HC2CQSxWgPB3K0Tvf6DcDc8huK
 NcavPi53E00AjLHxy8a9DSDPwhbA==
X-Google-Smtp-Source: AGHT+IHpSUmtW6VBCND0Ajq7buntWXqkcWqG8MiDfNC93wQ4chG9E/0ZaXWP1CDWjOGtySyfkTJosA==
X-Received: by 2002:a53:acc3:0:20b0:644:49f0:9a21 with SMTP id
 956f58d0204a3-6446eb2feaemr3672649d50.44.1765440350138; 
 Thu, 11 Dec 2025 00:05:50 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78d69d83a85sm7256657b3.28.2025.12.11.00.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 00:05:49 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Utsav Agarwal <utsav.agarwal@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Philip Molloy <philip@philipmolloy.com>, Tom Rini <trini@konsulko.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Subject: [PATCH 04/12] mach-sc5xx: Add preliminary support for binman
Date: Thu, 11 Dec 2025 03:03:55 -0500
Message-ID: <20251211080414.5363-5-malysagreg@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251211080414.5363-1-malysagreg@gmail.com>
References: <20251211080414.5363-1-malysagreg@gmail.com>
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

Binman is optionally supported for Analog Devices sc5xx SoCs if Yocto is
not being used to create and assemble system images. The spl LDR is
generated locally but other artifacts such as kernel FIT image and root
file system are built externally and must be supplied to binman if used.

Binman is enabled by selecting the SC5XX_USE_BINMAN config symbol and
the image structure is included in the shared sc5xx device tree.

Signed-off-by: Greg Malysa <malysagreg@gmail.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
---

(no changes since v1)

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
index b7c298fe279..ec1d5539dc9 100644
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
2.49.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB879CEBF93
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 06:41:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C96583CD2;
	Tue, 18 Nov 2025 07:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BuLWvKaC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8BEF83C72; Tue, 18 Nov 2025 07:40:45 +0100 (CET)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 914C683C93
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 07:40:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-641e9422473so3395472d50.2
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 22:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763448042; x=1764052842; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kOLvYABW607VGNhbGGH6i0LCrzafdHBVhMM2AMxPgak=;
 b=BuLWvKaCS2js61i/zPUOXZZrpn4dCb75r+pks/75Vb1Qe/t9Kxpg7MHacij3dYYEA/
 /5ir+3iRXaEPrsemo/OrBWs/VQPCujdr2QeudSn2zSyui+oZCjfaprP/cH0F+fK4URyy
 cKs/HV0EvsUpElWAtu/PZ1BNBppQEX9Dgsp6xkGHvJE5AcvPOsGNaH9Aa5Zznnu7LeI5
 xkb5VvDSKiKHnkVUZrrxVs1RmJWkJBqvX9KvMetF+P1q0CN2bpSvc7g+3mcj6jUsc2xL
 1/XVi0pMwUb5AkJXk9Lj+cdq2HXILfRFKsCDrTy/n5YUZfn2oBdT/62KhBGh3K3Ibn1n
 IrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763448042; x=1764052842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kOLvYABW607VGNhbGGH6i0LCrzafdHBVhMM2AMxPgak=;
 b=aWB/6YhDJl5KX/1hHYYgBSG5qeK4FH2/O4/M97aAOjIJXWF+n5j84MniobBfimzrFp
 cmx34a1AZkoEKFLbqAIXqt5Xv2Ow5NnPihD1XVtuajPlnrgDXSHzXKJkMagBOR8GVblM
 pj61knUDOH5o8nZKTXgiYshevunlmsJr3kVs/DDAhs7ujKtWD5TUoEVFquJA8xq+wZEv
 W5i4lu4EDho5qWzf62h3xH2ABgqX/u2xwgL+hdW6Pjm06ItyFP46SF5GVzUmp/PcjlyY
 zbWsyZE2PwH61S2MUQwIlZBxEW7Z0on6Bq4LDGGW9i/izFWGrw+WwJTW+1gAPxpLHA52
 ELhg==
X-Gm-Message-State: AOJu0Yw7k5NfwiqRQKCzJr7C1vdgSLh2JUY7LeUmX+CXVg0wmsvb2mIq
 F4hV/7T8yTKGs/Y3GuMN6AUm4Sn1SiO0UkXf6OoDuAozXP7UiThiV+q9u389
X-Gm-Gg: ASbGncvz9UJy0GdzWdXwN84zmARkeykfcraTd0c2H0eT6G5j2b1qbk0n2jEtYdiAcey
 b76f9MU+0ArkI9Fba1pkHPvQRX3CsEbbATOhympPtEgwacnKllyIcyWYiomip/f9NyuQlTtwmHV
 kwABlEHnMEFq5uxI5zH56YJuDw8wHwP8A5JZbwV8pF5pKDe28Mhsg93ePDS/uDJtbbqorQoj/xL
 P6jtjXWcVeGOBNKovqXkBcy0W9JxSyc5xBd+wPgmks+WyCgWcx04vWehoc0heaLSqO+g0AydLJH
 nKSs8AO33W1XvzhQr1muiV2BSqtW9w9jsdx+DIJwxUFEi+FS7qloBZVFY+hr2d2WW/uTtqGai9l
 +NrXddvFp/pV2EgPI5kC/1kozSY/gzv6o0OK2kZx27msuQh1GyGdPtJH4z5V76Ke7sPiZMnJnIy
 lsrgnnHo3Ado4JZJY=
X-Google-Smtp-Source: AGHT+IGFnyKSFQwhg8KYSdwnEVtcldDsTjLxFP2LoyHPe9LKYPVgrj95DPAbumcaBGGqzytPG70zSw==
X-Received: by 2002:a05:690c:6a86:b0:787:f043:1f10 with SMTP id
 00721157ae682-78929f20e83mr247660187b3.66.1763448042000; 
 Mon, 17 Nov 2025 22:40:42 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78822128160sm49781967b3.32.2025.11.17.22.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 22:40:41 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Utsav Agarwal <utsav.agarwal@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Philip Molloy <philip@philipmolloy.com>, Tom Rini <trini@konsulko.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Subject: [PATCH 04/12] mach-sc5xx: Add preliminary support for binman
Date: Tue, 18 Nov 2025 01:39:37 -0500
Message-ID: <20251118064000.14613-5-malysagreg@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251118064000.14613-1-malysagreg@gmail.com>
References: <20251118064000.14613-1-malysagreg@gmail.com>
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


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2460EC36011
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:39:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AED9B81EBB;
	Fri, 28 Mar 2025 16:36:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JrsTTHZZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67F65820A1; Fri, 28 Mar 2025 16:36:45 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3226281E6C
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:36:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3d03d2bd7d2so24040445ab.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176201; x=1743781001; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jlX8KjIZBaugKwayXuUQ0te0SThDsZ/r9HtxNm+9r2k=;
 b=JrsTTHZZnEL4n6V3Tk5mCXkU7zsBWnPeMMW9kJlHOMIxMLoCaYlM2st9OJVBOqpKkz
 2GQjhbxtIOE6mjmZz/zxRPiS3VPPnwrcxQ50kH/ksviKC1Rol7s9fNdUekQ3q4p8ytol
 HLo/eztXKDqhQ17yodloZumddeuWlD6DQ8chI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176201; x=1743781001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jlX8KjIZBaugKwayXuUQ0te0SThDsZ/r9HtxNm+9r2k=;
 b=eMs0E7Ewt8f7vRWaRXb9QoITAr5xDapO/NtjSqCMaNfLEsEe+M+b0A7d0PTiVe/fhx
 2HziX5I/2hjfpIwu/aepsuZP1fXTb1dRifGYO6zTWWWnjXstT4XPBViKGIb3eQvzr4Ti
 mZSFWX5HjY1PmYVqBaHku+69lT8s3nwZ4tkY1gIxBNV2SFjuYQQkvoVmRxveka2DtT/6
 wwot/ULfslZ8bNl2jF8oyI5MU4yIyyIcPw6yI/3wB9qskN5chUYGzrpPEHj3oTLGO89/
 n5kDAL3TejE+wkYFYrdjFiiBoVZVhAH6OaLhYXvwaGMLT2WL7R2rp/tkGqBy0h/4ZIa0
 ctug==
X-Gm-Message-State: AOJu0YyjML6ZWGy2DWakPlcxpVrjX36b5PIkB39U8nNIX55BjcmH7+f3
 dERztkUHDR+l3kgLgw85igB/mWck2kCDzgQ02LWbMRVWJlWZewRXMrrvCvJ6oXd8z1WHXIaKeRA
 =
X-Gm-Gg: ASbGnctI5Ruwj8EffeT5O8T8WKjH1I9N2EhpDz5+Lq1Ppp9dLKBxbN4J2xxYJsJc981
 gjGodrviU8rFPNxHN9QFZPYntvJQtHt6AAZBtas05KaR7//3JuzWPhZd7cMntffwDd4CLHpkRgk
 8stY3WFBwMKHVIJKm8mx4J+rbVClQnhiX1jEO20leqT31OFfvX4vf9dNXbwUf3E7Y82PYdy8WIH
 A4FiaCuY9IMWPDptyzzxtvoMvSsMPEK4hjzeqt2L11qGgTs99M3UrXHgiI5qG0zYGtqR95jnr2s
 HJ61PPETR8SlZw2XNi8jwr2vVCKBqaQ0UhpC5fvttaAtnPEri/FvM25zGj25wOJpjKEyvBUsIoL
 zogkmPFIgc6KGOECs
X-Google-Smtp-Source: AGHT+IG36L6sSM5dnqp/Fy3z4U1IJnDD1FlC9hax4F01LrGjb5xJazCjL/ZgjaO8zVRbTjZG5p6FyA==
X-Received: by 2002:a05:6e02:1889:b0:3d4:4114:1003 with SMTP id
 e9e14a558f8ab-3d5cce1d67cmr71217645ab.17.1743176201120; 
 Fri, 28 Mar 2025 08:36:41 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:36:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v3 28/31] rockchip: Update binman image for new skip-at-start
 setup
Date: Fri, 28 Mar 2025 09:35:08 -0600
Message-ID: <20250328153522.3555472-29-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328153522.3555472-1-sjg@chromium.org>
References: <20250328153522.3555472-1-sjg@chromium.org>
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

Now that the skip-at-start feature is properly used in Binman, drop the
various workarounds in the image.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Split out the fixes for skip-at-start into a new patch

 arch/arm/dts/rockchip-vpl-u-boot.dtsi | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
index 5367a40c543..0ac1bf0a09b 100644
--- a/arch/arm/dts/rockchip-vpl-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
@@ -28,7 +28,6 @@
 			bootph-verify;
 			compatible = "fwupd,vbe-abrec";
 			storage = "mmc0";
-			skip-offset = <0x8000>;
 			area-start = <0x7f8000>;
 			area-size = <0x800000>;
 			state-offset = <(0x7f8000 - 0x400)>;
@@ -129,7 +128,7 @@
 
 		vpl {
 			type = "fit";
-			offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 0x200 + 0x8000)>;
+			offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 0x200)>;
 			description = "FIT image for U-Boot TPL";
 			#address-cells = <1>;
 			fit,fdt-list = "of-list";
@@ -174,7 +173,7 @@
 # ifdef CONFIG_BOOTMETH_VBE_ABREC
 		vbe-a {
 			type = "section";
-			offset = <(CONFIG_SPL_PAD_TO + 0x8000)>;
+			offset = <CONFIG_SPL_PAD_TO>;
 			spl-a {
 				insert-template = <&spl_template>;
 				size = <0x100000>;
@@ -211,7 +210,7 @@
 # else /* CONFIG_BOOTMETH_VBE_SIMPLE */
 		vbe {
 			type = "fit";
-			offset = <(CONFIG_SPL_PAD_TO + 0x8000)>;
+			offset = <CONFIG_SPL_PAD_TO>;
 			insert-template = <&common_part>;
 		};
 # endif /* VBE method */
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C728AC54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 10:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7B1982E17;
	Mon, 26 May 2025 12:16:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RLDCov9S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E026C82E17; Mon, 26 May 2025 12:16:24 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE00182B19
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:16:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3dc83a8a4afso8846145ab.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 03:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748254581; x=1748859381; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DEXEpH2iDoy0QIS7qix2CyBu8B3Wi1GMYLuzYyIux0Q=;
 b=RLDCov9SpHm6UhcmrqDT3xArCb8xz+6u+MIQ4eLmMd+KX8I7Df5+pftl0CjuZ40E6X
 0Ks3J0szCbddQ7bYnW6S8BFG1QgO44NtrpQ+6mieIp9U65Vwwjem9bC5N/ueAO96SUz6
 mweuUug1qKeYBs12VFFnmao03zlBpBmtT2oKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254581; x=1748859381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DEXEpH2iDoy0QIS7qix2CyBu8B3Wi1GMYLuzYyIux0Q=;
 b=dXCIY7AYed+wJ/xeCpnPIeGsZ0aJR7AFel5pjvZZfGd+Sk1jPY9ORG+RkvpOKQ/g2s
 4jIKXm44NkN4Ta9asBEg9EYKhj5k4Rd9t2oISFPzoD4zMEu9d3PwUqJ8lZdyj3V14B/P
 SZeSJgL1xeAygdLTw02Q/mxfeERBdTyQdOWEq8w+zm832IA0h2lBdHqZTZbWU7CDC6aa
 gDC/ciyNSFKq8FJzpq/S3z0KghEAjP9eDoah6efF5sTcATkHIAmTcImPN5v4eksqnpTp
 YpAonHmY8OcZB58WqInkSuFAURnxHmVJo5L6px3zwNPVwukXSAWhg3kmZXBtWC3ZumN4
 AGuw==
X-Gm-Message-State: AOJu0Yxa125XSSHQdGBjl1pdSvb39XUwt1ImyuMNR2XXT6ALJENxgwL/
 e9ESej+IEKIs1Nn+ztvr+l+mKaivYVc6lj06/c1oV+jcIqrDqSMGcf+DLJ8YJ+xkLYmXKCd1eb1
 RS7DE5Qr+
X-Gm-Gg: ASbGncswEIAg9AUI8YWH/Nl15Ij/ZgbZxqQsoSlcPxhoEjnP0vlmVl9Ms5ekqZmEWTN
 vGByxTMAnHKrmGfjyUMNFubkP/uUp+tOeb/UDf8YeP/o4u7RKjt1P1chCm+RbyuQKVcVPammzk/
 yr/Ure7Yr8MOxdfc8kfSJGjYMG+EJ75b9S/Vgn4df+hRIIkhWX9kROaPZFMJwSE8Od/o936ET9T
 sYfIjphvNgNSoC1+uK6tbnftdV+584eyyzmiudmy1DRgZoElRkDHgNhFhj1GS68RvU4jRVIfFTa
 H1//Bt2oVUALRYR550CeEm9uekWgDB1Zi3WqL7B1IwCTp5z2aZuprw1mFUbcIE33KssYSPkHTKQ
 WjRTS1Opq/m9i
X-Google-Smtp-Source: AGHT+IEgeUtwkrauR7oFh4tCD2bmL4PYkQ7bhk5Ks2JplDPjj7lDvCb9iskFVg/rI4mPqQila7ue4Q==
X-Received: by 2002:a92:c0c8:0:b0:3dc:9b1b:bbd3 with SMTP id
 e9e14a558f8ab-3dc9b1bbd0fmr59360325ab.10.1748254580878; 
 Mon, 26 May 2025 03:16:20 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc3b19aasm4679249173.52.2025.05.26.03.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 03:16:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v5 11/25] rockchip: Add TPL alternatives
Date: Mon, 26 May 2025 04:14:57 -0600
Message-ID: <20250526101541.3254628-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526101541.3254628-1-sjg@chromium.org>
References: <20250526101541.3254628-1-sjg@chromium.org>
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

With VBE, the TPL image must be built separately for each board we need
to support. It is the only part of the VBE image which is
board-specific.

This helps to save space and reduce the size of TPL, so that it can fit
within the internal 192K IRAM of the RK3399 SoC.

As with other phases, the TPL devicetree is run through fdtgrep to
remove unwanted nodes and properties and reduce its size.

Update the fdtmap so it is at the end of the image, since templates are
added after existing nodes.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Drop removal of stray #ifdef
- Mention VBE in the first paragraph of the commit message
- Wrap the entire simple-bin node and add the properties to vpl

Changes in v4:
- Put the fdtmap at the end of the image
- Update the comment at the end of the '#ifndef CONFIG_VPL' block

Changes in v2:
- Mention RK3399 with respect to the memory limit
- Move VPL things into a separate file

 arch/arm/dts/rockchip-u-boot.dtsi     |  2 ++
 arch/arm/dts/rockchip-vpl-u-boot.dtsi | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index f1e8f129cb4..7a60f6b4526 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -167,6 +167,7 @@
 	};
 #endif /* HAS_FIT */
 
+#ifndef CONFIG_VPL
 	simple-bin {
 		filename = "u-boot-rockchip.bin";
 		pad-byte = <0xff>;
@@ -200,6 +201,7 @@
 		fdtmap {
 		};
 	};
+#endif /* !VPL */
 
 #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
 	simple-bin-spi {
diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
index 0d767113408..ac67b29c57a 100644
--- a/arch/arm/dts/rockchip-vpl-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
@@ -111,6 +111,25 @@
 	};
 
 	simple-bin {
+		filename = "u-boot-rockchip.bin";
+		pad-byte = <0xff>;
+
+		alternates-fdt {
+			fdt-list-dir = "dts/upstream/src/arm64/rockchip";
+			filename-pattern = "alt-NAME.bin";
+			fdt-phase = "tpl";
+
+			mkimage {
+				filename = "idbloader.img";
+				args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
+				multiple-data-files;
+
+				u-boot-tpl {
+					symbols-base = <0>;
+				};
+			};
+		};
+
 		vpl {
 			type = "fit";
 			offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 0x200 + 0x8000)>;
@@ -199,5 +218,7 @@
 			insert-template = <&fit_template>;
 		};
 # endif /* VBE method */
+		fdtmap {
+		};
 	};
 };
-- 
2.43.0


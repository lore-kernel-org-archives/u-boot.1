Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD65CD4F54
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 17:12:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4205984879;
	Thu, 28 May 2026 19:11:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FKCHmqn4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98F7484878; Thu, 28 May 2026 19:11:20 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78E048341A
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 19:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7df05fc49e5so12724190a34.3
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779988277; x=1780593077; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F3A8Yeq84nluzwvECbxa8Lzu1DynLdGQtiauxEYtJKI=;
 b=FKCHmqn4P9ltyKAJdCL/mWq636w835oTULL4sOeh3Fes8UjiQ9qd9daEFdjQzBd3mm
 qL1bKFN8kpRfMOTu8c6/LfgA4uXFlm2gORxLlH4RcS7bdS4+irlW+JwTTnBkNLb57I33
 be/JRIgQvuAH0dcXDJj/G8d34dBxZXy3m+njA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988277; x=1780593077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F3A8Yeq84nluzwvECbxa8Lzu1DynLdGQtiauxEYtJKI=;
 b=TvpQiuQAb8y8BeVV//hv1dlXTFx5sIF5cskkf+p8AOfZvw7MDtR3Ff6JJtgVr0IRtX
 YS9cy0yGqSOTbq2Wg2FfXDrJhHzrtJUTdMY3tIf+BDxfeKmX0Vmd2ckrr3fbul4aFcOq
 jdN8ZE8Jlx+1MuP6h/kWjt21awYuf/1jKgS1g4os5AxF9mQFBK2cyi5+JtvHuK2T3Tmb
 XDpMe6UaFlTXGRqucqC4dgnH2VdJh51SNvW1Ds06kMb9Q3SeYTIf/i+jmyOU+6u+SBag
 2eqHaAZ2PGnNAZN/4krsYgVKBF/Go72RPamdElsJZIKiZnlkXWvagjJuFz2TRCOJbeg8
 LGjw==
X-Gm-Message-State: AOJu0YwLvu31YUZMmkpqeQA/sNhIWxHfQrellFaREQDHlLqUX+LA/z90
 AJR0Y6b2sjvCsCx9bqM8FN6KKMa2jJyTFUvTa3Fsp33o70G+NbfgoTRnLzMGg8wsFqCHyJ8n7Td
 JocK/Pe1hHlc=
X-Gm-Gg: Acq92OFSd8eeS3w6Rue4A15VwlkrNmwTnIcg74EFzIyFqSOfDj21wjZkU1kwgZZoazy
 lzt2+JxyH1UYCOXYZI6B1Zi7KHFTKaSFM5osAgGBosCnSwcq8wQojvu1HXRQub8s0PfSJjXFdDU
 i4NuJqETYf9M8oRTxMNLuy480+js9mOrjn+VUFs5E+mvHHHoFoF6S1Rfw4YgAUiZRhKOwjWLJWO
 VIl1FHWJDj300pbvwh2ifuHiePjdC2GLb4LZHbU4tNotP9EKU3qgZwcHQPnS1B9uv1EQe5DXkrg
 Kx/H4mHBQF/x68agH44Z7oeuSMgnwMP+GGHOfhxQp3uV5EY9eT7XKacDhGaWgzZ+BwvXM2aYtaU
 uUwRO+1Wn6O0B5u46hHatmvzhSM/tFJknbSR77eKTLBFDpn0Mf+1qonR+Pl8Yi/qMhkupspq/Bq
 C81wEONCnLS+77HbsF5Cio9R0cF5ka
X-Received: by 2002:a05:6830:6a88:b0:7dc:dd58:50ab with SMTP id
 46e09a7af769-7e5fee5e275mr17780111a34.14.1779988277133; 
 Thu, 28 May 2026 10:11:17 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606459dadsm14461068a34.4.2026.05.28.10.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 10:11:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v7 11/22] rockchip: Add TPL alternatives
Date: Thu, 28 May 2026 11:10:18 -0600
Message-ID: <20260528171043.910264-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528171043.910264-1-sjg@chromium.org>
References: <20260528171043.910264-1-sjg@chromium.org>
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

(no changes since v5)

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
index daf4f489d44..7ca2d6d7663 100644
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


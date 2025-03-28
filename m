Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BBCC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:38:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8642B82012;
	Fri, 28 Mar 2025 16:36:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HjuSnPqM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EA9B82054; Fri, 28 Mar 2025 16:36:18 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1BEE81DF6
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:36:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3cf82bd380bso18821985ab.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176174; x=1743780974; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzJVsm9A0YDTbgbSzHUdbk/RiZJzvXhqru7plpKvcQU=;
 b=HjuSnPqMkN5iNE7GXTT+tLjnVFVlV6EKXpw667UA6Amp1WSKvYk6RvcJBATbSt/TWj
 mIqekRp6d5o/UWitaFadIYmuIznI/Ifr/2CFX9xoFAQLT5oeyrYaRdXP8m9wjqnfvrfJ
 XSL8wUInASZJbimuhOAZiffWIdTlvO9TUSQNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176174; x=1743780974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vzJVsm9A0YDTbgbSzHUdbk/RiZJzvXhqru7plpKvcQU=;
 b=gEyl20OhktGsCQzpPa99dL4T8ro5KKr/YuOMSI9bDmcsYa1+e1SXPxcKCRHh1fSPKo
 Ae7pEGBy5oP5ySqNYm9myCRXVqxtDfKpQZtYIGnGn7a2WvsyjhhBAs5k4P/CyDu9ceR0
 Z1rZ0VavTIxwjEOHb8AMuGjcmJO9FnoDCmdtGJHuph391SjFaSP4uPuWiC8L46eXFnnQ
 0RbvrG12ub+BY4AfB2mwx47IVpreo54ecth4cXJ7edoPBpWzSPphaoTTKuaFywRniT7B
 xHaRLvV9g2RLpiiSpV7P7YS+XDqGAKUHF135MPzU3vzxjD4DVvZi/LRyofrQvEZ5Wo5X
 /4Xg==
X-Gm-Message-State: AOJu0YwAPZ9u0HR5VUP9EkObBPYqB1xTqarOaa13ZzjuWqq0Rm/XvbND
 DwCmNGFfSp0HrBChLSWzR0Z/xQH3VBPwYWETO//Wgv2XLto2LyyLg+uaSvoQP500W/di3xhEIEI
 =
X-Gm-Gg: ASbGncuiesRoHtL/O9IP9UntaBurFdyfe2o8cR1cDWE7YY5xJ2Bd6X8M7vWunxuZ1fo
 WDva2X/jcGDShJAH5A/+ZbLFP21nItLzny19p4cFQbPNwxTF9kYYauERK5cahoC50fAoL3T5Zxe
 +EOCSamYqGjmw+jU8B0l8/jj+KIzXpIcsw3tJfJAXSIwKKKDxq3ptfRHi6GsgZ2yVMeNldCzrWH
 yftQFTGz88NrZt4XcDjshePKVRqHdaB4vyhHJ7Rkm6WpwvWlGTkpIIaZh2unqQrLIMUyOG8KKhf
 bBFaMrwggqFyfPt/RhKEn3pmeBUbBI7tv02qR+zlZyou/EtNZnz7D0bw9N5tkJ3p3skmYGTtIM+
 ihPaE0NGzgOHCmLmD
X-Google-Smtp-Source: AGHT+IEPbeOM5YNqRei4J/iPicqmMsYpmCQbqXS9N3N32cjkB35Lae5LjPLIzU7HBu8sFpdZHgu0XQ==
X-Received: by 2002:a05:6e02:1a29:b0:3d3:d229:f166 with SMTP id
 e9e14a558f8ab-3d5cce19191mr70374145ab.17.1743176173729; 
 Fri, 28 Mar 2025 08:36:13 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:36:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v3 17/31] rockchip: Add TPL alternatives
Date: Fri, 28 Mar 2025 09:34:57 -0600
Message-ID: <20250328153522.3555472-18-sjg@chromium.org>
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

The TPL image must be built for each board we need to support. It is the
only part of the image which is board-specific.

This helps to save space and reduce the size of TPL, so that it can fit
within the internal 192K IRAM of the RK3399 SoC.

As with other phases, the TPL devicetree is run through fdtgrep to
remove unwanted nodes and properties and reduce its size.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Mention RK3399 with respect to the memory limit
- Move VPL things into a separate file

 arch/arm/dts/rockchip-u-boot.dtsi     |  2 ++
 arch/arm/dts/rockchip-vpl-u-boot.dtsi | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index ef1f24fe29c..366d52de4ee 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -159,6 +159,7 @@
 		filename = "u-boot-rockchip.bin";
 		pad-byte = <0xff>;
 
+#ifndef CONFIG_VPL
 		mkimage {
 			filename = "idbloader.img";
 			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
@@ -184,6 +185,7 @@
 #endif
 			offset = <CONFIG_SPL_PAD_TO>;
 		};
+#endif /* VPL */
 
 		fdtmap {
 		};
diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
index eee57db5478..5367a40c543 100644
--- a/arch/arm/dts/rockchip-vpl-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
@@ -111,6 +111,22 @@
 	};
 
 	simple-bin {
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
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EA4C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 10:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 607E88382F;
	Mon, 26 May 2025 12:16:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mUV/LSWp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5BE98381D; Mon, 26 May 2025 12:16:44 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8402E837E2
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3dc6f6530c5so18227325ab.3
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 03:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748254601; x=1748859401; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9z/5xaUsd6ArDfS8NrBKcYvKGIdVU80n5QQyKGG8BMA=;
 b=mUV/LSWpmnpxqLFQyqW28dyDafI2c/k5P89vFefrR0A7k1jaVGcRhdmRwWLF1HXAm3
 fFEX7Enp5jM2Ve0qzhHbRXHTRTTDE928FAXOso1FGDcDqZSgn7seV/PIVgkUCYeRbpRf
 nXXN4cX41xnnxOf6uOI7/cigl0v8lqqwy8Ozc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254601; x=1748859401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9z/5xaUsd6ArDfS8NrBKcYvKGIdVU80n5QQyKGG8BMA=;
 b=NRpDoD9dSWgByU3YOlMtEMSCc64ZqwQb6NE1whJK5Hn0vT1pwWQdxyfi5T8+okGplG
 Elf1H5ebc2kqYBALPT6Vl2fv50Zff91YXoyQRYLjhpSKvegV9CC5p/lNh3OuwobmoPro
 2XFS2Qczin4VF6PY9+1sy2f0GGmBhdmFjMuMXIvF1Goqun7qBxNO0dioP0qUhII50sKw
 Rb+ub6AxcqEOebjMJaZqavf7TlN73fjOZa8NFSRQizau4KNwSgvBiLybGiMrP5mpPFSG
 ClIPDtrMcPUlCPU8cknji+o88XYJo52DhVRVIIq3qRA3lBw0aHsnLmK6NmVGauh2soFb
 fAIA==
X-Gm-Message-State: AOJu0YyImAH7AD92dD9zqT0dpGgvPHWF8VGSg67VsB0SaTmA9QbeiAA8
 b5gnUrHNA51pHm6GOMadT7BOoGGqF9kVXmiU2TuNJtryFS137/mxGiKCGPBzino4S2QD5hs2H0k
 BWR/DrrDG
X-Gm-Gg: ASbGnctHO7a8MTNS6KOPE3u4f72NBkrBTuR4pV5QOsF0HD7+yNiocyw3aJddXVixREW
 tqGqOVYD6hR3HDIemQurI9oieunwR7fXpOMA7BvertVSzgxQzYM1U1n0TFPW75LeIYBWkv6dHYm
 zOe3/YHek/ihO1ArxTRVon8/o9FMXcq3NOP/+k2hv1WXQOxx92bMdIPgitZqmHOcVsAsvYkQIFO
 WJME4gnjdQhiUJMqhc3AEmvN2HWdNdycpkyVlok80H7GSd+LZGJBi6QLVx6G7as7HCBhxjV5a/k
 o3pLTtU5g3OF5610Tdkyk8rKDiMKchuGbUQj6z/NFnsHe5yAeTjr0VLewZlPBVhwmiJd/NJwgaX
 flPPQyVE+3OoL
X-Google-Smtp-Source: AGHT+IGJsEykambjqdt/btzh/GfxJ5hihebwa9kQfxAa0sYJko+ddc0Docr/r8y2vdM9/dDC1Q50vQ==
X-Received: by 2002:a05:6e02:1aaf:b0:3dc:88ca:5ea4 with SMTP id
 e9e14a558f8ab-3dc9b68dfeamr72276895ab.8.1748254600690; 
 Mon, 26 May 2025 03:16:40 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc3b19aasm4679249173.52.2025.05.26.03.16.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 03:16:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v5 22/25] rockchip: Update binman image for new skip-at-start
 setup
Date: Mon, 26 May 2025 04:15:08 -0600
Message-ID: <20250526101541.3254628-23-sjg@chromium.org>
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
index 66dcf36010e..63e6a5416c5 100644
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
@@ -133,7 +132,7 @@
 
 		vpl {
 			type = "fit";
-			offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 0x200 + 0x8000)>;
+			offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 0x200)>;
 			description = "FIT image for U-Boot TPL";
 			#address-cells = <1>;
 			fit,fdt-list = "of-list";
@@ -178,7 +177,7 @@
 # ifdef CONFIG_BOOTMETH_VBE_ABREC
 		vbe-a {
 			type = "section";
-			offset = <(CONFIG_SPL_PAD_TO + 0x8000)>;
+			offset = <CONFIG_SPL_PAD_TO>;
 			spl-a {
 				insert-template = <&spl_template>;
 				size = <0x100000>;
@@ -215,7 +214,7 @@
 # else /* CONFIG_BOOTMETH_VBE_SIMPLE */
 		vbe {
 			type = "fit";
-			offset = <(CONFIG_SPL_PAD_TO + 0x8000)>;
+			offset = <CONFIG_SPL_PAD_TO>;
 			insert-template = <&fit_template>;
 		};
 # endif /* VBE method */
-- 
2.43.0


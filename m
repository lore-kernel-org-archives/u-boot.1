Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3637C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 10:19:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF80C83824;
	Mon, 26 May 2025 12:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lc3y3STc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DAAB8382C; Mon, 26 May 2025 12:16:41 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CDF482B19
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-85db3475637so81497339f.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 03:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748254597; x=1748859397; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tqIX2AU6NsdUdkAYSzL5wfNfum9Ytmkg88BhKz5qtRo=;
 b=lc3y3STcfs+1ET1pbwqQnNA8HuPuT43NibDtEAzHSxFUy9umam2Cq7gb9IVhbL65ED
 HKDFl/wPyzBu7hXN+oU0g+HGfav6U+dIs0jcy9Qhc0R0ySynqOQl3hEeHW1Gm91BnSpc
 Kyj+htgbRnzkbdI4wtXB+H76hLfcL1XTp7GG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254597; x=1748859397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tqIX2AU6NsdUdkAYSzL5wfNfum9Ytmkg88BhKz5qtRo=;
 b=Od80e9nsc2yxvWZ50txhr+FBjGT5PKkWzvKQ8QF+h8hl3sZFnT9ASZ1e6xhqM5HrBX
 87r3xpxv4IZxwMtYcIjny3mVF2f2suTl8sTX6+QD3FDnpl/vZZPcuYiW1dSK6HJPaF5l
 EWbz2Af7QKLzbS1SN2QnuWHrdYLaXSdl9aqfP64WkNb9hXwGwJX8F8tkbzs5j1AwSWmZ
 f/Ge45AuXnukD4O6Fo1ARgm8zOazWG1s/aNQ0J667+TWYW1+HbzxSAllrM4waUUiLP/g
 Z4RZjCA+ZSWRFH2+9b4J9ZzUBNDP2iMj87Ak8trc3cnmMbtPC9ZlT2j9Ki6pw4soCkql
 sF6g==
X-Gm-Message-State: AOJu0Yx40kwpW+049Vj3C5rJ01uNANAqvGLcQKQtnbLGOxLGb4A3HTgm
 LUZzl8/QGdDYjKWNi7a0AWn4PgdWaG9NYBU5sAKIcMf1h/VdjoqRicwmv2ssHdlT5/TMTyRthJn
 g6zb7mu/m
X-Gm-Gg: ASbGncvKGfDX3jW+xQQ83EF/aiS1FD6Iz6GFRpM9TgZqM7lKJU6iEE4yIdJrTV0D4Z3
 lmU6Xqo6H7hNPMyE34AlCWT1yz16+7abawQr3h/SWQuH8p1YJB0eR58ZytonPfgyWm3oxvLNn6d
 D5A5hYp6yysjbm6BVEfUb0NroYP77u3mCFbbpSzSigMo2zt5fqai7CgXgKxIzriW3Z1IIcRK6tx
 G18q+7l1p9Ij+yaW2CxXXlEtgmgTyRp2r/WdtkfldXkc/paSTcBUexlZwxELwvbjhwyX/bRnPlI
 vha168jMwZLiP2s0gvhDJ5KPYV9Dc8H2jt/JoX00Z9sXYnh9C5RDJj4fuKJTvmVItsGYdS88Oz8
 x98wSNUDUE4/p
X-Google-Smtp-Source: AGHT+IGDeJKxwigehcCJz4qHKpXlv0a2btqRrZKb7mxwAVwTB/AF2W8nFI1Bd7KDw2mmcOOg5KLk1g==
X-Received: by 2002:a5e:9406:0:b0:85e:73da:c56a with SMTP id
 ca18e2360f4ac-86cadd606c4mr1000607139f.3.1748254597466; 
 Mon, 26 May 2025 03:16:37 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc3b19aasm4679249173.52.2025.05.26.03.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 03:16:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>,
 Greg Malysa <malysagreg@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Peng Fan <peng.fan@nxp.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v5 20/25] rockchip: Set the skip-at-start property correctly
Date: Mon, 26 May 2025 04:15:06 -0600
Message-ID: <20250526101541.3254628-21-sjg@chromium.org>
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

The rockchip image is written to the media at block 64, which is a 32K
offset, so set the skip-at-start property to 0x8000

Update CONFIG_SPL_PAD_TO to point to the offset in the image, since
Binman is dealing with the 'missing' 32K now.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Add to VPL file also

Changes in v2:
- Move this patch to the end of the series
- Drop 0x8000 offset for SPI

 arch/arm/dts/rockchip-u-boot.dtsi     | 1 +
 arch/arm/dts/rockchip-vpl-u-boot.dtsi | 1 +
 common/spl/Kconfig                    | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 7a60f6b4526..3ff75c07121 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -171,6 +171,7 @@
 	simple-bin {
 		filename = "u-boot-rockchip.bin";
 		pad-byte = <0xff>;
+		skip-at-start = <0x8000>;
 
 		mkimage {
 			filename = "idbloader.img";
diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
index ac67b29c57a..66dcf36010e 100644
--- a/arch/arm/dts/rockchip-vpl-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
@@ -113,6 +113,7 @@
 	simple-bin {
 		filename = "u-boot-rockchip.bin";
 		pad-byte = <0xff>;
+		skip-at-start = <0x8000>;
 
 		alternates-fdt {
 			fdt-list-dir = "dts/upstream/src/arm64/rockchip";
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index fb6c90733ee..fa28c18fa48 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -96,7 +96,7 @@ config SPL_MAX_SIZE
 
 config SPL_PAD_TO
 	hex "Offset to which the SPL should be padded before appending the SPL payload"
-	default 0x7f8000 if ARCH_ROCKCHIP
+	default 0x800000 if ARCH_ROCKCHIP
 	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
 	default 0x11000 if ARCH_MX7 || (ARCH_MX6 && !MX6_OCRAM_256KB)
 	default 0x10000 if ARCH_KEYSTONE
-- 
2.43.0


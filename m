Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA6CC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 13:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48FDD88A21;
	Wed, 31 Jul 2024 14:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fPXrLJ3d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0239889D9; Wed, 31 Jul 2024 13:49:32 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF054889C1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 13:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=islavaivanov76@gmail.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-450217eaa62so21737451cf.3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 04:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722426569; x=1723031369; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WOfvm6rf3ugMOQEwqj2yIwrAefBWgstu0cKYjusTxMw=;
 b=fPXrLJ3de3cATWHCCtd5smY1bFh7coxEs9xQbl0HN1vP8a0y3CQKx/gc8znMflLnd3
 jbWVsLE8ZIWGGaBFymHqyvKjSqxnxqy6IkNvhDM45jdJmbF8FqQkc8POxGDlDPtBjsFm
 AwMH4aADv1HJDGsPIpyd35uyMV4ZjYg/zMXx1lIAlp0H5JjFz/qN1qdAe5qI8gF0uYRh
 7RUp+q/rEyoDhokFsfOq/5mdBr9goyK4CpbWMeZpdae26YZMZZbAoxieL7nIkZ8OnZ4k
 rg4htDzHtb0w84FU4drcSEKPBhDmxwNvvssX1Gju3h0ouTmHD8IA6WcjSwTGfmr64kje
 XWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722426569; x=1723031369;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WOfvm6rf3ugMOQEwqj2yIwrAefBWgstu0cKYjusTxMw=;
 b=jxu/9/OaWTfCzC2I6Asrv81MHq7kVK/4kdxm8oW7/I8UkeOYen+0ioLyHdoTvGtwcK
 iAh60YJKGV5aSpenEuTydzEKDK1SgR6m9/J/nNkxFyvIqyThVqDcVajeiFa1Qcqytu0Y
 vRD6q25iLcFEyGqMbp/5SfGjSkUXAvwpMBF8YFDRXZzlybd+gW3hDVr5+6r9kL6CKQbc
 5sL/WIeGi9XJv5j4ZMtbAnwsPk9mbFRzYzIG/QOKeVwqmRQHjUtdslN6s+9psrb36SOn
 oRZONUu7tPy2GfmMY24IECNB1HLoYG0e/ZazzNyL9qU+0RtxXcWnN7La3Ya+/K4q4Xc2
 uLbw==
X-Gm-Message-State: AOJu0YyvZQy/3/W8hKXbou+ks9JgduOYVH+7ytsUbdGbNAQakE8k2NZp
 0spOkZzXi3nA1R6T9NpcehPZLs+2JvlNXxf5HW6BpjD0893Uo+EipV3NolQVqDJdSjTprCr9ns+
 k4p0mFwSW1tlmXehnczzeQmNLCBtrxnteJZc=
X-Google-Smtp-Source: AGHT+IHKvNRkOiyWiAIw4vD4lymEQkOkiSbpdtrLwrJ9fCaZHNxmxQr5wq0fR0Q6SOVxT3d0u89abrJyb4TprSaPxVY=
X-Received: by 2002:a05:622a:1b22:b0:447:e381:9ad5 with SMTP id
 d75a77b69052e-45004db0631mr167411931cf.5.1722426569286; Wed, 31 Jul 2024
 04:49:29 -0700 (PDT)
MIME-Version: 1.0
From: Pugemon <islavaivanov76@gmail.com>
Date: Wed, 31 Jul 2024 14:49:18 +0300
Message-ID: <CACS4SE=VOJ9uHvG=mnWtR=9g_xAqgtfyf3MjE=RDJBdVEFxvzw@mail.gmail.com>
Subject: [PATCH] arm: dts: orangepi: Fix Orange Pi R1 and Plus LTS boot issue
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Wed, 31 Jul 2024 14:59:20 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Orange Pi R1 Plus and LTS don't have eMMC
(default mmc0 in rk3328-u-boot.dtsi).
The device is equipped with SPI flash memory, which U-Boot tries to use for
reading configuration. However, the manufacturer has not provided any means
to utilize SPI flash memory. There is no documentation,
or software available for this purpose.

As a result, during OpenWRT sysupgrade, the board fails to boot because the
script that switches the boot_device to an available one does not trigger.

This patch changes the alias of mmc0 from &emmc to &sdmmc,
ensuring the board boots correctly,
and sysupgrade completes successfully.
Additionally, this allows saving the U-Boot environment
by using saveenv with uboot-envtool.

Signed-off-by: Pugemon <islavaivanov76@gmail.com>
Cc: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi | 12 ++++++++++++
 arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi     | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
b/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
index b50c1332b8..7063b188f2 100644
--- a/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
@@ -2,11 +2,23 @@
 /*
  * (C) Copyright 2018-2019 Rockchip Electronics Co., Ltd
  * (C) Copyright 2020 David Bauer
+ * (C) Copyright 2024 Pugemon
  */

 #include "rk3328-u-boot.dtsi"
 #include "rk3328-sdram-lpddr3-666.dtsi"

+/ {
+       aliases {
+               mmc0 = &sdmmc;
+               spi0 = &spi0;
+       };
+
+       chosen {
+               u-boot,spl-boot-order = "same-as-spl", &sdmmc;
+       };
+};
+
 &spi0 {
        flash@0 {
                bootph-pre-ram;
diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
b/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
index 8ae003bbef..0374172527 100644
--- a/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
@@ -2,11 +2,23 @@
 /*
  * (C) Copyright 2018-2019 Rockchip Electronics Co., Ltd
  * (C) Copyright 2020 David Bauer
+ * (C) Copyright 2024 Pugemon
  */

 #include "rk3328-u-boot.dtsi"
 #include "rk3328-sdram-ddr4-666.dtsi"

+/ {
+       aliases {
+               mmc0 = &sdmmc;
+               spi0 = &spi0;
+       };
+
+       chosen {
+               u-boot,spl-boot-order = "same-as-spl", &sdmmc;
+       };
+};
+
 &spi0 {
        flash@0 {
                bootph-pre-ram;

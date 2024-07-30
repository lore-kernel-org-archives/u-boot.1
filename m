Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB25C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 12:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEBD188A03;
	Wed, 31 Jul 2024 14:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nUB2HlW6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95561887B9; Tue, 30 Jul 2024 22:55:14 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CDBA87A55
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 22:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=islavaivanov76@gmail.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-447d6edc6b1so23304061cf.0
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 13:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722372911; x=1722977711; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tPx4ozDDToQf9KIl0SpIi2GImzRHbulp7LuGKoic/No=;
 b=nUB2HlW6UjnAVkOStlEEo0GtMieIirlq9IxRow3jaEPLmy0Qd2WMQRueC/H0yJD5rn
 EXryQh56b5Uj2QIM4kqE9jUknRYROXo5VLtwImbDbaJp78O7UCB7rJ4sbjlNOPOhtDnF
 tNtAdt/2yjNOKExsIhI/Xti5E8JT03Or0JHK0f7FAmfKjXtTrRse/Rbd/caap7QNtwZF
 i2RAx+Iyv1siXQgJVIjQ13RICSGco7/VFekusyIHGSYXbSmcsRdpu1eB4/ahyz9T371r
 dVmn6wHwwLIxz3niRF77k9rC67UlfksMX9gYmkUsJrTAm+MXVZyDmGDm15LOlGpiVVXh
 Wk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722372911; x=1722977711;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tPx4ozDDToQf9KIl0SpIi2GImzRHbulp7LuGKoic/No=;
 b=U4d/ssVcLArLEnT21yntsPc0Ci/5F35F5YJQLxX1bkVpY6jFxohFe2K88W4GJG5qO3
 ZERE4ExPYrcGL+kyZRfZkVLgYO5rjqvwT8AinVhywrhXSPPrIJEg+lN3AqpeJ2Ou9h3L
 eOjH4QOjYgYjwZ4cuilnDNEMVYa3MLKO9I7EZdiO4MXS2t9txOFxuckvWXcGW587qYAR
 Mo3Yxl6WB64N4kxHcMEDF6xY961ad0QHIPU/O+tie5vu6/WdOiXGuVoAz/cNgvRm1yEp
 LCYaGh2xbe1xf744yEDKDwNf8xdBYdJ6ut95KHp7CicKt+yaOal+AiABZlwF2v/L7+WN
 EEdg==
X-Gm-Message-State: AOJu0YyaRPBy/mtq1/NPzbEBJ6nTtyv9Jcf/nWYlsoFRW9SPqEud8PiS
 +3iPQv/iN8KzimyCXxFNjICvvjKEnlBdv5BKlY3XEFUQzM0WzBb5X6weWX0pkZCuwarPHbzx/BU
 T/Pa+Zw089OGmbBtOf4hh8jzdbB/lyOW6Y9w=
X-Google-Smtp-Source: AGHT+IFdmsJhDb4r5cHdzKUXlZVY+o7z8NetZZuEvlba2gXFjoPL1MgkCYwA7WJ4scsHCVdcthInXAV503eNecyMsR4=
X-Received: by 2002:a05:622a:30c:b0:441:6021:df43 with SMTP id
 d75a77b69052e-45004fa6ff7mr154946701cf.62.1722372911018; Tue, 30 Jul 2024
 13:55:11 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?0KHQu9Cw0LLQsCDQmNCy0LDQvdC+0LI=?= <islavaivanov76@gmail.com>
Date: Tue, 30 Jul 2024 23:55:01 +0300
Message-ID: <CACS4SEmxUC_LLudMH9ErFEyaE5+MQGnsMdzvkvRGNWeih7v+_A@mail.gmail.com>
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

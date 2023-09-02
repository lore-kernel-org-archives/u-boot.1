Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B974C83F2C
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 16:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0F8F867EA;
	Sat,  2 Sep 2023 18:32:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AlNjQB+8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7AA9867F7; Sat,  2 Sep 2023 18:32:19 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D18CB866CF
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 18:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer+oss@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-401bdff4cb4so998385e9.3
 for <u-boot@lists.denx.de>; Sat, 02 Sep 2023 09:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693672336; x=1694277136; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=W+J552DO1hGn7NUA77QrXAQY5FgjoXHKdzYIaMfJpw8=;
 b=AlNjQB+84IE6r2gkkVQ4qSpdNCNXYndTOfu1yLcnNqpVYLkk4sXGeUqZ8DabTgDEGX
 Tr6MAqI4sTP6/zU7l9XGkwqw9h1ML51+c5uZsMEvy/+W1eix4UXdFz5A1hpV9xxVKXkz
 7k/Q/qwfJsWEoi3xVgmFQKmjK7n3qIQ2Bkell1ovVjzBS8HvBxsAAJNAuxHA8eNkj74m
 84JJL/LthAWtxySc932fCBK1pVNT0cy2Ogd+2JZZj6LHunfED/G3savBW76OTZI04YR0
 WAh7x/EKjFtqd36bL0TKGGCk0rZPpqftiztw+9Mv3R8ni392CfbYQxWP5nTLZp07OIUk
 +YUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693672336; x=1694277136;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+J552DO1hGn7NUA77QrXAQY5FgjoXHKdzYIaMfJpw8=;
 b=kvi5UMd3tb35JtkWBoHJC3zN+p0FMVT3tF9E2jgwg67msp0+HTzgaX08TkmdifgkRp
 4M1q9gAqOdClgSfLp9j7z2//gi++ZvMSu4upfhjmM1SlYiyarHeKQFgMcBHCeJDyaxZl
 eCY8OFanmJ+q6Xz4m+QtH8+WWBZ2ltXn+ryJWxupiuIM02t2fN8iQILbSDhuQ27QaLMk
 6gPm9wxXvWAkS4eheph8gtMJs+dPTpYXzWKXYOVoyngDbZ3s2VRMjD69izEgPP03qJZq
 B/dP22868n58fS9Dwx8qHWePVoruMIEVtmJBzYlgQ7pJOSaRysGcJpOp0Dy36iGBSliX
 rGPQ==
X-Gm-Message-State: AOJu0Yy/k+fYyTvB0iIDJ6QGm/y6mO4/A8KJlP+9TewIQJJhDv77iZzi
 hb2fOuWB9Iw8QPPPgXmqXZ4rXtPtWk9NxA==
X-Google-Smtp-Source: AGHT+IHRiHSie4XryPmED6iZtG5tOHV3knjkKaPoXIh+kbrNBfToQBqeTu4Ptepol7R4BAHLhSxTOQ==
X-Received: by 2002:a5d:510c:0:b0:317:18a8:5fa1 with SMTP id
 s12-20020a5d510c000000b0031718a85fa1mr4332759wrt.69.1693672336239; 
 Sat, 02 Sep 2023 09:32:16 -0700 (PDT)
Received: from pegmas-T15.fritz.box ([151.71.185.187])
 by smtp.gmail.com with ESMTPSA id
 a28-20020a5d457c000000b00317f70240afsm9039552wrc.27.2023.09.02.09.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 09:32:15 -0700 (PDT)
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@edgeble.ai>, FUKAUMI Naoki <naoki@radxa.com>
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH 2/2] doc: rockchip: Update and complete info about RK3308
Date: Sat,  2 Sep 2023 18:32:12 +0200
Message-Id: <20230902163212.343746-1-massimo.pegorer+oss@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Update documentation about build steps for RK3308, using an external
TPL. Add RK3308 case to rST document. Add ROCK Pi S in the list of
supported boards.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 doc/README.rockchip             |  4 ++--
 doc/board/rockchip/rockchip.rst | 10 ++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/doc/README.rockchip b/doc/README.rockchip
index 52b5140eca..cfbd858c3b 100644
--- a/doc/README.rockchip
+++ b/doc/README.rockchip
@@ -38,16 +38,16 @@ Building
     (or you can use another cross compiler if you prefer)
 
 2. To build RK3308 board:
+
    - Get the rkbin
      => git clone https://github.com/rockchip-linux/rkbin.git
 
    - Compile U-Boot
      => cd /path/to/u-boot
      => export BL31=/path/to/rkbin/bin/rk33/rk3308_bl31_v2.22.elf
+     => export ROCKCHIP_TPL=/path/to/rkbin/bin/rk33/rk3308_ddr_589MHz_uart2_m0_v1.26.bin
      => make roc-cc-rk3308_defconfig
      => make CROSS_COMPILE=aarch64-linux-gnu- all
-     => ./tools/mkimage -n rk3308 -T rksd -d /path/to/rkbin/bin/rk33/rk3308_ddr_589MHz_uart2_m0_v1.26.bin idbloader.img
-     => cat spl/u-boot-spl.bin  >> idbloader.img
 
 3. To build RK3399 board:
 
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index de9fe8e642..b38c3d3136 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -53,6 +53,7 @@ List of mainline supported Rockchip boards:
      - Google Speedy (chromebook_speedy)
      - Amarula Vyasa-RK3288 (vyasa-rk3288)
 * rk3308
+     - Radxa ROCK Pi S (rock-pi-s-rk3308)
      - Rockchip Evb-RK3308 (evb-rk3308)
      - Roc-cc-RK3308 (roc-cc-rk3308)
 * rk3326
@@ -172,6 +173,15 @@ To build rk3288 boards:
         make evb-rk3288_defconfig
         make CROSS_COMPILE=arm-linux-gnueabihf-
 
+To build rk3308 boards:
+
+.. code-block:: bash
+
+        export BL31=../rkbin/bin/rk33/rk3308_bl31_vX.YZ.elf
+        export ROCKCHIP_TPL=../rkbin/bin/rk33/rk3308_ddr_589MHz_uart0_m0_vX.YZ.bin
+        make evb-rk3308_defconfig
+        make CROSS_COMPILE=aarch64-linux-gnu-
+
 To build rk3328 boards:
 
 .. code-block:: bash
-- 
2.34.1


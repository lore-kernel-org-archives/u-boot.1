Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6E7C71153
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 16:32:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56BBA8675B;
	Sat,  2 Sep 2023 18:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ltomal9o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0851866CF; Sat,  2 Sep 2023 18:32:06 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 649938678A
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 18:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer+oss@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2bcc846fed0so494101fa.2
 for <u-boot@lists.denx.de>; Sat, 02 Sep 2023 09:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693672324; x=1694277124; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=asHoNLRODyqSYEP0cca1KRbOc7R5RMvAwep+1IQjWhk=;
 b=Ltomal9oOtQIhsllAfdYWBmlu+MeaXbzJsh0lhs6+CziEx19sO8i/vDPYddWBk/yD+
 NhT5I8anZvbREhGTfSDD/0/CmwCCRlx3BPbfuybmYmVv6NHpcsJXFgHHY6qnQZmiB1Ay
 q0iWzMq1DgOrAHG7cxcUFu1ugjbbNS0J7qnfsebWeFEOAbYwynRkVjB4t++rF8mj7SxV
 YaS3fdKpSvsoovlK+KSO1NjmvzdvOnl+0iiYSUY6zZXudBKEkqjXY/lsGEOX0fOJIcmF
 TZ0D5KbLmu2qk3M1MkfHMC2TvT2SJCBhWDtXzoEdGk9xMQf0sxk1uTII7DbqSovClOUm
 yfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693672324; x=1694277124;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=asHoNLRODyqSYEP0cca1KRbOc7R5RMvAwep+1IQjWhk=;
 b=HqKuDY5zzWG9rloPxwIKSzSHZ/oesKJzwL8VWTkRrXR5vtxs3X8uyMsJD59sHG2+t+
 UV/w1HkCy9YVwb6ZnSHq5c00i+yRdZzcbmxDxhSVE6BrR/OendgxgHVK4SpbS31XavdS
 7J/hHpNX2geN9212Td4S3R9P9bjx+bcGhYSz9K4T/zqcKqXF866gbYLIlA85/tNEh/sP
 oiyxbq+6QsGBLhqx6eMrUJg3kwP3aSgeNKCeZegAk4ulk+GmvMmKdIg2MXJ0aocXcLxG
 gJ/YxPOpOiAA9LNPwGnIZmw0u4V3xwhytK2RvOp1SlAbBSgY4PIWE/md45HKNBYLeBgq
 Trcw==
X-Gm-Message-State: AOJu0Yx6ydyJ4JsofmTj52M8WZHeYGMCwcXM91NXhIeqQZFWHRlySkMZ
 P2uHqNfa2vqrieESdnTsLqP/difS/2435A==
X-Google-Smtp-Source: AGHT+IFGYYpvnLjbzr5r65NGYDyEleroUjTOT1hFVCmAlI/YD8bgnqXhp90NjFKBYBUCwItp4h9zBA==
X-Received: by 2002:a2e:86ce:0:b0:2b9:f13b:6139 with SMTP id
 n14-20020a2e86ce000000b002b9f13b6139mr3972275ljj.20.1693672323427; 
 Sat, 02 Sep 2023 09:32:03 -0700 (PDT)
Received: from pegmas-T15.fritz.box ([151.71.185.187])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a05600c1d8300b00401e32b25adsm8650034wms.4.2023.09.02.09.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 09:32:03 -0700 (PDT)
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@edgeble.ai>, FUKAUMI Naoki <naoki@radxa.com>
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH 1/2] rockchip: Use an external TPL binary on RK3308
Date: Sat,  2 Sep 2023 18:31:59 +0200
Message-Id: <20230902163159.343716-1-massimo.pegorer+oss@gmail.com>
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

There is no support to initialize DRAM on RK3308 SoC using U-Boot
TPL and therefore an external TPL binary must be used to generate
a bootable u-boot-rockchip.bin image.

Imply ROCKCHIP_EXTERNAL_TPL by default for RK3308 builds. Remove
useless TPL_SERIAL.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 arch/arm/mach-rockchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index a279582f4f..e8584de258 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -159,6 +159,7 @@ config ROCKCHIP_RK3308
 	select SPL_ATF
 	select SPL_ATF_NO_PLATFORM_PARAM
 	select SPL_LOAD_FIT
+	imply ROCKCHIP_EXTERNAL_TPL
 	imply ROCKCHIP_COMMON_BOARD
 	imply SPL_ROCKCHIP_COMMON_BOARD
 	imply SPL_CLK
@@ -166,7 +167,6 @@ config ROCKCHIP_RK3308
 	imply SPL_SYSCON
 	imply SPL_RAM
 	imply SPL_SERIAL
-	imply TPL_SERIAL
 	imply SPL_SEPARATE_BSS
 	help
 	  The Rockchip RK3308 is a ARM-based Soc which embedded with quad
-- 
2.34.1


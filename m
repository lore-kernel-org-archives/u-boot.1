Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFC9EEB57F
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 09:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9659B86564;
	Sat,  9 Sep 2023 11:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VbW1fps8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8181F86564; Sat,  9 Sep 2023 11:33:31 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2EF886552
 for <u-boot@lists.denx.de>; Sat,  9 Sep 2023 11:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer+oss@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-401c90ed2ecso29950735e9.0
 for <u-boot@lists.denx.de>; Sat, 09 Sep 2023 02:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694252008; x=1694856808; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=nt1skYGfyuCnjKgVTjYoAKKorPWX04bcFrut3/581Fw=;
 b=VbW1fps8P1BpJ5x+ds/QhWEqCcSKtA1TdjONbkx9ImZfvqrzq8ooaaW24qsCNXclX+
 k6DVVtL3WDXSQHqRP6lZ+eykB5z+kdG1u5jS9pLyoMRgluRCvOVN7jBJDFVDWBP66a+u
 A9eQC6Op9W1lugZrhvhQJ/9Q0oh857DTR9nv/up7zkrrsDRPrERVzYtcrG2c/6lm33+N
 3VXOjxW73DNFj/UNIYRxJzod7OYnyVI+iVDhdoglVdWeD8SEnq3M+5Nkdp8t12ECsbwh
 lTLP19Chv3bU/5gi1IsoZp3WdJYd1krv9r9FGgj4h7dp31GA4fIG9VWdfddqcvotgZp/
 Sspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694252008; x=1694856808;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nt1skYGfyuCnjKgVTjYoAKKorPWX04bcFrut3/581Fw=;
 b=b71jgeGhiFfx+AWi2O8CA8W+kTaVq24eIQojVHVG/aLqNQKoeUmLLWuRVtHoQfxWQe
 yoz9o22djs4CR8g6kNfUxwK5x90ifkNQOh+DdrUsUjEHgB9bTWnfgdKS5e9dxzxx7E6R
 viPQMdxPlDq/B3ZjcIwzekaaV+59LZCVsqj9Xt219GNYylOO+7a9raPWg9JBLbQEJpAw
 nQqTGIOuDELDeRnFoT3l8h3f9RMzvBukaG8IvZtwwCOsL8Zjsd0mZgZfFSUcKgxd6cy6
 MmWRtVM7IXr7Lk8pIZWSlq5YTHaydxNVRq3j+DizMrEQ1KN4JHAVycukNhZFgRECAVA3
 EgXQ==
X-Gm-Message-State: AOJu0YzHlloT6RLDpdLA1er1d/heCsZfmT11mUc5oVDBLBgYaA0VBH7N
 ORImuau/IV14cvagHVq4oArqp7BuHXvBhw==
X-Google-Smtp-Source: AGHT+IF6lsJlCtr2TKHEJHbCjWz2kwPgEPf8Xoxpbcf6KWSkoHMhUYXajB0IxsSxAy8IsqEZuvxnmg==
X-Received: by 2002:a05:600c:ad3:b0:401:bcd9:4871 with SMTP id
 c19-20020a05600c0ad300b00401bcd94871mr4205829wmr.21.1694252008117; 
 Sat, 09 Sep 2023 02:33:28 -0700 (PDT)
Received: from pegmas-T15.fritz.box ([151.51.159.106])
 by smtp.gmail.com with ESMTPSA id
 n21-20020a1c7215000000b003fc16ee2864sm4058206wmc.48.2023.09.09.02.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 02:33:27 -0700 (PDT)
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@edgeble.ai>, FUKAUMI Naoki <naoki@radxa.com>,
 Johan Jonker <jbx6244@gmail.com>
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH v2 1/2] rockchip: Kconfig: Enable external TPL binary for
 rk3308
Date: Sat,  9 Sep 2023 11:33:24 +0200
Message-Id: <20230909093324.11954-1-massimo.pegorer+oss@gmail.com>
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

There is no support to initialize DRAM on rk3308 SoC using U-Boot
TPL or SPL, and therefore an external TPL binary must be used to
package a bootable u-boot-rockchip.bin image.

Default ROCKCHIP_EXTERNAL_TPL to yes if ROCKCHIP_RK3308.
Remove useless TPL_SERIAL.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 arch/arm/mach-rockchip/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index a279582f4f..3b044269bd 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -166,7 +166,6 @@ config ROCKCHIP_RK3308
 	imply SPL_SYSCON
 	imply SPL_RAM
 	imply SPL_SERIAL
-	imply TPL_SERIAL
 	imply SPL_SEPARATE_BSS
 	help
 	  The Rockchip RK3308 is a ARM-based Soc which embedded with quad
@@ -436,7 +435,7 @@ config TPL_ROCKCHIP_COMMON_BOARD
 
 config ROCKCHIP_EXTERNAL_TPL
 	bool "Use external TPL binary"
-	default y if ROCKCHIP_RK3568 || ROCKCHIP_RK3588
+	default y if ROCKCHIP_RK3308 || ROCKCHIP_RK3568 || ROCKCHIP_RK3588
 	help
 	  Some Rockchip SoCs require an external TPL to initialize DRAM.
 	  Enable this option and build with ROCKCHIP_TPL=/path/to/ddr.bin to
-- 
2.34.1


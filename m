Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CB7FA373A
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 10:01:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B2F888D16;
	Fri, 13 Sep 2024 11:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="isOC9Bw0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5102E88CC1; Fri, 13 Sep 2024 11:57:39 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B27B88DA2
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a8d0d0aea3cso233676466b.3
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 02:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726221450; x=1726826250;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=etkA6VA9tRrzouIACYAZ8RzC4lkECV9vmUTMOSxzUys=;
 b=isOC9Bw0VgKi+HLjYB0QrWv8gqjVFjFBKrH8yYJrK1B/EDic/5cx3VCUr9kUiTxlMS
 1t7fs2EqOmHagCHHgO63mrAMEry9R5TxKLHJZxUDdebOqVbcs73XTM+M+d7O4Dvm45Wj
 yisLK9jjk5y7uvvlNz2quhEKXz+6D6ZUIHtcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726221450; x=1726826250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=etkA6VA9tRrzouIACYAZ8RzC4lkECV9vmUTMOSxzUys=;
 b=xEXlPzcQQVqTWAdHmEhJQWtH3lDeeUcGqIAxWhySpc4Aucwpmqm29SWNeLtLgddBUL
 RYZdOSsvBUg6LrK5VInAWvBM+GKx6RROmYTzZ7q6SWMF3U7e+0kGxiezJpT/b2mi8Wcs
 XQVx7P9NyKCms4h9mHKwAwIaWJcDDO+Za+Z7oJAvvoNJk2mMtGgihPqz9Nza4cHWDpNN
 hhnKQb6MMvK6ijEulnWfB2iWWa3qu6ZkfTapaGAObS3EjD1eZy63s8wMNBYD1qNLauOh
 DkOOLEnuHhyQaKgXRdjUqGKABTVQXG5eQ+d14OGKl/CzIVDl9NslI75Iy7F3Mq9gTVOk
 ZsLw==
X-Gm-Message-State: AOJu0Yw8TZBa5SHJBgjDc1jjqAXxVSVLGHD48e/hByN5Tnk30KMY7XVI
 h4haH9UlHokKesSvbn+TFVHvijul88oZcWsnBvsGh/wRDrxBReL6sajIIA3VBV6wFDA7pov1Oxx
 xtV0=
X-Google-Smtp-Source: AGHT+IFWZpBlY3BaOQoym30Orfst2h4N6TIiUXCzk/BSJovb/Zp5jsEioNVCnX2uOK6xHqiXrwPwTw==
X-Received: by 2002:a17:907:e269:b0:a8d:3338:a497 with SMTP id
 a640c23a62f3a-a90293dbfd1mr548603366b.4.1726221450294; 
 Fri, 13 Sep 2024 02:57:30 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-102-18.retail.telecomitalia.it. [87.4.102.18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm863224766b.173.2024.09.13.02.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 02:57:29 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 25/26] imx8mn_bsh_smm_s2/pro: enable simple frame-buffer
Date: Fri, 13 Sep 2024 11:56:07 +0200
Message-ID: <20240913095622.72377-26-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
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

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 configs/imx8mn_bsh_smm_s2_defconfig    | 3 +++
 configs/imx8mn_bsh_smm_s2pro_defconfig | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/configs/imx8mn_bsh_smm_s2_defconfig b/configs/imx8mn_bsh_smm_s2_defconfig
index 2fa8bc22747e..4982b58407c6 100644
--- a/configs/imx8mn_bsh_smm_s2_defconfig
+++ b/configs/imx8mn_bsh_smm_s2_defconfig
@@ -28,7 +28,9 @@ CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_FDT_SIMPLEFB=y
 CONFIG_DEFAULT_FDT_FILE="freescale/imx8mn-bsh-smm-s2.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2067
@@ -124,6 +126,7 @@ CONFIG_VIDEO=y
 CONFIG_VIDEO_LCD_SYNAPTICS_R63353=y
 CONFIG_VIDEO_BRIDGE_SAMSUNG_DSIM=y
 CONFIG_VIDEO_MXS=y
+CONFIG_VIDEO_DT_SIMPLEFB=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
diff --git a/configs/imx8mn_bsh_smm_s2pro_defconfig b/configs/imx8mn_bsh_smm_s2pro_defconfig
index b6b62b9d53f9..7ae99adf7fad 100644
--- a/configs/imx8mn_bsh_smm_s2pro_defconfig
+++ b/configs/imx8mn_bsh_smm_s2pro_defconfig
@@ -29,7 +29,9 @@ CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_FDT_SIMPLEFB=y
 CONFIG_DEFAULT_FDT_FILE="freescale/imx8mn-bsh-smm-s2pro.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2067
@@ -113,6 +115,7 @@ CONFIG_VIDEO=y
 CONFIG_VIDEO_LCD_SYNAPTICS_R63353=y
 CONFIG_VIDEO_BRIDGE_SAMSUNG_DSIM=y
 CONFIG_VIDEO_MXS=y
+CONFIG_VIDEO_DT_SIMPLEFB=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
-- 
2.43.0


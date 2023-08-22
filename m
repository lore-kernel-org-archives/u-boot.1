Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EF6EE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 11:23:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74BF6864A1;
	Tue, 22 Aug 2023 13:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WQ2X4YgF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAB34864B1; Tue, 22 Aug 2023 13:22:47 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78D43864A0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 13:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-99c93638322so896171966b.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 04:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692703364; x=1693308164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VGTKi5hyg288FhatKgnvBzU0s7qfbulM2J8mlAxkUNE=;
 b=WQ2X4YgFuFpR0Xtcd281J0QqhA08Z8J+vhU01o/qZWfsF/hd4E0mPSmxs7zVHFbKqW
 GGXbGKlcK81d4rUxpMecQy0+1BQPLHrSrdvu+4N4ZefwCjWt2VixPrq647ldq3WqmA8a
 +tzupJhG/lXp1B/1mooBePsckBQD5XF8iPLMd2Wj4h6MTNlS0oRUX/uHTv8tr4e8D8zq
 STpbuCsYZbydgkEorO60ntr0M1lVmw+F1FS5XV+/T82gZHeR30CYHxC8TqknrZJKMUTJ
 OB67MZ5aKG78VOMntXeJy2kn/A9W3qxHh1LgJdmAx8sbUtEHKKxNVxhDqtJe+YLiUf7Z
 eIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692703364; x=1693308164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VGTKi5hyg288FhatKgnvBzU0s7qfbulM2J8mlAxkUNE=;
 b=BbJZ1XpIGrgjwAJyW0ypXkksqBAGZhCH1q2c8x24CUuDJNhGkBzqW8oVMDRjnDE8Bw
 LzGeqfgd85YOH6yuky7LQsH2XSCO2HM1nuevBSMolT/c9gsIbtpWwQHY5z7qiG0QSLzs
 LxCCLBoYi7vUCmKbCTcrIfo+bHmeN7HlqU5TNdnYA3M+DJKWDEtCckeP7etJqzC5glUf
 ++aKxcTjIPy/+lEYuxM9RBJdMmWhO/sqjvNl1MPRWQgtNVGxkTE5iEJ2qY3zyHaeKFfR
 lbGPUGXjJg3XxyWtsXL3EE7Q/lxHnLL34jNwA9shD9KlwTK/Utc5YPYQmaefe4fVItAo
 /rFA==
X-Gm-Message-State: AOJu0Yy8ikeRMK8eiYirjoSChd5DuxgiK+Fp276HCUgdZa/4sNp6Hffd
 QcM+Wsm1jKEWI3AVJqtftvbU8+DUY2pQUQ==
X-Google-Smtp-Source: AGHT+IGEkAqpxm5IDTYIuTkpwAIOBZXGl5pbWAtgzpjVAUS33mjk1H6E9Q1F0MpkUd7sd91GehzkTQ==
X-Received: by 2002:a17:907:a04a:b0:994:5407:9ac9 with SMTP id
 gz10-20020a170907a04a00b0099454079ac9mr9792371ejc.5.1692703363737; 
 Tue, 22 Aug 2023 04:22:43 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 mh9-20020a170906eb8900b009934855d8f1sm8041456ejb.34.2023.08.22.04.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 04:22:43 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 03/19] configs: transformer_t30: support booting from USB
Date: Tue, 22 Aug 2023 14:22:01 +0300
Message-Id: <20230822112217.4646-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230822112217.4646-1-clamor95@gmail.com>
References: <20230822112217.4646-1-clamor95@gmail.com>
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

Change boot logic to primary try to boot from USB in dock, then
from microSD and lastly from eMMC.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 configs/tf600t.config             | 2 +-
 configs/transformer_t30_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/tf600t.config b/configs/tf600t.config
index 89d8db4eb1..18ab4fbd87 100644
--- a/configs/tf600t.config
+++ b/configs/tf600t.config
@@ -1,4 +1,4 @@
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-asus-tf600t"
 CONFIG_TRANSFORMER_SPI_BOOT=y
-CONFIG_BOOTCOMMAND="setenv gpio_button 222; if run check_button; then poweroff; fi; setenv gpio_button 132; if run check_button; then echo Starting SPI flash update ...; run update_spi; fi; run bootcmd_mmc1; run bootcmd_mmc0; poweroff;"
+CONFIG_BOOTCOMMAND="setenv gpio_button 222; if run check_button; then poweroff; fi; setenv gpio_button 132; if run check_button; then echo Starting SPI flash update ...; run update_spi; fi; run bootcmd_usb0; run bootcmd_mmc1; run bootcmd_mmc0; poweroff;"
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4d00
diff --git a/configs/transformer_t30_defconfig b/configs/transformer_t30_defconfig
index 6fe6f2548d..840431ff38 100644
--- a/configs/transformer_t30_defconfig
+++ b/configs/transformer_t30_defconfig
@@ -22,7 +22,7 @@ CONFIG_BOOTDELAY=0
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_KEYED_CTRLC=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="setenv gpio_button 150; if run check_button; then poweroff; fi; setenv gpio_button 131; if run check_button; then bootmenu; fi; run bootcmd_mmc1; run bootcmd_mmc0; poweroff;"
+CONFIG_BOOTCOMMAND="setenv gpio_button 150; if run check_button; then poweroff; fi; setenv gpio_button 131; if run check_button; then bootmenu; fi; run bootcmd_usb0; run bootcmd_mmc1; run bootcmd_mmc0; poweroff;"
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-- 
2.39.2


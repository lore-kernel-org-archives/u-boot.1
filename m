Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB99CC4451C
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 16:16:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E7CF84A29;
	Sat, 18 Jul 2026 18:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="busKG25m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED89484A49; Sat, 18 Jul 2026 18:16:40 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1D3A84979
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 18:16:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so30765205e9.2
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 09:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784391398; x=1784996198; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JVss2Qczp1U2q6NFB+0xVJ3c0YhuEMEVGdtn9hJ96ps=;
 b=busKG25m9nq5tL7P34Z9t9qUQWrL1JJri9CuIkZInzxGQqUFJX5RoGvOtd0icE6Eus
 ythbjK6mzEiaI6bP0ecFiuN6wMdUETVrDdBDRVwNgCGRTzoVBesaxW729Ir0Cl7ibk8g
 72BsJX3wN9jEbH/17hA7ozZ33knyxegC1maoJ5Yi18Ipdx9nB/2JorGXCEgD9Qwz3G/i
 Kseqb8Ev7/wXAVY/HSRActMAM4VIImC5Stz9NSHKbDz5XA/teAumlc/3BD8MszsfFuwc
 3JpLc039RQUlvApZgyUNHXyYhzCb4vzNPUNeuX/kosLRcEmGZ+tiE0OO2PBlcZ1/FX5O
 O/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784391398; x=1784996198;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JVss2Qczp1U2q6NFB+0xVJ3c0YhuEMEVGdtn9hJ96ps=;
 b=jZyJVKTH1eU+1OJ+48EaYti3gbDfSHf7p2n3TdamaKWIn3PdOLrsEc35qJGDxxF1L0
 FTb8GuNhr6PkHs1xNN+sPS5oA9Q5hJA5XnWbgtpNiJ8YonsNZISteJQgez/Wi+QLiYNa
 0I4GhYeRkB1h3KBM7bIHHj0zwfs0/hXr6vZZj5W8TYhMx9kZMHl6ROexTIcnfQ8Nem3p
 s48E6bZOMzDswyp1s/M1SUmvsEVHnw4yS0Y4hqXec3S4GRBzzaBmxfu7x7kbPvcSXDx4
 nYYPqPMeX4sYbMzP9aSapvq4LhLJlxcxVmHPMEFx00bxMZsobNcugxES0FnYJexlTlnB
 6ORw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqBekQlqAazp3cqezI33SWkPSYj5MHMM28gOrLaHka95TrF6tyjoHGG2pBJDOMX01iBAAzmtj0=@lists.denx.de
X-Gm-Message-State: AOJu0YxEsYbKPDD1fSBakdLtQ7CYjO0vRYlaAGa0kgZYUB3IN+833e8p
 pUGJThlEnffDzAlLxByqlmTYzfc7NRcPOos8JAJVBE8j14N3Ks2FJnzWjKwzjTQYzEU=
X-Gm-Gg: AfdE7cnqsGMbUCf6JmhZcnuzo543LeU2iGvE/ph8zhg8aua210GKLHPmQ5S2gE5kHFY
 +tOFQrAhiMqqw1XGeQVF8rayXObVhFjG5p4Cn55k4kd351T4UhtYVJWeB7AA1R8627SFZz8RMpw
 LIx5tuCXzOhsGovDw6qKJ4Pfl638haEwiLG4Pw8Q1oT0GkHkatKsGZkST0/oIWvWgkY8PbXiATU
 o7ZflxQuHadXlSxfGc8uT4ol1gN/zl1C6tPNWTIAzxwe5hiYWGw0OmmraXZxhQM9oIAzdTTMjOl
 s31gUP7r95Ki0eNAsiwdoarw/wHq90gO9GZvBbaEV1VPGRmUroIopnSKW0t5LqQ0zpaKOKd9jAT
 PaHbiLFwS9V09X4rEjGgVigJu3Qm59/LLN815elg6/ehfGEGn+ao04W9gA2yfJWTHNeuMbGoTNU
 xgSVje2cfjqqBFOE+lkyPwMcUxN3QdJTDq3+jYEbyB6FVZYKEhT6yUyuvy/pu471nsWr+zDbgzz
 8cic4tacwMADnrx2V1V
X-Received: by 2002:a05:600c:4f09:b0:490:e19b:bd99 with SMTP id
 5b1f17b1804b1-4954a40bc1emr77326665e9.30.1784391398280; 
 Sat, 18 Jul 2026 09:16:38 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-16-115-126.retail.telecomitalia.it. [79.16.115.126])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495499d1d4asm88915955e9.2.2026.07.18.09.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 09:16:37 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sat, 18 Jul 2026 18:16:08 +0200
Subject: [PATCH 2/4] configs: mt8390: enable eMMC FIT boot from SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-ccaione-upstream-mt8390-spl-v1-2-1256b6dfda3f@baylibre.com>
References: <20260718-ccaione-upstream-mt8390-spl-v1-0-1256b6dfda3f@baylibre.com>
In-Reply-To: <20260718-ccaione-upstream-mt8390-spl-v1-0-1256b6dfda3f@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.15.2
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

Enable the normal Genio 700 SPL path entered by the external DDR
loader at 0x40000000. Bound the raw SPL to the loader's 0xaf000-byte
copy window, place BSS separately in DRAM, and retain the
non-overlapping SPL malloc region.

Use generic SPL MMC, GPT, FIT, and Arm Trusted Firmware support to load
the firmware FIT from eMMC partition 1. Keep U-Boot proper at the shared
MT8188 CONFIG_TEXT_BASE of 0x4c000000.

The MediaTek BL31 used on Genio 700 stalls when passed the runtime
devicetree as its platform parameter. Enable SPL_ATF_NO_PLATFORM_PARAM
so SPL can still use the tree to locate OP-TEE and U-Boot while passing
NULL as the separate BL31 platform parameter.

Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 configs/mt8390_genio_700_evk_defconfig | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/configs/mt8390_genio_700_evk_defconfig b/configs/mt8390_genio_700_evk_defconfig
index fe4f6ad9016..5730b056e29 100644
--- a/configs/mt8390_genio_700_evk_defconfig
+++ b/configs/mt8390_genio_700_evk_defconfig
@@ -1,3 +1,30 @@
 #include <configs/mt8188.config>
 
 CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8390-genio-700-evk"
+CONFIG_SPL=y
+CONFIG_SPL_TEXT_BASE=0x40000000
+CONFIG_SPL_MAX_SIZE=0xaf000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x400bb800
+CONFIG_SPL_BSS_LIMIT=y
+CONFIG_SPL_BSS_MAX_SIZE=0x100000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x5c000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x9000000
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_SERIAL=y
+# CONFIG_SPL_USE_TINY_PRINTF is not set
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_PINCONF=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_LIBDISK_SUPPORT=y
+CONFIG_SPL_EFI_PARTITION=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=1
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_ATF=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y

-- 
2.55.0


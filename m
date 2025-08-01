Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7DAC87FCA
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 12:41:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FD9E83A84;
	Fri,  1 Aug 2025 14:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="MWwsq2N8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63BA9839F1; Fri,  1 Aug 2025 14:32:48 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A26D3839F1
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 14:32:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=301ae58c2=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1754051558; x=1785587558;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/kdt+467TJ5o3OK0SANNXckFLOVrBoOMWhrz3LmSPtM=;
 b=MWwsq2N81QykBkUV5lfz3rsnNj63SoznWtawxOikOLxawzyXTeLeFHGQ
 U7qVUCHOri4hqvVC1D7nJw15Nck9eaRNK6jA8mK6D0oOuKayyCTr4a6Pd
 xdMS7RAy218kxSSFVjvgYI0r/g0KdWQazK6XAwPV/obL3cP8RJNE6Ks7Z
 XiabBvWj+2BPup90FFxI6bP8Gs9Xn0zdzdka86QD/Ub7jdvCn+qJzByrT
 oajcKP+yzuufP7KaOLCdF/MBKZwoCyTz85ShBUIaBv2UZsgrXJx4HR61u
 1VV/Kq1OCDYhqmDJeCyolABmKrs8ehDyIDb05/zdQjVY0s1gWjnaqDQt7 w==;
X-CSE-ConnectionGUID: bOK7yHieQUO4D5yc5zbu5g==
X-CSE-MsgGUID: BvSsEdPQQ1CF5iy4rFqsOw==
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; d="scan'208";a="44692462"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Aug 2025 05:32:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 1 Aug 2025 05:32:27 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Fri, 1 Aug 2025 05:32:25 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Cyril Jean
 <cyril.jean@microchip.com>, Tom Rini <trini@konsulko.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, <jamie.gibbons@microchip.com>
Subject: [PATCH 1/6] configs: microchip_mpfs_icicle: enable
 CONFIG_OF_BOARD_SETUP
Date: Fri, 1 Aug 2025 13:36:21 +0100
Message-ID: <20250801123626.1972658-2-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250801123626.1972658-1-jamie.gibbons@microchip.com>
References: <20250801123626.1972658-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 01 Aug 2025 14:41:57 +0200
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

Enable CONFIG_OF_BOARD_SETUP and other dependencies to allow the use of
the ft_board_setup() function to replace fdt set in boot scripts for
Microchip's MPFS Icicle kit.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 configs/microchip_mpfs_icicle_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/microchip_mpfs_icicle_defconfig b/configs/microchip_mpfs_icicle_defconfig
index 6937aa224a1..7aefcc5fa86 100644
--- a/configs/microchip_mpfs_icicle_defconfig
+++ b/configs/microchip_mpfs_icicle_defconfig
@@ -5,6 +5,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="microchip/mpfs-icicle-kit"
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_LOAD_ADDR=0x80200000
 CONFIG_SYS_MEM_TOP_HIDE=0x400000
 # CONFIG_DEBUG_UART is not set
@@ -12,14 +13,17 @@ CONFIG_TARGET_MICROCHIP_ICICLE=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
 CONFIG_FIT=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_DEFAULT_FDT_FILE="microchip/mpfs-icicle-kit.dtb"
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=282
+CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_DISPLAY_CPUINFO=y
 CONFIG_DISPLAY_BOARDINFO=y
 CONFIG_SYS_PROMPT="RISC-V # "
 CONFIG_OF_UPSTREAM=y
+CONFIG_OVERWRITE_ETHADDR_ONCE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_DM_MTD=y
-- 
2.43.0


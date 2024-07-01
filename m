Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09260C2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 13:53:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BCF2884EA;
	Mon,  1 Jul 2024 15:53:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="juyQ0Mxp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A4408866B; Mon,  1 Jul 2024 08:21:17 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 173D98824C
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 08:21:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1719814874; x=1722406874;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a9xqHm3qG8VvotrqEuPF8KSlFgXf/Z9slage8UEy8bg=;
 b=juyQ0Mxp3duQ5jTBkmMrX2OO87Y900wM5yFGaiaLkZCrb7A5j+CnZdnBC9x1tJmN
 OMnm4m6rfVGe1H1IrkDrS8vjNrH2uym1bK3QdVWkt8KlpxIJB3E7pNmW4hePNCkf
 IJR4avI57GaVINJjq6dQL1Zd0F8B+FwQkeeyUC5DzJY=;
X-AuditID: ac14000a-03251700000021bc-38-66824ada92c9
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id BB.A0.08636.ADA42866;
 Mon,  1 Jul 2024 08:21:14 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 1 Jul 2024
 08:21:12 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <w.egorov@phytec.de>, <trini@konsulko.com>, <d-gole@ti.com>,
 <mkorpershoek@baylibre.com>, <nm@ti.com>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 1/4] configs: phycore_am62x_a53: Add more commands
Date: Sun, 30 Jun 2024 23:20:47 -0700
Message-ID: <20240701062050.1475249-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsWyRpKBR/eWV1OaQecrBYuWtR4WL47NZbd4
 8+Msk8XUSZvZLd7u7WS36H6n7sDm8f5GK7vHqwOr2D3O3tnB6NHf3cLqcfzGdqYA1igum5TU
 nMyy1CJ9uwSujK4Vk5gKnnJWrHw4gaWB8SBHFyMnh4SAicSPBw9Zuxi5OIQEljBJvL7fyAjh
 3GOUuLnqBytIFZuAlsSdLXOZQWwRATOJRWvPs4EUMQtMZpRoPrSQHSQhLOAkcezbK7AiFgFV
 iWc3FoA18wpYSSzb8ZcJYp28xMxL39kh4oISJ2c+YQGxmYHizVtnM0PYEhIHX7wAs4UEFCRm
 b5vMCNM77dxrZgg7VOLIptVMExgFZiEZNQvJqFlIRi1gZF7FKJSbmZydWpSZrVeQUVmSmqyX
 krqJERTWIgxcOxj75ngcYmTiYDzEKMHBrCTCG/irPk2INyWxsiq1KD++qDQntfgQozQHi5I4
 7+qO4FQhgfTEktTs1NSC1CKYLBMHp1QDY/OBrrPFSyfq/eBlnBv2J6s698jNhca/gia+Tqz5
 2e7x5dU3Ry5XjW+fLB7xqVa1dywM4b9tllFUc61Xd1v72903Il/c2K28TyHw2mubBZ1Lom2e
 Vvmbr/f3cvgc+fh/R8nt+30vrq48dVZrZ969LBuXTZyvH2Wq1PyaFZsf9XJmSHrKiuhHFUos
 xRmJhlrMRcWJAES+X8xZAgAA
X-Mailman-Approved-At: Mon, 01 Jul 2024 15:53:19 +0200
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

Add i2c and rtc commands with all dependencies which are
required for testing.

Additionally, add smc and cache commands to boot Zephyr on the A53.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 configs/phycore_am62x_a53_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index 56302383c0f..06b8834e074 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -1,4 +1,5 @@
 CONFIG_ARM=y
+CONFIG_ARM_SMCCC=y
 CONFIG_ARCH_K3=y
 CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
@@ -63,9 +64,13 @@ CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_CMD_DFU=y
+CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_SMC=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_MULTI_DTB_FIT=y
@@ -123,6 +128,8 @@ CONFIG_TI_SCI_POWER_DOMAIN=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_RV3028=y
 CONFIG_DM_SERIAL=y
 CONFIG_SOC_DEVICE=y
 CONFIG_SOC_DEVICE_TI_K3=y
-- 
2.25.1


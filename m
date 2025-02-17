Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DE8C021A0
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 08:17:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE56780F53;
	Mon, 17 Feb 2025 09:17:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ItuXXyBM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF84080F56; Mon, 17 Feb 2025 09:17:25 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3795A80C7E
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 09:17:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51H8HJGQ1317056
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Feb 2025 02:17:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739780239;
 bh=dYokLvcrzzUzUp/Yn7nuGipE2abfYxd9fTWkVWAtbFc=;
 h=From:To:CC:Subject:Date;
 b=ItuXXyBM+UAc70acyR62Iu1XWmA2r6X0bgAGr0tdoxqll3k4mpX2br0RdoA6g6sEP
 pqziSlG0UdPGqTxCW6Zj/+KJOI3U9S4Q98ZZAh5/6P3++52E/kD6gusr9Uc7TEvKTH
 USSYs8VpAXH0xPoTqA6rGnaJA8LkwwqjNCtmw/QA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51H8HICs079088
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Feb 2025 02:17:19 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Feb 2025 02:17:18 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Feb 2025 02:17:18 -0600
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.6])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51H8HEfJ021538;
 Mon, 17 Feb 2025 02:17:15 -0600
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <j-humphreys@ti.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <afd@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <m-chawdhry@ti.com>, <b-padhi@ti.com>, <sjg@chromium.org>, Udit Kumar
 <u-kumar1@ti.com>
Subject: [PATCH] configs: j784s4-am69: Enable UFS
Date: Mon, 17 Feb 2025 13:47:12 +0530
Message-ID: <20250217081712.1866257-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

J784S4 EVM board has UFS flash, So enable UFS configs

Cc: Neha Francis <n-francis@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Bootlogs
https://gist.github.com/uditkumarti/828f4a7731d952f92b627f7ac46da5dd

 configs/am69_sk_a72_defconfig    | 5 +++++
 configs/j784s4_evm_a72_defconfig | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/configs/am69_sk_a72_defconfig b/configs/am69_sk_a72_defconfig
index 452de88725..bd8aaf7f20 100644
--- a/configs/am69_sk_a72_defconfig
+++ b/configs/am69_sk_a72_defconfig
@@ -5,5 +5,10 @@ CONFIG_ARCH_K3=y
 CONFIG_SOC_K3_J784S4=y
 CONFIG_TARGET_J784S4_A72_EVM=y
 
+CONFIG_CMD_UFS=n
+CONFIG_UFS=n
+CONFIG_CADENCE_UFS=n
+CONFIG_TI_J721E_UFS=n
+
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am69-sk"
 CONFIG_OF_LIST="ti/k3-am69-sk"
diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index f058e3b1c0..927f2a001b 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -159,5 +159,9 @@ CONFIG_SYSRESET_TI_SCI=y
 CONFIG_DM_THERMAL=y
 CONFIG_EFI_SET_TIME=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
+CONFIG_CMD_UFS=y
+CONFIG_UFS=y
+CONFIG_CADENCE_UFS=y
+CONFIG_TI_J721E_UFS=y
 
 #include <configs/k3_efi_capsule.config>
-- 
2.34.1


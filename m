Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05213C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 11:35:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83F3D88050;
	Mon, 15 Apr 2024 13:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ox35C3e9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F272788132; Mon, 15 Apr 2024 13:35:38 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76D8B8802E
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 13:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Np7tbbWWvBx8FItrqZxxHBmLBZVNxRmUITzh4I2v4EsuqgU4zxMB6laVou6fZ2zeoES8xqiNgYlJed0GlvF2hyDRJAJ/Pqz94/jZmGOGtNF+sRVIvkMmqnOILzfZV+oDWyDM8Y9VOqZ9+HoLGl/EvFUlCTHwRsXTFLs//egdwcl2VGDGSXEKxcjcDXUMMmnwx0AmaKtc0WsguDFxFSXUht6b0NDbWEr3dPmTxLGxv6J45dUiwi8LEJ2cvDbWX9IK6/DPzG4+ffO0tB0MGGZbEXrimDcUAE/wSNh26rGQr+jCeP1RMLL9mlbx+wI94x3X5DGCWXq7Wc6v35BxAcCyyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puHrGKZexjkCg6LV5EJAO+L5RZf/k0rOdXrU19yGDa0=;
 b=d18P/jSk8NgQKhbB2C0vi1bEx0hyEjMcFhjG2bdDI2W4Z188SxaZvgQpIDSTS7GnsjN7xonxWUy6EkYz8dOUxZkLiiNHS0gpuSj8ecXJAHDDyBnpfjTqUw0yYIuGmOE9cpDPoeS6E7691LwBCYwGdpvegF8vP6MzyYFDJnY64UZ4DURwwF4N+EY1E5I2tEeLa/AbjjDllR2gk0pQVDwT9IK+2YXGXIgj7flkTqOQ7PjZLtS/E9ddqUGIZOXM+dW3b6/+YNBgIMFtxNgmhobQHrnatLL2RRToe9s7dOMoGInmV9FKAaPrhrrGHboyvjS2Y6/BOx+Bj9vzPeTovsAmqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puHrGKZexjkCg6LV5EJAO+L5RZf/k0rOdXrU19yGDa0=;
 b=ox35C3e9/AAOhJ1k8lA14260XEiA8QkUc+KuXTRNYbTdJdjbaC7Wht5Eyuw1dAlC+/sNCcv2AKsvxDXpqN5mIYXa71M0USnpDk1e33PPfBn0+qIwssXsjU6Ze0CcQmA2HHzS/+uigWN5Xdeu/B2rm6GHZyO4p4BtGZ1FBmuotCk=
Received: from BN1PR12CA0022.namprd12.prod.outlook.com (2603:10b6:408:e1::27)
 by CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 15 Apr
 2024 11:35:31 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::2c) by BN1PR12CA0022.outlook.office365.com
 (2603:10b6:408:e1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31 via Frontend
 Transport; Mon, 15 Apr 2024 11:35:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 11:35:30 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 15 Apr
 2024 06:35:29 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: AKASHI Takahiro <takahiro.akashi@linaro.org>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Bin Meng <bmeng@tinylab.org>, Elon Zhang
 <zhangzj@rock-chips.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jagan
 Teki <jagan@edgeble.ai>, John Clark <inindev@gmail.com>, Jonas Karlman
 <jonas@kwiboo.se>, Joshua Riek <jjriek@verizon.net>, Kever Yang
 <kever.yang@rock-chips.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Oleksandr Suvorov
 <oleksandr.suvorov@foundries.io>, Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Sean Anderson
 <sean.anderson@seco.com>, Sean Edmond <seanedmond@microsoft.com>, Simon Glass
 <sjg@chromium.org>, Tim Lunn <tim@feathertop.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 2/4] Kconfig: Add missing quotes around source file
Date: Mon, 15 Apr 2024 13:35:08 +0200
Message-ID: <78064c48fd9297b43eae0abdec4783004ea74a07.1713180904.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713180904.git.michal.simek@amd.com>
References: <cover.1713180904.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5039; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=AOvJN+XVZtl0IIU1TGAkCCQUmWPWOhzLbP9KQwjeJEU=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhjRZga97HrbVaH7TTtu+s9pHWPa9qevX4J/eMfbbTH6GR
 /cz3DDpiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABN584dhwdxQ1cerJjasSTu/
 +Noy+wzLuNXhPAwL5uj82nP83V6LDLfCOM9Hrz3VOU6xAAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e18bf0-6741-4be8-6de2-08dc5d4027d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5aya+Ii5/bTyy2KzWY60S8nKCUPBcG0nrrmTBE61j4dB7CfjbYe15FXb2UcWBpdnLpWIUmw2+SjgUJO+G6pih0Qwdt1pBUq7OJ64NQnsFgEfTbGr9SOy/1lWK9GEOrRx/kzoJ7xd1DA/M9IQQ23xgfhIpfY0dk57fdd3HaSBhWSv3loXwWn68EbdAnWgAxkXRykMa/h/HhKx/8bcAH8D3jfO2lBwDpsBDQQB0VzGBoYOr9o94YvDFPN80FwB+0rPuHAx2+ejzVRIjUTLpBSNJGBiGDOJT4TmTZNoIMhNvI6+yNEL8zcoZckQTp/p8xb9gUxBe9w9IoEu2wwB+C4t9LAlRbjb6LitjXGSwyfXqhkDvQPiP70Q3rTwHBay1vCj32SU4LpoaNxXL0O7liIebKt8rxRHt08M4zfhSvTbDirA/VF7TGbqyMOIAxRGXcXlAUzJYtOKUws0PzA6NOYJI2QMvZzplDVMwij3gAJg1kdcDYvy7290vAzpNXyg8i0gHu7uKRdVR3abnBMTfI0oXYi97ZPnNRG/LS49vXbWajnAXqtsEDs7LiKyI5uSlDbimZoLK4tzAhu5jnxmWGlO6VU/RNDCSrCfzhrVYg77UXrhQPdZiLiNSSR6G3XBTfIwIv8av/z5csHks7nA8dQWvpXXtXtRu+jCrIS4Y9zKr7jN8vxOtZS51esJjctZvaOwFfPUmJzJzRaEYQvyuhwNMpQFjV/s9CBW+fEnxFIiMDfjg+MMLY5xSSzvYfxMcfeH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(7416005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 11:35:30.6953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e18bf0-6741-4be8-6de2-08dc5d4027d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441
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

All errors are generated by ./tools/qconfig.py -b -j8 -i whatever.
Error look like this:
drivers/crypto/Kconfig:9: warning: style: quotes recommended around
'drivers/crypto/nuvoton/Kconfig' in 'source drivers/crypto/nuvoton/Kconfig'

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-rockchip/rk3588/Kconfig | 18 +++++++++---------
 arch/arm/mach-rockchip/rv1108/Kconfig |  4 ++--
 arch/arm/mach-rockchip/rv1126/Kconfig |  4 ++--
 cmd/Kconfig                           |  2 +-
 drivers/crypto/Kconfig                |  8 ++++----
 lib/Kconfig                           | 18 +++++++++---------
 6 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index d7e4af31f24c..eb956b097c74 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -221,14 +221,14 @@ config ROCKCHIP_COMMON_STACK_ADDR
 config TEXT_BASE
 	default 0x00a00000
 
-source board/edgeble/neural-compute-module-6/Kconfig
-source board/friendlyelec/nanopc-t6-rk3588/Kconfig
-source board/pine64/quartzpro64-rk3588/Kconfig
-source board/turing/turing-rk1-rk3588/Kconfig
-source board/radxa/rock5a-rk3588s/Kconfig
-source board/radxa/rock5b-rk3588/Kconfig
-source board/rockchip/evb_rk3588/Kconfig
-source board/rockchip/toybrick_rk3588/Kconfig
-source board/theobroma-systems/jaguar_rk3588/Kconfig
+source "board/edgeble/neural-compute-module-6/Kconfig"
+source "board/friendlyelec/nanopc-t6-rk3588/Kconfig"
+source "board/pine64/quartzpro64-rk3588/Kconfig"
+source "board/turing/turing-rk1-rk3588/Kconfig"
+source "board/radxa/rock5a-rk3588s/Kconfig"
+source "board/radxa/rock5b-rk3588/Kconfig"
+source "board/rockchip/evb_rk3588/Kconfig"
+source "board/rockchip/toybrick_rk3588/Kconfig"
+source "board/theobroma-systems/jaguar_rk3588/Kconfig"
 
 endif
diff --git a/arch/arm/mach-rockchip/rv1108/Kconfig b/arch/arm/mach-rockchip/rv1108/Kconfig
index a12216dccf66..28ed0b245812 100644
--- a/arch/arm/mach-rockchip/rv1108/Kconfig
+++ b/arch/arm/mach-rockchip/rv1108/Kconfig
@@ -36,7 +36,7 @@ config SYS_SOC
 config SYS_MALLOC_F_LEN
 	default 0x400
 
-source board/rockchip/evb_rv1108/Kconfig
-source board/elgin/elgin_rv1108/Kconfig
+source "board/rockchip/evb_rv1108/Kconfig"
+source "board/elgin/elgin_rv1108/Kconfig"
 
 endif
diff --git a/arch/arm/mach-rockchip/rv1126/Kconfig b/arch/arm/mach-rockchip/rv1126/Kconfig
index 55b11121203b..ae323ee91235 100644
--- a/arch/arm/mach-rockchip/rv1126/Kconfig
+++ b/arch/arm/mach-rockchip/rv1126/Kconfig
@@ -64,7 +64,7 @@ config SYS_MALLOC_F_LEN
 config TEXT_BASE
 	default 0x600000
 
-source board/edgeble/neural-compute-module-2/Kconfig
-source board/itead/sonoff-ihost/Kconfig
+source "board/edgeble/neural-compute-module-2/Kconfig"
+source "board/itead/sonoff-ihost/Kconfig"
 
 endif
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 8eeb99eea5ed..45c206369518 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -398,7 +398,7 @@ config CMD_BOOTEFI_HELLO
 	  for testing that EFI is working at a basic level, and for bringing
 	  up EFI support on a new architecture.
 
-source lib/efi_selftest/Kconfig
+source "lib/efi_selftest/Kconfig"
 endif
 
 config CMD_BOOTMENU
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 12ef84ca05ca..8b49997030b4 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -1,11 +1,11 @@
 menu "Hardware crypto devices"
 
-source drivers/crypto/hash/Kconfig
+source "drivers/crypto/hash/Kconfig"
 
-source drivers/crypto/fsl/Kconfig
+source "drivers/crypto/fsl/Kconfig"
 
-source drivers/crypto/aspeed/Kconfig
+source "drivers/crypto/aspeed/Kconfig"
 
-source drivers/crypto/nuvoton/Kconfig
+source "drivers/crypto/nuvoton/Kconfig"
 
 endmenu
diff --git a/lib/Kconfig b/lib/Kconfig
index efb77978a652..189e6eb31aa1 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -416,7 +416,7 @@ config TRACE_EARLY_ADDR
 config CIRCBUF
 	bool "Enable circular buffer support"
 
-source lib/dhry/Kconfig
+source "lib/dhry/Kconfig"
 
 menu "Security support"
 
@@ -429,10 +429,10 @@ config AES
 	  supported by the algorithm but only a 128-bit key is supported at
 	  present.
 
-source lib/ecdsa/Kconfig
-source lib/rsa/Kconfig
-source lib/crypto/Kconfig
-source lib/crypt/Kconfig
+source "lib/ecdsa/Kconfig"
+source "lib/rsa/Kconfig"
+source "lib/crypto/Kconfig"
+source "lib/crypt/Kconfig"
 
 config TPM
 	bool "Trusted Platform Module (TPM) Support"
@@ -1081,9 +1081,9 @@ config SMBIOS_PARSER
 	help
 	  A simple parser for SMBIOS data.
 
-source lib/efi/Kconfig
-source lib/efi_loader/Kconfig
-source lib/optee/Kconfig
+source "lib/efi/Kconfig"
+source "lib/efi_loader/Kconfig"
+source "lib/optee/Kconfig"
 
 config TEST_FDTDEC
 	bool "enable fdtdec test"
@@ -1148,4 +1148,4 @@ config PHANDLE_CHECK_SEQ
 
 endmenu
 
-source lib/fwu_updates/Kconfig
+source "lib/fwu_updates/Kconfig"
-- 
2.44.0


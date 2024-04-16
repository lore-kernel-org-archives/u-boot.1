Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00403C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 06:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E1DF881EA;
	Tue, 16 Apr 2024 08:55:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pBdtrmX8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13C3E87F01; Tue, 16 Apr 2024 08:55:46 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CDCB88291
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 08:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBCgoArKRSVf7NsGGrhcnoULyJalPefiyTUkosVumEQDJlkF65HshwAmqWhYVug8IZTChlpQDhCr5MxEOx9IgfaCSPzdEMRTl6PX9fpdlLc2sm4qaHms/B6YjZykKEBqyybdqa4BkBWSuFkrbXq/iNs/p7gHZfeVjDmiCNk02iYUZ8RE6d/jb7bHGyrA/Fnrpkh0y62GHZeBtR0Kha+Hgh0nlo3xowKu1pJHcgHOL5lsFJ8MkIpBdnrSnNbf+P5ZfQdwV96Np2tW2zxZhttADFpJl9swnLlr2OvoJfY99pthhwkW1+0p4AgrWThs1G/px+tHYSvoR+SYuZzdCsc3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ux9th61Ckx/lSdQpEUlztxZMVdiwwh5CYflPjxv7ceU=;
 b=Tx2Itx2c2lY32mP5HYnFSyoR37rqrYZf/mxEB/xG6vlwtraZRiAEFlihaB0yhOKBzxu7MOdMTlOvSLvp3p2eYTS265in/CSLCE8cD/RiaJ9c7Pxp8H//zFrU8vNTpm6b/Baft4CZSVd1O5sO2eiDLYNmaAfFdwVsBnNYkwLUlhlXm1P779kkPBAc0wf0I1EBFWzX37mR/ONSH3a1O5yllbOGHNBbbcjVvAsXvY52quv/AGFBPsSmwWP8Eb3AhNCcpDJglNNX+N6CCeWgJ9v1A/Nr0hrTHmjcdEKoY/82MJLuu5OxOWfY5Ey9pO5L0CvuUe5PsFCGcHe8/3eOsXt6EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ux9th61Ckx/lSdQpEUlztxZMVdiwwh5CYflPjxv7ceU=;
 b=pBdtrmX8XKXwiEEdXWKkWd1k4KreVMLnM2XfThPWZb1l+LhzVi/IRa/Qb2qe6CcyX1mMK3SpeaKM7A+Nxg+Ximg7qsw91c42JOf21biaUDHvdyePgyBdqtnvqFcZwhZAcwZDEZigtzxzC8geOcrsTXqqMPf+/qSBvqNGuZTjL1I=
Received: from SA9PR13CA0097.namprd13.prod.outlook.com (2603:10b6:806:24::12)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 06:55:35 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:24:cafe::75) by SA9PR13CA0097.outlook.office365.com
 (2603:10b6:806:24::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.19 via Frontend
 Transport; Tue, 16 Apr 2024 06:55:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 06:55:35 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Apr
 2024 01:55:33 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: AKASHI Takahiro <takahiro.akashi@linaro.org>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Bin Meng <bmeng@tinylab.org>, Eddie James
 <eajames@linux.ibm.com>, Elon Zhang <zhangzj@rock-chips.com>, Eugen Hristev
 <eugen.hristev@collabora.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jagan
 Teki <jagan@edgeble.ai>, John Clark <inindev@gmail.com>, Jonas Karlman
 <jonas@kwiboo.se>, Joshua Riek <jjriek@verizon.net>, Kever Yang
 <kever.yang@rock-chips.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Oleksandr Suvorov
 <oleksandr.suvorov@foundries.io>, Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Sean Anderson
 <sean.anderson@seco.com>, Sean Edmond <seanedmond@microsoft.com>, Simon Glass
 <sjg@chromium.org>, Tim Lunn <tim@feathertop.org>, Tom Fitzhenry
 <tom@tom-fitzhenry.me.uk>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/5] Kconfig: Add missing quotes around source file
Date: Tue, 16 Apr 2024 08:55:16 +0200
Message-ID: <78064c48fd9297b43eae0abdec4783004ea74a07.1713250508.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713250508.git.michal.simek@amd.com>
References: <cover.1713250508.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5064; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=NnAhNN94joAhxIGE9Bw6dxI0ZnINcXsseya/7Md2qSA=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhjQ5hZu7lGzE31RG7OJsvPg41O6I6RrO2u9B9ZJpwhtEi
 masOPutI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEwkv4thvtOVo6de8N9NXTDH
 iN/46vG7FRFV+xjmad9dbLThvqnk3eeHFQ5Mus82f9dbJgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 7becd304-77bb-44ef-4cd6-08dc5de2375f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zU36Ci//26ISYjZL9yuJuPcQvpIskDCKHnzK4CoFJke1T6H41yEkh5uVWwlUvTwVnKq8oUUkSScwLPoDOewVQvIGDYsk46vOTyXYjr9a74I9uxiAfbWt1vsntedMh+S9lWQTFtbd3WslF1CPKQR+smVkZ5AU5j/J07ILgUs6QKkmO4KeURYx0YQD0JBzQWKgwJ/BRoR7FmJHLGUd60oN2qcoAqhd7wB4qasQmWWAJ0wgMIQEql2760YAvroYY0DKqoKzrOpeGC9o+duMctw3Wck6Imu8jx+yAS0xa6ZA+5LU7FSNwlX0RsrliowLtGRbFIQYAODd6DuTi/nY+f5u6m7ncUPa1D3LybnUOnfTH/vNHunmftoi12r9njG/nZZ5dWUyyAQBfS+YBQ7QylsfScpeJkn530eBGiUxsF3Iuvn6sj8g/minsL/HdlFBPTv/YUU69RU37pABoGFXRDNErE2n+TgzjssA9rQT5DLj7DaT+o8cTKiNW2aW168N1RGaAx0MYQaI+uejpPE0qcZPIwMaCK6I13xENDLOHx48bvZXtEjDUP8Ov6ilgGvncHJVw/ZG2FXoS7XNRIn2pIOeYqX7p0RTTD6MYLCZeNFad2UBpdMp5oljkc1syVlc6EewOmuZb3lWPNd+xxlTh4NZd/R+Z87SbeZYcAkgNBL66j9rHeXfkz3VgFJuvqDsmLQz/Jhw9bBFBxnBuoHXdUynMOS7SS9FhAnlpW/A2qsdnse8ZP6X1+QnF18VYHk4UCtD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(7416005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 06:55:35.1971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7becd304-77bb-44ef-4cd6-08dc5de2375f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388
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

(no changes since v1)

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


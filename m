Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F540C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 05:00:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B0C1812BB;
	Wed,  5 Mar 2025 05:58:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="a0LZ1gUf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14FBC800C1; Wed,  5 Mar 2025 05:58:56 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20716.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::716])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 916E480F9E
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 05:58:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjAJIASQq38CkGRpSBeJP1V+AzVS9CnoCtlcZbkatJE0K8M5qUb+UGB+r73JiqNS8HUoRtmo7Z6WhdF/0cI8FgE1aQ6dJPo0gTdeArP8KLCdcKtxy0S7OqEILhCjo9gNbhYyND+S2klm+hP7zo3onft3mfLC3Rux6swmy5QHEhR+lzZ/DMOLeJCvAIcZknwGj48nki4dclLlWmEPdW8vW01bl6rW/81EyNZbfUjxpaswQyrydMYFNK4x/0EsXpq+Nsr3g+0xxk1UaaNpjZN1MODfTnQBfA8YPDNdbGkGcdzyuaCi1BxctZUx4I3nrwqyp7zmhAg6pBezZGG+9HosQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SD75zKg+ZoGWhffXdZzLwfFQgC96mVmj+Sa7ERvOjc0=;
 b=h+DvW4/lvxcPurLSDJJAV3hsrDWe4SrFQlbsU9VntKwNieOPJKC5IDtRwBufQi4lzXRDIcvyLCRwwmhNcPcuHoRyamolwZMnmiN2JOSgEjGGl0wx8gCVRtRDX13oCI18WdvbFVASM95nmyRPC8B2pkKeUladRYZc/CIBEubNJ6PBWM9zNn9IV+hieEigxBpAhLjlc/vbY9cJjcIVHyCba2d/OrwF1RU0NDasKi3B2Q6v5f4ZVuAUQRjlWs4RjLTh0IQPrvZN/YNcw1NWRqnNkZxYY11xF/HeA6XJVmEWS/rjHzv0JG1ooJ1zmI9YsANDe5002M3zZPT3w+sOSuaB8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SD75zKg+ZoGWhffXdZzLwfFQgC96mVmj+Sa7ERvOjc0=;
 b=a0LZ1gUfKrCuJCKxLjIJyx0QsWbD7EvgvSCoSyDVeRVYOAxeoxo4njRE2ESQZ0WbKESaY00YJAD6UR9Sna0Gk1hA1dFBfcb9r93DSkZ6DG62SxA0vqUdfK1s43qh30tDzhO8/uNIyBS7yk7faOn365nOHMH8NnHkubOd/xh8IJzbqV7dNj755YJ/m8vxQSrW/YHdEnEV2EA5FSnrR606IZTmtyY+6QzPmLQmyR7+lw7A3/T9HhbjuCWKvYwsI0zpmkpZWLw4DxnNV/GMt+/Fla5+pKb2ogP2aQVpx1Ak3L2D/cL0ITj1c1CxoelWLcLKrxzzrLppr79cGL9acnfY4Q==
Received: from CWLP265CA0268.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5c::16)
 by DB8P195MB0534.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:15c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 04:58:49 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:401:5c:cafe::be) by CWLP265CA0268.outlook.office365.com
 (2603:10a6:401:5c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Wed,
 5 Mar 2025 04:58:49 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 04:58:49 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:47 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:47 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <joe.hershberger@ni.com>, <n-francis@ti.com>, <afd@ti.com>,
 <nmorrisson@phytec.com>, <d-gole@ti.com>
Subject: [PATCH 03/13] configs: phycore_am62ax_a53_defconfig: Enable capsule
 update
Date: Wed, 5 Mar 2025 05:58:28 +0100
Message-ID: <20250305045838.3614661-4-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305045838.3614661-1-w.egorov@phytec.de>
References: <20250305045838.3614661-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|DB8P195MB0534:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c6cbeb-aaa1-4ebf-7ba8-08dd5ba26b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?farSqy8QGU6s6DRHthLrXId6VipOaxY0Pof8hkQk0J2dEYb3taT3HJKfW4Ah?=
 =?us-ascii?Q?qycb6bzz9NJq9/R+J6/qHLlOMHaO7W2FmtnXxECUwWKLJ++Lu7gL2hA5jWIo?=
 =?us-ascii?Q?bsove557qbV6w2+vjXaNk5SbNTenxR8ahLM+QZbgPHqcw1/Al+W91bDOE9D1?=
 =?us-ascii?Q?xpW2N+JNlM+Rh2HiqZ9FdtSmVisuyWCZAMWbCLCeROHd/ttiBYjzDiFpb735?=
 =?us-ascii?Q?bhjF/kTgLiASSmjIdH1/87hwmlm3og7+t/ScsQwVdD3m1G6M/QtvFdJT25VF?=
 =?us-ascii?Q?dQ+Cw+VLJa/e+X/lby2xmDdiMM0pXH57l3F9iAMZO8YzxJiB+HzULFqrICsX?=
 =?us-ascii?Q?h6t7vcbObxhFzBc3IQfyQzeO+fmfBRwRhTItnyFUBRdCY3qzez/l1wuG3xNQ?=
 =?us-ascii?Q?eV5ak+3w7DgY4BZPx9ZylP6ADDFVHMfA09WkBvWXXSyAv0DvF7XliXfbGYWd?=
 =?us-ascii?Q?dw4lpBpJrT2sSz8w07rnLGIvWESnmrWG1Xh3kAMVhWj+b+I3V0ZQ34d8CYh7?=
 =?us-ascii?Q?Iwg0tfws5A0X/Stmw9f6BIASsJj4tPIlp/qOQyOkHAYUXjk2/rZdkZQ4nPWT?=
 =?us-ascii?Q?EQU9VQWbO6/gLwgRh+hUE2wB3PHuB7z82djBCy8cBy60jlLv0GwP9H6QxDDd?=
 =?us-ascii?Q?JWvdtlh5p0CLxGnsNFlXPf7UUL5bLMur9hyg1PTRk+TRr+nTHE9Bx/IoabrO?=
 =?us-ascii?Q?Eb96xXtpEX9p7C7nsEHivOdN9O4vd5XzsbPfRi46UCEKd3pqa2m4OjLoPVD+?=
 =?us-ascii?Q?kr3jGxsB2exSn/sr05IZ5BEjW6fZY/4aqKOYuueUqu5dXL5DeRExbdjalzUj?=
 =?us-ascii?Q?UCl9a8a/vyLt8WN3eMz2yz81Pbc6fb2y+4p54QB00aM0sn1bA+1tNYWvsuDx?=
 =?us-ascii?Q?dt4+g4qujPYye6Kc9K3me985/RAbPJMehlbYvCtisr/eAzRPycXi+nPS4y4X?=
 =?us-ascii?Q?VChF2CVJiA+24AWx5UwdqWqX8JBJx7OzLpZtMuTURC61/V/ciVh8hMQVW/TW?=
 =?us-ascii?Q?62+FCMnVw5a0TrsNJqCVg+UpmqqMtqp/olTOcz0AFlBT82jyk0mV9sOm1HbZ?=
 =?us-ascii?Q?Z60S4kjyaJUh5gmHPXwh0YrYDW3FBqi3zrL4THGmahhgniEPlpkRMfRT4UHM?=
 =?us-ascii?Q?CHZskIF0mA7l2yS5JpOsHYXjMgY7XiKi8nbd6ZoCKsFRcW/zjbKWn68EqwKC?=
 =?us-ascii?Q?WN+175qNBo2369R99FYUOa8GkvVuW0Z9lmG2i3kif0rjZmv1k9GrzucgFDEv?=
 =?us-ascii?Q?GnviipdjoMSC1vH6TiJW0NY6QoQMfVCrzlucLv+5D1+IBj5V5ANMrHG5QMaj?=
 =?us-ascii?Q?NFFYK7KDg5txjNMnE1QSLsD8sKg+8OhiD/diRwvOldznbBWqB9RqywjH9wNa?=
 =?us-ascii?Q?hJJ2OkOMsVYthHjBnI/S13ZOBlWiEGrZ/TChcmh/18x+Ryp10av1WdsHOlVZ?=
 =?us-ascii?Q?JbOqxczmQUD9QiOI1p9AAAg5FbsebtoDCUvzEGqEN72m/uId3RjePtWJMogx?=
 =?us-ascii?Q?M+Z5jQm81eRwrtU=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 04:58:49.5474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c6cbeb-aaa1-4ebf-7ba8-08dd5ba26b16
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0534
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

Enable raw & on disk capsule updates and provide configs required
for updating MTD devices. Also resync after savedefconfig.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 configs/phycore_am62ax_a53_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/configs/phycore_am62ax_a53_defconfig b/configs/phycore_am62ax_a53_defconfig
index 421dd851506..f8692f0b3b9 100644
--- a/configs/phycore_am62ax_a53_defconfig
+++ b/configs/phycore_am62ax_a53_defconfig
@@ -35,6 +35,9 @@ CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_EFI_SET_TIME=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
@@ -62,15 +65,20 @@ CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
 CONFIG_SPL_YMODEM_SUPPORT=y
+# CONFIG_CMD_BOOTEFI_HELLO is not set
+CONFIG_CMD_BOOTEFI_SELFTEST=y
+CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
+# CONFIG_CMD_POWEROFF is not set
 CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_RTC=y
 CONFIG_CMD_SMC=y
 CONFIG_OF_CONTROL=y
@@ -96,6 +104,7 @@ CONFIG_CLK=y
 CONFIG_SPL_CLK=y
 CONFIG_CLK_TI_SCI=y
 CONFIG_DFU_MMC=y
+CONFIG_DFU_MTD=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x40000
@@ -119,6 +128,7 @@ CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_AM654=y
 CONFIG_MTD=y
+CONFIG_DM_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 # CONFIG_SPI_FLASH_SMART_HWCAPS is not set
@@ -178,3 +188,4 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
 CONFIG_SPL_DFU=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
+# CONFIG_HEXDUMP is not set
-- 
2.34.1


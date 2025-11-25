Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83961D0EE0F
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 17:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1469F8413A;
	Tue, 25 Nov 2025 18:23:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="FPG5Unqv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3851E84132; Tue, 25 Nov 2025 18:23:40 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38E5884112
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 18:23:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DP8fHUPezY2ltIyUiNacQKwaNI5Itp+qrWMW4/48u+I2R61oDOjvHwvgipMNRcIsShem7n5NtYonZbS4+hD43Fhq/0fnY16erxr8P3goWtbj8tnBr6Biu/FEvKCG/dQ9iiUGnElBkGRd2pOGYKFNYS8IbW8+E/dY9JUHgCK5gRLUCFNChUCq2WcVNphEF1YOFpcCQLXZ7aiJdZlz2EKL8pVHYGpcPOHbCms8kiMCKNdl5JhbNhIccsj7xhaoY3ig8gZfMNq7PoAz8CdD6JKjtoEXYwVtRTHAtxTgsw7vQiUL+biZ/h/hI2G0b6+rb6GPoJF2CzQgyfDrYDibdjt7ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWZdmsNhpPLu/CEGq1gWBHhwTzBxu3oKGQ/xAPbFc3I=;
 b=cda2odHBAOHAw1ah3owY+q7yKh8NajR9GL6YT/a5nhMnPoqnEbpt1M9PMVNiPYrcDCndLXVWdJT0UDfhCsuTRFwMSRc9bvw4blZHHFyOmMA3JxBwaoIY/r6MKRzJeOqZUOxTyn26jCOTsIWCfSgkBx8+UeWHuCfKtyvaXpE6iICL51T3TXrhJ0m1+MihENl1+7rN46f/eBg51fljejqlANeHtHJmDLunRvavGi1pQrcZ7fFj/53mKp2iLlTPyiR6m9fyVqY1OSSwyfOANcj2wX2cifLBVBFCCfBdsZtSzQtsLSlvHNhzRMfWd+7foCwOKiJCKFLmExX76YURMVjTGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gmail.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWZdmsNhpPLu/CEGq1gWBHhwTzBxu3oKGQ/xAPbFc3I=;
 b=FPG5Unqv8Skseevp39HUcAiUSSKq/x4QFsaOnkUUip/uGwvqI57m4SZzfPXxJfgoIxVmXLk7bldhd7LNNm+c1v4+8dTTiX5whLhr+knU5qO8fJ9OYP+dogBZ3s+QRpc6SN0Qsf6aOx6VnFEtqSp+MzXk8NASlGgKWwRXCBjvRy8Ra5HZkkIn+1Ysm+Pp3r4/HWJbkQWolCRvfdQCxGQ8cbgOaDfEj1yXkSfilAjxL11iCiTDwqOjR/pN3KcD2X9/mfZ3jcP0vVfA/IavL5kIRwBTFqpjPT16JOTef2zOM1YTm+ijBQlyCFaMCiswbs4fHKl+giZsMH4PiD7FHU+9Sw==
Received: from DUZPR01CA0164.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::18) by GV2P195MB2258.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:150:d9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 17:23:31 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com
 (2603:10a6:10:4b3:cafe::f5) by DUZPR01CA0164.outlook.office365.com
 (2603:10a6:10:4b3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Tue,
 25 Nov 2025 17:23:30 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 17:23:31 +0000
Received: from [192.168.2.141] (172.25.39.126) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 25 Nov
 2025 18:23:29 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Tue, 25 Nov 2025 18:23:12 +0100
Subject: [PATCH 3/6] phytec: add emmc_dev and sd_dev env vars for imx8 boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251125-wip-bhahn-imx8_cleanup_env-v1-3-414829c01b4b@phytec.de>
References: <20251125-wip-bhahn-imx8_cleanup_env-v1-0-414829c01b4b@phytec.de>
In-Reply-To: <20251125-wip-bhahn-imx8_cleanup_env-v1-0-414829c01b4b@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, NXP i.MX U-Boot Team
 <uboot-imx@nxp.com>
CC: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>, "Peng
 Fan" <peng.fan@nxp.com>, Leonard Anderweit <l.anderweit@phytec.de>, "Marek
 Vasut" <marek.vasut+renesas@mailbox.org>, Martin Schwan <m.schwan@phytec.de>, 
 Yannic Moog <y.moog@phytec.de>, Simon Glass <sjg@chromium.org>, Yunus Bas
 <y.bas@phytec.de>, Stefano Babic <sbabic@nabladev.com>, Fabio Estevam
 <festevam@gmail.com>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764091408; l=1876;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=ixuCHGzrDhoHwh7pFuwISR+xZfD4iuTlf6Xh7Hszj40=;
 b=pA4LU3WAuUYYmi/sidSCOKC6zVLPAkcTFIuMZ3Du306bxqCCbPXKWCBfcM4phRaWM/2dxQ6HX
 DoFVpYU0ff7AbB5+ZwvZlHB0EWnYSVTfVSKjdWRvk8a9St1pxoOkvw/
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.39.126]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F5:EE_|GV2P195MB2258:EE_
X-MS-Office365-Filtering-Correlation-Id: 67b55a68-03d8-49b1-a7bf-08de2c475ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXpHZHNqY3UyR2lVaVNKaEYyeW1nNll3cFBFWlo5ZytiT3ZjczcyZDF3dzBq?=
 =?utf-8?B?alRLa296cURXWGw1UHlrNTVOWTQ3MjF2VkZ4Y01lNTIrZmtVOC9jRDF0SHIx?=
 =?utf-8?B?MEN4V05jRW9zZEtpRm1YVkhSQWVCWFpNbjB3TjA5K2tWN1Noa3ZBMmYxNnF4?=
 =?utf-8?B?ei9FNytDNEJaWnhTTTVWQjNrekNpTmtUbzRhSVRSMlloR3NjdUxwOVhpc2Jo?=
 =?utf-8?B?M011YjMwS3JUWU44eEo2R3dDTWxIOHBsYTdTUkluRnNwOW8xelo1RHlBMWo0?=
 =?utf-8?B?UWZ4ZnRITml3Kzh6cnpNOUY3N2NISmZITnNOM1p6K0RudkJVeDNWdDRwZml6?=
 =?utf-8?B?Y1ArY2hYOW93QmdlalJlalFhdmdLcFFNN2ZMdnFoMzU5dkFtQXJrbU55ajV6?=
 =?utf-8?B?VmJ0VmlQYlc0TnRUUHJualMwTndLVWc4UG1RYlhTOXFpRUV1U2VFU1lkS0dX?=
 =?utf-8?B?dDFBcnlacVhjN0lFWUhPNHVkMXFiU0ZwRnZlOW1kM2wzTG1VSGthbFNsQlF1?=
 =?utf-8?B?L0IxU1ZLSjg0OUFaYkdycHMyK1M0VzdzZlVvQ05ZaStqUGlWdys2SlM2RFJx?=
 =?utf-8?B?Y3d0aDRsVmFWUXNEQzBlencvNDFWWVJvb2pHNURGZ3ZwZ2E4QWJrRDZ6Mkhn?=
 =?utf-8?B?QzlUUWV3SEpPNW1SSVFIcGpIQm85VjZBc3B3SDdWd0RObThwcSsrZGxSbUF6?=
 =?utf-8?B?cFhZYVZWekJ3U2Q3alptUDFqdW1ZOGlEcUVrdnFBZGJDa2N4YW9hTnFKaEd4?=
 =?utf-8?B?Qm5nQkYzcWF2MENRWWplUE9jdU9qQkVNUGRrVEV3WndDaHJlVWo4R01IejJa?=
 =?utf-8?B?R1d2MUxPVFErY3ozcHZTQ0N5RzcwOXROb3RjeUJhRnQ3SXZ5RjREb2FudXpP?=
 =?utf-8?B?Sis0ZWs1Ulh1bUQxSzdyNUZpQUNtK3BUS1psUnNlVjdJeFJTc0dDTVpOcUZv?=
 =?utf-8?B?K0JNVnBBdnJmQmN4UWVTbk5YY041UUFIWVh2MzhoNGFIbStuRm15aDFqZ0dq?=
 =?utf-8?B?ZXJDNE9HYzJteW91WHVHRzNsSHhSVXVGUzZxWHV5MXFWaW01VzF2UG8vODVr?=
 =?utf-8?B?VXRtWGJUS2QyWWFQWngyVVIxc0JqdEltcVNtb00rZklLVDVxOEdodnNEMkN3?=
 =?utf-8?B?RjVaNEttVWIzNFQ2eE1lNWNwVFREblEyQW1pbTE3aXphQlhyZ0hWQytXVTFD?=
 =?utf-8?B?NVdmWkhLMTMzYkpldExqVkFyM0tYNUdMYUJuV05TcjNvNDMxakZSaCtKS2gr?=
 =?utf-8?B?MmNjRkxta3paMThGS1VCajQ3TWV4ZGUwWGJoaXZxL0IxcktQb2p3VkYrVmkv?=
 =?utf-8?B?R2pLZUFsSjRXUGM5MGdNQzkxbHU2ZmZtVWhJVmhHMW95ZkFzYzJZUDk3VGlP?=
 =?utf-8?B?Qm80anEvYmQxa2FsSkovenVkQytCNGVQaE1aRi9NODc3dWhvNXBjdkJFQ2lv?=
 =?utf-8?B?TmFzZnEwTkhCeWhUNWJzcmdSSGpzeUx0QytiS3VpVHlFZ21majBKNWcrT2oz?=
 =?utf-8?B?Y1Vmd3lGMGtuOFpMQ084cGphcHlqSFQ0QnJBYUl2cG9HTHpqWGhGRzVmQi92?=
 =?utf-8?B?c3NLTFBmQWJIVEtlbDNNdEpZT1lvanpDbEpWVWJRYmdiVll4QXNlVzM4YnJC?=
 =?utf-8?B?a2RnbFJ5NkVjTWp0RHUzdkpXUytYaElNREp3WVNVQXdIcnhRaGphUFpWZlRS?=
 =?utf-8?B?VkZYY1RTUVdEdmo4MUJncVlTQy9Db3JOK2tiZFJHZDAxNTJGNTl5SXcvNDVz?=
 =?utf-8?B?NzRmdXAyMGFCRXB4Tkh5SW1OVTJ4b3U4YmxNRUw5Q1REeW9CSExzWXVwV0VW?=
 =?utf-8?B?aFdBYVlMckUyclBvMVRheVM4eHBhcHJ4WUErT1NxQlBPdGdWclN5bEcrS1Vh?=
 =?utf-8?B?bHNTdzdpdXdBNkJyN0hteTY1Q2F4aE1WL3lBQTk5cTB6bEhMbk5Ham9rSVE1?=
 =?utf-8?B?VlcwWGQzYkdHbXpXQW9IZTJMcDEyME1Tc0V0b282TWY4cDlSWVhJTTZ4V2Zm?=
 =?utf-8?B?VmgwL2RyTnhwOTB4a0MzSVZOWEdranlyb0IxSzN2TEdNZUplSGpyQ1JsS0M0?=
 =?utf-8?B?UVcydVpBazZHSXB2VVdkTXV1czRXMWszS3ZSUWFIUzNvRG1YZENtb1Boam5Z?=
 =?utf-8?Q?dIps=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 17:23:31.1791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b55a68-03d8-49b1-a7bf-08de2c475ae5
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P195MB2258
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

Add emmc_dev and sd_dev env variables with comment that they are needed
for builtin uuu flash scripts. This is already done for imx8mp-libra
board.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 board/phytec/phycore_imx8mm/phycore_imx8mm.env | 3 ++-
 board/phytec/phycore_imx8mp/phycore_imx8mp.env | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/board/phytec/phycore_imx8mm/phycore_imx8mm.env b/board/phytec/phycore_imx8mm/phycore_imx8mm.env
index 1eb255878ba2..bb444d182939 100644
--- a/board/phytec/phycore_imx8mm/phycore_imx8mm.env
+++ b/board/phytec/phycore_imx8mm/phycore_imx8mm.env
@@ -1,6 +1,6 @@
 boot_script_dhcp=net_boot_fit.scr.uimg
 console=ttymxc2,CONFIG_BAUDRATE
-emmc_dev=2
+emmc_dev=2  /* This is needed by built-in uuu flash scripts */
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 fdt_addr_r=0x40480000
 fdt_overlay_addr_r=0x404a0000
@@ -12,5 +12,6 @@ ramdisk_addr_r=0x45802000
 scriptaddr=0x47600000
 script_offset_f=0x0
 script_size_f=0x2000
+sd_dev=1    /* This is needed by built-in uuu flash scripts */
 ip_dyn=yes
 nfsroot=/srv/nfs
diff --git a/board/phytec/phycore_imx8mp/phycore_imx8mp.env b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
index 96636651157d..cd95a9d21d7e 100644
--- a/board/phytec/phycore_imx8mp/phycore_imx8mp.env
+++ b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
@@ -7,6 +7,7 @@ boot_targets=mmc2 mmc1 usb ethernet
 bootenv_addr_r=0x49100000
 boot_script_dhcp=net_boot_fit.scr.uimg
 console=ttymxc0,115200
+emmc_dev=2  /* This is needed by built-in uuu flash scripts */
 fastboot_raw_partition_all=0 4194304
 fastboot_raw_partition_bootloader=64 8128
 fdt_addr_r=0x48000000
@@ -24,3 +25,4 @@ nfsroot=/srv/nfs
 pxefile_addr_r=0x58600000
 ramdisk_addr_r=0x5E000000
 scriptaddr=0x40000000
+sd_dev=1    /* This is needed by built-in uuu flash scripts */

-- 
2.43.0


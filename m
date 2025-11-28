Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D32D116F1
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 16:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3265783B99;
	Fri, 28 Nov 2025 17:39:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="jMyXLVSe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 263BF83B91; Fri, 28 Nov 2025 17:39:08 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6308683B8B
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 17:39:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yrl91znkBOvnQCU+Ik0MxcGxQIV2kHKzi7Or5K8Pnp4XgRbRlRS6CFNL0+e3y/xmhpt79fI7P5u7cBt3e//yYGkYDZ4lbXi7HV8TMWI+tMLFdhMpXo4BUqB5SGK0qojvsD4uJEyuyI7CwEWkwCUkeCmeQi0onGWwP0fvFuUxEDiYUBVR3Ausm9bqVcB6ptdf70hZEM/yKQw0eim7OafDCS/7cmaZ3YIwg2aZ90DUDIXxkqyT6Sb+yRkqV6EfGnq581+45arFhj6MOPDvuzzQ3+qjBu7pBUFB8uJhSXfHzAuxLe4Q8i2/9NM96qSJxN2curIxSTukjA7wMTrjsr18Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tZhUBKAXdAinnf82WRANjegO4d/mJKR9wX0dccg/4U=;
 b=gdYc979f3ut5LbKhGsWFVOdzIMf2a3XuMOIjwqCZCUMKqTJ5fuzMx5dt0vTs2vLpmokAOms2SeE9T3xVFzIolJb/81JA8fI+SZ68sk/FyDSxkkq9i/9v5GXAjDsA+V8sXE/YEjcnmbKCfqxMriI+bv1v/LqT8yJGHMnT5Uz0hJkrX67kd9z/K8JXfiFXMp1ovKu31WafavjgJYyvnXlvyl2JRbA1tGGa+3+q8AT5EDcM3//SZMmpUgrHrSvdp9FfLS2NEjjQQhvxb90xTJuraw/bAhtCilWqyogKzOVyAhRpGTuvXOtA1s7ZDypvI5YV2KJPB97Tg2NOflql3tuKtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=mailbox.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tZhUBKAXdAinnf82WRANjegO4d/mJKR9wX0dccg/4U=;
 b=jMyXLVSe2BgU3Cxu5DFb1rErjxUpmtJvUJEd4NpyDYUPi0HsfI53JXgqqYeT4/wQkDnjtVfOyK3eRm9jfhPoHyNk70cLUWu+FwPkTZmqgh1qJSeRauXevZYbVn1eLgl1CUkUV2PzVLnFJD/WsYJl32Ttirl/dPI3x9Xyv/vGgRCvC4WCWmtBoEiJTOxD9AdDaV2Y9gcJPZOvHAyUABN54+NvcsDlz87WTowcsmuJ4Brbmdp7cCYVoh2chA9JpeLu57iV4fOtm34lewIobOFWw/Sc6Os7COlIePl/g11t3BZO5XDCXPwStVzm7MjNT5lLPI9idtqwuLAB6jGW5Q1NUg==
Received: from CWLP123CA0245.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19e::14)
 by DB9P195MB2725.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:5e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Fri, 28 Nov
 2025 16:39:00 +0000
Received: from AMS0EPF000001B0.eurprd05.prod.outlook.com
 (2603:10a6:400:19e:cafe::e2) by CWLP123CA0245.outlook.office365.com
 (2603:10a6:400:19e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Fri,
 28 Nov 2025 16:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF000001B0.mail.protection.outlook.com (10.167.16.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 28 Nov 2025 16:39:00 +0000
Received: from [192.168.2.141] (172.25.39.126) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 28 Nov
 2025 17:38:59 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Fri, 28 Nov 2025 17:38:42 +0100
Subject: [PATCH v2 2/6] phytec: add emmc_dev and sd_dev env vars for imx8
 boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251128-wip-bhahn-imx8_cleanup_env-v2-2-93ebfd1591c7@phytec.de>
References: <20251128-wip-bhahn-imx8_cleanup_env-v2-0-93ebfd1591c7@phytec.de>
In-Reply-To: <20251128-wip-bhahn-imx8_cleanup_env-v2-0-93ebfd1591c7@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, NXP i.MX U-Boot Team
 <uboot-imx@nxp.com>
CC: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>, "Peng
 Fan" <peng.fan@nxp.com>, Leonard Anderweit <l.anderweit@phytec.de>, "Marek
 Vasut" <marek.vasut+renesas@mailbox.org>, Martin Schwan <m.schwan@phytec.de>, 
 Yannic Moog <y.moog@phytec.de>, Simon Glass <sjg@chromium.org>, Yunus Bas
 <y.bas@phytec.de>, Stefano Babic <sbabic@nabladev.com>, Fabio Estevam
 <festevam@gmail.com>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764347939; l=1865;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=PxNXgh60wvvIAtz3eBE0sx0O1aOyw3w0dsJkgxfr2kY=;
 b=m+K0+F8mYMSm50mj9NuujIfbztashWkAOcGnnH0JmxFzCx7FbuX3M9hwWWKbMRTNx8zkMMUrT
 GBIvGI1H2Y3D3N85ydcd2AtyIViFaV5EZZ51H/6ZPtXaHBjRSGQkdSg
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.39.126]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B0:EE_|DB9P195MB2725:EE_
X-MS-Office365-Filtering-Correlation-Id: 34426493-729f-42b5-c630-08de2e9ca264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkVmaUV2SWV0d3gxc2lRWmI4VXVpUTZzSnRZTlFWT3JWQktibEZmN0UwOU90?=
 =?utf-8?B?S3NaUlEyVXZBS0tIanMrRWcwWnZXYjM0RG42Y280VUxBRllqd2crdlhmSlkx?=
 =?utf-8?B?UnRKeFl5aXV6MGRRM0JpYzFhc0FSOEJTOWFFU0plUERVOE0xR1NxTXRNN0R3?=
 =?utf-8?B?eVU1ZE9IQmJlV2ZjT0huQ1pPMUN5b1M1NWlQbmtRM1lyRmRiaTR0S2VSYWRy?=
 =?utf-8?B?RGE0UVB4YzFRS1FzcHUvemlNNy8xeFZib1lOUTBsTmhwZ2R6UmVyUDVQbWtw?=
 =?utf-8?B?dHpJT2lxZG1WV1VRRTlReW14Z2J3bXhzRnVuR3VqbVJzbC9EN3JPNlh3c21Z?=
 =?utf-8?B?cVhjTlJtRDNvTkVIcENRcm1PZEFtQnlHeSt3akQydHVQSWtXdGYraVNVUHpm?=
 =?utf-8?B?MUVOMStEY3Q0NWwzSUx3M1Bna0owb2Z4UjBGRGp3Q1hVNW1PR1BzeDNLaDVq?=
 =?utf-8?B?NFVWaUpPNUkxSlkyUGpKSk5VT0drcmt0Q0pMdlBuRGtqaWFsdThCblB6M01I?=
 =?utf-8?B?aDFsdUlib0JZVkIrZzg4QUVPN3dzZkNoWXFLNnh6NWQ2MkRRZnYySXNhaWxO?=
 =?utf-8?B?cmhJZXB1NlNudGhKVnJjR1lIRFA1bGx2aG5MMGU3UnprOStaeEhwUHBEZFZ2?=
 =?utf-8?B?L2xUd2xQNjhUQk9VZHdrSDFQWnQ5bHp2RGE1M0gzM1pJWTN1SWdWZTV5bjV3?=
 =?utf-8?B?UEpXNFNwMjk4UjhCUzI1ek0zVmNYa0ZBNTJ0SCtLQVFtQzEzNDhFd2Ztc2Zw?=
 =?utf-8?B?US9SQjUxQ2d6d1IyVFQ4d1ZSanJnVStXRXY2bkhwRGtlWG5UNVBVN0N2WDEr?=
 =?utf-8?B?b3ppaG1MT2c0d2o0Z0pxRUkwMU5hbDBOSFNpR2swSE50bXFJUG0vZ2drVWw4?=
 =?utf-8?B?Y2tIOVNZd1lLd0kvajNUcHVWSm1DRURGUGlObnpOVXFIdmpXbVNYVGQ0c1Bw?=
 =?utf-8?B?VGN6d3pmSEpyYjlvN250VHZyU2FBdkpyckdEMWtmUkVKUld4eTlHeUVqQlE5?=
 =?utf-8?B?TXByQndZOEIzaDQ5enNNbHgwOC9Oc3hEQzFSdGc0M3JSZ2lldkFGTmd0QVBn?=
 =?utf-8?B?UEdBR1NPYUt1em5KY09uWXpuMXMvWnVuNE15aGJERzlVbGhFQzBZSmdlNXo1?=
 =?utf-8?B?SktsNkQyN2U4b2l0ZTVZNjJPSnFLSVg1LzFzVi8vZFZPRTgrN2NMV1pMdWN3?=
 =?utf-8?B?K0M4c3MrUVdwaVgvYnV3MGI3cjdhVG9wUEhVNjhaRzRYbm94SUdtOFVmVU1R?=
 =?utf-8?B?eXhxWUhBT0VCTmt6dVdSL0swZ0pCeXFVT0d5L2xxaHEyODVnRnM1QmRjd0dO?=
 =?utf-8?B?eTRQdE9OUCtyZlB6QkkvVjRCaWhRK05BSnJzMlB3OHgrMkRwMVc3OGpPeUg3?=
 =?utf-8?B?VWF4ZXFzc3lnT0hSaW9oRHluNWR2UXBFZmJKeXArWFRNQnloMjdPb29yclla?=
 =?utf-8?B?SU91Y3g1WjVuVzloUk0vaUd6Z3RPR3RMM1Q2Q3RxOWxuUzlZTFhiaWpCV0ZI?=
 =?utf-8?B?UjdMcnlSR2tNVVV1MUYvcGZnNnc2ZU5oSGd4TkRndGtvQUlhZmNSWHd2WUkx?=
 =?utf-8?B?TjZHYUc4UnM0b3FHeldkQTFaQld0VEFUMlZNYkRScGNJTW4yM25MRWFpbzY1?=
 =?utf-8?B?LzJ5bHlxdzNUR1l6eWJyMjRHNldiZ1RHYWdzeks0aXVINkhwaDl6MzltcC9t?=
 =?utf-8?B?Z09hd2duOHBBUDZmSzZxeFdCU0JyNUZraDFkZUJwcmZvL3lUQ09aZUVzaHM1?=
 =?utf-8?B?ZGRDdEdOWHBaaVJ0V2lFTS9jeEI1bXd3c1VZWHVxV3NXVDcwTUNndC9sZUg1?=
 =?utf-8?B?WVdvcFBQMTR2djJOMWh1WTBwcEZOUE5EMzNKclFiMVp3Nk03SU1pMlUyRkxQ?=
 =?utf-8?B?WHIrSlVUREI1NmFmdTZwNUliUlVheTd1Y0JxTkpnWXhuWDRyMDlLV0wyQnF5?=
 =?utf-8?B?eTUzRkhhb3lZZUJPZGNUZW43OWZFOE84S0Z4WkYzcjhnVzhLd0dYd0ZYVXJM?=
 =?utf-8?B?S0VSK0JKLy9sWk9kZkdPOVFwckhyeEFNaXk1T3U3QnlnNXh0TTNnK0h5Z1lF?=
 =?utf-8?B?anFvV00rVGVlbWFlTTJ0MSthZFZFcmJNQVd3UlpKU2NwSU45SUNaN3puaVhT?=
 =?utf-8?Q?rowQ=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 16:39:00.7083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34426493-729f-42b5-c630-08de2e9ca264
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB2725
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
index 8fa275e388cf..1ebd9f06a0c4 100644
--- a/board/phytec/phycore_imx8mp/phycore_imx8mp.env
+++ b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
@@ -12,6 +12,7 @@ boot_targets=mmc2 mmc1 usb ethernet
 boot_script_dhcp=net_boot_fit.scr.uimg
 console=ttymxc0,115200
 dofastboot=0
+emmc_dev=2  /* This is needed by built-in uuu flash scripts */
 fastboot_raw_partition_all=0 4194304
 fastboot_raw_partition_bootloader=64 8128
 fdt_addr_r=0x48000000
@@ -29,3 +30,4 @@ nfsroot=/srv/nfs
 pxefile_addr_r=0x58600000
 ramdisk_addr_r=0x5E000000
 scriptaddr=0x40000000
+sd_dev=1    /* This is needed by built-in uuu flash scripts */

-- 
2.43.0


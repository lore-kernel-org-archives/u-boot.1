Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08398D116F1
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 16:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ECED83C08;
	Fri, 28 Nov 2025 17:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="O0MszeTm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DA04838FA; Fri, 28 Nov 2025 17:39:08 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C726183B99
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 17:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSgCZQTpKXVHsqCSGV+X3SjPscjjyqOwrYqWue5yB0rRW7n5JUsp1YmcQLbm/oB1t9zK6E3yoKnXnfoSrX0yYMiOkxUJD3Qbi+iFVFrCYvv5OJxJuQ40EyV/VNZxJijcmtWfiQlLfgEFU3Xzipp9vtlpL92Cz3dn7KQaqPUHu5ROnhcXN/0lY0IwvXosYPSn4fk7cvzEutJ4IZuNMnUcPetup6loV8oU+vHleNzKXkxnQaqOaikOXmsk8+jfreA7W4CnF700dEa0EYmJlytNdOnBxGW2d0VFtf4gS07N7S0C2/cNr8YMeFtFL/DaFBFD+rqRMZHuU2KLAINQNp2dWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQEaDA6bG7M8NPFufiHjP86I7zfULXpprgA0hxXpDok=;
 b=Iw8NYpS20I1t2k5GI1CbduRy6JBICJeKs4atVs5RQ2sQr0oCLnf+jpdtZPay+d6zac/VvJLFZG3PSjVUgE229M7MRnOQ8luKHVOmXyh1/s2KJj5HqBMRSe2v/KKBQnAPR8MWEMNcIbZMhBrpp+3wY9cTo+BrvBkk16jgOMEjcF2QBJGZiDxoiynP0W4hF4miRlPpYq2s/X1wr+Y3U5GhALEJxzRSALiZQWkcTquhCnUse7KmG/vObqpsWa6akzQ/AHBcQSo94cRe4M16y6wPqj+oUEmTVHHVK05817XKDgkREtl42J/VC7g4jXDQIAZkrFZe2QUiDKWbkrumM0yWwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=mailbox.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQEaDA6bG7M8NPFufiHjP86I7zfULXpprgA0hxXpDok=;
 b=O0MszeTm73jfRPuI8u+D0oD+DSY0cp+3MNrLYwijqZQ8kQhFZ/h5RlHn0zAHRA8Joa8HepRpQt4cZeSbEWlWaVE69Js7NAT3KH3Q58meBcTYsBi1tov7EnjcY8kcRkIFyhWuzlHhTk7fVhfs7zunhqtYAPNoIOYTae0xsisEeunAifewFfoOBSp0XBCXfdzXxTj9fuhiKnMjMwpKIvfjBcp6uxMdfoIOLlrchIOuKYlWiHHMCBJDG31O4jyxuckn/QqHHaljmm4RYipZLFBhM1d5Ck3G7/+uU77rcamWtMIaMKZ8GEg0eFpM56I0zfv6y+BJ/okjKcmwuxDLxFgvlQ==
Received: from CWLP123CA0256.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19e::16)
 by PA6P195MB3195.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:523::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 16:39:03 +0000
Received: from AMS0EPF000001B0.eurprd05.prod.outlook.com
 (2603:10a6:400:19e:cafe::c0) by CWLP123CA0256.outlook.office365.com
 (2603:10a6:400:19e::16) with Microsoft SMTP Server (version=TLS1_3,
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
 15.20.9388.8 via Frontend Transport; Fri, 28 Nov 2025 16:39:02 +0000
Received: from [192.168.2.141] (172.25.39.126) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 28 Nov
 2025 17:39:00 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Fri, 28 Nov 2025 17:38:46 +0100
Subject: [PATCH v2 6/6] phytec: sort .env files alphabetically for imx8 boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251128-wip-bhahn-imx8_cleanup_env-v2-6-93ebfd1591c7@phytec.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764347939; l=2179;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=18A5Lnn/ufC8WAgTDIy1v9KrvTt5Tf6xG172p0fwk2U=;
 b=KYLrivGcIrzsvHHL5NZO1xjACTWmZeiG/YwpNbdt8H5Tz3vzmnF/OnhOSH7hoV1rKYBSpC1Os
 iyV2aWyZ5drC5QDK4CtQ5NA3NxAsTuIa/BvCwDenIWhX2uN7emSv+W6
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.39.126]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B0:EE_|PA6P195MB3195:EE_
X-MS-Office365-Filtering-Correlation-Id: ca441f68-47fa-42cb-6b61-08de2e9ca3b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUtKU2t5Y1NodnpBaElrZHdiNjR1dmNvdk42cGdnankvMmJkL2N4ZmptdXFo?=
 =?utf-8?B?M0pLOW9UejlWa202OEk1Tlg5Qlp5V0dVWTRLOHZsZjdGclFIbVdobSt4NXFw?=
 =?utf-8?B?ejZ3cGxZSllLbXAvSlU3NFF3dC8zVUdLUXpXRmduL1NKNzJEcEFhY2VWY1M2?=
 =?utf-8?B?akFxOEhwZkFNaitBcnMyTERsblRvRU1NWnhqODhaRXhmUnRDZFl0cXMwdTgv?=
 =?utf-8?B?bUpiUGp0RU91UzFRWXM5M2dPTS80aVpJWDFtVFVGSEdFMXFsbXBzL1MzSlVC?=
 =?utf-8?B?QVBuNGZaMGFuK1BnN0FyOTZxWUJxbFdBeWJYR0x0b0hCSDNaTkY5NXFlWEpP?=
 =?utf-8?B?YnFIb0FHbEtmaXRkbzdWbXBkMmRSQ3RMWVZEbEF4ek1vQk9nWGdubnd4VTNC?=
 =?utf-8?B?M2FJcnRldzdZcEpJYmNmMFhjbzJZTm95U0MyelgzUDAveG1NQUJ5emh6OGh4?=
 =?utf-8?B?VnhhM01XaFFqRlAyUk84RmhhUmUvWWE3N0Q0U3RSZDAwRXB5N3VxbDErUVB6?=
 =?utf-8?B?dVluRHNMMzhVS2taWS9GZXRKb09jVkpPMkhiT25FUHhmbzNHZnFvNXAvUmhi?=
 =?utf-8?B?N3pmcDlUNDhESTVpWldwVXE2OFJyb2hEdVhOa2ZtL3luY0xtNmpnbTNHRXRq?=
 =?utf-8?B?MWxNZkc2WEs0TDF1Ukt5cy9SbnpFNTVwY2FXMnVFaDAzWXJvOGl4RlpZelpX?=
 =?utf-8?B?SnhndnB5RnBXM1YxT0c2c1k0TGRSSnFtNm1BWFQ1d0E5VDljQWxQWnFLT1hq?=
 =?utf-8?B?NTA0NXhRQ3VTNjlXQm9ub1lvTC9Zbzl5NjF6QjZrQjREUUtpMkNXTmlxN2p0?=
 =?utf-8?B?TmdWakdJbWZWb3hwc3liRG5NMVorNXVqRmE0Y01qenY3RUc0dkxPNWtQU2RN?=
 =?utf-8?B?MVA3c1Z0UkRXVzB3VHUwY0gxc3VrSDMwaUpyWkl4ZitxNkJtOUswd3FrTHZq?=
 =?utf-8?B?ZWp3NjZ2cnVndGxYakdORlRvallrVnhqV1l6V3FCWEJFUlQwa2E1ZXlWcVMr?=
 =?utf-8?B?RG01VkJBTTJaRnkzcENHQ3UwaXd3TDZ1dDZWNFQwbWRESUkxL0R6RGZaVGMr?=
 =?utf-8?B?SXJPdW9XVk13c3IvSjYvQmF6KzAzOWpBNk91Wk9uSWdzam93OXNEUzRySmZq?=
 =?utf-8?B?MGZZbGpUc0xPQVVWc2NlaHo1OXY3NzVXbGRjQmhTMHh4Q1Vjb2pUOHZKZ3Bn?=
 =?utf-8?B?eGdMeFdwdW1tODN6cEZEdU5heUo5RU1IZFMrZFliZzJFckI2ZTBVOTBHbjVE?=
 =?utf-8?B?cFFhaHF4OUp1bGVMUjJmOUV0Z0JLaGpTR2psKzlQQ3A5T3FxWGE3TG1zQVZN?=
 =?utf-8?B?L0Jadm1zRE1FN1JUb1cvdFNiUDROOVU4UWNmc1lHaTB4RDJpcTRGWFRlWHFj?=
 =?utf-8?B?ZmVCVk5PbS9HWWJlaVdTRTRIWEg0SFQ3bzF6OTFsZHVXZ0dRNWlRZUV2SFUy?=
 =?utf-8?B?N0M3dmtkRnJhVWwzRGVRWHRJMVR4NEQ2QXNqNVZtTDByM1JzWVI0Wmp6Kzd6?=
 =?utf-8?B?Rk85d0hhWEdYZkVSTVFjMjlqVjlMUUNSdS8wUUlQMFFZUGZVU1RoSUhjc1Jj?=
 =?utf-8?B?dHhJVjJiMWh5aXlwRXJHTzJtdU43Q0FuT04wd0RxRExIU0psWWo1bTNXbzdk?=
 =?utf-8?B?amZxQm4yZmlham1rS1lVUmowaEtUaVRqa3g3bnRySWQ4eElDMHpuR1lZbWFP?=
 =?utf-8?B?Nm4wNFBaK2wxaGRvcmNFN3hzOStYZXI2K2FNNFpaUG1ETGRIVFhpbkpYc294?=
 =?utf-8?B?U3JOQWxYclV6TXJOWTcxdzl2Zk1iOGRBUlU5a0dBSWJyWlAxSmVxTU8wM0RB?=
 =?utf-8?B?STB0cS9weUtLNFVmQmdQQ3Z1MFR1bTFSaitNZ3E5VW1RQWhZY1pVTHZ4SXlw?=
 =?utf-8?B?ai9odE9GR1RPZlhmNllTS0ZNRWtHYUVwTDhGa21Eb21SZ2xGS052OUNiby9U?=
 =?utf-8?B?SWVVQ1Baa1E2cHg1SlhrVUxhZzRScFhVaWtnT1gyZ2FiaGxWS1N1djJPcHBn?=
 =?utf-8?B?MEIyYzY5Q3h5bUpyQmp1cndmTi9kWllUN1IvckRzV3NuZm11eXBBWUNWUStD?=
 =?utf-8?B?dCtqMW9wV0l3L3BuWDdvdEx0UkdBZitkYVFsUGtNNEcrT0k2aUIxV1hrQXhq?=
 =?utf-8?Q?nFxc=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 16:39:02.9217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca441f68-47fa-42cb-6b61-08de2e9ca3b6
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6P195MB3195
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

Sort all .env files alphabetically like it is already done for
phycore_imx8mp.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env | 8 ++++----
 board/phytec/phycore_imx8mm/phycore_imx8mm.env       | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env b/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env
index b9f0b2fb8ccc..f064bbe3d31e 100644
--- a/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env
+++ b/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env
@@ -1,17 +1,17 @@
 boot_script_dhcp=net_boot_fit.scr.uimg
 console=ttymxc3,CONFIG_BAUDRATE
 emmc_dev=2  /* This is needed by built-in uuu flash scripts */
-fdtfile=CONFIG_DEFAULT_FDT_FILE
 fdt_addr_r=0x40480000
+fdtfile=CONFIG_DEFAULT_FDT_FILE
 fdtoverlay_addr_r=0x404a0000
+ip_dyn=yes
 kernel_addr_r=0x40a00000
 kernel_comp_addr_r=0x43a00000
 kernel_comp_size=0x1e00000
+nfsroot=/srv/nfs
 pxefile_addr_r=0x45800000
 ramdisk_addr_r=0x45802000
-scriptaddr=0x47600000
 script_offset_f=0x0
 script_size_f=0x2000
+scriptaddr=0x47600000
 sd_dev=1    /* This is needed by built-in uuu flash scripts */
-ip_dyn=yes
-nfsroot=/srv/nfs
diff --git a/board/phytec/phycore_imx8mm/phycore_imx8mm.env b/board/phytec/phycore_imx8mm/phycore_imx8mm.env
index 4bf017a20baf..f6d0c0553b5d 100644
--- a/board/phytec/phycore_imx8mm/phycore_imx8mm.env
+++ b/board/phytec/phycore_imx8mm/phycore_imx8mm.env
@@ -1,17 +1,17 @@
 boot_script_dhcp=net_boot_fit.scr.uimg
 console=ttymxc2,CONFIG_BAUDRATE
 emmc_dev=2  /* This is needed by built-in uuu flash scripts */
-fdtfile=CONFIG_DEFAULT_FDT_FILE
 fdt_addr_r=0x40480000
+fdtfile=CONFIG_DEFAULT_FDT_FILE
 fdtoverlay_addr_r=0x404a0000
+ip_dyn=yes
 kernel_addr_r=0x40a00000
 kernel_comp_addr_r=0x43a00000
 kernel_comp_size=0x1e00000
+nfsroot=/srv/nfs
 pxefile_addr_r=0x45800000
 ramdisk_addr_r=0x45802000
-scriptaddr=0x47600000
 script_offset_f=0x0
 script_size_f=0x2000
+scriptaddr=0x47600000
 sd_dev=1    /* This is needed by built-in uuu flash scripts */
-ip_dyn=yes
-nfsroot=/srv/nfs

-- 
2.43.0


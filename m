Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C301CAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 09:44:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8A1583071;
	Tue, 16 Sep 2025 11:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ocGth58b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6470D8309A; Tue, 16 Sep 2025 11:44:50 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F8F4803CC
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:44:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsWZcFAKzy1pmZYFyaozyIFN8cWc9CFxb5xMPDXAx2IPzxVsoa0t7ehCbkdQxXmdRWtsCwYxdxgF3VHTtbyQnhIhRm2NGRAJvD8Z3vpQnrdhbDal6pEHAd+o7+yefFesJObMgS++fz832G1cdeKJAH9UIL9NG2Yah+57DRQMh3WAKvzevcPD+n6iF+uAU1W80DSpB4G86PWAKE2nI5ibhy9ExbYNgTt2D0Nn7YoxQ5W/+MNkdEbOadzQUTogRoXMZXn+r3B5skG2+zlJY5zNUo3rzz3fL7T7QKp5AnuQ8Kp9oQNfgHg1QLoDUFU89z7H7uRFLACoRtJO2ybIdCezIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7WcCTP760eH4LyMAHDSWCu4i/VVJcsODUkPm/xG+io=;
 b=dpmFRnLf1waNIWeEqcIfBJo3W2cfihkcutH+Y1ivN++Jbfkx57FkSiyFeGP8QasO3cqJC1f7wJEgk6sgxbytYxukpSJ/s67kZ6XmKvkIpHCeiFHBu+BTgvtF8Jlv0GFhcARt6dfKEBl+5vy6F8D2qdaPIQtxMFOR9OItEQDp6Cp8ZtlmaLswy5IUBYSCZnMMRjpmgCDR5bAgJlKlxf3V8ca6zKiS7SwtD613C1f8CNbMjDwrMkX8gGfq2CgAXH0ld1HRjeMmRuj22l2dSHYt5Zy0qY7tzQD71UDg3aqMhSzCW7E4JoO1l2HKh3qB9B7yPI+4ZvC6NQ/C8SiOJBKZFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7WcCTP760eH4LyMAHDSWCu4i/VVJcsODUkPm/xG+io=;
 b=ocGth58bMo/ROyiSvHLRQmdMj5QEqUFhroy5Q9+QvOiq8kO77D4q/ORQdIqfoOfznbMk+DMgUSMLhazBm5upLQEy6m6GNCiKeWKqbClFHakrCa37x7OfEw5LO0uARCS+Fgv9fd0AMNGgyVZ4k/zF7ZF5e5BxPjnzs/IPVSOhiq0ve6+QmbqZyg/R2X69jsDurUIemQh212acgdn8Y/zrvIqA7Wj/l1n3sWC4GsNnN0GbZVbISElEgJjpE2phM7QJ9y/tVch6a35gB6+fRTnN917iL/uX395Eh1gkEZ9TqBLH/nbhWS8ZhHAJMXL3U79NSTXRI4mBgzZ3HyeRufA1kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB9391.eurprd04.prod.outlook.com (2603:10a6:102:2aa::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Tue, 16 Sep
 2025 09:44:45 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 09:44:45 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: sbabic@nabladev.com, festevam@gmail.com, uboot-imx@nxp.com,
 trini@konsulko.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, ye.li@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com
Subject: [v2 01/12] imx9: Add i.MX94 CPU type and SoC-level Kconfig
Date: Sun,  7 Sep 2025 04:37:31 +0800
Message-ID: <20250906203743.3352805-2-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250906203743.3352805-1-alice.guo@oss.nxp.com>
References: <20250906203743.3352805-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0162.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::18) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA4PR04MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ce30a5-77d4-4da6-7a65-08ddf505aad4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zur4e77yKFQmm8ajrE2vHP/45++V/H9WeMvTLCnszZJuGwUDx1ZqqdibWn4n?=
 =?us-ascii?Q?nMvztl9YjwXWe2vkmjggNlj9whYvCLqSBeq3ehU/NHz2a8nWkJW7PNiXEojc?=
 =?us-ascii?Q?w2cVKUW0g8kDrgTimoJZk7dOogI8SDmNjBsftcD5Wf9iXsWFZ88XyArBuN3C?=
 =?us-ascii?Q?lNAY5XthZbRybbEH0Y3zHljcHyEjKTlHpCnT6xeFV0qpz8hUnB0IQjFBcqYb?=
 =?us-ascii?Q?BCR05G5hboPYkDtyjISLFx0i6XGTtZrx5j6Ih9oSsXda7dEG64AwWIKg004r?=
 =?us-ascii?Q?xb3zsNdc8RpKONtqEHqoZH2IyyRj5IErHWyleNXPg/XTJDTdgpjVXskuXPP1?=
 =?us-ascii?Q?EPCn7p8wV3O+nxO3q3/jZqqnYXfG+cK6whpb6i/RwcFeWYfEvDdARpZgt2oL?=
 =?us-ascii?Q?nkVQTkI7rwa9gkepAsCAxlyVKt9a4QtDelXfXhI8BLAOwC8HKrfaUiw3FA2p?=
 =?us-ascii?Q?31mAxhhmTFP1lOGKT/UPUicCufYoZ6IzLd+O5G1FtFWt+qdCguaWf8L9Lo3U?=
 =?us-ascii?Q?lkKSMAS4JWYUF2B+lvDnz5pEgqvTEpSYA0BkkO5mtJqAFU5wEKXPIQvXpuJO?=
 =?us-ascii?Q?mRT2NvvAoTous42lDJsUFN7KVIJqTofEyrfBtvpEsIeXa5tKT20kll3FKcl+?=
 =?us-ascii?Q?1R3vmO86psJBm7OKIoSbYtFTZj+2JUjBr3g2flZWuaSiDapyVBgxukQCI/Yt?=
 =?us-ascii?Q?nGPaIcG6uKMhlI83hoqHYUWtVv6B/fe0jG+XYDpo61p/MndQNjoMqe1yf4G0?=
 =?us-ascii?Q?yKY/wfEWT2h6vfSc6Au4D9Ur8fI++hc9hyZVHF1CFgUqleM4tq4Q2n2/dS01?=
 =?us-ascii?Q?Nr091JTY1ANqo6f/GLV6kdkrz6eFZRYFqc+Rhe9XdtaRWTJe9dWTQhvLnNIM?=
 =?us-ascii?Q?z5p6TC/oeUl6JTdNiStp4lbFErM/LHwXLDOfkRaU8paRd6nwp5hI/BJknYfT?=
 =?us-ascii?Q?y2ddoFT1yLvBKWA1hTc2WPc2AYRsTLHyw8fqCrrH+d1SCzHD8nYwvKjdZe4a?=
 =?us-ascii?Q?XYvaBS7PTE3yLi46VPXbRXBMFB9+UrNo15+L1RTPFWydrHSExrhFne57gEc3?=
 =?us-ascii?Q?Ln2S1bPYaJ3MnsZKJECV/LpFmDktSeVcsAtTq95JOsu+3ehMwAPK0WNsfWBT?=
 =?us-ascii?Q?SuxOc01QMd2cYNurnT02qKUsaw+PcGvgP6XHFTjcJF90G33OEZMNvJuDY9ul?=
 =?us-ascii?Q?1yZ5aQJva7HwWA8PwSlI6pOPULBoYYbhh0YwOuWhxqlY4YpGOv77SPAxv21+?=
 =?us-ascii?Q?aa/WhyOgy0llAAPcFv0rNrdWDcjAyEO00V2Mh3U+op51ztS2VKFgh+sopXxR?=
 =?us-ascii?Q?noe+uVTD2WFKj6T7ydlwTyFrD+HQlwDnJW7rqNexGvJ2qUeNnvMxrmSh/a3i?=
 =?us-ascii?Q?8d1kTWiNVGkbMxj0WId9zf2X9AoEUch0l7/itpn/H1zXYMBzA2Zsr2nWvMev?=
 =?us-ascii?Q?356rI6jeE4kAoOyLGlzxzn0+4EsiQMjVeoyZBS36bwy54LwWp2GXgQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mPxgvbp6F9qsEO68z6p21HQMUim3S1rNzOxbg2s+7oqKpDoh9bCuDjuyBIjb?=
 =?us-ascii?Q?WiB5M9CT+gqyvxNH5LvWy5C5+HKk2AO2mz0YbtMd7YNX/bkmwfRz5Sdk9/Q+?=
 =?us-ascii?Q?pgdyEOr/LgLxF2LCRvKTZWsf5+KgMHJN3isjl5J34WinlPaya1lFDoBgM6Qj?=
 =?us-ascii?Q?L0nmCzSdYWZyl/fLesXbWTGT7e0h16pICij5tIkNHqlA5awc+pgpordL4dVI?=
 =?us-ascii?Q?NoaxQ9tjtoB8+HAwG6JslhGm/0vm79UeaV9hNCdTgP3aIfBJnwICEM3sZ1wK?=
 =?us-ascii?Q?tJ5HDFJMR/xb69wfeDSgedRYe+xlxApqiROcy+B6I3q+HGfXIvInvN8GUnPH?=
 =?us-ascii?Q?VzSTFJkSdS3GlXMp3J1bs3WRIP4C+BZvo7fmbAsUVfXvLGmkwASZpIqBPMpd?=
 =?us-ascii?Q?FUF1LHvUfyNMcUNBB3XcB2rv/gi4cGna8jhyI5t3rdg9dhdIIqOqDs0EFru/?=
 =?us-ascii?Q?rLRV+KsreV68xF5aYuL47xux/Rq8x07+VcaIfR7kYFyr0buLecN7Qx7G4cCR?=
 =?us-ascii?Q?4g4uC7rjnD78qvr7IDqeSiai0PHnzt9TGMgLrIxk1dtjTjIirdXd8e3c/M+U?=
 =?us-ascii?Q?/lcW5aeXfqJQlXkt8Y7r92V+VKJ5+wFfvHsGTyxwKPL3g0z7ywVYYYhqKh+4?=
 =?us-ascii?Q?BDO38ljiCJRweQopUZLLPBgemCfeBrRUBxV4SXEnXlLaf9bTiNMv6MGf6vQX?=
 =?us-ascii?Q?EiNU/MMIxqIltDuIxdWYFfzl0sUmd51hKwbYrhNWtRAqtnOH/NxByJtVjtoG?=
 =?us-ascii?Q?EBMilVev/IMPmn21s9I7YPryM133eq9kzgHepcuEu7ux+S2m2QExyGrJ81mg?=
 =?us-ascii?Q?NkO+yfZHmld2C5j3EmluQjEIaFz+bi5lvyJDYhuzurYolnk2oCeZ5LayIf7N?=
 =?us-ascii?Q?lz18WOAWVEIJN5SxeOlUb0y5T6tnZs/c4X4xTN1eXLAs0KqQCNFRAuplBz8s?=
 =?us-ascii?Q?QBxujXol/Iz6ZAwpR4zFabmKRMCSV/5FLGZBFLVa7M5ApFYKUP2NTdkw22Ec?=
 =?us-ascii?Q?FhiAT5qDFuR0lc7F+xV/leatoFbT9zQMi9dwYThX4T3s3a9D3fjZT7Tz1fEp?=
 =?us-ascii?Q?vcRWxxFatkGKyL/hz7fWhCead8kcRLHj3jWcthKUHx6/U74+rR90/Is+98hM?=
 =?us-ascii?Q?VLbXtNh1VzCKOO/WWbRq/Bd2OXD6EqPSIemb26x4OwfYIhc0InubhuKLzbjH?=
 =?us-ascii?Q?7PRY/OHWY3maxsFPc2zOPUaHlXSpOtQp6tsATvbkH/F5M9en7T+Z6ZlO8WMi?=
 =?us-ascii?Q?/XcqJihNLNU/QR1QptxMuD5N0kPCZ/1xQkQDfj2LXg9SyeDs3JJTCMKcFUbZ?=
 =?us-ascii?Q?3NpBrYNWMVRhOTo6A5B6yHGJcJiww1IXzOWSRy9B+VlFhn5IY+afVYwvVfXO?=
 =?us-ascii?Q?iT0vEk5Hcqxm7vW8yjcFZH3jOrVvLyyknilPlU5e862uwPdLSx0unIOfyKkG?=
 =?us-ascii?Q?+c9oMJyoV5zMZSrYrcW0jWjUeFWryzHtBZv9qJN7FWQCnSLnSf9ncOLvfS6V?=
 =?us-ascii?Q?AWArTrhFImFlSYosv7TpeOer5DKItsC+ZjRMPB5+S3BxZyM/jaaE6sBOrK3/?=
 =?us-ascii?Q?32LpLxdhLN1QktLqCZPtzdLmfrLhclyZZ6Dr6pFu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ce30a5-77d4-4da6-7a65-08ddf505aad4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 09:44:44.9719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBwcV2ZfVKapJlMlpoH7AOyCjti2LDJjWlEkjraFu5i/0WPkcqCUGvzzbsBLnjaDGavuLA/WqoR1fpaXMotTRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9391
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

From: Ye Li <ye.li@nxp.com>

Introduce support for the new i.MX94 processor, including its CPU type
and SoC-level Kconfig entry.

The i.MX94 is a new member of the i.MX9 family. It uses a System Manager
to handle system-level functions such as power, clock, sensor and pin
control. The System Manager runs on a Cortex-M processor, while the
Cortex-A processor communicates with it via the ARM SCMI protocol and a
messaging unit.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
---
 arch/arm/include/asm/arch-imx/cpu.h       | 2 ++
 arch/arm/include/asm/mach-imx/sys_proto.h | 1 +
 arch/arm/mach-imx/imx9/Kconfig            | 9 +++++++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm/include/asm/arch-imx/cpu.h b/arch/arm/include/asm/arch-imx/cpu.h
index 1f669c72d00..1af9778f8ce 100644
--- a/arch/arm/include/asm/arch-imx/cpu.h
+++ b/arch/arm/include/asm/arch-imx/cpu.h
@@ -78,6 +78,8 @@
 
 #define MXC_CPU_IMX95		0x1C1 /* dummy ID */
 
+#define MXC_CPU_IMX94		0x1C2 /* dummy ID */
+
 #define MXC_SOC_MX6		0x60
 #define MXC_SOC_MX7		0x70
 #define MXC_SOC_IMX8M		0x80
diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index 0780f99b49a..46da7a1eff5 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -97,6 +97,7 @@ struct bd_info;
 #define is_imx9302() (is_cpu_type(MXC_CPU_IMX9302))
 #define is_imx9301() (is_cpu_type(MXC_CPU_IMX9301))
 
+#define is_imx94() (is_cpu_type(MXC_CPU_IMX94))
 #define is_imx95() (is_cpu_type(MXC_CPU_IMX95))
 
 #define is_imx9121() (is_cpu_type(MXC_CPU_IMX9121))
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index b6acbb20ff0..f2011448c23 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -38,6 +38,15 @@ config IMX95
 	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
 	select IMX_PQC_SUPPORT if !IMX95_A0
 
+config IMX94
+	bool
+	select ARMV8_SPL_EXCEPTION_VECTORS
+	select DM_MAILBOX
+	select IMX9
+	select IMX_PQC_SUPPORT
+	select SCMI_FIRMWARE
+	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
+
 config SYS_SOC
 	default "imx9"
 
-- 
2.43.0


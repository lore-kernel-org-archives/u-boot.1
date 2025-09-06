Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25E5CAC599
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 09:45:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F6CF83071;
	Tue, 16 Sep 2025 11:45:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Lg0WDs87";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D310F8323A; Tue, 16 Sep 2025 11:45:26 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1269803CC
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:45:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrUTrWGpunmVC+w2Swvy7UMfDQMrXDa9Miy2131O0W9XCj+GEEg6rYv+dyVyG5pxrEnMRgc0X3XE/YXlfm3NxJfgdIAmQU2bm80B/gOQ8c+HFK33jznd9Bvs8BlQ6pH4LpdUv9s60f/b2UdjF5ugpRBp0A9kHJnOGwSGitBoH1U/fhieCSabvBr3RrdcCCI3EyObSA/YYuYHYL6UBP5mY8lF3XkAXquwM41zZHpImkyNBbx8bj8HDHyG7ZEiU6Pt3qCt7l3JXWRNGiZB622xDAVNN3BNEeFaLwsNS4/xErnklLMkNNCAkBqg+7qrfbbObqVXxbCVO7/1XbKbZnKutQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4blCkfRAE6Ate+gnLOr2dw3R2o9ZIdaIW7y5xq1Jig=;
 b=PLldLK+frXFzUYoQoBTasglRKiPXDtxuN5GHtqTBzE/kZ2TvCni8aOk61gDBf2DGwxbUeX/bnlKEz4YKge2gyW9VsPpBciw44I0QCm9twHnRsheiqnK00xJpBBESA0AWmanW9g4CqThh/HQv9Sp9UWy2bWU+z2+xm0crdSOscOZiPiapK+11ngC1EOhQVvPJKZ+iJ2Pq6dvuId9an5JCVXkRvpLD2kVIEF9v57WLI8HsNN7VMk6ZQE633gh5Fz11tGJCyAiO7/1sh66yS+MOUlEyx3jpkCKTZtJNG8oMh1DZvXA4IO6s3YRY0kSb4x7wsdgB3EkOwPvS7zl4K4SCug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4blCkfRAE6Ate+gnLOr2dw3R2o9ZIdaIW7y5xq1Jig=;
 b=Lg0WDs87YAuQ3ajXWvg709h8kZU+ZIK8D1QKp3NstMfk9Q4TCLGpzKEWOWgIHGTXKNbtRicV1UYt0PBoJbrvwHUNUVMr1njzeK9Ri0WuYJbIwc6IHESJTiGIYNZvA55nnr7LUN5tJ8lPEpR07uWCvqgnWLCwHU/xrI89Zn1OcoXgc40KokYZauxiT+0hnlBjQqMZP80eT/YA6mtDI8UVRi4sFRit8edU/IrjANpVqLnP2IiPNewfelg40D2K4ZlcX1nRhXqw0BF7naqtvnmUSTPHCUWZALxvuc+eblou5XJbTz82pj3XjUhKSS18igAK9xKJgtVA80vchs+GGuQmDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB9391.eurprd04.prod.outlook.com (2603:10a6:102:2aa::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Tue, 16 Sep
 2025 09:45:22 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 09:45:22 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: sbabic@nabladev.com, festevam@gmail.com, uboot-imx@nxp.com,
 trini@konsulko.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, ye.li@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com
Subject: [v2 02/12] cpu: imx94: Add support for i.MX94 in get_imx_type_str()
Date: Sun,  7 Sep 2025 04:37:32 +0800
Message-ID: <20250906203743.3352805-3-alice.guo@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 33632694-5d46-4ecd-c54a-08ddf505c162
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iWRyHEktKzCxI3rFuDCDJQx4gA7gRi2Z0ghrxOGUToDmmvErVXNJ9S1GGkl2?=
 =?us-ascii?Q?oFw/h06CdKP2AeEmmJuNu/0DMh7CKR5QV2y9FQ/yOnWqjuTYxP3dSDXQDjyF?=
 =?us-ascii?Q?euh1+CT4ybgJQMwJpTRNCfBsamrGZFTe+ozDUeJAmM+ON875PhmXSgC6Yk1T?=
 =?us-ascii?Q?4nVuxMQYAU3ShfjOxhH4LpEsocJFa9B0qeiiTg1OSpwR2wkkRfhtSotfKtOZ?=
 =?us-ascii?Q?Ah0EA4X5W8iU4NKcbxhyVLVuoQVXWYp4OU1Y8A0vVWGWJP5Yrgz9xnXKpqMW?=
 =?us-ascii?Q?XbzHRcU+vrOxiZfrS9DIc1tlbbUcnYj/X/9bjLd2daE5a8yRKpz3/yAiwgQg?=
 =?us-ascii?Q?yYkDNZeyrot02tOe7qr9kJqZGi5AphSfEO3KcoGQe7ni0yFYS2ANMf1CgO5E?=
 =?us-ascii?Q?LVXOkLMy+Jugk3gxEqFH3GnolpawSqsejbzEWajhU57uB5cjoL/qvRZtoGaW?=
 =?us-ascii?Q?7qoPOSO0trxTCU8TnAhFNgBldtLi0ygcESFrGkZGS+iXx3DVV5iH/P1vkGix?=
 =?us-ascii?Q?iUnjm6/4XQ4ZogX0++6ySemnyGHF6srW9eKSApv1riREvtWnal36+ltrJBvc?=
 =?us-ascii?Q?6ZEfpBCcr5r3oKbgoEBCw28I3sAPqTG34uJED9xWq2FdPt6guZpnugUL0eeU?=
 =?us-ascii?Q?PDPgya73y4HbrCbOwvJcYRcSmQZO21HcxcKOsHwh3DJCyAzFDJMrxf7/nbd5?=
 =?us-ascii?Q?cSfWdDJ5Wn4Y29zGCyq8ERaPg5j2BmzKAtyg10G6Iz8Apss/fCNak/6q05Z1?=
 =?us-ascii?Q?Tbjqz2usWXpmO9oAqZNaADmDqHf/Fzqc1FM4wfJo54M9YkWtYmcFs3ZILrr5?=
 =?us-ascii?Q?NK48ie0l7TFztTGc8+XW5vGVSMLZVPTI4fQh0ZKd/4TwLpb8jKArUe/9hqhL?=
 =?us-ascii?Q?J0mu4eEDq1bf3kP1UNqRtCVKSQy/eEpu0tXsCjR5fQFYPJftDKiUDzW/RRJN?=
 =?us-ascii?Q?W+4FLA+e2Z1Ssdoftpy87FdxKtSNfe3npMz1wSPBL0JoUKwwRA0c1k/VFfdB?=
 =?us-ascii?Q?JNn3DiyTVai0LKhi+yJsyyrxidXRQppd1H/otvUAgeu/MObgq3BYLC4YRPpZ?=
 =?us-ascii?Q?WE9smq+N3nO4XfYpEIx2zYBZwvf8+e2MKBKe0Tv/btu/GtelEf1+5cRxI5rx?=
 =?us-ascii?Q?EkjZTi5v5vsPGU/NXQUowZVVbcuRBle1lkV8MwCmkIY+PQtsTx9HqPqnyAML?=
 =?us-ascii?Q?kjGfTrgry/76CYhTED3B6NFnnhR5dgSX+b0EeSawOH5XGHJg3+FJcgEQCY08?=
 =?us-ascii?Q?KdLVHFHPLySa/JI0ut5TaK9qzmPtGl/IttDIDzB+uACB/W2PFWsN3fz2+nsR?=
 =?us-ascii?Q?gnIIGnfMXuhlMY/Whq0nIjaMJlNM5RdwCC6PHU1y672QRCjyf5jl08YInI2d?=
 =?us-ascii?Q?pxdLMpHZGoo3nkxkAuqjth9J0cjPKL+esF66KnKwQwF7BN67jY+Uv4fI1Sie?=
 =?us-ascii?Q?lj3ahGte6QlA1ZpyHiXkM2/cb5elZNzJs/UUMXOBs5yG/OprLH9FIA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k0XleL8gtNkPds79WyRjVkKmbS/7gpMYBMK1Z/xN/j8mhIfKlcf1wr2S8tvx?=
 =?us-ascii?Q?m/O8OGU4ze34pQLRuauyPw29oj8jjHkaP4VbzxQkqEpwbBUKz1RNY2TlZokL?=
 =?us-ascii?Q?1vVLlGeeyqAmS+qWQ6d5kNmzsNssiI5qkSOg2Yi/iTpyvB1xl8lWAnc5Fzm5?=
 =?us-ascii?Q?zoKlrpJH5bmBJ+qpT0UmHBClZR+ehfX+tQ0zbHgprV2XKSqP/5RCmTG3kpZN?=
 =?us-ascii?Q?0UypFEpLRyEWYgU60qljJ52otQFivKUUgDXAqJx8MUv17mk3mp6xXgAyDzP6?=
 =?us-ascii?Q?p+hOME002YhAlNG5ps8gpEIMcvY46jbBxaIVRs9ZT+ZAO4S3CmC/ORZYnCsB?=
 =?us-ascii?Q?Mp8uqvOUZ/gW06RCiAxHtID5b4o60kKR9yUg89cT39BBNWS4sOZX5uf9/nqi?=
 =?us-ascii?Q?O0Z8nFbB1NuOYCo/PxdEmcTn6t9K+V0QqsRWBoCGBl+Mx2cf8IcW5WG5V9mS?=
 =?us-ascii?Q?uDPDnWEvgwWwKIU890eTU+79Cu44+O6vsLyY+NamUJzCkJP5WQDhUOexW44E?=
 =?us-ascii?Q?VZ1lfJgFr9yVjK3cu1Tc5KKTi7l7exwr0EUS9fq2vguy63YniNiNwdP9iLQx?=
 =?us-ascii?Q?gOJVS+VA+rla5+TwE2KiDy+ivXrNQ1jto/rP0sU8Nu9WlQmaUyezBF169jWd?=
 =?us-ascii?Q?+hT2dIyjh2RJwQwtfL8M3jvEUix/IhtlbTsAUW9IDed3GCKYaAU/jIF3gTA4?=
 =?us-ascii?Q?cZ/YrMKT9YRrZQZHgIT3spDkBww6ZaIaIueJEIWRo7X9u8Gcmqhkbj2ewspJ?=
 =?us-ascii?Q?6aP4v15dtVyhDNehPZEC2EktnggFzebrUhbu1I8jCq/dp0//y2dYpM7s9IwE?=
 =?us-ascii?Q?nkKTEcxZ90j0v1m4v2I1LDEDAFBB2AT3MTQI2tD+erD+HKrAoavxN4HYJ0kO?=
 =?us-ascii?Q?hMrm1ByMQKeMWOBRsJMhT4tSV26sM4WEj4ghCL1HbZfNLt16BOVWunMOl8+6?=
 =?us-ascii?Q?OipgLzfE/SZoM2w8ShPmPnDqEuX3xycr+5QZOOJowOgvoCI/RKkKfnVMjP4c?=
 =?us-ascii?Q?A7IhH3s8MyxMxFWYXrPPWRMqTc4fcO2cNdsZx+L4KbZr4AoEM7ZrxAGS+YeH?=
 =?us-ascii?Q?5+OxjBQw9vCEyr8f+CBGrzOqVTs/f4YKe1819364HzGcDZnQnx3TwXDtkCDA?=
 =?us-ascii?Q?zRxuZdMuzRNBUTg77rC7XiG6cH/Ak6hWaMC/AIyTOPEj+WavQ7kOC/HqLxSI?=
 =?us-ascii?Q?fVOsyA6ammSSO2rDecliQmCUANmk54VdBknTIDuO2iejf8Lr5+cleSYcKNA3?=
 =?us-ascii?Q?4qw+J03f3bQc+EcBRaZemV61bRF3mualgApx7OV4+wdUf1SSAVwaLJSvqyZE?=
 =?us-ascii?Q?mulP/gOdO9Oz/2E2hkfniB8unnQbeWDeY+knvLZInp3nOE8uMRnLwH1Nzwdd?=
 =?us-ascii?Q?ohnWgoSsL+6rKH86oAY9qVC8ruVqmpRc9LOzw07aVKvt+o3xls81z2BSG6Ji?=
 =?us-ascii?Q?7P8QF+XLMQP+YX6WumM4ZHgzJCEeyxYwdVFm2qXChI/V5i9jr+MoXoeMluBX?=
 =?us-ascii?Q?qrENMyZhnDkENzEOx943U+QY4QBxFEHT3ztuDcuNIpWOiqJfvoGDQAULROmG?=
 =?us-ascii?Q?XJiYA0gLGRdt+1sq5yXPZ+F7vC2JnQ++z/0mnkuI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33632694-5d46-4ecd-c54a-08ddf505c162
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 09:45:22.8197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5AnpsOtn+JRgF72q+jpOlMvBZ863wXPqabLLK4/q020dd2H5vi4gqTWx2Wl1A1ZPVxIaxc6gJ1FuEPN3AljYCg==
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

From: Alice Guo <alice.guo@nxp.com>

Add a case for i.MX94 to return the correct string identifier in the
get_imx_type_str() function. This ensures proper CPU type reporting for
i.MX94 platforms.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/cpu/imx8_cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 950630453f9..630919a3642 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -113,6 +113,8 @@ static const char *get_imx_type_str(u32 imxtype)
 		return "91(01)";/* iMX91 9x9 Specific feature */
 	case MXC_CPU_IMX95:
 		return "95";
+	case MXC_CPU_IMX94:
+		return "94";
 	default:
 		return "??";
 	}
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC863CCF9FE
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 07:37:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5379883642;
	Mon,  3 Nov 2025 08:37:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eOQJ9Otd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95BE283700; Mon,  3 Nov 2025 08:37:51 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE9868331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 08:37:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlbdwD8JiFygVKINFRdLqGnXgVZh6jYONtNU4LSkddAUpyi9EQ39FbeLWBz/rG8N9meYHsQM3yf+aDEX2LEiGZz7a6xrBp4/8thiEJkzvt41OrAy7oqEt/SItIex4w4YxrKRbBEs57v8o7EnE7thEW6mvPc8fvxnWRuDuAgUB/yO2Z/cpWqIW+PIJyOfhBPWU0NlsvK98wFvlV0nS92Uo1wtt34Hvqhw/BFy7ovTWaWVfkM4qD3ywrBsf5JtW9E8+Yp/f6ZfT4F+Ua08kyw9u7NB+qwxVEofOmqXGGBzv+Ke+UaV64ssLdTom6BCLhTtl78NuD4yZRQvVEiVyZc3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ws40LPNmQGZBrrf5BBTT49t/sGb46GMdpik5Mp7qpPc=;
 b=BV3gGjU+ZhJ7OoC8/q8of8qysQ6XXd92lz5vr/Jdm7GGSbHkol3rOyo91Q5X95wvs9BpqBOcBgRa3bxFiiS7VuuVwaZID6ASPcrBEytFR75vZKyiJQSLSxn3+nmt530g6T1W77k03WHA9omRZuacS8vQf6sSsEv9tjJuATbiAs97dbYLmMybf5cfXcTNKkT4gNkJscFTO6hjlgXoAxBLsP37Jh3HGRsXW22+E/RnvMp2+oDBr6a7hnk3BAfPaU1Ol/n5IrVqdSBbNCk8vxPBLjfNflPvAOERponWSXvyTvEqpL+FKBdPPyrZ9iNH50TKZVlfH4XvWGFxIvx09bJ7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ws40LPNmQGZBrrf5BBTT49t/sGb46GMdpik5Mp7qpPc=;
 b=eOQJ9OtdLba5YrxtKD/im14STbQod5D7/ZYePpUZTLNbUfrO+sTeymmdtPeZcMxxl3kYZtuf/APO8ChpTj0HuiupGvsc5ddlI/QfHHHOkhyKMRzTeqvlWIDwPeI8FM3FHMHN8q1kgfoPEC4BTi7BcC0KDmX0Ih+cAWvbknWYrr3t5Htn1Vu5vxoXiggGJMgiBMTFTfz9ibj/OF6nRhBZcIIlD7gadi9zaC3jz+HZlW1fW47KSZbLII0g9iSDJohAYtN0npJCJ4TwLhr6gyJW5INffNtDzzb2EbEatPDu0sdRcdlG7Utn4NYOAkQ7rpb+0ztRjofT1sGerAf6lKzRAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DBBPR04MB7546.eurprd04.prod.outlook.com (2603:10a6:10:1f7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 07:37:47 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 07:37:47 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de, uboot-imx@nxp.com, sbabic@nabladev.com,
 festevam@gmail.com, trini@konsulko.com, marek.vasut+renesas@mailbox.org
Cc: davidzangcs@gmail.com, sjg@chromium.org, ye.li@nxp.com, peng.fan@nxp.com,
 alice.guo@nxp.com
Subject: [PATCH v2] arm64: imx8ulp: Split SRAM0 mapping to isolate the SCMI
 shared memory as non-cacheable
Date: Mon,  3 Nov 2025 15:36:54 +0800
Message-ID: <20251103073654.2106782-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DBBPR04MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a6865b-87e2-4db1-99d3-08de1aabe19a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N+YefyOoKE5u/LJF7Whyi/Dri6jvtylL8dWypeZIJkveTNdMnreRftE1uuJD?=
 =?us-ascii?Q?igIrLXE2vqSYWzOXSp0lO+m5JcSjHIWp/s75q/06Uz4FCYFD+cDpER9gj1Mm?=
 =?us-ascii?Q?f97YGiLfdjcn31Aidx5qld9ecw1F0BnhTlejesDSt3vBzdouXRC32c43T9sK?=
 =?us-ascii?Q?/wKQ5jjAKXw41mgqTKBXRV18x/wAD4u71YrjDRWsj8SWztG8C/fe9UpMhghB?=
 =?us-ascii?Q?gjJKTnSALyubZJXhl+3ozU8v4ruykaz1f7+XfVrxeWuv1f9hHs/BK1YDGRPC?=
 =?us-ascii?Q?LjedzQUsuvo2QfwLZ/eUhd5lvV72RaH1gCmo5661J76OyNmPcmgwDJS1rt/p?=
 =?us-ascii?Q?GcyLelgLB93pUhJLil4wFEgF+VIPsFPF/IkX8UgyKosRs39hm/QbAyv/7ojD?=
 =?us-ascii?Q?ZW2VpBwzyDYhUGM4ybfCQWw2DWmAxivIqBF+qkxO4UnHwN9q7LL2As3aM2KX?=
 =?us-ascii?Q?i09NhWv6P/ZlTfMu07ZmRhlvYeVCJ2lmkagQpDe1evZYUlnWDACmXc0VJj+z?=
 =?us-ascii?Q?Tq64rpYwGpcmk7w6N2hobWILLc8RH1l1O3hdSuhrGOqCizmBTTfHY1dnZRyC?=
 =?us-ascii?Q?NvIKOKcasIr53RHf9nCNuBV4L1kds9zKNPKK2oGiIeq1bdsw291ZwFjAdV1J?=
 =?us-ascii?Q?1Zk2QxwO9Yqa+++cmNEUhgOBetNjEvAupYwcidU2rejkMH1DSJ2qzQf6RSsB?=
 =?us-ascii?Q?sT4tgn1yGMXE8EJe4tqBjGNAGMzaS55dYcGqGaeUws+oyQZh/XCjLrE/eSvk?=
 =?us-ascii?Q?OWs5Ib53VShqS3eaM0FYJcHdcW8TkP3wQcJReKLXTzCt61EnQWGdWiZAfr1T?=
 =?us-ascii?Q?xTWAZLxzGzScvHJGk9KSCOJ7BhLaEROh7COuU2RfyBGwfwVQIiS9rk7WLXej?=
 =?us-ascii?Q?MZqN/015aJ9So48U42ZnrLkpNSk8/q0Euqo9r2eBwqDzfpBo2gI7C/Ef5dxu?=
 =?us-ascii?Q?k0qie2WC2DOniirvBFl2SXEVGxlYugJ+cJsuc86cMxRC/d0Svb4SFsLFSAY3?=
 =?us-ascii?Q?ek0zUtUeBAqmHNMD0/AmND4NKiY8FFQLa8XFBBZAT4jpFW2+X2mHsVGJIBlE?=
 =?us-ascii?Q?wK2nzCDkzxHsrP1Qj+fBDUGQiiRrDq+mBxNNyTwfY1Z0O0cROIDVVKzOoqOx?=
 =?us-ascii?Q?rAVo9vIjJVNzj6q3Az+WkgnJadLAe1uBJhCiLVy1cRTCk/0qTfxPDVYZKyAp?=
 =?us-ascii?Q?t5OPqjNMn6fVRFufrOpxKge69nS6z/o71gvaBu8zLV8I0UBCtR/+I4Cx89lb?=
 =?us-ascii?Q?gNd4BTJ2+Ysj2PIF/pGaxXyNn1wJPTnlF74YV27hrDU5UegNiRfAuEBdkFzp?=
 =?us-ascii?Q?PaM0wxwCezsZg3q6f/4kEV3ZE4uUJTFvntItjB3ZINuIf50qSOhL8OZ/OdPO?=
 =?us-ascii?Q?+lX5mcRR4MZUutNP1L7KageTyRrkl81gMdRevMX/9avxObC4hmgGHt9/7ac1?=
 =?us-ascii?Q?JoSW2QogZBUnvc6x5sd2MMh0AKLslpCWUn9AOgYGKpBprcSu77aaMYhXYICd?=
 =?us-ascii?Q?jUZV5+838YFF0xbc/nQWxl4GmJtGd+0VZJOq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7XdrKmcp73FMnBuG8SmGGAgv7A+B3ORpI1+YshyQY+gwazfUdOmnYYLXW+T5?=
 =?us-ascii?Q?8H+KEiImoa3OYZT/fOmxQTX3jVbzhMnKvS6Fy3XGKO+JmQN7H8aXY+xbDzQi?=
 =?us-ascii?Q?nckKfqvsZbvwGIaBNYOuLzL501Des6b+3TtDPldde2YeQC7b8YywSAjUgK8X?=
 =?us-ascii?Q?6+xgxuOE9VHH5IaFPyu5fJXUGYXY41VkQO50ZZ4ZdLTOc11ekc77a+mP/4d8?=
 =?us-ascii?Q?UOhAE7I+32yuCFKxy7ggzoRzBKFVpTzMQDrDnzDJZIUL9bS+YrlCVkcVZl7Y?=
 =?us-ascii?Q?R1slB+nIW6HGFiv8Q3t42GfMkIQ0NT11x/+MiWylYNbCaplq/hqUpuuplEZu?=
 =?us-ascii?Q?dZudgLsx+AI4oIC5LqylZLt50zuh1Gm1VdWdkghmBuir3GdGjR6kx1KFwzcg?=
 =?us-ascii?Q?Ew8I9wJZRAvf3RD4JOJvpwaEmLKfx+CW0qjtbhSpv2aag3eOyN5r0NEu2Clu?=
 =?us-ascii?Q?Ceqn4dkLSyA60bixzR/jdz7He77LtbOYQg7Hrz4fGjsvQ8MdaJr80hM0SE8S?=
 =?us-ascii?Q?mDOZQcY/8hB9ku6jvnr8jeD5j2xgwMuxf31kgAtCu5RwHeA0cHN11nzMhS/+?=
 =?us-ascii?Q?eyzk+CRRDux1xXF3l7vcFoQt2vAxfZYaIfqn169MUKVnH6LJe8vvgEQCZd1X?=
 =?us-ascii?Q?09MH+sHSWM5t+nWUaZlpgueiaeeMxqzDtQJdCAgyQMcISoKvAyCYJzajSn1z?=
 =?us-ascii?Q?LU6gcv+uGpBZNaqc8ECWiTI2+iWhxMI9bgmqU7rdjLZR5BWesQ624iIsY2wz?=
 =?us-ascii?Q?5yhyjeHlpEz9s0GnFdKPb4HMlcCVr70zxyGuxXosGELCmEDnmly/hi0FKMmd?=
 =?us-ascii?Q?uq6bTSLcM3tVsnSNet9tRdluta4wBCOD/7BRHyP8ste1mr41WVy6XnOyyKIw?=
 =?us-ascii?Q?z+63vGl6dCDU9k5u8TB+acjiGUX3NTxmoq66IZ5wS3nGCgYjnYxOMXP3b2Rc?=
 =?us-ascii?Q?pVxQ2eDZLdApv/OyuUe2cuEMOnh3778xf/q8Hk/Qm9ATl/KwkjV1rLnaB8Em?=
 =?us-ascii?Q?PDUCwwPTY539Ul1MGJtgK5zANbCyqR1yDhRES39CAuETJKtQVUEI2D5dvh5J?=
 =?us-ascii?Q?yWQNXoDCECHVRBbk2lLH4vgSoorP8Vwo/L4Rd+IduOPQMQapG9g+BpwRQc9g?=
 =?us-ascii?Q?7KZ8Hw2Wh+EHnm6PeszcPykkWOnHp5UsC2pSaf/1cP1HB4p46djrK5+RocqU?=
 =?us-ascii?Q?jYHX0bUSFJgqdiY1zb94aAvns2QAotgHWCb074XrmMCKJX/bAAbYy5cTizGx?=
 =?us-ascii?Q?5hUOM17yD+XlmVax4+smLWnP0xV240PGz60IPPvvUPO/dZ19w63G45pVylEE?=
 =?us-ascii?Q?MLjUkIcmkNh4MXvkH+fpQ5ahoXOU3YdyVzk34Qr1+C/dn/yPkl/tIbJ6m/h1?=
 =?us-ascii?Q?+AxKivOSMRff7STRBGaLDQFTtRSQTOl9kejE23MfiY0NE0c9dgZEl2fkOKJf?=
 =?us-ascii?Q?E8fO0p4EnucjAggdCjLzXALzYK2nvO/5ar5SA35lkt44m2wCTuaa+6G3G/hU?=
 =?us-ascii?Q?QUZCCzMPCcJYbCP4UWEnxnupo//BZMGtDwL7H2DBaHZHu53gBZPhlYBy+33I?=
 =?us-ascii?Q?Ay28KhuylxcD7O4UN1JUoyv4ITVifrYREcL/Y3kt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a6865b-87e2-4db1-99d3-08de1aabe19a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 07:37:47.1325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gsj6Fedpd3YFe8HLvfEVbHWY+ui3MJTfCCpRivRS3RNhHDfFjrbM6pUpNJD3da4StqL6gm5y8fCYPGzjDhx6qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7546
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

This patch splits the 2MB SRAM0 mapping into three regions:
- 0x22000000~0x2201f000: cacheable normal memory
- 0x2201f000~0x22020000: non-cacheable device memory
- 0x22020000~0x22200000: cacheable normal memory

The change ensures the SCMI shared memory is non-cacheable, which
avoids cache-related issues after removing
mmu_set_region_dcache_behaviour() from scmi_dt_get_smt_buffer().

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
---

Changes for v2:
 - Add a comment to clarify that the 0x2201f000~0x22020000 region in SRAM0 is
   used for SCMI shared memory communication and must be mapped as
   non-cacheable.

 arch/arm/mach-imx/imx8ulp/soc.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx8ulp/soc.c b/arch/arm/mach-imx/imx8ulp/soc.c
index 04c6f064130..1ee483065e8 100644
--- a/arch/arm/mach-imx/imx8ulp/soc.c
+++ b/arch/arm/mach-imx/imx8ulp/soc.c
@@ -384,7 +384,22 @@ static struct mm_region imx8ulp_arm64_mem_map[] = {
 		/* SRAM0 (align with 2M) */
 		.virt = 0x22000000UL,
 		.phys = 0x22000000UL,
-		.size = 0x200000UL,
+		.size = 0x1f000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_OUTER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* SCMI shared memory buffer must be mapped as non-cacheable. */
+		.virt = 0x2201f000UL,
+		.phys = 0x2201f000UL,
+		.size = 0x1000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		.virt = 0x22020000UL,
+		.phys = 0x22020000UL,
+		.size = 0x1e0000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 			 PTE_BLOCK_OUTER_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-- 
2.43.0


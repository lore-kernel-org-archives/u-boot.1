Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785CBCAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 09:46:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2463F83577;
	Tue, 16 Sep 2025 11:45:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="glZGWZBL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9567834E1; Tue, 16 Sep 2025 11:45:44 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED765834E1
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ey/C2bcYtC1oRA2bINKeoSUTfPaKX/NhfoZTvUgqdkBvlwLBXwBLlJENRKlDxS0eE38hgxfh0O9YD/2KtTEJ7eGCyBBgLSlcdJNt5/rpSv3z6UPE5YbVrBEvHfpmJfKaT+snrF+KR8t2rZCbxR5RsLT6w4LQx8z/syxjUon7k3+s7iem6A2HMNX8qBWLT6M5apxsPs/tLDhmzh9mnXhLNqOJ/kq/KT/RvGMhJAN4H5WbKRgw6zfFvqiHhWSrSH+fHWFVXsFKOA5p9K4qqUCKz7X7vtyU1WygX5cGyGCeHnD1ZA+5r3HRHkC0o9tDO1wXH8tKD/oN4UoSQBB+ya6/PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HgMJHIrB6QZ3oeSYqpvBSdVDHwD9oLtKlwQx5NGhKI=;
 b=cndVOIoGefnJT0xY0Ye/AaR+EaMoHVYLkRl2TklniMUEIquuhxVZPIDdQdKPQDlYRnjrox6yQDm0Khe0ZyEJzqQPw7I4SmH9qO0dFG4JUH6wJCTjhsiNLy9PVTV48NAOra+tvw9MSJvt6Hu8s15klYnvTm4ISHBHvMprVeiWo81GOjy6miAz5bd5x7PSwitxzYfA8qzREmICTiqoAiyUikjq1stp/yDZFnZz9npqzXJhRgE8Mvl2gZlC23FHJhS61Z9JBi/vOQZ5htAf7c4niE5uO8fzLYgJhEnNDp7QmcceEVvS87Cm7Kq3WAfN34a55x9IR1peJ8F+5o6K1xMFYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HgMJHIrB6QZ3oeSYqpvBSdVDHwD9oLtKlwQx5NGhKI=;
 b=glZGWZBLYDcCgvBOZKZpDMxHxNlf9IAXtLJdWft5wWAna7G7LXEp0m9UOw6+eIL/wd97dgdni1Xl7kZEg6Kx0GPMjOMipPJn3BW3hWub9w0AVNvj4XURWEusOC95O+NZzB0M75BfSHjvejlX+6CJftyu9MmScKBs21Cq9W7RCMfhWVjL0Z5aCdrOqAw8lq8YWTWNTHEnQm/9tdKOzNGNWlZ4OG187EC6LYVqJgahEqt0/lZ6zZP2Bc7o86Wug+jLCTLOU9r+bjnRIPOTENYa/OPgB3tAnxzgUIYGirpA4V6CNm/QpbcF+UqBVyr5OrQ66eA87UxXCJvQlnLxtaGxuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB9391.eurprd04.prod.outlook.com (2603:10a6:102:2aa::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Tue, 16 Sep
 2025 09:45:38 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 09:45:38 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: sbabic@nabladev.com, festevam@gmail.com, uboot-imx@nxp.com,
 trini@konsulko.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, ye.li@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com
Subject: [v2 06/12] imx: container: Add i.MX94 support to get_imageset_end()
Date: Sun,  7 Sep 2025 04:37:36 +0800
Message-ID: <20250906203743.3352805-7-alice.guo@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 42584eb6-3732-4c06-0ce1-08ddf505cabc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wy37VOx3um0yz3OYXKYRDHo3U31SqtCa2+cTMjxwQ/h+UxiBL+JDUKpUDRLW?=
 =?us-ascii?Q?ZCL3IAhr9wfbBmAd5yWNh25PLWwmojE5DU/JpGzsSjeA8pkwgfkWDQ4XKhVV?=
 =?us-ascii?Q?ijvQGk8uifhavRv6jC59L43lGLxUvlotwKRfR7UZFimk5sJmQPv1HLaGcljb?=
 =?us-ascii?Q?riTGA4QGkfuKWN4eGaj93RHxsr6dmSZcM9A019nI08JPHKrfk7AZ3i/lVIgo?=
 =?us-ascii?Q?9PdczFIgD6KxyBP16ZFS/lndsY8CvFTbEpzSUj0qZQA7qdYs8HNuH+CO0zRe?=
 =?us-ascii?Q?WJuqn/yNK/XP2ZJ9XNL7Buh1LdO2wFeayIP4VEg2E5qN24U9XktAFclasgGU?=
 =?us-ascii?Q?epMLNYUhHynZe7EnXGa25L9Scunl+HjQTX+JhE2lc84bfv8Fmj8Oc6s1WN/l?=
 =?us-ascii?Q?GHqO3PwZCbj/mL6SJRQ4f1lAsFfqJVA758ERyyWAU4WIMZTalnDFEqz2b14y?=
 =?us-ascii?Q?OZQQfVjt7XQzhf3NeAEIzI+uM/zDDVR03EYnPwzKD3zUtBIaa6Tek2/6LgWO?=
 =?us-ascii?Q?+rM9NArnV830P5FRyj/0bd6u9CmlRRU+bvfdY7WUiHpYqclO+Q8atV2Zw9m5?=
 =?us-ascii?Q?0gy/tFSZotJIjJ7quL6lW/RTffCJfE79MxEYj6V51RK73GDwXtW9opevRCRJ?=
 =?us-ascii?Q?2ooGDIqB9tFVw8N/Qw3oXzIpzbIfBb/LLDixB80NylRyLpB1N+2j2hc8pJ2Y?=
 =?us-ascii?Q?4kl65qNUIPRibaZTMHBTdNbdMkm/94TypEQP370Ne0v4Y/yQu1cdqIh4ptCT?=
 =?us-ascii?Q?HynuoW4QogUi3LdjlaozOMHnLHzttPohA+ljeEHs2t5V0P0SrB9nYXSOcofL?=
 =?us-ascii?Q?GNggyy8YLd8nCsQbJtA0sFwzxqAdfaPS6X/dXZJ87/849DXYaZG4J/XWCgrG?=
 =?us-ascii?Q?Iz6zMaNk6mZfcIGQG6Q2006RWLqOt2aUPhmnL45B3eGopdn06x/y5Ji+1Kgz?=
 =?us-ascii?Q?41XXxNNBL/4mZFs0vzyknQOmkz3xnhub+yp7/A0dqSNb3fuD/Wck0c4yL1NW?=
 =?us-ascii?Q?RFQj8Ll9S76nzwT95JBBzqjb882npNQdBXtIuo813P/yOkFGsmoiIk8Bf/Dj?=
 =?us-ascii?Q?iecZa64j757xFeUsJu/GmC5Mmkts9U3Fcsx80Y2aWjneNOHGgyI+IIZ6rZ0i?=
 =?us-ascii?Q?p5pLLz9U1raKtUdPVM6H8iD4vdmpzzWd8oP+Eu8soFhRgShH8hEpm5pjI8jG?=
 =?us-ascii?Q?nLvmUdB7TFND6rixUK8+jsPs+KEB0appuIqtf9PP9lOPIxlFSy8l3eFKDLlq?=
 =?us-ascii?Q?T+ZyDw5Y8G9kiziJaHED3oC4BqaXjIqJDWVFjqVki/7PtIxxqHiZaucS1YW+?=
 =?us-ascii?Q?CnSd10RUa4tKnnEJZJ9kPswfJEL3qdo4O7gj5Vud0uF8rkfLXmkm0kQlL4No?=
 =?us-ascii?Q?JSSPGNn3QaFqSx8jTgs9itny0IXWvuBD5BP/8bvaqgPVhN1r2b5T03lyjRgZ?=
 =?us-ascii?Q?+sdS59KEXnGgaZVdbNFbOvxERhrcmbj0YCC8RbaEco8HnBq5zeTtJQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R6cQOgqRE/VP9xXzJuaITFwZ3blQbcDL7S+acr+PVApEGRIEds1qE15Aw/wb?=
 =?us-ascii?Q?dtghaJSRQMU787yTFrHh8ukq3moX4E8qqY2r5UMpeXDhhThOOCxzRc+OKsEx?=
 =?us-ascii?Q?5icHMgZ/wYbDwiLnLI2XSntiqyt6PNqGkPsZHi/lOxqBQ8ikKVYLC9Ggrs4t?=
 =?us-ascii?Q?B3JL8bV1DWPgYwkj5q51biG7szbb4vyGJpiuL85o1ipzsZRG5BItV4a8e0iA?=
 =?us-ascii?Q?r87hxvUi8c7SA56+YoSgKJu4NEElybYagx1xJDjfbNupjxGzG9qnK+qtrRlz?=
 =?us-ascii?Q?kz+UzndI4JCh4Woe36zmkg3dGCAnHF7qMh6iSqJv1aEmd2/hmUP+kZdePMpf?=
 =?us-ascii?Q?B54iJa1s/ELSol1+lME1cJR5cGeDSX30DNUqVYKWk4ejT8bo3yjO0yIUN/uz?=
 =?us-ascii?Q?tgRW7QZ1cosPaA2HLo3Xzn2z2Hc59wppfiRJ9xgyqMWag4oJnPpMRd32uwUz?=
 =?us-ascii?Q?0ry6K7tNBglhGFKPCV+sZ+OW3ps8TS4CpXLtWr7aJ0pZd4SmmtgCUAWEiIRc?=
 =?us-ascii?Q?KQyXUNwWd5TCh94KFgDekQyXWCxYzByVwRsNGST1BpLOScpbKk5EZtzfIr+R?=
 =?us-ascii?Q?oqZdQPu3vu4uKvVjH39/TYjPywtrvOG1z7b2Y5nVE7IAOye/6aQnWs7lKEHH?=
 =?us-ascii?Q?fY0wiKdMTXsyFfkseSi1rUvmNdoEpI9lh7w5f9360YWrrtIelSwZZ4POz0Au?=
 =?us-ascii?Q?NrKWqju+NY1Rmfnbu8tZ2pOrICXjSA9oXCPABq4HyiyhfM85V53vrwEICbRq?=
 =?us-ascii?Q?KKOwGPzYLGc+pbKAWtge7TnaZmvUa6dvG3F5J6Uq2uY9+KXjw9kN5CvTn2sY?=
 =?us-ascii?Q?Rohtjm/idNWXpvdA/1WptB8+fB3BOmewJafzl9MIOEN/g8uFMH3IzEoBF41a?=
 =?us-ascii?Q?KSt7AUlCErAGHqKUVF2FjB/jPa4sPzrP9d0pA44acDxOgeSbogapS3+y/aBh?=
 =?us-ascii?Q?L2FJEktHYmredxHkACT1JZYdIlf7Vgk1B3BYPM0eZWkxn8tx9J+A3Am95Abi?=
 =?us-ascii?Q?VCK/62qYvEaM4OU0Fd/ggYF0mqNrUmzWSB3Nug6c9r32cw6og5Vq9ClZwlv1?=
 =?us-ascii?Q?mgmoVWZSge/ARoYBPZLNnJQKSvct51bIC5d0q92Z2BqRNArmTiwBwCW7fm5i?=
 =?us-ascii?Q?57Y2ZoC2Xnn4nj7URNE/33UxHdM0IXCoBzhAayWGAaSSxYDahfOOmUhAbZLL?=
 =?us-ascii?Q?Uy7vkN7t7mFKJA3qzQQhArTEGVTC/t+pwdF2AhaHO6YxhbmSHOH75lNLYvcz?=
 =?us-ascii?Q?tQ7WwIzxJ8Gy9RzOMfsTtESzQmDsJyCDP+3U2SLB6mP+0Qm1+cdwOKlaZ9z5?=
 =?us-ascii?Q?0pjYTvJhm/tamvh4BntkqwcalTl1sWkEjyMRhxpscOr8tDw4SWPlS/EOEp3L?=
 =?us-ascii?Q?cujXFgypRShXSoTRu4bWxSnLPZdrocQbLMJGhHo4IYTDEM06hE7QYOIa6yr5?=
 =?us-ascii?Q?GxJ9VQnTeb0p9hEpqvdzhsskm+CJQ3jfc28TKhbk+fmJDWhAoeoe1X7WKZ4+?=
 =?us-ascii?Q?0beFlPNO2c0kH3MoJBagPTR0vmgLavyVQXvoH78wyri8yj42xR45LnNjo99l?=
 =?us-ascii?Q?WGMPj036JmlrrT2plzInflRJOspotYOCuZzzFQMj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42584eb6-3732-4c06-0ce1-08ddf505cabc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 09:45:38.4109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhZtFPh1/i+ukyyRWR+7D4M+GawYEAjIytOcictQPgoALAqVbGh+Lu7dP0ydTSmR3GYl3yEWLPwOvia4EKByZw==
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

Extend get_imageset_end() to handle i.MX94 family.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/image-container.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index 3a9e6dcf225..78f2488cf6d 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -297,7 +297,7 @@ static ulong get_imageset_end(void *dev, int dev_type)
 
 	debug("seco container size 0x%x\n", value_container[0]);
 
-	if (is_imx95()) {
+	if (is_imx95() || is_imx94()) {
 		offset[1] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
 
 		value_container[1] = get_dev_container_size(dev, dev_type, offset[1], &hdr_length, &v2x_fw);
@@ -321,7 +321,7 @@ static ulong get_imageset_end(void *dev, int dev_type)
 	value_container[2] = get_dev_container_size(dev, dev_type, offset[2], &hdr_length, NULL);
 	if (value_container[2] < 0) {
 		debug("Parse scu container image failed %d, only seco container\n", value_container[2]);
-		if (is_imx95())
+		if (is_imx95() || is_imx94())
 			return value_container[1] + offset[1]; /* return seco + v2x container total size */
 		else
 			return value_container[0] + offset[0]; /* return seco container total size */
-- 
2.43.0


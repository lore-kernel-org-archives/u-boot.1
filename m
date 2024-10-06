Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471CECFB43F
	for <u-boot@archiver.kernel.org>; Sun,  6 Oct 2024 09:40:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5770488D70;
	Sun,  6 Oct 2024 11:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pmSsWI2Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EE6788936; Sun,  6 Oct 2024 11:39:52 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DA3E88B79
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 11:39:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhcNLJxiyU3Sk9cLAJlCinth6xm1cPrFcE8CmPqtMi+SYBV26pOX9Pk+IVtobrGrmrb1ntUxkczxzDMBUMoBAp16k6485Lh0XVUhD5/nyuROl084chDpoViqVNFHz5BdF80lFIx+EYQzwm91jSo/FvjSQSL6dgS0fy9Jtpm0ePg7nqfZM5/OOBiuSMD/9VFemwCAgDXgduHTqnjAELQ84buLPl7Z7lJCOJ0SmdXHUHzshaY2YnNl5DlmZ5WsdKZv/4hqRBmPxCReDTBHwnIOZWDLQ5r8Vd6dNTnrLi6yzgDl6jDk6muN9rq4bBWO3SIj1tNPHAFw1M1r9U8CXtcnDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebNQKM/YWSTQopJYMg+ZPGGPQ18pcfOqYKBbrd5CesQ=;
 b=wTBxsDqJoqKXFvVdjGGasyu6h0JL5mh5eV3H2EuOq/1ZJLa3myIbiga/6/CBg78gt8ugSi4AHMnXBb1FVsXcX50MIz9x/C3F8qxgfu1AN3boWT5RvfHhHYK2GZjJ2hYct/8ZgikH8l5/to5tOGaM+GS7t2MHuK8p2onVbWdwQG12p0pY+KamSYqPpA+vjfarp0k4dkXo9Wh8mwR9SAcnjjeCH3QBPGn4uw5m+dVwo1FxtfUUBIpC4clOxLwGxaXmNtDjqnZPJKn9H9+vIZSmhfqiDtOtVfGmgeCcm9VVoZRCTtpp9oL6BzxrUeQmyrSb+NMPUXWnVlXWXv3xyuY3eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebNQKM/YWSTQopJYMg+ZPGGPQ18pcfOqYKBbrd5CesQ=;
 b=pmSsWI2Zd3VSHmClVI48e+Z8aYx/JwFu0CktWfZ5XL7v0swbVrSYiCj5hzDklgq8Hf2EkWVrcEd0PESwGcqzWMaVcUIegGgA01kK6SJK/BjpIXEaNgvSy9udgMMjHlGVShJslvnZUR9KDYttlQLWgtkHJZckmDyiT8fmzcBWVG/Vsc0P6A6veFXktTkFoqPmdwlS0BnMAZBisUfOS5ljY7+oz3ZWL+w6R/RQ0PVu1+gAkp2s7hJ1etrrVQEojbwzom7ejxrBSIj91C3EGJ9kJKhBEupbk36sLQPglazrzT2Py4wbTWCnFTfNRDhuNGDUDP2gOy0NPGUTizA5IKxcHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7670.eurprd04.prod.outlook.com (2603:10a6:20b:297::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Sun, 6 Oct
 2024 09:39:47 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 09:39:47 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de
Cc: lukma@denx.de, seanga2@gmail.com, trini@konsulko.com, peng.fan@nxp.com,
 ye.li@nxp.com, alice.guo@nxp.com, etienne.carriere@foss.st.com,
 akashi.tkhro@gmail.com, Ranjani.Vaidyanathan@nxp.com, festevam@gmail.com,
 marex@denx.de
Subject: [PATCH 3/4] clk: scmi: support probe in pre-reloc stage
Date: Sun,  6 Oct 2024 17:38:24 +0800
Message-Id: <20241006093825.2800013-3-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241006093825.2800013-1-alice.guo@oss.nxp.com>
References: <20241006093825.2800013-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc15968-c208-4b0e-13b8-08dce5ead0c0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c+26Ya6wZzgR82CYsYoZuuSM7uH7r+aWflxmBr8mP2AJuICfZxka4MZ/AcfC?=
 =?us-ascii?Q?CRJCLLMM/pmuhf3T1JNu56DekK8qepYqaf4i2lR82zLIQSSvNaXUAfSWmgWn?=
 =?us-ascii?Q?YjR8v2EpX+Uyngc7DwLv1nRU+5WtXCUP4MmC3qZjmIvvgNcepCWUGPc46g3W?=
 =?us-ascii?Q?woDIGbq7dgO5j7oiBggu7SkCNlsLucQWiqldPqP6UVnfw4aai8OePitXo1oE?=
 =?us-ascii?Q?uVwrNbJgTPRlMv13RzUzssqtIfztWPFzbT4E2cvu+haNHGppXBRVa8LIukwt?=
 =?us-ascii?Q?8jiQQDtMbDhD1Nu87DD8iTwQ8Pjz4uhbYvUqZXzT4eg5ZAReM9u7RYEhYiUW?=
 =?us-ascii?Q?gbmgzbQ1jfAWGJu5BW1CPtugz58TviYF1mjFZvzmt/NWcNETKyZkn4/67/TB?=
 =?us-ascii?Q?bRxyTSALznDbpnW8p1v/dymBNhscJD5b0zax91fTdfyilqom+DBHvK2NUwDF?=
 =?us-ascii?Q?vyukeqi9wFwd1kXbvNk7l8UtvztKS1EuN1Xz7fLZklZmAYGhtRSIFZ5P7Yzi?=
 =?us-ascii?Q?YojCDzRo4s7TS96v9zgAAsMAI2yElfvP8vZqFXlIsp2GLO1AIG2TVqcqyuy/?=
 =?us-ascii?Q?+HaVzQzAhQKudRHsL1GOWbgzZY2mYxOjGKkUvdCfzSH3YU9MB5swJ1sJ+W6P?=
 =?us-ascii?Q?9ugEq5GFDwwLYcFQuGTUocPN6b0oNNFfPVOI5xoWwPaKQxj4eOGC6NRdPeWH?=
 =?us-ascii?Q?V4lRYkQZ1O+ApVzNv/jRXcalYVpez/xsnOTWwrdk58nr+J3TgorkgsT9nFXN?=
 =?us-ascii?Q?S7VJQDoHQIvqD1ahENMCgqZFs9kT5fJmnNo0RrhkThS8w3k2onD2zeYlbejn?=
 =?us-ascii?Q?ZlMkEdM4Rtb+0lL9TaBeH+DEn4J/CGL8BZ6r74i9DLQSs6oR494D/WYtWsVC?=
 =?us-ascii?Q?8WvIUekYJk/fwGH2qrIKwU8TcX1YmUh/wqLDGKDAQiyPBKDT27+WpVXxtZKa?=
 =?us-ascii?Q?XFN+o7eSqSDA7eW3yxuEYKkt02tnRbdm+U5x5EZqjrM9+2g6yIqo3TUu7URu?=
 =?us-ascii?Q?L+4r4qo7fzPCC6eJhKeoH8tIZDtmaQqFhW/sIQ/IWonK1i32bwhl5nT4Er9I?=
 =?us-ascii?Q?mTv4sKhc7Q9UdO9PULcGiAbG16UFDiZyKvYqPsfyysLgcBLPR4Cte2pRt0gf?=
 =?us-ascii?Q?UrFqcNuw7xo6PgUXp0ZSLRmfR0Ty53u6nMFES/4FEgcCNzYBumHfrU2CzSUs?=
 =?us-ascii?Q?wknE2eHdixihhKs8uoxSxNXE/ord1At9MKFCYC6nGYLgv+M09Ds7Ls3CEtsc?=
 =?us-ascii?Q?Dx7hdQzFHpvokEuUZoz+i4K5cPZYxvHjpxLlH89eJRUbcAl3ZJl0sZf32kyB?=
 =?us-ascii?Q?RrsfbP+s4y5jLMJhugiBWptxqUuG704jiBjEBDWQNPnfHA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?smDCg1QEhhCT5UX/ZtZU3lVqip2QxM3OPOqwJdrHR3RJFO7xHjUIsYVzAAn8?=
 =?us-ascii?Q?7pGBQWKOZBdLApM/CfunyqG8CayZQONEB+btB7Aagb4FitJjVptzEfPJ+bAL?=
 =?us-ascii?Q?LtUr3VMMnSUvUPBjvY66AN+sKX64a+wzbxQiZZevoXp6Vb+b2gjW0yWjt/Mb?=
 =?us-ascii?Q?6RWC4cAVcug3ODMXbwD6X0EUlj4z0G7fMDlw86P3zz75bC/uNO+W7qXmI5T5?=
 =?us-ascii?Q?RYnva5v/1tzzJKAArpPPlLYe/ReFFksIbp1b/+rIadpNt6yYWgBH/O0PpL5Q?=
 =?us-ascii?Q?4Z3FQLUPzx0263KYkiYD2QnQP/aRBAg130n1uyWWf7/EfIXWQBLj+z5OjChC?=
 =?us-ascii?Q?uX4GBt0aQZFiccLru8vFq1uO7FcJnc2KS14amhYSNKFtJpQTBzN9I6fgA8Tq?=
 =?us-ascii?Q?bIMnOUVvxTStc2ecIMS1HQBNpbT0ObYteQ5XC6eLBNQiImGmptzyKLS07a74?=
 =?us-ascii?Q?LwRjHLxm1TnRW9VjsbIkZpBEyktwMFLkCAkItRJc16sDz1bLYaI6DG7uFQkP?=
 =?us-ascii?Q?XQKqCt0yS15Zr4ZTshAq6lIJr2dcdWqqDdss1S2Ult87XR6/HPwk6sUsk/U3?=
 =?us-ascii?Q?GJndxyFM48sE9aT0HLe+T0rsT6j0xxzujvj4s7mxQrkXxyVtZCMNjskbN0RD?=
 =?us-ascii?Q?MIblbB2rEqUaoadIdVJIYlWhQ3du4/TULza9gEKk8vFyCbrNMByS2nP00pvd?=
 =?us-ascii?Q?JRtcKc3aRtEHZc5eJRszWJ2gGbH2b7oWJN5K2mWst06i8dCLGjq5+HypNk8X?=
 =?us-ascii?Q?anmwXeOyqibXuDH3a298PXom7YoC08rUzCVne/LaP/tPGKSGyoy8zOgtJavz?=
 =?us-ascii?Q?F5orUeXYRFrv793/hTFtCY2qOJkU78y+s2fMuEB8SUL3GM8rZGVE5+kvyd3B?=
 =?us-ascii?Q?sJS+80+gDiDQZrXxV4EHovq0Xd+oJp44MytRT4QkLXdILpMglZyFcJG3xCTE?=
 =?us-ascii?Q?UYB3MMVPGVzzRKpqKM2iCseOVusZJt1ad4CHxkvf+GrIF5QfOGBue6AxRe5+?=
 =?us-ascii?Q?m20GxvFQakt1GOgSOH66eC/TQ2T4/PiGJYFuHE7Ua7Z5NB6z0Py9Vw+5cmDe?=
 =?us-ascii?Q?Baxr4wZaiIaCPiA2sVkOVEiqCOaOjP8jd7zO6DhMy0kl0kkKRibWr5juM2Yn?=
 =?us-ascii?Q?V30t1Pomi7Oj17fdhFYr/ZOdBMiFOzw05gvIMBq7ZToJ2oWz9pslLlH4C4oV?=
 =?us-ascii?Q?S/+Rgb4H0rRfRXge9WmZ6GXy+zCvV6DUDqZ9E7gBRkIuWTyNe899nhNKlV2K?=
 =?us-ascii?Q?yiKEvuM0kM7/v86ARZpFks0Gstq6+SBG8O7PKBxAj7c5BBIQLrvHMpfU+fkC?=
 =?us-ascii?Q?H54r+ckFkfQeietNI9mMarggc7YH9Q+jsC7ooUp736LuAcxa8YpFztR30S9c?=
 =?us-ascii?Q?XoHO0btXbZTzZhlVoInwlhu9Srto8FcHRokarVAh67/OXDC+8UUm4q6fLxT9?=
 =?us-ascii?Q?AMW3qdvUvvvoaMg1CkOsXdxomzXruAaoel+DqwsF8Q/1U0X4mUwtyv3lXpnU?=
 =?us-ascii?Q?kzYbyPUU/MrhqTEt1Eo9Wqx/pO/oMWVh0tennnvkZkSiOepttvZBtSkKW78C?=
 =?us-ascii?Q?iSzCGrV9rxXSrVFBFYkvt24gadiJwCbRb42vuIrg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc15968-c208-4b0e-13b8-08dce5ead0c0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 09:39:47.0259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pta2Zdc60x1Q7Jhbu4QG8nIwA1TRYGmi1/XHkP8t1HIC0ER0Z8ml63TzD6N/M4rysE8Y+2Rz0TkIiS7TCDjGwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7670
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

From: Peng Fan <peng.fan@nxp.com>

Support the clk scmi driver probe in pre-reloc stage.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/clk/clk_scmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 84333cdd0c..a01292c479 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -210,4 +210,5 @@ U_BOOT_DRIVER(scmi_clock) = {
 	.id = UCLASS_CLK,
 	.ops = &scmi_clk_ops,
 	.probe = scmi_clk_probe,
+	.flags = DM_FLAG_PRE_RELOC,
 };
-- 
2.34.1


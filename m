Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0F4CAC599
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 09:46:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41BCC835AA;
	Tue, 16 Sep 2025 11:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MHpUpLY2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B06C7835B0; Tue, 16 Sep 2025 11:45:50 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 411868357F
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:45:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p20CQUEDecNuKuNiC4oj+FrqZxNNTwg5xtcA25rqLk9ZslzBc+JbOy0vlTmE7JC2kQOY3NYUACmckIKiGQOlBWT6GSq5l7KRrxm1Ekl91oG5nsPIJxQIOG+Vzz/ebRa5UvsCESmCTWpAWHYEqRwB4pBZc/kJnwpVvRpHhNkCLTh+xHGJ+ssTgS8P3hif8p9Vs50PMFHCRrHRLXqvPUHglcmVrigiff8o7upVkzvDGYKiS7JBWehLfGT4Blkwt9HbO8O2GlGLZCL/N7R6aWSV0Vbr1jtp4Z22xS/fXV3QjHPbrf7JJHOVDhWOKwR0sQW2wXavza05pMlgb8LRGGsXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIAg1ACwUGtwJ5qa1MqOUTFjcdr7q+RO/i3KYQVELbQ=;
 b=fGb2og4laUDgQQBV+S3XeY3c/BC/SGrBAFR0S7b7YZ0pFoEp4rg1js4PyGiUK3MsuV0m2Na4rqCrfBLgqpSEPha0ymTgvi+RF0y04906bk0AGBB8G6E3Fa0IosUjmh1o9US8SxkBjZ6tbEUxCmfeoVvW7CayG6JA6JCKnq50JNnx+DqYM/f2Ur2ml7ATlbKdwf+EtYG5nEytGfLHgRB8n5JZ9aPaDoWVhXZZHCRe4VNaCjeD8xldY0cTAaLFXNuFyQXWzllEMSUh4q1WnDDxZ1l389g0cF0l3qew/SbAxfXOG1URwjQ9tIgsebZMJugNmgUVspyyHeq9d6f31MQzIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIAg1ACwUGtwJ5qa1MqOUTFjcdr7q+RO/i3KYQVELbQ=;
 b=MHpUpLY2A2Xf5zUPFvs9R6xTS4S0nu3Ews3/4h+yfawVrPHZnf3MMbTKaomirV6pCZ2jeIbVQWtdkVQ/5rNSJ/p5P70KA0FxCdxZGkcaPWS5wcaag+rpBM5NmVKmQbjbTbfz5b4I7Og5UDBPDff+kUBPjIGTX93JFShnMmRYwj3ujzuwOV5PW+zCrXhdfVjvLJUq6xLRkcBbkbJG/cN7YIWpVyvbWnn3QbSrJnKgJFRWkcQ+JsYFKpX9ADmFi4fCodOFiqw6y65W5ofLgkmc8s5Lp5yhXEdrTeNQS/0/sU8N27fw9pW/CRzuAMX6p7vD2L0sGs+5OHHCIOa3EkOQyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Tue, 16 Sep
 2025 09:45:46 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 09:45:46 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: sbabic@nabladev.com, festevam@gmail.com, uboot-imx@nxp.com,
 trini@konsulko.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, ye.li@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com
Subject: [v2 08/12] imx9: Change container header temp buffer address
Date: Sun,  7 Sep 2025 04:37:38 +0800
Message-ID: <20250906203743.3352805-9-alice.guo@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 25428fed-c3d3-415e-8703-08ddf505cf5d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x/NOi1SOoo4tRNLnAeLOSB65I/yCJEDd9qypIEqNShr9Bgz5wEiXrGY6thie?=
 =?us-ascii?Q?xsbFwEPGR74/OsXJnkLoDFCRUh1cNRO5nYVq/m0XY2hGynva483BUMRlfjjM?=
 =?us-ascii?Q?IA+aAUvZBjd6e4HVlWjjUeWlRGj4lQsgmvw6bM9IVeJwMdwBxaOUvYAZvfO4?=
 =?us-ascii?Q?u8yIfFsCaZ5vJKT3YumgSsd+91gRi75LmzSImRTAqfz3aH2jJBvAs1Lx4niW?=
 =?us-ascii?Q?e4zXMJPj0dlHabMsnTpVvqLZhZkcR6mYhALzsbLMS3to6S3tIUTA/lbWVWuP?=
 =?us-ascii?Q?AnR8VXuq0XB2469YjSLFQpwIOWmSWCgW3q5HztXHS4tVPotb6xWYXhUx8QUx?=
 =?us-ascii?Q?zlSbbSk4g0sGSMNpkUawZa1vkMA8kRwcJ77ed3ZLcMo8T6o+sNkZLKRQk9hQ?=
 =?us-ascii?Q?A8KuJErrcV58/1P1pE01ategq2G+26+t9SwIu284sbOO0kQQpa4BBt2zkUYV?=
 =?us-ascii?Q?f1ONpkg2EuLdF2k++IUwNIm5ApGh9zh8M2ZRz+GbWxnhoEYJ90TTL4nW5mY5?=
 =?us-ascii?Q?qF4ztHaqrxbXyPnxyVcHA0urK/JxEjWED5qZMUJHTp92AgKxPrEXUt4HJgva?=
 =?us-ascii?Q?KCwxU3uBvLEW/0zBnczSsTUUDfsAs7mzrwC8wdAIbD2cPHd+nfBuB6iIOSuC?=
 =?us-ascii?Q?G+lK6yyzthlUe3FfkyPC2tNtjvIAMs/n7v6M/MJ+U1SoEmJRd9uGgPpsNvJ+?=
 =?us-ascii?Q?GYxTOEAejjyZJoJKT6oW0JusCBaihvjwdy1/o6qJBK82MTmlQQoxgC+tTXOv?=
 =?us-ascii?Q?P/4ji6Zdn1Cv6VZAMcJZeYS1CyxsM9CvRsejghH2trinQdDaP2d3zTAX+C+e?=
 =?us-ascii?Q?v8WJrEXJi/7Lwr/FvyajFbImb3yWrVsseW9kfrZQoeNZrgIAcYxHDw263MWA?=
 =?us-ascii?Q?F+n/8a/1BWoPaVo0o/KsfF6eRmKab3Pwo+MlCobSjWEIU769d1d7HyNLEWt4?=
 =?us-ascii?Q?1KWR8WvRmy9ZxQH9dHkszrpyEl+tATT0telUTGUWl6BukuEBZHsamlpefVtd?=
 =?us-ascii?Q?653ArjuD0Toh2g96pJomK+4FnoJ+lqwwV/EDGV25+5qJb+lLKgePq6upVmuS?=
 =?us-ascii?Q?eUYHoH1lJezoro10YMV89Z99MOxor6sMzm9vPBu9gKEhgoytdhxnvUgOcsT3?=
 =?us-ascii?Q?FIy/reqIBNxoWF+MzNfO2JIrst827r/rK865lPxOb+DVRwgyyujCxhcbNMjw?=
 =?us-ascii?Q?29SaXQVNtPyQxYpYCUlOZzXMMSR2WPbgipBGjqBrIE8OftlxqwVfEJesiHZ9?=
 =?us-ascii?Q?w3NULw78Wq53CTQ6+m9YAxBVVPDd1xqFLHt+IHco3yiUf8QjDqaj7gG9rjOk?=
 =?us-ascii?Q?4V+X6mFsOHF05KE7F/ae7IcDeQMH8pZoMMLZCkYSYWoZD1aYnXhN9tmo9Tn3?=
 =?us-ascii?Q?ILxdOHoHX0E7uRJ37IJkot1/MU2/eBsWNIk4oCcnzKyFlqdSTBT8rN/yYeV8?=
 =?us-ascii?Q?gCTZ65tLTCr0kPO7NAwLtSOW5cSeDqab5fJ7Fcly1BXHnOFJBLAspw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A8MvT0S1M/nY1mt547YeufK0sObGCxsqNw8FAFqG/MDIvdKL12yMOHqPdJfD?=
 =?us-ascii?Q?Z0N07xMGbCjyTu7nMRqVeW7IIe5bhINd3TFZ6csgfC3W2ylQjU4eeFfQzOV0?=
 =?us-ascii?Q?9nFiqtiQ/H9MNR/YUjRJ1LroIr08LFyGZ2n23M/mMlrj1IVHQDHx+WFbLvBt?=
 =?us-ascii?Q?+nY9+anW01GKcxgf1RSPTHW0R6lhyBnqQ4UV/80mp7CE2OIWIJEdkAIPJHcW?=
 =?us-ascii?Q?IUuJAZv/6Z+W8ioEb9PmSCgj6aDAtkL3rJ0m+GuSFbvUswGjLZys33gkrniz?=
 =?us-ascii?Q?zJOqUrveGtXntKzw4RbYmkq5LeX92iwZnj6aK0TeFgldgmtdUJfq31J8MGsi?=
 =?us-ascii?Q?E/o/nXwn0t+0Rh/iJ6L9ef0MbhxbrDoCV+Pe3XR+35NbusPvyb0h8NAGofXh?=
 =?us-ascii?Q?3dBcduAYHWs8LiCU5cx+eHty/22kvfRE8BYT9abKhbRq4o1QHkgAmXUJr2sv?=
 =?us-ascii?Q?mJg7/FPYil8bIzvTSodsjCxc96m+/AMmX/obtZAdbn+/o0cUppYYp/04xhvO?=
 =?us-ascii?Q?x+/D9TujQaDHt2k0H8FXA3uw56IG4KzyTYX9ldudV4PNvpij1Oq78G/v/BMZ?=
 =?us-ascii?Q?UOIT2DlEMqwZ9tPPPAgX35TwAIMI1xiiL3KsJSTs5FslchgHbv1x93ucHcTX?=
 =?us-ascii?Q?YHLepqEMY5B+EQ5ZaWZeKXMdnkGoLk6kxY8S0TfDYd+718RL9kbOLqImX7Fo?=
 =?us-ascii?Q?UN0cPz/kYmWdJLmLVV6R1OorHVrbsiUGh3crl4daJajEltegXtlXrWdzKIZy?=
 =?us-ascii?Q?YB9Pgg+clyvL/59surUeNONNkAmUeqP2FTF/rq/B2Og9Y6v3bsRnIcCmLR6u?=
 =?us-ascii?Q?zjqddutWyUc9jGby6+JfaJm/a/LvvZPx+VmbLJD4BSO3bjCjUVMtdRrpb63l?=
 =?us-ascii?Q?q8N8Wu9TvElhplIj9boO4mtWoyJlrg2GJPQ/pdRZANulv4K/Q23RA7w2Y8TC?=
 =?us-ascii?Q?6FkG/jXks0MyU9DizzdYC2qxjiUVFhGwdS4+06r/42udU0WpUTkuHzhZ60d/?=
 =?us-ascii?Q?0Fk7aSuqhjIJEUKPJCvaCZQWyaxAadMtqZln2Tp5tWUIvgceqvTmNOicFO04?=
 =?us-ascii?Q?9qwVt99LGi2jaOpgfue1B9CnmIglmowI9dnO5DINnP8fM8YzXahkZlhqGlkf?=
 =?us-ascii?Q?c33K97S8+TGhv78WPucF1Ibsnne05Cx7oRIoVzpx9N8RrtnUy11vDISgfwIT?=
 =?us-ascii?Q?+TT6ZMa1lhBfb1NLmaAkDSsIijdNqwbR+6OMrYsln3qnbKt+GFTUAO8vuG5o?=
 =?us-ascii?Q?A14dQQuhVn8/DJSxP60qFKQOWOqhXk3cfd8l3mwEq/+r/IVfCb2lOoc7s8QP?=
 =?us-ascii?Q?8y6FiVfhVIi8BNyNxHisOwc2NgUwuCf/el1krUIC1ISi+A8LYm+hudV6xRBK?=
 =?us-ascii?Q?+Kg9R+wy2Z6k47ll/JkJ5AOATdG2vkf++hdAO39kpPOKERnXXHm346PbD1Jj?=
 =?us-ascii?Q?sd8OnBcSBrJ8HJZUkmx6fhacSUGAFtV/dpzUat1zxqHqifE6u/eR/fbgFVdl?=
 =?us-ascii?Q?xZzypjNeXook4Y8I75fMZ8j5XDhxfRGL/nTw70pmwRnPhP5C1lZPQjNvcAtf?=
 =?us-ascii?Q?iH2TxRC1CYCAaoWvRNqSCTAdR84p9gb6Z7AGxdrj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25428fed-c3d3-415e-8703-08ddf505cf5d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 09:45:46.3120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWtcps53/JQOJCEGrimi/8BE69mzBJMlE16rjHDlnrWXNB+//6qzTZAdXc5iJqfjXvYf3GhORVVaCToqexND6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957
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

Due to i.MX95 has reserved first 256MB DDR, change to use the DDR
start address in u-boot as the container header buffer.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx9/imx-regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index a44fa6663c3..e641ed299c0 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -57,7 +57,7 @@
 #define SRC_MIX_SLICE_FUNC_STAT_SSAR_STAT BIT(8)
 #define SRC_MIX_SLICE_FUNC_STAT_MEM_STAT BIT(12)
 
-#define IMG_CONTAINER_BASE             (0x80000000UL)
+#define IMG_CONTAINER_BASE             CFG_SYS_SDRAM_BASE
 
 #define BCTRL_GPR_ENET_QOS_INTF_MODE_MASK        GENMASK(3, 1)
 #define BCTRL_GPR_ENET_QOS_INTF_SEL_MII          (0x0 << 1)
-- 
2.43.0


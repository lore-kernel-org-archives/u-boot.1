Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B597FEA83E
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 11:22:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DFD38352B;
	Wed, 25 Mar 2026 12:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rHwbrnoq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F86083A91; Wed, 25 Mar 2026 12:22:56 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 990FE80517
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GcfG7f6GOdHNvqx0C+LDAtrqStJ5FtCoTUIr951q57Ayf3Ub/Pw41OX1ZIqQeXPsH+iszf54//uQjwYl+nn+IBXHp0KqX8r6Bvfv0ga9yMHh2kKGzvhViJoGbuSRUru1Gg/Ls5ZF9aF02ToJptAUDRnNCwx9BmvD9hHe9fwYqVMPWvP0F6WTJUBsZ5e6ZtNpsSO3KbxIw+TBGi9Ryib5v4YM9L8J+1CLM7K2ysW8EpVSVgQI6MB2cFLJ0aCn0Y1sjFw17e4LVte/Kzhx3eywT263+YAG3/DM0zUbDu9sPMrqUH5UexKSt29BPUU59BkwQ1j1uj8RSpNJmXz7WMvw9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQHmbGckdEWzrnJbIva6t2X+2JWkRvgfJhMA4+XC/u4=;
 b=m/KuBVZ5wFDuaSm15loExxZEcbNFF0kCujHgotJMC8iVqev3UMcfbp/sJWAe/Yj5W3Uzz6vKPTkBe6HghPU2Zu3v5oL+RjL05D6rOhhePFZpdIrLrOfyyLjCCdjnVQkbj4lf02+NDEo0Z0/LoJi9Ut8dENtJcjgSqUWv/ZseuM5GzATljWW228cn7Y2x0HZVX8LXOlM1cdOW5PmYY3wCHFA7Kqsy/qqylhcx3iGGUoWuq2gWP2ije05uR9mKLIz1sct5+L9YgaQlEjI6oWhOfvM3E1wDnFHi+MZ/3blnaPE88Qg8aVeqbU8SbPakmUEbR7ugCqCH7dyX6lGo75ppLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQHmbGckdEWzrnJbIva6t2X+2JWkRvgfJhMA4+XC/u4=;
 b=rHwbrnoqjR3GyPNu/Pxn8YFcKJZyjbqH2b4snRtnEm5XUCqXYKgYc5Reoe39BcaPf8vU5c0+bkQ0OI9Fnyd0MHbyCekAIux+d21t0k3i96UqspYKKuCgYgMinaYP7wypeS+vr0C+rPXVH13XP3vY+fIbQIlkvLkU0OawAYR2oeWoQ0FyVeh1w3StRePbbwpt2yx0yyd3nx13wVytAp8q7c3GsWmqKOxKGpDA5IdQaFFOrlcQ8Y1JIz+lE/ux3YMOvx1FLp2vxC9/7X1ChAFpY+b4w5DrDWZDOnlQdA4v3tBOeYkK/dXhhF7mnA3AUnaLxb7qfl6VSmTIKyZCebkDQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by OSKPR04MB11367.eurprd04.prod.outlook.com (2603:10a6:e10:9d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 11:22:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 11:22:31 +0000
Date: Wed, 25 Mar 2026 19:25:04 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: Re: [PATCH v2 2/8] board/tq: Add common SoM API
Message-ID: <acPGEGc16f3xwasm@shlinux89>
References: <20260325095801.47706-1-Alexander.Feilke@ew.tq-group.com>
 <20260325095801.47706-3-Alexander.Feilke@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325095801.47706-3-Alexander.Feilke@ew.tq-group.com>
X-ClientProxiedBy: MA0PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|OSKPR04MB11367:EE_
X-MS-Office365-Filtering-Correlation-Id: 757052a8-da31-453f-9e1a-08de8a60cde1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|19092799006|376014|38350700014|56012099003|22082099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: w4ceyI7qokwQl+weGTl9bhztG5mBYyC6lQRPPEDuD6W+/wiQ6zOsp2kRIcBK5YJI6GZEKZhAxA2jlNRy4aFvjqVPV88QRhVsiCHRqbD6+MBDojFaAf31OMBRd+/JHbowjfNcI6HXiei67JhLfinlR3gMB5oKlvPSLLXE9VszZNsvc3OlzqA/cpnoL3RHv3PLKXxbSpbbRBoaUp4W9gNg97sON6P9CNZSOUZrHzqpGlS5M/JINEUmuYnIvy1mZKC2zc2k7JMgO77SFjFtPUTCPigg2RdVzNj9yOnyCDCYikD7zo/8k6s2pAIMlcH2Pe8t8BLOF88kC/cz5N6J7RFH3xTQOizUAtxYZsrsdbnxSBgSoLAPEXlUyCexuQPFLqkY0hLN+FYXpMjPOILiwRd2FkgWlkNDQ9SeFq4/ewoH6OrOpAEGIw5IsEKiQu77QuQawmfZ80jmJQjFKEGVveUaCUuSxnTdfiPC+Vz54bSjTg3iaJf7KNIvOG78rhRxefo+RORHkjgiCDVZ4jlVQrS3zX7CuGg9TVmVEeVqNV6HVjY5lHZn1h7P22F8qnwt8BOqvXvRz8yQLMFolumoWTjfDbyse058zx0QG9utbwaRwRIRMwKEyUriSr60nD3qN/B5W9x6PMgfxlQsB/rqo1LHLzeV9fnmsWNR5wUrEgR9gIMqmlEM0ejBrLWv5CiLhgPWnQ7+b5Se4NF+96q2xcZUowzCuqLJ+56hAoirwN6tuODR6gmW053hXuUl0/5R0w5W4IEOIG6K6urJWe+6HyIiWJumDDUNK93jTaDc0dQ6mCA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(19092799006)(376014)(38350700014)(56012099003)(22082099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tvAd2jxfZnuvV9rI3+QrXxzC4Nqyt8H9AEOleHBHYGkeQ5DGNycoDhF2m0A4?=
 =?us-ascii?Q?dyOxhsFWGWwxJHuboMfISJC8BFrg4zbN7cxqdkbIrJ5gkcCHb41J+T/PxDJ9?=
 =?us-ascii?Q?J1Yqac8MlRAQAkpgcHKarRNm7j+WKbwaVdAa2jWksXfYFLRH4DxyTJa6HMTO?=
 =?us-ascii?Q?JfaMiFOUWNg+L8hJqislbybxydqkQNxwOzorG1oslfKnLu51KWNEDXn669lr?=
 =?us-ascii?Q?Nneh6IXktraetNjOr66PITayodzZpdI/x3y98e7+hJvCgliOMG9kZPIfOTRB?=
 =?us-ascii?Q?5LDbaxh61uGxxWfHw44fvKowjrigIPPEbx2oueh01Zfi3pcU45Qcw8IzuslA?=
 =?us-ascii?Q?ctB/PcnVqKGvnkyKj3iDJnRHoX8bDfhRZP9/DbGIC+GEPL4omUJ8RZy57vb0?=
 =?us-ascii?Q?jh86n22djBN3JoP4ho/i1/k26aEsR9s8QW+/MtST3+dWzgtZx5A07olzAVMc?=
 =?us-ascii?Q?3nvZ0yZq/f0AUwrDwKla12TKxk6r3KFkvXc+EAqnCDA7o71mJWVq840wMXCl?=
 =?us-ascii?Q?NIXSYRpnXEy5e21IYxzvl8/NpiFd1JEsM/1vPNOAXBZQTvIlsx6/xb2hW+GD?=
 =?us-ascii?Q?HcW3+AQ3G02EZgabgkapuXurnJN4kX8XoNfh+peKh1yGW3/Xi/yBDURFtLCg?=
 =?us-ascii?Q?CqNRKSk1bvWpTu6je+pS18QZy/Zi3pyqcT6Tz1E1RX+hwmimBaRUO/ojWCF5?=
 =?us-ascii?Q?kH/oHe+blY2tVcd8fCykAWrDT8ukT8dHlCRIqMU8wGNj0AVqdoXh15JOAKqF?=
 =?us-ascii?Q?7KfuVOq5im+PsVYZK/HzUlmN8PPvVqJBcJ/gqRed9Dgl8jr64uHz/Sfi09o9?=
 =?us-ascii?Q?RQmfKIerv+5GSa7rFjwg8VZEQwwL2e9aDxY8nlh4kzmvwTgDqTAw+lNyZ8Od?=
 =?us-ascii?Q?quOhqm7arRBAeCi6mkm67QYL/tUOMPvuf8IUT9FEWwOlwe1bBDuI0L3AI4Tn?=
 =?us-ascii?Q?dUDE+NF+wIm/I4Tw1TvCEX3ztDRdpLRlNVcPuochxUqzYhDl5ATs+0djQ0Va?=
 =?us-ascii?Q?sEB5GVeG1wCvuECceraP4kG7z3HN26Jap7jCaCpB4PWx5jnzFT6v2mKVNPgS?=
 =?us-ascii?Q?XmhIfK0Jkh3e8V3SJjgL5WUdBTML1B/zW7kyEAXG/HYSk6knsBkIpUxXftbd?=
 =?us-ascii?Q?pG4YD+g3aYcb28FdtISIs2ON6Ywx1Hu27QC1H48kKj/BhZ5gmmzgxHKf5o3u?=
 =?us-ascii?Q?puSDW+HuiuuGMGa2Ws53HHHjwllSdQev002zi+CZY0BeSUg1uuHWuDrQNIpm?=
 =?us-ascii?Q?8bT+jSq0fkWepTIyuF1jus6H6q8D+/AcBUZ6dTxOCVg379o80BcKSDblU95B?=
 =?us-ascii?Q?ayg/6TZ1Hz+cWgyIBrV7LGsesrUudoH9kaK9wfDOk+VB1VxTTnLSQ/3emelX?=
 =?us-ascii?Q?joz91I8IPwm/IuwGnK6OfFVpH5lxozpuDoYtGlBT32J5iumridJ0CnPVexO4?=
 =?us-ascii?Q?XNqYX3moWWuEcugu9nZV1q7HeFVJpulGyJUKG0zyej86elQDOkHEUlS5BKim?=
 =?us-ascii?Q?90nu51QIv2TcHgTnYfbqNsznR/IULGqWlKeTiGzdAPWrHAma5/rQhrEXH8Je?=
 =?us-ascii?Q?RHXs54ML42BQChyRDr8muhABL1JIrf45wSwqSn9r16vK9M3rdtmYgLqahjUV?=
 =?us-ascii?Q?1UcJgeXMfq+/hXNmttaldp2eSF4gPf8ilxgpKFI47PXF5xszhsqrW5YaQA0U?=
 =?us-ascii?Q?h/yu2ECZ5sIQJERBM6mbtnrkXwbYSJQyjtKLZCAiUsuzye5+qqCVIYLgyjvq?=
 =?us-ascii?Q?zJKrD6FMtQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 757052a8-da31-453f-9e1a-08de8a60cde1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:22:31.0127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0wjvV2yix9VCa+1/tIVWnWdGn4F9YCJeYyeWTX+idMpyNacvbmQTLBhEeV/PqjagiHninOkix05lqCJJL2r6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11367
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

On Wed, Mar 25, 2026 at 10:57:55AM +0100, Alexander Feilke wrote:
>From: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
>Reduce code duplication by adding a default implementation.
>
>Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
>---
>+static inline void tq_som_check_bits_set(u32 address, u32 mask)
>+{
>+	while ((readl(address) & mask) != mask)
>+		;

You may need to use readl_poll_timeout API.

Regards
Peng

>+}
>+
>+#endif /* __TQ_SOM_H */
>-- 
>2.34.1
>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DFFD58CBB
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 01:46:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7452783DB6;
	Mon, 23 Mar 2026 02:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HynENdxe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8611A83FEC; Mon, 23 Mar 2026 02:46:30 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B27D8366F
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 02:46:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+IvLbvxZ/fEnoduzkHp5EH5OKA6Vhdd720HFZgWzTHIZ7+Tpp7J/ojR0IPbd/ERF9zd8tHFdoW5c9b9MIFMwbgdBuTKnn4uhv3/N2sr7CjuuFLAZWCvQM/J/XMxAvcY+kl8pUav1TubcgLoTl55HNLjW0EAn51lN4VvDUuTKR3G4OLa7bbXggxr7veFIEi+rM197q7xIvPy+ZBm+3lw38CS2KvSsPoqCmR5Y+xE7VxTa0lHwCv/QazwEAvdXcF/lTAXgrBIYIsbv/XgVhVCWx2ZwkuyDhDdNjudm3ks2ga8E3Cjfqr+mcJmtfURHLAMQKZibziN5k5JaJMTVOE0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xCKkInLlT1S3eoXSu2pi7DbdDLXZgpjsW6YI73a0zk=;
 b=AKXjW5+TCqGZSwTq3sWFEBukstdoRm3VQj/HDmwj4GtDsXsL3xjD7A2+9+1c6iJkx6rk2N93KtePBU6pzsi6CuPxq50FGGJupPWKFY0x0wCbcBH7S99k0jkt5AR3NWmJLRMHe+vnLXbw/HDY4qxRzZ0adQLRgT0iJAIl9+GhRfsyvUbREdFmDnrNPuydTB4oUln0QXa7Nv0LVbAb7I2QRpqUYs7f4IIrYsXluY185UBgMhx7TbracTsoV3jKvNiLNhUMUu3fXOOw9FPUxTERSS/warB/w1FUheH7gizzfL3fwDPJzTQH9C3O3n7exoFIh3lQYQZiJNcpr17pjhJSUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xCKkInLlT1S3eoXSu2pi7DbdDLXZgpjsW6YI73a0zk=;
 b=HynENdxezHyg1W7C9mpfIeDtOBjCr3QvPc2I+cyf6Rtl07Z+VZwC69xjmgWznoa78ZZGKNUQV3Dr4IqWfN79J2ROC9idjZGqveY+0Vh24XtBDmbD/WfdVYbBxMr46f03kOAhsV/qNXhlJO8ulLM31w8DDruJcQ1vlGKyxVCGkwAbwDL57JNiB1RKFyPoSuIMNY5newmWR1YcwR2p9fZ0iYFfSKR7UQzB0qW8x1tLZ7Rkpu83ZusMq9IRZ4YXSw42GXYQc3Yj0qyNUBSAXGYbVpQveHgugTwN90HAHW3dWzK/CNBhYLAeOjaxxj8tUJ7OgUHzfFOFLKB1699QOZ5meQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7728.eurprd04.prod.outlook.com (2603:10a6:102:e8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 01:46:01 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 01:46:04 +0000
Date: Mon, 23 Mar 2026 11:02:06 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Kamlesh Gurudasani <kamlesh@ti.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Alice Guo <alice.guo@nxp.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>, anshuld@ti.com,
 vigneshr@ti.com
Subject: Re: [PATCH] clk: scmi: Fix protocol version fetch for non-CCF
 platforms
Message-ID: <acCtLvgX8T0OINDc@nxa18884-linux.ap.freescale.net>
References: <20260227-ccf-v1-1-a22c19460b74@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227-ccf-v1-1-a22c19460b74@ti.com>
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dcce03b-a310-4b43-aa58-08de887df1fa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|7416014|376014|52116014|1800799024|38350700014|56012099003|22082099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: 9bYZs7JxQGgQfevbGY1o0oo7CaY6QWuhtnea0z3Lvlf7tpK6HkdL/RFjEgxuHlm8dnlsM+gfvWhYhIkySkqpN1sXLnDbSuz1bL18AYot/Q9veLyy9f+dbgZjMKTgoBJ5tTMT9c0T9v+0ZIPSzV0pHfU/UAxwTF88z6J7x7Pao4sRuEczxIGyBK5lTcVkyh/1ZqMy3c0F2YXaFYxXJXiWdjgRKgor+w6OC4MHvKel93XkiUdaCj2An88mqNlxPDBSN1aU2W5K15KCNlQpM6zU0/DWmO5P8D7NDAtfFf/roIkxUgzb5Z37Dt14VbkakaHmlZ8ANiE+QQvUwarvdDbzFa9jdE6LGdKqpN0YI8WoSnBCBn89szVkeQwxfDbaEU7h7BUFTobHL+DHfKLzJki2Jm3j5941gNF6bWltnkwB8XyN3JA/zVL8DwFO4ftOaYcJ/c/ecJBqlFClIfeMft968ljlaBP4IMXcFLVEWmh9kXjZrNA1NxKXcVt48n6ZY5VUvO64rP/eWOhfdR94v0l3o0E76kcAxCr7ViLNPP/8KThPC6dxdYP7cKNuJMGMFLTVCt+jP6c/A4EAsxkxWtyfLfYD2r4s8ulcIlpVtlckvh8aXEg/3+ZzIJ03C17k3dwjeNmUmTTiYcngvhGHwSufX1BgK4o95vvTZTs5xjxkKH9Uo/HNic7kcy3oEmeIbKmJz/Rc4G9QIXCRqy6ZL4SwVv7SV4vCtxrG5dwrVpSfxlJAy06wknCdM/VsHs4hxhoEuMrlydbfsPc4n79Qgwf3/op3xRb9kKFfBU2hmhKyyBg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014)(56012099003)(22082099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q2f7eVX/GEZbsbZEn0x3v8Dm0p9iFYgGmsBXyjOZPzWOyWxeht314QhvqaFs?=
 =?us-ascii?Q?JftRnw2YS2lA+CUkdBq7gWcgvYMkd6w6PKQFi51mxAA6gr2pxlChI3FJL2FQ?=
 =?us-ascii?Q?8JnJ9W3zp7W/DbalrgSbus6kJr0lgWkaMo02IzbY3CnC8jmYXu4TPcVzHKeS?=
 =?us-ascii?Q?2ZI5r9FOg9hse2j9L4/LRr4oeUX0FGXY+6THN8SqI81M5kbkxSf8WVnnAz9W?=
 =?us-ascii?Q?smp3UqH2QcXmvmF7l+9my8pztNdcVfOJVYA8CEOW+xUKPzoYCxtjuS/T482l?=
 =?us-ascii?Q?N9klnRY2awILYxjzP5Ycy/Go0aeocqS21rBnVN1chppHak90hL8YtMfqysPw?=
 =?us-ascii?Q?V9KM34YxynzcAMbS+SfypfwjfDuNkYriF96Y+3GHqX5HwJf3BM1PXA552tT9?=
 =?us-ascii?Q?Qk1DliZ/WkxZOC0SEpNkQlq8cyRsWRlt+U3iMfKR+Yn8moEvNZ/EuONE8MOa?=
 =?us-ascii?Q?s9ZF2weWzY0NvptjTlYKFDm+jZNDzhATQ85u0dOz4dfgVu8UjSmOMRScK4AH?=
 =?us-ascii?Q?wwMPjxpY5l7KjsJ8O3OQYFYCQ8bUtSIEhq9A21YxXDKEqXJIy5DaeK/D7aIT?=
 =?us-ascii?Q?LyMaoO5aqqCysxdjbZpncDIHK/CHyxWWrnaTyhgAoyPTKF3GcT0FqBtGoyA3?=
 =?us-ascii?Q?kh0UqNjOFCqz2o/nyE35LmYEizn4DS4eW2tvgGvYC2qAqzXpJwr3OxbD0FRp?=
 =?us-ascii?Q?z9ukPx4l/8AfDomHELnR0Qj+/qgx83YKEgQtMkzAvqnLlRwYj34fwP/gRWHB?=
 =?us-ascii?Q?9EcU0/pUNOmTbGL1gSTGr3HU1SNlnJOx/0wk3cbQzo2ZXPeR9ws5G6jXO4aa?=
 =?us-ascii?Q?yOY1ga+lmD6KqsQE9kCHJrFBBcPsuXWwSUAwJvOPXMPoLx71UeRyf+3EfA7X?=
 =?us-ascii?Q?qTH4pwlseVHbCLQW4lTAR9heHf+qs1+ToIhj/csRg5BiByN0qR+oRthCCTju?=
 =?us-ascii?Q?ADZjlVpb0pZcbK9vCN7voC9gNEssbYpeTZTuydXkE0djeF3yde8g8zeujtuK?=
 =?us-ascii?Q?uduLOt3AKbWiinaPOGC3GW3YLq3X4Hi8/b+EIfDVUUsYl9YLn4XSy2pd4TDJ?=
 =?us-ascii?Q?Bjjr6Ox/hzQbrlkC3FbRbPEAdsZn59KQJ+0+8xuP6wRXr4JXOe90v08asIMl?=
 =?us-ascii?Q?2B5JZ0r/pSjrXY7MIxRngnBwqI3Zcn0Naumk1DbzXjBM/ElgtBuHHokIUjfN?=
 =?us-ascii?Q?Nud4Pvp72OEcrOhOjY1ScQCOzcb45Z+9nMO1obAgpHJSBSB6l5bHiSUV9WcU?=
 =?us-ascii?Q?pAyABdr1v4MJ/UtTAgumgS4pwSGiBhJiMZHTpCNEnT4f2yR6YEmcGdrJJ+iy?=
 =?us-ascii?Q?wSXhIgmypJgNSpd6RykeWS706ZVtMAWZ7pBOhuijzgxScQnww08QMNfhXJ9Z?=
 =?us-ascii?Q?b9SuqpuNNr1H4ZN/T4CHWt3Gklvq/xuFbZn3NPYAI4KrVwaFOb9bZV88GB6b?=
 =?us-ascii?Q?+j6qvm1Psmekr8aMmqRv7ITDUIzLJkZlMN7Q+5QU7aIFs012YkOrNyQ+R8W9?=
 =?us-ascii?Q?nmdIeuC4d9PewXbGcXTf+7PpN41w67CJfodRj3SjwoCbAap9PikU/xj9o1hs?=
 =?us-ascii?Q?T9A2ADD1emU9o+S9ZL3Fv25NodaLP4QEN9dGSuqw5/toapWT5s7sJXLfSIFM?=
 =?us-ascii?Q?8I9tnAVCswsqKsBwrw3A3syPPxKv4u8EvoKYDG0bYfrzvTrUXzrrEVoC3tZV?=
 =?us-ascii?Q?iyi+H99+r64uj0ZpJ7j1ikRyuNutUJBFCJGtb6jxZgygRwW4L8+lTLqIQXRJ?=
 =?us-ascii?Q?IKym4JU9fg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcce03b-a310-4b43-aa58-08de887df1fa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 01:46:04.7277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXy7L/fum5kGqGX7oI76SwuvTL+F/GqkkCYvfKFmYfShTSpZhbG0wks5xP7vQHNVzp5BKvnPEgNqoiQsaq3Z9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7728
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

On Fri, Feb 27, 2026 at 05:37:37PM +0530, Kamlesh Gurudasani wrote:
>The SCMI clock protocol version was only being fetched when CLK_CCF
>was enabled. On non-CCF platforms, the probe function returned early
>without fetching the version, leaving priv->version as 0.
>
>This caused issues because code paths like scmi_clk_gate() and
>scmi_clk_get_permissions() depend on priv->version to determine
>which protocol message format to use, even in non-CCF mode.
>
>Fix this by moving the scmi_generic_protocol_version() call before
>the CLK_CCF check, ensuring the version is fetched for both CCF and
>non-CCF platforms.

Please include a Fixes tag.

And update commit message on which platform was tested.

Thanks,
Peng

>
>Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
>---
> drivers/clk/clk_scmi.c | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
>index ee237ed6337..12c7b1e8254 100644
>--- a/drivers/clk/clk_scmi.c
>+++ b/drivers/clk/clk_scmi.c
>@@ -341,6 +341,12 @@ static int scmi_clk_probe(struct udevice *dev)
> 	if (ret)
> 		return ret;
> 
>+	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK, &priv->version);
>+	if (ret) {
>+		dev_dbg(dev, "%s: get SCMI clock management protocol version failed\n", __func__);
>+		return ret;
>+	}
>+
> 	if (!CONFIG_IS_ENABLED(CLK_CCF))
> 		return 0;
> 
>@@ -352,12 +358,6 @@ static int scmi_clk_probe(struct udevice *dev)
> 	if (ret)
> 		return ret;
> 
>-	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK, &priv->version);
>-	if (ret) {
>-		dev_dbg(dev, "%s: get SCMI clock management protocol version failed\n", __func__);
>-		return ret;
>-	}
>-
> 	clk_scmi_bulk = kzalloc(num_clocks * sizeof(*clk_scmi), GFP_KERNEL);
> 	if (!clk_scmi_bulk)
> 		return -ENOMEM;
>
>---
>base-commit: f6963fc232603007c661411fb31c57f1a9678a87
>change-id: 20260227-ccf-d7f40a33985c
>
>Best regards,
>-- 
>Kamlesh Gurudasani <kamlesh@ti.com>
>
>

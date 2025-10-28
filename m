Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F7FCCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 13:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EEC4836B4;
	Tue, 28 Oct 2025 14:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kCO0GtIX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EF2283A43; Tue, 28 Oct 2025 11:44:33 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E92A683A13
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 11:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWmbK1fBVk2rog2KDSKP6LkJBo4JOi5xdQDRphY6nQBT0Mz+Aa109CfRROc3WqZ60/tFbP7ka3Y97xE2iVVOm3bQYsrS2XfWsDGlAsuKRrPH/stRAqDIZbREByDYSiGVNWQEuB9s17dnV3GmoFKTE/vo5FcUyUjq5PEis4FepUrGHrNjcSOMfF+flhcj5Mwwjkt60maH472pR2h2di0EsCLLnsN+0CbNdSlJY6cYSaXNTuIuQEpdgEtuHtcVAT+8/sCOghpsr00UeX/tD9MAQs0QTZhh/zr9I6Kl78y4IFSG29HRThBH+8LvW39mNOLjigsC3TcDkAS3KETHIkrlPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLcJdtDLAAkl40Hw0kQB7oS0pvg5GV6Mku0LP7REPYo=;
 b=UgOizQl7w7AD3jv7MF91ZA7njOG/UGHYYHrSnyQys7AXjyp0AUsSw9s+1yF36FAIvdCyvUJMAH8q4SzdSO4FiayVBiSSniDKOp1L+frygMB8ncZcTBPyB4ad8gHw0fuTyTVQ/2aRDvH1icY15u2LHSO959tQ8LzsjZli4PbyT5A5fbX3Hq2ASl7KQLXkVzolCEgXuiopyuI8P9v3hO2j+qmu3c/mddWB33V2f5FaryXZARVtOLua0BQsdqZqDxmj9zW2YcxhcgXwLB9QI/KrKsVxLElNMKXxbkTJrdttlKGWmL13iaAFnJF2wljxEXI+ApYYQ2NP0TsNcTJoI/JNLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLcJdtDLAAkl40Hw0kQB7oS0pvg5GV6Mku0LP7REPYo=;
 b=kCO0GtIXehtPupiA5Vct5CEULMjGwAXHxWl7Ph2s6nudnAR4/9oKiWgsdBD8XHBIiLX2uXzPvvxiwVEPFtzsWZeNxgWWQRkXdy4/i4CtK7h0Yg6qwnxaQQJTXtcU7besAOcOqNnG6SuVL4Hnq5Hc5i3ODhtWLMIi4Eky6HWLg+1B//dHWbVqTFTUiIDJgLJS+cjCMv5Fth+qK6Q7bt+sIbomvFEG4ub/xF3KUoRxa51thcItUrE0TEuM0PilmaJQD+r2NcpjbvF1GVsNm2uosAMXQoopPJT2N1+WMhQOwRbf3AR2ukTFQ2td0ZMvQqM10cMJ3bBO6MAIACr3jt9sEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV2PR04MB11351.eurprd04.prod.outlook.com (2603:10a6:150:2a3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 10:44:28 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 10:44:27 +0000
Date: Tue, 28 Oct 2025 19:56:45 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Subject: Re: [PATCH 3/4] clk: scmi: Postpone clock name resolution
Message-ID: <20251028115645.GA9371@nxa18884-linux.ap.freescale.net>
References: <20251028034225.260469-1-marek.vasut+renesas@mailbox.org>
 <20251028034225.260469-3-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028034225.260469-3-marek.vasut+renesas@mailbox.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR03CA0095.apcprd03.prod.outlook.com
 (2603:1096:4:7c::23) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV2PR04MB11351:EE_
X-MS-Office365-Filtering-Correlation-Id: ad908767-414b-4182-750b-08de160ef72b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xMftIZQNqW/CSNtIjkjZjwGf2tC7ZWoPUMqX5g2h7s7C75m7hZz5Dq9KDwCG?=
 =?us-ascii?Q?HQZIEoR/Cghd70mYLRWONt6Ml9MYaDWr1/fwnJiFWN8fjcpVvVsfv6LBw5iu?=
 =?us-ascii?Q?BT4M/v7x+nEU3MRXAH2TwjROdL1A12C8K3/6HCA80Gf05Xx+isBYgMG5yNYv?=
 =?us-ascii?Q?Rm2tYmh6G689CsNjWO3lZ9tbCpUzzDyAj2A7nZWCAE3E6L+T8AEvA4P7Ld0t?=
 =?us-ascii?Q?3RJvgVcfno8Xtd+h8GAoZIKm7Rk/nBVe/DUX61VwhThzuD5z9rq1jJUYQyal?=
 =?us-ascii?Q?W+iWEle1LRAm13J4qmPKt8tFl/iiBzqeGPbdyq7VdkOD4keSxg0VlnbAGKij?=
 =?us-ascii?Q?u5BTpQtrGQTujg11/S+u/osmaaCZYa28YYSIX09kgAsthXpceDUdptfBNvnp?=
 =?us-ascii?Q?VEftpTSa7eXrf6dmOaiXeTrivyCAh4oECEbGbmv/EctKiX11UNy8LabUpFkv?=
 =?us-ascii?Q?mi7ag+0U1wnd4LuXrnpDqA6Cmux6U+9LTf/wWnwcrE416HTXQFMGxzcfvP4h?=
 =?us-ascii?Q?z0bz/hlKffKe/9jE99cwCpThY6588TaQf+uCdfpf/eupF+wD3I12WXMb7RKd?=
 =?us-ascii?Q?9ej4r+IvnXpBBkRQib2U5jDCKFodA5AfIzoa2CrsMg/fiOSOY+L/W9rX1Poa?=
 =?us-ascii?Q?4/VXENvrfHb/chyAS3rqnJZhnUhjCll9f61LNDgeh/vUBD8ueEgT35XB/DMZ?=
 =?us-ascii?Q?DvmKksfntPZQQTM83l4oiMXrvrJ6DWNe7wAlFyb9J1mvu+Y1q8VuRouPATHo?=
 =?us-ascii?Q?SC+FqLk1solyasfGWcylqSBEF4HgBi8F8jnXy9glWUb33ufDmkuyvR+E2Zz4?=
 =?us-ascii?Q?i2Xwsy6P+W/66w7QoI2Gt2J9pe/MtUcIY2h8EgBkNtv9f/sQsIGK1oDWgJfB?=
 =?us-ascii?Q?DTa0Z01Av/1u0nETEQmESe7YHhR2r+IWuVnQnuvJIVzM/psAxnjG/XkX35ML?=
 =?us-ascii?Q?LG60HevtACl36+qnv0yv/rYQndgkqBTIQwvRBghMO939hydjP8/8br02oYpS?=
 =?us-ascii?Q?PP405ivSD3CLlp64fIFbkBXgsqbTwt2D2gEMvseY4XNdgtDlKEG1gsC/GYTI?=
 =?us-ascii?Q?PfANXzQ8BkixGXBoPT4Txp/i0cbN31t6QbvZfOOYghUUZVhHxM8GDyfgU1sb?=
 =?us-ascii?Q?MjCMZmpJLgnVU0PKVkHTU27fiiBqSYGrG53ynlhs5OpXsd++G2GGxtMDE6hy?=
 =?us-ascii?Q?wbvQojllbv+b4++VrleO5V5IETjVUcR0TaYpELhvdpJnvcHn+Q/9yC41Q+LE?=
 =?us-ascii?Q?/CFdBuw5DMIf6hf34WbPoELvVnQ5x8piFdGYl9iauouskeSgYZRo2san6hok?=
 =?us-ascii?Q?apxMYvRecs0tPwPxGVxeF2dznSdLrOvIIh0v0WDn6JNTvwDaRdvAUn0aEMcj?=
 =?us-ascii?Q?TAuUJcirPqJk+9+ZQE36DNLbLY+mXW4P/m/ni3DhtQ4cPC+/khqB3GlnnD8V?=
 =?us-ascii?Q?vm8IWr87ST9vRFg/McWqM+obtjuTNNo0K+UobUXRSKQ/PMjNKcCxnlHhc7Ft?=
 =?us-ascii?Q?r50RE4F7rZuTYTbn7cPzojwIN5TbERlGgqDj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kPqBnAjkxFUB1QL9QIHYeGyVBqcvZFC1QQbdEZsUfRjwDD9ZXglvrKraLy5j?=
 =?us-ascii?Q?xMOzV5X9cBuZK2v+czv7bvFRry+kPPaho5l6h7TcXo61qZwdPGfj5j855HyC?=
 =?us-ascii?Q?5FurDiDW3aZGU+U0BF3jwqfSC3WcWbVyRCScanHHLKgj2SW/cp5fkfsViOG3?=
 =?us-ascii?Q?u1HwGybeQPgdUVrhKRT8yhrCWP4Lpfy27/x7M1ew20/cEenQ/Pg9Le1cT03C?=
 =?us-ascii?Q?F5fY9PN4sWuGgWhsmKfTBnLw/Rs6ekykXGO+KCmArkDWJpVKm21z4zr4LbU5?=
 =?us-ascii?Q?E/B+DfTLwO0opTWrAe/xipuSszuwAQSZSmOL234oHmtEe1M6PkHygz9wk1rB?=
 =?us-ascii?Q?7PQ2/lq8KTmQYtNMz/cQj6hW/VtTAnzIsJEYyemPnmDS9dJAXC2MCm8OTRsH?=
 =?us-ascii?Q?QjbeI/TJ6KUaJmKhGZ87NRqjZndj7O4aWjnxLP91jm5fJZOnTuhw6wuvh0YA?=
 =?us-ascii?Q?hhnOgAaPOKFXp/o3aUmfew3vQLWPSqfxjrCRmdRCtMkpnR8Pl6Jv0v2TuQq2?=
 =?us-ascii?Q?JZXbbXhVIEo4CypifbiHC0U7Q3hixQNKpIn84+ti7EuTZtJSJjrBky9T3v7i?=
 =?us-ascii?Q?3aPGHU49OJVb51TfrP773MHgI1/DxpXYnajZWCeYWMxeeFtjzRj6hpvyapBa?=
 =?us-ascii?Q?xU5HiVcxIv3AkQTmDcUT5UM++gYHZeq65eQIYatSdNBYzkz7U3R897hgBj0D?=
 =?us-ascii?Q?eV6SoUycXjObEuOJMlrHUSC6r20Q6V4/KsqHaW/HxsSP+R/K9uzLA9aSV6cZ?=
 =?us-ascii?Q?/NWnwS99nRWQCZGgWaqSdFzRp0aKGcvMp5EEQ+X36MsxybEtdQUe2F0EH8LN?=
 =?us-ascii?Q?sLmOSHXf1eEyhZz/2VPcQkEcX7P0t0tIdf37akrOjCq1G3Vg/fspI+PNiWlg?=
 =?us-ascii?Q?mA+iMoQMVGD2ALaHqW0TY4GHuXSDr57WXgIPXSZHNZ/ki3BDoM+I2gQbKp6+?=
 =?us-ascii?Q?x7dUG446RoPlJfUIyZJvMG5MhsRvQ/j0zr60lN5UF5sXMZ3OSXKk6LdLU8yE?=
 =?us-ascii?Q?MgrmhAG9T32cFbIS0+LEfxq6f50EBctofoZlYlgfjNTxygTm9CfExlM6Dmgk?=
 =?us-ascii?Q?xWksNeIXc2Z4d/kWgi6KXlYJQ2nd690Hs9KtOCmz2MPkXmDueJFIluXROiNN?=
 =?us-ascii?Q?WzbQKOJHC1i93cjm1EGIejM6EwduGXMc1KAlMnpT90/kp0EqwdJ1G7uquFvN?=
 =?us-ascii?Q?nVVsY3Xc89He4WQq04E3bOHWTXABpkIRClRU9rO67CtpWv+5I/PMIkQTXjur?=
 =?us-ascii?Q?jl/eF3GErTfafaTVFTlaDEWYMsUU1bLgyYEonVd8vk8l7Ma+o5Q+PLpPAugb?=
 =?us-ascii?Q?/CtvPJ8xNhPQpzXnZKkHMv4A39W1uy+CCF1yga8rhnSaCvzfbH/ouTUJrnlD?=
 =?us-ascii?Q?zm5QFvjiEmCjHj/TiYxC1S2XkwGphhoDHOr3k+K8oQo2+x2FEazIT+yKWUd2?=
 =?us-ascii?Q?IT+43Gc+OGdB0W/bEkRLGh+jsrSyF+kA77t18nFWYJaIh8X9I6+4DPab1LXR?=
 =?us-ascii?Q?KL6S6WRRmZt3K8pbS8NKhvfjTPOvanm5KWauBzZjsYwPz550n+WCeyh7lbQ9?=
 =?us-ascii?Q?1/14GFhin4BfCPOge4EaOTekQh7n3+HuGnAWq6ik?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad908767-414b-4182-750b-08de160ef72b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 10:44:27.6860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUu2OEeTkoMEWVQZVbt/DRDXgf/TbhVwffCd9ds/ORlvIbqsZ+9weS5AmJ/0SD613z2plrWDne7Zgxcgrn9mdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11351
X-Mailman-Approved-At: Tue, 28 Oct 2025 14:10:51 +0100
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

Hi Marek,

On Tue, Oct 28, 2025 at 04:41:05AM +0100, Marek Vasut wrote:
>The clock names are retrived via SCMI_CLOCK_ATTRIBUTES, called for each
>clock ID. This may take a lot of time to complete and is not strictly
>necessary. Register each clock as "scmi-%zu" instead, and let the first
>call of SCMI_CLOCK_ATTRIBUTES fill in the actual clock name.
>
>This has a side effect, which can be considered both an upside and also
>a downside. Unused clock are never renamed and retain their placeholder
>"scmi-%zu" name, which avoids empty clock names for nameless SCMI clock,
>and avoids the name resolution and improves boot time. But for those
>SCMI clock which do have name, that name is not listed until the clock
>are used.
>
>This is a preparatory patch for deferred issue of SCMI_CLOCK_ATTRIBUTES.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>---
>Cc: Alice Guo <alice.guo@nxp.com>
>Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>Cc: Peng Fan <peng.fan@nxp.com>
>Cc: Sean Anderson <seanga2@gmail.com>
>Cc: Tom Rini <trini@konsulko.com>
>Cc: Valentin Caron <valentin.caron@foss.st.com>
>Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
>Cc: u-boot@lists.denx.de
>---
> drivers/clk/clk_scmi.c | 25 +++++++++++--------------
> 1 file changed, 11 insertions(+), 14 deletions(-)
>
>diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
>index 3ee2df0ca9b..afaeb84e65d 100644
>--- a/drivers/clk/clk_scmi.c
>+++ b/drivers/clk/clk_scmi.c
>@@ -16,6 +16,7 @@
> 
> struct clk_scmi {
> 	struct clk clk;
>+	char name[SCMI_CLOCK_NAME_LENGTH_MAX];
> 	u32 ctrl_flags;
> };
> 
>@@ -325,24 +326,20 @@ static int scmi_clk_probe(struct udevice *dev)
> 		return -ENOMEM;
> 
> 	for (i = 0; i < num_clocks; i++) {
>-		char *clock_name;
>+		clk_scmi = clk_scmi_bulk + i;
>+		char *clock_name = clk_scmi->name;
> 		u32 attributes;
> 
>-		if (!scmi_clk_get_attibute(dev, i, &clock_name, &attributes)) {
>-			clk_scmi = clk_scmi_bulk + i;
>-			if (!clock_name)
>-				ret = -ENOMEM;
>-			else
>-				ret = clk_register(&clk_scmi->clk, dev->driver->name,
>-						   clock_name, dev->name);
>-
>-			if (ret) {
>-				free(clock_name);
>-				return ret;
>-			}
>+		snprintf(clock_name, SCMI_CLOCK_NAME_LENGTH_MAX, "scmi-%zu", i);
>+
>+		ret = clk_register(&clk_scmi->clk, dev->driver->name,
>+				   clock_name, dev->name);
>+		if (ret)
>+			return ret;
> 
>-			dev_clk_dm(dev, i, &clk_scmi->clk);
>+		dev_clk_dm(dev, i, &clk_scmi->clk);
> 
>+		if (!scmi_clk_get_attibute(dev, i, &clock_name, &attributes)) {

There is still scmi_clk_get_attibute for each clock. In commit log, 
you mentioned this takes lot time to complete. I may miss something,
what is improved in this change?

Thanks,
Peng

> 			if (CLK_HAS_RESTRICTIONS(attributes)) {
> 				u32 perm;
> 
>-- 
>2.51.0
>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A199BCD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 11:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F93083FB0;
	Wed, 13 May 2026 13:03:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="esB+8VYh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B75D7844BF; Wed, 13 May 2026 13:03:10 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90FA9836AC
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 13:03:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqlLK+x3a/14j0zkYIHTEwqnKWDlcNKRcDAnCDqs12nn7/6/Ez3qH0qdbiecdWV4aUtlleKXbY3UoqSeL1Vb9Q33rUT8UpCHLGas5c2+Ktlq7wAlmpVdfiD+rD0RzQri7giF5MTJ9ZrakBDQ74cFJENK32qlLbanwR7b7YIWWumfsEFTCzuPYWAJ8WiKgjRlAbb0jhumclt5N+BDqBl+4eKPQnXheYxQHPqFpupUdUH7aaLs4eGqnVQ8pigoK6/+ZkiP48j8v1PKtcuapKFlT1BhzH53x/A51IRK+JGr8sjXuyblseO7Uxik37g3Wtnwo7IHhAcgPJ3CrJsmN8JnqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOTKqYFiS5Hxi22U7u0fVMCd3CrWGeKryWtog42YC5E=;
 b=kzykGgxUaZIjc5RlbbloIXpTtD2yT1AWlm/p46EcYJhQ3d+w+wawDPPkK9m0/M88X973cN0uKm7zE6ltLEjfJTSG5J600yFA+sJ9lNFLrkVPmHTxtbe+iDe6H6wZjmjzm7dSXqY9l/KziIFvBet8snZLRN73BGVvf50CvuU6UI+q01PGnu7IGQtIq+wzEzBaPKQgk0Ba7dT3uAocqtY3Z7rFdFbG3o9oIvABnb5fh6AvBjXFpAfqBeUfIvesIPJe0jSIiLJ7fwIgmjAiaQ9MKWeTKlpOkxBuhtq2v6biubb38frmqYEbPEZOjiEF3BlTq7703P5vTn0IhH/YZ0NwTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOTKqYFiS5Hxi22U7u0fVMCd3CrWGeKryWtog42YC5E=;
 b=esB+8VYh0lfLEu9lE/iMS0wvfTOVDu3k9lo8nY2SL4dqp0/agclSVuSYmiCd3DrgW7StmlgnrSaV2xKyVwq9EsASrjft2oGqoeW8kaBgNtXJxBqzsC7P/6VNTlICa6nw5aMKa0nWdRTTp/MZ2becosZ23oktCZ61QlvBWty+wIDyD7OOB1ERwFBbYVJiwVUZgIHaWlRQ86LVe7Gzvqo+LTTeXxORT3JvIlzjKhbOcS0WfL3iFoW7azJ7hwRgYKKMARn517mF7zuMHqVHB9gOPAD+FI8PpZt5Cc1A5U3/dU8/e7hQP8lOX5R1IXsHCNDpFUuGDPQFoTNMn7q2RduqVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 11:03:06 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 11:03:05 +0000
Date: Wed, 13 May 2026 19:05:55 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Subject: Re: [PATCH] firmware: scmi: sandbox: Staticize and constify driver ops
Message-ID: <agRbE/8vaQ+AzJP/@shlinux89>
References: <20260507220519.209085-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507220519.209085-1-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: SG2PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:4:91::14) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AS8PR04MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: b354b156-313b-46eb-7856-08deb0df35ae
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|19092799006|11063799003|18002099003|56012099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: MVCeDDi+0ID5zu/3HT/nQZ8QptTYIp9PPtCnijv7Kw9Iz2x8iSKviWsQWeOeBC7I6YkUtWiSYr91J5/rkYXhpX/5gIa/90bsgeawqp6HVZnsFRjWohc32rjCUlkQf7nEQY5RuUW4pnZKg6CCTg4NDXx/EQa1IRc9qfKASpVxtR0HQpzPSD1hvda/ECpPCgD+iztlwCjSN5e5Rz0GSKf/oYKpt8utZb/kJQWLeKZSTOwl2wS8zG5ZflRhXvc10B3pLb+/6Ung8r1KA6XeAxzwIzpA2PQpzpIMbw89UUhuDt6r9hGF9kEsJCDo9v1Sl6pnFc/d4tScxQAIN892Wg/NZHiCqvXbwuf/+nZPYlxqrS810w3oHUu6M5LCJg8Tybe1j4+e3XbQr6LYtuprRmG8mEeeVIYWjnCga6lK1ULoO/ug4Eu7RUeXP97fOPx8pPuL227/stSDeAo98XUxV9shSS5+9rlYHezE+JJJ4+T6+KeopxWZ0B9Cr7k6p5Of7x9Wm10liW48MDt+Fs7l1BA/zT0nto2dFTYlF6Uw3NgE3lW5K4594/6DmWpGlMP312miuLQ61jfyacMgGt88146BDVTvMPILfmavO8xiyH5RDYhR5Z6yfahMUIRbSwGj9y946/xumcrIw1c7krGZ1+nVUFPZ/q3JkuIHSm2deHJYZRz85LKzZ2QoI97stDp5vj+ehgGP1k89RjwA5HYErSHTbxK0lBEsu1YOop3u5yWubbMMI6KOqhnfLosFJKo3z+Bf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(19092799006)(11063799003)(18002099003)(56012099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rqnIAfGdzOJToEGe1P7LHmGO8ss+GhJz7ukTlBv36ThfSxTCn45Dz/kjXtsp?=
 =?us-ascii?Q?nYg6RvcDA91XnSK6kzP2bN5cG6S7jW/KphtEAnbtjfqEZ/V3j8//Z8AsAgUB?=
 =?us-ascii?Q?8Gk+g1kjF4bb/GVlbuJkBh75U+L2SALbxbY6SgL2dmsdBvMU/aASV0RqV9Rt?=
 =?us-ascii?Q?rjUR7NdFJkSOkhktieopEokgbq1kZso5E9cqMvcdaTdMr2YxYT2RGXur+++/?=
 =?us-ascii?Q?gaGma2AMZ+SipG5nlZwM2dydoAewii2YnhJ1cQFeJhRUO9ACwP0h737JDFys?=
 =?us-ascii?Q?GI6IFlL4AmHB5va63IZQWx7JWC0ECLU8HsBajt54Mi5gS1AFEOCh/ly44j+6?=
 =?us-ascii?Q?c8CcbwwGvNnjJ35znxn8TF0+3UEmFyWgRzrOb/ehTXv/AFIHkykH+Hrjwawu?=
 =?us-ascii?Q?gr5U5lPHbqt7jHdkKh2klUPflqutBhN/sZ6tDrPoUeCC16uJ+DqbiPiI/LCq?=
 =?us-ascii?Q?dtx1JQYokVpGFN8oSEgxZiPtLVZ6m1PzNNCmdImW2ldymZngACV3KsHKFQME?=
 =?us-ascii?Q?ONzPy8DWIh389Gj3Nihu8w6kdehm7OHvANyzDNorkZVnErl1gb3iNLy293mC?=
 =?us-ascii?Q?73aMM68EIAtAjjXZmd6jnEDrgcHex+V2IMBcEy08+S/xg2Rjl/4Bxi5TrRvh?=
 =?us-ascii?Q?ytHhJgLS/FBss/OHSX5rknHqhniDqmt8D/lnRbGuEu0q/kFl0uSgN4BzYreN?=
 =?us-ascii?Q?y+I8Qxm0Dj6HdAa+/Wc0bmXmftXvsguqZijRviyEf7znIejjja3DqI0oeyZm?=
 =?us-ascii?Q?EqpfyG3M6jxOFJXK0v2ZgfkcFcjlALoMbyRFY09GthlI4NIRDv9SxzzwKNuv?=
 =?us-ascii?Q?rVnCy2/zzRcyz4gvPV7BHof3d/9w39LrQGr+vvRoyUGDefM84GO7qmEPW8Mn?=
 =?us-ascii?Q?Cat5sJ+1nyHq64mKao3Wd+Km3uHUzVWWCRr6iNN3E9WiUDLgIGD8kQhaHZnb?=
 =?us-ascii?Q?9/wiqdS/ruJs7mvV0eJARPhG4tNCl7uZiARon+SXGZ7jrOd8kzUNoj08NwRg?=
 =?us-ascii?Q?OVcG3OX4CcYn64tuiMtQyeZ3moC3aBol29WtlwtUiARFdQHI9ic7dwbdElg3?=
 =?us-ascii?Q?VAs29+DcPX9L4Ki2sfCe2rccl0ck4k859GojBg8LqQps5L+Onr8zA0WaWDBY?=
 =?us-ascii?Q?fVXTgreVRgYOVKmBbwbyvUk6kZO1QDFR/4vKdvMyh7FVk1c2o27nlOotIP2I?=
 =?us-ascii?Q?3q46NwR23zgv8h4hOlzFxUt53tW9s/tn3pmkLyP+0zqTO7+iEmoaNMh/gfR5?=
 =?us-ascii?Q?oMYQvMu5w/whfGJ+A1D/HC8VU43958KxiTwfOhzPOtgzKgfab3GeguVUYhI3?=
 =?us-ascii?Q?3yNWR4Kh5QL780MPAtsjRvoKFpMG69lsMgSDcQkC+blYrFYLeap36IvFC6F7?=
 =?us-ascii?Q?XZZuF43r49FgIkqtLUsHRhMzLn7uSMa0nJJK0YQ2nZk9QXBB9lg3T20ulYSS?=
 =?us-ascii?Q?P1TQShNKfgzq5z38vttxqKXyeAaUV+9TItgCSJa+Bel4kX3V4Ylc1DuVSZG7?=
 =?us-ascii?Q?471zyFFqML2mxtlypBjL1O5a7gPytZvrCjuoq8eF6A12KlDE6YmCwF5S4sV2?=
 =?us-ascii?Q?ybfptjge8no+8rbrdx9FQ1GelNffwl+D0tBdPdO1FqyDtOXuDyerg8+5RNMH?=
 =?us-ascii?Q?k+ErIDiegd8xfUI/DnibwogVBB6TsNBrGytmNnk/6TlFhbErf/oO8XSfHt0Y?=
 =?us-ascii?Q?CNdC19oDW5AUJgW1bGpJuCEEaBYUwtpYaqS0M02s8kkuBpB8RPjDL7vYrT19?=
 =?us-ascii?Q?/b+uKneJ/Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b354b156-313b-46eb-7856-08deb0df35ae
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 11:03:05.8917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aifFFrdmpU1uyMG4TexmzlOAgI6qLrHxNiozYiDIFIZKCWVVYVgvBAr6W+vnbm9Dz87dfvGcdyXfYt6k/fdpmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9126
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

On Fri, May 08, 2026 at 12:05:09AM +0200, Marek Vasut wrote:
>Set the ops structure as static const. The structure is not accessible
>from outside of this driver and is not going to be modified at runtime.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02279FEE4F2
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 16:00:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28C3A83F37;
	Sat, 28 Feb 2026 16:59:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DUU7g6zK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68A3283E63; Sat, 28 Feb 2026 12:45:18 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FD32801BE
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 12:45:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awPmAdnaJlMnQPpGoiv60yAV5gIu0fScsfubCS6WcWRuoTcZbuJ6Sa0GGfDTV232p7eGx7rzXRC24YIGR/iBbVD1wMzQB330ybg8gQKmPftcMoVxw3frAovPrquCldH8a+6MGRfxHOa8R9uKbSYxwAVFROO0jGircfDmBCCbBql3br8nESn9JVf3msxTl18FgwHjMETT/b+HjkHjRZFR5VWQca0x1h9eDTNomirmE39rZPSvPz8jys9UY7GGRtnQThRcXb/RQ9ky5IJy6Gsjkv+dW9W0w31/aVNRgJX2HR8NOFGeED1mNQi9GPOwLV/sqWvziU4v5LD6Kv24IQSOQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDX7FNlp8QH0sVsTeZtWB4Xh4sY26TdJl8GP/5OSims=;
 b=fa5zGY1nYoFszF9QumLJevuL0XEc72dmOMoR64p+HcU0i1pPlMNucIL91CWtfHKh+dhC/HAI9PqsieV2mGKqicA/sD1xhi1rf2OTPiq/LC1ttrL6py08nGLFHGjgWSQuDbMZ0izKb7Z6CzPE5Yzkx6wz7S2XeP7RYM0bKBX1HAOJezEm9K3XxhSMHvzAa1eb9q06FcRDVfynfggnyhBX9LiKBI9F+UgAKLN1iLfozDGriIPyFNQA4/GQyf1Iym5I4Xnhtv9Iajmy2UXeDTUJ716sZn+40Q58D4HKaqznZlYuRBWybY4d6bjOluN5CPLII2FfX+VYSlmkeD5u9evMwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDX7FNlp8QH0sVsTeZtWB4Xh4sY26TdJl8GP/5OSims=;
 b=DUU7g6zK5oxqcVZ7k2z3ccQihIduK4mLh5u+mDkhjvXoRtiTIXNl80eG308XF5e//dLy7kK4TNNRC9nOSjSqevCz5hYfzSlcFKhDKKkG8go+8HfQgBhux5ZXRzZfWlszuBDM0kD9tBhMwL0Gp01jcMjxH/RIXOyYDUqRmgnlD0jpAg4mVclavK+LxWYF8WFHqSh+nsh/3VWUmNudBx97Ij4mvM8tUOs9Yy59dlX7G/y2lV1BRggc2uZtc9PXQpsPCljpLK3woYY/ggu+ScDC54l4rJ5znSj/l36p8Irxho6QGQ3EE6EeaVSxOA5ab7LEQWKl/GhnfkaAdlGMB+hiIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA6PR04MB11713.eurprd04.prod.outlook.com (2603:10a6:102:51f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Sat, 28 Feb
 2026 11:45:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Sat, 28 Feb 2026
 11:45:14 +0000
Date: Sat, 28 Feb 2026 19:47:06 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
 Frank Li <Frank.Li@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jacky Bai <ping.bai@nxp.com>, Rasmus Villemoes <ravi@prevas.dk>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Jindong Yue <jindong.yue@nxp.com>, Ji Luo <ji.luo@nxp.com>,
 Niko Mauno <niko.mauno@vaisala.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 David Zang <davidzangcs@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>,
 Simon Glass <sjg@chromium.org>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v2 12/13] arm: dts: Add U-Boot device tree for i.MX952 EVK
Message-ID: <aaLVuoFhbnVLm3OX@shlinux89>
References: <20260228-imx952-v1-0-0a360e7e8cb7@nxp.com>
 <20260228-imx952-v1-12-0a360e7e8cb7@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228-imx952-v1-12-0a360e7e8cb7@nxp.com>
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA6PR04MB11713:EE_
X-MS-Office365-Filtering-Correlation-Id: 9332fa17-acba-44be-fab0-08de76bed640
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: SWdL2tJV1tq2Cl3WHQCgDNhd/hv47E1eBPVj7rKQQvgVkO3BAGo/TQtauv9oNNmbGZAMVgqGDqbyyfTR+4Q76Iv5IWZRAL769lJBUDKMzAil6bt2kaJXvEcetfMLkCWLGQLvk45bmQa3BtROrp9l0L0u4T3eJsOJhzgXBg7287jw2sYkaH/RiiVOBcY4lKB7sak1QCcoO9pRUYEG4Bivnng2oYAtN7oVRTfeKufb6DbOs9Zfxk4I0K/Xn3GO7Chy0XIlc1EpebAgVEvD+565TvUSNHJ3ehzC+V7FToCd/a0OFs8WLaOkvis9Jx3xKr4s0fYOQJ8xLtjRghZEfyxZM+OR9yV/8OSIowIAQOZxE5PVroLFaqJON4aSbIswm5Ja1I1oJzeckjvRtRmmx8tvAGOkscth2mDfe6aWJd/aEQ+d7FyUxRZJpcv3KT5rue26IjDSiP50GxwNX8MNtivg55UT0/EQ9+DqFWzSuiw20C7NelFjjU7qiTT3u/AFFEqXryg0R7w/YKZjazskBa1efrh5ccBwibUJIXwGtHXMZgTvm3OpffalBjAIebk98RFBl5NrSUebQS9NTxBd4ogjyI7D2yPO0Xlm85+4Y7WCldTfu1lvuJVAn0b3kjJulvl1aGzH/r72XzkZhjixEqjEYCXaaJGj5klIbr/wY+1QOzxtnqDJ5BLOyPWvRVhNPw/MAbLSnSUvCZrqe+dowVq5Hl9kzgFczlxF1fQ1WI4VK278Vbt0YmpRqhDZTdno2RJ3DircneSQJXnB4tnENL+gj+ta7OK+O+WlryRl2m5Do/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7bguIY67p7ze9rT+XPY53zZNiDW+nyIEzx7yIEFKyj0i/kHTB5XA5Jc0AQBW?=
 =?us-ascii?Q?AGzB1YIcCxs6E2vxPaOY0Xt0Q4mdz99L3QeoOd8+QAsf7nxVevCsOn9Vck0J?=
 =?us-ascii?Q?NfBDdbeIwQm0UaTDsCm704swMAZWm/QVOGiukhNNv0eskG7p+YwsK+VNRO/k?=
 =?us-ascii?Q?7JvhmRSra6ZEEQ8Tt7U8IKxgKk6gx+rJojx+QHKrLGq6n9cj2OD5oKaQL2rA?=
 =?us-ascii?Q?5vlisGmvimJCNGxcKBIwJ/qRyIh3pzYT8Hff8VW1c+Q0b5F883hFvPd1Wf08?=
 =?us-ascii?Q?sc62nJZq0sQXqYNYrfXk2JaD7eifjGjh9ax0wqpqYQ5FrcdvCQaacm29ff8u?=
 =?us-ascii?Q?cmBucLsYrG13G58NjASSiUxp0ZCvq09YJsVhgGeks4Kj6KP6dVQbbvlxh4g8?=
 =?us-ascii?Q?mMVFIpVsbB+A3LsJsSi2vFxqqYuzZ/K8puwn843nwQJCe3Q0jm/gV8ssrhAE?=
 =?us-ascii?Q?3sysAWjsIDaxbBsIo0WbKaJpz4ky5WTYV526W6F3jE0zKLwLqsR3u43PC7nw?=
 =?us-ascii?Q?pt/H7Q6vwFwFBo1IyvBnwovMt2wdHdiSw6X8vvUglOSttO4iED05CZX6NZYq?=
 =?us-ascii?Q?JyUoTnzS8wXoo1L7UWfXfm5hH8WJ1QlNDzxCZd/h5SQgmeiF4xWzPb/kR0Pj?=
 =?us-ascii?Q?n/2+UBpDHRSkQ6pNhQtsuEFcjmyNF/YJ1MUqS8ttN39c4IJZJRBZnqSQY797?=
 =?us-ascii?Q?fTtLBbomJ7dwHwUMYZxUNdP/Xwi6RDCXLqFekqPigTx5ea7paFdhGsJZJkdl?=
 =?us-ascii?Q?ROokNOOla/MwcagyjVL921uYaR55ruudkzotvpYY7Vuw+DZ1Oyzw+WQEaOuz?=
 =?us-ascii?Q?Awa+ae9Edtytz4gpsIAq7ZK+D4VB2vL0nVOuwps5T3ZjPaXVascC2zRxlrE4?=
 =?us-ascii?Q?YLw0CP6R5i7YnDgFWSa5+vXFjsJnpp72Bkn8p6LFz9xtBfWeqiIfcaAogxB/?=
 =?us-ascii?Q?uLbRFHEWzFgw/GoMyrfDdeufsMfiCrtRBj51IyEdEL+EayL57Wv2/ngqteJT?=
 =?us-ascii?Q?gMOg9zZTNHKeWvBKuvQFU7xCFJIaLpY9/eORRiNgbsFRLOYLcOHPv8ThaDNo?=
 =?us-ascii?Q?ZyzylhZ8CLRLraVge84pzXocgyTf0w/Z3ymlqwzjH5mSINpJUOKo70mpOnDq?=
 =?us-ascii?Q?mn4NzDVgzuSH8m1xatkeDMorjGzaMPGPxkjrn5Z8YCmA1MSANljWbLDzOfP5?=
 =?us-ascii?Q?Sdxt/+f2ElEZN/m0WG0LXBQ0P7j6wBXNNf/gwd7x435SZ5uQs4a6k8BRyGPW?=
 =?us-ascii?Q?x1tvXgnk8CXwv6LQuga1SF6ljCrJwgrrXo1Bcix1gHOZ0nsZh5u6KWt7WLiK?=
 =?us-ascii?Q?QUMIgNs3euyuC6sZnPB35G8lLCAVqeo8igEIxE1VwHGhI9CN4t/U+8PfQX6g?=
 =?us-ascii?Q?2hg9BaS4dHxwpeO2FoNF8bj2yebUnzdNh/DBrZvIAqyKFhI6CnqOKJ9Oz5By?=
 =?us-ascii?Q?2okUGMMK3iTd9y0XHalxnvgUH38q6U1f7q9rnG6SFyhHd370j774wjCe8Br/?=
 =?us-ascii?Q?h5ZHyfGLvipbEj6T0sKrQczC3R1ojyaXQTzvzpes/4qolnY1aGwXmLBw6fqI?=
 =?us-ascii?Q?9cYH3KWXfLVnSyHlHyz+GnTtcYOixjePym+yK8KC7LV/eY7QNukjcGShYdEV?=
 =?us-ascii?Q?BgdrsGnqWsczb1490yNzUKW6Jw+/kFJ0bQHuLMMPrawZigCsle/ZUrqNNWDU?=
 =?us-ascii?Q?OIVhq/82jNWwobEuXwcF6aHD2IP9qvuyYCuMdYaSxD4PuEOROd9DW0rtUEbu?=
 =?us-ascii?Q?2ncd6gv50Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9332fa17-acba-44be-fab0-08de76bed640
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 11:45:14.4999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TufoYz3GZp09PiauaHeCDHCt1W8qlvLveJrF7FZ6bAm7wRDqOZSz7KlIZXQAKy3hMZMk/EpP//ryRY6xcKARw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11713
X-Mailman-Approved-At: Sat, 28 Feb 2026 16:59:36 +0100
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

On Sat, Feb 28, 2026 at 08:22:30AM +0800, alice.guo@oss.nxp.com wrote:
>From: Alice Guo <alice.guo@nxp.com>
>
>Add U-Boot specific device tree configuration for i.MX952 EVK board.
>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88812C28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 05:37:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 077AC805D7;
	Wed, 12 Mar 2025 06:37:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="n4+G+Aqk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B00580756; Wed, 12 Mar 2025 06:37:39 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E13F801BE
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 06:37:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fe5/xZSWIhXlYHvjMe03F5fj87bquKWWPs2GA0xHF4X15QPbA3XN9IHBDtSLu/xgo95+ZHY9fBwiRJ36TwRCPWMj5Jmz7TakYyCU3yemGboTiKbMXzPWdCpoUnNBiTHfoGXeJL4EDTx8w6G93ThZC/jwppTrBMcN/TedSojHQnNQoVM7PDAyvbmU5NQWBzgUC9d/1+SscfNzteeg3n6Imrebk8AyH4Ue+jWc35jfQ7Gk4SYuDTGb50z1hVjYjk2ZqhAkXyrVGaRHg/IYUiH+KLHBkaH+rjHDPmqj40fg50KWhuXTh90uifQ6bb1dOJkfOkMcYcNY9g9LmNkUqOJ0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8L8KJAcsfojZY2cwpmpsFYD3wsCueholX8fLxvlZdI=;
 b=cPa7f9Y8eI+4v3Yq9Xk1EyR5LSrJNT/u6VjoQ5zoFewVechHcDpqKJEchuZBmtZNbjCYqg1V5AjxO5dOEsMGKehPg5t96Q6h/p3cTlVse1oeT0p5kEN8k5cJsLYtHZ01X1fO+a1CbeAGiZhuMcIgQacU2iJR2i2o47blU9p2dW+pfzP3y55zJJzgzxI+drtqtHusNawqrOA5bxvKiE90/+2L2pNzTV2G6D7xpQxMSdWxnW9PQenu8oKDCZJi7Dl/p4NE4U2Z+p54YxM4py/TKWBi4duQCCkFJzL1vWcGjkh0xX4Lxftv57dIHgBbhXU3jaPXrOgediWortduN7pgMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8L8KJAcsfojZY2cwpmpsFYD3wsCueholX8fLxvlZdI=;
 b=n4+G+AqkTQpEMzH4OZmvf03JYQ30I4gZ2Qy64H76Zlo1FvcUH7rudOWpN+NTsIH5sikUoQ/NdOhlRbjhcb6gMJQPuczw58lZIH3gQPzgLFVUk9hhiMJEm5WfSBrPap/AL6n4ZiqiaceKA4tziXHE9BmP03KgXj/4Anvg0G2fkTw8I8riq8GRIzPwici7cAv11HNRbYvQDvKQiLpHs8MWOkP7puSY4DmbDVj1G/diRXTPfUB5fMkw1UlmIKJ1xSMQgqVF9dSgWJ3w1mzAVj+72c3sUP0QD0gN97Zq9jWZZy2WsoAkdKepDsbxFGg/rO1mk26l8gl9GxRw1H7YMAAL+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9640.eurprd04.prod.outlook.com (2603:10a6:102:261::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 05:37:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 05:37:34 +0000
Date: Wed, 12 Mar 2025 14:45:13 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH V2 07/10] board: beacon: imx8mn: Let clock system enable
 UART clock
Message-ID: <20250312064513.GF11991@nxa18884-linux>
References: <20250312003041.110023-1-aford173@gmail.com>
 <20250312003041.110023-8-aford173@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312003041.110023-8-aford173@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR02CA0065.apcprd02.prod.outlook.com
 (2603:1096:4:54::29) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d5f000f-0245-4404-b709-08dd6127fd70
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|7416014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gQvtzUZE61eCBabnGwWeh0UPPNfmMGBrlBgJV6J92tX+NxGefgZwnT0lPIEv?=
 =?us-ascii?Q?+lnXGeciZUFgxTqseDriMc5Iqyc/FcWIwqVsIxHBNOfJJZqiupUv5A7UZGmS?=
 =?us-ascii?Q?IEKYaInLrNAgAsAbcH+lvph1zHRUhAS3vu4x8IdAD+ximV97W9XWJkKWlxDk?=
 =?us-ascii?Q?NJULFAoG33mWrGchwGxXmKM0rUutcitQpfkCVoYnYn5oMjAI7+AtIaZ2uWQ1?=
 =?us-ascii?Q?sED1BKI8KSeHdKfXwn8hiZNCIC9mwjfeXg7vxEMyWypQ4hWooFB2gavpv9Ge?=
 =?us-ascii?Q?/X1dcrgINh3Fiz3eLtYfmA8KUIQwoKaAKB9Dc/6BWX1o9ZMHib3Ky1ZCoK0K?=
 =?us-ascii?Q?udykwon/XowUK8/jnFgz1Lp2eOGWRLzyDXWSR/G+Uo8F2HJuNqIJZ/bMeyOk?=
 =?us-ascii?Q?kAO6QcSjaFeYTigRBsHINNNMp/Wjk0ru/Bf1diKX6xB3HYbRXMpH1SKnltVK?=
 =?us-ascii?Q?A9U0uMvuLKVX1JcUN3aFWdvBQJDWuwOqE+P5Biz7kWMGrWqib2XGVEAWh9o/?=
 =?us-ascii?Q?N3MmetiJ/O8p8VS6CBJpt2/nPVrneiuABejtLYYgMuuPuboTCTaJo75NRhJ1?=
 =?us-ascii?Q?2Bk7efBfn0IB/LTdmAPF2au9sEFPVoz3HZ89XbN9rYhecyb22pq2gkML2M/t?=
 =?us-ascii?Q?azg+qKcIrXo/nIcuizY0SaPsEHbKqg40pslep8SQjgySv0QWuXkbiDDGxs3a?=
 =?us-ascii?Q?fn1kIv3yP8FHTM5Z6ghe2I5BHikd7SD0g8MFxQbJcHEg9c4alKyKnR7Xwl1d?=
 =?us-ascii?Q?rYy7xBXxfOcpJDfJRqignZ4qXw3GpnF0QyKbPVuWOdH9PSlsxzlCuHgKtKcB?=
 =?us-ascii?Q?GFnEuf1NYcCQWH6hxIcjnsJj6WXTKakUrlczA7QVgtyffrCZ7aN0pneKK+YM?=
 =?us-ascii?Q?Pe5nA+oUCH0L5Gpwfy7cSJ39v0Fd3mwzosowoAYJQmQx5EiKtxcifKOzojsM?=
 =?us-ascii?Q?MzxsGv/wqmMsjAYlFqhjh0V8EwheH+EQxebs7azDgiTDrVuJs6/fGjAUFIKZ?=
 =?us-ascii?Q?29uHjAV0SYQBnp0LIWWnGBcuLo2BsbK+pxm3+jcyP0HBjRfArC3nVq4FhsFL?=
 =?us-ascii?Q?euDcxZIwhuesWN6NEFS4uj2KsoziW7NzxJMFplzV9TCBiSklC6KPsLeBS2LP?=
 =?us-ascii?Q?NNVIIssqVH0LxnjKcyt+C25aSXnyeALK5dLNgMzS5c/Vbry0OaQMWYel/xov?=
 =?us-ascii?Q?UCOalv4suTnjO/YKxP9s8jePH/CJ33mrIPaaE5MsDzDhJHW/ssIJhGXxnard?=
 =?us-ascii?Q?rXu/kjfHT1xhoUdsyHoSZnZ+O8bNAAig7KGCg9F3GjVoB+I8eYJ0Comrd7Am?=
 =?us-ascii?Q?06dQSO7qlMXOONq+Bx/kV1ocKPxKO85eLRZuAfGX4Od8jc3WX0XrAGJITxJ1?=
 =?us-ascii?Q?t07DOG0xLfA1opeho/fAAJtpYiEHvfMLV3Xx1S/hWRpBXN2nBhXkvaFdcCu2?=
 =?us-ascii?Q?TX4725rZJa5/YZ4xHFGtFJIgjn453zBs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?and+OXRZScQXgSBlTxzWDHeH4vdyL0lhD/tSwZXkENrdFKUe6FZOMtL67WP2?=
 =?us-ascii?Q?BEYknkyuFEEtL8DEPvnH4tlHD08lRuw+BfU6ZsxI+YolFO9Xe9u5lKLlCchm?=
 =?us-ascii?Q?47f6LCq4LdxJT3gm60vo/Muvx3Qqc6icaTF/RfVGHfJkrliO2+IgzNa51Vjc?=
 =?us-ascii?Q?HxTYQ3m456liLZWa3r8eNAHKHCuRIwYsksr5VKqDyvnKiLLv/Vb/ZClGOQS2?=
 =?us-ascii?Q?Hsdg595+JMpaxDlMoQKaJQJsoAtcKyYZv3LoLVZjAKNJZq9DSLEAgqpqexe+?=
 =?us-ascii?Q?s7M5YClRD7RrqgXyCtrpOJ8sqfk4AnHJdWh8IHrJB6oeVCuFpULGCUiiX33h?=
 =?us-ascii?Q?BOaS19LrgUqFyih+bQXBIk3TBGjwOmuwNtps3p/TqMMF2/N0+f/Vf90I1LSX?=
 =?us-ascii?Q?9hsFB26WB/AFwLJ6BADugRCot5nvtfieaROdJ/AnLoIdd2m3e48v7LBu1t2t?=
 =?us-ascii?Q?BKzb/LvE7Few1CoCne+CMU7EqSJ88RKW409aq6qPWOA7DcCH8hmne50lZxnP?=
 =?us-ascii?Q?3W1dT1qJn9hdKye+JQ7b1MAVLn743c4PQyyEFnqskkNuyc/Qr6Xnppm4AfDL?=
 =?us-ascii?Q?uiRDj1gcZyKJ0Ktz5YUse5H6MxKU+B3NX7tBK4GepSQNXOZfek+nKJVW7xuB?=
 =?us-ascii?Q?QL2ajJsVPU25qRiL2z6NXlZp4PmdaPKBMpHbb8opsZaBpaWrew2v+XKGqCQK?=
 =?us-ascii?Q?DcwPiVmPxGhTKW8c1vsZ2Gd065Vz9ScZ+mKrFLZR5zVo5WDrlAU/HYdNpRlv?=
 =?us-ascii?Q?3v7qAMQPKFgtPFFQKeSBdxAtr++Z8o0vNZkq329uHuN1KtiM0qYZS4uTGipj?=
 =?us-ascii?Q?O7BuAu8gxqiiKuSGiBzGBfpo23X67YxMarLMVNq3Ex1Ej4faghqAQYDR8ZwD?=
 =?us-ascii?Q?nb8TNL8Rk8I3AuPBz9TFZOUd5zi88W171MJkkp1Aj7/CVTxRdkxDC9lEN6uC?=
 =?us-ascii?Q?KuXqM0aVfuBcORtqjxgbBIOifseI8ggU3KaG5LqSVyJ/kJ7soZ5mSBk7C665?=
 =?us-ascii?Q?5Y4SVj4ER38l04TcsinoeFbC81yqh3gfcDH/YLom4p2sHvj1ZX70JHyvPfEv?=
 =?us-ascii?Q?yq1g9glkes8nvUlvDsfI9vomd84WQCw8jF5MBdkQJZdaPGo8xQ6PG/wnhOX/?=
 =?us-ascii?Q?DXhWnFXb7ldBBN30BNVAXpGY5RSIq9ev6FZzuVukos6n3oIlMHyiTwNtkt/y?=
 =?us-ascii?Q?L52HqDyfiMMq3NFkeLAf4n2jkqrq5oXl8thn0YBvQisxInboNbbOcbf/jYLl?=
 =?us-ascii?Q?NEJPYZ5hPVODGPE81XrGHqc+bk+Lq6lgEbPZMOWmdHK2zFyryPku89JcJoOP?=
 =?us-ascii?Q?KenIXk1u1+TJl17JiFHvQFPY3qbcxQq3R0DAwzZhU9+9hYCExaI5U/abFA0q?=
 =?us-ascii?Q?sY9f4KkUa9NypZ9K6M4NBiVT1mjzxuB3XcHjb0wKuMHWqy3g+H7iRRWf3s8a?=
 =?us-ascii?Q?82Kddglf+hNwtD04FlyUq7RJNY7j5yLSO+XOWia8P1KKOR3f7k28ob5ECkO0?=
 =?us-ascii?Q?Q4qv705/B7MoXeWSmYkTiBehsCSfGqw55hBPjnRkiIcjItAf9VRGklVXjgkV?=
 =?us-ascii?Q?NPFcJFeBhrq/YqsbVPqK1OMlHMdLjhkCaQJSP/XS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5f000f-0245-4404-b709-08dd6127fd70
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 05:37:34.5520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dGvRK5UIMleBVhoi0PYyofjmDqDTKlPVx0Kpy0VzcdnB1xDxdIJdyFBArjEiy6w0njrsYVNRBiTEtqZ6Pil8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9640
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

On Tue, Mar 11, 2025 at 07:30:27PM -0500, Adam Ford wrote:
>Now that the UART driver can enable the required clocks, remove
>the hard-coded clock enable.
>
>Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

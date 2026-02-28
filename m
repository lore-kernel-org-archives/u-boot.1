Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBBDFEE4F2
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 15:59:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99DC483F14;
	Sat, 28 Feb 2026 16:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QoyDsCyu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E23AB83DBF; Sat, 28 Feb 2026 12:28:14 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 076A7801BE
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 12:28:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+Uo6xSAv4A4yIqH/iKL4rkYdohgQ5RsbEsHZdc1yq9W/KUfy6jsQoVMQjDG6LMEVL/7/jLyWvWz5CBiZpZuFbmIfGDL54KxBwYiJKN4ps3iMUEuIPm4GdvSMtysuZ9RwG8/JEP6hb5BANKCwiwQAS9TGF9Hn2DW7VPgo6/Ki52igc8rqkBPEAb3VH6g9G/Dw1Ebw/yVwJX1XC+jTOYeWJ7RHumOTA4J2TDmqYKWSr3IheVkNhdEHoHykqZCgNn1d4+0xp9Vpylznljufx4IJ83cFfgqioUru7OcG+reNoutYGBUnQ/X15+8ZClgEVe6J9lbq/aVxyrkSZD17hGpKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4do38HwU3UgP/pEI2zVWpEfUsW9YV/4h5NkQ88cWJXs=;
 b=VmNIkCpbdiityzbz1DqrzbbPMPnShu+iOTw4z7A78B+Sg0MAKPUQl1AdnuY0V6vsjKvJDTyEozXz60PLwjQaHAEBVweOV/3of3QdoPpouitzuxyveFvuJ0u+6kACUIXOS4sqoY+fARwYxRr4Cz1JwFKpgb+IrdhpTNeITFGFME03fKsmxTcRHRHFHAiME4M5Qep5qsUlZFb717w2oZZ71LDsWXGbHciwoc9/QunwFk4tcmH25iBOboMk2jg0W1vOtQ1AWW2EA4gCtMij+iWbzZ/3/hL8KbaG55owj/Aa0B3BiJCUFZ/9+c92+fIOSAZov49aa3DJ59bkKVz1mrVG9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4do38HwU3UgP/pEI2zVWpEfUsW9YV/4h5NkQ88cWJXs=;
 b=QoyDsCyumE8UQ15PPXC6TYvuleEo0qtr9+7Bp3LIECkzP3tY7O/V51LmXHkojpblMEiE4af89c1/R4kt1BcUSPaqxaDFLtx9M+pMB1QWuXuTjrraC/S0uw21yp7XMmFtSqlCr5MQ9qS7Z/CL6Hpv0q7KLvKCm7BP+yiKaf9hYoqr5h4R/wLHWa02k1Z7nuCsjzgSFn3zIrzq/OsENr08gCPJB/GR0XZQ6DFpjp9q2Si7GtYsQxxvWf2NthtLbYUWDAWeYC3QCHah8rcXDLGCFAoCzJxEfjjV9WjbHQLQE8gpPhYFmQusQIQknx6oj+79LUqN0yW/Tt0thEs2Arlelw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA2PR04MB10470.eurprd04.prod.outlook.com (2603:10a6:102:419::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Sat, 28 Feb
 2026 11:28:10 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Sat, 28 Feb 2026
 11:28:10 +0000
Date: Sat, 28 Feb 2026 19:30:01 +0800
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
Subject: Re: [PATCH v2 08/13] cpu: imx952: Add i.MX952 support
Message-ID: <aaLRuVlNVRBB2adv@shlinux89>
References: <20260228-imx952-v1-0-0a360e7e8cb7@nxp.com>
 <20260228-imx952-v1-8-0a360e7e8cb7@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228-imx952-v1-8-0a360e7e8cb7@nxp.com>
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA2PR04MB10470:EE_
X-MS-Office365-Filtering-Correlation-Id: 741959a5-9900-47b7-105c-08de76bc73ab
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|1800799024|52116014|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info: sCVR9V1XdVGgJ8QsPBeMG3CIPOnc3dLnwQbI3XFwCvsSMllRYoSa63V7a4BTge0x2nX8dNdVOGNDpO8qWzvk1IFldHPukVoY3d53nJTDPyGa6fJUa1dv8Bf4ov116JQI6DiHjsK/+nEJjZ6F/sbNmpx9iFgyielnuW1MsKkuxoK7JRZhPVrS7yuaROhGMD8oq5OYLh4Nlt/A23T9PEgX2p+6MOszxdwqKvn6opoLPWJU6VnQ58iHsythqwRGCIYiT48TWlbvHaOOL7kHnJVsliJn+/RKb1fKmpAOp2/jlmv+ohphABeqv82w7ZbrshkJTtqH+YhSZPxMysEDXXg1lmCG5MKXrblBsX0nMYmCI7sL8UvB8z/RS3KVD+7zAokArymiiKP3mJ/eUKNLGkLd7h641I8oCQ+Y7IHucWAe47MCCbb9cOVOSbhlIIhqg4BFURaMwlZs2Vmwe2USTKmW5HkWIHmdUrxVMfzZ9cXsNPGw35DKeVkyQU4juiwaZjswiZfybrKq9YOb4eW3sohZNz75i/XzjpMdfGAqUdw0+SVX+ruN7fO0HKL1jZ0pO5EvMsKnbyKZbZC138/Tv31zC8ftg2PoWsgEDFpn8REHTrvji6CQzSt3xp3XwxgZrlTVt6DE7/Oo14peh+lv/tak13GdH5HhlxYiimjw2K4Py/66bkJwMLhvxrGa212dPd52O/0+tehsXolNj1sbdFiruopjhl5BnYNKNNx2e0CjktyJI1Ott2hVlD0nE735nvihETuMYRVWrDkzk5eLqLu/ZHbYqFGBbD2ymynX6BG95rg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(1800799024)(52116014)(366016)(7416014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WEsFIYqVO+NSzRCqxTW5jfojb22oEsNlywJioO6orCH63Q8SoMJIWmktwF6n?=
 =?us-ascii?Q?gcjD6k+IyAON4BESPXmaT1NibdmbIvdWjR75MTFpUsacq4XfZNzfosyMgRre?=
 =?us-ascii?Q?V1hXLY1hGLK12rvFoPSJFFjMxeeVx4KTEjvqerxiimw9xrjaz6sQcmYZaKBX?=
 =?us-ascii?Q?QH/qzw5506KJggwN533zgSZfmPqPBDNX9vo2tpo0g7utHfUPVdP68Zu24dyX?=
 =?us-ascii?Q?0rnHXMChnx1SCsvAP9gK5/0ivzFuHBa0sjUqoZIBgdcepFgS3wRlO/TMCJwT?=
 =?us-ascii?Q?YLCWfweCoF2VeVtXaVN4gA4onqFK4bjYbmoz/z2lBoTeys4MjMVH2x+xjVeL?=
 =?us-ascii?Q?+ADMzBJ3D1g9h54GWgHKzcDPQc6Ocq0pQaUToUKWz9j6HDxGVsffWgTiCghr?=
 =?us-ascii?Q?JottUCPz0q17orazPy0TuhYIjdLQLtYrBqS4ehyfqvS2ilqyctN3v35GNd19?=
 =?us-ascii?Q?RqEnsQxjuR8tIQMHqj7JJpQ7DxNA3TxnZ215etm/70mMgqX7RHg0DqmY8000?=
 =?us-ascii?Q?eOGSrn0r1NbvBWCPMRWjHWxrDbX8xQfuBMIGcT0T5bd3jisO+9RY7Pe9BTDR?=
 =?us-ascii?Q?O0LvQahCOnEKRXXhF88za3gQgUFQJc89InS5B5qZR/t6BdJhZg+NmRbTQPb+?=
 =?us-ascii?Q?86l/Onw8VwQmcJp39NZUkKxMVooI0gdWWElotw6Nw/KGDU71pc6+a0MxUaMV?=
 =?us-ascii?Q?dc5DHkU5wpWaiLgBauCx73J3wV0H/76E53SHjvuqLUmURlUn5FLknjhvHnpT?=
 =?us-ascii?Q?uG2FaRs1cfs/H1h53000PBGxLd+mvHxOPGOGktwp1WDsIBuibgX4SYcTGe9f?=
 =?us-ascii?Q?bu9xy2aLwDDX0DEQtUF3ezp/yoh9i10USpCXoNb//nMRscTK3Eop+9dBya52?=
 =?us-ascii?Q?BNpgwocGdGga1cna/uDDzRoldrtjGMY6Z6o9TVc1ug/eUT111JZxQPQo4xeK?=
 =?us-ascii?Q?sGhdi8vojru1Y/jgkFNOy2jIUDRYR4qpuFc9OOJtL54q7o2APEZAD+e22oz7?=
 =?us-ascii?Q?Q6ZryGoz0IiHKhYOkQP3qWItRNdToqn852xJ35m1ueUAdt7lJkz0Ev/5PkFG?=
 =?us-ascii?Q?+PrwU8ggLOSpzDwF1HPZ3OG8YwOlInH60U+8jGERo0+mCNcL6koP32zAqLhP?=
 =?us-ascii?Q?89nb8sW3VV/VN4t2RYkvTfRa/1nnEw1jSzhQNZcsqQ0usgWrMzh6p7f3qAem?=
 =?us-ascii?Q?CB0eO38C4XuahlQZnINlVnpkFgvSKEukWmwHkoWota1n0UinZidXGpKESt33?=
 =?us-ascii?Q?2w6Sjtiak7DqDvMwQaz5dTtsfDZ4xAa+UEki7QV1h4oXavpiFASM+o0Vjvqp?=
 =?us-ascii?Q?kc3+J+RUeZfe1+uckM904fo/ts0SGl+2Zukc/KGaCpTpk/PwWxM7iwzeoYJ1?=
 =?us-ascii?Q?39RkkRBi+4rgt8VXZPwpIrePZOy3KndslBbibxl7IZhzEo1F9a3T52M56TRk?=
 =?us-ascii?Q?geHkmZ/R1XaTlG7qtdItr5UZxVGlkQAh2zgjJ8qJVUVzlyz4nGyV7yo2gwn/?=
 =?us-ascii?Q?u3t4pyCjfUycPKY2D8tPYJWa3u9nyoj2BEZ7ZTcy49sxS7LRgEDlbsaDxmVT?=
 =?us-ascii?Q?A5W/22AcqZevzNFuJRsGbRtJxo6L3GO9l2U9vToqMk2QYo630K+Q37jas8rH?=
 =?us-ascii?Q?aNsAEzk3e08PZjuTFTZVAbPnhQV78EBhf6/g4wRK6JJ7RMvtogKCjJ4bmkii?=
 =?us-ascii?Q?5TnynkeZnc56YzNfRqd6IRCTyqze409/0lbuRbqgj612/4kg3inss+K203Ov?=
 =?us-ascii?Q?YpheWWGRpA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741959a5-9900-47b7-105c-08de76bc73ab
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 11:28:10.1164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6qnbYk60vr79yFtmnbLuocEQhVv3jTKsSmxm11uCPZOa80IbTV89LoPEF7agJPInObHih+nsCI5AavXRdn4TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10470
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

On Sat, Feb 28, 2026 at 08:22:26AM +0800, alice.guo@oss.nxp.com wrote:
>From: Alice Guo <alice.guo@nxp.com>
>
>This patch is used to add the imx type string of i.MX952 so that the
>i.MX952 CPU info can be printed.
>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

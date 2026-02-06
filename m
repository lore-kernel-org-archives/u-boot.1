Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811B8ECD9B5
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 00:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 083CC836D3;
	Fri,  6 Feb 2026 01:33:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="O9t+KMsq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB15C83AA4; Fri,  6 Feb 2026 01:33:48 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E68D283015
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 01:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+7KUf8IZ4XzqEufy1ncA/afE5qIaY3fGox6qqAX3D6Oy70Suq7wg3SHyhiAqYcD1F2UJMV/WYU0E+vvVumQF8Rylf+dLPg9l7zaVwWrsCBQp2uv+x4dJEJ1IUhHyyYLxLPz7HZ3kehaShfE3NKmWqOYbTOnC0NspVFF8jIsRFbL45i1oB418McTE3FpixulDlMVUOm7y9Z7y9S4qbDr7nOXkvGN6I1cjxLUAcGH/cpUr3ClHdpdBvhh1xW4GoVgAm/prnGVZOFm0/F+qsmhHKse1ITn2L3UbLwvkK0+GKn7yrvI5PtDrc3CN/HGlx3dTwBj/adfM8YlfxjLLTma6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fClk0dolrsquURXMGASA1Aolv27wOTr0BVSLhFUEZSY=;
 b=yYi7tOK1pjL3lWqMgoCeDzXPShY4ubUGGVYvt9BBLKYBG8V5YI/dNDbvq6LWeT31ScR0qUH2bOA8bT4056+8Bm0DKrNilt9irRajee4vogRxM9KOEW0OSUHLThARiX+0WRyh1eALV18PJlYXUNvqDDc+cLCI8jtP/V3LAFENG9sBhyR9AtuSpAYB5byeiOPAol4Kt1dYXHxZmOZfNzDnku+o6Cv1hNYTumNjfMW9tpd6pV4LYblMlrkeJInaJQicTTaqz+jf6NKQMr9onNQGxsR8kUV+9s+ZCiaRyTniRULCJ1JXK92U6dzbbDuHECYlq6Z53jCDG37rsNx0SAD6pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fClk0dolrsquURXMGASA1Aolv27wOTr0BVSLhFUEZSY=;
 b=O9t+KMsqMqLPJ/14xNtgcLmgJsjp+6UYeWFEqyEikqbVeIHlau3G1+fsJrO6lAxZ2qBb3kU3MWJ5rfzfi8nM/wo/HE4DlIrKNTVmNwS86pUR1VwsZoNfLvrA0jup0RK7A4K11zou+SNa9PhigQWSGDhUeJPUhkpmL1hBKKKrhLUKkXf9E1BYfKTu+Ull9Wn3CLPGGbr8WkucZODCn0vYAX70WE/7s6yirft92LElZK0DwIFfIrjwGDAaPafzuTH9DY6zfQSrOQIpN5fudHYn/xItQRRd/O8zbiEX8O8Mn6CvwGxvNWBlRiEtpf8TMSap1lVS9k8WqBJyMRi57QQN2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10925.eurprd04.prod.outlook.com (2603:10a6:800:25b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 00:33:44 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 00:33:44 +0000
Date: Fri, 6 Feb 2026 08:35:21 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Jindong Yue <jindong.yue@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Fedor Ross <fedor.ross@ifm.com>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>,
 Ji Luo <ji.luo@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 David Zang <davidzangcs@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1 02/12] imx95/imx94: Remove board_phys_sdram_size from
 each board
Message-ID: <aYU3SStSlGOS+VeX@shlinux89>
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
 <20260205-imx952-v1-2-2103d0222a0b@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205-imx952-v1-2-2103d0222a0b@nxp.com>
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10925:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e64a5b3-5804-44de-3c9e-08de6517623e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|376014|366016|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K90sAcJDdh37keWZqZ6+Fg34d8GaO/hr3yZCG3U3SBZtGWTUgax65J6dSg0U?=
 =?us-ascii?Q?WXMFwV3muYDJ0fi3n0ZTBn2JEiaIOJbgf8Ew2ZwZI9FsolzVBF4xXbdXbSK1?=
 =?us-ascii?Q?dPXBsmkaU8azw5DgJXqKBsHrXwspnzrMzYoZCRG3x8/OeYWxWunLC4NXbfoi?=
 =?us-ascii?Q?t9CSJUAM0Jsk8WzCFR7nGdmuqTUGbRvUF4Wq2Vsz+T4l6uRm/75WhjQTceq9?=
 =?us-ascii?Q?ziQOXwxncEYWqnN+OZyocOknQtDdzRhdvx+YQGWO5zwyx8xWq++5/BaLhAfz?=
 =?us-ascii?Q?8lA0Japp3YesfUW+8Iw7fNaQfWWRQN5OD/1eiVoBhDEumskqSGb/Kpur5Q2K?=
 =?us-ascii?Q?tI1bpzaDwK3C3PoeySsdUneDTZyVwWL4aU1OuhNgIHcTHkYqcHT+NpMsXdqD?=
 =?us-ascii?Q?qQGpnlJtShz6BXZ96KRy5P/ksqWXj3+CmTldJ+e8Y55k+VWpnhGlcQEuXEui?=
 =?us-ascii?Q?6J2+fKc9RUkh/fBdSfGylKkl0eqJzwR4+bQaKlBaH0ZenRnFtoZHWWlqDKCS?=
 =?us-ascii?Q?7JCvvg52Uj17uiXVXWZu6OdOJZt4x0JFaPxAz4k9r1F2D73iJHxT4z3jzDUp?=
 =?us-ascii?Q?rgU3+7EWxLTj+6h6Rxw8XiCvkTmkW+aaUXaVQljcgv4xNOJM7ED/SREbtjEm?=
 =?us-ascii?Q?hmN3gT4h+tEE3hX2YTIfHfyzB4/thwrnGWangvEpYrozK9MrCJHvfA1OB6YK?=
 =?us-ascii?Q?BfrocmvdMrV/0FVrmrITh+ztk/hvi2wjzA89Dmkx70EI3YKeG4a0geZDGxoS?=
 =?us-ascii?Q?ZLTur+a386J8m6/GjeEaDkd00aLZbsqfjWfNDJoRrwguH45ayNd5wy2TDEqp?=
 =?us-ascii?Q?Dvqd0bBWgccRlv8YV+fx3MUl8dPGFQUn/XybdOtCLpK/h+wID+POQRSPKOaq?=
 =?us-ascii?Q?/nWqBmTnDgvARmhiuZNIilhlYh/m/L/Kpyv9jqqDcxTS8yAxE1400zvqqNjr?=
 =?us-ascii?Q?M68YrBgM9lGU0fmBPGhMt8WXPFVJpVeYczuKCYEU5KdE1eL6zjUsEAtnvLCs?=
 =?us-ascii?Q?zClU8Mi9mHq7I4+apUIkDgp9DPEqBdy8xE6PYze5oPoED1o0iLfEk3NoRE5x?=
 =?us-ascii?Q?UX0QlIvrmcr1nFqjdRYmz0/AwHM3RyQgcoDI2sK9PrmjoW6WBybDkjr/Kxha?=
 =?us-ascii?Q?EnKPOyP+y2IJ8qCId/ocJ8nOJnzbi+yewQ6kgrzuedmvu5PW0psLGla+s9tj?=
 =?us-ascii?Q?tzyWN3F10uLlWANYnh86pNF2IoQUubVyegfa3ozvzzTtgnOl8ObUGPCyRqNL?=
 =?us-ascii?Q?pvq/0RvKnbzjYBNCbN1F6O3hs9tlYdsqKKKZVdecdM1/v8OzNe4sNd5MR3eI?=
 =?us-ascii?Q?yPdpC6uWQyWAC2ig0Cfpz4vljZWTRYf3etsAxK1YCWbQDcWNWQZMushLlAo/?=
 =?us-ascii?Q?0EwUDGr+A2tUCnZZqSV2flLiXxFrYj9vlbMXMBikGUbs0kgJWJi598vrO7z8?=
 =?us-ascii?Q?zgkCkwmESaK/0fD1N4l0Ibzg4OxOJ4sHd5ypcW9h5ofHhSvmJqYk81Q4C29e?=
 =?us-ascii?Q?mWvFzfGOax/VPoDMIBB4NXsdaphb1Hs0OaEwwEGKHeMns/cTVJePJpW3Vybh?=
 =?us-ascii?Q?V7xvoY3p5GY0KA8ey3qTKcZCU9TSh+LECxMvIt+SXeadCBaBd/UCZDFXhpoj?=
 =?us-ascii?Q?N/hj2omxAcjZFzpHH614E8U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(7416014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J1tIuSvYF8xJuGr2QOYEKTwEEUruUv53ZxHg8hCMPCDuiyVMqSq3QtN/dQ3s?=
 =?us-ascii?Q?LgP3qV3rOnFstF/LDZOoaXenoBo+PiwD1IY7MjZreHv4ONU7GSnZgv2L1xKb?=
 =?us-ascii?Q?QtLLQ2zjz30eLHJ55GSqi7ZiRE8DLRHI3kuP1BIEU0wcnhar8OwqzWYXyYo0?=
 =?us-ascii?Q?9qth0cRMXsWN3dEJLaXf0pVr9l8/avBalqsehFKsx2le4FYJAXNnxCXOVtgg?=
 =?us-ascii?Q?xQHp8Q6Hzu+sXkiYcz6jfiv00Y1T+KNgb8X9Alo9AgMpSUz5c5EglIpR0nb7?=
 =?us-ascii?Q?tyCRXWA4ST78+3xk/rLUBaNVkwcZ0ZjILVeP7ZnGQUNiJY9cJ23w4Dhlo/rQ?=
 =?us-ascii?Q?w6DJ3IZ4ONP3+dfm0KwgzUlZJD/i7rQid0dC7WrTirEWJSpWk5SwFBS4yaqa?=
 =?us-ascii?Q?n0lbCwEmg4xoHGgBUtW4S6mIpGde9+tMh/Lf2VwsM0XgfCcV8mmE1rVTYVoA?=
 =?us-ascii?Q?5BwVdL8rqUFWFOWd0KQ/qliW0E5bjST7gjLRLnj6x5ISRcuacHcaGf9phMAP?=
 =?us-ascii?Q?w5m6RG9QdlOegGm9ZGgnC9I3yEsiKhtJGdQFKwX3xPGxkOxPpg+wGktmcTx5?=
 =?us-ascii?Q?yE6kK4FkRZ2eLVyIW7Kjww3N3EYGZSPmbj2Xbo0c3MgioBhAcq3AuDIbeSGM?=
 =?us-ascii?Q?yiiyHOvROKjDgZA3l/foGLJUDH7xkosx8j0+ktp7rcouqEEOSQxAuauCkDug?=
 =?us-ascii?Q?vGje60U4RwND1o5+V7y7mLEuS92TZmj5A6DJfbAruMoIaG6EQ1kocCkUUpic?=
 =?us-ascii?Q?lOwyigX0kxsXPcu8LgHbmISGEnXEduxlBhgcRn9IEFeNUUgnkjd1FuI34M04?=
 =?us-ascii?Q?RoFkiHFYf6/yeOrRnTGkW+A3tyleefmEzOx6XdxgmvQsSK55XfEkZc8LwXxR?=
 =?us-ascii?Q?E2a6ZuolzSBpTOCQhcQQ386otxBpKsqYVjrXic89Le+OZPzRgJaZGeU57rQC?=
 =?us-ascii?Q?2DDuz/aX9acQieN0WnuRUewVlYyTSDmoycDvRD5bCxFR2CiyNZXw9dGu3ns1?=
 =?us-ascii?Q?wsicBFIrj6Exx6Cf717ZvksoMXoMAC3dpeaxGGbxJu9IKdlGQ7ylvKq8PGjL?=
 =?us-ascii?Q?+fPS80ZbXxmFOKiFud6qlI/A76nlgzIC6yRsj7V8VChUHYp8zuQRGSudCucV?=
 =?us-ascii?Q?Zw9+Cs2RW3+1aM8mLQf6+Pz+UAGimKIrrfocGOjgSgWNXepGsmIdrewxTlbD?=
 =?us-ascii?Q?A4WWnURccIZRvhJCtjx7ACmFXfEXG5e5JpDgKLqKitx6lRtHNFcNqo+aoqj2?=
 =?us-ascii?Q?A5WPgxQoG/hqdoy/s6eU1fcfZg8UHuSUDvEeqTWaucFAWHqnCb3wY095DYp1?=
 =?us-ascii?Q?t0nWV0o+HdgwBA3OWi68qli1obX8TYyswVHrClMKA3BVx7SCAh1YfMdAKQgH?=
 =?us-ascii?Q?3gyVGfEkgE4euzRvVxnSsZ6PtTJI+dAG8dJaJYygJGJA0/qN+ydvDR4mSCpA?=
 =?us-ascii?Q?ma5Iy4Jwy+k3KCpmhGSNJr0EiKF3ymTl5sFQk40bN5tK+3bMqjx0ZCNRo8MZ?=
 =?us-ascii?Q?PCZwL8mtu4vTnIpFoP8n8kpzKFuH/kDsK2WJtZ9j1u2IqzgUewqyyi9dx0Pv?=
 =?us-ascii?Q?/veU2NmE/n77P87bD8uHu0rRvuk7kK4mawy1FELPj24tKSJ9A6QbjyhCW9RC?=
 =?us-ascii?Q?Gm1PTGNnnl1fU2Yvphzif6WvIifEwwDfygsoHhdKgflroWbvFwtceDBoiFr4?=
 =?us-ascii?Q?YIEoxePW2tJGxMr14VTViSe3o8zXkVaNB1KFkTcVbMnL9POe+RZI8PgAbq3Y?=
 =?us-ascii?Q?g5p4vPP6uA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e64a5b3-5804-44de-3c9e-08de6517623e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 00:33:44.3683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/3PNyucighrGU5vNbHlCAa/jrh0eSc9rvtoDpbXK3y7wvNKs5IvgV3Xt4XN1qoPCVQraaFwVqMCkqArV7zCBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10925
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

On Thu, Feb 05, 2026 at 09:55:08PM +0800, alice.guo@oss.nxp.com wrote:
>From: Ye Li <ye.li@nxp.com>
>
>Change to use default board_phys_sdram_size implementation in soc.c,
>which will call SM API to get DDR size.
>
>If board has special implementation for DDR size, then board_phys_sdram_size
>could be implemented in board file to override the default one in soc.c.
>
>Signed-off-by: Ye Li <ye.li@nxp.com>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

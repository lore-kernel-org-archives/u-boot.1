Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A239F8FA66
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:27:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B19D683BC4;
	Tue, 21 Apr 2026 14:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TfEcZ9xs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5E978431C; Tue, 21 Apr 2026 14:26:33 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E27DD83FFA
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVPz/54vNAtLWYwnfAprBIXUtG5EEZ3Wm+URGRsTln/xytwdS/rsA0pDxO/6g6srBxw10QNs+MZJZVottOEYztCCbKnH0F4UL3wlT/Tr/ZIcvkd7AuhJd5jovWSb8jzfcCUpwNCNoGNVRA3yjP3xXMVn7m3SRQc0z6c20mZI/unwqCpBtJPuYfco7vkJwkX1qpNzNj6v6c3IhQXXsR2FZk9unz2pDMbLoEL/Ze0HGbq4M4eqvyjvUMZ18W1ah+JaLjrCdRuD2+7lOllx+HsYbW1+Xr9dYVxHr5z2XkMBtOfkUQpF5nv+IP9UO6uLYjdqDW61uQ+GEvOl6mz5Klj0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11iRxkmT/5ekzEaEb+RGQMKngg58k0zFvj0BlmMuxmE=;
 b=MS3hzrMwva2Gp3ExhLIX9l0CwrhVv17cuncPmqgdyapufCjl9XvQqPPl7mOm1TgN8laSzjFUhWgwudo1wNCzRVl1spfFbcRCLj9VsnQVca3ZaqdZih2moznue6EfjPuGnvUrRPyp4iML324bGOm9uZupGehrvvL5lm0SD2YWrPF0EF2u8zSePilrx1GrU9CZEXof9FrhCmG+2pXLuvVOxv8n4q5+xxql3v2xx6ULXwXM3sjM6y9GQMzKI+8Nu8hYyLEFAEqhUH3KWkqKlvTZpVEZmGIIHaNuRPWg2ahfcrLMqpK8p9YFITIl59imU8s/3nw/YsL4/ohlbWnwnw+xJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11iRxkmT/5ekzEaEb+RGQMKngg58k0zFvj0BlmMuxmE=;
 b=TfEcZ9xsVqYpcMFJTgruBgNylvq3s+aJBz9nSRs+dj6aEdTtAJxta8WFG0Vc4v0IJHtF3t65wjMrrKyZTZI5NIjAgBzQmpfU80q39LE5N1XWdk2u/lizO88J1feponY2pWoyvaqIGol9NgmVt2JkBYWFEXzYMEfuNisqhfT8Y2tx7zaPKCiaiQTo4TO83ADl7t0FhtrDFtO76bAHDcgUq/+ic6Q9HTxQBOFaFV16Re1y/N2mybaC38B+pcvXHiqqffafKWZf0XiW46JAIeyTNc+JOdBKQfLmQcIr40wr1Qs07Ym8mbLgvo3HKC30e99juQb0kAUJoMWrDhZd9JxYJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA3PR04MB11249.eurprd04.prod.outlook.com (2603:10a6:102:4aa::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 12:26:28 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 12:26:28 +0000
Date: Tue, 21 Apr 2026 21:42:56 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: alice.guo@oss.nxp.com
Cc: Ye Li <ye.li@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Marek Vasut <marex@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de,
 Jerome Forissier <jerome.forissier@arm.com>,
 Tom Rini <trini@konsulko.com>, Michael Walle <mwalle@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Heiko Thiery <heiko.thiery@gmail.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Thomas Schaefer <thomas.schaefer@kontron.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jacky Bai <ping.bai@nxp.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v2 1/2] net: fsl_enetc: fix the duplex setting on the iMX
 platform
Message-ID: <aed-4IWWC-4vG4HI@nxa18884-linux.ap.freescale.net>
References: <20260413-netc-v1-0-8670e5ce2d49@nxp.com>
 <20260413-netc-v1-1-8670e5ce2d49@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413-netc-v1-1-8670e5ce2d49@nxp.com>
X-ClientProxiedBy: MA5P287CA0065.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::7) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA3PR04MB11249:EE_
X-MS-Office365-Filtering-Correlation-Id: e186b50e-60c6-4b75-ca66-08de9fa13657
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|52116014|7416014|376014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bsZYeX3f+CZfhJLO0I8OFTabyNYqPia0VcraVcR28MMZKFAt62LJewoVSknKpJjvQtlzdTjI6Dt4URf0wkLqd4696PTOAZFmlk9PvyvPV7082yOUM3zOkMe3ElSDw1bHMg2WFzh+D+0ia26p3Ig9ctz+I8snUC8SURlqnifpjeZoNqwW8w7VsbYCgufY0XK0enjMingCv7w1RyjiennAhmc7gL9XM7JtEvXdDCTFHaZSjJ7HXgd9ZDSv5tZo1aVdaNyURMCfzoxmElSGYDml5Y2OU7uzMQox6BBNcyRWhDu7xWoc0CSc6W+csTIH5X1oKpS3NIy86zu9RtQKKBV/McWezVntAp2+TLdDPS8kUzg9ncS9y+PSrBJbH2v2ZRioglF5L6vi3xpzp9P1BIFeVX/QkMp/lQuCF2F6NwIJTw78ThFikd5/5F1g8E0D/FG5Xy+zD1V3ghLL/v6Oa9UZjWiHydljqGAln+d7rcn6hlogON832qA6fI1PW1mgfrjfrX3Vv8u4kfvsJe12RQ8HaYsLUzDoI3w9VZNlBNONuqTT/X905J5hjubRi+WF0uUF8UOBCuC/7r6IAZJeWyI8l5cKnaf6ReJleUyoqJtvTRNzhfJvnRHYwyJBXaRU7VE3EyJ/2ucQu1GceKDJ54SUaYHVAnWUleEytAYlETCtpkhC5oMzOiaTTGIrPhYjtQWyuXTmQSETkqRtuXrBbI6K1r3AhVA0bJvYANuuJq8yQrO1uYuOW2ZBsNVk+exH3OtUYvKXgvOP8fvwqhBYQmUZO52P6qeNCCAEL7dWeyD9JoA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CQfTgRvZYhuTkyUnMAGjkPrtTwDKtyTZQlVvom+rIObZ2TlHf9D9GMaTNrMT?=
 =?us-ascii?Q?1LAbaRbKJrF0smHx+4VEV1rglWua0M8qECjJlCW1zRBCdphqPuHl28qEmsag?=
 =?us-ascii?Q?/yKuMYA4NJzq/YfyKoCnKewcRbSx0UZSRp+SR/1CodR18w4pFjfJOgCqc4nw?=
 =?us-ascii?Q?9VykDHpwgvK1EA8pKz4MuOGibtr7yZ8WQSVfgeb8vwOUima8a6VkkXF5mdlQ?=
 =?us-ascii?Q?wTIYBodJap3C3hllq6HQyTmIRWBACfpjbibxoAsI43FSVPWbVrCjsK0J6xSp?=
 =?us-ascii?Q?XxiaT3/jgelOikpws0bbP3QMtOl3rJiTdDY3FvN1+LypMulGDI7tBkJMpR79?=
 =?us-ascii?Q?JFuqOMtmr9SBsZDtJeu2kjANV4aYV6i/8RKpmHQ1+kktcimN0hXJB8UCeVk/?=
 =?us-ascii?Q?ta7Q00RSJsZ4mv3BWYbgvZUIlPHMz56xGXn+snvfiWTZ+9GBmAaJciU3IeUr?=
 =?us-ascii?Q?+1dmZDpy/BHDz0/046/fZLXyUSpfLGJLbArJ1hNmQOaGNjIFMIKb5xixCRZz?=
 =?us-ascii?Q?FCjgj00w7bOna9Ecv05E5Crs6XcFk7/qBTww5Al7SsWOZp2EtLUOx9K5NGQO?=
 =?us-ascii?Q?wDSpY0gor2aMRSaQuw2NhObAYwGnzHcFgm1058sqn1JCMvL9J7j2MVczqAlP?=
 =?us-ascii?Q?xX8J+va/4QlPk0Uglgp+NxTuS+EhTZpYGP4A7akElMocuNFnA3gPmWrRzzBp?=
 =?us-ascii?Q?LWfkHZUO5ewzx+gfhaCXxOq1y0gqh+A1qAdnCI1hWtShk2kmrz6caiZUluRY?=
 =?us-ascii?Q?yVkxz/xSF9agfXeH2I2t7sdaf5D2GCQx8UiaOIuglMBBFyGZrR8KzMLwROJW?=
 =?us-ascii?Q?oFTzybpXWSRhyjWjFQe26pmAbTPI1vBEtoQS682o0TKwIv/M+TZaIzEm2RbN?=
 =?us-ascii?Q?dqNQDykuSumPkWuidUC+kziDzNRL0fXgT7GkEgrEoBJ+njFrn86jGQDNwj1S?=
 =?us-ascii?Q?m5mKYFCzzze5MDbi+LIQ4Cka9EwkKac9TXkJJO/kQ5ZiCVoloNl8l4oxwp11?=
 =?us-ascii?Q?RsyNQPErPRknD6kXGgjxJRkMdWkzd/ffbsTRET0MlO37t5BZer4o15cq5Tac?=
 =?us-ascii?Q?93SSE/85SEYMdICI+bAfQRelgbhVaUnyIazQzMr548v55poEWsepwT8lQQm7?=
 =?us-ascii?Q?Nj1rNqtntWSNiE4DXHOSkvNfwY81c+BVAYSPEw81D6FVuGmSg2UzyfOCGSF5?=
 =?us-ascii?Q?KMBD97dNXnDaf7N0DiqlYYOYRQyCP8Nk7hMWblqlNv0zQOhP+0UdQOgMIawd?=
 =?us-ascii?Q?bhvcCNj3k5YufoGN0ruJJmAW9PP/tb593Jguh1IJCP5NkDAnkW4tRtWSmrpS?=
 =?us-ascii?Q?OpJloDYqg1Vga78XauIHddhUy06hjXodPe07GgYQGdbXLV0vGvYb93SZ7ZI/?=
 =?us-ascii?Q?UpKJS2r6TxC0Pct1pbpri9WeVz4sVIfZ4Y5IRrVY1taP8ZvVznr0UH8BUqHR?=
 =?us-ascii?Q?A+5Y+cEE4YF5SrhME0BfMb8bglrJweKCW/oZ5bZPKPWS+cWhdyGFYQSnOl6X?=
 =?us-ascii?Q?d//WYd4Z/7JjYISksiOdIh5R7Fz7+z1NBu6F61O3wFqP2OK34ZkTyu1mjTT2?=
 =?us-ascii?Q?n6oizlrIuQK07YeAE5yKKECx0+kOKRA811KvVmOVquxKAtTB1ZN/kPdSXobk?=
 =?us-ascii?Q?aC/dwHaGs4ngnvqvc/KKIt13JHnag2oJ5hXBwSdcQ/jh3o+ee/EcipC+P+2W?=
 =?us-ascii?Q?rknBY2/va1xujpaKhMv8vQeWtY1n/QcdxmchQ0wIQr4PyP2fhMPmGgVYf5sM?=
 =?us-ascii?Q?swphK9uYLA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e186b50e-60c6-4b75-ca66-08de9fa13657
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 12:26:28.7038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+76TAJN61+mIPWCDczwW6uC3KA+bLjrig5LJ4RztXJOZPuNOPFfwol2TC6St5RhZl+k1ZKMfCjBVpWqJ9BIug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11249
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

On Mon, Apr 13, 2026 at 04:15:39PM +0800, alice.guo@oss.nxp.com wrote:
>From: Clark Wang <xiaoning.wang@nxp.com>
>
>The iMX and LS platforms use different bits in the same register to
>set duplex, but their logics are opposite.
>The current settings will result in unexpected configurations in
>RGMII mode.
>
>Fixes: e6df2f5e22c6 ("net: fsl_enetc: Update enetc driver to support i.MX95")
>Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

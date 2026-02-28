Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56850FEE4E9
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 12:13:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 843D583CDF;
	Sat, 28 Feb 2026 13:13:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KcrCZjz7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A89D083DBF; Sat, 28 Feb 2026 13:13:48 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBA46801BE
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 13:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuNAcE0xWftThhdJO33V7sqMDSV6ACMAP54c64aiIiIzfkSFVduXcyK7GIh+C3zsMjtI7DHBZmS7GRCc9/sWcFdyp2Qvr9zl559pr3kh+QxIXjZQkF6dZjkh7/ZM3yVnI71eGvK5AfnikivjWtcDxti02OQYxYUqiwEz8pkOBvuJ/ScyIBpAesGF/+/ZL96Xcew4BKqdjwstWfpiQj1HJbxUZTWtaFCoyGCpThzXjjm3Jmp29NlF1gUaHaBcuzfpgJWskcAqDyIIGE0Dw3YRddw99cHtDvFsJQAfEY761fO6prdmibVpiTE0dVgJyjvdJabZYZQi4CuJofJ1F7SIUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSdu5xAFaWKoUuofNDpJMneTyF/Qpg+7cthJ9qnc5to=;
 b=bIL+JStHjkhSrLOMLfDRSQqjtqanyvenM9lz4apqprZCwPgnET8Wgq7UGQka/YFmf3VtSyYONqTNsDxZkjos5OZ84XVmb41/NAo9jy4MIw2pd/JzZ0J4+manA2SJ3vnNMzaCiZ3E6aCzQ3Nvczl5AqN2mEXAn3cUva6JB78Kl5WnDWbBWlIJ2Aa8GDj/vZQhZHAkOIgxjojDS1U+EK51j+cfaUjbURrRhB1hQ5Dr7uyzh9TPd+vDxeVDoRlIxeCH+J35G2SmJ/PgF+D0/FG66GwP4PjeGIHhU1OwRjBI9LtXZASNENkIY7xh1m1lQIVU/PXD0B8aztSWgulXqIuXmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSdu5xAFaWKoUuofNDpJMneTyF/Qpg+7cthJ9qnc5to=;
 b=KcrCZjz7UWfwbWidoo/mh9pXhGKL8IEheggsWzzfI6bt/4zQ94CwXyVaYpO0nfKA9Ywxd3Yo+gRr49kYn7u7c9Y9hhAmR54ev3/UqPIwcSGQs4GgYaXkGttKAHv4vylvNUzQGbgxLlyEwmzOI1ToEtUIZyKV0tPPKe30+ZdrNqUmd/XQFAjjdcwbxyFtLjkko1v+VzAi/GOdunVPQ5Yu1Gm2Td+bA+ch3orMTobSQ84rYg8D1UVY/GRTtaJ3tDidbIFLC29hwe+8LobEGrS2TBlq35oeY3UeWem2btpSdTR+MOP5bzFyoENl+Ax39ga4HtkWmz1111B7K7XA53af+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by OSKPR04MB11366.eurprd04.prod.outlook.com (2603:10a6:e10:96::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 12:13:38 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Sat, 28 Feb 2026
 12:13:38 +0000
Date: Sat, 28 Feb 2026 20:15:33 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 Lukas Stockmann <lukas.stockmann@siemens.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: Re: [PATCH v3 01/11] arm: dts: capricorn: pinctrl_usdhc1 cleanup
Message-ID: <aaLcZblTkYpwJ+pc@shlinux89>
References: <20260217163911.31878-1-hs@nabladev.com>
 <20260217163911.31878-2-hs@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217163911.31878-2-hs@nabladev.com>
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|OSKPR04MB11366:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e0f778-edb4-476c-aa04-08de76c2cdba
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: 5W8PBeZSxOAl9PUfZq729WYC0V17ix9/XXe7lgeRpkCqsu63enw/52NeWrBVfRT/C7ir71R3rRN3rhgpsq9UxZTKg8l0RPWvyZw34qCaC+C4UCndaqoqdjsAOEczkgIZteZ033xCAdD5zq7nQtze7aExjpkq2RzcxRs7SMCmuQ3YUlrarKktyxWfUJCCpprkEXZsg67xGPE4b4chdvXRSgvsugy8bjlnGUK8fUdNBx0NoJVq0XYo1trZzJuIpwN0Kf1Zz8yJRTrpRuZIgAAAUy1V8ZTpiRX5P8UUPSkntPZOnzw3jeBa9tABfVheKTmq1nI+XvwMHtRq2bKQ/67WsOtV8XyT17pzQ8Cce/LKnrXZT7doGn27HkkhwCqj+8+Jf7fYINcgPWIvrGnqCCM2CkuIMDmpD1B6psiav+0QS1scq0BQUGCz35KDcFfvmnX6VlI+AbaBkX6uzunVnVaAgCBxL7V8E8ePxBJZvwvHZLD95Q17nZ1JnjS8OKy6WUny0B7IztyDGUJNz/vPIv9XaZGCyTF01Tzi6brkWD99Bk3STThbPjJVtOV+ADbEh89vqbkkEGRHmIIYrsod6wV7eXfZFC/Hox1Zv7AQQHB1G6oDscLwl2VM71e9UkatD83UawfahLNs8+Ht1fjBna2MG3SjiPFXNjPzckXXrZzcmzmsuMIE4Zoo9Zz6rzY3Zt3RU5lkpTR/qK3Tm8owu1Va7/Pzf/rE1KZKGEmVwipVkHEzCRF8/5Brwpm3wfDagXH11ze0nnXC7E8PIDGDE9nksufpZvdCV6+TQNdvhWUplnU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B8BjZEnG1DIXOg3+ifcdSLXujfRn5R5fRfWSc0c+EnSeQfANOea25u1WA1Cf?=
 =?us-ascii?Q?RoP9kDd/Lz3ATp8gQpl+jG3upMQGdvAdWroAYM1TAIA7XMHEtbQts8eC0I1l?=
 =?us-ascii?Q?QsHZkr3UGqv+nh6jW+veXlcsspNk+xpgubKyGlh0IyHWS9FPK9A1jNG0dji8?=
 =?us-ascii?Q?NV4mxBsEc0UQVHYgRQUjKA6K9DxjKmySyNUfaxoYxK1dCGIO3JcsF9udVmCO?=
 =?us-ascii?Q?xOBgEmkVBtp82YrZZ/u6lCo5tST1mZjW1jDo2A6RwHLdZ15joQN8ILh6T8xt?=
 =?us-ascii?Q?McNGzf/BpU5ujop+4pgJgcfjrGZyoifs8bWV92p/kYKgTp3w7rBWwhUzrp6o?=
 =?us-ascii?Q?iqa6n7eST97RsHFO4zYcsZEKxeiNILTjF5hn0YVbF6DrFw+uc8HFDNHOsvSQ?=
 =?us-ascii?Q?mxrl/UrZ+H3rs6tPVo/4DATf+itMCXxO3Kj7rweeWEeTfa7aKfA+ugCpyCPU?=
 =?us-ascii?Q?1QtHCW2lW9ISi8zaHu06nAbAVbOGMN2nD4sJ2jBfzFTD0Ksa/NnM5iF3l7O5?=
 =?us-ascii?Q?YZj5jCqkzUIFnOIOUrIqxqkj/lyaC2cedH74FBlNK/3CzC2K7azZ9X2mBBXq?=
 =?us-ascii?Q?EmqsAh/q9DhhEFnWtOkJtua/0MXKx+eaIyQ2tl4zKTvSancYKY1Ge9we6LfG?=
 =?us-ascii?Q?pIvXSCEc0/7GL5lE3vKmk4pCOO9H4xcguQqr57KcofTdQ65EgiYgKPtQNO00?=
 =?us-ascii?Q?9SwWXNTh7eygFZBlbmWZMzQx64tZd224gSCoyvUEphvKJIdmBzLTfqr00AUE?=
 =?us-ascii?Q?rH5l3CdnXeyMWPyd1iAsb27XWRsLkJuV1nXFtqyJcdZ5n68Wk4LDX1EwC2O+?=
 =?us-ascii?Q?sOMeIh7bKiKblWyaiWkhl00G4JUmVX5rhYXtPJT8ZduVs61wT7mwHbjcNu/x?=
 =?us-ascii?Q?InZ/HxFyj8vyWg76U+UvOhL1cpydSJYSYy2HoEkd+vZ54GuzIrRImaXiRQSr?=
 =?us-ascii?Q?L5kfA30ctCD6THC5HgE3Oaq2HIwgdI2Jmvgv3yfoBKcBAFw5TlJQ2DqiVC1e?=
 =?us-ascii?Q?MrqdOB+yxscwFFI76z7dWxsc/HGWKqSNyzznlc9/vTUuA8a7ZEWgrUaOG5a4?=
 =?us-ascii?Q?VdhcgRbjzjN7gN258O2TOgo3Y6bfM/5wxUxViKTT8rA/hfjulTRy1KCvai4x?=
 =?us-ascii?Q?9bgenDzJdp3tho6q+upZbJwV+zPBnssMF0zVie8xTGLDCAqjHTpN3v1PyKK1?=
 =?us-ascii?Q?+5aWxIa+jCjIeFDgyoVx5KoNojbGhs9+SN/lc14sL8FYlkKNPLDVKIGWvd+j?=
 =?us-ascii?Q?ZWefv3hoRPJgRLeC0xA1w1KeDkUwHoBALErwMfR9dNqFgBO9KOyOh1DceCV9?=
 =?us-ascii?Q?b9BjHWQMl50GfBkKV4zcgeMYlp4P3pnz1QeAHsJgSTOvYZcUVRxDg3aiUYkn?=
 =?us-ascii?Q?eljMlpythUepSBVct7NIiRzIV05q6qsvfNyFjqIzb22pyfbcJBSmwPGAvIDV?=
 =?us-ascii?Q?UyFlSyX/l/VEsksAPrj7T72uyjhLNBpbD3HpZaKz1wSuEMUojTyGLPpVKWgl?=
 =?us-ascii?Q?UKVa3QzqPYLXBcr65PCvu9PspiVJcGYEPaKNDr04tgySsqptkRQhqvRHYn77?=
 =?us-ascii?Q?Y09ESnuv6wMdORBybTR//O90abVN1r1Vea58CSZ6kVL6WoVjI3gz+O8x3LEE?=
 =?us-ascii?Q?m5bqHstYP8T9hsBqyey+BriBvy5ob1NVVRG9GGza+c4/yUP3pmkca5mDkba2?=
 =?us-ascii?Q?dmaowG8sgkoZ7E89rw/vFEYN3a3zn5lv/avouTI44mpZNrZItfvtQ+OOuClK?=
 =?us-ascii?Q?xq3amDcVqw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e0f778-edb4-476c-aa04-08de76c2cdba
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 12:13:38.2793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/OW2k0lY5K7+NIuRN4UQ8g1jQL7RD1KvLVnLhp7sqExIgIGmsgn60TfX3vzEQBbfsAJMgnUXR3uxlf12Og6BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11366
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

On Tue, Feb 17, 2026 at 05:39:01PM +0100, Heiko Schocher wrote:
>From: Lukas Stockmann <lukas.stockmann@siemens.com>
>
>gpio4.29 belongs to eth0 and not to emmc0 and is
>handled by the mainboard dts and not here in the
>cpu module dtsi.
>
>Signed-off-by: Lukas Stockmann <lukas.stockmann@siemens.com>
>Signed-off-by: Heiko Schocher <hs@nabladev.com>
>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

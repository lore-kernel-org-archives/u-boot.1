Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3922C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 07:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F78282B7C;
	Mon, 26 May 2025 09:10:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CpqWY27V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 618F282CB0; Mon, 26 May 2025 09:10:47 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86BF982B2F
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 09:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCvIUGGpL5L9fQATbatOFUN00xqI/A5dDE9zl3DU+fMlTi8aVajlfCI6yppOPKKuDr9AvJRdwaLumUel2ouT1C9VYGISNZMS/TlSacSsWqQf+3Avbg3EBQQIY8ZnwMBdACfyqVUN0rG4zMizrxE0TtgzZxn5ZMfu41UzZpanhBl5EhZn8wAiYCKQkSGyok+oPuIDHPYDQjJ5TKQNqLPl77v+XgVYPolO7uIgNDGNoypivky841DeViBtuDxzg5b6aWIAmDIr4+oYZy9YsohJw+6R6WZrn/Y0IN6zIoDs+36YUl1XCoy4OO2HVjUn3a/C44LyKQKLE0KRNf6QzTieaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZBZDchPaaI42Iri3/pRn9+J5ZEVm9/nNbkY5Rw4QVo=;
 b=dxHuWk8+jGaub5/fIQYDIKOvaqt5o2GTJGqB+kSjnX1b+UnFj5epSGJoy9r9vk/I7X/WMW+YjRub66F9f63mI7Zphz5sxSxNZbC+kq1ast9USnvQDPGZMcAcKxsAXJmVnp59KZiTGO0Rx/4G8DfvuP5mndD/SIf8QBX6ar3D0elTaMvwmpYLMr46CAM+FB38EjMKdrCIBKrfIENaduU4V1yGmFQos+1lTwcc8xlZ3NpL2ifAG3rb2f5v+qSvXCaemQ7JWCk3H8ElmrJogasHC1ayBnuk0Oh8ZtcN0eqPOgS91dDUBKM7rqT40j0o07MdS81NJU0Y9Ni8FL1tXXzwzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZBZDchPaaI42Iri3/pRn9+J5ZEVm9/nNbkY5Rw4QVo=;
 b=CpqWY27VZEUelWNLGGTc233TUnNqEi5zDWe/fOASTSFGJ7Wa/JWw99LvRSOz4g+wQf3Y/R0h0MVsUowJ1uRqaSoxYlQO0+ftsbyhQxljY+ZeMFhIkRAKon0E/no2YOvl62WwSmJ8pCPxfsRJjR3iKSm/cFF5Z+HJbfxqyXtX3zKYzUMuYs/UOOfWhyC9xXlD8M+FlC8ji2G5A4Yrndm7ejnhDXlgkKiTrXXJgb6i4NjKEfrOukQXIDOnHLrDUgYDIQHw/d3LbW8aYoDXbQ6IPBZEmf7iHW+jD/OGDWZg3JnBVLmbrRtjGvFkme1bdV6GzGfbvwfM/vEJBbD/638fmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10762.eurprd04.prod.outlook.com (2603:10a6:800:26e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Mon, 26 May
 2025 07:10:43 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 07:10:43 +0000
Date: Mon, 26 May 2025 16:20:30 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Subject: Re: [PATCH 05/13] board: venice: fix dram size for GW7901-SP486
Message-ID: <20250526082030.GK19264@nxa18884-linux>
References: <20250523172018.4164647-1-tharvey@gateworks.com>
 <20250523172018.4164647-5-tharvey@gateworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523172018.4164647-5-tharvey@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB10762:EE_
X-MS-Office365-Filtering-Correlation-Id: 758d8805-cd5b-4c19-2efc-08dd9c246e01
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LxJCO9EfsPI3vAvXCTF4gKBii1lQaWbQHY2KWQjVlXcOeZBp9bCaQGzmQiA6?=
 =?us-ascii?Q?fOc3VaT+V/yfZ5dhfHFAApcH9y3lvHvFcUitUWQBnzip+2jPpvaH8WH587S1?=
 =?us-ascii?Q?g0GcxIpu83fBwkSYCbYPKeio2TJDeI64Boe31vEQfBPkClyt+P/BHM2SDXPj?=
 =?us-ascii?Q?ok3nG3OJBLrz72Bhs4KmOJoplBIcEN1Wk+kOoVrHqcBYhUixOmzb+bi1L0pT?=
 =?us-ascii?Q?1pTHPNvqXgcxglyxPfomO4uPn+bSGLuMZQEpHoiqFcT9h9xPbdCJyv61wFSJ?=
 =?us-ascii?Q?sUlZe1K4xJB5yU9bp8f3qJ6XIISJpTIHMFyUreHG0zUMerkFQCuDwV4DGb6f?=
 =?us-ascii?Q?alehf4tpWCG60SvFtXCmjqB2O/C8MakcOnCmI+dYhFS7t9iikRN1GIqKwUoU?=
 =?us-ascii?Q?wXiLyP1LZVjqlBq22rpmDbOlMXbmYKsuIgv7TuG6CIK4/LYMt/aCr+L2fJXt?=
 =?us-ascii?Q?OmeW5YFDajZnB4IjC67T8sN2HZVxt22XfQpYj0UXkdgIOymkAuHNzyOf4FM3?=
 =?us-ascii?Q?VexPBp5tM/BjGKH5SevW4ROrz7tTe+rUbln5mSLjhEQEAE2LcBOz9CGGMS2C?=
 =?us-ascii?Q?0SE40Dh99qfVUUy2NfdGDT8tbirjBdDz+Mye5otG6YV9bcKLqCg3522eW2bb?=
 =?us-ascii?Q?3vtYh3/GE0q0VWBOfo4GeS7VKqV02XNZkJvjboq+4ZpOra/f6/xwKw4jvhfR?=
 =?us-ascii?Q?aDO37aQNam+BVOWj/iQ/38hVMnVfbR+UX8nGgLNrgNqXK31Q3Gz8qfmmxcCy?=
 =?us-ascii?Q?olXFgxLwVLEc339/cjDd3VcHQdt4ONrt6Fte0MPLoppFjItrZ/mA0JatAvKv?=
 =?us-ascii?Q?j7L15kIwk8gW1J3uB7HxvnsgPxj+J8925kRStApqaXQodKSiwusgoq0icjYN?=
 =?us-ascii?Q?FS/lKuuNrOjGZC2gxA3XQ3gvtG2qJYqCaFTWc9K2wYkm/QBhKE33VjVZmcMz?=
 =?us-ascii?Q?kmxKPfcDz18wD+rHR8z7WpoJzFxp1oU+yTvNEVzMu1ljuLA+HNNdzV0PO60E?=
 =?us-ascii?Q?P5QURgBF+z65eOsX75bPbrBBU4gwVUW4/W2sRs/u72yPfA48o9BMtQZPA4D8?=
 =?us-ascii?Q?5URuT75A32nHuxSdSaL4i7/mmc/GeVRUw+4pTCRQ9Ty6CNhkp7jI/ocEawrz?=
 =?us-ascii?Q?r5mVr8BConoR4SxbnwS9Wh4O1GT7Hlw8MfFx1jCwy8NFqh0HkrHIL5hwtM8w?=
 =?us-ascii?Q?LdokeqIxrAPWPe5h9nTqF12+2g7KMOBdgYOpCElcNrqlV6tnMGqk7Y9+YTY/?=
 =?us-ascii?Q?OG9spDWM8o/GFYRydzNK979NuydR5SEcOdHlobTQOCDfNJAdiMPoJgdRis1Z?=
 =?us-ascii?Q?dOssn6ZIBYcZazpAPWupxiEsn5JV9RueuOIq11AHAVDRVPIgyuSOILmxBFXR?=
 =?us-ascii?Q?QpPRSRp8YtSqiKqvJbRu4FPhJg/yUv7djVirSJZID1i1uQLx+Mmt8AwzzzDx?=
 =?us-ascii?Q?VvsxPCS3jxjP6kyZXEFV5IGoAPnrOM9JIbKPZcnrwlkyeeumUOPM8A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HZ9oFVK8j4NYXBEJxVvqidwBgSwK1yK1/9IUw3RIOPo0KGFuzdY9WTlDBbf8?=
 =?us-ascii?Q?R7zykGzqWYZLz+TIVgy4bFmz82vhq8A3vuIcGnD0y8QfdBWmG5mOaRmFszKL?=
 =?us-ascii?Q?QGKvgJaQYWqaSeYx7vNbFhareUhS8cAd1E1kMqnV8xRcaJDPImkzSB5nKaSN?=
 =?us-ascii?Q?oOULEcck9SCzlZ6rXIq1aye78PcS5wvjLRR/+vMyxEsZPZlW3POy3YfVAqCh?=
 =?us-ascii?Q?xRIAcWmucl00NPni7TG9coiGWVhUUMkldwLblTybQCPCnPYkH2MM3Bx/8xPC?=
 =?us-ascii?Q?X8CqjelIPnXIQ5Wgb9E+GE6HKyVWbNdQWQsCsyQVEtL0txTqUONp4pgfHKmL?=
 =?us-ascii?Q?OT3swRoQ7TCaEHVFEnnpbXnIP0S9fCxyyXIqr87/dRRxYk0Tz1YJTMLM4fSr?=
 =?us-ascii?Q?H2FtciCcAoyHsIvCK0XwDUUwh13qtg2/uXk4c2Sm6iD5uw8V7v1NJg7MEd5I?=
 =?us-ascii?Q?mVvmpoT/9gxLve/q9UP54VPIYqLq+IFCWSBc8c6FiD3RnSykhBjIpYm0UNiR?=
 =?us-ascii?Q?oyJrGaHizix0+E85tuDKq0LAOQi/N7yCDsQvsba/arVNYJBdRHfE4knbzeAG?=
 =?us-ascii?Q?oVO8/UIbdMdF6CvB2DRMoRoNppytOkKTloUkzxXs46/matJEGWcrADRgVsEO?=
 =?us-ascii?Q?UlEuh18V268C+8MSzz8XQO3YPgGGpbzVxiysFvRcYZIULoBR8rgoJYskTIYQ?=
 =?us-ascii?Q?7k/HvrXZjFTNiE2G9jwAywN8czZtk/NKsuKapBhbDQJyA76lDpKmwUmGpV2Q?=
 =?us-ascii?Q?2/SfMkzjqWgtRSI+eX6R39GxfjwaTR+CIq7g7zkZdf54kq2NG2pG9pmQKqbJ?=
 =?us-ascii?Q?bEOyznYVfx5MkZhRaKp53URmHjFAraXqSZ7gH9awUfp6GJ6cvkTFifJFYKjo?=
 =?us-ascii?Q?LLCNxhkNT5YHKQT3vUqJM5WcB1UzvpHm74fmugFbWxYTsbk/5r2gi9rAwxJE?=
 =?us-ascii?Q?+yjCkrhcjSV7IHV9gdJ+k3J9wPctFqNxYMQR/AntknElxcsy/KbSOb2u6s1R?=
 =?us-ascii?Q?qMxFS8admz5Y+NYfKQkMVodNcShjfesEjAv1GZPnBzLSBz+Bp/MxYTW3pvH3?=
 =?us-ascii?Q?d8OjXwN18oGKqHwpjFyos6zU6kNGWN2xzJyXZGpzuw0Muv8LxI2MpVb4vxii?=
 =?us-ascii?Q?VrYUingu+Lacd5ZCGzW5RNeDW/9RKiLgdp+CZahxwY4kfYVIjmeb5oZHFVYN?=
 =?us-ascii?Q?E4OhiKU08SRGK1ebUlhtOoe0Td0zp2x+0VISRzsVI8nE7rwg1ryUrWCJXK4T?=
 =?us-ascii?Q?FOaobxwwtZnkO30JcI4PXthY1YcvZW2HQxfETSmGvCnnBJ5gE7kxIdHldCPB?=
 =?us-ascii?Q?BLvDzaS48cJsL4lPnZVaFhAwzjk2rhucaH6yK0EWFWD4lnl2tJU9RpGzlxM8?=
 =?us-ascii?Q?ga5ZrTmR3M9MsgFmGHkr1TlV6W78BKDaKRwFyfTmZCNBTkvrv1CR82m84KT3?=
 =?us-ascii?Q?iuRTGm9pCy/zBy/EzyMXJDiKyjFLHlSleChUOxPOjEx6h7RbDl7O6yJSWW66?=
 =?us-ascii?Q?+jFQX3yUIYkoDoQUu82gC6V4NZGljVtSa+fWJt8hfRER48ehckWtTWg0VfZu?=
 =?us-ascii?Q?W7tXTsprF87+R6RRLDW12xXYB8GBOmBMUdbNM5VZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758d8805-cd5b-4c19-2efc-08dd9c246e01
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 07:10:43.6009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EO48tkDK6yUs2+yVO3/7Rt5jjIfmzxDiQDgyTCXPi/qw01tnKk5byEIAGmGIpLDmVugejV/PB0D8Cctv13nUBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10762
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

On Fri, May 23, 2025 at 10:20:10AM -0700, Tim Harvey wrote:
>The GW7901-SP486 with the exception of the -C revision has 2GB DRAM
>loaded but incorrectly specifies 1GB in the EEPROM. Adjust the DRAM size
>to account for this.
>
>Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

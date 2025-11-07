Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AEACCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 04:41:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8885B83D00;
	Fri,  7 Nov 2025 05:40:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LxhMXaOy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 779F283C5A; Fri,  7 Nov 2025 03:28:51 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 872F183C40
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 03:28:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJ0EHV9iMP7E1pZV+yGhE4j0GdOG3oY72JjzTdUqpveo7xkqkQjdeYnBcnFheU2I5N7ycUDmGGzw75d32cV6LbjmQVm2bUP/XGioaUNf0kWY0eEvq/zxTEZvUyFSzuo0K6uIJoU4uIRtaRB9Crr5kWQil2wRP+mXSSy+XKPa9jNNZaOu+3p/jxgCarkMSQudg97s+y5NdmvohZc9AY5BdlZ6DWxTU/ciAzwGVf0YC7D/8OMRFZwHn8nJdXKBRfn1nOyXxuAOD6jjqT3AneNP9qROq/tFVucqGbw2Tx01uwmx31amw4zB6bGNVA77p4xmysjDSrfgH2MLmk+36RsAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/taZBpwG7PIhn2VWU4sb9Djkz8ROUKA0nmFALlN+/rA=;
 b=f7ch9C3g+KmGeOsQRpI+BK1OuEPz+2DP4cc+nG6MCmVT7aU43c8BOHXZ0i08xlVXmt6jyvDVZ4sG6HxQvpwcXDxcc26y0SsOurQDtAHgZwsu53yWQ9c9sIfstXpaXmwyH3i7d7aX9hZakIE4OcJbLnbPbdJgfY08kb6Zfp2h6rQ2oILoOI/+T5qn4l0MuKbU1J++n5dbF/Sy0ni1eb55zD9fCkBj84cjNk9LAGrsUawMG0YdeWltB83ID0fUtyxhttAmQ/Vfa3nmgn8Y3FzMhOsaj0uBXbBFrOT73axjoAjxq3Dlga75Mwx08buI8J9hdAMB2LJL3RA/4vEgKvrY+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/taZBpwG7PIhn2VWU4sb9Djkz8ROUKA0nmFALlN+/rA=;
 b=LxhMXaOy4wPvHwkD6YrmLwj7o40jIgtuQuk2x2uwDaeSQnqtLxSB9ixAGnyV9R5cBZtgkVoAGuDkyegPILcAJd4KkzA5omiJkGTim0CmwOeKjwqj/0Be3OdRYcYjv/YTvNZ2OPWIvf6w1tGkkU5V99plkgwVuIYcWsEA5DG4xHVR6m2YDhBuesa64ZgcOkWGZiPv3wrjYZrh41KdxRyENpMQF6YcOwkT5ijHzjeu+mKyAn9uAL2493kS8MkPYbBeSAWHQft8kuWIC5KBSy0Nx9qK2XgyXfMMxb5tLjcIuDfnATUKCwq5pRuc3Mf33wBbHMk3e16yN0WHr9K0S7GF4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10579.eurprd04.prod.outlook.com (2603:10a6:102:48c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 02:28:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 02:28:47 +0000
Date: Fri, 7 Nov 2025 11:41:21 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Kamlesh Gurudasani <kamlesh@ti.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Maxim Kochetkov <fido_max@inbox.ru>, d-gole@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v4 1/2] clk: scmi: fix set_parent support when CCF is not
 being used
Message-ID: <aQ1qYQj7EzjEz3rG@nxa18884-linux>
References: <20251104-b4-scmi-v1-v4-0-51f101a6f8c3@ti.com>
 <20251104-b4-scmi-v1-v4-1-51f101a6f8c3@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-b4-scmi-v1-v4-1-51f101a6f8c3@ti.com>
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10579:EE_
X-MS-Office365-Filtering-Correlation-Id: c57ccec7-0619-4c27-3e2d-08de1da5618c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1dj2X+Pat5v/hZP8mU79WQIfp/LlhGidHKHGAxpV4lQgDFiZWTUaHbwn9a48?=
 =?us-ascii?Q?21JHpcVFtzUDxAkSxamumasz8NhL6xIW03BTqoGCJ7I7gvo6ekquY5QCfP0v?=
 =?us-ascii?Q?qeOMWQ+xaxSAaiqAUxeZH8vXc+rH4+5J0KemMYvlgCsMW10EqKlLo4EDwqd9?=
 =?us-ascii?Q?oalV6jhFSF7hBhMjk9B+obqe7ntI4880D5WazxKyb7OqP4vSXS4H5hbles4L?=
 =?us-ascii?Q?yUHb+lfLN/cpCjGmd+FztR1X5AzlQ1iPhLWkJjjZ+4gLmu8CnW8a9h2oIhvZ?=
 =?us-ascii?Q?NcEpwk18a2UQAfBTqncuNKtiu/h7GmADXFURwKdCCiOlkssuG5GSjIvIUMml?=
 =?us-ascii?Q?Acj9ktcChVzIEU7KuCgQre3pYEmFzpsHsdt+zyERHqbTHI07bPShZDvFLE77?=
 =?us-ascii?Q?l8X532JS/GM6jdv6KzkOUDIiGT7o2X5KF3lvT5SttRWxvl8gEDnNJ26QXo5O?=
 =?us-ascii?Q?kWGVDRlavNZ1L23YXFBZWypQ20Vt/fincraArvWsRtCTioRBS7sw76+jGEAb?=
 =?us-ascii?Q?E7OhVRwwJCHv2042LOtIsMIEsWQn08PkHOusBLS/kjzvMJ4/GvYvXX48S6SB?=
 =?us-ascii?Q?cEs8lbrbVq/ck0GCZpyc1iRPoC9meqLh2fPzh2EojXJETXB9vkVKtvzx3oKu?=
 =?us-ascii?Q?4dX+WrYY8ob+MB22EKKxgl+so4lHBDi+xwSn1F28VDL11TR4nRJYEBt7YJ89?=
 =?us-ascii?Q?LEFeN4ZWiq+hgQPun1cewW6pc+Zc8HYnSeIi5svmpPcNzF5JVJok8FiC+0bA?=
 =?us-ascii?Q?EqRDVSbIyiERs+hBrSoTXCVStSDBAfpf3KOpEDsZgt4z6D9q+20X/ZEYs2Iu?=
 =?us-ascii?Q?nqWg9b/CD7bxWtvxhdQALvUsTnjAmHTKTdI1FlRLF4zeQTf7gD9GCquNdDHZ?=
 =?us-ascii?Q?M0v0qIge6amxUIzVmctaKhsqtv/49uhv06AjG4ySxBP6J0oRBDFhVcc5hpPk?=
 =?us-ascii?Q?0AX9jSgPuLE1WWTzOHyop61eB+3bniJWRKIlh63TFlwwRK6Qc6XPj4cR4jl2?=
 =?us-ascii?Q?GYsatFiJ4xwCOgbZXCRgE9uablKtxdRK5XsToAbN1Ri9X27HsYX63vOI0jbw?=
 =?us-ascii?Q?UZloS4JjAYqH/WgXa+p4fnBv5m2uoGGuQeR3yVkF43xVSeqCMV1IEGdN2ZRa?=
 =?us-ascii?Q?zruk8taIuZKBECykhrf51gI4i1wZMxIyj5neRbPuRPqFGUckzLMNe35dNNu+?=
 =?us-ascii?Q?kWE5g5RwoI6re0R24NxZkgEJ8oEbM8E5qLfZwZHmCljiFOUnV6TL003q7XoG?=
 =?us-ascii?Q?7E3U8RDi+KhbN/RQ/blpsRAlpuJu/atuKt5+SWnWw7qAKQtNIfOCfICayi/e?=
 =?us-ascii?Q?kQ32pGGNtwOaat+v6sdTMe++WdgmrTdkrfIdU23IUv6kXJoRV+CC37Ji8wK8?=
 =?us-ascii?Q?L1+9euhO2DXriekmLwdp6oLTwnYBR3R7HJ+l4M1fgISaGRqbAdujhPjpmKeT?=
 =?us-ascii?Q?0EDDJdX/vnKt7VeDtixV66HCeKB3iE+AgX5VBDqqN7D6is0dt0/XyA396FAZ?=
 =?us-ascii?Q?VLOOp60UP17TqSH1RixnaTETnitNY2V2vnWL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uZuasLZMW1zPkYLz+YSdNKMli4eq4ikeMHt5azGIQwh63xeqvoKBrYU18qTt?=
 =?us-ascii?Q?ug0i3EjrrCieSG5z6aPdZ3Jj0fiv9Adk7exgidsFbjFHxlz8WJp6fVEgE53K?=
 =?us-ascii?Q?PAKn2WaigFwZE7MHvYqZOBYPKcuwz3GJR5EKaUHlznbhGp6YdueRicjH1wcd?=
 =?us-ascii?Q?XO00mdNu7RPjaPqOr08UJTu6M/yFTosSULEzsv/gkWn4YLYvcVn1nWyaDL7J?=
 =?us-ascii?Q?dVz2msZs3SgThyVeta52+c5WRnbqwnWDZnWq279sUjUydfQQ1TRB1Em0HtaT?=
 =?us-ascii?Q?N9o0/zUNhGfKPuhGjZBJphjcD3Bcqn+o4PLd8sUHjg8ahurWCPq2M2XZLA2u?=
 =?us-ascii?Q?V33E8T64trgCP7DMS+qgN/S7g+BSwezjHt3uq7AYkycz8AHYcqT4h51Ze22L?=
 =?us-ascii?Q?YhorE+rTjYrdYn9Vcb4pHJk1xetYaw5pEZuw7AsAYn6e30t4j3w/0E/RrqhG?=
 =?us-ascii?Q?B3kQeE1iEfM0WlVMiB0IZQ6U/2Ss3N55pVb6NyYuQJzarHa8t8UlTmpkM36o?=
 =?us-ascii?Q?mch0+wJjEF1hRLppjrCpu68sRxlY47BCFkv/Qpl2JNPqFXlIIn+uF18t3yOU?=
 =?us-ascii?Q?MUvH1AouUWdIzB6cJ74HZiGdgBmTZBjbU+nrC4ZguzGjBFuRr7NJXnirpkI5?=
 =?us-ascii?Q?h0uz+lRv0mfWSb091AAp+oJ0ejb9sewsjboyGBGxBuIcqUupQGwhJOqxe7KQ?=
 =?us-ascii?Q?SWJ+h1+KkpsKpHEyy5Y/1IVa4lf2bJhx8/yUCYfLFpCMXdVxhe38i3YMtWJg?=
 =?us-ascii?Q?/n7UMWFLcDKbVfQN/L4A96QXJ85DorqHFmNE9uFi6kuu/vzRN1s5mN7f5MPU?=
 =?us-ascii?Q?ionrO+OZTIXgFHTgoeUZl9QHkLwwkcSxtG8wj2yElGngZUhbAvZeZeA366lf?=
 =?us-ascii?Q?35g0cuDRkp4d9zRHZzPHCrOS5Hfm+498e8FUzEOFQLsUjsCjOn4XNLTFcT1d?=
 =?us-ascii?Q?S4qt0iltE3t5whRN5nQqXwTIWsG/Qm/p2hEvXorkC9J7M/7CDZ+xR1lSRdZy?=
 =?us-ascii?Q?/BsjKL5JOaSN3EjlSx6fMWMGJVLDUWXXCxMny3IbfKKx7k1H8+PHNEL92d5u?=
 =?us-ascii?Q?KFUfKZGWpfuEhWYqrsS3czc8/Sook5VYqoAJqoXhVUthiX07DvghiylG8mO1?=
 =?us-ascii?Q?Mz5RuNZBWsE+8SxkPLPzPEcGwq1BLfhygT+9z5liyQua6/dT7fD0/wEPIrUO?=
 =?us-ascii?Q?BS/i3DrUw9RH85rCSKf7m/PecO5p/htKYUccjs4tdkZxNOtQby4B58khMCEq?=
 =?us-ascii?Q?hClOGSUDquYuB79iw+moHuxgglx+SC8Sxv4rFOQSGrk7+O2+jOkVCasUZoK0?=
 =?us-ascii?Q?ikyR46wE7cNbcDLFz/CI7FuuQXm1DWWCGWjolxJS2ZQssmdZDqrlgSvnkcmb?=
 =?us-ascii?Q?NPGefgsFS8Y5slqyUJJfCFXf5cs2N20UUIB2zYKMBvx4nQ/Yews8/skk/oSU?=
 =?us-ascii?Q?EsB0aa6wZbYQKthV6gEJ5Y0wZnYsaRiWk02cji2TXdCWXfQHdQS8315GG9wL?=
 =?us-ascii?Q?q00rVd10/bzPWbMvIuCU2mfNbE2JY8gSumPPFC5so6oOTSiNvU/wQ8MtQ4KE?=
 =?us-ascii?Q?WgPZNbFLzcFtE+D6VVIGbbHqSzkitAb5KqgcGvx1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c57ccec7-0619-4c27-3e2d-08de1da5618c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 02:28:47.8684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EO1riqO6/bsrA+XZY21oJLWJZDuOH2TTDvqVrmK04gvez69lmsVWECCBWVQdTguBBM3/KP31DXSZwaFkH98J2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10579
X-Mailman-Approved-At: Fri, 07 Nov 2025 05:40:31 +0100
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

On Tue, Nov 04, 2025 at 04:49:30PM +0530, Kamlesh Gurudasani wrote:
>When not using Common clock framework(CCF), calls to
>scmi_clk_set_parent returns -ENOTSUPP, which should not be the case.
>Fix that.
>
>Fixes: 15fdfef6642c ("clk: scmi: check the clock state/parent/rate
>control permissions)
>
>Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>

Applied to fsl-qoirq/next!

Please only send patch 2 next time.

Thanks,
Peng

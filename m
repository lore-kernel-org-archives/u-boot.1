Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0663EE8FDA2
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 14:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C221283936;
	Fri, 26 Dec 2025 15:28:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YFTv7Ogr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E51C83946; Fri, 26 Dec 2025 15:28:51 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 195BA8392C
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 15:28:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSJ1r4AIb7VXnOsblwsgSINcWm9PrAj2CcJV9Z/lEvvR1ZernURqB4/J4smBvKxT3Zqnq8ucdZY/JiodaerdSnaGuiZqA3wGJwkzetNhrwND73Ap4wB8hsMPjYxbgmrokEHsu/goINppLcyc1iSbs8WtcVAmd8hH6p1jQZviYSz0lmNASLoKN+aoadNxY3MjyM0fAwUGGQcqL/LgnJE9U3B0BQHkJ0ilIb73/lmza5O4oJp5dYvjLj8nt0rnz+hG9Xc/MsW9ivYEg39n+VTbUI2Qre3A1BWV5sVLHhdczVq7WiRdLJqyOfwSDtMPJIJAlV9NMDXodROzGqIJRnWLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1xG9GN0lzy3t8r/XAX8PGVnNHMX1x4G3tcLZrRDrBs=;
 b=m/tUmxH18s2V63upy/q1ABdTcX5bPhXnozb8OsdGXMinpCD3esTset2q/EWH6V5YLVzDhyN+Qt2qn0F5VOeiPKT8POe/I5iDG6PFd/NQq816rx4M7CFFZVT8DUdbQv38N6hSS6OEPJaZjTya9nf2S23j90F+wXdZB/obcb3IXEYHmJ6qDZ+RjEHQd0ln7199/Zaw2O/vFQcKFMIe+m+EomKRq9a03UXYP7DTNSo09Kb3fwN3vZFHPT8xdwUunTvfAbnZL/kX84ygNYzyIEWQgC5bghL/DJ9IGm7y757m1SOLP+NQxzE53wMPtJOAKQGKqKNWesL8FxTeMhaUHtZM4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1xG9GN0lzy3t8r/XAX8PGVnNHMX1x4G3tcLZrRDrBs=;
 b=YFTv7OgrmkvArfy15f40/9AdIUnPTylxzHT68+xA8rgf1wxLMglM9pWSrNMfUjqX9c9RPsbs7AB1LzWhD6VSF2hf2XvUafqSU0MW0fQb4Ox0qBDsBWBqQHVY3gqZh4hPNo8cGoCOOhz4ysh8I32I6MpGyeXltZD74jIMaM2BFK0GFoXeQmLElF2kwCVvQ16xXQbB3/VicFBHNJ01YCDsUKwAPr2Q8WRLIeJa6qbfawLcTn0fet7i+3Yhs93S5v2lpf+ufoqSXLHUuVCGUQh+TzbOX/gQYARlWyoESlqN6P2BeI/qWJHs9z5BFnWiu1JiFiyEBh+lqcbUbUiAq1YLpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB7033.eurprd04.prod.outlook.com (2603:10a6:10:125::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Fri, 26 Dec
 2025 14:28:46 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9456.008; Fri, 26 Dec 2025
 14:28:46 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH v2 0/4] Enable XSPI1 on i.MX943 EVK board
Date: Fri, 26 Dec 2025 22:27:39 +0800
Message-Id: <20251226-xspi-v1-0-4bb116750dba@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFubTmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIyMz3YrigkxdAwNDI+MkMwtzS0NTJaDSgqLUtMwKsDHRSmVGSrG1tQC
 FgW4dWgAAAA==
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>, 
 Alexander Dahl <ada@thorsis.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB8PR04MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e0f092-f891-44e8-0046-08de448b13ea
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0I5cUdoT3VjOGpneHA4SXBoY3NNaElJNUw1MGMzTHQzM0dBVUpuN2J3SSth?=
 =?utf-8?B?RFYraFh5QmJlSnpxbWFQOGRxYTdLaDFGd3RsUit3ZjJNSVB1S0dXTWp6Wjlu?=
 =?utf-8?B?bWlaa0tMejRTTXgxMFRteGR2Zm5Wb3BYR2lpQnVrcHRXcXJhVWFUZXNWczNC?=
 =?utf-8?B?dFZtTHd1VmhLZXdFNWl4T3J5SjM2WDlSTWxRRVMrNTgvNzJEV3lsK2lZQjUx?=
 =?utf-8?B?NzNwaktrS3dvaUt1TVRaWksvQlR1MU1ReExla2ppY1ErSHhWMk5NOXBXTDhj?=
 =?utf-8?B?dm4wZEhpaHM5bHNFYkdVU2JYL3V5VGdWbG5qdWlMNGpOVWpodzNjRXJKL3dB?=
 =?utf-8?B?bkxHUGsvMXJGeEZBVndHYnVvMWNDOVU1UjdRT2ZGVWxxZUh6bmNSekdRM3pE?=
 =?utf-8?B?QkkvME1oS080QjBXUlFUaHozUkdmTDJGRzc5RXRuaFpaWFZVeDBOb0ZLZGRj?=
 =?utf-8?B?UkJ1ejY1QjJ3SnpBQXNFK2FZZ3VOc0NKTmF1TG4weWJQNTkzYkg4cHdWckxw?=
 =?utf-8?B?VlVHUGhIZ0VaczJENXNlZU56dGtHbnNHV0RoQjlJRVdOeVdjcDBkeHJTZlY2?=
 =?utf-8?B?RkJwTFdKSFpQeHZDTElIOUcxZHBzZ2lJZkVUamtWU1pwVmNYUVRuRVRjaE80?=
 =?utf-8?B?UVJMZWxRZjVYcHRacWZCcEM2MVZNY1g4dzU5TkRicFg4b3F0UzlaNjF0dzc1?=
 =?utf-8?B?WExGM3JTNldWeHVQOThrWWZ1RktDL1F0ZVFvMzQ5TGtOKzBSWXUxdlJQVFJ4?=
 =?utf-8?B?MVBjc2g4VEhXY25kVXJCSXlxdVJKSTNFNDlzSEhuaVg4dDk3dEJnbEsvYUww?=
 =?utf-8?B?a2NUN3dMYzRQdzlYYXlYY1dFK3N2cktRdFRuaWdHRURRb05La2dmb1FFRThY?=
 =?utf-8?B?VjQvcUxubHBJdFF5SUxqdXhSaGtNbHRvb0hISU96TVBSTGdPa3FEL1A4SG5U?=
 =?utf-8?B?WDVpZE9yMHVQOHhFaGROajNEcG5HMnVGelBXeFA5VW1OS29CcEg0UXB1bjhI?=
 =?utf-8?B?Z2N5b1lpazlCcTJNQndKbWNBRFFqZC9IcWV1RHVxc094b29OQVRXOGlZd1Av?=
 =?utf-8?B?K1RwakpLazRUMVJsVU9HV3ZZTkJ6UTJtZ21XdlF4c2xQTFRCbWJidFExRWVw?=
 =?utf-8?B?THRJd0JVYVRCUzVTSkJWS0tTa3VqeGpxLzhWSTNVVmRIell6Q1Arams1NUJm?=
 =?utf-8?B?dW9XdFhZaTNSNzVBZjFUZStCRSszdnlNOEZ4UjcwNXVBWW1HSnkxVnRtZk1Z?=
 =?utf-8?B?d3ZMbzRiZHlCYXFzMlpZcWRiODFGT2hwL3B3YlZnZmxWd1FUL285WjNDL3pI?=
 =?utf-8?B?bm9xbFpzVHNhNDhFWnI5anJ4OFk1RXFIeXEzT0NvSzk0bytFM1pnUzlUeEVV?=
 =?utf-8?B?ZEdFNStvanZyNHlZbEFIOEU1bFlUT0hHZVMzSjh6NGZqd2EzM2gwK1hzdSt2?=
 =?utf-8?B?RGV3SUh5TXVhcWZhR09XV3E4dndjWStvQWp4cUNmMHowQlg4UW9rUVh6QXM0?=
 =?utf-8?B?ZHMwZHVvTU9tdEM4a0lwUlNGZkExTWVFMWN1U3dzWStzK2NlZ0pPVkN3WThX?=
 =?utf-8?B?UDFRT3ppdkFsNWh1V2EyMm43U2VYOVFqelk4M3c2am5hT1lUSm5pSEEzTGp1?=
 =?utf-8?B?Q09qTE1KdVFoaGUyK1I2b0l4d1grRzNjK2oya0NqNGZ3NG96MFRlMDUycjJC?=
 =?utf-8?B?ZXdJdGhRTmFCbVlkc2lhczBtNmFIZDlha1pJRi93OVVuTUlBa1NxNUhISkNu?=
 =?utf-8?B?cy9LSDI5YW5ISDJ1ZXEyYjlEVVZOZldGRXkrOXZyUEx1VnpNeFNjOWh6cEty?=
 =?utf-8?B?dGlIbDVMOStVYTZZczFMbGlDZ011bjFtMjkrK29pZ3IxZHkrYlVxQ3BJc3Jz?=
 =?utf-8?B?dXprQ2QwVWVZR1p6L0FuSjJvZW5xbmdjckVBRGEzcEhqT1htcEp1dWdJcFNE?=
 =?utf-8?B?RTZlY2xaMFlxTlc5dUV0OEJmaisybFlhOFFGekw2SWN6a2x2ZkpXakRkb2hZ?=
 =?utf-8?B?bkJheFlVL2Y1Tkc3Q0VMRnV5YTN2OXRFVlhSRjlBNll0dG56UytOWldtU042?=
 =?utf-8?Q?sGakgZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(19092799006)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWQyT3BSaWpCcDBjUU9ncmhoNWRIdmprTnRjK29xNTczMUZhQUF2SnVRWnox?=
 =?utf-8?B?UWpLTzBJbFBrTWI3L3dvTjJaL3A5S3hGSTJGbTZ5Tk9seVpnK3hvNmxMRWlt?=
 =?utf-8?B?VVdDMUFnYnF3VytKc0xzWGFNZlNSRTF5NVJzN0JmbTZ4YkF1aWF2cXJ1anJD?=
 =?utf-8?B?SE9OWDZZUEd2Y3d1ZmQwOWxMeEs0aWtBWHdpNUJzOWRHRmRrVUVFekxNYStK?=
 =?utf-8?B?SXMrR3lTRGhyWmorcHZOMnp0ZnZRdUtPc0lIL1MvcjBlSUNuZUZvbU9xamdI?=
 =?utf-8?B?RTBZSjc5dTFZOFJseXNvUjlXYmNKRFdUMWtrb2JqTGFGREZ6elhyR2lObFJw?=
 =?utf-8?B?Y2pIbTVZQ2FpMUtzcmpJUWs2WHdlYUhSdUF5VThHbUxBK1hINUwyM21sNlBR?=
 =?utf-8?B?T044ejVudmNlSGJ5NkFpcjY3c0xJS1JvVG1RMy95YkpBYXJLV2ZLK1RQQnpY?=
 =?utf-8?B?aTR5ZGRFZHRpWWtBZ1FMcktnM3krTm0yNDlGNHJOWXN6cHpoMTlpdFpHbmp0?=
 =?utf-8?B?UGlmOEIwQkUyNzhEZ2h2TE5pdjQ4M0lGcFMzQlhObk5aSEt3SXF0bEJrdFF1?=
 =?utf-8?B?RGg1QVVZOFVxekFiRGl0VkxiTUV5b3BjNFExeWdvRmdvczZkQVRoSklZZC9W?=
 =?utf-8?B?c2V0NTdaUUhXWnBXZXFIakdNU09vbnRmK0wza2hhR3MzTE9mcU5WK3hmSC9C?=
 =?utf-8?B?U2pDQ1JtSEtNUlhhd1R6Uy80MDVDby9qM0habkk5MDJqOXROOVpVdzVBQUZT?=
 =?utf-8?B?SDJSWENZY3ZSTndWUzNwZ3Era1NPYzR3dHd5YUMxOXlWeTc2S09JSTBnMkx0?=
 =?utf-8?B?Y3dicURLYWlneGsra1gza1h5K0k5Sk1aSncvelFrRVA4dmZSRk94NzFEMVQ3?=
 =?utf-8?B?cUdPVFNpRHd2TDdUVVhsRzBGVUhOS3RUaSsvUVJlY1JoSWxvNExkSWVoaklT?=
 =?utf-8?B?aHh1dXlsdnZZbVMwVlJmNDRGQ1BJTWlmandLY0FuVjZnWldvdE9aZ3FWZEM1?=
 =?utf-8?B?cCtmOTF0UXQxK2RLZ1pRblJNTXdpWFJCM2xCemxZV0puMnB1OVhaek1pMzJU?=
 =?utf-8?B?TDdZN1lpc1NNZy9xNk5JWDQwQWZ5MnBScVJZM1IySVZUMGlKUnl1bWdiamJT?=
 =?utf-8?B?YnNxVUNET2EyREU5dEJsZm4wenp5ZlhJeElaeDlPOG5vRVo3QlNnUG56Rm9M?=
 =?utf-8?B?N2tMQVVmMjhaeXp0Y1ZwYXdTcG1wNUVrUU1LM1V0VmZsUkxOTi9lV1pKV1g3?=
 =?utf-8?B?czZKYkNDSkIrR21ER0JtMEw1WFlMTjRmU3J6SFZUU3JVUEoyYjRiUUpyWldW?=
 =?utf-8?B?c0hsdWROMFlrZ2hKMWQyVGR1cXJwOEt0eGUrWk9GZWZDdzNsMldIK3VtYnV3?=
 =?utf-8?B?M2F0dGswNFlMa3lZRjgxK0xKeGxmem9VWjR5RXVadEJ6NWhXcHlPaFE0aHh4?=
 =?utf-8?B?eWxaRXRZTElBN1dMSkMwajk3QXFJblJXOUdMaU5YcUduR05WcFV1d0VaSUdL?=
 =?utf-8?B?WDk2b2VPV0ZONzR5SkxlSnd6WGp5VGFUK3FqOEd4cHlYRzlrSFFteGFhT05Z?=
 =?utf-8?B?SEQ0NlRDY0JhMmxIVVJ6b0swbTIybUJ2TkJqUlpBSU0vcmUxNHF1ck9USVJ1?=
 =?utf-8?B?bkd1WGRBRWwwYlh3ek5aN083RnBZZUE3UDg1S2s3VGpPTm1xbDIxUEE3SjA5?=
 =?utf-8?B?WlV3RXl1WDVrbzU4UHIvSFN0cnVtY1c4UzB1Q21rS0QzY3RPUXN0Sm5FSWt0?=
 =?utf-8?B?V1NNa2pTbU4waFI3VHRrMjRpOXIrRTNCM1NHQklUU2hTK3c3SmNmdndpNXk1?=
 =?utf-8?B?T0Q4c3NVVFdvOUkzZXg2NlQyeXJ1ZjZoL2NTWUdSOGY3VkY2bXdMOWMxRVJv?=
 =?utf-8?B?dThjMlRWeW5JTUVJWFpyZlVEK1dnNHR0YklxU1Baa3lFSmhSTGRueXpoSEVZ?=
 =?utf-8?B?ZTBkNklCRk1na0kwcUExbWNRa0U2S1NkREpySm1OMlRzdTAyWk03V2R6K3g4?=
 =?utf-8?B?RklqUEZxWjlUTm1sNWxCcy9tdHNkeEo3dXFPTjlmV095eG5QSWZ0LzZyZ1VV?=
 =?utf-8?B?MCtGRE9QTjd4NzZ5a0ZPWVlhU0NlalBGVDNyQXVIZUc5S1hqd3UyZ3JGVzFh?=
 =?utf-8?B?N05sSGdrdng4YzB5NW04R0x3M1B4L1F4Uzk1TzVuSWYwakpDc1NGNjlaaFA1?=
 =?utf-8?B?L1JGUGNRN3d5MmxPVXRMMm1HL01sWTBreTdmVnpKZXl5TjJ5RTRJR0FmQ2U2?=
 =?utf-8?B?allDTWQ5dFhndGsxQnRMTWg5VU1HMml6NTRJd3BHUlorR1pnd3czUXF0WlBG?=
 =?utf-8?B?OUMvakI4SlJUTGZZa21BVm04WGI2WElNeDd0NU5TRmRJWGF3aGdYZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e0f092-f891-44e8-0046-08de448b13ea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2025 14:28:46.2096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bljjxoj626pYBbMEM5j/KuVRFPUSB7g+nnCQ4yotUn7ui54zgGptXX4VBaG9KfqMxFQdH6nR1dK0t6OcYfkK8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7033
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

Changes for v1:
 - Add support for XSPI1 on i.MX943 EVK board

Changes for v2:
 - Remove the big-endian related code
 - Change compatible to "nxp,imx94-xspi"

CI: https://github.com/u-boot/u-boot/pull/846/checks
link to the upstream submission:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/spi/spi-cadence-xspi.c?h=next-20251219

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (2):
      spi: nxp_xspi: Add new driver for NXP XSPI controller
      imx943_evk: Enable XSPI1

Ye Li (2):
      misc: ele_api: Add support for XSPI SET GMID command
      imx94_evk: Get ownership of XSPI control registers protected by GMID in SPL

 MAINTAINERS                             |   1 +
 arch/arm/dts/imx943-evk-u-boot.dtsi     |  34 ++
 arch/arm/dts/imx943-u-boot.dtsi         |  16 +
 arch/arm/include/asm/mach-imx/ele_api.h |   2 +
 board/freescale/imx94_evk/spl.c         |  12 +
 configs/imx943_evk_defconfig            |   9 +
 drivers/misc/imx_ele/ele_api.c          |  28 +
 drivers/spi/Kconfig                     |   7 +
 drivers/spi/Makefile                    |   1 +
 drivers/spi/nxp_xspi.c                  | 881 ++++++++++++++++++++++++++++++++
 drivers/spi/nxp_xspi.h                  | 705 +++++++++++++++++++++++++
 11 files changed, 1696 insertions(+)
---
base-commit: 56cac250b0839ddbad1311d3ca4231f532b5aadf
change-id: 20251226-xspi-00123b687915

Best regards,
-- 
Alice Guo <alice.guo@nxp.com>


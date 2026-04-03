Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5013AE7E36D
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 11:01:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 987A083642;
	Fri,  3 Apr 2026 13:01:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="l3NOjerA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C5058382A; Fri,  3 Apr 2026 13:01:49 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75EEF8341A
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 13:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K77LIaiC+tCEoR/5ZTCMHKvKm+V2czbl17+ScUpPEYjci1ehxOR5DTedGiJwgn8XWT/udwG99GNKxVqRNn8ZUuu3IjAtlQM270NiUEy9e/d9+RiNKpKHZFGaHzzrs7v6CgkcVDvqP8apVBWv3EZxtxyAk4nv/M0JSjeZt9TD0US++PrI07LVWr6onAtm33761PiIr58fRtpZda8J8pn0/s9lOA2L0jKHqQEbTzrN0l3bLz+19WvWpgoGFTk6rws4+qwfzFs8Y6X1qhJyVny8tKegw9P+v6h5Qat4NQ4aMEMi1/zNVBMu2jlHRrOunCPzyvuWz+Y3A7qmurMrVHMIiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Su8X8EZOTKuxhuEAmxLsJkd/akO3maxVMEDuz76vpe0=;
 b=jfbk0t7QH25/Wqvib9CF9HVLquvEv+IZuhI30QszlcsgDYABe5gX6meVr50ylsm/zG/14eDETMcpZuW/hNWg72L6dSjciASs19bGsSMha2IKfwJY5nXQ/nnv8p2fF0hA4Z/CU0JyDqISzLDFP1+m7bLK19zNrxW2xMWP/aqybIkfMjjqJ7tXqWgOnwiRnKUloNtPumH7F3NbRHbq8OpGmBNtRYFInUCCG8TviNveXteLLhuDhNW7khN3LCWEGutpIsMTPYkTog8odjnzdDXAchGjvAnc/AJrW9C+a9C8SFy55zSJUxddOe7tiNrr5Iu8FX39frM43K8HzadYffLo9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Su8X8EZOTKuxhuEAmxLsJkd/akO3maxVMEDuz76vpe0=;
 b=l3NOjerAvXycP4qbXmlMxXqjy2uajNC84D66RAFxqCbQUeSkRNrubs8d8VQ/e45isg9jE+TcAjkGb8eLgzPsUjB2tTn3injDKhKQLrBt2djDstdugKD14y0mzpl6r3HLKFvsY4BRLCR20iT70Fsp5ZyGclDSZjjzHiNr9ECO/vrw5dX6FI3CYvx6cIqPlHf2NPFIkSdIZaaK1yv709a70bv5of4jQMAyPPZzq3TqMBhoSODMM5LYHCm33hxVL0H+WpE77E1epkhAV6S0iNabrdOZosvtXDCxFiCw6VsPaQ0Rn/mm2c5WTjUD93kgsQ0kBYnY/CRwEK9vZO0UiC7ECg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7766.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Fri, 3 Apr
 2026 11:01:44 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 11:01:44 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH 0/3] Enable ENETC on i.MX952 EVK
Date: Fri, 03 Apr 2026 17:41:25 +0800
Message-Id: <20260403-enetc-v1-0-e42ae28ae3fe@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEWLz2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwNj3dS81JJk3SSjFAuDNBOjpEQjYyWg2oKi1LTMCrA50UplhkqxtbU
 ASfbfFlsAAAA=
To: Marek Vasut <marex@nabladev.com>, Tim Harvey <tharvey@gateworks.com>, 
 Ye Li <ye.li@nxp.com>, u-boot@lists.denx.de, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Thomas Schaefer <thomas.schaefer@kontron.com>, 
 Michael Walle <mwalle@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>, 
 Heiko Thiery <heiko.thiery@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR03CA0093.apcprd03.prod.outlook.com
 (2603:1096:4:7c::21) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: 0575125d-8ef6-451c-0d24-08de9170645f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|7416014|376014|52116014|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Z9nowdpDliDgd/dbSnyXfZYBZTQFtAgmH9L2pygN2w96WAOHouwKBry1Q5NlSUMinXOBl/oTqY5T76ZBrlIEVbMvJh9tfWiLaZgUN/FZ/+dOzvvIbvGu7RKEUO+OY8rvk9f44NXct9BE78IBAFxbbwtoZkPmfOnjDLBBkwABPvCipszcmZhIBwNfXvYHgZpND2qqJCRxNmpIF+FJVA+0Xj5KxhVjQwwTFyqwvc8KjI0k9XksgLVMyDiFPXhtGC1c1r3fDGOxUybtNIZxJDe3Me3fzYiCdH9OXVkD+nQYlomI5RHq2djF3hf5wLKFw4I/5EhaekV3nSNIJfpuF7dKzJIJHjXxn1jnaTdABS3HCuBceq00aBurcMKlx7UCSCmQjq62hbrVwA8IWnxDMpO0G05r7TjI7ZY04xKfbTRMRRJ7gFQBwv/SYjHd4fvqdwjhEP9HfxaGTOp/KDoWnL3hydNevu+jF937fnhju5m+87IpNMVapRsIeYACDTEmCymbgUHcTAwAXMuIzmqBNKW4uXfTIf+o9otZGQbKNVZWo+63KD2YILCAHSeSW/Q8P1f5GYlkdgF7YirhOi1e3AKH6uaeCLlRWiGg9kBYgMTubi35pMIpGWcK9CKS6mUH9+MbFaQ+5sQZ95own1gcGSZXZAcFOnTHPM/AxFddmFZeler8pSGIYJKxY7VEe4nM0eWXpW4vEY6PS+GfyWTsOFXsv6ibB48OWL6qf3VJdmFhl1VQ8A0K+fWOCrNabES80lK4NRVgCZAgdlI7yBKHPVNUoal4hl8GP4WZYw+y14kx3Is=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(52116014)(38350700014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THRZWXhJK08yaXJBNUVXNW1SSmxqS1JCVkRidUJnbTdvaFBZdnVkbTlzaWQz?=
 =?utf-8?B?d3U4UnFFNStPQW9PTDZuaUdkeXBMVG5vNy9MSGt4cFdmb1lrem9TeFVUM2xI?=
 =?utf-8?B?VUdmdTlnNytwbmlzeHh2ZktLRVlWdXErNWxzN1plRmNpbStUaE4wTW5GSFdi?=
 =?utf-8?B?eitKSXd1cFV0eko0UXdqMWlVNXZLZzdUR3hSQ3NKR3A4cmdGV052WHRLTFFj?=
 =?utf-8?B?YVFSK1haR1lMUFY1ZHhFK0lCdC9MZHFIbFl5bUhZSFdBdTFTOGt5UFFPZHM0?=
 =?utf-8?B?U1ROUjJMNGdlK3FxT0QwcGtpZDRCOE9Pc1Roc1ZQNXZtdUEvZ1NpMjFQOGhj?=
 =?utf-8?B?cE1WQmViYU1sQW5aY2g2RHh6QjJRVXR6OGVIbjEvYy9uSThqWFl0dFpXYXVz?=
 =?utf-8?B?cWl3L2pkTnBCck5hTmRudUh5QjNWekN6QzU4QXpnL2tVbnlEc29KZGtkdmdv?=
 =?utf-8?B?Y2c4UE1jdjNOYm5VaUQ3eTJZeTRBZVlWOUNOZnFhZzV4SmN4TEx3REkrNnls?=
 =?utf-8?B?Q2RhejJzcTc2RWtRVnVIOW5Jd2c5TzZRUEZYZ2tBNmhNaG12U0VvQVVkS3hP?=
 =?utf-8?B?THpYajNnU2JDRWZ3SEZzTk5jOGQ2c1Q3YkVHM0lOcDdJMDhTTWcxV0pLcVll?=
 =?utf-8?B?YXpmKzNBdDc0WEl2MFVtYzBNS0ZINjl0RHNSMzl4S1JwNWdZMTg1K3p2aDF2?=
 =?utf-8?B?Z3N0blJTN2dzeUpJTGdETFFsNGxYczFQaVErRlBxS1NKUGtYaUcwa1Bjdy9u?=
 =?utf-8?B?OTNkTCtSbkcvb2Y1ME1Zc0U1YWpBQW5XS0QwZ3Jya0xlSkE0U1A2UFQ0T3RH?=
 =?utf-8?B?d0cxcEFqb1ZYM04zbzIvNVdLNnhGNitTUjJ4MVVUcEZvRXFwMER2aUQyMnYr?=
 =?utf-8?B?QW9jc2tDRW9XZVVhclhxaDIyY1lNUmR2OUY2THFFUHUya000VWJOc3Bidzds?=
 =?utf-8?B?VllPazFMK0lYKzhWK0RNL3BMY3ZVdE1ZODhtRGFUVVB1L0pEbmZTUmpUcHB5?=
 =?utf-8?B?QU95WERuWmdNRTBVSm9BNjVtU3RaNVRuNkJVK2I3Y1lIQWRBS2FYRGtzdSs2?=
 =?utf-8?B?dHIvMjZKdUlUTE1JRFFPc01YT20vU2xqakZVdndYTjVjNUdjS1BtMnUyZUl4?=
 =?utf-8?B?eXNUdEJ6aytYeHFQVGprYk4xWDhUamdrT3FtME9kSHhjUFlNNXF1c3lJQk5a?=
 =?utf-8?B?b2xsK0c5dGlSNU9NVjBsVXpiajBSRlJKS0pYa0JWVE1SR3dWQjFFcVM0ZmxR?=
 =?utf-8?B?L3hVbGxBWmlRSHR3clQ0amRpZ01uMytGZVpVMnFpNTkrZms1OWM3Z0p4cEVN?=
 =?utf-8?B?b2pmSTI5NCtmaDZvam10ZzNRMXhYRFpaT1pWUHRUeTJUNExrZmFjMnQ2cjFC?=
 =?utf-8?B?cHpUMjhJT2JEQ1BhbGt0NmdlenN2MktrMisxcHJQUzNBT1VDczh6NkJGRFdp?=
 =?utf-8?B?TmhHb25LL01BVEZWcldaZE8vWVI5QVBPTEJLUzN1KzFqT1cyeFZxTUFEakhl?=
 =?utf-8?B?a0RoQ2hMQzI4SDVVSkpPZzJiRjJWODFZMkhvUU51TjUyWS9sNnlWZkJTYUJF?=
 =?utf-8?B?bnZiODRMRE1paDAxWnZLTitjbnpFY2d5UXRROFQrZzc0SnFGbzZKRGxBdEV4?=
 =?utf-8?B?OGVoYWhTTEJmQVFiYWhwYUpnOW93dUdsWmVlSWxoak9DWEZZSGljelNTZDlF?=
 =?utf-8?B?Qm1iTUNJbHR3ZFpYNjJVMEJvekN3THQvQTE5bVNCRlZ4eStCK1RMYTJDVkNi?=
 =?utf-8?B?eEhCVFlpd2JnendVK2ZOVHRhQUtjVXc2WG1LL3RKdzJWK3hEQ01FSjVzdUht?=
 =?utf-8?B?amNWNFlaQlc5MlVkUEhmUjkvUTEzN2pJcDFOK0R6cWFqcm9mMng2UllpSVpO?=
 =?utf-8?B?cTdYd2JqS3BFalpQMXV4TStxL09tWDFwMldTYVpRcnNtcDVSV3hxYlhLNHA0?=
 =?utf-8?B?YXdVK1B6YzJyaEJBTUN0d0ZRejVQK3BSVngvWlViQmRyRllKTTFDK0hnLzVv?=
 =?utf-8?B?d1V5bHhjMW0vMTZ3d0duRlBmQWNyZlJSbmxVdytNWEhzaEw3R0JjZ0xDU2NB?=
 =?utf-8?B?MlQwakR4V2ZueFJ6UEwyRmtBY0Z5L2Z0OUJNZWRwVTVBek9NSnpXYXZqbmZn?=
 =?utf-8?B?YmJ6Z0g2bUJZUkIyNWpNNnVENmZJcE05N0xiRlYwN1hYdUdaSFNKSTM0djBE?=
 =?utf-8?B?YUtsbVVyR05nUjVnOXBSS0dIc3NReEtXK0lGVkpDMlkyUFptN1Exc3lWUG9F?=
 =?utf-8?B?WU9IZFVEZUZUNVNiYXJoTnF1QXF3NzBCek83b3Y3eEN0ZnFoNTNoR0hHUmRu?=
 =?utf-8?B?bytYME1oZ2tXektyVmoxdWdpSzJsV3BQdFI1SWEzWnFvc0xlMWtlQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0575125d-8ef6-451c-0d24-08de9170645f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 11:01:44.1587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IA2hsfWTRxos0UGW7T3lIYd7WnpB6KXZvsfky9ugXAnTBy86jkXINYUSoSj1kbxB2AxRgcYDGY6E9AQ+d9S7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7766
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

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (1):
      imx952_evk: Enable ENETC0

Clark Wang (1):
      net: fsl_enetc: fix the duplex setting on the iMX platform

Ye Li (1):
      net: fsl_enetc: Add support for i.MX952

 arch/arm/dts/imx952-evk-u-boot.dtsi   |  94 ++++++++++++++++++++++++++++++++
 arch/arm/dts/imx952-u-boot.dtsi       | 100 ++++++++++++++++++++++++++++++++++
 configs/imx952_evk_defconfig          |   3 +
 drivers/net/Kconfig                   |   4 +-
 drivers/net/fsl_enetc.c               |  46 ++++++++++++----
 drivers/net/fsl_enetc_netc_blk_ctrl.c |  72 ++++++++++++++++++++++++
 6 files changed, 307 insertions(+), 12 deletions(-)
---
base-commit: f7e7c55e53e80100c327b9cb0512c069acf80ab5
change-id: 20260403-enetc-b2d80f42ba23

Best regards,
-- 
Alice Guo <alice.guo@nxp.com>


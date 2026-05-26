Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F0DCD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 05:22:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 490F0844CF;
	Tue, 26 May 2026 07:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IHm1Zewd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D35B841D7; Tue, 26 May 2026 07:22:34 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C47483FF5
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 07:22:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cr6Z4wBZ+oW31Co0E4XS5aSlvc7mdW6beegxjyivF8vtIDuT4HhGKOQObioY1OfG2N/dMlBYgIwuIRj42q7AkMF6n1HJIMxZGDELzHVppiD8oyaB4KGur2QY7br+Yx6BF4MCBVoGI4DbxR01kVWuIXZtTJ99mOoLcBSTVpgzuG3zBAU4/oJmyeaTn+dmWKzvdPqWdUriqOJB2APi94iu/SxoZHEiGeOrfKT1ceJZjEIEca/MUeJ/X8KdcxBeZK89qfdOdi3Z3NTifc6C69RLod693/O/F1s6Zfl6E22VBAkg6NJNW9wi0diyBVPqoxUw7miMQeGkZSww11nqThjUPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4zWTWiNMI2rfXP/Oj7B6o2DQFCGs1rnq26s5Ct6LdI=;
 b=FvJ/SNQtxwtYhLrmQNfV+c5676VjzsFUl/zMXAtDmtrpdN9Vxq/TT0dTOB6tGqzVtlbcXmvTIO9kFjuQTLMFlmFh8jA4XHCRChyWunCaCUdATM4ScfHTqE05e74lAqpofuUpNE6IhrFC43DCemV+p6kbkirZ/tsxRVSPrT1hbRg2TYbQDNqI40cILri0l9SMSHBfBsMHiHkpPLv/Bz/Xmge/Mkmv11GlESXqXtKENO69PcPQ2KOdU3FEBTowS+nehe0aU0uN7jyL+AEZjFoomx9ww1CdvMhEmBhW8cq87xpeNx0qtcoTzJUWTFbPbiFZe/WY2TwsuzHn6jGWVF5KLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4zWTWiNMI2rfXP/Oj7B6o2DQFCGs1rnq26s5Ct6LdI=;
 b=IHm1Zewd7ad9bebbrhwSiXrl0MLCzZz/DzmoQUEkrf0od/eoMB02uTV3GLRy4ViitWYbUPLwz238uc1n1ZrRROG55F4tEycrqeF2deYKFnDDo246D59ofwZ9Ja6D/tVN4xAj41+n6FHzQ8KvCDyd0Q4rZs6dfevwvoFuFc8YnWupU7skKooNAMAorbZHOCr56vL4Fqh2y8Qi44F5b6PTDCnyln7RJb3ARErmPrP4tP0PCZqbpVQyX83oeWZWxh8R8rxsC1q8m5krjSR2dHHVeP84ajgvCW25ozvSf77nTfAckVVnVBynXuOnXqoNaVyaCqINIefFOi15C9cBNk+zug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AMBPR04MB12287.eurprd04.prod.outlook.com (2603:10a6:20b:730::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 05:22:29 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 05:22:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/3] phy: Use device API to replace devfdt_ helpers
Date: Tue, 26 May 2026 14:39:13 +0800
Message-Id: <20260526-devfdt-phy-v1-0-908ff621dea4@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABFAFWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyMz3ZTUsrSUEt2CjErdNCMLSxNTE8NU48QUJaCGgqLUtMwKsGHRsbW
 1AAduzl9cAAAA
X-Change-ID: 20260526-devfdt-phy-f2894541e3ad
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Yao Zi <me@ziyao.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 George McCollister <george.mccollister@konsulko.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AMBPR04MB12287:EE_
X-MS-Office365-Filtering-Correlation-Id: 138cd829-f180-4954-1732-08debae6c7cd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|19092799006|11063799006|18002099003|56012099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info: xoJfwt81FXC7Gjbxocppy99dlSe1VvQAOfTcaXbzCeVrQMBNZXBhMgoUCX65mzPEFR0a3/HqKdMufmAm3AypO7P9h2bGDS3DlMeCTimFLpX91x60kRgh/LI1XDE0fC2hPlAe+3F5gJF3Fpmxma/FMP1HwaPbk/hrrIW8nnLmm3opU2TupDOYTNiLcT15u/MKhHHZNJdfbbwo+aRuACa+Pbs5CHgUjxjMTKDgvzqKSwSo+FoBFbiL/0o9zIyuc04pAynMz529byXH7jAU03bLu2Ud8AODzhMGh/vdDIvkvNf9l14lZNPEuunpPK3PnuUN3n7X2e2g9PYLZ5jPwi0c4I6nC8XpcbYYiWwwlrVycZmYjQacPLRayviNefCvkqsgM1XuzxwqZhcSsrdi9PRZMd2ay0Jib31qEqEakEA00ntLTZvlsbsXvjNYw5UnNsl1eRAeJsCf5Sm2a5ggmSXJDqSUjMglJCBcTwW5re/vP9no46zZGtSXjWLITvoehQqHE258/L/BVeEP9NI+A+voFOgqhllyXO39fIvYWmEnq/qh4TpqC0a8dU6MwCSNTMrqldpTu8B4wCh00fTi1aAF8/y00W1zJbMnlDqltGTBz4j6oegDf6/1uBaGcyWXZKTwrLlx4L1oMurRtZ4AonfNEl9pCjDBscKtS+JsYqkUHkZK7DmYlp8zkqDBXljVhkzNG7eNBcoypWWQ/manBE3+tpUCC5fah6cHNJS3FBA/vvOlj6LdrcVsUcBuu0/tPnLF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(19092799006)(11063799006)(18002099003)(56012099003)(6133799003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmJ4TEJrbnYrTUFWTWdaYVZYQWZaTndGTGpTRTA1dkU2NGZHaGpVVjhwTkNG?=
 =?utf-8?B?aVltVksyK2FyMTVmQlFSY25ManJWSExveG9DWjJncElhNlprekhSR3greVdW?=
 =?utf-8?B?bzJRZCtXanFqNHlJZFVEd0RGTStieFNnYWxkL2ZWSkRhREhXZzBaajBiT0NZ?=
 =?utf-8?B?WkhVRm00U1l2SGZ2Y0t6YjJWTjNQWW5jTzhIb0V2bUpaUGc2c2kvZzJNYm1V?=
 =?utf-8?B?NFo5Q2hxSHVPN2tlQTlaUHNaZTBVL0ZlSURlTURBZ1RoV0o5QUNVcFBHYi9q?=
 =?utf-8?B?dm9qc1J4UEtWYWpuWEFCeEFvNWcrd0JTTWwzNVRBdzQ4R3laelRFY3RsSHJS?=
 =?utf-8?B?OFNtVVB6TkR4dmV0Z2hkbGd0dDYyR2p3MUR6bTNKMG9LQnF4RW9Eb0hRaHdv?=
 =?utf-8?B?bkxrTWViQ2xRN3AzVktCRld4OW9yWjA4K1RIeDQyclFJUDlheTJjQVRpQjRm?=
 =?utf-8?B?aFJtRnNvT3ZqbUg5QWgvTktMWUhlSytlUm5ldTBLY0Z0bjhEaFAwTkl4dWFP?=
 =?utf-8?B?YUFoVkkzREFTNlBWSWt5NjBnUDlabWxKMXU2L1NrdmZHc2NtNTZ6QTE2Z1px?=
 =?utf-8?B?S25lYTR6emVQOU45M3pxOHFNY3Y5M25EbTgwNjAvczc5eWw4Yk40MkFwOUxS?=
 =?utf-8?B?N0g1aGxmaklmNWFOUTZtVzZsbG5sTWhDd05DaEJZaVhiSUMxaEhzRlZwL0dk?=
 =?utf-8?B?ckZRNmpyWmlEcFRHRlV4dDlVV2J1emlvZ3p3UWRjM2RJMTE4WnZhanlJbVpX?=
 =?utf-8?B?anNJaXl6RTV5KzdhRUFNZGE0VlFWUi9DSGluYW53YXpJWnR2VkNDbTFMc2Ur?=
 =?utf-8?B?Nkk5QzJhMlgzSFZ2c01hQU5MWXNYZkhFekVKN056Z2tHeGtQWFI2Zk13cVQy?=
 =?utf-8?B?d25xcjRrclFxU3drMmcwRWlna09WdUp2eFpldHZHd3RVakx4SWQ0bEFyL2VZ?=
 =?utf-8?B?ZjZuQytYOXd1ZFNqUjZ0aDlyQjhBUklrRjdiTy82SDUyRFhoUFgvT0dMQmhO?=
 =?utf-8?B?b3JaRmZscDJSS2J4bkxBc1NiRHhVTVF6K0xDS1pCQ1BzTFF3Y2FWd3dIK3Vy?=
 =?utf-8?B?cENGaFZtRFRTYWI5MFVPeVBXRzFPRmU0Rk9TM1dSbGw0UUdhVUVRbWRvSFFG?=
 =?utf-8?B?Sk02SkhEOXdtS1FuTXpGSzNuc2pjVklqSTA0bTFvSGwwczc2RmFOU3ozdllo?=
 =?utf-8?B?eWZETngzYnk2dVg1dXNqM2p3VWErQ0RoM01iWEFOQUNGcnlOYmZSRDg5SGhz?=
 =?utf-8?B?K1AzRkFpNzV0QjNmN0J4NWI0bytFZDFiYW4wRHJaZjVQZjNBMklDQURjakUr?=
 =?utf-8?B?UHc4eVpOUi9IS3FkeXRYQ3RiWlBZSXFQNEhVUVk1aWllZ0t1bVVpT0xiaW9S?=
 =?utf-8?B?cmVtcEcyb24ra0huc2tVTTVpNXpQSFBqcHBhZzZIOUJoKy9wblB2US9ZeENw?=
 =?utf-8?B?M3QyNEhqT1FNS1BRQWNFbURGdmdmYit6SXBzeWFCTnlVTmw2SEZwb3B1Wm9z?=
 =?utf-8?B?QWpIMm96cS8rRnNhQkhoZjN4VEFuc21mWmVjdXEvWFVFaW01WFBId0tPYVlR?=
 =?utf-8?B?MTA2dDIrR0NRU2t0SVBEQ0t5aGdEQmFoRjlCTHRYdm5SZGk2U2lzYVFzMWpS?=
 =?utf-8?B?U05xbWhGemx5M3U2b1VSNzBuSUprdStOb092bWZOcVBnd3ppa25EaEtWY3cx?=
 =?utf-8?B?dDg0OXZrUFA4VjlaSHBTT0ZuVFMyUk5NVFpwZTFVNVpKdGM0YmNXWjduQ3BG?=
 =?utf-8?B?ZTNaVlU0TXlsMkltSExwanZPVlhHamVHbVdnSU1xcFdXTEZ2QkJnRnpaS3NC?=
 =?utf-8?B?c0Q4ZW0zNzAwZjJKUEZBY2RoVWwrNFpKeHdkK3lOQVU3S2pZMXhkNTlGeE8y?=
 =?utf-8?B?eWZUSnFFNENzMUt6Zm9RbzJUL1l1aENHeExwdXA4SjV3dGdoNjU3UVV1V1ho?=
 =?utf-8?B?cld5V3hTazZlTHcrSjc4dGxvMkh4aUMvclBraGZNdWgwOVMyS28yN1pjOCtB?=
 =?utf-8?B?cVg4YjVwOENLeDRPUURRWG5iVWxvYmQ4OWh1K3JCMExMd1V4dXhYTlcyajMz?=
 =?utf-8?B?R2s4azJUeEdxcTlEV0h2Mzk1bi9RaGtGSWcxVTVybkNmTHYyNmJKcVFXdnFK?=
 =?utf-8?B?YWNBYll0RXkwYWpzY1luRDJ3UVc5d1hKNTVsazFWNDJ2R2YxcUFiTFF3TTgr?=
 =?utf-8?B?dGhDSE9BU2ZLMGdvM01BaEVNK3V5NFNDd1VhWVdPTEtpWUdhTGlYSGpENTZD?=
 =?utf-8?B?dzFXeUkvWnFWY3JpQmpQalQxaDlJaU1BdndVNTd5NGJnS2FXMVhydG9ML2Rz?=
 =?utf-8?B?L2loSGg0c0VTTW1ndGE3ajl4ek5SUTAvcWhSS2dKY0F0elJYR21OQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 138cd829-f180-4954-1732-08debae6c7cd
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 05:22:29.2352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pX00tgAKGAKEOqIW7Yk/nTbqZh4m++OdcJ5uFX2/ijiihuboGP9OmeKu2nSpB7klN/VbWe8Y1q+bUgdfS8BMcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12287
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

The goal is to remove the direct usage of devfdt_ APIs in drivers. The
device APIs supports both live device tree and flat DT backends,
avoiding direct dependency on devfdt_* helpers.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (3):
      phy: ti-pipe3: Use device API for DT parsing
      phy: marvell: comphy: Use dev_read_addr_index_ptr()
      phy: cadence: Use device API

 drivers/phy/cadence/phy-cadence-sierra.c  |  4 ++--
 drivers/phy/cadence/phy-cadence-torrent.c |  8 ++++----
 drivers/phy/marvell/comphy_core.c         |  4 ++--
 drivers/phy/ti-pipe3-phy.c                | 23 ++++++++++++++---------
 4 files changed, 22 insertions(+), 17 deletions(-)
---
base-commit: bb354d04459f5425318aeb8a70bae995ee573f1d
change-id: 20260526-devfdt-phy-f2894541e3ad

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6537ACD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 10:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB36084895;
	Tue,  2 Jun 2026 12:03:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ge8uXzV2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 210B984898; Tue,  2 Jun 2026 12:03:37 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E13018488F
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 12:03:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=joWtClqb/vDXlOHgAzXAog5QQVIi6BCwGljQRQxRHVp4nMtNC4FHxBB34uehO3tzkw8l+pS/drDAZMEzhTBKVRnnbQ2vlVLbj41JqmfJLx/YSDBE2Q7G3rmhGEILE20MFCcIOY4b0zUzU9SDwFRQAM2Ecqwq514XubGOW02b5wMMS36reT2V13Yu+yd2uKU/2JUALWgg3G2BmYVkBZWa3/Sg3iDdKeX5pZiaOgsUkEpy6zWJw8XIXBy/gZrG+x/utupx18qZTzwErHytCoA8PvTVgzFsTUa76lc2Q3rCGTYOiog4puZ0UK6ehi+bKIXwXj9/Y8vIcKhojNF/hH5zTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1eZo2V7b2g81KZrzFd1Hr1XrVvu5v7qhv6c6kRP3ps=;
 b=xjzS9DtGhCKnDpShlipFQGAbT89/85TY7NvB6SZ1Ptdfyg3graV7KHBHU2WFEZDuhx6kI2pg5E1dRB+ba+xKi3GetFzQ75cIJIUdqhPpDeTnWj9cwiCSq5ATmtWg5epIJXaa8fWfgjT5pi10B6ft9L3cOhzA7lho50Gpg54iZRSIozEkO3YrbreQGVhMF0p1EX2wJUGmDpPGzEk6Vgywmy+4zOzd0+6T+kxE7XUyI4WWh0ZIkiV3cL/G1cB91dlANbDayYrgVrrxbLBjDpBL2/kUTVqYimHHcGGa/xWLOZrEdFyNO3mxakS9+08QEbRXAXH2lar/WUtHx5FhwIDUDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1eZo2V7b2g81KZrzFd1Hr1XrVvu5v7qhv6c6kRP3ps=;
 b=Ge8uXzV2xdtrAJ6yCiMCvvnGuEsPQq/mKlxXALPS3loRpqbIuEaeNwIryowdwejbKurq5u6Bj+gBlLsr1m+9moSEFEbRdYryuLfoPKC95C4FUvqaD9zLl2FII1vu7kcFyN9UJ/fyn+mxL9Dg6GblG9UwbhQ+p8zgtHz22WdatXJ5Zj6j03oNPwyzRZgJWsQ/sxWEBZVBLC20Wt3YjEwhlwLxhlaSv+JkrZibcyVLXGrTEUqIqEVluQDDlbVdIBMbdAwiqWh8jug4AuX4LeP0tvuGH8lMyfy3J1WckxryluJjszYwZWA7cYQB8Hbc8vCyXABUZUg8C7uQJDGYB/ZYKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PR3PR04MB7419.eurprd04.prod.outlook.com (2603:10a6:102:80::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Tue, 2 Jun 2026
 10:03:31 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0071.011; Tue, 2 Jun 2026
 10:03:31 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/5] spi: Convert drivers to dev_read_* APIs
Date: Tue, 02 Jun 2026 19:20:14 +0800
Message-Id: <20260602-devfdt-spi-v2-0-08374650778a@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG68HmoC/03MywrCMBCF4VcpszaSGTGprnwP6aLmYmdhUpISK
 iXvbiwILv8D59sgu8Quw7XbILnCmWNoQYcOzDSGpxNsWwNJUvJMSlhXvF1EnlnQBdFokkg9Qjv
 MyXled+w+tJ44LzG9d7vgd/0x+p8pKKQ4aftArwyqfryFdT6a+IKh1voB8HI/AaIAAAA=
X-Change-ID: 20260526-devfdt-spi-2911c7201281
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>
Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 "Noah.Shen" <noah.shen@mediatek.com>, 
 Meiker Gao <ot_meiker.gao@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PR3PR04MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: eafd0201-ce80-471f-d5c4-08dec08e3326
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|7416014|376014|52116014|6133799003|38350700014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: +KcvzZkmSkEYxIMvxaj1+0UjWCpPU+TkRJoGqG+xH49lEclZ32r78FT/5jN17a93c1JGXqeCYagEopAtk5t3/qtm7m9yAW6+L87qFiPgfh981+5Nj9ejjnau9Isl2L0uO2r9S0GyzQ1WUwUQ2HS28P9w3BebYFXAaVydru5f6UwMvvM4o8qRdlfr/hBMbaMAJ3Z/x6r/C74CPw5UeHOGhhIJoGYnZsWkdMty/OOfTWHkHhtd1G4CRuVahouybFW2Y20P+1sJKWy/3z2V14B6EtaRjibvsMaMGd2jFu83lMCf+MpiXoWe+GSY6en1+U4wVGz58VD8zoyLJyt4DdTktazrCAxcRMWjOFxMFWueWOyMqhlV27n1YOXFxGm4hHwrgHMZbHxfDlChmALJyo3GdVLxpiD0239xuIodm8nCCQTFk0V/KtNuIz54MZXZPEMmVJFjeCnIDxXr14t1ubjSq7zc61Iq64HXtk3DFLPo8+9d0Q3lmQ1HD9SgDQne0OHRrXKDYdgjmE7JRs+4dZ5ni5pP8kAEJlWs/DoIgn6PkHVaEFt68rzVNEiLnvBE61MPcTHggZWUOKPMKFM392MD13AMy2pgp4iCVWz3YX5yBYZqGMVaSjDHBfo2aVWnQYDbURIEEBT5FPHz7gNV/armVRrgrzMOX+OLjvd7HUbA6aE5fc15KsmmS87AxowknqzhbVUDr9FBzMvvAoQC55XbSDFM2Li+R8sKNWUlz90GacSj0ThvC0y3Y70q65G3plk8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(52116014)(6133799003)(38350700014)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckZNemlVRzQvaGxoQXJteE10WHE2aU5FRlFrVXBCdUhRZkFiaXVwWkpHK0E3?=
 =?utf-8?B?V1BwRDBDdzJLbTJSck1YUzR6RndVMlQxQU12YVpJSDcrL2VOWWsrSEZKY0pH?=
 =?utf-8?B?QjBjUlNTdTROVDdLRGZQQVpDVFRoWHoxNXRaY1A3REdqSEFCcVc3eitKUVVp?=
 =?utf-8?B?blVZMytka3RKN3drTTczcjViWkMzUHpESUdxWHVvWTNTMlM4Umh3QjFYQk82?=
 =?utf-8?B?MTQ2d29NOGlOUFdrR1V5V0NqTWRLUEN6OVF4ZGZzVS9xbm11QzA5NmNESDkr?=
 =?utf-8?B?NEhPL1RLSkFpWVF0ZVRNUUtwcVI2SWxwa05Rb2o2cCtQWlIwY1BMRTR4VkV3?=
 =?utf-8?B?bUNncm1BaHlZYTJxbjJzVG1UcDBlRzhRVncxSEt3OVdFN1d1S2FrRmJVdURv?=
 =?utf-8?B?akg1ei9QV25nZXNXcmJaZmljUkc0aEc3ek04TzRrVzk1VXMySHArY1VlQWZr?=
 =?utf-8?B?SjU5WXIxV3dNVGt5SnZORUxGd1VYbWgrbjBSbnJuVklIeXcya2tuZllLU0N5?=
 =?utf-8?B?R3BiL1k4TExCNkRTZFJDVkJBeC95OUYvR3A3MkpUUTFSTGVPZVRjUW00OHlo?=
 =?utf-8?B?dEhDT2oyVTN1aWkrZ2paVzVYUGladnlmbzJ6UTlOSDYxV3M1bGZwaUVHdjdV?=
 =?utf-8?B?ck5VSnlFTGNjdnlDT0RJUkNKOXpheGpsYXMzb2ppVmUwUmcxNENybDNEZUtr?=
 =?utf-8?B?UmorekNQVy9WL2hyZWhKK2FNM2JVZ0RuZ3h5WHphd1YweTFIMlc3NHo4Q2dW?=
 =?utf-8?B?OUQ0YkdtaXBzZm5FMmp1NGNUdTNRZm13dGFEUlp3dmo5cHJZM0lVQVN5OXRI?=
 =?utf-8?B?djY3Y0w5c0QrT1J0c2IxZ3lGVW9obWR1Z0xiWFNCc283MlZNLzQ5ZERWbCtT?=
 =?utf-8?B?dEJ2UmVJZTl0YUZ2SkMyY1U0YVN5bVdweHpJWnN6TlA2Z2FBT1pmcDg0Q2to?=
 =?utf-8?B?TFRMclhLMENhakJXRERGSUJXaFhlL2JoWWxtUkpWNUdpTFJuQktXek8wbTlH?=
 =?utf-8?B?azB6WHF2SU5mTjBBaWlYMUVWRUhVVlRPb0YwT0YrdzhIc2dXaExudER6aG5n?=
 =?utf-8?B?dU1RUkQ0c3F5bkZhTUpSY0VuMWtCRWptcDA1OER1QXBGOHFqQzJxOEVTQXU1?=
 =?utf-8?B?TjhMbWJOZTRiNWsyVXZLbzcwalNkcjJIMjYrOSt2TFZrR0U0aDFiRmtwYVpl?=
 =?utf-8?B?bFdRdkthQUJWV3RtSjZsRlJ6UWh6TUNzOEQvNmdzalBMWGdmVTMvdTE4OVVi?=
 =?utf-8?B?aUxJOElhVzBTZWpkei9nSlg2N2N6TWpUKzlISzd3YUZidU51QXR2N29BTGM2?=
 =?utf-8?B?dUdEcUY2YzFWaVg1bGovVjNOSC8vaHBEb3g0MVp0V0x0eDVJS1RTek1pR0Q1?=
 =?utf-8?B?ZTdrUlRDQ0R3Y1M0VXlzWXBOMks1VDk5eVF4UnROdmFXVmRPaTNPMjVjNkla?=
 =?utf-8?B?VG5MS1RZaXEwRk16eXozYUgzR2JQSHZFYVJQbk5LclNCenJGVS9mM1o1SG5n?=
 =?utf-8?B?R1BXOEJjaUFqdFQwc1ZIRDFEbjhHQ2hkVEFEN1NUazlCb2M0SC9BSjRZYTBI?=
 =?utf-8?B?VFpmaGRpQjlOOGxEalphSzNkZ3h3ekV4eGp6eEFEUitPcFAvbFhRTWk2MGI4?=
 =?utf-8?B?U1NORzkxTnpzcUYzRHhKNnlhSVM3dHBudXo4dmNlNXVtV3dvbWVLVkk3dUJI?=
 =?utf-8?B?Mk1xeHV3VFBpdlBWMEZxT0c1YWVZbE9LejlaQWpBY0V0ZDlJaTYxQXgrdjdi?=
 =?utf-8?B?dWFib2ZSZ3RKRWkzREoxaGE3R0R2VmhYd1FYaTJka1BlcFI4TFNvS3JheVk2?=
 =?utf-8?B?R2NzTDZkenFDOHJ4cnArV3pwK3QvSldIRkRJM1VQNUhHcFhHaEpvZ0sySVBh?=
 =?utf-8?B?UFh2b1pFb2crTi93MUZEZmYxNS9TRGM5U0Mwb3NIWmh5UzhEQ25KWmRmbXdZ?=
 =?utf-8?B?Lys0azMxUVN6QmpLd2FjVG9zcWluRHZldjhWa2ExdmR4US8yWDQwTlNBaEdy?=
 =?utf-8?B?WTBMRk1QYk9kd0VkWTk0NVdMc2ZjOGlrNVFqUHZvcmI0cGZBNmNISm0vcGtB?=
 =?utf-8?B?UXNtNmxWME5ERmpLdEp1cktFalVOVHNKNDFLQTdycC9JYWlkcytnZWR6cDNC?=
 =?utf-8?B?SEdZdzcxdjJ3Ni95Nnh3eW9tMjZWcWRYVWIybG5CbnB6Y0d3cjVRMjJRNE9z?=
 =?utf-8?B?YXIxYkJKSE54YUZuVlhycW5YYk9TSFpVclhnQy9rN1FYRGJ0RGszWjZVbXNM?=
 =?utf-8?B?SDNsSGQzek9qN0VWK1daR21hU1lnSXVwV2c5SHF4NHAvYnE5Ky82OURSSzc5?=
 =?utf-8?B?bmdsZ24zcjF6SHI3N3oyRVBrZ2RVWHBqbDdsUTdKM3VrS2p2R3Nkdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eafd0201-ce80-471f-d5c4-08dec08e3326
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 10:03:31.0862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3PPniyZ5YQvyruefRsOmXmUyDbw3LXZt1+MviA1NgnUq2PF4ZxBMTy+8W93Zov/Obu2mlUZXFK5KqF+AHeMyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7419
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

This series converts several SPI controller drivers to use the
dev_read_* APIs instead of legacy devfdt_* and raw FDT helpers.
The dev_read_* APIs provide a unified interface that works with both
live device tree and flat device tree backends, avoiding direct
dependencies on devfdt_* helpers

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
Per Simon:
  - Patch 4/6 (cadence_qspi): Update commit log to note the new NULL checks
    for regbase/ahbbase as a behavior improvement, not "no functional changes".
  - Patch 6/6 (ti_qspi): Fix dev_read_phandle_with_args() call to use
    cell_count=1 instead of 0 so syscon-chipselects offset arg is parsed
    correctly. Wrap the call to 80 columns.
Add R-b from Simon.
- Link to v1: https://lore.kernel.org/r/20260527-devfdt-spi-v1-0-37db1f6c168a@nxp.com

---
Peng Fan (5):
      spi: spi-aspeed-smc: Use dev_read_addr_index_ptr()
      spi: cadence_qspi: Use dev_read_addr_index_ptr()
      spi: mtk_snor: Use dev_read_addr_ptr()
      spi: nxp: Use dev_read_addr_size_name()
      spi: ti_qspi: Use device APIs

 drivers/spi/cadence_qspi.c   |  7 +++++--
 drivers/spi/mtk_snor.c       |  2 +-
 drivers/spi/nxp_fspi.c       |  8 ++++----
 drivers/spi/nxp_xspi.c       |  8 ++++----
 drivers/spi/spi-aspeed-smc.c |  4 ++--
 drivers/spi/ti_qspi.c        | 22 ++++++++++------------
 6 files changed, 26 insertions(+), 25 deletions(-)
---
base-commit: 0a46055d96ac627c05180cdeaa187a9fdf6b7973
change-id: 20260526-devfdt-spi-2911c7201281

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C37FC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 03:30:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C142846B4;
	Tue,  7 Jul 2026 05:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="r3RbTmk4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BE1084844; Tue,  7 Jul 2026 05:30:28 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EF16801A9
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 05:30:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvE93XNXIO+kwahOjX70WCT2+FRDxn9XuWkNVDwzITAFs7kV1GRsLf0GQorwAF62KXlDIhJS52ilY/VQ4sR23Q4Klk2g5taSKVB0M3miN2NptxzwhdPLcAyMnTrSyTCWgiiuw+wH5V3uKwelBNq5b8L5pxiSLXG0jzhFvC57xWTqvyBrEd5xJeO1gNMcTpzv4B9plVJgOia3jW5nIWzNIixyhtqYS1ilLXOsHxQOEaT76525wAIxrxzrk6apekpNyqjh7UPAwDvDtfJ67Oo2klnohcO39TfsmKtRps7vnt6veZQo55dYgjYpBPtlW/i1/WIl+vIVccx3/fdgycNeTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHcB4xZn+B4QZfp04vCo1+QEGXvZElIxkWltgSOT0/4=;
 b=j8uTRb8kd0d7HPNWi+Kozy7SZKU4pfhU/mmhSUFP7j5Lh44qhe+HrmmQqOEp6N+mJxIt5ezytoJC805X5adzQ0A6ucLTiAEtxGr7XbxXjcDPNey5XIioXI36lVadRrJbEPXBPxPmbGl6wiwMe88mqoCW7/iHhOe04VsWFVATKg/npDJGKq7pVlzznuo8TDbw1cPhlrOCqdg4o4fCrKYE4iYVWIFlKWztWOm4PX8bNeK+Q2avarz0lWz9s8wlXwPodr68DIb9I3+DpUARr3QRzd+Ph/6E5c9c+1yqIIUunhMBQyosUqWK3wpH+cjuVwG+eX4Y/b69sl+eG069BbaPlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHcB4xZn+B4QZfp04vCo1+QEGXvZElIxkWltgSOT0/4=;
 b=r3RbTmk4CcN57SlrlEFyMTfSbkrK3/hlLBbIzdBShMkx2MelOcP1y0+Jz6uPYu7urqxcK7++wyJtTH+Npjs0jfqSZvL1cj3j0tNqKe7WvuzqjVK6R33xHueJ8QY7zxeRO8ot99ZdmtnUPlN/70EBZr4zVjfcrlcq5rmdxfPxBBe1GuG+JmgG0F5L4ZldLS19uuJQO1d4yjQJjrp64/6vjZ+1UwasqRaRX1es+Q0bjQ3RyhLNiTNBWHkdSgT429i0Lz4TBcyrjUWYZoF7tUzKGumNzbNXtcbdYkjk2scEEmYN1/dJUyzOv1hIQtECEjiV2CCfvJ/NsFvbrAnLT+yf5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by AS8PR04MB8008.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 03:30:24 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 03:30:24 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH v2 0/3] net: fsl_enetc: Add SGMII 1G for i.MX95
Date: Tue, 07 Jul 2026 11:33:48 +0800
Message-Id: <20260707-imx95-v1-0-5b4b0f03d5e3@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJxzTGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwNz3czcCktT3ZTEtCRTI0uDNEsLIyWg2oKi1LTMCrA50UplRkqxELH
 i0qSs1OQSkAFKtbUA73G97G0AAAA=
X-Change-ID: 20260707-imx95-dafb5290f982
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Marek Vasut <marex@nabladev.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5P287CA0155.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::17) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|AS8PR04MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b1fb4a-d868-4890-63c7-08dedbd814f6
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|19092799006|366016|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: SMe2s6w6tJLjR/W7F99IvegCFU28B7iCNQ5ldXLY2NimU3kGWLrEUhZbTQOK0PsXcBmV5Jdz6ACfd6N10vKeUpcISb8AkAmIn8qeV/9hTGhrIy8/P6Pt76KOnljocry+9+83qV1OwfEe0yHufIRs67NJf+6mnn7UvkBVKpWMwPFSJeYOBBbuEU8amy8OoSj+JtyK94J0UclRswtAARV5R1fw4k/no3S+RUXBJgGEBQA+It4Jf2f8UJoF+oAGSfTOvpnXpieaJgE9/EbSkaNdMugUCyvz9oDOnourY5IsKYr2KCHbd4P0mC7c0KPgVIehPJyeCeWconmdug1UJgolaQj53ddJ/K7+LlaPMmPQYgf0oDTNMwSzsWWgVrCb+rcdSUrt3bUBQCQuyRco9cdU+SEb+mup0orFYTYmTqhxW8zUF7e9d2dVR8hZwVm6Ychw+yeWFgQKAL9U2AmbvXu3LBIe/UvjLRE9HbGno1BunT0P2A9RzEfa/H3GJu5qP5YLaYh9KYak4sDP6yGQcTr3L9u99eVC/9Hz63FqxJY/8MPr9gBW+UoU07B6VDCxce406iB4lDMqcFjQ4WtCaWMidGQxu91LZFgNgADmeNa4T4YdaEMGhBdz6t0ac4jCpZVLgg9CJK/hEe8NCBSqOJrBffWVv92xNte+sTeDHlC79b8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(19092799006)(366016)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkdUZ3k5Q2FjSUw2NXVoOFU4MFhWNjNiRldLeC96QWJLSnNEZmhkZ1NDY2Zv?=
 =?utf-8?B?VDBUMFAvZTRwK2FvS3pDaWx3YmJIVW1kY1h4WDBWV0R3Q1BHeUsyaWY3K2Z2?=
 =?utf-8?B?Q0x2aW5INEttc3JEM2lyaG9neXFrTG16dEowNW40aDdMVDRFWUNQVVJhWDlB?=
 =?utf-8?B?OEtrTko3d1lRZFBsMTBqNmNzeWtRWG1RMzZXeVgrUUhaQ1NiTEJxY3hjcGs3?=
 =?utf-8?B?NlJ5MDNJTlZBeWFEbThUTGY2aG9xdUJHdkNOajNQbVR0ajdUU0JNTnozWDZJ?=
 =?utf-8?B?Ulg5TmxPdk9nMzlYU1dKODhDTnRYVEJKeGY5UStJTzBkb2JlVjZFS2ZTUnZw?=
 =?utf-8?B?VU5PWnZSTXR5NlFjMEZzMmU5NC9FVjA2QUxpZW1CVGc2UXhTSU1DaGZSYVhJ?=
 =?utf-8?B?VTBkUThJM0VrKzRVT3lkTldNSlVnZUxjc2FtZGZUcjNaR1B3ZEFjdGFnU0lP?=
 =?utf-8?B?dWlKVVdNWU94SG04N0RjaVF4cDczV3p3NTJNZEFOcXNRUVJJNU51cVliT1pw?=
 =?utf-8?B?K2xkY0VxMjY1UmVZV01qQ1c5ZGpQbzhkR00yK0VJOEZ6dnhXZWZ6NGJDeDdE?=
 =?utf-8?B?MytHTVpwZEhQMHQ5cXQxMTREMDBOcmlwc1RRK1dZVFJNTVBoQURqWWhHZmpR?=
 =?utf-8?B?UUtXK1VVaDkwcjYzazZURGFvdkZjOXVZcEpaZzFSbGlkOTdsVkJib2RNRWFm?=
 =?utf-8?B?NWtES0JhOWdDZEUyUVcramdTRHdsZEtGZlVkaVRjQ1hySUdmZEdPajduUytl?=
 =?utf-8?B?WEpFVVJSdDUvS0tmdG5BMkZ6dXpqMmpWcStLWFJEYzJ6RUIwUmp2SThKTUc0?=
 =?utf-8?B?bnlSeGJXM3VmaUZ2MzNxY3ZKTjJpYXZJYjh4Vit5Ujc1M1grVCtQTyt3RFlj?=
 =?utf-8?B?ZkRtNGxuNEMvUWhGaUpLbGU3NDIvaFpaSDBxYUhrTWt5UkJ4eFozVFhUYWVL?=
 =?utf-8?B?SVI1UkpaTE02R2tGUWdheFFVZmdRNDZUTCtXc2hrTGZCTTVNVTlTZUU4dXAr?=
 =?utf-8?B?QkdIeXByZThEaURPdzFPUnNUQlRnQlNVeGdoeUl2SVc1L3BMeENaaWRPNy9W?=
 =?utf-8?B?aFoxd2g2ZzA2T1RGcE1zeUJ2WWJhVWJyWjM1aXMvQnIrNW9FRnhLeEVkNjdT?=
 =?utf-8?B?Nm52VnNlNXJ1eUd5bHp5blZPcGJhbHEzU3puZkFwajd1ajFPcEc3Z3ViOVBq?=
 =?utf-8?B?M2tIdFhZdmVpWGtRR2RZMHludC80dzhrQkM0enNJd0tkVkU1dmgzVThaVlg1?=
 =?utf-8?B?QUZJdHJMR0lzVVVGNk15WGZJajJhUFVSM0U2VmJsajRYWUZ1QkhRc1hNck5p?=
 =?utf-8?B?WVVXQmtycCtlL2t4N05RNnl5VjBGN1Zqczg1eWJmMGVWUWNGWWUzMlg4L3VH?=
 =?utf-8?B?eHpZU3VRK0hXcjVQbG5nOTJMZjlOY0xqMGowY3E2RERQY3VxYmttcVZpMkVl?=
 =?utf-8?B?V3BUTTQ1YXkrVzBIWjRPTEpON243QzZoSUhkNDFSWkhzY2UwWWFXSUxwSmJx?=
 =?utf-8?B?Tmc3emE4Skp6T2RTOHRlWEk1elQ4YkpZVzBrRm1MSEN0SWx4YXNKRk5VcVo2?=
 =?utf-8?B?SFpSajhESVhDNmFTNmgyNWtGcEZKMGJrV3B5WlBHbjNFNDF5NndYaHMwdGVV?=
 =?utf-8?B?aG53RzVJSGpsSU1UYTdIbDNPTERVSVlSM1B2OUFsQ2FhNlVwWTJiblRZcHNL?=
 =?utf-8?B?Wjdydng1ajI5MlBzOUpZMWRoUUlCRGNTaE9Kd1d5VjM4cXVjdFg0d1dxblh1?=
 =?utf-8?B?b0ZUL0pkUkJQK2huYnJhZGM1VlMvK3BlTTZONlVSWG12SXd5VU1OTDBZbHpz?=
 =?utf-8?B?ZnlNMmh6V2s4T3IwWXBxdUwvelU0VkhwVjRXQ01Xazl3OFFUdXN0L1daaG1w?=
 =?utf-8?B?OHpxeGVjN3F3SU5RRnNyM1lHRCtHcUZ5ckFjNEQ2NGFkQ2JqaUlTYzhoRzJM?=
 =?utf-8?B?YlBnUG85eFdxK2RHaHgwdUFkVXN2RW5mRHMzOWpUVmsySTFySmFhV2hFQXk2?=
 =?utf-8?B?SGNNTWNhcC8rR2RCYUxsN2tPWGdMQmlPTTN0TkZteG84blVKOHBUd0RnZU5R?=
 =?utf-8?B?aEVzUGMwUlZJeVIrRVVuRnJuUVljSmF1bjZtS1pwVEVpaHJ3Zit2UEhQVXgx?=
 =?utf-8?B?Z29lam9wSTF3N3NZUU5RcW9mb1VvVVRxVng1VDQrbGpwZmcvc1I3YVBLaGJ6?=
 =?utf-8?B?MHU2RUliNGhhc1VPdFNmV0NGUS80bDJGR2JzUlFwSEtMUGN6alNoNUZXazdu?=
 =?utf-8?B?UElZNmh1eDhxOHBpOEx4bitaZUlHM1lvbkZpekwza05oUS9lQW0zbitSWEFn?=
 =?utf-8?B?MEtyRnRYWjBMdTl0VS9taWs5R1d1WGk4Zm5aTXROcE9wSXJjVHVLcng2YzhV?=
 =?utf-8?Q?qD6lsou8W8/E9dx5Dlu+jVEZaPccbsTRDJn8B?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b1fb4a-d868-4890-63c7-08dedbd814f6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 03:30:24.5595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVeiQKSEVVvA/8SOhCD7ayE2eWmDTfOp5irbLRVTTXq9nHSo75t8BXhkYJQkmsu7X3km0BC5f8BXkApQoT+AXyAPAwBAqYqNash4Lpcc6M0xMQRVNFMK2rPyMmauyfWh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8008
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

Changes in v2:
- Fix CI build failure

CI:
https://github.com/u-boot/u-boot/pull/1007/checks

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (3):
      net: fsl_enetc_xpcs_phy: Extract common PMA MMD init sequence into helper function
      net: fsl_enetc_xpcs_phy: Add SGMII 1G support for i.MX95 Ethernet PHY Wrapper
      net: fsl_enetc: Add SGMII mode support for i.MX95

 drivers/net/fsl_enetc.c          |  12 +
 drivers/net/fsl_enetc.h          |   1 +
 drivers/net/fsl_enetc_xpcs_phy.c | 691 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 622 insertions(+), 82 deletions(-)
---
base-commit: a18265f1ccb7a272721ed4286ed3b5a6182ff424
change-id: 20260707-imx95-dafb5290f982

Best regards,
--  
Alice Guo <alice.guo@nxp.com>


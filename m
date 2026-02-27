Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9206FFEFB70
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 17:24:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5FCA83D1A;
	Fri, 27 Feb 2026 18:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="dCVWCZ3R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EC8283E8E; Fri, 27 Feb 2026 18:24:17 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 123E983CDF
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 18:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoP7HbpGuuPNRE2gM4EE4QT1wxNJZCsLIbleoS/95IgXKkBj36pIGh6pMG4h0bJeEr9eFzOlZdcOceXdAaBF1dDSp+GY3j4Q0/nRdCUihK0llvhyqYufxu11AvalLHeYe2Qp0m0JHKnzieso4Xdm2iFrSaVRcaAl+ouj8quoKDV0/sE6mYy+30sulzH22KxRpDmB6t0x5neHOv9ohTu1S/YUMd5OpSmrmRcZs1y37W8sHlAxJabPqNx0ZLVzfK5WxKJCWnsAx+oM7lD7wAdSKT1de82YRtbmguzSYA344uq84D0yuqolqyiZ9tOKvo4zPF+tU2ebMAVAHF9OiR2Y4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiYloTphyDJSZ7qkyT5Ajip6wFeuiMnUrTZxWaFtaLY=;
 b=LgKM1W7TTqMIgyrgjxrTWk3QgxK4282EnJTTQfyCtkBlBTeMqWgjZHIK2L72dA+7Uiack70uKsCjLNFiviN3f8BRq0YSzq94ZI4DEvFtCoGAbXuGd4Ej4/gJkvtZAOUWP/WrdSOWgBvbwB5M2Ehp92y3+jM/LcG+ufqEkN5JZBWCB3cl+yfVwualGu6/7nifLqtfpmAA30Lx5Wx8eenQkDcQPifeI67bMYani3fxnabeyWRzQDIq/VGTp4zILyAFo+gD8yKfgvD9MOLjPBrRU6tMtWJuBNoYSbFXJU3xAuodskUsGKSUmA77ET2UzxpIGasFi80105+rO3kGdq0vzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiYloTphyDJSZ7qkyT5Ajip6wFeuiMnUrTZxWaFtaLY=;
 b=dCVWCZ3R1pT2pxPhKnw99tXhe3Q/1eLwflTJyEzXpm6/v21MDMbHZPH8DS5MRDocA//OU5Z3Up1KBXFDJ710ZH5SIdd8sAjelgfddu+b3A7Msqwmu00ixcAKvBGLvnLoTA/Hwc9xbKXx7G4mhEQQuzaptYYtOKnDqlRWWlX2nXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DB8PR04MB6972.eurprd04.prod.outlook.com (2603:10a6:10:11c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 17:24:13 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 17:24:13 +0000
Message-ID: <15c6cb6f-e927-4820-8ece-b8283fe0d4e2@cherry.de>
Date: Fri, 27 Feb 2026 18:23:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/16] binman: test: Move pack/layout test files to
 test/pack/
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
References: <20260226234802.345968-1-sjg@chromium.org>
 <20260226234802.345968-2-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260226234802.345968-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::8) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DB8PR04MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df6c240-bc9b-4670-2b1c-08de76250690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: B6Yxmoi54+TWkMNxF/UFykvXF6mV4gbUapIzJtBmvhYJnc+/KQeiyJtALFjOmAzv9DEgBt5bZjAOxrlpiX/zbPUKt+h0f1qZLRXatylAH9ERI5vzltXqEot+7VJWWRgNEjSMXHiaYF85qYfBmoQILD3xa7dm/uaJLCMywE746WeA5Iv8i5xjEcXAYNcSb2cgt4mjoVgcqQJrkZBNFwq5RDCWkz+w0I+esBW84L6QQ/BUwF54luFSiJYC52hQQwgC16smtRrbruupRf850BgKqz2p4CcLwMmVqZUs7gqVZelU45cCqZHdJjTFRQ+57j+TxhmB4YcxY/Ol1YqU4CNx4bOHu6yJvI474V0sAWrcwxP6+rNRwvxYukqe6RcacQ//HMNnOXtI30SWBKikd+zHGQGjcQFz10zKQbVoe/L5Y/GOnUHppZxoRzp0oclOH5LvXgeQqypx9LFJEx7DBY49GdUkv6YazXCcTzDMXs+qxAg/i6kiQdonHGspP+2CmD9lT3iIejJGXp4TgOKjIDCXLQTJXV91ecZCbFPgBsXYT+lIsjb6Av+Eqr26TUL9IElucYAbQL5hLUH8NcrhIgQJI6M0n/7KaQCR+4JXYno50WdGRW0nG3kS10kCUOsCevNQVpnng2WYjSqe363XVNC4SOdOcZHDOH0brFBoLRmu6ymBtsCf1+wegH6NNCXDGTMafzChaRd6XrkEVDqKHi7NGCw9vqV1iV5x9IhzAIbuM2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjBaR25XdTNDOThLL0kzc1FsT3F2RlN3aVdkYU9udHZjMWRMbGYyd0VQMXZO?=
 =?utf-8?B?dzQ5UTFMak5pMjBaSlNaTlNNQ1VqdjVlSnlUSU5sRWYxdVpQNGJxMll0a2l2?=
 =?utf-8?B?WVMwaGQ2bzJ0aU5FUDBWNCtHL3lKbE4yaEhaMkYzWUFXMWRLbjc3UTFEbHRn?=
 =?utf-8?B?TXdSUmxia0p6RDg4SFlFRVpydDMyTVdCS0Y4SWVXM3pZWFNrYkhzYjRya3hG?=
 =?utf-8?B?OGdvMHVTaElaMlc3bU1iUjlBTTZueDVRNTBJdk5nTjFKZ1REY0tkdVJxUzZQ?=
 =?utf-8?B?NDJxdWhHRlhRbzhBcVIxcTFpK2hnM2dCRnpTeHdYNzVxTjBVeGIrRkZRSHlP?=
 =?utf-8?B?RHY0WmlaYkRVUit1OS85WnBaQjRTeWtkTVpyNEpTcHVMVEhVbURvZFh5Q25G?=
 =?utf-8?B?RUNDckdUOWxydnNsNEZqRGFTK3crR2pBSHZjbVlnSzAvMTRyWmRaWHpVOERQ?=
 =?utf-8?B?KzcrWVZNSWRCSWxscnJmMzRIKzg5MXhLRDNBTWZRL245ZVhsTnpYSXBjQWs1?=
 =?utf-8?B?UzhwaURkOWM4VisvS0YvQ1VuS3VtUlpYSjA0VUdaMTltSnF2N0VwWUpjYkxa?=
 =?utf-8?B?TUlUN2Z2blJBWjRBSDA1eDUvTUpQQ2pKM0lWVFpETFczTmVqOXVwZlJEdFNj?=
 =?utf-8?B?dWtMSUJ6RDlXcTh6ZVk1TWdBUXFzTkIxa3RHdkZPODNsRG52NEZ5Vy9JQTFz?=
 =?utf-8?B?U0V1L2E4U040ZjREQm1PK1VuNytwbnhYL1BnQWEvZXJ4RXc5TWNva3pLK0p5?=
 =?utf-8?B?NE9CUzF1K04zUE5SdVBJMGV1QTZRTXE2SHd0UlA1aWt0bjRXYVZEd24reVpp?=
 =?utf-8?B?OTRXL29URmp3MDQxbktDNTgwMG5tRjlneVlUYlptVUlwV2JvNnptaTNESDJp?=
 =?utf-8?B?Vjdkb2tzaTI2YnpCVkpObmFpNlV0UGJNb0ZaMlVGdndleEdQc1NkY2dSbGZy?=
 =?utf-8?B?bU0rTGlJZ2J2SmUxRmQ4UlVVSWowQWlBZXl4bFpSSVBnc1NjVElGVmpaS1Fo?=
 =?utf-8?B?SmlhNS9lRW9SdEVhL1pBSEo2MzMrdTFlNHNxTktLVXhTWDV6ekxRN0F1Mjh4?=
 =?utf-8?B?aFh2cHI2bFVCTmNjeVlVWXhrWld5bnloK3QzblZGNldjL3BmblVLWGlDeVc3?=
 =?utf-8?B?UGNCV01yVzA3WUxCWCsrKzVuK1g2cDNDc0F4QUVSazBzZ21ZWVRnVEQrOHR0?=
 =?utf-8?B?MlF4Sml2R1Y0MHQxRURaSWVGRW1Dalo2V05IdEF1aTNkM0lkc3B2bUE3d2VM?=
 =?utf-8?B?Q2c0RHp0V3pjdGJyNkpRMHF1ZVJ5UDV0TUIzU2o0VDZrSzhPVzBjWDY2SlAw?=
 =?utf-8?B?V1hOSE1KOWRka2wwbStkdHhWRmJuZTFHb3VOWDdKZCtodEk3OUxtSDlkaTFJ?=
 =?utf-8?B?ZzRnSFRBOFN1VW5CckU3dGpsZk9CMGZCQTZzZmZwZk14cndUMkh5UjNyZW9Y?=
 =?utf-8?B?Z0V3THlUcklVL2czYW1uUWRZelppS3FUMDR3bWNwQ1luSWY2VThueTg4aHZI?=
 =?utf-8?B?aC9QcUZqUkpzNi93RS9sOFdNOHEwTVExMmxNTW5pSzF4ZGRUQ3piTXRvSHIw?=
 =?utf-8?B?NC9wdzU2V3NzeXdRdFZabGtZUS9za3NHRUtBU3hBT0syZElrQ3BUYXEwZStM?=
 =?utf-8?B?UFE5SVlnaTlqU3hBZXczVk9zVlJOckRkTTYyWjZweXVGdi9EbTc1V0VtUHAv?=
 =?utf-8?B?Nm8wYjhkNEtJaWxNY04ycjU1ODdVMThZVFJHdWdKNjVsM3M0Rmd0cEUrQWVj?=
 =?utf-8?B?NldCRVBRMUFST3FLV3FLYnVqK2NkL3k4bjR6MVdWWmtLQkNENVY4YWJRMG1I?=
 =?utf-8?B?azBQQkhYbU9qL2ZwZHc0bk5rWFJLVFBiK0xPNDlHaENHSWJaN0NsWU5TNGpL?=
 =?utf-8?B?a0I4cytWZEVDcTV1RmxrczZLUzEzOVAvTjJvK0NRZ1lua01qalJPdXB1d0kx?=
 =?utf-8?B?dlFiREFxZVZHd2UwbFM0TmcyOE1xNDZWdGM1ejZ0Q29nd0JOZThtNDZ1QVZt?=
 =?utf-8?B?R05tVjZuaStlbHkxWDBZWGNvT0p2UG5GTVQ1RFZBbWE0ZXJDNUpzUDJUOHVY?=
 =?utf-8?B?Ly9VOTl1WCsyb0EzRnExQjVvOHdWQ2Fnekt3VlJlYWo5ZmVCMWlPZ2lHQ0tt?=
 =?utf-8?B?UFd3MU9PbDJYeEZEck1QdjlZRzljOVRrK1dBTnR0SU9ld3dRMU5mSHpsdnhn?=
 =?utf-8?B?OW96WmpLaHJ2NUcwc1Q5MU1jcUlzY3M0SUNYai9ZbG5QRk9MU1luK3loc1hP?=
 =?utf-8?B?VG5XclVUc0hUZ2pGVG5kclBaNHFlNEdJSEtCcGVocVpFcThnVlkyWlpXRGY3?=
 =?utf-8?B?bDNpL1ZmVEtsQjB3THFDVG0xNWd1WnR4MnJLZjgrVHc5d2dmRlNtdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df6c240-bc9b-4670-2b1c-08de76250690
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 17:24:13.0454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKsy5ziMl9Ts5qHQgxBDvX/YpwJz3Fed21vPu08n0E4MkiR8QaowFeSG+O1x35LX5LKO8PBHB/1W87HKJSgzJc/BYdhyac2W1tM1coOVN3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6972
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

Hi Simon,

On 2/27/26 12:47 AM, Simon Glass wrote:
> From: Simon Glass <simon.glass@canonical.com>
> 
> Move about 50 test files related to basic layout, packing, alignment,
> sections, and image structure into a pack/ subdirectory. Drop the
> numeric prefixes from the filenames and update all references in
> ftest.py, entry_test.py, and binman_tests.rst
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

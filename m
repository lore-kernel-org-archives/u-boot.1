Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486BEC43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 13:09:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 035C884A0B;
	Sun, 12 Jul 2026 15:09:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vRNQe9Ub";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D8A184A0B; Sun, 12 Jul 2026 15:09:02 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 864BF84940
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 15:09:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbRXKx73ZhgxW3tPOqSxELW+/Ah1BPPAT0UeUGChzY5KQIj6BcK+BRX+jeNfeqDR6Hxux+eaWZL2QGR1jP7/IQ0xVhNAheG+V7TQlYyWYrMrkM5mt7FcFCx/QIjuf/sYQguKQIGc70R55wbTiYl8eEX7RYJhNrQDeShHMVQ4OkXliY7wv3oP/C/048wfYym/53tmccodbzQoXRtvMrxKERnquXQqVCDRnRqWqV5uz9zuaQqG1XqZSMNp/GDFSA73p/THVrv/EaIz2eQHbVqUFnI+Ne2dBkU3uPnZDwLe6OfDhcB3Ph6wZlQviZQaZSm+vKGiht4DynhhlBZAPcUqww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aq5zi7E/1+y7Bt71Y7AUwaNaDsXRdD5MyPUJUN2upnU=;
 b=ubI7kwdLCvfmT1znUkuzOYPL6lFdyAnCpRfyMmw+nJSH8fdy37qVrrl9s9JKOL9tHeR8RzqvEFJraiBCcEoUFpCS5IwWM7UtarsltGnGNRrXRvrsrLI8oCj8tGMEF4CcCEOrqS51sYnoIDcP37XaLloMKWOjB3/TdgReWcKY6gli7zCVupM6G//laTQDnSoyEAQ0Frlq2eY53NHMOAUfm5FiKIU7dRFdrujQ5XGOvA/E/CojvgQH8FFM+FdqCDVQXCykU2CeHZXUMGmFshpMW3WjVqwwYqY1nZAaVeAZozeVfc93QzJC0MtSFDWBVqkKf/NKRCVR+X7cShZpGzMudQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aq5zi7E/1+y7Bt71Y7AUwaNaDsXRdD5MyPUJUN2upnU=;
 b=vRNQe9UbTs+6gswThtZPUp/e+sylbDDsX3JBUTsWRSZFAzhl6C7AzddQo882KdtXz4VKGHiEl/l8Jx+o6GBgokCjbJZlBGinNbeIOqMCIqpGC8R4445f7kt9F7wLdRktOCj+ZfMe+nQC6B7QjRxlF8j+SUOy2AbzSg4aNibp9M6H94TAocNyhlknVnIhivlx3BMkhDhbcTzId4A/N2aulN0qvTaiKuuBzb+EFE7uuzMS1SMm0bRR+GX7uK2FNB8N4TMp/6gW0HKfqyXp97kqn2xhZOK4fNxUbJ7niP6rAtN6uuMpwsYkLdmx1n5Y9uB8/gxQuNcEjGC0iyJASPV7Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GVXPR04MB10945.eurprd04.prod.outlook.com (2603:10a6:150:21e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Sun, 12 Jul
 2026 13:08:56 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0181.019; Sun, 12 Jul 2026
 13:08:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/5] mmc: misc fixes across MMC/SDHCI/RPMB
Date: Sun, 12 Jul 2026 21:07:27 +0800
Message-Id: <20260712-mmc-fix-v1-0-99a1136bbe54@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI+RU2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0Mj3dzcZN20zArd5GRDE3MjE1MTwyQLJaDqgqJUoDDYpOhYCL+4NCk
 rNbkEpF2pthYAohDSomsAAAA=
X-Change-ID: 20260712-mmc-fix-cc14724541b8
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Eran Moshe <emoshe@gsitechnology.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>, 
 Jimmy Durand Wesolowski <jimmy.wesolowski@mobileye.com>, 
 Iulian Banaga <iulianeugen.banaga@mobileye.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GVXPR04MB10945:EE_
X-MS-Office365-Filtering-Correlation-Id: 66751bc8-2e0b-44df-c48c-08dee016bafc
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|1800799024|376014|366016|7416014|6133799003|56012099006|11063799006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: HRR4fZVGU5kMKR5dHwydEi4Vtt4ZMpiKv9FrzwQYrwVlOxi66wJFNV+6eMw1DRYlx2fFDqctFOCD9tVaSslQEdlMwxqHQq5cXoQhKaU8AVw1jvZxC1hzmaT91bLlMy6wTSANsFBVBXS60MYCturhDoVBcuikLvIdBXp9yHygoTQaERJ7U2ykzjeybYJIAIFvWUSXMjv7Yvxd2nS5yyLJ5RB2SI1pi4cAHo60Focv3bUZB5f/rw6anEZIccI1nTbvN5rvxItAd5mSBr5OZhSgsFnYAVvvAA8Nq8fE+yydH8ywelT5htQOsx8Y5Pp2Ua5/uoLqqjQBF54fnUK+Xx96+//2z89qQLJbby9o1NowZo5mXcL+U78vEBk0KDRHtreGarfduyXQuny3CqiWNsnMkMW9T7PbUaJhCAWiOJhtF9Kjixn07sZPXyFkhnTIjPFnlxzeNNB3Ko+CxnGRKCzbFscB7fiy0XhAt+e05b1qzb0ZfUdQES5QgvQ0Z8aHbHf40CATC0vOolV+6VJhUZJ2El1TC1heVtd69mEHtut772K2re9vqIlDVBTJqcUXaCOQ7k8yGWzE/dmSKOLze5MfV/i32V2h344vkI4H/mSoerr3LAsmMhMF3yL3u6JINY9zcD6LB3w8REhmJoJTpTOgkRTLmgGP1WNo6vWmW5IYGh0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(366016)(7416014)(6133799003)(56012099006)(11063799006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aCsyKzV5RXdDWjdnbGh0bmE0WU9UckdBZEJpME5GZC9KTnR6Tk1VMm5udWVW?=
 =?utf-8?B?MUhEd2F5OTEzMFBWbWtlc0N2cU03bnQ5ZWZidjJtZ283bE1GQjJQWHN2MGpa?=
 =?utf-8?B?d3pvQitLR2EzYkZQWGxobDVoTFg4QU1aMTl4MWdJTURBSnd5dHFNQ29XQUJ3?=
 =?utf-8?B?bmQ3ZnJQOVloK0ZrVlF3c1dPNEtQVVBQWkpaK0JJT0ZCbjh4RzJsZ21uQ2hv?=
 =?utf-8?B?MEpJbnI4dmhiMDh4eXU1Q2dkYi91RXVmdHpkaHBFaVNBN3hoQkdLcEpUdnBE?=
 =?utf-8?B?VEFmMW53N29TMkIzZ01EMnloN2s3dnJaTDJKNCt3YWk2NWUzemEwais2SjlW?=
 =?utf-8?B?ZXlIRzVUYjJna2V2KzJKZDh1Y21QS1gxRENwNThZZjN0ditvMTk2Nld2b0lR?=
 =?utf-8?B?UTBrVERoZ0JCTTNiOUM5L1E2dXV1djNYSlBZWlpzY0x2QXU2YWU1OUpHTVNt?=
 =?utf-8?B?cXZwMm8xY3dIam5EcFRjQlQ5SGx4c1d6blBpcU45OVU0cGZCN1llblBPSW56?=
 =?utf-8?B?Rzk0aGdQcVNRTS9xKzExNFowQXlJSUhKSFVCTy9YK1ZmVHZXbEl6OFJFV3lP?=
 =?utf-8?B?S2wvMlkrWEp1a050c0l6RWdvQm96YW1MVUdzQ2xEYlVick9VbTBtc0k5dEVZ?=
 =?utf-8?B?Z2ZKUG14UVFuYWhKOEhSd0txdzVpVGxoWjYzZUJwRmJFaitTWHdTcWNMYTln?=
 =?utf-8?B?a2szYm52TGZTWTRub1FUVUFNRStscGRURktJdit4L2FCTUcrWklCbFJINTJW?=
 =?utf-8?B?WUpHVGNZdS9TazZYMGlIdFByKzJxQkRydEtSVTRvSGpFUFZTczV0c0NMUnho?=
 =?utf-8?B?N0ZhODJlMDZES3BRenNZU1kzRkk0Q1QvTFJYcWJrWERwVjJlZWVtdjNwMWN5?=
 =?utf-8?B?VXFnV2Z2LzRXckdnM2haRlRkKzhvR0pTaGFjYlRCUFFNUUZpTGtvaVk4L0pl?=
 =?utf-8?B?dnJSYTJtRHhneW1iZnVOYkZ2WFJYMSsrejdHU3FHTUswZWd3SGkxdlg5UldR?=
 =?utf-8?B?OW9tQ2d0bkhyYnJ1ZzE5VHZZN2I2SSs0MjhUcU1uNEp3RUlaWTlxUjNkT1hF?=
 =?utf-8?B?d1JtYVdYNzBlOVlFNTlzekFjeXRGaXhTcm4wSy9JTzUzUTBYR2ZVOVRFRFA0?=
 =?utf-8?B?dkZrMTNIcGRYV0lwZE1oOXBGUFhZLzlPWkJtWlpoVWtEQUxWclhtWDdvVjNh?=
 =?utf-8?B?WVJVRVNvZ3YyY3NSZXY3KzlqSTJxMGlGdG1PTHZxdlA1bnZjbE1lbXloeGxC?=
 =?utf-8?B?OW5DTjBKT0NVSkxFWTVoaHpsL3NCdTFFbDFKVVlkalNzNURwdi9IdVRUTGtm?=
 =?utf-8?B?WmZ0RmhTbllsdTFwZVNTM0k5ODY2aUJCd1R3ZU8zNkd6czdXeUQwWmZuY0J2?=
 =?utf-8?B?UWtkckhjWW1QY3R5V0srZXZSaGxVcTM1cjVlb2tidmxzblU5NDBBbWNXaHJR?=
 =?utf-8?B?bklzNVJ2RlFhUUtYQjQ5ZW1oV1h5aWtKVzI0cUw2QVFTWjRMTDNLTG9icCtU?=
 =?utf-8?B?d0lBTFRCV3NlM3ZudUp0dEdPTUNlTXRWOEpuNW5vdVNwS3NYNmIyZ05MdVZU?=
 =?utf-8?B?VkgyRmt6QWRydkNabnhtMmpVOGtzZENaY3NJY3FGdEZrUjM1TFYyWkNoaGZR?=
 =?utf-8?B?cTdFU2dUaVdKc2hyd08rQ1Z5eUZZcTQ0akRRT2JuUERxWDM4UjBlcThoZ3Vk?=
 =?utf-8?B?VUZ6VllDdGJ2Z0tNY0dsNmpOVTk2bXc0Zk1PYllpZUN4M3I3NklneWliUFdT?=
 =?utf-8?B?WlRIK21DaFZ0VUNsaFY1RnNLRHg5WUZDVGxUeDVMSDlrRzArRHVEZUEyQ2p3?=
 =?utf-8?B?OVk3NVpXTWxObnZVZ1puVGVhcDd4VDE3Y3NQZUVUekdHOEVCYUtFU244WUIy?=
 =?utf-8?B?QlVLdC8zd1NQS3B2dm5sMmJRT1lqSW5ZQ3JjQzlTdlFWd0RxN2Q1Q3Fod1dF?=
 =?utf-8?B?OGVzTHU1eVd3eXgzYzhPWld5SlRTZysvUFJEZEt4N0R0cWRoQ3lyaDdBekZN?=
 =?utf-8?B?QnhQVkRldHpWUTA1WFJtOVhIalp3cWg1UjhVaWNXdkx3N1ZYdjhxSkkrd0py?=
 =?utf-8?B?OUgxRGdlOGxkeFQ3YlZ6bGROMDBrWkR3cFdEUkJmWUV5YmIzV2lXZFBqL1dx?=
 =?utf-8?B?ZHFFdGF2QTc3T2NiMGRMaXEvZFA4VnVISEVNdHRhRC8zb3IzSEg5TzZEK0g0?=
 =?utf-8?B?SVFvV2NjUEFXNThJRmRUYmkrQURzdmdOYkdxREU3SVVFbXJEQWdnaHNYZitv?=
 =?utf-8?B?TEZKUTRGamg5R3F6WGx6RGdRR3p1S2pReWF4OCtZZ2FvblNadWd1M2t3eFdN?=
 =?utf-8?B?QXAzekM0VUQ2dGNMejhweDJ3QmIxb3dTR1lnaDVldWoyMVJiU2Z5dEJ0Mlpx?=
 =?utf-8?Q?f1eYLzFPtV+rctId2RAyeLGHbcBPMj8lyNgJT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66751bc8-2e0b-44df-c48c-08dee016bafc
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2026 13:08:56.7722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0O0qiF9hCcxLMaMP5vRhEXyPnv5PzfsqzN1Oh40VIIhrCsd+he0uI8awop2Hip02cSCmOcY5bkW67TRync/5SDyXP1bwBEv5CIBm7Lb7GSOfkPgEFeI/U6g4GIsVh/37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10945
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

Patches 1-4 are straightforward single-site fixes found through code
review. Patch 5 fixes a regression introduced by commit 906ee6785b1
("mmc: sd: Handle UHS-I voltage signaling without power cycle").

 1. mmc_poll_for_busy() can return a false -ETIMEDOUT if the card
    becomes ready on the exact iteration where the timeout counter
    reaches zero. Fix by returning 0 directly on card-ready.

 2. rpmb_route_frames() has a tautological condition "req_cnt != 1 ||
    !req_cnt" in the RPMB_REQ_READ_DATA case. The second operand is
    dead code. Based on the pattern of the other cases, this should
    be "req_cnt != 1 || !rsp_cnt" to validate the response count.

 3. sdhci_init() allocates a 512KB aligned bounce buffer on every
    call without checking if one was already allocated, leaking
    memory on re-initialization in the non-DM code path.

 4. mmc_bwrite() uses mmc->cfg->b_max directly instead of calling
    mmc_get_b_max(), which the read path (mmc_bread) uses. This
    means host drivers that implement get_b_max() for DMA boundary
    constraints have those constraints ignored for writes.

 5. mmc_deinit() strips all UHS capabilities before calling
    sd_select_mode_and_width(). After commit 906ee6785b1, that
    function detects cards already at 1.8V and enables UHS mode
    selection, but no UHS modes remain in the filtered caps. The
    non-UHS fallbacks (SD_HS, Legacy) require 3.3V which the card
    cannot revert to without a power cycle. Fix by preserving
    UHS_SDR12 as the minimum fallback when the card is at 1.8V.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (5):
      mmc: fix mmc_poll_for_busy() false timeout when card is ready
      mmc: rpmb: fix tautological condition in RPMB_REQ_READ_DATA validation
      mmc: sdhci: fix align_buffer memory leak on re-initialization
      mmc: fix mmc_bwrite() ignoring host get_b_max() callback
      mmc: fix mmc_deinit regression when card is at 1.8V signaling

 drivers/mmc/mmc.c         | 23 +++++++++++++++--------
 drivers/mmc/mmc_private.h |  4 ++++
 drivers/mmc/mmc_write.c   |  6 ++++--
 drivers/mmc/rpmb.c        |  2 +-
 drivers/mmc/sdhci.c       |  3 ++-
 5 files changed, 26 insertions(+), 12 deletions(-)
---
base-commit: 6741b0dfb41dc82a284ab1cff4c58af6ef2f3f9c
change-id: 20260712-mmc-fix-cc14724541b8

Best regards,
--  
Peng Fan <peng.fan@nxp.com>


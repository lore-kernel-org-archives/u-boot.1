Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FA1CD37AF
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 01:42:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB8DD84ACF;
	Sun, 10 May 2026 03:41:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="D1wcKbIV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DE81846C1; Sat,  9 May 2026 22:13:37 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazolkn19010023.outbound.protection.outlook.com
 [52.103.33.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24696846B2
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 22:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9cEYx3uW27g4ivv3fva/xfrDBNW9EODaPh4BHgUFvKDGu1U2bwgE68Sp8uJboaSObng5cCOFYCDf5fX28Z5asryKMgSYFStlWa/VY/nynr/Wuj4xVMHhsO1ZyZOoWEm+oQNgmR0FzCZMMTbSWSGF/fyWnfNojZRCqJNJtMpBbKseK3r4NXp3sHXJyFGFCawXBKLKnGoJOIgPr9mRbTfNawZcmqx7Z6lrXVfpOarK6sIqtj/h/Yo2Dya7WT9Q9lNZwkwNxW3ylyNALyBCJAXee4PKwVD5S49zalb8etABewTcjU8dUlsuDzLDghD5K58e9+3O02+l67dDg30oazq4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wPzlV7O9X9GMKlsg6yosrbAWgR7iItAjkZ6pEGfNfY=;
 b=Ee6DwhfvryC92kiEvQ7Qy6TaEbdkjTwtFJoehRBIRqx2Stn45j1eGGwAGYMfcPxRRj4BgLILUN07qnrKF4IeqWc+lAF4EGNxL81oZQLXBlxBHuuTylNX+3VHEVSRC0pqmf73C2/+vSqxqnNK6V6MrBglWWIV+xyiXwKzC3xPTxtPGgke4P/vbBGyZofWSQS6zlXl4SDhoDaf+KzDwb45LM1WOj1tUeT1SnFsF/MDwkpgVpMK8Fx864SxWrPKl/ICiebe8RSM8a2R1q12+EdyI55oCm1jhhwnKtFyGYVuDsJ0ibB/ipsCzMXu3dlYw3+c15mJWYCidGFiY/BhQn1JHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wPzlV7O9X9GMKlsg6yosrbAWgR7iItAjkZ6pEGfNfY=;
 b=D1wcKbIV5j5k8szXsjccv/O4vFIwgkZ9Yse6aJJg2I0MlEgEM/iJpBQO5eztrBVdmWEgqPoWlcODaVc7dOTDvMNPj8pl2eA+MxY+au10X6Jw7NC5x2h8ArLIy95sjiqJGPYWa8YnXK0tRHZyJeMiPDrO2gn/pVyCxYFWNh/TGEUGFpGeOiKffOJl0XVpkvBKJjFpD3zSlMYcc4bRVuvNIfDEZMHrkRFuGYfEO8PApKlp6qinBy2du5aiDoi4e4XvYGF7bUVgGe+1GoCRROYjJ0y/L3XOrxdy5egNNBmAI7lVeXB4sdfpM6d/WgSWe8ufTGZ1zyxMIj+gzxKy5HrfeQ==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 VE1P194MB0735.EURP194.PROD.OUTLOOK.COM (2603:10a6:800:16f::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.21; Sat, 9 May 2026 20:13:33 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 20:13:33 +0000
Message-ID: <BESP194MB280542535B098A33C8A815EEDA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Sat, 9 May 2026 22:13:31 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Mark Kettenis <kettenis@openbsd.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] nvme: apple: Check memalign return value
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0222.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:374::19) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <824fa85f-f349-4d64-aeb4-a7718fbe4830@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|VE1P194MB0735:EE_
X-MS-Office365-Filtering-Correlation-Id: e6de5aea-ca99-4097-66a3-08deae077211
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|41001999006|23021999003|19110799012|8060799015|15080799012|5072599009|6090799003|5062599005|37011999003|55001999006|24021099003|440099028|3412199025|52005399003|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFc5cWxpVldwanRuSGJsVG1zbVpGZlcrVGl3U3g3WHBzL3NkUGpQaFRVZ2dE?=
 =?utf-8?B?RE1yMzJzcTdiVGtzbE1QTklvQis1c0ZQdFkyMTdwZ3Z0c0xqMnBubmpFNFZp?=
 =?utf-8?B?alNzdnpGdkliQWlHTUx2aFpOL1ROa0hJY0JwQTIyTlBtSWhUMU16clNrSFEv?=
 =?utf-8?B?ZitCekJ1dEswVmNpai9WYkZZL3FSL3Y5aW9TMW4wczFYME9sOWRLVmhKS2Jw?=
 =?utf-8?B?RGk0Q3V2YlFHRmFVQlN4bTVTQ2s5alM5MmozRHBLdFJZcEVLOW0zOFhZbHFW?=
 =?utf-8?B?ckhDd1g3NS9HOFBEb1VIMWpzYkxXaHlYQkhwQ0I2V0s3ZEx5cGt0K3NIaEF1?=
 =?utf-8?B?cEhTM2NMY0dwc2tDQk9la1BYUGM4K29taWxrUnJDN251c3AyV0YzR2V2RFdt?=
 =?utf-8?B?V2V5N2sxSnpKdlNab1RqT09mS05iRTZtaDhyRElUNXRiOEErY2lIQ2xLNldw?=
 =?utf-8?B?OGVZZi96RTBsa2xaZFZ1c0FJdEdXRXhuUzlvWWRiMmZvWXdGd3hUOVkxek1s?=
 =?utf-8?B?c29YTllMeHQvQk1jMC9YRnd6bGM4akpicm9RdzJ3clYxMjFZQzRFWVkvczB4?=
 =?utf-8?B?d0JCRUVVYmFubVcxNHFIbDF4dWdnT0RLRldDSDdobjZVL1JVU1ZnMVZwOGZZ?=
 =?utf-8?B?cHNTWE5IQjV5MkZ2N01nK1l1aSsvMWVUbHVIeFdpeVBaclpOdEQ0WGNZSVZr?=
 =?utf-8?B?UDMyQWgvdFpxQlZaQkhicDNmK3dzbCtsMVhFM01UT1NKdElZUE1kNmRKZ3Fo?=
 =?utf-8?B?TEowakEyMDBVeURreW1SSWRCRnJ2QWtUSjhELy9HTVJqV0ZyM0gvWDdpcTQr?=
 =?utf-8?B?a3RrODN1V0JUMXNGZFpRV3JrMDdVbmNITlAvUG02cnovbDI4WGtSdWU1SjV6?=
 =?utf-8?B?K1hlMlBoVTZwQVJrM0F2SWU4VnpwUGxOU3U0TTJJR1lsTEU1RHpEdkI0REpm?=
 =?utf-8?B?TXVGWm9hcFZiN2trZGtVODQreXBCSFhUT0JUNkxFaHYyNEZsWWFST3kzNXN0?=
 =?utf-8?B?NDYrSWJNZC9FRXV3bE5oR25LdEZWa2VlR0IwS0o2bG11ZWJSWFExaVk0SE5L?=
 =?utf-8?B?VXNCZXJPN1NoZ0tGdVpiOURNNlh2OGNuVDlnMTV5ZFloTndHNkpIbWNIZ3pF?=
 =?utf-8?B?aGp6YS9lb1pvWitDckV2K2FCOGxHT0w3dTlxQnBxdjF4REJEV1AwejVjZWdQ?=
 =?utf-8?B?MERPMnlxNURpVWdqa09WeU9YdzNDK25VTGhDYlBFL1RjMzBnam5GdHpKbWhT?=
 =?utf-8?B?TzZsN0x6MFRzd1JMWU1tQWJnL0VER3k1bnVKdlFKc2RXLzVaTStzZXRPSkho?=
 =?utf-8?B?OUgxQlJnUEZ1SW1CMTF3TkY2Zmo2dkJVZllsc3NESW0zcXhsc1AvUy9Hdmov?=
 =?utf-8?B?b2pzYjBTc0ZhUVhWNElIQXJqd2VqMmR5aVpxUTY0cU8rcEt0Tzd1aDZQNE9p?=
 =?utf-8?B?N1pRajVvY3lQWFVmMFBWbDV4T2tvUnI1dlQxOHRnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NExBaG9BTXBCWVdzak5qa2ZxNFgxT2YxMGJkRlJxMFl3QUlKV09zZm1iWnFk?=
 =?utf-8?B?OXdETUE1bitkTDBSRXpOUlVLN0pnbVo1bnJWaHl0RHRHdGcxMDBORWdxUldk?=
 =?utf-8?B?bWVSbXFxM09qMWY1WHNmUzJsVHI5UlpSNXRua0x2bXNsOXJERkxoVEdNd29S?=
 =?utf-8?B?bnQ2MnZqMENnYmRvRXhFa04wdUxQY2h5RHlXMW5jZGZuUUV3d0E0ZUtGVjJm?=
 =?utf-8?B?NnJxZ3FVS09IamltV3RqQjJYMkx3aWpMb0s1RnZrLy83ZWIrYURlSkQ1dUJQ?=
 =?utf-8?B?eFRVa3JxazZNTTJuQzlvM1Bud0hQUDU1THlZTU9TN0paS1hWd2ZyMjRPN016?=
 =?utf-8?B?YVk5dG1MZVhrallHS2NOVS9zcCt0alBsR3Y2RnE1Z0ZQNkdwL0dua3hPSjdl?=
 =?utf-8?B?WHcrbjByY2RpMWF0d2M0Zy93bm0wemlxcnJEVWxRMWZlUDZQV29KVG9hUmh3?=
 =?utf-8?B?NlN3Nnc2SkxsYWR4b29TMXBOMlR5eXdGOEM1WHlSV0dxMmZVWDhBSkp2RTFC?=
 =?utf-8?B?MUN6RzdWbDVxVC9Zdzd2SmlJVmJ1ZXlIU1A3YXVhMStSV0pwTzh1dVNJYmFy?=
 =?utf-8?B?YmxIOWxZNVdkYmdTbDhpSkhyOElUaVZEUmtuN1ZVSnhJSi9hUmUrd0h2UWJF?=
 =?utf-8?B?S0hjdm42Tk12V0lwOTJqTGJzb2xYSm1zZEJ5TWlMUGJNTlNpYjhxYnAvWVQ1?=
 =?utf-8?B?RDlEdnVCZzZNcDJIZVJ3cWl0ZFZVdWFhblh1a1dOSmR0RnYrRGsrTE5CZlF4?=
 =?utf-8?B?M3dxZ3hELzh3YUlXaUVsZERDU2c3SnVvVWFzc1NMbTZLYUZ1bURZM0tNZVVm?=
 =?utf-8?B?S2RTeXV1YTZKVzZMa2FBZ2crWE1SSHUyZWMwUVEvdDRUc1FIeXBDWXVibkVU?=
 =?utf-8?B?MVNzUW10eFBJbC9naXYrcUM2ZmIvbnVxejlpdDVvamU4Tk4rMlMyRVZLTUJo?=
 =?utf-8?B?UlAwc1hWNVBFRE5nZXRwcmFBaGVKQjlsWHJkaml3M0JWNlRiSTQycUxHY3Uz?=
 =?utf-8?B?VG5XT3craFA1UkR2M2VHS1JEY0w1R1VqMjBnNkxTSlZoR3BabDh1ZDIyYmtY?=
 =?utf-8?B?TjRPa3JLZWkwclR2M0JHT3hXVFFscTVERlIrb2RXd2owTDlZVEpGWXBCMkhJ?=
 =?utf-8?B?Q0VTb21aVVNJMFlCVmVCS2lod1RrWlZoOEE1SlRxaFlKUE11MFdqWVZaamc1?=
 =?utf-8?B?ZWtFaDhDbCswMEo5RkRhSGU2a0xUZldSMVZVbDA0SXdFZVZpYUxuSXVRZ3BP?=
 =?utf-8?B?YTE0RFVMVFF5RDZCRUZsYitWT3dtT2RveWQxQk1EOXlxdDdkTy95VmRSMnZj?=
 =?utf-8?B?RWJoMjY4MGhac1M2OHo5eWdER2tLaUNuM09UWmRybmdwZmZnaG5uWVFNaFRu?=
 =?utf-8?B?dDMyZGswTERUaDE3b2lWNHZ2cHJlTmlVVEk4bitIaERDUWZpQU5OcWlXbTRL?=
 =?utf-8?B?Nm1kS2w3bURURjVUWFRCaDlhMkpOWHZ6cXdsR3hYazZKcUN1YVRSOUoyRVRy?=
 =?utf-8?B?LzVlYUxoQzVTYzRtcFhQZXpEbWozc3V1amtLSW5Ydk9ycStJVTM5R0NQeHQ5?=
 =?utf-8?B?cExVQmhtTFZuNW16SVJodFI4N0pJMzNWRWw3VDhKSkRDMTQ0ZTM2MWUzS1lo?=
 =?utf-8?B?NXA0dFFlNkVOOGRTSC80R2dEVjcwb3BzUThCbmFQT0JRTjNKUHlOUDk0WDFm?=
 =?utf-8?B?dlExRHoxVkwzM29MV3p1YkZ2RExicGVJYjNsb1RSZituWnZBR2hvQ1E4eVVp?=
 =?utf-8?B?SUhkaG40TFpFcjkyODhHdHpsSGVzWEZubDFDL3dWaTBGd0ZPNUF5Qld3NFlt?=
 =?utf-8?B?SkUzMlRyVXJQbnoxSmhwalk1NkUxcS96YlQ5SmN2blJnb3pJcFROMXY4VWVy?=
 =?utf-8?Q?hr7xHBdIr0uny?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e6de5aea-ca99-4097-66a3-08deae077211
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 20:13:33.6787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P194MB0735
X-Mailman-Approved-At: Sun, 10 May 2026 03:41:44 +0200
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

memalign returns NULL if it fails.
This commit ensures that we handle this failure before
filling the buffer with 0s.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 drivers/nvme/nvme_apple.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/nvme_apple.c b/drivers/nvme/nvme_apple.c
index 7e7538553e3..46af1d716ff 100644
--- a/drivers/nvme/nvme_apple.c
+++ b/drivers/nvme/nvme_apple.c
@@ -87,6 +87,9 @@ static int apple_nvme_setup_queue(struct nvme_queue *nvmeq)
 	}
 
 	priv->tcbs[nvmeq->qid] = (void *)memalign(4096, ANS_NVMMU_TCB_SIZE);
+	if (!priv->tcbs[nvmeq->qid])
+		return -ENOMEM;
+
 	memset((void *)priv->tcbs[nvmeq->qid], 0, ANS_NVMMU_TCB_SIZE);
 
 	switch (nvmeq->qid) {
-- 
2.43.0

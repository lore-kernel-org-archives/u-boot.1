Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04914C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 12:31:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BDD18845B;
	Thu,  6 Jun 2024 14:31:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="KdXEm182";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8133D88103; Thu,  6 Jun 2024 11:12:21 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20713.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::713])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A2BA8829E
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 11:12:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8C+edxu+RkPdDDeQkGN1eNhXiTiz2/g1edaNrFSGonUv6knsiWF8Xtc3v+XoE+ihz5cpJOAanLR7HS5Ou6252NexkYgx53z6UAl3xeqFl6+KWJIZd7pZQvIvg/wn4l4QZ2yx61LfzDS8Zesy7d69ML/wJZc9dBmy5EqKhsGRrxTJEPUxsQ7hEJWMVzPO28s3XYjjUaQLCwgKbaz0T00h5mFIB72HkPO/ahqUhnTh+LuFpTizlaR+AsBXOL6EDI4CugE3Gh56BUvNJZnWrApMlkn0ypkMP/XwKOyE1rQtN7tfDeJEhWVq24U/uRgRkZ8yGlanUNQuYWWpR4K54YEPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0naZF1YZqgaK81wPmvzs+a8yeisfi+mDSkt0reQS28=;
 b=gtOq7rDgVciAz9u0iyHVMO3htOn2Kmqftu3r+clC8gsutGknDmVOhZ0UfcSmF7h4BZh+PwnruSxTFNM1bel/LKYFL7+utyHRZht7f1h5t+JmPFM1Gy7z9N+BAGdKayVFhQ5FNldaE3yFb9iLcUnfHHKNKrQZr4TochpCFs6FdJ0XB57/xIWZpueNOxbYJ0IK70rAPY4EEGsRbtHxUJreVnXphNUovGCzeiIx48LvN1tznPWhRRRLE5zvQWNqLWSsGlBy6NKO3QzRpwAzZ9ZVTL+NszNB+J/9J1LWLpPczvJDeNxXPSjVY7fGYkRWFpCsd40+BT+wUgBqp6wDl2W2DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0naZF1YZqgaK81wPmvzs+a8yeisfi+mDSkt0reQS28=;
 b=KdXEm182pW3BGj031L5NggsIjuBSBN4VP2AO6m4DJa5GUHGcMFBcttDEyc+u4zTFBRRKYf0kxn25UUgYCcoGJ2X/iJXfRBMp9BjFeLDsaqOnlI9lKbMbvZdqf/kDrNA3drZn3xaWdUoF6L/9TpWzJEkaGNRIHOrPNVN86qfUz7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by DU2PR04MB8952.eurprd04.prod.outlook.com (2603:10a6:10:2e3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 09:12:16 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 09:12:16 +0000
Message-ID: <85d02b8a-dee1-42db-a804-d065517391aa@cherry.de>
Date: Thu, 6 Jun 2024 11:12:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] misc: introduce STATUS LED activity function
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Eugene Uriev <eugeneuriev@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>, Raymond Mao <raymond.mao@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 William Zhang <william.zhang@broadcom.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Pratyush Yadav <p.yadav@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, AKASHI Takahiro
 <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
References: <20240605192146.19052-1-ansuelsmth@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240605192146.19052-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0008.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::24) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|DU2PR04MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: f77e7f03-40c5-42fc-c96e-08dc8608c273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|7416005|376005|366007|921011; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlBHL1Q4WGIyM2c0MFhZcDZPV0pya0RqSU5RWkNmbjdRR2gyd25YaXdGT0dr?=
 =?utf-8?B?TEwzbFZTQWFrVklXbit1L2I0UHhKcWNuNit4MTdrRFRtZjEwbGJVdDBUUDVS?=
 =?utf-8?B?WXBiTEFVdXBCbWk3NW5VRW93WEE1RWwyaVZBamVKTzB4MGRLTG14TjE0My96?=
 =?utf-8?B?UjhkQzFPTGtvVEU3MStBMUlkNXdqbExsdWZ1QUEvbFJwRUt0eE1OOExYTHE3?=
 =?utf-8?B?L2JhSXNGTW1VOVczb2gzRmcwQWtFUjV3OWJJSm9pK0dBNGhQcW4ybUJVN1A5?=
 =?utf-8?B?dUdYa1FNakg2eHU1RnNMaGtJTThMR1lScGl4MW8vRXZ2N0pRcitIRUpQck5C?=
 =?utf-8?B?b3FXVmJ4WFpKSDR6K3dObTVvVGhpcmQ2aHlDSTNaOUd3cGVMbWk4Wi9vSUZh?=
 =?utf-8?B?bXMvS2wxNGwya3lQQjQxVzZZSDBHTUlkNVRhVkNIQjZ6WVdYaGt5T1ErVkM3?=
 =?utf-8?B?M2lhQjBtaGVnaFBiNlJMWTNaRi9JYlYxNDMzR0Rmb2VlMnBkMzNPbzhIZWVF?=
 =?utf-8?B?N3l6NHNVai8yaFNpWFlxWG85OFVMV2dlcERGUVF5dHZ4dE5EN0hIRGxWd3hr?=
 =?utf-8?B?OHhiSW1GRTk0c2RzKzhadFNVWGxWM1JZMEFjL2EvL1d1dnZBT1FQbDVUY2FY?=
 =?utf-8?B?dTltNE5QY3FpKzN5WGhTQ3VXdUVTaHNQVjJKdWxhb3I0NE1NN1ZaMzlENGdh?=
 =?utf-8?B?N01WVm9NQXVhM2kvTnR4VlBheHFKYXhQdmFobk0ySkNiNW1Qa09USXloeXdo?=
 =?utf-8?B?VTI1cVFDVUVzQTZDNTR3MExrT3UwZDJSOXVIem1COGl3bUhYV04waGVaaC8v?=
 =?utf-8?B?UldJb0cwbWJEd2QwVEVTVFZVUkozWW45UFp2azJzWlczdkcyUWZwNFZFQUxL?=
 =?utf-8?B?R0JBb2pyU0tuTTg3NXVuTGFNYmNGNkZVQmpkR0dtb0N6Z251MUZqREdxamhD?=
 =?utf-8?B?ZmJic2RrTzhpZnJxR2ROeDVrS2JPQjkxNzJob2lzdzNSVndhWEZSZ0xBNTJB?=
 =?utf-8?B?OERWL3dpb25DbHM3SXZOb25sNXhleTl0RGNXQlFtaWt5VWdwbmZsWTVXNllp?=
 =?utf-8?B?RkRlK2dSZ0tCcVlJdDh3dDN6VkxEdTNCanByMXlmQjVKS0ZhRXV0REZJUTJY?=
 =?utf-8?B?Zjh2L3p3NnkvNUdSQ1JVelNXQTA0T1pxQ1BpMlhjcTJ3cVA5OXJ6Z3FhWXlP?=
 =?utf-8?B?cDlydmVkNG9PYVd0SkZvNGZKNVFHK1duempmVGpER0N1d1lHZEZ4S3Rha1ov?=
 =?utf-8?B?ZUswY2hia2hDdDRJWnJjSVUxTE5tc1ExQnBNMkNESkRaL3FnM1FLd0ZqQ2k0?=
 =?utf-8?B?VUhETlR1M2pmUGtxN0JiWmIycWFGNHFab0k3TG1rbmg1Ri9BMHdqZjNMU1J2?=
 =?utf-8?B?aUpLTGhnSjVMdHZsUEF6bGh6NWxZWHNrQ1VQV2Z6UWdMOHV4eVg3RjZVS1RS?=
 =?utf-8?B?ckJFdS9jNzZDWFNvNVhaWE84VDJDdmtFaTVRa2JNc0hHRkR2ZVpjS1FKaENS?=
 =?utf-8?B?OHpMV0NuK2UveEttUDNzQ3ZBREpVSXhhWUdzS0JNTHQrcDhHUEFkVEMrTXF6?=
 =?utf-8?B?MHBzOFlzUldYSmNmaGc0NGd3aDY4UE9kYWhxb1ZJOVgzcDl6L3BJVlhWaWQ5?=
 =?utf-8?B?WlN4cXdaNGUvb0lKa0ZOVWhwVkZ0YU9DV2dyZ0tSR2Yrc3I5RzU5amd5YnBS?=
 =?utf-8?B?ajkwOUxWaFIrTTFJbFJGaU9hUGxHcFQ1ZXpWUWhNT0Uvd3E0TFdnc3p3NSt2?=
 =?utf-8?B?QllnbzUxRVNHUGN4M1NxMFptTXBvZUJZRE9sL3VzRlM4eXFoRllkTlFRVENO?=
 =?utf-8?Q?McLyqa4ph8bWMZjUlxvOcN4CqH8rNxYbf++7s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(376005)(366007)(921011); DIR:OUT; SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXJuSDlKU2d6dnpZVmZ4ekgzM1I4NlpUQW5RLzFvTmtXZEdxTkhXOWRpbUtS?=
 =?utf-8?B?blJnYnRYS29NeGllMXQ4OTFoQUpwT0oyVXRleFlveVBpQk5HcDFXZ1BXdHBx?=
 =?utf-8?B?dnRxYkVHb2RNWmxrNzU0NHBjN0c5M1BKUW55YVV6RGVPUjNBcFpIY3dVYVhh?=
 =?utf-8?B?MVJYK1BRc0N1azBaY2syZTdKQ3oxN0xhc3hoY2ZCZDZjNzk0WmNxN0ZJUG5T?=
 =?utf-8?B?ait3bkxqMzZyaHdxVGV1a0NjdTlQNndKUWNHMFp4cDV5OVFiTHozZ3gwN3pQ?=
 =?utf-8?B?bU1UK1RVMnVhaE0xYi9TUEU2MUIxWGNER3ZGMzM1Wk5RMFFBVTdnUnVpOWlm?=
 =?utf-8?B?c09yM1FQcW1jRnZZTTNrQzhiTk90NXRnSVljbjcrTmNYOFcrWVNzQktLVzB4?=
 =?utf-8?B?Z3E2SzM3NVg5OThPdjAwQ3g4SkdGQmVnak5hdm9TUVFQOGVQWjdZTE5kZXBj?=
 =?utf-8?B?dlJEUkkzTmFTVEZraFVoRkZYd0hmcjB4OS80WDlPTnpYc2xENUthNS9aaVZS?=
 =?utf-8?B?dGtnK1I4LzhsL1VYYVpkRGZGcHlWWEtrM2VKd29BaUFyMkRnb3lJeDJIVDN5?=
 =?utf-8?B?OU4zMGQvYSs3RS9iUjQ5SmlQRVRjRUVDbkJrM2Yzd2R4SE50YnFjRVVZTXlT?=
 =?utf-8?B?VmppR1Q3OCtUeGlES3prZHpHNkJNS1duMlZNWlBkZWM1OWNlalMxTUxsOTBT?=
 =?utf-8?B?MXJ3Z0NSUVV3WHJvaUlSa0laVVF4akZyanZ4d0JCQWhoVUw1V2x0S0FaZlkz?=
 =?utf-8?B?TGNsVHlGRldzUW8xYmI2MlhHQitLcC9kQ1V5a1JHd1hYY2RiOW96SUY0dCtD?=
 =?utf-8?B?eVlBeXA1c3dMU3Mzb0hoejIzSHFUUjE1RTZVYXBtQ2xiM0RTTHExSUIzMFpU?=
 =?utf-8?B?Y0FTOWFMZXh3Z3RZOERYK1F1M281ZVRSVGl6T2JzYjU5QTRHVzNEdTdBekov?=
 =?utf-8?B?WUhJeFNPTXExdU9nYkkzU1cvTkpXcmdLTkdFR2ZWVnZ3TGNEeG4zWEFMdnZP?=
 =?utf-8?B?NVJ5QVFmOFRuSGE5eDFLcWp0SDZGL0RCL25TVEQ0V2gzTTN1SmdSNWl1VEox?=
 =?utf-8?B?cS9GeHRvcmhFZHlrZjRPTUM0dFpSVHBUM3YwUGJpZW94NDBkcEMrcHVoR3Yx?=
 =?utf-8?B?WUNqYTh5RzV2RS9yZ3VTb0hPRXZ2eVJPaTRRRWRjcW52UGNqaUNLaHhIQ0NV?=
 =?utf-8?B?ZFAyaTZNT1FjeDJuSjVFZitiYUZvQWp1N1hmMXZnbm01Mmc2UXNLZW5kVEdq?=
 =?utf-8?B?dWdDUjI3UzAveDR3YXZIY0x5MlAreDFMa1NyNG1ndDFlVWxCVXF2MTBleVZu?=
 =?utf-8?B?QkJZWlFHdUNIdyt1RERZd0cvKzlkNnJuMU9CaFBUVituMjhaemZyaUFEMU5D?=
 =?utf-8?B?OHgxbFJUcHlJTUNDMFpVTHl2YzJoeEdJUGdqL3pCeGx0NEZTVjdKWXBna1Y5?=
 =?utf-8?B?YkJyUHR1OUtzTHlRUzZ1bytwcUxINUkycjJuNnRiS2QvZHBKaGt1TGY0R2xC?=
 =?utf-8?B?M29ZWE5FZFFURlRJRm1BTmsxdFRrYWlEWFh5UVgxRWV3Qzlnb2lXcmllb2th?=
 =?utf-8?B?eTVvY1cvUWtWNDRiUU13Q2lRK29oUkd3QjlGa1k3ZFF1N2piZ2tkZzhxR3pl?=
 =?utf-8?B?dVhkTlJCYVpQTUtBa2xoTDRKRThDZjNQMjJRMld0T0RrOGt6NC9kdEpHYkNa?=
 =?utf-8?B?ekhxQjM5Y1ROS3ZLK3pSRE1sU1VPVXZiYjhhMVpOMFdRKzRRNVVOSzE2UEtJ?=
 =?utf-8?B?OU54cVc4OFB6NlYxcEFWcmtFWUpvbVlqL0pxRlBkSEppb1d1ZDF2YmtWdUV3?=
 =?utf-8?B?Y1VCZHdNdklaRWJSTWpJZzB2ZytsQlpjREFOWWxYRWdnTFpiNEtCa1cvSDRx?=
 =?utf-8?B?Nml5Tnk5MDFGcEdnTnJ3bnhua2lWZkxHc2haNHdqNFhFaUU2Y2R6L0JZOWFo?=
 =?utf-8?B?bkZBQlVLR1lvZTZtQzg2L2tQaEV3bEtQSW1udzNnYjRyYm5uUi8yR1Ewb21z?=
 =?utf-8?B?cUxtMHpCTlRGK1hFOHVLd0k5ZTVXNE9WTXFzYTBteGNhWDc1STBUNGpiODBC?=
 =?utf-8?B?dHlBWEhCTHpNQkZ5NzhSSWw2SlhDN25DYUszaHhPQnAxTmhLR3JCaEV4bVp4?=
 =?utf-8?B?N2czTnhsQjF4ak03b1I2MTBYeFRUMFRmN1lIc21CajZZWjlqUHJTNVErdnVG?=
 =?utf-8?Q?67N365iMKEvJTJX6goCQPZo=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f77e7f03-40c5-42fc-c96e-08dc8608c273
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 09:12:16.1640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FGsq81tKQgfi/7Q44jfqRMEsGPilWPr0hpYMadlQvJRTltlX4DWP1VtRU7UQWTh1ibNhqWHZDgpPZyNyTAIkrwBbTaVeoPabEVpXkA5jblQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8952
X-Mailman-Approved-At: Thu, 06 Jun 2024 14:31:15 +0200
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

Hi Christian,

On 6/5/24 9:21 PM, Christian Marangi wrote:
> This series expand the STATUS LED framework with a new color
> and a big new feature. One thing that many device need is a way
> to communicate to the user that the device is actually doing
> something.
> 
> This is especially useful for recovery steps where an
> user (for example) insert an USB drive, keep a button pressed
> and the device autorecover.
> 
> There is currently no way to signal the user externally that
> the bootloader is processing/recoverying aside from setting
> a LED on.
> 
> A solid LED on is not enough and won't actually signal any
> kind of progress.
> Solution is the good old blinking LED but uboot doesn't
> suggest (and support) interrupts and almost all the LED
> are usually GPIO LED that doesn't support HW blink.
> 

I haven't used it yet but we do have a cyclic framework now for things 
happening in the background. I think this is a good use-case for this 
framework? Something would set the blinking frequency (could be from CLI 
directly, or as part of board files, or architecture, etc...) and the 
LED would just blink then. This would allow to highlight stages in the 
boot process, though that is not like an activity LED so if you're stuck 
in a stage, you wouldn't know if something is still happening or if 
you're really stuck (e.g. no packet on TFTP or TFTP very slow). The 
benefit is that it would be way less intrusive than patching all 
commands that could make use of that LED. Right now, this only adds 
support to MTD, SPI and TFTP, but what about MMC, NVMe, USB, other net 
stuff (e.g. wget), etc...

Cheers,
Quentin

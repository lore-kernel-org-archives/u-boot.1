Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EF9CA0EC6
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:21:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCFFB82AC4;
	Mon, 18 Aug 2025 12:21:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="CI4Oz24c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5684182AFC; Mon, 18 Aug 2025 12:21:15 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0654082A53
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meZOHqcKccA7lkxW8cqZ7Oj5ZGTjz8tvQqRlFDt5WHavVDFiQy6gbHbIVji0teafrfWOHzI7JkvVK/pwktB2OC/QWeZXK2SO7hW0Jv6MkRecdct3g3zioDClWVI4u3fIz9tmBtIyPIo268WPlOU98Sa5z4YtyhF0SkwPJ/yRd9IHOpYmruMjDO1Cq4VXyRdSMgshnrProWdpHnvfup43ex/BO3xdlG1cDOGh5Dc77ZWslN5rAqKObZlw7ZIGmiqLwGUwBDaDXgsU/8HhRNgHAFiu1OBhe8Jzf2hfGkBqt32lrgvTlST+F0lWVDcNeMAhAaCrouCL8Kb3Rt0gNgozEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zX/Rx+NGIQJ+Olkz4qBP/gPbycr3Ed77LM1k1cPftAo=;
 b=IXL5n/5LqayleUPlgHkKHU+uN8M7VhGrU3bea3/Txw6raChAToNDsPschp4b6yf9ZfmiJIAfnVmOmrkICA6etUz97X/6l8QrO6ZYDwXiytRHkf87Bi5YvmdtRs0zaoTsMiGuFcSiWQklVR8+xsf9w0xojBAGHxdd4IejT5YPgrASksEyvWSZKmsf0C6Y3IogCoKij0jsgdlRtcu07p+ZAN2jvlFWMk9r/+F4ASrkNx5ZYPuyn5fJcIUuZ383BkXNA+jIkfFpT0FDjqfAiSKBKgaO/FJGJ7GB8rXyIPbdzWaARJvO5mRu0ySMPB7/IdfGWxTHvxRYLUvrRBBVJFKBsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zX/Rx+NGIQJ+Olkz4qBP/gPbycr3Ed77LM1k1cPftAo=;
 b=CI4Oz24ckJxnso+ydE1iV4B2hZb/c5nXfc6Tp0tK1XF9NIzukfgt20jBpfhQhHJDiC1CIWPyDAKU383HvbZNwZXWdwbDsX5UO5Nm5lX71mxBUqfVISA6sCun2hATST5JdrI88rUYHUhbavIE7CYdd6lrWAY/pDeMRrk2n+1F6FfHXxVhk9exfmgKXsEWo3dujB1WKFkTcGPs3RlIPeZzNamyD0yWgXoJYtH1q2EQUvkp7RhjjPb8EIYPI1qJyVp8SZnKmlzwx731UdN+AlLnQ1QqCLSMlfRiHZPeMFQ6B9EA7aVEwXeuWckQrYo2Bv2Gb1P44gu/7cxa44MC3eEpqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DUZPR10MB8127.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4b0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.22; Mon, 18 Aug
 2025 10:21:10 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 10:21:10 +0000
Message-ID: <221fbb2b-1999-4696-a416-27dd9220da81@kontron.de>
Date: Mon, 18 Aug 2025 12:21:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] mtd: spinand: winbond: add Winbond W25N04KV flash
 support
To: Christian Marangi <ansuelsmth@gmail.com>,
 Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250606072140.18824-1-ansuelsmth@gmail.com>
 <20250606072140.18824-6-ansuelsmth@gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250606072140.18824-6-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::9) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DUZPR10MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7f73c8-fdaf-4086-f9dc-08ddde40f343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzJsYU1CNTJTVFgxM25iY0tXZWpXQ0cvVzdwNTFiZVM0MEcxNjVCeTdHeTY3?=
 =?utf-8?B?aEhjTlVlUU02V0RXN1hoZ3NPVWIrRDRsWENzZXM3UFB6QS9sTkZjT0FZK2Zy?=
 =?utf-8?B?MlhhREU0LzQrQm1TWTZpeDhQTENENitMZHZMVnN6MHp0LzhnV2JaSmNzZm9o?=
 =?utf-8?B?K3lFS0hwaVlPSDJvZVNHK1o5dXZUMXRLUHExMWphOGV6Zi9TRDBnd2hCQk5S?=
 =?utf-8?B?SEtET0psL1Q0eDB1ZGt3Vzh1aWw3UTczMklyUmhQY0RnSXR2cXUvVGxRM09z?=
 =?utf-8?B?bmVtTmJjVlM1TTZiZmVabGFFNHFIeENTaWpmTVNaRFdQWWJpUWF1YnVuWm1H?=
 =?utf-8?B?RmsvY2dpZk9lZHFUOE9HSjRIQVEvajd5Vy9qK2VxUlVuMFJ1eC95UjhXV3gx?=
 =?utf-8?B?RjhPNlp2WGM1RDRTSFZkV3V1OVRuWTJhSDVsZ0Z2REVkVkdYRVVaMmtxY0U4?=
 =?utf-8?B?WFFHaEhvSW1Kc09wZ0NlYUREeEd4UjN1THF4ZDJmL3FnYXAxcTdDeEhYc1Y1?=
 =?utf-8?B?UlBMSXgwQmhEZGJtZG1hZjZQMnEzWnh5SDhZZ054NHR2aVZHSFBRNExOVUVj?=
 =?utf-8?B?eTVOaE1TMTZheGVYSXdkYjV0c0JIdTdsYzF0UzBtaVBia0s3ZmIzWHpUS2dn?=
 =?utf-8?B?QWFYd0swR2dZUWRPTUlyWFJLZFBGMHhoa21YZTRKdkltNll5WmpmNTNydHJ4?=
 =?utf-8?B?ZXlqWXZMOXlZNUkwQjQ4aElDYXgza2NoWUNldDh5Z0UrTlY4bFllOExoc2Uv?=
 =?utf-8?B?eC8yQXhwTlkydUoyNTgzczdkRXV6K3VLYkN2bTkyWUE1TWNKQWIrNldrNHVV?=
 =?utf-8?B?andIL2JCd3FBblJDUW5CWDVWdWo1Q2J1alpmV1l3REdPNDVrR3dtWG53T2Nw?=
 =?utf-8?B?TFRaQXcxK05RaUhnM3czNnJmNXdFSlhkbTdML1hVMTg1VjB1Qklib05yaW11?=
 =?utf-8?B?ZzA3QXEzbFlhMzluSlpLTDV4ZXBGUkQrZGVDaFQrTVJvTzBXUURXcitzZnZO?=
 =?utf-8?B?ZXl4a01EbnRZeWl5Zkh3cWtkQ2dBaFB5aHdaMkcrNS8rZElWWkdUMDV0K2Ju?=
 =?utf-8?B?TXJHdlhjS1pTRTFGUHo4cDNpYVdYd0JUdDA0WGpQZE1QenlDZWxxamk2NWpL?=
 =?utf-8?B?eG5kb1hCRXNMRHd5bWErKzR1MWUzMUszbkJQaEQzOThYM3hRTU1ENkNzMjcz?=
 =?utf-8?B?MTFsbk5uR2VuRGJ5eWFLdnpnblRQclBqRDB3enhRRU1FcFBKY1dEdTdMdnRm?=
 =?utf-8?B?OUcza1l1OFdRL3VNWTMrUHFxYzdHSkdjNVYyQlRMRUM4VUx0RG0yeGlqOXYz?=
 =?utf-8?B?RUVRT0VGTWZPVHNBWUx0UFM4NjNsK0MvU0FzRXJ2M1pRR1BnVkVhWkJ4TU5x?=
 =?utf-8?B?RzJjKzEvcWxrWmlTQUU4dU1ocjcwakZoRUxtdEdmRXZhZzJRbnNqSjdaZVJT?=
 =?utf-8?B?aFZwMG1wc2lXVVQxUVMvME9GaU5uWERSNjkyU212L01yZ2hFQVpOTnpBTU14?=
 =?utf-8?B?WjhZUFZEUUxOSk91SXpkZFQ4M2RhZ3RZZWt0WEVRMGJ1cktuSzY3QlVxY2Rn?=
 =?utf-8?B?SUNoRVdWZmxlZXY1b1dTRC82NFM0MENJSGphQ0RaUG41NXFKLys5N0JMNUk0?=
 =?utf-8?B?bk5ERlF0WEd2VVcxYytqTnE0U01sTnYvNlhQWXdlYVQxOERLWWZremliQzFP?=
 =?utf-8?B?ZHpvaS9pSmNMNUFCbGwweFdZVGdNWXpwWnRGYlVNcVM2RFFLU0NvZGJjUFJn?=
 =?utf-8?B?cEMrR081QklLOG9FUmJ6bzlOWVBTYVBpOEh1bTFFVWJ5Tm4wVHd6ckxnNk1a?=
 =?utf-8?B?Wm5yNXZxMmMxWGVSbEhpaG4vWmFxQ0E4amVFNEtkenpVQnlZTzJ0dUI3a1Nu?=
 =?utf-8?B?ak5HQXRHNlVnQ084MFVzOGlkTGVHamZGamd2WFRNa25sUXBuNUVZOHNPaHpN?=
 =?utf-8?B?QjJSMCtwUGJVYnVlYlIxUmVsM1pFVFZDYmxBNko0MEdnQitOOGlXc2E5ZnQ2?=
 =?utf-8?B?RUxxZm14OHFRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2FBQ2pIMkJVRlFyekZKVStiNkRyLy94QkcrNjdLVStDUXh0UTdQdTJLTFIz?=
 =?utf-8?B?dlFLZ3ljN0VrR01qSmQzRmdWUVY1Y1U5dk4wV3cxQitwUkx1SElCNEpIL1NV?=
 =?utf-8?B?ZXR3ZXpzZ2NCZ1NFQlpCUDNaWlJnYWVoMXFEM3hueDljWDdQZnZ2bk8vWW9h?=
 =?utf-8?B?WldheEFBZ1BEeTQ3YllHdU9KNGU4Q2hXVkgwcm80SHJzZjZJaVFrN2JDbkJi?=
 =?utf-8?B?Uld5WHViZVRQZENQZlYrb2NINFRTNEVvWUE3UjRNUU1FYitKa0NrYVJIQzli?=
 =?utf-8?B?R2ptOVl4SkVEb1FrcDlMZzNUT2YySERHQkxrUHFTR0tIZWFmejNRMG1kaG5P?=
 =?utf-8?B?UHFKSWl4eVFaMlRWQjVXVzg0RmpCZFU1cFVPWmEvYU1qQVBxRmliTmMwUGhr?=
 =?utf-8?B?eUc3Qjh6MGpFaXRacnQ0RHBhOUJlanRVS2x5WlNwbnp6YUl2ek83a2lSTGtm?=
 =?utf-8?B?ZzdjUmxZU3BQTUxsZGZxN2ppYnBOUWJoY0NpWlZ0Zkt2U3QwYVE3RllTNUJD?=
 =?utf-8?B?a284MmNTd0Y0NDNrZkJKK0U1WjZ0U2lXSE51VHBjakUzUkx5TXp5WEVqVmxC?=
 =?utf-8?B?Z3NpVWhyYUg0NEI4TjhVb2RFNmFrV0ZiQlFjc3FJK1dwN0orZEFnaXBRMHdB?=
 =?utf-8?B?WVoyaVZQcjZOYk9qYXllOTRUTWJLc00raEx0NjBZeUZsQ09abU9qVzk2eDFK?=
 =?utf-8?B?L203NXhvaGxsOFNVMXFIUHBsQ3Mzd1B4YVZuNUh3RjA2R3FobzlRYUxJVFZV?=
 =?utf-8?B?clNHaTRPL2dvUkw0TUNwV0dyS3YyTVVISmdTeGtvL0E2Y2dUSkNkcVFIdEVJ?=
 =?utf-8?B?YVBPUmR1MVVuVkdodWliekpHbXVlZ3llNys4aDg3QnhEOFNxT3pYUkpJbm9z?=
 =?utf-8?B?cHYwRXVSbWh5K0l6aDNhbndjZHBlZWdGMXJRUERIaTdtWVdmQ09YTGJqRyts?=
 =?utf-8?B?TWw1TzFjWTc3VU5vU1YzbkltdERERzhwZytTZlUwYXIzYXNHb1BCM2J0VXE5?=
 =?utf-8?B?TE85TW1wMkhYTzRiR2F0UTM1dktBNFdseFVWdjBRSmJTSGV6eFRnQkJkdEVt?=
 =?utf-8?B?NXJWaDJaaFphK1FkZ3d2Nk1KVnd5eENDOUJMRnR2bE8vWHRBRzFsYTMzTmRJ?=
 =?utf-8?B?V0d0bGxzYlhLNTcxZjR0NW5YRVI1djdvNGpkbGo0S0NmVTdYVXhuT1krMjdx?=
 =?utf-8?B?cUtmc0hNR2hzNGpnV3dLSnplOUxmVVJUTkx0K3JaS0xKVlJhMDRieDdCb3dm?=
 =?utf-8?B?cVBXVlpFVmpQTHhiM0tUMWdTRTNrQlREY2ZuRXovdlVGeXMwYkxhTzRKam42?=
 =?utf-8?B?Qkl4N1g2VGh1dVR2cVdWdmtyZlltR1FoZktyYTZSMVlSYXZCZjlQM2t3SjJx?=
 =?utf-8?B?dnlGS3JTeGY1TWcxNE5qekdFVlh0TGdDQkNyTS9ac1NCZjN6VGtLNlNvQTZD?=
 =?utf-8?B?VnJPVG1KMUVJSmtOV0pDcFd5c1lkWDJYbWxjdm00MDhhVGRCYkptTmt0L1kz?=
 =?utf-8?B?SnJpM0wzcDZVQlhmQ0ZuVkNob2w2Y1hCYnNBaWtpV25WMW1rN0VDZDdEdnBv?=
 =?utf-8?B?RVR3ZjhBRVA2czN1RkI0cURlV3duRkRFRXU5V0w1TzlMNmRONFN2RDZGcjNF?=
 =?utf-8?B?TWZDMnRzTlZTbTBldkpjS1IrS2hKWGNmbisxaStVekpsekJ2UlRqNm8weDhv?=
 =?utf-8?B?TGZnTkdEZFBPaWo1WkNJZXBXVU1kaE5wZGpsZWk3SUdFcGl4VE9WOE15RnZH?=
 =?utf-8?B?ZVRhZUhXNVRORGwzZE9DUUcxTXlMbk1qSjZxQlFXbk1TWGFoUXQ4eS9EcVJj?=
 =?utf-8?B?NC8wMVVhTXZwb3pLVnlENzBjSG1yTHZNZEVRRGxWZ0hHVGpZRG91MTd1R0hW?=
 =?utf-8?B?Y2dRNk1iZXBGdElRTWIyZmpkbSszclF4emZSZWk2Wko5ZTB2SG5WbXE1NUUy?=
 =?utf-8?B?YjMxME1YMW9ESDFpQWVpTHpYVkRqcTdBVzdKd3pJaEFIS3B1WTF6YXJkejBW?=
 =?utf-8?B?b21NNkM4S0ViNlJKOUkrK2pZVjBvdXZ2Qng4QnE5YTd1VkZzUXNxaW8vQk1z?=
 =?utf-8?B?eEtNeVpYU0JGdTY5K3VRVnN2b1VmY1VqZGIzU0o3QzZwUlkzWmdFWllWRWJi?=
 =?utf-8?B?eDQyUnpMYlNTU1ZxUDl2YnlEVkpjOEFRUmRLY21jdGFTMzZ4VlNvdVFOS04r?=
 =?utf-8?B?alE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7f73c8-fdaf-4086-f9dc-08ddde40f343
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:21:10.0547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhheBqQl1XscgaDAPrkdozKbNk0UqzfK/uRjPUNdlGN1G2zD7Tb8NJ8xaMx2OhnFaYpp7gMkIYTJhjubdHD6dleY+FPWuSrl6fko34O45lU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8127
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

Am 06.06.25 um 09:21 schrieb Christian Marangi:
> Add Winbond W25N04KV flash support that use a different value to detect
> ECC bitflip.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

For information: this will be covered by Mikhail's patchset here:

https://patchwork.ozlabs.org/project/uboot/cover/20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu/

And for the future, please provide a changelog when you send mulitple
versions of the same patch. Thanks!

> ---
>  drivers/mtd/nand/spi/winbond.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
> index dd4ed257a83..16abf89dbbf 100644
> --- a/drivers/mtd/nand/spi/winbond.c
> +++ b/drivers/mtd/nand/spi/winbond.c
> @@ -11,6 +11,7 @@
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #endif
> +#include <linux/bitfield.h>
>  #include <linux/bug.h>
>  #include <linux/mtd/spinand.h>
>  
> @@ -18,6 +19,8 @@
>  
>  #define WINBOND_CFG_BUF_READ		BIT(3)
>  
> +#define W25N04KV_STATUS_ECC_5_8_BITFLIPS FIELD_PREP_CONST(STATUS_ECC_MASK, 0x3)
> +
>  static SPINAND_OP_VARIANTS(read_cache_variants,
>  		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
>  		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> @@ -121,6 +124,7 @@ static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
>  		return -EBADMSG;
>  
>  	case STATUS_ECC_HAS_BITFLIPS:
> +	case W25N04KV_STATUS_ECC_5_8_BITFLIPS:
>  		/*
>  		 * Let's try to retrieve the real maximum number of bitflips
>  		 * in order to avoid forcing the wear-leveling layer to move
> @@ -172,6 +176,15 @@ static const struct spinand_info winbond_spinand_table[] = {
>  					      &update_cache_variants),
>  		     0,
>  		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
> +	SPINAND_INFO("W25N04KV",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x23),
> +		     NAND_MEMORG(1, 2048, 128, 64, 4096, 40, 2, 1, 1),
> +		     NAND_ECCREQ(8, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     0,
> +		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
>  };
>  
>  static int winbond_spinand_init(struct spinand_device *spinand)


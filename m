Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39796FF885D
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 03:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D1F283FDB;
	Mon, 27 Apr 2026 05:09:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="X+tA/EJ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D166783693; Mon, 27 Apr 2026 05:09:15 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2379C80077
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 05:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDn7mUuvm8cj8zZHaxJQTv09aY2JYueSRAEbdVyx4ESFyIHgtjEkAVVEgXuLPyruLqSuPrgvYSJOqrtHu1Ju/btw7LBN+Sk+Oea+N2sqOqN9Crp77QxpUE6aYPAygYqe0P/KYP33cAbVCrNcGhNPjuWVlRViju36EmIUKZi6n02bmoFG04z9bZnoOLuJNyxB++wAYeVTrPuTkwKmwnpejcdQrZDYRma+tOhoFELMyV6FxvCmFZp584ubHt4X7rSZIiYxPgYH4WM1IKQ28SWKg9oX6cO/LbfBwWRJI1bLIFoW0VESxa85SxVeh0GFQ+YaH9YuGL4p86lZN78QWe9I0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVXpxgI3XDllAi5r11R3l1oJnqLar4d/ch20E4ss6wo=;
 b=IzjOHLhenwhL9IpsgPHESQzezHKcLWhJTquBDSt4JpYh0536U5lAyhJJu1pFuc1U0VfCoK8EDcDu8jZz8eqrATKxBJbwmqJe7BDw5HLFWPgFubd1cooA+4relv7wp02OUVe3dMxATikjZCCVnnLmqvMnqZW1Wh4kxIpyU+efsACdOfYZwHvck8GKngrBvAp8KRepUXn7/Uo93fk1pAMpSVLDJGJ1B051hSdmzyKXn0j3BmeIgLPp33PQZcvDEWtLxbKR3icR/waIuHjIuKzvNfz6bMg83xVzXhWufbFQQU6uuW6OPFGyKtYdgqJbkHeOHoZTi/0AlBsUtfOoNPrtGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVXpxgI3XDllAi5r11R3l1oJnqLar4d/ch20E4ss6wo=;
 b=X+tA/EJ6bilYx45Jvr10ZJQXZ76FeV0dx/VFK1PDp7AAlQeU/2IWbddTDykLQFm4x7b8taQ9Dgj8fC2hPE6+lJ+fKw06oNmPYu8xsjbMYKAADvk3bFdSbg9LmBliEGpuQn50FFkEP3KUoYRG6GXp5Eep8VuSi9TpgduTOg0QdbgcEcEcspRYvJvBaZE6udVEqQHmzuRNf9aUli1sVuQ9ct99BFihSyHZ2zyNiHcbLyTlGDPq1DJefEY2CNeme/BX/+FNQE+6yvontHepfWUMwz+r481WiDcDzHMbQMVFmU0/69CtG5TEZsp72nF+uuUCFbc1wPihZIX2UrpChEM09Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by BY5PR03MB5235.namprd03.prod.outlook.com (2603:10b6:a03:21b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 03:09:09 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.20.9846.021; Mon, 27 Apr 2026
 03:09:09 +0000
Message-ID: <c63a73eb-3c5c-439c-924e-e5a9c0baabf0@altera.com>
Date: Mon, 27 Apr 2026 11:09:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] Improve handoff prepare on SoCFPGA
To: Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
References: <20260422065910.5398-1-briansune@gmail.com>
 <870316ea-6fbb-4923-b772-58528eadaf10@altera.com>
 <CAN7C2SDD2p89v=haRMt4Fj=xypRcWP4PGTQ17WSJA1ysp2n+CA@mail.gmail.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <CAN7C2SDD2p89v=haRMt4Fj=xypRcWP4PGTQ17WSJA1ysp2n+CA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096::22) To
 CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|BY5PR03MB5235:EE_
X-MS-Office365-Filtering-Correlation-Id: ab180dbb-8369-47ca-2e02-08dea40a597c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: nKTyC9ZpqCLmr97x8oRAxVZRFTCcSlxZShknUNk7uIbFX6KMARo38RfA0t7D5k0D8DnNcTT8wOvd4MuXO5fsAverGdP4BA66ybnbpT/LjBn1Ne4uuo0fCwSQ41003b0N285k3FWOdnPOIUyQQ8MynuUQSn5VMVUJV4KQeAFy5M6ZO07JcsRiHeUXUsscwzLK0mlhpXaDvJmnYiuInYe1Dt6AP0CAcKgQBTCQpb5rN6lzOCTrFuWXdKTnZYx3zAi9/4H9fU9i5cGox2kMtW7O87DIO0H2gqG0F3pHVD5ORiQ6vfK4T+uI0SCY8O9C5UfBwjjZ4dA8pL9xgMIX678MHwnvKchCM6djdjIqJnBT7VOkOgTttn3frd2rOm81hT+hzPD8wRD/OjdmJr+PkV1F1Tl5ZUsHJj0k237qBwYbJGjBHTajsCw9ko1iMJIGHrPZg8jwBy0mIi3jxckRyF/xMjtETmnQjP0uQCGsoLLXsH9ck5HBUMc3RX1RQy1a34FEI1IH46JHelBUu6uBT8KTzoZJqp9/SMWeimcQPCr1LXkN2L+ae1KKI5LZeR5SHqhA+7q2gkxdvx2RQ3gbHK0VKMSwECJfm1p2FszLOSdp8B/xuzfDHZw+y+iybGVP6yDVgY5wt8qsbbup+P2fNXgDpofMlFL0AifSdjYmG5/4xkEFFCinRzHMkqNbgsq3DhTFGphXXZ62gPP5tHNzFGo37QhArxOPOy3wdviQ/mE7nX8Rf21w742mObQDnWgIHKka
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTMwOGhjWDlKTHM3L3RCTkYxS1ZseGJTNnJqVDYwWm1BZlFZVzViU3BZYUhJ?=
 =?utf-8?B?VGJLbUs4SS9SUnFKTzhnazMyWDlVenNwMU5CbjY0b21yRkQ4b1pwSy9KT21U?=
 =?utf-8?B?LzlHOGJ2bUhoQ0toZWoxN3VMdmo5TWdGUkt4MldEbG5PWnA5UEZZWmZYOWdH?=
 =?utf-8?B?c3VCN0U5TVJ2MXpRZktZYzk0MVN2VlFxS0dTTEZRWlkzTXlQdjU3VjRRSHJX?=
 =?utf-8?B?VFM3RHRiSVhsV1lXSWE0aUVBSlZ4VzRnVHFackk1c0hWV2diV1FITnM1MlVZ?=
 =?utf-8?B?V0k4REVTRWw1bjZYbW9zTGJlT3JSNjN3L2wzVGduN1k3UHJuTmV2SHRjOWhB?=
 =?utf-8?B?Wmpkcm50UmI1L2loWjhCdUR2bmZHOWQzV0tWdi9Vak1RaS9DN1hrMDFGUTN6?=
 =?utf-8?B?VGo3RzZaRTh1akpLWGZZTlFpV2hmODNhSURPb1Y2UHNLZzY4NUFKMTRVRFF6?=
 =?utf-8?B?VFpCaTh2YnduUGhNdS9SNGZZQWhoM2NCVXFML2FlcDJjUnFKQXMzRkhwUUcr?=
 =?utf-8?B?VklMSll6ckozaEFtM0lJY0VaQkhQTE4zSU1aajM3WnVBT1c2a0FZL29BQkIz?=
 =?utf-8?B?Qzk3ZWR4QXJsTTBNcHlaY3JvU01hcExOK1p5WUFac2RxL1pBT1lyL2FMZWtV?=
 =?utf-8?B?aHRFSmJOTUh0dTQwaW1icEhVWEdLdzRzQW1FYkxtNEVNdzNENkkzT3Q3M2Er?=
 =?utf-8?B?NUp6bzZXMkxhcXprSG56UHQwYUlDQzVMeGZjUlhlMXN0K0hUMVNaemdGa21N?=
 =?utf-8?B?bzVJMklNV1RHNm52RVdIc0hGVTVtZGZGdjlSeUl1TE5BbU90ZnNIL3ZsZDNF?=
 =?utf-8?B?L1I5UW1WSmhMT0pRRGhJdmxuaGJXenF2aG5wZkxGWlJKK1pYVjVQMDFxQmlV?=
 =?utf-8?B?RUZnRWtsaGpjbnJpZ0pMTit4UXhJWjdTN2I0eEx3QlBETVV2MjBSWnBPY3Zw?=
 =?utf-8?B?bUh1c09TeStTazBjS2h5VVB0ekVZUVNMeU91OE8zV3pKc2Z4eU05azdVREgv?=
 =?utf-8?B?MWQ2NkZoNUhzdytnUXJQcDk4NkZ6SzRZN3R4U3hSczhlVjNTQ3BoL21wckNG?=
 =?utf-8?B?bDJmM0VDc0pMTk40ci9kakxFenVGbSsyVVhmSDNNVVVBOHcvWGk4end2WEpq?=
 =?utf-8?B?QThVQXB0WGxPV21QWTNuQ2wvTnhiV0JydFlzVzhiKzJtU0hXNGticUowV2xB?=
 =?utf-8?B?NkhyQlNMUHkvcG9QMko0eEpDai9nbWEydlI5SGZUSVVzalB2ZjA3aG5HZ1kw?=
 =?utf-8?B?OTlNZStvSHE0ZDFQWjRDdWN2azRFRmRaU2Q1dVRwdkFzeDhvZ1M1MFdkTmcv?=
 =?utf-8?B?SjMxalF3dGJLM05lSVdGQTlOanJ3c0w3djJhenFIc3QrNXB1a1dDNmxoVWdU?=
 =?utf-8?B?aTk4clNMc2ZGZ2Ird3kxa0x0NFdBOHg0M2FEdmoxV01Nb3BTZWl4OUMwand3?=
 =?utf-8?B?d05paGhYQU1ONk93bTArcnJpdjBPdm9ZNmdoNW1UMXZqMWsvcW9Za1R1V3Bq?=
 =?utf-8?B?SS92bWQrb3lRNlF5QldaSTRBZm5jNld3RUZmVVUyY2hWMWNiMDZnTTZNTXo2?=
 =?utf-8?B?WmFuTzlhWm5velVHVWNSYytqVFJOaGNzczhiOTEwVU1NK1M0NFRlTFVKRmxO?=
 =?utf-8?B?M25wcUtXR1dBZDdhdzRycVRPSFlPNU4rUjJGeGJ4aCthVTRwa09DQjJvWDFK?=
 =?utf-8?B?aUJFN3dUMytQZkRwbFpHbGVYSTNqa3hSeUNWME5TajlueUM4eWtRaFU2NC9u?=
 =?utf-8?B?M0pmOEFESHkwZE5UZVp4anRPMFViWEQ2Nzhuc2FaWkFFb1hUV1hmUG8wMC9Q?=
 =?utf-8?B?ZFdZcFFGaDY0djdtL29oTk5VNGNBL0hxcEtHVmR1dkpiTmxqcUd3emRFZElB?=
 =?utf-8?B?WitxelNYNEN2T0UxUDdLMDJQUDdzOFJhWVpla0FzWXBvWmR4VkhnMVF2TFpC?=
 =?utf-8?B?QjhCNHQ2VEFFYmVsZjFNUzJXR2RSWmhUaE5lRm12VzhrUm5idVRjcTR1TFpa?=
 =?utf-8?B?dm51N0JucjVaWU9VQ0JIbU1jMEZWOFdhblpoYXVOUjMzeWJvazlTdWYrQlBN?=
 =?utf-8?B?ZzljZ3MyQXlPL2UyR2Z1WUNUUEtqcEIwbE96RmZkbVRrK1hHcUdqQTZsK0l1?=
 =?utf-8?B?bXJpNStVODl1QzhSWEpNVHBCL0E5SkI2blNwNVptZlhsVUdEWEI1TVY2eW82?=
 =?utf-8?B?dVJ6Q0c0TlU4SUJNMU1OVnVjV3lPWUxQUzkvODFZMnduUS9tQ1A1TGNKczJp?=
 =?utf-8?B?QlM1ZmIzNUJ5dVRsSmV4UE9EN2MxMmlsTFZKdVpCeUZCeE5sMGJJQjk1Y201?=
 =?utf-8?B?Q2pvQ1A5VEVjZUF3cGhEUllZZTl0NXBlSS9uN2NvQnlJWDdtVWdMcFhrYVBU?=
 =?utf-8?Q?Zuynrfm2DWwoiBG8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab180dbb-8369-47ca-2e02-08dea40a597c
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 03:09:09.4047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkvX0EkluSF4EWTIu0w90H5Y8rFfmQXm9x4N9oNw0ZM1xClWWHUvUDl4amTLkrParnWMv/w+PvdfAKvzmUpBaOOb3t3/5MOrMzCWeSnOB8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5235
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

Hi Brian,

On 23/4/2026 11:23 am, Sune Brian wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> On Thu, Apr 23, 2026 at 10:20 AM Chee, Tien Fong
> <tien.fong.chee@altera.com> wrote:
>> Hi Brian,
>>
>>
>> On 22/4/2026 2:59 pm, Brian Sune wrote:
>>> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>>>
>>> Ensure qts folder header files are properly updated by isolating
>>> the Python execution environment. This prevents partial or failed
>>> script runs from corrupting the target directory.
>>>
>>> Changelog v4 -> v5:
>>> - Change HANDOFF_KEEP condition to if [ 2501{HANDOFF_KEEP:-0} != 0 ]
>>
>> appears corrupted in the commit message, e.g.:
>>        if [ 2501{HANDOFF_KEEP:-0} != 0 ]
>>
>>
>>      Please correct this to the actual test (e.g. reference to
>>      "${HANDOFF_KEEP:-0}" and proper quoting) so 'git log' is accurate.
>>
>>
>>> - Add HANDOFF_KEEP and HANDOFF_PATH comments in config.mk
>>>
>>> Changes:
>>> - Implement a temp folder for Python script execution.
>>> - Clean temp folder automatically despite execution failures.
>>> - Gate the file replacement process on the successful exit of
>>>     the Python scripts.
>>> - Execute the replacement (with or without keep) only upon script
>>>     success via the NEW HANDOFF_KEEP=xxx variable.
>>> - Rename old files to .h.handoff_backup.<timestamp> when the
>>>     keep option is selected.
>>>
>>> Signed-off-by: Brian Sune <briansune@gmail.com>
>>> ---
>>>    arch/arm/mach-socfpga/config.mk | 38 ++++++++++++++++++++++++++++++---
>>>    1 file changed, 35 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/config.mk
>>> index 1ca1d33cb16..e777b95b528 100644
>>> --- a/arch/arm/mach-socfpga/config.mk
>>> +++ b/arch/arm/mach-socfpga/config.mk
>>> @@ -1,6 +1,17 @@
>>>    # SPDX-License-Identifier: GPL-2.0+
>>>    #
>>>    # Brian Sune <briansune@gmail.com>
>>> +#
>>> +# HANDOFF_PATH
>>> +# ------------
>>> +# Unset - Board path where qts locates and "hps_isw_handoff" should be placed.
>>> +# Set   - Custom path points to "hps_isw_handoff" folder.
>>> +#
>>> +# HANDOFF_KEEP
>>> +# ------------
>>> +# Unset - HANDOFF_KEEP= , Clean header files.
>>> +# Set   - HANDOFF_KEEP=0, Clean header files.
>>> +#         HANDOFF_KEEP=1, Backup header files and rename to ".h.handoff_backup.<timestamp>".
>>
>> Should be tightened to match the real behaviour:
>>      - For HANDOFF_KEEP, avoid lines that mix "Unset" and "HANDOFF_KEEP= " in
>>        a way that is easy to misread. Document:
>>          unset, empty, or =0  => clean old .h in qts, then install new
>>          =1 (or any non-0)     => rename old *.h to .h.handoff_backup.<ts>
>>
>>
>>      - For HANDOFF_PATH, a short "unset: auto hps_isw_handoff; set: custom
>>        handoff path" style note reads clearer than the current phrasing.
>>
>>>    ifeq ($(CONFIG_ARCH_SOCFPGA_CYCLONE5),y)
>>>    archprepare: socfpga_g5_handoff_prepare
>>> @@ -43,6 +54,27 @@ socfpga_g5_handoff_prepare:
>>>                           exit 0; \
>>>                   fi; \
>>>                   echo "[INFO] Found hiof file: $$HIOF_FILE"; \
>>> -               echo "[INFO] Running BSP generator..."; \
>>> -               python3 $(srctree)/tools/cv_bsp_generator/cv_bsp_generator.py -i "$$HANDOFF_PATH" -o "$$BOARD_DIR/qts" || echo "[WARN] BSP generator failed, continuing..."; \
>>> -               echo "[DONE] SoCFPGA QTS handoff conversion complete."
>>> +               echo "[INFO] Try BSP generator..."; \
>>> +               TEMP_DIR=$$(mktemp -dp "$$BOARD_DIR/"); \
>>> +               trap 'rm -rf "$$TEMP_DIR"' EXIT; \
>>> +               if python3 $(srctree)/tools/cv_bsp_generator/cv_bsp_generator.py -i "$$HANDOFF_PATH" -o "$$TEMP_DIR"; then \
>>> +                       if [ "$${HANDOFF_KEEP:-0}" != "0" ]; then \
>>> +                               echo "[INFO] Preserving old BSP files..."; \
>>> +                               TIMESTAMP=$$(date +%Y%m%d_%H%M%S); \
>>> +                               for f in "$$BOARD_DIR"/qts/*.h; do \
>>> +                                       [ -e "$$f" ] || continue; \
>>> +                                       echo "[INFO] $$f -> $${f%.h}.h.handoff_backup.$$TIMESTAMP"; \
>>> +                                       mv "$$f" "$${f%.h}.h.handoff_backup.$$TIMESTAMP"; \
>>> +                               done; \
>>> +                       else \
>>> +                               echo "[INFO] Clean old BSP files..."; \
>>> +                               if ls "$$BOARD_DIR/qts"/*.h >/dev/null 2>&1; then \
>>> +                                       rm "$$BOARD_DIR/qts"/*.h; \
>>> +                                       echo "[INFO] Removed old BSP files..."; \
>>> +                               fi; \
>>> +                       fi; \
>>> +                       mv "$$TEMP_DIR"/*.h "$$BOARD_DIR"/qts; \
>>> +                       echo "[INFO] SoCFPGA QTS handoff conversion complete."; \
>>> +               else \
>>> +                       echo "[WARN] BSP generator failed!"; \
>>> +               fi;
>>> --
>>> 2.34.1
>>
>> You can add Simon and my review tag to a new version.
>>
>> I’m fine to proceed with v5 as posted. If you prefer a different
>> implementation,
>>
>> feel free to propose it in a follow‑up patch and we can review it there.
> Hi T.F.,
>
> I committed a new v6 patch just to replace the corrupted " symbol.
>
> The version control placing v5 with v5 is not allowed so v6 is used.
> While the change log kept v4->v5 because code changes are not
> done under v6.
> So v6 is a git commit text fix only.


I’ve received a few v6 patches on my end. Is this the one you’re 
referring to?

https://patchwork.ozlabs.org/project/uboot/patch/20260423042538.3367-1-briansune@gmail.com/

Thanks.


Best regards,

Tien Fong




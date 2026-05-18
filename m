Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50DECD4F52
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 12:28:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D93A83EF9;
	Mon, 18 May 2026 14:28:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wBbRLhdH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 992E483FEE; Mon, 18 May 2026 14:28:44 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0775803C6
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 14:28:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVyEY0nrRp5CtBpYvud8F+HOqGrqmeY5/XPzadpFfZcxhQDqtB8BbXjxvGetU3u69tQl1yyy4QJzHfOobd5wGN3auqw7JFELJQ/qCDebw3ckUY+SCGHjZM9SXFXiucUOew+i45mXDcGJIRBZPJsQXBzWh7/opZtsNfcb3JzneDjsGRR1fypjzL6UJX1uW1KCT1sLWzss5l7or270V0d1a3Y9cTBQAlIYyt1fOYwes+j1MAszm25rEzoYJ5RQUnNag3LxcGgxfeM5z//Lq1yeGZ6UZSDh6Uo1lk3Ey3yMJLNXubiE1IFRhaAFYqjGAfbWz/7pjEYy9pqhgYZDPYVnYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzoXY/dGqOf0q2Jtn0XtIQNqAF8ZvQiIEZ/cothEnbw=;
 b=ElwUhpEP2ce9yr4Ul8yU7s0D2wiOt3Obu5FIJWT3tgqVmSNt/omyO0p85i6whktbKj3R6kMlhby5J9NcHvz5tutCHz6gvSjJPmXg8lwxrXXgrNSlUjakF57ZVHEuTWtn9IBODV59As16KYwTWcnBO+atD3OQIPQtdGnhn9hnEDdW6mTF5RoEQGlJo6oN9CgCwbv9MWFyh/5yci9yO7E7O5dS9ED6UX2dPHamBLWoeDw9kXPMn+qF9yd4ipWPOvUznCuwI1qn3aKklkVu98C/9hGuEah2tH4cxxCEy+4m7mFF14d9Y80EeF6nXl0iNRONOs5StJJYunHZG4B58fU2Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzoXY/dGqOf0q2Jtn0XtIQNqAF8ZvQiIEZ/cothEnbw=;
 b=wBbRLhdHN02FeQFn55wzmtbGl+++uQ9bgF4EDlhmYFs75a0Az5N2zJ18lvmyN4zQZvENfU2//hviESfz4BPlI3y3PAFAr8mV28ZAtdWNDN9w/sm60d2b18ftvx63TQVVYm4pIhinEsrm1jpu8Eyp7j/nLpXcy02kM4lNfpBi6Q8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by MW4PR12MB7466.namprd12.prod.outlook.com (2603:10b6:303:212::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 12:28:35 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 12:28:35 +0000
Message-ID: <12534d6c-6961-4fb7-80c3-d83c3f8d13dd@amd.com>
Date: Mon, 18 May 2026 14:28:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] reset: Add reset_reset() and reset_reset_bulk() API
To: Maarten Brock <Maarten.Brock@sttls.nl>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "git@amd.com" <git@amd.com>,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
References: <cover.1778665323.git.michal.simek@amd.com>
 <b8229b9f7b357cf6013e8423831a9af1d69fefdb.1778665323.git.michal.simek@amd.com>
 <GV2PR05MB1194140D0CFDB4D8C63BB998183032@GV2PR05MB11941.eurprd05.prod.outlook.com>
 <0f7c82f8-dfff-4c0b-84c5-41f189ee042b@amd.com>
 <GV2PR05MB1194186BCEE688E85977E22FE83032@GV2PR05MB11941.eurprd05.prod.outlook.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <GV2PR05MB1194186BCEE688E85977E22FE83032@GV2PR05MB11941.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0112.namprd05.prod.outlook.com
 (2603:10b6:a03:334::27) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|MW4PR12MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: 76ddfb9c-0604-4adb-f66a-08deb4d8fb3a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info: B2wlPR913vwS7I2gdovjz16XqPJJF31ReRGu0qNIrz1tHxvE3HbUWppuk6+YovnTc7b1+Yv+2tE4T6mDmQ/G9daL/97LNKUD1Cdle5pY2+B+nQFkolp3jVesw1uLOZ3OzYJS4uVszqyrvZ8pDvtimOcbpCgNcT/i/yDHX2cISTlli+sD2EzEf9w2+RgCvMAeDTRjbJ/Ddsyy4maol1NYl31qrN6sHyUzp4tymXkEj/yLuHrM40DbszKI0/4Nr/kJcyX/AGHLw34RNYA4M0ImQMx9HgXKJN9H/Um9LuHiWeZbajfF+1dC6rNNQu6POwQRXGk/1a5+V74nW9M0owQhepilnz+G9fFouSAuU2xXaEhx5G4icm84YoO3BBuB0UR3JpKFpygkW9mcBZMZkojProNzEWUfZ+5wPa5apbIMzA1BTvOq2HpvzitTUhQqqDO1So8/6214oF5imVaPxYwEVi0ut4LBfFluGGE+LAjruMrWFJ6gM9RLJEx1nAuu4u7p2McleNApv9mavWr+U85K1jRUQ61aD5SIvFLyeb8MezVNrZcxvjtEsCWY0nzrxkWbEtuQi+xJbzaYyBWWqLIPo9rvNJDc8Lh7379Zhh3D+67GfyHHa1Wf6AQ/NPdEqVvTCXWA0oMnqxwlctoKBwijWmZ/zib5CQhkU4HQivY79Foo1b8OT82tauUjB9OJR4xw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003)(4143699003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkRSWEtOV1AyU0RZVkhyVm0ra3ZNZVh1SVF3WnVWODlRZ1dhUkx2eUg5clBn?=
 =?utf-8?B?bG4vWHBwZ25xMUtZY2VpTW1jaGYxNnZFemtRWTJ6YWFVT1ZOdlVCWGJjRlZB?=
 =?utf-8?B?bkdjbENERHY3VThLOGlJZGUwNzRLaVNoTHFoYUtBQkFCUUlEWUxHQTJEcm9B?=
 =?utf-8?B?SUU2QSt6UC9UcmptY3JXdjArbTRzWCtrOUxvWmhSMzRnaHR5M21uYlNEcEJX?=
 =?utf-8?B?Qy9EL2g3U3F4OThKVWt5eXJzQTVIVnlJUlN2MkdmY0UwOTk2UzhlZkJ0VkVa?=
 =?utf-8?B?MUxnRlo1TmErcEdqZVNVMENTWWdQZFlYcmJzNWpURlllL1FDWEo3VXhPVlBD?=
 =?utf-8?B?TUplS25UVWxrbDRadWtLc2FrNVlZS0hqd1lRSEYzL1FuWUxzTXJSeERWWUQr?=
 =?utf-8?B?ZTRWbnBXUjV5U053eCsvOURKSzBwN0dybVg4dkw4RjVZTkc3TGdzYnBYZDFG?=
 =?utf-8?B?WGZuSUpSR0F5UlhEV3ExTXN4a055MmlZUWFmNzRtVHIySjdzaW1oMnBlYm9G?=
 =?utf-8?B?V0loR1AxTk1kam1IYWJpZjZSWkVPbmdkRWJtSjBWL0VnV0VzRzZaNURNVGlm?=
 =?utf-8?B?YlF1TzFmZXVlQitSUklvNDlFUlF4czByWlpYS0duWGZpTSs0MEFvcnhnUUZv?=
 =?utf-8?B?bCtYdzNJMWptdTJvZHAxalBEVGxOUnFjTnA1T1R0QTl3OTZxM0NlQlIxeU1l?=
 =?utf-8?B?bEMxbUVraE5QOEFSdHRhOGl4K04zM1hEN2FBemU5M0hMKzNVWDJnamFjT1ky?=
 =?utf-8?B?OEtKWStYQXM2SEt5RUxYN0RWZnhSUUxiTFExc2dqMGVQYUl0b3Y2QzNBdnNt?=
 =?utf-8?B?eFJyVldMbnhBTkI0UkxqY01PdXVwMEhIZDZWZitQZUg1TTZ5a1NuNGtDT1hs?=
 =?utf-8?B?RVh4bmw2T1h2L3NyYlNDdXpLM012Mzk0a2FNakJNeE42dTlRdnJaMHhIdk1F?=
 =?utf-8?B?U2lFaWJrUGQvSkwxQy9Nbk0zVHkrdmcyVDdSV05xOUN3NG82ZGpCVStNR0VP?=
 =?utf-8?B?SitmVm5rdlhYQkM3SWIzdWFuTjJSN2tGY01ROE9HRFdzcjlYckxrNEpwaFcy?=
 =?utf-8?B?dVR0eUZPcHhXU1hBRG1KQ0hWMldjZmxKVXMyczhjMzI2MEh2emUxMWVBNThi?=
 =?utf-8?B?V0pmTmlMWFFXNU5FRU9RcWY4bGZhNXhqdkF5R3ArMEppRTlqT3Q0QzNNNkky?=
 =?utf-8?B?TXBwTHhPUzJEVGhoakhCRDZpUjkxR2xSZGFReEEwdFFZL0haVG5rQ1NYdWM5?=
 =?utf-8?B?OEJUSFpWbHRHc3RCTWxlNkFXWisyWjgxQnBJZEdkMEUyY2RhZ0QrWHRlY2Jw?=
 =?utf-8?B?bzU4MHk3NTY1Q1BRc2crRGdkemVPR25UMGJ3dGtZVE9iZjRZTW9EQkR1TFNJ?=
 =?utf-8?B?QnJqWUFaS0s1ellyNWZTY2thakVtTGR0RnBQbi91UlRRSEZyWkZVZnVYWEZL?=
 =?utf-8?B?R2tjcUxibm9iMXlqRnZ2SDk2dTNEUzkyWTNJQXBNVFZqZnNveXpyVldaQU93?=
 =?utf-8?B?eE9zMHRkWGtUTGxobGlGOHloTjh2QW1icDZrU0NOY0J2YzFPalpzS20zdFlv?=
 =?utf-8?B?bnRaVGFmRS9WaEgxUnVYaWZuVWkzSGMrc0FvQzY4VFFTdlpmb3g0YUVZUWdC?=
 =?utf-8?B?RmlLNlFJR1lacFk0aWhwM3A1YVQwTmx0STlkMEMweFliaVhDVTcrZGMvc1hj?=
 =?utf-8?B?akVVb1NHVVhkZWpkcHBYbWpYd2tRc1k5cm9MNGlzUldqZ1hwWjl5ZGxUTDlm?=
 =?utf-8?B?K0NUNm5QSjNubzM1VVRxdDdqNXpCVVUxZ1g2MnYremlUR2dZUE5QN3BhREpW?=
 =?utf-8?B?S0RXS2ZQVE44YjIySUpVV0FlWHQ1L1cyOTl0bE9WRndEdkNNMkNWS3JpSURt?=
 =?utf-8?B?OUtxUTQwelZ5RkxJRmNYNUFBcmRtOGFEZlRydXV1cU1acnNISzFqVHB3TVJy?=
 =?utf-8?B?M2N0RisxTzI5TzFTek0zaSt0UDIrcW85eUs2TWZCanVvWVdJRE5mVGMvdGNl?=
 =?utf-8?B?UjdNVU9VZmVINDE1ZzVrb2FZNDRtSVU3Q2pTaEVBVWg1cFVwR0NrRjk4Zkl6?=
 =?utf-8?B?UEthdkg5YzBVMThtSjVhZjdyTGpjeDNKN3J0cURHdFZ0UjVZR3hDaE5BUDBY?=
 =?utf-8?B?SkxlTTBLVnkvaHlHOFc5WHhGY3NnN3IzKytOL3AyVjlrc1JxV2hTRXhZbFRa?=
 =?utf-8?B?L0RqVG9hQWpndEFkM29uWldaV1VFOUhoeGpMTTBIaGcxZEFYS3N2dnBkMlpa?=
 =?utf-8?B?ZHZFQ1pVS2gyY25hWm8xNW9HVlhzdkdqUVNKQzhFREdXNHpGQ1p6N2hOMURu?=
 =?utf-8?B?R1MzYzlmSUtLR3FjcXVBbVJuZElDS0V2ZURuWTBKZkd2eWU1YnZOZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ddfb9c-0604-4adb-f66a-08deb4d8fb3a
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 12:28:35.5584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJI2Gx+zBGmxZ4XcgERISXErInvqaT1rRX43PMGx++LAptj/jkgB+ZjKWeYlLS+E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7466
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



On 5/18/26 14:07, Maarten Brock wrote:
> Hello Michal,
> 
>> -----Original Message-----
>> From: Michal Simek <michal.simek@amd.com>
>> On 5/18/26 12:21, Maarten Brock wrote:
>>>
>>> Although properly commented, I find the reset_reset_bulk() implementation
>>> counterintuitive. Are we so certain that the Linux implementation is the right
>>> and obvious one? I personally would prefer to have it assert all resets at the
>>> same time. It is faster and prevents races if the resets are interdependent.
>>
>> Why do you think that it is faster?
>>
>> I expect you would like to do it like this right?
>>
>> int reset_reset_bulk(struct reset_ctl_bulk *bulk, ulong delay_us)
>> {
>> 	int ret;
>>
>> 	ret = reset_assert_bulk(bulk);
>> 	if (ret) {
>> 		dev_err(bus, "Failed to assert reset: %d\n", ret);
>> 		return ret;
>> 	}
>>
>> 	udelay(delay_us);
>>
>> 	/* Deassert all OSPI reset lines */
>> 	ret = reset_deassert_bulk(bulk);
>> 	if (ret) {
>> 		dev_err(bus, "Failed to deassert reset: %d\n", ret);
>> 		return ret;
>> 	}
>>
>> 	return 0;
>> }
> 
> That is correct.
> And a single delay of delay_us takes less time than N*delay_us (for N>1), so the total startup time is smaller (a.k.a. faster startup).

It really depends on other factors and delay time. In our case it is not just 
MMIO access. But it is SMC to TF-A and then seconding request over mailbox to 
another firmware to ack it first and then do it. And with above you would have 
to do twice compare to once.

I can do another optimization which is that if bulk->count is 1 then call 
reset_reset() directly and for others do what you see above.

What do you think?

Thanks,
Michal

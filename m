Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CCBE77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 14:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AA0180657;
	Tue, 14 Jan 2025 15:46:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nYbzFSp6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F9D2806B7; Tue, 14 Jan 2025 15:46:18 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 916578060C
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 15:46:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akaeCTlPNhxA/dR03H6rQumkfD7Wd0j3ecr+rcBjtykfWqeFDEyUBoYkYQ26tmwxt2fCWEBhcUZ9a1/0mZJ55vyzuK3NI8Cv6mEaivV7hAuCVzq5X7DFh38LlY51CqFbmeYX75lrTCZB/Vkbe3yrOV+1PDP2uZySX6SYHcLYsNC/clAamTl8spfzjb09U09cxzxkliwuqnRnRGEr35TVUCSJh2bfkyrL/9EhS7y/B4P5myhR9K+OZZVE+zSevvwTQWOc1tRGFufxWddAPA8DcnERw/LM2nvBf2YfXSb3rHYCm4YLaMgThpJxZhMVvyV2TVbh2Mp/TRJ5Hc8CuU+qQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDW795ySLUtvwnVXZQic5AISjTaVC1nko7UyQF3d7k0=;
 b=x75DKBCkMK4n4Q1tkgEQdCmbUjgE8WzN0rNsi4HM40hlwOWQxbVb9IedF9KMoOM2DAKYkStbuvCGQEwP0etjAhnwfewYAjkPeWyIkTUVXTuvOI0zGsX5/ZeMgIYrErSlZAxXHMNK5Gf5DFNvziKdApqCIjT7kCgZT/iJRtRCiFRuFBMARDAxSGcDjs1nCldo2x2CkqDqwIL37F+qNDWtDA5KkbdfOogiSqTU8LlidqNC9UWEpJ0lXiLfGEz2Bxx/+SRpzecNQdlpXyGE1feFYKRVi4LM66wkZD+axk8gyhwhKPO5kTJ6ncAhBHGIF7DtzdqK85pkX+ylaT0MDsijzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDW795ySLUtvwnVXZQic5AISjTaVC1nko7UyQF3d7k0=;
 b=nYbzFSp6NAjc1yeEk15fDNCf0rR8dukvXj1ZAIzLjlhtOmMggS9Svzd8SdxoYhB4nLDs9zlPe+LKL9h3g1CBRKQ27VTX6bYwD8/LHDrfVDZdyKJMZ4/7i9WH4z7/ayb91lzS3uhrOa4rWVnEexIFSP8U7KhYxwtyiFIXKMItrTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Tue, 14 Jan
 2025 14:46:10 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 14:46:10 +0000
Message-ID: <e35ac4b8-e730-43be-a6c5-13651f2af53a@amd.com>
Date: Tue, 14 Jan 2025 15:46:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rtc: zynqmp: allow on Versal architectures
To: Vincent Fazio <vfazio@xes-inc.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, vfazio@gmail.com
References: <d2ae2c87-8c0c-4496-8767-1ce5b28fbfac@amd.com>
 <20250114135812.2605618-1-vfazio@xes-inc.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250114135812.2605618-1-vfazio@xes-inc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0030.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::43) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 251f8807-bb27-44e2-ffa2-08dd34aa2f2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHJ0NnJvVHR6UmFsVFV5WGc5UG5oWG1MV1FjL0RWRWpYSlBwNHRQVG15VFJn?=
 =?utf-8?B?N01CUkNjK2lma0JpOUVVWVUrZUxKTzVNWEtmV2Z6M3ZLb0ZPcVpUZzBzKy9C?=
 =?utf-8?B?T1VLM1VFMWYzWDFIbHIyVys2a0VUQU1KUG9UVFV1cUtTRmhDK3pVZDBtMWpX?=
 =?utf-8?B?NGxlRUV3R25rZUh2RExmOVVIWE5DWEswSnF0akFUM3ZiL01DY1d2K3NwUStl?=
 =?utf-8?B?d2RYZlJjVGswdVFFMnlrUitpSlFjazVyNVg1SXlta0lQQ1NlNTZpQ1l3RDhZ?=
 =?utf-8?B?Wml4VzZYZ3VYd0hpdXVSQjRTRTB5d1QzY3hmRmNTN1FQNHZIOGNZNkRKSUl2?=
 =?utf-8?B?UW0rdGFGc2MrWFF0T2xyRGFaVmpCMENRR2RFN01GTlMxejVOakxjbGJ0dTdm?=
 =?utf-8?B?SEl4eFB5a1FxWk1CUXBzWEw0cTN6TXRuczJLWDQrTks3WDF4VWJlaStSSG1o?=
 =?utf-8?B?dkZoU1NrYkE5VWlXNTRSU040bTNOUWpRSWFUelZMcGx4SlNsaG5kZGU0akxI?=
 =?utf-8?B?Q3RFdHl2S1pqb2wvWTNFN1pabVVtVmZLR2N0ODRyNjZ6TXJQZXJiOFVaRWtP?=
 =?utf-8?B?b3gwZVp1WTljTE12cDY1aUY1dFBtUVB3Z2VXakZtS3lkZDJtdDUwcVo5K3Vl?=
 =?utf-8?B?T2xaT2IvK2JZRXppNGkwOW5STWgwVDVvN1h3ZWJOOTZUSmJLdG1OSGtXS0do?=
 =?utf-8?B?R0cvaW42UzlUU2VBWlkzalpYVzIweDhOU0NCck5RMEZRN01Ed1QrKy9PRHRx?=
 =?utf-8?B?ZStabEZqT1dIZlozeC9VelE2Y3pKcW1EUlFvc09abGVBVnk2aE1SSUZCdStz?=
 =?utf-8?B?VWlObmk0YVB2cSsrbnRRdjRZYXdueUJvTVRoenZXVHBCODVCbzdHNW1CWk82?=
 =?utf-8?B?dFFuNW9Oa1lSMlZQdlRLYXNQZTlqS0l2K3U5WmlYNHEwRFVvWTdmdk9jZ2Nw?=
 =?utf-8?B?VE9lNFJ3dTlMeXlUK2cvSjNBdzZmdHV3N3pSaTlwMEZrQXR1NmN6Unk5bURK?=
 =?utf-8?B?VHNSWUtPNnRhY3E1eTd6WDVGM1NYTjRvSEJWUWV0RUlWV3ROWVVza2kzVkJ1?=
 =?utf-8?B?YmlaWmhGdE5DSVVnbVZ5SGhSTENuanp6UENhbThoZTdVTlh6VTE2eXhubUY5?=
 =?utf-8?B?ZmJBcWJxbncrWHhZV0ZZbFBpUTIyWHlJenhqQiszS0NJc2x6NGJJeml5Z1Ux?=
 =?utf-8?B?alh3ZWhMNHd4ZHBSRzlINHcybTJCWVNoS0RFY2JzcFROMHdJMldvL3RUYnpr?=
 =?utf-8?B?UE9HR21WcFU1TkdGZE95dkdhRjc0NWpHSmE0Zmh6VVM0RUxDbkRPMnJCbEh6?=
 =?utf-8?B?UjI3bXVkOE5PZERlSHh1RHFKWXdQUnJvYVoxZjBnQWY3cWU4ZFVFdVo4amU3?=
 =?utf-8?B?bHhydXBtK3BwRDdodzVjblRwS0drd1VBMXpIdlZtcUVpNFY1N3RsTlYvc0Ju?=
 =?utf-8?B?aXAyeG8ybWhwcXJzVExvM3pISEg1ZCtaN3B3S3l5MVBNQzAxUXA3MGVJZzdX?=
 =?utf-8?B?WVRsR3UxVXYzcDFyUDFCZ3RtSWZ0bW5TbWxxRTVYVjBOLytFSVJFaHlUdk1T?=
 =?utf-8?B?NzFZaTFRUmhjb0ZTeFNlaGorNmY4Nm5FK1NBL3pCajJ1MzNNUHlGaURoUlZH?=
 =?utf-8?B?WmJMYStlQzRnTTc3TXNJRGJQRk9BdndUVDY3a2JGL1N2WUhMMG9MOFkxdUJ3?=
 =?utf-8?B?bmVLMVg5ZzVkT0k1blpUSnhxVjJtQmlDTzkzYnluZ2hpRU5DN2YraFBvZTc3?=
 =?utf-8?B?Q0ZsYnlFY1lJSTBndGpPVGdDNUgvM2FCNDhZdk84b2twR0tlUm1sUnVhdm9m?=
 =?utf-8?B?WUJjUkp2d1ovakJjdTk2UHVKWEpZTk9OYTdoSkYzZFhndTdCSm9ONHNSZ242?=
 =?utf-8?Q?0TV2lF0b0oVFO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWVFVWJzSDg4SU5qVWpldHorS09MNzQ3R2s0WTV0cmV1bmJsSjB6RjBoc0NO?=
 =?utf-8?B?V2RRS3p4TkJ6TmV2THI1WW14U2E0UkN1d0hBMEk5ZjNWQ2ZhVDk1VTdpd2xh?=
 =?utf-8?B?SW0wMDI1RGg2cWtPejdhQU84Z0hyMnltcFVRcHR1MWtDVG8wR2p5dERXNGlX?=
 =?utf-8?B?dWJKRVVTajdEa1A3RmY3WDhMQyttZVhDRTltS1dQdjc5OXRSNDBmeFJRK0E5?=
 =?utf-8?B?RmhhSFQ1L2hBZkREQUh4YnZKWUZURFIxNlZucEVvWVpNaGxwNThtNjl3SDQy?=
 =?utf-8?B?OEprS1ZxbDdvZ2l5TVhPNStGQlE2SDA1L3N2dnhCKzJLR1B2OVc4cTlWVVR0?=
 =?utf-8?B?SkcweG8rS21xWnoxUUU0Umgzd2dXTmJHY0p2VUFTaWQyOFQxaUY2ZkdJa1pJ?=
 =?utf-8?B?UEZXK3hvMi9YcUUva2poRU4yM21jTFY5UDI3WHNUZlAxUC9LNkRLTENMZTJL?=
 =?utf-8?B?OFJtNnArd1F2bVB2MWFoTS9MM2tCUWoxTGRZT291ZmxIM3VTMFUvdUY4Um9M?=
 =?utf-8?B?OWcvSFR6TVg3cFJOcytJN3kwWE5iaXRzcFpVNkc2Qi9jYi9TQkJrWTU4UUdu?=
 =?utf-8?B?a05rZFppMngxTmRlNHFhUGliWkZkOGFMcCtZYmI2cEJzMG16QmlVelBRWlEw?=
 =?utf-8?B?MDdlbS9XZkJxTWNacmlhQXNMd3NOeUY4VGprYi9NV3BTa0toWFAvelB5SGor?=
 =?utf-8?B?OHB5cmFwbFZmK0VYWXRrMFc5Z1VITU5HTFBrdGlacGxFWGNDME5tdEUwOWZu?=
 =?utf-8?B?TWNWMFdhSlc3Q080SDlzUmFXem1CUlV3bUxsQXlXaTRCWVExaDlnUlB0Qmcr?=
 =?utf-8?B?VkkvVWpoWHFFT0ZqUDh6K1lyb093M3JreDFJQzhlNkMva1QzcFAyTTlDQ3Zw?=
 =?utf-8?B?MHQ4Z1N2MW9Hd1V6T0hUSUc1cmgveFhvdnRLc1ovNC9wYmV0MjlqOVNKRWVy?=
 =?utf-8?B?YVUyNGFubXZ4aXRlTTdyai9lOEgrazZTODl5TDlKampLRDhoK29aSXpSUGVF?=
 =?utf-8?B?YWZRQ3dVdVQrcG0rcmhhWEFyUTdyWmZ4SG9ZaWFBZmowMUNjeHBzUnlTSGVF?=
 =?utf-8?B?d0tpYnlCa2FMYVFzS0IzVFFjd0dLdnBoMUZwZmRMTVVXZHZBZUVnYkJhbXhq?=
 =?utf-8?B?ZUx6WktuUFNJTmkyRXh0MXV5aU1DMjQ5b1Y0dDgxTHBoRks4OG9ER3RLR09u?=
 =?utf-8?B?SEhRUWtNS1M3QXo4bnRPSkFLbUg0Tmg2WUNldURSaklCMHRrUE54WXBhbWdF?=
 =?utf-8?B?bHlidXEyeDlWRmU1dXMwc3VhY1RPRHBsZVA0ZHZiSEtzSmFobjZHdU5hbC83?=
 =?utf-8?B?SXloNkl2dkxGNm9WSGozSmVpZUNIZmVnNFBsYURkUm03eU5yWDhCSEw5M1M4?=
 =?utf-8?B?UE9SQjRZUXFXV2RxVlA0OG93N0tMbThoeWN4RHc3WVROKzMvdHRrYU9TUWk1?=
 =?utf-8?B?Q1FOSWQvTE4yRnhXbjVDUFArVGlZUTN0RVdFUTNqdy9hZzlGajlPendRZEt1?=
 =?utf-8?B?dzFBMGFZRS9aeHd6RnRpdHRUbHUwUXlsdVlqck1YN2NpMEkvenFGd0FRVDZz?=
 =?utf-8?B?NXRwenNzOFFYeUQ5cEE5WVppUVBKMFk2T2s3NVlDeGt2OThTa2VTbWpyQVVI?=
 =?utf-8?B?VjdodDFpU29pZFEvTGRGQUwrSzFUM3hRZ0p0UUIzU3hqOGREejJBU042blhu?=
 =?utf-8?B?d09WRGNud1QrTVoxRXpLOWg4UExYbmVGZm5CelVwSEhMV1Q4cHNlc3NmT0NE?=
 =?utf-8?B?cC9XcXpoUkVSRGNlTUk5MzV5cjQ2NGRtSTR5d1FsSWZLdWdoWiswUUZ6ZG9M?=
 =?utf-8?B?M1RvUVV3bnJNcWdTcHJ1Y1ByNS9UNWxCQldZMEdRbWFuYk5uQVk1WGJrVjhD?=
 =?utf-8?B?cXBNSmdCbjl6S3RFWlRXQ0ZHTjQ0OGZ1WVRTYnQwVVcybE0rNmcwN1ZsK1VU?=
 =?utf-8?B?Nnhwek5Zdnhqckd4blBFcDY1WEZiU3JoejhPWTlpZ2s0blBvWGppSklZdmpl?=
 =?utf-8?B?TUZEaFBpd25QV0Z3eVRsWkNKc3pHWklyQ2ZZa256QXhFbU81eUhSTStObFNE?=
 =?utf-8?B?eTc4djRGQXhpcitRYklhRzhWRDJlcHV6MGw1T29YNVhWTHNGbXFGK3RYamNH?=
 =?utf-8?Q?PB0SAmZvI9zs5WeRUSRl+YBci?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251f8807-bb27-44e2-ffa2-08dd34aa2f2b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 14:46:09.9463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XR9eiVAT7roRRsmHldtV2T+ebJytNXDo0a62OHbki00w0CgJtj0XyiFOzF83YUB8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6812
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



On 1/14/25 14:58, Vincent Fazio wrote:
> Allow the ZyncMP RTC driver to be enabled on Versal architectures.
> 
> Also, require DM_RTC since the driver uses the RTC driver model.
> 
> Signed-off-by: Vincent Fazio <vfazio@xes-inc.com>
> ---
> Changes in v3:
> - Revert a typo in the help text
> 
> Changes in v2:
> - Add DM_RTC dependency (Michal)
> ---
>   drivers/rtc/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 9c2d1398247..6467f20422b 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -294,7 +294,7 @@ config RTC_DAVINCI
>   
>   config RTC_ZYNQMP
>   	bool "Enable ZynqMP RTC driver"
> -	depends on ARCH_ZYNQMP
> +	depends on DM_RTC && (ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2)
>   	help
>   	  Say "yes" here to support the on chip real time clock
>   	  present on Xilinx ZynqMP SoC.

Applied.
M

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4522C3DA41
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 11:59:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB41D87D07;
	Thu, 11 Jul 2024 13:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wqn0Ms8b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7960C80705; Thu, 11 Jul 2024 13:59:41 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58A5687873
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 13:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnGnRFCSyD/jG+f23pUcg6FdCZ/lfCmPm0ZNy0lvMD5WKEz4kHBKnVcU8jCMf0vXud4ouLCMvLSSAD2jU3T3MDfulXPnvWaEBWXKta0VoIBTeoDr4e94EnpDg+a/N7W0DF3NBTURc/qmmkTcPdeAhD4Hf4XTsraTwjthUYCxJVhwtX3up7UTT19F9ql2Npg9MWqYYx/a3lGjFKQUrhNb9jfKSyOAB0y1ZAnVd0DzMfZ3iJRCuPOoqcklh5tLyXeDFqqzHc2Aaok10m5qZwkSpl/iqOiamxPSWIxKAWncf7A8C953+g75QG63fBhBVqClFacHGxjVQGzS75ksAU19Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZH/sbUCyCjvQH5ANNWYFhT9nGXubdldNbtz2+aFwCmU=;
 b=upyYcFYpELwK3XiD9B9e/YSCfaDP4Ffd5eS49YwX5VwmWkEMGHM0iQ8chhc57N286dlTPtJWVxaEALpYFcZJ5Xw33l2wZUGVrebhnO2bB6q+5g2O80cZfeSpP0+ZfulFaX7vORlu1HhEq+ahlwha5BS+U5tqWWaWsX9DPsghQW4aVofGBGdReKS3M1PLXeqQQMsh7r5Vp97DYZUgeSec/XmPbCxYs+1kibQEhN/rHldPEpLYoBMNlcK93CvF4rLb6nj95UDsu8bv3uxL3SEq9Y1/pv2D1z8h5SdCp+izIWBN3bDE303p/z0LQVisXwjsqojN4WkaxXFeCnvEOGN7Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZH/sbUCyCjvQH5ANNWYFhT9nGXubdldNbtz2+aFwCmU=;
 b=wqn0Ms8bKd/uMffroJ8HtAjLJ6DOOsiXBEoG3HIVgKoSdRRXzl0EgCf5hzx9L5BNIBV1QyWeQGtFV/W/a1ZKSQcK6O/clLyxo0TIQFXbXRbG1oKjRDV82CNOyPGolQskixQT6CBjEEDkvYlOw4mzimWFUfcffwkIODnSwrRJKz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH0PR12MB7907.namprd12.prod.outlook.com (2603:10b6:510:28d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 11:59:36 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 11:59:36 +0000
Message-ID: <aaf27d47-c5b6-45f6-b013-dd95566081f7@amd.com>
Date: Thu, 11 Jul 2024 13:36:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: ids: Add IS25LP01GG flash support
To: Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.denx.de
Cc: venkatesh.abbarapu@amd.com, git@xilinx.com, jagan@amarulasolutions.com,
 n-francis@ti.com, d-gole@ti.com
References: <20240617041841.1336632-1-prasad.kummari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240617041841.1336632-1-prasad.kummari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0193.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::14) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH0PR12MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: d0315525-47a9-4466-aad1-08dca1a0ef2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEthYXBLQjJPUGpodTN1a1dEdEY5OTBiazYyc0ZuTzAvZnd6OXdXSW5mQm1D?=
 =?utf-8?B?ODJCZmtPWCtrL0pNR1J0Z3E2OW44Ri9hUVZoWjNZeWN3UEQxZkhxKzMydWww?=
 =?utf-8?B?ZDJEdnkwZ0txdlpnRFVzK1VBWkJFdGNaOGJxcDI1QUdubGc4N1ZjNVc2MVlP?=
 =?utf-8?B?QUhmTk9HTjVkN0szeGwvejVGemhSeUI2NlVRZXEyOG9MV3RSb1NJNUVSV1Yx?=
 =?utf-8?B?ZFlNZExSQVNoYW9FYVhxa1AwUExwQ0RNaWN0SDZUeW9ONmRadGxTZlpWZmUw?=
 =?utf-8?B?Wk5QM2ZNOGlSN3EvTHpyTEtPMWF2aUo1UDJIT0ZWMTV0Q2RZeEUrN0lsRTh1?=
 =?utf-8?B?T3NrNHpIQlRRNGdKUldqdUVudDBNNkpLazI4TkJqaERSQU5oQzZoT0YybThY?=
 =?utf-8?B?VFAyV2U0L0lITFBzb1JobTltbENUNTdsZ1o5WENBWURKUFlrQWl4TmJDaDBP?=
 =?utf-8?B?T0N4cUxmZHlqU3I5LzgvNVV2bzFsbnRnWjIxQkIvMGNQUFVGZ044ZW5xcVUv?=
 =?utf-8?B?ejR4TTBPV3hXdTBPc2UyRG1ra0NnMWlSTnJmMnVVRUI3b0RONE9VSm9QU3NO?=
 =?utf-8?B?YkpQaEVNeXBvZWxtd2NiWk9TUzE5UWhnTmNxRHZKYnJBUDJZNmlqQ2x2RjN5?=
 =?utf-8?B?eXowNlNIUHJYeDhKTU0wb2JzNGsyWUlTKy9tN0hCc1Jza29EZmdtc3dkZkJ5?=
 =?utf-8?B?NHdsbEVLV1p2M21veEpEQU1jekcyVlNqTlk5S29Eb3orUCttc2V6TFJDaCtM?=
 =?utf-8?B?ODBiU2pwME9yYWVlb0xNYVQ2UmMwTnRhNW1LTk5jVk1wcEx3NWZCWi9RVVdH?=
 =?utf-8?B?UEk1bVY5dVg4RnlvSTlySDk1QndFL0prZStUclVPcDdKVXlrQWVZZVZwU3ZV?=
 =?utf-8?B?OHV6OXU0WERVcHVib2FsWU5ZZ0JveVdFVjBNQmRiRE1lMmVwdHdHMm8veDBa?=
 =?utf-8?B?OWNVWkRoRVE5aFRLSk51dGd0ZEgvdFJnN1JFaFV1ZHltSHM2M0RkUDFMang4?=
 =?utf-8?B?aW1HRTMxWGRRem1TbWNJOS9jczVtRnltV0didytRZ2hIeCtFQlAva0Fqang5?=
 =?utf-8?B?MFYxQi8vWlNPQXVtZmVoaXFKM2Z1YS9uYWVuVm9qbWpRUXBxM1VqdDNJcFd1?=
 =?utf-8?B?Q0NvV2F6bmoxbStvVGhheEttUkhJOFR4UlF4YTV6eVdnYitBV3ZtVFduenZj?=
 =?utf-8?B?eHhoTjMwa0p2ekFtaEk3R1BzWlA1MUtqd2hicHRJbVhZQWY2NFd2RXhLWjhk?=
 =?utf-8?B?MUQxOFZJQ2M1bFFZcDlZeWdSeDJiNEhHZlBIcTM4OGJRbHYxRHhKN0ppZE1h?=
 =?utf-8?B?bWZTaFZVOVJOMDQ0SmxmREJWMzRiQ0pMMkRib1daWXBMcDE2WFBvL2F1Ynd2?=
 =?utf-8?B?aWlRSEhwMlRBMWRWODQyZ2oxaTZWWEpRUDNIeG5DOFZRSDBoU3hCTTNiKzVx?=
 =?utf-8?B?Y3AvbXFTWWZ0ZStFeWl0dE5NWUVvZWswUkM3czg3TDhheWQ4andrUDY0SHFz?=
 =?utf-8?B?bE1ncGZsL1phYjh6QllKTmorajZlbjRRVjlDckc0NGo5K0MrNG9iYkZLMG9B?=
 =?utf-8?B?TllWekE3cXBZVGJDYU9sdUQvNmFMVk1TR2JpdEJGekRYN0RWR2xjeVlHZEFa?=
 =?utf-8?B?bDltTjJGNEZoMXlZZ01BZnhOaWhaU2Z4RERaK2x1TG5XLzJ1amwrZ0p2TndP?=
 =?utf-8?B?SVNZa3lLYlB1SG81VmI4d2habmQwanZwMDdkVjdMajllMHdOM2pPcVJkaGl2?=
 =?utf-8?B?bHc1Tmh4d1VQU0hFYzRjcHBZNVRaZ082S2hpUmpSUFpTSDRNQkFOQ0FWREYw?=
 =?utf-8?B?QllnNVRGU3ZFODUvL2FJQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlNPZnNQV0VBYjU2Mk5aY3JRL2JVWTlqdHo4Q0duL0o4VGZkZzR0VStJR3Vo?=
 =?utf-8?B?d0N3SHdlRU84OFZtK3hsazJRZlZrRnhKQ2dBQ1VPUGhySFplVGllNUlyQ05r?=
 =?utf-8?B?NG5JenVZTFlEMkdsLzJWNXRJYTVLZjk3VlNLU000Y1hZMWN0UXpCYng5ekMv?=
 =?utf-8?B?eGVsRFdNOUZ3Sld3Uk5pQVFselRlamlHd2NYVkZPTHpDOHNLY3NwcndqOFZZ?=
 =?utf-8?B?MTQwemxyUXRDUDZFckhualN6Ui9EZEI2VHlBaStpS1c5SERjUnluYzV2K2hR?=
 =?utf-8?B?R3lJSldwNkp1alpuSzV4eUFDZEkwVDRubXI3MldNMEQzL3VCaXZRNXQzODly?=
 =?utf-8?B?SThiM1BVSXRvMWZUelBtOVJzSSt4Wk1lN2VPclhPY3NnVUp3bmNLOWlJZ3R5?=
 =?utf-8?B?MExYeGMxaGZrcHA2c3lQYlFKZXcweUtySExvcURDNjdFbFV3UUZURno3RmtK?=
 =?utf-8?B?cnVway96SXAveGRjczE2eGZrNEhmR24vb3pmenA4NmptbTZkZXE4dnZVeS95?=
 =?utf-8?B?TFZldmVaVVFhS09Wc1Q1SXNNNVNwczFmby9LS2Q3ZEozSm9JZmZMTHZ4YXln?=
 =?utf-8?B?N25sOGc4cmV3cU0weXQ4Qi9aVi80MEx2eFlGbjVRWTNOSFJiL0N6eUVubGFK?=
 =?utf-8?B?VFlpTEZxNHJCWGJlWWl0LzhYTjJLNWtlMjl1ZDFJQkx2TGlJYmRVVHRLaE84?=
 =?utf-8?B?aXlxVk1RNENDang5SzhrS01OMnptaHlKUlUyd3pXSzBsWHVDSGhZV0VZclRY?=
 =?utf-8?B?dFBRcWkzQ0RNMklwUjZVT2VOaGtvRXl1RGRiWG9sd0hGYnZZdXJxa3NoWFpa?=
 =?utf-8?B?QzlsSmdZQ0FmMW11VFRjTlB1Y1ZJMWhablQxZ2wvTHUwbVR4bzJZTk8xZ3Ay?=
 =?utf-8?B?dm9LcUxCOTRDYWlPMEszc0Y0UnF3QTZCaHNlZVVKWlZ3UHhUWmUycnM1bXdC?=
 =?utf-8?B?bEQrank2NGlScFlyZ3h0NCs2bzRqemh1VGJEbG1qUjUrQmVQWThUQ0N1cldp?=
 =?utf-8?B?MGVXckVjRlhKQUp0SnQxeUMyWDdFazFKMnJ1K3QwNDBCdkdlQ21ZcEJtSklT?=
 =?utf-8?B?LytiTVlBRDZXc1BzM2tRaWR3Qk9zS3FJY2V0diszRlVad1NrTUJQYmlPQURV?=
 =?utf-8?B?UFI1NDBVU1o1MXJpalBWUGR1QlBRTWxvRS9JMHBGRm5JT2RnN1BDbGVnL0s2?=
 =?utf-8?B?N3haOFN0U2huR2xKMUNKdnBmRXg3N0owNVF6bVF6YXhPdEhMejkzTnlqOHdo?=
 =?utf-8?B?S2wrTTgvSVRPQkNyK3J3aHBUQ1lxcVVacFFYTGdjTHozdjF1eEVhcUxUVHVW?=
 =?utf-8?B?VG1pOU9zMlIzd2xrNlh0ZzRuTHVzVkY1T3RDNzk4YURPZi9HOTZieGxOSmY1?=
 =?utf-8?B?U0FOTG5Wa3M1UkxYdkZ5cm41ajN3amZ1WXhIK0NjZ2JSZEZTUHdveFdXMFdj?=
 =?utf-8?B?TEt5eWs1dU4xbkFPU2NUT0FSeUx2eGpFRE1QWlJoNlhTK3R5OVBsWVhhVG9k?=
 =?utf-8?B?ajE3TVNFc2x4VG8vclIrb0JnZzRzUE5wKys1N0REcUxGc05Ea28xTlJ5ZWFY?=
 =?utf-8?B?Z0h0UTBEQ2dCWTEreXVLS1pxRmtINDgyN2JVVDBIQ1F0S3B5dUNPWEVQVHNa?=
 =?utf-8?B?TVB4SlAyQkFKZGllLzB5RDJPVTYvZVFkZVJnbmZOZUVqN0g1eDErY3RtY3po?=
 =?utf-8?B?MUNkUWd4eWVINlc3ZDFTOXRSTVpwRUJaWU9ScGxsYWRPT0Vnb2VodWM0cWU5?=
 =?utf-8?B?U3hEbDFPOWozaVFXa2xqbFNWRGt0ZmIwTUlocnhzUVFLZnhkd0l4c3JOV2hv?=
 =?utf-8?B?UjRiM3Q1K2NlS2p6WlRHMVl6MnllMmphYTMxN2h4bU9CL3ZERkRyZ05Ja1pN?=
 =?utf-8?B?NXkxVjJKU0ExWldxRmJPQTNBYTRwN1ZIY0twYWI4Tnpwd0k2aG5XUFBsK3pO?=
 =?utf-8?B?L1BJVXF1d1ljZm51VTc4dUtTS1VGMFlId2N0dEZidEFLUnFvNFBJVjhlc1Iy?=
 =?utf-8?B?SjBudXNUUGN6VnB0Q3N6Q2lLSmg2OHlDWEtPTUt1dStzbVRRblBndWM4TUs5?=
 =?utf-8?B?NlZKMnFsWDhLNjVmeGlDQjBtU1VCTjRqUmQrWEIraWNneFFPUFJnVUpzaXBT?=
 =?utf-8?Q?N7Hur71ju3WYqOhC0Go/FxRZV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0315525-47a9-4466-aad1-08dca1a0ef2a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 11:59:36.4294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AiRzi9Vnz3TNxu1qBDSKbZt2vMMl8uaJR/R4ucRUWZj7+OncjU0fQj6XH5XaDNyO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7907
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



On 6/17/24 06:18, Prasad Kummari wrote:
> Add support for ISSI 128MB flash IS25LP01GG. This part
> supports 4byte opcodes. It also supports dual and quad
> read.
> 
> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> ---
>   drivers/mtd/spi/spi-nor-ids.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index 4e83b8c94c..8cad764237 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -242,6 +242,8 @@ const struct flash_info spi_nor_ids[] = {
>   			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
>   	{ INFO("is25lx512",  0x9d5a1a, 0, 64 * 1024, 1024,
>   			SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES | SPI_NOR_HAS_TB) },
> +	{ INFO("is25lp01gg",  0x9d6021, 0, 64 * 1024, 2048,
> +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },
>   #endif
>   #ifdef CONFIG_SPI_FLASH_MACRONIX	/* MACRONIX */
>   	/* Macronix */

Applied.
M

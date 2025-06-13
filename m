Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888F4C61DB2
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 12:34:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEE2782CA6;
	Fri, 13 Jun 2025 14:33:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qrAcDOrT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B1A682CA8; Fri, 13 Jun 2025 14:33:58 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 779C482CA0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 14:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbL7nTaH8xRwTKoVXQ5nWbQEk46AAusrrVM616cve3hKqmcch9dLkUtQ1nLoJoumXzpweWYk1nEpakYl83TFWTglwR9Id7Ebu0i5fUT2dnIuUvuu0MtZRvqj5miVJsRm2ZE9rwv+/BRWt9xGyDVS4yM5YLgMVjo0IfaboV9gBuqyFp4BGGOoCwoFf+MNW5hOmwxt1x52OSdfCnb93er8hHmQtUriteo3K2PBuf3rO7OtG7bC0qLxWCXp2ExnB0e20n8ErHTNYzfVaCOgX1KkcRNTzP2G9rAKloMYnJVw6eUGNvw+Y/LTRKYIFKwBQBA4MCRQ7Hj2gKy6ZIY3Cqczrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEBq4oxHmNVCd+oLy6kSB7ZRf96ilkOXpssMkfQES6U=;
 b=tQ+coH0piEqwEggvfi7Z9iOvbSY0DRDA2ftNq91j779bXTaBOLnvTozmzwuVXXKfJUx3GaA9ANw/Q/Z/0UvgeKzNE5XF5e1z9vSwTgCy/CwHJ5JuyEfh07jQJwaWRacWsN1FaYbxyxyvqiJ6rdK56fOVkJNi8xkVn7UGPLHdI78VJdMHkAkzs2GQS90fDDiD6/xjkNWsL7C9eD0AmhhbD9ySLR7hsh997U/wgmR46sVbL69ArucU9bctBDKj27OD77sqG9Y+i35sUwTQtjTKglFTh2QieOk/R7FjK2odQF0wPlt2JlPZdrjZAY/MPQpoP8xhRaFGVUKOGJGGOH5XUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEBq4oxHmNVCd+oLy6kSB7ZRf96ilkOXpssMkfQES6U=;
 b=qrAcDOrT+UGwWN2AjbNzzGuXGX0oNm++H2iTAPyXG4MJHAmY13TNYDud+TzONVvRraZarmlRoiITUiqoYAUriXR6+1XUphcGKrCMxUGGvD/sZnAra40GU7jDcArMt7wT85PbANg5pFDU5opAF52qcRdya+NAoZnoR2OZ4x+CZOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW4PR12MB7384.namprd12.prod.outlook.com (2603:10b6:303:22b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.41; Fri, 13 Jun
 2025 12:33:49 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 12:33:49 +0000
Message-ID: <44bf4391-8c8b-4018-85c6-ce75c9a6ffaf@amd.com>
Date: Fri, 13 Jun 2025 14:33:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tools: zynqmp: add build script and documentation for
 ZynqMP KV260
To: Jerome Forissier <jerome.forissier@linaro.org>,
 U-Boot mailing list <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20250612153311.2379944-1-jerome.forissier@linaro.org>
 <7dd048ed-4f8b-4318-88d4-3bdf14f961b2@amd.com>
 <79cac2b5-630b-49b0-a4d3-54e7af2d605d@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <79cac2b5-630b-49b0-a4d3-54e7af2d605d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0260.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::27) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW4PR12MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a401375-41cb-4650-1028-08ddaa768bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1hZV0tuZkNWeXVxT0ttOVJ0dFZkYVZTek9CUlZjR0VpQ2RpT2gydko2MmVl?=
 =?utf-8?B?WmtLUkk2Qi9rTWpqa3laZkNHV3FrRnVWdDR5YnhCbWFEeUNiOEJTUjBHRklQ?=
 =?utf-8?B?a21LN3hKN1JMRG9vYmNYOGtVTTJycGYxanVHL2NwMjVXM1RFNGVsL2czT1Rh?=
 =?utf-8?B?dE9aQUFtaUhLcHpvMmx0SGZ2ZDMzTUpyNjBPZFJVS2RMc2dZSzViUmZITk9n?=
 =?utf-8?B?Ti8zNXJMUGZRT2hxQkJDcUQ1RjM0MDZQeUh2OVVoK1dpcFRYcmtQYWpRQ1lP?=
 =?utf-8?B?QU5jcS9XZEFrdjUwVnczUUpRbDZNZFJhYzVacTFqZ2t0SktmS3p0Q1VRTHhG?=
 =?utf-8?B?ekJxeDJ0eFNCNnA3N0VlVlV5ODRaK0VtRnlPSXcwZXlYbGovMG5XNys4LzZC?=
 =?utf-8?B?Ym14b3NKSGo4b2pUMkJoQVpqY2Z1dGsyczBaZnp6bERXUE9MM09OQTJySG5Q?=
 =?utf-8?B?MFJsdWU4bUlQODhHZXQ5RUx2MHNrTW5kOWhUVlJmc2J2M1QwMjRyaXFtSEV2?=
 =?utf-8?B?MG15OExoNW04QUdvL3RYWm0zV3lDUVhyUHA1K3NZc1dNZ2FkYTlQcVg5aVM5?=
 =?utf-8?B?dkQvS1FXV3NpZ0o3dnZtNXovWFI5NTVSamt1cTZ0UkV1Qzh5djFtejlBS1VO?=
 =?utf-8?B?L1BLOG1JTEtDNzhYMlF6OSt6dzhvTStTZGlaUzZxZFdCdVpsWVdtZWxXTXl6?=
 =?utf-8?B?Skwxa3o5dFZvMHZ6cjZSV1VKOFFKeFllYzZPTFUvRGkwY2JkODFMMkY2MElz?=
 =?utf-8?B?VW5adzJmSnN6bHBEWHAzYTVxdE0rckNoV1QzZngwYUpBaS9SNnRBWVFGS29m?=
 =?utf-8?B?dTNsUDdwcER0WmVNcmJ4c0pUYTJHc3VWL1kyeFBhRnJHY29mYmtIa0JhNWEw?=
 =?utf-8?B?THZMNVNMTmtLWDE3dStxOUwwcXowemJvWGxQSHRwV2VSNFU5Qlc3Z3Y4Y2NV?=
 =?utf-8?B?M2tGQjkzVXc1cEYvZ2xxbW5yZU9oaTdTSG90ZG5SMWdTcXhyaU5CYnNlU1pP?=
 =?utf-8?B?QVBzSkROMWRFcHpjclZ5N3VPa2VQYVF4bUQ4NkxPdFV4LzBQTmdrZ0s4aWtN?=
 =?utf-8?B?MDRnMkUxd0djakdZdDFHc2Q0N0VLZHZHSDdzclQ4VnVXQWRsUXB2bFlXUXRx?=
 =?utf-8?B?ajJ0ajZ1V2tUdnBBSjkrcm0vV3NuZVFuUlNtbXNNOUlrNy9mSVRpaFJaL0RT?=
 =?utf-8?B?ZFYrNUV0NkhXVDdNbTJBMGF3YjA3OHlLU2VjSGxDY3ZBbHRSTGhhbFR6dXpW?=
 =?utf-8?B?a1FYQ2gyMEhiTHk2VzNxenRoOTQrZXZZWS9QbG5TZmM0QVV3cGZvZzg1Qm83?=
 =?utf-8?B?UHNVZjdWYWZtVGdhMHprUVdsYVh4WmFTbldjaWx5YTBvbkZ3Qy9YZjlwdmt1?=
 =?utf-8?B?ZUZaT2FhZFhlZ0VYWElUMHV1YmtnVTVBVjhoVHZlSWJETjRXdnlHTUh5R2lD?=
 =?utf-8?B?UTQ0UTBITDR3UzFaZnFiRzlqZjZPUVo0Z09MMzg1M1l6SFR2SmpWMHBZQTl2?=
 =?utf-8?B?RGdqUmRBSFVwOXpaNWs3Z09rTHRaMnBHSWFBUVpJTFF4c08vRWN5VnlKc1Rv?=
 =?utf-8?B?cHY4ZGh1QUw3R0Nyb1dXblptdVlpa2VRaVRVb2QrTkFrd0R6TXBkaVZCeDRE?=
 =?utf-8?B?K1FmQ2dsaDQ4YVA5RWhvajZNTHJqNUxHb2VoVSsza2NkMGpTcFUyQ1VLV2lk?=
 =?utf-8?B?YWdKRjZEVkZvV3d2amdmQkZIdi8wdkFiNEVKMDFlbVJZWityU1B5MnpKamNy?=
 =?utf-8?B?cE1kbmZaOHd5RWg3dWtlbDcxRFYvQ1YrcmFjQ0Y1cVNPRHdZWlNiU1VKM1Bn?=
 =?utf-8?B?S1RCbFZ6M1hOcm1LMFlubGh4UEkxRmhxYVFMemNxdFdhUW1KbHJ1Q3pwenNI?=
 =?utf-8?B?OFFveG5pOU9udXcySU42VldmRHA3YWtMNWd2YWNMbnFSd2kwT0hGNHVVdkpu?=
 =?utf-8?Q?AWSnNOpZkc4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTBRencvNTVpenJES210NTlLaE4vNUtLVGQxd2xUZ00wK3FvVVJPWXNDUUhn?=
 =?utf-8?B?WjAxbVloaXFsUm54YnNTVTBhdGNYYXoxdVd0dG5RK2FWZDNyVmNjTG4wTmo0?=
 =?utf-8?B?NXZReXRYczFQdEZubmp4MG9DYnVWaHdWMFNZRyt1ZFM1bG9DdTZCbVVjcmZl?=
 =?utf-8?B?Uk5FM0w5cEwrYnEwcTRCQkhCZWNjR042anlXQ2JMRlVLdmZodDdKWUV2RE41?=
 =?utf-8?B?UW44RGtTcllWamhnbjJ1QitlVGNzZCtsSzhadjFaSEw5NUNNa2lrUjlxZ3Jl?=
 =?utf-8?B?L3loRkNYN1ZQdDhIdk45M2NIZ2MrV1JqN2IvbEpIdGdES2lWcmt4Y2o1ZDNS?=
 =?utf-8?B?cERQRkF2R0FtbFVRS2RldW4wMUhxZ0NreXJkd1ljZUhtTjByUmFYamtkakU4?=
 =?utf-8?B?RzlsSHZQTzVqQTlJRVFaU1VLbXVXaTk5MXR3UlMzUldKR2dtWUNKOGZNcnR3?=
 =?utf-8?B?RkZDWWpMR2Y4NHlpdCtTT2tMZFJtZTdNVVlxQTc2aW9QdVpvNnRtMXBEL2x4?=
 =?utf-8?B?d096aGV2N2dCNUNwNWtWdUU4STdhdi9BMkNlNm05THBhVXd1dGR3OXlrVGhx?=
 =?utf-8?B?UDdENGhpbllKalR2cUN6TXl4KzBtUXVuSVZQLzdnZGVRVVdUOXpOaWd3ak05?=
 =?utf-8?B?djFhOVFuaFNSbHRqQUZZUUxOZktSR1NOK1VaNjQxUU5nNEpRVlVjdUVpcmhq?=
 =?utf-8?B?UU1odU1HQzR6UFkxUDJ4Yis1RFJ3N2tQT25UYkJ2T2RSdzdLdW0wQ1hGT3NK?=
 =?utf-8?B?RGJPa3Y5bFVId2JibWswSzJET21xOG1KVTN0L2R4d3pLbnNwWEVVZEhRa0c2?=
 =?utf-8?B?V25mR0JyOG9wUWZoQ0ljY2UxQi9wQVBwUlBzNE5Gb09TbHk4WG1LM0NUWW1L?=
 =?utf-8?B?UGE3OTA4UkZVTXo0b0RVM0dpR3ltbjUyYnN6WkgzYURENjRJblRQNGoydmU4?=
 =?utf-8?B?N2lYQ2pJWTc2Snl5RWRFbThoU1NzUkN5YW9TbHZidFRsLzA1aHZQaFVpYXNY?=
 =?utf-8?B?OFRCWXpKRnNsTlRZcVBHT1c2MU4wSlBDNXhDTUgyNFh0S3B4RHhFejgraGRK?=
 =?utf-8?B?aTViM0F4KzhyZmYyY1kxc2VDRlVFc25vQzlSakx1ZklWc2I1d0V3ekg3eEFR?=
 =?utf-8?B?N2pSazhKVUZaeTBOL0tNMHo4RTdsYXFram9IcERLMThSZkhpMFVTcHNlRENW?=
 =?utf-8?B?d1J4ditWaXBRQm43b25Nci80ZENNNTA2WUMyRWxFWVF4cVIxNi9JczYzd3pG?=
 =?utf-8?B?WHRCQy94c0hhZ1p2a0U3YXZJTG9IdTBvclA1Zi8zamtBMkU4Rlp2bGhTRzFL?=
 =?utf-8?B?WEx4WmJGOUQ3bVYrWW53MEp1MEowbks1U2ExcDJiL0lVcUxKbVVVeVIrdXFS?=
 =?utf-8?B?TnBwdmRJalNOUzZuVFF0Mk5iRkRwT2Jya1hBd0N2aWh4TERsbDJIbkZwTHFR?=
 =?utf-8?B?cWFrWnF5N2NrZFFUS1QzeHh1TzYwRE5JY3ZGRlVmaDEvWnlHQVNTQk1mQyti?=
 =?utf-8?B?REgxM041Z3R5dHNabU9VSThSdjM0RXN1ZDR4cUR6UmlZS2F1NlhVZjg1R1Bv?=
 =?utf-8?B?aW9Jb0VYN3BCVVcrQi9kemhHOXlhZmJLZGFHVjl6RW5QYVJmTEFhQWN0RGV5?=
 =?utf-8?B?VVVCRTZhTjF2SE1LMm9Hd2JqYVBBUTBYRDRSY3I1NkF4NHpTTDdDUnlVOEtn?=
 =?utf-8?B?VjNtZmx3QmIxaEU0S3E1OGlZREgyRVZtSVNWQkk2eDdCekRwNHJScklCaTRq?=
 =?utf-8?B?YTNvNENqbjRua2lHOGdSemh4OTdIZW5la1JRdC9XY1laOTN6bm9paHV3Uk1L?=
 =?utf-8?B?aVdTV3RkN1VkZEtpTWFNVTRnb05meE5ZVDNLNVg0M1J1WURiTm9xWHN5Z0hU?=
 =?utf-8?B?bHZsVlBPeHZ4dHFSeTBRUVNZZTdwZyt5cWYvQmYxUkdCRXlvU0hKdnkrd08x?=
 =?utf-8?B?VDVzQnluMTFZOFAxelZrNlIvUFYydUhuR1hUUS92dUJnRGtuaDR1ckgwUnJY?=
 =?utf-8?B?R3IrQkdUWXBiKzF5czVwT2pkOWcxcm5CUWY0VnY5V1YxMnR1NWlyNkRXU2JX?=
 =?utf-8?B?Q0N6UjFyQTRrVDh2bjFMMlJNeG1FbHlRZzl6WlRRYnNONFBYdU5YNEtGNFYv?=
 =?utf-8?Q?xASwrJj7RWCr8TxbS7CS3uDn5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a401375-41cb-4650-1028-08ddaa768bf1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 12:33:49.0373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIR1whB9f8242ciQz/A3geKy0Nl7rc7nG7RhpVUHAtrmPneeDfMm3F2DlCT0W3oi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7384
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



On 6/13/25 14:25, Jerome Forissier wrote:
> Hi Michal,
> 
> On 6/13/25 09:55, Michal Simek wrote:
>>
>>
>> On 6/12/25 17:32, Jerome Forissier wrote:
>>> Add a script to help build a functional U-Boot binary for the ZynqMP
>>> Kria KV260. Also add some documentation.
>>>
>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>> ---
>>>
>>>    doc/board/xilinx/index.rst        |  1 +
>>>    doc/board/xilinx/zynqmp-kv260.rst | 27 +++++++++
>>>    tools/zynqmp_kv260_build.sh       | 43 ++++++++++++++
>>>    tools/zynqmp_pmufw_elf_convert.py | 96 +++++++++++++++++++++++++++++++
>>>    4 files changed, 167 insertions(+)
>>>    create mode 100644 doc/board/xilinx/zynqmp-kv260.rst
>>>    create mode 100755 tools/zynqmp_kv260_build.sh
>>>    create mode 100755 tools/zynqmp_pmufw_elf_convert.py
>>>
>>> diff --git a/doc/board/xilinx/index.rst b/doc/board/xilinx/index.rst
>>> index 2e31fe3f3a4..3f3a85b709c 100644
>>> --- a/doc/board/xilinx/index.rst
>>> +++ b/doc/board/xilinx/index.rst
>>> @@ -9,4 +9,5 @@ Xilinx
>>>       xilinx
>>>       zynq
>>>       zynqmp
>>> +   zynqmp-kv260
>>>       zynqmp-r5
>>> diff --git a/doc/board/xilinx/zynqmp-kv260.rst b/doc/board/xilinx/zynqmp-kv260.rst
>>> new file mode 100644
>>> index 00000000000..219bbd602e9
>>> --- /dev/null
>>> +++ b/doc/board/xilinx/zynqmp-kv260.rst
>>> @@ -0,0 +1,27 @@
>>> +.. SPDX-License-Identifier: GPL-2.0
>>> +..  (C) Copyright 2025 Linaro Ltd.
>>> +
>>> +ZYNQMP KV260
>>> +============
>>> +
>>> +Building
>>> +--------
>>> +
>>> +To build for the KV260:
>>> +
>>> +   $ ./tools/zynqmp_kv260_build.sh
>>> +
>>> +The first invocation will fetch and build some required binaries (bl31.bin,
>>> +pm_cfg_obj.o, pmufw.bin). Subsequently `make` can be invoked directly as
>>> +follows:
>>> +
>>> +   $ export BL31=bl31.bin
>>> +   # export CROSS_COMPILE=aarch64-linux-gnu-
>>> +   $ make -j$(nproc) BINMAN_ALLOW_MISSING=1
>>> +
>>> +Flashing
>>> +--------
>>> +
>>> +Press the FWUEN button on the carrier board, the press and release the RESET
>>> +button, then release FWUEN. Connect to the embedded HTTP server and upload
>>> +`qspi.bin`. Press and release RESET again.
>>> diff --git a/tools/zynqmp_kv260_build.sh b/tools/zynqmp_kv260_build.sh
>>> new file mode 100755
>>> index 00000000000..3cf7147e3a6
>>> --- /dev/null
>>> +++ b/tools/zynqmp_kv260_build.sh
>>> @@ -0,0 +1,43 @@
>>> +#!/bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0+
>>> +#
>>> +# Copyright (C) 2025 Linaro Ltd.
>>> +
>>> +set -ex
>>> +
>>> +if [ "$1" == "-c" ]; then
>>> +  rm -f bl31.bin pmufw.elf pmufw.bin pm_cfg_obj.c pm_cfg_obj.o
>>> +  exit 0
>>> +fi
>>> +[ -e bl31.bin ] || {
>>> +  ATF_SRC=$(mktemp -d /tmp/arm-trusted-firmware.XXXXXXXXXX)
>>> +  git clone https://github.com/ARM-software/arm-trusted-firmware ${ATF_SRC}
>>> +  make -C ${ATF_SRC} -j$(nproc) bl31 CROSS_COMPILE=aarch64-linux-gnu- \
>>> +      LOG_LEVEL=40 ZYNQMP_CONSOLE=cadence1 CONSOLE_RUNTIME=cadence1 \
>>> +      RESET_TO_BL31=1 PLAT=zynqmp ZYNQMP_ATF_MEM_BASE=0x10000 \
>>> +      ZYNQMP_ATF_MEM_SIZE=0x2ffff ENABLE_LTO=1
>>
>> As I told you this is shortcut. Recommendation is to put TF-A to OCM with FSBL.
>> That's why there are some challenges in connection to fit both of them there.
>>
>> Another thing is that none is creating reservation for TFA in DT. When you boot Linux than there is big chance that user application will rewrite TF-A and you break your platform because of missing protection.
> 
> OK. What if the bl31.elf from soc-prebuilt-firmware is used? It has load address
> at 0xfffea000. Is it on-chip memory? Is this area protected from access by the
> Linux kernel in the DT?
> 

yes OCM. It is not protected but it is also not described in DT that's why Linux 
is not aware about it.

M

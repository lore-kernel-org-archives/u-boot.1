Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D934CC02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 12:44:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61E9180A35;
	Thu,  6 Feb 2025 13:44:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bd7MNJAL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C932680A38; Thu,  6 Feb 2025 13:44:22 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E99D807FB
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 13:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixoH1+bz+FiXCz9y4oWYbCtvbdbWZpsRiXKD5IFrKGA27UN5/dORkHhC66UYlVuveDSdeJtw2cFQDqjT4Hd04PSmIRbGHDyWEksHecX1gibd8A1VEYpZ7/r7H3a1kl+KtNcTC1R/QFjhJ7TMcKjZkWxEjCa93e68kGAb4elG4UWJofvTl37b9Ol5MX4ZOvbGNnL3hjKWOaE/0TAZwANQEUWp1C8nvfTwuqArTsyFFt11XCaK5tyC8OMgUvCKc6xUSOJk1swcOr/90XnCa78/PU+ypV3ukON7MBiyPKSUdxrnIWLn4H7WUchR+aanAo3y2MlZEYFewoEjY9AWGGwf+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oz0Y0AuA7JemQBscICsPoO8AaUJ9w63y7TOQ2+EDBvE=;
 b=fX7IJfg5yFGPvBPXBFUPRziDhVGrX4Rh242NTv+x9A/DWmwmmfhTQj4CPkRdUvMTR1iytqkotLzOKjh3qZYl1tURmrt7E6Dx8PjB4hZOPRpgTbmoqPo/2MOZStrt/u/vtnSPUu4MkA1/ZFaXOZzdQHQ0wHUPGZYIzaDHmBecXFYFO5Vld9TdYel+XvME5OJebpu8ylXHd31rRb4pdZMiDlgnebdNi+iGJo8u+oNQjJSkVc1s4ihQ8inA/9cCU5lKjdkdTjKKTWKzAw/ICHmZgAmMhHvLvzRdi8sBBYQIxQ+HBDfvQ1YphIGfWJ/QCiqal2Ao91gi61S3UqV6NRfbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oz0Y0AuA7JemQBscICsPoO8AaUJ9w63y7TOQ2+EDBvE=;
 b=bd7MNJALesCcsCDVL6a76oGCtKDlehttERkKsJWGf0Z7YMNoq6VE+AohvcrBHImuRvMMTSAOoTemKt87ZTn7Z74JIo2FUSMWhoRDpNFeezuhaoOBEJet8xtZh02tlA2iDrkRJhdvhHq79a6CMTGGDWZkHD5AQ5ogEaRiuy+f3TI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 12:44:17 +0000
Received: from PH7PR12MB6538.namprd12.prod.outlook.com
 ([fe80::f0e4:5de5:39b7:ea7f]) by PH7PR12MB6538.namprd12.prod.outlook.com
 ([fe80::f0e4:5de5:39b7:ea7f%6]) with mapi id 15.20.8422.009; Thu, 6 Feb 2025
 12:44:17 +0000
Message-ID: <f7689555-3509-4fa4-a435-6732fe1096ad@amd.com>
Date: Thu, 6 Feb 2025 18:14:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Enabling test/py/tests/test_spi.py more?
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
References: <20250131200007.GR1233568@bill-the-cat>
 <20250131225825.GU1233568@bill-the-cat>
Content-Language: en-US
Cc: Michal Simek <michal.simek@amd.com>,
 "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "Begari, Padmarao" <Padmarao.Begari@amd.com>
From: Love Kumar <love.kumar@amd.com>
In-Reply-To: <20250131225825.GU1233568@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0203.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::15) To PH7PR12MB6538.namprd12.prod.outlook.com
 (2603:10b6:510:1f1::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6538:EE_|MN2PR12MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: fb4f05b4-49ef-4a4d-65f8-08dd46abf7eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VG5zK0hHb1V5S3VNK1R3RlQrQ2U1aWZoc2N3U3lLQU1oNnk3cURPNWVKWURy?=
 =?utf-8?B?MTJzZHRCdEw2eFh1dmdDS3I5RnR3cll4dVBxVzlGLzFwRVdwVkg5REJjY29R?=
 =?utf-8?B?YjFYOFhJWkFodituLzk0bXBaWVRaTHM1ZDZlRXIvaE5LTWRGckN2QmYyM2Zp?=
 =?utf-8?B?MVJBelRNZHBIU28zenEwZjk5R0J0eWQ4cThDcUp1LzhicVY4U2xmRW1GR3ZF?=
 =?utf-8?B?YlZWeDJrWkJVRnBOY0R6QUJTbEpmUGRJZzNIOE5wMmhJVm93SGVoM3orVUxa?=
 =?utf-8?B?ZHppNVFJd09LYzNBM2hWNEpGcUcySWd6ejI5QXhKZlhiUGw1MHpLdVZSK2VE?=
 =?utf-8?B?a1g0Y21EMHBtelNKcm5sUVlFTVhjQVlrTTVLdmR4Qmt0aGhOMWtXRWZ1SGJV?=
 =?utf-8?B?SkJTVVBqTm1CQUk5Q0RWb0FyQS9TNlgvaHdhcFVvTWV0NjBSZ1JBWlU4WmlS?=
 =?utf-8?B?ZUwreEphZVlra2oxK1MveThDSXB1TXNmOTI5ZUJaTi90cmorbDF6WnRtMlVC?=
 =?utf-8?B?UVdaL0ZHL0tnSnZoc0xMdXVmVmhnTU9WZEQvUjZLVEJROEp3RTBaRTkxdkI1?=
 =?utf-8?B?L1ZOVDJZZWhlK0RZdFpaSlNLSnliZmtOSjVVMjlKTjNLR2ZlV2FmM3BVU0VS?=
 =?utf-8?B?YUVDQzlzZmZlY0Fsa2pobUd0cEZ6Vy9zOUJEUjl2enVqaDVtaGxjME5YSCs5?=
 =?utf-8?B?TjNBR2pIL295Q2ZLUE10M2hmRGtBdmM3YnI4TGJSbFREMDV6cjArQm1UMEhy?=
 =?utf-8?B?bzlhaXJMcGtVR1Rob1NBNTM2S0ZpSGtQMVlsSHQ5bzFyQ2VwSzcxQmt2UlJm?=
 =?utf-8?B?cnVqb2d3bC9CU3RsRGVSeVBVdmZqRW91RFJ6UUJDUEN0SGk1WDNVd3orNDhN?=
 =?utf-8?B?cDNKeXpZamRhM0dsUGxTK0ovNEs5THFSYnlPc2NQYUQ2bHNTUUpkbjBqZlVy?=
 =?utf-8?B?eDZTS3YybU1hRVVoV0VvcmU5eGZpREFJUUlqTFdvQVNWUWNZRkdIY1JSeU0y?=
 =?utf-8?B?NHJEZzlERExGRUt1L1R5aUZzTjlSck5hc3lFOGpSd2FxeDB4cFRjeXAvMTZF?=
 =?utf-8?B?OWZUU0p4cnliZ0R2eVFsWVFCMUhrQzdPbHFtZnZhRlZkWmNzQkx5S25za01I?=
 =?utf-8?B?OWw1L1NKZktFNFp0cFhLNWRHdnFwN3o3cG9zOWVtMnVlZEhRMXBjazh4b3RF?=
 =?utf-8?B?YUh6VGdiYmdrQ2FWMnB6M3Qzd3AyKzNBNHdZRjkxN01HdVIwdVBGUkhzbHda?=
 =?utf-8?B?MXNSdVFmYkxGM3hNTnFPVHpjTStFaVJydUlETS96NitRWFlwMVhsZkNoNVlE?=
 =?utf-8?B?ajJBTUVZL1FCMEZJbWczUjJjbnBjSTFKZ09QSU1MSGJZYkM0NElKb24vMjdT?=
 =?utf-8?B?V1pWaDJiN2o0V3JmcHlaR3pJRHdMRmw5dGZWOHZML0xXQkt4VTMvZE9vQWFD?=
 =?utf-8?B?akI4WHIvQmh6dWJ6VTRJOG40aVNFbFFCZTNQaTBaNm83akJhbDJWZzl5aGVS?=
 =?utf-8?B?aWlLblRyb3k0N05pbEdBYm1mSW5pbXNxY09yeVd4SkhINUIvYkJqSCsvNmtk?=
 =?utf-8?B?eWhwYk9DbUM3UUhQbFdYQWowVVJoeUIyVXNkMGtVZ3l5eitaQjhDdGh0NE1E?=
 =?utf-8?B?VGxwU2tqQjBMRERPb1hRMEluK0FMcERPRnd4NHBjeDlZd0RnZUJia25ISHBq?=
 =?utf-8?B?WTZmekZmQlF6cDZIMjBWbjhDdWhwOHkvV1RMYmRsMDViSVdScmVTbVo2RkZm?=
 =?utf-8?B?WENOVVdqZ0RwdGJvQ2ZMY0x2NmEwdG1RMjVzaXk5ODVmeGl2NWFnVHhnYmVP?=
 =?utf-8?B?KzMrMHlmcE1NQ3JKYkR2QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6538.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFdSbWR4cW9HSUU0Y3JOdVdaWWhJQnkwM3F4QU1Ja3p4NlFBRmJ0YjhFZ3NP?=
 =?utf-8?B?Q1FFL21NTEY1MG5xTVlSYkZaeURzSkJPeGM1L0VkNlhBN2FUVlc1Q2dwdHJy?=
 =?utf-8?B?bVpEYVRyRzNmVlRHRFZYc1k0cWswY2J3Z082SnFQbnpENEcrbS9ucHpwaXA2?=
 =?utf-8?B?a1ltTmhOdEJ2SmRFQTk4U3J6UCtLcm1qS29HV0gwZjN1KzV3TW8zL2hEa0hv?=
 =?utf-8?B?MU1UdmptaE54aXVXR1prYlRxVERpUEdEVDNOUS9QVWRIdWx1emdyMXhLdzdM?=
 =?utf-8?B?VHR5TFFvenk1QytxNEs5RXJlU3dDNDB5dGFLWmhML2R6b3J4NEJGa1hRWHJ6?=
 =?utf-8?B?SXRiSy9pSjdyV2hIeXFrc0JwNm9ScTZ6VU5BZjJIWW42WjJiZ1laWnJvUnY3?=
 =?utf-8?B?Sm1OYy8waXl4U3JCQWlwb0xCWHJhM1VoY1FOc3ltZHlQS0RUdW00bmlsRVlq?=
 =?utf-8?B?Q052bmU5dG4yOWtrZEZtR1hZWlRrZFJ4aUV5clRJbFV1OTFEL1FjUlhROTBl?=
 =?utf-8?B?blhZUHJ0WjNKOGt1bStPN0tCcWdDeXAwSm5Wam9sYUp2dURYN1FrbzJlenVW?=
 =?utf-8?B?V2xFTXdYdmJoOGdjanlvNVdGZ280WGJ5YVErYmhLdnhjenRxT2tJMW9lM0N0?=
 =?utf-8?B?Ri84S29KUFBjWElibXJxbTA0RzllYkt0YXpORS9Gb0EzVFFHTHQ0SFlnd2dU?=
 =?utf-8?B?eFFZbDBGdmRLaHRJQmd3ZS9oTXoyVUJNY0J3aHc5dk14SVVDVndCZVdZSURV?=
 =?utf-8?B?WE1JaTl2WThaWnZyY05qSVRYYVZIRnpObU53Qjhaa3RaS0NoNElyVDgzRW4z?=
 =?utf-8?B?UGs0a1dEbGQzYU0wZFNsVE51Y2srSUcvVEdibUkzQ2NCeTdlUk15WUphdVpm?=
 =?utf-8?B?bzQ5STFERS9wbXppMlhURGNXR3g1SUQxL01jR3hnTXFYazFpaXQ3SnUvanlr?=
 =?utf-8?B?QnU3YUovbTFlQVVGTmg3SmlnZDV4MkJWQ1hZcnJ5OEs1TjlrTjlreStsVmZw?=
 =?utf-8?B?RVhWYjJEbm1CbHdpNzlCWUNMV29IQ3I4bU01OHl6UXlJTFdyL1IzYTcvNXpQ?=
 =?utf-8?B?dnlvNi9sdzZhOC9uZGR3L0U2ZFFzTDBJVG5qcTAwYTVlYWdWZEM4UDVOV1Fr?=
 =?utf-8?B?Tm0yYjNIa0QzS1JqTmZodEdBMVVxQVlId1F4RzU3UFJVc1N2T0pJbzRHLzRu?=
 =?utf-8?B?WjRrYVlmQWpHRXhwVWlzK2hYYXZPd3R5ZzFXSk1UZ0VDOTNKWS93VDZNWG1Q?=
 =?utf-8?B?d0tZUDZwd2Vma1RUNlBaRW1HZUVpWkl1L0YwRGwvOTFnWnRUMUhTMDJ6R2pE?=
 =?utf-8?B?TW51eThUWmJseHA5TTBFbkJraGlYUWlEbzJXZFNUU1Z6VkMwc3NvaUZHRzlT?=
 =?utf-8?B?NW9lTHQvTTRkRkQ1VCt6REtNdlRnTXNWdXNsd3haL0s1Y25HZ3JBT3VjaXBt?=
 =?utf-8?B?YS9kdlVFWUdFaE9JN1FHelNiQVo3SXBKZURKUVBxZkpiejZyeWRwWTRnVVJ5?=
 =?utf-8?B?OGdIMTR1TVdUbS9peGZCQ1dtcDcyYTNFRWVsSXZMQThNcXljOGJNMk03a05u?=
 =?utf-8?B?bHhWZEdaeUpKTDVIZFl1RzZ4MGFqb2kzUU9NRkkxazVLWWNaSnJUUklUblJs?=
 =?utf-8?B?MzlUOFJqT0FYQlUxWVhUbzM3Tzd0WSs5Q0JyWGZObmljSjRqczlPeHpnOEF3?=
 =?utf-8?B?NlBzSmczZ0ZiSXpEdzlLSS8wMU1MWnZ1dnRxZW1lZHV4T2F0T2t4VzEzYThR?=
 =?utf-8?B?Rml3c1dWejFpN01FOTVTd2hhNngvMkg3a1hOb043aTNVMnJ1Z3IwM2lsUUw3?=
 =?utf-8?B?Qit5R044UDJIM0pUN1hTdHI3SmgxclEvUW5PZTZWK3FjNDhKeTVqeWpGcjNT?=
 =?utf-8?B?aHhhNnJvMjZKb21SWUZFQmhJZUxMVHZ6czZBdWg2M2RpVzMwYlJGWU5PRCti?=
 =?utf-8?B?OW9jQWlwcU5MUkdqeVJTYWVkLzI5eVcvTTdWUUdZL0tSWjdTOU9NbmwzUUVr?=
 =?utf-8?B?cC9ZdkdJU1h6Vkk4RTRaUnVibXY5YVBiQzdjblNORzloK0tQWWhRbW1HdTZY?=
 =?utf-8?B?NTYrM3RRS205eGhrOS9oS2wwNDFaVXIxVG9XaG5ZaXhtTC9OUnlMaVIrNFFG?=
 =?utf-8?Q?LL4k=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4f05b4-49ef-4a4d-65f8-08dd46abf7eb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6538.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 12:44:17.2860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QIHS9X+FcJxBKDSEV80V1u5gFOjWzE2ph/w3VKc502xybZqAL8fbaPM0ZxG2e0S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
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

Hi Tom,

On 01/02/25 4:28 am, Tom Rini wrote:
> On Fri, Jan 31, 2025 at 02:00:07PM -0600, Tom Rini wrote:
>> Hey,
>>
>> Can you please confirm that this test currently functions on your
>> platforms? And then can we please enable it in
>> https://source.denx.de/u-boot/u-boot-test-hooks as both a functional
>> example, and testing of the SPI framework?
>>
Yes, this test works fine on our boards and it can be enabled it in 
u-boot-test-hooks as well.

>> I'm asking in part because I've attempted to enable it on two TI K3
>> platforms (am62x_evm_a53 and am64x_evm_a53) and the write twice test
>> fails there and while I can repeat the failure on the command line, I
>> can't make the same concept fail at the CLI (including 0xff'ing out
>> memory before reading back to the same location). I've also tried
>> enabling it for sifive_unleashed via QEMU but that in turn seems to fail
>> differently, and possibly because we're destroying all of the SPI
>> contents and need to expand the test to include a region to ignore? I'm
>> not entirely sure, I'm still debugging that one.

You mean to say some regions in SPI are protected and test should ignore it?

> 
> As an easy'ish for-example, if you rename
> py/travis-ci/u_boot_boardenv_evb-ast2500_qemu.py to
> py/travis-ci/u_boot_boardenv_evb_ast2500_qemu.py and add:
> 
> env__spi_device_test = {
>      'bus': 0,
>      'chip_select': 0,
>      'mode': 0,
>      'part_name': 'mx25l25635e',
>      'timeout': 10000,
>      'iteration': 5,
> }
> 
> So that the test will run, it fails with:
> AssertionError: assert 'f753d4e0' in 'crc32 for 822000c8 ... 83212327 ==> bf3e333c'
> ------------------------------------ Captured stdout call -------------------------------------
> => sf probe 0:0 0 0
> SF: Detected mx25l25635e with page size 256 Bytes, erase size 64 KiB, total 32 MiB
> => => crc32 0x82200000 0x10
> crc32 for 82200000 ... 8220000f ==> ecbb4b55
> => => sf erase 0x0 0x10000
> SF: 65536 bytes @ 0x0 Erased: OK
> => => sf write 0x82200000 0x0 0x10
> device 0 offset 0x0, size 0x10
> SF: 16 bytes @ 0x0 Written: OK
> => => sf read 0x82200054 0x0 0x10
> device 0 offset 0x0, size 0x10
> SF: 16 bytes @ 0x0 Read: OK
> => => crc32 0x82200054 0x10
> crc32 for 82200054 ... 82200063 ==> ecbb4b55
> => => crc32 0x82200000 0x1012260
> crc32 for 82200000 ... 8321225f ==> f753d4e0
> => => sf erase 0x0 0x1020000
> SF: 16908288 bytes @ 0x0 Erased: OK
> => => sf write 0x82200000 0x0 0x1012260
> device 0 offset 0x0, size 0x1012260
> SF: 16851552 bytes @ 0x0 Written: OK
> => => sf read 0x822000c8 0x0 0x1012260
> device 0 offset 0x0, size 0x1012260
> SF: 16851552 bytes @ 0x0 Read: OK
> => => crc32 0x822000c8 0x1012260
> crc32 for 822000c8 ... 83212327 ==> bf3e333c
> =>

I haven't tried with mx25l25635e part but on other macronix part 
(mx66u1g45g) - it was working on ZynqMP. Need to figure out if it is a 
flash specific issue or any thing else?

Regards,
Love Kumar

> 
> And that is also how the TI K3 platforms fail. However, evb-ast2600 is
> fine, with:
> env__spi_device_test = {
>      'bus': 0,
>      'chip_select': 0,
>      'mode': 0,
>      'part_name': 'mx25u51245g',
>      'timeout': 10000,
>      'iteration': 5,
> }
> 
> And note that evb-ast2600 is a 64MB flash while evb-ast2500 is a 32MB
> flash.
> 

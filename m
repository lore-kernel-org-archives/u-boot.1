Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58896C02196
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 04:58:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A9A78033D;
	Thu,  6 Feb 2025 05:58:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5NmJw7N6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C587780562; Thu,  6 Feb 2025 05:58:15 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38C0880104
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 05:58:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+7423yJZ+XDAePREXjDnz9Rq4GDwmVjiYWii8rcyIFjL6YnJlBZDzQ8lOEWKe4/OJn0dx4POwcMGOUwf57c7KcZtcLbamDdpPjpjaCXN2WWXiemFn/gZr/eX6pO79nJhabqabQjHx6W/LSDnSKuQNBs7tgHXWplmOqFriuBFWvNKBR1mrcFTSUBp0PnXqYRqkPLntirgSBz3m/revbRDoJ2fXopsGvL/9QhxDEXRbcWcHXkt17a3twpS99mG2uf44XQ/lxLxZo8ZihRwP0KTRcL3/fQ9nuAHea9gTIauMUcJayXK97d+U81WIswEHMIh736uB0vvZobg7SmsN41mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fd0msKPxQiHQI6ueYKscNb1eWp5WafSG3d3vBt0frvw=;
 b=gCZ36uuZ/gup3rEI9FpVoGAlIxBR8iAuNjD4jleBzQ8GVBLHt/ATtm3u4M0jdBOi3Tvr7lfzFVpXvR/4NuKPEhkZR5H+z5/SnTAivEsN9CG/NfhCivspr1SPsU7CR/MGDyYMgTGJuDsCSOCfop7dAcLYAfdbMz2hXVE/hscVjCUJjHzbEyPgq5gPsWDxO51ABED6RZfim661zempSFLz7YZdWncfiIaBEnS9cZo9l1YS8ASiIIqPdWSisaHF3BrZgCs23Yeadw1UBq4nU3gsW9dB+TjNPjBl2BpcHrGaBox3S2sw4sIwjtNmWL8A/p3fr6P6nxD17qAKxzTvtPMCLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fd0msKPxQiHQI6ueYKscNb1eWp5WafSG3d3vBt0frvw=;
 b=5NmJw7N6rUSurwdN9YL+Jl1stPaY54TFeSrZVOSQ/HiOvkRRSXvlHsU66BboKDDNsy3ckkNrlQoFeblw14/KZYmBedADA7xhZB+P8h1uLu+YBLZxUrwrrjs2tiDnOZ1GTIt/hbe//77g5vj9HF8c/k69CC4BsC9DRND27wXOMTg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11)
 by IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Thu, 6 Feb
 2025 04:58:09 +0000
Received: from PH7PR12MB6538.namprd12.prod.outlook.com
 ([fe80::f0e4:5de5:39b7:ea7f]) by PH7PR12MB6538.namprd12.prod.outlook.com
 ([fe80::f0e4:5de5:39b7:ea7f%6]) with mapi id 15.20.8422.009; Thu, 6 Feb 2025
 04:58:08 +0000
Message-ID: <428eedd1-b336-4dec-8631-1f4b9c8d8908@amd.com>
Date: Thu, 6 Feb 2025 10:28:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test/py: usb: Fix format string for fstype command
To: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
References: <20250205130427.2385292-1-andrew.goodbody@linaro.org>
Content-Language: en-US
From: Love Kumar <love.kumar@amd.com>
In-Reply-To: <20250205130427.2385292-1-andrew.goodbody@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::30) To PH7PR12MB6538.namprd12.prod.outlook.com
 (2603:10b6:510:1f1::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6538:EE_|IA1PR12MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aed7e9d-4048-4fd9-4686-08dd466ad968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXBJOFpEeUJ3SkdLZWJpd2k3TVJ3RGMyL0JQdHcrUTRYUit1TmFXdk54b3J2?=
 =?utf-8?B?b3pNZzhOaTl6dEpTazRSTWtZTHdZeGRvcXUwZ0h4a3ZNUkwzWlp2YTNPWnNy?=
 =?utf-8?B?c1k2MDkyOVJkdVRNU0FwR3ZEdlZQaDFDTVRUeElKY2hHQUxhUDhFaHh2YkxL?=
 =?utf-8?B?Y3hkN0VnNUdNYW9VK1Z6dmY0ZDNjajIyQW5DOFRwRlkxRFY2a1ZSU2k4QjlX?=
 =?utf-8?B?dmJaNjBORzFUdWhhem54M1dwVGNCZGVHd0Z5aDI1SW1XbmQxeitsWTNPaVg2?=
 =?utf-8?B?UXg5Ym1ZbnZyMTdNSDg1WXpSZXBrUnZNRlpyWURxRkd4eEF0NWorTGo2QTNv?=
 =?utf-8?B?c1o4a3pkVTRZL3NJdEZJc1ZEN1llWU1QUGozQWhMay9zUDNrSHNQdFlKVEdj?=
 =?utf-8?B?UnU0M0d4ZUhwV0tVWG1kaVBLTzJBaGtoUWJJMHV5MDNaWFpnZ0gxWVFnNkI2?=
 =?utf-8?B?ZEFhYzJ5Zjd2WTVnb3JaUzhUQWRsVHJZeHZrdytZNmltME13RlhFOWhrbmRh?=
 =?utf-8?B?eFFZVG9JQUJpbm4waGlKcVdIWnE1KzNuSG9IT0xZSnpub1hZcXFDb05lOFdX?=
 =?utf-8?B?NDdydDB3L2I4VmpEcW9RV2ZabEcySHlBSnJ5MEdUajlmYk5DRG9mTTJpVlEv?=
 =?utf-8?B?cGZoSXI5UFYzVG4vK0pCOXN3TkJmSnRSQmo3ZmVVWml0MUpLSUlTRXRmd1NZ?=
 =?utf-8?B?bnlIU3dIQXFtcStJZXhudW9xckJWYm9WK09ZNWNtcDhKL2NrMTJJNzNqVjlm?=
 =?utf-8?B?dWw3U1FOTVNFWVN2aUcxUGRsSzZlVll3elVGNjZNNjA5L0lESGVoR1ZzcjlT?=
 =?utf-8?B?TU9qWkhKTlV2VVVBVXl0ZzE0Q0dHT0luQ1I4OXJVaWVNRjU2U1B2cFVHT0ZY?=
 =?utf-8?B?Vi9YbnFpbklNRGNYRlpzMG9aS1RiWlBGdkw3YVJldnY3SHZlZ1pUZS9POFEv?=
 =?utf-8?B?UXNzSkVzeUE2cG1IdWttNWQvUTFkd0dtUUMvMWczdTlRU3BVSXJ6bDZrSFNQ?=
 =?utf-8?B?UGpHckNZTmVHeUxvd1F5VUZtRER5YTVlQk80SmtnY2JDaHVlZy9wOFdXZmVK?=
 =?utf-8?B?YlYzK1VSbG44OFlRMUtWQmovTjFwK0UwbDdKdlJCMml4bTNYRTQySk9nZC9a?=
 =?utf-8?B?bjlzRjF0UDVNTVphZzUxdEY4ZitFS0w4STZjYk9wcTdiMnJBWUFTR2k3RGF1?=
 =?utf-8?B?aGkrdjRiUVZOVHZxZDEwMExzeGdqOW9vMGsxdEo2UmJ1dk9wWDN6VDFoR25w?=
 =?utf-8?B?UHhhV3p0dHpNd3IxSkJkUDN0cGtrRXAwajhhaGx4bE5XWE4vTVBMekdpWUhh?=
 =?utf-8?B?c0NUSkhBWk1SbjZVVjZVRURSYkl0L0did1ZKcmZiRzlOTWx6dlJTVkt3SGt2?=
 =?utf-8?B?bHNxUVZzUTFlMm4rWUEyVWtXdCtVem9wZ1JuQzJGdHM0VEFvcE1NTVpqc1lo?=
 =?utf-8?B?VXJjaldYVkM5dlBXUUFscVJIRncrNW1KRHhwR0prSGFkMHZGVlVvTFFoUEwv?=
 =?utf-8?B?WFU0ekNkWU4rcndxRHZsSkZUcGRZTitlc1lyQkhoQWQrU1J2RnlRcFRSYUFx?=
 =?utf-8?B?RElsZDdyN05tSmV4ZUVldUJ6MXNaUHJneHROa0RFNStwQmp0MmhGdTU2RDJY?=
 =?utf-8?B?Y0E2akFsUlZBUHRlQXVIakFRM1VHQ3BYV09LZ0pIYWRWQ0JhTEJNV1RTRXNy?=
 =?utf-8?B?YjU4NTFrTkh2MzZUM0FUMEc1dVFMYVhLUHNOeVM1dWlvSVZiV3d6bEF4WkVB?=
 =?utf-8?B?dnBzWGwwcGxTNi9PWTArZ3YvSXhLL1ZrcTcrSTVqcFY1WWYyT29YYmhTSE1O?=
 =?utf-8?B?a1l5SmJBd2x3TFNKaC9KVFNKL0ZSamlhbllSNHA5STJMZU9YSUtxOG9xUjFD?=
 =?utf-8?Q?LTCF77IzoQmzU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6538.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TytSQ0RIM0RRdDl6QWhYTzh6RWt5bnJ1TGNsR3dYdGJkS0lqVjNSWUdKVmx1?=
 =?utf-8?B?VzZCZXRiZS8yUWQ5Qll5SERZeUJoZVZRTXNBZzVjQkx6cHVpNE1DWHNldTNX?=
 =?utf-8?B?blZOeVArRmkwMEVkbTVDbXFzeVlUMktrMHNtYnpKR21UdlJ2WEJrdG1qV3pP?=
 =?utf-8?B?YTdzYVhoYzF6RXo4dmd6dC9MS3JnQzY3SEhYa050VEl6eXlxVHVIR01ESndJ?=
 =?utf-8?B?N0NwZCt6S3ZRamFhZ0cxdENkQ1daR2FOYTBFbVhBVXEybXZDL0pFUjVJYm9o?=
 =?utf-8?B?VWl2S2xDb0JSZzZyd09EWlBNdTVCLzhMbkVOTHhDNm5hdTRCYVJ5a1B2bklm?=
 =?utf-8?B?d3M2OTFzNUJqOW41SUdlYTRxYWxVTjZpRnE2cTRIdjcvelY0MkR2OEw5eTB3?=
 =?utf-8?B?ZjhJNFZsR2VvN2lhMmdmZVNESHYwZTlsWDJEb2RzMlFRR1ZNWkVzOGRKZGpJ?=
 =?utf-8?B?Z3ByT0Vwb0Z2dXlkRTRUY1pwZFhJcUNXSmRCRFZkNWxwMEJwUVNYR2dDbFF2?=
 =?utf-8?B?c2tzemt2ZTdDbWxLZzBiNWt3OVVIQVF4dkFzUXJMU3JqZzIzbHF4M2YwQkFD?=
 =?utf-8?B?NW8zNXVUdXB1MktLSmIzUDh0R0dvU0dkeGlGeVRzV0d1ckFneHZnRjVVb2Nj?=
 =?utf-8?B?VUFPeXVlQ0pSK1gybE1HVWhiRldOSFNaeUJsNmFndmhrdkZLV2lGb3ZqSEhY?=
 =?utf-8?B?ZHo2d1psRThNL3hpRUFQclc0VGtEUldXa3JXSVFkY29KcWVoVVdjenl2V20w?=
 =?utf-8?B?NnE5WWcyY3ZrdDJjZE1FL0lJOFdrVkFtSGUvWVJ1RVdBNG9qUEpPaitDeUdn?=
 =?utf-8?B?V0pGUG9DWGgyUmpnWHA0clFiNXRPTmRlU0FiZ1VSMGhScFA4QVU1VDBzRUtn?=
 =?utf-8?B?QWVYRFNyaExibzZIdk1hNHZFaC90WWlMK1UwUHV1YmFUcnRRT0syTU5Ub2RR?=
 =?utf-8?B?SGszbXN5Ujd4cGhKNmx5bnU3c3JvTEFnMWFQODlPSzExaDIyY21kcHRwNU51?=
 =?utf-8?B?UjVyMWV5OW1veW9SbGp0L2JkSDBWNE82RlZBdEJ1ZTlLRjVBaXozSTJSZ2xj?=
 =?utf-8?B?R1hhUUo3VjZhWmJIVzNSOEZQbEo2ZTdJVC95djJFMHE2TkFsMndzR1NxUzRE?=
 =?utf-8?B?NW1XSlBtZHNpb2FVbGh2c2oxQnNzNXpDNEVnSWprZlEwbWFTSnFrWm5jM1FS?=
 =?utf-8?B?NjFaYXRxd01aODZEdzR2MURlL3pybFA5WHBDQ0ZWSlJrN2UybTN1T3NYQUEz?=
 =?utf-8?B?TTRPaUJEWjJZa0FiMGpaK0s1ZWlSV0VLN3Z4WFlRMVJHcVpBNFZ4Y0cyQkN4?=
 =?utf-8?B?dnRveGpvaXU2d010UlNNU3VGdTAwYVVpamovVWtlRDdSMENjSnd5d2tJN3JK?=
 =?utf-8?B?Z3grSXdid1B5ckNzb1MxM3poQnY5Z2lVZ29yWHdqQk0yT2kzUkgxNjJ5S3Zo?=
 =?utf-8?B?Zm45UWFUcmZyWnNkdHh3NE1LSGg3cUVNK3g1YlNzSlBoMjQyMXBNenQ3U1V4?=
 =?utf-8?B?UktneDY1Y25vc1RiT0dSOHpudElWYWVCZThVL2lRSXRnU2lLWDV0bEFFYm5W?=
 =?utf-8?B?eEZaVjJLZ3h2RE9MSkpSQ1YwTnZ0cEVZNnlyREQ5ejQrNFdLc0lpRGF2dEM2?=
 =?utf-8?B?ZW1vMnVOczNEVlk4eG1STTk2bWJKcmJYdVFPV0NTbkNvN1NkZ0xLeGhBZ2dU?=
 =?utf-8?B?eHdEMExha00xV3hCRnhodG91dnRwZkZEaVBWczQ1QlBwYVlCdGJJOVNnaGQr?=
 =?utf-8?B?ZkpjWHJGNk1jYlBPSFgxZFpaejh2eG1OTnc2M2tEbGpzekZ6UE5yV2Q1NzlE?=
 =?utf-8?B?YVJDREd0N3Z0bG1RUWFXNGg0NnhqaDdMMEN2MU5JS2tlVXR4RkRKMSs4SVhj?=
 =?utf-8?B?L3RZK0NHYWRONFFjUElQOFNCRVY4SjV5dW91Rkp1WEVlczR0aDJxSklaSnZ2?=
 =?utf-8?B?bGNBeGZYUUN1SUpESkRUZmwwbnpPRU02dDc2MlhRdG9VZjA0TnQ3T1JjNE5Q?=
 =?utf-8?B?WU10TmQwN29NL1VxSDNhNElrTnVxNTh4U0JuK0xpa3k2Z3pVRzBzV0dyT2JI?=
 =?utf-8?B?QUNHKzRLQXlSR0NTWnZGYkgrUVFXNXAyUDNSZG1IK0pmRktUYmFzaHdobVNN?=
 =?utf-8?Q?bB1s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aed7e9d-4048-4fd9-4686-08dd466ad968
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6538.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 04:58:08.8070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: de4MWxuBMFS4D8uXPYZRJIxKQ5QoogQ0nvD2Yup2+eLKNseTDGVpTkgC+4JkeFPF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686
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



On 05/02/25 6:34 pm, Andrew Goodbody wrote:
> USB tests on ext partitions can fail with the following output
> 
> test/py/tests/test_usb.py:245: in test_usb_part
>      'fstype usb %d:%d' % i, part_id
> E   TypeError: not enough arguments for format string
> 
> So add brackets around the format string arguments to prevent the
> error.
> 
> Fixes: a730947974e3 ("test/py: usb: Distinguish b/w ext2/ext4 partitions")
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Love Kumar <love.kumar@amd.com>

Regards,
Love Kumar

> ---
> 
>   test/py/tests/test_usb.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/test/py/tests/test_usb.py b/test/py/tests/test_usb.py
> index e1f203b5cbc..566d73b7c64 100644
> --- a/test/py/tests/test_usb.py
> +++ b/test/py/tests/test_usb.py
> @@ -242,7 +242,7 @@ def test_usb_part(u_boot_console):
>                       elif part_type == '83':
>                           print('ext(2/4) detected')
>                           output = u_boot_console.run_command(
> -                            'fstype usb %d:%d' % i, part_id
> +                            'fstype usb %d:%d' % (i, part_id)
>                           )
>                           if 'ext2' in output:
>                               part_ext2.append(part_id)

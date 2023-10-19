Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165B8CDB484
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 10:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B038871EF;
	Thu, 19 Oct 2023 12:30:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="umuBbok9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32C0A871EF; Thu, 19 Oct 2023 12:30:12 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2A8F86FFA
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 12:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCFguuRHxc2t/0s7+1eHAKIc7SjHL2I0wHPqTPCmSjvcvWXhFC4kuhbPZWTdEar1EixbRquYl/6+x/NRxedqlmssQ4KzKoqISx8GY1PRxB0Xg9oQjx8zN3nKiAmSlSE/GDjelFat2FQmbPfuJBdxrSbCU518LZnSU2OXCaREaKDvTrn+V/CvJYzVNIRuJAg8wpaLsVZoMesrdCDt8BNTdq51Ax86K9G/sd6p1dG2E0R8jHrQSXebS3S8L4v2krIVx0bAbI1RBgDbDHvxfXtTCWQl2uzsito+kKuxav/6EgYWZNn4v3ybGyyKQM6nXbbYF2Ejz6qXhC57g2CrZ6U1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fg4leoYEUbw+sW4vDh6KKqptJ8pfiW9/OhtK8kAXR0g=;
 b=JlcKtnxSUPrOf25tgAP0IpoklGpdfz7Cf3oKF7pGtjU/3Ea4cNMtx3vc+wU8zAIptH5uAUkPZaO7oYv3ZH4DXor9eh86KzvIJ462aOW+6tIbncT8aRfT8tPIua9ogvSpw3BK95t6kCKCw15+WxY9XWl598rOhI1yrJwYmTvuub0LSItr/tlA4bgQb9heZckjnj9+K7r4ZqGi3itkx99yWOZvaIcJwPPLqu3CMD3yw1ATHoVaxt/IbudpBKltMVB3kW8QQ1vUTOAOGhHE7q1GPMqJgDRxi1Nc2JB6SvXmsnBpdbLXqfFlRfNTe4puHteJ9d1ASFHxr/kZu2DJ7Tyixg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fg4leoYEUbw+sW4vDh6KKqptJ8pfiW9/OhtK8kAXR0g=;
 b=umuBbok9SR7W9ycQKr9GrSyHHTcvRdIhAMN/DJNOpwQSGYlz7HjUc6lmWHa5SwpXofmmRmaomVaKcChvAMzhQ/9c6rrEjoq0/nIOnF4eT9OY4pQy0+WLcVq5ewwcPJAioLgjWhH0fk0fyhanV4R6ycjdeWs9wSRVpbDQ95mR6LM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Thu, 19 Oct
 2023 10:30:00 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::b220:eeee:98e7:a62e]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::b220:eeee:98e7:a62e%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 10:30:00 +0000
Message-ID: <0d7feb25-cf6d-44c2-bbfe-586217b32fc9@amd.com>
Date: Thu, 19 Oct 2023 12:29:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: zynqmp: make hw-ecc as the default ecc mode
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
References: <f47b95616eb40d3a9908ca60df94ec6e873b071c.1697119098.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <f47b95616eb40d3a9908ca60df94ec6e873b071c.1697119098.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0066.eurprd03.prod.outlook.com
 (2603:10a6:803:50::37) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: ad744c54-f1d1-48b7-918a-08dbd08e58f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yR364vGOaEcy8QmcsN13Tu6mLPqJQ6V0rBK17ghFle5vgnPpw4KmRFOUD6BCtNVoramnLKDAdUfbJ4Q6VoTtSNZZRYGsjlOjA2qczEcNrKNS40LbTUil7EWLJ/+THPw/2zMVJ0HZBh2niEC54SXy/Kq4ZelOuMWnKp+mlbGKIT3Db7AusSnWRowf+PwITMRq/31eMVlC+ZZNlR8Dh9hyi1vOmDOJAZiY+FNdBeQkhf0wWUpcXrF+GDHVESuxraPmTmWimk0orwRHZtcZjY9hJJuheMyuuP3itgwnrwGqu6xL7KkIDWLx4O981OT3G3XUzb7nlSmeEwz+jVWKhAWlUvkhb2nQkiTouqt3bo+i+/MUrysUnsMExdU+zJeUFiFEz2MNuKFLMW+1Yp2SeNK+LHUZyzWp5aG0Yl1AYPM4prIuA9z5TbUgwFHcZ4eskFGV9cASXBjI1MzbyJ6xyEz6ccr2YXaoouz3MYM8tqceUWtCjg/Jhuj9nr43izSCP8HJHvjMuM9U3X45jFnD9EJ/xO/j5G/+Gh2xFitX/xr1OJT0bwuflpEgGJJq2mjmu72FqwEodtHIgxNA+wN1L/0+mFq/x2t6bZbzu4SaO9nVN/N/aCcF/w3+/JvQ1lrVZebN9lsmcUdPPbIysmdcIy0Knw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(366004)(346002)(136003)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(36756003)(4326008)(44832011)(5660300002)(66476007)(66556008)(41300700001)(316002)(8936002)(2906002)(8676002)(31696002)(86362001)(66946007)(31686004)(83380400001)(38100700002)(478600001)(6666004)(6512007)(53546011)(6506007)(2616005)(26005)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGFpU2U5V0lpLzdpNUgxYVNBOWRrZmNaT0lkYTNRUm1pdjFUa0FuRE1nK2dz?=
 =?utf-8?B?R0E2YWJ1QUF5LzI2UklWWkZKUnpmNHQxZDBNZ3lyN3BoZVcrSHN5UUZlNHc1?=
 =?utf-8?B?RUk5NDh4MW12Uy9hTWo5dTZtZHdQNmhIQjJTb29ZaWpPM2lhM0ZQRVlwclBO?=
 =?utf-8?B?bEJJOTQ0R1YxR2tlUU16S3g5MTl2VEhyWlR0WW9WbWUwdVZYS3NQbVZoQmZX?=
 =?utf-8?B?bmhjSmZXMnc3UXRhS3dLUWVXUTRORUdCcUlNSkZuTTF5eWdhWGpVc2tLWFc0?=
 =?utf-8?B?SWtsbVdjRDB2Q1E2c0ZVQmdpbmloR0tzcmFuU1hWVEFFMGZ2K05maFdOZkZv?=
 =?utf-8?B?SThZMVU5L3lZeGJ2UkRoUEZ1SjVwQSt4dWpoRUxZbVc0L1FjVEtDT0NibUtH?=
 =?utf-8?B?NGVvdDcwMEZha2dsYjk1N3ZCdXk1ZHN6OGMvL0ZnRkFXcEFIU0pkcklocHpL?=
 =?utf-8?B?VkxxdWVrZDBSV053emlSTlNNeUV0RVhzSExKSk4xYzRXK2lMUE9hV0l6MGds?=
 =?utf-8?B?dWpmM214QllmYjMwbEZ2ZThSSVVqMldpLzBXMzFIMFJiSHpRZ1pNWWExOHdj?=
 =?utf-8?B?Nnp1UGFNVE5wTXk5MS8wUGlEU0lBVExrVVhvc3NnMXY5L1hTRHhGNmJUcXN2?=
 =?utf-8?B?K213eTRkcDEzYldVU1A5VGw2SlJpdmhyRUVzaFdzOHphY0VhSnhVTFN1QVo1?=
 =?utf-8?B?ZWJCQlcrTGtLRTBPM05wNlRKQWw5SEVuRnJJMHhmazdxUlozY0ZnRzNnUytq?=
 =?utf-8?B?VFpJSWVQbDAxbU1FenVtUGJWVnN6WXFmNDQvLytBQUJCVU02Y2xIREw2Tk01?=
 =?utf-8?B?d0ZaMXY1WU9NZDhGTFhyK0lNNW8xT2lMU2NjRk5YM0V0bERjakJxTHhhN1d0?=
 =?utf-8?B?TklnZUdVakFYMFNTYTZwc0RtSFNQcHA1ZVQ5SDdHVE14QlcwQ245eUZsV0pz?=
 =?utf-8?B?dHRLYTlSTGpmc1FXS1pDYmRjUnlIZmZldmFsUlpndG5WS3RVRElIS01DVEM3?=
 =?utf-8?B?QUgyeDI4c1ZtZW9LbE44S1Nra2VCNHRSWmd1UElnVHdxbFQ1SlZlemhhSmhN?=
 =?utf-8?B?SjdoMXdwRE1BQkZHa0J6emR3Qm5qM0VmckNHaERmQmFPUmtiODNiZkl4bm56?=
 =?utf-8?B?K29lS2RJaXZua3hVdXRRTkVBcDdZei83SE1vR3pVTGJGT3Q3VlJaSlR3cjll?=
 =?utf-8?B?aUZYT21ITHdtbGExWkNDbkFHMTI3SG5WTTdqQ0krYS9MMk4zV1NMbVBlWFlk?=
 =?utf-8?B?cU9iS2ZENW4wa2tPV25YMGpncUtxakhhaEc4K2piRXZuVzNOYmpDbC9SaWRu?=
 =?utf-8?B?RWZyS0lsNmd5aGRkZVh0Rk5ybGdvTlJQK3hNZGUxL3Rva2lMand4Y2tZVWYz?=
 =?utf-8?B?aWtmc1dEZGdxY1FTTXFTRFc3M3lRVE9iR1libE9wR0E1ZlhHVEEvT2dXNzlG?=
 =?utf-8?B?QUFVUkJyY1lqSzVobk4ybDVXejdwSHZkQzJ2M2NIN3dRZGoyalNvRW5wbU9K?=
 =?utf-8?B?VGpwOW9icm8rakNnaEpweHlKVWhCb2VaZk5TUUgrM2ZGRU1JZGhZSnlFMnFn?=
 =?utf-8?B?RTJEaGNzR0VmaWVpWmZuemZPN1lYeU9YMDlZMWI5MGdpQ3h6SVhDcGsvNGsv?=
 =?utf-8?B?cW5QdFZFa2xaS3pEYytSVHc4YklrMnF6OEwvMytkc2NHWVhCaFk1Z2RBaTRz?=
 =?utf-8?B?VjVUSXlpQUI2UWNjTFZrYVNZanE0aFFBczNiY2ljeVd1bGYwV29uMGVzOVBq?=
 =?utf-8?B?QXN2RUR5bG1sVitEc2tKblVQaVBISFc0YWtIOHlweUdZQ0ZVU1NDeVM3alds?=
 =?utf-8?B?b0QxWnBCRFJSUTBvQ2FYL3hnRGppUFlGRCs0MUFNTVNHbGNwMVpjTjcyMGt0?=
 =?utf-8?B?MHVQNDNrTEZLbm8vU2xxWjVjdFh3aHAxa2JCZnN2dzlhckNLRzhLbDhNUEt1?=
 =?utf-8?B?clRwS3g1OHJpMTh0dkkwTGQrSGlTSkdmd3VvTGMzOElkamtvSHRRYkg5cXFV?=
 =?utf-8?B?UHlqTzJ0M1VjVkZoZUY3NzFFdytrTi9qdzVDUnhtczJDY1BVWE5VQ1BlTzNO?=
 =?utf-8?B?cTdrS3BpT1FaTG9Wc3RoNGdXaE9UaDVSVHgxRnJXS3BKUFBGSGMwcUtDNmtt?=
 =?utf-8?Q?t5dLR/aclU0qBFYn2b8awNJrx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad744c54-f1d1-48b7-918a-08dbd08e58f1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:30:00.2123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jQ8mDNPBbSMAOB7/b74DsFtNzB54QXacUll6ikVjxjubE9vzUAKT028xEe0dfy0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166
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



On 10/12/23 15:58, Michal Simek wrote:
> From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> 
> Except for Linux no other component (i.e., u-boot, fsbl or BootRom) of the
> software stack supports software ecc engine. So, make hw-ecc as the default
> ecc mode.
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts b/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
> index 23a3ff2fed98..160c6c58b36d 100644
> --- a/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
> +++ b/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
> @@ -141,8 +141,7 @@
>   		reg = <0x0>;
>   		#address-cells = <0x2>;
>   		#size-cells = <0x1>;
> -		nand-ecc-mode = "soft";
> -		nand-ecc-algo = "bch";
> +		nand-ecc-mode = "hw";
>   		nand-rb = <0>;
>   		label = "main-storage-0";
>   		nand-ecc-step-size = <1024>;
> @@ -178,8 +177,7 @@
>   		reg = <0x1>;
>   		#address-cells = <0x2>;
>   		#size-cells = <0x1>;
> -		nand-ecc-mode = "soft";
> -		nand-ecc-algo = "bch";
> +		nand-ecc-mode = "hw";
>   		nand-rb = <0>;
>   		label = "main-storage-1";
>   		nand-ecc-step-size = <1024>;

Applied.
M

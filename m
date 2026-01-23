Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F1DD72347
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 08:23:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B4A683A6A;
	Fri, 23 Jan 2026 09:23:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kkCkq+qF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F285F83AC5; Fri, 23 Jan 2026 09:23:03 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F6FA839DF
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 09:22:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+LBvGI5E6jb88Q1mBQfz4az50Hb3ItSL2HMxyrRTClhFUa14Dz4iVqzpqXPH9iKWeZEOYrVvY9PYecQUXHpyT1X6Y/Px/IBWGE1vurAd9LQDR/IZe0dgimONTlIFbpKK6V89q81e/edEo2kR+gbKVGgLCm6MemaKPebK2fQ+b3arqwz94l+L+HlnTG47GtEJiUsk6lDTlJ/lvMxCe8I2lpaZf6fmV2wgXPsDWXJ6cXYia7B/F3PL1V1ncn7UBpfuUEGC+0NUvi9VS+X5EIU1FNu2uJrrOmXcUbZjXa6/uL8B0ObD92GbMczxurReL/R4mvKceESpCOZ53ujd5vbhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLDAuWWb9aq0ZL/ODULzZh9sAHLchmWQ6HuTvQuBukU=;
 b=uhZ3fw7aEMxCan8j+ZM6ubYwbLFRSnavsdslTBzQq5Osl+63OPQyXZzoPMmAScnaGXP5bp9T/LCuEAuEpg6M2RyrvNKwdXELhjXPTmi/8W14e2zcEu3U04Rt6SkCjJ9ZVReDvgRuyUimTS1x8/r+ZUMWaWKK22ZRxajXTTLYFpf1MnfhLf/m8MPkk7OdTZcQH/9HVj6jpy3S3/yaScZFRWWy0NA4JX7GjS1qCOZxB7ZRGlWja+n3WACapV7PDqp64Qecpo07X1wdsbZw/ysRUJ1GQg/TFYCyrRJKP+UuOIhts1XRQsOA8Zp260p8oM5qSmHSv31ihIdPnX0SBGue5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLDAuWWb9aq0ZL/ODULzZh9sAHLchmWQ6HuTvQuBukU=;
 b=kkCkq+qFTkH58VkxTtCSCsgN7x8KCS6WYcW6J3GB9CHyxY1IYRi0OHzrBFDrFShMiXTV3/4nIlR5ctHQjarbF7+pc7cxyuBHZOhRTZtqluUCcF27exvO3n/CS/OJIDhv6UT0KAoY5+IQPZKyZ9orcK3LB7nDlU19xePPZe15i6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV2PR12MB5917.namprd12.prod.outlook.com (2603:10b6:408:175::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 08:22:54 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9542.009; Fri, 23 Jan 2026
 08:22:54 +0000
Message-ID: <2de4c7cb-4d74-4f8e-a14a-1f09ad880b80@amd.com>
Date: Fri, 23 Jan 2026 09:22:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] efi_vars: Implement SPI Flash store
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 git@amd.com, Shantur Rathore <i@shantur.com>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Raymond Mao
 <raymondmaoca@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, "Ying-Chun Liu (PaulLiu)"
 <paul.liu@linaro.org>
References: <cover.1768403729.git.michal.simek@amd.com>
 <da6f7b65cfb5aa81b7ff13848f532cde1b009227.1768403729.git.michal.simek@amd.com>
 <CAC_iWjKrfLXNy6a+bBUAW-xHSicir1TL0vXey2MVz8MxDsMYMA@mail.gmail.com>
 <6b91098b-8072-4691-b2b4-a41ecf6879e2@amd.com>
 <CAC_iWjLBZz1m+9o1PJJegEPE6SGfNvbAe_JuAUrrFTCE=ydOjw@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAC_iWjLBZz1m+9o1PJJegEPE6SGfNvbAe_JuAUrrFTCE=ydOjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P221CA0056.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::11) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV2PR12MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d391c0f-961d-4218-25b9-08de5a589b76
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1BiZ2pKcm1ZVTRLQ2hjaDJLaU9IenZTdlErRFQ5SHF6VkprZjV0T2tPdW40?=
 =?utf-8?B?OUh0cmpMSkRXTGRueGo2a1VEd3hXamNtRTc5bVBxYUlHMitNbzdXeWFWUG4x?=
 =?utf-8?B?WEplZHRpbnBNYnEraFJZdFhaZjZCbnplckFUekNRR0l5RUhSWG1MeEI0OHl1?=
 =?utf-8?B?OXI5MGt3NTVLYmJxc04vQU9yZW5wOFc3bnN1dzJqVU9UaUxlMVhaVmRYQnpE?=
 =?utf-8?B?eGlNVm54bnpmcWtiMCtnazVyT0tVR1czcEFNblI0ejVvdi83c0d0bUhibnA3?=
 =?utf-8?B?RDBZRUtudlNOcXNqVGZlclNRTGNVYzdnUGh0WEwyR2lWaWdrREFuR2h2RU5B?=
 =?utf-8?B?bW1RTDFaNG40YmxVM0NGNnArQm5mT1NsSEhXUi9VSkgzT1BsUGtwM0ljTFdi?=
 =?utf-8?B?Q0RlWS9rRXE5K0lqWEJDUW9JRzgwRnhyc21KYjY3d3pNM2FJUis3bFhwWVNK?=
 =?utf-8?B?anV3cUkvTERVT2xlMGZubHFnMHlnTEc4TVZCY0ZHbTBrd1dpY2FHL3JzOXht?=
 =?utf-8?B?VGNaNmlmcmV4K0dycjByM0hHQ2hEMnBpK3ExT0toSEZnMlE1dVRQaE0rSldi?=
 =?utf-8?B?emtwS3R6VjVDTldCVnZkZ213WGZOUlhXUVplVjBvTGlMcndNcTYzWjZaQ0xz?=
 =?utf-8?B?NkxOeC9lQ0Yrc2NSejN2eGVqMzhlVytUUTZlLzRDQ1RwZG9XOGV0dWNQZDRP?=
 =?utf-8?B?cDRKTGx0bWRzQ1pDc29qNmlqTjN1QmpSK1dtVGwwems5Vk0ycklTd1Y1ODgr?=
 =?utf-8?B?TnBzcnZvRDFHdW5rYTRGak1McTJEeVk3eUpvajdRU1lEcE9OV2VUbnlxMXlY?=
 =?utf-8?B?bXJ1V2VFaVhQbTYxRFBCQzhraGJoRDg3QUpzME5JeVArbXVEc25kNGphTXNl?=
 =?utf-8?B?bDVFN1AwOGxJOEdWK2liRXVHLzNHRTVTTFJ0ejBmQVA5THAwOFk1MnFEemZN?=
 =?utf-8?B?bU9sMWhENDgzMEVSbk9KY2dRY1RaU2xnMXJWcFYrUmpEczd2Umx2MWJla3hC?=
 =?utf-8?B?Wk4wQnRWaG05V0kxbTQvWTR0T1RSVFNGdzBzcXBaTFNaZ3hrR2ZvR3NHTFFs?=
 =?utf-8?B?ZjA3d2NNMFFGTFloa3JBcHFnR2hjbXF6dkVWU1BNanhFMVdWd0lvQnIrUnNq?=
 =?utf-8?B?cituMGMvUFNSeFNmbUdBcGx4QlYzRDZBejV5aGMrbmNUWldFWkdqOXR0dXln?=
 =?utf-8?B?ejJtSjljaWpCbnlZZUFiTlpFdXlSS3o5NnFtNUcwaFR0TlZ6ekV6NXYwL090?=
 =?utf-8?B?dU5HaUR4cVVuYWVka29CTWRFdStvVm1nUk42dmRWRS9Zam82VHBKY0ZMeG9S?=
 =?utf-8?B?R0ttR0FqVmU0V0lOWUFmMVBEZzFmTDdlM3lUTzBiKzlKTUdrUkZSZjJFdkpZ?=
 =?utf-8?B?N2V2L0VGWFBvTW02c0xsZTJIRyt5RHdXUVU5YlNVZk00bjBFdGw3OVV6ZGJC?=
 =?utf-8?B?a2sycGpxQXpKdzFxOC9aQzcwcVdCYk1uTGZ4ODZOK0VMeVdCM21HdlBYdlda?=
 =?utf-8?B?b3VkNWcyYWF1dk56cE9sdnhMMWtPNUU0RjhwS3R4VHVwOHJTMGppQUpneFor?=
 =?utf-8?B?ZU95NGc3RVlibGJKZDFpNG1ubmdNLzdkVG1TWVRSdVVlS1JGUmJYYzE4V1d0?=
 =?utf-8?B?NTdWSFZIUkxycUJndWUwWXhwV0FBNEptV0RLVjRnSmZRdW9IRlNqMTY1QTlH?=
 =?utf-8?B?TGxIdzFreDdjZ3RNN0pWMmRWTkxMUDdsQ2xMUXhUZ2Ira0F0bWEvNFM5L0Zr?=
 =?utf-8?B?N0tFQm8vWDRqbEFKQVN3aTZoaFdpZDdVd044SXR0SUhZbWwrcFUvZnE2aTVQ?=
 =?utf-8?B?ZThOQWd4Q0ZCeEVGTWU5OVBWV2NIdXBEUTNCajNXc1VOdEFPWVJnWEU3Rk1K?=
 =?utf-8?B?eWZLQ3hXZVJnRlk0VjU3QzA4MndZU2pHNWN1dGp2akdNaElkZ1A0WEFMc3h3?=
 =?utf-8?B?QzdMR2RhRkJCR0h0N2cyK2x6UlhsMGg4Z0MvL2dmYktuQXlDbU5Ob0EwWkFt?=
 =?utf-8?B?VDBFeHpnV3J3WEttR0VKc3lFZytmWUIyVWFDbmtMaWsrM2pVeTdNMkQvcldV?=
 =?utf-8?B?eWRTU3BSby9qUzFKN0lnVTI4NlRMTXZFNWlBdytDbGkvK1BlVDQ5dExOa21N?=
 =?utf-8?Q?jLUwP8i/YVbyl8dd8QRK5GAvx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bCtHcStzYVlseUovTkZvbWRDOE10SjZYcFJrQUc0RFRIU3JvdFVnOHdaUnY2?=
 =?utf-8?B?TlgydC85aTZUamltRk96OWN0a2lKbHUwTFlPMDkzcmUxdklzVUM0VTNuOWs1?=
 =?utf-8?B?T2FCcTBYWVYvend6RkNiZTlWNTB0c25EVS9lRFFQYitySDZOZGMvLysraWox?=
 =?utf-8?B?cENRLytlQzlQZ0o4SjFxTzBTTzcweUNOVFc0OCtrYkNlMzRXYm0zRmZLQ0FB?=
 =?utf-8?B?VXV2VXFPTjJGcTF6aGxVNWY0N2hmM0lBTFgzVlRHUlJBdFhHcGNSNThKRko4?=
 =?utf-8?B?QTd5VkFESmxNOG1XaTBzaGRvY2ZOSmoxYXhBOUQ0NzBPK2Y5c29VZ2cwbGtl?=
 =?utf-8?B?Z1NKbmRORFRhNmprUjRQaTU3SE1wcksrRVczMnc3SkFhNDNMSnBSNXh4VWdU?=
 =?utf-8?B?cldqQlFEOFJHWjJBRkR3cytKMmgybXNZN1FTK3phZkhBTUNnSHFhNlZ4eGhp?=
 =?utf-8?B?UTdFQXZudWVQZGZhOUxXNVhrOG1wbGNCODhubnJZbTJZRnJXcnNmdGpGRjZB?=
 =?utf-8?B?YVBjaTNoN2pUemQ3S1pKallUcFdjQUtibmt4b1ZVRzk4MkE1L0I2VURSaCtH?=
 =?utf-8?B?dDR2MWwwVUt0RElldUlQNDlIVVdET256OS9DY0ZqeFNUaXZBeGpQOW9WUUQ0?=
 =?utf-8?B?cnczZ2gydURKU3I2eU9sZDhwMUhQVmJDRkN4dGxxK3ZRcTlBcmRTUUNFTEYy?=
 =?utf-8?B?UXdOUE5FUXRORWhKZTl3T1hiL2ZHdkxUUnRGQTB3SGZmeWVmRU50SWNtNk1E?=
 =?utf-8?B?TVZ4Y1VCZDdwY3VRa3FVVnB1WnFDcjhNdGVEZzYyamY0bC9jM3h4b2xlaFhq?=
 =?utf-8?B?K3V4N0o0V3lXY05xZ210bk9yVWRZL2V1aEJ2UFlkUi9xRDhqK1AzYkw5aStw?=
 =?utf-8?B?OUM0RzlhU2Zab0d1c3JUdlpRSCtSelZIZDRMYWxQTnpRMVp1dVlYT1grTjFS?=
 =?utf-8?B?dTRMRFlMN0dsVVRuQmJvYUhlUVRncW4yaFpuZHkrcmdQdHJWQ3FkVFdwdkNM?=
 =?utf-8?B?NUR5QlJhUGg4N1VjZmlUUVFqSERCOTZvbE85THNwV3BHeTlUb2xJWlJSU3JB?=
 =?utf-8?B?TjF1U09hb3phQkMwQktxL0Z6SVNIL21QWmpGUVV2Yzg2azlsVWZObnE1TFVa?=
 =?utf-8?B?N2FQQ0FrOFhBYzBjdHZ0SFo3OWdlUW5jMjh3ZTZKcnl4bytUbEFJYWYyVmpE?=
 =?utf-8?B?Y2t5clFFU1RCZ0V4dUwralp6dUVlMm8vR08rYm9jUnJXM2ExbUthZDFobGI4?=
 =?utf-8?B?S285U3B2MVczSkFsY0wvRnRWV05xYk5nemNOOTZLS0N1VXN1bVJURU1WdG4y?=
 =?utf-8?B?Z2tycFZDZk8wOHJDd0Jya2krTVNhQ0ZwZEpsODdJNU4yemE3R092WTczOVZT?=
 =?utf-8?B?V3o0S05ITWxLaUJoK0dqTS9nRFB0L0Z0aG1lU0Y1YTF4emNuMVlGbDYvVzNL?=
 =?utf-8?B?Zkc2UitXNWFkZU56eXlEeTUybTJ3ZVpRajFKMkEyTTlzb2Fjb2lKcFN2eTQw?=
 =?utf-8?B?ZWkyMmF0bmswV2FOYUhQRE5YRTk2Yzdwb0dtbzY0MmNxL2Z6SzRSQ04veHEx?=
 =?utf-8?B?Z0k2OFN3L294NjRacDlwK3JFVHJheHM3ZEFYTElSTFRkM2ZBY0dBMzFTWWtj?=
 =?utf-8?B?Q1p5QnFMd2pUYnMwZlhwamVzZFQzVWdVSVQ1L3FmN0xtdVo4ZXl6MDVRTjFK?=
 =?utf-8?B?ekJqRlN0MWtObk9ObjYvdWVERDdLRmNaRGpqOVlwSlpZb1BZNk5rUlo4S2hz?=
 =?utf-8?B?QUdvUkRLRS91U2pUU3IvWDZFQTM1aHd5QmgrbGFaUEtrZHplN1Z2Q0Vvazgv?=
 =?utf-8?B?Wi8ydDFLSTZZcjVaZms2Tk9pNkpvY0FFYzNQU0Q4SWV5NTdIWHpBRXY5M2l2?=
 =?utf-8?B?SG82VnpzakphTHMxNWVTZ2Yzd09aMzBRUHlrRkszcyt4UjRnMW5kOVVDQkdV?=
 =?utf-8?B?a2pjNjF1QTM0UW85ckNnYVNOZWcyQXIzS25XTWpEb3VtL0JrWjFOQVc1ZjM5?=
 =?utf-8?B?ZmNBOVdiQzBReUZ6SmxlNDd1a1NGeUs4R2ZYcnBsdUNSR1p6aUk0RVc0TDBU?=
 =?utf-8?B?anRuMWI0MUtmckhXT0kyYnFkRW1hTWVtblYwcHlkVkx0cWFXdVRnRkJUcTVr?=
 =?utf-8?B?cUY5K2FESTYwRWRXeEZqWHlvcEpuaVd2Rkx5TzdGaWpkajNlblR6dXRYYU1G?=
 =?utf-8?B?c09NSGFTMHVLNDBVNnczcU5uYXRBMkY5ekVpaHNUWjU3ZUtVaTY4YXlvbGpN?=
 =?utf-8?B?OHQrbHlNeFFVejJNTzBLOVFEVjY2eVJlVGJIZ2RrSUtIYWhnQVBaZ1lXK1ZM?=
 =?utf-8?B?VGpTMEZZQzlzeEM2d3IxTUgwTDBmYSthWlpDVWliL20zeGo4OGNIUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d391c0f-961d-4218-25b9-08de5a589b76
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 08:22:54.6170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rw8scGkzl3+wYhT3XbclFZyroDc5VRZXLz1V3qv1wh9fUswDgoR6vHJlYgh8KMYr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5917
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



On 1/23/26 08:40, Ilias Apalodimas wrote:
> On Thu, 22 Jan 2026 at 14:32, Michal Simek <michal.simek@amd.com> wrote:
>>
>> Hi,
>>
>> On 1/22/26 13:18, Ilias Apalodimas wrote:
>>> Hi Michal,
>>>
>>> [...]
>>>
>>>>
>>>>    config EFI_RT_VOLATILE_STORE
>>>>           bool "Allow variable runtime services in volatile storage (e.g RAM)"
>>>> -       depends on EFI_VARIABLE_FILE_STORE
>>>> +       depends on EFI_VARIABLE_FILE_STORE || EFI_VARIABLE_SF_STORE
>>>
>>> Will this work on nands as well? They got a  much shrter lifetime that
>>> spi flashes.
>>
>> I don't think this is valid argument here. Users have options to decide where to
>> put them. The same argument can be used for u-boot variables saved in NAND.
>> Obviously I can update Kconfig option with saying that you should be careful
>> about it but it is user choice.
> 
> Yes I think that's a good idea.
> 
>>
>>>
>>>>           help
>>>>             When EFI variables are stored on file we don't allow SetVariableRT,
>>>>             since the OS doesn't know how to write that file. At the same time
>>>
>>> I am not sure we need to allow this for now. At least not until we've
>>> talked to the efitool maintainers and make sure they will accept
>>> another 'special' case.
>>
>> Not a problem for me to disable it for now.
>>
>>>
>>> The problem with allowing this is that if people enable it, boot a
>>> linux and do a setvariable, it will return a success. But none of the
>>> variables will be preserved after a reboot unless someone manually
>>> updates the serial flash contents. In theory, we can preserve the
>>> driver  model and the spi drivers in EFI runtime services and allow
>>> 'proper' setvariable at runtime.
>>
>> Wasn't this the same case for file based one? I mean u-boot had it but efi
>>
>> Yours efivar patch was merged Jun 23, 2025
>> But this symbol was introduce in U-Boot April 18, 2024.
> 
> Yes but the patches were sent a long time ago in efivar. If you look
> at the original PR date it was a lot eariler [0]. It just took a long
> time to discuss and merge.
> Apart from that the case for file stored variables is by itself pretty
> unique and convincing the maintainers to accept the patch had some
> basis. I don't know if they want the same workaround for spi flashes.

Correct June, 2024
https://github.com/rhboot/efivar/pull/267


>>
>>
>>> However, I think this is not very useful. Having an unprotected to
>>> store authenticated EFI variables, is dangerous. Someone can erase the
>>> SPI flash and efectively disable secure boot. Due to that, I prefer
>>> the current file based approach for EFI variables -- which doesn't
>>> store/restore authenticated EFI variables (and which this patch
>>> implements). The obvious downside is that enable setvariable at
>>> runtime is tricky once again....
>>
>> Isn't the same happening with file store too?
>>
>>   From implementation perspective it should be the same as file based. Obviously
>> efivar part is missing.
> 
> Yes. However, that commit included instructions on how to set runtime
> variables with dd, so people could use it until the efivar changes
> were merged.

I don't think it is going to be problem too.

What about?
dd if=/sys/firmware/efi/efivars/VarToFile-b2ac5fc9-92b7-4acd-aeac-11e818c3130c \
    of=/tmp/vars skip=4 bs=1
flashcp /tmp/vars /dev/mtdX

> 
>>
>>>
>>> [...]
>>>
>>>> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
>>>> index be670a8e7c25..feab212b245b 100644
>>>> --- a/lib/efi_loader/efi_variable.c
>>>> +++ b/lib/efi_loader/efi_variable.c
>>>> @@ -397,11 +397,11 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>>>>                   ret = EFI_SUCCESS;
>>>>
>>>>           /*
>>>> -        * Write non-volatile EFI variables to file
>>>> +        * Write non-volatile EFI variables to file or SPI Flash
>>>>            * TODO: check if a value change has occured to avoid superfluous writes
>>>>            */
>>>>           if (attributes & EFI_VARIABLE_NON_VOLATILE) {
>>>> -#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
>>>> +#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE) || CONFIG_IS_ENABLED(EFI_VARIABLE_SF_STORE)
>>>
>>> Do we need the ifdefery here? efi_variable.o is basically compiled
>>> whenever we have the variables managed by the non-secure world and
>>> this function will exist either with a file back storage or a SPI
>>> flash
>>
>> It can be reverted and return EFI_NOT_READY for EFI_VARIABLE_NO_STORE.
> 
> Yes I *thinkk* that will look cleaner.

ok.

Thanks,
Michal

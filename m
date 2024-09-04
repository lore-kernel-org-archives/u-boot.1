Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D51CD3431
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 07:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C01388C91;
	Wed,  4 Sep 2024 09:59:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="towvXTMl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 532C788C97; Wed,  4 Sep 2024 09:59:37 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AE738876E
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 09:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvXchI+ac8sOTRfJp67ItJ1hNwlGdMzWaVtO88tCqF6nwduuIicfFr4TGXdlOvtk3Besh60rJ+7aJ2/M7N1b5doxEh0o+fnTzxaw/4Ckse7HqBj7e3yolevfFJffEod84O1U6SV10AxAi/qQfITBjlTzaIjcE/eZoZOuxp2O91d1E8Omk2ayBBS6J4TkjzJYNSp+4bwDDl1GpfxPaobZgH8p6BVJcZYic4WxKwRKD55v3/GXSmz3I/tVGsZGGVQcknUWf/VSVNjl2z0wSJesZZqa87NQntPA0geMNiRW51qGS/t0MZNzZg6ftYFVDYukBgDbKXgfMVHuQlWQeRRiIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgpzWTQoG16Vk0RVLR7q5rgOVJvtlE4v2LknPrqk/0U=;
 b=FfcQgp2gKpYxEuMfw4Qg+0+QJp6M5ZHIN6WxJS4ZFq7dqPe+xI8qlkAXGZNJdO+VfGJ1zOAIC00gd5VlqLP3kALIrO9GYnS4MFaBMN/Tq4IreCDP/x7t9lmh3TsUX44fwbkgA4CGaOOPbgbGptPam0J2DDW7baiOauF4VgyeR5yW91gJWh1LSvltbAM4sFGKNQHPV8jDb0WQdOqD3AAtDOP3lpZEsZh6nOWtPA5K46waSb1Hsgx2OrvI5b6D6xozzyyt+DhaqIJPzRQ7kOJmR7NgOFFg+TCjkjAXD90FNc391V0p7W3xwvj3MQtO0i+/vh9ZukOR3kKPVx6nP62O7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgpzWTQoG16Vk0RVLR7q5rgOVJvtlE4v2LknPrqk/0U=;
 b=towvXTMlXQVh9ZV8qMPj6ORnaT+IjO8jLC+E+nWImNtZkiqwjL2O0jh9AGjMZNoSbOLEsUF6z4n+/tvXRcFKWh88XO3r947fcOAYvkQo8ZV0lDFcFqLD5Wu7B4DN43a5ux6JB3eUqKDnWFFsBcvla0+U+M2TazExLHS5ouSC320=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 07:59:32 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 07:59:31 +0000
Message-ID: <fd9acaa1-b014-4d21-9756-a6f1b2f9a8b5@amd.com>
Date: Wed, 4 Sep 2024 09:59:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] fwu: v2: try reading both copies of metadata
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240830114057.891069-1-sughosh.ganu@linaro.org>
 <20240830114057.891069-3-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240830114057.891069-3-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0274.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::41) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN2PR12MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f96704-76d5-4dc8-6793-08dcccb78244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmJ6NzlwSjVlZG1OMktQT0NWVDhLcXJ5RHZrNHpmcktHRkNMZWgyZ3FrNjVp?=
 =?utf-8?B?WUR1cTcvUDJpU2p2eHV1QUQ0QnREVTVsazM4WVFXeHRqMFA1Y1ozWWh6UkVL?=
 =?utf-8?B?VkswTk9BVUNqdEoxWkExUkJsNTJ0SHVqUVVPayt2YTJMOHQxb2d5bzNsQXNB?=
 =?utf-8?B?anRJQTNldzlpUWY2MkM4dk9tSDBacHRzMmw3WEx4UGJiMDRFTENpeWo5aUNH?=
 =?utf-8?B?SG4ySnZiRmpkU0J2L1NKeHJsMnB2bTVva3JMQXdLSmRPa05LYm9rMlZ3Y0RB?=
 =?utf-8?B?bzRHNWoyRUxsTWlCZ3h1TTJkVU8rNUg0aE90bUVMK29KQkdoaWU1L25EMUFG?=
 =?utf-8?B?U2c5b1ovOEFPU08weFVhWkpid3F2OCtBT01tQnZnWW04NEVIYzNwcTBGQ0tZ?=
 =?utf-8?B?aTcvUzJPcGYvWG8xSXRMcnVaL1JWRjZHNDFlZlFHTGFCZHI5UlVLWldWWW02?=
 =?utf-8?B?S3ZFcU9QbzdJdCs5elMyN0U2N2JwYVQxMWlOOHBjUDVrMDZ4bFRYL0ZjUmdn?=
 =?utf-8?B?eld4UExIVjlMSCtybEJvSUZIYlhiYkVtVUduL242S3k5cm5ldHVEU2d5R1NK?=
 =?utf-8?B?Zjg1Q3IvMlRhTVF5dUh0WUVienhzZDVpOGZKd3dSRHJSWVNlWFNDSFRGa21T?=
 =?utf-8?B?ZWRpTkZHWVp6ZXYxZTlUSVhCTFZFV1ZTUkYvTDN6VjYvWjkzb0NoZXFjd1RK?=
 =?utf-8?B?UjdoaEFSclBEM0xwOWt3aEU3TGRvL2tZNlR5Q3RSN3gzV0l1cGdxMldJc2or?=
 =?utf-8?B?T3FWQUMrdTRzaHZIWXNmenRWUUJCM1I0Wm1Tc1E3VGVCU3NwNjJORitTVjQy?=
 =?utf-8?B?bEJBWnBnL3I4cDU1N0gyaW43WWNLVHNpZnNtVklUSzNTT2g4U0ZrK3FqcW1R?=
 =?utf-8?B?dklLb3NnaCtvVjFLYWpYSUJWUWZMeWJnb1dzSldJN1cxaUFCZnFFYXhuK1RX?=
 =?utf-8?B?RkFWcHNzak1qUFdwK21aa2RTQjlVQ3RGaVFVMjZHNlRwMmVKZFpla1c2MHcx?=
 =?utf-8?B?U0QyY1RNY1MrRUxmbnc0NlZvdll3eDN0N2hzUE9KeWZvWFc5RHp1UjF0bzFL?=
 =?utf-8?B?UzZSdC9Za0pNS3NkS3FDT2lyWHlJajRHeEhuSVJISHFaTkdFSE1IQUwvTnNR?=
 =?utf-8?B?ZitVMHNIb2ZQcFdmcDF6QjR4Qy9Dc1VmOXNsMExIQzN6MDhiNWdoZ3RrOS9p?=
 =?utf-8?B?aCthd3dHZHZzT3NNRGlaaG9pSVJyR2hHZjJjM1F1d3A3MUNmYjFiQW5pWlNR?=
 =?utf-8?B?T0tUTHppd0R3Z2pDVGx3S2xxZVkvU3E3ZnIvNmJwbThUK0xJQnpjdzBrTnlG?=
 =?utf-8?B?dE1ERmE3SUtIdktvVzhWTElXQzNsNkVUUXNPMThXQ3BJK0lrVFF0MTJLdHR2?=
 =?utf-8?B?aVNtNUFsYkhRTjZZSzE0QUkvdEtjSmptS1BJSTMyQ2ZYUEUxUS9VWW0wazNV?=
 =?utf-8?B?MXA2YzFGU04wMnAyMzRJem9qNnRCQUtlZHFYcWVjd2dxY2RIUEk4aldzYkpE?=
 =?utf-8?B?ZFpuRm9EMmJYajZxcHgwRFNHbDY5ZTUrWjhjcVQ0QzhQOUF5MmwzYk9YT01u?=
 =?utf-8?B?ZUF6bVdxRUdxUmsxVVlvZ1dxcm84R3lTajdCdWN5dlQ4d05NMGI2ejBnVWFN?=
 =?utf-8?B?bXYzUWV0VWNGeXM0ZjcvMDVNdlhDSTVSTWxjSGJTUGFHVzN3QllCZGo3Z1Bw?=
 =?utf-8?B?SEJiMlFXOVBtNUI5NHowaDE2Y1A3eXBiTWEvaEpJY3hHZ1FPZVkyb0pCc0gz?=
 =?utf-8?B?aGJVR1VUNHRDRXJNeDIrUkFmQk9TSlpLZE84TW1jTGdhVG1QNnlLemY3VmN4?=
 =?utf-8?B?QVo1MGtXM2FwVnp3cUJlQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjZZTi9kdWtoNHpBUlNLVWVsVkc1VzNIaC9Kc242L2JMYkd5Z3ZyRWN6QjdV?=
 =?utf-8?B?ZVBYazd0Wms1SWlpMEZuNXNCMzdvQnBTTVZtZVliMjBVU3VCMzl6OEFaUjFu?=
 =?utf-8?B?KzQ5RTA4ZjZldU56R2VpWDhRU0Y1blp6R3RKWXNxamtlY0lwSXY1V1dXTXdu?=
 =?utf-8?B?WlpNVCtqSHNrSzBRc3lKRU5OMUxqaWc3WGUwNnZrNXFBNzA2Mkx5elZRdWZk?=
 =?utf-8?B?TktKY0x3ZHRoaEZlelV2dk9EZXZnRFlDYXp1Zk9oUEd3cUpLOURnTkZZVTNk?=
 =?utf-8?B?TTBIb2JaL00rdmdVYTZXaU5aaytkTklUQkliTnFuNnZJTjd4R2oyR1Rkd0Ix?=
 =?utf-8?B?VjdwOUVyWTVhUXNPS2JzQlQvVWl0UXlTZUx4RElUUTRxZVBPZ1ZocU83ZHlQ?=
 =?utf-8?B?eVlnVFRJWFJ6bGtaa3RsN21JQ0NPcjM1LyszTytseWVQY2tRdUxNSjJpYXlZ?=
 =?utf-8?B?Y2F2U3dPT3p6TVhZMlhJRlF0OFNuR2FnbUJVRDVoSGdxUzk1ZW1kc2lQRDIw?=
 =?utf-8?B?Q1ZIUGlramdXSWRmT2U1NUM0M3RZMmxsWnR4WXAvcWlPK0JmR0k0a0hZd1lL?=
 =?utf-8?B?bXBTMDN5R1VHN3ZCT3oybHZXQzNxMktsaW1RMStZcWVTV0tuSjlWWFI5RTVQ?=
 =?utf-8?B?dU9zSG16b0pMVnNhLzlHMWdjTHVEUHB0VzcrQVN3QitjMlgxVzNhNDdaN05E?=
 =?utf-8?B?Zlg3VzJ3bUhLcTFEWTRiWnJRRkx0UjZTNDYvVDFUdTZ6aHNBRU5uV3hsMGRl?=
 =?utf-8?B?NEx2elVMOVlTS1R0V1NkUlBSUnZlOU9KVlk5M1dtQkswQkRmd2RNOHNmU0Ro?=
 =?utf-8?B?eVpZMU1lZEthSXJ4RWpwWjJQSjdiZFJkZ0xtbjBYTlhpVjNHZUJCTUw0N0Q2?=
 =?utf-8?B?cnRUQlZYckdINlRocWNSY0l3RGhHTEo3c3dRMW5rTHl3bk9saE1PTXhxbXRP?=
 =?utf-8?B?UTYwZis0WEM3UWhUeFg1Y295K05tZW1hcXhnRUEwVXdjQmJiSlVXZTJqOUJa?=
 =?utf-8?B?TGs4OWk4a2hqUy9mNDVZRkpnR1NvY3duRThpdHF1RUdkeHh6YVZFSzJ2ZVN3?=
 =?utf-8?B?bWlzSUlINW8rcHQzMGFxd0VBTVFBekhzUXV2YUxydzBBSzkwUXBXWkxWTkVq?=
 =?utf-8?B?WUc2RnBta3N3aXhqcjlWYUNBUGlJZWFuU3F1UDQ1YzZwUExXNWNVQzI1eWFj?=
 =?utf-8?B?ZEpsS1g0S094VHh2UG5CNDYrMVN5YlZ3TlBYeURlMmNrRHJ5cXBBSWx2ZjdE?=
 =?utf-8?B?Y1JFeHhpL2hHblB4UVU3bVd6NHR3dHJvRjd6SGVuQklyQzU4RDg3bHVJamVu?=
 =?utf-8?B?UnFNNnd3U3hxeWJUQ3ErWnMxSEtaaitzQ1Zjb2Jnbk1qWlFDS2ZLTnJPWDRj?=
 =?utf-8?B?VHVMblFqR3hZaE5nRWhubzZWUjRkS3cvdWtjWUJjSEVGdWFKdTlpLzgvV3Zz?=
 =?utf-8?B?cDdQYm50K0VpNU4vNXVjbW5ka2FaYmdlbFZ3MEpxcXM4OW0veTUzTGpacW1w?=
 =?utf-8?B?dUhOTGowZVhTQ29ydHo4OUdIWjhGT2Y1NTcxMEdaTnZUWU1HZlVZUXREWlZT?=
 =?utf-8?B?dlNnaVVaVXpqOVMvZENwdWNOZWVDdUptYzEwRlhId0xSamVFUDdPL0s4aXdq?=
 =?utf-8?B?Zm5RUzR6R1JicDIraTNaNHhkNnMvSHcyVUQwcW9QaXRPaHRjUk9KMzdpanpx?=
 =?utf-8?B?aWFOd2RpSGdxU21mZS9XZnNMK2lSU1k5elN0NDdyYm1Jd2RmT0lJeis3aDk5?=
 =?utf-8?B?cFNVSjFYQ2dWVzJjelhIcTdSTG1wL0lGRGVnM1psZWhZNXZzVVRZbTJ2azBC?=
 =?utf-8?B?eXhMbitJNzg2VzlzemhpaFBBMmFjR0U5NjFMRFFLVVowa25VdmcyeHhPM0gy?=
 =?utf-8?B?WEhrQUt0UCtwQW9JQmdRNEc4WTFucGJIM2tpZ01mcnJFQkovWWJrcTExV0l0?=
 =?utf-8?B?blpJbDVhSGVTSzQyeUh3S05jWXhJTGcwcmoyVmpQd0pVa1pXWEpGeGpUMXdH?=
 =?utf-8?B?N0VnekdMdENqOTVaNmtXZmt5RmY1N2QvcG80dEhRbWFHWU1sRnZqaE1YNHFJ?=
 =?utf-8?B?Q0J5YUMydzI4QkcvVG5lTVBmbzdXQTVmVHNTVm5zQWpSSGwwS2c3a2xlbU81?=
 =?utf-8?Q?gA5aAjhdOSgf3cqotapbq0MTc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f96704-76d5-4dc8-6793-08dcccb78244
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 07:59:31.8742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skrxbd7Gzi1R/Y7VEmBcnf4UC4L5YuOIFWtVvwT+NQrxCs9+4w3p42ScIJnXbI3Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343
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



On 8/30/24 13:40, Sughosh Ganu wrote:
> In the version 2 of the FWU metadata, the metadata is broken into two
> parts, a top-level structure, which provides information on the total
> size of the structure among other things. Try reading the primary
> partition first, and if that fails, try reading the secondary
> partition. This will help in the scenario where the primary metadata
> partition has been corrupted, but the secondary partition is intact.
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   lib/fwu_updates/fwu_v2.c | 77 +++++++++++++++++++++-------------------
>   1 file changed, 41 insertions(+), 36 deletions(-)
> 
> diff --git a/lib/fwu_updates/fwu_v2.c b/lib/fwu_updates/fwu_v2.c
> index d0d8a25929..69306282aa 100644
> --- a/lib/fwu_updates/fwu_v2.c
> +++ b/lib/fwu_updates/fwu_v2.c
> @@ -10,6 +10,12 @@
>   #include <linux/types.h>
>   
>   #define FWU_MDATA_VERSION	0x2U
> +#define FWU_IMG_DESC_OFFSET	0x20U

And this is value which is sizeof(struct fwu_mdata) right?


> +
> +static struct fwu_mdata g_mdata;
> +
> +#define PRI_PART		0x1U
> +#define SEC_PART		0x2U

You already have them in include/fwu.h

  88 enum {
  89         PRIMARY_PART = 1,
  90         SECONDARY_PART,
  91         BOTH_PARTS,
  92 };
  93


M

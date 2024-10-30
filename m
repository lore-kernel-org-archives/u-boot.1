Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD03D74962
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 04:53:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5064E891D6;
	Wed, 30 Oct 2024 05:53:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cbt0wBYM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FBAF891DD; Wed, 30 Oct 2024 05:53:22 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E2D78918E
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 05:53:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOYTNMuCOwFde3Ib3bYX+c3Wm7Q6T03YqlRVz67pETHHYXE2jBjNXSa7gvbRodb49ErP22lLvE5uSZpbunTue2/rVv/Ixl+XLI/BfFtjGu88W78SOovzxm+DXDKsrfvrtGbmKWsR1qsRbe6PNKrZ3tefjIQr7+KfSPMJymjpLwi5UO1yIj41Mf4fkVzCOE3NkGEar7ar7i4QAQyhBYVPuNqwjSx3tD7Dz2g79HUspVYokGQUw3n5W7Kd4v5JZicaciOJocM90YtrTy5b7eHibSlhOTtTKelVL9M0QhxjhG7jWywNWkB5k0RktuaDk5838xbneq5BGskftcy3tK4ffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oZtYbvjw47moUggqjE9v63pax6b/t5mcKVSaK5ZCJs=;
 b=rfEWRKZLLLGkM2DxHQrH/jbtv8BXY+s1qkJDuBdNXZCxSaqC7E6Jdyrz6ih6+1JTlUNFH6fBWz922tzJktWjDxP4c8E0zTGfiqFlRJV9j0iZuNxR8Q7+4Oj6Jw5fCd2YqlMatZiPlZ9Zvb0cO5Xh00Mre6MwjbLJcqiGY3iTcxyHmEixcfDGOXyodApVRpuK4GI7YtQJE4qXgfw/kgA6o/OHBex0M+aUR/bl0A9oUUv08CVAjACj4ATxgpSCebyvAVeeAm+CFAB5pzTg2t9x+Il7XrA5LPxCFWt/xls6FPfxY78U7yz/xRQT7jqMNPxY6KFe23Az0tJiOFhC6lS0+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oZtYbvjw47moUggqjE9v63pax6b/t5mcKVSaK5ZCJs=;
 b=Cbt0wBYMEoHk4J8eUkTJrLJyfRkqIh05DQdZToyenso8bQC25UdOdyGkBQYgpqg6ziqiih/zMtw/K94tPmgPgUjhV6GVGlHMObsNFWcau8DptuezS0tyoXnKsCW56lM8dCL5omgw81dPpm/LQcKZRuUKr3oPe7+Npu6wFvBlGVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11)
 by PH7PR12MB6835.namprd12.prod.outlook.com (2603:10b6:510:1b5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 04:53:12 +0000
Received: from PH7PR12MB6538.namprd12.prod.outlook.com
 ([fe80::f0e4:5de5:39b7:ea7f]) by PH7PR12MB6538.namprd12.prod.outlook.com
 ([fe80::f0e4:5de5:39b7:ea7f%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 04:53:12 +0000
Message-ID: <a6fce844-d28f-4af9-8a6f-c3e82eb7eeff@amd.com>
Date: Wed, 30 Oct 2024 10:23:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test/py: spi: prevent overwriting relocation memory
To: Tom Rini <trini@konsulko.com>, Padmarao Begari <padmarao.begari@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, michal.simek@amd.com
References: <20241029114709.3983243-1-padmarao.begari@amd.com>
 <20241029191253.GH4959@bill-the-cat>
Content-Language: en-US
From: Love Kumar <love.kumar@amd.com>
In-Reply-To: <20241029191253.GH4959@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::11) To PH7PR12MB6538.namprd12.prod.outlook.com
 (2603:10b6:510:1f1::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6538:EE_|PH7PR12MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a127ac8-599d-4038-be24-08dcf89ec1a9
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnFrenAwYjhTb08xUVdISXVwZ05sTTBxVGhqZGtxSkt5SGxPdnNLRncvQ2VS?=
 =?utf-8?B?ZVI5anU5SytBb2VBVUg0RTN1UGNkQW1rMEdOSGxYSE9hbDFraklEZzJLdjR5?=
 =?utf-8?B?TnR0SHdJYk9WN1JjOTB6alNwK1M0aXRacEtremN4WXY1RVlYQ1dOaC9oaUVO?=
 =?utf-8?B?ZlhjbnlEYllFV1hJTk83OXNQeWRNNExCNWoyTmRvVSt4VXNwakIzYWNVbDNY?=
 =?utf-8?B?NURwTzhNeVh2RUdoTmdkYTdpRm9xeEwwb2JDWkFJQTV5MkowREFvakw2QkE1?=
 =?utf-8?B?SzVVaWlMME81cktLcHhLTmZFVUl3Q0FJY2V2dEEyVERZaUlWR3dSTTh4SUpR?=
 =?utf-8?B?Zm1VYzZpZ2FuSWJ5ZGFMZG5nUytGajNrdTN1T1Y2elNGczBDWkJzdE9UUTUw?=
 =?utf-8?B?K1FDUjdMNkJXYUdoSHpVc29XbVUwN1BUcnM4MzZJell4RE5RZjhQd3RuTm0x?=
 =?utf-8?B?Wi8vME1MSlgwMjIxU09tL1NWQjNMcWpBanMrSE9RQ1JSK0FoU0ZGcnVhc3FR?=
 =?utf-8?B?Ykp6ZWE2ZCtBcGMrSkNQVk5OWDloVUt1QXhjREVqUkZQVWt4dytsYUQzT2Zu?=
 =?utf-8?B?UjdoWDZlUmdTcnpSOWo5Z0IycXdscFdUaERkcUxmYit2MU5HenhyWUNVcEFU?=
 =?utf-8?B?anVWdTJFQjJ2SFdoRGJHblVVS3FIQ3BqcE1OOVpSWjU0aWQvN1BBSXdHYkhm?=
 =?utf-8?B?enpPNkU0a2htQk50dTRHMlR4a3ZGVXQ5MXBKYXBuN3lCRFFQQ3BQSDJ3Qktt?=
 =?utf-8?B?d2RQQmNGMCt0eGhlQWFyYnFCODN0THorTnVmM3pHeTk5dGRKQVliMS9mR0da?=
 =?utf-8?B?QVM3V0QzTVJtZ0g3WVZaRHA2TjA4TWxBWUNJSm9NMUtqZHQycmpqSktYckdh?=
 =?utf-8?B?ajhLSkcwdVc2VW5MWmxqRXNsZmRybnBlQldIRGVrclpTeTF1dzBoRWFneUcx?=
 =?utf-8?B?NkM1Qmd2ZjZWV21wRk1xemNJeUdhL0NkVDZBaVNsbSs5NFpYVFArSjFvaWNh?=
 =?utf-8?B?b0V0TWY1cE11VGdUMFRqSWd5ZUFDcllFOXV4MExETlBob3BmZm5hZGw2UTZV?=
 =?utf-8?B?a0g0Q3gyWmY0bXpSYmorejhHTStwMlNrdmZWTlJQSGN1aENjdWxudDBCQ25q?=
 =?utf-8?B?MzVWY2FPR0lJUkphbkZoZ0xWVWQrTkN0L0pnZDhhTThVakZ1Zm5DNGxBVG03?=
 =?utf-8?B?UWRKeEVEc0x2WXExdm5qMFozWFE0MlZkeVZPZTRpdHNzWk0ybEdCSzBEdGJ6?=
 =?utf-8?B?dk1pTFl5NWZPakt1NkR1SEtwNXN1V0ZFRllXb1VpeWRkRXFQZ1BSOVQ3SlhM?=
 =?utf-8?B?TjZ4Vk55N3Z5Qm5zODZnV055WUFuWjlhdmU1cnB1dktVTlZjUVBOc1FTc1F6?=
 =?utf-8?B?UXlSL29tZUNYRmxYaEpUS2E3ZkdpWWlkampjYWF0bkNhbFlnSEVTWU5PMUFH?=
 =?utf-8?B?UURZd1FpbG82UjVhWjZNSFVwUGkxT0R6YWlXL3FXU2YrQ0s1dWI2aVpyL1Bn?=
 =?utf-8?B?RGlMYzVTalhOUXVxanVtdGNWRTdDa29tdG5XbTNzdzVmbTl1UFhlekJUMzFQ?=
 =?utf-8?B?dklhQlNmemtBbjZWbWpkeXhUYUlONkZFL1pINlZrTWNoVWdVYStwdUg5QXkv?=
 =?utf-8?B?OGp3V056MnJTMFJWeEN2dlFyd09rVm1sTkZ5OC9wcVBIY2dPcm95a3JiNGti?=
 =?utf-8?B?YzdERDhpTEdxSkU0OGdXRkMrMURNZC9TNW93ZW55cHg5QXhMTnR3bTFEZFZi?=
 =?utf-8?Q?MBT0RFAtDJeUUp69UF43wZUGoIIHSObHRl4kX/P?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6538.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWJuMGNKQlRKMjNRb0ZJNmJWVjJReVFINnB2TFBwM3M5N0ZhRGtYRVRPOEhR?=
 =?utf-8?B?QWR2b2dSRDFzNjdEa3VoWUxiTDVkR2h4NklDWklJQmQ5Nlhic1JmWUh5dlhk?=
 =?utf-8?B?aURPcTBMSFFmSXF2R2xVRXowWXloU09lcFBqZnFoNUFsSDFIdWJGaHpjbC92?=
 =?utf-8?B?d0ZwNzM4MVgrdURSYzA5dmJxT0IrUVJSVzlkODFHTmZUdUc3aU53NEFnR01o?=
 =?utf-8?B?VlppWHAzQkcwVDZtbDdHbms4aHNCamxDczdxbm5Vbk9wN2RCeUtwaGVLZ09L?=
 =?utf-8?B?SW1zVDFwMWVKOHN2Qmk4WUhoQzViSmpkdUNkOW9QSFF4dlIwNlFGMThtMHF1?=
 =?utf-8?B?dDhDZy93WEEyOHkzaHEvUnpjR1BQYXpyZzJtZGxYN0h3dHRZNkRndFk1dDdq?=
 =?utf-8?B?RlAvVUM2MFpCVkJ1NWdibFFxcDI2OGVMeWNTeG9ZTXJIdUxoOGNXeGllSlhV?=
 =?utf-8?B?ZkFGVldNeVF5cGJCb1hKSUh5cVdsTE8rWWx4dWRpOFRzUlQ0Z3BzNmhITlJH?=
 =?utf-8?B?NEtWcmhXMU90ZTBLTVhNbXZXMHFrQ0FKcEdFQ1hXclhJdldBK1BFd280SGhS?=
 =?utf-8?B?OSszZzh6cjRQVkVYVW5TU3VEU0pKWlBnN0IyQzR3WW5jbkZKUnk4VlRTcnls?=
 =?utf-8?B?LzBETmJIaE5oUkQrZnk1ck53RGg2ZlVXUGgvMFRIT0tWc3hXOGJQOVFxUlU1?=
 =?utf-8?B?bFJHYVVhODNXTXBQU2JjSU5JMVNGSVc0cmlBSUo0T0xjblVJaHgrMTNJL3lM?=
 =?utf-8?B?NjczbHFHQmVaYTBjSzZ5RXhkdVNTL0tJSUdyb2FFZWJnam5TT2MvWXpYeHZK?=
 =?utf-8?B?SURKbUhqbmNKZGM4M29SSWFuMFE4M2xZRHlJV1dYZkEzNVI1WmtZRDByY2JY?=
 =?utf-8?B?b2pRY3VzaDFmbnhUdEl0c1dDK1E2dmlXOEF2ODJwSUt0d2lRWnRhejZ1OHBF?=
 =?utf-8?B?VnBQQVNZUGxjcFJRTWZlVHNMYTUrbTZ2M045MjZEV2xZaUxmQk4xRkZiQXBj?=
 =?utf-8?B?MklxeG96SlNXUUVCYndnd2h0MVpWRGFBZ0Y4WkxyUUdjbXI4WnZvbk43VHRj?=
 =?utf-8?B?SStzVUpxdkdmQWQvQlN4QkRDanYyclBEWUMybnhacHlsUk9pdVRtR2FQNllK?=
 =?utf-8?B?M1JTVHF1TU5xdHF5VWFHMkx4OFpZWkozMHFXQXJITi9oR3hqSEM3TFN6VGZK?=
 =?utf-8?B?L1VtanVsT2NwdkcxanlEa3dhM0VibWN6aVNuZVZ1aXd3RzkzdUZtQjNPVWhn?=
 =?utf-8?B?dUVyOFNnMjFmTXNmWG04MmsrWXNwWC9GUWYrcnR2YlpoTXRaQXZMclB0L2tw?=
 =?utf-8?B?WkhFcy9wN3lVdi9LZWkwdFZUdG9IcGF0aENOWjZoVmptVXFPWXppZDBaZ0Zk?=
 =?utf-8?B?U0FqeDNLVUV1LzdGNkRuTFBDaXdKU0F2YnpCSnoreUYrQ3ZFc3dKUUJiOGFl?=
 =?utf-8?B?enFFTUwweE85bURpVzB1QnZlKytzQngxNzF4SkFzNWtHcWRtTjd2eHNPMTRS?=
 =?utf-8?B?cW42OGovYzhEUWs5MCt5ZjdTNzhSY2RSOEJiMC9lWWExRHJsd3g3dHVqKzdt?=
 =?utf-8?B?bThvRTRQZU5kQXU1UnZkeW1FUys1Vll3bmJTSnN5THVpeTRhZGEyRzNENElr?=
 =?utf-8?B?di9HM0RiQ3EzdlZoUEZsa1RtVmRYZ1pZY0pqQS9xR2lXV2wzcEdHZzNOYk5Q?=
 =?utf-8?B?V0V1QmkwNUVIQ3Y5RjhPNkM1NGlTOEIxR0pIdHVidHNjQjJZZWxLdCtGTnJa?=
 =?utf-8?B?MFcyWlN3b2ZWK0dRUEVSeXBBSmpsaFZuMDJSZEIyeEhDVkxjT1FvYWFxdCts?=
 =?utf-8?B?Q2locHpndTdERUg0d2JjZW9IVFh1YWk1ZGwrZlJRS3ZSM2hrNjk0RHhZdHFk?=
 =?utf-8?B?d2o4VVp4QmRYY2dubXRkV3VhMXpsMDlhcW5UM01sNVFTWG8vWVZtR2lnQU9R?=
 =?utf-8?B?TEVZSkYzbUtQR3VsQ2dla1lzRlBqL294OEt1M1ZtZjd5UEhKYVRpRkMzSjVI?=
 =?utf-8?B?T2MxVGZnTDNLekJ3RDBjMGF6UWJhWkd5Q2o2VUhWVU9UVUF2UXVKWnFNcHZV?=
 =?utf-8?B?SGlES2t2S0g5VUpCREppSTJKOTJWdUR5d1dTazhJWTRncDkrLzAxVzRZZlkw?=
 =?utf-8?Q?nqNpTGZ56iZ8eO95GZ7oc2vvk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a127ac8-599d-4038-be24-08dcf89ec1a9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6538.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 04:53:12.0770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NTJxkngsItvhRpHSF8TUdLbS0hjWcbqoMMwqsO5zswCs/R21KSoq2C1HWT9MIM3K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6835
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


On 30/10/24 12:42 am, Tom Rini wrote:
> On Tue, Oct 29, 2024 at 05:17:09PM +0530, Padmarao Begari wrote:
> 
>> Update spi negative test case to prevent SF command
>> from overwriting relocation memory area.
>>
>> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
>> ---
>>   test/py/tests/test_spi.py | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/test/py/tests/test_spi.py b/test/py/tests/test_spi.py
>> index 3160d58540..caca930327 100644
>> --- a/test/py/tests/test_spi.py
>> +++ b/test/py/tests/test_spi.py
>> @@ -693,4 +693,16 @@ def test_spi_negative(u_boot_console):
>>               u_boot_console, 'read', offset, size, addr, 1, error_msg, EXPECTED_READ
>>           )
>>   
>> +        # Read to relocation address
>> +        output = u_boot_console.run_command('bdinfo')
>> +        m = re.search('relocaddr\s*= (.+)', output)
>> +        res_area = int(m.group(1), 16)
>> +
>> +        start = 0
>> +        size = 0x2000
>> +        error_msg = 'ERROR: trying to overwrite reserved memory'
>> +        flash_ops(
>> +            u_boot_console, 'read', start, size, res_area, 1, error_msg, EXPECTED_READ
>> +        )
>> +
>>           i = i + 1
> 
> This got me looking at test/py/tests/test_spi.py more closely and this
> test is fine, so:
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> 
> However, the error message 'No env file to read for SPI family device
> test' should really say that it's no test device configured (and similar
> change for env__spi_lock_unlock). A follow-up to rephrase those error
> messages would be appreciated.
> 

Thanks for looking it.
We'll send the separate patch for the above.

Regards,
Love Kumar

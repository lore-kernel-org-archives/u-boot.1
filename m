Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC9CC7883B
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 13:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B00DD89387;
	Fri, 20 Sep 2024 15:18:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CC0JGSyt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE033893A3; Fri, 20 Sep 2024 15:18:10 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3959689375
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 15:18:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPa8A3drZI0WUFycxT/nbC13iF7SBmRpvORMQvpIHZo/hSJNkDOWPbFJIBp/dobmACJtuDs6B5X2hT3hOwMcruxk/ONNYDXUmx/mC0ZWnNjBg3wgoKqaEwPZwNGRrXg3Bd1MAUnFFqGhMnYYf5gAC5cbqsmhyWNv7jSu+RH+QwWXejj1/c5NuEIGJi5TAmWB5SQJ8Vizu+1e+5+DEjVf1ku1nKVocURZzSASf/FdFpgrluTuilN8NFyNAvgyHaq4DuQwJ1sNVSZcC87ZmS0DiQfWecnsGuIJmMU0qyWN3ML4YSnSuJTdA5PMlpIpf9iOink4mH1vM0+t1lt8+m0IeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVIXKmkcn1tPY2PzU+rXn1vbVXFocQLOwZ3HONIDfUg=;
 b=v3yzpDNEcjy7an+gG0GPTnw4mNi4Nf8B9r1Ofkv5tpQq2S5FH8yCqH0V9QiwdFD/pqGpwgMiBbSQjWmbcryaibDeOpTjTDOIQdBq/a71dvh62PZdqsF53x2v3F3bYqUD6eBFnm51QWf3yyZDUygiZkwHnsdkC5WVBwb4MpEZTdftTfyPHIhapwvVnA/1U9RX0d4k7Kdqut8IlmL5zUZsKOAaEWoixv3zt8Q58od2i2+/6vy2R44pEGzFCDyEWMZlQdQUO3YLAdcJQHaZCZwer4ActpumoChfRG9cGXKH79M2508WJAGnfwPQnY9o4KEIYW4/hKApx/LqegE+Fgi/LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVIXKmkcn1tPY2PzU+rXn1vbVXFocQLOwZ3HONIDfUg=;
 b=CC0JGSytrIbPjgGYKLwxfDJz9FTTtB/5D5aFqvslCiSOf5jaRQWX/+8xNpPSZY57SXOjNjM6t1Qi1/US8aGAEKdQjY4Rl7jJsms69vTRcIQdoslAvceY4kA9Cx6GnKq9hsK+7nd0kmQufqf6S/CyuGE48Pw2R8SSnLmQQIIEpcQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Fri, 20 Sep
 2024 13:17:58 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 13:17:58 +0000
Message-ID: <583a0b4c-9b4a-4668-b1ae-65f0116856ce@amd.com>
Date: Fri, 20 Sep 2024 15:17:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: zynq_sdhci: Remove device_is_compatible() function
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de,
 git-dev@amd.com
Cc: venkatesh.abbarapu@amd.com, Prasad.Kummari@amd.com
References: <20240913093157.2343476-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240913093157.2343476-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0105.eurprd04.prod.outlook.com
 (2603:10a6:803:64::40) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: 23eb142f-c1da-4eaa-8495-08dcd976a575
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWFLVzQrWWhHWCt6QVU2Wng3RUE3M0hXUmFIUUZCTGNTcFp2dm0xT1BLV0E3?=
 =?utf-8?B?dmtMTXE1NFBiRy9HcGFWZHZFQldaRFI2djVobFZYL0NiT0JDVC84VHZwYXJo?=
 =?utf-8?B?ZkdudWU0WDlqUVlRU093ZDIwb1J5dFExVVdVMGYxckMyamg1clp0cVJzSUI0?=
 =?utf-8?B?QkVYaTZsTnplN0tGU0loaTlsdzh0R052eE1aV3k5d1dQSG82VHZHVlpyWUYr?=
 =?utf-8?B?Zk5sVzZETCsvOVdsTUhZeVI1YVRwb2ZYZUlKS2d0OEhvYUxuQnUwRTE1cXRv?=
 =?utf-8?B?UG9pbDNzcENnRno4N004VktLOVcxRVNtNFBaQ2FvMTJXSGVYM056c1p1cGY3?=
 =?utf-8?B?TzhwTEtkODhNNHNMUnRJbHpoZUxlR2ZzNjR3cVF4aG5USDFCZDlCNWU3RHhj?=
 =?utf-8?B?OXJCbTJyTjJxcVZGUzdsT3h6MFJWTnRnSkVLdW93K0dzMHdMTmJxeE0rY0Jy?=
 =?utf-8?B?RDEvZ1FadTVoVW1BY2Ixb2ZnN2ZDTjZSdjNPMVVQU2Nhb3V4b0drYU82anUw?=
 =?utf-8?B?L1Uza05oak11NUNjMUZwNjhyVTMvb2pOa2JLNzIwbWFjRHgrSXhuZ3BSbHdF?=
 =?utf-8?B?RktOK2pBUUNNZ2hKNU9XaVliOUZDM1g3UVI5L1BUUmo0MWFaT0M5NzAxMEJx?=
 =?utf-8?B?NkwyUENuTkRvZURlZkU4bzRlbEVuZDFVdUFEbVVpbEovSjBXVmg5dFlRUk9G?=
 =?utf-8?B?czViejRnK3hqb0hjT3o2aTczbVd5NUxLNUttaXBrQlJoRHl6TjFvbHkwTkU4?=
 =?utf-8?B?RnFrY21NZTM5ZDRXQUszZnBjV0kxVGRPWVdTUzdkOWp2eG1tQmpEVWl6S1N4?=
 =?utf-8?B?RmpPeUNhOTBQanF0eUZPTjBheHFwV3NIVCswdFVDa0xrcmtJZlUzQ3lVTU1N?=
 =?utf-8?B?bUUvT2o1YWRkVWltbGxzWHdSbS9KckZPdUJqOXJkWDNoT0l0V2poQ0FkNzlz?=
 =?utf-8?B?MWJBb1lUSmdPeU0xT0xyQ3MwWloyRzgraUJvMGY5U2kwck4xeDJJMFlURUR6?=
 =?utf-8?B?ZFk1bjdPcUlkVGRlSEhjakJuQ050YUZCRm5hcmNmZUZBMU1vUWtqYmx0ak5l?=
 =?utf-8?B?QTJ3MzdvcUpzM3QwU2RZeTJCeUsycDIweGRQaVZrbTRmVS94TzlWZ0NSL1Qx?=
 =?utf-8?B?MWdJMWczck9SWVhPV1lMNXZxZzJJKy9WdzlyOVN4cSs4b1VlZjVCa3BTMVcx?=
 =?utf-8?B?aGFLVUY5WGhqd0ZoeS85aldhdTRpM0V6dWlNcmlsUEFqdHlHZnZZeVN2SE9i?=
 =?utf-8?B?QW5Oa1hxUmxzcnFvTXoySkl5eHVZZWVpZHJKdGR2aldlSnRJdFljTHIrWlZv?=
 =?utf-8?B?NjRJSnhSQXlpZmdPNnMwZE1RRTIxbnVoMnBYYUJNRjQvRXN2N25RbithaXJt?=
 =?utf-8?B?WktHMXQydERXQkFSbndBeFAzQVFQVC92dlJXc0tueUVqV01xT1RhRzNLREFr?=
 =?utf-8?B?c3lMV2s2UGJ3MFgyL1Ivcnl2ZVZQbDdMWmVVckFHZmZJQTVTWnlST1oycU1B?=
 =?utf-8?B?cUptMUJSeVkrck1uYXJSQXRkYXZZT2VtbXFQdEZ3eGdMakpOQ0NaMU9la3NI?=
 =?utf-8?B?SGpXeW8xb3V1S1pwTGxiTTNOMnMvSTRSYTRyRmhrQXNKWDB0cVQ1YUlkcm1N?=
 =?utf-8?B?V01nQmJabmlPQkRLcmIwVW5FSmJpR0pOeVhYWi9mSk1HWXJRQnlQbmNyN0Vp?=
 =?utf-8?B?MFVLZlovN3JWYXh1eWtjc0lDVlBlREJEMnlpWWdUUHpMQmxESDcxN05TaFBH?=
 =?utf-8?B?cEZ0TTQ1MVorQXJQdVRyc0dnWWI1YXpXc2Y5UmpObytxZ2hTUGtsSVRKaURk?=
 =?utf-8?B?K01wYnZMY0l1QWhaQ3BKUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0xwb1BBWmh0YlpCQkxsMktwNTZ5MUZ2U2M3VkpOcWhkRzNLWG1vV013RVhD?=
 =?utf-8?B?YlRRY3puTzEyWCtwVmtjV2wvRDlYa1pUenZLNTZhUkFvUjJPNU1aQS8vN29T?=
 =?utf-8?B?d0RnVDBIY3FUTk1vRzVkUFpRb2hsaEJlTHpIZFNaMWYvUWg2RFlGZ2pzZ0ZD?=
 =?utf-8?B?QUdzN0ptUXhxU3BRRjB2THRnVi9zdVIyNXhObTF3ZW53bURXYXc1UTRId3pp?=
 =?utf-8?B?eDJtR1RlM1FoU2NqRU93cnhRRGM0cnlxUXM4cyt1RjFlQkVnTW5BYTNzbHUw?=
 =?utf-8?B?Sks2Y3pXa29BbHFoUHgvYU1GZTl2ZmdhV1JDcm45NEFZZ050NFBHeHhxTXpF?=
 =?utf-8?B?aUFDc0ZNWlMyVU5KNFpvNTlDVElyMUI3QkFBb3ptSFF2d2N4UWxEZHNmTlJ2?=
 =?utf-8?B?ajRxU1UzQ3pVS2s4V3FlL1RURk9hTytJSmRCTW91NURqZVpEQ1c4dFVrTk1m?=
 =?utf-8?B?STN3SGdBYlk0TkRqSTdxUWxTK0poWHlKWExaY3ZCeXpaYnREY0hwQ3NwakE5?=
 =?utf-8?B?OTE3U3J1bEtkVUlwemRlSzJ6Sk4rTko1Nmd5QXVtSk5PSUx5Vmtlb0hiSFVX?=
 =?utf-8?B?YzMySmRrWWRKMFc5NUQ5RTlWdXNiVXVoOWl0ajF4K1JoZGE4ckUvNVNxM09x?=
 =?utf-8?B?OWtzT0l1NUQ1R1VuRTdXQkY1ejZ2eWFPbXNzcXhyQktSNFhWM1BVekh2WnhW?=
 =?utf-8?B?QnNmeVVmam9LbWRzNGVUWVR2cDdKTmZKeStyZVpqWnVRdXBYRjV3WWF2UWxH?=
 =?utf-8?B?M1V6QVpBTlFoV094ajB2ZFpMdlhxaG52M0dMYlpDcTU5c3JlZVBJb1UrT1Y5?=
 =?utf-8?B?eUtGSzFIakRoTnhIZEZwbTdZNUR5WVpIZHpOenVJZ05jUDRRSGJBdC85K01z?=
 =?utf-8?B?emFGc1N0QS96NXlsQmFjRm9jYk5IczMyU3lBY3RnSVE3WEc2WmdGZUhCcW5N?=
 =?utf-8?B?SmJTUjViTkZRZmxIbW1ORmJaSm9jaFVXbmN3MHZuQU9TQlp5MXZnUU8wNzAz?=
 =?utf-8?B?bENwQ05QZW44SFUwOGkxWTFqaEdxWmNObnBtT2Y3ODBTSGZRSHBid1Fwa3ov?=
 =?utf-8?B?NGlPWTZxV3ZJQ0lzMG9IOFZucmJJUm5OZXlYMjJGUXpySWlYVGt1QURiUVE1?=
 =?utf-8?B?WDBOVmk3UGpaQVBRcG1PZHRyQitHT3VCOUE3TzJxa3ZYU3pLckFLbXliOHJl?=
 =?utf-8?B?QUoyNTR6eERQZzc1b0h4aTJUcnQ3MDg5MkgvUVQ3d1VKelVxbExKZm84L0s1?=
 =?utf-8?B?dVlkckNGVkZ3RldXVEFzZHRjQVhKWXJOeWxGS0FjVm9sNFhHL083bTEyZUl5?=
 =?utf-8?B?a0RrVDZoL3k4VkhKbHdaUU1JZEpsQVJOSzdYZnJGQklOZytQNWVPSEJacTdm?=
 =?utf-8?B?YTJORC9URnFVTjFXRHVFN2NCWll6azU0VXlBRzNQdnorL2M5dTNBUnI1Nll5?=
 =?utf-8?B?TURVNXRwV2RKQmhJd0dyNVJDUDFWNXNxZnh0ZE1pWENldE5hSkJJNkNNQXRF?=
 =?utf-8?B?M3BGVkcvSjJjdUZUbStnV2xZallnVmkwNFFGMGY1OURldTRkcnFNV3ZrZGNS?=
 =?utf-8?B?ZzdqNFJPbWRpdUhDdWp0RUZSNGRFWTVodjRSak0wL1NIL0JOTkJyaUFHVG1s?=
 =?utf-8?B?am5aZUNKQys1eEIrNjFVaWN1YVIwTUsvZVFFdUV3U1J0R0VTVW9DN3p4QTg3?=
 =?utf-8?B?bDhkNFhNUkR5ZDMxZy9wbG9QbFhYVVFtOXVTdS9wQy9VM3F5WWZvVjJmd202?=
 =?utf-8?B?enA2M05rcmYvRElpb25mTXBUZFFSVCs5SmdsWWJOQmFkMEl0UHhQOXBpeTNv?=
 =?utf-8?B?cE5ORjJ1N1I4WW5pMXdNOTY3c3hNekR2SWpKZWlET0lRbGNqcFduSjE0ZXBS?=
 =?utf-8?B?S25jM1RvbEJzbmdqN0ZScEFyaVNKbFE3VVBmNTRJaENOTmMxcG1HZWh2TXkv?=
 =?utf-8?B?KzRDWm80bXRFOVdiZUlVV1VhRWNnRzJ1cVBsblhteUkvYWRoYTZ3UDFIRUd6?=
 =?utf-8?B?b3lJbzVYWjZnUDFQRHMwcFg0SGk0Y3l0RC8xVXlGNndpTUIvOWZFUXNZMzZR?=
 =?utf-8?B?aXNSZTdaS0FMdTlBQWt4WTRldjd3blBwSGZ3NFM3V2NuZlpEL3Bycm12dEJh?=
 =?utf-8?Q?Opa7+MMaGatdGYOZP/EADkKNK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23eb142f-c1da-4eaa-8495-08dcd976a575
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 13:17:58.7510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sw7gStL0S3bEFi56FzBanpJKmPXu785QWm87s/w0jOupLnMccG0H3s/htuUxkLjU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643
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



On 9/13/24 11:31, Padmarao Begari wrote:
> There are lot of device_is_compatible() present in the driver.
> Remove them and replace with a variables "SDHCI_COMPATIBLE_SDHCI_89A"
> and "SDHCI_COMPATIBLE_VERSAL_NET_EMMC" with match data.
> This change saves the space and reduce the execution time.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>   drivers/mmc/zynq_sdhci.c | 39 ++++++++++++++++++++++++++-------------
>   1 file changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mmc/zynq_sdhci.c b/drivers/mmc/zynq_sdhci.c
> index 28d2b456fb..24d0556cd3 100644
> --- a/drivers/mmc/zynq_sdhci.c
> +++ b/drivers/mmc/zynq_sdhci.c
> @@ -105,6 +105,19 @@ struct arasan_sdhci_priv {
>   	struct reset_ctl_bulk resets;
>   };
>   
> +enum arasan_sdhci_compatible {
> +	SDHCI_COMPATIBLE_SDHCI_89A,
> +	SDHCI_COMPATIBLE_VERSAL_NET_EMMC,
> +};
> +
> +static bool arasan_sdhci_is_compatible(struct udevice *dev,
> +				       enum arasan_sdhci_compatible family)
> +{
> +	enum arasan_sdhci_compatible compat = dev_get_driver_data(dev);
> +
> +	return compat == family;
> +}
> +
>   /* For Versal platforms zynqmp_mmio_write() won't be available */
>   __weak int zynqmp_mmio_write(const u32 address, const u32 mask, const u32 value)
>   {
> @@ -422,7 +435,7 @@ static int arasan_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
>   
>   	mdelay(1);
>   
> -	if (device_is_compatible(mmc->dev, "xlnx,zynqmp-8.9a"))
> +	if (arasan_sdhci_is_compatible(mmc->dev, SDHCI_COMPATIBLE_SDHCI_89A))
>   		arasan_zynqmp_dll_reset(host, priv->node_id);
>   
>   	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_INT_ENABLE);
> @@ -470,7 +483,7 @@ static int arasan_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
>   
>   	udelay(1);
>   
> -	if (device_is_compatible(mmc->dev, "xlnx,zynqmp-8.9a"))
> +	if (arasan_sdhci_is_compatible(mmc->dev, SDHCI_COMPATIBLE_SDHCI_89A))
>   		arasan_zynqmp_dll_reset(host, priv->node_id);
>   
>   	/* Enable only interrupts served by the SD controller */
> @@ -858,7 +871,7 @@ static int arasan_sdhci_set_tapdelay(struct sdhci_host *host)
>   	dev_dbg(dev, "%s, host:%s, mode:%d\n", __func__, host->name, timing);
>   
>   	if (IS_ENABLED(CONFIG_ARCH_ZYNQMP) &&
> -	    device_is_compatible(dev, "xlnx,zynqmp-8.9a")) {
> +	    arasan_sdhci_is_compatible(dev, SDHCI_COMPATIBLE_SDHCI_89A)) {
>   		ret = sdhci_zynqmp_sampleclk_set_phase(host, iclk_phase);
>   		if (ret)
>   			return ret;
> @@ -869,7 +882,7 @@ static int arasan_sdhci_set_tapdelay(struct sdhci_host *host)
>   	} else if ((IS_ENABLED(CONFIG_ARCH_VERSAL) ||
>   		    IS_ENABLED(CONFIG_ARCH_VERSAL_NET) ||
>   		    IS_ENABLED(CONFIG_ARCH_VERSAL2)) &&
> -		   device_is_compatible(dev, "xlnx,versal-8.9a")) {
> +		   arasan_sdhci_is_compatible(dev, SDHCI_COMPATIBLE_SDHCI_89A)) {
>   		ret = sdhci_versal_sampleclk_set_phase(host, iclk_phase);
>   		if (ret)
>   			return ret;
> @@ -879,7 +892,7 @@ static int arasan_sdhci_set_tapdelay(struct sdhci_host *host)
>   			return ret;
>   	} else if ((IS_ENABLED(CONFIG_ARCH_VERSAL_NET) ||
>   		    IS_ENABLED(CONFIG_ARCH_VERSAL2)) &&
> -		   device_is_compatible(dev, "xlnx,versal-net-emmc")) {
> +		   arasan_sdhci_is_compatible(dev, SDHCI_COMPATIBLE_VERSAL_NET_EMMC)) {
>   		if (mmc->clock >= MIN_PHY_CLK_HZ)
>   			if (iclk_phase == VERSAL_NET_EMMC_ICLK_PHASE_DDR52_DLY_CHAIN)
>   				iclk_phase = VERSAL_NET_EMMC_ICLK_PHASE_DDR52_DLL;
> @@ -933,7 +946,7 @@ static void arasan_dt_parse_clk_phases(struct udevice *dev)
>   	int i;
>   
>   	if (IS_ENABLED(CONFIG_ARCH_ZYNQMP) &&
> -	    device_is_compatible(dev, "xlnx,zynqmp-8.9a")) {
> +	    arasan_sdhci_is_compatible(dev, SDHCI_COMPATIBLE_SDHCI_89A)) {
>   		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
>   			clk_data->clk_phase_in[i] = zynqmp_iclk_phases[i];
>   			clk_data->clk_phase_out[i] = zynqmp_oclk_phases[i];
> @@ -948,7 +961,7 @@ static void arasan_dt_parse_clk_phases(struct udevice *dev)
>   	if ((IS_ENABLED(CONFIG_ARCH_VERSAL) ||
>   	     IS_ENABLED(CONFIG_ARCH_VERSAL_NET) ||
>   	     IS_ENABLED(CONFIG_ARCH_VERSAL2)) &&
> -	    device_is_compatible(dev, "xlnx,versal-8.9a")) {
> +	    arasan_sdhci_is_compatible(dev, SDHCI_COMPATIBLE_SDHCI_89A)) {
>   		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
>   			clk_data->clk_phase_in[i] = versal_iclk_phases[i];
>   			clk_data->clk_phase_out[i] = versal_oclk_phases[i];
> @@ -957,7 +970,7 @@ static void arasan_dt_parse_clk_phases(struct udevice *dev)
>   
>   	if ((IS_ENABLED(CONFIG_ARCH_VERSAL_NET) ||
>   	     IS_ENABLED(CONFIG_ARCH_VERSAL2)) &&
> -	    device_is_compatible(dev, "xlnx,versal-net-emmc")) {
> +	    arasan_sdhci_is_compatible(dev, SDHCI_COMPATIBLE_VERSAL_NET_EMMC)) {
>   		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
>   			clk_data->clk_phase_in[i] = versal_net_emmc_iclk_phases[i];
>   			clk_data->clk_phase_out[i] = versal_net_emmc_oclk_phases[i];
> @@ -1101,7 +1114,7 @@ static int arasan_sdhci_probe(struct udevice *dev)
>   	host = priv->host;
>   
>   #if defined(CONFIG_ARCH_ZYNQMP) && defined(CONFIG_ZYNQMP_FIRMWARE)
> -	if (device_is_compatible(dev, "xlnx,zynqmp-8.9a")) {
> +	if (arasan_sdhci_is_compatible(dev, SDHCI_COMPATIBLE_SDHCI_89A)) {
>   		ret = zynqmp_pm_is_function_supported(PM_IOCTL,
>   						      IOCTL_SET_SD_CONFIG);
>   		if (!ret) {
> @@ -1111,7 +1124,7 @@ static int arasan_sdhci_probe(struct udevice *dev)
>   		}
>   	}
>   #endif
> -	if (device_is_compatible(dev, "xlnx,versal-net-emmc"))
> +	if (arasan_sdhci_is_compatible(dev, SDHCI_COMPATIBLE_VERSAL_NET_EMMC))
>   		priv->internal_phy_reg = true;
>   
>   	ret = clk_get_by_index(dev, 0, &clk);
> @@ -1145,7 +1158,7 @@ static int arasan_sdhci_probe(struct udevice *dev)
>   		host->quirks |= SDHCI_QUIRK_NO_1_8_V;
>   
>   	if (CONFIG_IS_ENABLED(ARCH_VERSAL_NET) &&
> -	    device_is_compatible(dev, "xlnx,versal-net-emmc"))
> +	    arasan_sdhci_is_compatible(dev, SDHCI_COMPATIBLE_VERSAL_NET_EMMC))
>   		host->quirks |= SDHCI_QUIRK_CAPS_BIT63_FOR_HS400;
>   
>   	plat->cfg.f_max = CONFIG_ZYNQ_SDHCI_MAX_FREQ;
> @@ -1228,8 +1241,8 @@ static int arasan_sdhci_bind(struct udevice *dev)
>   }
>   
>   static const struct udevice_id arasan_sdhci_ids[] = {
> -	{ .compatible = "arasan,sdhci-8.9a" },
> -	{ .compatible = "xlnx,versal-net-emmc" },
> +	{ .compatible = "arasan,sdhci-8.9a", .data = SDHCI_COMPATIBLE_SDHCI_89A },
> +	{ .compatible = "xlnx,versal-net-emmc", .data = SDHCI_COMPATIBLE_VERSAL_NET_EMMC },
>   	{ }
>   };
>   

Applied.
M

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867CFD74961
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 08:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE61D80077;
	Fri, 19 Dec 2025 09:40:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fy9jzdG1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1442080FA1; Fri, 19 Dec 2025 09:40:45 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 786DC8003E
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 09:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqGuoYaJOxKD/FndvgEm12Aw0vJ/j8ZA5jyQ/cJwFTvvioXjctIlYHvx9toskd3uwhiTUK9PAPfLvUG/fQ4/7N7ZyOPvs1bhpCHMvhzpjoT0RTfdGns8XsNfTH4b+5A1HYkJ6/gkCt1mIX3QFyb6AsiTsXt5QW3Nk6kHvXUVRTEJE4heM7n3o0GSgUytEGvjyxiPyoLFMBac/3Jii4BbHr30lAu83gqRZIzW0Qv24TBFkyhvIBo6/uLwhkCLV3OscHfV0fFPIWfquApGZThwWigCMS0ujdTL2yd3ReDYsyuhXgJSHi2vxSfEa2T1uPpewMSHwiFE1ZEecVzl4MhRYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvKqaFO6h0r8520Ph38pnYd6B2rRtp66pAxnl4d9BF4=;
 b=ut6CopNmPvC48hkxo+dA/cXX1r1rlEngs5vbTyXTxAR4LPeDXxSRvkygqGG1J0+5dWsYEaaaI9c2T2DYcBxq+Zb8nMVh4QV2CrREKhC1EdJ4C280mSDn83ASJOvruw2zbzFZcVYjZSO9tj7ErI4BdcHD/uNoCHIg7Gp25fuW/GZIe7M1qQ/R/YHPsAJRbTnhiDSyyvMN2sV5FLypEXjVvl4m1ViXuipWmTnR+OOygVL1sI6clMT4ZYfpVdHKa7TUVgyNa1Qpn/DIZrHPudIDkCGd7YN6EUOW+oK0ao6H9x/kmHdZRRQWsFz1FsZLts0akjyPRIY0cPwoNjfOkHalSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvKqaFO6h0r8520Ph38pnYd6B2rRtp66pAxnl4d9BF4=;
 b=fy9jzdG1p8Rp+a7cFvBtcMi28Zk6Q7/BxKayM402ULZShrZtDX+674VKQHxClPNOxk+USXnOJnAfSWz3VltQs2/XQqsVeWm8i/I8gHwHpFiNTYWGyDjurQhs5qX+5Zv2dX4288ntTMLKA20DmmG3QwLWKCsSsQPbviZIj91evqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB7332.namprd12.prod.outlook.com (2603:10b6:510:20f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Fri, 19 Dec
 2025 08:40:37 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 08:40:37 +0000
Message-ID: <db2140db-8ad8-4038-af5c-9779e37361c6@amd.com>
Date: Fri, 19 Dec 2025 09:40:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] arch/arm/mach-zynqmp: configure default
 BL32_LOAD_ADDR
To: Neal Frager <neal.frager@amd.com>, u-boot@lists.denx.de
Cc: fabio.caccamo@amd.com
References: <20251217125107.1095397-1-neal.frager@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20251217125107.1095397-1-neal.frager@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0081.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::22) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c3eca9a-6c5a-464b-2f21-08de3eda4875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1F6ZjIrd3JaRHpjbVF5amNCbzFKbFl1TWdZNHBPVEJ0U1laTitjcHlMRnVH?=
 =?utf-8?B?clcvMEZ1ZGpmYUZTQ09RV1FrOXJ4aEJsR3hyeXBNUnRuckdIYXNsOWRmTXZB?=
 =?utf-8?B?NGlaZEUyV2J4cWhqR0dud1EzTWFjVmppSjJkaU1NS2h2MWtGSDBnZEhQZzNh?=
 =?utf-8?B?UjQ0WVZHMG5ob3cvY1VJNE1URTZsUkFKbDgwTFJTNXYvc0VDWUZ0UHE0M3Na?=
 =?utf-8?B?WEQzZjZQS3BNOTN2MGJIY1UxakpkMnBmRkpqNENtV2VEaGhGVGhZaVlyREo4?=
 =?utf-8?B?R0pCdGMxcVNFcWxhVFpTNUZqQ1BxaksyUTZBVE1XbEdkTGRpR095VWdHeitz?=
 =?utf-8?B?SlhhcE1oVjVINW5kS2tpVkUweWxmRlpQdzY0THc4WUNkZ2VkU3RxV05iKy85?=
 =?utf-8?B?cjI4QmVaQ1RPZ2ZBM2YxazQ5WmVKcGJqZUVJM3BhSXRKQU5Kb1NBdUs3bU5R?=
 =?utf-8?B?ZWxQcDN4TjdnQS95ZENMTEluVENxTHNaMGlNdXBLYk1NUUxvMnJ4VUREZ2JJ?=
 =?utf-8?B?N2xtTEphejJ5Rk9mbFMvUlZkekFURW56ZjlaOStjaEN5K1htZlZaYzNiOFJN?=
 =?utf-8?B?OXovYjlMUnhTUUtzb3Z2c1ZvZzhuamRmbi9BMGFMRVBFb2M1eDk5T0g5M05w?=
 =?utf-8?B?dzVHblIwS2lLSm9JVEsxUGVHcnQ3cjROTFBQNjd0TDZSMTBEMlo4N2ZpZXVq?=
 =?utf-8?B?TTRHekEyUmVjNFlRRHJvL2RRMXNLMFN1N2RqS2ZRdHBNZzFlYVFnUGszdW1k?=
 =?utf-8?B?eDhPQ0FuVkUybTQweC95aStERzQ3bE4vdCsvSDZlMFBndXZocTJ6SGhqK3NF?=
 =?utf-8?B?V3EyRjFERGF0QVp6MDlOVmdldUIvOHJqbitSZzRzc3FxNjVJQ3Y4QVlZMkpL?=
 =?utf-8?B?NjFMRHNTYU9oOEFWSmZpQWxJWUF1ZkZYYjZxcXhIaXNzSlpwa0RSWGd1a0RT?=
 =?utf-8?B?bWRCNDR0K1pyallYTDNUdnFUZE9OemhIWUl3NmRlUStncXdGTExFaFV5RzNQ?=
 =?utf-8?B?VnJHUkEyeUp4cklDVlJIcUVjQUNpSklibTZzR1kxRUROU0s1UjZDMzFYaCt2?=
 =?utf-8?B?a2daWDNVSzVkOSsrRkh2ZDZSZTJPOXVPSElYMWJ3OXlNZllZaTVpYkIxdUM2?=
 =?utf-8?B?bjRmMEhwblJSVjB4a25VY29sRml6N0V3ZXk5STlXM3BqcUd4ZFN3d0Rpdm96?=
 =?utf-8?B?b0QxK3pwbFI4Q3B5SjRCNjFTUUNWQjhPOXdqamw4UjlEckxEKzZNbEhqTnVj?=
 =?utf-8?B?Q0Eyb0pPN1pMLzViZGFUYjhQeVBjWXAwNkRLdmlJOHA1YXNHclVPWVVseUVY?=
 =?utf-8?B?Y3duekJCeXRMZUxMQ0RINmUzTGVTN2k0ajJxQmlDK3RadkNkYkFBaVY4Z09Y?=
 =?utf-8?B?eWthbm9IYWxFWU1WZEVIa3pWR3h1WStzeWF4ZWNpTFhpOWZCd3JkRTJPcEhV?=
 =?utf-8?B?KzBhdmo2Nnl2eDloUFlBSHhpMTAxZmVzNUQ3eHhGVFhicUY2bEZkcGFNaUZo?=
 =?utf-8?B?SjBBVW9ySlFzN0d3eCtSYS9LQlZObmZKbWFIWGV2b3N4RDZXS3hjUkdqR3VJ?=
 =?utf-8?B?WWxKdDdQSFR1Wmh0L0RGZE9INWo0TUdaYTROTEREMTZXWlhpaXVLN2RTYms3?=
 =?utf-8?B?SllBK2t1b2ZPTVdDWG04YTl4aGdrVFNSbmgxRzhTcWpER2ptYm5mMWJpWlFq?=
 =?utf-8?B?S3Y3ZkIxaDdQTGhnUU9Pa0ptS01jazZPL29jOVRtWUl4Vy9vZ3E4aTM3bDlK?=
 =?utf-8?B?ZlhPSzNxSzFaQjFmQXVycjR1UUk5c1ZRTTZSQTlGWGpIODRqRjI1OTlNMnpK?=
 =?utf-8?B?YndCZ0pPS0ZVWXJNUjR2Q2ZQL1d4LzBsS1BISWl4UWhieGtMV21rUkY1UHYr?=
 =?utf-8?B?VC9zdG1OT1k5ZjhpZmJjd1lPV0FuUlRFRHBIQXR6Z0dMNndyZjNGRGx6ZjNT?=
 =?utf-8?Q?f6/R0/z1WTo2tOIhWn4C7fc2YXMpp6xZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d001S1I2YzY4N01XNmJLZ0hkWkpQN0tCSTZaVDRQektDU1lJMjNrQ2g4b3Q1?=
 =?utf-8?B?R1VZUDN2ZkxhY213VFphVlFZeGFiODIrdkxjS1VhQ3NkcnF4bDF6SFFkTVds?=
 =?utf-8?B?VERWek12anNwc1k2Wm1KK3UrbC9XS0lHMUQrQ2dDUFRhWE44OUo2TjFRVFFL?=
 =?utf-8?B?VEkxYWRiTXIrQkpNa2dvNXNyWThVS1FpeHlscDNIbGJHKzdQaGpuS09QaUIv?=
 =?utf-8?B?bzlIU0M2S3R5L3UxN2t1Z2Q2a0J2bzdzUFZGQnZoQ1Bwc09SQ3ZrQVc1NkFZ?=
 =?utf-8?B?bllvbFVZN3ZlTUlDQ3JZSmZ1L05UWVh1VGNFTWErQW83TmlQTmljdnZkNlZM?=
 =?utf-8?B?UGR2azVsOFZCWUphOEhZYjBxMW1YR05DMlhkK0JMOE0ra0lnTTNWdEpEQ1Bv?=
 =?utf-8?B?SVNLdEtkZEo5cERTNnVQVDdweHVZWDZGWmxlcExPQ0FUcGxQZEh2bzkvSUtl?=
 =?utf-8?B?K0xyNzhZMnQwVGc4L3B6ZDVVZlZSczdYcnVlWDJLemhzVEV6UjF2ZG8ycVJi?=
 =?utf-8?B?V0o3ZTlFUENLVVJTbFNBK1plektzWkhuUGpBUWJZMEdBT2w0aVA0dEVTcTBa?=
 =?utf-8?B?cTFUZ1ErR0syVEpFbm00b1BQTXVyNDB1SzFxM3N5cXppS3ROb2I0Y29OSi9K?=
 =?utf-8?B?SW9VQmp4NDJVZEpRZXBxOXBMZjV0dTVmakJ6UkdPR0RkTkpBSVAwSGpibjI0?=
 =?utf-8?B?TFBFVjN1QUV5UXpQei8rVGMwRnl0OS9RM20vV25ZQThVQ1pEbTdBaEc3M1Zm?=
 =?utf-8?B?UFFXM21tTmR2RlVUUHpUejBQZC9vNkhZc0hzMlFqNXVrTmZvbGY1ZEloWU1L?=
 =?utf-8?B?aXVxSTdvKzNjK3NlR29nYWU5eXdXZXpMcXdBYnFZRUVDZ1htRW9tQUtSNkNx?=
 =?utf-8?B?Z2lmU2djcDJyVmczSlVjT0xRM25yVXRCL0lsVm1CVTJpaWxPZUpZNTF2NklB?=
 =?utf-8?B?ZHg3SUNZait5SzlCSm5wRGI4WDFzZFJYeUQxMlFybVUwWDd5TGJYdytrNXRs?=
 =?utf-8?B?b2VDbTAzVlFOdHZTdW54S1dEeWxLSlhFOWZwOERKNWF5ZlYweUh6VXh1MWMw?=
 =?utf-8?B?ODNXeVRiS3NpT1hRMTBIQ2ZMdDhjSzZKYWRYTEdjVFdpN2lwRWs4dGlQaXBp?=
 =?utf-8?B?dDdTVWVzbjQ2M245T1RabWdxeElHc2NiMEw3N3d3UVQ4S0tubnpXQ3dDTGR5?=
 =?utf-8?B?NG9oZWJXNEJLOW51TWZKSlFVMzNsaVZveGpzcXEwa2tpYnRnbGhPaW8vaVM2?=
 =?utf-8?B?eGNJTE82SkNkbks5dWRFaTlaKzhIUFcydUFPditQTkkzZjhvc0ltUFJKa1BR?=
 =?utf-8?B?SkxQRTZ3elBYODZIM25uMmNuUUdlSkx0SW5WUityOFozdzVJa1p2WkhYdFgw?=
 =?utf-8?B?QVB1Vmp0T0ZOeFpndzF1UUhPeHRTUEpheHBQb0tsYzhHVUwxQmhIY1FQQ09o?=
 =?utf-8?B?SnBCa1JNaUxIVEEyU0FzQytaOENKY0huSTdHSSs3Tm1WV3NXWHZRQ1V4bFFB?=
 =?utf-8?B?UUxCT0FpeTA4cFhmOGZPYkRDQWxtRXlCa2ViN1RVejlSOUxVS2ozSzU0Nlpk?=
 =?utf-8?B?ZnRnNUtCcFNxOEN6YTRyRFhsNjNST2grSTU0aUgwNU9GU2VqZE5mbXR3SEZv?=
 =?utf-8?B?NmpqVFhwcHBmclZBQXVxWVpQTVVGU203NVY5ZVZOZHJBVUlvNVpKVEhwYS96?=
 =?utf-8?B?ZGZJTFNQZkNqYjFlNTN4dFJGMXZETTBhZnRmTTJvS1VmNC9lVlBodTNZeFZR?=
 =?utf-8?B?QTQwQm5KbzRlWEhVRmpVRmlWLzB2Y0R4NGNlNE91ODQwazJ1bkd2YmRPNU1L?=
 =?utf-8?B?ekM1UW16N3pKYTBPZ0t2cFlNWk0vOVBWajVHU0VhS2RPcVRsWGpLd0lUUXBi?=
 =?utf-8?B?bHJrcHMwa3VkSU9lM01HOXpRUm9zSzdjNjZFWUlPMlNiK2t2ZDBSNEp1eCtE?=
 =?utf-8?B?amxUNHBKYXVXdTYxUDYzL0QyNWQ0Sk5BSW5RbktQdWlZZXFSejlpa1h1OW82?=
 =?utf-8?B?VFhCZUhpZnlLdjRaV0V1RlJzUDZjV09xMXJZTjZzbnB0Z3RQL2Jubm5oWVZS?=
 =?utf-8?B?K2NDR3JGOFZTYVZIVENNV2lSNS9GRkV2cnU0clZHMHM1UmN5UENJQjBOM3BM?=
 =?utf-8?Q?8CZ42aJiWRADeHD1kFFGE1IvC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3eca9a-6c5a-464b-2f21-08de3eda4875
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 08:40:37.4912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7vzqqPYl4MBEQpIGgxfW8/y6/TDYfkf2tb+66/DN9ebJXiQkfsH8Nd1UYAIWcOa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7332
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



On 12/17/25 13:51, Neal Frager wrote:
> The default entry point address for the optee-os tee.bin for the zynqmp
> platform is 0x60000000. For this reason, set the default u-boot BL32_LOAD_ADDR
> to match the default optee-os entry point address of 0x60000000.
> 
> Signed-off-by: Neal Frager <neal.frager@amd.com>
> ---
>   arch/arm/mach-zynqmp/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-zynqmp/Kconfig b/arch/arm/mach-zynqmp/Kconfig
> index 151cfada436..8a4356bc060 100644
> --- a/arch/arm/mach-zynqmp/Kconfig
> +++ b/arch/arm/mach-zynqmp/Kconfig
> @@ -138,7 +138,7 @@ config BL31_LOAD_ADDR
>   
>   config BL32_LOAD_ADDR
>   	hex "Load address of BL32 image (mostly secure OS)"
> -	default 0
> +	default 0x60000000
>   	help
>   	  The load address for the BL32 image. This value is used to build the
>   	  FIT image header that places BL32 in memory where it will run.

Applied.
M

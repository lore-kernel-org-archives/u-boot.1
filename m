Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F75C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 13:32:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9B3C88271;
	Mon, 17 Jun 2024 15:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xvNk63oj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89BC38829B; Mon, 17 Jun 2024 15:32:46 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60F6E84374
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 15:32:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEgyX9DGN0Y+oY6vT/UqtdVk9/w4pagQZC0hY23nGzUYmtVAIyhY1MQY9+DUNOQ+1wVfVlJtxhbuWwoSbkLhuXafraCMTuq7eb6ODeANs3HUidjC+ycrGQlsrfKUHZ/7jKVhL6W/oUQNe+J2gQKbANkRln9htu/CYrYJm3iUcqbOivWe/h5YJuHcWCxwmOGa6kHEUg4Al4c/81vl5HJYMvlpp9qwesvUqVAeDQpX+/3ApF2ur4fde6V96kqJiqJJ0QZ4YEGI9ZEzR9K3PqHhOPzzdIVjTwAqRwjboOnQ6Yab61tVHsKtjJy6j7hQzjuTW+ZF3S3D9PHYGIbdIHszBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xMueFFjuMwbDR0SWG/LObFE+V/ciomcngCQyspdDS4=;
 b=IxzkfURweGfuNCAqJwQrKsphIsKwoeOwLPuEck+2+TaL2KjX5TIVfQGC/40UCEFNiafp7ak4MOh2vR/RuUOO+k8LpjwCLIeJSyRDpg1xxTRX5iToQ+fHJiwPLANxSeM3RzW15oI71xfqtnxkFkEXyarIcripEdueaIyP+Ytb7KKn7h7qvZTUeIwjnKIIk9xe1lbZroih+J1ekAs0cDyzzrg+uzZTg0nYWgOHodbH97qn/h2A+Rjb973D4neDWYBh9MDVplLOGjPMEVK4748xTEG9KEmJN6ezn76a3wmgEse0ferb6Zlz+VH7cfXZy+BFW5dU7njq7AHFyzxarZV20g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xMueFFjuMwbDR0SWG/LObFE+V/ciomcngCQyspdDS4=;
 b=xvNk63ojzhnGfr67nUDxb0dClqMrldxPV3ZYy+xfGuoF2cihEh+XC/wWoZTVRsZGvsjBtF+U36cErDVQRtoIx54/q122eIP8TRpq3G05XsG7ijNfi+KF7F7is3p4JdX43MiJge1muqPNax0dlWJ5ciFkd5tmPtIOtXkxuFV+Jg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN0PR12MB6344.namprd12.prod.outlook.com (2603:10b6:208:3d3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 13:32:40 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 13:32:40 +0000
Message-ID: <896b1be1-b5b0-4af9-9d17-bdaad049bef0@amd.com>
Date: Mon, 17 Jun 2024 15:32:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: versal-net: Add env redund offset
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20240614125110.23058-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240614125110.23058-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0059.eurprd03.prod.outlook.com
 (2603:10a6:803:118::48) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN0PR12MB6344:EE_
X-MS-Office365-Filtering-Correlation-Id: 7542327b-9e80-4b12-b0d1-08dc8ed1f5ca
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y09MNUJPWkZwU0NzUVVoeVI4YVM3QlVNS01FUk5MUXd4Y25taTFsUmNrME11?=
 =?utf-8?B?OGVzMmhHajFkemtuaUM1Q2lyZTU0YklsNHdSSXZHbXRjN0VTQW5wUHBBaERE?=
 =?utf-8?B?RVB5N3dCZFY0WnJnVjBpUnJFcDRkQmQ4cHpuU3FkUjVEck9tdHMrMzE0dDVt?=
 =?utf-8?B?cDZuVXZNb2hYYU1TcFNJR3lpZkJtQWliNTJ4ZGRBVG00Nk5GV2psNEg0cWdn?=
 =?utf-8?B?U3BSMnk5ZWdUQXFlZjFSL2k5UUJ0M3hBcDg5amJzSXdYVzZqRXN1Z1MrbVdQ?=
 =?utf-8?B?bXNHOFhwVnBWVEl0U2kyOVNuMWZHNWdibE9RMXB2Ulp4L1AzdDFFWTZBc29X?=
 =?utf-8?B?R3B4dFFzck5LamZCMzlJNWtsVFVoQzcwQWEvUVQxQm9jSklabmkxNjRyNC9k?=
 =?utf-8?B?ejhmRGRoaFppMS9oZm4zaUx2V3krbDFMeENtK0VZSkZiZ0JsNTBndEZPQVc2?=
 =?utf-8?B?RzdnUUdvMFZ0RE5VanZFMXFBLzR3bWgydTBJRUtCeTY3M2dkSnhqcFhlcGpT?=
 =?utf-8?B?UWdpUVFQN0dwRjN2RnJBc0lZMkRJWS91UEpablAzSkl5WWplMXlWS1NJSE5C?=
 =?utf-8?B?WmlKZW1aU1JpeHVpS1RneVFRWEhJNGZCc2dCVzh1Y2tkZUxrejFqNmQvWlpx?=
 =?utf-8?B?Y09vM1J3TzhrMjJSckJGTjArWnRnbjZwWHJIS1BmTm9lVGN4Yi9IeVNMdEtV?=
 =?utf-8?B?Q0JueHQ5cVZiZFNha29Gc1NOY2h3alhXOGJJQVNvY1hLK3ZLanhjQ29OL1pW?=
 =?utf-8?B?ajFleGh6S21OQThiQTFHdEU5Vy9hM25KMXVFd0s1bjFCWnFvd0ZqQWpjbHM2?=
 =?utf-8?B?ZUNwVzN4eFNwY21FRGhieHJyMGsvTGV1eTFrQk5VamhzQlZVbVY5blREaTYv?=
 =?utf-8?B?WDdiWWN3ZSt0KzVOWEJjYW1QTnpybWVWa2RGMVdxQTlydGVjUHZIakVsL09C?=
 =?utf-8?B?Qi90bDBOcDJyNVdJWGZjd1BIMTBpbURXcHVoYTdSWlF6enhOOFlXQWY4SWxj?=
 =?utf-8?B?MlpmT0IyZnU2VjBHcC9zYit3NWxrOHNsbElxRjNINjlkSnFOcFk3V3BvOXZU?=
 =?utf-8?B?dklsVjhvWmM1aFJ3SlovVm9XU05sWnVoWEtxV1E0V0hRVHJiWlYzNUZXT0Zr?=
 =?utf-8?B?Nk41cWdBMlcyQkttZGMyL0JaWkJVWnhyM0Z4S3pWQ2JHQUxFMisrb0hPM3ln?=
 =?utf-8?B?aEI1akwydXBwVFRTYnlNdmdhVzdlbW84bFVRMkZ6d0dteCtPUk1ibGl4UitU?=
 =?utf-8?B?T0NyekdNZGZDb0RHaWRnWGRMUW5pSWJiOXRnMm5DQ3BGTzcxekdCbkkyMXBT?=
 =?utf-8?B?VGZwSlN3MDhXdEhEalYzY0QzS2pXdXp6aGwyZU9NR0lScTVBK3oyeHhxUmY2?=
 =?utf-8?B?N0hWUHpGaUlZdEI3OFI0enRrVXgxUkt3VzMzNWVad1ZscXdIQmVPblRlZWFt?=
 =?utf-8?B?M1hPcmEvVWtRbXFnUUZqS0l6YnJ2U1F6czNYbExSc2pvdTQwNDNSSnBsRDcr?=
 =?utf-8?B?UTdnNS94V1BySEtzVXMxSGRxb09MN3FUQ2RNR01Iekk0cjZ2dVFtR2tRMnF2?=
 =?utf-8?B?TGFZOVIvZFZmRWpLeFZqN2FuOEVBVkR2cFhJRU5sSWRCWENYTEtvWi9oQ2xV?=
 =?utf-8?B?N0NxMUdIQURZSHJtbGluR1R1RUpoQXhMd2JGbUZPU3VWckNrUll2dnY2QXZF?=
 =?utf-8?B?TlJHQUZrdVZpaE1MZFN5dHVqc2crRXBPbmJzY1NCOFk3NXpuS0J3b25LRXYv?=
 =?utf-8?Q?r4x5qs7b0DXSpzEnwloHgNJd5VkhHtK60PXYsNH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YllNM1RIV2JwMTBmWmdGMDVlODQrQTQ3MWJMY2wzRXk4UWZYeHlWYkVib0JU?=
 =?utf-8?B?RWFlOGtobXBKSEZmRWpNNnFqeWpweXZwMzB4QmdqbTZ6OUdscHZmMjhVQ0lK?=
 =?utf-8?B?VTlneFhsSWFyNllWa1BuQzZrbnM4RFRVNXljRVVyYjd5aU40dWVmNVB3aDhE?=
 =?utf-8?B?UFVrcERpL0krV0h0cFhoa0t0OTR2MGhZb253MmpzUkg0SmFCOVJoemNXUGZQ?=
 =?utf-8?B?Q1d3M1hBWmk3QnFnbzgyNHJOY0MwVlFoajN5T2ZzQWdQb0VuWkxPQmRkanMz?=
 =?utf-8?B?Y09zRk0zUnFhcHZRekEvaml2MWNTWlZ3QVhuMTQrZGdDTEtFUXlscHVUblh6?=
 =?utf-8?B?OE1iVzlEOEVmVStWWHJhRkJ2Vk5VMzNyMC9xalhvajRvV1VUTktSQ0dyS2xm?=
 =?utf-8?B?U085MUt4cmdFMmpJb2tHVURuQlF1OXVwMW8zbjdNRUpocXdCcWFDU1RIUjlQ?=
 =?utf-8?B?K2NVVit6Q3pVOEkzbGdTUFhldUxiTUNGaE9OR2pKNkdIWk4xY1htUVBmMzVo?=
 =?utf-8?B?d1hHMnE3ajZmUFYyTTRQUHVsZEFzWkEzc1hwbjZhMXNUTXdWbkcxS0IvdnJX?=
 =?utf-8?B?SEt3bEx1Q2NNZjc4WnNrYTNPZFl5bXRCY0FkVzhpc3A0WWkxMHQveW5DcnhI?=
 =?utf-8?B?YXc5LzhoSkZhMExyRFg1cVZ5UnVEY1FHL09WdDU2aDBJcVZ6MncvcCthallh?=
 =?utf-8?B?amRnVTVDcG84cXdTalVNaEUvRmdzRjNhM21HNVdyaUZBckdyNmxXbkZBQU9w?=
 =?utf-8?B?ZEdSQit4MXo2TEtDQXp3YWJwRTN1TWdmWGk5b1lpbnF6SENvQkJNOXFocHBh?=
 =?utf-8?B?NEFjVEhpdytqM1doS3E0WE1JeVJVdnl4b3p0ZldweDVrYS9aRStkNitqK3RY?=
 =?utf-8?B?LysrdnoxaDlIVUE1K1JtaW5RM1lWMTM3dlAwQVhtWkhHaUROcFRXUEJ2dGFL?=
 =?utf-8?B?Vk11Ti9TcDdLM09HeGM3R0UzNmZERnZzUmpSMlJkUFZUYnVENkFSTTBUSU44?=
 =?utf-8?B?VEd1WlBOOXEyUVRmcDN1U09zdS93bm1kVWZ4MTRWUWJ6UlQ3TWsyRUR4OWMy?=
 =?utf-8?B?dTZST2Z2VG51aHJxdCtQOGV0eW0yQXhZcEZ0YWgyQTB6OXFRcEJ2alpLaHNZ?=
 =?utf-8?B?N1Eyd0pmd1Z5ZW0zUHBFUm4rU09SeTFVN3lNWXRPajkxWU1uR0lSVEtDNS9z?=
 =?utf-8?B?Y2FSMXJGSUIzell2dnhtQU85TFpQM3hPd3g5TVBiUzlEOFZEbHZsSVN6aWhJ?=
 =?utf-8?B?Q0ZFVXpaS2UybGIySkQ1bVp2TlRZQ1ZPVDhKZTNjY2ZFZzlPOVNDQ0ZFSnRE?=
 =?utf-8?B?MWlSSys3TTJCVXFXNVpOcjkvWmQwVVBJd3NHNURaWVhWa29wZzhsd3QwVmU3?=
 =?utf-8?B?bm5teVlTeTJqeWhocGNvWkdvYXpvNkd6UFFXdnJwR09pN2pqRy93RDZ0VlRa?=
 =?utf-8?B?dk16dmJlUE4yWllVOEFFczJoMDR5eHVOTUJLM0VUZHQ4Nlk3cXdDNCtEV2tT?=
 =?utf-8?B?SmtWcW9CNFZzOXoxRXZRSTlPcURLTHgwNCt4Y0hrbWRnWGVGMHBCelR6bjQ3?=
 =?utf-8?B?MkNQV29LNklhc09xRDFiMWZLczlVVUNNVjl0Y293QjNMOUlTZE5LeWZUK2s2?=
 =?utf-8?B?RUxWMzFoZUgzK0RPVkc3SnUwU0EwNVlnaVEyR2dVS2dOYzhjUDdISElEOHBT?=
 =?utf-8?B?NTdaYWcxcm9jNXdUSkp3MDJmUVdhUXlteGVYTkd5eVBXb0hKOTR1dzBJZXVp?=
 =?utf-8?B?bGQyNXNiTURlbW5QMjRRNkEybzJZREo4Y2JTcHViSDE1SU5ycjFEWUJMbU5w?=
 =?utf-8?B?SE9yc1pXNXJVbVJBVy9vbHZZVVJRR2Q4OTFpZGJSSVlNbkVnb2g1aDdmODlv?=
 =?utf-8?B?cjZHRW04N0d5ZncyYmNQeHh1SzlGVVJxdzZLVUt2aGJucW1aaXBnTkVXVkZw?=
 =?utf-8?B?WTlFajFOakNIWXF0MU13WmtaczlsUzlYUU0vbXZRODRVQkZkZzNDUU42U2Vu?=
 =?utf-8?B?d2RvbEY5dDVjUUlSaVdGTEpwSWJxUDZ6K1RJblFLUTc3MEJRRm4vOVZqZWlo?=
 =?utf-8?B?bGI3Q0Jpdms0cVNoS3o0VThFZDNSWEV4MHU2RGQxcUppUjNlM1BqSWt3UXJC?=
 =?utf-8?Q?QLHXXCP4AiSVopL6wlgi9DDFx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7542327b-9e80-4b12-b0d1-08dc8ed1f5ca
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 13:32:40.3566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Hy78GsrKqBXMfFX9vRktzJEOILetDmB85S/G8FSE1RLUwiacC2DvBne7RqOXE19
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6344
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



On 6/14/24 14:51, Venkatesh Yadav Abbarapu wrote:
> ENV_OFFSET_REDUND config is by default set to 0 for flashes.
> Saving the env variables is overwriting data at 0 offset,
> which is wrong. So add default redund env offset
> ENV_OFFSET_REDUND at 0x7F00000 for Versal NET platform.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   configs/xilinx_versal_net_virt_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
> index 40c6a29a16..289f27cdea 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -8,6 +8,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x100000
>   CONFIG_DEFAULT_DEVICE_TREE="xilinx-versal-net-virt"
>   CONFIG_OF_LIBFDT_OVERLAY=y
>   CONFIG_DM_RESET=y
> +CONFIG_ENV_OFFSET_REDUND=0x7F00000
>   CONFIG_CMD_FRU=y
>   CONFIG_SYS_LOAD_ADDR=0x8000000
>   CONFIG_SYS_MEMTEST_START=0x00000000

Applied.
M

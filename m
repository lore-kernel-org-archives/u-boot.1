Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22A9C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 11:36:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BAA682E26;
	Wed, 16 Apr 2025 13:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YPaYt7Fs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B857582E27; Wed, 16 Apr 2025 13:36:10 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94DBA82C96
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 13:36:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPd2nuZgexx4tcld/U7YsfZE/JIH+D30uBqqMjz1p35qunZ6FeWhSrT6EZbJ61HH6dlu7iLTQXMeUTNJ0GiSYgxvM0+Ne66hNZDMUlb7LlrwQGN87vanyWnvVJpxukUrAZLuGsktuLkzc2taSljcaiAqGclJ3hmx33/6Zzz9GEIq6ynRxAZdC8L80r5i9SXuPZZKXr4MfjqTnm3mQY7CwXVl4voP5vN1trYnJoDqb2HJCL0ZWJaZrJTecB+tWiZsjiFLhoF+TRHowEhf/31sVHecf8GIV6RQk1rs2YPvPta+l5mx5hW8DhSTO97PdOjEqQ93oYS4FSLAMHLd+stKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vq0sZSTiD9SgS4FL/l9si4FA4icY/+d61nsNxiAJBJk=;
 b=VKtDGO6UUB4RzJjpk7L8x9VUkyFftotksoDA8gKPSMyRGqsBvTgrT1Om3KstjvDKaeWUqco5Ydc5nyqeN1JVh9DGkwTE2MOu5UijtFFdF1NeA0BBrTkFJgzOgvo42rosD9T5fsQD3G987rxDQSROMIGE1JnvhcXZRlFOqK6GB8i+ltax5zQS+RogVpij68Izpmx71eE6CyWwZCFXJ8tu7ix/vpZecfWB8eH2UAH1jUii5qjbBCVTqVIiL8C6/GIRROLuQofDjBY6DgbzfaBT+EkqZIcpzGR8pLtXpDsY2NYDqcyi0YBKou6DSucUC8U1LEe6tLDv/ZL1yiFB99rvMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vq0sZSTiD9SgS4FL/l9si4FA4icY/+d61nsNxiAJBJk=;
 b=YPaYt7FslGjAgLmbdV9LovakR2HysqWA9ghVpyqLVfjHvdwaDtpCBjQg/edjnzDbclxx5S+RW5dQVTP4BaHcnaNSlh/lN2hU5ckl+czAOyoL9+uq8VkWVRJcEPTobGCy4/CDRqE+HJO71psvXGTgOR377zgUMdVxLqPvUyV3M2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Wed, 16 Apr
 2025 11:36:05 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 11:36:05 +0000
Message-ID: <401cb6d0-dd47-4904-97e2-da100444e0ad@amd.com>
Date: Wed, 16 Apr 2025 13:35:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Free memory when variable is saved in
 boot_targets_setup()
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <fa10fc22193a1a23258466056b3d02f7496fccfe.1744270729.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <fa10fc22193a1a23258466056b3d02f7496fccfe.1744270729.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::6) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc60515-d269-42d2-a216-08dd7cdadfb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZE5wQ2RyZE9pdzFXaGl0Q2ZmWEEvOUhUcGR3RlRZYmhjcThBRWdRZXVOTmRI?=
 =?utf-8?B?WDV6dkR3SkpNUTk2QzZXSU5zazQ2SURvMCswT3dUeC9mUkFyTDZxZ2dxUHJm?=
 =?utf-8?B?TG5ETTVPUUtYeHJXMVlMR2QzdWNXZStxNXRLZnZQekZ5VzlxemFNVXVoQ0dH?=
 =?utf-8?B?TnU2OXdsRDhTN1BZblgwdDNBR3V2UFp4cENIZEliVURPTmR1dUswTDVBVStk?=
 =?utf-8?B?YWNQTVRLZjZJRnpRUGQyZTMzVHQwOEcyTTFCMWs1RzNVQWJtakhyL1NqS0Ja?=
 =?utf-8?B?ZGg1WjViU0FuWmlrTXpWc2FTNUl4OEVWVjYxemg5NndzZS9zdkg3ZXZhdVNI?=
 =?utf-8?B?ZVY1aU5kSExtcUZRd1AvSUI2ajVrUnE0czlKRTJlUGRua2lOK1d4Y041bW0x?=
 =?utf-8?B?YzNJZFdzSlRoT2ZoRXRTWWFxdXNjUzVLVktxSVN2RXFjbHZVL1ErTURiTkJZ?=
 =?utf-8?B?YTZ0TjF6R1p2N0w5MzJ2cjkrS09RUUNsdW5ydmFJMHNyZk10emt6LzFsR2tG?=
 =?utf-8?B?OEdQTVdmQndOZzRoMzVPWE8xeUZUZ3V3Y0RDVjRsWUtWZEZoeW1EZHYrYVQw?=
 =?utf-8?B?TkRYSEUySWdrZklKZUtQQUwrWExST3RTazNUOGhxdmdVcDBoOTR3SGJTT24z?=
 =?utf-8?B?N2VodFZKbjRScnVoNE9zeUVsVU9meUFNTjd6dytjZ2U4MnFkQjlqcjlUb0xl?=
 =?utf-8?B?c0k5eWxEQWsxeWkvVEkvQnU4V1dJMFJUY1lqdjZRUDN0RmE1Rkd6aTdBaWM3?=
 =?utf-8?B?dGwvd3dTR0svKzM2SEo0STlNMEsxbmJXTXFnZEwvSkRXM0JWY2FBeHJRV1gz?=
 =?utf-8?B?eHpnZ1N2M3gzS2dta3AxVHpkR0txczd1S0Nrbk05eFBkQ3o2OWdIYkJpVlR5?=
 =?utf-8?B?Nm1NcVFWV2w4Q0ZJbndEWUphLzFkcmJJNDFOMy9mR1lQU0kyc0xDTTRHNjNu?=
 =?utf-8?B?bWhzL1Bxdktnd1FQUWZUOW5VUS9PV3lRdEhPSlg2dHVmWDZHVWprY1lkMGE3?=
 =?utf-8?B?ZTFsU3dQUkdTTVh3ZWJDajIxMTI3S2l2ZGhYcU5UZ3RkZHc2RmVGSVlONE1R?=
 =?utf-8?B?OEl6ZWFaNldvOVlNd0FyU3RaQ2tBOWZnbUROSVFlY2dDbFpUZkthSzlTWUJW?=
 =?utf-8?B?WXIyVlI3amp2OUdVSExKYTYzSjBHbHFjemdlTEtldURqTjVQRkJ0VmYxYXJ5?=
 =?utf-8?B?UnUyQ0MvV21iYjRpY0tsbm5JTWw1ZHFoNEVBZmJ2c0twNVc3UkNXaG0zQVhD?=
 =?utf-8?B?MzRGMm5Kak1ueVlLMldDV2JiMDJ5RVJiNXhvRVR3WjNrZVJtWEQxcnpDcUFU?=
 =?utf-8?B?WDRRajFxNUY5YUZGbFkxUTN4MGMxUDJSMXMwQ3NxUHJLbWdRTEN6RktRZytE?=
 =?utf-8?B?TGx5K1pua2lvTmpVUnRsL0FXY2I3U3pMYjB4TDJCV28rQzA4VnROWjNTa1Ar?=
 =?utf-8?B?TThXZjdjOVU0QzcvZEVGSFhmRUwvVVNLeEJnTy9hb0hmUnppaHZwdm1oa091?=
 =?utf-8?B?OTlaQ280OThONWJoVExReXVPUVg5VFlLYmJWTmRybXZUemZ4SHFPeGIvK0JS?=
 =?utf-8?B?bGNWSW11dFpkTVJlcVhZa1UvczgvdllGdmc1bCs5ZVEwRnlxZC9UTW12Qk5o?=
 =?utf-8?B?eGxKcC8xcVZXRDNFdzd4aGd1R3FtYm5lc2NiN291NDhTMUV5RkE1YzdtMDhJ?=
 =?utf-8?B?dzREUTA5VDdwNFZIdHVhZXh6YzJUVk0zN1pValVjUTVvQWVJRlRjYXphSHpQ?=
 =?utf-8?B?T0REZno3dFBFd21Da0J6QlJBVDBjb0cvTzBlWEJwQnlLVWZwUTRSTE1VelJ4?=
 =?utf-8?B?Ry9vTW9DVTZiNHZQTjNzT0tyeithTEN1NWw5dDJoMlhkSk03OGUza0c0Y2I5?=
 =?utf-8?B?YXg3MENVMnNyQ0JtenNUT1hJUE5raVRycktTVjA1YWw4eU5aZ3dzdWRMMDJT?=
 =?utf-8?Q?Qd6psbm8MX4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG90cXdOS1hpQVVwbmE0TEZaMmZPS1Nja21ab25ZaG83MGxUR1pNVlR3V1dz?=
 =?utf-8?B?YjcxeUFzSGw4c1dVK0FGMVZZM1JhRzhHcjJRbkpYTVhyc25RT0RyS29rME9v?=
 =?utf-8?B?Z1NsUzlTSEFuckpDa0UvbGFyZisrU285a1ZzL2YzMlFBSWNGalRrNE05dzNR?=
 =?utf-8?B?alQ0R1JxSjJaRFRFWko0eWh5ODY1aC9iUjBDaXc0bHRkQk5WaXJjUnZWaldB?=
 =?utf-8?B?aDIydGxQQ1lleUYybFFlSmRVSkJVMm9DNk94dEtiUE4yWnczWHF3QTZIRGtC?=
 =?utf-8?B?bS9VaTQva1ArNTVhMlhPd3RPNGlOakpSQmFxR09UUFNaZmRURGtCQ0lFU0Yw?=
 =?utf-8?B?WjlRR2U2TmRTQVpOektZZHlFcWVQNkFlTWxnSlJ1cGhZdDN1eEdXTE1pQXNx?=
 =?utf-8?B?aWtYL0U5S3E1YU5IOU9HQTltWmR3Tmx3UllJQmhxemozdmkxVFY4QU16Ui9u?=
 =?utf-8?B?YVppMU1CZzhMREwyTHY3Rm1Ua3JtR1hEY0xDSUlPTkhsOVppWm55MGpxbENo?=
 =?utf-8?B?REYrNGJVdW5Nb2ZNdzdweEg2empWS2IxKzVjaDljYzdyZVMvZG9nemtLb0Fh?=
 =?utf-8?B?enlqeFBvUkVhLzFYTXdFVHJvOHd3MVk3Vi8xdlBibHVPZEJYcXErY1JlOW9P?=
 =?utf-8?B?RUszWnMreDRvZ1Fpb3lDOGZMRGFwc2diemdxUEc0dllOMEpqZEhSVTVGNjI1?=
 =?utf-8?B?RHFrYVllWEUzdWFKcWxUQy9DdWZ4aU9HVXM2SC9CaFArUlJQQzFmb3VKYy8z?=
 =?utf-8?B?U25vaDhFUktoRWZjSjhNbmZFNHBSSllJUklFVkhjVEZ4cjYzdDZJdFRhZUZy?=
 =?utf-8?B?YzV1UG5WVG5xV3BEV3JUczZEc0dETyt2b1dTcDlLRllHbnR6WTF4aGRDUHh1?=
 =?utf-8?B?d3I2ems5OEYweW55TkNvczc0SHpzMTdxWWtuQVY4N1FLa3JWZWg4L0o2dm9L?=
 =?utf-8?B?bGhFTkUrN2IzUEV3RGROQlVrcEhtN2FyYURmL3dTVmNNZmJXNjM3NlFXLzNV?=
 =?utf-8?B?Q0VEeEwxT3J5ZDd5dlJGc2kyV2svT3M2WE5pZmxIWDJzUVArNlRFRXVyTXZZ?=
 =?utf-8?B?VjY3SnJvMUlackVpUUxPc2ZTN0V2ZUdXdXNpbXR0Zm1Rc0d3Uy9WSXd2Nk5k?=
 =?utf-8?B?N0tneDVsdEQ5YlQvTEFqMHVzKy9HbUFvN01tNEpUZVpvMS92MXFSZlJlWkpX?=
 =?utf-8?B?bWVMdXR0c0hMSmpQc2JNbUoydXJYN3ZIdjhqQ0VTbFpFRmxFdVpmd3cxRlQ2?=
 =?utf-8?B?SHBTREUycFFEQzQ0ZnJiTHUvemEvWjVYamJTNWcvS1ZJcnJaTVRmb250NDVh?=
 =?utf-8?B?NkVwV0pHTGdZR2pNQ0MyOHYwSG9LcWJobjBnKysyOXZnV2UrM0lHbjZKSk5u?=
 =?utf-8?B?T2NuelNRZldNR2c1U2NvRGl3b0N6cE9uenNrTFdPZU9ZT1l2Wk54d290a00z?=
 =?utf-8?B?b0FIVU9kdFpaRGYyTFBuVjFVNkltMWVxUDUyTlFjbjRVc2RDNkg5ZWQ1WlF1?=
 =?utf-8?B?THRoYnNyamFsdFphQVJOVGt1dTUzMWl6MFV1Mm9sSys3VWJrYjRCN0l6ZWxh?=
 =?utf-8?B?OXlFRDdSazFCeVQvRjVWdjNWbmppNGVyenc0OUMrcVBQVGNROVBEMWgzckpD?=
 =?utf-8?B?YzFGTjdkQ0lEbzZTK0R4V2VGU0VoeEhoanNtK2s5T083cU8vMERtZVNSdlhX?=
 =?utf-8?B?eGlIMWJzNlo3L2VUd3gzQXRxbWc2UExXcWxDbVlFS3VtS0FYZUVEeEFkcm9u?=
 =?utf-8?B?M1BlUEtOSmpuU1hibGMrWWhUek9BeGpMTTh1SjJvUHlKRjFNcGtGWUUzaDZu?=
 =?utf-8?B?dEQ0WlEwSGxRV3pnNDVlcFhlWE5WUHVBS2NZOTRhaWIzNEVqNlJIQnhBS3k3?=
 =?utf-8?B?ampuTXBSZUVjSmhSaGVZUUx3Z1FsM3VZNm1LRDFyNEpuZDlJdmk3SytvSzFO?=
 =?utf-8?B?TFA2YURHcVdUUU11SndGczdUUEhjcWtac0JFK0orckZ2cWFSd0VxYTVndzc1?=
 =?utf-8?B?RG93dE1qM2dRK3piS2JhanRlTHV0RlpFT1NUVU1QZDVBNlFabmRBTFlJVkYv?=
 =?utf-8?B?VmtTN1Y1L3dnemtOVzJ1aCtiMlFMMExqN0lhS0ZGaEsyNk5LTnRUOEZheTAz?=
 =?utf-8?Q?YTp2iyQRTYQAwDH+cpQ0QU5Fw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc60515-d269-42d2-a216-08dd7cdadfb8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:36:05.8267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0CYjiyiVKihkczEFzeTBeWluNuZ0kTQ4a76OxeINZqhIE0qJd6anwqJMOG6G3dp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671
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



On 4/10/25 09:38, Michal Simek wrote:
> When boot_targets variable is saved there is no reason to keep string in
> malloc area that's why free it. This change is already done in ZynqMP code.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/amd/versal2/board.c   | 3 ++-
>   board/xilinx/versal/board.c | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
> index aea3bf022600..ee0dc3487831 100644
> --- a/board/amd/versal2/board.c
> +++ b/board/amd/versal2/board.c
> @@ -1,7 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (C) 2021 - 2022, Xilinx, Inc.
> - * Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
> + * Copyright (C) 2022 - 2025, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    */
> @@ -307,6 +307,7 @@ static int boot_targets_setup(void)
>   				env_targets ? env_targets : "");
>   
>   		env_set("boot_targets", new_targets);
> +		free(new_targets);
>   	}
>   
>   	return 0;
> diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
> index 6c4a2f5ead62..de53657b0c4e 100644
> --- a/board/xilinx/versal/board.c
> +++ b/board/xilinx/versal/board.c
> @@ -282,6 +282,7 @@ static int boot_targets_setup(void)
>   				env_targets ? env_targets : "");
>   
>   		env_set("boot_targets", new_targets);
> +		free(new_targets);
>   	}
>   
>   	return 0;

Applied.
M

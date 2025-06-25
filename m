Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D18C7EE30
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 12:22:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 559B782977;
	Wed, 25 Jun 2025 14:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TP3qd3ET";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3DB582CBC; Wed, 25 Jun 2025 14:22:49 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B8D8803CC
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 14:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=auCqOVz/PgrfRggSxyOSibybjG2fQNQR788bsj9AI0iqCuVUL4KacSp/x6vgSQuJGBMta/pRKp7+Pj0j5bHU3J9vNELyXETTYamk4bw+7BeO+DrrKjfSMlKkPRUuS/a62dhFCKRNRp+Yjqq9n8vUPxwBlFPGu8bTzvYnY1INQ512rLH0w+NjpLkJXzaQqc02Bywc4++Ra/989uySCb1YojGJh0XIxLyF/ulaGTTzanR9w9sbu0F1nxtF/MoL4gdLFqNqJm+thQDNMNrC2Men0kbGIitKm9+8ByN6C/cYZW4wZomjMsRcimrPEG6Fc2h45VPl6NfyZTHjRiupgO6V7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPzhioj3p51kVq53sML+i9N/dsczPdYyDbb6OSlSJR8=;
 b=y+iyXlOXOFxt0stzLpoAPOGtVNbvKKrx+r0O18j+8HrddNaWw8AfXWM0g65ztZolWuz+O5U9KeRGXOZ86kcykIZLduwx2AIYAJC7Dt8wN+eAxlZlSRbvQ7KcNusYGC8+sjWmO8/Z/wlTVUxA4NnvPj3kmxeiTqsMRUU1vFKTgbMuSS6LMN9WMOTvW0a2AwFrkxGSiKEy93EhkBrAG4mbcSlYV1HqAfcnfKTuHLhG3tpiP0kGKT8NVe4lL4FYQMs1WaUWELPDdtQrajhUCDE3HVvPfdAWsFcKqZ6Iur0RZwi6AvgqyZ03CgH4kYiMZ1woKaJ+jU6mltz1U9d7lsYckA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPzhioj3p51kVq53sML+i9N/dsczPdYyDbb6OSlSJR8=;
 b=TP3qd3ETGqtZPSv5jemiUOte3yRtNPkYEokIzfcoXiIUOPXP8zbSVuoRcwtCYWuUo+ZV6A4Bl3tcMXNCft19/BnPuZxZYZaMV6iub0QyEPMYOnQQG/x5CLO6EEIA4PBUBD8FykV177F22W0NVVGbAPPsvRSsl3N66qIO/GjMwCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 12:22:36 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8857.021; Wed, 25 Jun 2025
 12:22:36 +0000
Message-ID: <9afa7068-79e2-4d87-8d71-ce38a8d40bd2@amd.com>
Date: Wed, 25 Jun 2025 14:22:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: zynq_sdhci: Reset the host controller
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, git@amd.com
References: <20250625052639.229461-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250625052639.229461-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0081.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::22) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 7693c96e-8007-4024-e387-08ddb3e2f7ea
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXlBY3FNaThGU0p3U01KVGlLRm5qd2V1U2NyemRKNUFndGZKSzlINEphRWJP?=
 =?utf-8?B?K3I2M1BJYXFGb1I2RFdMeVlqYzlrVTFTNWxrWGtJWVRNRWRUQ1NWYVhOS3hJ?=
 =?utf-8?B?VzFIWk9vQ1ZQV2M4cDV4L1RBTlF0QUUxR0t5dVo2Y1J5dXYxNEFZMzJnRzJ1?=
 =?utf-8?B?SVJ5OWNXUzdjZ2QyRWN2TE9iM05uWk44WTBaU2t0VUd4bURRNjQ2NjA4M25I?=
 =?utf-8?B?QnJyNjc5cUlzSi8veWxEM3VNbFJabHpMYzNEVnFlNlVoUnZUbzJJLzNZUlhM?=
 =?utf-8?B?NWhKRWg1RG9Dc1lwUldSTTYrSWRJbEZaNjRrdGtiMkcwSVp4MDRGdC9uZUUy?=
 =?utf-8?B?a0RjOU1VQk5YdkFpaUI1YkNlelFCbkJ5Vk02Y0hEV0V4eHRpU3ljMkJYNG1W?=
 =?utf-8?B?QW53UXNTdmFWcVJFMVlYR1RaK2QyZWxiZ05XSWVLM0lKcm9OVlBRNzAyREpY?=
 =?utf-8?B?S1dIdmZINFJQNFdQQnBBbDVVb1JNUzUyMzEwQ25YZjQxWmFQelZ1RFhyM05L?=
 =?utf-8?B?MCtmMllBLzRUN28wR1JvWjBuek9aZnhUSm0xNzNxOVNnTTJWMURQZ3RsMVBO?=
 =?utf-8?B?cFIwSVl2dGlhWGx1RDFoTEJveEFhVmluYTBOMTlPQlRwVmdOT0JUeThRMjMw?=
 =?utf-8?B?cEErTStWUHB4MmpMVzdOSThOQWQ4UzN1VWNWZS9QRmt1bVpLNEpDZXk0T09a?=
 =?utf-8?B?czlkSUt0V1duOXZJcVI5QnU2MEw0VkRyckFxQWxtVlhVSDdTUlYrdXRCVnNq?=
 =?utf-8?B?QS9yUnNxWFlwaWcvSWVkZmliaEpuZE9aNDJ5L2JlYkJkemJGeTRlNFl0ZnRj?=
 =?utf-8?B?SGdhSVlxZ1hiSURvYmJKOGdXazYwUytPR25UUURSdmlFRVdESWdldmRGTDJn?=
 =?utf-8?B?TmVzR01ESTdQNGxEZ2ZkUWJTd1JraGs1bmE1Ty9aUkZidFY4TXJtOWJUQ0x1?=
 =?utf-8?B?V3U5T0JKSGk2Y2JlS2ZXMFVUSTRtSTU4M3orSEtaejN3dmg3ZjFxVnIwalI1?=
 =?utf-8?B?RmlSbHRKOVRLQlRFSkNrTXNqaW11QnA2elRPYWNDSm5QUVJvYW9tY0M2T3Vj?=
 =?utf-8?B?OWFUYlBqWlN0MFFYNVE3L3pqTXdvOFlYUnN1aUJOZWhGaVFOeTczbXgrMVl5?=
 =?utf-8?B?Z2J4M3VlUStwTkwvTjdoMGNVRzloQ3IzSXZBaVF3Y2t0VG5vSHR0cXgwaEVv?=
 =?utf-8?B?YVUwdUp0TGw5NFlSbi9nLzRwUUpSd1ZxekFkb0s3TElrdXV1a21TaEptcFVH?=
 =?utf-8?B?YUgrQWg1SStzOUdYL1FqSjlmWVlYcXR2VlZGSGZOZE1DRHRwREQzdDl2ZWdY?=
 =?utf-8?B?VThyZ3BYSHNVVjlTd1NZWXl3YlFsZ3d6aWxVRDExYUw4M2UxTEFYVkdIU1dz?=
 =?utf-8?B?Z0owejBHRnZqVTV2YW92aHdmMDFwRUJHZDRIZFVnTkN1U1AyT1Vidi9oZnRT?=
 =?utf-8?B?SFNLSHVZUENJeGhnTnFXMDZVRkptcHNTUHkzSmg4YkpacTFDZk9JV2VWZ0lK?=
 =?utf-8?B?bW5iajIwUFQ5VERHT3hER3dNMmhGalVRZUtrRnFHQWgyaGl0SjZja0NjUzgz?=
 =?utf-8?B?emFUQWN1R2tGWTEzZHEwbHlxc0R1T3lwdnQxS2h0K3BKTW5VYUhhckg4ejdq?=
 =?utf-8?B?OEw2MGIxUVM5aC9hem1leWxFSU54cmczdTdXT2x1MHdMclk4N1IxeWJEU1dO?=
 =?utf-8?B?WitrTWVMK280eWNHL0RsZ3k4MUlMNHhSYWFzRW01QnpIQVRGZmRod3lRcUky?=
 =?utf-8?B?UURRS1NjU3RLNlp2UmJIZjJvT2RENXRIYjBQazc3N21GNjdmWkRHM2JzMG1n?=
 =?utf-8?B?c2RoTk9YQ056ZmtZeld2OWF0ZUhFQjlmejhiMitJOEc3a1ljR01hZFV5M1pj?=
 =?utf-8?B?RGcxcXZQYjNiKy9waGsweXEzMUNZZnpPbWlzOXAvek84SUFIVVZuRmRBUHZK?=
 =?utf-8?Q?MpVTM8aDgaI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXhlWjRBWHI5R3FtdzR6ejFuNldkTmZYWktGaldQUHc2RHFVblE5aDBOczVF?=
 =?utf-8?B?YnBLQzlYQ25uQUppT1VUc0t6M1hZcEFsUEZwZk5xT2xjM2tod1YwZVRsNGJW?=
 =?utf-8?B?Y0RlTURNdFM1Rk9QS2JwT2R3ZkJ6Tys5bW1oVHdDc3QvdnRSWCtrRE5EbDdk?=
 =?utf-8?B?K1UwekdhRFF6UUZieU05Z1doTVNSMTNwM0s5ZzgxZlFJZzlGMXZVZkw1SHV2?=
 =?utf-8?B?ZVBzOHkrN1FuallzVkJGekFuczg1NmREQjZNSGxFVjhUUW1laEFlS2J1YnNR?=
 =?utf-8?B?SHkwYUxpSXFRc0JVWTJMLy8yRTlPa3VKYzJyYkEwWFpUZy8vdno4ZldPbGps?=
 =?utf-8?B?dkgvbyswVkdyeityckdZMEEzSXpjVXh3RHBVLzNtdFk0SktBR1BsRndqWU1o?=
 =?utf-8?B?bVVHZEkwSVpoT2QrWUpLSDNiYWF4VmtNMnZTR3hJeHpzeTFPcTRhZlUyUEgy?=
 =?utf-8?B?ZC9LOFNLbWo3Y0ZBejlmMmRUcGp2VEwrQ0Q1RW9zRVBXb2RuTnF6dzd5VjlH?=
 =?utf-8?B?VjNNMW92SEVQQlFSWVZ5NGNITE43YjZoWmY2RTYzN1RyVGZhdUZaVW9kS1Rs?=
 =?utf-8?B?RjlCVGUvOFVjQ1g5NXFMdTFyTC9QRTh2UTViUFhFeXBNZmp4dnRrSEh5U2F1?=
 =?utf-8?B?Mys1cG91ZEJnSlNHVHdFc013T1ducFBpdmszZzZCcWpINnNiNEJJMUF3YTdC?=
 =?utf-8?B?S3hwUzhBWmJKZ0hjdEd4c1JzbjZxdmpGMEpGZzNyZTlreEx0SzVra3RYaUlM?=
 =?utf-8?B?VGN4TjJpa0ZaeUY0bElXZE02alB0eE84UTMvL1NnMGJvWnVBc1RRa1U1Vmh1?=
 =?utf-8?B?UE9YSno4dS9FUEFDVEdsSE1RallJcTVsdHpMc3gyd1RVcmhiKytlVEJEakcv?=
 =?utf-8?B?Nm5UeGxZYTcxcW9Mc1dGOEpjZW1yaC9wdGo1RmxqMnNqVGgva2RrUHI2UmY4?=
 =?utf-8?B?Zk1qSEZhZ2JJdzZOKzdLYkdxQnI4bXhFT0xXc3VrN0VSWGg0dHZWSytZb2hY?=
 =?utf-8?B?K3pLVGpGWFpQTFRtS05uOTRZTlpuZUduTHBuV1RRM2dXYUJyQ3piWTFoT05Q?=
 =?utf-8?B?MjVFRFlkOVVnQ29HUVd0VDRWdVFmYldEZSs2Y0ZtTWJ5akF2RkFsOWZjVTRj?=
 =?utf-8?B?ZTRYTFJ0RVpERzVpYlR1YlhaT1VKb2Q3dUhNdXk5Q2FaemdjUmdtRWhhWUM4?=
 =?utf-8?B?UUh5SU1US2hKT2dCYnB1VDFwMDBoMFlLSUZDVnNsVENCZmJEQnRBNWd6L25w?=
 =?utf-8?B?c3lMVjVNUnJEU0haSDgreE5sMnJUdGRMWXZvd2hJZlVFbVovR2Y1Vk1OdUVP?=
 =?utf-8?B?Z0hPcXVURzZOT0R5WURjQ2RSQ2FFcCtycDNKdXBYL2NrK3NGeldrcXZGOFRI?=
 =?utf-8?B?UjZ5b3JzL1M3dk5uR29ZN0xZVThaNFJIVjAvR0Z6cjBybTU1WkJoOUZJWkVE?=
 =?utf-8?B?M2JqZFZjODRyNEhBZ1NQRmJJejI1cENHQ1hpM3dXRVJ3ZFlhb3F1WXZqdnp0?=
 =?utf-8?B?YW45ZDZIdkcrV01aNm5RNHJPUHhqUEdpWmdmUmZpRXJTMllTb09HdDRWdi9l?=
 =?utf-8?B?UzZxWEZDZ2pUcENvbFhoQnNJTndIRzZTTmpKUE1rckhKNUFuN1B5VHRhaGVD?=
 =?utf-8?B?aTVkSVZic1lxN1dlN2k5Ymh3V2Nzemd0UGRDNXREZENNT2ZFOXVlWUkya1FL?=
 =?utf-8?B?SXFZbnJ5UDBOM0NoYUUxOWtLbnJYc3NDS0czeEVjRHkwMStrSlpoZzVES0lG?=
 =?utf-8?B?clRtRVhTdTBsM1ljcTlja0cyay8yTEE4WWlvNVc2aThjem5mQUExQkRPbTl5?=
 =?utf-8?B?cWRqN2FLMG9CZ1BSSzZmeDhqRWVlT0RkekdudVNoWnpZUDluQ3p5bHlmUWR0?=
 =?utf-8?B?a3JOY05rT0tzb2ZPYVZlb2ppcE0zL3NQZ2NDTzhZU2ludzZhOWdDQlJuNVhw?=
 =?utf-8?B?VTR6OEJTb053OURkUVI3NjFENXBlNnNkY01EYmo5bXNaOVdvemFiVFBXc0Uw?=
 =?utf-8?B?MDBaM0QzdVJ6TUxUV0lpMlQ4aFhKV0pPUEQ1cENFS3lvR25jdEErMjd6MUxL?=
 =?utf-8?B?SFZXblhWVVR6L2ZqV01oVXVLeE5vNkJYTkdEM1ROU256ZVFPbUR2WnA2c09j?=
 =?utf-8?Q?2cocHv+otvyAy4JZ6CMvppHQ1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7693c96e-8007-4024-e387-08ddb3e2f7ea
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 12:22:36.1053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2O3v5ghNkz+Yc/8TD0vfLp9ZMcS9LaCy5CmGxPYyORcY5KBCbb2h+VfFMvDLk+xw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762
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



On 6/25/25 07:26, Venkatesh Yadav Abbarapu wrote:
> Reset the host controller at the early stage of probe so that the
> configuration will be done properly for reboot cases.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/mmc/zynq_sdhci.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/mmc/zynq_sdhci.c b/drivers/mmc/zynq_sdhci.c
> index 0e2bdab4e7e..5d797dfd0c4 100644
> --- a/drivers/mmc/zynq_sdhci.c
> +++ b/drivers/mmc/zynq_sdhci.c
> @@ -1127,6 +1127,27 @@ static int arasan_sdhci_probe(struct udevice *dev)
>   	if (arasan_sdhci_is_compatible(dev, SDHCI_COMPATIBLE_VERSAL_NET_EMMC))
>   		priv->internal_phy_reg = true;
>   
> +	ret = reset_get_bulk(dev, &priv->resets);
> +	if (ret == -ENOTSUPP || ret == -ENOENT) {
> +		dev_warn(dev, "Reset not found\n");
> +		return 0;
> +	} else if (ret) {
> +		dev_err(dev, "Reset failed\n");
> +		return ret;
> +	}
> +
> +	ret = reset_assert_bulk(&priv->resets);
> +	if (ret) {
> +		dev_err(dev, "Reset assert failed\n");
> +		return ret;
> +	}
> +
> +	ret = reset_deassert_bulk(&priv->resets);
> +	if (ret) {
> +		dev_err(dev, "Reset release failed\n");
> +		return ret;
> +	}

reset can still be optional right?

It means if reset is found you should call assert/deassert.
Not sure if there is any need to keep reset for some time.

If reset is not preset it should pass.
If reset is present but error out because whatever reason you should return error.

M


> +
>   	ret = clk_get_by_index(dev, 0, &clk);
>   	if (ret < 0) {
>   		dev_err(dev, "failed to get clock\n");


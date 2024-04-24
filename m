Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47429C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 08:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F73B88DF8;
	Wed, 24 Apr 2024 10:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oPrRPPLE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAA3A88DF5; Wed, 24 Apr 2024 10:23:06 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82ACE88DF8
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 10:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5uAn95oduV4ST9RXBvwsBb3+J1EgRdSXWcnOwLDzfEaM6m/46oA/TndZvyVEITtyI2TyCxWtMQRfnioL3ozpFc+HW+rhqbOLaLdvdSturGLCEWsLgdALodHg+mQPi7ZKoWedTDSR18JEJHgSnvtE9JgxcAs6NKRTdUbZ/37m64qvrqRswd/wae541ndagxxQ+IM0a+fyf9Ruohe09YbpN4C2SPp+eOZChSAwQ58p85RfVjtt6725SRVHOSVZI46BgbJyn66u1mRrZUr3AutU+1+DUopeMeY6wcdGbhWpktREY7D7OaqiAUGtazgJOwn8JwHAsV+VIvkBGpFu5TXBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wn81lImP7FYQtVf3Xhv1NgurJOzLcJnddSi1GVcJgUA=;
 b=JR/nipKJl0QdkzS7Af8F/l817KNxmw/XYN8cYd/9kWjM0xD1cSgvRkt9ebQINUxNNE0YvwBOC1H+cewkjx8VebhEXOFI+/em3NsRw/brM/4ZJC4qZRDRLsIIF1S/pIHeO6dVjC0PTMLGtI53cBun6TWRs7fuv4XSwUm2tn9sC2Uo6+sMZUpVCaMOjGLf5D1vW/u+Q51OUZ9K/yWaeDFYI/oohTc6RwWUF2Cjztv8mj1uRVYZeAMkMDuPCpuEkWlhPfZI+8fRaNewl/ve9xHjQz6hYc2HPAV2s959h5AXwQwaAeEGDomAzXCKr8KHcnliY9yAcOCtVryDVFx/KLS/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wn81lImP7FYQtVf3Xhv1NgurJOzLcJnddSi1GVcJgUA=;
 b=oPrRPPLETQmUUKxUtaCclIi7YzpVQSeFZ660KM0j6rl1n3vMjdnKDfe5EMNK5/hvx/efCyKGui+z62hGjHT1H41gmtg5iUTXIkOAfu83yQIcmBAcF4CeAuRVskd/S0S1JVv65xN9l39G4+oxiOA18+qTMuzd4MDn8FNy6jseXR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:22:53 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 08:22:52 +0000
Message-ID: <0041a655-8414-4e80-9901-7284fc38ce23@amd.com>
Date: Wed, 24 Apr 2024 10:22:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: zynqmp: Clean up xilinx_zynqmp.h
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <fa117ac482591d3d5957af54fe99e6acc89972e3.1713167731.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <fa117ac482591d3d5957af54fe99e6acc89972e3.1713167731.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0061.eurprd04.prod.outlook.com
 (2603:10a6:802:2::32) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BL3PR12MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: d4916057-d1a2-475e-98e1-08dc6437bc2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekpxQ3dma1kwWmIyZVVmZitCcWZTeUFqRnJvcTAveU0yR1BjTGowS2lwQkFh?=
 =?utf-8?B?SkhDdkUrSE5KZG05L0pIdWhJT2UrcVU4ZlhGQU9nNWt4Wi9BTzRHaWU1bzg1?=
 =?utf-8?B?M0lzWkxOQU94S29XQTVmTENpbnBGTU1XZThpbkY4ZGFoaDkrYWJuVG9sbHg1?=
 =?utf-8?B?d2xydEtIQ3R4WTZ4MDc1T2tVUWJjOGtneXl0UldvbkR6UWxaT1R3UFB4djFq?=
 =?utf-8?B?eVlNQlM2RU05UXoyTkNlOWFUbllXZVNsUkV6TnNPS21oMnVzTDdnZmFpNWxY?=
 =?utf-8?B?dkFMQnpVTHl5bVg3dW9WcGlsQkNGMis5RWh0SjJsUzkwcjFsR1kwTkN5NmYv?=
 =?utf-8?B?V0N4VEFzdDc3ci94ME9hNlNYV2tyR2ZDR0wrV2NVeFpEYTBFOUxCYUhXai9H?=
 =?utf-8?B?RDlDNTZuUGNoekorYTZDblZQU21LWGdORE45WURmWkNSSXFqTWtzT3lxdjZ3?=
 =?utf-8?B?TVhYVFpGeHZGT3VKS2p2K2RxTDVIMmd6N0xRVUV4cXdpR3JxQWp4MWtSSmdt?=
 =?utf-8?B?bkM1ekhEd0hpcVFXVHczVExsR0NJMERWcWhVdnl3MHVQaXlybUZUZW1XRS9V?=
 =?utf-8?B?N1cxYlljcTF4V2p5Z3BZZEh1dXM1NWxoUUNwOUFYdjhLVnRwWEZWZzBxSGox?=
 =?utf-8?B?ZDBsK2V5MWRkWDhyQ1JCUDNMVEVrayt1b1kwTFFDeFhhZFR6TkNpUU13dTNX?=
 =?utf-8?B?MzNuNklEb08yK2d6c1ZnZEZhQW40MjBoS3lEMGtCRVVxanFFRlN4SWZJT0pm?=
 =?utf-8?B?bzJDTFZEeWpkV0JON3l6QUtrUVI0T2dPUkZqb2tkOVp0UFZPWUo2aEVnL3hw?=
 =?utf-8?B?dGZUclM3Qkt6RjlYYTVYdXE2UUxqZGtlTUlOckZJcVMyckVuV2w1K3M4ZkJ1?=
 =?utf-8?B?TGNsanZuWDk5ZXdoS1ZGVjRBS1I1OFFic0NscGlTcFdJc0JkOXlyUmdkZFln?=
 =?utf-8?B?MmFrcmoyTWxJT0U1OVpaOXR0a2RYNGNOYXQzNDlpUXQ1NllBQVJKdThnSmlZ?=
 =?utf-8?B?Y2QxdFFiWmRsM3FFa25qQnZOVGRDMlhGZTcrRjdXbUREazZlMDhuNkhUWDJz?=
 =?utf-8?B?MHRzaGIxeHV5SFgyVVRoSTUzWmxmMkpqSDdCdFY1N1Ixa3lhcnVMdDk4N2p4?=
 =?utf-8?B?eVowMzB2TndlSWlJVVBzeGhENVVaWFREVXhRMFNRWUUyS0lMY01HT2RiSy8v?=
 =?utf-8?B?R0dveE9iZ3lyQWprS29hakdKMkptUThyVnJqelVDMnhENGFoOFdabW5FTjFu?=
 =?utf-8?B?S2F6SVhiREFoMzJic01YZUgvRmY0NjF6cDdYc1JobFlIR3p0Zi9SaVdOem10?=
 =?utf-8?B?MXVxa2J3RlNOSDdiT1VBVDFCSGpPYzlRV0h0TE9kUEEyN3VhQU5vOCtXUXUv?=
 =?utf-8?B?aXQ1Ri9aaXZHZ2R5Vit4M1hGaTI1dktLNUhqVnF1MUI0dGpqa2NkZFF6QVl3?=
 =?utf-8?B?RWdtQ2tlQzVuWkJySnBkNlFKYjR3T0NqcVpsT2cxT3hyb1doU3RNTk1xejN3?=
 =?utf-8?B?bkFXK0dNZGNZVExGV1haNHBDQ1gzdHhyYzIwQm9MWEZteStpdTlnUGJ4UEdF?=
 =?utf-8?B?NFphNk5Xbk1xSUs3eGJQQXJjWGV4cTlvaGdyTmMrVlpJTDFEa1VZcGlZMGVP?=
 =?utf-8?B?MGF6b1ZadVVrVlIxbjA5dy8veTE0RjZjUmxiWityc2hmZFVpTkxMWHNEa29H?=
 =?utf-8?B?eFJRWlZOaXJtYVZnVjlOeDMyVFJzb0hzZjQ3ekVMcVhNeHNqUW1YZjdRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFJ2VVJTVjhKV0R4Zk1oSWkvZHN6OUpRZDNOaVBUVzRBZGN6ekIvSWFNNStT?=
 =?utf-8?B?VmdIRTN1RmtRcmQ0RWJsVnBxQm9VWmNpYWh3T3ltZmtDbHJ2bE05d0ZhRnJ3?=
 =?utf-8?B?ZUdJUWdMMC9UVTc1QS9HZTZUcy9tdGM4NFpkMHlrQ1BTczJsKzI1OSszMUxp?=
 =?utf-8?B?ekZVN1FCbEVQU0ZPbXJnR01XQysrWmt1akQ1TEFUVkhOT3VBM2w2NVMzUkgy?=
 =?utf-8?B?TFVUVmV4TVVVRkkzZCttSm5YR0gvdHptQ3NVTjdPQTR2aVVWZmNaSE5PUjJm?=
 =?utf-8?B?TGRIZ3doaW5WZFpqWnhZZ1lIMHdtQ0Q2ZXdlRXNXUFVSMjF5MENNT3hZY29n?=
 =?utf-8?B?Tkp4NVY0WW4vZ21oUHllNHpxRnM4MFVMYWpkeFBmWC85ZmFkS2JIWVpTcTdW?=
 =?utf-8?B?OW1WakREbDB0QmYrbEpXQUMwa0ljVFl5ZTUyL1o4a1c2Q1FHN1ZNS0FKZmp3?=
 =?utf-8?B?NlRlQzhtaHQ4Ym9Kb0kyamxqdmRtbFdBY0Z5RndUQi9MY0lUK1R1MVZBSG9v?=
 =?utf-8?B?bWZFaE5zSzU5ZVhSang4ejdwRUd1UWRxeXlTK3BtVDBpNkErMTMza3kwSTI1?=
 =?utf-8?B?MDY3YWw0S2tOOWtGZXhTQU0zZk40NHVZb0g5U2lsVGpxTzgrTURjM3VRa2lT?=
 =?utf-8?B?Z296cEdnZFJ2Z2JyaFhUd3lhVU5Ra1d6Q0poU1JpUVZVdy9LUVZZNFppd2NC?=
 =?utf-8?B?YjRqMVF5ZFptMVVPKzFFUy9VUGFzVzZMZElXWk4vc2lJYlJ2YkUrT3UxUlNl?=
 =?utf-8?B?QTh2eEJNZ2g4dFJSN1ZKUHBodGp1Mmw3clRscHJZTWswY3NyTm5OZjBmbjdY?=
 =?utf-8?B?Z3hEN0l0UUh3ZjIzV0YwTVUxaUZNUHErQUFISjBVY3o4RTZFQTZXSENia2hr?=
 =?utf-8?B?TU5pcXdIOStlZkt4NnFmWmNEeUJ6U1RFRUNzNitBOWFqZGpzczBXZXhjdG1B?=
 =?utf-8?B?Smk5MFlJRzFIV3JvOS9aQ3BZNHJ4U3pZa3Bpc1ZEOWlaeUFTV1FWWG9FZUkx?=
 =?utf-8?B?Q09HdFVSTHVhL1RPZHVROUxMWUN0YmI5djlYRlJmMGlDWlBlTXVEemIxY2Jn?=
 =?utf-8?B?SHJTWndTckNUdVJMKys1a0FhQlF5YnJqVTl3ZGdGaFJQeTR3WC9nYXhCamIy?=
 =?utf-8?B?SU5YL20zVjRaaHArdXN1SWVLTkhEM1B3Q3hrUkJyZWVtUHJuL0hmcTExQThk?=
 =?utf-8?B?LzZ4SHR5UHEzMkdENDI5TWRaeDhmM1cyR2J0QXRWQTZiSFhHd2VIZWpHUy9y?=
 =?utf-8?B?U0dXMVcwVW1ORkRYbUwxdjJ5NGx3ZmhHblZ6THhFdTRyNTRTNnZEWGxxRTVw?=
 =?utf-8?B?aWtsWTlMN0dSVlNTK2o1YWk1NjR6NHNiQ1VxZlN4VnVFYmxlTk9ESE1wYkgv?=
 =?utf-8?B?Ty85MmhQVk50S1A2dkZlZVY1NVdMSHdhZWM4Ly83TmNxdWZIWmNkRGo5cW5o?=
 =?utf-8?B?YUtHLzVXc0pJWVJVSTVSV1UvODdJVzhZV0l4cmtwY1VyeHFhSlc2cU5TenJR?=
 =?utf-8?B?UXlTSTZMM240Z0N3M0pFR245Z3hrVzF2VEdiVTFjbUpLUWRZWHlYM3JyaWMr?=
 =?utf-8?B?Y1NVeTdCcGNpdW4vSTFYMEJpOGdoaEwrRGRreWQwL0w4bUx1eGdqVEFjbkND?=
 =?utf-8?B?a0Z4bEZaKytPQ05JazVCMEFMN0QrRURUYmFKSllQdkhpdndmck1kOWpkOTJk?=
 =?utf-8?B?Z24zRk9yMmNPWHljTG5lVkpGWlBKUGFhRENGczdVT09aMjA2aHVpbGtSU05I?=
 =?utf-8?B?RW1SUEhqdSsxTW9aN2E5a0lSZXdzbFhYbUVmOGdTMGJJcmVEL2tnN2tjejVs?=
 =?utf-8?B?R1YvOHJXOGQ4Mitib2QzaWtkaWNudzQzbnBmRGdLSTZ2UmdIblVmSkhiMkFJ?=
 =?utf-8?B?ZGkrZjJmenNNdDI5TWxUdXp6L0R2Y1lVTXgzRnBZaktXQnRWN3dnT0lUbEVV?=
 =?utf-8?B?TW1zQzlSL2dvblkzWFRCMmZUSkVNay9BVGtlTHFiSHd6QlhER1dKWXBrbVE1?=
 =?utf-8?B?T0RBQ3k4cWdRdXV5RFhOektTbDFXY2thazVxbzRtcHkyUWVlTTdVNEZITmpp?=
 =?utf-8?B?dnZob044OHdkVkJieFE5RkdTYTRpTnp5aXRXZ3hHZjBtR09YV2c5cGM4RW5k?=
 =?utf-8?Q?OKclARoqqV/O/ErAuyEGqNRX5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4916057-d1a2-475e-98e1-08dc6437bc2a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:22:52.5389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gqWh41DtPPj/xPQ+lHbqjjJP/a+WnYcf/lNgTyMtoOht2Lc4N9S/27DbPEg+sWEL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473
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



On 4/15/24 09:55, Michal Simek wrote:
> Options are moving to Kconfig by running sed and comments are staying in
> that's why do clean up and remove useless comments.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   include/configs/xilinx_zynqmp.h | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/include/configs/xilinx_zynqmp.h b/include/configs/xilinx_zynqmp.h
> index 5bc117e19000..c5cbb76645ef 100644
> --- a/include/configs/xilinx_zynqmp.h
> +++ b/include/configs/xilinx_zynqmp.h
> @@ -42,8 +42,6 @@
>   # define PARTS_DEFAULT
>   #endif
>   
> -/* Console I/O Buffer Size */
> -
>   /* Ethernet driver */
>   #if defined(CONFIG_ZYNQ_GEM)
>   # define PHY_ANEG_TIMEOUT       20000
> @@ -204,10 +202,6 @@
>   # define CFG_SYS_SPI_ARGS_SIZE	0xa0000
>   #endif
>   
> -/* u-boot is like dtb */
> -
> -/* ATF is my kernel image */
> -
>   #ifdef CONFIG_SPL_SYS_MALLOC_SIMPLE
>   # error "Disable CONFIG_SPL_SYS_MALLOC_SIMPLE. Full malloc needs to be used"
>   #endif

Applied.
M

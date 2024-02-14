Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636D0C48BC4
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 10:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42D0F87DFE;
	Wed, 14 Feb 2024 11:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3cef0MMy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B785387DFC; Wed, 14 Feb 2024 11:23:36 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1471B87E01
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 11:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niKsjTK2tcBXFMMrMv22LrDsMHAX/8yxk1s697DQw+nKkIkRCH/+soedstBwvu7e7BRQEEGIa+6SCdQRPo1+FGyZk2M+GTQm7qK9ZClsy48Owt9+KDl7SZcFbI8AfSRgMR6aD1biUXUJrVpAxiVW5dI6CaPOYUaoxttL+pTI1NfuC3xneLzdLrUnhEAPQ4rQgn7+5JQJ0GOhj5TRZA3RTSQH0d0x1fVQ9SQoXNILH8enFPcbIhkGGoGVG6ZI5GVVTLldW/q37lydRY/sguEXs0tNnp+49HVG8OqxL6xhe1Rk5g8LfkDW6QbMiKjZHpx7ONBNPDjrWbbJpMno0s7mTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Q9xTithT1qcLAiXty9C7Kbv4Ytnowj8Cfc8WiDQBbI=;
 b=OqG4XikpN0lUXvqtH4l42xEgUR7MvwRChZ++bww/fhKl1akDRNrzuWePmwBIXOn7A/YJDzhF1mqZUreFhD9W1fm83V4axPiwiDOTs7efMPZ7unnvSTBCq4IzWVuR9uPhzWjfB1FV0mEd+Vv82FnWiEqRP3HZAdwLaCZAFGVA5Cn8LUcIOgr6xhQHDd1gO+BRniqh2Qr3gQe5a6zfVa1vJibAE+nr6xxZzs3ByVwECIJMyd6vd8ZZMaJiG7UBve9E/ofVnDwxjLrDk+4g5uAfO14DG1Ch0QHbSaVkPvuZ9FnZVclDwjYGdbROdirFuEOeheHPG7kJ3ExhBYNWDa88rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Q9xTithT1qcLAiXty9C7Kbv4Ytnowj8Cfc8WiDQBbI=;
 b=3cef0MMyJV/nLiULxyo4UXZP8iZy4YqLAf6jPsqMxOh5gEHy7pMC3M50EEuY/uNQVhz+B+JQDkA9ks7/Sg/zZUfJpdL8Jo8ni3cKNCtMSZh/QsfvYC5n8XKIhh4pywwUkHMrFWSKJtiTk7RK69V4HuZCB9D223F3xzvs+JPgN5k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by DS7PR12MB5911.namprd12.prod.outlook.com (2603:10b6:8:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.21; Wed, 14 Feb
 2024 10:23:28 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7292.022; Wed, 14 Feb 2024
 10:23:28 +0000
Message-ID: <09e92f9c-6e64-4906-9259-5248f2a51a40@amd.com>
Date: Wed, 14 Feb 2024 11:23:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: versal-net: Setup correct addresses of GICR/GICD
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Tom Rini <trini@konsulko.com>
References: <5d3d0e1afb1f673ffeb4a1c5d7f040475c806a30.1707220293.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <5d3d0e1afb1f673ffeb4a1c5d7f040475c806a30.1707220293.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0035.eurprd08.prod.outlook.com
 (2603:10a6:803:104::48) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|DS7PR12MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b95540-1b45-49db-4fe9-08dc2d46fc00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+VenrhVASwOIywLspKrMl2YLXYVdHVeudt4qRm1b5PoYt2dgrJ6I6fr3AUovN7qr3AjR17eFTwsLNnSTfFLE93NqpOO/aTQ4LhxRyziNtPAm2aHadiTbpKTQwZfSK4QqTVSi64t4L447QFwNGkQ7QtVK9r2P1pFWp6f5Kcu5KWwjW9mSG3DBSQogUk3R/+D3gKpSVDHFmPyNrmUmfz85ZJS5qdX0xAvPOIVvR9ROoB7J+qHBoRfpvaeJolvFbYJOR5Lqv5NjHIRBIRHX/e6epbs7MUB+hjupk/tpL7qiZk6nJUF0+MYDTRo6jj8T9T8YiYT2C68ZRxekx8qfBGEx71JRCCteL6XWjA/IMrhKOlZKMEtKu+m+3PNtjCe5umK/cha368TlYxRc6eFxGmf7lup3yv2Yt/y8NVVokNdDejfrLt8vL9nTmIGQEnS280Uv7hgkzfM69aGhdLp1i6ehcDfavuP8DlonBIU5PzbZKKYGEjcGu79EhSuev+WyFYxY6vqgroXdanmqFpgy0VN2DSmUSh56phytjvVpqfeCkXJ4Pb7tmQ2VRltfDfSC3qy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(39860400002)(136003)(346002)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(86362001)(31696002)(38100700002)(41300700001)(31686004)(4744005)(6486002)(2906002)(6512007)(316002)(66556008)(478600001)(6506007)(83380400001)(26005)(2616005)(6666004)(53546011)(5660300002)(36756003)(54906003)(8936002)(66946007)(66476007)(8676002)(4326008)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0NZK3hHbitRN2hNUVNPcWo0cXJKWG9FSFFlS0RlaXZEc3gvVnI4SDQxMndv?=
 =?utf-8?B?N3ovVml0dzdmRm9FYnVlR29UbTB6V3ROb3ZLeStDVzdkSFRMSWcvZTl6Q2dM?=
 =?utf-8?B?ZUdEb2pHZ2JKb2ptSGU3ZXk0eU5Dc2wzc3lGUE9LMndrTU9qY2Y5Zmx1V0pN?=
 =?utf-8?B?T3BIUUJJWjU3bjlpTGo4TUdsTnpHSnpWNnNLRmdIbnlna2ZlYlZnNEZMaGYy?=
 =?utf-8?B?TFlXdVpFQng5SEZEZE5VMUNiaCtLSVN4KzVlWjljeXMxZ2VNVkpsUUdNVm1D?=
 =?utf-8?B?Tmg3MVdEOG9kMHhEUHNUVFB6cUVtVTFESHA1N1VDRU5sTjd2RStzUG1DZGMx?=
 =?utf-8?B?TUFnd1Exc0FTdXRsNXA2cjhWSlo2KzNpVDdOWW9QWitTbkZ3K2ptVkU1UWpW?=
 =?utf-8?B?Wnp1N3FuYWlGOEppUXJCZExYYXU1T3FHaDM2WHRtOVl2ckVnOFdBMm43TU1E?=
 =?utf-8?B?ajc0R0Nxd0ZzZTloWWlHN0NFS0RtajFGbHk1K3VQbUdpNUI5bk5NNWlRTEdY?=
 =?utf-8?B?K0MrYXBEYWZ4bUtpK3VZSG1FMmVqR254b3l1QjIvWG9FZTl3NGI1SndlelA4?=
 =?utf-8?B?UVQ1UUM4ZDNhM3ZTV1BwRG1iTHo1cmgraU4rWmxNczJiaUJVbkF4SERMaDRU?=
 =?utf-8?B?VDI0VTVCU3FKMXZnVWphNnRaTmVkQ2cweXFXbWxyNFVLdWtYOXdLdmJWQzhk?=
 =?utf-8?B?eXcyQUoxS3c0cGJwMDZyVlppaUhsQmgvVFM3cTB6dE5yM0RuRFFsdmNmSWZY?=
 =?utf-8?B?a2NMR0FxNWFReEMzWTV1Wjh1ZWFzdFo3NGNJR0t4dWY0VFRRMURmWGdKYTVp?=
 =?utf-8?B?WjJCeEV2NXBtVy96T1M1dStoZTBkS2ZrRkNUYkU4VHFiTW01Sk9NVTcraXJR?=
 =?utf-8?B?dDV2OS9QTUF0WGFDOG9McTRsNWxqdERteGhqV1V1U1hORVBlYU9PdUZYSVlN?=
 =?utf-8?B?UmxCWmh5UzF6NCtRRW1RdTUrVytCaS81ZFFCUktnNjJlMnlodVF6L0pTZFNC?=
 =?utf-8?B?MXIvN3prcUZ2UnkxMHh5cytHcW5MOU1XdnVHWFpkN3dMaGc3bFlpR096R2Vx?=
 =?utf-8?B?TDJOS3pvWmdjVGVGamtYODBJNVNocCthODhualRGNEkzMFJxZ3FhNC9KbUJy?=
 =?utf-8?B?OFUvUUkyWExicXozMjloZW5wSm15Y1FhdFhLSGcrbWYyazN1L3hZRkZSZ0U3?=
 =?utf-8?B?WXQvb3lsYmRNbC8zWXBaL2UydDFiN05OS3F5cmNTVzE0WnpPN1owSVkzQ1Z4?=
 =?utf-8?B?d0xMVVZjU3FaQ0dvZzBuWWx0YUdpR2cycHFMR3ArcDdKcjRRL1BJWlV5Tk1R?=
 =?utf-8?B?ekV6bUJxNFBKVnBMVlFQZkx2MTdKenZGR0lzMitZUE5vSHl6YnNiU3FKODRQ?=
 =?utf-8?B?RUlnOUlDUDM0MVE1UVdBbjJsVVZvUWY3TEFDL3RKSEpZNUFxNkZoTWJPZ3NB?=
 =?utf-8?B?d3JLUnl6czNiK0VBMnJsZmFXcjVKYjFQcEVROUxUNERubXp4NEMvNkRoSktR?=
 =?utf-8?B?V1hxTHh2azFHa25PK3VoS0ViQ0RaaGN3UEZ1eXhDZ1VvdWUzenU1MW9kVk16?=
 =?utf-8?B?VHFoY29rVjBOK01KQzlFb1RzWXBaRzJvS3JOQlE4TVdsYmcvS3JpWVFZcUl3?=
 =?utf-8?B?SE9uczdndnNqblZvSHFTcC9NU0JQbUorVzhGdFZGVVNEZHpqaUxkNXQvZlEz?=
 =?utf-8?B?ZG1LdStwaVp5eUZ0S3hIdmxMb2pwYlZkcFBWcU56b0hTcjI5aUs1LzFEQ3Vi?=
 =?utf-8?B?aS9BWkNUR3dwdjRLbDE0RGR4YXE4K0txUWxJUURyUXRJZVpJUHBpRVRPZVly?=
 =?utf-8?B?Z1VZdDZHZTByUnMwY3BSUXpIVlg1eWJiWkN5UCsyQk51WVRXMkdYemhUNFVy?=
 =?utf-8?B?eVlFMTFhaU52RVlONnFWV1ZtckV5NDMyWksyb2l6UldmdGJsR0FKYWJzVExk?=
 =?utf-8?B?M29RWHJSSDFiaHVhK0FkN1A4NTg0ckVpR00yc2hrZ1kzQ0Y4RExrZ3NYMmxE?=
 =?utf-8?B?elRoamhneUpsMUw1a3dqd2JXTEVDN1ZWUktVenAvVkpGUGorVS9CVTRQc2Jp?=
 =?utf-8?B?WmdhSlJXcjd5Y21hRmhDQzR1eTNSdCtpOGxucE8zVVBTY0tGZVFFOTAwelJ3?=
 =?utf-8?Q?BUQIkFLMvJKXCf9M+rZDcMOL0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b95540-1b45-49db-4fe9-08dc2d46fc00
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 10:23:28.0918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnwuhwW+Dy933e8QgSdmtY0Gw7UyBX1jOf5Rp0QQsPJIZJs6k/3GFXOGvjRCUiXc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5911
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



On 2/6/24 12:51, Michal Simek wrote:
> Previous addresses where used in past in emulation environment but never
> gets to silicon that's why use correct addresses.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   include/configs/xilinx_versal_net.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/configs/xilinx_versal_net.h b/include/configs/xilinx_versal_net.h
> index 2b441da91a10..9cb6b2bfea3e 100644
> --- a/include/configs/xilinx_versal_net.h
> +++ b/include/configs/xilinx_versal_net.h
> @@ -16,8 +16,8 @@
>   /* #define CONFIG_ARMV8_SWITCH_TO_EL1 */
>   
>   /* Generic Interrupt Controller Definitions */
> -#define GICD_BASE	0xF9000000
> -#define GICR_BASE	0xF9060000
> +#define GICD_BASE	0xe2000000
> +#define GICR_BASE	0xe2060000
>   
>   /* Serial setup */
>   #define CFG_SYS_BAUDRATE_TABLE \

Applied.
M

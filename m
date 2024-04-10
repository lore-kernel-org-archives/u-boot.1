Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A5ACD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 06:16:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 019EE87861;
	Wed, 10 Apr 2024 08:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N9m0whbT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68E6087916; Wed, 10 Apr 2024 08:16:03 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16FD78758B
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 08:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CA3PfitDZv27D+DmMI8xwjg9FFtp7iduydRBMcf3DcMgb1SAbJ7gvRrw2NehYimGS+lPWEpdssIbmcKQvxUIR8YdIg+tbWnS1em8AubEPewXYXleXcziM91x+sI6iIyoPKP6chaTAmxMZKI/9miJFjm5Xyqse8N5rXlYJAZNzE9eNr3N2cw1z/CR5DZiu+heO9LPokUHrAygvmKFUDBVAsTY+1tHw/esT4axUk4Wh8P5Kvfp1bbaJELgO7N0+G6wfD6FQ3gVzI0cdK3s6p7GyPPbnGo5HpupD75XrsuNffVQTpxp1f5muluin/ZmroiyYPAAe/6G/1ooGT+eXN8JqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2zwPLePfWXmNO9echQhzIfMkEF128ZAfx3G7ExnBlM=;
 b=Yx5bAxI0ff4i4iL7+Ex/dE0leYuviyvYzS70+lpP5ajJAdOxcRjfxYSlPnj8PlaKt8Qf9QQs+bbQ2XnnGIE6lXjes08Oy/8t1+ZTg3sHseaIrLKMHkN7gtholYOT6/tcAtkDZgSaRCESSCmnAlazVDe6/yOhQYdKgqPskgeZf6EtTkcWNC9pfk85M7ZcFFJfsQPWr2yqFhwcxVKeYqJG33qjMkV/9HCbI+ui/db8CtcfR/wGBKh4eMvFgZFPMz4PhGnc/TIlTXCQn3JPyYYcEpqV3Gq1lSigC+5Mv2xP2pMjOc0AVzNQu+ddsBlePOXPN+DPkEpjFXFYIRAYubMsjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2zwPLePfWXmNO9echQhzIfMkEF128ZAfx3G7ExnBlM=;
 b=N9m0whbT83W2QX2CyTj2oUP04DPNDdJ8pARKON1LGn+b76hACXWapZYDbbB7BMs9DDiDXyQBzq2uSEwqdel2kmJl93b0Y/HXuBYG249+dRgdEhNJdAJ3d84mrziF2ZBjw68/TRHGewISElQ7vMEr21KJAL3Bwar6NERRs3ouINY=
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB8003.namprd12.prod.outlook.com (2603:10b6:806:32a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 06:15:58 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7409.046; Wed, 10 Apr 2024
 06:15:58 +0000
Message-ID: <7b1bae99-0e2d-4b78-8463-5192153525a4@amd.com>
Date: Wed, 10 Apr 2024 08:15:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] board: zynqmp: Move zynqmp commands from board/ to
 cmd/
To: Charlie Johnston <charlie.johnston@loftorbital.com>, u-boot@lists.denx.de
References: <20240408201313.10183-1-charlie.johnston@loftorbital.com>
 <20240408201313.10183-2-charlie.johnston@loftorbital.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240408201313.10183-2-charlie.johnston@loftorbital.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0290.eurprd07.prod.outlook.com
 (2603:10a6:800:130::18) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB8003:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qXJFoFY9tCfQ+nFwdWX5gBfwo06uYlbkIt3vqBXzj5qYoqklRrYdUHH4hFq/eUWBDxTu25qI9wQ0B7X3SK0k9+N4+JFkRmmBd63jCQlHu+euxFgVgiAVVpZQJYPGriHRvI70oyx1gHR9jXI5YvIz/plqOQt+b/y1+rzJIVvnxCubXlhAirbXWPxguHYk9F2qcmvyy+2yc6cQ4sIzxMobqN9LlMwhW161ruvxP/DbkUKPoTHMx35wQuVU7xxm90/nIW9jDDySGu9Or0BGF5V47q9PkTS99qAnpT4vzOTa+dtS0F+8zRLd6qD+OT/StozLl2iJ3/tL5rMSUmxuKmybeepOG2sWfGinOyjocxrMmgNPgbLLvkOULAjCxYxPo67251x5h+pBwFMoCF+DpkUAHRssJtPLwVfjdt9NYmDdEi9+zZpGdJGxTWdJwl1tNjCxTOjBPuCZ8tus+coDy18ATqF5RplAIekTQBsGczs6Gb5XYHZjn4H3Z9MmelLuyL4+ZWAvtP6whzkSuZMfSbm/8NdX/gL4vsbaYx3wTo1/rAAtfgAoXRbg7xjn+hLJLZbd/+3P30v431V5BhLkOfYheh7rNxGEF37KYeEqZW5DESvroCPJSAyxATqRmHuazURjUpjXfNK4BzmUs2kWClmtqlYGVoqH7KIWARB9w3NHwz0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTI2elRoSzR2UGlXMitSZzdtREU2TTg0c0pIWGNLSzZGR0VDMExMMGVTWTVv?=
 =?utf-8?B?TnIwWHdsZnNVakwvSzBRYmxxMER3cmNvRURMV2Z6bDJMQUxGU1BjUXRoZ1Jq?=
 =?utf-8?B?L0xuV0RFYUtmTE1ZN005VUNsd1FvMFUyVWNzaWpjQVY3WjI2dk94bEdyVHgx?=
 =?utf-8?B?bldiVFpQMTJTbHhkdjh4VElkZ2hLd2NIaS9rRVgzeHJGVExIVXJkaVZNb3oz?=
 =?utf-8?B?Q0dpcXhsWFVrZVhTdTlTN01NdWZpSDFvQUtkVXlrZ2pNOUhUWFNCNHJreVFX?=
 =?utf-8?B?ZFRtY0lMQTFIemthejBhbXprTERCT1NFYTdSNm16THFsSHBuUXhSeHlRclY5?=
 =?utf-8?B?Zkg5NEZJaEQvYVhxOEhHeTFBSkllYkNReSsyTnNNOTJ0NXZES3hGcHhSL0l2?=
 =?utf-8?B?bVZHQmU4VUJpaklyZlRvM3dBYW01MmhwaVBaQ010clR0UE9oMXNkcGREN3B4?=
 =?utf-8?B?ZE0vd3Jla3V2R0V3akYwdUVwaHVnM05Db2QwM2ExVjBTaGZVQTF0TDV1anY0?=
 =?utf-8?B?U2FGcWhHK3ZhbTdSOTkxTS9kenBHQ3hiaHovenBScEU0Vmp5MmtqRTJYNUF3?=
 =?utf-8?B?Q1YvREJ0N0lHdTZZaXVWbmJhcll4VEVVRVVWS3hvN0RGeWhzM041djRjV2hM?=
 =?utf-8?B?R21rdm5NMFBzdTltUmhPNDJrcG4wSTFKYXRXTHVSdnl6cU9NcmZmMzFidHk0?=
 =?utf-8?B?dEJ2SHVCb09wTTRhd0ZGQ2pOS0M2M2NRd3NaQmhsSkVFVHRtTFI3S1NUdC9D?=
 =?utf-8?B?MnNSNC81MENHY1hlaXE3YnBDNXFQMDlpcjdCWS9ZYWVibytZL0VGOXNLR2tL?=
 =?utf-8?B?UG5KU3Q3cldVR292WGVNSDBPeGo2WVBuWlhkYWxlQ3Q0TFdWTVFEL0hJNnlh?=
 =?utf-8?B?TWkvNzA5WEJpWFdNaTJ5S3ZtSk03elh2M3JoTUwwUUtUWlpwR1QrcktFdWNB?=
 =?utf-8?B?TnlhdnRMZGhjUGtOeHdQWXUxZkRZOGNUbXZ6VVFDMFc2S2Uwc1BzSEUzSDBm?=
 =?utf-8?B?UGlWMllldXhtQ1BLRmg5RUJYYkdyWkxpbVhxN1Z4eVhYWkkybnc3SVMwYTFV?=
 =?utf-8?B?eHJmdWE1eThpS09INzZSRm10bGE5dTRnUk1pOVNCQjRaT0VoM1dGTm1EN0Ni?=
 =?utf-8?B?VW93YVJhelhqbzY0K2RxMy96SmUwMExjYmZEM2psSkd3dEdaazA0NXB6cklS?=
 =?utf-8?B?djd6RlFmemF4MzlUSzFFWWl2N2xHdWQwRWEwek9yQ2ZVUjU4dk1mVFNSNFlk?=
 =?utf-8?B?WE9EZVpROWl4dkNrL2sxeURrZi9XYnRlQlJpRGxFNllxVXRnN2hWNzFBWjk5?=
 =?utf-8?B?Wmk4YzBCQWF6ZkNEdDNrc0hMT1ZYU2tOME9zR1Y1SlRYN2pIV25zWnRodVVF?=
 =?utf-8?B?bGxKUkx6NVFIRU8zaHVBN0JDa0pDU3VOSW10dXpxOGo4VmUwMmpTOG9xZlVa?=
 =?utf-8?B?QUx5T2xUY2MwMUpheEFodlVzNGZNK0cxY01CQXJwbzVhSjFXallBTGlhRmFN?=
 =?utf-8?B?bnVuSkk4QWJSMis0OVFqMk5oWm5DdFJhclpqYTQwL3pUUVZKRENuRVBEY0tj?=
 =?utf-8?B?WSs1T0xEWlBjRUZqa3BBeGhtTlBTSmlldzNPZzVDQjQ0OWZsbVRua1JIMkFP?=
 =?utf-8?B?ZEtzN2VpcVRSOW8rRm5KRHh3Rkc4bHdnMXNxTjBoMkhnOXNCOVVRZGJweWZ0?=
 =?utf-8?B?SUdObWs3WHFUM3FvVnM5K0lTYk5tTUxmanovOG9pL3pma3phbGExTWp1eklJ?=
 =?utf-8?B?R0NRQUVaaUY5bk9VRXJlVU1RTjZSZXIwL2F5djZzR2pFenQ4clo1T3ROeU1v?=
 =?utf-8?B?SXNVZ1pta3NWdTk5R2tGajBOdU5SRTBSbis2T3FCVkJVSzNURFZKcGh3N3Nh?=
 =?utf-8?B?ZWtBWUZsZGljaWpmK0NPbVBWc1kvMkZQdzU1c1VtN3N6eDNyRWRIYzM3RVZC?=
 =?utf-8?B?OUdwbEM4WEttWE8rdCthL29rcU5xY3lYZmdNMnhybjlYU2FSdjV2dWJrTmhF?=
 =?utf-8?B?VTlzdklZM05mWkVvNEYwQktuOHNaSlZvTUY4YnFUMitMcVRkYUhyODZNRmN4?=
 =?utf-8?B?Sk1uOTVFcUhLbllaYkF1MVNBT3VZYkdDYllJVkpLaFFETmhvSjk0N1NrY3Bs?=
 =?utf-8?Q?eXobiqJHVPU2E8DYRoydDwebw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724197d1-dd34-4309-57fc-08dc5925afde
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 06:15:58.1394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPZHkuWjClLXZOuGV0N0vHKtEcdPd3jJexAaHlHLSSlCnGVbwWt8ugC0LAVpzqJU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8003
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



On 4/8/24 22:13, Charlie Johnston wrote:
> The zynqmp cmds.c is currently tied to the board but the commands
> contained within are more closely tied to the architecture. To
> allow usage of those commands when the architecture is ZynqMP but
> the board is not, this change moves the cmds into the cmd/ tree
> instead of the board tree that would only be included if the board
> were also a ZynqMP predefined board.
> 
> Signed-off-by: Charlie Johnston <charlie.johnston@loftorbital.com>
> ---
>   board/xilinx/zynqmp/Makefile               | 4 ----
>   cmd/Makefile                               | 3 +++
>   board/xilinx/zynqmp/cmds.c => cmd/zynqmp.c | 0
>   3 files changed, 3 insertions(+), 4 deletions(-)
>   rename board/xilinx/zynqmp/cmds.c => cmd/zynqmp.c (100%)
> 
> diff --git a/board/xilinx/zynqmp/Makefile b/board/xilinx/zynqmp/Makefile
> index 204e4fadf0..9ab50eca40 100644
> --- a/board/xilinx/zynqmp/Makefile
> +++ b/board/xilinx/zynqmp/Makefile
> @@ -40,10 +40,6 @@ $(obj)/pm_cfg_obj.o: $(shell cd $(srctree); readlink -f $(CONFIG_ZYNQMP_SPL_PM_C
>   endif
>   endif
>   
> -ifndef CONFIG_SPL_BUILD
> -obj-$(CONFIG_CMD_ZYNQMP) += cmds.o
> -endif
> -
>   # Suppress "warning: function declaration isn't a prototype"
>   CFLAGS_REMOVE_psu_init_gpl.o := -Wstrict-prototypes
>   
> diff --git a/cmd/Makefile b/cmd/Makefile
> index 87133cc27a..7afb1c9a7c 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -232,6 +232,9 @@ obj-$(CONFIG_CMD_SCP03) += scp03.o
>   
>   obj-$(CONFIG_HUSH_SELECTABLE) += cli.o
>   
> +# ZynqMP
> +obj-$(CONFIG_CMD_ZYNQMP) += zynqmp.o
> +
>   obj-$(CONFIG_ARM) += arm/
>   obj-$(CONFIG_RISCV) += riscv/
>   obj-$(CONFIG_SANDBOX) += sandbox/
> diff --git a/board/xilinx/zynqmp/cmds.c b/cmd/zynqmp.c
> similarity index 100%
> rename from board/xilinx/zynqmp/cmds.c
> rename to cmd/zynqmp.c

I have no problem of moving these commands to architecture and when I grep
git grep U_BOOT_CMD I see that commands are defined inside arch/arm/mach-* folders.
That's why I would prefer to move it there instead of cmd/ which is supposed to 
be used for generic command not really soc specific.

Also please squash both patches together and do it via single one.

Thanks,
Michal

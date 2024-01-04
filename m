Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113CFC47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 12:47:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 382F3877BA;
	Thu,  4 Jan 2024 13:47:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PAaQxiQC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 713BE87867; Thu,  4 Jan 2024 13:47:11 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04CF987756
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 13:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLSvFKcBHCmia9E2fO6TjkHqCXbI9Q3/qGdmRf2mYIKhoSeNdFEdTNCO4AV7ppvZ3FifmCsQHjCaJeb1nM+BKBRPoK1lV00vZIKr4nHEhI4PwUk6hq8ZvI40Y3YnD3QUm/LEQaL0jZq4gRVMMjNJKcquG4DnVUbrPK0Yg1o+a9qIxbAFHY8cOXAiH3Jtc/F+tl3QbgYUOrWXKpUjm2bwoQKSQ1508UHW2kikyj0IITwR0pJVF2/z1IpXrDJRp7EKXftC09yPEQxIzg1Ao5NsQAbZie/i2MiDcFE1AzSHHYNfN+V7Ibxpwj2K2Pqli5xV7YUoii42mHHB++SUu+Qc0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQ3U129tpTWbCclHkMJHZKsSfZf9LfnIaaWEjwR0IVM=;
 b=ckU+u0+TD4WvrsV+11vBvaw4JgrCW3ya139PunwV6Pv+MK4B7Vt7WLBZkC92whtATW0rNhS6ODsPxDmU9RZdBB0yYvoY2Bpm8ieHLylGxNZJZH+5WT768dH9cDr7zShwIkeaNfhJXIWzbHcn44SlFHQrM3txYiqqjvlvrUd3IgFSnTQzijwVJslpfCzKTUptJDIJheYP0Qg/XkI7fCzr5ExoU+NYYgGb8W24+DrZrmr9ckg5eo3OObteK7oeogzkajxmdTXydWp5cset25BpKUk4702xaBG67vchThnFsOJNL98TCfWz6cKY+5+js5o8DgIvqY01BI+y6QikV0wm6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQ3U129tpTWbCclHkMJHZKsSfZf9LfnIaaWEjwR0IVM=;
 b=PAaQxiQCHmENl7qIkNMijW9MD9KkqyWtEXLpO+uIim/SyM5T+wVIx8GYtVZkZxQrM2Jc2VfZF/3IsqnyMyrcqy9pIDcSmlTWk7YCbVNgoqH/e84hkVkZb8vnJrTuBTJk57EcqyEjUKZ4cvwwp/XQhLIPIf3smkKZ6c1WzQgcE/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by BY5PR12MB4226.namprd12.prod.outlook.com (2603:10b6:a03:203::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 12:47:06 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 12:47:05 +0000
Message-ID: <bbf14e1c-66f1-4d77-b977-98156d1cf2f8@amd.com>
Date: Thu, 4 Jan 2024 13:46:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xilinx: Enable the NFS command by default
Content-Language: en-US
To: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, u-boot@lists.denx.de
Cc: venkatesh.abbarapu@amd.com, git@xilinx.com
References: <20240104045217.2966454-1-tejas.arvind.bhumkar@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240104045217.2966454-1-tejas.arvind.bhumkar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::6) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|BY5PR12MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a2de78-1b1d-49a1-f18a-08dc0d23418c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UeMzAa8DBx0n7eKVyrLLnwTMwhTvOy4tRMoW75rvUQWIkK4xXmDTSA4jWVsjRJV+Y+1MatbLr2GrDnCri8ckD6GqSoppa6dm869FjrAjpR4lBi4zL8OEPAKQ90u3g7gzg8bkKZDQw3cAfpCxw/nZ6kVpM+5Viqn77IJ1hmYiZPTBxWKMLaEjDwIFQCYWYUugQAtkh8MWIM/0V3gU3AHIn1srVTGmAvGCrnRNpLF3Cmp4/yGn/9GUtynxwLaTnFNNk02U2WctU/yrtLAPDol023u/NPSrVYYlGH36UpustKuz7kwbDkHrMS0rdwQOYVEAv9T75atG8p2/hNiqf9jg8mQo3T/AmQC0ZjP0s4axIDPWiLDd3ZWAF1tbJzv1MG197gdbrAT9yZWBFf4640IANIZWElyPoICQpc+qqzsmfzB7QeP8s8If0SoOEMA3ejSicg3mvufXHGBRrTzPF4gcGcrKaPoWOsiw6zzRXNUJHf6Jrk5N0g2SQ2y/rwxdZB4Hj2laub3ujYNXs5juq5bsSXIWCUseWyX5jD/1yOEHtWCvoSkjeMj5RO4VkFMyAG6Vsg5+iVZ7CZuQsHApFaEI9m2Aiugd3kYSnVkxzgM8+n/+PSGSAe9PmHq3Og4A9cOMgqnecdEZvIoKlcaxuWcRcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(8936002)(6486002)(8676002)(316002)(4326008)(83380400001)(66556008)(478600001)(66476007)(66946007)(44832011)(6506007)(53546011)(6666004)(6512007)(2616005)(26005)(41300700001)(2906002)(5660300002)(36756003)(38100700002)(86362001)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEl0MWFrWCtwWFVPUlhJbHVBYndYWXZqM0ZzUlgzZlZ3ZkZPK2hoTWxaV0ty?=
 =?utf-8?B?TjFzOGhHMHJlMFo1NU1mWVJvL3pQTXJyemkybTRveWRNN1lZN2ZyTDRpbFpw?=
 =?utf-8?B?b0tmMlFyMld1RjNsaXlJZURXbys1d2h0TXRjTlNOTHQrUGJWY2tIcW52VDBS?=
 =?utf-8?B?eTFyQ3ZYTGFpRGR0bUJwZjZPa0t4RVd5bkpsMU5uaERFMG9VanZBcCtEV2tP?=
 =?utf-8?B?UDVVUWEyRUVDeTkzZFVPTzhreXQyazFYQkRvdGtYVVVjU2Z4VGgyd0VRbE9W?=
 =?utf-8?B?NnpUbzJkUmw0VERsakJGcFBSeE1zY0VWSDBFaCtGZy8wZyt4c3pWbzRQK3J3?=
 =?utf-8?B?YWpKMGM0SG94QWdla0hjWnovcWhQSWNXaG90SFp5c0tkaTJmTEtVRXRLYU03?=
 =?utf-8?B?MUtDVVM3QWhSZWk5M3hBMGJRZWFsQ3dTU09QUFdUb3l6ZTNLTThGeTAzTy91?=
 =?utf-8?B?NVpwNHdzN3M5c0NoVjlzV09FOFdSVlNKL29maENvUSthNHdFbUtMQzlxK3ly?=
 =?utf-8?B?dXdsbVplMzRqVmlSWk42dGhXSTUyakVsTmxQQVZVZHZTclY5dE4xNUxjeUtJ?=
 =?utf-8?B?WXFHZGlnSW05SjkyVjF5aFBNZlByU3hIMG93K0kzMVVLODc1Wk1MMThVTWd4?=
 =?utf-8?B?VmpnZC8yamxqV3Nlb25QZlQzYkRhbmh1VW1YbDZaYm4xeTVpVExoWjdyQ1lW?=
 =?utf-8?B?Nk12eG53ZU56S25VNWFQalhtMTEzZElzWGN4Q1ZoZUNQa1Z1UDBBa2NWL0dC?=
 =?utf-8?B?T1pvTnBXdE9xRm0rbmozeUdoQXVwc3BOYnNVL3pwZnRQV3lBaVlQTTBqNVpS?=
 =?utf-8?B?eHNNaDByRVVkSG45R1VlblNQc2NPRTlxWHY3aWd5OC9RM2V5Z2s1SUZlWHNF?=
 =?utf-8?B?UEZrdFJKTlR6aytVUG52SmRIaUFzbnBpa29xNGxyaGtUdzNiOXJaeStRQnBE?=
 =?utf-8?B?RTB4Tm8wbXJ3OVVNRlQrcDg0TUNmNzNiNUMzaFhsdldOaFBNMmppdS9LSGs4?=
 =?utf-8?B?MCtVNFlUL1NaS0g4ZTAxYjFYeTJZeWE3K3h1N0VoRTU3UXc5bFQ2Z2VObk80?=
 =?utf-8?B?ck5UVTZxT1BDK2t4WEFWSE9ZSks5Ri9vS1lCaXdBL29TNFFBUlI2eFlCamY0?=
 =?utf-8?B?dWtXOGR3NmZqSjhmaDlwMG1xRUlraENKR1N6Qi9HMEJ2Zlpaak1lVVFxeEc5?=
 =?utf-8?B?dHJzZzJ5RThFRmlBWmsvMDdYeDdZUWJnMjVRZWdJKzVsaVV2ZHhvMHl4dFJw?=
 =?utf-8?B?cDMrUlVHNHRjaGVBeGFSWXdZVTQ1RTlXSCtYMjB1VGpCVlVZVjBGOTVWc0kw?=
 =?utf-8?B?MFNVLzBMZDhQRk1KMkxpV3YzUGEwMGNFQUlkUGt4Q1hQU2NGektFdnd5VVlS?=
 =?utf-8?B?WTYxTHJUU2FMZlZwM3hwMDl3clA3MWR5d2xsVVhLcTd6K0p6Y3pPYmd3Y09n?=
 =?utf-8?B?NnpFaXhsQ2dtNHFQTXVhTHRuekxkRFVYT2ZWV2F2TW9meXNKVXZZR1FUVUhw?=
 =?utf-8?B?TzIrSmZMblNmRE5xbmkveU8zSEJaajNqcElEMEIrR2VTcjljRFFNbW5DSjNN?=
 =?utf-8?B?YmRRQzhnRkFYT280MENiSlZWK0N0SjkrRDM3WGovM1ZzRnhDRXF2WUxCN2ZL?=
 =?utf-8?B?ZytaMkhvaElUSVB3UC92b0Q3eFFnMmZVN1BTek40RWdNejhVMkJnYnpuZ0c1?=
 =?utf-8?B?UW81WEhhemkyV000K254ZVBvaS9ieEhIR2MrRHp5bkVGT3JiWHZtdVJaelBD?=
 =?utf-8?B?V2VyZE5BZ0s4bml6MEYxdjNoZTU1eldXUlhwbERTRTVEMHhIamhxc2t6VnFC?=
 =?utf-8?B?VkNGQjk1UUtCNDJBdW9mVUdYblVoZ2tXRFhQYTF0V1BiVldIMVMwZ1ZRaTFT?=
 =?utf-8?B?dHQ4SVB2KzF5SkJJU25OS3FGanFITlhpVEY4UkVMTDNHWGJPeTI2TU4yc3d6?=
 =?utf-8?B?R3FyWXVZYWJvbzNaOExWaWxYZHVHWEdTZk5Ha3c0YmIxeGV4YUl5TW9GckVW?=
 =?utf-8?B?cldrZkI0SElIT1BqanZSUEY0Uzgzb1VwaUlxRWFSRzAyMzgwSmlkZlZtVVdM?=
 =?utf-8?B?OXBROFhWTFViaFkza2pMdTVJc1BnR3ZKY21LWHhuaEVmTG13NlUxcElCNS9m?=
 =?utf-8?Q?Dj2DFNpehPfU73DGzuPT6MJek?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a2de78-1b1d-49a1-f18a-08dc0d23418c
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 12:47:05.7006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dnZoyfTWe4Qf1AVcb5rvIZqmX/iJ95vVawpr/V91vnRA6OYGWP4DOd6aLYQANzyM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4226
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



On 1/4/24 05:52, Tejas Bhumkar wrote:
> Enabled the default utilization of the NFS command across all Xilinx
> platforms to facilitate the booting of images through the network
> using the NFS protocol.
> 
> Fixes: 10de12570799 ("disable NFS support by default")
> 
> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
> ---
> Changes in v2:
> 	- Updated commit message
> 	- Removed CONFIG_NFS_TIMEOUT config option
> 
>   configs/xilinx_versal_net_virt_defconfig | 1 +
>   configs/xilinx_versal_virt_defconfig     | 1 +
>   configs/xilinx_zynq_virt_defconfig       | 1 +
>   configs/xilinx_zynqmp_virt_defconfig     | 1 +
>   4 files changed, 4 insertions(+)
> 
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
> index 0553ac6b17..95743c0c41 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -46,6 +46,7 @@ CONFIG_CMD_USB=y
>   CONFIG_BOOTP_MAY_FAIL=y
>   CONFIG_BOOTP_BOOTFILESIZE=y
>   CONFIG_CMD_TFTPPUT=y
> +CONFIG_CMD_NFS=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_EFIDEBUG=y
>   CONFIG_CMD_TIME=y
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
> index 6a2c03ccdd..5a858537ca 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -48,6 +48,7 @@ CONFIG_CMD_USB=y
>   CONFIG_BOOTP_MAY_FAIL=y
>   CONFIG_BOOTP_BOOTFILESIZE=y
>   CONFIG_CMD_TFTPPUT=y
> +CONFIG_CMD_NFS=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_EFIDEBUG=y
>   CONFIG_CMD_TIME=y
> diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
> index c3ee9beaef..136b497ab6 100644
> --- a/configs/xilinx_zynq_virt_defconfig
> +++ b/configs/xilinx_zynq_virt_defconfig
> @@ -70,6 +70,7 @@ CONFIG_CMD_SF_TEST=y
>   CONFIG_CMD_USB=y
>   CONFIG_BOOTP_MAY_FAIL=y
>   CONFIG_CMD_TFTPPUT=y
> +CONFIG_CMD_NFS=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_EFIDEBUG=y
>   CONFIG_CMD_TIME=y
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
> index 239bb1f5cc..7192b2301f 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -82,6 +82,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
>   CONFIG_BOOTP_MAY_FAIL=y
>   CONFIG_BOOTP_BOOTFILESIZE=y
>   CONFIG_CMD_TFTPPUT=y
> +CONFIG_CMD_NFS=y
>   CONFIG_CMD_BMP=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_EFIDEBUG=y


Applied.
M

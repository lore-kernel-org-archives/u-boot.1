Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A044F433E0
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 03:17:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D3F683C2B;
	Thu, 16 Apr 2026 05:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="luXoDUD9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA2CF83EEF; Thu, 16 Apr 2026 05:17:19 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5044B83015
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 05:17:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScttTCI31kObifx/Rt70/DPBS567IICHki0GLyHTVynQD2l+RcAA7wXI5oxgdlIn9J4F57mYN/2wrqhUOGxktsb/jk/aAzG6+z570KuHyyMHmjVRhq25xrWx3bo7fGMGQsBnGbPdhugrLbqBD1GUquBNVndUfBUqEmvHrV4K/tdg/AaEg/BveRQ/bZPpW3D2hdqj4yQFdsHzLNnUxCS7H8aLf0A5wALCjenaaIJ84qBG73SgvcfC+m1rcDR7TViHA2lhEafOOWf+Ic/AiyZ8C9vpoMXcxSUIZbLwIpvKeqFECmRjrSiujUrh8Mx1HwI3U40BSkr31h8UiH3JS+jzhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7T6zYON/C8fZ0F7ueq5ynRVlWiocp0mBwSRdDAs+PSY=;
 b=L2EfWJ2Z8zjTB5I5nr6USblkSokicYKJmVBQ5R382cFfvcQXN2cmJZ50YasxZOMOGY+e9MhrZT3b89o+tKlCVB7qqx/uTZSE/BiO1BMVYEAMAzB4iH4vS3Hssku5jMV78z2i4fABD5gVrkpJCf9LgKzi4ChUB828B+YKc1AzZ4ZSDdfVwOeipIs+v0Z6jBLJl4DcXf5xc8uT0xj54ZJYNUF9dI3vnkjLG338RsK9X0o7GAQWT8MPlxkQ67zDhF/lhngENEUQefHAPp6ykBR7HkNAzwdEmgG797s4MiG09ylIOqRpqHva32a3E1uD8DvuHsx+wdIqiuqdY6zDyn5sPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7T6zYON/C8fZ0F7ueq5ynRVlWiocp0mBwSRdDAs+PSY=;
 b=luXoDUD9Q4eRurKeAVWtXF+ZSmL3t6L5A5jLp1BYrWg8/KTOaAejuIW8VWV48l/D5C5clg5KiaVnIfFNHbS72k+3/KvU+Fulfzr22u0G44XW59KaIUW/8vG+tsgD5EIr8ydLgzLStxXgFx6ddGghEgqFllTufty94nim4CdiUy+FnIx7viNVUSkdJzVt9a2ZL/JNQyMSviyk1f2EpdytgekdIsxZDR++XMxm2tzkg1N/jfO1mBlA8/FKt8YBaPaa27J9q9CvjxSFQDAjurM5KbCmXPyXSKLjIdC3x9G4K+oNWzzoeNfu5SkEwWGKZ2FfJ3WExG5e8fuQgyToS60IxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DS0PR03MB7250.namprd03.prod.outlook.com (2603:10b6:8:115::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 03:17:13 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 03:17:13 +0000
Message-ID: <fae8a67a-e8d7-428e-806c-7cd9e6c8653e@altera.com>
Date: Thu, 16 Apr 2026 11:17:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] configs: socfpga: arria10: Disable
 CONFIG_SPL_USE_TINY_PRINTF
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Simon Glass <sjg@chromium.org>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>
References: <20260305055804.21580-1-dinesh.maniyam@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260305055804.21580-1-dinesh.maniyam@altera.com>
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|DS0PR03MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d3eb89-97dd-4db4-91bb-08de9b66a6ff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|55112099003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: W/4r5DkUgncOlZiuczl57G2G5ODZhVy5w5rkov6irXn+bD1sUx3o7bcwTIstNpCqFGX91NaxB9JrU6hW86Ajfnggcnn4sk64FuIr8HL5BcEGb9y7EAik88zewGTzIl8tsv4AxSeI2n81Hql4bo7/PWdUOhID9Th2zkWTge/OMEjd51Jk5vvsYUWW1YeCnPL92Yt5mibrxw961xIVj+MyXPcVnEa16knM31P9lrVkfC+tELNwHiHoIsVEpq58YygPLjAEDwyhsYsgdV5XPjGnd0ynO7T1KlP76o09p1svfCEfZaRXVh4pR2MfDtQPOeSWcZo/WuddSWUoTOVUyBxC0UA9/Y3U4Q9NswD6oJUHWYti5MqriY6FcpM9zKKdmHlZLnBmXH3/JeNYQ8EBIwhhbQ8dDaiJHdWb53bfzHWQuJ4djR3pGfdUvtIu3x70BaEcFIO/5Y5e6q4djxrmU44HEH/ANGPrXyOMgw6ORJO2e0vvYUo8K5r3v45WrSefEVhqRuTFO4WPzsMR4c4qHlsVNQMb6+PuKl3NAqCuk5GjxWn9tXqoaoMELQSoNJ7oSxuOEFy+yD3SW/GIhDz9vubSg5egxlvvnR7LlAvhKFWcEJ2qkE7PeogWOhDn7fYk0WS3+71OlJTLxfaZyxQRfFds12GwDvAadZvksu1lD/9YxEG22lfqsGZX2182M95zH5uBMdn6TG0Q3UA8P15zXkjMWDwfzdlQ/3g5Ide4A0IL0t8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(55112099003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1F1d0VsUm4yZ29nYXVZU2NPY3NZZGpPczI3Vm0zVUlEQ0lQZGwvMDBDN3Z0?=
 =?utf-8?B?K1VLR1B1MEdTcFJXa3JjNmF2YnNDb3M4bXZsWDEvc2dYRUg2V3BXVG1uaXB3?=
 =?utf-8?B?Mnl1VXZLYWxWZTJRYWh0VGMxZllBQjVGV0R3RzRld2taTjVkZG1QZmwxVWdr?=
 =?utf-8?B?b2c4dVhCc2pCT0I3VWxCSVExVTZrdHM3MFRackNhekpuSVAzTkFqdFZyYXBx?=
 =?utf-8?B?di84VWN0Uy81V3VBK2hNSzZzazRVTFcrazE0YjB2VzdSYk4wWmxZTEwyVVZz?=
 =?utf-8?B?SVRMZW9MR1ZWNmpsYXhNbmJaQXE0USs2Y1JRNFF5V3hVOU9CaGdPR3lCUFcv?=
 =?utf-8?B?U0sreVl2MnhtWlVmaDd4N1F4RTZpWXN5ei9LUURrYURsTitXdUVqNU55Snh1?=
 =?utf-8?B?U0JXNzhtUXBYdkxYSERvNTQvYng2RlcvZ0FOV1RZNVBYK3ZjU2ZPOE5pZ3li?=
 =?utf-8?B?R0pWeVA1VGpkdkZTT3RtdWlnOVZLcVMwOUNvdlhjdDRkdzgzR2NzMWtQT3ZO?=
 =?utf-8?B?MURNZERVdjFHVzFUOU54RVovKzRmbXNCUWRDZkRHSEovNHo5aU55M0s4UlF5?=
 =?utf-8?B?aGNIaXRweStQQnJLT2UxM0tEWnMvMlgvNVIvNkxCMU9PM2JUanNocnFncXhZ?=
 =?utf-8?B?MGxzbUV5ZmwrMDZrdXAvSEhqNkR6SnhVZXpiaVo5TFFubkYydDBxYTd5UW9j?=
 =?utf-8?B?dElKMnJEYkpoL1I4dW5UNEZmd0d4eUt6eVdDb010WXFnTFB3OVRCbmVnd2hZ?=
 =?utf-8?B?bTJoTE03bTJKRTl6WGZUR2pDREw2dXFrc01RQXJZamNRV1BvVTFKbDFhNlNJ?=
 =?utf-8?B?WUhmRm52d2JlZVFXY1ZqMkxibDBBM1NiVFJqYmNrbjNOZkdCRVR6TFVUQW9w?=
 =?utf-8?B?MkIxcHY5cVgwblAzUHhqcTlxS0cxd0pwUzNDY1NnWFEyaURuMEZYSE8rYUlv?=
 =?utf-8?B?ODI3Z1ZQK2grZFZoK2pkNXFnMjJuK1plK0VSaFZXZG43TnZSckVMbEkzUWJ5?=
 =?utf-8?B?TWVUMzd3U3h6eG1NdzVDNW1KSmF0RjNWem01TGZXSmtCZXdxS0dKQk90RzVr?=
 =?utf-8?B?NTlXUnY3ME0zeTByS01oYUlpdjBDNG9UdlplZ0R6cjc1NnVTUDZ0dGEwSU9h?=
 =?utf-8?B?MFpPNlEzdWtGa2w1dzErZFp1QVlXY2dHaHZCUE1SSHVhMnlWaHpUSWtqaGJL?=
 =?utf-8?B?MmQwWDYwYnVpcXg4c2x3b2N0MXlqQVNGems2V0dYS05KZU5ObmtjQU5Ya0tv?=
 =?utf-8?B?RTFqN0Zhb2R2NU1VS3hrSWdlQ2hITzJMSFVHWWVjODVQbjJ1ZXpsMUtSNDJz?=
 =?utf-8?B?WTc1SDVCa3lzNkR4bzFoOU1YdXpIY2ttR2pHWmJ5aEJsRnhyVjFMQVRQY1Bh?=
 =?utf-8?B?UkpLSlZDRDlTd2VBblFReWY5UGNJTFJhQzZjd0JpQnpLdDVEMEdVT3Nwa0t5?=
 =?utf-8?B?U2FuYWdiTDBzVmMvZ3J5Y3NnTHpKUERpTkJJOEI1NDBrYnRlVExrN2lHTDEy?=
 =?utf-8?B?MkN1YUJhQ0ZjR3p5ZmxNSkY0bUNGOEZnSUFoTjBoRlIzVWJuekZoWEh0WVBZ?=
 =?utf-8?B?c1ZQbis5MWZHZmlDaHFZblplUS85WHhldTRJeDVJa2NmV0FMRDFOSVpzdmJC?=
 =?utf-8?B?Vjd3UWpqcFVxSHVxSjZCMHlUSkpaSGI5cWF0U3pzUkxLb0h5VDVQRzhOYlI1?=
 =?utf-8?B?bDdJRTh6ZXNrL1g3bHM5Q0RoWCsxQ2xlc3RxT1lBdHdkTWYrdWdvc1FYWVY2?=
 =?utf-8?B?d3h3Nks1QlVoTVpDZlhQQVg4M1lsK2xBYzJtMVR4ajI0TTR5ZHFUeEVGOU05?=
 =?utf-8?B?RGtmczhuRTd3bkI0bUpPSDliblVPSzVhalhwcmJwZWl0aFNja0h2Vzl0c0Qr?=
 =?utf-8?B?WXNOSDByU290QkxRRWdFOG9heE0wcERUNDRFbTFZd0ZXZ0cza0g4MFE0Smgz?=
 =?utf-8?B?NDNvdHU0dWxnVUlVWVlmcnpDQm5GYnYxcTRQNzdCZUpkbm5YK0wrd2pWQ3gv?=
 =?utf-8?B?NEZVZFdyYzZwdFVUcENodlFRemJaclFpSWlVZmM0Y3dPOTB3anhha1Z5Zk9U?=
 =?utf-8?B?TTAza1hLU2hzRzRwSkVGTFJxcEpTWjU2ZkdUM0hPaEVmNVhOUWlhZzVFY2h5?=
 =?utf-8?B?aHJTb0J3Y0kwSmNybUc0anBFUUE4OXNIdlQ2RjJvMXJ3SGxCQmlJZDhhSEVO?=
 =?utf-8?B?Z1QrN2pNZFE0RVMrY3QzdU9OdVdZV0FYSGU5REI1QU5SR2xEdXF4c3E4Qy9z?=
 =?utf-8?B?bkVMT0VnbG1wRzBDM3d2UWkyWnNGTzVoYmRNVjR2bkpWUlduU1B6OTljNDVp?=
 =?utf-8?B?YWNJb3NlMDdRVi9wNHFjY0tYVUV2VDRVMHhrR0Y4eHVUNEQ2aXpOS0w3VUo2?=
 =?utf-8?Q?EPXVh+7fCuttfnyM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d3eb89-97dd-4db4-91bb-08de9b66a6ff
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 03:17:12.9686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezYdyVqRGGqw8DOtQnxRoW12oNZM4agcCpo4lJbGRLB1eWSHLpkfj1NMH+eg/Iol/DH0uXFDu4mQ3Not6WP2U3c4rCczw5tbfa+28oJslAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7250
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On 5/3/2026 1:58 pm, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam<dinesh.maniyam@altera.com>
>
> CONFIG_SPL_USE_TINY_PRINTF is enabled by default, disable it.
> Arria 10 has 256KB of onchip ram and it is enough to support full printf.
> Full printf allows us to have more complex format printing, example %ll.
>
> Signed-off-by: Dinesh Maniyam<dinesh.maniyam@altera.com>
> ---
>   arch/arm/mach-socfpga/Kconfig     | 1 -
>   configs/socfpga_arria10_defconfig | 1 +
>   2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
> index f2e959b5662..ba01ec08be2 100644
> --- a/arch/arm/mach-socfpga/Kconfig
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@ -101,7 +101,6 @@ config TARGET_SOCFPGA_ARRIA10
>   	select SPL_SYSCON if SPL
>   	select ETH_DESIGNWARE_SOCFPGA
>   	imply FPGA_SOCFPGA
> -	imply SPL_USE_TINY_PRINTF
>   
>   config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
>   	bool "Always reprogram Arria 10 FPGA"
> diff --git a/configs/socfpga_arria10_defconfig b/configs/socfpga_arria10_defconfig
> index b32f40ae408..74ec07cf3e4 100644
> --- a/configs/socfpga_arria10_defconfig
> +++ b/configs/socfpga_arria10_defconfig
> @@ -69,3 +69,4 @@ CONFIG_USB=y
>   CONFIG_USB_DWC2=y
>   # CONFIG_SPL_WDT is not set
>   # CONFIG_TOOLS_MKEFICAPSULE is not set
> +# CONFIG_SPL_USE_TINY_PRINTF is not set

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com> Best regards, 
Tien Fong

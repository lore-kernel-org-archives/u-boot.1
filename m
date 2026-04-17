Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D491EF8E4B7
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 07:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20D0983FC0;
	Fri, 17 Apr 2026 09:44:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="haUPUFyu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF4DF841C2; Fri, 17 Apr 2026 09:44:17 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D49C83015
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 09:44:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpUo2nLEoEAYLx5lyt1P5HW2vAtQVGI2O0EKzZbDzkE3CXEqrfXaihRNkYT5f2Wpwgdpe5duhRMZmbf9oWUkC3HXrp2BKdyiMi5gtvBayhFPFukPd2u8DYE2JpqxEiqCFVCtmH39xoCKEEIvWmi1JXHJFTMtwJ0L/0NBulVbyEPrMr/IJYNf4DfYR+aswE5nyU+NrV0t7ytEPr/7mGLk/wst7i2tWskMIvbZx9ny7Me91FdvgOl5l7R2Bva9GVTlCsVQuBpq+fbWvd+defnoJQg7Q+5YkwS72lq6JS5lUTYvfZgpX1xyZgB7vhCwJSwAVtkTw3joPzmYkWXb1umLWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNQp6IoSxIBSxb1EOaUw1ic9QB/nsvICI4iib96XC5E=;
 b=s2CocoPOzWDnA9Zk6lw4L0OCNClhKCoFiNYTUjKSAlooVUzoM/tjxgF0n9TotZjAyOT3WytbH4xoSzqnsjnt7jQMQ/lgSEDT6jj9Ju8Xf0EiSdl4kJjHdTbDczAWf0DV8xswmmsDMoBxSGULoMeSmtYWe3NfPh7k+ffpnDo7uEH8tbpcACvR4hXv8Z4n1aLGK3CHoXKoDVgWEGzWvZ2lNanUGo26OFXwfTUbzh+BRqeYfwKX5aoZ1TTuEk7HUQqFh2uxByPE1kWwwNsY7MN46Bmo/zmdBbTouvCWo9WJrFUrwfmheR3rvE8P/I0+w9nIOSGdaPZw0jKlSwz42wEn+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNQp6IoSxIBSxb1EOaUw1ic9QB/nsvICI4iib96XC5E=;
 b=haUPUFyuNKoofRP8MGSiSndcRboS701Ym43S6gmnKv+3mgA76+CM1WV1wtes89N2AetbNLmQa6m16C5FMI4xI0gjlQvyGy5Z/mxFLCnSUb9IMtthh9S2dqjjgOjZ9B2GUyDnPJ7JxsnCOXrfqCm721wdI4IOrjXGCficVXDMMPTFMCPQpIy/iwKT8sBcEHQ727XWIyzRBmAORmEn/YjH2FVHEoy8ZFEPbswaCLDRE2+Ok3HU3Kjf0kwKiG4NQ+UcrSo1fDGfbTG/gyU4oKKICbhSNdg36Upr465rOBVJBOR6ANDKjZx2BOWzJ1wlB9rxc7bZxNFW3fQnsodNaM6nag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SJ2PR03MB7354.namprd03.prod.outlook.com (2603:10b6:a03:567::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 07:44:10 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 07:44:10 +0000
Message-ID: <4d44be5b-1446-4be2-8eac-2e1fefb8973d@altera.com>
Date: Fri, 17 Apr 2026 15:44:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] configs: socfpga: Add QSPI support for Cyclone 5
To: Boon Khai Ng <boon.khai.ng@altera.com>,
 U-boot Openlist <u-boot@lists.denx.de>
Cc: Brian Sune <briansune@gmail.com>, Chin-Liang See <clsee@altera.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260318104018.2261-1-boon.khai.ng@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260318104018.2261-1-boon.khai.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SJ2PR03MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: ae9a15ac-4f02-457b-975a-08de9c551c67
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: RUmHT28Mtxp3vurPFzXfQLzKwuLvyyV00ATQx6wTA63h56qzyDxbztp//4NfsmBvkdIFHOOqjMv+xkEL4Q+FhKwRLJvdP1VVpNVRxSVTllhocAffroQK3KgLNMsISh8AB+rdagAoCJk0Una2CcafLBD8Lr1376Z0C0dUguhzxGdX7FsY9QZ929G7AyMsk0XLHqr8Il9dAejTeJl5iygQRuB/FX0u8wV8DgzqxP3GQNtERL/FazqMTPH2gol+3D58g5JNscZOhZP4tl4ShtyOG++iA5WZyP0CPNrwJm05/WMEco3Mihd91kb71/ALJgZxgH5dvrAKmNSIubMDQ6yseL4dB7on3aaTMheUdsb2L9i6ol9zR78bM5Pc9sfXjrIC2poJ5IguyoSLMLp4TeHFgXoMggUKrK7DRVNKF9GmFrIGURO1fQ99/XHljgRtPe0DglcuJyiwJFVauAHADtz1Wr3kMjYR055yfu6zgKtqBhCC5f4nrjEX+w1MRURc0FbKglOacCkL2+xyOv9vbkvFoDw8OW73a6sOSolnqi+B7Vjp48uyUbZJgbFuAku409MqW9J2wzXCYxrwPS3YXV3M/l5aMv0L8w6TwnYadh9kkXHSuPFtD1Z3YRlsqYtiYeMmoeby0eGvt2iff1U1zfq/kgnTXAK646yOUO5ZsOkwlFqTSMtMi+gDBv5mQKkrf6LLRD7itvoDvmBhNICSVLMdvdiw9g/fEazBthgmSYvkthI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHA3NEJIWVhheGN2blJtd1FKQWE2cHhmSEhjWTZ5L2YwKzlzRDEwU1JlSUx2?=
 =?utf-8?B?NGpSSlkwMWt4bG5uMm1rZmI2QzcrRFluNTVmK0Y4aUtwa05yWFNqUlJ1dUxR?=
 =?utf-8?B?NXEwb09LUjlJMWRpVFpHZ1NuZnVkdHYrdldZcDBDd0lXc2piaEo4elJCMmYr?=
 =?utf-8?B?R1FMUTVRbWhxYkFucU5iRXlqWkUvZldkemZwK1d6SXRLYkhyVk5BNGdXSUhj?=
 =?utf-8?B?L2hNZTA0d2pZZ1lPc1pzM1l4YVFYaThHb3pyVFBYcnV2aG05dVVUeS9xb1RX?=
 =?utf-8?B?VGgrb0MxeDNCZ3lTMUJrWHNmd0NSd2NxQmFGbkpnV0NJZ1ZUaHRpRlRLZis3?=
 =?utf-8?B?ZnpPS05JZHpkL3daYTZlUjNKSDNORW1LWmV2bVg4NnVFK2JzUVVET24zUUdJ?=
 =?utf-8?B?RkdXN09OMytnallxbEhIMnJENW1pVlNVOUhTNUpnZlc4V1ZRc1BxcU5wbENI?=
 =?utf-8?B?ME9HL1V3RitsOWRNMVM5dDBPUzhES1J1WHpGNitwU1IweDZLZEN1S1E5ZTg1?=
 =?utf-8?B?NmYvM0ZITVlwMk9ndDNkaGd3UTdaRm13aDkyQnFjdkZBbU9mNFhJeXBMVU4r?=
 =?utf-8?B?NGRqcXkzNzNhWTQ4cTI1RjJobk5FN1RRa0FoY2tlM0IzZ3ZLbk9CUU5TQU5X?=
 =?utf-8?B?UnAxWEtlSDk2aGxYZXJsMHFNc1JqWWhhMFRiOUZmM2dSNGZuUHhiR29vaFM3?=
 =?utf-8?B?VE5ZOTBIR3lDY2YxZVdwUTF3Y2N2N24ranhpRXVnMmI4RkRZUlBJSDVHZ1NV?=
 =?utf-8?B?ZjJHbXRMekk1SElyb3hHZ1VjaExwK3ErZC9pcHRSa0NmNytWa1VzOG81dXF4?=
 =?utf-8?B?Qko3VlBybXZyWDUvR01sNHBBaGQvc2J1ZGVtV21maDhqTnpPaC9pOVQ5RVJj?=
 =?utf-8?B?TXJEZVpkczl3dkxRaHpnamtyUGZkL0xQRnFIYVE4UkZoOE5WRXRRRzFEK0J5?=
 =?utf-8?B?N29kT0ZNM3dvTmhpU1Ivbk55UStSOEtsR0NVUjZNOU82MjVaZzhjTTZMS1JK?=
 =?utf-8?B?aUZqcW9VT0M0RWpHbU4zQzA5azdmY2JCZHcwMUVKMmwzblNOUXB2R0dENFFD?=
 =?utf-8?B?S2ZPSHNaRDVzdDNMZHpObm9hdE4zdThRNVdqNmtBUEZadnNrdVBZSFQyN09u?=
 =?utf-8?B?NVF4cWljVHlOYkxmNURxOWd2UzlmMUlsYWhmR2phanBuTjBENXNHS0RYaGRW?=
 =?utf-8?B?bFR0a2t2UFNLckMyWlQvY3Jjb2xyaFpZYnUwUGpiQjA2bzhiMEtlNnM5YWt6?=
 =?utf-8?B?OWZDbFl4a1VLbk1jYVN3QTVBWjJWbWJ6V1hWTkViOFVPWE9GemlVb1lrdzBp?=
 =?utf-8?B?Y2dZTlpoeFM5cXR2ZXlqQjdhdGZ1amwrdmNXU2VRTGN3WlpQK25VN1VDNjBh?=
 =?utf-8?B?US9mWGRmSlZCUk51RGFZc3M0RVBoY09VWEQ1V1JDYTNlNnVOR2RPck9GWnFz?=
 =?utf-8?B?clpLVW5SZ3hZQ2VuRHBJWXFmWi85U3ZMSWFVTWFKK0FUNUZOOG1oMEdKV0tS?=
 =?utf-8?B?Tlh4Q3EzelRjM2xrd2tKcHBDNkM1MzNwQW1OUFV0dHF6aVhEVUx5OEZwNEpj?=
 =?utf-8?B?UHo0QXdvSnd6VURJczUzb0RSYTJuNkZwNEpTbGlwelRBMDEzNzNDODQ2WWZv?=
 =?utf-8?B?N0tJTlUwcHFhdW4raDh6RkoxQVNTak5QN05Zdm8rYXFQVE5hWXlWeXRuZmFE?=
 =?utf-8?B?Z0hObnZ3cHV4aGRORUI2QXdkTlpya2xBVlZEMnF2ZjcrTURoVFJNdHNjYSth?=
 =?utf-8?B?QjFXN0dQNVJvQnFVd3cwWmw3and3L0lGREkveUw3MHdndkpXQTFpdE9Ra2Fq?=
 =?utf-8?B?MXA2Uk9uSmNCUTlCamIwSFpMRW91bERDL3BaY3FKNGlNeXJoWHhyYTdsb1pi?=
 =?utf-8?B?eG9yeGpDdm16VUxoRGxLK0lJcVh5eFlMeW1Ja0FxYWMrbzZkTDNQQkZJK3Er?=
 =?utf-8?B?dzVlNjQrUDZ5V1FnRnFYdWJreW0wWkU2UEFCNUZIQUQzb1BXTTloRTNPZ1Z0?=
 =?utf-8?B?VGNtSXFpaW80YUJiZVhuSmZQOHg5SCtDbGYrY3pYM1d2MDNHYytBczVjWmxJ?=
 =?utf-8?B?OENFWUVkdFpVRHkxZ2Z3dEJOWkp6N1ZqNkd5TmxsRjhvR3BPeTZKVzFKMTkr?=
 =?utf-8?B?NjROcVowU2xDT201bWtJZ2lBRFkwVm5WckhaRXBQbTlGZTF0VFlPMkZnNXBt?=
 =?utf-8?B?NEpwMG9EMkNYbWNQR2piT1VVaWJxQUVLVVU4cUQ0NlEyczV3Yko2dUNZT0ho?=
 =?utf-8?B?T1N4Ums3RTAzcDBuQVltN1JYa1YxazFJMExGWndIaHgwN2NNSC9xM3NsV0xG?=
 =?utf-8?B?SklQNWVST3BDREZiemV5S3UvaFNRdWZ5aDFzK2hoMnlpQ1ZoeEc0WjlDZTNh?=
 =?utf-8?Q?EhXOSoLax1uscMIk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9a15ac-4f02-457b-975a-08de9c551c67
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 07:44:10.1794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7r1E3aOCXNzSZtPihfJXai7MM9K0kKWmFDb9vVP52TLbPDrJi93k8PrY5iH6XAs8Cey8qh1O4cE8odw6Le7HiYiimU5on0XrfxnKjvLS8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7354
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

Hi Boon Khai,


On 18/3/2026 6:40 pm, Boon Khai Ng wrote:
> Add QSPI boot support to boot target devices list.
> Platform can provide their own boot settings through
> OCFPGA_BOOT_SETTINGS macro if needed.


Commit message typo:  “OCFPGA_BOOT_SETTINGS” — should be 
SOCFPGA_BOOT_SETTINGS.


>
> Add SOCFPGA_BOOT_SETTINGS for Cyclone 5.
>
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> ---
>   include/configs/socfpga_common.h         | 18 ++++++++++++++++++
>   include/configs/socfpga_cyclone5_socdk.h | 18 ++++++++++++++++++
>   2 files changed, 36 insertions(+)
>
> diff --git a/include/configs/socfpga_common.h b/include/configs/socfpga_common.h
> index 36d6bfb3d03..5d98d662ea7 100644
> --- a/include/configs/socfpga_common.h
> +++ b/include/configs/socfpga_common.h
> @@ -137,11 +137,28 @@
>   #define BOOT_TARGET_DEVICES_MMC(func)
>   #endif
>   
> +#ifdef CONFIG_CMD_SF
> +#define BOOT_TARGET_DEVICES_QSPI(func) func(QSPI, qspi, na)


Any defconfig that sets CONFIG_CMD_SF=y and includes this header

will get qspi in boot_targets and a generic bootcmd_qspi=run qspiload; 
run qspiboot.

Those commands only exist in the default env if the board defines 
SOCFPGA_BOOT_SETTINGS (this patch only defines it for Cyclone V SOCdk).

Other SoCFPGA targets (Arria V, DE10, Sockit, …) might enable CMD_SF for 
a small SPI flash or a different layout without defining qspiload / 
qspiboot.

After this change, distro autoboot can eventually run bootcmd_qspi and 
fail once MMC/PXE/DHCP paths do not boot a kernel.

QSPI boot-target integration should be restricted to Cyclone V with new 
Kconfig-guarded macro.

Example:
config SOCFPGA_DISTRO_BOOT_QSPI
     bool "Append QSPI to distro boot targets (boot_targets)"
     depends on CMD_SF
     default y if TARGET_SOCFPGA_CYCLONE5_SOCDK
     help
       When enabled, socfpga_common.h adds QSPI to the distro boot device
       list and defines bootcmd_qspi (run qspiload; run qspiboot). The board
       header must supply qspiload and qspiboot in default environment (for
       example via SOCFPGA_BOARD_ENV_APPEND). Disable on boards that enable
       CMD_SF for a small SPI flash or a layout incompatible with that flow.

Any other board stays n unless it sets CONFIG_SOCFPGA_DISTRO_BOOT_QSPI=y 
in its defconfig (and defines qspiload / qspiboot in env).

#if IS_ENABLED(CONFIG_CMD_SF) && IS_ENABLED(CONFIG_SOCFPGA_DISTRO_BOOT_QSPI)
#define BOOT_TARGET_DEVICES_QSPI(func) func(QSPI, qspi, na)

[...]

> +#else
> +#define BOOT_TARGET_DEVICES_QSPI(func)
> +#endif
> +
> +#define BOOTENV_DEV_QSPI(devtypeu, devtypel, instance) \
> +	"bootcmd_qspi=run qspiload; run qspiboot\0"
> +
> +#define BOOTENV_DEV_NAME_QSPI(devtypeu, devtypel, instance) \
> +	"qspi "
> +
>   #define BOOT_TARGET_DEVICES(func) \
>   	BOOT_TARGET_DEVICES_MMC(func) \
> +	BOOT_TARGET_DEVICES_QSPI(func) \
>   	BOOT_TARGET_DEVICES_PXE(func) \
>   	BOOT_TARGET_DEVICES_DHCP(func)


Best regards,

Tien Fong


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFD0C67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 14:44:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6793887D73;
	Tue,  9 Apr 2024 16:44:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="cAFFmrhC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C432E87D4B; Tue,  9 Apr 2024 16:44:16 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2BA687D91
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 16:44:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8fdGHaBFCPDAfFoQJgItgA5EwYQ8CzJfV4yoqr5D/oq9WWLCg9J2xXSa9UIRsbwNnbGfdCKaCYs8UjA4iEMQDgYfRMatRm8sm7or79JjncDJsi1Gdz4JP0FsggObwwRH279ehjTsJJxVhU9WnxEQVmzod5TlAzHCoaoyhhEpehUaM6vQYtOPdrvpDoXnPZcYPF2955/Fxn09TaE4uuewjX3hZ3xhu5Nyhx1Mi64Y82ctXaruzjLcD7eLpRlFzzHASYS7fbwu4yzUHApo7nVGj5lC27Kyxu5nynUDr7OjrIShqLnnQf9WyGx8DpPtMvLygsR/BF7ON7mRmSX+f1wWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVhehU6Tpt/cOsfyfUrdxis61VyKL2KL8/xetCnuXwg=;
 b=EGfE3CfgRowRHbpJkDxVyT2Ydj/WAY1Q16lsZcvnPonQZKtzwQqGrIrdT+o9Q0AOChoGju7VDi+JejiPo1MBx6GgoJN+COwo9mhvERxpBEYTqetpDdoP20mVa5bBnwroycIjiW7vDy1sdCgSAZN1pNiZ2EtitLdUG+IasXc2sWFLxAcelzWRiXlGmjagu7MRadAPAtQuBzUEYmwqaNpj1kZcQ8YpqRpwd2NFpZTs1PINLJd8eYx23DmmacmnAY9MiPkpHZi7Jdm1+SteY5zMYXb7B6FpQ3v5lvkn0q/50X5Yz2cYhIkEUzuZJRPHSl+58Md1H7pHgfCoEVEKwSMEcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVhehU6Tpt/cOsfyfUrdxis61VyKL2KL8/xetCnuXwg=;
 b=cAFFmrhCo4AtSZQr5Gy9UsCPXz/Dyu4X/lmGEmRF+yoXtlgh5U04mwAzy+IjCegOKR0lBf6zlxR2RS9oiTKoiuMaihm5pBtm80RMjGtv3ubyYd1ZhQyqBNFr9UYt+yk3xkJ1iA6KJFFBuKMhaPR82dJ0IxIoufzfc2Mf7AxfZ97L+d7yHR4dgMjI0od68aajIauEA6YQkvnWc5/TvUxmNTnsYk5mNszE/RbIr0pkGzauKyNlBf5fwW2ewIxGQes8XOxYjUMKAloWJfd9SZ69gb6EbR8G3hjsUDflvDpHGTk0WIjubQPNDaebFucrUcz7Ulom+QGgvi1n4dLKhsPaGA==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM9PR04MB8212.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 14:44:11 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 14:44:11 +0000
Message-ID: <9efdf140-8da3-4b5e-b1c4-2f106067afd3@theobroma-systems.com>
Date: Tue, 9 Apr 2024 16:44:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] fastboot: introduce 'oem board' subcommand
To: Alexey Romanov <avromanov@salutedevices.com>, sjg@chromium.org,
 hs@denx.de, sean.anderson@seco.com, dimorinny@google.com,
 mkorpershoek@baylibre.com, patrick.delaunay@foss.st.com
Cc: kernel@salutedevices.com, u-boot@lists.denx.de
References: <20240408101552.539037-1-avromanov@salutedevices.com>
 <20240408101552.539037-2-avromanov@salutedevices.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240408101552.539037-2-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0048.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::10) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM9PR04MB8212:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fcUEtgnpR6iMZ+2CGnKTRIm9eAibGM7ipTi48g/DT+jKmeH8tqj2eptB4MyDJNYEcBUgD6eN2ql8WUVX/XE8JLX45AoJB/pGNZTxxhzKoG165QVbejt1zK9sOvFyb5IsUko4BjO2yHL9DT7+aGcMD9lrzbMwxSfMCywttvUmC8tzHL9ATE8qj7wfV4CRDbLzSbp7LiZlPLvKY7Npq4JncmcTCHXJx8ib8FfM+0DdccXKXpz6OfQF6fPl9UVxtDkoBYP7hAP3DaYUsuTfLMLCoL4mzOcffxaIjjWipqiuREu0cjSS1nel3U7WgCXUUuPiutKS1bsfxl6KWOfWLLcIA9XqGnKrMOgu8F2GuzkzRMcNQweH5+qHiyGBqNX8sMJIvf17bMd1RFglh6BcQQ//XUVq7e+KRrDLpnXTjVjHr2tTvmxKgdZvI04KZjgjprXXwp9O2X2zDpcUS74EL8Vf+Iq5BnKmnNnqTIAOVbAdSQ7s69FvSgIGSTnehP67S30hqFMcXUtAr2MxxYTbRckJ7RIZshBQAgn3ei4hWuFHsyOMa0B9SJjVzrBJhgh4JuGMgj0cDmR3MYKPdNdQb8UeWLJndkthdRc/0v8Y5jS8ZH/BkEc/7ulVBapnBT9/lBsweZlBKytnLEuIeAzl17YVaBfgrOzFsD8ivGl9GqVNalg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUxDdnhNa0crSXFSNmtNM1FKTk5UelRhZXdzL3hhckhwZHVoOVJCekdCVlhZ?=
 =?utf-8?B?eDBoVGV2aTVFY01VZWJSTnBBYUF0NFpwTUxaSHQzRGxTNVVqakJCbHR2NHpq?=
 =?utf-8?B?QStNcEZWNGx5K2Zuejg3eFN4ZFlhYlJTMEFVNE13UEZvMzA4S2xudXZRRHg4?=
 =?utf-8?B?cEZJMnBtQWI0WnZpVmcrUDE1OU8zRkhrUXB0blJqL2tiTUhUVmlTYkx6TFJC?=
 =?utf-8?B?NDd5cmdFMzNLS2FrcFkwTDRFVVV2dWNQem83cVQ5OHk2bHVod0hmQnJlSWkv?=
 =?utf-8?B?QnowUXdIREVSNGlTWktXK3JjRkdWMDRPcWE0MVMzanl0UzBYU0dhUzhSTjNj?=
 =?utf-8?B?WHVPTEdsVTN5ZS80R1Fkc2dVWGtlL2JmRFk1UnlTRXc2QW04WFF6bVFDSUtX?=
 =?utf-8?B?cEFveWJWWnpSRGw1dEt6em5veVljdHk3aFNkNTUxbFRTMnNHU1FsaEdVNTRl?=
 =?utf-8?B?eFIrZHU3VVhpTmJHWkdRQnNqVzhCcEkycURIeGlrTmZyemwvM0l1KzlmaUpt?=
 =?utf-8?B?UlRxalhYNzhpUlBwNnA3L1FydVhjYm1RT1dQS3Fhc3ZPd1krMnlMTW9BMTlW?=
 =?utf-8?B?cGVpdU5TbmtETHBjWlNJUW5WeVZDN3NFdFV1MndDNytDTXJFQXc5RC9UaHpX?=
 =?utf-8?B?enNNUE1Vdnpjb0dSdVR4dVdqWWQ3UmZ5bC9zQ0gxdmZUU2ZGSUJiN0QyVnRZ?=
 =?utf-8?B?cktuck05ZkVMUHBWWmdVckFJZU5JK2dWN05iYVAvQ1ZCbHEvL2h5dFExWlF2?=
 =?utf-8?B?YTRxSXB6cE1OM2ZlQUp4WWxGd1Z0V1pYQWRCOTFHK0ZzTFNPcEpmR3o0Wldu?=
 =?utf-8?B?Qk5uNFA3TjlGakxuSWYvNnEyL00vaDlIYXV6YnZWZjJiT2xFMGF0Q00vT1NJ?=
 =?utf-8?B?V0RxNE0rSk1MeHJPYzlURlNlVjBzTlphdldma1RqdFl4QUxFb1NtZmQySzJX?=
 =?utf-8?B?SWxpaVFRdVZJNUYzOTRxNVo2dHh1VWRpd1JHbHl5SHRVUWxESjlxVkhRb0lo?=
 =?utf-8?B?cXRiV2h1ZlhmMXI3UUdORTdsalZkbFZyMHBXOHJMY0lLckpoVnBTbVZOVytP?=
 =?utf-8?B?VHVqSk9Hd2ZRQUZpOXR5aE5SS3BzMEM3VE5lOXlQbEkrc05pOFR4ZGQ5VVRy?=
 =?utf-8?B?N2ZFenkwMlB6UTRrdjFYNi9VeElVUXV0RnBQUGU5K0IzM0Z4WUxjL1djMVdx?=
 =?utf-8?B?eFoySDF3amxnM0JEV1oxMGduZEhHYlQ1ZHNTN0NqYkJFeTFEc05OOUpHNVps?=
 =?utf-8?B?NnFCWVBaaEpKV1F6OGdtY2JFcnhIYVh2YjlXdHNJU0NRdVBIUFlBYzB3ZW1P?=
 =?utf-8?B?dDBHMjdocjhybHRBL1p4ZElrbGZZalBOSERZdm04UDBEakM5Um15NXJIc2VQ?=
 =?utf-8?B?NW9Tcm1JWnFqbTdlbGtJRnBRT3NxMFhDYUtRL3hHNG96OGRsNHE4ejY5Zmdy?=
 =?utf-8?B?MTg3OS9HMGlMaTVYQis4MXFXczRLQmViN3l1RzZJbzY0YlZ4K0dYTk5veWZm?=
 =?utf-8?B?WmQ0WlVCZkg3dzlBNnZyTFlIaGVDbmFob3JPT2txWGNKdUptQ0tlWkN0YWlt?=
 =?utf-8?B?VE1VVzdPU3hjRkJ4ajRkYk02bFdWSEJjQldSTXk5b2FzS05EVXFpSTlBaXE1?=
 =?utf-8?B?cXVMNkNudk5YMkRtS1dnQ1l1S2wwM3gvZ2ZtUHpMbXNscm9yakljREh0dWFF?=
 =?utf-8?B?T3pvNGpGY3pHS3RQaWcwKzJyWGQyQVF5N2FzTDQ5ODltNkkzMXRSQjI1a2E4?=
 =?utf-8?B?YzJJUkUrUVhxQk1KNlpDYkRJM1RnS2xld2dFS2MrcnFuZkdYdUF2Q09PTzVq?=
 =?utf-8?B?ZldKRXJ4ZVAvYzUxZVhqaGg3L2lIdFFqUFJzaGk0TXFVekY5c2RrditSNFlK?=
 =?utf-8?B?RXJSeHpKL2NMM1pyL0RTRDViMi9LZkdEMitTcXBJMVo1bVdhVWl4Y1dnenhx?=
 =?utf-8?B?U2o1M3N1Zm41NVBKdnUxT29DbDV4RTlIUCtLcU9hV0M4bEd4RTlFcHYxVUZR?=
 =?utf-8?B?TklGR0Zla1RlcENKYjQ2czBjTThNdGJ5b2xJcE9rdThMSzRNczVBSS85Q1dq?=
 =?utf-8?B?TmdFUERGQlB2d210RlMzNEFMODZqNkswZEZNMk8rZ1MrN2NCRzQ2b0UzMW0w?=
 =?utf-8?B?MEU1cmJWQTE3dzA2Y0JZQ2VhaFQwUDZCdEQ3THkyMEZxeGpkOUJmK0JXMTRz?=
 =?utf-8?Q?gz+AvZcIqwQyxY6ncEbcn6U=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f60958fa-1da1-42ef-6daf-08dc58a384bb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 14:44:11.2033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tu3KadDhXpHSeu7ewiBrKe/H3kTgoNS4Y7veMXdukCE4/kLMi+4Zh6sICc9r/tnXK/7gbeFWwBatYCA0NuhpmyhH1pmWBEZVH4BslGrqZo2t5J1m4OKwMg6KpKFE7NjV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8212
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

Hi Alexey,

On 4/8/24 12:15, Alexey Romanov wrote:
> Currently, fastboot protocol in U-Boot has no opportunity
> to execute vendor custom code with verifed boot. This patch
> introduce new fastboot subcommand fastboot oem board:<cmd>,
> which allow to run custom oem_board function.
> 
> Default implementation is __weak. Vendor must redefine it in
> board/ folder with his own logic.
> 
> For example, some vendors have their custom nand/emmc partition
> flashing or erasing. Here some typical command for such use cases:
> 
> - flashing:
> 
>    $ fastboot stage bootloader.img
>    $ fastboot oem board:write_bootloader
> 
> - erasing:
> 
>    $ fastboot oem board:erase_env
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   doc/android/fastboot.rst      | 18 ++++++++++++++++++
>   drivers/fastboot/Kconfig      |  7 +++++++
>   drivers/fastboot/fb_command.c | 30 ++++++++++++++++++++++++++++++
>   include/fastboot.h            |  1 +
>   4 files changed, 56 insertions(+)
> 
> diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
> index 05d8f77759..2020590657 100644
> --- a/doc/android/fastboot.rst
> +++ b/doc/android/fastboot.rst
> @@ -30,6 +30,7 @@ The following OEM commands are supported (if enabled):
>   - ``oem bootbus``  - this executes ``mmc bootbus %x %s`` to configure eMMC
>   - ``oem run`` - this executes an arbitrary U-Boot command
>   - ``oem console`` - this dumps U-Boot console record buffer
> +- ``oem board`` - this executes an custom board function which is defined by vendor

s/an/a/

+the vendor? (missing "the")

>   
>   Support for both eMMC and NAND devices is included.
>   
> @@ -246,6 +247,23 @@ including multiple commands (using e.g. ``;`` or ``&&``) and control structures
>   (``if``, ``while``, etc.). The exit code of ``fastboot`` will reflect the exit
>   code of the command you ran.
>   
> +Running Custom Vendor Code
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +U-Boot allows you to execute custom fastboot logic, which can be defined
> +in board/ files. It can still be used for production devices with verified
> +boot, because vendor define logic at compile time by overriding weak

s/vendor define/the vendor defines/

Suggestion:

Replace "by overriding weak implementation of fastboot_oem_board()" with 
"by implementing fastboot_oem_board()", the weak symbol is an 
implementation detail I don't think we need to keep in the documentation?

> +implementation of fastboot_oem_board() function. The attacker will
> +not able to execute his commands / code. For example, this can be useful

+be able (missing be)

s/his/custom/ or s/his/their/

> +for custom flashing or erasing protocols::
> +
> +    $ fastboot stage bootloader.img
> +    $ fastboot oem board:write_bootloader
> +
> +In this case, ``cmd_parameter`` argument of the function ``fastboot_oem_board()``
> +will contain string "write_bootloader" and ``data`` argument is a pointer to
> +fastboot input buffer, which containing the contents of bootloader.img file.
> +

Either

-which (remove "which")

s/which containing/which contains/

Cheers,
Quentin

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710DBC48BC4
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 12:43:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B10F87D6D;
	Thu, 15 Feb 2024 13:43:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="j3Nctl0e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B781A87DC1; Thu, 15 Feb 2024 13:43:04 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B46B98785F
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 13:43:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsTJnY8n46u/8eamGowgzHkTFoWb8ldzpmBkS9R+Qj4VPfO13NIbJwUPFU8f6gnPQcWbQr3Qq4ooUALJeTVZdnxLoLcC7Molw/MfLigWX4vr2Q69h0P2wt1e0B1ZDEPxIBqajohbVwamaY9463lRAciWUZHn46jlIUVZbERU16byI/IyqxRodDUK6XTqH9jojpTb/z9V3go8lixQB8vnYy9D2Hq3dX2uN9Fs+O0fCKkbGLeUdIrZtDqLOcZKPW19cu+QKeFuqJF63fy7+4v26IcYadM4HhwfFCbHkFo3bdtYAVjr1WFAWi1ph829nGyxIRJlNuZOodNn7aPMlySngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAm7BYKC873ZZJUcy2cvwsPXScLQgvlCVjT9AsLxMnM=;
 b=Dc6gAnAI51CoC+dro12ONXOYbkKiMfr5nAaDABqD/y8wWQbkil3JPW9sbllSMVDSqGQDa55yL6qOxR3Hq29xrqUfqpGEQ6fHtor4EAvAaU1Ka/sMfYXWGPR6kaGobHgPzNjgbNGj4x55jYXM7S1L62RBdfMcLr7dj/VnhXS2nok4aqw2maEnk0dCghPXLngRG0WUxB5l3frtDRfNx+Ky4S2N1sFqm6OfEG8dprPIG5mx74+f71vBTlucFvBqGJiMZG+OeP4fXVRpLRhcVC69rUdWvsVGZR81GPNe8PCS9uWL6/IyiljxG5KXy9oayDEr9uJ1JRBR60zsu99DVOV7mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAm7BYKC873ZZJUcy2cvwsPXScLQgvlCVjT9AsLxMnM=;
 b=j3Nctl0ebuLB8hAtUw/gtrVOKrFcFbeNiJJDFOH2lIhAZzbTe4Qa1NqSf+cqRMGfi4YJnlOqEBYB7BtxJzWlQCnoGEXhwbPxL04euO3oDkYZfqXhz0kD8MYjSby+G9vq80i6ezK27E5NAYiQmy6sxN79mGfeIv90KZjuYQQ4sawqnDnx8K93P/RXx/cJJNJYwr5YeBj3GD6z7oqIbPHIBz5tPLbWYM+s737MokPehHWAAw/h/8sgf87lL5VUmbqSigghS4smn+U4nGXyI/iv2ZBphJsSamtAjHOtg+1zVe/suwrSxMFwanoE8kpSzBnr3QRt3Ygn1JFjCDMBL1IMiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 12:42:58 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 12:42:58 +0000
Message-ID: <0b536be2-3469-4c1a-b972-a7b5c877a03d@theobroma-systems.com>
Date: Thu, 15 Feb 2024 13:42:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] board: rockchip: Add support for rk3588s based
 Cool Pi 4B
Content-Language: en-US
To: Andy Yan <andyshrk@163.com>
Cc: kever.yang@rock-chips.com, jonas@kwiboo.se, u-boot@lists.denx.de
References: <20240214093126.329717-1-andyshrk@163.com>
 <918dfa17-3c32-44d4-8d16-87bab10cc138@theobroma-systems.com>
 <261ba9aa.2fa.18dac558cf4.Coremail.andyshrk@163.com>
 <cdda29dd-3d9f-4eef-83a5-a5f80ca79dcb@theobroma-systems.com>
 <1cd3e505.333.18dac9f1eed.Coremail.andyshrk@163.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <1cd3e505.333.18dac9f1eed.Coremail.andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::7) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PAXPR04MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e3f842d-68c5-447b-2ee6-08dc2e23a3a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y8ahXH1aLwJRF8SxmWs9hBFtQXZVDYcjaj3kO7oVh5ZmO+cKCLAxddLqVQdY5f0XGdaBgngx5VF8XB3nIx2Dd+Zk/L2nZj6/FgZFP3FxC+nb+XB/rl+X1PSxGw2rtzezBP5mod75eWrviOxv6OMM1lL2Ny+bp0gkbpb4YT4rq9e3LSzkeFC/RZYq8tEze74/c2Jp4NjjwaS5zBc3b3zzXeIJxf2fF6G+XJ6b5g8FtISYZwLvo3lRdMITKKeC4guTWFO7I5l2IHcsWTdNiTWMTsy3VuisU9k4Ff878XZ1iYAoD7zo8g1CqY0CKDJk16lySC5uTrQtoWg+PF8WT4/kyP5B+iHJjV4al0691/Bn62mWueDX7g8yebXctPm0/WNQ0fK1qt/yqKEmFQ9AMM0ikywRSET/nsTl5APMHDKZ46s9SnVmfc3sWFCIiGmTCLpJL8d7vr1EY7XIypRA07+iMWUqPohlvGB8LIsaxUchBFanqN3M4N5O6OFLbEbyM3f8DqzCASo06elHRwISFFxewXUxN1O+qj76eFJpiLYYDAQiWAUPjjqtwOSL1nbXZh4z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(136003)(346002)(396003)(376002)(366004)(230922051799003)(230473577357003)(230273577357003)(186009)(451199024)(64100799003)(1800799012)(5660300002)(2906002)(44832011)(6512007)(6506007)(6486002)(478600001)(966005)(316002)(53546011)(2616005)(66556008)(66476007)(8936002)(66946007)(6916009)(8676002)(41300700001)(4326008)(83380400001)(86362001)(31686004)(38100700002)(36756003)(31696002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWFqNm9MVFNYQ2YwMzZOT2pYaVVmR3ovcGJBN2VUV2FzSjdJQ21zdFU5amlP?=
 =?utf-8?B?SnM3WFBzOWFHVWNxYW4yQ0w4K1MvNUJaZm5zb0NJcU11alF2a3hibHZ0djFQ?=
 =?utf-8?B?ZzcyQTNaUXAwUmNLUkNwQ29SaDFVV01rS1dCaEtLOG1MKzNvSUZ3cVE0ZC9Z?=
 =?utf-8?B?eldYai8vMnMzWXJtbTJHRENXMWtSZUowMmplWFE1aHZxNU1MeEV1dW94WHo5?=
 =?utf-8?B?M1drdXI5eVFVMjBuYjNSd08yZ2dVbWlJVjRIYlRiWlVjYmoyb2k3RmNRUGs4?=
 =?utf-8?B?cENHMS83UmtXR3Bwek93M3FiV3Jwc1p5OWFOSTdLM2oxNzJlSktmYzJYSlB0?=
 =?utf-8?B?TFovUzZadWlPSHhnb29mVGVUcC9VMTBFTmxvbVZ0Q3pZN2lMcHFRbGhBcXF4?=
 =?utf-8?B?b1pNOVNYWmszUHJyWnRXMzhmc1ZkeXFDNE9tWm0ydUFJekk4b2FldDlSeEp1?=
 =?utf-8?B?QkFybG14UW5qdU1xM3lCZGUwY0F3R1IxejNlWjkxNFlJMWxUa3VIK0ZIWTMw?=
 =?utf-8?B?ZnhuQzBXMW8xemhObUdmbVVWejVETGFaRDJTR2RQZXZzUXVDOXBuUDk0NlAv?=
 =?utf-8?B?azI3RzEyRERBRDNvdENXSGYwTkJrSGN5NWQ5UFBUbExhQ01PaGlFdk96Tnpy?=
 =?utf-8?B?MFUzY3pBeUJ0bFNOdDJLM2Zoa05LRlZqWU45NG1acUhCNXFLSkd4bHJyeEtm?=
 =?utf-8?B?UlJPL1RQU1lrNDhZa0xTWWJmYWVnOHM3K0V4S2pqeCt3Q040OWRudk5ReGEv?=
 =?utf-8?B?bVhrMDd3dTFSbVdnTVY4elBZQld1UjRuZnVueWJyWDVGdDVpVFdhMEJPMVBD?=
 =?utf-8?B?K1RpQk5COUthdTM0VmY5WXJETHo1V0w1UHNJYkQveEpabGhYY1QzRjZOYVA0?=
 =?utf-8?B?eXZSUjdlZ2VrbEFxYlE3b1pJU0cvL3dtWStUTlI1Nkx4TTUvVkhjYi9QOS81?=
 =?utf-8?B?Q3paWkhtTGJtMTJkS05RQXVYTHNWdFFFVHNiOFZHRjd4OGpkU1JER0ZaZzZN?=
 =?utf-8?B?NjVNS1pZY2xYeEs0Rk5NdE1USXJjRTUvYUFvZ2tNUlVUTHBMK3VyNFFmeU9t?=
 =?utf-8?B?N3FZVDdPZ0drZDh2dUx1aFlUai9zZTJWUXkwOTA2TEpqVHNJb2ZxdC9DcTd5?=
 =?utf-8?B?V1p5Q05hdW9HUXJVeG90WWltdTFlUmh6MEFzOUszN2lZUHptSlliM2JkU014?=
 =?utf-8?B?NjVObWh4RHZVOXI2WDdWNjBDYjNCcDI1bktvckxrY09DMVZIUDBEdi9YVExF?=
 =?utf-8?B?QkhwRkE1OW9TTDZna1lCRFZTdm02NnBDZE9EWjB4YnFhZVZYUmVFdG1jSzRC?=
 =?utf-8?B?TUtVM0JzaVNzNlRWZ0gxVzRiSVEwcXhQVWF4Zm1TZ0xNMDZsckhteExOSjhQ?=
 =?utf-8?B?elJnSnZPaCtCRC9KbnRjeE1tV0lhRzZPUHdDY0xROG4xY0VxbldQQjVHNFJM?=
 =?utf-8?B?WThpZmFWNDI4dGtjcGhITzBnY2hUZ2drYnN0ZnJPNDFiZzQ5b1lubTFrUVlP?=
 =?utf-8?B?U21CZFFDY1UvblM4K216L2JmL2l5YlFVdGdGRlBPTUNTaUdQbFVmVGRFYmhh?=
 =?utf-8?B?TkVsek9XVFBNb0RibHUxN1NKcS9uemJodUdqdlZWR0xwK1RSUEJubHEyejFK?=
 =?utf-8?B?VFhJeXNuaURZcmZ0WjJNNjR4eW4rR29haVIrOWpXb3lxYVRpNXc2TWNBNlk2?=
 =?utf-8?B?L3Ivem56ck8vUFRteTJBZWN0blBWZFdVT1h5TW1HV3RJaXNnRjB2RTdiYWIv?=
 =?utf-8?B?NUhUK0R4SnZraG94cWlEbFB2enhUQ1huNHhBOGFiZGFPTlR6NUNwanFvTnND?=
 =?utf-8?B?aUFHUVBmM2tGNWdiL01qMG43b1hxRDNCclloU0k3TStHTnNSZHlVRWVKd0V2?=
 =?utf-8?B?V0psSEM4MlJJaHFZRklvZndBL0dyeDB5eWxCQjQwVEMxUzVDd2NFMVZIU2ZK?=
 =?utf-8?B?TE05ZlErV2xmVVp6NzAwRjBHWHN4MityVXkrYTYwTzJrQjlCOXd0d3RhQW05?=
 =?utf-8?B?NjloeDlMNmZwWlRUSUt5REw5a09xckZyczlnUU9sMHlITncySlJyaVpyRjAw?=
 =?utf-8?B?alBqUUhObHpPZGFrOWNqY1ZCRk52bTVGM0RGZTN0Q0VYc1dTSVpqNGFKZXE1?=
 =?utf-8?B?Y0hzQ2l0OStYRnVzS3A4THBzemlRdWxtVGZkL3ZYbjVDS29ib3BURUR6Z2lF?=
 =?utf-8?B?Z05EcTZqaGJVUjU5R2p6WmFuOTgvbDAyWnU0WWo2K2MraHYrSEczczZDcy80?=
 =?utf-8?B?VUYxMFp5dmErQnFTQllCVU5JQ05RPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3f842d-68c5-447b-2ee6-08dc2e23a3a0
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 12:42:58.5386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0II2xHI2M4UtFPZ85xECjqqcArQ6/NarnNX/dJNh1PwAtiB9Wu45pbvbQUjlzSDzCkQV0b5ZnQnNIadvu8B6cydgdVjsCjo+sR5NT2vWkzeJ+3WnSuttSKKyvTmwqTd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8510
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

Hi Andy,

On 2/15/24 12:55, Andy Yan wrote:
> [You don't often get email from andyshrk@163.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi Quentin：
> At 2024-02-15 18:40:25, "Quentin Schulz" <quentin.schulz@theobroma-systems.com> wrote:
>> Hi Andy,
>>
>> On 2/15/24 11:35, Andy Yan wrote:
>> [...]
>>>>> diff --git a/configs/coolpi-4b-rk3588s_defconfig b/configs/coolpi-4b-rk3588s_defconfig
>>>>> new file mode 100644
>>>>> index 0000000000..3e3e5abc86
>>>>> --- /dev/null
>>>>> +++ b/configs/coolpi-4b-rk3588s_defconfig
>>>>> @@ -0,0 +1,105 @@
>>>>> +CONFIG_ARM=y
>>>>> +CONFIG_SKIP_LOWLEVEL_INIT=y
>>>>> +CONFIG_COUNTER_FREQUENCY=24000000
>>>>> +CONFIG_ARCH_ROCKCHIP=y
>>>>> +CONFIG_TEXT_BASE=0x00a00000
>>>>> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
>>>>> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
>>>>> +CONFIG_NR_DRAM_BANKS=2
>>>>> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>>>>> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
>>>>> +CONFIG_SF_DEFAULT_SPEED=24000000
>>>>> +CONFIG_SF_DEFAULT_MODE=0x2000
>>>>> +CONFIG_DEFAULT_DEVICE_TREE="rk3588s-coolpi-4b"
>>>>> +CONFIG_ROCKCHIP_RK3588=y
>>>>> +CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
>>>>> +CONFIG_ROCKCHIP_SPI_IMAGE=y
>>>>> +CONFIG_SPL_SERIAL=y
>>>>> +CONFIG_SPL_STACK_R_ADDR=0x600000
>>>>> +CONFIG_TARGET_EVB_RK3588=y
>>>>> +CONFIG_SPL_STACK=0x400000
>>>>> +CONFIG_DEBUG_UART_BASE=0xFEB50000
>>>>> +CONFIG_DEBUG_UART_CLOCK=24000000
>>>>> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
>>>>> +CONFIG_SPL_SPI=y
>>>>> +CONFIG_SYS_LOAD_ADDR=0xc00800
>>>>> +CONFIG_PCI=y
>>>>> +CONFIG_DEBUG_UART=y
>>>>> +CONFIG_AHCI=y
>>>>> +CONFIG_FIT=y
>>>>> +CONFIG_FIT_VERBOSE=y
>>>>> +CONFIG_SPL_FIT_SIGNATURE=y
>>>>> +CONFIG_SPL_LOAD_FIT=y
>>>>> +CONFIG_LEGACY_IMAGE_FORMAT=y
>>>>> +CONFIG_OF_BOARD_SETUP=y
>>>>> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-coolpi-4b.dtb"
>>>>> +# CONFIG_DISPLAY_CPUINFO is not set
>>>>> +CONFIG_DISPLAY_BOARDINFO_LATE=y
>>>>> +CONFIG_SPL_MAX_SIZE=0x40000
>>>>> +CONFIG_SPL_PAD_TO=0x7f8000
>>>>> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>>>>> +CONFIG_SPL_BSS_START_ADDR=0x4000000
>>>>> +CONFIG_SPL_BSS_MAX_SIZE=0x4000
>>>>> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>>>>> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>>>>> +CONFIG_SPL_STACK_R=y
>>>>> +CONFIG_SPL_SPI_LOAD=y
>>>>> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>>>>> +CONFIG_SPL_ATF=y
>>>>> +CONFIG_CMD_GPIO=y
>>>>> +CONFIG_CMD_GPT=y
>>>>> +CONFIG_CMD_I2C=y
>>>>> +CONFIG_CMD_MMC=y
>>>>> +CONFIG_CMD_PCI=y
>>>>> +CONFIG_CMD_USB=y
>>>>> +# CONFIG_CMD_SETEXPR is not set
>>>>> +CONFIG_CMD_REGULATOR=y
>>>>> +# CONFIG_SPL_DOS_PARTITION is not set
>>>>> +CONFIG_SPL_OF_CONTROL=y
>>>>> +CONFIG_OF_LIVE=y
>>>>> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>>>>> +CONFIG_SPL_DM_SEQ_ALIAS=y
>>>>> +CONFIG_SPL_REGMAP=y
>>>>> +CONFIG_SPL_SYSCON=y
>>>>> +CONFIG_AHCI_PCI=y
>>>>> +CONFIG_DWC_AHCI=y
>>>>> +CONFIG_SPL_CLK=y
>>>>> +CONFIG_ROCKCHIP_GPIO=y
>>>>> +CONFIG_SYS_I2C_ROCKCHIP=y
>>>>> +CONFIG_MISC=y
>>>>> +CONFIG_SUPPORT_EMMC_RPMB=y
>>>>> +CONFIG_MMC_DW=y
>>>>> +CONFIG_MMC_DW_ROCKCHIP=y
>>>>> +CONFIG_MMC_SDHCI=y
>>>>> +CONFIG_MMC_SDHCI_SDMA=y
>>>>> +CONFIG_MMC_SDHCI_ROCKCHIP=y
>>>>> +CONFIG_SF_DEFAULT_BUS=5
>>>>> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>>>>> +CONFIG_SPI_FLASH_XMC=y
>>>>> +CONFIG_SPI_FLASH_XTX=y
>>>>> +CONFIG_PHY_MOTORCOMM=y
>>>>> +CONFIG_DWC_ETH_QOS=y
>>>>> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>>>>> +CONFIG_NVME_PCI=y
>>>>> +CONFIG_PCIE_DW_ROCKCHIP=y
>>>>> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>>>>> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>>>>> +CONFIG_PHY_ROCKCHIP_USBDP=y
>>>>> +CONFIG_SPL_PINCTRL=y
>>>>> +CONFIG_PWM_ROCKCHIP=y
>>>>> +CONFIG_SPL_RAM=y
>>>>> +CONFIG_SCSI=y
>>>>> +CONFIG_BAUDRATE=1500000
>>>>> +CONFIG_DEBUG_UART_SHIFT=2
>>>>> +CONFIG_SYS_NS16550_MEM32=y
>>>>> +CONFIG_ROCKCHIP_SFC=y
>>>>> +CONFIG_SYSRESET=y
>>>>> +CONFIG_USB=y
>>>>> +CONFIG_USB_XHCI_HCD=y
>>>>> +CONFIG_USB_EHCI_HCD=y
>>>>> +CONFIG_USB_EHCI_GENERIC=y
>>>>> +CONFIG_USB_OHCI_HCD=y
>>>>> +CONFIG_USB_OHCI_GENERIC=y
>>>>> +CONFIG_USB_DWC3=y
>>>>> +CONFIG_USB_DWC3_GENERIC=y
>>>>> +CONFIG_ERRNO_STR=y
>>>>
>>>> Is there any reason for NOT enabling MMC_HS400_ES?
>>>
>>> No, I just follow the config of other rk3588/s based boards.
>>
>> Fortunately enough, a patch was recently merged to have at least HS200
>> on RK3588, which is the first mode that actually works, anything below
>> that is broken right now.
>>
>>> It seems that there are no rk3588/s based boards enable MMC_HS400_ES in the current u-boot mainline ?
>>>
>>
>> Jaguar is hopefully coming soon-ish, maybe not in this release but the
>> next one (patches are sent already), and we make us of it in U-Boot
>> proper and the SPL. Up to you, can always be enabled later on.
> 
> With a quick search， I fond jonas'S patch for enabling HS200 has been merged, but
> your patch will bring HS400_ES, does that mean all the rk3588/s based boars will switch to
> HS400 ES if they support it?
> 

No, it's on a per-board basis. Not all eMMC or boards support 
HS400/HS400_ES, it depends on the signal quality/integrity and the eMMC 
chip itself if I'm not mistaken. If I remember correctly, Jonas had some 
RK3588 boards which didn't work with HS400/HS400_ES (probably one of 
those boards with the eMMC that is plugged in?).

Now to come to think of it... I don't know how/why HS400 isn't enabled 
only when it's present in the DTB?

Cheers,
Quentin

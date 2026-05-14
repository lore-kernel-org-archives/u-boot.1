Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089E0CD4851
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 05:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79A7480F0E;
	Thu, 14 May 2026 07:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ZhlzkFPS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2C248341A; Thu, 14 May 2026 07:42:33 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D62768056B
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 07:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBjEDXNKTjKdTo5gBHF++g+Yka7qpo7YfUTFfDvtpbFUIy5V1irNpAgxh980q1hO8Jh/q6ZjgqoqgiZVECevt4p3jhTz5vBiWHpEFtxi6VwaEm7P8+0Bnr/7nxFDKaaNrRQXaCIwrN8lDM2OP3Gy0a9ljrG9bF5M8mJAn+liKmx1uXA8kcDh5eXF/RujvCi1R48hQMg36fT598b/AyprALKk5f+7b6535izsTCjRwDJ81gCLNPmnzQ+ZFFHICOJplk+E4haSJ19IV5TxmF0VMa18ckNh0sUCIE99uBr/MtBqR1VGPRLfii/3rMCoeRYaBanFxeij25K7Cl6Q1Sk7BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3tc0NIvZ46d+r9wu1wOEW1gUkILNUAOpdvRa4jec8s=;
 b=ED88OX75uJMB9lqkEjW4odqyeWkg09XoQIlP8RMjMROLIKy9WnA0n2zKGHzji6QKYnqJd3Sxs2eUph7iIY/lbdkxflt+pCzm+I5+yzX4NnUiH4CYzA+GfUAYF3ESU1a1moA1+VtNn0fL+8L/JLaPQA9Lzc4ni5f5Oe+G3f6NRBO6uvo6AdV64ywK6NR4tfb5XbcfCqxlFLIHyNAVMTJ4e4uei598zFbmLY7ABJDmRsH6qPuV4xRX2NmTnV4ITC6VJ5287vt7RPvrMzL0Fp/vFVBlLXCURO7j5LpwwXWNq6El+WwDZ5e2dkEy3WtubM3dBLINoGbCMp9LGLAeN5uTfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3tc0NIvZ46d+r9wu1wOEW1gUkILNUAOpdvRa4jec8s=;
 b=ZhlzkFPSpASNW6byOg12VWCyxqsMIt45qgSAY5u49wVdBe7dk8TLiYty0r5kg+V2c60hp/gH1AHYIjIWHZCF6lkw/4PfXqx1q7XaByZlB5qh+teyJBkRQEplvgxE11wo86SRNK77UhAnVL2hA1PEtaB1qSG6+ar6q4TXzHJQV+lVLrllcLU4vi27Yth3YNB+Q+csYDxMOu1DF1LkOUGHVrsd6wslP4mlAwUQquhakh+NTLb5XAtheiPLybxfaQMh8YKecv7VCCsCWDbIvG3YlvnT/FZdovUcEStEwIvMpNZhBvxXS7fRLHWZu/Qe+q6Z6hc7Qla8IoXx9OAbyJtfrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DS2PR03MB8465.namprd03.prod.outlook.com (2603:10b6:8:32b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 05:42:25 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 05:42:25 +0000
Message-ID: <5677e494-21aa-4532-a47d-9d45a6376f44@altera.com>
Date: Thu, 14 May 2026 13:42:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] configs: stratix10: Combine defconfig for all boot
 flashes
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>
References: <20260428034822.23756-1-alif.zakuan.yuslaimi@altera.com>
 <20260428034822.23756-3-alif.zakuan.yuslaimi@altera.com>
 <c569f03b-1383-4771-8169-99eb611d3f5d@altera.com>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <c569f03b-1383-4771-8169-99eb611d3f5d@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DS2PR03MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a824f8-94be-4f32-6d90-08deb17b93b5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|55112099003|4143699003|56012099003|11063799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YRQVSjf6eU09uPU7pBfWLQx4v9W4r956kGUOtiCjjBqL+J36QPGQy6EdMuksVts0LwWTgfhNmrfM59goXrRWdNo+NNDNgsbnJZpMAZPqTmAkTDN2tapnH+Vj4t9onH7BGp/ilUvYag/ZblwTp/S9u9dPYzxsrhfeLJ3Ko53+eDBtaoE6NqMcCUOl2TDOb4ZWOi2bbjvoOGLpHBfBOXOcqwMxCTseggZW+DVrzu6CEeP6v+8xD13bp/MVYMPp5Uwdzc08K+M4DPmvQra+19sKmDW4C8YO+XOv414pGrTC8UuGsZp4wsqAO4LyGQWk4pUJtaAlO3hdSISIcYkPAPT9KsBsBTRY5Y62QYGIKFHMRp3nX6r+XiS5aNmmh1YL09mweA4Q+SFDeZo/KNgD+rA7osNkeTd9YkcfHvDX/I7jxb/s4Y8XDewMrVzEApqbLna5n8xtQjH19r06gwXPGOw77nfe7DimRWVtDwFNulSifOOFJ0H6BWXyGfgkSSlAZh/zlEN7GTZYH7Nm5zTSnD9lmnfGmCGtxjNfM9Hos2NYWIkPFijBSbgJy4XH9Km2Qvv7dlPkZWts24Yq/Dwicy3YEWKi8om1EbgF9Lpu2UYdPXTKaxrMxZW83Z0HmPl3Bn56YdM+D55wQqbdY+NsZc1Gc/FytiiijABLz5gOe98y0NbtIKOLoU6Gy4Mr9IbCOY4P
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(55112099003)(4143699003)(56012099003)(11063799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2d3SEZ6QXVUR0NTWU1MOGhLRmlDSGwwOSs3dk01SHBNSzAyVEc4RDVRelZK?=
 =?utf-8?B?aGxKOE1HZVVsU2JOWUhQaWtFVVVnUnYwODgyOEh2cGpjWFo0RTdvMFFTbm1C?=
 =?utf-8?B?N0FyMjE5UXNjSVdTS0swN0tGSHJGUVNXdWZIMk5INnJnSmlEY29obk9aTVFN?=
 =?utf-8?B?d2RUTGZRbEozeGpUZlYvRi9zaHdoVDJwbmRNTHE1K3ByTWxRU0JBdXp2WVBu?=
 =?utf-8?B?MXdRSjBnZGNxaGNQOWozOEhhbmFQaXIyN3N4eTRGUmRKL05VZXY2NkVCbnls?=
 =?utf-8?B?dHIzQXVmZ3VlUTc4Um1PM2NYeXhSR0VyU3dNVVpsd0F2V0FvaXVKUURMSE12?=
 =?utf-8?B?cFJIalBubzl0OUF3SHh3U3VnVjNlSTN5SytSc1F0NWRkbGs1WDl1cS9pOU1z?=
 =?utf-8?B?KzA0UTlxUEZzZ3ZTa2FLbU4zcXkwQUVHYUtBakNkckE1VnZTbzhtSFdFVXMy?=
 =?utf-8?B?QlJXNFpDZEltUWZaN2FQWXphNFhtVnQxSjlucFl0ZmtrWVlDZzg5cE5xQysv?=
 =?utf-8?B?ZHVRWEV0Y2VVbzRSVGpZdDM1RHdlS0g0UU50YW12TGMwTkZ5V25tc09kOGJr?=
 =?utf-8?B?YTcyQ3pSU2FvRWVuQS8ydENlN2tlQ0N2eDVQcHovRTJaWUpwOC8zZjZ0WFFB?=
 =?utf-8?B?cDMzdGdtUVA3elZlbEZkOERFUktjQ2svT1BudjZSNVVLay83UlRBaVVRcVJt?=
 =?utf-8?B?RG9TN3NBMGcwa0lJZFpYZkl4VVBZb2REeG5SNFJPZVZSblU2ek9qYW1Eazl5?=
 =?utf-8?B?ZzBlZ3VCNDRxenRESGdVZ3N1dU5hNjFtTlh6V1FKdDg2SnVzWnl6VzhuSVQ5?=
 =?utf-8?B?MUx1WCtKemJaV2pEeEZGUHFWUzQrV0dwSW9MYTBzWXgwWGZ1c0E4MHcvblJH?=
 =?utf-8?B?ZTdFSGVpN3pKcHgwM05VL05DVmZQQzBoQUlKRHUyRkZDcUlGb21kS3I1aW9j?=
 =?utf-8?B?RnNZUzgxVEtYVkt4RmhrOFN4RDd3enlpbFBJR0lYL0s2Ry9sR3NaNGFZd0tn?=
 =?utf-8?B?UzBSMGthb0dKM2VqckhVRWs4WmlRZnpuL3JWU0JTSCtqdUZsZTViWUhOZkZv?=
 =?utf-8?B?MHB1dzVpN29ta240TUVYOGIvM1A4N0xCRGU0a3htWkE2NXNWWW5nTjUyRWhB?=
 =?utf-8?B?VzhBaTlTSEthMDA4Mzk4cDgwYWIvaXAxcGV0REJSNncyNUw1ckNuWjFaOHJV?=
 =?utf-8?B?WnRZaHNBTVNhU0ExWXFkYURkREx2aGhrdE5kcHVHS1VFblpOQjVERzdJd1ZY?=
 =?utf-8?B?cHJJZTFKMHh1Vk0rM0JKSTRSdEs3Y0JIc1QxbXJLeXlZOHhlVVBnYUFKSE5C?=
 =?utf-8?B?dTVrbGJVSjlmSVdwN1ZqcHJ1T0I5Y3c4Q3g3MzMvVzZPVU1UM3NSSEhsSjFs?=
 =?utf-8?B?bk9yeDFQcEJiRHdFK3JpNTJmeEcwSDhpNUdLNmxiWHA0ZzJRdmZLN251c21Z?=
 =?utf-8?B?bEtxN3E3b21CckU3SU1yYnRCVGgwQkNzSm15dkEvdCtNazQydStkVFJZc2Ex?=
 =?utf-8?B?bTFoR3BXQ01XL2wydWFLRzc0REpmQkpaaGxuaVk2RzlyMVl6OWZTQVE4dGhs?=
 =?utf-8?B?TnhUanpORUxCclhKN1pPRlhaSEowY1B3QUZFUktOTG1ETDFadlR1RjVsSjM4?=
 =?utf-8?B?TUg4Vko3RHRlRnRHeFRTN2lMNWFyZDVKOWUrd0hEN3hCVktmUUVkUzVZR2NM?=
 =?utf-8?B?K1RuVXcxSnplSTU0U0JEc01GRkVnQWthVHVwSnhwazdnSWplY2pyNTNpZmMr?=
 =?utf-8?B?TElEbWs2S1pHVmFPWnVBUlc2cWNrZ3pVSmdTaUNtaTVudy9CaUladTBUazBq?=
 =?utf-8?B?eXQxU2puY3ZGckt6ZVdyU3NyQmMvSldwZjE3WG1IejNVbXNMUm40MHl4cHl1?=
 =?utf-8?B?Q1Zic2ZSdktoeThyTjJxTzF3Wm13K25DT21PVXRWdVh4bmZ4MGdYRlp5anlp?=
 =?utf-8?B?dHZ2TFZraWZ3SzVNU2xncFg0dk1WTE5OeEtGSGZ6OFppeUVkVHhaNXd1TVdF?=
 =?utf-8?B?dTBrSWFIR21BYzdQTWdXKytJc1VKRmlqM010akdOU3Z0NXh0cHlOUGg0U0FV?=
 =?utf-8?B?aG5FdFk1bWlRNDRWMHZiRG9GajVXblBYRGR6ejVJS1JkM1ZNQncreHQrd243?=
 =?utf-8?B?aUd6bW42MUZkU2gyWUlhSzhlSjNlQUlMOE5mY3JkVTMwZkdwUEptSHJlTnBq?=
 =?utf-8?B?azhDWU5yMXJhZnlkWEhmeERMaDlhTGNkRjBuVkpsTXdJUS84VVBiZDFYR3Nm?=
 =?utf-8?B?bGg4eTZtOXRhOENJcGFqcDh6RnZoRmVSY1pjT2xFYTVZMEtsbWZ4OWRVMU9i?=
 =?utf-8?B?NXNzSWZVUUJWWSsvMHhSaUd0NzhRT3NzZVd6OGZqWXlnYmtsYnZ1dGJlQldL?=
 =?utf-8?Q?Ef3MAR3tyGOLbXZykX0FTaUhPCnD57En5MbUF?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a824f8-94be-4f32-6d90-08deb17b93b5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 05:42:25.4168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xak3tUefBXxnV3iBaisteKx8EY5dxo2mtuH9RDQQXUy58hyvGOomu/DKH4ml354Koz3xEXwSpMcvjioVwVYJVLRroIgRYD5e6u2+X8nOgmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR03MB8465
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

Hi Tien Fong,

On 7/5/2026 5:31 pm, Chee, Tien Fong wrote:
> Hi Alif,
> 
> 
> On 28/4/2026 11:48 am, alif.zakuan.yuslaimi@altera.com wrote:
>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>
>> Combine all MMC and QSPI configs into single defconfig which is named
>> as "socfpga_stratix10_defconfig". This will be the default defconfig to
>> use.
>>
>> This will support booting from all three flashes using ARM Trusted Firmware
>> (ATF) as the secure runtime monitor.
>>
>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>> ---
>>    configs/socfpga_stratix10_atf_defconfig | 90 ----------------------
>>    configs/socfpga_stratix10_defconfig     | 99 +++++++++++++++----------
>>    2 files changed, 58 insertions(+), 131 deletions(-)
>>    delete mode 100644 configs/socfpga_stratix10_atf_defconfig
>>
>> diff --git a/configs/socfpga_stratix10_atf_defconfig b/configs/socfpga_stratix10_atf_defconfig
>> deleted file mode 100644
>> index 206343885d9..00000000000
>> --- a/configs/socfpga_stratix10_atf_defconfig
>> +++ /dev/null
>> @@ -1,90 +0,0 @@
>> -CONFIG_ARM=y
>> -CONFIG_COUNTER_FREQUENCY=400000000
>> -CONFIG_ARCH_SOCFPGA=y
>> -CONFIG_TEXT_BASE=0x200000
>> -CONFIG_SYS_MALLOC_LEN=0x500000
>> -CONFIG_NR_DRAM_BANKS=2
>> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>> -CONFIG_SF_DEFAULT_MODE=0x2003
>> -CONFIG_ENV_SIZE=0x1000
>> -CONFIG_ENV_OFFSET=0x200
>> -CONFIG_DM_GPIO=y
>> -CONFIG_DEFAULT_DEVICE_TREE="socfpga_stratix10_socdk"
>> -CONFIG_DM_RESET=y
>> -CONFIG_SPL_STACK=0xffe3f000
>> -CONFIG_SPL_TEXT_BASE=0xFFE00000
>> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>> -CONFIG_SPL_BSS_START_ADDR=0x3ff00000
>> -CONFIG_SPL_BSS_MAX_SIZE=0x100000
>> -CONFIG_SYS_BOOTM_LEN=0x2000000
>> -CONFIG_SYS_LOAD_ADDR=0x02000000
>> -CONFIG_TARGET_SOCFPGA_STRATIX10_SOCDK=y
>> -CONFIG_IDENT_STRING="socfpga_stratix10"
>> -CONFIG_SPL_FS_FAT=y
>> -CONFIG_REMAKE_ELF=y
>> -CONFIG_FIT=y
>> -CONFIG_SPL_FIT_SIGNATURE=y
>> -CONFIG_SPL_LOAD_FIT=y
>> -CONFIG_SPL_LOAD_FIT_ADDRESS=0x02000000
>> -CONFIG_BOOTDELAY=5
>> -CONFIG_USE_BOOTARGS=y
>> -CONFIG_BOOTARGS="earlycon"
>> -CONFIG_USE_BOOTCOMMAND=y
>> -CONFIG_BOOTCOMMAND="run fatscript; run mmcfitload; run mmcfitboot"
>> -CONFIG_SYS_PBSIZE=2085
>> -CONFIG_SPL_MAX_SIZE=0x40000
>> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>> -CONFIG_SPL_HAVE_INIT_STACK=y
>> -CONFIG_SPL_SYS_MALLOC=y
>> -CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
>> -CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
>> -CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
>> -CONFIG_SPL_SPI_LOAD=y
>> -CONFIG_SYS_SPI_U_BOOT_OFFS=0x02000000
>> -CONFIG_SPL_ATF=y
>> -CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>> -CONFIG_SPL_TARGET="spl/u-boot-spl-dtb.hex"
>> -CONFIG_HUSH_PARSER=y
>> -CONFIG_SYS_PROMPT="SOCFPGA_STRATIX10 # "
>> -CONFIG_CMD_MEMTEST=y
>> -CONFIG_CMD_GPIO=y
>> -CONFIG_CMD_I2C=y
>> -CONFIG_CMD_MMC=y
>> -CONFIG_CMD_SPI=y
>> -CONFIG_CMD_USB=y
>> -CONFIG_CMD_DHCP=y
>> -CONFIG_CMD_MII=y
>> -CONFIG_CMD_PING=y
>> -CONFIG_CMD_CACHE=y
>> -CONFIG_CMD_EXT4=y
>> -CONFIG_CMD_FAT=y
>> -CONFIG_CMD_FS_GENERIC=y
>> -CONFIG_ENV_IS_IN_MMC=y
>> -CONFIG_ENV_RELOC_GD_ENV_ADDR=y
>> -CONFIG_NET_RANDOM_ETHADDR=y
>> -CONFIG_SPL_DM_SEQ_ALIAS=y
>> -CONFIG_SPL_ALTERA_SDRAM=y
>> -CONFIG_DWAPB_GPIO=y
>> -CONFIG_DM_I2C=y
>> -CONFIG_SYS_I2C_DW=y
>> -CONFIG_SYS_MMC_MAX_BLK_COUNT=256
>> -CONFIG_MMC_DW=y
>> -CONFIG_SPI_FLASH_SPANSION=y
>> -CONFIG_SPI_FLASH_STMICRO=y
>> -CONFIG_PHY_MICREL=y
>> -CONFIG_PHY_MICREL_KSZ90X1=y
>> -CONFIG_ETH_DESIGNWARE=y
>> -CONFIG_MII=y
>> -CONFIG_SYS_NS16550_MEM32=y
>> -CONFIG_SPI=y
>> -CONFIG_CADENCE_QSPI=y
>> -CONFIG_DESIGNWARE_SPI=y
>> -CONFIG_USB=y
>> -CONFIG_USB_DWC2=y
>> -CONFIG_USB_STORAGE=y
>> -CONFIG_DESIGNWARE_WATCHDOG=y
>> -CONFIG_WDT=y
>> -# CONFIG_SPL_USE_TINY_PRINTF is not set
>> -CONFIG_PANIC_HANG=y
>> -CONFIG_SPL_CRC32=y
>> diff --git a/configs/socfpga_stratix10_defconfig b/configs/socfpga_stratix10_defconfig
>> index ef21dc92493..02a1875a72e 100644
>> --- a/configs/socfpga_stratix10_defconfig
>> +++ b/configs/socfpga_stratix10_defconfig
>> @@ -1,93 +1,110 @@
>>    CONFIG_ARM=y
>>    CONFIG_COUNTER_FREQUENCY=400000000
>> +CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
>>    CONFIG_ARCH_SOCFPGA=y
>> -CONFIG_TEXT_BASE=0x1000
>> -CONFIG_SYS_MALLOC_LEN=0x500000
>> +CONFIG_TEXT_BASE=0x200000
>> +CONFIG_SYS_MALLOC_F_LEN=0x2000
>>    CONFIG_NR_DRAM_BANKS=2
>> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x101000
>> -CONFIG_SF_DEFAULT_MODE=0x2003
>> -CONFIG_ENV_SIZE=0x1000
>> -CONFIG_ENV_OFFSET=0x200
>> +CONFIG_ENV_SIZE=0x2000
>> +CONFIG_ENV_OFFSET=0x04100000
>> +CONFIG_ENV_SECT_SIZE=0x20000
>> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x04000000
>>    CONFIG_DM_GPIO=y
>>    CONFIG_DEFAULT_DEVICE_TREE="altera/socfpga_stratix10_socdk"
>>    CONFIG_OF_UPSTREAM=y
>> -CONFIG_DM_RESET=y
>> -CONFIG_SPL_STACK=0xffe3f000
>>    CONFIG_SPL_TEXT_BASE=0xFFE00000
>> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>> -CONFIG_SPL_BSS_START_ADDR=0x3ff00000
>> -CONFIG_SPL_BSS_MAX_SIZE=0x100000
>> -CONFIG_SYS_BOOTM_LEN=0x2000000
>> -CONFIG_SYS_LOAD_ADDR=0x02000000
>>    CONFIG_TARGET_SOCFPGA_STRATIX10_SOCDK=y
>>    CONFIG_IDENT_STRING="socfpga_stratix10"
>>    CONFIG_SPL_FS_FAT=y
>> -# CONFIG_PSCI_RESET is not set
>> -CONFIG_SYS_MEMTEST_START=0x00000000
>> -CONFIG_SYS_MEMTEST_END=0x3fe00000
>> -CONFIG_OPTIMIZE_INLINING=y
>> -CONFIG_SPL_OPTIMIZE_INLINING=y
>> -CONFIG_REMAKE_ELF=y
>> +CONFIG_DISTRO_DEFAULTS=y
>> +CONFIG_FIT=y
>> +CONFIG_SPL_FIT_SIGNATURE=y
>> +CONFIG_SPL_LOAD_FIT=y
>> +CONFIG_SPL_LOAD_FIT_ADDRESS=0x02000000
>> +# CONFIG_USE_SPL_FIT_GENERATOR is not set
>> +CONFIG_QSPI_BOOT=y
>>    CONFIG_BOOTDELAY=5
>>    CONFIG_USE_BOOTARGS=y
>> -CONFIG_BOOTARGS="earlycon"
>> -CONFIG_USE_BOOTCOMMAND=y
>> -CONFIG_BOOTCOMMAND="run fatscript; run mmcload; run linux_qspi_enable; run mmcboot"
>> -CONFIG_SYS_PBSIZE=2085
>> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>>    CONFIG_SPL_MAX_SIZE=0x40000
>> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>> +CONFIG_SPL_BSS_START_ADDR=0x3ff00000
>>    # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>>    CONFIG_SPL_HAVE_INIT_STACK=y
>> +CONFIG_SPL_STACK=0xffe3f000
>>    CONFIG_SPL_SYS_MALLOC=y
>>    CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
>>    CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
>>    CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
>> +CONFIG_SPL_BSS_MAX_SIZE=0x100000
>> +CONFIG_BOOTARGS="earlycon panic=-1"
>> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> 
> 
> Remove one of the two identical # CONFIG_SPL_RAW_IMAGE_SUPPORT lines.
> Regenerate defconfig with make savedefconfig
> 
> 
Noted, I will clean this up with savedefconfig for v3.

>> +CONFIG_SPL_CRC32=y
>> +CONFIG_SPL_MTD=y
>> +CONFIG_SPL_MTD_SUPPORT=y
>>    CONFIG_SPL_SPI_LOAD=y
>> -CONFIG_SYS_SPI_U_BOOT_OFFS=0x3C00000
>> -CONFIG_SPL_TARGET="spl/u-boot-spl-dtb.hex"
>> -CONFIG_HUSH_PARSER=y
>> +CONFIG_SPL_ATF=y
>> +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>>    CONFIG_SYS_PROMPT="SOCFPGA_STRATIX10 # "
>> +CONFIG_CMD_NVEDIT_SELECT=y
>>    CONFIG_CMD_MEMTEST=y
>> +# CONFIG_CMD_FLASH is not set
>>    CONFIG_CMD_GPIO=y
>>    CONFIG_CMD_I2C=y
>>    CONFIG_CMD_MMC=y
>> +CONFIG_CMD_MTD=y
>>    CONFIG_CMD_SPI=y
>>    CONFIG_CMD_USB=y
>> -CONFIG_CMD_WDT=y
>> -CONFIG_CMD_DHCP=y
>> -CONFIG_CMD_MII=y
>> -CONFIG_CMD_PING=y
>>    CONFIG_CMD_CACHE=y
>> -CONFIG_CMD_EXT4=y
>> -CONFIG_CMD_FAT=y
>> -CONFIG_CMD_FS_GENERIC=y
>> -CONFIG_ENV_IS_IN_MMC=y
>> -CONFIG_ENV_RELOC_GD_ENV_ADDR=y
>> -CONFIG_USE_BOOTFILE=y
>> -CONFIG_BOOTFILE="Image"
>> +CONFIG_SPL_SPI_FLASH_MTD=y
>> +CONFIG_SPI_FLASH_MTD=y
>> +# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
>> +CONFIG_CMD_UBI=y
>> +CONFIG_CMD_UBIFS=y
>> +CONFIG_MTD_UBI=y
>> +CONFIG_MTD_UBI_WL_THRESHOLD=4096
>> +CONFIG_MTD_UBI_BEB_LIMIT=20
>> +# CONFIG_ISO_PARTITION is not set
>> +# CONFIG_EFI_PARTITION is not set
>> +CONFIG_OF_LIST=""
>> +CONFIG_ENV_IS_IN_FAT=y
>> +CONFIG_ENV_IS_IN_UBI=y
>> +CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
>> +CONFIG_ENV_UBI_PART="root"
>> +CONFIG_ENV_UBI_VOLUME="env"
>> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>>    CONFIG_NET_RANDOM_ETHADDR=y
>>    CONFIG_SPL_DM_SEQ_ALIAS=y
>>    CONFIG_SPL_ALTERA_SDRAM=y
>> +CONFIG_FPGA_INTEL_PR=y
>>    CONFIG_DWAPB_GPIO=y
>>    CONFIG_DM_I2C=y
>>    CONFIG_SYS_I2C_DW=y
>> -CONFIG_SYS_MMC_MAX_BLK_COUNT=256
>> +CONFIG_MISC=y
>>    CONFIG_MMC_DW=y
>> +CONFIG_SYS_MMC_MAX_BLK_COUNT=256
>> +CONFIG_MTD=y
>> +CONFIG_DM_MTD=y
>> +CONFIG_SF_DEFAULT_MODE=0x2003
>>    CONFIG_SPI_FLASH_SPANSION=y
>>    CONFIG_SPI_FLASH_STMICRO=y
>>    CONFIG_PHY_MICREL=y
>>    CONFIG_PHY_MICREL_KSZ90X1=y
>> +CONFIG_DM_ETH=y
>>    CONFIG_ETH_DESIGNWARE=y
>>    CONFIG_MII=y
>> +CONFIG_DM_RESET=y
>>    CONFIG_SYS_NS16550_MEM32=y
>>    CONFIG_SPI=y
>>    CONFIG_CADENCE_QSPI=y
>>    CONFIG_DESIGNWARE_SPI=y
>>    CONFIG_USB=y
>> +CONFIG_DM_USB=y
>>    CONFIG_USB_DWC2=y
>> -CONFIG_USB_STORAGE=y
> 
> 
> missing vs ATF defconfig, why dropping this?
> 
> 
> Best regards,
> 
> Tien Fong
> 
This is not needed to be enabled as CONFIG_DISTRO_DEFAULTS is enabled in 
this defconfig.

CONFIG_DISTRO_DEFAULTS -> BOOT_DEFAULTS_FEATURES -> USB_STORAGE in 
boot/Kconfig

Thanks,
Alif




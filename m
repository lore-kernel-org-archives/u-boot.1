Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6740FC47422
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 07:19:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92FFD87BBA;
	Wed, 24 Jan 2024 08:19:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3rcYk1hl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65E3287BCE; Wed, 24 Jan 2024 08:19:16 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 056BA87BA2
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 08:19:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPKylOzS5uIIycp9hp1bKld4Xd32+tsD6g+3qtUkp0/AqjS/V+l9qQ0jdotpEqiH4wJAM1mYbjBhfvVlE2Y33x7FliSl/l36o0relnKZwaXVxPlVYscQf/y86GXGuXk0BSmg8OY+Uab4uFQoJ2+tu5nQqEV/zdU/l+vc3PO6JGl9sBd2+DnYOBXQbCux+XfKWjKG05jXzX0YAfnaVmUT4kweTooIV0QWgjFAVMNrxo55XmgO8Q1Mnwl+4Ulaq5oUBneBMUqRFVnhdQpdcNnwgYk79H/MgNF9JEnKX1sasg2/1Yse3EiUpCO9CHeWFC8D4sJLEXrH7kRxzVoAY1vWrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJ4E6W0SPGp5MB4mpDovWvy5RyUEn+OMvFhStCs966k=;
 b=QoMrAx8Mttn2OK2nYRUoBBSj4665I14BReSRn1/6pCsmQuZhFOBtH1EjE8TIBE/JMM+CgUWSy84kB1Am3E+oqIr2uQN5OrAEIQM8AHVHlscTYccmuWK0trIJGWw3ViZk+zmHQ9oZb4Doo+bZaoayZpBxwDlOzDFZJl5S17Vk5h4JAQ96QJO4msnUFcNXJ1imzU1hbUENlfJ0X5QEdjAbYP9hlw344lcMNjwDNHrSUt9IjgcLLfSDQEZ2iYJiCZXTiywD2P6Mbc/x2hXbyastA6UXCCzLBpJ4oDG5jLY407c9Ry/Dx/DtpPnpF00uJRyqiVlBLZZYAyIrritDGU4OQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJ4E6W0SPGp5MB4mpDovWvy5RyUEn+OMvFhStCs966k=;
 b=3rcYk1hlBhk/vyaDv3dxXB7JDH/mG+ifuCkH/SnUBt4kmnBiizSj83Hj2AwjvNF306m+bmdev9ZLyEMpS9P8vfAPh9h3KZyvbvmJ9M5ZEB1MYMoxIOqrBlBg7THm7Y9OLNqU+eDQPdJj9nXqlh/nPbPRMQ9wOFDdLqJSLqqWcCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by DS0PR12MB6606.namprd12.prod.outlook.com (2603:10b6:8:d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Wed, 24 Jan
 2024 07:19:09 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 07:19:09 +0000
Message-ID: <3b14e176-3e05-4cc1-9099-507080d12aee@amd.com>
Date: Wed, 24 Jan 2024 08:19:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] xilinx_mbv: Remove empty config header
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240122223920.3630168-1-trini@konsulko.com>
 <20240122223920.3630168-2-trini@konsulko.com>
 <d6f63f01-5b53-48da-ab50-75bf8f0d83c3@amd.com>
 <20240123175851.GU3652023@bill-the-cat>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240123175851.GU3652023@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0087.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::28) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|DS0PR12MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a02836-b3b8-4f6e-c9ec-08dc1cacc1f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gTirieaQPhesr7G/ZaR8sWCk8i1HfFjT4vZFUWkgxbSv6PsMEtJSs7IldMWXYgfsjb3m2CFob8Qx+fkbkUizRnVCvRB7lBlE2rmNWRYzKOWohZrfazxYXhlr1xvSL2YlPm4i2YYWs/7lWGAxIo0jUUbLO2PALsS5v1C+PxQ/fCOHgZsGtym0iHBERGG5LoHVs483J5A6V4O6ptE/BvH43JDvny3pZ1vH0Fqkt6wvGnUcRalYocYU09EYHOYfoVX52msdIvn6de1uYSdF9x6fGS+qpFyiZMeQwpNl0/msoEXhIBM1TSLcKfPKdnRdPE9/69/gO9vqdgPLCA0knrBkc6axY26L4QOdHpjllnUsUkR0YYjG0Y5tyGj48rB3tCWHcD4MHW2ZKdeCM+L/FVa1MBW0QnAJD3wn/vF1/XGVnqM5saDRPhi5HNGZyqL25jLPFZbDQx0MwUK+L+DZK2A3MASjaGt8du0fI8RJAxCD197EpwKmFvfTK+Q/cm1oE8JFrE8F4jNvFSUNeku7/8F0iPZlvD31xSI4zgdXGTOYtLFYp/IqMl/UJP/nyDsd5Gc9GJy77Z7Nprcnyq9vQ/4SZmZ55EjUKbIjHM6thTGs1AT6ltwxak7LpXEhODvjFl0PkbxOIgxyRl6MBjqUHJWSRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(376002)(136003)(346002)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(6512007)(6666004)(478600001)(6506007)(53546011)(31696002)(8676002)(4326008)(8936002)(5660300002)(66556008)(2906002)(44832011)(36756003)(6916009)(316002)(66476007)(41300700001)(66946007)(86362001)(6486002)(26005)(83380400001)(31686004)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWdZaUlTUllhT1crb0diQ3F5UmI2UkxPb2wxSXNMMWpOMTJRaTVSUGRXQU5U?=
 =?utf-8?B?OXFaRWcyVUdUak9lckkzTCtoRkg2MUN4MWpuK2RDaVBPTzI0aS9iSEFSa21W?=
 =?utf-8?B?dUQxNjNqSWgvZ2w4c1FxVzhNUmo5QmwyMGRkTDh0WXdFejJsb1hrZjkzME9I?=
 =?utf-8?B?YzFVZ2dOcnlYOTd1MXN1NFhGZHBjc3pyWGliTEJDOXJKbUlDNXRYeG5pZnZ3?=
 =?utf-8?B?SkFwbXZXakcrQk81UDh2cVV5bXVoRnA5SGo2YnBGZFEzMGtERzRBU296WFhM?=
 =?utf-8?B?SnVSZmJHdG42Yy96cW1PQlk4Y3RwTkM3bGcvcUpleXAwTFBQdVJjL1ZIbi9p?=
 =?utf-8?B?OEFkY0NJTmNMOGN6WURlV0V5SzFNVVJDaHI0UDhqcG1sUGlFMG4rYzdNV1Fl?=
 =?utf-8?B?SnpLN0tTS3hoVVRTTmFSZGtSWUlOUzBLVWVlaWZ2TE5XQ0xRYm9XamY1M3Qr?=
 =?utf-8?B?ZlU0T2g4QllFYXJHank3M3U3bktlc21PRDJDbDJ4VGs4WWhIbzNCSFF1dSt2?=
 =?utf-8?B?Q1Y5QWtPODBGU09iOVBrNlRvSDVKK3luTksxNEVzbGppODNxZml1TUVjekNt?=
 =?utf-8?B?c25JWG5PRFBxTkdVMFJpblg5bi9TaGpOZjlwL2ovaUlCV3NTVlZuR3A3QTYv?=
 =?utf-8?B?OFFjOS82bWQ4UWV1dFgxUzFKelQvL2hhdXlkV2hzV3hjOUc5RnBCZDcxYnNs?=
 =?utf-8?B?bzE5N3dBL296VFdVUlh6ZDZVaVhaaUtJK0pweHUyUVk2V3owUVBxWWhISjFV?=
 =?utf-8?B?UG4rTnBxRnRsODlvZVJKc0xzYk81L1cwRmZZTGwxNEdtaWtsN1ozOUxxVEZL?=
 =?utf-8?B?ZmJjWm0vd2FMeDF1OHlrZDVCTytYM0dObUlEWWdZejN2RXVXdjgwcnppZlVp?=
 =?utf-8?B?WWR4ZXRLdFJraitkTEtySmhSTnZNQS9QclZPeUxvRUtJQ000ZEFSWERXM0tW?=
 =?utf-8?B?UVlwdjdiZ1Y3Nzk5L1hEbE5XUXZMK1JjT2ZiUmtQYlltV3Izc3VqS01naGd6?=
 =?utf-8?B?Uzd0NmNxZFJITXprZk1EcmJCVHlrN3FmV29TYitVMTMyMkYvOXlJUEdqWnVN?=
 =?utf-8?B?ZzJ6a3RzeHp2bXp5SXc1T2dwRXNOWGRjaE9NQm9lVTVRM3VsMGhUVE1DRFJk?=
 =?utf-8?B?c1d5QXlsWlRXcTE0TEFrV1psTmdDaFpacTN3MXFrcGVIQXdCZVphUy9VU1JD?=
 =?utf-8?B?cG9rK0hrOWRZREF3WFAwRXRNaTBTaEpmQno1N3BMZGZPTGlpZ3NTWkpsWGxH?=
 =?utf-8?B?YUl4ejRDY0tyMmIrYTY2NnZyQ0NCZklqdkIzelFSM0h6M3JNZHJLeEVDWFUz?=
 =?utf-8?B?ZmhXUzJKbFgwcmdaekRMeUdCWjZGbnIva05xeGo2SXo3UzA4QXd1eHpkVjN3?=
 =?utf-8?B?SitZenlHV3hlaUQwcEJQVTNXYVAwZGM5WU0vYWE4akwrVGxGTTBpREhyNExG?=
 =?utf-8?B?ajJUY0VLdW5mM3ZlK09TK01oUjlETUtiY0FnZGkwcXIyM3crRzlpbkNQVmZh?=
 =?utf-8?B?WkVyTTlqcjNvVkRoSXVYUEdXTUhDMHZ0eE9Tak9qRVFLY0dYV1pseW51eERa?=
 =?utf-8?B?WUNrVkVtQkVxcHcxU2Z3bzdnc2V0MS9ML0k0eGwwc2xDdmFnUzFaWVlSZWR1?=
 =?utf-8?B?V3IrUEgvSFhwZ0NaQWpoaE96VDlqUFpYMG5UOUdMd1JzK1pjcUMvYUhnY21C?=
 =?utf-8?B?MDR0Vml4T3dzQ1dJM2dqem4vYUdCRERyTkxNQS9nbDB6bXMzVW1yNGhjMUNC?=
 =?utf-8?B?VFV1bklaUUltMmJ1YUQyd1VsTGRGMWkwczJ5VlROSk01VDlDN2pOVzRBbllF?=
 =?utf-8?B?STR5Z0dPM2E4MUtJVEFPemdPVUxudUZlcVhhMVdHZ3lIOE9JVUZDTFduTXcv?=
 =?utf-8?B?bUU0dnB3TEU0RG1Kd3NjNG9mdnpyT1drNlFQQlNCR25NellqRyt3RjNGUkVK?=
 =?utf-8?B?QllJN3FDSXE3ZmFESU1vUUJxYkpuRDExdXRwanJMbEhtM1IyU0UwTmdHK3pP?=
 =?utf-8?B?K2FPOXdwOUVWT3NaMTg3N0s4TG9uY1dlQlM3VWZNRkxxWGVsVmJRdFdmWjN3?=
 =?utf-8?B?c1oyeHBZWWdNYzJHNHc4RzVxTkhEQ3FjZU9hZC9IV3YyeVg1ODlEc1hmK0NL?=
 =?utf-8?Q?ww+NFHJR20UJXsY61uJBHVErY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a02836-b3b8-4f6e-c9ec-08dc1cacc1f6
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 07:19:09.5721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tI/Lospjz3ClEHHgz7KmQLI/hJmD9T4cDzXJ+OA1nJIjXe08SrQPfdTpCJ8dymQm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6606
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



On 1/23/24 18:58, Tom Rini wrote:
> On Tue, Jan 23, 2024 at 08:53:21AM +0100, Michal Simek wrote:
>>
>>
>> On 1/22/24 23:39, Tom Rini wrote:
>>> Now that we support having CONFIG_SYS_CONFIG_NAME be unset to indicate a
>>> lack of board.h file, unset this on the xilinx_mbv platforms and remove
>>> the otherwise empty file.
>>>
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>>> Cc: Michal Simek <michal.simek@amd.com>
>>> ---
>>>    board/xilinx/mbv/Kconfig     | 3 ---
>>>    board/xilinx/mbv/MAINTAINERS | 1 -
>>>    include/configs/xilinx_mbv.h | 6 ------
>>>    3 files changed, 10 deletions(-)
>>>    delete mode 100644 include/configs/xilinx_mbv.h
>>>
>>> diff --git a/board/xilinx/mbv/Kconfig b/board/xilinx/mbv/Kconfig
>>> index 4bc9f72c541b..d2dec397ed6f 100644
>>> --- a/board/xilinx/mbv/Kconfig
>>> +++ b/board/xilinx/mbv/Kconfig
>>> @@ -9,9 +9,6 @@ config SYS_VENDOR
>>>    config SYS_CPU
>>>    	default "generic"
>>> -config SYS_CONFIG_NAME
>>> -	default "xilinx_mbv"
>>> -
>>>    config TEXT_BASE
>>>    	default 0x80000000 if !RISCV_SMODE
>>>    	default 0x80400000 if RISCV_SMODE && ARCH_RV32I
>>> diff --git a/board/xilinx/mbv/MAINTAINERS b/board/xilinx/mbv/MAINTAINERS
>>> index 445654fe740e..db9f03388df9 100644
>>> --- a/board/xilinx/mbv/MAINTAINERS
>>> +++ b/board/xilinx/mbv/MAINTAINERS
>>> @@ -4,4 +4,3 @@ S:	Maintained
>>>    F:	arch/riscv/dts/xilinx-mbv*
>>>    F:	board/xilinx/mbv/
>>>    F:	configs/xilinx_mbv*
>>> -F:	include/configs/xilinx_mbv.h
>>> diff --git a/include/configs/xilinx_mbv.h b/include/configs/xilinx_mbv.h
>>> deleted file mode 100644
>>> index dba398aeec49..000000000000
>>> --- a/include/configs/xilinx_mbv.h
>>> +++ /dev/null
>>> @@ -1,6 +0,0 @@
>>> -/* SPDX-License-Identifier: GPL-2.0 */
>>> -/*
>>> - * (C) Copyright 2023, Advanced Micro Devices, Inc.
>>> - *
>>> - * Michal Simek <michal.simek@amd.com>
>>> - */
>>
>> Acked-by: Michal Simek <michal.simek@amd.com>
>>
>> But maybe in future we need to revert this patch to add more options there.
>> Or do you plan to remove all of these configs?
>> I can imagine distro boot wiring but that can be done via vars file only but
>> it is not practical.
> 
> Do you mean that plain text environment feels impractical for standard
> boot (which should be used instead of the pure scripts of distro_boot) ?

I didn't play with standard boot yet to find out how to prioritize certain 
devices at run time. But normally we are trying to keep all amd platforms in 
sync to make sure that from user perspective doesn't really matter if you are on 
microblaze, arm32, arm64 or risc-v based platform.

There are still a lot of configs like GUIDs, dfu and others that I don't think 
we will end up without these config files anytime soon. But it doesn't mean we 
shouldn't aim for it.

Thanks,
Michal






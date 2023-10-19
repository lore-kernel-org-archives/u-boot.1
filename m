Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7A7CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 10:29:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB11A871F7;
	Thu, 19 Oct 2023 12:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DiFYkjDO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5415A871F5; Thu, 19 Oct 2023 12:28:48 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7206871E2
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 12:28:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jx/fA512Wv3y3mG/+BnvKhBP7StyOMRN3fPcw4mFeXYcq010F9FXp50hX+MYlsVZqz7kI7kvOnkareslkNpa0caf5Z3bElVoqkQW3DVGRA2HKGa2/XxdueRQz5EGnX3LxwFp+gA/EeBQdwOC1hTEWZAJEX0ef2lDsTtstJ8trz2N3xpLZOVWCKO4PId+sxO4qRy6TAILtRV//xOv1QTKaLF6Kg8TvCWZ7G3sksRfwJYpZh7hqorxV/GHZtWs4JopAWFW/pLHxTI2oMKCerIC2lwgVgUu2peeiYEpYk+v1OD0/pibt9vF494azeZ82IZFh8OXf03S+TlFikrS3kPyUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/6BMROhLQ1gZquoATrFwfqiuwvSDLJ8vgpN9UyXZZY=;
 b=WAqXdLS4xnKgk6Hp5ZIVuSF+8bFTY+5lX3ze40Uw+IxZ+ixVjtVXH4c6TQuNColya8hColeZYlqL8hPFVTYNWd19o0w0JD+BXXVL5OIpAyA0zCSblflvS7nbljiRFxZ8XFNpqCjAWiAVFWU86qXynDPzOPWd+VDzGldcsl58PqnSBllrmoYyyZbVmSa0NP7HTZcb0K3J53bfbn10MaSOzFSuFWRZc1do072D4W7T7LD06ajV+jPBdYXvZxClPguKo5koYsWz5bYZ4NvVdtPu2zrBtiumGBHvDHayNdqioBe+qT7qhaCzLILNXcBNlyEB2kMFHbMbhUZ+CqwTA4ArPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/6BMROhLQ1gZquoATrFwfqiuwvSDLJ8vgpN9UyXZZY=;
 b=DiFYkjDOBv+/G8d7DXP8LOK+J1QHpRjHbd53oWd5XdQMfuj2fsDmvVbBaj27jw1ByobG3KPQztylG0o8e0t4O5DwYJwzpGwtzd8silzIx5l4WFF0wOkKo/EXzJLVrOpfKK/AI1ANLxicCgM7k2LRlNPkTFdT77Fd0kUONiAuVWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Thu, 19 Oct
 2023 10:28:42 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::b220:eeee:98e7:a62e]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::b220:eeee:98e7:a62e%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 10:28:41 +0000
Message-ID: <687ace07-c2ba-49c8-9e2d-86a7297ff922@amd.com>
Date: Thu, 19 Oct 2023 12:28:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] Add support to fetch baudrate from dtb
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, git@xilinx.com
References: <20230921112043.3144726-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20230921112043.3144726-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0066.eurprd03.prod.outlook.com
 (2603:10a6:803:50::37) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ca58aa-31b0-44f0-1f84-08dbd08e29e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BnTlmd8Ua/7SPq7b77UezGleG3cGdyolqRn0XOqBL0CVAtn95dvTtO116ghuwGcOhI6MDmmZD0rxtG1PtCFJYVszAEe/1Q2m1/uNJPKSPjD9FsPTXqf6nwFf+pb0rwLb9eTWS0+HaPZjtONux7t4z4BrYd78CViBr8N40pTOgdUBFBIMLUfKfz5KpDcJ6hfx+sKqfjjCEVws36F8gEUqobNWNBqIqrAfrYBDOgpbBD7Ptv/CpC7tfyMkuk9oWvIDwz17z7z76DT5+ssk7zJ8hxtWJ0ubmNrCRWTehsCidvEuu7iQbI06L78ypsLRn5wmRiTSunb2/AUR/HYFM7nP3O4RFICGh28QK/hFdmdWPvzN3NoGj2RrP4m5F2HIVEf2IlB6NNRu/DNmsNL/pChAhv9Cmdc3i/XA7AY9WaXbRNodgABQHKWcejC/9IcymK/jxRKhlPed8zKioq8SleZLS++GbQz4U4MA1kVZCTrEUjLdoWFOL8bynew98Vyle2A2GeHfI6TYDzsHECy09I5fzUX1UawXHJYax2vrkDLp5hPyultS27GZ1SLMqFFKlEfQkxAs16Hv1IhXMea/HZwAZFW8YwFNISv70QzpKguNM/0jywmCVNKJoB6GNsMjqeUyphqG/C2o+OCm9bdzpN/feQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(366004)(346002)(136003)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(36756003)(4326008)(44832011)(5660300002)(66476007)(66556008)(41300700001)(316002)(8936002)(2906002)(8676002)(31696002)(86362001)(66946007)(31686004)(83380400001)(38100700002)(478600001)(6666004)(6512007)(53546011)(6506007)(2616005)(26005)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWZuMVhhQlFtczZ3eDlpZVV5OEJueWNMNjF4b0o5dTdSK0lEUVNGRHVHOUtL?=
 =?utf-8?B?dXQwMmxLdGl3R20xYTdkVGhNQjJTb0dTQldGWFpkelRpS1ZEUC9vNFZFTUZr?=
 =?utf-8?B?bkdXa0pzcHlzODhDaDRsaTRvaFBqK0lrcFkrd2RJcTFSNWs1aENnTlVQQ3Uy?=
 =?utf-8?B?WTgyZDhHbFZRbjI5d1dGeE9oVjFlOTdpeVdOOVFhemdPNEZISWtZcjFzdkF1?=
 =?utf-8?B?TFV6MVI3SGVLdXZaanRZbm5WQXEvZzdJRGZ4aHFXQUNHYi9JWkM3dGNpTk1p?=
 =?utf-8?B?Y3RGYUxoWTZPSXJ4SXY2blVTczA2akNWdG9acHJDRXRWY3dXV2lMekRTQzZX?=
 =?utf-8?B?Q3l2NnMyZEtYTGx5Vm95bnlHZ1Rab1RYaXkvT3NSTzQ1TUFzY25ZWForUTlK?=
 =?utf-8?B?L3BOL3NaWmFIeWplSTNETTRBQm9HZllHUmRXcXJxa2NleHhDMkplem9yWDNX?=
 =?utf-8?B?bG1qTUZYUDVUbUJnRkl6V0tzVllNSm5XY2MrNmdWV1lJQ2Q4eXZrZWVJTEJj?=
 =?utf-8?B?eXFRaDlMeWNTS0l0dnRydlByb2R3M1VQQklZS2k2bk81T2VZRW1lQVcrY0FI?=
 =?utf-8?B?Vk9zbndBWFN4SGxHbjdnelB2dU9XZUx5ZWxkcnFsTVNpSVlQZXczT1dnaFly?=
 =?utf-8?B?TUJad016a013MWl0QXdYN0xZcFNSdDVjckdOeEY1RUFYNXlicndZT0RSS21Q?=
 =?utf-8?B?cTltRFNOSFZwTS95a0xuc3cybDVVTG5VbFdFcVg0OHJvVy9NVEk3dU1yTGli?=
 =?utf-8?B?NllLamVKTUk2WkZNZEUxYjdtUkRhV2phTGlVRkV4aHR5WVJaQ3pRMndBNCsv?=
 =?utf-8?B?WFljaHRPci9mdEx3U2ViL2NyckRaSGtQUDNVWllvRTJzWTVCeit0UjdZeU1k?=
 =?utf-8?B?QVdCRUd5a0V0QkxSRCtoZUJtQlRQYW92NEw5VjVkaXp5a3pSbDdRU1AxZkxN?=
 =?utf-8?B?TWdHTmdYZWh1bzh4dVRlUnlHK2pNZmxjQm10RExIbXphN0FOb1QxVmxjZkRN?=
 =?utf-8?B?M2VRT2ZFdm91ZXVmRXpvUms1emRRL1lQcm54V21SWFdvVmFsNGpzWlhGZ2FG?=
 =?utf-8?B?aXorcERYN0FqOXJSSkVzZnBxTStCSUFSYzhWdFZoRk82Y2JSM2xZT1AvQ0Q3?=
 =?utf-8?B?M0loSnEwcUJRak9wVEovVi95UUFNQkFwWVVrUzJEdFZRdmlsTHhPVnB6SU00?=
 =?utf-8?B?ZWN2TXRDcVhVQWdicVk4ditVUWVoUVRQR3hQaEtCanpLcEdZU2VtcVM4a2ts?=
 =?utf-8?B?ZTVkaHdEbjBYa2RPUzJiY291K2NCZitYQWFIL1g2aGEzVGpiMnFUYjBzaWhU?=
 =?utf-8?B?RHQzWmdKYVgzQVpaVllVYjB5eGNvbW9MbjBxblJ6ZUVwR25YeDY4QWwrd2tj?=
 =?utf-8?B?RituV1RUdkJKZ0FNREFvcGVHU0NqVGhsVW5qM0hGOGhCZ3hXcXhDaEpQQ1lu?=
 =?utf-8?B?Q3JLRlJPeDhUUWtNeTQxaW85eUdIT1RxMUpGYk8zdmxEeEc4RkVRV0VsOUlD?=
 =?utf-8?B?aytrOGpzblQxYjF5U1pnb0JMeXh5SmpDL21henFjbFhUYXlFckc1VkYyanY1?=
 =?utf-8?B?b3JrTFl5OUFBMjd4YnJidnU2cmNLeEhMcUdxcGZZMlh1dVlzN0Juclc5VlY2?=
 =?utf-8?B?dmFEZzhxVkFUMlcrQ3p2SHFDZHFTbUR4UVYySkRSZm9GWnJnSmpQTzZMeTVx?=
 =?utf-8?B?bUtsclh0T2ZZVXlvVC93ZU1tcUZiaWVGMHh1WXN1NGFmWEZ3K2huQ2lhKzZp?=
 =?utf-8?B?eGhjTEt6NWhXNUZwTW43cTkvMFZhVm96dFNQSFJTeHA3L1Uzd2g0Nm12NUZG?=
 =?utf-8?B?bXZ0WkFOQ21rT1VSQTBrWUVIdEdpOEtKZk93SWZUWkxZTERyK3pmMUd0Kysz?=
 =?utf-8?B?dTNhbngzUk1kczhHd2tIUEk3L2daMDBTazFhaDJPdmZneitlOWNxU1V5c0Nx?=
 =?utf-8?B?SXR0UjdJSWJ4aTNCVGRBeXoxeDJiRFlDVmw5cHh6UHN4KzM1K3FubGp6NUFO?=
 =?utf-8?B?VW9OQmxWNVM5UlRQRVJCdXJ1WVBGZEJEZzVscEM2Zk81WmQrUjQ4QW0zejJY?=
 =?utf-8?B?aTJkYm9WRm1Wc0kvMDYvWDFvQ1NtWkM4SHo4c0tWVkoyOEVIRThNcVRpNXc2?=
 =?utf-8?Q?/2jhqKdoRE6x9Go9P1dlkbIMX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ca58aa-31b0-44f0-1f84-08dbd08e29e7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:28:41.6858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miu9TZQpHoHWpVsksz11BN+RYYMp0BtCg8cOVsxOFARkzdtz+qNEe82j03FT1NmZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166
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



On 9/21/23 13:20, Venkatesh Yadav Abbarapu wrote:
> In this patch series
> - Add support in Kconfig and convert for armada boards
> - Fetch baudrate from the dtb and update
> 
> Changes in v8:
> - Added test to cover fetch_baud_from_dtb.
> - Changed this check_valid_baudrate() to static and removed
>    from serial.h
> - Fixed the compilation error.
>   
> Changes in v7:
> - Updated the commit message.
> 
> Changes in v6:
> - Changed Kconfig OF_SERIAL_DT_BAUD to OF_SERIAL_BAUD.
> - Added IS_ENABLED() in place of #ifdef CONFIG_OF_SERIAL_AUD
> 
> Changes in v5:
> - Adding DEFAULT_ENV_IS_RW Kconfig in missing files
> - Updating DEFAULT_ENV_IS_RW to CONFIG_DEFAULT_ENV_IS_RW
> 
> Changes in v4:
> - Moved SERIAL_DT_BAUD to another patch
> - Added doc file for fetching serial baudrate from DT.
> - Changed Kconfig SERIAL_DT_BAUD to OF_SERIAL_DT_BAUD
> - Added function docs wherever required.
> - Moved changes from fdtdec api to ofnode
> - Changed serial_get_valid_baudrate to check_valid_baudrate
> - Added function fetch_baud_from_dtb to fetch baud from DT
> - Used dectoul() for parsing baudrate
> 
> Changes in v3:
> - Add SERIAL_DT_BAUD to Kconfig
> - Moved DEFAULT_ENV_IS_RW to Kconfig also updated armada files
> - Moved filler changes from zynqmp.h to generic file env_default.h
> - Removed ENV_RW_FILLER and added padding in the generic file env_default.h.
> - Print baudrate parameter properly when SERIAL_DT is enabled.
> 
> Changes in v2:
> - Changed to #ifdef from #if CONFIG_IS_ENABLED to enable patching in spl.
> - Added SPL_ENV_SUPPORT dependency in SERIAL_DT_BAUD to allow SPL compilation.
> - Moved DEFAULT_ENV_IS_RW to Kconfig also updated armada files
> - Moved ENV_RW_FILLER to generic file env_default.h.
> - Increased the ENV_RW_FILLER padding to support 8000000 baud.
> 
> 
> 
> Algapally Santosh Sagar (2):
>    configs: Add support in Kconfig and convert for armada boards
>    serial: zynqmp: Fetch baudrate from dtb and update
> 
>   arch/sandbox/dts/test.dts                   |  1 +
>   configs/eDPU_defconfig                      |  1 +
>   configs/mvebu_db-88f3720_defconfig          |  1 +
>   configs/mvebu_espressobin-88f3720_defconfig |  1 +
>   configs/uDPU_defconfig                      |  1 +
>   doc/README.serial_dt_baud                   | 41 +++++++++++++++++
>   drivers/core/ofnode.c                       | 18 ++++++++
>   drivers/serial/Kconfig                      | 15 +++++++
>   drivers/serial/serial-uclass.c              | 49 +++++++++++++++++++++
>   include/configs/mvebu_armada-37xx.h         |  1 -
>   include/dm/ofnode.h                         | 14 +++++-
>   include/env_default.h                       |  8 +++-
>   include/env_internal.h                      |  2 +-
>   include/serial.h                            |  7 +++
>   test/dm/serial.c                            |  1 +
>   15 files changed, 155 insertions(+), 6 deletions(-)
>   create mode 100644 doc/README.serial_dt_baud
> 

I didn't see any comment for this series that's why applied.
M

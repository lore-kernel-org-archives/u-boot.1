Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5198ECDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 07:11:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0896C86DD8;
	Fri, 13 Oct 2023 09:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a25x7Uar";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5992186E03; Fri, 13 Oct 2023 09:11:31 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 732B586D20
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 09:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lp/mN3r+UBqvidUtxJIAefV5gUamef5UvZueuLiztoX09vO0/K6rpd33oUrYeOWdPM7WP1jLG5+QgexI78dwFMfHFGWgl3OSKS2I2ZGCu6UalRBmLj5vSklYNlQX/isljJbfUDIatSotkJ0QOmhrooheALqS4vWBrkmp7qu4TZpMUwqajP4Ig9exQOWXGbnc/1YnBq0aPVJW1Ri4Czj5VrlFz+WX3sEhaftFPxtIGj+CJkKaaa/wLKxL3g1OcIK9TqvaohEcxF7ZZCpYeASXeY0TMvAXMTIJg0hi8RpeOMDS85LrrhKrBtylM1z+0hYknTeIfSUJ/AWh+78+qb5gww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYeEtJFyebdDzsmZ0lt+w50DbjSN77rjr+0OJBlp3Zk=;
 b=lCD6lRAHs3Eg9DZSxLJsqLUwelw3yv9x4i/pemQa9ayrAoqZmM7qIJySL57b4DK9htcVUXssxDPZv36qbhq6gJ/aJhaeu/YKfoIRkrd+i4cO8Av9iZnKzSwbGXkKwaVbt6BCiSBVxhsrDLcnZu8v1e4jInm1jejEu4cSbGrwfxwsjrctz8mfZEAaIIlcXXEGxKDk3kcP8k/51XJagGC7NEqEq8ZT8DXbTGBO5fOWSZfLZa6BGgB0p/Lqi3kaoOqjVBm0k2/Ys9X9PJVeiamffyvv/2WbjQ9JmSMz5nxtqYvxm2xQScYdurokpiN+8lxMs1sS1n+OEzkTTHmsPgOlSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=konsulko.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYeEtJFyebdDzsmZ0lt+w50DbjSN77rjr+0OJBlp3Zk=;
 b=a25x7UarvzgBdWMLLYqLfF7e8R1zHNZDzsVVWPDVsUNht77fdDmAvNgmd7kHA0QyzCD5ADzxh6bGCHxyyi+6Nz8fwiSI6XcaCTlXOctQ6AFZRP4q5qmr3HBdlQHbW7NtGshUVGqzHja8N95PO6+qXmEyr6Ca5T950QzwK1+xpZc=
Received: from DS7PR03CA0205.namprd03.prod.outlook.com (2603:10b6:5:3b6::30)
 by SA1PR12MB6893.namprd12.prod.outlook.com (2603:10b6:806:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Fri, 13 Oct
 2023 07:11:19 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::8) by DS7PR03CA0205.outlook.office365.com
 (2603:10b6:5:3b6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46 via Frontend
 Transport; Fri, 13 Oct 2023 07:11:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 07:11:18 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 02:11:17 -0500
Message-ID: <0ca51bb4-0e20-4cb4-bd00-ea3c6b06fb08@amd.com>
Date: Fri, 13 Oct 2023 09:11:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] microblaze: Remove common.h usage
To: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
References: <20231012230359.2005249-1-trini@konsulko.com>
 <20231012230359.2005249-5-trini@konsulko.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231012230359.2005249-5-trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|SA1PR12MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: b3562d95-258a-4161-014c-08dbcbbb98e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1h0Ut/ocr+HORhmyLV9Oxa3rV7xrbPHhCPyFRZEI77t+gJ3iQh5uRWrARl5xz+gVF+yQeJgplmW7pBcf6glwGouJ3l0YsueE/teZLKa2b22YWepgQuLSRWBjn9zi94j77c0yTrvkMOfyg+O8QlrrPozj3l8YwY0ZDh2A1i7RkcdwYUY+rAUhRf2CfrSVyCzq3X1UhNI8LqOdQvOvto240dD7HaJW/ZjRzS5roltQv56iRUFguGVp1Q3js1EEawhjwmDw0ComAF4en5uI0llPeVSZewe7wcdxxUG30GW5kEBDM2BvxNfitRJM6jRivw7hscpm+UibVjsf7eHlPwmmryN4MHOdIKs8DKZsSU9rYlHxU8t5Wt1/3RezQHidB5QSVWm45PNPv77VWu0QrpAxIKROgXLM23h65Muk72tHeKGcs/YJ16n3TDIfn2eCNRpsHWqPkK6nX5oNtsNzEHARTVXlIoqw1hw6bnvEY4YQdyp1FIyFlXYw+HWpEeQLC0nr4S2Z665R8eTMU/6PC+WTRDhHVWnBGeMY+Qrk/o66CFp8v53YNjeQ3vm9rYao811/GA1Q2xM+9PSjwMQmFFjrPDur3/DjJdS18cEKu4U7jkt0vEgUlI4iie/GSaAYlmAHpgN8Sgsu5epBGXkO5EkTrZlGSk2TV0DFfTv9wEHF4yDdMZfkoWUrdwHCCWfXPMX398L3YdeU/Ze7d6WLIx6rpN9j4pRAEaaWlfbTUsqytxXklwTwr9xXFeQ9CBtp+e6hmWWorNQnmdNKZHn+GczGzP3sOAJEnWwRSAQBsErLUTnLXmDbsFuq0g1PLkebUi2l
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(36860700001)(82740400003)(8936002)(356005)(2906002)(8676002)(81166007)(31686004)(44832011)(47076005)(426003)(5660300002)(336012)(478600001)(31696002)(53546011)(86362001)(41300700001)(36756003)(316002)(16526019)(16576012)(83380400001)(26005)(70586007)(70206006)(110136005)(40460700003)(2616005)(40480700001)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 07:11:18.6415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3562d95-258a-4161-014c-08dbcbbb98e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6893
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



On 10/13/23 01:03, Tom Rini wrote:
> We can remove common.h from most cases of the code here, and only a few
> places need an additional header instead.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Michal Simek <michal.simek@amd.com>
> ---
>   arch/microblaze/cpu/cache.c                          | 1 -
>   arch/microblaze/cpu/cpuinfo.c                        | 1 -
>   arch/microblaze/cpu/exception.c                      | 2 +-
>   arch/microblaze/cpu/interrupts.c                     | 3 ++-
>   arch/microblaze/cpu/pvr.c                            | 1 -
>   arch/microblaze/cpu/relocate.c                       | 3 ++-
>   arch/microblaze/cpu/spl.c                            | 1 -
>   arch/microblaze/include/asm/cpuinfo.h                | 2 ++
>   arch/microblaze/lib/bootm.c                          | 1 -
>   board/xilinx/microblaze-generic/microblaze-generic.c | 1 -
>   10 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/microblaze/cpu/cache.c b/arch/microblaze/cpu/cache.c
> index 829e6c7ae605..75ec0a8fd24f 100644
> --- a/arch/microblaze/cpu/cache.c
> +++ b/arch/microblaze/cpu/cache.c
> @@ -5,7 +5,6 @@
>    * Michal SIMEK <monstr@monstr.eu>
>    */
>   
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <asm/asm.h>
>   #include <asm/cache.h>
> diff --git a/arch/microblaze/cpu/cpuinfo.c b/arch/microblaze/cpu/cpuinfo.c
> index 6b15d6ca41c0..2bfdf767f3a5 100644
> --- a/arch/microblaze/cpu/cpuinfo.c
> +++ b/arch/microblaze/cpu/cpuinfo.c
> @@ -2,7 +2,6 @@
>   /*
>    * Copyright (C) 2022, Ovidiu Panait <ovpanait@gmail.com>
>    */
> -#include <common.h>
>   #include <asm/cpuinfo.h>
>   #include <asm/global_data.h>
>   
> diff --git a/arch/microblaze/cpu/exception.c b/arch/microblaze/cpu/exception.c
> index 9414776afa7f..6b329fc7b3a2 100644
> --- a/arch/microblaze/cpu/exception.c
> +++ b/arch/microblaze/cpu/exception.c
> @@ -5,8 +5,8 @@
>    * Michal  SIMEK <monstr@monstr.eu>
>    */
>   
> -#include <common.h>
>   #include <hang.h>
> +#include <stdio.h>
>   #include <asm/asm.h>
>   
>   void _hw_exception_handler (void)
> diff --git a/arch/microblaze/cpu/interrupts.c b/arch/microblaze/cpu/interrupts.c
> index ac53208bda67..244f7fd15eba 100644
> --- a/arch/microblaze/cpu/interrupts.c
> +++ b/arch/microblaze/cpu/interrupts.c
> @@ -7,7 +7,8 @@
>    * Yasushi SHOJI <yashi@atmark-techno.com>
>    */
>   
> -#include <common.h>
> +#include <log.h>
> +#include <vsprintf.h>
>   #include <asm/asm.h>
>   
>   void enable_interrupts(void)
> diff --git a/arch/microblaze/cpu/pvr.c b/arch/microblaze/cpu/pvr.c
> index 23c0f912d435..71aea0b9380c 100644
> --- a/arch/microblaze/cpu/pvr.c
> +++ b/arch/microblaze/cpu/pvr.c
> @@ -2,7 +2,6 @@
>   /*
>    * Copyright (C) 2022, Ovidiu Panait <ovpanait@gmail.com>
>    */
> -#include <common.h>
>   #include <asm/asm.h>
>   #include <asm/pvr.h>
>   
> diff --git a/arch/microblaze/cpu/relocate.c b/arch/microblaze/cpu/relocate.c
> index 7a15fb2ec397..e46fe5bdd5d7 100644
> --- a/arch/microblaze/cpu/relocate.c
> +++ b/arch/microblaze/cpu/relocate.c
> @@ -4,8 +4,9 @@
>    * Michal Simek <michal.simek@amd.com>
>    */
>   
> -#include <common.h>
>   #include <elf.h>
> +#include <log.h>
> +#include <linux/types.h>
>   
>   #define R_MICROBLAZE_NONE	0
>   #define R_MICROBLAZE_32		1
> diff --git a/arch/microblaze/cpu/spl.c b/arch/microblaze/cpu/spl.c
> index c21beafdb810..cb224bd25423 100644
> --- a/arch/microblaze/cpu/spl.c
> +++ b/arch/microblaze/cpu/spl.c
> @@ -5,7 +5,6 @@
>    * Michal Simek <michal.simek@amd.com>
>    */
>   
> -#include <common.h>
>   #include <command.h>
>   #include <image.h>
>   #include <log.h>
> diff --git a/arch/microblaze/include/asm/cpuinfo.h b/arch/microblaze/include/asm/cpuinfo.h
> index 3c58e52217c4..fbd9418a2f8b 100644
> --- a/arch/microblaze/include/asm/cpuinfo.h
> +++ b/arch/microblaze/include/asm/cpuinfo.h
> @@ -6,6 +6,8 @@
>   #ifndef __ASM_MICROBLAZE_CPUINFO_H
>   #define __ASM_MICROBLAZE_CPUINFO_H
>   
> +#include <linux/types.h>
> +
>   /**
>    * struct microblaze_cpuinfo - CPU info for microblaze processor core.
>    *
> diff --git a/arch/microblaze/lib/bootm.c b/arch/microblaze/lib/bootm.c
> index 930384f4015f..f3ec4b741b88 100644
> --- a/arch/microblaze/lib/bootm.c
> +++ b/arch/microblaze/lib/bootm.c
> @@ -7,7 +7,6 @@
>    * Yasushi SHOJI <yashi@atmark-techno.com>
>    */
>   
> -#include <common.h>
>   #include <bootstage.h>
>   #include <command.h>
>   #include <cpu_func.h>
> diff --git a/board/xilinx/microblaze-generic/microblaze-generic.c b/board/xilinx/microblaze-generic/microblaze-generic.c
> index a427ac94a170..2b035d535892 100644
> --- a/board/xilinx/microblaze-generic/microblaze-generic.c
> +++ b/board/xilinx/microblaze-generic/microblaze-generic.c
> @@ -10,7 +10,6 @@
>    * header files
>    */
>   
> -#include <common.h>
>   #include <config.h>
>   #include <env.h>
>   #include <init.h>

I build it and no problem seen that's why.
Acked-by: Michal Simek <michal.simek@amd.com>

If you want me to take it via my tree please let me know but I expect you will 
take it directly.

Thanks,
Michal

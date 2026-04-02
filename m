Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2EFD6AAFF
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 19:15:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 552BA83D8A;
	Thu,  2 Apr 2026 21:15:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jkO7j2q3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E77983F7D; Thu,  2 Apr 2026 21:15:39 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8619F83CF5
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 21:15:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMvmTPpDcKlUEYykAt6yHoxJO/XxCws38hcAHqQGI85qQV7JQPdeMg9aCfEgfjJXRJMQHunechwmIUZ4BEYUo3BWoPX3VUJOu8FqVRFmJrB90iVZXTY/eLYcXy9RVI04UZw8SSTB11jeAGhQyGvJeSgGyw5iSaiWY82zw4t/Tlk0Eb1k8czxS/DMC0YIdL/xOn1dHeLf/PqMTgB2GedCk7Kcu9aGTC0rhDG/5B67v/mR3D+UkK0yc1x2CVMdO9Yv8Hv2LYBXIICe6fR4dDb3Cq5cV0dHAswjtpvXQI5xhZrHQ68EfU89idE2ttxt/V7ul72eq7Yx39lkmuAOOYwoHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MK9L54bKJ74o4nLp8LDoeR8HspHlBWx4vzuBObIizzw=;
 b=EaWNlBNvp4DccSDOzWXBK/Ykmik7FgnXgOfkn7q5muPCj3HgYH2gT6Z5+Ft4zIx2Qgr9KUmMd1LB92fi39/yhL2LR2k2xGBBl7byY6Fy62GV/dFtF/fPsy0o2O+pLfrzNmRXUnvL1NQxrqD8nBwFRq981MRjSfFZXPqHQMH05Jfog/aIdK1MfUHnYMNxBOpTu6JZLNhI81prQNPhPkw+El7qh7IgxjEjUhqCo4RmlAEDiU/86R0mGFyW/iGD7pAl4UJ2IDwbVgiijJ9V7t9WjlQTEz95Pg6Ipi3dypjdl7APkLz3L3yRhCzVGDGTLoYGmXtcVjazrH/X75lG7e806g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MK9L54bKJ74o4nLp8LDoeR8HspHlBWx4vzuBObIizzw=;
 b=jkO7j2q38n6kmDPuOy5MpwECnamUlxjxHQgiNyVdU+Yxqu66A7a+jNfrA6T84xKC3t5xE+oOU4pJgaeUfd0szlq6un2LLoBajzCYoDKdEGlZ2MOjCftbdO3z+B5ezm3A+ms/nY09HO8GkDXb30a50rN7QyNAE7q+jAZY8NqweWE=
Received: from MN0P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::20)
 by CH0PR10MB5082.namprd10.prod.outlook.com (2603:10b6:610:c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 19:15:32 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:208:52e:cafe::6d) by MN0P220CA0010.outlook.office365.com
 (2603:10b6:208:52e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 19:15:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 19:15:29 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 14:15:25 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 14:15:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Apr 2026 14:15:25 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 632JFPTp3033919;
 Thu, 2 Apr 2026 14:15:25 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 2 Apr 2026 14:15:25 -0500
Message-ID: <DHIWR5815YIB.2M5I1ZPQKVT8T@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 6/6] memory: reserve from start_addr_sp to relocaddr
From: Randolph Sapp <rs@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260402001410.3736815-1-rs@ti.com>
 <20260402001410.3736815-7-rs@ti.com>
 <CAC_iWj+VbbyyJS57DBMwbkCK2LoZi2WXu4pS11hRL+jzXXPpwA@mail.gmail.com>
In-Reply-To: <CAC_iWj+VbbyyJS57DBMwbkCK2LoZi2WXu4pS11hRL+jzXXPpwA@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|CH0PR10MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 95bbb6fb-d87c-49d3-5933-08de90ec347d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: ghP6JZN6uKpBpW7XMelC7ywNlz/ppyoW/PJT+TCCtycCJt9fwfH71v5VtZvqYSH3k0pzT3Hm2i7L7oU2PD+RUgc7GFqXb+AXtrnc2cCKgJ86T5imtbWbFIErUXp1fs7EqybJg4fCr7mqguSgdnytUyA/XeEaWbSNxAyMi9KMBy6wXquBfBwQBWpJk71E9uhVzoESxceVzVgrjai+mspvraJ5GnvwRJ70J6PIqQZvDaZ26tlan/1jYmaejS3X3dtLZG5eT1273f2xqgY7XvQomqRE8KuBDeKZL8Nb0IqRWa5Qme8V9RRrSHKl2KmAHa4F82qzE36mfEJCsfNzq24qfW+IY2K0dKVDFazHGpxFxjb7FwxU8+dxhOMAq0A84agJTYZL/fmbmXebT9/JJw5blv0kJZE9qer+QkeunVI0GsroEppgjyUB2/msbT4AW+8RPAwj+lrBIqe5cjs7z9ifsCA1kXJyp7+XReG+DNYuqxm3o5J1aZVvfM42gQlkm+RV33rvyNBIE7pEkBupO03aefCxSPwIlrHS/1JDHA53rAQsGZdPbQVBRkoXz4auXurU4LBT/Fb3gBVXM+HGhAxmH49Xfg9gOCOqyLRO2iqZ4hKkQIHe+Y/6cLQL2TqjNyTg6ojd9enrSOXEBt7WI86xYhu5fEjoIh6VNRRgz4TDvX56/e8M1K4owXyK5wk2XkVEcBCk4yPm4uZUt5D0iqkCrK4eWhRlLZ6c3jH351NrxfjHMuAi//v19KO2QZfHqkFNmP7BJQ2tnE0l3S9N6LcJMw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NVMTnfL352i+ts/lZ+qMnvNjBu5tHyLPAqPuiBqXMZG/rZ/Xbv4Ga3Mh0HOG28gR/DiO8AO87ywG5y8FkpqWPKzAEEDOFHdtFMmDeK2szWtfYpx/9XcnQ1CkiibCdXuoASz3D6A4h3O6znzFQ4KdYFQLzKeGmjUYJxF2rFYIr5h7suYc/IYSrwBqQ3UEOuWNMy5hDznTVS3bM/AiwIDvZ5ZSQG56M4PAFMXqEusa6FkuOM57KGIB6rM+qVnNfBDtI9Kx8gqU2/bInoniTm9ay6Muiylinh3280VRIhf22HwzIEZ/C8EFwK3o+wyGXD56LIUx+USeuIMQmL6W4IEfAGgLrU0K4xakDKB5RIRh2kEIC2JQSbtzcJmBPeWe7LEHuUGme/gs2fikbqbgCBeuNYkw7wq8QJijPRI85yoRCK9KVTGQRmiS2YLCz0km4rrj
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 19:15:29.9305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bbb6fb-d87c-49d3-5933-08de90ec347d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5082
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

On Thu Apr 2, 2026 at 4:21 AM CDT, Ilias Apalodimas wrote:
> On Thu, 2 Apr 2026 at 03:14, <rs@ti.com> wrote:
>>
>> From: Randolph Sapp <rs@ti.com>
>>
>> Reserve the memory from gd->start_addr_sp - CONFIG_STACK_SIZE to
>> gd->relocaddr instead of gd->ram_top. This allows platform specific
>> relocation addresses to work without unnecessarily painting over a large
>> range.
>
> This hangs when trying to boot with UEFI on QEMU aarch64.
> With the qemu_arm64_lwip_defconfig and this command line
>
> qemu-system-aarch64 -m 8192 -smp 2 -nographic -cpu cortex-a57 \
>     -machine virt,secure=3Doff \
>     -bios u-boot.bin \
>     -device virtio-rng-pci \
>     -drive id=3Dos,if=3Dnone,file=3Dmy.iso \
>     -device virtio-blk-device,drive=3Dos \
>     -object memory-backend-ram,id=3Dram0,size=3D4G \
>     -object memory-backend-ram,id=3Dram1,size=3D4G \
>     -numa node,memdev=3Dram0 \
>     -numa node,memdev=3Dram1
>
> It also hangs when trying to initialize the EFI subsystem in general,
> e.g 'efidebug memmap', probably because some EFI code is relocated on
> the region you exlcuded.
>
> Thanks
> /Ilias

Thanks for the QEMU testcase. I see now there are a few cases where
gd->relocaddr can actually be decremented, meaning we won't actually cover =
the
entire u-boot memory region. I've added a new global data struct member
(end_addr_sp, but if anyone has any better name feel free to comment) to tr=
ack
the original value of relocaddr set by setup_dest_addr and it works like a
charm.

I also realized that means I could cut out the PRAM and all of that bank
specific logic in lmb_reserve_uboot_region now, so that's cool.

>>
>> Signed-off-by: Randolph Sapp <rs@ti.com>
>> ---
>>  lib/efi_loader/efi_memory.c | 4 ++--
>>  lib/lmb.c                   | 2 +-
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
>> index f07cc39b157..57691d15758 100644
>> --- a/lib/efi_loader/efi_memory.c
>> +++ b/lib/efi_loader/efi_memory.c
>> @@ -915,8 +915,8 @@ static void add_u_boot_and_runtime(void)
>>         /* Add U-Boot */
>>         uboot_start =3D ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
>>                        uboot_stack_size) & ~EFI_PAGE_MASK;
>> -       uboot_pages =3D ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
>> -                      uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
>> +       uboot_pages =3D ((gd->relocaddr - uboot_start) + EFI_PAGE_MASK) =
>>
>> +                     EFI_PAGE_SHIFT;
>>         efi_update_memory_map(uboot_start, uboot_pages, EFI_BOOT_SERVICE=
S_CODE,
>>                               false, false);
>>  #if defined(__aarch64__)
>> diff --git a/lib/lmb.c b/lib/lmb.c
>> index 542bb11dcf5..0df8157db7f 100644
>> --- a/lib/lmb.c
>> +++ b/lib/lmb.c
>> @@ -540,7 +540,7 @@ static void lmb_reserve_uboot_region(void)
>>         ulong pram =3D 0;
>>
>>         rsv_start =3D gd->start_addr_sp - CONFIG_STACK_SIZE;
>> -       end =3D gd->ram_top;
>> +       end =3D gd->relocaddr;
>>
>>         /*
>>          * Reserve memory from aligned address below the bottom of U-Boo=
t stack
>> --
>> 2.53.0
>>


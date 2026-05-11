Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471A4CD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 14:22:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E657684374;
	Mon, 11 May 2026 16:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="gMMm5duu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A14988394E; Mon, 11 May 2026 15:56:33 +0200 (CEST)
Received: from mxd-2-a07.seznam.cz (mxd-2-a07.seznam.cz
 [IPv6:2a02:598:64:8a00::1000:a07])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6EEF8341A
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Michael.Srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-7994f94c68-rqlzm
 (smtpc-mxd-7994f94c68-rqlzm [2a02:598:64:8a00::1000:a07])
 id 043c23c95f3277a00595ef97; Mon, 11 May 2026 15:56:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1778507763; bh=UQ+7JRstlS1sLifXY7rSXu+tntzaq9RNWAvlQaL4J38=;
 h=Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 Content-Language:From:Content-Type:Content-Transfer-Encoding;
 b=gMMm5duuV8yd5pGZ5LEV7qjKcpyFpoNYpi2XmfZvbs6SF9//tRefTwL1eueTxZrwf
 2IkkTiHRfB0T1NCoFw48DQZQUzscFXUuDpfRWmqnCN5z42XtsjX0i8WCcaMEUuM4Cd
 n8wvGB5psh9jHiPJZftAE8skT3lIGK7EhMeXRGimUg9gW1bYjjfig7MGk7mKA9a1nv
 a2SkA2vGQqsDhd0tAxcOEYhWLoCGRoEJRAj8ixg/18JzQzQqzTLZBCMM+GF80G9TXW
 S6B+0uQwM7r9qC/nDLWjr3PbGMl+AbPBW7g37rNb0sYz4YBYn32TOCZJoBU15uAMQ9
 4nKkTlzhr4mlg==
Received: from [192.168.0.240] (ip-111-27.static.ccinternet.cz
 [147.161.27.111])
 by smtpd-relay-b9cdfc4b8-hlnnr (szn-email-smtpd/2.0.72) with ESMTPA
 id ec417f23-6e3c-4be2-853d-625560de70e4;
 Mon, 11 May 2026 15:56:00 +0200
Message-ID: <6bc4f999-b37f-4961-9bed-17d45e1b77ac@seznam.cz>
Date: Mon, 11 May 2026 15:55:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/11] mach-snapdragon: add board_spl.c and split out
 common code
To: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Heiko Schocher
 <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
References: <20260508-qcom_spl-v7-0-7d0e22aaaa8f@seznam.cz>
 <20260508-qcom_spl-v7-9-7d0e22aaaa8f@seznam.cz>
 <d965e291-51eb-4120-8740-1f14d739bc5c@linaro.org>
Content-Language: en-US
From: Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <d965e291-51eb-4120-8740-1f14d739bc5c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 11 May 2026 16:21:38 +0200
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



On 5/11/26 15:33, Casey Connolly wrote:
> Hi Michael,
>
> On 08/05/2026 23:45, michael.srba@seznam.cz wrote:
>> From: Michael Srba <Michael.Srba@seznam.cz>
>>
>> Code in board.c will now only be compiled into U-Boot proper,
>> and the new board_spl.c will only be built into SPL.
>> Code in board_common.c is common to both phases.
>>
>> Also split out mem_map.c, which is currently common to both
>> phases since it seems to not cause issues in SPL. In the future
>> it should probably behave differenly in SPL, especially if dram
>> initialization is supported.
> Sorry to be a pest with this one, could you rebase this on the SMEM
> series since it also pulls out all the memory mapping stuff.
>
> Since the only thing you left in board_common.c is the board_usb_init(),
> it seems like it's only actually used in db410c at least according to a
> quick grep. Could you just move it over to board/qualcomm/dragonboard410c?
>
> Along with the other changes maybe most of the contents of board_spl.c
> should go into some board/qualcomm/sdm845-spl/board.c file or something?
but there's nothing sdm845-specific about it? SPL won't ever be passed
dt by a previous stage, empty board-init is a sensible default even
if someone wants to override it in specific cases, reset-cpu is a stub and
if qcom wants to implement it there's no good reason to use PSCI for that
so it can be universal (though an ifdef for the non-typical case
of late-in-the-chain SPL would probably still be cleaner than multiple
separate board.c files), and fully implemented spl_boot_device should check
what medium the BROM booted from (or at least if it was EDL, which is
in a hw register, not sure if emmc vs ufs vs sdcard vs spi needs awareness
of data passed from PBL), so again can be perfectly shared.
If DFU is not enabled in config then the USB boot branch can even
be ifdef'd away at compile time.
> I'd expect with qcom also doing SPL stuff there will be some conflicting
> implementations we'll need to handle at build time and this might be the
> easiest way to handle it.
>
>> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> ---
>>   arch/arm/mach-snapdragon/Makefile       |   8 +
>>   arch/arm/mach-snapdragon/board.c        | 358 +-------------------------------
>>   arch/arm/mach-snapdragon/board_common.c |  56 +++++
>>   arch/arm/mach-snapdragon/board_spl.c    |  35 ++++
>>   arch/arm/mach-snapdragon/mem_map.c      | 318 ++++++++++++++++++++++++++++
>>   arch/arm/mach-snapdragon/qcom-priv.h    |   4 +-
>>   6 files changed, 429 insertions(+), 350 deletions(-)
>>
>> diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
>> index 343e825c6fd..4b265b746ce 100644
>> --- a/arch/arm/mach-snapdragon/Makefile
>> +++ b/arch/arm/mach-snapdragon/Makefile
>> @@ -2,6 +2,14 @@
>>   #
>>   # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>>   
>> +obj-y += board_common.o
>> +obj-y += mem_map.o
>> +
>> +ifeq ($(CONFIG_SPL_BUILD),y)
>> +obj-y += board_spl.o
>> +else
>>   obj-y += board.o
>>   obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
>> +endif
>> +
>>   obj-$(CONFIG_OF_LIVE) += of_fixup.o
>> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
>> index 829a0109ac7..a20c9853789 100644
>> --- a/arch/arm/mach-snapdragon/board.c
>> +++ b/arch/arm/mach-snapdragon/board.c
>> @@ -1,6 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0+
>>   /*
>>    * Common initialisation for Qualcomm Snapdragon boards.
>> + * U-Boot proper only, see board_common.c for parts shared with SPL
>>    *
>>    * Copyright (c) 2024 Linaro Ltd.
>>    * Author: Casey Connolly <casey.connolly@linaro.org>
>> @@ -9,155 +10,21 @@
>>   #define LOG_CATEGORY LOGC_BOARD
>>   #define pr_fmt(fmt) "QCOM: " fmt
>>   
>> -#include <asm/armv8/mmu.h>
>> -#include <asm/gpio.h>
>> -#include <asm/io.h>
>> -#include <asm/psci.h>
>> -#include <asm/system.h>
>> -#include <dm/device.h>
>> -#include <dm/pinctrl.h>
>> -#include <dm/uclass-internal.h>
>> -#include <dm/read.h>
>> -#include <power/regulator.h>
>> +#include <dm/ofnode.h>
>>   #include <env.h>
>>   #include <fdt_support.h>
>>   #include <init.h>
>>   #include <linux/arm-smccc.h>
>> -#include <linux/bug.h>
>> +#include <linux/errno.h>
>>   #include <linux/psci.h>
>>   #include <linux/sizes.h>
>>   #include <lmb.h>
>> -#include <malloc.h>
>> -#include <fdt_support.h>
>> -#include <usb.h>
>> -#include <sort.h>
>> -#include <time.h>
>>   
>>   #include "qcom-priv.h"
>>   
>> -DECLARE_GLOBAL_DATA_PTR;
>> -
>>   enum qcom_boot_source qcom_boot_source __section(".data") = 0;
>>   
>> -static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
>> -
>> -struct mm_region *mem_map = rbx_mem_map;
>> -
>> -static struct {
>> -	phys_addr_t start;
>> -	phys_size_t size;
>> -} prevbl_ddr_banks[CONFIG_NR_DRAM_BANKS] __section(".data") = { 0 };
>> -
>> -int dram_init(void)
>> -{
>> -	/*
>> -	 * gd->ram_base / ram_size have been setup already
>> -	 * in qcom_parse_memory().
>> -	 */
>> -	return 0;
>> -}
>> -
>> -static int ddr_bank_cmp(const void *v1, const void *v2)
>> -{
>> -	const struct {
>> -		phys_addr_t start;
>> -		phys_size_t size;
>> -	} *res1 = v1, *res2 = v2;
>> -
>> -	if (!res1->size)
>> -		return 1;
>> -	if (!res2->size)
>> -		return -1;
>> -
>> -	return (res1->start >> 24) - (res2->start >> 24);
>> -}
>> -
>> -/* This has to be done post-relocation since gd->bd isn't preserved */
>> -static void qcom_configure_bi_dram(void)
>> -{
>> -	int i;
>> -
>> -	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
>> -		gd->bd->bi_dram[i].start = prevbl_ddr_banks[i].start;
>> -		gd->bd->bi_dram[i].size = prevbl_ddr_banks[i].size;
>> -	}
>> -}
>> -
>> -int dram_init_banksize(void)
>> -{
>> -	qcom_configure_bi_dram();
>> -
>> -	return 0;
>> -}
>> -
>> -/**
>> - * The generic memory parsing code in U-Boot lacks a few things that we
>> - * need on Qualcomm:
>> - *
>> - * 1. It sets gd->ram_size and gd->ram_base to represent a single memory block
>> - * 2. setup_dest_addr() later relocates U-Boot to ram_base + ram_size, the end
>> - *    of that first memory block.
>> - *
>> - * This results in all memory beyond U-Boot being unusable in Linux when booting
>> - * with EFI.
>> - *
>> - * Since the ranges in the memory node may be out of order, the only way for us
>> - * to correctly determine the relocation address for U-Boot is to parse all
>> - * memory regions and find the highest valid address.
>> - *
>> - * We can't use fdtdec_setup_memory_banksize() since it stores the result in
>> - * gd->bd, which is not yet allocated.
>> - *
>> - * @fdt: FDT blob to parse /memory node from
>> - *
>> - * Return: 0 on success or -ENODATA if /memory node is missing or incomplete
>> - */
>> -static int qcom_parse_memory(const void *fdt)
>> -{
>> -	int offset;
>> -	const fdt64_t *memory;
>> -	int memsize;
>> -	phys_addr_t ram_end = 0;
>> -	int i, j, banks;
>> -
>> -	offset = fdt_path_offset(fdt, "/memory");
>> -	if (offset < 0)
>> -		return -ENODATA;
>> -
>> -	memory = fdt_getprop(fdt, offset, "reg", &memsize);
>> -	if (!memory)
>> -		return -ENODATA;
>> -
>> -	banks = min(memsize / (2 * sizeof(u64)), (ulong)CONFIG_NR_DRAM_BANKS);
>> -
>> -	if (memsize / sizeof(u64) > CONFIG_NR_DRAM_BANKS * 2)
>> -		log_err("Provided more than the max of %d memory banks\n", CONFIG_NR_DRAM_BANKS);
>> -
>> -	if (banks > CONFIG_NR_DRAM_BANKS)
>> -		log_err("Provided more memory banks than we can handle\n");
>> -
>> -	for (i = 0, j = 0; i < banks * 2; i += 2, j++) {
>> -		prevbl_ddr_banks[j].start = get_unaligned_be64(&memory[i]);
>> -		prevbl_ddr_banks[j].size = get_unaligned_be64(&memory[i + 1]);
>> -		if (!prevbl_ddr_banks[j].size) {
>> -			j--;
>> -			continue;
>> -		}
>> -		ram_end = max(ram_end, prevbl_ddr_banks[j].start + prevbl_ddr_banks[j].size);
>> -	}
>> -
>> -	if (!banks || !prevbl_ddr_banks[0].size)
>> -		return -ENODATA;
>> -
>> -	/* Sort our RAM banks -_- */
>> -	qsort(prevbl_ddr_banks, banks, sizeof(prevbl_ddr_banks[0]), ddr_bank_cmp);
>> -
>> -	gd->ram_base = prevbl_ddr_banks[0].start;
>> -	gd->ram_size = ram_end - gd->ram_base;
>> -
>> -	return 0;
>> -}
>> -
>> +#if CONFIG_IS_ENABLED(SYSRESET_PSCI)
>>   static void show_psci_version(void)
>>   {
>>   	struct arm_smccc_res res;
>> @@ -199,6 +66,7 @@ static void qcom_psci_fixup(void *fdt)
>>   	if (ret)
>>   		log_err("Failed to delete /psci node: %d\n", ret);
>>   }
>> +#endif
>>   
>>   /* We support booting U-Boot with an internal DT when running as a first-stage bootloader
>>    * or for supporting quirky devices where it's easier to leave the downstream DT in place
>> @@ -258,49 +126,13 @@ int board_fdt_blob_setup(void **fdtp)
>>   		ret = 0;
>>   	}
>>   
>> +#if CONFIG_IS_ENABLED(SYSRESET_PSCI)
>>   	qcom_psci_fixup(*fdtp);
>> +#endif
>>   
>>   	return ret;
>>   }
>>   
>> -/*
>> - * Some Qualcomm boards require GPIO configuration when switching USB modes.
>> - * Support setting this configuration via pinctrl state.
>> - */
>> -int board_usb_init(int index, enum usb_init_type init)
>> -{
>> -	struct udevice *usb;
>> -	int ret = 0;
>> -
>> -	/* USB device */
>> -	ret = uclass_find_device_by_seq(UCLASS_USB, index, &usb);
>> -	if (ret) {
>> -		printf("Cannot find USB device\n");
>> -		return ret;
>> -	}
>> -
>> -	ret = dev_read_stringlist_search(usb, "pinctrl-names",
>> -					 "device");
>> -	/* No "device" pinctrl state, so just bail */
>> -	if (ret < 0)
>> -		return 0;
>> -
>> -	/* Select "default" or "device" pinctrl */
>> -	switch (init) {
>> -	case USB_INIT_HOST:
>> -		pinctrl_select_state(usb, "default");
>> -		break;
>> -	case USB_INIT_DEVICE:
>> -		pinctrl_select_state(usb, "device");
>> -		break;
>> -	default:
>> -		debug("Unknown usb_init_type %d\n", init);
>> -		break;
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>>   /*
>>    * Some boards still need board specific init code, they can implement that by
>>    * overriding this function.
>> @@ -313,7 +145,9 @@ void __weak qcom_board_init(void)
>>   
>>   int board_init(void)
>>   {
>> +#if CONFIG_IS_ENABLED(SYSRESET_PSCI) && !defined(CONFIG_SPL_BUILD)
>>   	show_psci_version();
>> +#endif
>>   	qcom_board_init();
>>   	return 0;
>>   }
>> @@ -580,177 +414,3 @@ int board_late_init(void)
>>   
>>   	return 0;
>>   }
>> -
>> -static void build_mem_map(void)
>> -{
>> -	int i, j;
>> -
>> -	/*
>> -	 * Ensure the peripheral block is sized to correctly cover the address range
>> -	 * up to the first memory bank.
>> -	 * Don't map the first page to ensure that we actually trigger an abort on a
>> -	 * null pointer access rather than just hanging.
>> -	 * FIXME: we should probably split this into more precise regions
>> -	 */
>> -	mem_map[0].phys = 0x1000;
>> -	mem_map[0].virt = mem_map[0].phys;
>> -	mem_map[0].size = gd->bd->bi_dram[0].start - mem_map[0].phys;
>> -	mem_map[0].attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>> -			 PTE_BLOCK_NON_SHARE |
>> -			 PTE_BLOCK_PXN | PTE_BLOCK_UXN;
>> -
>> -	for (i = 1, j = 0; i < ARRAY_SIZE(rbx_mem_map) - 1 && gd->bd->bi_dram[j].size; i++, j++) {
>> -		mem_map[i].phys = gd->bd->bi_dram[j].start;
>> -		mem_map[i].virt = mem_map[i].phys;
>> -		mem_map[i].size = gd->bd->bi_dram[j].size;
>> -		mem_map[i].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | \
>> -				   PTE_BLOCK_INNER_SHARE;
>> -	}
>> -
>> -	mem_map[i].phys = UINT64_MAX;
>> -	mem_map[i].size = 0;
>> -
>> -#ifdef DEBUG
>> -	debug("Configured memory map:\n");
>> -	for (i = 0; mem_map[i].size; i++)
>> -		debug("  0x%016llx - 0x%016llx: entry %d\n",
>> -		      mem_map[i].phys, mem_map[i].phys + mem_map[i].size, i);
>> -#endif
>> -}
>> -
>> -u64 get_page_table_size(void)
>> -{
>> -	return SZ_1M;
>> -}
>> -
>> -static int fdt_cmp_res(const void *v1, const void *v2)
>> -{
>> -	const struct fdt_resource *res1 = v1, *res2 = v2;
>> -
>> -	return res1->start - res2->start;
>> -}
>> -
>> -#define N_RESERVED_REGIONS 32
>> -
>> -/* Mark all no-map regions as PTE_TYPE_FAULT to prevent speculative access.
>> - * On some platforms this is enough to trigger a security violation and trap
>> - * to EL3.
>> - */
>> -static void carve_out_reserved_memory(void)
>> -{
>> -	static struct fdt_resource res[N_RESERVED_REGIONS] = { 0 };
>> -	int parent, rmem, count, i = 0;
>> -	phys_addr_t start;
>> -	size_t size;
>> -
>> -	/* Some reserved nodes must be carved out, as the cache-prefetcher may otherwise
>> -	 * attempt to access them, causing a security exception.
>> -	 */
>> -	parent = fdt_path_offset(gd->fdt_blob, "/reserved-memory");
>> -	if (parent <= 0) {
>> -		log_err("No reserved memory regions found\n");
>> -		return;
>> -	}
>> -
>> -	/* Collect the reserved memory regions */
>> -	fdt_for_each_subnode(rmem, gd->fdt_blob, parent) {
>> -		const fdt32_t *ptr;
>> -		int len;
>> -		if (!fdt_getprop(gd->fdt_blob, rmem, "no-map", NULL))
>> -			continue;
>> -
>> -		if (i == N_RESERVED_REGIONS) {
>> -			log_err("Too many reserved regions!\n");
>> -			break;
>> -		}
>> -
>> -		/* Read the address and size out from the reg property. Doing this "properly" with
>> -		 * fdt_get_resource() takes ~70ms on SDM845, but open-coding the happy path here
>> -		 * takes <1ms... Oh the woes of no dcache.
>> -		 */
>> -		ptr = fdt_getprop(gd->fdt_blob, rmem, "reg", &len);
>> -		if (ptr) {
>> -			/* Qualcomm devices use #address/size-cells = <2> but all reserved regions are within
>> -			 * the 32-bit address space. So we can cheat here for speed.
>> -			 */
>> -			res[i].start = fdt32_to_cpu(ptr[1]);
>> -			res[i].end = res[i].start + fdt32_to_cpu(ptr[3]);
>> -			i++;
>> -		}
>> -	}
>> -
>> -	/* Sort the reserved memory regions by address */
>> -	count = i;
>> -	qsort(res, count, sizeof(struct fdt_resource), fdt_cmp_res);
>> -
>> -	/* Now set the right attributes for them. Often a lot of the regions are tightly packed together
>> -	 * so we can optimise the number of calls to mmu_change_region_attr() by combining adjacent
>> -	 * regions.
>> -	 */
>> -	start = ALIGN_DOWN(res[0].start, SZ_2M);
>> -	size = ALIGN(res[0].end - start, SZ_2M);
>> -	for (i = 1; i <= count; i++) {
>> -		/* We ideally want to 2M align everything for more efficient pagetables, but we must avoid
>> -		 * overwriting reserved memory regions which shouldn't be mapped as FAULT (like those with
>> -		 * compatible properties).
>> -		 * If within 2M of the previous region, bump the size to include this region. Otherwise
>> -		 * start a new region.
>> -		 */
>> -		if (i == count || start + size < res[i].start - SZ_2M) {
>> -			debug("  0x%016llx - 0x%016llx: reserved\n",
>> -			      start, start + size);
>> -			mmu_change_region_attr(start, size, PTE_TYPE_FAULT);
>> -			/* If this is the final region then quit here before we index
>> -			 * out of bounds...
>> -			 */
>> -			if (i == count)
>> -				break;
>> -			start = ALIGN_DOWN(res[i].start, SZ_2M);
>> -			size = ALIGN(res[i].end - start, SZ_2M);
>> -		} else {
>> -			/* Bump size if this region is immediately after the previous one */
>> -			size = ALIGN(res[i].end - start, SZ_2M);
>> -		}
>> -	}
>> -}
>> -
>> -/* This function open-codes setup_all_pgtables() so that we can
>> - * insert additional mappings *before* turning on the MMU.
>> - */
>> -void enable_caches(void)
>> -{
>> -	u64 tlb_addr = gd->arch.tlb_addr;
>> -	u64 tlb_size = gd->arch.tlb_size;
>> -	u64 pt_size;
>> -	ulong carveout_start;
>> -
>> -	gd->arch.tlb_fillptr = tlb_addr;
>> -
>> -	build_mem_map();
>> -
>> -	icache_enable();
>> -
>> -	/* Create normal system page tables */
>> -	setup_pgtables();
>> -
>> -	pt_size = (uintptr_t)gd->arch.tlb_fillptr -
>> -		  (uintptr_t)gd->arch.tlb_addr;
>> -	debug("Primary pagetable size: %lluKiB\n", pt_size / 1024);
>> -
>> -	/* Create emergency page tables */
>> -	gd->arch.tlb_size -= pt_size;
>> -	gd->arch.tlb_addr = gd->arch.tlb_fillptr;
>> -	setup_pgtables();
>> -	gd->arch.tlb_emerg = gd->arch.tlb_addr;
>> -	gd->arch.tlb_addr = tlb_addr;
>> -	gd->arch.tlb_size = tlb_size;
>> -
>> -	/* We do the carveouts only for QCS404, for now. */
>> -	if (fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcs404") == 0) {
>> -		carveout_start = get_timer(0);
>> -		/* Takes ~20-50ms on SDM845 */
>> -		carve_out_reserved_memory();
>> -		debug("carveout time: %lums\n", get_timer(carveout_start));
>> -	}
>> -	dcache_enable();
>> -}
>> diff --git a/arch/arm/mach-snapdragon/board_common.c b/arch/arm/mach-snapdragon/board_common.c
>> new file mode 100644
>> index 00000000000..f6daeb6edf4
>> --- /dev/null
>> +++ b/arch/arm/mach-snapdragon/board_common.c
>> @@ -0,0 +1,56 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Common initialisation for Qualcomm Snapdragon boards.
>> + *
>> + * Copyright (c) 2024 Linaro Ltd.
>> + * Author: Casey Connolly <casey.connolly@linaro.org>
>> + */
>> +
>> +#define LOG_CATEGORY LOGC_BOARD
>> +#define pr_fmt(fmt) "QCOM: " fmt
>> +
>> +#include <dm/device.h>
>> +#include <dm/pinctrl.h>
>> +#include <dm/uclass-internal.h>
>> +#include <dm/read.h>
>> +#include <usb.h>
>> +
>> +#include "qcom-priv.h"
>> +
>> +/*
>> + * Some Qualcomm boards require GPIO configuration when switching USB modes.
>> + * Support setting this configuration via pinctrl state.
>> + */
>> +int board_usb_init(int index, enum usb_init_type init)
>> +{
>> +	struct udevice *usb;
>> +	int ret = 0;
>> +
>> +	/* USB device */
>> +	ret = uclass_find_device_by_seq(UCLASS_USB, index, &usb);
>> +	if (ret) {
>> +		printf("Cannot find USB device\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = dev_read_stringlist_search(usb, "pinctrl-names",
>> +					 "device");
>> +	/* No "device" pinctrl state, so just bail */
>> +	if (ret < 0)
>> +		return 0;
>> +
>> +	/* Select "default" or "device" pinctrl */
>> +	switch (init) {
>> +	case USB_INIT_HOST:
>> +		pinctrl_select_state(usb, "default");
>> +		break;
>> +	case USB_INIT_DEVICE:
>> +		pinctrl_select_state(usb, "device");
>> +		break;
>> +	default:
>> +		debug("Unknown usb_init_type %d\n", init);
>> +		break;
>> +	}
>> +
>> +	return 0;
>> +}
>> diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
>> new file mode 100644
>> index 00000000000..19260975063
>> --- /dev/null
>> +++ b/arch/arm/mach-snapdragon/board_spl.c
>> @@ -0,0 +1,35 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Common SPL code for Qualcomm Snapdragon boards.
>> + *
>> + * Copyright (c) 2026 Michael Srba <Michael.Srba@seznam.cz>
>> + */
>> +
>> +#include <hang.h>
>> +#include <spl.h>
>> +
>> +/* in SPL, we always use internal DT */
>> +int board_fdt_blob_setup(void **fdtp)
>> +{
>> +	return -EEXIST;
>> +}
>> +
>> +int board_init(void)
>> +{
>> +	return 0;
>> +}
>> +
>> +__weak void reset_cpu(void)
>> +{
>> +	/* This should currently not get called in non-error paths, so just hang */
>> +	printf("reset_cpu called, going to hang()\n");
>> +	hang();
>> +}
>> +
>> +u32 spl_boot_device(void)
>> +{
>> +	/* TODO: check boot reason to support UFS and sdcard */
>> +	u32 boot_device = BOOT_DEVICE_DFU;
>> +
>> +	return boot_device;
>> +}
>> diff --git a/arch/arm/mach-snapdragon/mem_map.c b/arch/arm/mach-snapdragon/mem_map.c
>> new file mode 100644
>> index 00000000000..70e3c1d1fcc
>> --- /dev/null
>> +++ b/arch/arm/mach-snapdragon/mem_map.c
>> @@ -0,0 +1,318 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Common initialisation for Qualcomm Snapdragon boards.
>> + *
>> + * Copyright (c) 2024 Linaro Ltd.
>> + * Author: Casey Connolly <casey.connolly@linaro.org>
>> + */
>> +
>> +#define LOG_CATEGORY LOGC_BOARD
>> +#define pr_fmt(fmt) "QCOM: " fmt
>> +
>> +#include <asm/armv8/mmu.h>
>> +#include <asm/global_data.h>
>> +#include <asm/system.h>
>> +#include <asm-generic/unaligned.h>
>> +#include <cpu_func.h>
>> +#include <fdt_support.h>
>> +#include <linux/errno.h>
>> +#include <linux/sizes.h>
>> +#include <sort.h>
>> +#include <time.h>
>> +
>> +#include "qcom-priv.h"
>> +
>> +DECLARE_GLOBAL_DATA_PTR;
>> +
>> +static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
>> +
>> +struct mm_region *mem_map = rbx_mem_map;
>> +
>> +static struct {
>> +	phys_addr_t start;
>> +	phys_size_t size;
>> +} prevbl_ddr_banks[CONFIG_NR_DRAM_BANKS] __section(".data") = { 0 };
>> +
>> +int dram_init(void)
>> +{
>> +	/*
>> +	 * gd->ram_base / ram_size have been setup already
>> +	 * in qcom_parse_memory().
>> +	 */
>> +	return 0;
>> +}
>> +
>> +static int ddr_bank_cmp(const void *v1, const void *v2)
>> +{
>> +	const struct {
>> +		phys_addr_t start;
>> +		phys_size_t size;
>> +	} *res1 = v1, *res2 = v2;
>> +
>> +	if (!res1->size)
>> +		return 1;
>> +	if (!res2->size)
>> +		return -1;
>> +
>> +	return (res1->start >> 24) - (res2->start >> 24);
>> +}
>> +
>> +/* This has to be done post-relocation since gd->bd isn't preserved */
>> +static void qcom_configure_bi_dram(void)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
>> +		gd->bd->bi_dram[i].start = prevbl_ddr_banks[i].start;
>> +		gd->bd->bi_dram[i].size = prevbl_ddr_banks[i].size;
>> +	}
>> +}
>> +
>> +int dram_init_banksize(void)
>> +{
>> +	qcom_configure_bi_dram();
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * The generic memory parsing code in U-Boot lacks a few things that we
>> + * need on Qualcomm:
>> + *
>> + * 1. It sets gd->ram_size and gd->ram_base to represent a single memory block
>> + * 2. setup_dest_addr() later relocates U-Boot to ram_base + ram_size, the end
>> + *    of that first memory block.
>> + *
>> + * This results in all memory beyond U-Boot being unusable in Linux when booting
>> + * with EFI.
>> + *
>> + * Since the ranges in the memory node may be out of order, the only way for us
>> + * to correctly determine the relocation address for U-Boot is to parse all
>> + * memory regions and find the highest valid address.
>> + *
>> + * We can't use fdtdec_setup_memory_banksize() since it stores the result in
>> + * gd->bd, which is not yet allocated.
>> + *
>> + * @fdt: FDT blob to parse /memory node from
>> + *
>> + * Return: 0 on success or -ENODATA if /memory node is missing or incomplete
>> + */
>> +int qcom_parse_memory(const void *fdt)
>> +{
>> +	int offset;
>> +	const fdt64_t *memory;
>> +	int memsize;
>> +	phys_addr_t ram_end = 0;
>> +	int i, j, banks;
>> +
>> +	offset = fdt_path_offset(fdt, "/memory");
>> +	if (offset < 0)
>> +		return -ENODATA;
>> +
>> +	memory = fdt_getprop(fdt, offset, "reg", &memsize);
>> +	if (!memory)
>> +		return -ENODATA;
>> +
>> +	banks = min(memsize / (2 * sizeof(u64)), (ulong)CONFIG_NR_DRAM_BANKS);
>> +
>> +	if (memsize / sizeof(u64) > CONFIG_NR_DRAM_BANKS * 2)
>> +		log_err("Provided more than the max of %d memory banks\n", CONFIG_NR_DRAM_BANKS);
>> +
>> +	if (banks > CONFIG_NR_DRAM_BANKS)
>> +		log_err("Provided more memory banks than we can handle\n");
>> +
>> +	for (i = 0, j = 0; i < banks * 2; i += 2, j++) {
>> +		prevbl_ddr_banks[j].start = get_unaligned_be64(&memory[i]);
>> +		prevbl_ddr_banks[j].size = get_unaligned_be64(&memory[i + 1]);
>> +		if (!prevbl_ddr_banks[j].size) {
>> +			j--;
>> +			continue;
>> +		}
>> +		ram_end = max(ram_end, prevbl_ddr_banks[j].start + prevbl_ddr_banks[j].size);
>> +	}
>> +
>> +	if (!banks || !prevbl_ddr_banks[0].size)
>> +		return -ENODATA;
>> +
>> +	/* Sort our RAM banks -_- */
>> +	qsort(prevbl_ddr_banks, banks, sizeof(prevbl_ddr_banks[0]), ddr_bank_cmp);
>> +
>> +	gd->ram_base = prevbl_ddr_banks[0].start;
>> +	gd->ram_size = ram_end - gd->ram_base;
>> +
>> +	return 0;
>> +}
>> +
>> +static void build_mem_map(void)
>> +{
>> +	int i, j;
>> +
>> +	/*
>> +	 * Ensure the peripheral block is sized to correctly cover the address range
>> +	 * up to the first memory bank.
>> +	 * Don't map the first page to ensure that we actually trigger an abort on a
>> +	 * null pointer access rather than just hanging.
>> +	 * FIXME: we should probably split this into more precise regions
>> +	 */
>> +	mem_map[0].phys = 0x1000;
>> +	mem_map[0].virt = mem_map[0].phys;
>> +	mem_map[0].size = gd->bd->bi_dram[0].start - mem_map[0].phys;
>> +	mem_map[0].attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>> +			 PTE_BLOCK_NON_SHARE |
>> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN;
>> +
>> +	for (i = 1, j = 0; i < ARRAY_SIZE(rbx_mem_map) - 1 && gd->bd->bi_dram[j].size; i++, j++) {
>> +		mem_map[i].phys = gd->bd->bi_dram[j].start;
>> +		mem_map[i].virt = mem_map[i].phys;
>> +		mem_map[i].size = gd->bd->bi_dram[j].size;
>> +		mem_map[i].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | \
>> +				   PTE_BLOCK_INNER_SHARE;
>> +	}
>> +
>> +	mem_map[i].phys = UINT64_MAX;
>> +	mem_map[i].size = 0;
>> +
>> +#ifdef DEBUG
>> +	debug("Configured memory map:\n");
>> +	for (i = 0; mem_map[i].size; i++)
>> +		debug("  0x%016llx - 0x%016llx: entry %d\n",
>> +		      mem_map[i].phys, mem_map[i].phys + mem_map[i].size, i);
>> +#endif
>> +}
>> +
>> +u64 get_page_table_size(void)
>> +{
>> +	return SZ_1M;
>> +}
>> +
>> +static int fdt_cmp_res(const void *v1, const void *v2)
>> +{
>> +	const struct fdt_resource *res1 = v1, *res2 = v2;
>> +
>> +	return res1->start - res2->start;
>> +}
>> +
>> +#define N_RESERVED_REGIONS 32
>> +
>> +/* Mark all no-map regions as PTE_TYPE_FAULT to prevent speculative access.
>> + * On some platforms this is enough to trigger a security violation and trap
>> + * to EL3.
>> + */
>> +static void carve_out_reserved_memory(void)
>> +{
>> +	static struct fdt_resource res[N_RESERVED_REGIONS] = { 0 };
>> +	int parent, rmem, count, i = 0;
>> +	phys_addr_t start;
>> +	size_t size;
>> +
>> +	/* Some reserved nodes must be carved out, as the cache-prefetcher may otherwise
>> +	 * attempt to access them, causing a security exception.
>> +	 */
>> +	parent = fdt_path_offset(gd->fdt_blob, "/reserved-memory");
>> +	if (parent <= 0) {
>> +		log_err("No reserved memory regions found\n");
>> +		return;
>> +	}
>> +
>> +	/* Collect the reserved memory regions */
>> +	fdt_for_each_subnode(rmem, gd->fdt_blob, parent) {
>> +		const fdt32_t *ptr;
>> +		int len;
>> +		if (!fdt_getprop(gd->fdt_blob, rmem, "no-map", NULL))
>> +			continue;
>> +
>> +		if (i == N_RESERVED_REGIONS) {
>> +			log_err("Too many reserved regions!\n");
>> +			break;
>> +		}
>> +
>> +		/* Read the address and size out from the reg property. Doing this "properly" with
>> +		 * fdt_get_resource() takes ~70ms on SDM845, but open-coding the happy path here
>> +		 * takes <1ms... Oh the woes of no dcache.
>> +		 */
>> +		ptr = fdt_getprop(gd->fdt_blob, rmem, "reg", &len);
>> +		if (ptr) {
>> +			/* Qualcomm devices use #address/size-cells = <2> but all reserved regions are within
>> +			 * the 32-bit address space. So we can cheat here for speed.
>> +			 */
>> +			res[i].start = fdt32_to_cpu(ptr[1]);
>> +			res[i].end = res[i].start + fdt32_to_cpu(ptr[3]);
>> +			i++;
>> +		}
>> +	}
>> +
>> +	/* Sort the reserved memory regions by address */
>> +	count = i;
>> +	qsort(res, count, sizeof(struct fdt_resource), fdt_cmp_res);
>> +
>> +	/* Now set the right attributes for them. Often a lot of the regions are tightly packed together
>> +	 * so we can optimise the number of calls to mmu_change_region_attr() by combining adjacent
>> +	 * regions.
>> +	 */
>> +	start = ALIGN_DOWN(res[0].start, SZ_2M);
>> +	size = ALIGN(res[0].end - start, SZ_2M);
>> +	for (i = 1; i <= count; i++) {
>> +		/* We ideally want to 2M align everything for more efficient pagetables, but we must avoid
>> +		 * overwriting reserved memory regions which shouldn't be mapped as FAULT (like those with
>> +		 * compatible properties).
>> +		 * If within 2M of the previous region, bump the size to include this region. Otherwise
>> +		 * start a new region.
>> +		 */
>> +		if (i == count || start + size < res[i].start - SZ_2M) {
>> +			debug("  0x%016llx - 0x%016llx: reserved\n",
>> +			      start, start + size);
>> +			mmu_change_region_attr(start, size, PTE_TYPE_FAULT);
>> +			/* If this is the final region then quit here before we index
>> +			 * out of bounds...
>> +			 */
>> +			if (i == count)
>> +				break;
>> +			start = ALIGN_DOWN(res[i].start, SZ_2M);
>> +			size = ALIGN(res[i].end - start, SZ_2M);
>> +		} else {
>> +			/* Bump size if this region is immediately after the previous one */
>> +			size = ALIGN(res[i].end - start, SZ_2M);
>> +		}
>> +	}
>> +}
>> +
>> +/* This function open-codes setup_all_pgtables() so that we can
>> + * insert additional mappings *before* turning on the MMU.
>> + */
>> +void enable_caches(void)
>> +{
>> +	u64 tlb_addr = gd->arch.tlb_addr;
>> +	u64 tlb_size = gd->arch.tlb_size;
>> +	u64 pt_size;
>> +	ulong carveout_start;
>> +
>> +	gd->arch.tlb_fillptr = tlb_addr;
>> +
>> +	build_mem_map();
>> +
>> +	icache_enable();
>> +
>> +	/* Create normal system page tables */
>> +	setup_pgtables();
>> +
>> +	pt_size = (uintptr_t)gd->arch.tlb_fillptr -
>> +		  (uintptr_t)gd->arch.tlb_addr;
>> +	debug("Primary pagetable size: %lluKiB\n", pt_size / 1024);
>> +
>> +	/* Create emergency page tables */
>> +	gd->arch.tlb_size -= pt_size;
>> +	gd->arch.tlb_addr = gd->arch.tlb_fillptr;
>> +	setup_pgtables();
>> +	gd->arch.tlb_emerg = gd->arch.tlb_addr;
>> +	gd->arch.tlb_addr = tlb_addr;
>> +	gd->arch.tlb_size = tlb_size;
>> +
>> +	/* We do the carveouts only for QCS404, for now. */
>> +	if (fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcs404") == 0) {
>> +		carveout_start = get_timer(0);
>> +		/* Takes ~20-50ms on SDM845 */
>> +		carve_out_reserved_memory();
>> +		debug("carveout time: %lums\n", get_timer(carveout_start));
>> +	}
>> +	dcache_enable();
>> +}
>> diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
>> index b8bf574e8bb..b372465d125 100644
>> --- a/arch/arm/mach-snapdragon/qcom-priv.h
>> +++ b/arch/arm/mach-snapdragon/qcom-priv.h
>> @@ -20,7 +20,9 @@ extern enum qcom_boot_source qcom_boot_source;
>>   #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
>>   void qcom_configure_capsule_updates(void);
>>   #else
>> -void qcom_configure_capsule_updates(void) {}
>> +static inline void qcom_configure_capsule_updates(void) {}
>>   #endif /* EFI_HAVE_CAPSULE_SUPPORT */
>>   
>> +int qcom_parse_memory(const void *fdt);
>> +
>>   #endif /* __QCOM_PRIV_H__ */
>>


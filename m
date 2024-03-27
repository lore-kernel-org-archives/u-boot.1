Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C55CCD11DD
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 14:21:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88C10880FB;
	Wed, 27 Mar 2024 15:21:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="so6HfP1I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C638A880EB; Wed, 27 Mar 2024 15:21:53 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EB118809B
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 15:21:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1711549311;
 bh=ixhCgXjoa1LF9cMgup8CLQzwW+Srj9MRM7faXTyYc/U=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=so6HfP1I6ueTUI16TiiPn1Y05S03MoJywF+fj+j8jwUNOvahjOHO+abzk+26speEc
 38PVoriuRIKVbd2MoONxoWeYHR/2WCKfyjyPonJUnXlzvGEPZUYQq0KPl/jZTe/g4j
 7rkKRyqK7voyqL3Cwp55TqJBvB+Z0hsO6BUmn8lAQ9qOYvza9Hj2rpG8kAaMPyzcyD
 QYp5oqCA6pLhALiOJANPDiWmE+5qC2NZ3J1ujDXx4Tgz24AZLCB8vlL4NVAPnR3igf
 SMwmU6slRfkX9QcYlO8yHPk5XxOvGetwNaX5lpEDJruFvcp6wjt+sOh119IC2gagHR
 KYePKpcPeUY7A==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2A76F378210B;
 Wed, 27 Mar 2024 14:21:50 +0000 (UTC)
Message-ID: <9541747b-b05c-4bb2-bf73-d720659905d2@collabora.com>
Date: Wed, 27 Mar 2024 16:21:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: rk3588: Add support for ATAG parsing
To: Chris Morgan <macromorgan@hotmail.com>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 xypron.glpk@gmx.de, cym@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, trini@konsulko.com, jonas@kwiboo.se
References: <20240326204944.1572667-1-macroalpha82@gmail.com>
 <20240326204944.1572667-2-macroalpha82@gmail.com>
 <fe9eef97-5814-4d25-8357-60873d565aff@rock-chips.com>
 <DM4PR05MB9229EA8B503F50C94DDA5212A5342@DM4PR05MB9229.namprd05.prod.outlook.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <DM4PR05MB9229EA8B503F50C94DDA5212A5342@DM4PR05MB9229.namprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 3/27/24 15:32, Chris Morgan wrote:
> On Wed, Mar 27, 2024 at 06:32:06PM +0800, Kever Yang wrote:
>> Hi Chris,
>>
>>     The ATAGS is used for passing parameter from bootloader to kernel at
>> first, which has been replaced by DTB now for ARM platform.
>>
>>     And Rockchip using ATAGs for passing parameter like dram memory
>> size/board uart in different boot process like DRAM init binary/ TPL/SPL to
>> U-Boot since 2018.
>>
>>     And almost at the same time, Simon add bloblist for mainline U-Boot
>> which for similar purpose.
>>
>>     So I'm not sure if this ATAGS should be accept in mainline U-Boot or
>> not, even for rockchip platform only seems some kind of regression for this
>> feature support.
>>
>>
>> Hi Simon and Tom,
>>
>>      Could you help to give some suggestion for this?
>>
> 
> I really meant to do this as an "RFC", so I apologize in advance for
> possibly causing more work in treating this as a full-fledged patch.
> 
> The problem I'm trying to solve is that I've got 2 boards, a Rock 5B
> as well as an Indiedroid Nova both with 16GB of RAM. I noticed that
> without the memory holes the Rock 5B defined in my Indiedroid it would
> also fail to boot. I've got 2 other boards as well with less than 16GB
> of RAM which seem to work fine without any holes (a 4GB Indiedroid Nova
> prototype and a GameForce Ace with 12GB of RAM).

Hi,

When I initially added these holes in the memory, I tried to ask Rockchip what are
the holes for. I didn't get any answer, however the patches to reserve the holes
were accepted.
If we could get more information about why the holes are there, if that area is
specific to something, or that it's fixed in a per-SoC basis, we could reserve it
by hardcoding in the Linux DT, without the need for ATAGs.
Without real information, we cannot be sure that for other variants of the SoC or
some other bootrom configuration, the holes will not change/move.

Eugen

> 
> The "RFC" part for which I'm really requesting guidance/comments is
> a question of "is it appropriate to use ATAGS" to get the RAM banks
> on this SoC, or is there a different way we should be doing it? If
> we can/should use the ATAGS, then I guess this can be pared down and
> refactored to just be RK3588 specific. If so, we can possibly add
> something like this to the RK3588 SoC specific code, guard it with
> an #ifdef ROCKCHIP_TPL to only call it when using the Rockchip
> specific RAM init (in the hopes that maybe one day we get our own
> RAM init), and then replace existing code for boards like the Rock 5B
> so that it no longer reserves these memory banks.
> 
> Thank you,
> Chris.
> 
>>
>> Thanks,
>> - Kever
>> On 2024/3/27 04:49, Chris Morgan wrote:
>>> From: Chris Morgan <macromorgan@hotmail.com>
>>>
>>> Add support for parsing the ATAGs created by the Rockchip binary
>>> RAM init. This ATAG parsing code was taken from the Rockchip BSP
>>> U-Boot source and tested only on parsing the RAM specific ATAGs
>>> for the RK3588.
>>>
>>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
>>> ---
>>>   arch/arm/include/asm/arch-rockchip/atags.h | 222 +++++++++++++++++++++
>>>   arch/arm/mach-rockchip/Makefile            |   1 +
>>>   arch/arm/mach-rockchip/atags.c             |  99 +++++++++
>>>   3 files changed, 322 insertions(+)
>>>   create mode 100644 arch/arm/include/asm/arch-rockchip/atags.h
>>>   create mode 100644 arch/arm/mach-rockchip/atags.c
>>>
>>> diff --git a/arch/arm/include/asm/arch-rockchip/atags.h b/arch/arm/include/asm/arch-rockchip/atags.h
>>> new file mode 100644
>>> index 0000000000..9bae66d7f8
>>> --- /dev/null
>>> +++ b/arch/arm/include/asm/arch-rockchip/atags.h
>>> @@ -0,0 +1,222 @@
>>> +/* SPDX-License-Identifier:     GPL-2.0+ */
>>> +/*
>>> + * (C) Copyright 2018 Rockchip Electronics Co., Ltd
>>> + *
>>> + */
>>> +
>>> +#ifndef __RK_ATAGS_H_
>>> +#define __RK_ATAGS_H_
>>> +
>>> +/* Tag magic */
>>> +#define ATAG_CORE		0x54410001
>>> +#define ATAG_NONE		0x00000000
>>> +
>>> +#define ATAG_SERIAL		0x54410050
>>> +#define ATAG_BOOTDEV		0x54410051
>>> +#define ATAG_DDR_MEM		0x54410052
>>> +#define ATAG_TOS_MEM		0x54410053
>>> +#define ATAG_RAM_PARTITION	0x54410054
>>> +#define ATAG_ATF_MEM		0x54410055
>>> +#define ATAG_PUB_KEY		0x54410056
>>> +#define ATAG_SOC_INFO		0x54410057
>>> +#define ATAG_BOOT1_PARAM	0x54410058
>>> +#define ATAG_PSTORE		0x54410059
>>> +#define ATAG_FWVER		0x5441005a
>>> +#define ATAG_MAX		0x544100ff
>>> +
>>> +/* Tag size and offset */
>>> +#define ATAGS_SIZE		(0x2000)	/* 8K */
>>> +#define ATAGS_OFFSET		(0x200000 - ATAGS_SIZE)/* [2M-8K, 2M] */
>>> +#define ATAGS_PHYS_BASE		(CFG_SYS_SDRAM_BASE + ATAGS_OFFSET)
>>> +
>>> +/* tag_fwver.ver[fwid][] */
>>> +#define FWVER_LEN		36
>>> +
>>> +enum fwid {
>>> +	FW_DDR,
>>> +	FW_SPL,
>>> +	FW_ATF,
>>> +	FW_TEE,
>>> +	FW_MAX,
>>> +};
>>> +
>>> +struct tag_serial {
>>> +	u32 version;
>>> +	u32 enable;
>>> +	u64 addr;
>>> +	u32 baudrate;
>>> +	u32 m_mode;
>>> +	u32 id;
>>> +	u32 reserved[2];
>>> +	u32 hash;
>>> +} __packed;
>>> +
>>> +struct tag_bootdev {
>>> +	u32 version;
>>> +	u32 devtype;
>>> +	u32 devnum;
>>> +	u32 mode;
>>> +	u32 sdupdate;
>>> +	u32 reserved[6];
>>> +	u32 hash;
>>> +} __packed;
>>> +
>>> +struct tag_ddr_mem {
>>> +	u32 count;
>>> +	u32 version;
>>> +	u64 bank[20];
>>> +	u32 flags;
>>> +	u32 data[2];
>>> +	u32 hash;
>>> +} __packed;
>>> +
>>> +struct tag_tos_mem {
>>> +	u32 version;
>>> +	struct {
>>> +		char name[8];
>>> +		u64 phy_addr;
>>> +		u32 size;
>>> +		u32 flags;
>>> +	} tee_mem;
>>> +
>>> +	struct {
>>> +		char name[8];
>>> +		u64 phy_addr;
>>> +		u32 size;
>>> +		u32 flags;
>>> +	} drm_mem;
>>> +
>>> +	u64 reserved[7];
>>> +	u32 reserved1;
>>> +	u32 hash;
>>> +} __packed;
>>> +
>>> +struct tag_atf_mem {
>>> +	u32 version;
>>> +	u64 phy_addr;
>>> +	u32 size;
>>> +	u32 flags;
>>> +	u32 reserved[2];
>>> +	u32 hash;
>>> +} __packed;
>>> +
>>> +struct tag_pub_key {
>>> +	u32 version;
>>> +	u32 len;
>>> +	u8  data[768];	/* u32 rsa_n[64], rsa_e[64], rsa_c[64] */
>>> +	u32 flag;
>>> +	u32 reserved[5];
>>> +	u32 hash;
>>> +} __packed;
>>> +
>>> +struct tag_ram_partition {
>>> +	u32 version;
>>> +	u32 count;
>>> +	u32 reserved[4];
>>> +
>>> +	struct {
>>> +		char name[16];
>>> +		u64 start;
>>> +		u64 size;
>>> +	} part[6];
>>> +
>>> +	u32 reserved1[3];
>>> +	u32 hash;
>>> +} __packed;
>>> +
>>> +struct tag_soc_info {
>>> +	u32 version;
>>> +	u32 name;	/* Hex: 0x3288, 0x3399... */
>>> +	u32 flags;
>>> +	u32 reserved[6];
>>> +	u32 hash;
>>> +} __packed;
>>> +
>>> +struct tag_boot1p {
>>> +	u32 version;
>>> +	u32 param[8];
>>> +	u32 reserved[4];
>>> +	u32 hash;
>>> +} __packed;
>>> +
>>> +struct tag_pstore {
>>> +	u32 version;
>>> +	struct {
>>> +		u32 addr;
>>> +		u32 size;
>>> +	} buf[16];
>>> +	u32 hash;
>>> +} __packed;
>>> +
>>> +struct tag_fwver {
>>> +	u32 version;
>>> +	char ver[8][FWVER_LEN];
>>> +	u32 hash;
>>> +} __packed;
>>> +
>>> +struct tag_core {
>>> +	u32 flags;
>>> +	u32 pagesize;
>>> +	u32 rootdev;
>>> +} __packed;
>>> +
>>> +struct tag_header {
>>> +	u32 size;	/* bytes = size * 4 */
>>> +	u32 magic;
>>> +} __packed;
>>> +
>>> +/* Must be 4 bytes align */
>>> +struct tag {
>>> +	struct tag_header hdr;
>>> +	union {
>>> +		struct tag_core		core;
>>> +		struct tag_serial	serial;
>>> +		struct tag_bootdev	bootdev;
>>> +		struct tag_ddr_mem	ddr_mem;
>>> +		struct tag_tos_mem	tos_mem;
>>> +		struct tag_ram_partition ram_part;
>>> +		struct tag_atf_mem	atf_mem;
>>> +		struct tag_pub_key	pub_key;
>>> +		struct tag_soc_info	soc;
>>> +		struct tag_boot1p	boot1p;
>>> +		struct tag_pstore	pstore;
>>> +		struct tag_fwver	fwver;
>>> +	} u;
>>> +} __aligned(4);
>>> +
>>> +#define tag_next(t)	((struct tag *)((u32 *)(t) + (t)->hdr.size))
>>> +#define tag_size(type)	((sizeof(struct tag_header) + sizeof(struct type)) >> 2)
>>> +#define for_each_tag(t, base)		\
>>> +	for (t = base; t->hdr.size; t = tag_next(t))
>>> +
>>> +/*
>>> + * atags_get_tag - get tag by tag magic
>>> + *
>>> + * @magic: tag magic, i.e. ATAG_SERIAL, ATAG_BOOTDEV, ...
>>> + *
>>> + * return: NULL on failed, otherwise return the tag that we want.
>>> + */
>>> +struct tag *atags_get_tag(u32 magic);
>>> +
>>> +/*
>>> + * atags_is_available - check if atags is available, used for second or
>>> + *			later pre-loaders.
>>> + *
>>> + * return: 0 is not available, otherwise available.
>>> + */
>>> +int atags_is_available(void);
>>> +
>>> +/*
>>> + * atags_overflow - check if atags is overflow
>>> + *
>>> + * return: 0 if not overflow, otherwise overflow.
>>> + */
>>> +int atags_overflow(struct tag *t);
>>> +
>>> +/*
>>> + * atags_bad_magic - check if atags magic is invalid.
>>> + *
>>> + * return: 1 if invalid, otherwise valid.
>>> + */
>>> +int atags_bad_magic(u32 magic);
>>> +#endif
>>> diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
>>> index 1dc92066bb..4165cbe99f 100644
>>> --- a/arch/arm/mach-rockchip/Makefile
>>> +++ b/arch/arm/mach-rockchip/Makefile
>>> @@ -28,6 +28,7 @@ endif
>>>   ifeq ($(CONFIG_TPL_BUILD),)
>>>   obj-$(CONFIG_DISPLAY_CPUINFO) += cpu-info.o
>>> +obj-$(CONFIG_ROCKCHIP_RK3588) += atags.o
>>>   endif
>>>   obj-$(CONFIG_$(SPL_TPL_)RAM) += sdram.o
>>> diff --git a/arch/arm/mach-rockchip/atags.c b/arch/arm/mach-rockchip/atags.c
>>> new file mode 100644
>>> index 0000000000..9daa2f2fc0
>>> --- /dev/null
>>> +++ b/arch/arm/mach-rockchip/atags.c
>>> @@ -0,0 +1,99 @@
>>> +// SPDX-License-Identifier:     GPL-2.0+
>>> +/*
>>> + * (C) Copyright 2018 Rockchip Electronics Co., Ltd.
>>> + *
>>> + */
>>> +
>>> +#include <config.h>
>>> +#include <asm/io.h>
>>> +#include <asm/arch-rockchip/atags.h>
>>> +
>>> +#define HASH_LEN	sizeof(u32)
>>> +
>>> +static u32 js_hash(void *buf, u32 len)
>>> +{
>>> +	u32 i, hash = 0x47C6A7E6;
>>> +	char *data = buf;
>>> +
>>> +	if (!buf || !len)
>>> +		return hash;
>>> +
>>> +	for (i = 0; i < len; i++)
>>> +		hash ^= ((hash << 5) + data[i] + (hash >> 2));
>>> +
>>> +	return hash;
>>> +}
>>> +
>>> +int atags_bad_magic(u32 magic)
>>> +{
>>> +	bool bad;
>>> +
>>> +	bad = ((magic != ATAG_CORE) &&
>>> +	       (magic != ATAG_NONE) &&
>>> +	       (magic < ATAG_SERIAL || magic > ATAG_MAX));
>>> +	if (bad)
>>> +		printf("Magic(%x) is not support\n", magic);
>>> +
>>> +	return bad;
>>> +}
>>> +
>>> +static int atags_size_overflow(struct tag *t, u32 tag_size)
>>> +{
>>> +	return (unsigned long)t + (tag_size << 2) - ATAGS_PHYS_BASE > ATAGS_SIZE;
>>> +}
>>> +
>>> +int atags_overflow(struct tag *t)
>>> +{
>>> +	bool overflow;
>>> +
>>> +	overflow = atags_size_overflow(t, 0) ||
>>> +		   atags_size_overflow(t, t->hdr.size);
>>> +	if (overflow)
>>> +		printf("Tag is overflow\n");
>>> +
>>> +	return overflow;
>>> +}
>>> +
>>> +int atags_is_available(void)
>>> +{
>>> +	struct tag *t = (struct tag *)ATAGS_PHYS_BASE;
>>> +
>>> +	return (t->hdr.magic == ATAG_CORE);
>>> +}
>>> +
>>> +struct tag *atags_get_tag(u32 magic)
>>> +{
>>> +	u32 *hash, calc_hash, size;
>>> +	struct tag *t;
>>> +
>>> +	if (!atags_is_available())
>>> +		return NULL;
>>> +
>>> +	for_each_tag(t, (struct tag *)ATAGS_PHYS_BASE) {
>>> +		if (atags_overflow(t))
>>> +			return NULL;
>>> +
>>> +		if (atags_bad_magic(t->hdr.magic))
>>> +			return NULL;
>>> +
>>> +		if (t->hdr.magic != magic)
>>> +			continue;
>>> +
>>> +		size = t->hdr.size;
>>> +		hash = (u32 *)((ulong)t + (size << 2) - HASH_LEN);
>>> +		if (!*hash) {
>>> +			debug("No hash, magic(%x)\n", magic);
>>> +			return t;
>>> +		}
>>> +		calc_hash = js_hash(t, (size << 2) - HASH_LEN);
>>> +		if (calc_hash == *hash) {
>>> +			debug("Hash okay, magic(%x)\n", magic);
>>> +			return t;
>>> +		}
>>> +		debug("Hash bad, magic(%x), orgHash=%x, nowHash=%x\n",
>>> +		      magic, *hash, calc_hash);
>>> +		return NULL;
>>> +	}
>>> +
>>> +	return NULL;
>>> +}


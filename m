Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE5EC79F82
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 10:03:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C6673605D7;
	Tue,  8 Sep 2026 10:03:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e8FLaH9iyVZI; Tue,  8 Sep 2026 10:03:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6AB1C605DA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788861813;
	b=CNrIbSe2g4IMpLGGqNvWTNmIs2MG1QBRdWP8y3IHyzs/eKAoNyePJb5YwiXnnKatosx5
	 y1ehfTkN2QZGcJFHccwJmQIm8EQIJZz2KV2y/zA+/XzhZ/ZA5uBoIZjQKkGPvLHotLOnW
	 kefLbLqcMzEEukWO5D8D71mA3JLEkYXLWd+l1cpMRz1ClvDLtMx4vbPkQCfGoUjZ+zoSM
	 3A0lPwQdkQNxJ4sscLLu6RfrVKJsDtCYA4hdIWUAsZEkbuJKhCOLXRo4lWd7+IKauUKM2
	 EcvRmZuJmOKp6txFy1miFPNeQlanX5SCW4WsehWkxKW/9PjkYFO5V1uBR8Y4LwsTq0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788861813;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NlOuT7o2DGY8S7/8tcOi00kJFygqJTHzgWzb79Koy/c=;
	b=EkH5K32yjV5gjV16GKp/kLi33gcfluN8FwqMAJu8owjWbTIwZ9jKX5osVnv0PU5/t0gl
	 ISLJO7+Vj4v+4fx/qCKKA9XQjY79AdgCa/2QDgiO6GwSZ7rr0Sfnu08k+KQX0+JkbYkOH
	 bHPfAyG4JfbopXzS5Z4owxSh86z6V/Rph3si0J6zbRkMbD5BpSw/Q0gy5XCnKm6rNCUkt
	 6ncvTbJqJ26I++aniH0YbVr1tamLWLRKBGJjuqgXxAvMmYJr9AOcaAar2TvejC9au3Z5F
	 qYcCBaRx1iIYXW5+MlY8YFD3hO6b92udZ3Dmka/NIpop6/PCfJYQM44xWARpnzgZ2yw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mPPQrEmw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788861813;
	bh=NlOuT7o2DGY8S7/8tcOi00kJFygqJTHzgWzb79Koy/c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LVa9WpdMH+A3U/BTIHTVWhCu6qdm3wTW2rTciabTQTXlIxrZIXolvGDUQ4xsRDpoP
	 Y59D+QqYM8n69nwUU5BNOh7W7ABH00T2DbLTBMY0MQ4Tsx2x5+rpL0zGJLU/WSd3Lb
	 xy/nj2MulYqfsyelTn6FdHpjWwLA+HcoZRtw4PeGnvVznri5/mbX/qPuHiDGosSTQx
	 7NpTOt9jRyuZbqxJm8QMlThrG3D7efyzd8cRQgL0aY/RfbAjjm/tkDBXKIO2CJcwZb
	 jHyHFa6Qe7GDkr5jhmBVKiFpkVU4zoE+j6UpbFTRRmjJ/kBqvr1hUbs77308sjYWrY
	 gQUgvMr1X6qrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AB1C605DA;
	Tue,  8 Sep 2026 10:03:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5776F72C
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 10:03:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D95E605DA
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 10:03:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j6rlNTt9G8hK for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 10:03:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 69FB8605D7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788861809;
 b=izA6mIteND1NMdM+99Dc8Q6IsA0LrqWdsd0iCoIDqAdnPD24rtiPdKHU55+qCHV1x0vA
 zEmGyx7VVLXixmn0H0kHj6GFzz3nKfQfqSJx6Ydy5zEhIts7ODca27HLsyo6zSdu0qzgc
 oYvDG+enTm+RLuCjE6fSGrxFZxwIYSoqaJ1Vz0cUsMzt2QiLnxWhxGUcdmOv38qxE81Sf
 9rD5VVm7uahpqaWpQqB9OaDhGLscXuRm6FEfEh8SUfFIdVmLZE9t/NXWmducqosS9FzXc
 kRl5ZPQKX+iXMDzEcaufgrIsqyqdyCoTv07j9ZL2/cV69m/e8rpiKDi5AyF4jSaIZJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788861809;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
 Content-Language:Organization:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=NlOuT7o2DGY8S7/8tcOi00kJFygqJTHzgWzb79Koy/c=;
 b=OXXc8lGpDVYK3ro2zIN0Fy/r9DBOm1vu5pS2J480cQqEXqbIy9D99mPvpuBBnSNf8F9X
 8Uxt1fAcTarjU6lhnQt0oTJAByyg0t8byrEmKsAD+vICtFlKkKj2JUZhn5KUvpay6I+LY
 XpAv2Y/WxFlOlxtg5WZWUR2IToV+KOWMEnSOESsn/3CjGd8Z99Y20oDs2nST6WkLIhA4x
 Gsu9gcvpX2DF2mWCXqUTMaKzqCpEF6XneshWTBOUNxnlv/YuKq1FUgRapJm1r4y21+q7S
 mEyKweW4JLlCyNUp2R6KLc258gOLPco3Xg3DEMyococXFakF4eHDGXC6wIv/ZyVphww==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=mPPQrEmw; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=mPPQrEmw
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 69FB8605D7
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 10:03:27 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 0F6714E4158D;
 Tue,  8 Sep 2026 10:03:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CDB92603C4;
 Tue,  8 Sep 2026 10:03:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5185E11C7AF4E; 
 Tue,  8 Sep 2026 12:03:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788861795; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=NlOuT7o2DGY8S7/8tcOi00kJFygqJTHzgWzb79Koy/c=;
 b=mPPQrEmw1dz/FqJUJ/kDLTJw1Q9U7J8Gb4P8Wvcg5sDMX799+oPO/1L/GwO+lCYUZyfcDv
 eXUzHfOkuvicXGO3Wl3a36AECfvFZN6wXVXBYzhIZcjcbvfXoMfOY7p5L9Xexcy7kirNBJ
 9ohvEGR6Eu6lFju5nF0ld/UgSShiDvvUBT+ZcyfXSwPZiacs/MrrLMsHA3xvsRabBXkQ/4
 1udj6F7vW1BLk8f5YC/xnyDqH2lm4xZ4GgSfc/u/wffQBkL36jQbvMCUe2l0VFpIjYKoyW
 jO8N92A9JEdSCGi2E6O+BjmAq32F97v1dBegw65//FpWa7tgWAwZe+/PJFDR0g==
Message-ID: <a1b12368-9162-4d03-8818-0cd1dfe8d76e@bootlin.com>
Date: Tue, 8 Sep 2026 12:03:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/21] mach-k3: r5: common: add helper functions needed
 in LPM resume sequence
To: "Kumar, Udit" <u-kumar1@ti.com>, Tom Rini <trini@konsulko.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.u-boot-project.org
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
 <20260828135730.1565643-5-richard.genoud@bootlin.com>
 <7c909676-c821-4c51-a339-03aee3871a00@ti.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <7c909676-c821-4c51-a339-03aee3871a00@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Le 07/09/2026 à 07:46, Kumar, Udit a écrit :
> 
> 
> On 8/28/2026 7:27 PM, Richard Genoud (TI) wrote:
>> From: Prasanth Babu Mantena <p-mantena@ti.com>
>>
>> Add helper functions that are used by respective SoCs in LPM resume flow.
>>
>> - lpm_process() is called at boot time to:
>>    - retrieve the LPM memory region from DTS
>>    - save ATF/OPTEE certificates information and DM code in this memory
>>      region
>>    - Forward the LPM address to TIFS via TISCI_MSG_LPM_SAVE_ADDR
>> TIFS will use this address to save TFA context and its own minimal
>> context just before suspend.
>>
>> - do_resume() is called at resume, just after bringing the DDR out of
>>    retention to:
>>    - retrieve the LPM memory region from DTS
>>    - authenticate certificates from LPM memory region and apply firewalls
>>    - ask TIFS to restore TFA and its own minimal context
>>    - start TFA on remote proc
>>    - load and jump to DM
>>
>> - k3_set_lpm_core_bus_node_path() and k3_set_lpm_core_compatible() are
>>    used to locate the lpm memory region in the DTB
>>
>> https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#lpm-msg-lpm-save-addr
>>
>> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
>> Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
>> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
>> ---
>>   arch/arm/mach-k3/common.h        |  16 ++
>>   arch/arm/mach-k3/lpm-common.h    |  17 ++
>>   arch/arm/mach-k3/r5/Kconfig      |   4 +
>>   arch/arm/mach-k3/r5/Makefile     |   1 +
>>   arch/arm/mach-k3/r5/common.c     |  17 +-
>>   arch/arm/mach-k3/r5/lpm-common.c | 268 +++++++++++++++++++++++++++++++
>>   6 files changed, 311 insertions(+), 12 deletions(-)
>>   create mode 100644 arch/arm/mach-k3/lpm-common.h
>>   create mode 100644 arch/arm/mach-k3/r5/lpm-common.c
>>
>> diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
>> index 37ff98d89924..c97ccc8e0619 100644
>> --- a/arch/arm/mach-k3/common.h
>> +++ b/arch/arm/mach-k3/common.h
>> @@ -8,6 +8,7 @@
>>   
>>   #include <asm/armv7_mpu.h>
>>   #include <asm/hardware.h>
>> +#include <image.h>
>>   #include <mach/security.h>
>>   
>>   /* keep ram_top in the 32-bit address space */
>> @@ -16,6 +17,21 @@
>>   #define K3_FIREWALL_BACKGROUND_BIT	(8)
>>   #define K3_SPEED_GRADE_UNKNOWN		'\0'
>>   
>> +#if IS_ENABLED(CONFIG_SYS_K3_SPL_ATF)
>> +enum {
>> +	IMAGE_ID_ATF,
>> +	IMAGE_ID_OPTEE,
>> +	IMAGE_ID_SPL,
>> +	IMAGE_ID_DM_FW,
>> +	IMAGE_ID_TIFSSTUB_HS,
>> +	IMAGE_ID_TIFSSTUB_FS,
>> +	IMAGE_ID_TIFSSTUB_GP,
>> +	IMAGE_AMT,
>> +};
>> +
>> +extern struct image_info fit_image_info[IMAGE_AMT];
>> +#endif
>> +
>>   struct fwl_data {
>>   	const char *name;
>>   	u16 fwl_id;
>> diff --git a/arch/arm/mach-k3/lpm-common.h b/arch/arm/mach-k3/lpm-common.h
>> new file mode 100644
>> index 000000000000..83e0fdcca6ca
>> --- /dev/null
>> +++ b/arch/arm/mach-k3/lpm-common.h
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * K3: LPM Architecture common definitions
>> + *
>> + * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
>> + * Copyright (C) 2026 Bootlin
>> + */
>> +
>> +#ifndef _LPM_COMMON_H_
>> +#define _LPM_COMMON_H_
>> +
>> +void __noreturn do_resume(void);
>> +void lpm_process(void);
>> +void k3_set_lpm_core_bus_node_path(const char *node_path);
>> +void k3_set_lpm_core_compatible(const char *compatible);
>> +
>> +#endif
>> diff --git a/arch/arm/mach-k3/r5/Kconfig b/arch/arm/mach-k3/r5/Kconfig
>> index 12335880e106..7a9c005a6d7c 100644
>> --- a/arch/arm/mach-k3/r5/Kconfig
>> +++ b/arch/arm/mach-k3/r5/Kconfig
>> @@ -1,6 +1,10 @@
>>   config K3_LOAD_SYSFW
>>   	bool
>>   
>> +config K3_LPM
>> +	bool
>> +	default y if SOC_K3_J721E || SOC_K3_J7200 || SOC_K3_J784S4 || SOC_K3_J722S || SOC_K3_J721S2
> 
> SOC_K3_J721E does not support LPM
ok, I'll remove that

> 
>> +
>>   config K3_OPP_LOW
>>   	depends on ARCH_K3 && K3_AVS0
>>   	bool "Enable OPP_LOW on supported TI K3 SoCs"
>> diff --git a/arch/arm/mach-k3/r5/Makefile b/arch/arm/mach-k3/r5/Makefile
>> index 074e3b61a262..ccededbc0d60 100644
>> --- a/arch/arm/mach-k3/r5/Makefile
>> +++ b/arch/arm/mach-k3/r5/Makefile
>> @@ -13,6 +13,7 @@ obj-$(CONFIG_SOC_K3_J722S) += j722s/
>>   obj-$(CONFIG_SOC_K3_J784S4) += j784s4/
>>   
>>   obj-y += common.o
>> +obj-$(CONFIG_K3_LPM) += lpm-common.o
>>   obj-y += lowlevel_init.o
>>   obj-y += r5_mpu.o
>>   
>> [..]
>> +static int extract_lpm_region(struct lpm_addr_info *mem_addr_lpm)
>> +{
>> +	struct ofnode_phandle_args memregion_phandle;
>> +	fdt_addr_t lpm_reg_addr;
>> +	fdt_size_t lpm_reg_size;
>> +	ofnode memregion;
>> +	ofnode bus_node;
>> +	int ret, idx;
>> +
>> +	if (!lpm_core_compatible) {
>> +		printf("LPM compatible core string not set\n");
>> +		return -EINVAL;
>> +	}
>> +	if (!lpm_core_bus_node_path) {
>> +		printf("LPM core bus path  not set\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	bus_node = ofnode_path(lpm_core_bus_node_path);
>> +	if (!ofnode_valid(bus_node)) {
>> +		printf("Failed to find wkup bus\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	memregion = ofnode_by_compatible(bus_node, lpm_core_compatible);
>> +	if (!ofnode_valid(memregion)) {
>> +		printf("Failed to find r5f devicetree node %s\n",
>> +		       lpm_core_compatible);
>> +		return -EINVAL;
>> +	}
>> +
>> +	idx = ofnode_stringlist_search(memregion, "memory-region-names",
>> +				       "lpm-metadata");
>> +	if (idx < 0)
>> +		return idx;
>> +
>> +	ret = ofnode_parse_phandle_with_args(memregion, "memory-region", NULL,
>> +					     0, idx, &memregion_phandle);
>> +
>> +	if (ret) {
>> +		printf("Failed to parse phandle for lpm memory region\n");
>> +		return ret;
>> +	}
>> +
>> +	lpm_reg_addr = ofnode_get_addr(memregion_phandle.node);
>> +	if (lpm_reg_addr == FDT_ADDR_T_NONE) {
>> +		printf("Can't find a valid reserved node!\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	lpm_reg_size = ofnode_get_size(memregion_phandle.node);
>> +	if (lpm_reg_size == FDT_ADDR_T_NONE) {
>> +		printf("Can't find a valid reserved node!\n");
>> +		return -ENODEV;
>> +	}
>> +
> 
> having check on lpm_reg_size will be helpful, so that you are not
> exceeding below allocation of memory.
ok

> 
>> +	mem_addr_lpm->context_save_addr = lpm_reg_addr;
>> +	mem_addr_lpm->atf_cert_addr = mem_addr_lpm->context_save_addr + FW_IMAGE_SIZE;
>> +	mem_addr_lpm->optee_cert_addr = mem_addr_lpm->atf_cert_addr + FW_IMAGE_SIZE;
>> +	mem_addr_lpm->dm_save_addr = mem_addr_lpm->optee_cert_addr + (2 * FW_IMAGE_SIZE);
>> +	mem_addr_lpm->size = lpm_reg_size;
>> +
>> +	return 0;
>> +}
>> +
>> +static int save_certificate(struct lpm_addr_info *mem_addr_lpm)
> 
> Since we are saving images as well, so save_certificate is not right
> function name.
Indeed

>> +{
>> +	int ret;
>> +
>> +	if (!fit_image_info[IMAGE_ID_ATF].image_start ||
>> +	    !fit_image_info[IMAGE_ID_OPTEE].image_start ||
>> +	    !fit_image_info[IMAGE_ID_DM_FW].image_start) {
>> +		pr_err("Invalid images to save\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = extract_lpm_region(mem_addr_lpm);
>> +	if (ret) {
>> +		pr_err("Cannot find valid LPM address range..\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	memcpy((void *)mem_addr_lpm->atf_cert_addr,
>> +	       (void *)fit_image_info[IMAGE_ID_ATF].image_start,
>> +	       fit_image_info[IMAGE_ID_ATF].image_len);
>> +
>> +	memcpy((void *)mem_addr_lpm->optee_cert_addr,
>> +	       (void *)fit_image_info[IMAGE_ID_OPTEE].image_start,
>> +	       fit_image_info[IMAGE_ID_OPTEE].image_len);
>> +
>> +	memcpy((void *)mem_addr_lpm->dm_save_addr,
>> +	       (void *)fit_image_info[IMAGE_ID_DM_FW].image_start,
>> +	       fit_image_info[IMAGE_ID_DM_FW].image_len);
> 
> Is this DM image with certificates ?
No, the certificate has been stripped by ti_secure_image_post_process()

> 
>> +
>> +	return 0;
>> +}
>> +
>> +void lpm_process(void)
>> +{
>> +	int ret = 0;
>> +	struct lpm_addr_info mem_addr_lpm;
>> +	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
>> +
>> +	ret = save_certificate(&mem_addr_lpm);
>> +	if (ret)
>> +		return;
>> +	/*
>> +	 * As there is no function to check TIFS capabilities, we can't really
>> +	 * know if the call failed because it's not supported by TIFS or for
>> +	 * another reason.
>> +	 */
>> +	ret = ti_sci->ops.lpm_ops.lpm_save_addr(ti_sci,
>> +						mem_addr_lpm.context_save_addr,
>> +						mem_addr_lpm.size);
>> +	if (ret)
>> +		pr_err("TIFS lpm save addr fails (message not supported?)\n");
>> +}
>> +
>> +static unsigned long resume_to_dm_f(const struct lpm_addr_info *mem_addr_lpm)
>> +{
>> +	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
>> +	unsigned long loadaddr;
>> +	int ret = 0;
>> +
>> +	loadaddr = mem_addr_lpm->dm_save_addr;
>> +	if (!valid_elf_image(loadaddr))
>> +		panic("%s: DM-Firmware image is not valid, it cannot be loaded\n",
>> +		      __func__);
>> +
>> +	loadaddr = load_elf_image_phdr(loadaddr);
> 
> I suggest to load DM image using proc_auth_boot API, so that firewall
> inforamtion in DM image can be applied, or replay certificate of DM
> image and load elf.
In this case, we should save somehow the certificates

> 
>> +	ret = ti_sci->ops.lpm_ops.lpm_save_addr(ti_sci,
>> +						mem_addr_lpm->context_save_addr,
>> +						mem_addr_lpm->size);
>> +	if (ret)
>> +		panic("TIFS lpm save addr fail : %x\n", ret);
>> +
>> +	/*
>> +	 * TIFS minimal context restore
>> +	 * This restores also the firewall
>> +	 */
>> +	ret = ti_sci->ops.lpm_ops.min_context_restore(ti_sci, 0);
>> +	if (ret)
>> +		panic("TIFS restore_context failed (%d)\n", ret);
>> +
>> +	/*
>> +	 * Restore TFA in msmc memory
>> +	 */
>> +	ret = ti_sci->ops.lpm_ops.decrypt_tfa(ti_sci,
>> +					      CONFIG_K3_ATF_LOAD_ADDR);
>> +	if (ret)
>> +		panic("%s: TIFS failed to decrytp TFA : %x\n", __func__, ret);
>> +
>> +	/* restore TFA resume vector address in main core */
>> +	ret = ti_sci->ops.lpm_ops.core_resume(ti_sci);
>> +	if (ret)
>> +		panic("ATF failed to resume (%d)\n", ret);
>> +
>> +	return loadaddr;
>> +}
>> +
>> +static void resume_rproc_f(void)
>> +{
>> +	struct power_domain rproc_pwrdmn;
>> +	struct udevice *dev;
>> +	int ret;
>> +
>> +	ret = uclass_get_device_by_seq(UCLASS_REMOTEPROC, 1, &dev);
>> +	if (ret)
>> +		panic("Unknown remote processor 1 (%d)\n", ret);
>> +
>> +	ret = power_domain_get_by_index(dev, &rproc_pwrdmn, 1);
>> +	if (ret)
>> +		panic("power_domain_get_rproc() failed: %d\n", ret);
>> +
>> +	ret = power_domain_on(&rproc_pwrdmn);
>> +	if (ret)
>> +		panic("power_domain_on failed: %d\n", ret);
>> +}
>> +
>> +typedef void __noreturn (*image_entry_noargs_t)(void);
>> +
>> +void __noreturn do_resume(void)
>> +{
>> +	struct lpm_addr_info mem_addr_lpm;
>> +	image_entry_noargs_t image_entry;
>> +	size_t sz = FW_IMAGE_SIZE;
>> +	unsigned long loadaddr;
>> +	void *image_addr;
>> +	int ret;
>> +
>> +	ret = extract_lpm_region(&mem_addr_lpm);
>> +	if (ret)
>> +		panic("Cannot find valid LPM address range... LPM resume failed\n");
>> +
>> +	/*
>> +	 * Disclamer:
> 
> Disclaimer
ok

> 
>> +	 * ---------
>> +	 * There's a potential attack vector here, because OPTEE could be
>> +	 * modified before being reloaded.
>> +	 *
>> +	 * Also, if the certificate replay is skipped, then TFA can be
>> +	 * read from MSMC.
>> +	 */
>> +	ret = rproc_load(1, mem_addr_lpm.atf_cert_addr, 0x200);
>> +	if (ret)
>> +		panic("rproc failed to be initialized (%d)\n", ret);
>> +
>> +	image_addr = (void *)mem_addr_lpm.atf_cert_addr;
>> +	ti_secure_image_auth_apply_fwls(&image_addr, sz);
>> +
>> +	image_addr = (void *)mem_addr_lpm.optee_cert_addr;
>> +	ti_secure_image_auth_apply_fwls(&image_addr, sz);
>> +
>> +	loadaddr = resume_to_dm_f(&mem_addr_lpm);
>> +	printf("Starting ATF on ARM64 core...\n\n");
>> +	resume_rproc_f();
>> +
>> +	image_entry = (image_entry_noargs_t)loadaddr;
>> +	image_entry();
>> +}
> 

Thanks!

Regards,
Richard

-- 
Richard Genoud, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

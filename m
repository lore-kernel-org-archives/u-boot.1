Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE89DE95A62
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 21:15:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 692658648D;
	Sat,  7 Oct 2023 23:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QW4xBacx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DC0C86410; Sat,  7 Oct 2023 23:15:54 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3127C82BBF
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 23:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4S2yks1P4gz9sTq;
 Sat,  7 Oct 2023 23:15:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696713349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kAf9DPdI99n9RX2PoWRr7Q3NHZ1PxKxsPelIv98vTXc=;
 b=QW4xBacxrHViUEpTc06aEAG0Ebw5jdNaTDfFaXFaosbI9vnqjaq8gvLuvLZShZDjdXqwgR
 AN+kfhaWM60/5JG4oC6SynM7hXDWNIq9HmtuhOS/97yX8TgL3MgrT4/czi/7Up046JYj6z
 rF/LdnK+gi5/tp4JW4DkWzo5VseSJxof+u9MJMtpAX4WM3oy0RNe4L4jPbT0ofgc6+u+ra
 UGKqvSClqm/OJfUDjMhWDo4C2c4iYjzk95zl0FcLmyAVuYrpvGcK6AXMLcvwp2pjFfuEQH
 mckFu3TZls7TWuMxXmfvnvw48Edwsvx1jBNEA2PcSkVIjsq8/g3L0eCVrmTC8g==
Message-ID: <35a0e0f8-e2a6-4641-bdbe-0f2907701a37@mailbox.org>
Date: Sat, 7 Oct 2023 23:15:48 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 16/16] board: rzg2l: Add RZ/G2L SMARC EVK board
Content-Language: en-US
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-17-paul.barker.ct@bp.renesas.com>
 <37900365-9d1c-6248-635c-5f6566a08bfb@mailbox.org>
 <7f298a13-72e4-7187-7849-c223b15384ff@bp.renesas.com>
 <OS0PR01MB5922289935215A82AF50036E86C9A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <OS0PR01MB5922289935215A82AF50036E86C9A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 9crgn6mp5794t7a6sitbzy1xrreo1zrf
X-MBO-RS-ID: e7f20e1a8f32aee54cc
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

On 10/6/23 14:51, Biju Das wrote:
> Hi Paul,
> 
>> Subject: Re: [PATCH 16/16] board: rzg2l: Add RZ/G2L SMARC EVK board
>>
>> On 03/10/2023 14:36, Marek Vasut wrote:
>>> On 9/20/23 14:42, Paul Barker wrote:
>>>> The Renesas RZ/G2L SMARC Evaluation Board Kit consists of the RZ/G2L
>>>> System-on-Module (SOM) based on the R9A07G044L2 SoC, and a common
>>>> SMARC carrier board.
>>>>
>>>> The ARM TrustedFirmware code for the Renesas RZ/G2L SoC family passes
>>>> a devicetree blob to the bootloader as an argument in the same was
>>>> previous R-Car gen3/gen4 SoCs. This blob contains a compatible string
>>>> which can be used to identify the particular SoC we are running on
>>>> and this is used to select the appropriate device tree to load.
>>>>
>>>> The configuration renesas_rzg2l_smarc_defconfig is added to support
>>>> building for this target. In the future this defconfig will be
>>>> extended to support other SoCs and evaluation boards from the RZ/G2L
>> family.
>>>>
>>>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>>>> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
>>>> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>>> ---
>>>>    arch/arm/mach-rmobile/Kconfig.rzg2l   | 14 +++++
>>>>    board/renesas/rzg2l/Kconfig           | 18 +++++++
>>>>    board/renesas/rzg2l/MAINTAINERS       |  6 +++
>>>>    board/renesas/rzg2l/Makefile          |  4 ++
>>>>    board/renesas/rzg2l/rzg2l.c           | 76 +++++++++++++++++++++++++++
>>>>    configs/renesas_rzg2l_smarc_defconfig | 52 ++++++++++++++++++
>>>>    include/configs/rzg2l-smarc.h         | 14 +++++
>>>>    7 files changed, 184 insertions(+)
>>>>    create mode 100644 board/renesas/rzg2l/Kconfig
>>>>    create mode 100644 board/renesas/rzg2l/MAINTAINERS
>>>>    create mode 100644 board/renesas/rzg2l/Makefile
>>>>    create mode 100644 board/renesas/rzg2l/rzg2l.c
>>>>    create mode 100644 configs/renesas_rzg2l_smarc_defconfig
>>>>    create mode 100644 include/configs/rzg2l-smarc.h
>>>>
>>>> diff --git a/arch/arm/mach-rmobile/Kconfig.rzg2l
>>>> b/arch/arm/mach-rmobile/Kconfig.rzg2l
>>>> index 7d268e8c366a..1fe49e323300 100644
>>>> --- a/arch/arm/mach-rmobile/Kconfig.rzg2l
>>>> +++ b/arch/arm/mach-rmobile/Kconfig.rzg2l
>>>> @@ -9,6 +9,20 @@ config R9A07G044L
>>>>    	help
>>>>    	  Enable support for the R9A07G044L SoC used in the RZ/G2L.
>>>>
>>>> +choice
>>>> +	prompt "Renesas RZ/G2L Family Board selection"
>>>> +	default TARGET_RZG2L_SMARC_EVK
>>>> +
>>>> +config TARGET_RZG2L_SMARC_EVK
>>>> +	bool "Renesas RZ/G2L SMARC EVK"
>>>> +	imply R9A07G044L
>>>> +	help
>>>> +	  Enable support for the RZ/G2L SMARC evaluation board.
>>>> +
>>>> +source "board/renesas/rzg2l/Kconfig"
>>>> +
>>>> +endchoice
>>>> +
>>>>    config MULTI_DTB_FIT_UNCOMPRESS_SZ
>>>>    	default 0x80000 if TARGET_RZG2L_SMARC_EVK
>>>>
>>>> diff --git a/board/renesas/rzg2l/Kconfig
>>>> b/board/renesas/rzg2l/Kconfig new file mode 100644 index
>>>> 000000000000..1335fc7ae806
>>>> --- /dev/null
>>>> +++ b/board/renesas/rzg2l/Kconfig
>>>> @@ -0,0 +1,18 @@
>>>> +# Copyright (C) 2023 Renesas Electronics Corporation #
>>>> +SPDX-License-Identifier: GPL-2.0+
>>>> +
>>>> +if TARGET_RZG2L_SMARC_EVK
>>>> +
>>>> +config SYS_SOC
>>>> +	default "rmobile"
>>>> +
>>>> +config SYS_BOARD
>>>> +	default "rzg2l"
>>>> +
>>>> +config SYS_VENDOR
>>>> +	default "renesas"
>>>> +
>>>> +config SYS_CONFIG_NAME
>>>> +	default "rzg2l-smarc"
>>>> +
>>>> +endif
>>>> diff --git a/board/renesas/rzg2l/MAINTAINERS
>>>> b/board/renesas/rzg2l/MAINTAINERS new file mode 100644 index
>>>> 000000000000..0a51391c1fc9
>>>> --- /dev/null
>>>> +++ b/board/renesas/rzg2l/MAINTAINERS
>>>> @@ -0,0 +1,6 @@
>>>> +RENESAS RZG2L BOARD FAMILY
>>>> +M:	Paul Barker <paul.barker.ct@bp.renesas.com>
>>>> +S:	Supported
>>>> +F:	arch/arm/dts/rz-smarc-common.dtsi
>>>
>>> I suspect there should be more files here, right ?
>>> You likely want to be CCed on things like rzg2l clock, scif, and so on.
>>>
>>>> +N:	rzg2l
>>>> +N:	r9a07g044
>>>> diff --git a/board/renesas/rzg2l/Makefile
>>>> b/board/renesas/rzg2l/Makefile new file mode 100644 index
>>>> 000000000000..466935fc8158
>>>> --- /dev/null
>>>> +++ b/board/renesas/rzg2l/Makefile
>>>> @@ -0,0 +1,4 @@
>>>> +# Copyright (C) 2023 Renesas Electronics Corporation #
>>>> +SPDX-License-Identifier: GPL-2.0+
>>>> +
>>>> +obj-y	:= rzg2l.o
>>>
>>>> diff --git a/board/renesas/rzg2l/rzg2l.c
>>>> b/board/renesas/rzg2l/rzg2l.c new file mode 100644 index
>>>> 000000000000..2b1bb3546c26
>>>> --- /dev/null
>>>> +++ b/board/renesas/rzg2l/rzg2l.c
>>>> @@ -0,0 +1,76 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +/*
>>>> + * RZ/G2L board support.
>>>> + * Copyright (C) 2023 Renesas Electronics Corporation  */
>>>> +
>>>> +#include <common.h>
>>>> +#include <fdtdec.h>
>>>> +#include <linux/libfdt.h>
>>>> +
>>>> +#if IS_ENABLED(CONFIG_MULTI_DTB_FIT)
>>>> +/* If the firmware passed a device tree, use it for board
>>>> +identification. */ extern u64 rcar_atf_boot_args[];
>>>> +
>>>> +static bool is_rzg2l_board(const char *board_name) {
>>>> +	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
>>>> +
>>>> +	return fdt_node_check_compatible(atf_fdt_blob, 0, board_name) == 0;
>>>> +}
>>>> +
>>>> +int board_fit_config_name_match(const char *name) {
>>>> +	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
>>>> +
>>>> +	if (fdt_magic(atf_fdt_blob) != FDT_MAGIC)
>>>> +		return -1;
>>>> +
>>>> +	if (is_rzg2l_board("renesas,r9a07g044l2"))
>>>> +		return strcmp(name, "r9a07g044l2-smarc");
>>>> +
>>>> +	return -1;
>>>> +}
>>>> +#endif
>>>> +
>>>> +static void apply_atf_overlay(void *fdt_blob) {
>>>> +	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
>>>> +
>>>> +	if (fdt_magic(atf_fdt_blob) == FDT_MAGIC)
>>>> +		fdt_overlay_apply_node(fdt_blob, 0, atf_fdt_blob, 0); }
>>>> +
>>>> +int fdtdec_board_setup(const void *fdt_blob) {
>>>> +	apply_atf_overlay((void *)fdt_blob);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +int ft_board_setup(void *blob, struct bd_info *bd) {
>>>> +	return 0;
>>>
>>> Are all these stub functions really needed or can they be removed
>>> (possibly also with removal of unnecessary config options) ?
>>
>> I've moved dram_init() & dram_init_banksize() out to arch/arm/mach-
>> rmobile/memmap-rzg2l.c. However, the other three stub functions can't
>> easily be removed:
>>
>> * board_init() is always called if CONFIG_ARM is enabled. There is a
>>    similar stub in board/renesas/rcar-common/common.c so I think this is
>>    ok.
>>
>> * ft_board_setup() is called if CONFIG_OF_BOARD_SETUP is enabled, which
>>    is selected by CONFIG_RCAR_64, I don't see much point messing around
>>    to break that config dependency when I'm going to be coming back to
>>    fill in this stub once support for these boards is fully upstreamed to
>>    TrustedFirmware.
>>
>> * reset_cpu() is called from arch/arm/lib/reset.c, which is included
>>    unless CONFIG_SYSRESET is defined, and I don't think enabling
>>    CONFIG_SYSRESET makes any sense here. Again, I'll be filling in this
>>    stub once TrustedFirmware supports resetting this board.
>>
>> I'll chat to the rest of the team tomorrow and see if there's a hacky way
>> we can do the reset before TrustedFirmware support is complete.
> 
> If you need reset other than TF-A, either you can implement
> 
> 1) watchdog reset
> 
> Or
> 
> 2) System reset through PMIC
> 
> Former requires watchdog driver support where as later requires
> I2C support.
> 
> I will go with 2) as with 2 one can distinguish
> Normal reset from abnormal reset due to watchdog.

Let's add a ToDo comment for now, just to be clear this is being worked on.

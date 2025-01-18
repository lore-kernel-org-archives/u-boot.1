Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF87C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 08:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 041A480756;
	Sat, 18 Jan 2025 09:00:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Cm/W2HtV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ntduFznp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00C3A8073D; Sat, 18 Jan 2025 09:00:27 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BC3B80312
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 09:00:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YZptc1wZsz9stj;
 Sat, 18 Jan 2025 09:00:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737187224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QjajNawcxvp0+OIgzzCCMyyS36bqLJum0Kk8JhFePYA=;
 b=Cm/W2HtVkoSsq/52mzhU9vYuQHrqWnsjWuzr8n4l5wwVtTfhDUuVCnzJXdYEu+atZ1mhS7
 00gQEJO04sxefppkctg+gtMjTpemENQhEqwDqI5elTa7RbU7cfW3cqzjuFmUu7ehPRp1pH
 oGPvK0ubhox3zYVUH3JCKfrzijX2vT1aPOMe4SdbhJWTqhVS25orgkWbisD4v51RboEM0H
 4UMIo2+n78lKOCTp/GnmxZ1fc5N7poT7zqfyeogiayzXkNu2eWHsB8eH4fp1mnLHyRRqaX
 NG2vPgfsnsbnEh3tRq7vDhwezgj89HX3Pb7GHgT7/HV5UmV9J/AgmdOqqz3BWg==
Message-ID: <c063022a-d68f-4c49-8e5b-882ad836a18b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737187220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QjajNawcxvp0+OIgzzCCMyyS36bqLJum0Kk8JhFePYA=;
 b=ntduFznpfgXpA3RpMY+2Xv8N5cC4IxDW6vuHvU++czpknyyUNVzDsDQ0QP8IxZDKdiBCS3
 TirjEsRVdfna6ltRohddYFZGTRaC31ZSpSwQ3Qnk5lzRcZIcpLaelEyQdXNxk4PjX6fYcQ
 FVWTAX+sogwyQtUKFKeaKFbJvKDNx4EWx4FtZuBrufjI+EdXKqZb+oxXY3iqZlRdEsE19t
 +Dyt+k+5YOrb8w3lguwtoWpaEswp/gP/GrItdV0yGwzq6TN/e7Y9sheoIzkLbhgYzOWL5L
 QQ1ble1cYC7oS3lUKirUxzS7Vb2jRFE0WUiTwQUicNXq5xXUhhdVMntrIZCSNQ==
Date: Sat, 18 Jan 2025 08:53:34 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/8] ARM: renesas: Simplify board Makefiles
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250112223528.179828-1-marek.vasut+renesas@mailbox.org>
 <20250112223528.179828-2-marek.vasut+renesas@mailbox.org>
 <8b08dbda-58a4-4d7a-b691-acd30460942c@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <8b08dbda-58a4-4d7a-b691-acd30460942c@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xuas4qw8shfjbfj6z89oi65oucrunhd6
X-MBO-RS-ID: 85ca871535fa2a2628c
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

On 1/15/25 11:22 AM, Quentin Schulz wrote:
> Hi Marek,
> 
> On 1/12/25 11:34 PM, Marek Vasut wrote:
>> Introduce board/renesas/common/Makefile and remove the multiple
>> duplicate copies of obj := ../common/*.o from board Makefiles.
>> Let the build system include the common Makefile using the
>> HAVE_VENDOR_COMMON_LIB and build the common objects that are
>> shared by all the boards that way. No functional change intended.
>>
> 
> Thanks for highlighting this HAVE_VENDOR_COMMON_LIB mechanism, I'm now 
> planning on migrating the Theobroma boards to that :) (I would need 
> https://lore.kernel.org/u-boot/20250112223252.179123-1- 
> marek.vasut+renesas@mailbox.org/ though :) ).
> 
>> Some of the remaining board files which include board specific
>> settings have been updated to use obj-y += to avoid rewriting
>> the board obj-y target and avoid dropping object files from the
>> build.
>>
>> Board Makefiles cannot be empty, else they do not generate built-in.o,
>> move the CONFIG_XPL_BUILD ifdeffery from Makefiles into .c files to
>> make sure there is always a built-in.o generated from the remaining
>> minimal Makefiles. This will be further cleaned up in follow up patches.
>>
> 
> Unrelated, but I misread the commit log and was wondering whether this 
> patch series would work without the additional patch from https:// 
> lore.kernel.org/u-boot/20250112223252.179123-1- 
> marek.vasut+renesas@mailbox.org/ so wanted to build an Rcar defconfig to 
> verify but I'm unable to build r8a779f0_spider_defconfig from master:
> 
> /usr/bin/aarch64-linux-gnu-ld: /usr/lib/gcc/aarch64-linux-gnu/14/ 
> libgcc.a(lse-init.o): in function `init_have_lse_atomics':
> /builddir/build/BUILD/cross-gcc-14.2.1-build/gcc-14.2.1-20240912/ 
> aarch64-linux-gnu/aarch64-linux-gnu/libgcc/../../../gcc-14.2.1-20240912/ 
> libgcc/config/aarch64/lse-init.c:46:(.text.startup+0xc): undefined 
> reference to `__getauxval'

[...]

> collect2: fatal error: ld terminated with signal 11 [Segmentation 
> fault], core dumped
> compilation terminated.
> make: *** [Makefile:1812: u-boot] Error 1
> make: *** Deleting file 'u-boot'
> 
> so cannot check myself.
> 
> I'm running Fedora 41.
> 
> $ aarch64-linux-gnu-gcc --version
> aarch64-linux-gnu-gcc (GCC) 14.2.1 20240912 (Red Hat Cross 14.2.1-1)

Debian testing/unstable is at 14.2.0 and spider builds just fine.
Do you observe this failure with or without these patches applied ?

[...]

>> +++ b/board/renesas/common/Makefile
>> @@ -0,0 +1,45 @@
>> +#
>> +# board/renesas/whitehawk/Makefile
>> +#
>> +# Copyright (C) 2024 Marek Vasut <marek.vasut+renesas@mailbox.org>
>> +#
>> +# SPDX-License-Identifier: GPL-2.0+
>> +#
>> +
>> +# R-Car SoCs
>> +ifndef CONFIG_RZG2L
>> +
> 
> This is a bit out of context, can you explain why this suddenly is here?

Fixed in V2

>> +# 32 bit SoCs
>> +ifdef CONFIG_RCAR_GEN2
>> +endif
>> +
> 
> Not sure we need this noop?

This is preparation for R-Car Gen2 deduplication which might happen 
sometimes.

> Also this probably should rather be CONFIG_RCAR_32 instead?

R-Car Gen2 is the only supported 32bit R-Car . I will have to add both

ifdef RCAR_32
ifdef RCAR_GEN2

[...]

>> --- a/board/renesas/whitehawk/Makefile
>> +++ /dev/null
>> @@ -1,13 +0,0 @@
>> -#
>> -# board/renesas/whitehawk/Makefile
>> -#
>> -# Copyright (C) 2021 Renesas Electronics Corp.
>> -#
>> -# SPDX-License-Identifier: GPL-2.0+
>> -#
>> -
>> -ifdef CONFIG_SPL_BUILD
>> -obj-y    := ../common/gen4-spl.o
>> -else
>> -obj-y    := ../common/gen4-common.o ../common/common.o
>> -endif
> 
> This honestly was a bit difficult to review and felt like more than one 
> change was made at once.
> 
> The #if !IS_ENABLED(CONFIG_XPL_BUILD) changes could have been made in a 
> separate commit I believe.
This is actually bogus, so I dropped the whole thing.

The rest is fixed, thanks .

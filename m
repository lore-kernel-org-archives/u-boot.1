Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58518C0219F
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 15:17:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D016388A24;
	Sat, 14 Sep 2024 17:17:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="dp2ZZ7Gb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CAF888ABF; Sat, 14 Sep 2024 17:17:46 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3700B889E2
 for <u-boot@lists.denx.de>; Sat, 14 Sep 2024 17:17:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1726327062; x=1726931862; i=xypron.glpk@gmx.de;
 bh=y4yoFDKKL/5J8oJApN5XBCWX3L8xs2YMwQke0tsrc9Q=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dp2ZZ7GbtnT/owz+KFYX8e6Y1/KYzYbI+JIfq+PdQlkKrA3u7jpG0zodakDTlKGZ
 HV2jh+IRBFPlgn67kvEoeBwvULd53eIgTAIGt9LZ+phTBYN2TBBcGfgGbAMitgMye
 R66dq3PD0VENyIUqfeF84H5NLI7h2HiZdoC+ld8t7DHi3fv+79hX7jdN20g7LC3OP
 FssGnwTi/B/qUMdZc9Wof8rvuuusTIQw6teVvd/su4ve/+Ae2MP/1Xi9dWbblAE6a
 kknSLezO3auF/UHBQPhid6S+5CBDh/Aj3n8pOlOz4RMomZQ77HD6o+z7iKc84xjbU
 pZt4gYLWutxMQSbV1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MulqD-1ryu2g3cTz-018GK0; Sat, 14
 Sep 2024 17:17:41 +0200
Message-ID: <7ff1dbfe-8b8f-47a4-aabf-f20ed50ab6cd@gmx.de>
Date: Sat, 14 Sep 2024 17:17:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] Make EFI memory allocations synchronous with LMB
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J6gmI85GxAAYwpRtvO1oEGOALraq8O8ERDt1s1u6gOuWqVvQ0R7
 AMOhw89KWg5O1dT3jx/u0p0ya1ScvTbau4zLT9UyCMfuhi4D1BojcK5IZa/SoEVO8w2Rc9O
 q3zevICiMONlwFAKuVP3Mnco747EqhbPNogrJiXoj4a5z+EOrhLC/ETtvvaoK2VAlE0weDV
 3hAoKNpCLvx3CAIZMElTQ==
UI-OutboundReport: notjunk:1;M01:P0:ujSjQWQIFM4=;LHhPZRdo2GYp0JAi6+TzfXMGYbR
 T9bm8YdlfqWUYpvkS+cJ2RQRvgHC7J96L6BMEvnbzYRB+lhruxdoVRRanlAf6jbyELN46712l
 lnYwTg20ZEL/3Rf9JopkwNilCakjPnMVunREGnjojpsRgIVklhuPDTyZXLi9IPF8OyBHSTtsd
 Em45Yv66WeP6eqChHcniYNhDhsGNJkBn85loHwMFBSRRQtKG+ssm/mhbiVW2qgOORUh/7Ct/b
 wY7IbVmxqAz5hMvTYk+uFgmS3tTJLyek/w4fC+axyb06LOwRBOcqDhV732Fs4AyjEOqgg2vpE
 VcyjI5/FbOzO7iuSSyfENQ0CbRHfYJtn9w5aAZwE4XhBEi8gd+dkRQ2kqAuYSLK84QABav36z
 n3rryDEVebJJrDu2ROcgfUF8dyhY0Ev/t6kWgO+fEePmhtXCFgRDaDJAyL55DXW7fO4h4n0gz
 /ead07vWsdArpjIEQKbQWw10NWGictR6Taib0TsnUTIsw6+YjjnSzTK8+npoQDrQQ4VNdGqQu
 AO8Bp9VJJGIylPEe4fDvVWn/wrVegndhP5dWH13Q9ihJH/DpCAn7Aho9ZSAm5Kx/m5qCpJIei
 k5Ve89J4vknJon1InCaFwHRo9dn7pnpIvt2baEWomw4Op1WvGWWLSXGGrvZQpNXzFzNLlLVQg
 OZWhonBhghaISjrvIK6wv48pTj8NCuMERZraO5/iv7npMozjUWUr/VCgHxXAwAxaIchdyxEDY
 xfRJsFPwe4y4g1nusj4QgCaD/vC5fzSf1twWVGdzer6JFAqSANwdeqHpyO0hdYg856AbAZHx0
 8CHIOwyPQSfMlSPpDBbQ0pGg==
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

On 9/5/24 10:27, Sughosh Ganu wrote:
>
> This is part two of the series to have the EFI and LMB modules have a
> coherent view of memory. Part one of this goal was to change the LMB
> module to have a global and persistent memory map. Those patches have
> now been applied to the next branch.

We should have only one memory map. This will ensure synchronicity.

Implementing the ARM64 requirement that 4 KiB pages with conflicting
memory attributes cannot be located in the same 64 KiB cannot be
reasonably implemented with the concept presented in this patch series.

Events should only be used to signal EFI_EVENT_GROUP_MEMORY_MAP_CHANGE.

Best regards

Heinrich

>
> These patches are changing the EFI memory allocation API's such that
> they rely on the LMB module to allocate RAM memory. This fixes the
> current scenario where the EFI memory module has no visibility of the
> allocations/reservations made by the LMB module. One thing to note
> here is that this is limited to the RAM memory region, i.e. the
> EFI_CONVENTIONAL_MEMORY type. Any other memory type that is to be
> added to the EFI memory map, still gets handled by the EFI memory
> module.
>
> Note: To be applied on top of the next branch.
>
>
> Sughosh Ganu (16):
>    lmb: add versions of the lmb API with flags
>    lmb: add a flag to allow suppressing memory map change notification
>    efi: memory: use the lmb API's for allocating and freeing memory
>    event: add event to notify lmb memory map changes
>    lib: Kconfig: add a config symbol for getting lmb memory map updates
>    add a function to check if an address is in RAM memory
>    lmb: notify of any changes to the LMB memory map
>    efi_memory: add an event handler to update memory map
>    ti: k3: remove efi_add_known_memory() function definition
>    stm32mp: remove efi_add_known_memory() function definition
>    lmb: allow for boards to specify memory map
>    layerscape: use the lmb API's to add RAM memory
>    x86: e820: use the lmb API for adding RAM memory
>    efi_memory: do not add RAM memory to the memory map
>    lmb: remove call to efi_lmb_reserve()
>    test: event: update the expected event dump output
>
>   arch/arm/cpu/armv8/fsl-layerscape/cpu.c |   8 +-
>   arch/arm/mach-k3/common.c               |  11 --
>   arch/arm/mach-stm32mp/dram_init.c       |  11 --
>   arch/x86/lib/e820.c                     |  47 ++++--
>   common/board_r.c                        |   5 +
>   common/event.c                          |   2 +
>   include/efi_loader.h                    |  12 +-
>   include/event.h                         |  14 ++
>   include/lmb.h                           |  11 ++
>   lib/Kconfig                             |  30 ++++
>   lib/efi_loader/Kconfig                  |   3 +
>   lib/efi_loader/efi_memory.c             | 184 ++++++++----------------
>   lib/lmb.c                               | 146 +++++++++++++------
>   test/py/tests/test_event_dump.py        |   1 +
>   14 files changed, 276 insertions(+), 209 deletions(-)
>


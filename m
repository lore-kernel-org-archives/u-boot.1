Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C9CCA0EFA
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 08:29:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31DEC81E13;
	Mon, 25 Aug 2025 10:29:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA5D882E37; Mon, 25 Aug 2025 10:29:48 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4362808AF
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 10:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.26.216])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id A912DB4E0040;
 Mon, 25 Aug 2025 10:29:45 +0200 (CEST)
Message-ID: <ebdb6cf5-c899-4c6f-a9a1-9de39c1c4beb@freeshell.de>
Date: Mon, 25 Aug 2025 01:29:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] scripts/Makefile.lib: add CONFIG_SYS_CONFIG_NAME
 prefix to dtsi search
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250825040122.303437-1-e@freeshell.de> <87sehf4z73.fsf@prevas.dk>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <87sehf4z73.fsf@prevas.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Rasmus,

On 8/25/25 00:50, Rasmus Villemoes wrote:
> On Sun, Aug 24 2025, E Shattow <e@freeshell.de> wrote:
> 
>> Add ${CONFIG_SYS_CONFIG_NAME}-u-boot.dtsi into dtsi include search order:
>> dtsi location, SYS_SOC, SYS_CPU, SYS_VENDOR, (SYS_CONFIG_NAME), no prefix
>>
> 
> I tried that, with CONFIG_SYS_BOARD, but for my use case I wanted it to
> have higher priority than something "just" matching SOC or CPU.
> 
>   https://lore.kernel.org/u-boot/20230317102639.464263-1-rasmus.villemoes@prevas.dk/
> 
> Can you explain what board(s) you are going to use this for? Because
> this having lower priority than SOC, CPU, VENDOR seems wrong, and if
> there already is some soc-dtsi file for you board, this won't have any
> effect for you.
> 
> The problem with my patch was that we build a lot of completely
> unnecessary .dtb files, and the build of those unneeded dtb files break
> if/when the .config we're building causes an unrelated .dtsi file to be
> included (most often because it refers to nodes that do not exist). I've
> suggested several times that we just nuke most of that dts/Makefile
> because it's really not useful, it still contains typos, and nobody
> notices because we nowadays have build logic to automatically build all
> the .dtbs that are actually relevant to the .config we're building.
> 
> Rasmus

The starfive_visionfive2_defconfig target supports a variety of variant
boards from several vendors and models (and even a range of SoM's)
having the StarFive Jh7110 CPU;  when before adoption of OF_UPSTREAM we
go from having:

arch/riscv/dts/jh7110-milkv-mars.dts
arch/riscv/dts/jh7110-pine64-star64.dts
arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a.dts
arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b.dts
arch/riscv/dts/jh7110-common.dts
arch/riscv/dts/jh7110.dts

(and my memory of this is not quite accurate I think there was a
jh7110-visionfive2.dts or something ... )

each some confusing not-quite-upstream-Linux mish-mash of copy-and-paste
from the respective vendor U-Boot firmware from several years in the
past; More confusingly the U-Boot target to build this is named
'starfive_visionfive2_defconfig' which has no visual relation to
'jh7110'-named things...

and then to after sending everything upstream to Linux kernel and
adoption of OF_UPSTREAM having:

arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
arch/riscv/dts/jh7110-common-u-boot.dtsi
arch/riscv/dts/jh7110-u-boot.dtsi
arch/riscv/dts/starfive-visionfive2-binman.dtsi
arch/riscv/dts/binman.dtsi

each simply having an '#include "jh7110-common-u-boot.dtsi"' for the
common stuff that hasn't quite made it upstream yet and also '#include
"starfive-visionfive2-binman.dtsi"' for the binman specific ops that
stuff a copy of that particular variant devicetree into the final output
so that they can be selected at runtime from a heuristic against the
EEPROM content...

anyhow all that is to say I would like this to reduce further:

arch/riscv/dts/starfive-visionfive2-u-boot.dtsi
arch/riscv/dts/starfive-visionfive2-binman.dtsi
arch/riscv/dts/binman.dtsi

and removes any need for file clutter when we are already naming the
devicetree-rebasing dts target as part of CONFIG_OF_LIST.

my view is that for multi-variant U-Boot targets the defconfig name
should match the dtsi override names so they're easy to search for,
simple as that.

When the U-Boot target is OF_UPSTREAM then CONFIG_OF_LIST contains the
list of board dts target names.

I don't want to push this unnecessarily on any other user in U-Boot, and
I think it's actually appropriate that it only takes precedence over
'u-boot.dtsi'.

I look at those as the old way, and then introducing some new way should
be rather optional; if you want to take advantage of it then clearing
out the SOC, CPU, or VENDOR dtsi that take precedence is necessary.

For your suggestion of adding BOARD, it is more complicated. There is
more restriction on naming a board because it can't be something totally
different than what it is, that would not make sense. But we have
"coreboot_defconfig" for example what is that? it is not a board. It is
however a U-Boot board target. So yes things are a bit strange trying to
go back and add a new class of automatic dtsi include in the search order.

I think OF_UPSTREAM and CONFIG_OF_LIST with an automatic dtsi include of
the defconfig name go a long way to what you might want?

I do have to test this more to be sure it is working like I imagine it
should be, also.

-E Shattow

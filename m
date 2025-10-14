Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB79CCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 18:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B51D580107;
	Tue, 14 Oct 2025 20:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C50D807B1; Tue, 14 Oct 2025 20:26:27 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CD5E800D7
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 20:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.63.107])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 2471BB2202A0;
 Tue, 14 Oct 2025 20:26:23 +0200 (CEST)
Message-ID: <f9931130-96cb-41bf-9be2-6a390085bcad@freeshell.de>
Date: Tue, 14 Oct 2025 11:26:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Merge cherry-pick tag 'riscv-dt-for-v6.18' of
 https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into soc/dt
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20251013215239.19059-2-e@freeshell.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20251013215239.19059-2-e@freeshell.de>
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

Postscript,

On 10/13/25 14:52, E Shattow wrote:
> Cherry-pick RISC-V Misc Devicetrees for v6.18 (Starfive, SiFive, Microchip)
> 
> * tag 'riscv-dt-for-v6.18' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux:
>   riscv: dts: starfive: add Milk-V Mars CM Lite system-on-module
>   dt-bindings: riscv: starfive: add milkv,marscm-lite
>   riscv: dts: starfive: add Milk-V Mars CM system-on-module
>   dt-bindings: riscv: starfive: add milkv,marscm-emmc
>   riscv: dts: starfive: add common board dtsi for Milk-V Mars CM variants
>   riscv: dts: microchip: add a device tree for Discovery Kit
>   dt-bindings: riscv: microchip: document Discovery Kit
>   riscv: dts: microchip: rename icicle kit ccc clock and other minor fixes
>   riscv: dts: microchip: add icicle kit with production device
>   dt-bindings: riscv: microchip: document icicle kit with production device
>   riscv: dts: microchip: add common board dtsi for icicle kit variants
>   riscv: dts: starfive: jh7110-common: drop mmc post-power-on-delay-ms
>   riscv: dts: starfive: jh7110-common: drop no-mmc property from mmc1
>   riscv: dts: starfive: jh7110: bootph-pre-ram hinting needed by boot loader
>   riscv: dts: starfive: jh7110: add DMC memory controller
>   dt-bindings: memory-controllers: add StarFive JH7110 SoC DMC
>   riscv: dts: starfive: jh7110-common: drop no-sdio property from mmc1
>   riscv: dts: microchip: Minor whitespace cleanup
>   dt-bindings: riscv: Add SiFive vendor extensions description
> 
> Link: https://lore.kernel.org/r/20250924-frighten-magazine-ee2f16e64638@spud
> 
> [ upstream commit: 8c0650e0cef283fb31aca5dc7c72b891ff121a88 ]
> 
> (cherry picked from commit 31727e081d77f1cde5ec261a72e0c33dae7ee3c2)
...snip...

Although this is probably okay to take, I cannot vouch for the parts
that touch platforms other than starfive jh7110. Talking on IRC about
how this should be done I learned that taking a merge commit is possible
for U-Boot maintainer to resolve later without too much trouble.

Individual commits are what I intended (and did not understand how to
do). I would like to instead do this as just the commits I am interested in.

I will be sending a series to make the control.rst document more helpful
in this regard, and probably add a "log" operation to the
tools/update-subtree.sh script. There's a logical step missing between
adding the remote repository already knowing what the commit id is, and
firstly explaining how to obtain that commit id.

-E

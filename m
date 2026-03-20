Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950791099B56
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 23:55:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 353F084067;
	Sat, 21 Mar 2026 00:54:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a5T3F0yV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50BF083F00; Fri, 20 Mar 2026 17:52:28 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF11083CEA
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 17:52:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b9831ed36d4so122603466b.3
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 09:52:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774025545; cv=none;
 d=google.com; s=arc-20240605;
 b=EkCR+VzSWVJePHz6VY5v1AqNWe9LkquvknbZAwANNjI/Z8d2pUlKPSgAJkzIyGLJvY
 ApJcFbX2DjMT3H6LhTBn1VrF6iwYSrQxG1/NQg5PZChSP6cvxgexQJ4esGlMc0uwID9q
 7Af2nuykRaskNMxProNa0njqX9Loy+hxWBNychMAe8QvfTLyXksVRXtZuBdMsEiTd7Tq
 KzG3FHWFGJYgWzWMyD++7kuYbstAmpL/p3+md76oA/SdKle+fZZoVDBw9jS6oILhUu0W
 NefjnFWBdIbHpsnt0OmWIlOQ/xIgqgEW+diBN6BotRjCxhZUo4cDwVqLKu2ulSSFrHjE
 vMJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ogAQHzvDO6Z2mtpWF4WWMAnj55zQVH/abZq6g+QI030=;
 fh=o6ASdykb4KLEscL1pIL3jiA1JwlcKqICXsDnyKXEHlY=;
 b=XhtK1u3fyUuqM942ngYYZ+8KNRudZbVlsWVHwSBRHH7zte+VCErhwakFucvqcfUThF
 cb9dMtQ/xSCebkRM4NuMUHoS2UFIuUfjRWp1o/gm6dy5jQKFvh4NEEUJEAhku8Cjm1DM
 v0VV6euEEFzqn20qQdsrwHOBmdnoBEDypMBaLuNWp7t1DXBIOm9SWlv2HdVrKm+WGF+E
 kv+/jrJhZeYhMXxRWp0x5XuJAHbh5QBALgrS68by5rnTxsFiMgA15yebD9cZUu7iVTHW
 g6yNg5njLlWZNGUcukiMN83QY8AqIrWYKCy5eiUjWYhivh2U1y6XwQHjWpAge9lw01lP
 3I5Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774025545; x=1774630345; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ogAQHzvDO6Z2mtpWF4WWMAnj55zQVH/abZq6g+QI030=;
 b=a5T3F0yVFvwnwiD4EffsXHSEJY0CTbzZsUg4WvlpnE6jHXqyR+UZXj8Y3BL2D3LtsW
 QXsSLz57Ui4M4CI9KMJAGAtCKM37f6gUoYG+y6ZpzYNcr4+O4Nes3M7peAXJMc3LMOc+
 jB8uCcUpaew74NvVwZrqOwK3bjE/53RucsY6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774025545; x=1774630345;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ogAQHzvDO6Z2mtpWF4WWMAnj55zQVH/abZq6g+QI030=;
 b=NBbCgO5kL84UOAScoDLfSZBZ06iOz13i+sqI8mGBX/qrhbVJEthzZCzJA3daCIgHsY
 7hl9Sy5UVaaZi8C6sAm+9FPxZ81lSHyjF6gAIo29Xgoj9K8eDRqGr4vtOCUv/CPLjzqz
 AzL9bWOPMIygxd+2kSRte69uDmu1+FPfw/qy2KjPkILgYsyODmmo0PUoVyZ00rhZ3Abx
 URjCLOTaGldzxG2jrNCLIEuTR4mBevQ0yIjOTzOKOxneSEsFkRJs2E9nm7eRDu3m4F3e
 hp8WBk85vRFxb95Vd63kWyEL/rcMee06IeU9pjrTXqMPPfEOwe29xF9OcJaimfdF8kL2
 8tfw==
X-Gm-Message-State: AOJu0YwYvJKDmfswW3nqM6ciwJV6L90t97jS8gjC2Pi/hvUb+pVW0nyM
 FAR6bWjmtxQDfGWtPbKZjTRtoU7ca/HPsNRqqxLGXA14a1gOG0c0P4zXSa+IuOPDtV/u44kLYs8
 t6ucoGnAFwsffpFmrZtndaKs0D8cIHzpDyF7F05YC
X-Gm-Gg: ATEYQzxMMEUuVzHVDGsvYFqTaRCnjfN4yiFJ8AE903pWtqC2W96zE7/f910s+c2+PF3
 mM/nyrY6VRj0kb4MKggYmpbUKZGVwVwS3ZbdJadawUmB/aN8HyThkgPD+rIFWjH2yYv+FlbYreQ
 peUIbJBL+U5dy7s16VM1CyWV1YPVN1/UvkXsCsH1prDDoIdcu9cviHnxD+VOebo6sW4vTaXdqmw
 30jwyROylHuz1L4hA+oSLdOOZsya177EYN6rqZa0JPfxisi1lNdGPSCDYZgydcrqf+MWPpBi2TL
 kNY5Pq/axpMPPZGpfbs=
X-Received: by 2002:a17:906:f0d8:b0:b98:4b8:1046 with SMTP id
 a640c23a62f3a-b982f2edce8mr188687866b.31.1774025544622; Fri, 20 Mar 2026
 09:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
In-Reply-To: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Mar 2026 10:52:12 -0600
X-Gm-Features: AaiRm52WedrmCbbdHbA3EK3NH8g7GEWpMQQboV0WG4VAi5OVQf0TPWMTfopz5AU
Message-ID: <CAFLszTimOLhu=n5jrztE9QqbtXRDjutf_WiKLGMVe4ODJOc8wA@mail.gmail.com>
Subject: Re: [PATCH RFC 00/40] clk: port full Linux Common Clock Framework to
 U-Boot
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 u-boot-qcom@groups.io, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Paul Barker <paul@pbarker.dev>, 
 Dai Okamura <okamura.dai@socionext.com>, linux@analog.com,
 uboot-snps-arc@synopsys.com, 
 u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Stephen Boyd <swboyd@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>,
 Raymond Mao <raymondmaoca@gmail.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Korsgaard <peter@korsgaard.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Thierry Reding <treding@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ryan Wanner <Ryan.Wanner@microchip.com>, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>, 
 Jens Reidel <adrian@mainlining.org>, David Wronek <david.wronek@mainlining.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 David Lechner <dlechner@baylibre.com>, 
 Nishanth Menon <nm@ti.com>, Alice Guo <alice.guo@nxp.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>, 
 Jonathan Currier <dullfire@yahoo.com>, Sam Shih <sam.shih@mediatek.com>, 
 Conor Dooley <conor.dooley@microchip.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Sam Day <me@samcday.com>, Rui Miguel Silva <rui.silva@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Shmuel Leib Melamud <smelamud@redhat.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Finley Xiao <finley.xiao@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, Elaine Zhang <zhangqing@rock-chips.com>, 
 Heiko Stuebner <heiko@sntech.de>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Andrew Davis <afd@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Heiko Schocher <hs@nabladev.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Paul Sajna <sajattack@postmarketos.org>, Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 21 Mar 2026 00:54:25 +0100
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

Hi Casey,

On Thu, 19 Mar 2026 at 14:56, Casey Connolly <casey.connolly@linaro.org> wrote:
>
> This RFC provides a proof of concept for using the full Linux CCF in
> U-Boot and consequently porting full Linux clock drivers with extremely
> minimal changes.

As a general question, what is the boot flow for the Qualcomm devices
you are are targeting, i.e. where does U-Boot come in the chain from
reset? Does it use xPL?

>
> == Overview ==
>
> This RFC is pretty long but can be separated into a few chunks. The
> first patches relate to Linux API compatibility and just contain small
> self contained changes, these can go upstream regardless of CCF.
>
> The next group of changes prepare for importing CCF from Linux, the
> standalone fixed clock drivers are moved to clk/basic, the existing
> U-Boot CCF drivers are moved to clk/uccf, and struct clk_ops is renamed
> to clk_ops_uboot.
>
> Additionally, clk_set_rate() is changed so that it returns a signed
> long, since it can return negative values. This is also done to align
> with CCF but it's a standalone improvement nonetheless.

Agreed.

>
> The next changes import CCF from Linux 6.19 and then adjust it to
> compile and work with U-Boot. These commits are split up mostly to
> try and reduce the size. Finally clk-uclass is adjusted for CCF, this
> definitely will need some additional passes to be a bit cleaner.
>
> With CCF done, sandbox clk-ccf driver gets a CCF_FULL port, the clk_ccf
> tests are adjusted to pass.

Minor point - perhaps CLK_LINUX ? CCF_FULL seems cryptic to me and
some would argue that the existing CLK_CCF is already full..

>
> Lastly, a PoC port of Qualcomms Linux clock drivers is done, this
> only has sm8650 clocks but they serve the desired purpose. The changes
> necessary to the Linux drivers are mostly to deal with U-Boots driver
> model, the actual platform specific clock drivers require essentially
> zero changes!
>
> === Feedback ===
>
> I'd like to get feedback on the overall architecture and ideas, feel
> free to point out any dead code or printf's I forgot about, but I'll for
> sure do a more detailed cleanup before the next revision.
>
> I would definitely like to input on how to deal with clk-uclass, since
> it's now supporting 3 different clock frameworks, but I'm now sure how
> best to separate the code out without duplicating code.

Perhaps a justification can be expressed in terms of code size / capabilities:

Small - can boot in xPL from limited SRAM, only simple clocks
Medium - smaller code size but still provides good access to clocks
Large - Linux compatible, full capability but lots of code

>
> In terms of overall architecture, CCF is a departure from the uclass
> model that U-Boot has stuck too for so long. If this is a success then
> I think it could make a lot of sense to make similar changes for power
> domains and resets. I think this change offers a lot of additional
> flexibility which has been sorely missed.

While those are separate, does this mean that there will be a
significant delta from Linux's clock drivers on Qualcomm, or will it
be minor?
>
> == Motivation ==
>
> There were quite a few motivating factors behind this effort which I
> think provide useful context for this series:
>
> 1. Existing UCLASS_CLK support in U-Boot (even with U-Boots minimal CCF)
>    doesn't provide a fully cohesive API nor implement the necessary
>    functionality to support complex modern platforms without a lot of
>    additional effort.
>
> 2. While trying to enable display support on Qualcomm, it became clear
>    that U-Boots clock framework was a severe limiting factor,
>    particularly for more complicated setups like "bonded" dual-DSI.

It seems that 1 and 2 could be merged? The question here is how much
effort would someone want to put in. Providing an easy way to pull in
the Linux clock driver makes sense. Some people may wish to put in
effort to at least support the basic clocks for xPL, etc.

>
> 3. The current state of Qualcomm clock drivers in U-Boot is pretty poor,
>    as the old very basic driver code is being expected to support more
>    and more complicated usecases. Clock support is generally the most
>    complicated part of bringing up any new Qualcomm platform, so being
>    able to properly reuse Linux drivers with the familiar API greatly
>    reduces the amount of friction when working on U-Boot support for
>    complicated peripherals like the display.
>
> Consequently, My aim with this effort was primarily to provide API
> compatibility with Linux as much as possible, minimising the changes
> that have to be made to clock drivers to port them from Linux, and
> reducing the chance of introducing U-Boot specific bugs.
>
> === clk_ops/UCLASS_CLK ===
>
> CCF_FULL drivers should NOT use UCLASS_CLK, since CCF uses a totally
> independent clock API. If the clocks are provided by another device like
> a phy, they can simply be registered with the clk core the same way they
> are in Linux. Standalone clock drivers should use UCLASS_NOP.

Bypassing UCLASS_CLK entirely is a big departure. It means DM can't
track these clock devices properly - no uclass_find_device(), no
sequence numbers, no standard device iteration.

The suggestion to do the same for power domains and resets would
fragment driver model further.

How about having a single UCLASS_CLK_LINUX device?

>
> Clocks must all be registered during driver probe, the CCF will ensure
> that a given clock provider is probed (via a global ofnode -> device
> lookup) before checking the of_providers, thus making sure the clocks
> are registered so that the consumer can use them. There is currently no
> special handling for cyclical dependencies.

Driver model normally registers devices during a bind step, which
helps to remove the problem of cyclic dependencies. Is there any need
to wait until probe()? Also, can we statically declare it, to save
code size? Most of the definitions are static

The global ofnode -> device lookup to force probe ordering is
reinventing what DM already does with uclass probing. This feels like
it should integrate with DM rather than work around it.

>
> === struct clk ===
>
> It's definitely debatable if it makes sense to have 3 different structs
> for each clk (clk_hw, clk_core and clk). I do think clk_hw and clk_core
> are justified, since clk_hw is more tied to the hardware description and
> typically nested in a clk-specific descriptor while clk_core contains
> the internal runtime state of the clk which should remain private to
> CCF core.

Probably we should follow Linux, since we would start to lose the
benefit of your series if we merged two structs.

>
> It could make sense to merge clk and clk_core, but since struct clk is
> public in U-Boot, where it's an opaque pointer in Linux this would be
> a substantial effort. In Linux struct clk objects are allocated inside
> CCF, but in U-Boot they're allocated by the driver, this would need to
> be resolved before we investigate combining these structs.
>
> === Memory/perf overhead ===
>
> The memory and size overhead of CCF is undoubtably bigger than uCCF,
> although I suspect the difference is less than it might seem at
> first glance. In particular: clk_core is only ~50 bytes larger than
> struct udevice on ARM64, and an additional 120 bytes is saved for each
> U_BOOT_DRIVER used by uCCF.
>
> On the other hand, the CPU overhead is probably more significant,
> but not an unreasonable cost to ensure correctness and propagate rate
> changes across the clock tree.

We already struggle with slow pre-relocation performance, something I
have never really dug into.

>
> Just comparing the binary size of sandbox64_defconfig with uCCF vs
> CCF_FULL, CCF_FULL results in a 135k size increase in the binary. I
> haven't done any more detailed analysis here (still haven't got buildman
> to play nice...).

Sandbox may overestimate the size here, not sure. Ping on irc if you
need update with the buildman setup.

>
> === SPL ===
>
> This RFC doesn't have any SPL specific support, I think this role is
> better fulfilled by UCLASS_CLK.
>
> === U-Boot's old CCF port ===
>
> The original CCF port done for IMX platforms is vastly different in API,
> scope, and function to CCF_FULL, to differentiate I refer to it
> as "uCCF".
>
> I have kept support for this in and made it mutually exclusive with
> CCF_FULL. uCCF drivers have been moved to drivers/clk/uccf, with the new
> CCF port in drivers/clk/ccf.
>
> Included near the end of this series is a port of Sandbox's clk-ccf
> driver from uCCF over to CCF_FULL, this might be a useful reference for
> other drivers (although it's probably better to just adapt the Linux
> drivers).
>
> === Compat shim ===
>
> Lastly, this series includes a compat shim which allows UCLASS_CLK
> drivers to somewhat work with CCF, I would imagine this being useful
> if some generic peripheral device provides a clock for example, but in
> almost all cases I think it's better to implement a proper CCF clock
> device. Unless there is a particular usecase for this I would probably
> not include it in the next revision.
>
> == TODO/Outstanding issues ==
>
> * Clean up clk-uclass.c, does it make sense to somewhow split it in two?
> * Assess test coverage, have basic sandbox tests, would like to mostly
>   use integration tests (i.e. diff the clk summary) once more platforms
>   are supported.
> * pre-relocation support is currently missing, on Qualcomm at least I
>   would prefer to completely skip FDT scanning pre-reloc, there is a
>   patch in this series which does that. It is very non-trivial to try
>   and handle clocks pre-reloc.

Does this mean that only serial is needed and the clock for it is
already set up by some pre-U-Boot phase?

Regards,
SImon

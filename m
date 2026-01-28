Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B36D3F07A
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 15:27:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE95A83FC6;
	Wed, 28 Jan 2026 16:27:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="isNg34NW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D40F983FE9; Wed, 28 Jan 2026 16:27:56 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B69B083DFF
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 16:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: e9fda4ab-fc5d-11f0-be9c-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id e9fda4ab-fc5d-11f0-be9c-005056992ed3;
 Wed, 28 Jan 2026 16:27:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=pY/yWm9qZHvd/e9ncUsRIWf2zbOhRNECcPZgZZxiQ0E=;
 b=isNg34NW1PMg8ew4WZQTHrwFgFLydzdv0QUvRC0v3Z+9ebwZOUnL8Dloya2CWVXRSyuRSEimJInfo
 R9wxyHHbhGB7OFs+WxOW3WiWpKaUDa1jENSwn6cgGxzUBzkqe2m+oKgFQkGsUqjwX8aa/fGPSW3/pK
 DZXn3V56gErtGk1KXdyFcUFXr2KFjk8mvvo3pS9CznQ1IKYo0lbnnwgt4+6AqZ1jNY40zPLsOss3TE
 suadfinVKzL/QtYwHeDy7bKhSOfEC1yKyBr5NG2Ikp+9NLdtNCThH9dNlzYz7/0p/L5/Fn8X7nxwSK
 yYbUwFI4AVRBeZCrYDaLAFv/P20sSGQ==
X-KPN-MID: 33|lyUAeVPPl5pNPR3imiRRg+zsILJdtyyeD7jytjhTwbbOQHsc4uHp/wjeHWC1ecJ
 Ew9Hsr+OQd1FY5G5s4O9CbtO0yTOHjRj4sOm4x5wsb68=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Z7dE8fmmQvPgMd9/rzIwkU+bK58EQFGCJ+UCy34/qHX/AROAfZyUsPPeoT38MO4
 tXGI4yMBF5oGyhzL9/OgAFA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id e99269e5-fc5d-11f0-8d40-00505699b758;
 Wed, 28 Jan 2026 16:27:53 +0100 (CET)
Date: Wed, 28 Jan 2026 16:27:52 +0100
Message-Id: <875x8l69l3.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: xypron.glpk@gmx.de, u-boot@lists.denx.de,
 yuya.hamamachi.sx@renesas.com, andrew.goodbody@linaro.org,
 casey.connolly@linaro.org, holger.brunck@hitachienergy.com,
 ilias.apalodimas@linaro.org, jonas@kwiboo.se,
 kettenis@openbsd.org, semen.protsenko@linaro.org,
 sughosh.ganu@linaro.org, trini@konsulko.com
In-Reply-To: <462cf22d-10d4-4c59-9690-29d9584e7efb@mailbox.org> (message from
 Marek Vasut on Wed, 28 Jan 2026 12:43:28 +0100)
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <A2BF7446-8270-486A-9239-8CBB2C52AC17@gmx.de>
 <462cf22d-10d4-4c59-9690-29d9584e7efb@mailbox.org>
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

> Date: Wed, 28 Jan 2026 12:43:28 +0100
> From: Marek Vasut <marek.vasut@mailbox.org>

Hi Marek,

> On 1/28/26 5:41 AM, Heinrich Schuchardt wrote:
> > Am 28. Januar 2026 00:48:40 MEZ schrieb Marek Vasut <marek.vasut+renesas@mailbox.org>:
> >> Revert commit eb052cbb896f ("lmb: add and reserve memory above ram_top")
> >> and commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from
> >> same bank"). These are based on incorrect premise of the first commit, that
> >> "U-Boot does not use memory above ram_top". While U-Boot itself indeed does
> >> not and should not use memory above ram_top, user can perfectly well use
> >> that memory from the U-Boot shell, for example to load content in there.
> >>
> >> Currently, attempt to use that memory to load large image using TFTP ends
> >> with "TFTP error: trying to overwrite reserved memory...". With this change
> >> in place, the memory can be used again.
> > 
> > IIRC there are drivers that have issues with memory above 4 GiB and boards that artificially set ram_top to 4 GiB to work around these issues.
> 
> I thought I had all of those solved, but apparently not, please read on.
> 
> > We need to carefully consider why the reverted patch was introduced.
> 
> I didn't find much on either commit. I believe the premise on which the 
> original patch was introduced is wrong, cf this commit message. We 
> should allow U-Boot to access the memory above ram_top, we should not 
> allow U-Boot to use it for its data structures because of the possible 
> 32bit DMA limitations.

What do you want to do with that memory in U-Boot?  You can't really
use it to load a kernel into if there is a 32-bit DMA limitations in,
for example, your MMC controller...

Are there boards that don't have enough memory below the 4GB address
boundary?

> > Why does your board use a 4GiB ram_top and not place ram_top at the physical top?
> Originally, I thought it was only a remnant from the past which kept 
> U-Boot and all its data structures, stack, heap in the first DRAM bank 
> in 32bit space, so I tried to remove that. It turns out there are still 
> a couple of problems that have to be solved to make it possible to 
> relocate U-Boot fully into the 64bit space.
> 
> The first one is the standard parsing of DRAM size / ram_top / DRAM 
> banks order in common/board_f.c , which probably hides a lot of issues 
> on various boards, pretty much what you wrote above. In short, 
> dram_init() only sets up gd->ram_base and gd->ram_size , which is often 
> the first continuous DRAM bank which is in 32bit space. The follow up 
> setup_dest_addr() uses that information to set up U-Boot relocation 
> address at the end of that first continuous bank. And then 
> dram_init_banksize() parses the rest of the DRAM banks into gd->bd 
> (gd->bd is set up after setup_dest_addr() is called, in reserve_board()).
> 
> This above is fixable and I already have some clean up patches for that, 
> which I implemented while writing this email.
> 
> But then I found out, that the ravb ethernet driver also has 32bit 
> limited DMA, which breaks if I relocate U-Boot to the 64bit range. It 
> worked thus far, because U-Boot was in 32bit space, so were mallocated 
> DMA descriptors, so was the net_pkt_buf[] array (which is in .data 
> section). I didn't find any other breakage thus far.

Unfortunately hardware with 32-bit DMA constraints is very common.
There are device trees with dma-ranges properties that imply DMA
constraints.  That is mostly about restrictions of busses that have a
limited number of address lines so it certainly doesn't cover
everything.  My list of additonal SoCs with restrictions in OpenBSD has
the Raspberry Pi 4 and Rockchip RK356x and RK3588 on it.

> Which means, before we can really start switching boards to relocate to 
> 64bit space, we need to find all these remaining 32bit limitation sites 
> and fix them first. And to do that, we would need some way to force 
> allocation from 32bit space for drivers which need that ... do we 
> already have such a thing ? I couldn't find anything.

We have bounce buffers in the EFI loader.  There is a more genric
bounce buffer implementation in U-Boot as well, but that is only used
to solve DMA cache coherency issues.  But this suggests that solving
things in generic code instead of drivers might be feasable (at the
price of extra memery copying).

That said, is there really a benefit in giving U-Boot more memory on
systems that typically have 2GB or more below the 4GB address
boundary?

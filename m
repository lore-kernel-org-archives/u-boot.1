Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4727CCCF9F8
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 10:29:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A126783B5F;
	Thu,  6 Nov 2025 11:29:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="OkNT0ubQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E93B583B71; Thu,  6 Nov 2025 11:29:26 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5631383B49
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 11:29:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 194B126091;
 Thu,  6 Nov 2025 11:29:24 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nmBUn_TxajXZ; Thu,  6 Nov 2025 11:29:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1762424962; bh=D3ubo2ceiwcBK5jYKqe/zCH03qcEbpx6j4itTMVWLuc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OkNT0ubQsXUQE/gL+HCqAEcfB2l07h8YuQDzbnUsjrUGNL+WgSnUONN04mKZOCXyK
 yrPmhUOrpXubj+S5WuXR1Y+WozIC3/G0EjsexgsUH7zXE5Z/3W3HVoOwFCPQ9rp15x
 PpFcNKbZkmuc8j7HXSCKSkkygW2GwN0c6dXfdQf/a/92Ps2OhaMD+MON4OUe2uVzyM
 00BJ9bG1NRglRYy9/9WNJ6j1xIBv+r8izxJ7RL76h0BUdascVT0fjOI+Co+Ld9Fnkr
 bQAQ6B1sPeiMK98ALjq48gCwbaRtgqXhxQfNM6SsCjBmwiTvPRcEP0Mpp7VStFmSJy
 T6J3AoRcGKrbQ==
Date: Thu, 6 Nov 2025 10:29:11 +0000
From: Yao Zi <ziyao@disroot.org>
To: Nathaniel Hourt <i@nathaniel.land>
Cc: UBML <u-boot@lists.denx.de>
Subject: Re: Build for RISC-V with LLVM
Message-ID: <aQx4Xk-qsaHXOQ1p@pie>
References: <aAx9bjXivAAuth-y@pie>
 <EF1C62F4-2780-4DD4-B0FE-355AA66A10C4@getmailspring.com>
 <aA2z6ImdniJZm7fq@pie.lan>
 <cd30d0ef07796710523ac5d55bb67d0e@nathaniel.land>
 <aBQkbNrT-u6FPm_D@pie.lan>
 <534beda9eb77a786945ce647aebf7fa7@nathaniel.land>
 <9c0038ed1494e9f293bf4faaf5e66ed8@nathaniel.land>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c0038ed1494e9f293bf4faaf5e66ed8@nathaniel.land>
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

On Wed, Nov 05, 2025 at 10:26:56PM -0600, Nathaniel Hourt wrote:
> On 2025-05-01 21:31, Nathaniel Hourt wrote:
> 
> > On 2025-05-01 20:48, Yao Zi wrote: On Thu, May 01, 2025 at 03:54:34PM
> > -0500, Nathaniel Hourt wrote: Do you have any further information on the
> > issue of linking with LLD? Is
> > anything more known about this problem yet?
> > Sadly no, without any serial output it's hard to work on the problem and
> > I haven't searched through the mailing list for similar reports.
> > Additionally, I don't have enough time to dig further on the issue...
> > sorry about it.
> > 
> > I could revisit the linking problem sometime later if it's still there.
> > May you give ld.bfd a try for now?
> > 
> > [1] https://lists.denx.de/pipermail/u-boot/2025-April/588038.html
> > 
> > --
> > Nathaniel
> > Thanks,
> > Yao Zi
> 
> Oh, it's certainly an option. =)
> 
> But it'll be more fun to dig in and see if I can get lucky enough to figure
> out why LLD isn't doing the job correctly. I suppose I'll start by trying to
> figure out from the make system how the SPL image is derived and begin
> analyzing it or the build assets from which it is derived to determine what
> might be going wrong.
> 
> Advice and pointers are always welcome!
> 
> --
> Nathaniel
> I have found the problem and ~~fixed~~ worked around it! =)

Wow, exciting update!

> So let's dig in. The problem is, when we link with LLD, the FDT winds up in
> the wrong place and U-Boot/SPL can't find it.

...

> The main uboot payload will also fail with a mismatch, because although the
> fdt very nearly hits the right spot, it actually lands 3 bytes early because
> u-boot-nofdt.bin is not 8-byte aligned:
> $ grep "\b_end" u-boot.map
> 
>         402c9cb0         402c9cb0        0     1 _end = .
> 
> $ grep "\b_start" u-boot.map
> 
>         40200000         40200000        0     1                 _start
> $ printf "%x\n" `du -b u-boot-nodtb.bin | cut -f1`
> 
> c9cad
> 
> (Actually, the main uboot seems to be working on the starfive now, even with
> this misalignment, but it wasn't back in May... Nevertheless, this issue
> does still seem to affect other boards, particularly one I have which
> doesn't use an SPL. Padding those last 3 bytes with nulls fixes it.)

I suspect this doesn't affect RISC-V boards enabling OF_BOARD, since we
have a default board_fdt_blob_setup() in arch/riscv/lib/board.c, which
retrieves the FDT address passed by SBI, thus it doesn't matter whether
fdt_find_separate() succeeds or not.

starfive_visionfive2_defconfig does enable OF_BOARD, so it isn't a
problem. But for other ports, it's necessary to correctly pad the binary
to the alignment enforced for __image_binary_end/__bss_end. What ports
did you observe issues on without padding?

> Alright, so focusing back on the SPL... Why is the -nofdtb image too long?
> Well, let's look in the vicinity:
> $ grep 8024 spl/u-boot-spl.map | tail -n5
>          80248fc          80248fc        0     1 _end = .
>          80248fc          80248fc        0     1 _image_binary_end = .
>          80248fc          80248fc        0     1 __image_copy_end = .
>          8024900          8024900      198     8 .got
>         8024900          8024900      198     8         <internal>:(.got)
> Hmmm, for some reason, LLD is putting the GOT after the end tag. Should the
> SPL even _have_ a GOT?

I don't think so.

Currently RISC-V SPL works in, at least to me, a crazy way. Both proper
U-Boot and SPL for RISC-V are now compiled with -fpic flags, which means
GOT relocations could be generated, and we need a GOT for these
relocations to work.

We don't have any code in SPL to fill the GOT table, but linkers could
fill it for us if address of the symbol is determinate at link time,
which covers basically all symbols for a static executable.

But back to the original question, why should we compile SPL with -fpic
(see arch/riscv/config.mk) in the first place, and thus (maybe[1]) need
a GOT? In the current way, SPL won't work, either if it's loaded in an
address differing from CONFIG_SPL_TEXT_BASE, because symbols won't stay
in the address specified and pre-filled by the linker.

So compiling SPL with -fno-pic sounds more reasonable to me, and though
I couldn't test it now, it should fix the boot issue with
starfive_visionfive2_defconfig and ld.lld, too. This would be a huge
change to RISC-V port, and I think deserves more discussion.

> So at last, here is my workaround:
> diff --git a/arch/riscv/cpu/u-boot-spl.lds b/arch/riscv/cpu/u-boot-spl.lds
> index 0717833df55..6e30f2f26dc 100644
> --- a/arch/riscv/cpu/u-boot-spl.lds
> +++ b/arch/riscv/cpu/u-boot-spl.lds
> @@ -33,6 +33,14 @@ SECTIONS
>         } > .spl_mem
>         . = ALIGN(4);
> 
> +       .got : {
> +               __got_start = .;
> +               *(.got.plt) *(.got)
> +               __got_end = .;
> +       } > .spl_mem
> +
> +       . = ALIGN(4);
> +
>         __u_boot_list : {
>                 KEEP(*(SORT(__u_boot_list*)));
>         } > .spl_mem
> 
> Explicitly position the GOT the same place the main uboot image keeps it, so
> it doesn't sneak in somewhere it shouldn't.
> 
> Now, I'm sure this is not a proper solution (I note that u-boot-nodtb.bin is
> still wrong), but I have no idea what a proper solution would be, nor do I
> really know exactly what is going wrong here at all. But I've found a way to
> get everything running, and I hope I've found enough that someone who _does_
> know what they're doing can see the real problem and how to fix it. =)
> 
> OK, that's all I've got!

Many thanks for digging into it.

> -- 
> Nathaniel
> 
> Links:
> ------
> [1] https://source.denx.de/u-boot/u-boot/-/blob/master/lib/fdtdec.c#L1250

Regards,
Yao Zi

[1]: Technically for a static binary, we could lower all GOT relocations
to pcrel ones, and thus it could run anywhere and require no GOT. But
during my experiment, even building starfive_visionfive2_defconfig with
ld.bfd still generates a GOT with -fpic in arch/riscv/config.mk changed
to -fpie, and "la" pseudo-instructions in arch/riscv/start.S replaced
with "lla". Not sure whether I missed something.

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4817BE6ADF8
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 13:08:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 295C48938D;
	Sat, 23 Nov 2024 14:08:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24834893AA; Sat, 23 Nov 2024 14:08:12 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 47BF98936C
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 14:08:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A34171C01;
 Sat, 23 Nov 2024 05:08:38 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 638543F66E;
 Sat, 23 Nov 2024 05:08:07 -0800 (PST)
Date: Sat, 23 Nov 2024 13:07:50 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, U-Boot
 Mailing List <u-boot@lists.denx.de>, Jagan Teki
 <jagan@amarulasolutions.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>
Subject: Re: [PATCH v5 3/8] efi_loader: bootstd: Drop bootmgr for sunxi
Message-ID: <20241123130750.10729a5a@minigeek.lan>
In-Reply-To: <3F1F4DAC-39AC-4D17-8C92-A467FE90DA38@gmx.de>
References: <20241113150938.1534931-1-sjg@chromium.org>
 <20241113150938.1534931-4-sjg@chromium.org>
 <20241113175017.GS3600562@bill-the-cat>
 <CAFLszTjVgz7HxO8jrvVhGORbccGCN6HHMy7fWz=FJYKrfdyQ+g@mail.gmail.com>
 <20241123020802.26cba055@minigeek.lan>
 <3F1F4DAC-39AC-4D17-8C92-A467FE90DA38@gmx.de>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sat, 23 Nov 2024 05:06:49 +0100
Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:

Hi,

> Am 23. November 2024 03:08:02 MEZ schrieb Andre Przywara <andre.przywara@arm.com>:
> >On Fri, 15 Nov 2024 07:21:53 -0700
> >Simon Glass <sjg@chromium.org> wrote:
> >
> >Hi Simon, Tom, Heinrich,
> >
> >sorry for the delay, I was away.
> >  
> >> On Wed, 13 Nov 2024 at 10:50, Tom Rini <trini@konsulko.com> wrote:  
> >> >
> >> > On Wed, Nov 13, 2024 at 08:09:33AM -0700, Simon Glass wrote:
> >> >    
> >> > > This causes problems with the boot order, so drop it until we can figure
> >> > > out a better way to know when bootmgr should be used.
> >> > >
> >> > > Link: https://lore.kernel.org/u-boot/20241112171205.4e80548d@donnerap.manchester.arm.com/
> >> > >
> >> > > Signed-off-by: Simon Glass <sjg@chromium.org>    
> >> >
> >> > I would really prefer a short summary of the contents of the link in the
> >> > commit message. I'm not NAK'ing the patch as-is, but it would be helpful
> >> > when revisiting this if there was a short explanation of the problem to
> >> > solve here and not just "problems with the boot order". Thanks.    
> >> 
> >> The summary is that sunxi supports FEL (USB boot) but bootmgr is not
> >> aware of it, so boots the OS instead.  
> >
> >So that's not the problem: FEL is working fine, since it's marked as
> >global, same as efi_bootmgr, but with a lower order number. The problem
> >is that the higher priority non-global methods (scripts) are "ignored".
> >
> >So this is the list without this patch:
> >Order  Seq  Name                Description
> >-----  ---  ------------------  ------------------
> >    0    0  extlinux            extlinux
> > glob    1  fel                 FEL
> >    2    2  script              script
> > glob    3  efi_mgr             EFI bootmgr flow
> >    4    4  efi                 EFI
> >    5    5  pxe                 PXE
> > glob    6  vbe_simple          vbe-simple
> >-----  ---  ------------------  ------------------
> >
> >The sequence looks roughly alright, only that it's not the actual
> >order, since "glob" takes precedence. So the actual order is:
> >fel -> efi_mgr -> vbe_simple -> extlinux -> script -> efi -> pxe
> >And that puts efi_mgr before extlinux and script, which is not what we
> >want, because efi_mgr finds bootaa64.efi *somewhere* (eMMC or SD card or
> >USB stick) and uses that, even when there is a tailored boot.scr or
> >extlinux.conf on the *boot media* which should be higher priority.
> >"fel" being first is fine, since it's *only* triggered if someone
> >deliberately uploaded a boot script via USB: in this case they surely
> >want to execute exactly that.
> >
> >So I think the underlying problem is the "glob" tag for efi_mgr PLUS
> >the fact that it scans all media for bootaa64.efi files. I think it
> >would be fine if efi_mgr would just consider EFI boot order variables,
> >and would ignore any "removable media" default files (bootaa64.efi).
> >The "efi" bootmeth does the scanning as well, and it's fine there,
> >since it's lower priority, so we can still boot EFI systems.
> >
> >I guess it would make sense if an installer on an USB stick should boot
> >even if there is something on the eMMC, for instance. But we want to
> >control that, and we can't, because the order is ignored due to the
> >"glob" flag.
> >
> >So while I agree that disabling efi_bootmgr sounds like a hack, it
> >solves the problem quite elegantly: We keep the (current) boot order,
> >which prioritises scripts over EFI, but still retain EFI. If people
> >want EFI first, they can change the order in the environment (I think?).
> >
> >Without that patch there is quite a regression for users, because
> >suddenly any bootaa64.efi files *somewhere* would be booted first, and
> >there is no way to turn that off.
> >
> >This has bitten me actually: for development I put a custom boot.scr on
> >an SD card which loads a kernel+DTB via TFTP from my box. And I want
> >that to be first, despite there being a proper EFI setup on the eMMC or
> >USB drive.
> >
> >So I hope that clears that up. I am not a big fan of that patch, but I
> >would like sunxi to be converted, and Simon seemed to be eager to do
> >this as well, so in the interest of not blocking this, I am fine with
> >that.  
> 
> Disabling EFI will break booting for users that rely on it (like me).

So are you using the UEFI BootOrder variables? How do you set them?
Manually on the U-Boot shell, or via some Linux tool manipulating the
U-Boot environment file? IIUC those are the only two methods that work
for sunxi, since the UEFI variable runtime services are not implemented.

In reality I am using UEFI booting as well, but entirely rely on
bootaa64.efi, hence bootmeth_efi is totally sufficient for me.

> Yes, the introduction of boot standard changed the boot order and specifically deprioritizing scripts is unexpected.
> 
> The priority sequence used to be
> 
> scripts
> extlinux
> efi
> pxe
>
> bootmeth_efimgr always running before scripts be fixed.

I agree, but with bootmeth_efimgr marked as global this is not gonna work
easily, at least that's my understanding.

> bootmeth_efi should be removed from the code base as redundant.

I wonder if a solution is to split this up: bootmeth_efimgr is only
looking at variables - then "glob" would be correct. Then people
can place bootmeth_efi at the position they want, either before the
scripts (allowing USB boot) or after. I think this would also solve the
case where bootaa64.efi is both on an eMMC and an SD card, as it would
pick the boot media first.

A lot of sunxi use cases are embedded, and people mostly don't
want to boot from USB on for instance their TV box, just because the
stick with the movies and some bootaa64.efi was still in the slot when
they turned the box on. Even more so for truly embedded devices. And
that's also the default setting for PCs, I think, where USB booting
would need to be explicitly enabled in the BIOS.

Cheers,
Andre

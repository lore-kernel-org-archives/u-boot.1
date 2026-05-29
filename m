Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72521CD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 16:30:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1F7A846A3;
	Fri, 29 May 2026 18:30:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OLTj9sLU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6014B84671; Fri, 29 May 2026 18:30:26 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 065AE846F4
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 18:30:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-68c5eecdd56so540485a12.3
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 09:30:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780072221; cv=none;
 d=google.com; s=arc-20240605;
 b=LcI5xMo1hcO+J7XqVueq0jowzAUmKvVBTx8BPVOnzZApZV5xQx9vE5ySAguaW0KZ0i
 RjpvtKMfH7iOKRPsZxQUigqqRh9brg0r3/UDOK+LXiDulW1pzUrTlUinAsUp994E1Ylf
 TaweRv0krImrVmdXV1qWYAiCuKs4JWeX5LOz1pkxn79a/Ym4JAttU4KO6iXpPcnBePOa
 DLcmK35hLaW3Y3nh+ngdBI5WzHdBBeZ3r1QMcLVmCupDtVs3ULNE9ZzGvI0JPFi5zxsy
 b7cjiFk1UKn7rVlaAFfmx2N75moqECCPE4hrdN0Y3bDQlqgyRUxb84uJdScCwYTXCt0x
 egBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TA6tiXHs3mMPBGanOIXzgTjzkmZR1jAQQ1Hsm+EcO00=;
 fh=ERUHvMi9Jnc/noBeJ4kKdk00HKPQF57bVe7KqVt/gJM=;
 b=i/SICTL6ltLZht+fS1vFsFZkYCGAn4fqYbIekN97KsCDY6xaIwkdHF5HKcETAEo6Ks
 MeW1DCXkL9404NkrqVDbfeBDrN8mDYw4hIApYLNhlIENMIxQFNRF3+GTOJ2ZZki121I4
 Ei5l2VtmNdJ9VQaTBk4A1wr/h2fVAbkBjMKPSaFA3FIP4MxhiWtKOlwbwVPqOeZ6jv1V
 HZ70pWztN9c6hVOLzeBiiwe4L8Ry+3xeSp5txXb3zgJeCgKg0OFNKzV+5kWNW2wYXkpV
 C5mCGLdZNNoKJiEr0Nl2uTCIeOqY7pL8ua5LaKhPMgNPweItNLYcHFB4011UzHrtOKXh
 1sRg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780072221; x=1780677021; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TA6tiXHs3mMPBGanOIXzgTjzkmZR1jAQQ1Hsm+EcO00=;
 b=OLTj9sLULahH74ZzDAGophjmcp1aMkHLjI24guI7npzi14SxkMrxHwpzt5jRiov33r
 v+h/vXXWcVmnksAqINGSAItKzWOyRWLAmBNUvvWL9zs+C41lGSNLKRgBZt0HekdSYdZi
 jHI+MhYROMYNuNUufbT2n7sUOvp3oCtecCQ2UhZnspbrEFTfwliO8W2RT06EE8ZGhXZ0
 FBLZWRZjwD60ZyCz+PcDZ9nhViUJDcGjsyzskB3BzHbjpFxNtnmZ1+x7fBAqB8JriEfl
 7KZB/+BjxZLjDr3R19w5+nd+g1RV9HWLbwQTxtBPfn0WO4TfMJp/F7l7P5ORlbh08aWs
 mY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780072221; x=1780677021;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TA6tiXHs3mMPBGanOIXzgTjzkmZR1jAQQ1Hsm+EcO00=;
 b=ACUwAat2QI1VehqCH0DdHGgds6o5nQd17531KZnkPrlQXziRA6UxeY1bmuCBPZ4ozs
 Yw2QLtl2sSE6MVWVjvHQo9Tjm5o3nFEun/1cx3h3cmG0llQCRWw0jIIeDH/HdPwn8kzX
 8IqdNnYiWOVKyaDxgvDqQ5jJ0NzfqMeOQ/sLRY/XwQMPzSUlzUPKOh3O5vxAkxKd7qg1
 EyopM0ieV5xe53Z8CVFtRGvO7/TWokC1n5cImtAM1YIO6/K4/kxS+zYMDd2rZPXnrRL4
 hvS+hvBuEx0WMMDGLpVAPZwCFK/A5OGFfgg4cauJupVi+y3yyPCxsxPWed1z/9T82CMZ
 X4bg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7z3B7lws/98ITLG92qFpfpwHo8oNhDDMf4CqBioZVN/ZPKRKXiARZGAzYjJO2Ny+QHQQwRVI=@lists.denx.de
X-Gm-Message-State: AOJu0YwJdP73NM0p+kHBbA4hpyiD+382c6qwOh87IlPmACit7N9OHRzB
 LX2inTgGjgEt8FME6OgfAx10h3Uteqancyvkg9gguOiLEP2jMeVJ/MMOLPdoOTGa6ZQ8HxKiNiB
 8f0p+0pCfHM36ak4pIhbskoDg89vSkG4=
X-Gm-Gg: Acq92OH5P+4G8hfEbaEOEbwLbZmxbIXFuy+MAguT5DVBb1TvbJr8vI0U+FEltI458O5
 wiTzWZfrU2JyO/lfDth3txcPuWIMzi8OhINyVK17soTUVaZmGStRYJjS7u9bShfksWcbTsMayrO
 pToz05hJzK31Rf1CicYCDkGBkd4jiFGhJX92Jzl2RgfLsBAPJBvoOK+OB2t7Iqlxoiz6WvbJvaA
 02aYMXou7084esyva56F0+DvwxTh6+5jgWgsSp0NnExkW/RVoUVclPkB/Z9Rzxc9rtiphVIuU9O
 9bGFP905QB4edsjAAKUY00Lzvres5OOO1amoIJ0oB9BkaeC2pg/RtYjsvqjfV2EOqfV9TP34v8e
 RSaAgDjbfNsz/dNZpTiUMo8xhgcz4gasjU8kRy9iP+Qt1Tcsxya0ONdE5cBivwLl6ei3lCho3Xl
 hzKcj4lVkxYXfI
X-Received: by 2002:a05:6402:2112:b0:687:8a9f:3142 with SMTP id
 4fb4d7f45d1cf-68c8ac282d0mr274244a12.10.1780072221323; Fri, 29 May 2026
 09:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
 <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
 <CALeDE9PARyt0iUvnfbSfz=rSA2RkQ1AcoaJpU=8RgnYivaPNEA@mail.gmail.com>
 <20260529154446.GC627328@bill-the-cat>
In-Reply-To: <20260529154446.GC627328@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 29 May 2026 17:30:09 +0100
X-Gm-Features: AVHnY4LM-pNcoGPJm-D6cXHZu7MQbzpqBkNDyDEBsywbvfFbgH4MNoL9RNRAfro
Message-ID: <CALeDE9MAE6r3pFzNRDbwAXkkkWrZo_0gXEMTavmpnGjQBoxrVQ@mail.gmail.com>
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
To: Tom Rini <trini@konsulko.com>
Cc: Gary Guo <gary@garyguo.net>, u-boot@lists.denx.de, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthias Brugger <mbrugger@suse.com>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Mark Kettenis <kettenis@openbsd.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, U-Boot <u-boot-bounces@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 29 May 2026 at 16:44, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 29, 2026 at 01:10:14PM +0100, Peter Robinson wrote:
> > Hi Tom, Marek et el,
> >
> > This is still broken on Raspberry Pis, at least RPi4/RPi5 against RC3.
> >
> > > On Fri Mar 13, 2026 at 8:54 PM GMT, Tom Rini wrote:
> > > > On Wed, 28 Jan 2026 00:48:40 +0100, Marek Vasut wrote:
> > > >
> > > >> Revert commit eb052cbb896f ("lmb: add and reserve memory above ram_top")
> > > >> and commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from
> > > >> same bank"). These are based on incorrect premise of the first commit, that
> > > >> "U-Boot does not use memory above ram_top". While U-Boot itself indeed does
> > > >> not and should not use memory above ram_top, user can perfectly well use
> > > >> that memory from the U-Boot shell, for example to load content in there.
> > > >>
> > > >> [...]
> > > >
> > > > Applied to u-boot/next, thanks!
> > > >
> > > > [1/1] lmb: Reinstate access to memory above ram_top
> > > >       commit: a3075db94d49f415658bf7e961e1eae90d9abc33
> > >
> > > (Cc RPI maintainers)
> > >
> > > Hi Tom,
> > >
> > > I'm testing out latest u-boot/next on my Raspberry Pi 5 8GB, and I am running
> > > into issues caused by this patch.
> > >
> > > I have EFI enabled, and efi_allocate_pages will call into lmb to allocate pages
> > > and start accessing them. However on RPI5, only 1G is mapped, so I got hit with
> > > an "Synchronous Abort" triggered at address 0x1_ffff_f000.
> >
> > I was seeing a "Synchronous Abort" triggered, but now now I am seeing:
> >
> > Hit any key to stop autoboot: 0
> > Cannot persist EFI variables without system partition
> > ** Booting bootflow '<NULL>' with efi_mgr
> > Not a PE-COFF file
> > Loading Boot0000 'mmc 0' failed
> > EFI boot manager: Cannot load any image
> > Boot failed (err=-14)
> > ** Booting bootflow 'mmc@7e340000.bootdev.part_1' with efi
> > Booting /\EFI\BOOT\BOOTAA64.EFI
> > Platform does not support this image
> > Failed to read header: Unsupported
> > Failed to load image: Unsupported
> > start_image() returned Unsupported
> > ## Application failed, r = 3
> > Boot failed (err=-22)
> >
> > > Now, that is easy to fix with the following diff:
> >
> > Simon sent something similar [1] but it didn't fix the problem, nor
> > address the RPi4.
> >
> > [1] https://patchwork.ozlabs.org/project/uboot/patch/20260508233254.2022495-1-sjg@chromium.org/
> >
> > > diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
> > > index 7a1de22e0aef..1db2e37c44f4 100644
> > > --- a/arch/arm/mach-bcm283x/init.c
> > > +++ b/arch/arm/mach-bcm283x/init.c
> > > @@ -69,10 +69,10 @@ static struct mm_region bcm2711_mem_map[MEM_MAP_MAX_ENTRIES] = {
> > >
> > >  static struct mm_region bcm2712_mem_map[MEM_MAP_MAX_ENTRIES] = {
> > >         {
> > > -               /* First 1GB of DRAM */
> > > -               .virt = 0x00000000UL,
> > > -               .phys = 0x00000000UL,
> > > -               .size = 0x40000000UL,
> > > +               /* 16GB of DRAM max */
> > > +               .virt = 0x000000000UL,
> > > +               .phys = 0x000000000UL,
> > > +               .size = 0x400000000UL,
> > >                 .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> > >                          PTE_BLOCK_INNER_SHARE
> > >         }, {
> > >
> > > and that indeed makes my system go past the init. However, I found that while it
> > > is fine to boot into systemd-boot, systemd-boot cannot boot into kernel. After
> > > some investigation, it turns out that efi_load_image_from_file uses
> > > efi_allocate_pages to allocate pages, and then feed this to f->read. This all
> > > eventually trickles down to the MMC driver, and MMC is doing a 32-bit DMA and it
> > > fails to write to the buffer allocated (which is above 4G).
> >
> > The Raspberry Pi has a number of devices which are only accessible at
> > lower memory access, the mailbox is only accessible < 1Gb too.
> >
> > > This could be all fixed by having dma_map_single use a bounce buffer and copy
> > > back the contents on unmap similar to kernel's swiotlb, but that's going to be
> > > some major work.
> > >
> > > In the mean time, I think this patch should be reverted. I can confirm that my
> > > system boots fine with this reverted.
> >
> > Yes, I agree here.
>
> Can you please post the revert Peter? Thanks.

Sent.

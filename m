Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D24CD5BD0
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 13:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77BF684693;
	Sat, 30 May 2026 15:45:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BIcjOGOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42EDA84671; Sat, 30 May 2026 15:45:14 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0296984693
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 15:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6896c54a7easo7075732a12.3
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 06:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780148711; cv=none;
 d=google.com; s=arc-20240605;
 b=dqKtU2YaJOupaIqLDoo99u+bDCMEQWyUwmTD3TKaoeHhdTlT8MtB24xi4x7gJy1cTQ
 2DDE8ArBc0bfCSh4UzDew+h35S4KzXhZ6+u8SuBHvlXwHQkpdL4jzXvv98jBPDmc1uSU
 7xjPiAGKTWUsPxWjNPzfXsPmZfbrYVsHt5wbXMWZwfvROCPeemTXbCMOnPwgzVl4CDIu
 am9o0vzrZrT3aHtzuvIO+CUKzwmu8dseVKrEvfs2a4sftVu2eCUNSM1rgsCehsctFhtI
 V2n1PQike0qmEaHiblfEofkqkz4pkWvlvHg0IOc3XmnirPEg9Si0Q0oN+oADoPXQSV6b
 BIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dZ2mqXa2A3hHdvKASq/maDj4L5T+PeMwJgYzAXe54Jk=;
 fh=PLuip5dMfAixXnE0bFKyfQIHIexlu1OLiTZPkxFzYQo=;
 b=AFQk1ViFtY63v+3NA1AnSWBdAdH4ujp0d7CXpUvYp46choRhR3KIE7Y/r15j6ZgUJl
 DAI7xlmqf7N6r9mgvlu5y8Q3Wve1MZ9/FdJky1pyVN1RLxqr5XQTcd8A1m0a0to0quAI
 w380G4YIFpiQtwJCmN859i+jgZCfxbnE5cm7dIbWemwT0cVn2sqg0SsqRvEAgNJ4/39j
 l5gzCt4ytgb04Z0XuhImFRjMDzz8rPJDzdplWu+n/9RZASZyETD6f8RRQgxMNtpYvSdv
 tcwLxHh3+HL0AFzF7LFJU9gyIdFs5iunv3CsN9FmZeDPB/J3+rvcELIjnuRWt+2ADn5S
 miIQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780148711; x=1780753511; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dZ2mqXa2A3hHdvKASq/maDj4L5T+PeMwJgYzAXe54Jk=;
 b=BIcjOGOvXA4TzoXU1MQuosnkFnsdiJrcYCNtXCWRSIIQDtbb2hUPEMTJNudNjjQN2D
 224FFkWP4qG2vU7yqsDrMqLCdRml7bQ5grhEfGVPb1JQiK3HQppctBR+WR/xlSiONmN2
 hZgplIoRwoJaBKDUs7998HZXjKTkc1dpd9OarLe6QU5iDpfyCMLtgCVVmiMdby90FIDi
 eydmeo7VbnG0l2luW1WhjnvgrG2YP4lLOYWo++EzcZdx8h4JQxZeXcQSckoxaBObWVuI
 4G+IpCJZII9sKkvq7lVJCnTiawSOzMtRNgocJSbKUBkRqxw6yuMKN2ujKjJ2UVkuEJew
 Zj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780148711; x=1780753511;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dZ2mqXa2A3hHdvKASq/maDj4L5T+PeMwJgYzAXe54Jk=;
 b=n0J3fsCsxVwJAJC4WssF927fUfb3fTFm1HvqvBIUGYoL1oc7IZmmYxrq7On5591aqP
 RIim1ch3gVm+pdFmPNz3/OkUFI8TUK20FUrzyo9NFM/3p2P2Px6MgSrjKRey36UsAtKB
 eoUCWAfSyEI6EfBoaWiIm31AcpbH0aEWbY42eMmxMMt8ycX9LJjIEGtAwnNC90esEM5C
 tOF4gNFtG0QZpTHy8nRguR0Rq2r5N7KYC3KSc3TTOsSOkT2LK4pueIDQ2WNkew+2m5Dg
 n5+F0kINf92pG/jPWKsyXWqH/LEw+Ao17RmAwWIS9Z0jDNnH1IMajVsEBBIULXct1SQZ
 qOPA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/tHVLLtDh9PNFhRnfD0N0iSoycnjhru78IVL3pvMur+uQEJHsHv5uUMbDXtV3ritqu+/O54w8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx72mdqLbQAxLwsaD7a7uA552yDDIWgTwg/9bJN852mSJnXvL8v
 T5iWEv3Kj3kg86vCMh6vK7ysTwh8YEsBGpTnjNwczcjYQI6cZVA83enId54r2sBpUY9Q8UJ8j0G
 HAZF+iwksLA3AeyrPmZHl4tqMrNUP1xU=
X-Gm-Gg: Acq92OERG0YEpr3K3Ra9icEFcdovn0hyc3C9ujZYjDta5nvewiZg2hL3oQS4AUKCI+2
 5T994GLtiWqMF/Gktk0mjGBpV1UtARsYYQt8/8jUM6NUjve3WCkDrn0rh9tUaGXNUQV3N38EZ8m
 AdK9qJBLpermddWgVKw8i9lFd4SZIhOf3LWczJiwTyjSnb8nLGnnfQogxlM9Mq/fusk4CiKwwd4
 u5IoQRpDSSXxE5GAvXXYZ777UckGTW91fg1cqSQKb5ULPh93YNLptXy2xYV16d5SMwxhBzevKbG
 pwnVuiJC9wR9yTzS5C/ODnuO45PtJpYpT6rkEy/z3OIRMivHvB3deQxryH/ZtlWPt6fjuPEVSq2
 UF7w30qrhnVcVowbUvlNxiSarKa+hK7oLXoryngqghP9kL3kRxQvA3NpzXuhcH7hXRRBr1ZBCY7
 xDGJOjUIRJMKNuRLtmiLgY8a8=
X-Received: by 2002:a05:6402:a5ca:10b0:686:d801:96c9 with SMTP id
 4fb4d7f45d1cf-68c8c36a8acmr1236078a12.14.1780148711164; Sat, 30 May 2026
 06:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
 <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
 <CALeDE9PARyt0iUvnfbSfz=rSA2RkQ1AcoaJpU=8RgnYivaPNEA@mail.gmail.com>
 <20260529154446.GC627328@bill-the-cat>
 <CALeDE9MAE6r3pFzNRDbwAXkkkWrZo_0gXEMTavmpnGjQBoxrVQ@mail.gmail.com>
 <c9e810ac-6c0e-4a66-bbae-d6557a26197b@mailbox.org>
In-Reply-To: <c9e810ac-6c0e-4a66-bbae-d6557a26197b@mailbox.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 30 May 2026 14:44:58 +0100
X-Gm-Features: AVHnY4KQBAyDiHhXRzC5cNBZrIBtnfaCGy17DXIxbSiz9H9Um0S6rdNC-Mn0h-g
Message-ID: <CALeDE9OzEf2RHZSP047hOd4UzikcUpDfTBo0JNFjy8vMZ912Hg@mail.gmail.com>
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Gary Guo <gary@garyguo.net>,
 u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
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

On Sat, 30 May 2026 at 14:28, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 5/29/26 6:30 PM, Peter Robinson wrote:
> > On Fri, 29 May 2026 at 16:44, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Fri, May 29, 2026 at 01:10:14PM +0100, Peter Robinson wrote:
> >>> Hi Tom, Marek et el,
> >>>
> >>> This is still broken on Raspberry Pis, at least RPi4/RPi5 against RC3.
> >>>
> >>>> On Fri Mar 13, 2026 at 8:54 PM GMT, Tom Rini wrote:
> >>>>> On Wed, 28 Jan 2026 00:48:40 +0100, Marek Vasut wrote:
> >>>>>
> >>>>>> Revert commit eb052cbb896f ("lmb: add and reserve memory above ram_top")
> >>>>>> and commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from
> >>>>>> same bank"). These are based on incorrect premise of the first commit, that
> >>>>>> "U-Boot does not use memory above ram_top". While U-Boot itself indeed does
> >>>>>> not and should not use memory above ram_top, user can perfectly well use
> >>>>>> that memory from the U-Boot shell, for example to load content in there.
> >>>>>>
> >>>>>> [...]
> >>>>>
> >>>>> Applied to u-boot/next, thanks!
> >>>>>
> >>>>> [1/1] lmb: Reinstate access to memory above ram_top
> >>>>>        commit: a3075db94d49f415658bf7e961e1eae90d9abc33
> >>>>
> >>>> (Cc RPI maintainers)
> >>>>
> >>>> Hi Tom,
> >>>>
> >>>> I'm testing out latest u-boot/next on my Raspberry Pi 5 8GB, and I am running
> >>>> into issues caused by this patch.
> >>>>
> >>>> I have EFI enabled, and efi_allocate_pages will call into lmb to allocate pages
> >>>> and start accessing them. However on RPI5, only 1G is mapped, so I got hit with
> >>>> an "Synchronous Abort" triggered at address 0x1_ffff_f000.
> >>>
> >>> I was seeing a "Synchronous Abort" triggered, but now now I am seeing:
> >>>
> >>> Hit any key to stop autoboot: 0
> >>> Cannot persist EFI variables without system partition
> >>> ** Booting bootflow '<NULL>' with efi_mgr
> >>> Not a PE-COFF file
> >>> Loading Boot0000 'mmc 0' failed
> >>> EFI boot manager: Cannot load any image
> >>> Boot failed (err=-14)
> >>> ** Booting bootflow 'mmc@7e340000.bootdev.part_1' with efi
> >>> Booting /\EFI\BOOT\BOOTAA64.EFI
> >>> Platform does not support this image
> >>> Failed to read header: Unsupported
> >>> Failed to load image: Unsupported
> >>> start_image() returned Unsupported
> >>> ## Application failed, r = 3
> >>> Boot failed (err=-22)
> >>>
> >>>> Now, that is easy to fix with the following diff:
> >>>
> >>> Simon sent something similar [1] but it didn't fix the problem, nor
> >>> address the RPi4.
> >>>
> >>> [1] https://patchwork.ozlabs.org/project/uboot/patch/20260508233254.2022495-1-sjg@chromium.org/
> >>>
> >>>> diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
> >>>> index 7a1de22e0aef..1db2e37c44f4 100644
> >>>> --- a/arch/arm/mach-bcm283x/init.c
> >>>> +++ b/arch/arm/mach-bcm283x/init.c
> >>>> @@ -69,10 +69,10 @@ static struct mm_region bcm2711_mem_map[MEM_MAP_MAX_ENTRIES] = {
> >>>>
> >>>>   static struct mm_region bcm2712_mem_map[MEM_MAP_MAX_ENTRIES] = {
> >>>>          {
> >>>> -               /* First 1GB of DRAM */
> >>>> -               .virt = 0x00000000UL,
> >>>> -               .phys = 0x00000000UL,
> >>>> -               .size = 0x40000000UL,
> >>>> +               /* 16GB of DRAM max */
> >>>> +               .virt = 0x000000000UL,
> >>>> +               .phys = 0x000000000UL,
> >>>> +               .size = 0x400000000UL,
> >>>>                  .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> >>>>                           PTE_BLOCK_INNER_SHARE
> >>>>          }, {
> >>>>
> >>>> and that indeed makes my system go past the init. However, I found that while it
> >>>> is fine to boot into systemd-boot, systemd-boot cannot boot into kernel. After
> >>>> some investigation, it turns out that efi_load_image_from_file uses
> >>>> efi_allocate_pages to allocate pages, and then feed this to f->read. This all
> >>>> eventually trickles down to the MMC driver, and MMC is doing a 32-bit DMA and it
> >>>> fails to write to the buffer allocated (which is above 4G).
> >>>
> >>> The Raspberry Pi has a number of devices which are only accessible at
> >>> lower memory access, the mailbox is only accessible < 1Gb too.
> >>>
> >>>> This could be all fixed by having dma_map_single use a bounce buffer and copy
> >>>> back the contents on unmap similar to kernel's swiotlb, but that's going to be
> >>>> some major work.
> >>>>
> >>>> In the mean time, I think this patch should be reverted. I can confirm that my
> >>>> system boots fine with this reverted.
> >>>
> >>> Yes, I agree here.
> >>
> >> Can you please post the revert Peter? Thanks.
> >
> > Sent.
>
> The revert is wrong as that breaks other things , like use of DRAM above
> 4 GiB boundary, which is exactly why this change was implemented. If RPi
> has limitations, then those limitations should be imposed on RPi, not
> globally, so add the LMB reservations on RPi.

I have no idea how LMB works so please send a patch that does that.

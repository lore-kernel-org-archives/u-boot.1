Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0646CD6E51
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 12:10:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A453B84671;
	Fri, 29 May 2026 14:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HJe0g9jF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6469846CA; Fri, 29 May 2026 14:10:29 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72CF884671
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 14:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-687ed9aabb3so1679443a12.1
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 05:10:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780056627; cv=none;
 d=google.com; s=arc-20240605;
 b=EqkKVITQ2oE+VlLjvCXS98sYKkj+7Z9C5kwhIdsCQYRcj0Idr9TNtDzsvX6ioAH8Fu
 P9M4ysX260Pqplt8jkL4YY2j1YEjXfo6i75ut6L2wQHJNykYYMehfBddHulC6ld05mfz
 YKN/k/zHiBR/X6aCI7JHIUHNTjYvUOtgtIDjBah/b6Ywu10e6VhJ8w08vZAUwQ+coFO+
 LiRaILQY+BOLy1NPLumgYj+Zf09H1+dyIwIpyNMch1xYGWoW81JwTux4Zq3w0YKbLUKi
 MFO+bF8z5BGS1oq6t/CQrn5s1lA2LLmxhyje3/gGtnzKb3jDzLAHhMBojYCYKp8YEphL
 uphA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EvwddWMor+HqWyaVBzxXhWRhEmh8qy2FsIRQlhdGKdg=;
 fh=EjXX5xUw6cmmFmgReM91FxJAxUWEh3Hax3Kjd2W9fck=;
 b=P953+1eq5EikYy/Zmm77q4RQOQ9pXBHDO+HsygledbkboS6qB6sV2/gDz/a4en5A+Q
 BtAX9q7UyLwEI4ubo6Qj1yQIr2IzQuz755AgpXqvt9vkAD6l37v5Rx4pZcppQB0587pr
 FIlDOl7PG4yNVjUkkOdzq5vL1mvJajBEzyOsDJS03xTmJsMow9FGSZfY2T8elzzPhIh4
 6ziZF3e8Fe9b5XiTQrNUKe8lmbS3K4L4/sgYUKWwqptVw3CSKI22x8ZpWEzlPPMtUdoB
 Llz9MxUDIcueOvV5T0+BoOFQg/WdSvFJQEEvyhz1MLmssz1gwUoQMY2HLa9KsX9AQLbs
 srrQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780056627; x=1780661427; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EvwddWMor+HqWyaVBzxXhWRhEmh8qy2FsIRQlhdGKdg=;
 b=HJe0g9jFTHvCnnpe+0lrsn0Hi+mSZx27HNUrVNB16AFXVDP/EN6VLLO3QI8omzFd3C
 O9jelETGqjx2C336ZhU40YZTHl+jrwGJGfjpvU2I2aAlNIumZU9MzYf6UHk3b70FYZsO
 E7hf8TxQbITVpuMPNiZLF3Vr70RjP+bAtyuXlj68sKcg/bmPPCL2GhNWf62zImb4nhS5
 5N3Egs+rsnyZmY4rEmM1mKg9HcK0yGWX8zYpXpwim2iE+U2r/N+T0j+WDeBkPzInm2mu
 FW1V1khCHiiM1tFGYZws/0zuIN50WmhpgQvKzJ9ha6SkxNT3XYkNpDZ0L8qgC+6u/Pk7
 C62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780056627; x=1780661427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EvwddWMor+HqWyaVBzxXhWRhEmh8qy2FsIRQlhdGKdg=;
 b=mKWp1p3J1wUdVyAHp2GFpX4wkI7Cl4EFr8ium/tvKf4OD+sHcNWm7RtCSbP1ZvlElq
 YDE4++EDoQWX/kDGlVTki+wmXqo9JTJtVPqqEtOXRWdLr1fQK2xqLaayHzpsEY41La9B
 6OBiS8L8a4KaysjBmy8SxZHZrOvEFQxjw8NonZngw/vPYX0MnRNVg91tUQIwNvNeXjYX
 erYQzpFJueBSbcJZEN1x/5mebuhudLcW2WUvDCH9gevRWd3Lsqzs8XU4cZt9vHnhs/DR
 W7Dc/sLeTpwgCswwIbORDgC9m+lKfGyPIM6F1XPAkWEcsixREja6d1tIvpX6OAxyvKeG
 1jTQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+T2DZu+fp3dMvRxjqBG7t5d5EL5nPIfRK1n0PaA1ZVN5ZheGjtFC3fFVY1NRLnSbvFhsrir6M=@lists.denx.de
X-Gm-Message-State: AOJu0YwViEeN2GI3uYhSXs9Xx6KaUL2uj2TuWhbaeXZpziXak6xgoiua
 3JLJVdA5urClL/+SLMkBK/LwriFYE0QvMe4Lu1WqDJUPqdzgq6EQ7QTh56Ct+dhAciGh7RgZnfW
 IEewcXMtZbN5aFpasAY+tagZAUqzPeCg=
X-Gm-Gg: Acq92OFX/PlKomskd9kn3PkEvtLBmgVRFxLBHGB8PCrDYJPhthW9CFnyRmMnZh4oHmj
 RaU36B1AoX1wf+WPY0rsnkobCkXpswkj9x8VrAOyBPfQnYHhVkUpevdmmS1rMzl9ryRT+nA799h
 AbIOiXRNI9qe7tMeYMyPfDuJGSbaWKc1vl3/b580SxlGrHaemn+MrlJ0vCip9fL9XlHi4sBWxr9
 gaNxem6mH7ScOG73QqACIwt9vd4OOOrtizv2Oboulv4DGWBXxEV47gO0SqBDWsRzTECYunSiAFf
 TMQ4WyPFxjMfShKJiri0iVYxni4kETzxXfPHZ0zPa1GplrHvZQmwsYgalwsaDWaUpZDHnjW3YtE
 JHF3uT7mIpY3jva9yNSkqesQbbJBFuMITk/VmiFUyJDZbcvdXnN7/p4FiITszesglfIc6BRiTys
 0oKzBGXO5N7Dn+NiIUzJmKc5U=
X-Received: by 2002:a05:6402:28cb:b0:670:62dd:e2f4 with SMTP id
 4fb4d7f45d1cf-68c0fd856e6mr1313611a12.8.1780056626531; Fri, 29 May 2026
 05:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
 <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
In-Reply-To: <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 29 May 2026 13:10:14 +0100
X-Gm-Features: AVHnY4KdDcoCqA7BR7XrgrAmU4x_WAez4rUmVvHd5OeigUeSqyRcZUPrLPWTjdQ
Message-ID: <CALeDE9PARyt0iUvnfbSfz=rSA2RkQ1AcoaJpU=8RgnYivaPNEA@mail.gmail.com>
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
To: Gary Guo <gary@garyguo.net>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
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

Hi Tom, Marek et el,

This is still broken on Raspberry Pis, at least RPi4/RPi5 against RC3.

> On Fri Mar 13, 2026 at 8:54 PM GMT, Tom Rini wrote:
> > On Wed, 28 Jan 2026 00:48:40 +0100, Marek Vasut wrote:
> >
> >> Revert commit eb052cbb896f ("lmb: add and reserve memory above ram_top")
> >> and commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from
> >> same bank"). These are based on incorrect premise of the first commit, that
> >> "U-Boot does not use memory above ram_top". While U-Boot itself indeed does
> >> not and should not use memory above ram_top, user can perfectly well use
> >> that memory from the U-Boot shell, for example to load content in there.
> >>
> >> [...]
> >
> > Applied to u-boot/next, thanks!
> >
> > [1/1] lmb: Reinstate access to memory above ram_top
> >       commit: a3075db94d49f415658bf7e961e1eae90d9abc33
>
> (Cc RPI maintainers)
>
> Hi Tom,
>
> I'm testing out latest u-boot/next on my Raspberry Pi 5 8GB, and I am running
> into issues caused by this patch.
>
> I have EFI enabled, and efi_allocate_pages will call into lmb to allocate pages
> and start accessing them. However on RPI5, only 1G is mapped, so I got hit with
> an "Synchronous Abort" triggered at address 0x1_ffff_f000.

I was seeing a "Synchronous Abort" triggered, but now now I am seeing:

Hit any key to stop autoboot: 0
Cannot persist EFI variables without system partition
** Booting bootflow '<NULL>' with efi_mgr
Not a PE-COFF file
Loading Boot0000 'mmc 0' failed
EFI boot manager: Cannot load any image
Boot failed (err=-14)
** Booting bootflow 'mmc@7e340000.bootdev.part_1' with efi
Booting /\EFI\BOOT\BOOTAA64.EFI
Platform does not support this image
Failed to read header: Unsupported
Failed to load image: Unsupported
start_image() returned Unsupported
## Application failed, r = 3
Boot failed (err=-22)

> Now, that is easy to fix with the following diff:

Simon sent something similar [1] but it didn't fix the problem, nor
address the RPi4.

[1] https://patchwork.ozlabs.org/project/uboot/patch/20260508233254.2022495-1-sjg@chromium.org/

> diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
> index 7a1de22e0aef..1db2e37c44f4 100644
> --- a/arch/arm/mach-bcm283x/init.c
> +++ b/arch/arm/mach-bcm283x/init.c
> @@ -69,10 +69,10 @@ static struct mm_region bcm2711_mem_map[MEM_MAP_MAX_ENTRIES] = {
>
>  static struct mm_region bcm2712_mem_map[MEM_MAP_MAX_ENTRIES] = {
>         {
> -               /* First 1GB of DRAM */
> -               .virt = 0x00000000UL,
> -               .phys = 0x00000000UL,
> -               .size = 0x40000000UL,
> +               /* 16GB of DRAM max */
> +               .virt = 0x000000000UL,
> +               .phys = 0x000000000UL,
> +               .size = 0x400000000UL,
>                 .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>                          PTE_BLOCK_INNER_SHARE
>         }, {
>
> and that indeed makes my system go past the init. However, I found that while it
> is fine to boot into systemd-boot, systemd-boot cannot boot into kernel. After
> some investigation, it turns out that efi_load_image_from_file uses
> efi_allocate_pages to allocate pages, and then feed this to f->read. This all
> eventually trickles down to the MMC driver, and MMC is doing a 32-bit DMA and it
> fails to write to the buffer allocated (which is above 4G).

The Raspberry Pi has a number of devices which are only accessible at
lower memory access, the mailbox is only accessible < 1Gb too.

> This could be all fixed by having dma_map_single use a bounce buffer and copy
> back the contents on unmap similar to kernel's swiotlb, but that's going to be
> some major work.
>
> In the mean time, I think this patch should be reverted. I can confirm that my
> system boots fine with this reverted.

Yes, I agree here.

Peter

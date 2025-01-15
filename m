Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE9EC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 23:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0873F8069D;
	Thu, 16 Jan 2025 00:21:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cGQkGwE3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 252FE806D4; Thu, 16 Jan 2025 00:21:31 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C3E78033D
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 00:21:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ab2b29dfc65so52742566b.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 15:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736983288; x=1737588088; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UstGjRPYofxcvVwwd3CLwJomawxtRqwSvicS8pn+4Xo=;
 b=cGQkGwE3WCaWvaTJE4X+hzFwIoM54Ac2hFzldFEuJ0jgzaxb6cVdd8UwGDw64MbuEG
 J6Jc9TwRh+9qNbNpCJdxCNyVCzpp2LlksxFRuJEDeNsunfM0NBMQQWB8bRvY3yj/wcB6
 6nYduf52ve4KMso6VgklfPrAhNDx1u2s80EhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983288; x=1737588088;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UstGjRPYofxcvVwwd3CLwJomawxtRqwSvicS8pn+4Xo=;
 b=sPFDHjmOPjbCCvtTFHltYHf0+iDTpnfOwfPhhXmz1HZ3URO6QzK3Q8Qui6HGqqfBZB
 0dYLeYzJgVckH2mcmaCnpCzKbxNaA2TBy1P+pkHfxV9mEI7MBvnLEXZxBPppindIHYhL
 vxuSPgEeqtKsuiuiiGpbd2GNR5A3qLPr123KvZwGrtMK5EE3eexB8qtncYHKB1rTTO/U
 HCe5+ZbJzykgK39IxSd/dlMQqL8AHzccepL6WCBtIkMjheiW1E3JMP1MtlPem0R42BcZ
 zvnDq+u//FjFyR4lsoGenHuIIcmLPblVtfVgOBplLm6g483Aphd37A3381sTGPtJHxpX
 GwqQ==
X-Gm-Message-State: AOJu0YzwkgC7SCdxRTEaxFhkdw2UyBdBexgt2n7V3jTiscMYJ7EJ3kd+
 8JEoMwyc/uucODoCdta3IDv1C03DKn64RW8AAjA283jk24+6dFrgWJSaLLwQELF2a7zq6VExj8x
 BOrV4D/kkIvnOvpHwVwwIu1OVkNbwlNzc5O/LKfpNGVSUR/k=
X-Gm-Gg: ASbGncul+0QKGez96t1aXaVB3fg/usnz8dxlTCtYoRiuX93JVX7czGJkGqSc6cJ1i3J
 TnUJpJblcNaKwZydvkmVonOsFuEzHf2IZMsXbTxE=
X-Google-Smtp-Source: AGHT+IFLp5zevU2Kia9aY1M9kYTbnogrRqOuuzFqOzMH8Be2SKNOyH4xZyPf3QrNR2OdgrD/YlCO6gGOYT7ORGd0AwQ=
X-Received: by 2002:a17:907:7e9b:b0:aae:bd4c:2683 with SMTP id
 a640c23a62f3a-ab2abdbe9famr3414787066b.49.1736983287805; Wed, 15 Jan 2025
 15:21:27 -0800 (PST)
MIME-Version: 1.0
References: <20250109123010.4005298-1-sjg@chromium.org>
 <20250109123010.4005298-3-sjg@chromium.org>
 <20250111225433.GS3476@bill-the-cat>
 <CAFLszThO9BaSi8R8=3FpLq7Nnx7XdiCungY1vcRfKyfFQ0baJQ@mail.gmail.com>
 <20250113204419.GE3476@bill-the-cat>
 <CAFLszTjo1FcHL4G76u1tS3caEgdpk7FHdstoXe+AhERO8rJJfg@mail.gmail.com>
 <20250114012219.GF3476@bill-the-cat> <20250115144310.GY3476@bill-the-cat>
In-Reply-To: <20250115144310.GY3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Jan 2025 16:21:16 -0700
X-Gm-Features: AbW1kva3cvqU8z2gHYFmISwa9BKW8rIekro8CguFOuSf3TKfMM3ERL8BaYwv464
Message-ID: <CAFLszThBevXKpofrDheYNUzf51mnhL7GuBui5DZtfpTqsT+xCw@mail.gmail.com>
Subject: Re: [PATCH 02/15] vbe: Split out reading a FIT into a common file
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Wed, 15 Jan 2025 at 07:43, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jan 13, 2025 at 07:22:19PM -0600, Tom Rini wrote:
> > On Mon, Jan 13, 2025 at 05:13:46PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 13 Jan 2025 at 13:44, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Jan 13, 2025 at 01:03:52PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Sat, 11 Jan 2025 at 15:54, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Jan 09, 2025 at 05:29:57AM -0700, Simon Glass wrote:
> > > > > >
> > > > > > > Loading a FIT is useful for other VBE methods, such as ABrec. Create a
> > > > > > > new function to handling reading it.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > >
> > > > > > This causes a bunch of growth:
> > > > > >             a3y17lte       : all +1328 text +1328
> > > > > >                u-boot: add: 8/0, grow: 1/0 bytes: 1328/0 (1328)
> > > > > >                  function                                   old     new   delta
> > > > > >                  blkcache_fill                                -     332    +332
> > > > > >                  blkcache_read                                -     240    +240
> > > > > >                  blk_read                                     -     188    +188
> > > > > >                  vbe_read_nvdata                              -     156    +156
> > > > > >                  vbe_read_version                             -     140    +140
> > > > > >                  vbe_get_blk                                  -     100    +100
> > > > > >                  simple_read_nvdata                           -      96     +96
> > > > > >                  crc8                                         -      72     +72
> > > > > >                  vbe_simple_read_state                      108     112      +4
> > > > > >
> > > > > > Which is unexpected for just moving code around that's not newly used.
> > > > >
> > > > > I hadn't noticed that on the boards I was trying, so thank you for spotting it.
> > > > >
> > > > > This is because it now uses blk_read() instead of blk_dread(), so if
> > > >
> > > > That's not what this patch does? There's no caller before or after in
> > > > this patch of "blk_dread". Just moving functions around should not
> > > > increase size on platforms that weren't using the existing
> > > > functionality.
> > >
> > > Firstly, are we looking at the same patch? Here is the one I am looking at:
> > >
> > > https://patchwork.ozlabs.org/project/uboot/patch/20250109123010.4005298-2-sjg@chromium.org/
> >
> > You're right, I replied to the wrong patch here, sorry for the
> > confusion. I'll move some of my comments in reply to the correct patch
> > now.
> >
> > [snip]
> > > > > > And even when it's just a move it's still growing:
> > > > > >             xilinx_zynqmp_virt: all +128 bss -72 text +200
> > > > > >                u-boot: add: 4/0, grow: 0/-1 bytes: 540/-340 (200)
> > > > > >                  function                                   old     new   delta
> > > > > >                  vbe_read_nvdata                              -     156    +156
> > > > > >                  vbe_get_blk                                  -     148    +148
> > > > > >                  vbe_read_version                             -     140    +140
> > > > > >                  simple_read_nvdata                           -      96     +96
> > > > > >                  vbe_simple_read_state                      452     112    -340
> > > > >
> > > > > Unfortunately this one is hard to fix. As you know, whenever you take
> > > > > code from a single module and put it into another, the compiler cannot
> > > > > optimise away the function-call overhead. I'll note that there is no
> > > > > increase when LTO is used, e.g. with xilinx_versal_net_mini_qspi
> >
> > Yes, but 200 bytes isn't just function call overhead. Some of that might
> > be from going from one ALLOC_CACHE_ALIGN_BUFFER(u8, buf,
> > MMC_MAX_BLOCK_LEN) to two?
>
> This is the double buffer I was referring to.

OK, well that is just a declaration, so doesn't add any code, so far
as I understand it.

I ran out of time this morning, but did find that the compiler cannot
(of course) optimise the common range-checks when the code is in
different files. So I fiddled with removing some of them and that gets
the growth down, about 40 bytes on Thumb2 and 130 on aarch64, both
without LTO.

I'll send a new series out later today.

Regards,
Simon

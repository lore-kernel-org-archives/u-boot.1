Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B01DC001E0
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 05:35:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 968E78757A;
	Sat, 21 Oct 2023 07:35:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ns9GVU6W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EEBA87572; Sat, 21 Oct 2023 07:35:45 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AFB68753C
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 07:35:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5384975e34cso2266949a12.0
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 22:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697866541; x=1698471341; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lQZOngFMp3nCX/OheVdAm6Qa+ok0BbnsrM2pK5lmzr4=;
 b=Ns9GVU6WMKXDFtSexLcpU3y6sKlBwfvWXNqd1N+EN10rgpXh8Z7EPJviUGQMU5oUVR
 ZeF0wgPw32CnNFFvGyBuVIoOFne2TJJSSqnZt5EO/vUSpRj8js0J5yucbybu6qXPFNg6
 XPXyNLFk6UIKWwfI7E95Dlml5gl1r0D3OAEPW5aVmQwxVKpHVnDhHzMLLc5FaRDuosP9
 R7o9arD4WcwOfZRJl4aMuN4HA2dzwfcVV2uVx9hVvpjBsF9DLyCn+DT8Byu4glkLSgBB
 lJarh4ZWc22SDv8KN9ffxNdYFLyyWgLRlm7Eut3oLiKthKjhG9rnzDvXEMo40J8/PZER
 bhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866541; x=1698471341;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lQZOngFMp3nCX/OheVdAm6Qa+ok0BbnsrM2pK5lmzr4=;
 b=s9vePk81ECOWJQAiFpr0lEXFGLH3ecj+dwUrjfsHsspL+SlH52id+MssoipQtxMgFN
 zEXp4Uhngh6utk+TzJ06Qf+753v0WY3926UpXBUJ3YBBbdeZPga1zvNF3dkSQiPFs+P8
 oEdVPDRpLwf4hcGaH4UZzyW1DyOHy02PzAWlVSBGJIwmxxaw+DO01Mbyw5YA+62Wm76E
 6vtTMvarg4WwHUOpTXUaFRMIJ/2PeluIJyNDC87hZoQzbNesctHlMydYrmcBjP0U/3Rs
 KTMqFUAobv+ujyogBX8TfHJ8FR91akUqGFmXoHxXKsSBj34+3y1joJk6rKxS2XwcKhWA
 +1YQ==
X-Gm-Message-State: AOJu0YxqUj2q5wtLDayn8c4mulAf2mbV8tSxkz9MXQmzlhaN3HuvlFki
 pJAEPToXqHv0iiWnuA8JfjV3hBdomS4YwEQi1LY=
X-Google-Smtp-Source: AGHT+IFxQzLGwGlozYIVxKPAP6rNZLz5xkSQYec42JldFFrxG0mP231YO5WLNXiRgaIM6uFzayj+GkNhvFm/ZZbeLFs=
X-Received: by 2002:a50:d756:0:b0:53d:a1c0:410e with SMTP id
 i22-20020a50d756000000b0053da1c0410emr2434270edj.7.1697866541248; Fri, 20 Oct
 2023 22:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231018205358.1557234-1-judge.packham@gmail.com>
 <063a16d559dc9cb327c9459803005006@kernel.org>
In-Reply-To: <063a16d559dc9cb327c9459803005006@kernel.org>
From: Chris Packham <judge.packham@gmail.com>
Date: Sat, 21 Oct 2023 18:35:28 +1300
Message-ID: <CAFOYHZBcN2K2jNfs1S3xGKno4dqiJwMWyAeOUNPW5=o5+Oy3hQ@mail.gmail.com>
Subject: Re: [PATCH] arm: mvebu: AC5/AC5X: use fixed page table size
To: Marc Zyngier <maz@kernel.org>
Cc: u-boot <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Sat, 21 Oct 2023, 2:04 am Marc Zyngier, <maz@kernel.org> wrote:

> On 2023-10-18 21:53, Chris Packham wrote:
> > Since commit 6cdf6b7a340d ("arm64: Use FEAT_HAFDBS to track dirty pages
> > when available") the default get_page_table_size() sets some flags for
> > more efficient handling of dirty page table entries. This causes
> > problems on the AC5/AC5X SoC (specifically a lockup when calling
> > __asm_switch_ttbr() via mmu_set_region_dcache_behaviour()).
> >
> > The reason for the lockup isn't at all clear but it can be avoided if
> > we
> > provide our own get_page_table_size() which stops gd->arch.has_hafdbs
> > from being set to true effectively returning the AC5/AC5X to the older
> > behaviour. This also opts for a simple fixed page table size rather
> > than
> > trying to duplicate the more complicated logic to optimise the table
> > size.
> >
> > Signed-off-by: Chris Packham <judge.packham@gmail.com>
> > ---
> >
> >  arch/arm/mach-mvebu/alleycat5/cpu.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm/mach-mvebu/alleycat5/cpu.c
> > b/arch/arm/mach-mvebu/alleycat5/cpu.c
> > index 8204d9627515..7ba57ae75e76 100644
> > --- a/arch/arm/mach-mvebu/alleycat5/cpu.c
> > +++ b/arch/arm/mach-mvebu/alleycat5/cpu.c
> > @@ -63,6 +63,11 @@ static struct mm_region ac5_mem_map[] = {
> >
> >  struct mm_region *mem_map = ac5_mem_map;
> >
> > +u64 get_page_table_size(void)
> > +{
> > +     return 0x80000;
> > +}
> > +
> >  void reset_cpu(void)
> >  {
> >  }
>
> This looks terribly wrong. In all honesty, if the original
> patch creates problems and that people add this sort of stuff
> to paper over it, I'd rather your *revert* my patch altogether.
>

There are other platforms that define a get_page_table_size(). That may
mean that they are just inadvertently avoiding the issues I'm seeing.

I'm happy to prepare a series reverting the problematic changes. But I'm
sure that there's something about the AC5 that's the actual problem. I'm
just out of my depth in terms of my ability to progress it.


>          M.
> --
> Jazz is not dead. It just smells funny...
>

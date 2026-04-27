Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E143FF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 14:34:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D46C2842CE;
	Mon, 27 Apr 2026 16:34:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hV43+WdV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FF3D84236; Mon, 27 Apr 2026 16:34:06 +0200 (CEST)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50A5083AA9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 16:34:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6501c9903edso10360550d50.1
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 07:34:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777300441; cv=none;
 d=google.com; s=arc-20240605;
 b=HSH4fuxylAWjJQtMCfSQM7cF68LTpL70czMacfwg1+aRiBO+LolTYTTm5MLL0H4N+O
 gqcaIgVbny9QXHJK0Q72eFgqRINCLk+CDfZxTtSOyNXMp/33sh2eUX5nyCpp5VTdbSkM
 xd4pNF1Mw3/AsbbImXYD3cDutfM/rBBjn5+4ua06RMmmAdz9GJJWadzf3bzrL/9CCDBN
 HkZu5JyAvPyLot4Pj0ykFkrfP8UX2/nDC3u0DPnmaFts2uCG0QVYKyy87+DSwuqxT/bI
 pe65pACiGhuFlFVWyOc+VN3QvHT2DdnBlMXMlYaKHm/DKsWM+2Rw9JYZtJnms6w7HQia
 1VnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jO5BJXLrHnkiJKFgInKVOzitfOdAl2/PESg6lb/SYzE=;
 fh=79zPDB0AQdQQBjoRQO7FzQi1m5JZhlNZQGy+IMZ4jqU=;
 b=AXCLnHnA+A2iKikX6U6llugT4yC+noEDrVRHAsMyePkh9HbDm5Orpqig446ZNr6qr8
 jXKEIQyj4lPS+guxoLDkB/Af6pvJ6tNLGYdIEIsEvmmkevpU4R7y1k5Kxg0jjz7ZPjtx
 wFX9DSfhuOzOfBKLCNYKrBV3YxmgEyOY8ieGETk5qVxAF6PM1F7HlU/LGOEQpaqSRWeL
 qlTcNyUVTMhE8gMuufU9jeQJfJfCF0u7ZFy2QPPBfh99B7z9X9AnOD6Jd2uCtZclfE+c
 apPtFF4sGlOSsmHfIp341+5EHM6PH/PyH3HqIOSugQ/+L9b6zxA5KBBL+dWdlDojZD1X
 4A7A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777300441; x=1777905241; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jO5BJXLrHnkiJKFgInKVOzitfOdAl2/PESg6lb/SYzE=;
 b=hV43+WdV2DkvLlZPY4WELU+KQoJSRRkHX6u2cmlGHeBOCU3Eo3+VDtUN5pmavNprW3
 5GzLv4C1M9X2X0kOlniOW35MxgnQBEzoJyU+0ppQvaEly75DrhrzCkZnT3ujrSzLcgwz
 L22zG/dAlj17ZXeCZgLpWfx4G2Mv8oLXrPWmIgWP3ELwZ7oOU4pYOXwA+6IbmGSyYtjv
 V9/zX8nBBO1aEEDtoRk9q3OC3lba562XsqjKSoP43khj7UU3EqFcLXiweecHzOSXIK+7
 vBIyASpyY/2WOhNXTSTCOL0Q5TwoIc1ukQjZsE8gCnmdWS88uL4mJtYgfwiVry2DI/yV
 iSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777300441; x=1777905241;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jO5BJXLrHnkiJKFgInKVOzitfOdAl2/PESg6lb/SYzE=;
 b=RFXF+ZBgy6GhFCEs5g7AgyamRVqA3FCzQ623ISf8idsOS9ItYB2zJmayBywpYWBkwy
 dOMOex+00r0T0vm8iHrIyOCYJNn+fQufjybpEEi3GBQ9kubkMd8CAGEF3J0mEo7rdO0q
 TeypCAqGufv4R6dH1mVKD11ZilGwYD8GG8W4hqIKv5sxKiU2zoof2T/wCKu07wng8zqQ
 QgsMPZ0zprBALVe5QzbGM1NmsLy9x/arQtz8N//S57dS8N1V+UuMT1IY9vJ++y/xb6Xy
 uMMAi9337nSabioQV+DDn4IaV6Mq4x5qV8bqzDnVNwuuKEcubvqZhmTGF8aaUUawoHBg
 yE2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/iANEsF4ImPrR3A8z/gKVr8cdxhGZwbKEQPWzlHy/iPuZshLhkKBhyLpL9S7/szEh6c0y1Mk8=@lists.denx.de
X-Gm-Message-State: AOJu0YyJpl1mpACrV9GGjtXCf3Ps0B+mgSt0LWeIPqhWUf/egd8nJhNV
 l/AwbTjNGN8+ytY/Y6VDI9FRU/GHD/pBb4l9BW/j9H7f2g5qsLu8MDHAz7iLeU0wvnFHaDN050X
 J+tyMpiKyhGCSmlWpXv2Li5A/BR4j4wTM5aPvsUdnYQ==
X-Gm-Gg: AeBDiesweicQRwbV0ubhCuL1T3xZQYV4Xuz5f+4/GF8o38I/cvkoWauF4DTf303jyqM
 sc/ZVVA4niN35FcwQV17B14XzGoAIZn6qkv/wh9Xb4rQmnJpwfylDLnpGyMK3jdl0N2/kPHj5oY
 nxbeoQD+z+KKC+X9Sh1GaB6Uk5qoGtf3Vs+6Hex59L5AMVWajivKIJ7n3p/CAW4ZXMGyQiELops
 vQHyKrGPAo5EL6F99eMtrPPsw9C2+466z7d0gl1rQCwRP5tT8ElAktke7SpjwcbvAOasUcmZOTx
 j5rTmpf+svE1Yg/uwdRLNl5pDdtNbIeka5PRmo8oNWYYu7219KN6GNzncw+KXusZS/DsaMpinA8
 VFfsy5GIUVYO2w2fsL/Bsu6PnTxmIgE3OD3q3SnRVoqYvDmmlfkRy9QCueaoP8s2fdvoaqzXSIY
 ldOd3p7vWgVJCKRPcoevFd1h38V2m6HUJ/w2lbOiNleyeSyDytSniowXbdUJzEDwVLISSCnct+Z
 ZF3gObeG4k03xjtx2qbMLFBppBSDDnG5IbR8PSxy1rKZ5I2+EHbKKFgokfcCqwuROjHxySoFzf3
 YaIsZ8hohpe9j/E0AuGJtpdIJvOHn1fM8X1e7X7ZyIVGsIh4UdpzKGk0MkFtSUQQMSWXT9ufRpw
 L50EKgVMwuUibzMDH
X-Received: by 2002:a05:690e:124a:b0:650:3064:4cf2 with SMTP id
 956f58d0204a3-653107edd2fmr39788415d50.5.1777300440444; Mon, 27 Apr 2026
 07:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260416055948.130041-1-ilias.apalodimas@linaro.org>
 <20260416055948.130041-7-ilias.apalodimas@linaro.org>
 <6944f28f-131f-4a08-9ef9-aae812926f4b@mailbox.org>
 <CAC_iWj+ufWdroVDCh9qNAYfsjON5r_pdfOUgyB=h=b2b_rMVKg@mail.gmail.com>
 <8b87df2b-1904-4f2c-862d-924daff649e6@mailbox.org>
In-Reply-To: <8b87df2b-1904-4f2c-862d-924daff649e6@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 27 Apr 2026 17:33:24 +0300
X-Gm-Features: AQROBzB1cYw2maTU1cmmP0b0qfSXXI7IYe36N5OoXplNm5i9O0SkeuOZrNSrJEQ
Message-ID: <CAC_iWj+1PNaGjX5DH3hA4iednKruydKjy-0YoXuWTCJHmPVCDA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] common: Add an option to relocate on ram top
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 anshuld@ti.com, sjg@chromium.org, u-boot@lists.denx.de
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

On Mon, 27 Apr 2026 at 14:27, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 4/27/26 8:20 AM, Ilias Apalodimas wrote:
> > Hi Marek,
> >
> > On Sun, 26 Apr 2026 at 19:35, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >>
> >> On 4/16/26 7:59 AM, Ilias Apalodimas wrote:
> >>> Right now we only relocate u-boot to the top of the first
> >>> memory bank unless the board specific code overwrites it.
> >>> This is problematic when loading big binaries as it
> >>> fragments the contiguous memory space for no apparent reason.
> >>>
> >>> It's worth noting that there are cases where we must not relocate
> >>> above the 4GiB boundary (64bit hardware with 32bit only capable
> >>> DMA). E.g This will break platforms, if the ethernet
> >>> controller cannot DMA above 4 GiB, and once U-Boot does
> >>> get relocated above 4 GiB, the packet buffer which is built
> >>> into the U-Boot binary is also relocated above 4 GiB.
> >>
> >> On certain platforms, it is currently not possible to relocate U-Boot
> >> above the 32bit boundary, due to various dependencies on content located
> >> below the 32bit boundary. One such example is ethernet, where the packet
> >> buffer built into U-Boot binary is placed below the 32bit boundary and
> >> allows loading of data via ethernet even above 32bit boundary due to
> >> memory copy from the packet buffer to the destination location.
> >>
> >>> A previous patch moves the bi_dram[] info from bd to gd and make
> >>> the memory bank information available early. So move the
> >>> dram_init_banksize() INITCALL before the relocation address calculation
> >>> and use it to derive the address.
> >>>
> >>> Also add a Kconfig option and allow the common code to relocate U-Boot
> >>> to the top of the last discovered bank.
> >>>
> >
> > [...]
> >
> >>
> >>> +
> >>>    endif # EXPERT
> >>>
> >>>    config PHYS_64BIT
> >>> diff --git a/common/board_f.c b/common/board_f.c
> >>> index 4ac22dca9e7c..f95e789257ad 100644
> >>> --- a/common/board_f.c
> >>> +++ b/common/board_f.c
> >>> @@ -339,7 +339,22 @@ static int setup_ram_base(void)
> >>>    static int setup_ram_config(void)
> >>>    {
> >>>        debug("Monitor len: %08x\n", gd->mon_len);
> >>> -#if CONFIG_VAL(SYS_MEM_TOP_HIDE)
> >>> +
> >>> +     if (CONFIG_IS_ENABLED(RELOC_ADDR_TOP)) {
> >>> +             int bank;
> >>> +             phys_size_t total_size = 0;
> >>> +
> >>> +             for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> >>> +                     if (gd->ram_top <= gd->bi_dram[bank].start)
> >>> +                             gd->ram_top = gd->bi_dram[bank].start +
> >>> +                                             gd->bi_dram[bank].size;
> >>> +                     total_size += gd->bi_dram[bank].size;
> >>> +             }
> >>> +             gd->ram_size = total_size;
> >>
> >> Shouldn't this also apply board_get_usable_ram_top() to be consistent ?
> >
> > Simon asked the same thing. I'd rather keep this option strict for now
> > and always relocate to the upper memory boundary fnor now. Once I do
> > further cleanups, I can either add it or remove the function entirely
> > since dram_init_banksize() (which hs also board specific) runs really
> > early now.
>
> Maybe the default board_get_usable_ram_top() can return the ram top if
> CONFIG_IS_ENABLED(RELOC_ADDR_TOP) ? That would still allow users to use
> board_get_usable_ram_top() consistently to reduce the ram top.

dram_init_banksize() can be used instead now to reduce that and we can
remove this option eventually. Is there anything that we can't achieve
with only that ?

Cheers
/Ilias
>
> >>> +     } else {
> >>> +             gd->ram_top = gd->ram_base + get_effective_memsize();
> >>> +             gd->ram_top = board_get_usable_ram_top(gd->mon_len);
> >>
> >> Should this really use gd->mon_len as a parameter, or gd->ram_top?
> >
> > I haven't really thought about thism since it's what we currently do.
> > In any case that's a change that needs to go on another patch.
> Indeed.

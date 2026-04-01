Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457C8D35164
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 09:36:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC11C840AA;
	Wed,  1 Apr 2026 11:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ix8yALMN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0935B84099; Wed,  1 Apr 2026 11:36:18 +0200 (CEST)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97B398408D
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 11:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-65003f40a22so8470419d50.2
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 02:36:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775036173; cv=none;
 d=google.com; s=arc-20240605;
 b=huQZrfv+2pNmTHNaGOl6+Ip0n5+N/WUX2+lnoHNe2FGUVv3BXYJXHhTCxq7f8dxs7X
 0Y2bhU5vSiZyJzSVoe+v+n2kc84AexyNvPavzks3d3CIb3saOtQevI6+jMw1PhnOGikt
 HdH09ufZ0EgGsI6Qy4l8LZvkWoVHvC8rsFFALl1WD3XrWaFDS59tvvvR7pvwHCBVZiig
 RrahxF2RxTFGnbpb8Xxa3T7O9J+FNh+QybntmDk4whAbm3g3J9hJki9Bp8TBM8PJTvee
 MqBL5jdqFPwicq0v7OFQENF3V8fwAKe4OzT2otYQ6w8NiSK2fD5y+TuRW7UhI0gF16fH
 rW/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hUMNcU84DASKyk28cGEFbV6fDTTbdkol9+H9MxBel/Q=;
 fh=a7F6x3NQQp1EBjxPbpSwxRS/z/1eCH1canUoq2zE9lQ=;
 b=VMmbA+1CxVN2J8XTMtCypzdmx/807OeugKRrXFCyXhejZDZUOVarHasEb1qvR+/tiY
 bnAk7H7Y/BYJ2pvrBLb8jKHUK9sefRXLk9rL42vRMmQoArB1YsIDPZHpxkvgN1VM61p3
 ixGDk4oGF387QONosuzFIjfS4D8bKNxMdYoPeit2K/E3wfjXy6DwhoFg8ewgYl/keTiK
 NzB1jSKRHwmAU+1cfeO7oqvx6aj8w9gSfPxOUDZx3kclifiev/oOTCf0V3MF+oK2pCvg
 lGu6POcjLh7qON5r2cUZry4tlEfurLemg1c1afGWPbNp2UGDTKP10Kq5FHeSj12YsnfW
 m9lA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775036173; x=1775640973; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hUMNcU84DASKyk28cGEFbV6fDTTbdkol9+H9MxBel/Q=;
 b=ix8yALMNI0NDNMV8QXA2qbmZ/txyYs+yEZdKz35w1lEwsPuPJjGSdUKSTabKurVKUh
 6A06krJoDpWgVFtF1vZH4RM6Ai5u3Hf3R6mvtgdMdJnh7bZXXYBsBj7nO+IOa53j/+jM
 LCnbtPyJvoYnByOezkxlKa8coJm40hlv14/76FJyQj5J6Q7da3MnZTxyF5EgVcUavdqL
 7msXqyMY4exbCIhDgWsFxx+fHZPAgGbuJVJPBGyxdLRquO03/D8JrYtlmx2sjVY8INuM
 8m3aK4BgAf07dFRZZs8hxvPIzqPnNxMuNLDap/PQZVlE5M/bR1fFhdJKhbnAYvBq6eKA
 Yx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775036173; x=1775640973;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hUMNcU84DASKyk28cGEFbV6fDTTbdkol9+H9MxBel/Q=;
 b=Mtu6/OkvNNMxtV5A4WkVIEG2fROkxMRmG8s97MX1YRWNOD1PmfyLUNTdXr4W8BoYvQ
 gom3PhpMU8RxVY9Uy3U6zTiV/HO/gyKjrAQfYJqs1Pdl7smdebZYRC9Txjlsx9ND5n2s
 CMqAEpG12J5ShTe2PHzcC7Fzrc1/EI4q2Y77dK2zcSveKPa/FkDBGsMjSX/OIANZO8OX
 Y7vSV7MNFH/6SZZY20++q7JDWzOIGuhl53/FDUFTsQ2yiLjb3SixmO0WQ/hdwmpXHsOI
 whXG6MX+TSvRkDUPpk3MRoh++zjZC6h60Ljm2YfTEWyp0iSkT6sSPwlTMXTI7j4KlpQe
 hqrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiRi/+HOC3kyD9dRVthtTTatanWfTH2/hGbrUBiqSFGPSt+GFaVaOdT6x86wllX6VBwpXTaXk=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7x7vKakIp5oIlynq9JZ6cJ8Rbxa/mcu/1YJuf2JLYr0N21gsU
 uhSIs+M8JWH9zrMP4E+00bFcNvsw2eKyP1TVIwBscHtb+mAvcygxmodW7B9iMwijqFkEo8RtY5l
 0x3ubiD+K67bUCnDETn87ODDl0iX52Tu9/6t/RTRwAKbzjaCa8A8K+ko=
X-Gm-Gg: ATEYQzzUEO5ThaUA2OsrAW3/5tPb9FMthomGIg81qTZ1rDPe554nWX9ffSsoDEXtzjK
 l8r7xN2Ur3lnd5BvSzU9xTySPKvb8eQsd/nAbjka3EGB4luooHAcN6XdGONq/HM/Z3OVnfE/7HP
 j4sYustO/LN6Wx2F/Ll0JR/JXwdzqPJkwjtzLmaAJW0o0hNWReZVyzGIqQ4DAu8V29euGiu4HlP
 IBXghftNZUhXOv3X89bWb3Aavd6DSHoGL5L3RSd+KVNKw7Jyr6+PwgMkvlv3SPs18M7WFyowcPd
 p1XoClvDcVmMYHlOPTzLk5wYi7VoGe07Yj6jGIj8Kybwg8QRXIks4/dKp7SqtSj4Hdi2E5CaRR5
 psJrjM9iYa5kr9A+O2umHQEmcbdoIQMfs17FdkVh7r8oqGg4e/GyJ9tdbASfqBwwW4GGzVDkgCw
 ueU5s70PnSTjo619sV6Dceab0i2tgXP4azX39Edh43dD7BrdwfQfT4hRvO4fuoy4EusfGeOZJUl
 t0a8f9RUgGgibOLp30KlI2GGg35Gt4IG/EYHCfa5RBMjXUaEvjKoeAfJutIDcO03S3m55V/zxYL
 tEH6KWZQXJLnEAAwzPKSQeu0qRFXCca8lkIyfw18ggFa
X-Received: by 2002:a05:690e:190d:b0:650:3783:4acd with SMTP id
 956f58d0204a3-65037834da1mr334409d50.38.1775036173252; Wed, 01 Apr 2026
 02:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
 <20260331080117.2370092-5-ilias.apalodimas@linaro.org>
 <564fc8c9-90de-43ed-a312-5a92b16078df@kwiboo.se>
 <CAC_iWjKRrL8CtU5Fu-ZM=Yg8XQztfC8e6TAoCY_SGX_Ds8xHCg@mail.gmail.com>
 <3ed2db2d-bdbe-4ef2-980c-372a3e88fb31@kwiboo.se>
 <CAC_iWjKXWx4QYAQm_vub5wHv92S_-SC2UepX4x9PP0SmG_t8RQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKXWx4QYAQm_vub5wHv92S_-SC2UepX4x9PP0SmG_t8RQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 1 Apr 2026 12:35:36 +0300
X-Gm-Features: AQROBzDgC52qO51cVuigBuohIfcAoZ-KXC2J-UxUh1G1phZ0b8ropiYCPZR0blU
Message-ID: <CAC_iWjKu-OeiweerDkwpUKE=cs917twDSoTuJvRS=94TpbfHWw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] common: Allow relocations on the top of the last
 bank
To: Jonas Karlman <jonas@kwiboo.se>
Cc: marek.vasut+renesas@mailbox.org, trini@konsulko.com, u-boot@lists.denx.de
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

Replying to myself here but,

On Wed, 1 Apr 2026 at 12:21, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Wed, 1 Apr 2026 at 11:54, Jonas Karlman <jonas@kwiboo.se> wrote:
> >
> > On 4/1/2026 10:31 AM, Ilias Apalodimas wrote:
> > > Hi Jonas
> > >
> > > [...]
> > >
> > >>>  #if defined(CFG_SYS_SDRAM_BASE) && CFG_SYS_SDRAM_BASE > 0
> > >>>       /*
> > >>>        * Detect whether we have so much RAM that it goes past the end of our
> > >>> @@ -321,6 +323,19 @@ __weak phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> > >>>                */
> > >>>               return 0;
> > >>>  #endif
> > >>> +     if (IS_ENABLED(CONFIG_RELOCATE_LAST_BANK)) {
> > >>> +             phys_addr_t old_top = gd->ram_top;
> > >>> +
> > >>> +             ret = fdtdec_setup_mem_ram_top();
> > >>
> > >> This seem to make assumption that memory is already fully described in
> > >> FDT? Maybe this should instead be based on gd->bd->bi_dram, however that
> > >> is possible initialized at a later initcall.
> > >
> > > It is. That was my first approach in fixing it, but the
> > > gd->bd->bi_dram contained garbage at that point.
> > >
> > >>
> > >> If I got the call chain correct board_get_usable_ram_top() is normally
> > >> called from INITCALL(setup_dest_addr), and gd->bd->bi_dram banks are
> > >> typically initialized in INITCALL(dram_init_banksize), a later initcall.
> > >
> > > Yes
> > >
> > >>
> > >> On e.g. Rockchip there is no memory bank information in FDT at that
> > >> stage and memory banks is populated to gd->bd->bi_dram based on
> > >> information from dram init and only later possible added to the FDT for
> > >> booting OS.
> > >
> > > And that happens after u-boot has relocated or before?
> >
> > gd->bd->bi_dram is populated during dram_init_banksize() so I think it
> > should be almost just before u-boot is relocated.
>
> Ok I'll check that on QEMU. If that's true I think this is a better
> approach overall. We can skip all the DT parsing and if the iformation
> is  filled up before the reloc we can use that to decide on the top
> reloc address. Which will also be useful in getting rid of bespoke
> board ram init functions, like the one you have in rockpi.

So the calculations for ram_top are done ad-hoc in setup_dest_addr().
The dram_init_banksize() gets called afterwards, but before the time
we relocate. So I think I'll completely change the direction of this
patchset.

We can still apply #1 & #2 from Marek, since it's a cleanup. We can
then add another INITCALL if the CONFIG_RELOCATE_LAST_BANK is enabled
and calculate a new ram_top and and ram_size based on the discovered
bank info. That will obviously disregard board_get_usable_ram_top()
and will be generic for any board that selects it. But I think that's
a convenient side effect, since we can start enabling it on boards,
and if it works get rid of the board specific variants.

Thoughts?
>
> >
> > I am not sure when or how, but the OS knows about the bank information
> > populated to bi_dram, not sure if some fdt fixup is happening just
> > before jumping to OS.
>
> Depends on how you boot. In the EFI world we add all the memory in the
> memmap, but marked the regions above ram_top as reserved (but
> reclaimable).
> The OS then boots and can use the entire defined DRAM.
>
> >
> > On Rockchip we keep gd->ram_top below 4 GiB to work around any >32-bit
> > DMA issues, however we do populate ram_size and bi_dram with correct
> > info gathered during the initial dram init (U-Boot TPL or external TPL).
>
> Yea, that's the next problem to fix. We already had a discussion with
> Marek on how to fix this.
>
> Thanks
> /Ilias
> >
> > Regards,
> > Jonas
> >
> > >
> > >>
> > >> Rockchip does have a platform board_get_usable_ram_top() so this will
> > >> not be an issue, but the new generic Kconfig option added here seem to
> > >> have a dependency on FDT containing memory bank information, if I am not
> > >> mistaken. Maybe something worth mentioning in help and commit message?
> > >
> > > I can amend the Kconfig option. However, people using that default
> > > function are already aware of this.
> > >
> > > Thanks
> > > /Ilias
> > >>
> > >> Regards,
> > >> Jonas
> > >>
> > >>> +             if (ret)
> > >>> +                     debug("failed to relocate to ram top");
> > >>> +             ret = fdtdec_setup_ram_size();
> > >>> +             if (ret) {
> > >>> +                     debug("failed to calculate RAM size");
> > >>> +                     gd->ram_top = old_top;
> > >>> +             }
> > >>> +     }
> > >>> +
> > >>>       return gd->ram_top;
> > >>>  }
> > >>>
> > >>
> >

Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B616DC5AC67
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 13:52:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D1666065E;
	Sat,  8 Aug 2026 13:52:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SEZ8Rgce1K3v; Sat,  8 Aug 2026 13:52:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 43BD160672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786197138;
	bh=s1mSUjnq5VugT2mqpOd6nxhfwqf75MBIQYlVOKlb9zw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ngOQ4ns16TsItimRolXRyXHywk6HK4hsvqR5+33GKQtTwe0zEX3snHXOJ+Z77HnZ5
	 tNPyl3pRLgJUDBkbiMKH/RHgMxYd3BvNey8K9Ys/amZomWW2lcfVFhJ/Hg5RLuUwjK
	 gQ7e4EUUETHO264xZUJtHfAGoE6yIHC//xoNEJnsPIGmOx2XwdlXkYME+sE5lrNpgL
	 EUIP2DXX5xVO+/pf5O6Ss42JR3lzwrbi30h2ng+mTbco2ngWdJO6DV1y1VDvo0EIHn
	 oeQscnt2cuxo/pkM2oZB8iQuX4CZ5qhfmIs7Q9zXPafSjEeh8RqGgsfuz1Rt108hRe
	 qaaDolEcLgdrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43BD160672;
	Sat,  8 Aug 2026 13:52:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 46D5D1AF
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:52:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 448F0400A9
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:52:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l7xoz2ddfMH8 for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 13:52:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 07EE64004B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 07EE64004B
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 07EE64004B
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:52:14 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a28cbdso664062a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 06:52:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786197133; cv=none;
 d=google.com; s=arc-20260327;
 b=iIa2lYhAdpMczC8l1NH2f2M7riqlpfZkhjTVy77z1GQtEpgHTxLRKfQRyzDMCAfDFa
 5snJvhbkJXfaZxUdTI1y3EAx4dGCblSIy9KzbmvxSccK06iQNDcx0Yof+WAUwY3DWZUg
 EfAIiqxZovbVGuDCixJAjmvhv/pOPWbP/RApIxbklvUZgTE9jgUlDYo1HimCqjtAOsxV
 xNwNIDR0A6hw1iF7D+I0S5T3D5cZmVBVM/c4Dan1pA+OpJYfAqHAldrVEFIMs6aPPVYV
 u6hhDuMMnaLE1Fvqeq6b4D9JG4Y2sv9IVmvWa8bizPSLbH22hC4VzxLfhQxAK4vxza4w
 Wa4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=s1mSUjnq5VugT2mqpOd6nxhfwqf75MBIQYlVOKlb9zw=;
 fh=IhWzch3iJ+cTuRPhiV5NH5m85VI59vemP1y4PijfKg4=;
 b=Ksi5WMcOBklk5jX6o+3v1ReTWnbOfgbMQA7BuBpF2oCCIbGkm6SV/8rNyOg9tcW/0D
 SzVSBI9ArE8YoRtC+oD2Y19n2l3765O3vHfEdMLAyFSOexK8RowTmtO5Prz/b8jvnaqp
 MWMHC5rnGkcfqemen4t1UaqmMgW/P4u6lU5Euc8vz317VOVs04/MxbEachSRnkfnE4AU
 8vjHGGPh+TqnZDnpTnoAJAXBSycnGbG6uvSlY/hZLqOxa+QP6VdT36e4hUtutCpK39T9
 7AaJ4LpFHJRakXocEhL72JCG/3CovFzXC4V0UXl23mOuTKnO6kx90x2qVG/tqIG+e4Dk
 msOw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786197133; x=1786801933;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=s1mSUjnq5VugT2mqpOd6nxhfwqf75MBIQYlVOKlb9zw=;
 b=BSefdDapG4cydb4AudJNsYacLF9Gnem3HwumDOrLHWO06TmGGQ9uQm9jFwOe3Ir2QG
 QrFc65VPi5VAHfVzv+Mv3p7PGrznrrfr/x7YHg65fskkWl05o2I9msDYyil/z19nrTP9
 Up3bGH17jaUTXVoVJujJrukGUQktC3ue1j+e+SjR9W00wdVdVh0mtR3csPK/mHevWC1S
 xHGU5hicMo123kyli8rkDKk2Y9YfShcNS72OQlFWqWSHYkzkIIFFtIJo/E3k6ainlxyt
 vwKmGnWipVi8z64QK35ALIfsw47R1wQciP3ctUKqMdvSX4CynwMQEDI8+x7w+/Dvjw1k
 w78w==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+7RuQLVOQLqZI7odHftyhLC9DJMXKj/FxApNgynccRa60iwSHBjh+WU0/nJz7TAPYNHp0WHM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Ywghe1rV3xwzT2E69VY47dMb0wjtYmSQC5y+vMq5JUJGqpps0XN
 bA91Qdgpc/7lAJMhS/NgLRccH5V85IvPWnQWHUkmrkXIpcKlEW8iMHdzg+54b34O9wtjpVtuXiE
 km9b0p9LowIK6HoCVPj9tBbzvs4wXhiZ/HhucPzZC
X-Gm-Gg: AR+sD12WgGhLan5ZjwV5S/iQemw6UL2Nn3yFq8f7bBZMOowI9L6cyBLPJ/g56MyAAm8
 9h8uQlgbXFEHLq4U3xSFczQbFh85EWaM3Y4ylMrL+NShp/NS4T0QS2kKNhIIVkWQljCqd7HMomy
 0SiA2oyWISQFxu+7P7UxdMDZ8lxugnj8t1suXtje0CcCEVAwnRo9+bNjOvMVFN9Le15S8ccLF0R
 f/pas54NA+Hyx8PnRJe+00R6ANkFbU6bEUtDudMZYZ6HFuwXTZ25aYZma16vT9nGVNB2JY7QCjG
 WaBxPQn3jSMFQyMVLOSQeurFSaEmapxAVHRMt46tPT8=
X-Received: by 2002:a05:6402:4487:b0:698:3602:d0d with SMTP id
 4fb4d7f45d1cf-6a1f249e06bmr3873925a12.17.1786197132970; Sat, 08 Aug 2026
 06:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260807090431.464978-1-jonas@kwiboo.se>
 <CAFLszThA3502QnQxSGyQL+WPEz3tovqE8VA7512gjVKUPSBMEg@mail.gmail.com>
 <a1436f49-823c-4708-b640-92c67fc6362d@kwiboo.se>
 <CAFLszTgso=ayEMwx+cF9FDPis1VmO4yQYH+3qoxWbah_GSnfug@mail.gmail.com>
 <da12d1c4-d3bb-4b11-82c9-1210ee1ac97f@kwiboo.se>
In-Reply-To: <da12d1c4-d3bb-4b11-82c9-1210ee1ac97f@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 07:52:01 -0600
X-Gm-Features: AUfX_mxRUEMwHDsolnKxAsCx9BDWmgHmmNlmAQWLNXNOYosnUTy327fWm5LKxys
Message-ID: <CAFLszTiLeLB-OB_2oXZFNV2Qe+O1LV9PLBjXrtGNNQGg=jsL+A@mail.gmail.com>
Subject: Re: [PATCH] rockchip: px30: Fix TPL_STACK overflow into BootROM
 reserved region
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786197133; x=1786801933;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s1mSUjnq5VugT2mqpOd6nxhfwqf75MBIQYlVOKlb9zw=;
 b=A1MzXFuTH29CtzcVmg8xeTVQW6GSHuQ0WaLq61TqPYAF1NomNEeVUSlPo14qntpSGo
 c9CuNXNKcJbMn+4XO9HLGgj/tUlVA84b1eFmyd7QlEJRjJJVa0RJ0J4YGejWK1KQiHog
 9wyW3BGuZnP2XSDsok+4xZU1EzBjd33cfrbjg=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=A1MzXFuT
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On Fri, 7 Aug 2026 at 17:06, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 8/8/2026 12:00 AM, Simon Glass wrote:
> > Hi Jonas,
> >
> > On Fri, 7 Aug 2026 at 15:41, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 8/7/2026 10:40 PM, Simon Glass wrote:
> >>> Hi Jonas,
> >>>
> >>> On 2026-08-07T09:04:31, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>>> rockchip: px30: Fix TPL_STACK overflow into BootROM reserved region
> >>>>
> >>>> The PX30/RK3326 has 16 KiB SRAM at [0xff0e0000, 0xff0e4000), with the
> >>>> initial 4 KiB at [0xff0e0000, 0xff0e1000) reserved for BootROM at boot.
> >>>>
> >>>> SRAM addressing only seem to use 14 bits, meaning that reading from
> >>>> 0xff0e4000+ wraps around and instad reads back data at 0xff0e0000+.
> >>>
> >>> Typos: 'seem' -> 'seems', 'instad' -> 'instead' and 'possible looks'
> >>> below -> 'possibly looks'.
> >>
> >> Thanks, will update in a v2.
> >>
> >>>
> >>>>
> >>>> Using a TPL_STACK at 0xff0e4ff0 (16-bytes aligned) means TPL use BootROM
> >>>> reserved region for its global data, malloc area and runtime stack.
> >>>>
> >>>> TPL on PX30/RK3326 does not have any use for the malloc area and the
> >>>> generated GD_SIZE is typically around 304 bytes.
> >>>>
> >>>> Current memory layout possible looks something like:
> >>>>
> >>>>   [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
> >>>>     [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
> >>>>       [0xff0e09f0, 0xff0e0ff0)    1536 bytes  malloc area (unused)
> >>>>       [0xff0e08c0, 0xff0e09f0)     304 bytes  global data
> >>>> [...]
> >>>>
> >>>> arch/arm/mach-rockchip/px30/Kconfig | 4 ++--
> >>>>  common/spl/Kconfig.tpl              | 2 +-
> >>>>  tools/rkcommon.c                    | 2 +-
> >>>>  3 files changed, 4 insertions(+), 4 deletions(-)
> >>>
> >>>> diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
> >>>> @@ -129,7 +129,7 @@ config TPL_MAX_SIZE
> >>>> -     default 0x2800 if ROCKCHIP_PX30
> >>>> +     default 0x2c00 if ROCKCHIP_PX30
> >>>
> >>> Just to check, the layout shows [0xff0e3c00, 0xff0e3ed0) as pure
> >>> stack, but BSS (e.g. dram_info in sdram_px30.c) sits after
> >>> __image_copy_end and is not counted by the TPL_MAX_SIZE assert in
> >>> u-boot-tpl-v8.lds, so with an image close to 11 KiB the real stack
> >>> headroom is a bit less than 720 bytes.
> >>
> >> You are correct, current BSS is 72 bytes, will update the commit message
> >> to mention that the 720 bytes must fit both BSS and the stack in a v2.
> >>
> >> What is interesting is that global data is so large, especially when in
> >> this case nothing here is really using global data. We could save 16
> >> bytes by fully disable CONFIG_TPL_SYS_MALLOC_F, but that was too
> >> intrusive to be part of this fix.
> >
> > Well we have DRAM in there now. Actually now that Ilas' series is in,
> > we could take a look at trimming and aligning things - some things are
> > long which could be int, which matters on arm64.
>
> The px30/rk3326 boards do use CONFIG_NR_DRAM_BANKS=1 or 2, so dram
> should at least be limited somewhat.
>
> I think there are some DM related fields that could be excluded to save
> little bit more space. With below diff the GD_SIZE is down to 240 bytes,
> 16 for TPL_SYS_MALLOC_F and remaining 48 due to the DM related fields.
> Not sure this is safe, but the odroid-go2_defconfig could be built.
>
> I do not think the global data size is really a big issue for this
> board, but rk3036 only have 4 KiB that need to fit SPL (2716b),
> BSS (0b), global data (160b) and stack. SPL image is down to 2716 bytes
> after upcoming TPL refactoring at [1] (tpl branch).
>
> diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
> index dfdea66cd70c..c5fd6514010c 100644
> --- a/configs/odroid-go2_defconfig
> +++ b/configs/odroid-go2_defconfig
> @@ -118,3 +118,4 @@ CONFIG_USB_FUNCTION_ROCKUSB=y
>  CONFIG_TPL_TINY_MEMSET=y
>  CONFIG_LZO=y
>  CONFIG_ERRNO_STR=y
> +# CONFIG_TPL_SYS_MALLOC_F is not set
> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
> index fd116b0cebf2..886c12900ddb 100644
> --- a/include/asm-generic/global_data.h
> +++ b/include/asm-generic/global_data.h
> @@ -174,10 +174,12 @@ struct global_data {
>          * @arch: architecture-specific data
>          */
>         struct arch_global_data arch;
> +#if CONFIG_IS_ENABLED(DM)
>         /**
>          * @dmtag_list: List of DM tags
>          */
>         struct list_head dmtag_list;
> +#endif
>         /**
>          * @timebase_h: high 32 bits of timer
>          */
> @@ -228,7 +230,7 @@ struct global_data {
>          */
>         long precon_buf_idx;
>  #endif
> -#ifdef CONFIG_DM
> +#if CONFIG_IS_ENABLED(DM)
>         /**
>          * @dm_root: root instance for Driver Model
>          */

Yes please, that's a huge improvement!

>
> [1] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/commit/8c8b98a29aa35880b93bbacce8daf68edb537eca
>
> Regards,
> Jonas
>
> >
> > I also did some work on struct board_f which is another way to reduce
> > space, if we can find more things which are only needed in early board
> > start-up. I suppose we could even expand that to include the
> > board_init_r() calls.
> >
> > Regards,
> > Simon
>

Regards,
Simon

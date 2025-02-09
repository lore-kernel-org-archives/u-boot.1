Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43E6C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 20:15:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEA2480821;
	Sun,  9 Feb 2025 21:14:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xafda+8w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0276A8083C; Sun,  9 Feb 2025 21:14:55 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 696A480141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 21:14:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5de4f4b0e31so3730559a12.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 12:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739132092; x=1739736892; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iEJr+u5PJXRVWHh6ObiIKZPN6Z7n/iZTaLAF0gjSrgc=;
 b=Xafda+8w3X+HHtbYLO0GTr1VgokdJJQI5OnRRAPiNkZzV2TB+S/YQYSwZTPaVp0fzt
 zE1BUdc9f/fmw3C9vquosl1icU7mNWlqFyGeG5Q5PM2mlhseaoUsPLd13neZ85iEd5Jr
 0DTXFtyKv8lGw8rQ6dLADa4PcwXC/gBrOSQco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739132092; x=1739736892;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iEJr+u5PJXRVWHh6ObiIKZPN6Z7n/iZTaLAF0gjSrgc=;
 b=N/h77gDhOitESaMRll00xeVrcFvih2tl6V6ve3aMIrdOESNfGZyY1HR6XmglddkpL4
 vmSA/Yt4lBcbs4Su0NXe8VXVGAO7hi+g/oCDixLJX6mNQTdLxUdPaDgIVieinY3PfRhQ
 v6sm7ZJxIPkBClXuyvafwRMpLPz4ZT1BMMr1WsjbHZXYhgTjEw2wuriV2BI3KiE8YjXX
 kGZQWFbArC3u6ADkM8FoEWvdOuqjRcWhgjrWBreu6zav7Qy1Atu9JjrQq9dpM78DuE8q
 Rekax6KkEFhVanrHVYjGVAt+IT9agaSA6gT93Oi9oezB9L2bH1UUStj+yy7xms5BgMr6
 ANnQ==
X-Gm-Message-State: AOJu0YxYYbco0CSrf/7jkTg0D9UQnjeSvb+Gvq5SCeXTFxWmp3hQMHbQ
 fwiCAw2odvYvHL0fug3GmTsj7KIAXqN/yP2SRZ0hK3WoCBXJmyXaL6OcWmWHqk4V1OQ5KnTtLNF
 0FwqM8vcBEYnXQLKpUZNx2K8au0SuuIk4GgfE
X-Gm-Gg: ASbGncseDlfzzHgiB4wKgre6G+8dM6loSvOs0np32TUuEjG/jSICpxdVIhK0ohRWYhP
 GbWF/8Be/doi9y3aojcDo1HE6/pCOz3UtOrOvWw9Mr6PfS1D0Y/nJHqRgSaPx8HnRsWlE5zA03w
 ==
X-Google-Smtp-Source: AGHT+IE6E+UAaIW9xYCKebmhHH8dF9j2zMiDiqBSJTE8+vDlG6h5oHcQ4Wuf+eSIT/EG9PGgWF9Eyg1cIdDLi/nNFH0=
X-Received: by 2002:a05:6402:2383:b0:5d2:723c:a568 with SMTP id
 4fb4d7f45d1cf-5de45003940mr11572264a12.10.1739132091739; Sun, 09 Feb 2025
 12:14:51 -0800 (PST)
MIME-Version: 1.0
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-6-sjg@chromium.org>
 <d6eb6aa3-8b38-4bf0-942f-ffc8a068e444@kwiboo.se>
 <CAFLszTi3VMhdX=n8GvvG3ZW7=oy3Eac9KaSBaCaBi7m17e0gfQ@mail.gmail.com>
 <356d2004-7b5e-4745-8bb2-5e559c46b8a3@kwiboo.se>
 <CAFLszTjXeZOtJNpoPTBKuwLhVbmqTu3nQGJQ3AsNic5SDC02kQ@mail.gmail.com>
 <287c0a7b-57c9-4669-bced-bd1deb1fa7ad@kwiboo.se>
In-Reply-To: <287c0a7b-57c9-4669-bced-bd1deb1fa7ad@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 13:14:40 -0700
X-Gm-Features: AWEUYZk2aqmr0gnclv0tPZDdpiUj5dfcXN9r_y75sny_v58bZFGM1lP4kkzTX_s
Message-ID: <CAFLszTjW_s8a4epCfjvwO2JYCgbRoCBWTuKkk-tXt_aj5xDYEw@mail.gmail.com>
Subject: Re: [PATCH 05/29] rockchip: Allow RAM init to happen in SPL on rk3399
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 huang lin <hl@rock-chips.com>
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

Hi Jonas,

On Sun, 9 Feb 2025 at 09:30, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-02-09 16:36, Simon Glass wrote:
> > Hi Jonas,
> >
> > On Sun, 9 Feb 2025 at 08:17, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 2025-02-09 15:26, Simon Glass wrote:
> >>> Hi Jonas,
> >>>
> >>> On Wed, 5 Feb 2025 at 15:18, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>>>
> >>>> Hi Simon,
> >>>>
> >>>> On 2025-02-05 02:54, Simon Glass wrote:
> >>>>> TPL runs before VPL. The earliest updatable phase with VBE is SPL. We
> >>>>> want to be able to update the RAM-init code in the field.
> >>>>
> >>>> If I understand your description here, you mean that both TPL and VPL
> >>>> are meant to be "burned" onto the board and not intended to be updatable?
> >>>
> >>> Yes, that's right. If you look at [1] and click on 'vbe-intro' there
> >>> is a diagram that shows the flow.
> >>
> >> Thanks for the reference, I can see that both are listed as read-only.
> >> Unfortunately that do not explain why we need to have both TPL and VPL
> >> aside from it being two separate conceptual parts.
> >>
> >> We can as easily just have BootROM load VPL and start from there, it
> >> does not look like TPL provides anything of real value for VBE on
> >> Rockchip, only one more part that can potentially fail?
> >
> > It is partly conceptual, partly due to space.
> >
> > TPL is about init setup and it is board-specific. VPL is a generic
> > 'root-of-trust' thing which contains the ABrec logic. It is supposed
> > to be generic and run on any supported board.
> >
> > Some boards have very limited space for TPL, but can load a larger
> > amount of code after that. There are quite a lot of x86 boards like
> > that. Also, for rk3399 I was unable to fit all the TPL init and VPL
> > logic into a single phase and still have room to load SPL.
>
> For Rockchip RK3399 I do not really understand why it would not fit.

Here are the margins at present. Loads of space going from TPL to VPL.
From VPL to SPL it is a lot tighter. I'm pretty sure more things could
be optimised, but there are also things I'd like to enable, like FIT
signatures.

=> vbe state
Phases: TPL (margin 94ea)  VPL (margin 2a9f)  SPL

>
> BootROM already does most init that is typically needed, and TPL
> probably only need to init iomux for debug uart and pinctrl for the
> storage media next phase is loaded from. Will be easier to understand
> once you have a series that can be applied :-)

Yes indeed. It has been so hard trying to get this all landed and
there are so many things needed. Once it is applied and in the lab it
will be easier to try things.

>
> >
> > As to combining them, I am sure it could be done, if there is enough
> > SRAM. Perhaps that could be a build option?
> >
> > If the MMC fails, we are not going to boot, so loading an extra phase
> > is not a big problem, IMO.
> >
> >>
> >>>
> >>>>
> >>>> Is this a typo or do I misunderstand something? Else I do not understand
> >>>> why you would need TPL->VPL->SPL, please explain.
> >>>>
> >>>>>
> >>>>> So when VPL is being used, init the RAM later, in SPL.
> >>>>>
> >>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>>>> ---
> >>>>>
> >>>>>  drivers/ram/rockchip/sdram_rk3399.c | 6 ++++--
> >>>>>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
> >>>>> index 6fa8f268770..9ac16dfdc71 100644
> >>>>> --- a/drivers/ram/rockchip/sdram_rk3399.c
> >>>>> +++ b/drivers/ram/rockchip/sdram_rk3399.c
> >>>>> @@ -194,6 +194,7 @@ struct io_setting {
> >>>>>  static bool phase_sdram_init(void)
> >>>>>  {
> >>>>>       return xpl_phase() == PHASE_TPL ||
> >>>>> +             (IS_ENABLED(CONFIG_VPL) && xpl_phase() == PHASE_SPL) ||
> >>>>>               (!IS_ENABLED(CONFIG_TPL) &&
> >>>>>                !IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL) &&
> >>>>>                !not_xpl());
> >>>>> @@ -3195,8 +3196,9 @@ U_BOOT_DRIVER(dmc_rk3399) = {
> >>>>>       .of_to_plat = rk3399_dmc_of_to_plat,
> >>>>>       .probe = rk3399_dmc_probe,
> >>>>>       .priv_auto      = sizeof(struct dram_info),
> >>>>> -#if defined(CONFIG_TPL_BUILD) || \
> >>>>> -     (!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
> >>>>> +#if defined(CONFIG_VPL) && defined(CONFIG_SPL_BUILD) || \
> >>>>> +     !defined(CONFIG_VPL) && defined(CONFIG_TPL_BUILD) || \
> >>>>> +     !defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD)
> >>>>>       .plat_auto      = sizeof(struct rockchip_dmc_plat),
> >>>>>  #endif
> >>>>>  };
> >>>>
> >>>> These two conditions are starting to get ridiculous.
> >>>>
> >>>> With "[PATCH 24/29] rockchip: Allow SPL to set up SDRAM" you are
> >>>> depending on TPL_RAM to decide if RAM should be initialized. Maybe that
> >>>> is something we can use here to simplify?
> >>>
> >>> The problem is that TPL_RAM means that the ram driver is present,
> >>> which isn't the same thing as actually doing the RAM init in that
> >>> phase. If we had a Kconfig value for 'phase' then we could perhaps
> >>> have CONFIG_PHASE_RAM=tpl or something like that.
> >>
> >> Yes, we may need to add a new Kconfig symbol to more easily control
> >> where DRAM init happens.
> >>
> >> I have been slowly working on unifying all Rockchip SoCs to use TPL for
> >> DRAM init and SPL for loading a FIT. All AArch64 should now follow this,
> >> and currently looking at migrating the older ARMv7 SoCs.
> >
> > OK, that's fine, but note that SPL is where this is supposed to
> > happen. What is the benefit of doing it earlier? From my understanding
> > it was just to accommodate Rockchip's secret blobs?
>
> It has nothing to do with accommodating Rockchip's secret blobs to my
> knowledge.
>
> Most Rockchip SoCs have limited SRAM and initializing full DRAM is
> what needs to happen early, i.e. RK3036 have 8 KiB SRAM. Thanks to
> this SPL has full DRAM access and does not really have a size limit.
>
> Theoretically you can have BootROM load full U-Boot proper as the next
> phase after the initial DRAM init phase. Not something that is really
> used, instead SPL is loaded to have more control over what is loaded
> next, i.e. falcon boot, EDK2, TF-A/OP-TEE and/or U-Boot proper.

OK. So I wonder whether DRAM should be in SPL, for modern SoCs, then?

It would be nice if Rockchip could expose the MMC-reading code as a
function table in the ROM, so we don't need to repeat the code in xPL.

>
> Rockchip does provide DRAM init blobs that typically can be used as a
> stand in replacement for U-Boot TPL (DRAM init) in case there is no
> open-source implementation for the DRAM used on a board or SoC.

OK.

Regards,
Simon

>
> Regards,
> Jonas
>
> >
> >>
> >>> I plan to get back
> >>> to my rejected XPL series soon and that is something I could
> >>> incorporate when that goes in.
> >>>
> >>>>
> >>>> Basically we will have 3 possible DRAM init scenarios to support:
> >>>> - ROCKCHIP_EXTERNA_TPL=y -> DRAM init happen in external TPL and SPL
> >>>>   should only read DRAM size
> >>>> - VPL=y or TPL=n -> both DRAM init and read DRAM size happen in SPL
> >>>> - TPL=y -> DRAM init in TPL and SPL should only read DRAM size
> >>>
> >>> Yes that's my understanding too. For the last one, for clarity:
> >>>
> >>>  - TPL=y -> DRAM init in TPL; SPL should only read DRAM size
> >>
> >> Correct.
> >>
> >>
> >
> > Regards,
> > SImon
> >
> >>>
> >>> [1] https://docs.u-boot.org/en/latest/develop/vbe.html#verified-boot-for-embedded-vbe
> >>
>

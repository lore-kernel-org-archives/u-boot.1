Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695D6C0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 13:55:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB6B78213E;
	Fri, 31 Jan 2025 14:55:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vvcimrZi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF9EB82163; Fri, 31 Jan 2025 14:55:36 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CAA880F92
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 14:55:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e573136107bso2732397276.3
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 05:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738331733; x=1738936533; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5XTM25aS+xbvEAlv7R0WpaDfdjRwQq109IHweSPG294=;
 b=vvcimrZiKxLlmgqov7QkFG0c8JyQaPVwo/VtYnJse5gCYhYpAFUAWbhTrED6c3QCzx
 2pEjc/YOAbPWJN8gcckGR29g8a4Wh8169yRlutHJJWUy5vucwMyFNdbtEHBZeLoyoCfd
 tys1ItNxcPjStZeN740K+/dJVASPsKUGvPx65jpBzQ/+p7EYeFyzdBiZhO2uPS73mj84
 co4WKhOTJJpnXDQgtQ0BH3PYm7fTxDk7u15TB0ZEvAluzpgcHwXhqh6wguVYYDLdsqmd
 QhJODsKtyXAaaLeSHzHi//7td+VKOJca2t0fyw8dkQzwPgfVOhM7ZkZeqVEcMnnj+Ip0
 GaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738331733; x=1738936533;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5XTM25aS+xbvEAlv7R0WpaDfdjRwQq109IHweSPG294=;
 b=cOGgliTvy8gCki7j8POVCnyxbob0svJc0QYU5QuslcuBz8eRKNnSi4Db+w4L6n7Wcx
 sWVGakEFeHqxLH/NohuG2lEDd26AOyN9POl8kvAVl5B7fcy2Qr6k7G2scOE3hQIvwkXJ
 ArK+l8f8F4P28emnTEx7T5NTyEv1iQFnbAWsNSQ6iW1m4EuVqYDn2ssAjhu0M6yLUQSs
 mdYqAI6oBT7aM02qztvgrFEz1jLI6gnRTpBJJhEYDfkE5EI1+NxxgA5d/oWrq3JxT2Ht
 307JPlgnt29Gw/bY3AVH3K5UfCwLAjYbJxROnnK1nyCjyzcKUF2J8jUhc9gJ0oQXpI9n
 eQvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOLakdDHdlhNt67Y2SKL4XMX9jHvSetkP6f1FqlpJpZmDXGVN3Jt0PsscX9hOsLS8eBMLiHMQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwSy/k+1j7bJynT/6hz2qUmuxwRq301zdUG7lD6b6XBWgI2TQtx
 ILVb1QnVa5kKV8cJyZikTuiiPdez592f/ut6U081l8JU+uZUFyaqCJqOZn1QPzZ5C5NsTLUt9Nd
 4yZV8KsU5X+h43bufhguHyqlQbxmcpB2MQOeovA==
X-Gm-Gg: ASbGnctUJiDeDc/0FSamNsPrbMKqM8tk1OhlXt6u84hJbOxbnuy0zfcD4Hvjbdn1kVw
 DdtGzUGwPlIuVyHCyvQjgB0kEXBq40l2IoUIjA+fwckYWzICoZUoKDkZZ3yBoyTOXqlZw94IQ
X-Google-Smtp-Source: AGHT+IGTvrz2AXoCaeH1xmTlL5a2ghYz7XIo9SnK0fEcTxF0cq9MiXWdBJqLtuw6v76eK+UTbT7G1Er7GugkRlhCfSI=
X-Received: by 2002:a05:6902:2b06:b0:e58:37fe:4a17 with SMTP id
 3f1490d57ef6-e58a4bd758cmr8635940276.46.1738331732863; Fri, 31 Jan 2025
 05:55:32 -0800 (PST)
MIME-Version: 1.0
References: <20250129-rockchip-pinctrl-const-v1-0-450ccdadfa7e@cherry.de>
 <0ca2ce57-8efe-4de2-8f83-71623867e51f@kwiboo.se>
 <70588c5a-fca5-4600-a229-f30b8d97ac6b@cherry.de>
 <02557bff-3a8e-48ce-8bcd-e9a0cf81f51b@kwiboo.se>
In-Reply-To: <02557bff-3a8e-48ce-8bcd-e9a0cf81f51b@kwiboo.se>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 31 Jan 2025 15:54:57 +0200
X-Gm-Features: AWEUYZnn2Ai6vovXxCfGPwI1t6v96o6qFNYzTCkovCm_7F5oQY7AT506Il-zZmY
Message-ID: <CAC_iWjJ9xWc0kDoveqJDHy2Sa2D-BKWApRaurbxf0MV2M=9oqQ@mail.gmail.com>
Subject: Re: [PATCH 00/14] pinctrl: rockchip: fix editing const struct +
 constify rockchip_pin_ctrl
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Jagan Teki <jagan@edgeble.ai>, u-boot@lists.denx.de
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

On Thu, 30 Jan 2025 at 23:20, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Quentin,
>
> On 2025-01-30 15:16, Quentin Schulz wrote:
> > Hi Jonas,
> >
> > On 1/29/25 3:20 PM, Jonas Karlman wrote:
> >> Hi Quentin,
> >>
> >> On 2025-01-29 13:42, Quentin Schulz wrote:
> >>> While testing some WIP work done by Ilias Apalodimas on guaranteeing
> >>> read-only memory areas truly are handled as read-only[1], my RK3588
> >>> Tiger couldn't reach U-Boot CLI anymore because of the pinctrl driver
> >>> modifying a const struct rockchip_pin_ctrl, triggering a CPU abort.
> >>>
> >>> Instead of going the lazy way and unconstify it, let's fix the actual
> >>> issue in play.
> >>>
> >>> The member modified in the const is only ever used for setting a member
> >>> from another struct (not const that one). However this other member is
> >>> never read! Therefore we can simply afford to remove it which means the
> >>> sole reader of the member in the const is now gone, thus making it
> >>> possible to remove the member from the const struct as well.
> >>>
> >>> This also means we should be able to constify the private data of the
> >>> controller device for all Rockchip devices, instead of having those only
> >>> for RK356x, RK3588 and RV1126. With the constify done on top of Ilias
> >>> branch[1], my PX30 Ringneck, RK3399 Puma and RK3588 Tiger all reach
> >>> U-Boot CLI. No further test (like booting into Linux userspace) was
> >>> done.
> >>>
> >>> [1] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/tree/fix_memory_permissions
> >>>
> >>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> >>> ---
> >>> Quentin Schulz (14):
> >>>        pinctrl: rockchip: remove unused base_pin bank member
> >>>        pinctrl: rockchip: remove unused nr_pins controller member
> >>
> >> pin_base and nr_pins is used after my "rockchip: pinctrl: Add support
> >> for pinmux status cmd" series [1].
> >>
> >> The pin_base should probably be moved to udevice priv data or similar.
> >> nr_pins can probably also be moved to udevice priv data or constify in
> >> driver data.
> >>
> >> Do you want me to re-work/re-store these fields in a different way once
> >> I finally send a v3 of that series?
> >>
> >
> > What I can suggest is to remove the setting of ctrl->nr_pins as I
> > believe we shouldn't be modifying it and we don't need to store it, even
> > in your patch series as we discussed on IRC, and keep pin_base from the
> > bank.
> >
> > What I can offer instead is to use a local variable to replace the one
> > from the controller struct.
> >
> > """
> > diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> > b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> > index d449d07d32e..14aba6f370b 100644
> > --- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> > +++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> > @@ -531,20 +531,22 @@ static struct rockchip_pin_ctrl
> > *rockchip_pinctrl_get_soc_data(struct udevice *d
> >       struct rockchip_pin_ctrl *ctrl =
> >                       (struct rockchip_pin_ctrl *)dev_get_driver_data(dev);
> >       struct rockchip_pin_bank *bank;
> > -     int grf_offs, pmu_offs, drv_grf_offs, drv_pmu_offs, i, j;
> > +     int grf_offs, pmu_offs, drv_grf_offs, drv_pmu_offs, ctrl_nr_pins, i, j;
> >
> >       grf_offs = ctrl->grf_mux_offset;
> >       pmu_offs = ctrl->pmu_mux_offset;
> >       drv_pmu_offs = ctrl->pmu_drv_offset;
> >       drv_grf_offs = ctrl->grf_drv_offset;
> >       bank = ctrl->pin_banks;
> > +     ctrl_nr_pins = 0;
> > +
> >
> >       for (i = 0; i < ctrl->nr_banks; ++i, ++bank) {
> >               int bank_pins = 0;
> >
> >               bank->priv = priv;
> > -             bank->pin_base = ctrl->nr_pins;
> > -             ctrl->nr_pins += bank->nr_pins;
> > +             bank->pin_base = ctrl_nr_pins;
> > +             ctrl_nr_pins += bank->nr_pins;
> >
> >               /* calculate iomux and drv offsets */
> >               for (j = 0; j < 4; j++) {
> > """
> >
> > Something like that to replace patches 1 and 2. This should allow you to
> > keep working on your other patch series without me making it too much
> > more difficult for you to rebase?
>
> Thanks for taking a look, and I agree this should help when I pick up
> and re-spin my series.
>
> >
> > We need this patch series in before
> > https://lore.kernel.org/u-boot/20250130072100.27297-1-ilias.apalodimas@linaro.org/T/#t
> > gets is otherwise we don't be able to boot anymore on RK356x, RK3588 and
> > RV1126. I don't think there's going to be much bikeshedding or
> > controversy about my series here (in v2 if you agree with the above
> > diff), the pinctrl series from last August seems like it could be
> > opening many can of worms so better not rebase this series on top of
> > that series. Do you agree with that?
>
> I fully agree, better to get this in first, I will try to re-spin my
> series on top of this sometime later once this has landed.

Ok, I'll post this after the weekend in case I get more review
comments. Keep in mind that i'll hide it behind a Kconfig option for
now, since we seem to have enough cases of code writing const
variables

Cheers
/Ilias
>
> Regards,
> Jonas
>
> >
> > Cheers,
> > Quentin
>

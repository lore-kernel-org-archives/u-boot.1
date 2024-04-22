Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD537C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 12:34:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18E42887E2;
	Mon, 22 Apr 2024 14:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LaIz06+G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 412E98832C; Mon, 22 Apr 2024 07:32:04 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FBD78831B
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 07:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-343e46ec237so3342884f8f.2
 for <u-boot@lists.denx.de>; Sun, 21 Apr 2024 22:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713763922; x=1714368722; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aHGB9gE8/XOMEbN2Bls/BU6U8I+zFuHFoKeaxTqTRJo=;
 b=LaIz06+GA+uUmww12ualz7MH3/jZm2jKOvUzhzcww2jwI5aRHE1+BZ05UPeopeZAKH
 HLhVjdlgreBhcmUZd0sz1dQc3o4toe3F2L4mIid3MV7jVPjt8ku2YkB7d+gksp4nTJeL
 jg/C/TxAEg6pjM6u4iG/LcfIKHu4Dhn9CSe0LFL1ndzQbfhELjbt6dhAgVwAU5wFf99u
 /UKVmzjeSmVThyVmhb5KGhOtJ4XmVb9+ayMV7mKQR9VkdKVW0zPTZNLOOp/+sWwZTf/R
 wInlcR0l1A5i3gNUEYiN7npbXNbXfteVcRVyga2Nw0fUNkvDrjwgrNykIpY+ewb5QLZ5
 Mjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713763922; x=1714368722;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aHGB9gE8/XOMEbN2Bls/BU6U8I+zFuHFoKeaxTqTRJo=;
 b=SJYdahn+ZUNnvqr8uDM30KCAx5PiZaDO49W0XFn89d515u/51f++8+KS84QZJT3MPg
 yfQfipcskKKA4qLICdtSglbibZ64DEzLxeHslQctj0Bo+vrj7bto7DcqVA9krbpr2mBP
 LBcNTG+2N4pXAjC+gRuaoGCXhA7yz3Dn7DzOriGzDMkQaIdcuGfsbvZw4sUSuHXmHR/T
 ijVgRQJzUbv5EB5YBt4R3XzsvyVS/4WpxKvhu5RJliKiv8f2bV9pB2g6dHcR6OJJ+Hk3
 N/2Skx3SqGXw2CR0gmTSvHVKC1C/WLjc1BiIb3ORt9Gbl3xkjMZ+gcsFLBI/h+AuHZvc
 b3kA==
X-Gm-Message-State: AOJu0YxScyohf+Dmz/JVrEe/TIKBwlw6WQFbGze6qir5yiC9UYiUlgIG
 Tg2l0T1Y41g7mCo65m6kzjgUsLGXjdTnZvWEFEOhZ4JUgzkBdfNnDMqcbvJU2of7bWOaLpLCMlx
 2XrMK5vpXte/9szzkZT0V0CnZJEM=
X-Google-Smtp-Source: AGHT+IHmHiX57KtXO6TNIl/iHQEad0RcOLKaMwCRrLEGNKyNafS2qHlSqlxgbEX4BZF3JoNtnjANfz3if2k4WFjpk5w=
X-Received: by 2002:adf:e384:0:b0:347:f695:bae0 with SMTP id
 e4-20020adfe384000000b00347f695bae0mr6435953wrm.31.1713763921292; Sun, 21 Apr
 2024 22:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240328131811.94559-1-seashell11234455@gmail.com>
 <7e3063b5-cb03-436d-b780-c05edbd95010@denx.de>
In-Reply-To: <7e3063b5-cb03-436d-b780-c05edbd95010@denx.de>
From: Kongyang Liu <seashell11234455@gmail.com>
Date: Mon, 22 Apr 2024 13:31:49 +0800
Message-ID: <CAOKwTdp0DA2APPeAfB0OduWiYv+YLED+mRvJm0jEe1VsqJ7kVA@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc2: update reset method for host and device mode
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Simon Glass <sjg@chromium.org>,
 Teik Heng Chong <teik.heng.chong@intel.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 22 Apr 2024 14:34:13 +0200
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

Marek Vasut <marex@denx.de> =E4=BA=8E2024=E5=B9=B44=E6=9C=8822=E6=97=A5=E5=
=91=A8=E4=B8=80 04:45=E5=86=99=E9=81=93=EF=BC=9A
>
> On 3/28/24 2:14 PM, Kongyang Liu wrote:
>
> [...]
>
> > @@ -464,12 +464,26 @@ static void reconfig_usbd(struct dwc2_udc *dev)
> >   {
> >       /* 2. Soft-reset OTG Core and then unreset again. */
> >       int i;
> > -     unsigned int uTemp =3D writel(CORE_SOFT_RESET, &reg->grstctl);
> > +     unsigned int uTemp;
> >       uint32_t dflt_gusbcfg;
> >       uint32_t rx_fifo_sz, tx_fifo_sz, np_tx_fifo_sz;
> >       u32 max_hw_ep;
> >       int pdata_hw_ep;
> >
>
> Drop this newline
>

I will fix it

> > +     u32 snpsid, greset;
> > +
> > +     snpsid =3D readl(&reg->gsnpsid);
> > +     writel(CORE_SOFT_RESET, &reg->grstctl);
> > +     if ((snpsid & SNPSID_VER_MASK) < (SNPSID_VER_420a & SNPSID_VER_MA=
SK)) {
>
> Can you use FIELD_GET()/FIELD_PREP() for this ?
>

I will fix it

> > +             wait_for_bit_le32(&reg->grstctl, CORE_SOFT_RESET, false, =
1000, false);
> > +     } else {
> > +             wait_for_bit_le32(&reg->grstctl, CORE_SOFT_RESET_DONE, tr=
ue, 1000, false);
> > +             greset =3D readl(&reg->grstctl);
> > +             greset &=3D ~CORE_SOFT_RESET;
> > +             greset |=3D CORE_SOFT_RESET_DONE;
> > +             writel(greset, &reg->grstctl);
>
> clrsetbits_le32()
>

I will fix it

> [...]
>
> > diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
> > index 637eb2dd06..1baeff96ee 100644
> > --- a/drivers/usb/host/dwc2.c
> > +++ b/drivers/usb/host/dwc2.c
> > @@ -159,6 +159,7 @@ static void dwc_otg_core_reset(struct udevice *dev,
> >                              struct dwc2_core_regs *regs)
> >   {
> >       int ret;
> > +     u32 snpsid, greset;
> >
> >       /* Wait for AHB master IDLE state. */
> >       ret =3D wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_AHBIDLE,
> > @@ -167,9 +168,20 @@ static void dwc_otg_core_reset(struct udevice *dev=
,
> >               dev_info(dev, "%s: Timeout!\n", __func__);
> >
> >       /* Core Soft Reset */
> > +     snpsid =3D readl(&regs->gsnpsid);
> >       writel(DWC2_GRSTCTL_CSFTRST, &regs->grstctl);
> > -     ret =3D wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_CSFTRST,
> > -                             false, 1000, false);
> > +     if ((snpsid & DWC2_SNPSID_VER_MASK) < (DWC2_SNPSID_DEVID_VER_420a=
 & DWC2_SNPSID_VER_MASK)) {
> > +             ret =3D wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_CS=
FTRST,
> > +                                     false, 1000, false);
> > +     } else {
> > +             ret =3D wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_GS=
FTRST_DONE,
> > +                                     true, 1000, false);
> > +             greset =3D readl(&regs->grstctl);
> > +             greset &=3D ~DWC2_GRSTCTL_CSFTRST;
> > +             greset |=3D DWC2_GRSTCTL_GSFTRST_DONE;
> > +             writel(greset, &regs->grstctl);
>
> Same comments as above.
>
> Maybe this should be pulled into dedicated function to avoid duplication?
>

For U-Boot, the dwc2 USB driver is split into two modules: host and gadget.
Each has its own register definitions and definitions for register bits,
which makes it difficult to extract a single function. Moreover, deciding
where to place this function is also an issue.

> > +     }
> > +
> >       if (ret)
> >               dev_info(dev, "%s: Timeout!\n", __func__);
> >
> > @@ -1180,7 +1192,8 @@ static int dwc2_init_common(struct udevice *dev, =
struct dwc2_priv *priv)
> >                snpsid >> 12 & 0xf, snpsid & 0xfff);
> >
> >       if ((snpsid & DWC2_SNPSID_DEVID_MASK) !=3D DWC2_SNPSID_DEVID_VER_=
2xx &&
> > -         (snpsid & DWC2_SNPSID_DEVID_MASK) !=3D DWC2_SNPSID_DEVID_VER_=
3xx) {
> > +             (snpsid & DWC2_SNPSID_DEVID_MASK) !=3D DWC2_SNPSID_DEVID_=
VER_3xx &&
> > +         (snpsid & DWC2_SNPSID_DEVID_MASK) !=3D DWC2_SNPSID_DEVID_VER_=
4xx) {
>
> Try FIELD_GET/FIELD_PREP

I will fix it

Best regards
Kongyang Liu

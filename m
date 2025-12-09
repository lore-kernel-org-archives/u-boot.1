Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B835D3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 09:24:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8825183AED;
	Tue,  9 Dec 2025 10:24:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nZVxXtRc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6084283AEE; Tue,  9 Dec 2025 10:24:22 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AAE1838FA
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 10:24:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b73875aa527so770362666b.3
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 01:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765272258; x=1765877058;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pHiljDBgW4UGDRrR28vtO/mYzhGeb1ZCOCA10EQ8yvo=;
 b=nZVxXtRcG9h5yTrQ6PWB5eVhvWv9xYAsKFTbRiI45Y5fb9H8DrZzdzvQxgUOXcMMat
 x6F7+sdXf5A1xrmaJ2rzFBQKCLtti5kJMW3TReOe7Ie5jzI3I/HtccVvD+MjJBWgmBTA
 RTfH3mjbCBmeL9A8meZIt0w7KESZUUnp651xaAPUe+2SdfUGCxvOWInx4wy6Mo8r0FtL
 enSbiYq+nRT0iehv35butjWANGSIuKCiTMDUxZkyo8+twE7HP3pPyrmUs9wKqzo7pqsy
 v10OZqujfB1POipILcFtlAZ8R9OHh/JTz/lkJtMucjzqs4UXpkA4ySUPAtKQ8sd6NKhc
 IPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765272258; x=1765877058;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pHiljDBgW4UGDRrR28vtO/mYzhGeb1ZCOCA10EQ8yvo=;
 b=DiQRpTYf9AE6SIZ0zadJPvGPf9Z6WSqk2a+B20haehPYqbr6sk7IptjR2S/KgX8a7A
 ha2PRIFlEF3xOHXi5EaJNA2TdAOxORDFzP8yklW4p0yIV1wa09WlWpAExzIgoS0doWZ7
 OwKTKCsY1kL/z28ZTDlzHFsx+214AV3AN55Oz9DXZi5HDb8fBCRlby4i4HuDWVAoniNC
 +Q02tPIni/kcIeg8//j+G+HzBQMjdWGQfGl8fMnGgydJOTVCsXX99DJK7vSutVesNna1
 a33k0ct9cLDSc9T24OHpueIfbAAHhU4zBlvCWPpKCOz/8Nxyb3yCkXy3tFsqwdcW8HYh
 ZEBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCkbxmiqs4L9zu9+nfAWQu+S8WFdHn8XfI4Cb6xQXeNWADevY9HQX+KzyJ3PjfahrLnmAZ23M=@lists.denx.de
X-Gm-Message-State: AOJu0YzKOBk9EqgbWHP3XGJHo9dj6PELFIKxr+H8TZ+NINW4QdVWzgOO
 Dywm9SNEZ/UTi6rG8yra5fvKZL2P5kfJJ1x2hgvhTrh94ZqFbQnWU7U3R3TxigmAGG+q8jf7gM7
 RKYq9ldKR9v07jpEOWLxRE/BY4Q0V39bZc7+7/KMbMQ==
X-Gm-Gg: ASbGncsEQp4lm59LDsXJgpaYxnjiV3yNmnuYz+Fohh7WH88YEgJy9icQyRvJBg/algC
 mfzm9/oSpKjSrIx+oCkl33AS53+PqFmG3B3XT5jnV7hXfdsuu1b9C3d301HbpTFUeOJgN+ALzzj
 MdohpEwJ/tflCK7wOm9/+pS/MXPiet2GDgCnivpAzoXmrIUuL5+7+4EpeO3rZn4Nk5tIt33QdD4
 1q6sMtrRm7Yr74HF9hs8VhmgCdtl//N7YicdOEmZ78mSWmAyZC/gLJgP5lqbOlbj9NhqQmy+/QL
 qT57pRfCqm/QXTgcEOb66azF036i/MjFXAovk15y
X-Google-Smtp-Source: AGHT+IHDp1dAVFYx3jREpMZD2Pi68XZgEJp560u40PAZtEA34pPw0OdQVwIMheJGWfkFTOJEoW7ZlKDVetmMdUKBki8=
X-Received: by 2002:a17:907:9803:b0:b73:7710:fe03 with SMTP id
 a640c23a62f3a-b7a2477d5fcmr1059875166b.58.1765272257915; Tue, 09 Dec 2025
 01:24:17 -0800 (PST)
MIME-Version: 1.0
References: <20251203-add-mt8188-support-v1-0-9a06ebb97734@baylibre.com>
 <20251203-add-mt8188-support-v1-1-9a06ebb97734@baylibre.com>
 <2130bf1ebe2e3684a3d1c7341249ce2ca524d0bb.camel@mediatek.com>
In-Reply-To: <2130bf1ebe2e3684a3d1c7341249ce2ca524d0bb.camel@mediatek.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 9 Dec 2025 10:24:05 +0100
X-Gm-Features: AQt7F2pzbHMxhiF2gCGioM_ihW-xYg3PrvcP7ECjbE7Wf_KhAMyS81J20VF6Nk4
Message-ID: <CAEHHSvbUNo0zxaasC9K8+k1i_S9H2GGi4GjF5qqMTibk=Q2abA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm: mediatek: add support for MediaTek MT8188 SoC
To: =?UTF-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
Cc: =?UTF-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>, 
 =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>, 
 Ryder Lee <Ryder.Lee@mediatek.com>, "trini@konsulko.com" <trini@konsulko.com>, 
 =?UTF-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>, 
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 =?UTF-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?= <Chris-qj.Chen@mediatek.com>, 
 "mkorpershoek@kernel.org" <mkorpershoek@kernel.org>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>, 
 "stefan.roese@mailbox.org" <stefan.roese@mailbox.org>, 
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, 
 "alif.zakuan.yuslaimi@altera.com" <alif.zakuan.yuslaimi@altera.com>,
 Julien Masson <jmasson@baylibre.com>, 
 "nathan.morrison@timesys.com" <nathan.morrison@timesys.com>, 
 "sumit.garg@kernel.org" <sumit.garg@kernel.org>, 
 "vasileios.bimpikas@analog.com" <vasileios.bimpikas@analog.com>,
 "lukma@denx.de" <lukma@denx.de>, 
 "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>, 
 "utsav.agarwal@analog.com" <utsav.agarwal@analog.com>,
 "ziyao@disroot.org" <ziyao@disroot.org>, 
 =?UTF-8?B?U2FtIFNoaWggKOWPsueiqeS4iSk=?= <Sam.Shih@mediatek.com>, 
 "Oliver.Gaskell@analog.com" <Oliver.Gaskell@analog.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, "sjg@chromium.org" <sjg@chromium.org>, 
 "jerome.forissier@linaro.org" <jerome.forissier@linaro.org>, 
 "arturs.artamonovs@analog.com" <arturs.artamonovs@analog.com>, 
 "malysagreg@gmail.com" <malysagreg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Le ven. 5 d=C3=A9c. 2025 =C3=A0 11:53, Macpaul Lin (=E6=9E=97=E6=99=BA=E6=
=96=8C)
<Macpaul.Lin@mediatek.com> a =C3=A9crit :
>
> On Wed, 2025-12-03 at 10:31 +0100, Julien Stephan wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >
> >
> > From: Julien Masson <jmasson@baylibre.com>
> >
> > This adds basic support for MediaTek MT8188 SoC.
> >
> > Add watchdog support by adding upstream compatible string.
> >
> > Add tphy support by adding "mediatek,generic-tphy-v2" compatible
> > string
> > in arch/arm/dts/mt8188-u-boot.dtsi
> >
> > Signed-off-by: Julien Masson <jmasson@baylibre.com>
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
> >  MAINTAINERS                            |  1 +
> >  arch/arm/dts/mt8188-u-boot.dtsi        | 10 +++++
>
> Where is mt8188.dtsi?
> Would you please to keep the mt8188.dtsi
> and then create the seperate mt8188-u-boot.dtsi?
> Please refer to other platforms like mt7622 or mt7982, etc.
>

Hi Macpaul,

mt8188.dtsi is located in  dts/upstream/src/arm64/mediatek/mt8188.dtsi
mt8188-u-boot.dtsi is applied on top of this device tree.
If I am correct new submissions should use the Linux Kernel upstream
dts located in dts/upstream (config OF_UPSTREAM).
I think other platforms like mt7622 or mt7982 needs to be switched to
config OF_UPSTREAM.

> >  arch/arm/mach-mediatek/Kconfig         | 11 +++++-
> >  arch/arm/mach-mediatek/Makefile        |  1 +
> >  arch/arm/mach-mediatek/mt8188/Makefile |  3 ++
> >  arch/arm/mach-mediatek/mt8188/init.c   | 69
> > ++++++++++++++++++++++++++++++++++
> >  drivers/watchdog/mtk_wdt.c             |  1 +
> >  7 files changed, 95 insertions(+), 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index
> > b43dae882b3ea33c2cd745bd3759e3f4d97abc80..5b52d2fe17506d2659be9016a7c
> > a639062332ae9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -415,6 +415,7 @@ M:  Chunfeng Yun <chunfeng.yun@mediatek.com>
> >  M:     Igor Belwon <igor.belwon@mentallysanemainliners.org>
> >  R:     GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
> >  S:     Maintained
> > +F:     arch/arm/dts/mt*
> >  F:     arch/arm/mach-mediatek/
> >  F:     arch/arm/include/asm/arch-mediatek/
> >  F:     board/mediatek/
> >
> >
> > [snip]
>
> Thanks for helping upstream these SOC to u-boot upstream.
> However, I've found it seems lots of formatting issues (errors
> and warnings) in coding style when I ran checkpatch through
> these patches.
>
> Please help to fix them as could as possible.
>
> > diff --git a/arch/arm/dts/mt8188-u-boot.dtsi b/arch/arm/dts/mt8188-u-
> > boot.dtsi
> > new file mode 100644
> > index
> > 0000000000000000000000000000000000000000..6d1b2ab82da1c95a49b8a693eb0
> > f854ab913a26b
> > --- /dev/null
> > +++ b/arch/arm/dts/mt8188-u-boot.dtsi
>
> [snip]
>
>
> > diff --git a/arch/arm/mach-mediatek/mt8188/init.c b/arch/arm/mach-
> > mediatek/mt8188/init.c
> > new file mode 100644
> > index
> > 0000000000000000000000000000000000000000..3389c03b06006e8130b4ce448d5
> > dcfb8f103c28f
> > --- /dev/null
> > +++ b/arch/arm/mach-mediatek/mt8188/init.c
> > @@ -0,0 +1,69 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2025 MediaTek Inc.
> > + * Copyright (C) 2025 BayLibre, SAS
> > + * Author: Julien Masson <jmasson@baylibre.com>
> > + */
>
>
> Would you please help to keep the origin author here together with you?
> Since this file should come from
>
>
> https://gitlab.com/mediatek/aiot/bsp/u-boot/-/blob/mtk-v2022.10/arch/arm/=
mach-mediatek/mt8188/init.c?ref_type=3Dheads
> Author: Chris-QJ Chen <chris-qj.chen@mediatek.com>
>

you are right, I forgot to add  back Chris-QJ Chen, I'll do it, thank
you for the reminder!

Cheers
Julien Stephan

> And please help to do it so when you adding back mt8188.dtsi.
>
> Thanks!
> Macpaul Lin
>
>
> ************* MEDIATEK Confidentiality Notice ********************
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be
> conveyed only to the designated recipient(s). Any use, dissemination,
> distribution, printing, retaining or copying of this e-mail (including it=
s
> attachments) by unintended recipient(s) is strictly prohibited and may
> be unlawful. If you are not an intended recipient of this e-mail, or beli=
eve
> that you have received this e-mail in error, please notify the sender
> immediately (by replying to this e-mail), delete any and all copies of
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!

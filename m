Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37509C001E0
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 05:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A14B8757C;
	Sat, 21 Oct 2023 07:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jjgoozux";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9634687581; Sat, 21 Oct 2023 07:48:31 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9770487572
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 07:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-408002b5b9fso12025015e9.3
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 22:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697867309; x=1698472109; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMEYudI/B1WqyeBUHWXJyj5hAIqgtBB4CYrmLqo+0Uk=;
 b=JjgoozuxDdVp1lyv8E8eKaWsAy1DSdpLjoW5RgQloMhXpuqFJmRGyyX+n5gLQVLopC
 aVEdp9kox7PBN9GItri+KQUf8VzUVZLVU/k6p/ab+DS01eaHr0w59hxsaPZwF3TJ7wM1
 /XETUF6WsrXxDszHe8gRIVn15iUJB8l1Sm/L4qQAvTgIcdC8ushnTTP9PSvCJz5rCNh5
 oDDD0/bnGy8rif9WJ5SHTA8yEG2QRepbecQM67tJuoQgetr0/IV7xINBsyPxybcHU6La
 qxjESukhXnMO/wmPR/sbjhPOkwr//F5BI7igjKfvamJAvympOoLR757H+CC7jOkngRUd
 LAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697867309; x=1698472109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PMEYudI/B1WqyeBUHWXJyj5hAIqgtBB4CYrmLqo+0Uk=;
 b=sJrflI+wlfPIlfiC8fPLxP2gEdoSOWoyQoeYNmp9kFBjGOfhidMW2rI4sVfbEvT/WS
 DZbpkAswr2tDHRut2+AMI4gXJ772Nn4MI3fyXuSAkeZNAKA1MWd+5QRKP0UQxmupiOLw
 2MAxoZ1+gTV3gxRwzFjI7Z8OU8ijwoAHfqX5eX963XRQiynEeIVtjibrurw+B2ZrhCxK
 tvz4IzUXHVKTgctUlj5bUNusjOxFXBRQpIKw1Mp2M6GIeZxl+/NZXCVuOaHRzFzqMgwa
 9dGcJxVq6AJq8U+y73+M5KsVFaH7IMasnV0qA5QKXLugTO863l2XqSk2PsHL3F8Ila33
 9Amw==
X-Gm-Message-State: AOJu0YxnV4O8VgJRWXTYgLh+ZxFa7XAN4B3FO4gss12jniYrgmR2VRSV
 PZp+eDCMGkFugZ6yLY+o6hs=
X-Google-Smtp-Source: AGHT+IFD5JQoTSmNQeG07tBJCsnod+mI4mjJUYEwMIKnrUvOk5Wm5GmAAJKn7Nv6K3g2CtI9kBhvow==
X-Received: by 2002:a05:600c:4ecf:b0:405:e492:8aef with SMTP id
 g15-20020a05600c4ecf00b00405e4928aefmr2621296wmq.40.1697867308684; 
 Fri, 20 Oct 2023 22:48:28 -0700 (PDT)
Received: from archlinux.localnet (82-149-12-148.dynamic.telemach.net.
 [82.149.12.148]) by smtp.gmail.com with ESMTPSA id
 c39-20020a05600c4a2700b0040588d85b3asm8223581wmp.15.2023.10.20.22.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:48:28 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Gunjan Gupta <viraniac@gmail.com>, u-boot@lists.denx.de,
 Ondrej Jirman <megi@xff.cz>, Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH 1/1] sunxi: dram: Fix incorrect ram size detection for
 some H6 boards
Date: Sat, 21 Oct 2023 07:48:27 +0200
Message-ID: <4518016.LvFx2qVVIh@archlinux>
In-Reply-To: <20231021003839.1fcf08c8@slackpad.lan>
References: <20231001161336.31140-1-viraniac@gmail.com>
 <4834802.GXAFRqVoOG@jernej-laptop> <20231021003839.1fcf08c8@slackpad.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

On Saturday, October 21, 2023 1:38:39 AM CEST Andre Przywara wrote:
> On Mon, 02 Oct 2023 20:59:34 +0200
> Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:
>=20
> Hi Jernej,
>=20
> > Dne ponedeljek, 02. oktober 2023 ob 14:42:40 CEST je Gunjan Gupta=20
napisal(a):
> > > > >  bool mctl_mem_matches(u32 offset)
> > > > >  {
> > > > >=20
> > > > > +     dsb();
> > > >=20
> > > > This looks a bit odd, do you have an explanation for that? And are =
you
> > > > sure that is really needed?
> > > > I understand why we need the DSB after the writel's below, but befo=
re
> > > > that?
> > >=20
> > > I started with Ondrej Jirman's patch from LibreELEC's tree that had a
> > > dsb call added
> > > after the first writel call. That reduced the frequency of the errors
> > > but didn't removed
> > > it completely. My reason for moving it before the writel was to make
> > > sure any memory
> > > access is completed before starting the actual logic for the test.
> > > That reduced the
> > > frequency even further, but didn't resolve the issue. I did try
> > > removing it leaving only
> > > udelay added to the code, but that brings back the issue.
> > >=20
> > > > The only thing I could think of is that we are missing a barrier in
> > > > mctl_core_init() - which is the function called before
> > > > mctl_mem_matches().
> > > > Can you move that dsb(); into mctl_auto_detect_dram_size(), right
> > > > after
> > > > the mctl_core_init() call (where you add the udelay() below)? And I
> > > > wonder
> > > > if a dmb() would already be sufficient?
> > >=20
> > > Sure, I will try experimenting with it.
> > >=20
> > > > I noticed recently that the clr/setbit_le32() functions don't have a
> > > > barrier at all, maybe that should be fixed instead?
> > >=20
> > > I haven't done much of the low level programming myself. Mostly have
> > > done user space
> > > programming along with fixing minor kernel module compilation issues
> > > due to kernel api
> > > changes. So I wasn't sure what all places to debug. But if you point
> > > me to places with
> > > things to try, I surely can give time playing around testing the
> > > proposed fixes.> >=20
> > > > > @@ -623,6 +623,8 @@ static void mctl_auto_detect_dram_size(struct
> > > > > dram_para *para)> > > >=20
> > > > >       para->cols =3D 11;
> > > > >       mctl_core_init(para);
> > > > >=20
> > > > > +     udelay(50);
> > > >=20
> > > > The location of that udelay() looks a bit odd, any chance that belo=
ngs
> > > > at
> > > > the end of mctl_channel_init() instead? And how did you come up with
> > > > that
> > > > and the value of 50? Just pure experimentation?
> > >=20
> > > Before adding the udelay, I added 7 print statements to print all the
> > > members of the para
> > > struct. That itself solved the issue along with the dsb added to the
> > > top of the mctl_mem_matches
> > > function. This is what gave me the clue that a delay is needed there.
> > > The value of 50 is
> > > indeed from pure experimentation
> >=20
> > Oh, I found one major difference between BSP and mainline driver. Please
> > test patch attached below. I don't know if this path is always taken wh=
en
> > wrong configuration is tested or not.
> >=20
> > Best regards,
> > Jernej
> >=20
> > --- a/arch/arm/mach-sunxi/dram_sun50i_h6.c
> > +++ b/arch/arm/mach-sunxi/dram_sun50i_h6.c
> > @@ -420,6 +420,7 @@ static bool mctl_channel_init(struct dram_para *par=
a)
> >=20
> >                         (struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BA=
SE;
> >        =20
> >         struct sunxi_mctl_phy_reg * const mctl_phy =3D
> >        =20
> >                         (struct sunxi_mctl_phy_reg *)SUNXI_DRAM_PHY0_BA=
SE;
> >=20
> > +       bool ret =3D true;
> >=20
> >         int i;
> >         u32 val;
> >=20
> > @@ -537,7 +538,7 @@ static bool mctl_channel_init(struct dram_para *par=
a)
> >=20
> >                         debug("DRAM PHY DX%dRSR0 =3D %x\n", i,
> >                         readl(&mctl_phy->dx[i].rsr[0]));
> >                =20
> >                 debug("Error while initializing DRAM PHY!\n");
>=20
> So those error messages (and the ones before them, not shown here) look
> odd: if I follow the code correctly, this here is the only place which
> makes mctl_core_init() return false. And we rely on it doing so up to
> three times, to detect the proper rank and bus width, in
> mctl_auto_detect_rank_width(). So we should not have dramatic error
> messages (even for debug), as they would occur during normal, eventually
> successful setup as well.
> So shall we tone those messages down? I'd suggest to change the
> "Oops!..." comment into something saying that we detected a wrong
> rank/bus-width setup. Also removing the pointless PLL debug print
> (since the failure is not DRAM clock related), and also the final error
> message (the last line shown here). I will make patch for that.

Those messages are remnants of old behaviour. In the past, code first
enabled dual rank and 32-bit lanes. If that failed, it analyzed error
messages and in second round only enabled supported features.
However, that proved unreliable, so I changed code so it simply tries
every combination and uses whatever works first.

In any case, I concur that these messages might not make sense anymore.

>=20
> But regardless I doubt that this patch is doing anything: when this
> function returns false, we set new rank/width parameters, and call
> mctl_core_init() again, which starts with mctl_sys_init() resetting all
> DRAM controller registers, which I actually wonder is really necessary.
> But surely any register setup after that point above is useless, with
> the current code.
>=20
> Does that make sense?

My concern is that code after failure might put controller or DRAM in
initial state which may gave more time for next round of attempts to
init DRAM properly. It may also be the reason why initial approach didn't
work reliably.

I'm fine with current approach if Gunjan confirms that initialization
works reliably.

Best regards,
Jernej

>=20
> Cheers,
> Andre
>=20
> > -               return false;
> > +               ret =3D false;
> >=20
> >         }
> >        =20
> >         if (sunxi_dram_is_lpddr(para->type))
> >=20
> > @@ -553,7 +554,7 @@ static bool mctl_channel_init(struct dram_para *par=
a)
> >=20
> >         writel(0x7ff, &mctl_com->maer1);
> >         writel(0xffff, &mctl_com->maer2);
> >=20
> > -       return true;
> > +       return ret;
> >=20
> >  }
> > =20
> >  static void mctl_auto_detect_rank_width(struct dram_para *para)





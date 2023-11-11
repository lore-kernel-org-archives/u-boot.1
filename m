Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76DAC4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 07:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E86886F5E;
	Sat, 11 Nov 2023 08:50:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I1F6CWGv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 569DF86F63; Sat, 11 Nov 2023 08:50:40 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BC0886D3C
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 08:50:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4084b0223ccso20105595e9.2
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 23:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699689038; x=1700293838; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dou11kROq8kA3YzG8Rq2+F5mKb5nOn4fGD68oMUViMI=;
 b=I1F6CWGvZHqXD+UnFu+Fo0KnjAjiSmeTn4cyeLF3UaXt2pY/p6vu5efVjXibCd6x8G
 XTHH/otr8HRi2xWku+M8EDyVJ2N/Yk8yjRhOEpZAOfsx9BChLDw3jGFVg6jY9H+vL1o8
 QEGCXDdrOhyBrDIx+kYvCqrfMVc39g3j4aaumb5nUJF+e9aNZ8Vq7Bu2ryOT3Ab+tyl1
 Dg7KVZyebXgvemjCo/WiUxkj/J5wFP+OB74v4CwfzjisAequUCSQjNRLCpBYGH2s/LZu
 46qEW2z/Uu/QvlHzvYYkb9QHStPzQznqXZM8duUQ6oQ4cmeVi1MxK2JAsoTeaIpgM6Gc
 xtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699689038; x=1700293838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dou11kROq8kA3YzG8Rq2+F5mKb5nOn4fGD68oMUViMI=;
 b=uuPQEpy59Aqe9O0juFcJXLCTiTKTDvD17KeahlIb0m+Qguvhm3SAulMFGB2ukpS1k0
 kSvaSvi7nDQtYTLEPdM0Z1sHDe4ugNIPBRgszM0TinLt5YhKKxK1PeMqYzUq2VrZ7M2O
 z+MHiAH2AJoVopNNNyhZG935qCQoI6QWPTfq6aoyMcPfjzfSzCj7T2a4CHe8BnDCzrP4
 w/nl57kb0NWKk9RzhT+AuVT2ql47KxYeNMJaFpeFVY6HSyVQsOWologEGXicOYrz0ZpL
 ofIqTciTu8mzd/nlnLVVGKC0v/3Y0DwKHFMZQZPBsGzHC9DnrCbHegpQagJXEYVUooUZ
 l18w==
X-Gm-Message-State: AOJu0YzWbvYVlA3ZHa/pOHbHfxIFnS5vCCOWwEoBpkMiL10kIVGoXdIO
 DxnhWQnv1yf39RUJaneTdp0=
X-Google-Smtp-Source: AGHT+IFu+vL/CLk6KDbRR85zy1gK6ng9scfGhUoRG+hqF4qxjER2ysoSdeQU8EwDda76A+ae44Za9Q==
X-Received: by 2002:a05:600c:3543:b0:409:5a4e:512b with SMTP id
 i3-20020a05600c354300b004095a4e512bmr1018977wmq.18.1699689037620; 
 Fri, 10 Nov 2023 23:50:37 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net.
 [82.149.12.148]) by smtp.gmail.com with ESMTPSA id
 z14-20020adff74e000000b0032f7865a4c7sm951065wrp.21.2023.11.10.23.50.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 23:50:36 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/1] sunxi: H616: add LPDDR4 DRAM support
Date: Sat, 11 Nov 2023 08:50:36 +0100
Message-ID: <12318958.O9o76ZdvQC@jernej-laptop>
In-Reply-To: <3ff938ac-35c0-4705-86f7-819060ebb2d6@gmail.com>
References: <20231104062248.32938-1-iuncuim@gmail.com>
 <2211206.irdbgypaU6@archlinux>
 <3ff938ac-35c0-4705-86f7-819060ebb2d6@gmail.com>
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

Dne sobota, 11. november 2023 ob 08:43:22 CET je Mikhail Kalashnikov napisa=
l(a):
> Hi Jernej,
>=20
> On 04.11.2023 11:31, Jernej =C5=A0krabec wrote:
> > Hi Mikhail,
> >
> > I have some notes on LPDDR4 from a long time ago. It mostly matches to =
your
> > code, but please take a look at comments below.
> >
> > Note that I have extra code, not included in this patch, for
> > mctl_phy_read_training(). At the very beginning, before any other regis=
ter
> > access is done, this should be added:
> >
> > if (para->type =3D=3D SUNXI_DRAM_TYPE_LPDDR4) {
> > 	writel(0, SUNXI_DRAM_PHY0_BASE + 0x800);
> > 	writel(0, SUNXI_DRAM_PHY0_BASE + 0x81c);
> > }
> >
> > Maybe that will help with other LPDDR4 boards?
>=20
> Current H618 and t507 boards do not yet require this feature. Yes, this
> feature may be required for future devices. I will add it in the next=20
> version.
>=20
> >> @@ -246,8 +251,13 @@ static void mctl_phy_configure_odt(const struct
> >> dram_para *para) {
> >>   	uint32_t val_lo, val_hi;
> >>
> >> +	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x390, BIT(5), BIT(4));
> >> +	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x3d0, BIT(5), BIT(4));
> >> +	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x410, BIT(5), BIT(4));
> >> +	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x450, BIT(5), BIT(4));
> >
> > I don't have above block. Something from newer libdram? Is it applicabl=
e to
> > all DRAM types?
>=20
> This function is present in the RE code for all types of memory. Binary=20
> file dumped from orangepi zero3 nor spi.I paid attention to this area=20
> code when comparing the sunxi u-boot dump (md.l) with the resulting=20
> mainline u-boot. Now I checked my tvbox with H616 and LPDDR3 and it=20
> doesn't have this block. In this case, maybe it would be better to make=20
> it only for devices with LPDDR4?
> >> +	case SUNXI_DRAM_TYPE_LPDDR4:
> >> +		writel(0x0, &mctl_ctl->mrctrl1);
> >> +		writel(0x80000030, &mctl_ctl->mrctrl0);
> >> +		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> > I don't have above block. Maybe difference from newer version of libdra=
m=20
> > code?
>=20
> This block was present in the sunxi t507 binaries for which the driver=20
> was originally intended.  Now I checked original dump from orangepi zero3=
 NOR SPI.
> This is also present here.
>=20
>=20
> >>   	writel(reg_val, &mctl_ctl->odtcfg);
> >>   	writel(reg_val, &mctl_ctl->unk_0x2240);
> >>   	writel(reg_val, &mctl_ctl->unk_0x3240);
> > I have extra "writel(BIT(31), &mctl_com->cr);" after this block for all=
 DRAM
> > types. Not sure if it changes anything.
> Looks like this has already been done in previous patches.
> >> +	u16 trfc	=3D ns_to_t(280);
> > My notes say 180 instead of 280. Did you check if register value matche=
s if
> > booted with boot0
> I booted from NOR SPI of the sunxi u-boot and made a dump with md.l=20
> 0x047fb064. It show me value 0030006f, where 0x6f trfc value. Based on=20
> the transformation function - 111*1000/(792/2)=3D280,30(30) So, obtained=
=20
> value looks correct. Best regards,
> Mikhail

Ok, thanks for double checking. I think next version can be merged and then
issues can be fixed if they appear.

Best regards,
Jernej




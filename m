Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DDFC369AB
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 00:16:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2510E81D5D;
	Fri, 25 Apr 2025 02:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IEGyh4jE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E615B8082A; Fri, 25 Apr 2025 02:16:49 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1451809D4
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 02:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-601b6146b9cso917661eaf.0
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 17:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745540205; x=1746145005; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=J7TgQNLV8oUzYOc4sHa8i6t2Zy1D2XsFHt+K66XytwQ=;
 b=IEGyh4jEclriSZEHWcns5vGi19o+hd8EyNKNyHYX5BuA16FXv8y8WvIfD74UzxC2c8
 NLdCWrjcY0d4nalKow3S0RZiJMIf5hRxHUPp1GoFkCuibEOKwGdxSglZZT9IEJ93SZUx
 ld2cdxfIluwa53cSR9P8NVABntHwDFL8lcuCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745540205; x=1746145005;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J7TgQNLV8oUzYOc4sHa8i6t2Zy1D2XsFHt+K66XytwQ=;
 b=XbHr7PF7H9fhl4IpPvY4bSzMrj1WmD0F4WxMSnBjsB61Dz44serX88rHD98vcBIIIa
 Uac2JB84KfjsZ/PoM73smvPneJRbI39G29QADmKRRxvLoasN6uwEpY5yxCktjPNRBjaA
 P9/VCw6fb3JmM4FCNCRoztKFVfW64f12tXye6k2Z80BZDxS5namY+cr0pqo9p5EPHf0S
 uv7tLSr/idIsiiEDlZSyIuNbbluivQdRd5Aj6yZ3YrJBBrCynd/Em+T7b6Qp3wLv9V+8
 5ctG3DhsKjLPLYMVYSfku9W9aLgvYP42dpBZDiZT0KtjeDFIsDc1FUF9EH4auxS1yo6x
 gxwA==
X-Gm-Message-State: AOJu0YzqyTkiGsw14Q321MOR0bzX88Dbugn9bWzBDaq7BgQybdlwlvNf
 oINKFE8/UK9BCRqHIH1GR/XKMjBldusqJUgJfKFtNobEiBayyWRE7YgdgpAqWNg=
X-Gm-Gg: ASbGnctIQnaz8ZaCNfthvete0Slta51JL9bqpojguVtYJ3h+Mi2XlVfgsmXcLtsj7XY
 n7kq2OtvSGDhIz1Vp2hb1bba5VBnWxndV6RFhXfgzYUaWK6OD7mTU5NWltXRnHS37s+VGjLqKG1
 04lU94df3nOE1ZRWXUYjA/2Mg4TR6NKkbigebdGsYlU7OvzHs3n+eLsGKS1LMNd78UGznE1ofth
 e6hVx+VdeJvOBIliSIMByUfU5gnGoFmDlSJ/WVPHsj0Lg/SmDCG+HcpQMMY6mP8nAvYIzsDlAhZ
 cpfN2vwrE9FxQSdadvPRCz4hmRTvvOQbhuMH45OqngIcaY5ggSt9ZTc4Ld5sH2CzBFwxJbgE9U5
 jEg==
X-Google-Smtp-Source: AGHT+IHS04776ScAg6QyLKvAYjSO3i/8HBDFtdLVf2jHq0NG/egHLE0B6wYwriiPQpAs0w6VFRqEKw==
X-Received: by 2002:a4a:e904:0:b0:603:f777:980a with SMTP id
 006d021491bc7-60652bc9b0amr133188eaf.7.1745540205561; 
 Thu, 24 Apr 2025 17:16:45 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-606468816d6sm476143eaf.12.2025.04.24.17.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 17:16:44 -0700 (PDT)
Date: Thu, 24 Apr 2025 18:16:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: Maintenance of Python tools
Message-ID: <20250425001642.GR5495@bill-the-cat>
References: <CAFLszTjnXQu3bwWt3Do7S_Vu0UO5si4HRUeW9bv0981WbUn_7Q@mail.gmail.com>
 <20250423140850.GE5495@bill-the-cat>
 <CAFLszTgBbh8F93peSC6JO+02BLGNYnRv8fgQTSW-E3xmhsY9ZQ@mail.gmail.com>
 <20250424185515.GP5495@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q+TtepzOWfadX/4p"
Content-Disposition: inline
In-Reply-To: <20250424185515.GP5495@bill-the-cat>
X-Clacks-Overhead: GNU Terry Pratchett
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


--q+TtepzOWfadX/4p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 12:55:15PM -0600, Tom Rini wrote:
> On Thu, Apr 24, 2025 at 12:34:23PM -0600, Simon Glass wrote:
> > Hi Tom,
> >=20
> > On Wed, 23 Apr 2025 at 08:08, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Apr 22, 2025 at 05:39:30PM -0600, Simon Glass wrote:
> > >
> > > > Hi,
> > > >
> > > > Tom has indicated that he would like Patman to move out of his tree=
=2E I
> > > > suggested on another thread[1] that I maintain it in my 'sjg' tree,=
 so
> > > > here is a new thread to discuss this.
> > > >
> > > > I have already done this for the qemu/efi/coreboot scripts as Tom h=
as
> > > > NAK'ed patches for those.
> > > >
> > > > For the other tools there is going to be quite a bit of churn, as I
> > > > would like to resolve most of the many Python warnings.
> > > >
> > > > Given the shared source between the tools, it would be easier for me
> > > > to do the same for buildman, binman and qconfig. I am thinking that=
 I
> > > > might try a move to allow Gitlab pull-requests for reviews on these=
 as
> > > > well as the mailing list, if that is useful.
> > > >
> > > > For tools which need to sync back to Tom's tree (i.e. not patman), I
> > > > or Tom could do a pull request every now and then, omitting any
> > > > changes that relate to pylint.
> > > >
> > > > Please let me know your thoughts. The timing is good as I am going =
to
> > > > be sending out a new Patman feature in the next few weeks and it is=
 a
> > > > few thousand more lines of code.
> > >
> > > My biggest objection to all of this is that you should NOT use
> > > sjg.u-boot.org as that perpetuates your abusing owning u-boot.org. As=
 I
> > > said in the thread, it should be under https://source.denx.de/u-boot/
> > > somewhere and you should be the one to own it there.
> >=20
> > I wish you would stop bringing this up. Until things change, that is
> > unfortunately what I have to do, to avoid being blocked.
>=20
> I really wish you would stop holding the project domain hostage. I will
> not stop bringing up that you are holding the project domain hostage
> because you are holding the project domain hostage.
>=20
> I am in fact getting close to my breaking point of you and your holding
> of the project domain hostage.

And since you don't like me pointing this out, would you transfer the
domain to either:

- Myself (the head of the project)

- DENX (whom I am volunteering on the spur of the moment, sorry) who
  otherwise run the projects general infrastructure

?

--=20
Tom

--q+TtepzOWfadX/4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgK1GYACgkQFHw5/5Y0
tyzEfAv/XtL8Q1ZFzGSEJNVcStWaUINOu3xqBiQAYvjZO2QcDs3w91zBmBImAzx6
uRE1C7ojSR0hmgrxg+hZBov/5eX3VaeUHBATjp173eMaCRKL3Gq6IfLZ5hRnogm8
GHb/SzNB1DlUQRIbwcJ8HdvUGBX0R0Lc57N+Zhm4kAt0yiQLfl2pkyNYAw6RSdOF
X8h2Mb3Jo+yBs4L4l5/NvYiXQkveweFeSJeItSFdGuRWDZa63rPeztG2SNk7vOxr
nJP+D7yWtuxYh7RsRdZe/2gCllyWJzIOqhcu5khN6kN/3LK4vdrUF2KgnMlO7k9z
bEg5dPhyGK6z9NB4ulyRByYE+LHa9Z0FBtYfsbGWz5SepF0JFYYmIInMqgr2FJRP
fuz3bB25FlxXGSw0PM+f98wkq0OKOjd/Uurj2Cz+4nGuhL3q6W1qIpQ7xWYUYtX3
G+XaIllFGjIdZ2oDLiOS6W/dWUsDp4qbrsHHORzWSJenKQEh6z/yW8u4scww3Hx2
gyAY2gmG
=T9k5
-----END PGP SIGNATURE-----

--q+TtepzOWfadX/4p--

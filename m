Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2707ECD37B6
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 22:32:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9221788B12;
	Thu,  5 Sep 2024 00:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fqxtncoN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55D4788B8E; Thu,  5 Sep 2024 00:32:38 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16B48881C1
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 00:32:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6c35334dfb1so812476d6.0
 for <u-boot@lists.denx.de>; Wed, 04 Sep 2024 15:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725489155; x=1726093955; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dvnDcF+ZP/eQXA1cS7FIKii5dhvw+J5ewcteJI8pJcg=;
 b=fqxtncoNMLeDJDa4OVE4ercvzphpBoDrTPP1JP8FzqVEUSD9srk9nt2KCxb2W85ep1
 h1Qs6v9Z+JUGx0V6Ai+ma4VmbUgdRkwe65d+Wu1CC6B7M4ri6Mn8yTLEXh8hu3dTem4p
 xc36djVxFdtcaAH7GWTVVFc/QndKFv1pZ2BNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725489155; x=1726093955;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dvnDcF+ZP/eQXA1cS7FIKii5dhvw+J5ewcteJI8pJcg=;
 b=TDlZYknDArDTqkFAuMCyTupu8SIsPekeZhTYsCAzUslUkc8p75WlMpcg8Q6D3jVfnS
 NQ2E5g+NQMZyylnN2CbfcqCSqhYsBykYCPrsttjMwkYbrFED2RrLue3szlwqaCLgsMpr
 VxRJBVuy4qVH0XlSeC30nNk9RGJukE6oaiWUIDQdd4j8yeQw0hXmF0KbjpJWWT6JOE7L
 MhMbNxQgcuZHBd9ket11wTS7w64r3nRcTb8jEb7JUQXaFoOj6cfggcU7LnI+L91Vi4pA
 Ykj1i190ZZpEKhbTaicEnbeLfCzvtgVc+7OVTL3miXSY2ePJiFVYinR7OuJfYLIy0Gqa
 I8gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj0ZEd/phymbp1o21T9RgddagWKOhV9RonHNfB1W4qQcsBHnONr9pf8ad0x2eG7yXMApUISjo=@lists.denx.de
X-Gm-Message-State: AOJu0YzKjfbgm+BxE4a7p7kgwdcLwRVtnZdEajadPZtQD8DA+ubLQjiW
 ZvTWQOPodKMa1Tql1/Umy3zrMbB9bo1aK6kOhlgU8M9kOG8ZQsOvauOECxBReYI=
X-Google-Smtp-Source: AGHT+IGM5y2XCqk7wgUIcSlXT6xDKtwnLTu6oigW/mrZUJtx8seVKySH13TUFVLJcNtVuAfqD27BIA==
X-Received: by 2002:a05:6214:4805:b0:6c3:6455:85df with SMTP id
 6a1803df08f44-6c364558786mr113318556d6.44.1725489154802; 
 Wed, 04 Sep 2024 15:32:34 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c52041874asm2501816d6.113.2024.09.04.15.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 15:32:34 -0700 (PDT)
Date: Wed, 4 Sep 2024 16:32:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>, Anton Antonov <Anton.Antonov@arm.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>, Greg Malysa <greg.malysa@timesys.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH v9 35/37] [TESTING] Kconfig: enable NET_LWIP by default
 except for SANDBOX
Message-ID: <20240904223230.GC2479150@bill-the-cat>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
 <1629f6845b448edcdead09a9350f1ae2ae7a4bb6.1724419624.git.jerome.forissier@linaro.org>
 <CAFLszThJzVvHSd+dEjTSff2DUPPaQTGWeyCmHmP56Vtjr0WF-g@mail.gmail.com>
 <d2465352-66ea-400c-9216-a92ce5351475@linaro.org>
 <CAFLszThp9Ya-doN39L-uv6C_oZsw454PUiUfOZmYa7wHjoz+oA@mail.gmail.com>
 <CAC_iWjJ1aACnb2u+6+k30ATr6UAwkBQ++2syXy6xR5sSvzq4rQ@mail.gmail.com>
 <CAFLszTh-5o8hEv47+jb2od=xQxMhjOGpG0qC_PjL5XkLx5nM2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bwJiNvhLMdYkL4Eo"
Content-Disposition: inline
In-Reply-To: <CAFLszTh-5o8hEv47+jb2od=xQxMhjOGpG0qC_PjL5XkLx5nM2w@mail.gmail.com>
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


--bwJiNvhLMdYkL4Eo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 01, 2024 at 02:09:43PM -0600, Simon Glass wrote:
> Hi Ilias,
>=20
> On Fri, 30 Aug 2024 at 03:27, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Fri, 30 Aug 2024 at 03:59, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Jerome,
> > >
> > > On Thu, 29 Aug 2024 at 10:21, Jerome Forissier
> > > <jerome.forissier@linaro.org> wrote:
> > > >
> > > >
> > > >
> > > > On 8/29/24 16:05, Simon Glass wrote:
> > > > > Hi Jerome,
> > > > >
> > > > > On Fri, 23 Aug 2024 at 07:50, Jerome Forissier
> > > > > <jerome.forissier@linaro.org> wrote:
> > > > >>
> > > > >> Enable NET_LWIP by default for testing purposes. SANDBOX doesn't=
 support
> > > > >> NET_LWIP so default to NET in this case.
> > > > >
> > > > > Sandbox needs to support NET_LWIP.
> > > >
> > > > I agree in principle, but AFAICT it is not a trivial task. Does it =
have to
> > > > be done in this series or can it be dealt with later?
> > >
> > > Does it build OK with sandbox? We use it for almost all of our feature
> > > development and testing, so I cannot imagine bringing this in if it
> > > doesn't work. How did you develop this feature?
> >
> > sandbox is deeply rooted into the old network stack. It fakes ACK
> > responses, handles the ping request/replies with the sandbox ethernet
> > driver etc. I was looking on adding LWIP support for it, but it's not
> > trivial and I don't want us to add another hacky 'glue layer'. Since
> > LWIP is a big feature on its own -- and is working on real hardware
> > and QEMU, we discussed adding it, so people can test and contribute
> > fixes while we fix sandbox.
>=20
> At the very least it needs to build on sandbox.

It builds with sandbox, one of my tests is to switch the global default
to lwIP and make sure nothing blows up.

> I am not sure what tests LWIP has. The U-Boot networking tests are
> very simple on sandbox. The test provides a handler to generate a
> packet that it wants, then does a networking operation. It should not
> be hard to plumb that through.
>=20
> I am nervous about this going in with an intention to fix it up later...

We have two flavours of tests. One is the sandbox-specific state
machines, and the other is functional testing. This series passes
functional testing while adding another functional test (for wget). I'm
quite fine with having sandbox figure out lwIP be a later TODO.

--=20
Tom

--bwJiNvhLMdYkL4Eo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbY3/4ACgkQFHw5/5Y0
tyydTwv9GRz05mkCUufRX4mUszhtYWqWojyJ+04R8puCxX4cEzE6XPoL2Z3X4tqt
Fl794oOJ0elqQ+d3dAhqjlLMgLKZmBXELUVmY2I6yFdbv26dH1LP2r3am07h5upw
ayj/diFMmQvbhJZr8fih8YwyKutz3CZWFoPzv369l9QBAntIv1eLKqlpLN/DWLhi
AeYUiUhoFFK8T3ToNqpHpeu6mtwCtDBQWKqVQDmNH23uaGDaVPmj/i3iF8N+4pt6
i7BFuxgYTIrnKKAlKYSxjiuK6yHRo+aPJerdH0+0zJXSaCHXeXCEV7sbnLg86xZo
0580vqTMZjgvirGSJ5VT+0cV+mryy2iV3iDxNBjK1khRstNZaXLN3eGL7bednFpM
OclarruD04dUX4e9AYbFIcFiGSNsC94OR4OI0iG9x7NCXztAmuYCAxc18OXUgGDS
LRqbQ7IEckFboYGR0nswO5Y0PqrzQKcmTt7UpkLVukJOAsK1YID0cbdz26GI8msS
GXJ5YGGn
=TzRH
-----END PGP SIGNATURE-----

--bwJiNvhLMdYkL4Eo--

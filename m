Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA88CA0ECC
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 00:49:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69BA788D06;
	Fri, 30 Aug 2024 02:49:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iyLQmZcw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9365488D1D; Fri, 30 Aug 2024 02:49:46 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A032288914
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 02:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4568571de47so5438041cf.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 17:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724978982; x=1725583782; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CJlfLXfvFykYvlEoWO/9Ds/e2ayXQBN9Zd0YqJOmEd8=;
 b=iyLQmZcw4yg9fVjdORzgAebwbGMLpo0HYos5Dw68GmlpyZ5OSM0E2tNlMe4O/bPF9P
 4ZzjHNW5CitfN8gc7Y9Gh2tN16/hWv6Iw//BIurDPorRRDBTgjyFeXhpThfn8aptDR9D
 fEK6/8Kkt5aBNmdOX/R6voN0a1twHggDHLClE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724978982; x=1725583782;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CJlfLXfvFykYvlEoWO/9Ds/e2ayXQBN9Zd0YqJOmEd8=;
 b=dyEckDub7rTwot4L/B0P3UmQZ7pvMqeY81JY03McPYYsMZCocJKC3iL5+FfDdeROHW
 wZ7lobl9D8BbbJMrS0/1+ZndtqzHtRLr3ECY8V4PNnLDmonl8oKHDT5G7MaKU+Bul/Au
 +gja5wvFnWNESkXSgeQDfcodwxWG8EOb0sl11kh7CV3bBJf/JunlWz7jAK0KKbeTeIZL
 zhNjIqljw6EA5WM7LPXtkR+BBdi5C8Q0XanuthUDxbyPFjNJ7W+q9hgFb3qMihUbHWUi
 iyfiq7ih2ATiUYEDBckGIGurvPMkG0mnrANQjjEwK2xq6EJuW4BHFDt99I0VnhSG4I14
 X4kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj4r7tuSHaucEjZa9Qswo4+9WsYWgBR9EO4ueqZEt3ZKpgIR7u3WJ9pY2nFHvrxclQs1LkXBQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+vZ1LoB6QG7StnfIyFFZbASPupgJ15+piqFMjM3JjdLrVRAIR
 b94p2h+egcipVjxZJsjBNNXUQcOLqD1TLOp5mk+unmRGRG0yYJ7Zio8E5fiqLc0=
X-Google-Smtp-Source: AGHT+IHhdueAUL/2BZN7XcylQWY9BMLCL2p43/UWdNHG/VLOdscWBz3g6eX6VdOu+RuNVo1ipPZ6pQ==
X-Received: by 2002:ac8:6f12:0:b0:451:d821:2eb8 with SMTP id
 d75a77b69052e-4567f6f79a7mr54291411cf.51.1724978982220; 
 Thu, 29 Aug 2024 17:49:42 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45682d67e19sm9538851cf.63.2024.08.29.17.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 17:49:41 -0700 (PDT)
Date: Thu, 29 Aug 2024 18:49:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Apurva Nandan <a-nandan@ti.com>, Bryan Brattlof <bb@ti.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Roese <sr@denx.de>, Tony Dinh <mibodhi@gmail.com>,
 Vaishnav Achath <vaishnav.a@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 huang lin <hl@rock-chips.com>
Subject: Re: [PATCH 00/18] vbe: Series part D
Message-ID: <20240830004936.GP2479150@bill-the-cat>
References: <20240828014538.3322013-1-sjg@chromium.org>
 <CALeDE9MX6MMECX+vNCjMs8Z2_G3+gSio4BxFHgez-H_a4f2Uyg@mail.gmail.com>
 <CAFLszTgrCGhvhO0GDSLABu1D10H97dBWFSnEf8gSJujq6iUduw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZgE/e8Uwu2O6f1Rm"
Content-Disposition: inline
In-Reply-To: <CAFLszTgrCGhvhO0GDSLABu1D10H97dBWFSnEf8gSJujq6iUduw@mail.gmail.com>
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


--ZgE/e8Uwu2O6f1Rm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 04:16:55PM -0600, Simon Glass wrote:
> Hi Peter,
>=20
> On Wed, 28 Aug 2024 at 03:59, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> > Hi Simon,
> >
> > > This includes various patches towards implementing the VBE abrec
> >
> > What is abrec?
>=20
> It's a VBE method which supports A, B and recovery images and permits
> updating from SPL onwards. The idea is that you can safely update
> without bricking a device.
>=20
> >
> > > bootmeth in U-Boot.
> > >
> > >
> > > Simon Glass (18):
> > >   sandbox: Add missing header file
> > >   bootstd: Add stub for bootdev_setup_for_sibling_blk()
> > >   gzip: Correct function comment for gunzip()
> >
> > Is this from upstream gzip code somewher?
>=20
> I'm not sure, actually.
>=20
> >
> > >   fdtdec: Support separate BSS for all XPL builds
>=20
> Needed so that VPL can use DDT
>=20
> > >   tiny-printf: Correct return values
>=20
> I can't remember, sorry.
>=20
> > >   tpl: Support numbered aliases in device tree
>=20
> The MMC needs to be accessed using its sequence number
>=20
> > >   ram: Support driver model in TPL
>=20
> That should say VPL...but again I'm not quite sure
>=20
> > >   serial: Support debug UART in TPL
>=20
> This allows debugging of the jump from TPL to VPL
>=20
> > >   armv8: Support not having separate BSS
>=20
> VPL doesn't want a separate BSS since SDRAM isn't available that early
>=20
> > >   arm: cache: Drop a stale comment
>=20
> Just something I noticed
>=20
> > >   arm: Fix up a stale comment in sections.c
>=20
> Another thing I noticed
>=20
> > >   mmc: Support driver model in TPL
>=20
> TPL needs to read VPL from MMC
>=20
> > >   mmc: Add more debugging for SPL
> > >   mmc: Log the error when init fails
> > >   mmc: rockchip: Log some error returns
> > >   mmc: rockchip: Allow clocks to be missing
>=20
> These all help with debugging reading of VPL from the correct MMC device
>=20
> > >   rockchip: mmc: Fix a missing colon
>=20
> Just something I noticed
>=20
> > >   rockchip: Provided SPL control over efuse presence
>=20
> We don't want this driver in TPL or VPL
>=20
> >
> > I'm not sure what most of these patches have to do with VBE?
>=20
> Basically there are a lot of little tweaks needed.

Well, I think this gets back to some common feedback. You have a lot of
little bugfixes, which is good, but they get sprinkled in to the next
big series you post, which is bad and hard to review. And that leads to
fixes not getting merged / reviewed timely because nominally simple fix
A is in part 3 of a series to introduce something larger and to which
there is feedback to work through.

--=20
Tom

--ZgE/e8Uwu2O6f1Rm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbRFx0ACgkQFHw5/5Y0
tyyoQQv9GXC2LxpvU3a1kWybgeCpV8SwYLiLQflGw7V3Gdv8B3NCaz0Wh1Oh4b9f
ZHPImIceJpCrl484EDzsnIHfMzREqOw4Ki+0GXPQhs5EgK4HZz4ltyrxvEkLpZ4F
wkCKo1SAKm1pWxAwk5d6N+SUPHVxhrmDBQ5I1v5MBpHayJ0hHkVXrAhwKIInBJfz
gSiNr9y1WtG/FwHr2P3wLLMmYF9PeadSr2fauWSF1HXP/Dq0GO/oOI9+0W9/Fx3x
LlOs0PJ9vM5Zlp605YeejKgFQhL2qy9Fof1ZGpqCNX2Ms+S1LvbiXj+Xnrimu5/1
elZKBLiRlFU+D6WLuKF4CaSp4Z/B610quptW1yAijNVxHbLklAD7PREt//Lbhqal
fOWyAA4DfkuySBgnwAykWi0FIdfM2r2UFzYgwFHzuRsHb1U5zE6FtafGs+LjiSps
JspOx8357ToAcOJpjxAcLQJu6j1JFKfmjeaQzx6nAobGrv+oIsh8p3Wc7TC8gjMc
ch9ZE8mb
=DPLL
-----END PGP SIGNATURE-----

--ZgE/e8Uwu2O6f1Rm--

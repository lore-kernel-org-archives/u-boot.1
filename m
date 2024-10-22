Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD50CDD0CB
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 19:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C67A89286;
	Tue, 22 Oct 2024 21:02:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rfFy4/e4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63580891E9; Tue, 22 Oct 2024 19:29:23 +0200 (CEST)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C80E8904E
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 19:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-84fc0212a60so1535016241.2
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 10:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729618160; x=1730222960; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=41PmUGYMqxIldxuh0hIT/DG41DTNJUSPWmhdCXpSoJQ=;
 b=rfFy4/e4D06eYgS8se31iUpfGdlyK4HNCCB7Pd2xIPn0CAS0eqVqUO5SVwl7d6ph+7
 ySNu97UkZzZ4COlY3+dA3yceKVOlSnKItQDH1q4FGmtRo/4xZhf+wllLcIrzQC8ilerB
 qOZs7eYac98LYJh56Od/V1CTJknHXn9uLO7s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729618160; x=1730222960;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=41PmUGYMqxIldxuh0hIT/DG41DTNJUSPWmhdCXpSoJQ=;
 b=jXndwCgOC2UQ0jaTsCGxWO0rcr3UdSXxWCc2WAZENly81PctR/s6M4SlN/suowQwWo
 8yLOIWYQ/AInDosrMUciIitLq0ssL9BYnzk2YDnIkKpgL0a3ZPzexu0q7JdE5HguLYlA
 MEOySH82iDzXjeNM6XSI5ognshYAoUeWDbiTPd6viDQi3m5QT6v4JFjMCS+BZZDKn6P7
 YElhVUhSAx/ZAQJ8eqwY6BkqGft9mJfUpY9MByYNGh7iz8EUdqEu/iHrkZLyOdRde2LC
 JNdlBl8/oIcITaGX2ZrHSv07V3z2tS2WYg0thHbRl50dJMOrLPPvUhyBp4VZimq1BMAa
 7qng==
X-Gm-Message-State: AOJu0YwDNWCOU7ev2mnvv2sbnl1IRZMb9lY66IjI0+LdOwcPRXrZxYJF
 yaFMHeelV84mv5I4BhgqhgRSL5Q/1mbyieoK33QWvhKTGW2zfsjRsdJ5x1J/AsA=
X-Google-Smtp-Source: AGHT+IFieOgoQWUpXgt6VXMwVjIKHe80b8BBHFK/+283RL5sKYTet2D3N1q+qcBkF5kRYx16ip5ACA==
X-Received: by 2002:a05:6122:2a09:b0:50a:49d1:f1f with SMTP id
 71dfb90a1353d-50fb62cf120mr3610792e0c.13.1729618159962; 
 Tue, 22 Oct 2024 10:29:19 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1659e614fsm298916285a.48.2024.10.22.10.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 10:29:19 -0700 (PDT)
Date: Tue, 22 Oct 2024 11:29:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Alexander Gendin <agendin@matrox.com>, Alison Wang <alison.wang@nxp.com>,
 Andre Przywara <andre.przywara@arm.com>, Andy Fleming <afleming@gmail.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Angelo Dureghello <angelo@sysam.it>, Artur Rojek <artur@conclusive.pl>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Charles Hardin <ckhardin@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Doug Zobel <douglas.zobel@climate.com>,
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jens Scharsig <esw@bus-elektronik.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kamil Lulko <kamil.lulko@gmail.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Mario Six <mario.six@gdsys.cc>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sam Edwards <CFSworks@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Sean Anderson <seanga2@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Wolfgang Denk <wd@denx.de>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 00/25] led: Remove old status-LED code
Message-ID: <20241022172912.GG4959@bill-the-cat>
References: <20241021113839.318572-1-sjg@chromium.org>
 <20241021172613.GN4959@bill-the-cat>
 <CAFLszTguu7hRpsSLxADsBkMgTzA_-fAR0t8Axv+8=OvxJvSRCw@mail.gmail.com>
 <20241022140204.GY4959@bill-the-cat>
 <CAFLszTj92aehOTfy_MJmaS316jRs5yYgDKFA5htOoSZs1=faNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Pqe38mgScmr8731+"
Content-Disposition: inline
In-Reply-To: <CAFLszTj92aehOTfy_MJmaS316jRs5yYgDKFA5htOoSZs1=faNQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 22 Oct 2024 21:02:05 +0200
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


--Pqe38mgScmr8731+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 07:00:46PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 22 Oct 2024 at 16:02, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Oct 22, 2024 at 02:15:34PM +0200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 21 Oct 2024 at 19:26, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Oct 21, 2024 at 01:38:08PM +0200, Simon Glass wrote:
> > > > > There has been an LED framework in U-Boot which uses driver model=
 for
> > > > > about 9 years now. Recent work is underway to improve it and prov=
ide
> > > > > more features. It is probably a good time to drop the old code, w=
hich
> > > > > is only used by 5 boards:
> > > > >
> > > > >    ./tools/qconfig.py -f LED_STATUS
> > > > >    5 matches
> > > > >    eb_cpu5282 eb_cpu5282_internal mx23_olinuxino pinephone
> > > > >    socfpga_vining_fpga
> > > > >
> > > > > This series attempts that.
> > > > >
> > > > > Changes in v2:
> > > > > - Combine code-removal and defconfig changes
> > > > > - Add a patch to enable LED and LED_BOOT for these boards
> > > > > - Add a patch to enable LED and LED_BOOT for these boards
> > > > > - Enable LED on the 5 affected platforms
> > > > > - Reorder patches for bisectability
> > > >
> > > > So I believe this means you missed the feedback of just doing the b=
lind
> > > > migration rather than disabling the feature, like we used to often =
do
> > > > for cases where it's just a matter of changing CONFIG options. It
> > > > should:
> > > > - Not introduce a failure to build
> > > > - Just work on platforms with either OF_UPSTREAM or semi-recent dev=
ice
> > > >   trees
> > > > - Just start working on those platforms when they do move to
> > > >   OF_UPSTREAM.
> > >
> > > Perhaps I didn't understand what you were saying. I thought you meant
> > > to enable LED and LED_BOOT on these 5 boards?
> >
> > Ah, OK, I see the disconnects now, sorry. The first comment I saw was
> > Marek's on patch #2. So yes, along with Peter's request instead of one
> > commit to disable and another commit to enable, just do 5 commits to
> > migrate from one to the other please, thanks.
>=20
> In order to maintain bisectability I need to delete some code in each
> of those commits. But if that is OK, then yes, I believe this is
> possible.

Yes, thanks.

--=20
Tom

--Pqe38mgScmr8731+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcX4OQACgkQFHw5/5Y0
tywHBQwAj8HaVqBt6h4MuCyFi+aNnN44V8dwjKr+K1CoFIsSUXdNju35n7a1HHOy
9kCgA1UEeTmvS6NuPIs4A2mGJ3fTwcVnEZ76mzQ6ncpLphQOjwz7IudevNZMchAp
GIfT56k0O8J1MMxMmQ90WQQ/loAIdhTpmJMVrc7SKIlbbJRWOv0ZcL+csxxcn9QE
y2bRCQJwKL+glxb2bNHiOgkbqgB13k9SHXUFuImditkYgnyJwq+QxGRL1SV1IIFl
2nTmlhombDDMyx15kvahLMyqdM40aZO+eolXpuaVOF0MJEXNOqvS/wPG0Zg0otjG
/JmVVS76qz6XaLOWGvyW9uXX1cKhdh7xds+KxC3WEEbRa7DP1xR8Sbs/FhrmFE+w
ilUyInU5dQt+MwyndiNOuHYvZTHkYTTVTpY2ZSo4whlD18m9ASveKON1WXLBfwou
Ttu9rwl2ljxSH4MN7j+IVUfJuT00SgKW5rx7ZcQqOft9FPcbg1P0JAYLzidxrjF4
Wj6DXZl6
=4XlM
-----END PGP SIGNATURE-----

--Pqe38mgScmr8731+--

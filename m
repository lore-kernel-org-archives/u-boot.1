Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE3ACDD0CB
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 19:02:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E2638904B;
	Tue, 22 Oct 2024 21:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pKorkPrF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ADD788FD9; Tue, 22 Oct 2024 16:02:18 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E42558928D
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 16:02:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cbcc2bd800so47216676d6.0
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 07:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729605733; x=1730210533; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MDqrSAgLtquIIl5qrpQ5H4AIocG47vtogseRe9yFmqU=;
 b=pKorkPrFB8+sexYHL2iyWqSWHJDQV3JwR2s2ptUWFByrIgWuzWHxFLFybzeKtoz/hD
 ViYdr9CWeXA44OvAA5jnY95kNQYAtCWO6M+5DTJaMQ97BWZ3nqd4kSKwuHgShzKNvWvo
 wrOdnI2ykqBCftFa8ELSzEkckXfvOEQ3CAYvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729605733; x=1730210533;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MDqrSAgLtquIIl5qrpQ5H4AIocG47vtogseRe9yFmqU=;
 b=sA5jfkSfIkiBqSmzICYzPm2Q77uTrfKVPUxY9kMnS3Z/vRm85zBMrHnnHhCs9BO8zc
 1Sci25DvrueD2lpkefe0k1ZQE77EwWwHlT5Hsw3q42rHNOgMbFMAKdJJdKTI9njb/kZd
 chut7Z4txwA4q+11UQC30zymZUutLggmdS7V085LjQkFD8ctFutnPI2L718/OepS8V1g
 60qCR/qhX50YxOeJozeOHiiQoid2QFRBQ8OGAozQ3HYamT7jJAPhHvmNO9arNThSvwH+
 1KGvZwrwrvJz0PYuFiTGAnJOhsyLX9Csyz6SGLN/HnrduhmOYOUW8Gi4LAVBsXiR4Xlg
 +myg==
X-Gm-Message-State: AOJu0YynnbAaEqxu5I1MwJby7zV/dq9EsaNrK2n8W1fiJcT0sbA8DJTQ
 4zAhWFlrEM0+uBafokswvflngSHLyrvsGPmcwaMwNJFG2UtGP2pVpbpGQH+mTbk=
X-Google-Smtp-Source: AGHT+IFu6v2NjXktFApedEIQ/6I0F4wo+kp7JCiI//65x5p3IfpdhE+AXsDyo3myjaVp2Q/8+NGcDw==
X-Received: by 2002:a05:6214:130c:b0:6c3:6477:16e7 with SMTP id
 6a1803df08f44-6ce21a03cb7mr56812126d6.11.1729605732270; 
 Tue, 22 Oct 2024 07:02:12 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1659ffb88sm280087785a.54.2024.10.22.07.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 07:02:11 -0700 (PDT)
Date: Tue, 22 Oct 2024 08:02:04 -0600
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
Message-ID: <20241022140204.GY4959@bill-the-cat>
References: <20241021113839.318572-1-sjg@chromium.org>
 <20241021172613.GN4959@bill-the-cat>
 <CAFLszTguu7hRpsSLxADsBkMgTzA_-fAR0t8Axv+8=OvxJvSRCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dBr9ok7ui4CCab8g"
Content-Disposition: inline
In-Reply-To: <CAFLszTguu7hRpsSLxADsBkMgTzA_-fAR0t8Axv+8=OvxJvSRCw@mail.gmail.com>
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


--dBr9ok7ui4CCab8g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 02:15:34PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 21 Oct 2024 at 19:26, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 21, 2024 at 01:38:08PM +0200, Simon Glass wrote:
> > > There has been an LED framework in U-Boot which uses driver model for
> > > about 9 years now. Recent work is underway to improve it and provide
> > > more features. It is probably a good time to drop the old code, which
> > > is only used by 5 boards:
> > >
> > >    ./tools/qconfig.py -f LED_STATUS
> > >    5 matches
> > >    eb_cpu5282 eb_cpu5282_internal mx23_olinuxino pinephone
> > >    socfpga_vining_fpga
> > >
> > > This series attempts that.
> > >
> > > Changes in v2:
> > > - Combine code-removal and defconfig changes
> > > - Add a patch to enable LED and LED_BOOT for these boards
> > > - Add a patch to enable LED and LED_BOOT for these boards
> > > - Enable LED on the 5 affected platforms
> > > - Reorder patches for bisectability
> >
> > So I believe this means you missed the feedback of just doing the blind
> > migration rather than disabling the feature, like we used to often do
> > for cases where it's just a matter of changing CONFIG options. It
> > should:
> > - Not introduce a failure to build
> > - Just work on platforms with either OF_UPSTREAM or semi-recent device
> >   trees
> > - Just start working on those platforms when they do move to
> >   OF_UPSTREAM.
>=20
> Perhaps I didn't understand what you were saying. I thought you meant
> to enable LED and LED_BOOT on these 5 boards?

Ah, OK, I see the disconnects now, sorry. The first comment I saw was
Marek's on patch #2. So yes, along with Peter's request instead of one
commit to disable and another commit to enable, just do 5 commits to
migrate from one to the other please, thanks.

--=20
Tom

--dBr9ok7ui4CCab8g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcXsFwACgkQFHw5/5Y0
tyxtXwv+Ky9PV2HGnoDchOK7/EpFyH8eD86zQAfJbQSGuvK7pIrAl6M7hmGhkS10
NUozxYCf+/7hlC7Jn4LvbP14O62dZYL5GfAaz2cVT6BIvJYO+5L0fqsYnIfxg5pY
w8zfNilwyER1JyegsW/bkcstL1WPXKTolweM7/INHodtYsu+nwZGPhG+5Jy2J4cv
0aRnZRAt+TS1xHJbH+nuG4dF2gHn0TU0WolH7YQuSuji+8Vp/BM/IPbmtZrZZiZ7
15Ajh6ghjKvqpv2DX2EaG0FwkxyvboTo/D0respk4saFpFpOsNdAq5Vqy9VcGm3Y
lPduj81dy39fb4Pnt8gwtRm2cGrFLWGWMkQl2X513MDlT2ZYVXk0UB8A3ZvR7u+e
alxVnHVJ2E5hEyFML9StG9XF+VmPGXvXT2k3RaRawimpD3X6/8eJR+DYTMQjRZUX
+zzb6WbOogPye70EVD3WO3rmOBNCwYBftTBXXl3GaC8PPe/Ndf6LrCWDSu3/VHBx
e0UDXTK2
=YQIr
-----END PGP SIGNATURE-----

--dBr9ok7ui4CCab8g--

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25596C02180
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 20:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8231F805E9;
	Mon, 13 Jan 2025 21:35:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q9DkbXpq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 369D18060C; Mon, 13 Jan 2025 21:35:28 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A18DF805DA
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 21:35:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6dd43b08674so45284996d6.3
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 12:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736800524; x=1737405324; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5IxjLukns48F9rjui1BhzhJc0H7gw6WH+V2WgIlUizI=;
 b=q9DkbXpq6qc0RNvUoGeFAuNNuP+9yoCVn7+60BEjbnjQ9+z2CDRftJXqWP9nDUYNU4
 afZqTCRxIxfRCUsciTys+t0pTNc6+fwZEA03qTCOlKq7fvvEPv6rjRw2McfPuoRDbbhq
 WxDM+pAzOXaQiVXNUOuAUpLnkW5Ae07R6/7ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736800524; x=1737405324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5IxjLukns48F9rjui1BhzhJc0H7gw6WH+V2WgIlUizI=;
 b=SuFzHH3ns98KZQ18QhYs/L33fEk1IWCVM3Yp50IIqIHD7GW9GdPNEkaFZjesyCK7ky
 pamN9MNTjcm8NfHihrmN3UgRmY1KFwXECKo8G19scVgZeqMYghyM3n0orq8x+PFChOEA
 dBp0soSBN6jsHobiMH551/+LNuXUmbwD3KTvRMyLbaPYTRVeMdjs3BGGPb4DhUVmZZ/n
 HVe+dAjnW2YMi2zSduRUOhhwLw7xPMKWFQQ9JFe7elNu6scvXakORAgSnRXCIsrWCA2u
 t05226h16kWfO77B9XGB2Hvv+x3UPER/bzWwTV7V4xKrZUFIY1Y7DRLFOhl7UtWN0T/M
 P4Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOhlQfkl7GOba+babBZWia06c7PuN5rPUuAEpAQVrPOBe3wPO0mhtU5bH7M0GYJHyjPkU/SBw=@lists.denx.de
X-Gm-Message-State: AOJu0YwvW4W3GI+i1825Iat0fU/hnqC4XnHy3LBGH+NLp0QnwaRS2juN
 uU4nRf451h/X/x7S/oOz3E1leTHFKimKUft5885ywUG/eOg1l7wTFL71V7N3oz0=
X-Gm-Gg: ASbGnct8nEA0UDG7LuYzX/wQiFFD/iiXkeoYydnmRg1GAvP6y/r6uHX1VKSdTemgUhW
 9uLuMuUIvT3jaDgWJHBWhltwju43YZN5WUiy/Bq+1fEF0h4zOof/LETLaf7VZP3/P2f0tuh4/wL
 fmUxeihR0YunF647lzsb1kBFrDXosLipTISk/Oj2c/uPY1uozyOhYCC5bf9aUTtjoIEWalYeP7O
 f8cjbd6nRfN7sTahvB/6Vs1+f+7PL7Lgco8RUJkOOA9GTKKOiKPGW0=
X-Google-Smtp-Source: AGHT+IHSx/Q2v8knX3ksdJ1237Ebga0UFAU1aky/8+fNEZCmnoEzvVapulQbK4/Gjj9DRwVJjFU8Wg==
X-Received: by 2002:a05:6214:194e:b0:6d8:a4fd:d247 with SMTP id
 6a1803df08f44-6df9b1b508emr406797776d6.7.1736800524426; 
 Mon, 13 Jan 2025 12:35:24 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad9b2df9sm44883866d6.68.2025.01.13.12.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 12:35:23 -0800 (PST)
Date: Mon, 13 Jan 2025 14:35:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Weijie Gao <weijie.gao@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 5/6] cmd: bootmenu: add parameter -e for UEFI boot
 options
Message-ID: <20250113203519.GD3476@bill-the-cat>
References: <20241127070631.16412-1-heinrich.schuchardt@canonical.com>
 <20241127070631.16412-6-heinrich.schuchardt@canonical.com>
 <20250110224554.GA2278614@bill-the-cat>
 <CAM=mAOmee=By9ErZrvk0hVbZyLH_viguu_wMfOsV3LzTwddArw@mail.gmail.com>
 <20250113015108.GT3476@bill-the-cat>
 <CAFLszTh7S=jmezZNwg=b+96+6ravY41iRbgJ_ssJ48nx4d=0QA@mail.gmail.com>
 <20250113192352.GZ3476@bill-the-cat>
 <CAFLszTht-DdniDnZDgMsf7F5oK3X19ahjcNsM6u1-sN-D_8kdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fVQzYsftKN+2MjZ3"
Content-Disposition: inline
In-Reply-To: <CAFLszTht-DdniDnZDgMsf7F5oK3X19ahjcNsM6u1-sN-D_8kdQ@mail.gmail.com>
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


--fVQzYsftKN+2MjZ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 01:09:16PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 13 Jan 2025 at 12:24, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Jan 13, 2025 at 12:01:45PM -0700, Simon Glass wrote:
> > > Hi,
> > >
> > > On Sun, 12 Jan 2025 at 18:51, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Jan 12, 2025 at 08:08:13PM +0100, Heinrich Schuchardt wrote:
> > > > > Tom Rini <trini@konsulko.com> schrieb am Fr., 10. Jan. 2025, 23:4=
6:
> > > > >
> > > > > > On Wed, Nov 27, 2024 at 08:06:30AM +0100, Heinrich Schuchardt w=
rote:
> > > > > >
> > > > > > > The bootmenu command can display
> > > > > > >
> > > > > > > * menu entries defined by environment variables
> > > > > > > * menu entries defined by UEFI boot options
> > > > > > >
> > > > > > > Not in all cases showing the UEFI boot options is desired.
> > > > > > > Provide a new parameter '-e' to select the display of UEFI bo=
ot options.
> > > > > > >
> > > > > > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canon=
ical.com>
> > > > > >
> > > > > > Very strangely, this leads to the EFI selftest "Executing 'rand=
om number
> > > > > > generator'" test failing on Pi 4, where was was passing previou=
sly (and
> > > > > > Pi 4 has an RNG, unlike Pi 3), and this is
> > > > >
> > > > > Do you have a link to the log?
> > > >
> > > > Here's the failing part:
> > > > Setting up 'random number generator'
> > > > ESC[0;37;40mESC[1;32;40mSetting up 'random number generator' succee=
ded
> > > > ESC[0;37;40mESC[1;34;40m
> > > > Executing 'random number generator'
> > > > ESC[0;37;40mESC[1;31;40mlib/efi_selftest/efi_selftest_rng.c(52):
> > > > ERROR: ESC[0;37;40mESC[1;31;40mRandom number generator protocol not
> > > > available
> > > > ESC[0;37;40mESC[1;31;40mlib/efi_selftest/efi_selftest.c(114):
> > > > ERROR: ESC[0;37;40mESC[1;31;40mExecuting 'random number generator'
> > > > failed
> > > > ESC[0;37;40mESC[1;34;40m
> > >
> > > This might help make the log more intelligible.
> > >
> > > https://patchwork.ozlabs.org/project/uboot/patch/20240811145209.41914=
04-37-sjg@chromium.org/
> >
> > Shrug, it's the age old problem of sending raw stdout to a file. It
> > looks fine on console as it happens, I was just grabbing from an
> > existing log.
>=20
> Oh well. I would probably suggest only writing this junk to log files
> if we actually need it in there (i.e. something is programmatically
> checking), but it seems like this is a different situation from the
> one my patch fixes.

I mean, yes? The problem here is that the random number generator test
now fails, when it didn't before. As far as I know (and I think the rest
of us understood?) your problem was that the ANSI sequences exist.

--=20
Tom

--fVQzYsftKN+2MjZ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeFeP8ACgkQFHw5/5Y0
tyxAQAv/cpZO/5V0FpW7buvXjFkU2u7fmNk9Z0IQe25WVipQjozfhBg7ZAMPmmfK
imoN8L5cj4QS7E8X6B7T4MLYe8S8NwOHILpgUwEPW9/1y3KqdOjkEHHP8lN+coPq
YNXxjCxzwSRCcHmJiSzq+R2iw8hmhNwZAcRjljcSing2q0Lenr1jIKXEw5Af91Dj
RF3htOlsze1DCHAjjrFE9/5/c0vkgHIZtZaKLsyIuteT55p7uxJ2qXEGuU8EAPU5
KZVb966hL1zokV30gcU0TDOq/lzS7rXKK7okJ1wYgGXNa53uW4YvQaGKDJ0w67y+
fZoW4dKQaUGYOqo0qO8TAHYIe81PphYX3ncUTE+4lPSSZJiRNW2f886qytkPGetE
Wljcemh0aZoalK/UdMHYdEB9P01fOU2KwfnzIywqy7VVYUtfLVeOQMnblpbxFKKg
PGwCyvtRtJj3dEhJ60dj7tl2ldlCdfNV9ZdhgFx7P7MZS/XCMm1HB1bExSfqt0r3
2DvmAsK0
=xIti
-----END PGP SIGNATURE-----

--fVQzYsftKN+2MjZ3--

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE3BC02180
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 19:24:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33267805E9;
	Mon, 13 Jan 2025 20:24:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ozWujYiq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 896C08060C; Mon, 13 Jan 2025 20:24:04 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 098F1805E7
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 20:24:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-467a6ecaa54so35416081cf.0
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 11:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736796241; x=1737401041; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+8pmyn7jPwQo4yBKq/nAEeFRhA1wDzkozikpgWLqgng=;
 b=ozWujYiq50+8thIEPVxHJnQMm2ohT6WFPK0bVladfRu04vOKD8EP49t9FOvUiS5l9A
 PMsx4mVDk8tvjlCq791o3N/niUPsRmuJy86cNBpbgWc8Zm4W9Fj/uD6skI4GfdHMl29J
 +NsPIic89mhN+lafmg+n7yQfjNjSXf8rjtPIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736796241; x=1737401041;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+8pmyn7jPwQo4yBKq/nAEeFRhA1wDzkozikpgWLqgng=;
 b=FPcM8ICDIJSBS5SJqxpzFhQytaz0UweeYg1IapIVswcIcYQ7b27QUewBHnskWG5QA2
 mFalnNV7bigX/+Awdbobp5sw5pZ5ijY7lbkC3NXNi2kG0WFUFsCynQfpbU3mCVCISAra
 WDpdEA2Wc41bw8l+FHSidDyRkJWOqau+Pclj6hw2ptmyj7rbygpVHHhbANZsoijzY1iO
 HP89fg8t7oEFyOx7WUn0H7Z4OFT49OtfhSJrXuoPmbzRP6t3rzCcVp/xVHPjXy04DRXi
 NEErwPYZT3zvPIU8vAW+x4wVX+9weqVO/NZsluO1il/4B38TS0eReVjEcqhj21K0ePSR
 xpiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURDGS8NTjiAh7hflo6hxpAF8pqBH6JXKO8H8VYspFaMKodxZtqhz5bmn14zQicHpfVcoGG7Uw=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6+CEzRL5BN9Hfm4LCLsxcUoKm/+XiTj8m5anzz33tQHpUb1lo
 Z0IeJfLRKXoUCfuMgaS6eWG66NMBknpVgX4Qe8zlRG7TS0nB9imHQ6RSSXyOzYQ=
X-Gm-Gg: ASbGncsq7gSCTYdvu0HHlzF/OQPJzJ/KcH/mxb8avVpBBkQEBC77+3pmXp9MyyrwQwG
 AWjw3rDPdpHKsvqYMm31i/pVA35t0KMbLZr4WgSf6L76YdrJwFPDnpwlREZvfLpneOmYkZb0erS
 aJI7II4kpTzQnFCz3TdAvRmgK3Ng60gUBKK43NH2As1UlD2mn3Vq92ubi3qoqPZkHrPe3bQpJ3a
 9dte9ZdyKqBwZakqVHZmhbXAJsHy6ZODlHGWjc4KM4BEsaqSgrFnIc=
X-Google-Smtp-Source: AGHT+IHb9HkkPMssP6qrDIR1tSgr9uNDKV9o+BBJPlvNzJrpytooQ7jmbiDycJoGCakkCBbymEmupw==
X-Received: by 2002:ac8:7d15:0:b0:467:94c9:24e1 with SMTP id
 d75a77b69052e-46c7102fe6amr315143881cf.32.1736796240767; 
 Mon, 13 Jan 2025 11:24:00 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873cc196sm44274481cf.58.2025.01.13.11.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 11:23:59 -0800 (PST)
Date: Mon, 13 Jan 2025 13:23:52 -0600
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
Message-ID: <20250113192352.GZ3476@bill-the-cat>
References: <20241127070631.16412-1-heinrich.schuchardt@canonical.com>
 <20241127070631.16412-6-heinrich.schuchardt@canonical.com>
 <20250110224554.GA2278614@bill-the-cat>
 <CAM=mAOmee=By9ErZrvk0hVbZyLH_viguu_wMfOsV3LzTwddArw@mail.gmail.com>
 <20250113015108.GT3476@bill-the-cat>
 <CAFLszTh7S=jmezZNwg=b+96+6ravY41iRbgJ_ssJ48nx4d=0QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4wHO+F/gB+6yqf0f"
Content-Disposition: inline
In-Reply-To: <CAFLszTh7S=jmezZNwg=b+96+6ravY41iRbgJ_ssJ48nx4d=0QA@mail.gmail.com>
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


--4wHO+F/gB+6yqf0f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 12:01:45PM -0700, Simon Glass wrote:
> Hi,
>=20
> On Sun, 12 Jan 2025 at 18:51, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Jan 12, 2025 at 08:08:13PM +0100, Heinrich Schuchardt wrote:
> > > Tom Rini <trini@konsulko.com> schrieb am Fr., 10. Jan. 2025, 23:46:
> > >
> > > > On Wed, Nov 27, 2024 at 08:06:30AM +0100, Heinrich Schuchardt wrote:
> > > >
> > > > > The bootmenu command can display
> > > > >
> > > > > * menu entries defined by environment variables
> > > > > * menu entries defined by UEFI boot options
> > > > >
> > > > > Not in all cases showing the UEFI boot options is desired.
> > > > > Provide a new parameter '-e' to select the display of UEFI boot o=
ptions.
> > > > >
> > > > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical=
=2Ecom>
> > > >
> > > > Very strangely, this leads to the EFI selftest "Executing 'random n=
umber
> > > > generator'" test failing on Pi 4, where was was passing previously =
(and
> > > > Pi 4 has an RNG, unlike Pi 3), and this is
> > >
> > > Do you have a link to the log?
> >
> > Here's the failing part:
> > Setting up 'random number generator'
> > ESC[0;37;40mESC[1;32;40mSetting up 'random number generator' succeeded
> > ESC[0;37;40mESC[1;34;40m
> > Executing 'random number generator'
> > ESC[0;37;40mESC[1;31;40mlib/efi_selftest/efi_selftest_rng.c(52):
> > ERROR: ESC[0;37;40mESC[1;31;40mRandom number generator protocol not
> > available
> > ESC[0;37;40mESC[1;31;40mlib/efi_selftest/efi_selftest.c(114):
> > ERROR: ESC[0;37;40mESC[1;31;40mExecuting 'random number generator'
> > failed
> > ESC[0;37;40mESC[1;34;40m
>=20
> This might help make the log more intelligible.
>=20
> https://patchwork.ozlabs.org/project/uboot/patch/20240811145209.4191404-3=
7-sjg@chromium.org/

Shrug, it's the age old problem of sending raw stdout to a file. It
looks fine on console as it happens, I was just grabbing from an
existing log.

--=20
Tom

--4wHO+F/gB+6yqf0f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeFaEQACgkQFHw5/5Y0
tyze1Av/cZqDWABkFxwcZWjd7QRu0pZqbHb+IKY7a9M7s+NY4YOhaz/IKkdJDiGB
U6kBFbhecdDgAx7Bp3HSW1r/qm5ZEETNXPb8mNED3Ocv4b/led0UuXfwJuM/G/yb
uWP9S18kLYSswFFdG9uUyg9EwADQGEsYVXRxTovzwnoh07yObsaDEcckb+z6wC7Y
/zPRVPEL8hyfIygt0DVeG9agUmXYAcu4b0zaU1aDH7yAy+PXKBS3PWNsthrfPjqQ
C2cpEBPcZmQPesqugSlIDXi4GNE0tpOnm9hKNMBGFtJ9AAVv3rog6IUaag0B5itP
nfSF2MWYBfpyFGA3/2TZdhJw9TX506WxQfD6FkjYX5c5XYkQe/roy2UoUrii8CdI
ZwN9YbCwWJQpr1F4qsZBqMjnZlWAIfoj7tWo9NrS2j+GCPbZaPNfr/WEPYk+ZB9G
of/fWCKmT8PYd7xWbdTnu+cXUKtGQhYq8ycwEU54JAOwXyaoel3YA/JFAGhRjztg
T1Fdxznn
=Q0nC
-----END PGP SIGNATURE-----

--4wHO+F/gB+6yqf0f--

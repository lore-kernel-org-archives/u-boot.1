Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22203C47DAF
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 18:01:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 566718777F;
	Mon, 22 Jan 2024 19:01:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PPaEAixk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D5808777F; Mon, 22 Jan 2024 19:01:28 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95A798753A
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 19:01:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5f2d4aaa2fdso33729237b3.1
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 10:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705946484; x=1706551284; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jdzXx6uicy7aVvI5XZWGaF8LlacCt5+M9Moqvt1pwow=;
 b=PPaEAixk4fItmCFV0VTbCN0FhdXHcAYsp6ZTyT1cY00/tbs1tr3TTBBqtBKnfpXXGQ
 ysSh3NSMmwuEzjfz5F/zQLXfo+N3jCkUIH8uunBlbPIuGfGvAXmXtSGhAOu0mZ7fuNX7
 7xpgA5vYUHkx7VzNwMB1aTLYR3EwxoTJrBEdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705946484; x=1706551284;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jdzXx6uicy7aVvI5XZWGaF8LlacCt5+M9Moqvt1pwow=;
 b=QVM6CTD5iS1HUl2UdF7xnIjxEU+XNHqmixQbiRJQnjBSryIYSlpflkDpgIhvOX7O36
 qERxiciqAi34BIioYRIEcpPt7EuTaLAD4hyHcoouHnR1armlQcGosCn2UP6nnkQb6z2s
 bJeWPQrsgC8o0wByZkHi2Q8dJd4ccf6I6CmY5bxabFnNiEr+Hn3w2Dy/tLuj83tQCpP5
 l0UdXYMfTLZG/hwYc8HoOdLRKAys2QE44qmdEzuXuxH3VnFXDuaSRvRhZprm/tyVEpeM
 d7k2biER1nT9lXwTgZcrYuMK437N0yVbUrc6I10Gj/8BWmw3CZFQqYF9YzerZD2S7L3A
 OQVw==
X-Gm-Message-State: AOJu0Yy3BR2G9voQ+GiRyw9rFIVKztEcd3oVg98cBU+P23DD1Eh49IJj
 rs0aRRxwEZdzv8P4C95mPXCoqXBeFIVgckL14KMfWH/tL3WTlfwVWTFX6cpSvUI=
X-Google-Smtp-Source: AGHT+IHwQTuoGai/DofAtId7OoIQAKTBvX6r0f7BNW3ePxd/vLKS9iMtDvlEv1O1MwYPz2Te/2B2OQ==
X-Received: by 2002:a81:8704:0:b0:5ed:8cf7:8233 with SMTP id
 x4-20020a818704000000b005ed8cf78233mr3677720ywf.87.1705946484278; 
 Mon, 22 Jan 2024 10:01:24 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 m15-20020a819e0f000000b005ff9d895d4fsm2470989ywj.8.2024.01.22.10.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 10:01:23 -0800 (PST)
Date: Mon, 22 Jan 2024 13:01:22 -0500
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: "Ivan T. Ivanov" <iivanov@suse.de>, wahrenst@gmx.net, mail@jens-maus.de,
 u-boot@lists.denx.de
Subject: Re: [PATCH v4 0/6] rpi5: initial support
Message-ID: <20240122180122.GP3652023@bill-the-cat>
References: <FB66DFF3-03B0-4DA5-8916-AB80CA6C6EB5@jens-maus.de>
 <dvpwizpui6a52dfmy57ghv4zmplvgqvow6oec7x5opwzh63zzl@jehyglofr6yh>
 <489FBAE5-501A-49F6-894D-58BE5C5429CC@jens-maus.de>
 <A0746263-646C-40C6-A2A6-659C39385E8B@jens-maus.de>
 <246035ba-0090-4cc3-982e-1de837ec7340@gmx.net>
 <6E2D7E91-E869-48C6-8CE8-0B410A2B67B9@jens-maus.de>
 <ebffa598-6945-4a03-abe4-fe519df5fbfd@gmx.net>
 <223DA3F8-B17B-44CF-B247-12DEBD100A75@suse.de>
 <uwh4skanpw4c42t5iefqiawfns2wglxl4rizmaexeaetyvahf3@yibnd3owvcn2>
 <87frypsaon.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qnq5S4VZJ6NNXSty"
Content-Disposition: inline
In-Reply-To: <87frypsaon.fsf@bloch.sibelius.xs4all.nl>
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


--qnq5S4VZJ6NNXSty
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 03:30:00PM +0100, Mark Kettenis wrote:
> > Date: Mon, 22 Jan 2024 16:16:34 +0200
> > From: "Ivan T. Ivanov" <iivanov@suse.de>
> >=20
> > Hi,
> >=20
> > On 01-22 13:57, Ivan T. Ivanov wrote:
> > > > Am 20.01.24 um 10:48 schrieb Jens Maus:
> > > >> Hi,
> > > >>=20
> > > >>> Am 20.01.2024 um 10:22 schrieb Stefan Wahren <wahrenst@gmx.net>:
> > > >>>=20
> > > >>> Am 19.01.24 um 22:26 schrieb Jens Maus:
> > > >>>> I actually do have some good and bad news:
> > > >>>>=20
> > > >>>> 1. Good news: I got u-boot finally showing up with my RaspberryP=
i5 8GB both on the HDMI and on the serial debug UART like you reported.
> > > >>>>=20
> > > >>>> 2. Bad news: I actually got it working by downgrading the rpi-ee=
prom to the same 2023/10/30 (VERSION:30de0ba5) version like you have.
> > > >>>>=20
> > > >=20
> > > > One idea would be to enable early debug in U-Boot (no idea how to
> > > > achieve this). I assume U-Boot crashes before it's able to print the
> > > > first line, but it's hard to believe it crashes at the very first
> > > > instruction of U-Boot. So with some luck we should be able to narrow
> > > > done the cause.
> > >=20
> > > I was able to enable early debug UART in U-Boot and I will try to
> > > find what is happening, once I get some free cycles.
> >=20
> > Ok, this was relatively easy to find :-)
> >=20
> > New versions of EEPROM firmware change =E2=80=9Ckernel=E2=80=9D/U-Boot =
load address=20
> > from 0x80000 to 0x200000. And because on RPi=E2=80=99s CONFIG_TEXT_BASE=
 is
> > hardcoded to 0x80000 code run through the fields.=20
> >=20
> > Hopefully simple patch like bellow make it work fine in older and
> > newer EEPROM firmware versions.
> >=20
> > Regards,
> > Ivan =20
> >=20
> > diff --git a/configs/rpi_arm64_defconfig b/configs/rpi_arm64_defconfig
> > index 11ede9435d..ce64f9554f 100644
> > --- a/configs/rpi_arm64_defconfig
> > +++ b/configs/rpi_arm64_defconfig
> > @@ -1,6 +1,7 @@
> >  CONFIG_ARM=3Dy
> >  CONFIG_ARCH_BCM283X=3Dy
> >  CONFIG_TEXT_BASE=3D0x00080000
> > +CONFIG_POSITION_INDEPENDENT=3Dy
>=20
> Not sure if it really matters, but for the Apple M1 config I set
> CONFIG_TEXT_BASE to 0x00000000 (zero).

It shouldn't matter. 0x0 is the default for TEXT_BASE in this case, but
also a number of platforms set it to something else seemingly valid,
but could I suspect still drop the setting as it should not matter at
run time.

--=20
Tom

--qnq5S4VZJ6NNXSty
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWurXIACgkQFHw5/5Y0
tyydMQv/cNI5RhGjaprgVVuoeSWuD7I3H9nFTKeZEtnutLn/yxBrlcBzmPehQ5tD
vgF3VnZmB9egyhC/PuCME5bV02z9QbUVh4RespI2gXG+oTW6BAZj4JI+vgRjtGZq
/mCSpX26YwD/BkTajcbXGOwmDuygCX6a57BIK6MZzl7+pfVmqRHEcWLa5OMIBVOn
I2K/z9lB8YtTbatqHCjpzuo6Se7AOzscIO7+h2Vjd24EQZE3lFqjCPqgEUlVPgae
rJIf4BZzXRJgMPDbugdajzacGxrniF0Uxck2uXimS00lPb6+gOJrszwxCwMf+h9o
yI+xVrmzLr2k89fUwXadMFYuCPR4zaoz3eJlkNNI4O8ahFHd+7WqxboTP7MUY71J
YDS4zb4S4wcFbu3RnQqndc2ieUT3I5OIx2tpnaywviIyOrO3SFOlduTPArwjXVou
XJdvFso2xC4Rj+iCTek5I8W7exzhRA9B8Dkn5C3MrrhZV6hr2AfEsoZvYg3DHPKb
o5H+mhhW
=O/ef
-----END PGP SIGNATURE-----

--qnq5S4VZJ6NNXSty--

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99370CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 15:40:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CC8E835C7;
	Wed, 13 Aug 2025 17:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FtqBJR9j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 230A183621; Wed, 13 Aug 2025 17:40:40 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD9DC8211F
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 17:40:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-619bc5f638aso1154931eaf.0
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 08:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755099636; x=1755704436; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rKywC7DwwFtDjNbG4pmTixmf24xjIKw0hJrJ28XDERc=;
 b=FtqBJR9j9hZHNDAZjXr98XHuifvFFhS3FwV+rDAFDyMOIE0cR+/ash3HB2GJzCgrGO
 1Z3M91Rtj52JDpZu8wqWkBHrtNfwZsg3b4XxC07P2/RvINNUgJ6yqn/yEUYSC0ClykGg
 1sXVqYpZss0E0b6KsMvL+MiqfLTKPTqyxXhxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755099636; x=1755704436;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rKywC7DwwFtDjNbG4pmTixmf24xjIKw0hJrJ28XDERc=;
 b=B5yWYQXOoX5r3LPFs9vXJHEeZ1k8t4hC+pDbwq2drpXjnG9MaMX22jjo4syxYPebIu
 j8eWzwc3uuTAON5dXqTezWk9BOQeTImterZrENwIb0Jgo6TZAW0BD6AQWgb98jfyZ5IR
 jcO7Ah++jCi0P35Zv1tVcgEdLaFK4k5C5naRd8IsSU19JMaNvA+GifR34MeRx/sW0Zq4
 eWix/ykSNxFgVLKZozZnUlI9tBYX5RkNUgz15r0I8BquEKf94KIKSv9Dtuyb1WJERamX
 XZQJS/h2SlNETUGGippKtVngHOAepDFDJBqPam18aDpOz1IiA8+nQDX8sDVtHgP/25oe
 GWJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIhhR/SMcMUtqdliMJJ0+uSMBb3g1n3HeVW4NvIClTLSOsnQcqT3zn+pCKKYQY6m/sasyTvV0=@lists.denx.de
X-Gm-Message-State: AOJu0YzY8dFHdrI+IkPZDcfFigKXMdpzFFzPSXlvNKb6VNvx6stJ87Hw
 AqaWD/BUyPfk44Kv9Pb0hrjXhDMEabfu96OftpT6UDQk1dBSEcSnr1eXdvBGXOzt2dM=
X-Gm-Gg: ASbGncvYdbhXLUY0Wl7IER2vyvw4EqxZEbi+w+aGMuAp0HCf4MV2A2dAZFR5RnQRy2r
 df78Nsq+P7ESyZyL27Zern/WB5s7lCPQZ4RIYEnT8qmfM7sQxIoc0CekJbI+j13cNSzF2V/6x84
 FrE+veS/7EFdjG4y1LdowoqPvtmCumDQYS4A6na5eBPejgAgiIFk4Tg0jgShsSJV3TUU0WK+qk5
 ZK/KAa2feNtkO95LNqGwYJEevlrRvzXs8V9/kvoCMtFY2rxKZpbTqqhH9xRISDQdH6eZueGK4T+
 XCIeq4wS7exqDZR0si8Dk1ReNixa0U+q9YLbjdIwrh8XzAO1pwocshsR4U5CmOhLm/w3zxlae/C
 rx20qKHSTNSGIeQwQY9sVZ0qciecLXM4v+VE4yaTQCc4k+8jiy0Mw7Cun
X-Google-Smtp-Source: AGHT+IFlyVZge3A1OUy7MKVoMJTyZt1wWlYYZMALTjC+3pANqtrSNo9EqU4Sk+XzboneG4a7LtA8aQ==
X-Received: by 2002:a05:6808:4f66:b0:435:722d:f7c6 with SMTP id
 5614622812f47-435d424642dmr2253600b6e.18.1755099636220; 
 Wed, 13 Aug 2025 08:40:36 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-435ce8b4028sm682620b6e.33.2025.08.13.08.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 08:40:35 -0700 (PDT)
Date: Wed, 13 Aug 2025 09:40:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Seeking advice on API return type inconsistency
Message-ID: <20250813154033.GB124814@bill-the-cat>
References: <f5c94319-8ef8-459d-88b2-836702779cfb@linaro.org>
 <e10a39e4-9606-4ae4-86dd-11de4b39b5ed@cherry.de>
 <2d6457b8-c637-4531-8f56-e2aea320a319@linaro.org>
 <20250812143349.GQ124814@bill-the-cat>
 <cc82add8-5f9c-4ee1-87ea-a458e840e621@linaro.org>
 <20250812150359.GS124814@bill-the-cat>
 <56d03251-1185-44ca-98e6-f45ac0e0af53@linaro.org>
 <aJx54frzXkLRFcGO@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Xg5OWSto4fWg85jF"
Content-Disposition: inline
In-Reply-To: <aJx54frzXkLRFcGO@kitsune.suse.cz>
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


--Xg5OWSto4fWg85jF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 01:41:21PM +0200, Michal Such=E1nek wrote:
> Hello,
>=20
> On Wed, Aug 13, 2025 at 11:58:19AM +0100, Andrew Goodbody wrote:
> > On 12/08/2025 16:03, Tom Rini wrote:
> > > On Tue, Aug 12, 2025 at 03:46:56PM +0100, Andrew Goodbody wrote:
> > > > On 12/08/2025 15:33, Tom Rini wrote:
> > > > > On Tue, Aug 12, 2025 at 10:17:47AM +0100, Andrew Goodbody wrote:
> > > > > > On 11/08/2025 17:36, Quentin Schulz wrote:
> > > > > > > Hi Andrew,
> > > > > > >=20
> > > > > > > On 8/11/25 5:24 PM, Andrew Goodbody wrote:
> > > > > > > > Hi,
> > > > > > > >=20
> > > > > > > > I was wondering what people's thoughts were on API return t=
ypes. In
> > > > > > > > particular there is this and other examples in include/clk-=
uclass.h
> > > > > > > >=20
> > > > > > > > /**
> > > > > > > >   =A0=A0* get_rate() - Get current clock rate.
> > > > > > > >   =A0=A0* @clk:=A0=A0=A0 The clock to query.
> > > > > > > >   =A0=A0*
> > > > > > > >   =A0=A0* This returns the current rate of a clock. If the =
clock is
> > > > > > > > disabled, it
> > > > > > > >   =A0=A0* returns the rate at which the clock would run if =
it was enabled. The
> > > > > > > >   =A0=A0* following pseudo-code should hold::
> > > > > > > >   =A0=A0*
> > > > > > > >   =A0=A0*=A0=A0 disable(clk)
> > > > > > > >   =A0=A0*=A0=A0 rate =3D get_rate(clk)
> > > > > > > >   =A0=A0*=A0=A0 enable(clk)
> > > > > > > >   =A0=A0*=A0=A0 assert(get_rate(clk) =3D=3D rate)
> > > > > > > >   =A0=A0*
> > > > > > > >   =A0=A0* Return:
> > > > > > > >   =A0=A0* * The rate of @clk
> > > > > > > >   =A0=A0* * -%ENOSYS if this function is not implemented fo=
r @clk
> > > > > > > >   =A0=A0* * -%ENOENT if @clk->id is invalid. Prefer using a=
n assert
> > > > > > > > instead, and doing
> > > > > > > >   =A0=A0*=A0=A0 this check in request().
> > > > > > > >   =A0=A0* * Another negative error value (such as %EIO or %=
ECOMM) if the
> > > > > > > > rate could
> > > > > > > >   =A0=A0*=A0=A0 not be determined due to a bus error.
> > > > > > > >   =A0=A0*/
> > > > > > > > ulong get_rate(struct clk *clk);
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > get_rate is declared as returning a ulong but the descripti=
on says
> > > > > > > > that it can return negative errors. A simple test of the re=
turn
> > > > > > > > value for being less than 0 will always fail so errors can =
go
> > > > > > > > undetected. Casting to a signed type seems less than ideal.
> > > > > > > >=20
> > > > > > > > What is the best way to deal with this? Cast to a signed or=
 update
> > > > > > > > the API to be signed or...?
> > > > > > > >=20
> > > > > > >=20
> > > > > > > Note that clk_get_rate() in the kernel has the same function =
signature
> > > > > > > so I would refrain from changing the type otherwise we'll hav=
e some
> > > > > > > "funny" bugs to handle considering it isn't that uncommon to =
import
> > > > > > > drivers almost as-is from the Linux kernel.
> > > > > >=20
> > > > > > Ah yes. The difference being that the kernel does not seem to a=
ttempt to
> > > > > > push an error code through this API, you get a rate or you get =
0.
> > > > >=20
> > > > > How is the error code pushed? Or is it up to the caller to decide=
 that 0
> > > > > means on a case by case basis?
>=20
> Presumably it returns -EBUSY which is then implicitly converted to a large
> positive value. For pointers there is IS_ERR macro to decode that, and
> for integers there is another corresponding macro (I don't recall the
> name).
>=20
> For memory this assumes that the last page that holds the 'error'
> pointers cannot be mapped, and there was already a bug in the kernel
> that this was not true.
>=20
> For clock rates this assumes that rates close to the maximum value are
> invalid which is not guaranteed in any way whatsoever.
>=20
> Consequently, this should not be used.
>=20
> 0 is the only clock rate guaranteed to be invalid.
>=20
> As far as I have seen in the u-boot code almost no caller checks the
> result, and those that do cannot do anything meaningful with it anyway,
> at most a message is printed. That can be done by the driver without
> passing around the error.
>=20
> > > > In the Linux kernel almost no code checks the return of clk_get_rat=
e at all.
> > > > Some code will check the value is sensible and 0 is obviously not s=
ensible.
> > > > But pretty much the call to clk_get_rate is not expected to fail.
> > >=20
> > > Perhaps getting lost in the specifics then, but perhaps for this case=
 we
> > > should just do the same? But your question was more general, so anoth=
er
> > > example might help.
> >=20
> > I suspect that the answer is always going to that it depends on the
> > specifics of each case. The U-Boot implementation of clk_get_rate seems=
 to
> > have become more complicated leading to the addition of returning error
> > codes. This leads to the question about what level of compatibility sho=
uld
> > there be maintained with the kernel? That addition of returning error c=
odes
> > in U-Boot already means that the API is no longer compatible with that =
of
> > the kernel.
>=20
> I would suggest to abolish returning 'errors' as clock rates.

Yes, I think this is a case where we should change our internal API,
both for easier driver migrations from the linux kernel and also because
it seems our design here can't quite work as intended.

--=20
Tom

--Xg5OWSto4fWg85jF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJyx5gAKCRAr4qD1Cr/k
CnZaAQCYm+ylnt1BgeeFamc69P+RVZTCoEOcM4imAu0nkn3ndwD9E6sEGEgi0IEj
lcWeyFP8C6wzObBoE/yuW/rnEmRRlAc=
=OMMz
-----END PGP SIGNATURE-----

--Xg5OWSto4fWg85jF--

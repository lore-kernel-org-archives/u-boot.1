Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40ED9C83F2E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:38:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABEE288BCD;
	Thu, 29 Aug 2024 16:38:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RSOYzKV9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 939A088BEF; Thu, 29 Aug 2024 16:38:27 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6902F88BB2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6bf7ec5c837so3774546d6.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724942304; x=1725547104; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6Wv28IgLGgdKU8+LzZ8RUm2Uqik6pEs1MdzJhio332I=;
 b=RSOYzKV9skTc0vz2smjI6lATU6qFPhIfMWRVeCHaJ35rE/kzmzgmkOZJgR5NwvFCb/
 7J3xfUuycYTKSSh9W9U+Oh/nHWLhPCT9RqgLtNUHdkLibJV/cCYnxT9iJWbmd/KVyNjp
 d6Lodrz4XNeqdvP4nvO/xDmljwTjyDvQO1ftY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724942304; x=1725547104;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Wv28IgLGgdKU8+LzZ8RUm2Uqik6pEs1MdzJhio332I=;
 b=vwZ7VSC+dV8hulo8dlaf6L215g+5+2tWgZBZEE72I53q4atTrT0DjGeQWPy1HlbDqC
 ksIStX/XZqy2EBc6mGbJBtfJf3rJ6AiXajSQvqDFMfh9vXQ9iu3r2We3LgJMgoBxDZQp
 fTahr2NbU7Y+/nd1DurQ5R1zdUt5LXorgc5AAR9leiLQgP4IL4VQajooHbdu+bpXORxo
 s4Fl3Ab8xLTLdFL0kmAXRDj3AIsvzYDfTI1ey6+HYWDke2HB2CGoBBhxhj6vAmbb3s4e
 OdnkaO/H6xnZbREQznt+oiV21JRSoOmf4bm7GA/omW7G3xpqdCysB83WSo1C9Wn1yUeQ
 8wGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSpTfPd/Rl4Aob61cG36w5uwnX79qQuE+S4ddQHmurRylNEYTPHCrsbOBqQ6/LVxSpHni+5gw=@lists.denx.de
X-Gm-Message-State: AOJu0YxG6FSCZaunxvwR8OIUR54popuyiXM3zbmfPPyZf2VwSuc4dKGJ
 Sk3CQ41VryLV9E5quf7ntZHOSRsno1sADap8qSHTl/j3Ka/BCz+nrccvdQArNbA=
X-Google-Smtp-Source: AGHT+IFI4HKpXL0L9talJN3xLJv/P4+vsO5Z2ziVQMRCILIdNav2bZ4VqQiGG02/LcwJttMG68Rk/A==
X-Received: by 2002:a05:6214:5883:b0:6c3:2dcd:7600 with SMTP id
 6a1803df08f44-6c33e5dca7amr33976036d6.4.1724942303206; 
 Thu, 29 Aug 2024 07:38:23 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c340c00d8fsm5700266d6.42.2024.08.29.07.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:38:22 -0700 (PDT)
Date: Thu, 29 Aug 2024 08:38:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [u-boot-test-hooks PATCH v4 3/3] Provide some basic scripts for
 Labgrid integration
Message-ID: <20240829143820.GZ2479150@bill-the-cat>
References: <20240828164523.125770-1-sjg@chromium.org>
 <20240828164523.125770-4-sjg@chromium.org>
 <CALeDE9Ptr0Ln4H24yMqxuw1+E_Wt5qBGdQabUH54PaYUTPf9Yg@mail.gmail.com>
 <CAFLszThK_t5EwL28vnzmSp5UZQrSEpBRsaXhnNudMQRe8-7Ejw@mail.gmail.com>
 <CALeDE9O-kmnqkosThf8xQpLZ2tEebiHvrUEzVJNDjiEff2-t2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tXyD5/JHMbAnUkga"
Content-Disposition: inline
In-Reply-To: <CALeDE9O-kmnqkosThf8xQpLZ2tEebiHvrUEzVJNDjiEff2-t2Q@mail.gmail.com>
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


--tXyD5/JHMbAnUkga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 11:43:12AM +0100, Peter Robinson wrote:
> On Wed, 28 Aug 2024 at 22:25, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Peter,
> >
> > On Wed, 28 Aug 2024 at 12:14, Peter Robinson <pbrobinson@gmail.com> wro=
te:
> > >
> > > Hi Simon,
> > >
> > > > With Labgrid we don't need to specify the various methods, except f=
or
> > > > the console, which simply calls labgrid-client.
> > > >
> > > > This allows supporting any boards in your lab, without adding per-b=
oard
> > > > configuration to these hooks.
> > > >
> > > > Provide ellesmere files as an example.
> > >
> > > What's ellesmere?
> >
> > It is a lake but also the name of a computer.
> >
> > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > Changes in v4:
> > > > - Support pytest fully with dual-build boards like Beagleplay
> > > >
> > > > Changes in v3:
> > > > - Update scripts for latest version of Labgrid integration
> > > > - Add poweroff.none and poweron.none
> > > > - Provide -n flag when querying board info
> > > > - Target the grpc version of Labgrid which is now in -master
> > > > - Update README to cover the changes
> > > >
> > > > Changes in v2:
> > > > - Make use of the common script (only) to set bin_dir
> > > >
> > > >  README.md                    | 50 ++++++++++++++++++++++++++++++++=
++++
> > >
> > > Maybe that should be in a separate labsgrid readme?
> >
> > My hope is that Labgrid becomes the normal way of running these tests,
>=20
> Generally I agree with automated testing platforms, I think <insert
> you're preferred platform here> makes sense, there's a bunch like
> Linaro and a bunch in the arm ecosystem use LAVA [1] and  there's a
> bunch more that I'm aware of.
>=20
> Does it make sense, of course at some point in the future post this
> being merged, make sense to look at a general way of making it easier
> to plugin these sort of HW test platforms using this as a basis? I ask
> mostly because putting a bunch of my devices into some sort of
> platform can auto test things and of course everyone has an opinion to
> which is the best one :-P

Well, as the repository stands today, yes, assuming there's a handful of
CLI tools for LAVA for "give me console", "change power state" and
"write blob to filesystem/location", LAVA could be integrated fairly
easily.

The alternative for labgrid support is what I'm using where U-Boot is
built outside of test.py, and we have labgrid-client console/power cycle
and then more per-SoC "write" scripts (as Pi is different from TI K3
which is different from rockchip ...).

--=20
Tom

--tXyD5/JHMbAnUkga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbQh9sACgkQFHw5/5Y0
tyy3gwwAqIX+FCirUVHWSrPvSExqk+00cdAAysvt+D6WQAFqh16UxL7I21ahMDGd
sXjSfPOeh9yAnsl1/cdZTraUyne0UN/Tzju1Mm6IMRWT6LX/ojPdWRojcFGgkgIZ
Gie8e6xcb8NoRDQZmM28enXV8BIr9delAqhil06Tud/uir0wYWCYTL3/78/45V10
OtDX98U9QP8FkxlmuDz86wAs7rdfdhypHfv8hJh6jW9a5yzl3xPDk+ayUmxOkz6/
O1zOVDWyrgFxO8CZbuBzINFnsYM+X57h7MlFgGUpcVLRI1EXY9dsd8c3Jd9q8XfG
fENZEBktQP1rKy8r0+lt9Y+oH1ZT5WE09QhzJOJH7PITdq+977oCo6xlk0rPQPtc
u3aiEJdI0+nLreZtiImc7AGDds8FjrBus4gSgTl48l12qpBjl7jxlKUfH6JEoZwo
RS5/GHT8HFGCq/vE+lj/HNjJXTSsBytHO8PBpRZg4zLGXmnyikWjm5ySCM0YcoUK
Ouf4/Kub
=M4h+
-----END PGP SIGNATURE-----

--tXyD5/JHMbAnUkga--

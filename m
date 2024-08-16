Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F9CC531DC
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 18:06:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC86588BDE;
	Fri, 16 Aug 2024 20:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tuSaoL3g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9249988BDA; Fri, 16 Aug 2024 20:06:29 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 645FB889A2
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 20:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3db50abf929so1548789b6e.2
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723831582; x=1724436382; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DEd8aH8WQO3xDSsmhiZl9aZensrcPHQq4907g+DxYsg=;
 b=tuSaoL3gRDdHa0I5wRIQyR4GqVj2NPjb9kxijSdf+V2cydX+z+5mwm3PTfUT8FtPwe
 XVRB0yBDdBgwBzrtdhF7Se6a17Fx2uB9cb5cu+gI73UbX8QLp9YztdPy8fykD2wLX9xf
 stKvCHfJV6NBFcY/dgh++epR8QB9ZVcOxAsXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723831582; x=1724436382;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DEd8aH8WQO3xDSsmhiZl9aZensrcPHQq4907g+DxYsg=;
 b=dHGbz7jdY5q1qMk0hJ1pKKPFeUeNpZxHgFvZYjrFXNmgTXu3IwLlhA2WSLkjmWz9Oo
 rM7AxFyC9zGJa7H8v873Nlfa3rIIKn06EAHV06aYKxWbjq+XxBHhUiyoAtgg+rXmGuyj
 +2gRyjY1o1CFJpbeuQxEXmgEIBfNv1avds8oU9AuArbHw8ydQbsxmDyp3iQMxb1fxLJc
 Pt/VU0HDKIb2K5Ds52PKHX/8V0y4kwjLjKWmJZfErMx+H16RiyMTwVHfTGKO4Ixn/W4R
 0cny21g1ZdjrbqeVDpBYldOKgbXwnTuz62PigHMwoRtAFlbSzyo52cKsF87hkiYStV3U
 LDrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZPSLC/ojRtc06hexyxK3h0IqI5QhjJgtM0b0h96uu2SuIqy1BtnEdN7H+MiFyY47Et55s1Z0MPxLvSJV1ot6AMEInpQ==
X-Gm-Message-State: AOJu0YyzJxCbqCGHk0sxjTC4R1IC553h/y9uYSODNnmK+BFiC/I8vG2X
 9FNXMlSlyi6xwrdSR7645keA3UHkP+UN5laNbmTuHEygMRlNJT0wV+QoSTOi8r4=
X-Google-Smtp-Source: AGHT+IERQ4T3yHl+SJVY9TQwOdzVKoO6/Z5hu7Px8Hyzr2jm7I4ONVenW7wJP8jwAqvU/+WYqCgVbw==
X-Received: by 2002:a05:6808:22a3:b0:3d6:3450:7fe0 with SMTP id
 5614622812f47-3dd3acaf624mr3746973b6e.9.1723831581735; 
 Fri, 16 Aug 2024 11:06:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dd33ef5c97sm770618b6e.55.2024.08.16.11.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 11:06:21 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:06:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2 27/32] test: cedit: use allocated address for reading
 file
Message-ID: <20240816180618.GB1626301@bill-the-cat>
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-28-sughosh.ganu@linaro.org>
 <CAFLszTh-5c4_OdZs8F_e=giR+ZFjNB1oX8L8cV8hXi9Je6e+5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hotx0G0Q1MEHGgyy"
Content-Disposition: inline
In-Reply-To: <CAFLszTh-5c4_OdZs8F_e=giR+ZFjNB1oX8L8cV8hXi9Je6e+5w@mail.gmail.com>
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


--hotx0G0Q1MEHGgyy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 09:32:29PM +0100, Simon Glass wrote:
> Hi Sughosh,
>=20
> On Wed, 14 Aug 2024 at 05:02, Sughosh Ganu <sughosh.ganu@linaro.org> wrot=
e:
> >
> > Instead of a randomly selected address, use an LMB allocated one for
> > reading the file into memory. With the LMB map now being persistent
> > and global, the address used for reading the file might be already
> > allocated as non-overwritable, resulting in a failure. Get a valid
> > address from LMB and then read the file to that address.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V1:
> > * Don't use the API version with flags parameter.
> >
> >  test/boot/cedit.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
>=20
> No, this address needs to work fine without using lmb. Same with any
> other tests. Tests make use of the sandbox memory space memory
> addresses and it makes things easier to code and debug.

Can't we just request/free that address from LMB then?

--=20
Tom

--hotx0G0Q1MEHGgyy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma/lRMACgkQFHw5/5Y0
tywFLQv/VjKtS2+DcRCh3HlWzEdoglTHmq0sJqrxII4YWRYJvNMYA1WZw9GGzdez
x6wCheSN08b0KL2o9SNZuDWAcqA6suQGYCv5+NtgnZ+GQyjAYbzOXy1Om/GGSoly
1Pyuaj04+AtOU9eVdGegIHdEAFd3DJ3Z/1YdyJY2KAjrh2Ie5hFulVhjR2v3UWQc
sj3JAeFNyTNQJhGXXgegb0iOMdn9TW2KMTMVTvbBKen21E0dZqR3SCwbLfyxsnA8
aTeRL859d5F8Aiq5uAyCDGSaXvg+ROE72s4tW6MaMLWnFzyUwfC18Gqrv69eMq4J
y+w0RKmlLBV1ZLgasmfc9LmYUifly1QgkyaAs1+edZPDr8NZxSp7HQH8xt+xGS6i
+V2OdANn8SIXurkmBTMVtC6WTelvHa9TR+F5lGoN42lI1xVM2bBA1j4NPaz1DEz3
qxyyZqumPK7cyl0NlRSRXObCNM+D0rtu7Skk+Ao56u5DmwLNSWqtuWyYx9gCmkf3
X7VcHuW7
=h/5V
-----END PGP SIGNATURE-----

--hotx0G0Q1MEHGgyy--

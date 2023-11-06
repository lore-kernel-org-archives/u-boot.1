Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBDEC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 20:16:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A52C86C56;
	Mon,  6 Nov 2023 21:16:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZhayT68B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BD9686F9F; Mon,  6 Nov 2023 21:15:59 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2688286BF7
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 21:15:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-66d264e67d8so31215316d6.1
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 12:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699301756; x=1699906556; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/5m/E3GJ6n4MV2AumVPlJto3c2NrMTC3ZWEKAR906TA=;
 b=ZhayT68BAO3Jv/lllEXSuRo3pVpRewOjVz+qwVd5lHlqcuXuGPBxgx89B5Yp0x1Ra/
 UXccjVAkPczcgADLkg3r7YifyqcagcE/3nl//uEXuaKFBetVnJ15WQtPv2YKCjw9FaxU
 BBm+5D/Kl1YJ1G32pHu5fnct1Z2gnuZQuEiQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699301756; x=1699906556;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/5m/E3GJ6n4MV2AumVPlJto3c2NrMTC3ZWEKAR906TA=;
 b=ohxEfVa0s3SmPbda8dF9BlQx/rmWnnc0Azj/b94PgLDNS4fwoU5YTnGKS6Q8oJHV9I
 iszEn2hPwkokPa+7GjNcCAyaC0NAIb3WQgk1O01hCbijQFKuOU3n6K/eEZzN4Ak/JUJF
 IrdT8JkK4vJcMip9+zId+ExeRb4jvCm/VJnw/PsI+/MqaAwE9zu2ru1lEuN/qvENiRmw
 VltEIUJ0HUm3/zRPKuXPlauughs5XVQ/gZmgeI/FIKt0jLnYD1RYwlrNefXWwru8a3Is
 ZnD3CuNdGycZRVhB2ZJaX3oblXHji+xhnGkdzX0xr906uPq2qxd0rJVlb81sknskjSGk
 BAHg==
X-Gm-Message-State: AOJu0YzJnmdm57e6R0uGpxNR2093d2/6kjhpagX7SR/qDMua2yEQLSne
 h3NT67q/kR3rG/BDLG4H7DWERg==
X-Google-Smtp-Source: AGHT+IHY03XqWWQl8yH3m67U0zIYq1TA8tlp8DYC02DcK9C2Xgm3hXaqdUmNVpTbVf09YPuNDln+xg==
X-Received: by 2002:a05:6214:d6f:b0:66d:2140:1f88 with SMTP id
 15-20020a0562140d6f00b0066d21401f88mr33577950qvs.5.1699301755747; 
 Mon, 06 Nov 2023 12:15:55 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 l8-20020a0ce848000000b0065d89f4d537sm3713324qvo.45.2023.11.06.12.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 12:15:55 -0800 (PST)
Date: Mon, 6 Nov 2023 15:15:53 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH 1/4] bootm: Allow ignoring the load address with
 kernel_noload
Message-ID: <20231106201553.GF496310@bill-the-cat>
References: <20231105200453.1887418-1-sjg@chromium.org>
 <20231105130351.1.Iae1cd9e0e207784e680480ee52021ec5caed877e@changeid>
 <20231105211910.GE496310@bill-the-cat>
 <CAPnjgZ26DyfvayO8BgQvCoEVDfmxotG7A7GMWc9T0wK0Okho8w@mail.gmail.com>
 <20231106183020.GB496310@bill-the-cat>
 <CAPnjgZ20ZY3SO3sXWjNk6uAvgBKcNK+XRRs+k0MmrTcj6A1zjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="t6DsIaR5cF6JkaVG"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ20ZY3SO3sXWjNk6uAvgBKcNK+XRRs+k0MmrTcj6A1zjw@mail.gmail.com>
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


--t6DsIaR5cF6JkaVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 12:58:46PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
>=20
> On Mon, 6 Nov 2023 at 11:30, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Nov 06, 2023 at 10:25:00AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sun, 5 Nov 2023 at 14:19, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Nov 05, 2023 at 01:03:51PM -0700, Simon Glass wrote:
> > > >
> > > > > This image type is supposed to ignore the load address. But at pr=
esent
> > > > > it fails if the load address is missing. If it is zero, the image=
 is
> > > > > loaded at address 0, which may not work on all boards.
> > > > >
> > > > > Make use of the kernel_addr_r environment variable, instead, sinc=
e this
> > > > > seems to be a more reliable final address for the kernel.
> > > > >
> > > > > Another option would be to create a new Kconfig for this, or to u=
se a
> > > > > region of memory known to be free, e.g. calculated from the DRAM =
banks.
> > > > > But in any case we should try to avoid conflicting with the
> > > > > kernel_addr_r variable. So the approach in this patch seems reaso=
nable
> > > > > to me.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > How are you creating the image in question here? A noload FIT is
> > > > supposed to just supposed to go from where it is. Where do things f=
all
> > > > down later?
> > >
> > > The image is Image.gz built by Linux, for example. So compression =3D
> > > "gzip" which means that it has to be decompressed.
> > >
> > > Things fall down as soon as U-Boot looks at the image, since it
> > > doesn't have the ARM64 magic.
> >
> > Can you provide logs and env? "booti" is supposed to handle this case
> > already, and if it's not we should figure out when / why it broke.
>=20
> Do you mean booti handles compression? Yes, I can see that in the code.

Yes, you use "booti" with an Image.gz.

> But in my case I am using bootm, since it is a FIT.

Shouldn't this be handled by the normal compression =3D "foo" logic? And in
turn is that what's not working? If so, the commit messages aren't
clear.

--=20
Tom

--t6DsIaR5cF6JkaVG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJSXkACgkQFHw5/5Y0
tyysNgwAm2JrWZwaQ9TrVeDFzsTwKAlPnpaOOLDH4ryyOu7vN9ybbcjMJsXQnACZ
cbq9o4rLyTARNdLsd2OCxoqX54hBqnu/WMAWUiGri54uRgBHXTfq1AVN68wpP2U+
X4kXxQYX8GDkiMNd2zr9NbyQ896PYAjnD4wRHAM6zGmsx897Qlf4Nxc6G5y9Yc3Q
Kvmba448qdcElEc83rF6Mqrn4/GYFLFqBFh3jUSO5GK6PjeUyRkpOI+8Yp6CxQwZ
qP7jx2BVTVo3aSTKeSo7Ly/h2q/+F7vMnfAsMpJJY6F4I+4Vsy6F8cPaKNvYNkJ+
IWsHWTfBNO9Gj+2rCv87oFTkvnAxMBzh2pAlPcvAXENIHFEVeREWX2DgtaHeFdX5
qZNd0zawRgr6RJuW8rGMQPIGlBj+g61aLQbxhjazWI5cAy6utbsUd8+99iJfk/2c
n3VVRcZMGsliCPLR0XfAGlkE8cqxbUu37vHUK8ERW2D2ELiSlTtmirEcj3xHdvYX
KGMnKK8K
=WU7V
-----END PGP SIGNATURE-----

--t6DsIaR5cF6JkaVG--

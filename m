Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6858BFF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 04:26:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A736C84690;
	Tue,  5 May 2026 06:26:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dvyQIJmm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F5AF8469A; Tue,  5 May 2026 06:26:38 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 372848468B
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 06:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dbe437b072so3019873a34.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 21:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777955195; x=1778559995; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xdmJf6AEMk9wps6VJvQp0vNPTv0wCGKkfjTJ3jZ+Nck=;
 b=dvyQIJmmEQX62xSZJnJrtY3/ttCHhlQi4+IDYVJ+UBMFrCfdeEcRhg4YjD3TeIkMJO
 XdSM5UxFasON3XoelGWZw2oVPCGXF9VNPjpQ1xtuckcbXoAdJocFdlobmtqHckG5L7Kb
 zqnT7LRf8PzAh0KCtdc4UKKLC27CfdT9Ln2EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777955195; x=1778559995;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xdmJf6AEMk9wps6VJvQp0vNPTv0wCGKkfjTJ3jZ+Nck=;
 b=b7jf3chV6rxDIv7T0Fl0lRZ7DKj9H9JJjnI89ihSzFNtnwXYW5LoisxClp24RIZ1BB
 DCsCiRuJsZ4+YkPuNu9uWhGcIWc0T/kDxEp4vTkmQL1AhQxGFof76lnqJzLlbZyPhT+X
 sEAg/mnZZNLwQCMh50dzV62uza9dm0IwYfH1pSw1UnYjsuqzhf56zDqVNj9UJR3M2iE6
 1mwLNoCYKmb5lv6BDFEzQ2XCIMXXVWJ39sp37QZefDHOPg5Qd3QFsHj4JPBxzXOh6U0C
 Kp2ONA9g/OhY9qkg3wdtIs7ljKaKWRTEHYU5F19KqFeX7tYoeMOuGCdI7AJHOGzGw6LZ
 mu0Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ93K78BlOTww0UQI0BYQ6POJ1y8ODEedqnueiMxjHbotyHvmv4O7yBouUKDsnIy7V+x/uVFVTI=@lists.denx.de
X-Gm-Message-State: AOJu0Yyk9obgWOFdxiBG2jRTKHNHY32xiOGWyIAfR/gF/RJ8VJ077Noh
 KjjvHP9LVlCeMeHmHv/hmrqXZ0KNlLcER2yZshvV2L7D89TO/Iox/LhiJI6jaAWKnKw=
X-Gm-Gg: AeBDievRqfn/+jvz1LLcQKuasWMnQe0FyAWD98MBhB/HEl6ZLmNjKqdL+NMdk45GZpL
 1B/BmkAAUOlkZnLaOpGCe8lhzGBM/v3XopjMVWpanRyQW6AoLk8/JfPjzyv2h2W+XSo3ZVo3mB2
 vK+/jORJFFrEChWMj8qW9QrLY+q0/o8dweXQVbRf961wLXasQbJ0riiTO8tjp63KPpeR9a4Ue5N
 a3Hn0fHcy9iUs08DW8pQUfNbrMukDmr3jbRO1RW9FnwPS2Hi01AUhhsVtIrPGa2/dohUnk6za5S
 lV4AHS+AfREIGciWff6LB1rfalGvqC5oU/kzV8Dpx9YEgGaxMbs1+D2niroGTuBOSv5yVB39anv
 l1qHcdok2mCh6CAuCqaa4y6G24hsl4khitRWpynRYcPIlZFBFakc2YEL0BPIV2ezNuScKTcXR9i
 UXev550ZdBpkvkKy0NykeJFicAbMPhG5O9096uoxITaA2BP0S0/hFswn1yn6fvb8M6hfRScQ5D4
 WvVPcWVTGfidxGQ9kJxhV+hO3ri/WvnbgLWDHVZj2zoYPpvZ21HudVH3C+rHw==
X-Received: by 2002:a05:6820:6aea:b0:694:21fa:4ef2 with SMTP id
 006d021491bc7-6998d2512fbmr642159eaf.43.1777955194779; 
 Mon, 04 May 2026 21:26:34 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69689441144sm7778855eaf.2.2026.05.04.21.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 21:26:33 -0700 (PDT)
Date: Mon, 4 May 2026 22:26:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com,
 sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH v5 0/8] Add virtio-mmio support to m68k virt machine
Message-ID: <20260505042628.GN1614990@bill-the-cat>
References: <20260416093927.602613-1-daniel@thingy.jp>
 <20260504220957.GM1614990@bill-the-cat>
 <CAFr9PXkDJOP4KF5+=Bmyo-LaPRe0uwU05pgTALOUWPSLCPzULQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PiqCVUOYBCZmWi1D"
Content-Disposition: inline
In-Reply-To: <CAFr9PXkDJOP4KF5+=Bmyo-LaPRe0uwU05pgTALOUWPSLCPzULQ@mail.gmail.com>
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


--PiqCVUOYBCZmWi1D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2026 at 11:11:24AM +0900, Daniel Palmer wrote:
> Hi Tom,
>=20
> On Tue, 5 May 2026 at 07:10, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Apr 16, 2026 at 06:39:19PM +0900, Daniel Palmer wrote:
> >
> > > Lets start making the m68k virt machine support useful.
> > >
> > > First we need to fix some m68k endian issues.
> > >
> > > Then allow virtio mmio driver instances to be created with
> > > platform data and fix a minor endian issue.
> > >
> > > Finally, add the code for the board to create the instances.
> >
> > We get this in CI:
> > drivers/virtio/virtio_mmio.c:359:15: warning: cast to 'void *' from
> >  smaller integer type 'phys_addr_t' (aka 'unsigned int') [-Wint-to-void=
-pointer-cast]
> >   359 |         priv->base =3D (void __iomem *)plat->base;
> >       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~                =
                      1 warning generated.
> >
> > With clang, please fix.
>=20
> That seems to be a 64bit cpu that has 32bit phys_addr_t
> (CONFIG_PHYS_64BIT=3Dn)? Would this be acceptable:
> priv->base =3D (void __iomem *)(uintptr_t)plat->base
>=20
> That would extend plat->base up to 64bits where needed and I guess
> that is ok because if you have a 64bit cpu but a 32bit phys_addr_t you
> don't have anything above 4GB that you want to access?

Yes, we're building on sandbox when this comes up, and that sounds fine.
Thanks!

--=20
Tom

--PiqCVUOYBCZmWi1D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaflxcQAKCRAr4qD1Cr/k
ChBMAQCb5PM/LCcyxN766lVH1eMpsO1pQ/1xPml88SNghnIj/gD/VdTjOmnpJmj9
8rtFbzxZ+QU4E3dnW+X1NiAyPazXJwY=
=xR6Q
-----END PGP SIGNATURE-----

--PiqCVUOYBCZmWi1D--

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31387EF99C1
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 18:14:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8789983AAB;
	Fri, 13 Feb 2026 19:14:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eKG6XAL0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9962483C4B; Fri, 13 Feb 2026 19:14:15 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CB9383AA9
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 19:14:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d4ba9abbecso1374655a34.1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 10:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771006452; x=1771611252; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UCwvuQuat3uPBJa4crDXc0E7aaGdbbkzgYeer40g02I=;
 b=eKG6XAL0tGuD/jSyyrNXxNNmUHnqYnJsfKE97PCvkWAMhtJnK3VW+7qMp1eypMHNLc
 8J1AjV0J/HYASvTB5T/zr5EPMBkG5+UVJChqabDe1l/BAhXhD3uA5GcNvFeNJ4YmqvA4
 IfVfv9LSgALhKj0r2W97uyHUZ3SU0IA/uB/nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771006452; x=1771611252;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UCwvuQuat3uPBJa4crDXc0E7aaGdbbkzgYeer40g02I=;
 b=Ifb4m5x9NY06vMVc5K21ZsePGmaGUEJ0cD8Q8ZwOmQ8z4A3RhO7na0yXLDOm+S3CRd
 mpilKnxsddnVrhqVLCeigiVbWyQbLU0fU0S1a5B5zxTVE/OEnsMv2MNtf7Q9S4XoRRw+
 0SLMkXr/eqC+Pn0G0amuvtG5KRkt0yQhmYi89nWEb09t2rH4K31XcJ+b/5OkdnwPBtwP
 9CjLAYB8jQ+8/NFHyqzUJ1hFtQxhPhXGhSSkGYxW7Q5b6VIu5mAreh5wDBGXVMIrETF7
 o2gpYEbU9XAWV0ghgTTYU81KsFvVXD4rygwZRnKw9GlCpe00Z1qZuGPAXm/9JZnc0KB3
 yaWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpF9TwjCnQ6j9Vhc2Vtp8P1XcsPz7QhesS+wl0xE1MX/dW3QSkt8TULCtQ+k4uBVy5XOv0cRI=@lists.denx.de
X-Gm-Message-State: AOJu0YzryRligAqIbQjfzHJDx/2zE4RaO5Pvr9HdP/KIjRAo+nuoBql9
 jdpitN3B1NLWcFZK/rLCbZhhm79FAnifD+1+e8IQXAh+5OyAekG6hHxj2JMQYGxqrMs=
X-Gm-Gg: AZuq6aI62spwTKypbqVAG448282QQYBaw5J+BSEElN2gLG2S1XS62torCqZCRfnPwuR
 pj6IgBCG+u8eAeVpJp15dREVzGdL+CpVpGRKjQ/xqFcUejZ6L9Sq6KpX4XMKUobIkbB4l4bN4M+
 1VIDNve7zGpyCxJThT4XVSaGIHZQkhxaH9Jzx0bF5hooFapz/PZogQYrW3KU+uZHSk5lZJVxw8p
 Mz3bZ5mi4aP3+EegzHceTDKJMo/IuI6TbV0G8UssnSHF19io0KlFRhz2geiw45XFP5N47M3TulV
 0e9fN9WMaDOFEUq38i8sRWDSJNd0v643fNyIuBzs30TX/0PONp8RjBSHD3z1ChRPm2VpQzVcMOZ
 bKzqmhq5iuaMFYBKUJ9tvZQVTdtdQ33ngAMqpc/KZjBv+fnqEv3zfxO6+zY7sxIO+NNE9vbVQ9q
 rNggF7F+i8IhamM3OyvEk0BGl76sBy/CBYn25ByxzCqscwkytIVIjCal7lEu/Rv/DIl55vK8Yiu
 TOFs2Bc4Zxu4YwxrOriBHwHdgaZpokb+4JzznEcwObQYZDXCYeHGzkbS02exA==
X-Received: by 2002:a05:6830:90d:b0:7d1:9160:7b98 with SMTP id
 46e09a7af769-7d4c302911dmr1563065a34.15.1771006452181; 
 Fri, 13 Feb 2026 10:14:12 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a771c495sm6391703a34.26.2026.02.13.10.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 10:14:11 -0800 (PST)
Date: Fri, 13 Feb 2026 12:14:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>
Subject: Re: [PATCH 2/2] Fix x86 baytrail boot flow, UPD/VPD Updates
Message-ID: <20260213181405.GL2747538@bill-the-cat>
References: <20250714210249.4139916-1-eric.schikschneit@novatechautomation.com>
 <20250714210249.4139916-2-eric.schikschneit@novatechautomation.com>
 <20260203181444.GQ2603314@bill-the-cat>
 <CAFLszTgLx_TtEO-8qq_9uojLd7PgFdUuhs5_6kYqL7GuzFt7ow@mail.gmail.com>
 <SJ2PR07MB97113A17DC42B9E4E87E95EB8162A@SJ2PR07MB9711.namprd07.prod.outlook.com>
 <CAFLszThAYG9UXu0GoUDHv=k44G3b4CMBNdZjEUmHgrneJZAXOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ik4m+Sab5ckXv1d7"
Content-Disposition: inline
In-Reply-To: <CAFLszThAYG9UXu0GoUDHv=k44G3b4CMBNdZjEUmHgrneJZAXOQ@mail.gmail.com>
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


--Ik4m+Sab5ckXv1d7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 10:53:26AM -0700, Simon Glass wrote:
> Hi Eric,
>=20
> On Tue, 10 Feb 2026 at 07:38, Eric Schikschneit
> <eric.schikschneit@novatechautomation.com> wrote:
> >
> > Hello Simon, Tom,
> >
> > 1. Tom -
> > > And we should spell out that device tree can't set these any more in =
the
> > > commit message, along with spelling out why we can't do that anymore
> > > safely (why can't we?). Thanks.
> > I would be happy to move the code comment into the commit message:
> >  /* NOTE: This breaks u-boot ability to set board options via    *
> >   * device tree, but guarantees specific known values..          *
> >   * you wouldnt use an uninitialized variable would you??        */
> > These settings could be set by device tree, but every fdtdec* function =
must
> > set a valid value. If a user has something set differently than called =
out in the
> > FSP_MR5 Integration Guide the board stability will be compromised. Many=
 of
> > these settings are co-dependant so we would need much more robust error
> > checking. This task would not be trivial. By using the specific values =
called out
> > by the Integration guide we allow users to begin from a documented known
> > good configuration. Maybe we could set all the values, and then check t=
he
> > device tree to see if the user specified a different value? If the devi=
ce tree does
> > not call out a specific setting we would not want to just set it to zer=
o for example
> > as this can cause undefined behavior.
>=20
> The device tree is actually where these values are set for all x86
> boards. If you change any value in a device tree you risk bricking any
> board. It should be considered an integral part of the build. If you
> change the C code you can also brick a board.
>=20
> So I don't like the idea of changing this to C, sorry.
>=20
> NAK from me sorry.

Let us not be hasty here. It sounds like we're getting some feedback
=66rom production users of this support finally and not just people like
you and I that had reflashed our Minnowboards or similar to prove it
worked.

--=20
Tom

--Ik4m+Sab5ckXv1d7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaY9p6QAKCRAr4qD1Cr/k
Ci7uAQC2E79pLU7qNowZeKB70rpzD5LFopK8VNwgzlAWpQHvOgD6AxvFmmyZdI4/
a5l1QRSLuiBWxTczoY3RnXGZU+fncAE=
=dtoI
-----END PGP SIGNATURE-----

--Ik4m+Sab5ckXv1d7--

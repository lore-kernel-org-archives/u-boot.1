Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0EECF6498
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 00:46:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A396F887D1;
	Mon, 30 Sep 2024 02:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ig2Qoiyx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D70B88770; Mon, 30 Sep 2024 02:46:33 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA948887D1
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 02:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cb29ff33c5so36963996d6.2
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 17:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727657189; x=1728261989; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TC1HeTWL8ruIRrOfh10Znf8KGU+fm/4wjw9HcdNwV4Q=;
 b=ig2QoiyxynNFQLTb9tRAGXvEK0av1sWlY/m4Qk9LLLU9S+JdXhP/iOTqwkH/m6pESi
 h8LRgEbvYruOlt+qpHAFINSZipCj8hdk5BZwMklN56UHahgeWjBoTTnUPoXH9tXjKTtw
 8XS3VfV9+K5HaNV+OR8DCFsQTVAx3KzDbj/G0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727657189; x=1728261989;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TC1HeTWL8ruIRrOfh10Znf8KGU+fm/4wjw9HcdNwV4Q=;
 b=O4eT3dXQraRHNS6YOgfDEN+lB+y57r5kUEvNbN7YVkkjyAd8tec19NJ0rkhDpfsUvj
 IKyAF4t1qh/t0nv8o4kH+VpgAqMNyTO+NRHd8OVVDUa0Azcnrl4+/YI8vkNNnLS9Zf+P
 jQrdxP05dWi02ecteM9a5jca8zJmlVLmD1ijuy8psQekknKWnPNL+rVctfSA+niV90fF
 g/SZLszCiFYoeZ49NQCiblzdiv8LiXe1r/xdxRefAfUbhCI+b8UauJFe85XAvW3NFO29
 OpdzFOsW6bZ/EAMqJlh67iKUHPor8oAy/fIPESEHuGuKhXaURpyTGVtFRNgUGYdbZORb
 yX1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6u4219rvj1UkcsZbAMVzfe3LsYelZRCeBLPtqIzGuLm8WSHR8DyYESmWFxP8ojTs1H4sOSBc=@lists.denx.de
X-Gm-Message-State: AOJu0YzIui+3FbR5l9MZDuKAEmkgRFyaJcb3YFtLqbNedUabDZPq+t3m
 U1ido3Uqs9xzhCOtFXTVma6zKdRIagdzlkSFfz8+bijDpcbJPg3ATiMnH9EHFKs=
X-Google-Smtp-Source: AGHT+IEx8eLvsB5VWoX8p8sDJXe7w6bghxBLgl3pAvBA1P1OrXgWy3Y3VezhJ10/xu1VXH0rn+xxVw==
X-Received: by 2002:a05:6214:4306:b0:6c5:b6de:5ee with SMTP id
 6a1803df08f44-6cb3b5f83f0mr146694816d6.30.1727657188594; 
 Sun, 29 Sep 2024 17:46:28 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b60fcefsm35807766d6.38.2024.09.29.17.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 17:46:26 -0700 (PDT)
Date: Sun, 29 Sep 2024 18:46:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Fabio Estevam <festevam@gmail.com>,
 Brian Ruley <brian.ruley@gehealthcare.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 ian.ray@gehealthcare.com, Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH] binman: add fast authentication method for i.MX8M signing
Message-ID: <20240930004623.GA5579@bill-the-cat>
References: <20240927124237.47-1-brian.ruley@gehealthcare.com>
 <CAFLszTjHkmT0JcgcZ6Yn69q27Pe7YhvwuXc0bC0N+agmpPtCfg@mail.gmail.com>
 <20240927204046.GW4252@bill-the-cat>
 <CAOMZO5DAUD3WR5z8ZxPkVhnv_2VZpYaHRziEvZ7MHvwooNS8Jg@mail.gmail.com>
 <CAFLszTiUQBJvaU_bhUYdsujo-oeeT8RCDguu+pYQ9YEppqqALg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I0ewhCQgJf93YXqo"
Content-Disposition: inline
In-Reply-To: <CAFLszTiUQBJvaU_bhUYdsujo-oeeT8RCDguu+pYQ9YEppqqALg@mail.gmail.com>
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


--I0ewhCQgJf93YXqo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 04:49:17PM -0600, Simon Glass wrote:
> Hi Fabio,
>=20
> On Sun, 29 Sept 2024 at 14:53, Fabio Estevam <festevam@gmail.com> wrote:
> >
> > Hi Simon, Marek, and Tom,
> >
> > On Fri, Sep 27, 2024 at 5:47=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> >
> > > > Please can you coordinate with Marek as we need to sort out the test
> > > > coverage for this etype, before adding more functionality. I did a
> > > > starting point, now in -next, which should help.
> > >
> > > Well, when someone has both time and understanding of the tools and t=
he
> > > frameworks, we can expand the automatic tests while still having
> > > functional testing as people use the feature.
> >
> > Do you think this patch should be applied as is? Could the tests be
> > handled later?
> >
> > Please let me know.
>=20
> Who is going to handle the tests later and when?

Someone, once how to write and run the tests is documented. That's a
big hurdle this private thread has shown, to me at least.

--=20
Tom

--I0ewhCQgJf93YXqo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb59NcACgkQFHw5/5Y0
tyx3nQv/aPFBA/2hxmA57s/6oFNSgqq0tmqa5UtnTuLY/tzlMk5JE6tV6hhUb/C9
ZCm3rTjcoMNVJeDtLWmDwFDSVkioOOIIOKfL4O2EqLk3favC21TioEMANAYGaUKZ
7GiEimK+BAFoPM9djAE+kboqg7RiyxBwCY0aGayf9UtpUAmY/HoTNEI+0BccA6Uw
pKHaf8hKq31OBsyGQ38c1XtzCOM7d24GhJI8ZoI87bTynBUWYmzUnANyx1dPxVfj
eMSRSw49vbFRzTFM89wrB9pB0mDfZ8leJ/OWSXMFxyriMMSp1nNS3eHBIdTW5ji4
kLtWKuBXvAlyauvu/Px85Gxoj8+/l5aUCDaxvRet0Yp1w1dE215a7jNLqkwxvfkz
U29GSM6D+wyIJw8NCBVHhoTF2FP7IWWutk9PQr85zakS5PGd8OcSftathjpw0piV
YmDGomhxN7efm9aX3jD4Lk53Lm5vyAXwh0rP6OvfwQ3ZpXdVU1fl7wrAZ4wtJf6F
GGm+atM7
=fc2R
-----END PGP SIGNATURE-----

--I0ewhCQgJf93YXqo--

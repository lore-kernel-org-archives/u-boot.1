Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36271C52D7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 18:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E73A88871;
	Mon, 12 Aug 2024 20:46:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eyQUT6EO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B79918886A; Mon, 12 Aug 2024 20:46:21 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9283D88871
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 20:46:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5d5e97b84fbso2659998eaf.1
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 11:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723488378; x=1724093178; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n2EG2OsxhbzkgfLRC2CLZg9eArwsbvPBQCObSPCFHa8=;
 b=eyQUT6EOYkuqfrwPL8HULd706Kfh1xQkhm5XnGOKmrIFUSOJyPbqqEZlUiWbQpM8uX
 VBS0H61UOuhE9mfx4gCCGeGAthM+TqdC7q2pW74Z8h+3JUQ0gl8Fj0RRsLSZdywH27NQ
 qkbEwbVThxZ4s6UxEEj0/f6fiajI/eQhzHbVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723488378; x=1724093178;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n2EG2OsxhbzkgfLRC2CLZg9eArwsbvPBQCObSPCFHa8=;
 b=TMoPZCUWHPa/iM7vurn3tPAUAoSUK2YhkeDPIb+SOvBEYlwOmmjJaU0kOGkRP+T9m+
 Q2aHg4G+orj/jtEcd4q9IYHIXKrh7wtLeDnxNgra4kqvOneDGhpvSbvq+ZZh6ojEX0hK
 iFDFGJX9yi1FqsYsB7Y59QEXBDH6zGhOqSn2rEajxKsPbpsbs0VrTEAASorL6k1Nz+W1
 SyUZZlni3CtOWUT0c3uRFi49AL6y7nfqRL9doDG+vINGjEZG8rwfQ6FMubsqlf3Kydc8
 OBgB5E6qE+aYdC9OVmDWv1FxGbI8Zjg5nicSHQiwwEzsMYLnthw2Xa8fH5jaB05dAmew
 hfeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVshOZnnZk3o3Phhe5A/blYl+jsPlrN8nL74aWyHis/bxzvr7EBy+sUJHvEHiJkTdbCyob2NJ4=@lists.denx.de
X-Gm-Message-State: AOJu0YxJ8dtMkovd6xiyfaQuYjEehLBJgT0/L1FebGXzDqe11PEx58Wn
 qUs8OZmy5kem7uaD5H87zEsK0K9VrC0yG74z3iGidvrBc6CkxOTxEkQ05UyoPeU=
X-Google-Smtp-Source: AGHT+IFlb/Nng2ytJdbmE3wJRp8XLWS9rJV0PG/+nXx4iwOiOTptg/KCoFHH9ruyjEhhrG0l0lv25Q==
X-Received: by 2002:a05:6820:221f:b0:5d5:6733:ca74 with SMTP id
 006d021491bc7-5da685adcc0mr1399188eaf.2.1723488378276; 
 Mon, 12 Aug 2024 11:46:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5da3e59899bsm1364508eaf.26.2024.08.12.11.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 11:46:17 -0700 (PDT)
Date: Mon, 12 Aug 2024 12:46:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Ramon Fried <rfried.dev@gmail.com>, Richard Weinberger <richard@nod.at>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: Re: [PATCH 07/21] Revert "net: wget: Support retransmission a
 dropped packet"
Message-ID: <20240812184615.GI1626301@bill-the-cat>
References: <20240810205205.3403177-1-sjg@chromium.org>
 <20240810205205.3403177-8-sjg@chromium.org>
 <CALu9rSbrAcxkGkFHuiFSBd-JMTm0kfEwDuBCDNYZc33eTLVU9w@mail.gmail.com>
 <CAFLszTjujOXs39KMnV-5NNWNqJ8K+FoisPYB=1HmC5QHf671ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="g5p8AQi1RCTPI+dF"
Content-Disposition: inline
In-Reply-To: <CAFLszTjujOXs39KMnV-5NNWNqJ8K+FoisPYB=1HmC5QHf671ag@mail.gmail.com>
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


--g5p8AQi1RCTPI+dF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 08:50:18AM -0600, Simon Glass wrote:
> +Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
>=20
> Hi Yasuharu,
>=20
> On Sat, 10 Aug 2024 at 20:48, Yasuharu Shibata
> <yasuharu.shibata@gmail.com> wrote:
> >
> > Dear Simon,
> >
> > Could you inform me how the wget test was broken?
> > As I explained in the commit log, I fixed the bug in specific condition=
s.
> > Without the details of how the break happened,
> > it is difficult to find a proper patch.
> >
> > Best regards,
> > Yasuharu Shibata
>=20
> Yes, I should have mentioned that. It is test/cmd/wget.c - see also [1].
>=20
> This is a good run:
> Test: net_test_wget: wget.c
> HTTP/1.1 200 OK
> Packets received 5, Transfer Successful
> Bytes transferred =3D 32 (20 hex)
> md5 for 00020000 ... 0002001f =3D=3D> 234af48e94b0085060249ecb5942ab57
> Failures: 0
>=20
> With your patch it hangs:
>=20
> Test: net_test_wget: wget.c
> HTTP/1.1 200 OKT

Can you please figure out what's going on with the sandbox test then?
The change in question fixes wget support on real hardware, and also the
other wget tests (as part of the lwIP series) work fine as well. This
seems like something specific to that test.

--=20
Tom

--g5p8AQi1RCTPI+dF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma6WHcACgkQFHw5/5Y0
tywItgv/VBKGEj1z+Z31s7FPGOfIoGg53EqeoGF047LNV2GbEDk2+0+X+e5uuzd1
kqbvK81lTemZ73qAKvFxOiDcziOtD5vO/jkcqsBhUZjJkXeABPnAt6ohCnOjgtZg
sK3KjXxyNfibCDS1FnPc/xsPGXYaPGIWWbT6SNcGz53oFW0Z7oW5tS8ZcEv6/wvH
hg29NkjVsvkDeMiI1pOAFifK+XJFbRv4US2MBvf15ZbDPmifUgTanuOhl1jGcNwY
ni1j+jTZj2VDLvdfDAjLeICRqdM5mjcVXUhUI7VguVEGuFQdu3rdwmOJvBy+ouEC
2kzVEttAP7NOZez8MKmvKX3SWiTvVRobYVClGOEDgRqjZVy2LIIjwb5SxWI3o9uM
LrtmVRzULEVRV4f36dZcaTm9OJDzk0rDR3SOv/dn3/8T3GbniE8dDn6YMbcmOYFC
PVvsaDXjYwRBSd5Pu2JabB2vsTW0JUwDu8K1i/z0CK5/TJx30+RTzz+JE6QkkKZl
XAd6IrUC
=Wx/z
-----END PGP SIGNATURE-----

--g5p8AQi1RCTPI+dF--

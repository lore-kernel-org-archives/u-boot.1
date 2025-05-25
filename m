Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9CBC54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 22:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1249282B31;
	Mon, 26 May 2025 00:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qLkQGcYm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6623882B37; Mon, 26 May 2025 00:57:47 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBC2782B19
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 00:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3fe83c8cbdbso292155b6e.3
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 15:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748213863; x=1748818663; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=awB8xmWC+PvIm7BTnhHuOk+uvnWXOj6Pl8S1FFckApM=;
 b=qLkQGcYmlVwDQiGsROpWCMdHyiIQADFjqfOUkqHJFedHq2PP/ENQ11tOsmdXwRzZqp
 rxNYPenCO012e7mZoVkHu5qePdX/hGQX72IgybT3GCNdx5pylt7iSYVNNaseoKoigaEG
 FikJLjiq2eIHPqDkDx5a6Qmb2naUkMpRK1cGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748213863; x=1748818663;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=awB8xmWC+PvIm7BTnhHuOk+uvnWXOj6Pl8S1FFckApM=;
 b=nrXzQ6sO/SxExxAN7GyBnRANa9nHIucMnpsZ2tO+LAcVx1O+PYKcxAqlDDV8ehhbup
 LRwlFFEm+CqkGZRR1lZ2//zzJhb5xdoiX7aeGjKxX+kvrmVK9bpvOoxWV2RN25qdfrb5
 FhN3RjhKojxfGQKux0OYFm3GDeIucaIQmlvaCTWnnwWHd8n9wCwdLG4mNBRyv/8SuBHy
 WQSSGV22MV7lwpzADdq3xcGaSrdlCtucP0TS3LUXixeLlD7uqG2Mr43JgC7HV3eNXgUk
 XM3+sQOMrSNDAWtLy80QGEc9twfIM+r49ip9hLYbvEQy9YVaIB1PDmRDbd1CiZcaO6va
 THlA==
X-Gm-Message-State: AOJu0YyHt8H7s36N9wHW+LVHWIo+uVwzmmB9F6BTjFVgt0GDg6XxPMiJ
 Z81IFCY9aCHvpEZTHzPA9f+vNnqR2ZBcpgpSgYLsJHoKQSPG2VWhT5chZk8IEgvKAZ8=
X-Gm-Gg: ASbGncsFc9foRT0uGRF2anadXnDVDHmYdMoB6p7Pd8aG/BH6xqToDgixY3Eas83trws
 +KcNuylClRsk2l4htHxe9HGZ/O6YhOHBCjhuGQryOA/Rdzz9OARkqBx792zK3CN3BERAY4IpZ1N
 eEt7Ougpkz6kgTZFezfdS/B0z94A/fhCam6ET+9Qkk87SuWyzA1E2dYrzn/N8CPG/3bZug+g8KA
 mJJyMFCJybxsn3scY9mgopTuwzaq1Zt8UbZztTGFr2xWhFMXSv3e9wfvk0mtGNP0sqBaOThDU7O
 qStieW/LKny4XABdH9ZPqfD3hkyn6HfPl6UDVcwV2j3uyFeQrB6aiL5CS4f1h/L9bb51itoPrfG
 S9fhEGQm18uwC
X-Google-Smtp-Source: AGHT+IEM6qbnQcwk6NiasnYziUequov7hQb7s84ttwa3FN0A37d6Ey/jsoVMoQJjD2wlA/6ZJWPQRA==
X-Received: by 2002:a05:6808:4d07:b0:406:3d05:9de3 with SMTP id
 5614622812f47-40646859697mr3411838b6e.18.1748213863455; 
 Sun, 25 May 2025 15:57:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-404d98b18a9sm3957966b6e.31.2025.05.25.15.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 15:57:42 -0700 (PDT)
Date: Sun, 25 May 2025 16:57:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Broken boards?
Message-ID: <20250525225740.GR100073@bill-the-cat>
References: <CAFLszThbRhKF1Xwqk+hLu8Y-VXB6+fHVXYfphfVjWMN=dVC1dg@mail.gmail.com>
 <20250525135553.GQ100073@bill-the-cat>
 <CAFLszTgPK_TWjoaJPMa6RAH-pugpO_uhkm-VafQLzaNuFZRDLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PdBwuaPk1YFubgn6"
Content-Disposition: inline
In-Reply-To: <CAFLszTgPK_TWjoaJPMa6RAH-pugpO_uhkm-VafQLzaNuFZRDLw@mail.gmail.com>
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


--PdBwuaPk1YFubgn6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 07:05:52PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 25 May 2025 at 14:55, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, May 25, 2025 at 09:46:03AM +0100, Simon Glass wrote:
> >
> > > Hi Tom,
> > >
> > > It seems that some of the boards in my lab are broken in your tree.
> > > Have you noticed that?
> >
> > Your lab has never fully functioned in mainline, so no I've not paid
> > attention to it and don't use it. I figure it's part of the lab
> > maintainers duties to figure out false failures and
> > more-or-less-expected failures.
>=20
> Oh, that's a shame. I didn't know you had stopped using it.

I never used it, since it was never fully green. I thought there was
still some problems with the TPM tests for example on one of your
platforms. I've only poked it in passing when I needed something
specific to your lab.

> I use it on nearly every PR. I did once send a patch to disable the
> boards that were broken, then another to re-enable them, but I don't
> think you took either of them...

No, because iirc at least one of your "broken" boards at the time was
working I think.

>=20
> Here's a recent run showing a few problems:
>=20
> https://sjg.u-boot.org/u-boot/u-boot/-/pipelines/794
>=20
> But x86, RISC-V and some rockchip seem to be broken in your tree.

I wouldn't characterize any of that as broken, just a combination of
lab issues (what Jonas pointed out for rockchip, I don't know when samus
last worked in your lab, no idea about zybo) and expected failures (the
TPM test, probably an incorrect test on pine64, I forget what the
resolution was for vf2).

--=20
Tom

--PdBwuaPk1YFubgn6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgzoFkACgkQFHw5/5Y0
tywUogv9GP3aWZzLlAxdrpfH+1O+yt9Ts32+961tpj9Q5Z1ICz2ltpkmHLZoTR1w
e+ZyblZr6+k8RqXvEBqE0v/Hrxb6Ru7+Kf4Y/hJEwoRrrzmHkyTJm4UkV5oKhd1t
om8wQdttGQD0QAO9UzURSCHvehCxpKeUq0xbooo3ZuicFmo0+dYiF8nZWQRW1Owd
IM3I6zJYPXhqEM5yXyCd8Z/sHMie3AZK+b+zcazzx03cEb9/9Y5NWFkUUhED5/vQ
A3d9+l/iXEcGEINnGXlsbmqDw8M8+Hqgnmzdng64GmQ30EOVM/gc5jEUv8Vnrbi5
BP6ltWKn//sOwYlAq28cWS8JCQRLbyMBDj75dT35UfXIJ7qZzilt0aH4lrg6rJ5e
DydEp82kTinGfpawQhXDwNlefsSLWmBqqhmK0YD0p8w9rYX82SzkJbSFpR3roYsp
3QSCuj34Lb7Bl8STEUNBTcUMsF9JUU93NKLrXrKT4qrQ+LkBiwlpRc7z50R/bIzR
duwug4E8
=IB/I
-----END PGP SIGNATURE-----

--PdBwuaPk1YFubgn6--

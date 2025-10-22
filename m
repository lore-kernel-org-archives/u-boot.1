Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E535BCCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 17:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 310B180422;
	Wed, 22 Oct 2025 19:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IxEfxeqm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2180781E13; Wed, 22 Oct 2025 19:58:26 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3D858004F
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 19:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4439fc3abfeso3048262b6e.3
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 10:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761155902; x=1761760702; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QLumypv45F0IxWiTExowMb8BdMonyFKxtEmGCrjO54A=;
 b=IxEfxeqmunzgCV+TUBH20Ss3UEhD8eyAwpNbNQe8l0qEnlINaOeY++AdxdVDtV9nCc
 I1GTuLR9DH1UDmCxaECUz6irJdYSYC0jEJQ42aoJ04suzkOnRvPko/VqAaJCSVk6FI86
 OGKb/UwuEtTUEy6RMhepLLJAShxoKplHVSQFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761155902; x=1761760702;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QLumypv45F0IxWiTExowMb8BdMonyFKxtEmGCrjO54A=;
 b=R+VT+A71LWnmimy2AyTt5/nPDj4MMANlvY7nkLTSLXrbztbQKV1YPm4cuZBVx2lKrQ
 oTwG1VGMA3pRlUCnuTkS4iIY1sx5e4w7uukhB2SzqYv3PzHc0C59UJhs+yHnxcvIO8Xg
 WpEo3utu4GlW2LS3w88OIezUrptEbiM3JOQwYTDBk3ewvP7eOoGiHOmGdKtLblEVkvvx
 ZuP8x5MIu6Qz7/sV0hxYg7e8+oxuS9sARApP+/imKvk1TJFgOxmMbhv/TRSOE+daxXpb
 fjkAbmmiRJqYq6NFAcHQoCntGRANVnbdRD9R3gpcnnyoTPZmvehlszZvTjSbDKMvqB2A
 TMgw==
X-Gm-Message-State: AOJu0YwInKdVbLb1cc3jOuNkTyOSCGnCpau8sPj27FWQ5RqmjmOWzwRT
 1VDyNy9hWKIRHEy1afVMOqOchkK1ebCoyi8oMHadWn0XIg6jCt8CYVtVGjoobzpTx0o=
X-Gm-Gg: ASbGncvJp9zDzmrfy3ysNRktT/EMpR+q0Dwdi4RkkcTqki2K1s6/fQ+c0AYnOQ0RMIq
 wXe+gDATMWLTM97lBKiwlS06we1INV0SW9GGVwaWdoxyGkQWjC5T/ryL5OxcYNOfuOFqms8w59D
 tYMqMtTEn+LEAf7mpLqbFA8Gt104x7pEPC/MKgCbGWEYqbjM10rtruSGwj6pyarZjiikLui+NJX
 cVpHM4RDojPexsg1g/2KXO6W7rhP40Aqo5em7QjTQB6FSz0rO0WFhUaRAMcsGot01s4//qlZNkj
 214FsFpEsxgdF1rs3AKyIN42Pph5a+kveDy5nvSaQIxoAK/z9xVUQKM0xm3+TYfgMed69aCiptl
 5XtKG7UeHsCEpvLMGi+c8rnFGrypDMZB5D94T1NzQd1JVDgluOeANa7EXfGUx5GUbtT5RobzEdb
 oEAYazI5p1C+eJvLmMXcpE7zoz2wwp3sLfrQPVdPI=
X-Google-Smtp-Source: AGHT+IFujhyMqdXWqretpkHG5VxP/joxEQHndqL6H5cGtfSG1XcRjRRndwdrlvJEmfJDBL5Yoi7WwA==
X-Received: by 2002:a05:6808:3387:b0:441:8f74:f1c with SMTP id
 5614622812f47-443a315d024mr8875035b6e.54.1761155902655; 
 Wed, 22 Oct 2025 10:58:22 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-651d7cc4b60sm3429010eaf.3.2025.10.22.10.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 10:58:21 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:58:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [PATCH v2 0/5] Allow falcon boot from A-core SPL on K3 devices
Message-ID: <20251022175818.GA1639808@bill-the-cat>
References: <20251015104702.3726411-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PSCSwUUvASqpElk4"
Content-Disposition: inline
In-Reply-To: <20251015104702.3726411-1-anshuld@ti.com>
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


--PSCSwUUvASqpElk4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 04:16:42PM +0530, Anshul Dalal wrote:

> Hi all,
>=20
> With the addition of secure falcon mode from my last few series[1], this =
series
> now adds support for the same to TI's K3 devices and documents the feature
> taking AM62x EVM as an example.
>=20
> The patch [5/5] (doc: develop: falcon: document unsetting CMD_BOOTx) of t=
he
> series is a workaround for now since we first need to refactor out the us=
age of
> CMD_BOOTI/CMD_BOOTZ options from the SPL boot flow[2].
>=20
> I will be working on a respin of my older series[3] addressing the same b=
ut for
> now the workaround of disabling respective CMD_BOOTx option works well en=
ough.
> With that in place we should be able to revert the patch [5/5].

Since you pointed me at your WIP for working on CMD_BOOTx stuff on IRC,
I'd like to re-order things for merging. Lets get CMD_BOOTx support
split such that SPL can enable/disable library functionality as needed,
then enable falcon mode on secure devices once it's possible to make
sure we don't support legacy kernel images by accident of configuration.

--=20
Tom

--PSCSwUUvASqpElk4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPkbNwAKCRAr4qD1Cr/k
Ci92AQCYAEZHd4bMo9iuFV6NHviTwygV4SyAzBxhHXg9Heu91gD9GCtxaynZzseX
KUyrap37qIP9W4j2r9P+/Nghv25HPgQ=
=Fk7d
-----END PGP SIGNATURE-----

--PSCSwUUvASqpElk4--

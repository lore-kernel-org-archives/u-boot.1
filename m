Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD0BC02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 01:19:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8239680658;
	Thu, 16 Jan 2025 02:19:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hDeWJAhs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03EAA8069D; Thu, 16 Jan 2025 02:19:14 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8BF380214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:19:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b6ff72ba5aso34859485a.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736990350; x=1737595150; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m5yxwaW9XUD74DL2ZR8ZTudIKyP3ZN3r6XUblHZ4SlQ=;
 b=hDeWJAhs4TuXS2LkgpecyH4t21snk7vyauA7Dt5GIdMEh1gobfcIsQFketEOMU2vsA
 9Z3BZmIIZiVZZp9UF4Vt3agUG+Op8XOZjdaRGQIIi5PazKbxenysvPscG7YuyzsPb67p
 ZHtQE3fNiSnM2ltJ7g/CuoX7mnUan1bOaLPh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736990350; x=1737595150;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m5yxwaW9XUD74DL2ZR8ZTudIKyP3ZN3r6XUblHZ4SlQ=;
 b=NZ6v9VXVlL1mov5gdl05uPAxGARktzK6hQwL9QEo2eaGmasXBESlyei0QPtAsoeUyQ
 iVSNBVWNqyX4tY3Es75bes34Q6y7ArztFqLOzeIb7EDNpSvd28hclE8Twa6D5h/3G/yX
 Qgy6ewHOjbUtq6QTh9QbZ5od9XZmGKWe5ri8L1wjfgD/3z/Ihv/ExIlsbm5uYEL/VZSW
 fvBh+wKDh8D9DrrNiVUp4MFEox/OHrbKs7o5RQGEdk6BFq+/ZfeIdyRarWpveZVyktVa
 sh2thGIKUGrzoq66c7+ffLEtEmadvjMrYLc/Id+DdgJjQmxCaCjevedwNOM/aNxlIl5a
 lrRA==
X-Gm-Message-State: AOJu0Yxf5WRFLXQe6hYHaj0rz8AO9qBIG4KKEIbukMXMAR+yzL5oh0u8
 GwOjJx18pbNRTeVCNLEveccPhBmoQ3KTAb2fcf02UvoAHf04sdgAsDn08ielO8iroTBxtwFWFGl
 Q
X-Gm-Gg: ASbGncucZFu24OaUzU3HRY0DpvvX/vDpPg78NbMkSs2vNi3rhN+0N7ULZ5CHndDzZo8
 Wwm59BIJEa4/ox5ctS+2cIrL2iWH2zopSdM4JM4gXFDksRLoMmFrqe2qybz+GD3Uambwe1Qg7GB
 758jQrqgAKvPR3KinTg9VKyo7X+VjZHhnlIxPcWKD+/KDn7Afxfu3woCnacytVVTIBBo1LuS6tF
 QokuBxlhl2DKNI0xPKj0QEidt5eUlY0rjN7tx0ARYVsbjwDSv5CzA==
X-Google-Smtp-Source: AGHT+IFIUv23uWatOnvodw8pPEg84FdLbpXlnTzTWURy03/LdLnw3yMJJhnwEG/DUAyh++v7mi0Zwg==
X-Received: by 2002:a05:620a:2452:b0:7b6:c92e:2e6f with SMTP id
 af79cd13be357-7bcd970e1c8mr4931447585a.22.1736990350598; 
 Wed, 15 Jan 2025 17:19:10 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad865e07sm70384646d6.1.2025.01.15.17.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 17:19:09 -0800 (PST)
Date: Wed, 15 Jan 2025 19:19:06 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: Simon Glass's future with Das U-Boot project?
Message-ID: <20250116011906.GF3476@bill-the-cat>
References: <20250102161313.GP3476@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iroCAIWsFqeiQqGX"
Content-Disposition: inline
In-Reply-To: <20250102161313.GP3476@bill-the-cat>
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


--iroCAIWsFqeiQqGX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2025 at 10:13:13AM -0600, Tom Rini wrote:

> Hey all,
>=20
> While I had hoped that the quiet of the last week or so had meant that
> things would perhaps return to how they had been before, Simon's large
> patch series and then comments on the TPM+bloblist patch have shown
> otherwise.
>=20
> At this point, I do not know how best to handle Simon's behavior,
> without soliciting feedback in public first. At best he's created a
> soft-fork of the project with his "sjg/master" branch. I've asked him
> repeatedly to explain how he thinks this is all going to work out, in
> public. I've had private conversations with him, but I want him to
> explain in public. Or, he can post the messages if he likes.
>=20
> And I am in the process of getting outside help that would in turn be
> able to help the project move beyond the BDFL model we've always used.
> Because at the end of the day, if most of the active developers would
> prefer the direction Simon wants to take everything in, that's something
> I can accept. But what's going on now is towards the worst end of
> possible outcomes I think for the project itself. And by that I mean,
> one prominent contributor steam-rolling over others and doing as the
> please and implicitly acting as an authoritative voice for the project.

It's been not quite two weeks. On the positive side, Simon and I are
continuing to talk in private and things are moving in what I hope (and I
believe Simon hopes) to be a good direction for both individuals and the
project as a whole. And to answer some of the "wait, what is this
about?" in order to not misconstrue things I would point anyone at the
list archives of the last few months for how things have finally reached
this point, but it's been a much longer running problem.

--=20
Tom

--iroCAIWsFqeiQqGX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeIXoUACgkQFHw5/5Y0
tyyEvAwAinXnM9SpgLKonwI/i88Srtog9V4W/LYHzdRmWOLNxudZDdFizGFZNMMx
Pl/9aiYI9EVT+S1I7X/+DFHJS5uA1maEkCPYDdImAKTsqGSWssrvYTXkHS4SHDRR
92NTtjPStoSrenAaS54cxFIVSCWJrUdPPDBR1A64Wae1c0axjcdvCCJ2tWjoaCFD
g0QifOKqw83DHHCPje8pY/H+6biF0CVyu3AUgvBiq4S7aE+rKXIBQI3Pbp/UFtNg
l9BsEEX8w3Is9YREwUIRHZ6coED7nxZ3oDOaoGq93z92IbK4IfAsfxTrAirc8nJm
E+iu56l2M8jHUnRW6iOaia8+i03jS5U41BGn6xCmuEfZYwNfYbB8WYCYc+6QXXIP
UtpQLdZ9TaGWPrlcAEvRpP07gWNGyqWXCPUxDlaNiB8P87N3BNzCyPExhwd+kh/u
Wq6Eb8PbNvRMaViNJKT8NzbeDcWpV7kh9iD0MuaVAdxRaiDPuh7/d5YcFT7mv/oa
5JITuw0L
=feiF
-----END PGP SIGNATURE-----

--iroCAIWsFqeiQqGX--

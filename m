Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC50FC369CB
	for <u-boot@archiver.kernel.org>; Sat, 26 Apr 2025 14:14:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30A66820F6;
	Sat, 26 Apr 2025 16:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Bf9KPVzt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C3D280FDA; Sat, 26 Apr 2025 16:14:36 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6CFC82045
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 16:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6065251725bso1117364eaf.1
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 07:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745676872; x=1746281672; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qtmeCxKENOitvlRhcZuY6Fswbr8diOkWAe1QsWTwpHE=;
 b=Bf9KPVzt788mYRbADDCMGVf+kCrVRMlnxDSblsbTdY5+s1krJqs3HiU3v8yuQtYGg2
 NsjCgQRhOGLAUz/SKsWENyeEoMo2yIZWuGP6aZKgLUo6s8OROyshi3nmUODfgyl8kbH4
 EHorcpxvI0KnAx8SATV9pA5iHWVhj4Emhp08g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745676872; x=1746281672;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qtmeCxKENOitvlRhcZuY6Fswbr8diOkWAe1QsWTwpHE=;
 b=dnvjlV5pfAqCMZf/0k2/iTKiAzYldZdA861ZKG0i6Uwl5cWSiZZlIhrA+M95jBoauI
 v5pRSYbeAeO5eegusyARs80CmQzNVWAGLU0crbXgJpPrS/lgo6NsTq7Vr76zIh0bbwmy
 Uacb1CIt7+QX2mULz3geV+cBa8WmQlULRcok075sPZ+svj1xgT3maQBKnU+ka+ySZfKv
 iMADv/2cJFkAPBWGgeorcTh9HBPBl0Yod8CL+uar3DqcW7hO/vKXdaPLlxC0iQY82mFn
 67+mQTaX59v0ekJjohzVTMEGJygozdUrP/6odKgfSQa7HZF5kI7E6rAHhk9eNZ4EFdtE
 EByA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYMPjTxMqOAPWqPH3jzrrhA0AH2kM998JaKmLLinT7kyx/mpZa1joSEE/3GSBh3yGKv7RoygI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+PzIKLttVcxXBIV2CiVlGzd/BRJmjZ7zAkNh/fcapaQUiQTq3
 zI0u6VAN1M3vfxgpC37OSzwy/hiExpMPCrAcgG7sJPjr5ZBLE9wP02YaPlKTyDY/QYHJJuzxAUW
 CPqY=
X-Gm-Gg: ASbGnctkXZgvpHN/wRrKkaimcbrABFmnNqMcUGIQjQCna1MY0hBWGBuJq0Wxy6LFPyT
 HdQ9wlpkBHl5r61UyVZIUyQaCuvkXmKBHXYe7GEpMzHpHwxvyjxP53bCOHRx5TO2WfoBnNe+f5+
 +PbMCnoJ73nBkHg75/0hhVh8VGnI4QVFU3Zah94Ujg4zTEkjtLxT4d2sYqM3Wj7XnppS+j/k3ze
 PIOkFqyPGYwt7IJTSVK1VSdHbXS8f+W27my4UQUnORsbD+GPRJ71szFItqKhNSTKwFJNeSD6UbP
 PY4Uj64d7A6GGumwsBSDQlUvTpV5vJyMX/EhcPqJyJoizm3JNFfmWow3+uMOE4l90IhhCy4i+SD
 qd9CG3f+tari/
X-Google-Smtp-Source: AGHT+IH2kYJzG9cKeLvWsrC90BPaQVW7CAsaRL3wnuvcvRwUFnstFFewIh/tJCS1OdK9Fy9IedmWWA==
X-Received: by 2002:a05:6870:2045:b0:2a7:d856:94a with SMTP id
 586e51a60fabf-2d99d86712cmr3284622fac.22.1745676872252; 
 Sat, 26 Apr 2025 07:14:32 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d97364d9c5sm1370901fac.7.2025.04.26.07.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Apr 2025 07:14:31 -0700 (PDT)
Date: Sat, 26 Apr 2025 08:14:28 -0600
From: Tom Rini <trini@konsulko.com>
To: E Shattow <e@freeshell.de>
Cc: Leo Liang <ycliang@andestech.com>, u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20250426141428.GY5495@bill-the-cat>
References: <aAte-nS8ZhO_Odw1@swlinux02>
 <174562459055.746741.13011026537921584133.b4-ty@konsulko.com>
 <756019b8-60f6-4cab-92b0-cd1e857a375c@freeshell.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3H4PAHPnMm53lFJl"
Content-Disposition: inline
In-Reply-To: <756019b8-60f6-4cab-92b0-cd1e857a375c@freeshell.de>
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


--3H4PAHPnMm53lFJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 06:13:38PM -0700, E Shattow wrote:
> The outcome of that merge went a bit weird for
> board/starfive/visionfive2/spl.c
>=20
> On 4/25/25 16:43, Tom Rini wrote:
> > On Fri, 25 Apr 2025 18:07:54 +0800, Leo Liang wrote:
> >=20
> >> The following changes since commit 10f48365112b164bee6564033ab682747ef=
cb483:
> >>
> >>   Merge patch series "Add PCIe support for TI AM64 SoC" (2025-04-24 10=
:46:17 -0600)
> >>
> >> are available in the Git repository at:
> >>
> >>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git
> >>
> >> [...]
> >=20
> > Merged into u-boot/master, thanks!
> >=20
>=20
> # The fix:

Sorry! Can you submit as a proper patch? I'll apply it quickly.  Thanks!

--=20
Tom

--3H4PAHPnMm53lFJl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgM6kQACgkQFHw5/5Y0
tyzJDQv9Hg+CrF0sRRiCs/6YsXYbJ1PdB4JsT0R1aI7cOR7VMQ8oQy6dDBv4Ev0L
uRRzFyNkMXul5hbH6aX4eZtWTLmLITfZuEUlCvXWlw3obWuGOGnVbUCg6BKfZmIW
MYHfnVD0j7dPxvQoOZ1BcQue0MLQGxPeG3uT5PtWrKVb7/ekLfCa3Z3LYWGXCODf
yyJIEELsUEpsVs/Dr516vC/VomXPWkSB+6Bfsb3uX8bNdTS06Ef96ohb8mnkBxi6
7s3xEBHjMzb59YTzvqphysNsk8pgJssedSd8Z8DzVYr9W4OqWn6q/6UF7vN74wyp
hWI3FHhs/LTpVG6DDgbG6v5SywqB8tB/FMNVroajeC8/LSv5c6YxLabnlZVwQs0v
W8cfx5P5Ju7tIUsc9Rb+++HVrr3wboFmwI1XLPyYWVE/UyhPGLEVSqyjRCjeYk1R
0B+ZFmsIITpqvIK5HMT11s1KgbHr8bjqxwVZKlOjPiuUukUhn2zFW62aHyK08v9g
3J0/xf5H
=M500
-----END PGP SIGNATURE-----

--3H4PAHPnMm53lFJl--

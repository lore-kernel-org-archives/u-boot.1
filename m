Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24EECDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 14:19:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E42DE86BA1;
	Tue, 17 Oct 2023 16:19:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XxkLUWt8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ADDA86F07; Tue, 17 Oct 2023 16:19:17 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62A7386380
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 16:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a84204e7aeso40225217b3.0
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 07:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697552348; x=1698157148; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7UkL67nNZhyoSb+268r/UFpVLK4RCx0p1faEEPF/1EI=;
 b=XxkLUWt8QkgENhV+ELAbfRhb1qrGnQduYfp/xhgf/7Al9D81lJC5VSsMzBBuxl8pB3
 uC8LmIHZI0QhlfJ/8bxpFs6e95/NY1Db9/iU7B+oIvMKBeTBatbyoSkiUoQBGrG9KzB+
 b2Kt8reJ9bAS7QVpF3b9cY/AGPQVq+07/LKvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697552348; x=1698157148;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7UkL67nNZhyoSb+268r/UFpVLK4RCx0p1faEEPF/1EI=;
 b=GKZsm4Smua+oqQniCJ3qk+5Lf3NX2xBin4t0dra0haG+RN4zTdgBs1ozuYhbzYPOT8
 8Lw7CQ7+8Zx7lfB5qs4I0TuqLba2dgZFTpSfKAuOEoXy0OOnUtlo6/jwUDjsOz5aXjGp
 RTpRxmshYwvmj1BKQ6vZQQhTGOJgkXo1t1gW144NEd2weHZi9okhdWoZbAfV118gUnvj
 RAAGMiCUUpHaunm70yMcCcy7dM8MuIiUEodp8YEVagT3MP00Izr6FWx/5AHs+heTB7rx
 6sGxMFk2TBOdPKwKEvkl2V98j5ZH1H0/qLsRg6gXtFTCui6MQ2ATPGdzQFIkzvUijzy9
 Du2Q==
X-Gm-Message-State: AOJu0YwBUoPVOlvrO6+U5bVOi6D64TpLCaLE+E1crT25v8UT5pp2qQxc
 wKFKUSK4n7myzGvW/E4WaVREhDsePGijfY+zoUIlfQ==
X-Google-Smtp-Source: AGHT+IG3j6PFi37bBtbbGIs1AnUqei7sQeg9mRbpco0v01luUHNh6Fkz51CqVvgU9yz4Dy6jqyxFZg==
X-Received: by 2002:a0d:c447:0:b0:59f:21c1:30b6 with SMTP id
 g68-20020a0dc447000000b0059f21c130b6mr2222151ywd.51.1697552348135; 
 Tue, 17 Oct 2023 07:19:08 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 x133-20020a817c8b000000b00583f8f41cb8sm638995ywc.63.2023.10.17.07.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 07:19:06 -0700 (PDT)
Date: Tue, 17 Oct 2023 10:19:04 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: Re: [PULL] u-boot-sh/master
Message-ID: <20231017141904.GG3119521@bill-the-cat>
References: <20231017023228.142539-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wAaoWvL6tVrFnvpR"
Content-Disposition: inline
In-Reply-To: <20231017023228.142539-1-marek.vasut+renesas@mailbox.org>
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


--wAaoWvL6tVrFnvpR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 04:31:27AM +0200, Marek Vasut wrote:

> RZ/G2L part 1, except for two serial port patches which I had to drop as =
they
> broke R2Dplus, they will come later via subsequent PR.
>=20
> The following changes since commit 3c3f1626919cd93cbe6c56e3849937de5be18d=
bb:
>=20
>   Merge tag 'dm-pull-13oct23' of https://source.denx.de/u-boot/custodians=
/u-boot-dm (2023-10-14 10:50:20 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
>=20
> for you to fetch changes up to 4e65545f7a35430710ce95bdddf9d683f7a3f72a:
>=20
>   board: rzg2l: Add RZ/G2L SMARC EVK board (2023-10-17 03:27:42 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--wAaoWvL6tVrFnvpR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUul9gACgkQFHw5/5Y0
tyy3JQv+N6qmBX6dkDbppbhgBkDWeWgx5sX9A9VVkEQq+CYA02jo2eebbjlCWoUe
rY1CO29VChL6u2OKG/0mTisHRm66Jo6r59XZaQAQsJX2xyk9Car4rat0AebAHbQ4
G33BeaFDpnzO8xyAmTrVUdWdj3SuvTJvy3M729yltBE/Tijlk1jeyI/PdDkIksAj
rL4ONn7wmVnH/1xS0RP1LVa5nJyC6oCY5l3w9upKmyAhKMlS2A5OCsq9Z/xAyn0s
tFdm5qs0tksj0y7anYOLEF9yk01kuJVeqwxY76fwZ1vaelDMW7Q7AT/khj399jwS
JZzS91IrTGQJqdswVwUBMIOWQM8TdjjmSYwGJ6W6PkxRhmNYJRNxBO1i1hF4GpU1
1TtUzv5ktMyP0jVgwRSExCItCd3nXlENrSt3kJi0+ody96CBs/d9QWQeVDogSa7E
wn8p43I6J76gDxERqijONcaAVVpEEoXFr8Znp1BPhZGlc8n8qgXouLaU9JCyK2z5
DQX3tzkp
=teLL
-----END PGP SIGNATURE-----

--wAaoWvL6tVrFnvpR--

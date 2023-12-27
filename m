Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452C0C47072
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 13:22:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C16CF8790F;
	Wed, 27 Dec 2023 14:22:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pQQSfJkm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AFFA87919; Wed, 27 Dec 2023 14:22:02 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DC4F876FF
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 14:22:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5e840338607so31328917b3.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 05:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703683319; x=1704288119; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=B36Kgm8pWAig5nE18qyiRMBCaFZoL/1J1Wi5HW96qvo=;
 b=pQQSfJkm8BfzhHUHPNBg6wd8k2ntf7J0GkvOxpUJ8T2HFngR2YdiQ1yZrAfqmLVy9D
 O59sKAwFZ78Qu6gqGZBYzigTq2ofX+CwkA+3AFdKKCU4evyMm2ksC8kRb6pZQxdGbMM+
 bT3b5O6J/VlC55s28X6tClDwUq2UCTaFT3smU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703683319; x=1704288119;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B36Kgm8pWAig5nE18qyiRMBCaFZoL/1J1Wi5HW96qvo=;
 b=XJRAVZF8dc2dsXaG7h6EOWu5Pjw5DmyJmm4sYkUlNImvYwmr7NfIeUf5tgT0l3+k/K
 tVQCTcALjdfmNXG2H06NQLIepiosY6rC6qC25xRBZzGH+W92owpr3gRBqAhB2m53HWuC
 mLYBg3o0K9qud72GWHFqYjDKAU7o6AVqgWk0JHot3s6WDD1bvOvD7WoEBnpUtZVULqtb
 iD82NjDYVAXEnfck16Rf7WHMuozYEnmRyAT6UMijDdA2G5zTXnb2kEvigUhtkAfhC0aC
 tLacU2bNRR874SFXZPN2lFBqm969yjzPV4/IH5MSL7NBxuALkHU8aCI0zshGKeilBgta
 mqSA==
X-Gm-Message-State: AOJu0YzVMjh2EeDlOi56ZxEOFAK5EASpVmfxUm0WYQyT/y1UahzCIVG1
 2tT/6XPgik2ozRnJdV2MHUJdSKsbajZXcQ==
X-Google-Smtp-Source: AGHT+IH5TTSA3S9vuMv7POvGHUVJ6WvXlCMSsCmeMvENMuJEG7oI2U/EjLQVgLQ00Sv907mDKoRP+A==
X-Received: by 2002:a81:a193:0:b0:5e9:9e43:2038 with SMTP id
 y141-20020a81a193000000b005e99e432038mr2887590ywg.44.1703683319290; 
 Wed, 27 Dec 2023 05:21:59 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 z12-20020a81ac4c000000b005ec2d763ae4sm2933904ywj.68.2023.12.27.05.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 05:21:58 -0800 (PST)
Date: Wed, 27 Dec 2023 08:21:56 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Andreas =?iso-8859-1?Q?Bie=DFmann?= <andreas@biessmann.org>,
 Michal Simek <michal.simek@amd.com>,
 Michal Simek <monstr@monstr.eu>, Minkyu Kang <mk7.kang@samsung.com>,
 Scott McNutt <smcnutt@psyent.com>, Thomas Chou <thomas@wytron.com.tw>
Subject: Re: [PATCH 0/9] dts: Move to SoC-specific build rules
Message-ID: <20231227132156.GQ2652760@bill-the-cat>
References: <20231227082405.2202246-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TxQC1jORMt+qOs+q"
Content-Disposition: inline
In-Reply-To: <20231227082405.2202246-1-sjg@chromium.org>
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


--TxQC1jORMt+qOs+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 08:23:56AM +0000, Simon Glass wrote:

> U-Boot builds devicetree binaries from its source tree. As part of the
> Kconfig conversion, the Makefiles were updated to align with how this
> is done in Linux: a single target for each SoC is used to build all the
> .dtb files for that SoC.
>=20
> Since then, the Makefiles have devolved in some cases, resulting in
> lots of target-specific build rules. Also Linux has moved to using
> subdirectories for each vendor.
>=20
> Recent work aims to allow U-Boot to directly use devicetree files from
> Linux. This would be easier if the directory structure were the same.
> Another recent discussion involved dropping the build rules altogether.
>=20
> This series makes a start at cleaning up some of the build rules, to
> reduce the amount of code and make it easier to add new boards for the
> same SoC.
>=20
> One issue is that the ARCH_xxx Kconfig options between U-Boot and Linux
> are not always the same. Given the large number of SoCs and boards
> supported by U-Boot, it would be useful to align these where possible.

I don't know why we should start with this now, and further not being on
top of Sumit's series to remove our duplicate dts files. And that's
where we can have the conversation about for which cases it even makes
sense to build all of the dts files for a given SoC.

--=20
Tom

--TxQC1jORMt+qOs+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWMJPQACgkQFHw5/5Y0
tyy92QwAthTbi0vYnAMFHAGbo9ADG5Y+4mbWDj4EG+6+U3XuKmQCtynXtcfVrG6H
B4qltYnuQj4I6w4mdw6k+45HaxjXTgYeRfdJi2Kq0/tLDMUeAlBNH1E0Gk3Obd+7
poNDtqRo4cR8YdlVOunIu+3ukyfW4hBRS5+7p3GyOER78lWcXVOU8BVbwpFcEHA8
CMKDEmjsQbnLxevQwjKGp6Fh0vhzJdtuaSWqTKVha7MxMa2LLhfJYgro5IGO7Pid
YG/7kFOvG22XECQPpqqIR0k0Nb8Tm0tg03DN2sEaU/WC+wmYyvYjCNql9n1m+tje
PYO8jvG+2HoQKBkdgKht0tLyOyz78kdm5uL82SGliDr6wBhTJz8NxNiCVuoKN1Bt
YDQ3CylZX20LR+BJkmin8ifEtqeSF814PcSlRR37tW+ZK1XJksVZhK9YM6xiR03e
ZVTRatogYbzi/RyFk1YBRi4F/7gdaCm9wg46X9vbjy7wLvH+ngJAggAw/d0wm2Mj
PLW2Egsz
=zlHV
-----END PGP SIGNATURE-----

--TxQC1jORMt+qOs+q--

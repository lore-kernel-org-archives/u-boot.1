Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBA9CCF9EE
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 19:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64F7B8004F;
	Wed, 29 Oct 2025 20:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ICilTAA1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 835928144A; Wed, 29 Oct 2025 20:15:26 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 624F58003E
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 20:15:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c0e357ab51so107330a34.2
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 12:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761765323; x=1762370123; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/CcZbZPodPPfMaK2JO/FYzwjFZwzAeDaFlxcY/O6sdA=;
 b=ICilTAA1Ws36uZaf6RzHThd3Qa8ZF2MU0jdM1X5KNmoASEzAsSDE+h7/dQCnr7C106
 e7VKM0uUMdLgvqCPEZkGb5WGzUKQueQXjgC967SYzT/M3sOAhTzG8GQuYH77jAsmw9qV
 0dFiQENrk3BvyaM6Vpd7XUXofHA2ys2oeMhy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761765323; x=1762370123;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/CcZbZPodPPfMaK2JO/FYzwjFZwzAeDaFlxcY/O6sdA=;
 b=RNs5SRSxfG5l/2WQq2AumckGDZfft/7L7E1pa3KgoilBm04FlVHkyuJ6Okw83e3omN
 rxQvI0G0TKngtmzWdzuFC4n1qmeJdgDD4NNJw3LA61adMElu5EzDpDl3yT1h64lynPyh
 69wrws2oxnXIyqq0FMyYXzhJMRSWAHF3LgwoWLC4lU/8lO0wyugjb9cYS+HGHgN8yt4P
 fD+6nm3yCHdZJNFKpr7jgRQjUj03RzmxdtoMzt3kfoZhsN0C8JtPA/BkwHo9vg/r0+rq
 s1W6Yyg+uPc/R5s0rOgbpu4MFQnUjRA73bEJY7lDcdyY1cBZ5IHkRHXhx1/j8a7GY3P9
 ySWQ==
X-Gm-Message-State: AOJu0Yw2eKkyfxFYm7wZy9PshJMLfdNJOF3xfrHk3ExutW4KeWt74KEA
 GRGBQGrh+CCaPchbOmPKFyh1bdXYX7TLLD2ac6w3UAdtTkR+3vWzkjE+No1OhIIp6OJpOAeDxbl
 zPNYdhq0JiA==
X-Gm-Gg: ASbGncuok3GUIEO81ATD6xlTf88IGITp3wiMbjRNtqNZaoDUA7/Dz0QM+mHKYLmWewv
 i3CtfI2SzmYVWN6ydpJIOIhTai9RN+3o5Z2FrXUVBLISFGvzZucyV7V/mqMB5BL8MUb4iIGHFNf
 SBiu+Q8z7iAatENFk2pom4BOl7TEPZlwy2Rv+I7FqYkYgSlbCk753sRSVyrZPVqSKs7l+VFL6nn
 7b/D2tA/5VCEyvsVAP4t2YSDGJizlpZXb/+3OBBnIneMj+9eOGaU9X+5mWODBIAXqjjkLt4026D
 2GPZGMERxkb35lxZVo+/cYrji7PRJlfxW61mv5CHCEDYNepvaZdS8WA54YEKU/b4C8A8Kc3WEAw
 OEwJT0caqsSaiiJFZ5w9kNtbiHliEmSEcXrCbj0/Nk5JyhoBxubahwJGg9I+RDQq2LcDK5+1l0O
 dbukDQew3mzF/45qI9UmyGmnN5OmKFGKHvNu2B2w4=
X-Google-Smtp-Source: AGHT+IE4/ov1YqsD7M0jUXmX89lHKNVehaAFFwjmnVhSaVvKLXJX0MTRiYamIAipHiN4wPgYlVPHzg==
X-Received: by 2002:a05:6830:922:b0:7b0:3df1:92c6 with SMTP id
 46e09a7af769-7c683060263mr2303735a34.15.1761765322947; 
 Wed, 29 Oct 2025 12:15:22 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c5301e39a0sm4405318a34.22.2025.10.29.12.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 12:15:22 -0700 (PDT)
Date: Wed, 29 Oct 2025 13:15:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Sukrut Bellary <sbellary@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Cheick Traore <cheick.traore@foss.st.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 2/3] pwm: put all UCLASS PWM drivers under an if
 condition on DM_PWM
Message-ID: <20251029191520.GM6688@bill-the-cat>
References: <20251029-pwm-kconfig-v1-0-80186567f2e8@cherry.de>
 <20251029-pwm-kconfig-v1-2-80186567f2e8@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c0ckpYnL3N83O47I"
Content-Disposition: inline
In-Reply-To: <20251029-pwm-kconfig-v1-2-80186567f2e8@cherry.de>
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


--c0ckpYnL3N83O47I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 12:16:09PM +0100, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> This simplifies the "depends on" since we don't need DM_PWM listed
> explicitly there as it already is made explicit via the surrounding
> "if". No intended change in behavior.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

> ---
> Note that I believe PWM_SANDBOX should also depend on DM_PWM but I'm not
> sure how to make sure of that. The PWM sandbox test is explicitly only
> built when DM_PWM=3Dy instead of SANDBOX_PWM=3Dy (is that another issue?).

Yes, it's DM_PWM only, and so could be moved there. The test in
test/dm/pwm.c is specifically only for sandbox but that's true of all of
test/dm/ and so UT_DM depends on sandbox and so that Makefile part is
fine.

--=20
Tom

--c0ckpYnL3N83O47I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQJnxwAKCRAr4qD1Cr/k
ChZRAQCCS/hjVmYXWXUY6YsH4bb6urdm4HENrJI1MBfD0ZHC8AD+O2BUL5ZxEewp
TEJsgA7Sk+m0utI5PVZ2PtPWp3w0IAE=
=rOjz
-----END PGP SIGNATURE-----

--c0ckpYnL3N83O47I--

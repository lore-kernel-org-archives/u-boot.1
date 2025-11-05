Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F9FCCF9F8
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 19:19:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB42D83AC5;
	Wed,  5 Nov 2025 20:19:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EXzzZtxT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC60783AC7; Wed,  5 Nov 2025 20:19:02 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91DD083A97
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 20:19:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c6d2ec149eso136499a34.1
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 11:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762370339; x=1762975139; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TczcIiwny7GOGXoWt48NO/y7cfWr073MnHyTxAcQbUU=;
 b=EXzzZtxTHN96XxXjX40MOz/XLJoLxB1ISfoRrfJ24tX8ajiBXsaZvQ1UipzPOnkZvJ
 003rEvvM6HnOt/FH0eya/GABXIQY/cUpscGoOdU2TMdj10m0bKHV+7xhN/CBFGCq67Ak
 9WUdoxeuEHiHHRUGI4wGQbDDp0MzRb98Iawls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762370339; x=1762975139;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TczcIiwny7GOGXoWt48NO/y7cfWr073MnHyTxAcQbUU=;
 b=U0NTmafHE1DrFsBHuHxGIBza2cMPEz56C82Hlqcgr19VAOHo6H9bULUdNNEOlQRwIR
 /g4PGw1oyqzrzIklCg80d8lQLGURmRjnwYdlx70msn6Q51BOKl7mKa1nMVBbkeqzSkqi
 9Mh7xoRZh5Mxm27iKcwZD3DKumQiXM9xAVZeMXiO6esRG2ho48Ia2cmSA6KPhARizoCf
 PgjnGonkSj4tjvgEytBCaHBKVIcqPwFRl6u+vBtyIjyvP5+rpGJhdzveS3POHidWh8E5
 4K5GHxzfclMZVvjteLyGNstBNB3efb3wZnfKYnp7n+R2HsXVu7OX4BuzXg82r7IXYOCV
 Dwjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKrpAxCYym0ErHpubioyoLKvVL8CFm7SeS7GSmAg6xYyQQaWBnPp38dYzEfEfWVSoO/YJsOos=@lists.denx.de
X-Gm-Message-State: AOJu0YzwV30XE5YwDnP2tPyrCbFwlB9iYKGlY3JZLcMbMrgQxtoJDVgL
 sCE99Nq8Ua1b09V0BJ2/nWxe7RBmeNoAasFkh1cFo2olkfa5Fl1f/E/jZ7gKrqjJgF0=
X-Gm-Gg: ASbGncuv+RG4FuzdsSAn5xIihni/6tytQezZijG7SpkhwafCe8MUAr/aqsuP3C4e/7b
 QEJbNnvtvI4xp1JofO8q+MAhtOk9Ux1+SboMWbSZw+5MaUObSNOFBmPB9q+dT38vLaypP//WUrF
 00ZU+spKGsenTAIOCR5OMonp4512nCTWZL5nmLRNB0eZjqfRkESgVe40rshTTuaZDYxTjzBrHq3
 Md+dGmcKmWgQFqyzBJCshyFODqFkWScZUFaVvMj+Iq6S9zJFrm1Ra1P4XHP33kTwATsgdHG5lTY
 b0ZhOyhtYXnJjP8zNVjAbhHRqQ9jzVHXbt3WnKDjax0tGroOCIWrTpn5XJzJdGVIE3yLbGSj9z7
 UKtaM5dHbj3swiExasKYzDMtRdoQK3NDDTglOMTNPkx/ojq1XOoMq3LiWtManlBZgS9Env/O41/
 9Jyqu6QgL2rgqycTli5mk6TdZ4xRb474wqXTEM+63aDVZ4hMuwJA==
X-Google-Smtp-Source: AGHT+IFyF+UJ3DINI2sMRjFwTb1MpgmrivK0WvJRPih3q88gbQ2+AmDBxAz5cYjHF8T9hiutfqQrbA==
X-Received: by 2002:a05:6830:4120:b0:74b:dd1e:d12f with SMTP id
 46e09a7af769-7c6e134af6dmr433944a34.3.1762370339233; 
 Wed, 05 Nov 2025 11:18:59 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6c24eddd6sm2362268a34.17.2025.11.05.11.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 11:18:58 -0800 (PST)
Date: Wed, 5 Nov 2025 13:18:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] test: do not write to 0x0 except on sandbox
Message-ID: <20251105191856.GS6688@bill-the-cat>
References: <20251105180748.115441-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ROO/yRyjrauibcPB"
Content-Disposition: inline
In-Reply-To: <20251105180748.115441-1-heinrich.schuchardt@canonical.com>
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


--ROO/yRyjrauibcPB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 07:07:47PM +0100, Heinrich Schuchardt wrote:

> ARM and RISC-V do not have memory at 0x0.

Except when they do have memory at 0x0 like Pi.

> On X86 interrupt vectors are stored at 0x0.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/cmd/fdt.c      | 4 ++++
>  test/common/print.c | 8 ++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
> index 96a8488e172..6b07999c88f 100644
> --- a/test/cmd/fdt.c
> +++ b/test/cmd/fdt.c
> @@ -269,6 +269,10 @@ static int fdt_test_move(struct unit_test_state *uts)
>  	uint32_t ts;
>  	void *buf;
> =20
> +	/* This test requires low writable memory */
> +	if (!IS_ENABLED(CONFIG_SANDBOX))
> +		return -EAGAIN;
> +
>  	/* Original source DT */
>  	ut_assertok(make_test_fdt(uts, fdt, size, &addr));
>  	ts =3D fdt_totalsize(fdt);
> diff --git a/test/common/print.c b/test/common/print.c
> index 76ee851fe6a..389d6bf4069 100644
> --- a/test/common/print.c
> +++ b/test/common/print.c
> @@ -169,7 +169,7 @@ static int print_display_buffer(struct unit_test_stat=
e *uts)
>  	int i;
> =20
>  	/* This test requires writable memory at zero */
> -	if (IS_ENABLED(CONFIG_X86))
> +	if (!IS_ENABLED(CONFIG_SANDBOX))
>  		return -EAGAIN;
> =20
>  	buf =3D map_sysmem(0, BUF_SIZE);
> @@ -244,6 +244,10 @@ static int print_hexdump_line(struct unit_test_state=
 *uts)
>  	u8 *buf;
>  	int i;
> =20
> +	/* This test requires writable memory at zero */
> +	if (!IS_ENABLED(CONFIG_SANDBOX))
> +		return -EAGAIN;
> +
>  	buf =3D map_sysmem(0, BUF_SIZE);
>  	memset(buf, '\0', BUF_SIZE);
>  	for (i =3D 0; i < 0x11; i++)
> @@ -270,7 +274,7 @@ static int print_do_hex_dump(struct unit_test_state *=
uts)
>  	int i;
> =20
>  	/* This test requires writable memory at zero */
> -	if (IS_ENABLED(CONFIG_X86))
> +	if (!IS_ENABLED(CONFIG_SANDBOX))
>  		return -EAGAIN;
> =20
>  	buf =3D map_sysmem(0, BUF_SIZE);

I need to double check which of the things under test/ are already just
sandbox only and which are things I'm currently running on various ARM
platforms. Did all of these fail for you on something or just some of
them?

--=20
Tom

--ROO/yRyjrauibcPB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQujFQAKCRAr4qD1Cr/k
ClM0AP9SIVAd0Fv1O/UqBji56heC7CK25kbeMC6lPHcBFUGqUwEA/QM8xDqQLo3f
zzApBL67K/mRqAld1BstMvHWJfN0Fw8=
=M7Dg
-----END PGP SIGNATURE-----

--ROO/yRyjrauibcPB--

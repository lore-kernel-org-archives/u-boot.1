Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A133CCDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 14:07:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00F1F86F26;
	Tue, 17 Oct 2023 16:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qGh4AjgA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4287586F26; Tue, 17 Oct 2023 16:07:11 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0537486F2A
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 16:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a7be88e9ccso72153547b3.2
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 07:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697551626; x=1698156426; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7i0ZKxzUOQwELnYs+ilIo2guGmb+Hg5Ff5YaRlIAjH0=;
 b=qGh4AjgAmF9XvUhHi0cnWIiW4Te2AiyjpY9l7zmnKNQIPLf24yp41e28V0t2WdHxW9
 PJAcL+UKFvoeHIY2Dl8lk9T6CQ+3oknWSt9EiRjgsDtnFGPrIFVOnDYo2UkhP5cZLRlF
 5ZWXGgcfmeM6WAXTZatSsEJB/1MPUKTlWadDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697551626; x=1698156426;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7i0ZKxzUOQwELnYs+ilIo2guGmb+Hg5Ff5YaRlIAjH0=;
 b=p3qQYh0x5xSIXPi5si8F8E7xmvZ5M5gU+tDYyV5XLL0PwaGqrpwBG9B7n4fyUIjoai
 sSdyePs3R1tmg5cqQEnOFa3Ctz+q49a2dAJQrETNt1dNyQKLcLCZ5202m5orJrEplC0s
 yvMvhMhQ0ddH10LYX5tNdNgopJ10LmWjWKRoQZb1I/vHBrLP0Twl0a/izEo3uGnBigSM
 6kBYvqZk6USmKdS7T6PAl65uvGZomumwphHKK1MJHJw/24WehC6SOExB9pcKZ5lzHv3y
 Ip8Lt5AR/VeQINgs3aMWhTZRAJXi3Np4+kCeJWpZkWQiClCmHNyU3NEgM3+QAymbaaBe
 QNHA==
X-Gm-Message-State: AOJu0YwnjFCksnCiaTQ0WZmJQe1Z+Fm/Jr96rm7JXwhml71ACLqC6Xfo
 JBT7k/kzdzC8cKidvs5hN1TvYw==
X-Google-Smtp-Source: AGHT+IEHOSgbd7+hkut+VWq22gmLVpZqatJONksnyY2/nc7y+B6s8kVlmceqlikkw5bRWjOWWmOYaw==
X-Received: by 2002:a81:8702:0:b0:5a5:798:4f0b with SMTP id
 x2-20020a818702000000b005a507984f0bmr2349381ywf.52.1697551626416; 
 Tue, 17 Oct 2023 07:07:06 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 d14-20020a81ab4e000000b00570599de9a5sm623115ywk.88.2023.10.17.07.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 07:07:05 -0700 (PDT)
Date: Tue, 17 Oct 2023 10:07:03 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v3 18/32] video: Allow use without CONFIG_CMDLINE
Message-ID: <20231017140703.GZ3119521@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-19-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qaDB7geUpjqGJd4C"
Content-Disposition: inline
In-Reply-To: <20231016222835.596572-19-sjg@chromium.org>
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


--qaDB7geUpjqGJd4C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 04:28:09PM -0600, Simon Glass wrote:

> Provide a fallback for when CONFIG_SYS_CBSIZE is not provided, so that
> the console can still be used.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  drivers/video/console_truetype.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/video/console_truetype.c b/drivers/video/console_tru=
etype.c
> index 14fb81e9563c..e4dad3f9a191 100644
> --- a/drivers/video/console_truetype.c
> +++ b/drivers/video/console_truetype.c
> @@ -125,7 +125,11 @@ struct pos_info {
>   * Allow one for each character on the command line plus one for each ne=
wline.
>   * This is just an estimate, but it should not be exceeded.
>   */
> +#ifdef CONFIG_SYS_CBSIZE
>  #define POS_HISTORY_SIZE	(CONFIG_SYS_CBSIZE * 11 / 10)
> +#else
> +#define POS_HISTORY_SIZE	(250 * 11 / 10)
> +#endif
> =20
>  /**
>   * struct console_tt_metrics - Information about a font / size combinati=
on

NAK, this either should be SYS_PBSIZE (output buffer) instead which you
move out from under CMDLINE or SYS_CBSIZE (input buffer) should also be
outside, and both get a help text to explain them a bit better.

--=20
Tom

--qaDB7geUpjqGJd4C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUulQcACgkQFHw5/5Y0
tyxz3wwAqtFHID9Rg15su+loUTUxncsc2E0CNGgAYu4vFJncLp6VPJc3JPJMj4IH
Fr8bqQJSWd9vehrbnsrVUbWigJK1YbQa3BIlfYb28R2jZvPZX2JEg0KTFhh3k7Q3
VhhHIe5wo7oILhfdIuhDvyvBjpq5+kzNhRxsCFWnRF4JxY+JTmjjoL7mPtiwy2CX
a/6vvcccWGv8k4qfFEgqBEtJ52U8HxVd78cQTx5x0W0tNQsa4UQPUsy9cdrJj1rq
jGUB41ayQO9GnqChuR3lNirDSz3UMDx2kcgik/P265uJidlSlnaz53DRDP7PojNj
tN6bYMeFg6AUpsovK1jd1HGJd5NeM9DdSWk8NmQlCakEoh/IqspxKWUbSXJFfRCJ
tBFJz24HQKlEOlgTyj4J/jLdb0eD7jritqcI0yIzLwTpuqK0mqevRQMbQNLTQgX7
GYjMjFQTYfV7gqZbz8GofnbYVgNDXMCNTnwU719VD0ZuWAuGpDTskhfBR4oQCFVN
6rGa18Gf
=6MTf
-----END PGP SIGNATURE-----

--qaDB7geUpjqGJd4C--

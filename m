Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB098C02193
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 20:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39E1D80711;
	Mon,  3 Feb 2025 21:10:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q0jGjnea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9067480079; Mon,  3 Feb 2025 21:10:43 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71AC4807A8
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 21:10:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-467a17055e6so57926401cf.3
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 12:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738613440; x=1739218240; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8J+IrjG9rXUw3PlDr3R9FqrjLgekpfWcUjMKxk0g/ZA=;
 b=Q0jGjneataFXAG+1pEnzREQe+u2HQR78mMGQgjJ1E+TZJh9gF4NZcUm3uEntC636RH
 GjLH/cy3mvNqT6WIYg2cEb4FDf8yX2uR5twP4Mkt4jD7vTuB58wqx7UbA35flIo/gv1Q
 JEKqEYxv4YJoqPzOB8cr1sWbUsYpy3R1HOtBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738613440; x=1739218240;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8J+IrjG9rXUw3PlDr3R9FqrjLgekpfWcUjMKxk0g/ZA=;
 b=gU1gJK+99dvaEtqx7gAEfJg3WpQFzdW4Xn6fph/JHG7unTQXIW92fsOA2kUjvR6VGb
 tbc3LqYo+JwF0nF9TRKnIj0IQGCuVWr5a6+kTdO+Bx83ocbtZeU2OItQJkv66VLdsO1x
 Zheu6b5/KjeZfafbgxgac8gOcm7PWAzd2SXf+Ug8bX0jPIUdl8L5Zn8J0JruGnKj6QFs
 jsUi6zRjg0bEGOuOT9CT/KdlaZcbWtU2gdFg6VtlY07lNR5AgMqP4kd+bUqkrTx66iyM
 hQudCWaUYkpxfT+BvTyGjzSqAVgOPCRE0y5fyv4gnLN1Z2hKfMXrGhfoXgZm/tcHCJc+
 FSbw==
X-Gm-Message-State: AOJu0YzXdbbyCC3mOF954ourtlmnm0xCAWrTz4/gVLRBlU1BOWZXjg03
 kGhAjB7KxL+9xbQihptRx0IlLiWVUVIF2o7NpJCHmOcXUg+er1ataLibM8aHE7o=
X-Gm-Gg: ASbGncsRfYy4hH09obk8QCcE9FGtd78pWSgLelO4i84XsZT/QFK1N9B/vl/Z6694oLB
 Kmy9MLq9ys8oO/Lq9zMeMgFdhm4kHdrvtBFm3OTHGxBjMtwuOm0r+JkxnelUhueubahMBW5LxkE
 KOtkaR4sfRWgpWojes5MjezjA6FmOGV6gssXGum1MrOH3aqH4xh9dnd1aqtbcnpBk/JJj4Ap/vM
 3MuFkwHuOp2c8AwT3bNadIZQcDJC+DUKA8R83wBkglfk5RljDs9JEPNMRomYIvRAKzx0B05GzBA
 W8hmSI8SKLrtRDw=
X-Google-Smtp-Source: AGHT+IHcysbyJBQDDjnGDyfMF8wR5gnxzkZ50CCm53gZH0PC7xXqXfTk/A05Afml8fV0bbr9jbyWZQ==
X-Received: by 2002:a05:622a:1993:b0:45d:82a0:5028 with SMTP id
 d75a77b69052e-46fd0a7fda9mr374301721cf.1.1738613440348; 
 Mon, 03 Feb 2025 12:10:40 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf0a7475sm52103511cf.5.2025.02.03.12.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:10:39 -0800 (PST)
Date: Mon, 3 Feb 2025 14:10:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH 31/32] efi: arm: Simplify the crt0 file and update link
 script
Message-ID: <20250203201036.GT1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-32-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Hficm9ADPwedn/F0"
Content-Disposition: inline
In-Reply-To: <20250203174245.1331464-32-sjg@chromium.org>
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


--Hficm9ADPwedn/F0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 10:42:24AM -0700, Simon Glass wrote:
> We don't need to manually add the PE header, since binutils has support
> for this now. Remove it to simplify the file.
>=20
> Set the link-target to efi-app-aarch64 so that binutils knows what to
> do. Add rules to pick up the arm64 files.
>=20
> Make some updates to the link-script for arm64, so this all works:
>=20
> - Pass  .hash .eh_frame and .reloc sections through to objcopy
> - Put RELA pieces into a single section
> - Put linker lists into .data
> - Embed the dtb
>=20
> Note that it does not seem to be possible to use this approach with arm,
> so this is left alone.

Did you mean x86 in this last comment? I'm not sure about the rest,
either way, so I'll leave it to others to comment on that.

--=20
Tom

--Hficm9ADPwedn/F0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehIrwACgkQFHw5/5Y0
tyx1Ngv+LoW6FWrlF9/qTe6/aMgTwYVXiSGiMpoYl7q05I1eV0CnYg9Hck87urzF
sWNKe4rtLqY+Ibjp9xXmQU8i745BS/3OaAhkIh+LIakG/AMdL8cne5yrCHfTH722
J/zpq9cngoEEpapR/cHA+/fdFQPoTOaZYInXgV6XHAfpv0pn0j7sbDh/I1R9ffmO
DqrZG0jgox+rT9EKZx/Npon1duMjbzjosyGAKq7Df/IKKHz95KkW3iI1UNayrhJ/
t7vJxJRKTY/gjfK+0E8MHjeiHkUz4Xl/RONrnZxgRnhqUVG2ujgFSKjPrGmH7GC9
IGgtYC1CUJx3TADLg8coSCWkObrEpbpdNHHUXqfdB+Xq37jrFahSuNwMU+aOXynL
+NG2ho77sCrB/kIyiLmTlZ/wwah/mpuPR/tSS6Hy/kP0kY4zZCDuQa7qQyMMj6PA
JWeX/JGClS8acpIaXqHEz1qGIJfmWiXB6NRhS8iSH1wxOUbsieZcg3YP69/LBUFh
NAse4l6M
=QEn7
-----END PGP SIGNATURE-----

--Hficm9ADPwedn/F0--

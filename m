Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676A3D10BED
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 22:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0274189045;
	Sun, 27 Oct 2024 00:34:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tODR8Es0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA99F88D94; Sun, 27 Oct 2024 00:33:58 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA68A89040
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 00:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b1601e853eso245180085a.2
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 15:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729982030; x=1730586830; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ex1VLJgPpbHJinCc8+RbpyyM/VQU+HB/iNXl5hXnrxY=;
 b=tODR8Es02erPeKNv3d8QOV3PwZQid8e494FH/fClObDo/lSCrxwa5o0mj07x8uNOqc
 PQXlwtHoKWJ4oGczFQ5+EkIBkNNSEcfvbuGvz4HXZz1yZGX2Fk9LpOTL7Bb/3BKqaT4w
 c2XNlIenwbT0r5qE752fy3hiRpVqWGPVCuPs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729982030; x=1730586830;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ex1VLJgPpbHJinCc8+RbpyyM/VQU+HB/iNXl5hXnrxY=;
 b=cgVDeGbJpLqWKdlBG9FaBexvCOvukvYFbAHfKTs6Nq1iIqS4GU07+cUyoe3Rvsosyq
 MQ7hLZ4uV3yBbr0kRNT/I5EFvvyspevu1fQmDc5e/ONFvupwpKWXoHqZ7E4MEOPPEXTo
 Dm/GivkS20ILwuoDJfWAfA3tQmQnHyzP3CTcmd8GJ0ltI2oQckCrVPLMIh2ORJAB2EIO
 gCuqUhtv4UB+a1MOa1hMnhtO/D4Ea2d6MvVyofzgX7gTuK2/X+EZkGIf+1jO0+6cL5mv
 nYW0TbfNxh5UfVJeWHtclmRJenNNgQt2gp0rUF0liR/03gnzXGtMaXBB2NJokQSa6Mtx
 1h6w==
X-Gm-Message-State: AOJu0YyyhhJftuEg7+uAPiX/pQDZK57jWgo/F5LfIjkNfQ1fcic94CGK
 I/UCvjsWtMKnVgYNJKlMMdVWPvyklKQ7fcgqdPnayedQMWGB1MDesG6utmM5Tzg=
X-Google-Smtp-Source: AGHT+IGvEN8X+Vho4dSG235yH+CkgniACi+0PwlJV66p3BZet5REy1W+VhQW110N9sRLbfMAZpOZwA==
X-Received: by 2002:a05:6214:398e:b0:6cb:faee:76bd with SMTP id
 6a1803df08f44-6d18583c4cfmr60240296d6.37.1729982030563; 
 Sat, 26 Oct 2024 15:33:50 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d1798b0962sm19026806d6.51.2024.10.26.15.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2024 15:33:49 -0700 (PDT)
Date: Sat, 26 Oct 2024 16:33:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v2] sandbox: Add a build without CMDLINE
Message-ID: <20241026223346.GI4959@bill-the-cat>
References: <20241026120252.865215-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r95b2y+CHJk1rJm2"
Content-Disposition: inline
In-Reply-To: <20241026120252.865215-1-sjg@chromium.org>
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


--r95b2y+CHJk1rJm2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 02:02:49PM +0200, Simon Glass wrote:

> Something this breaks, so add a build to keep it working. Since sandbox
> enables a lot of options, it is a good board to use. The new config is
> created simply by copying the existing sandbox and turning off CMDLINE
>=20
> Once we have tests for non-CMDLINE operation, this can be adjusted to
> run those tests.
>=20
> Create a new build which will be picked up by CI. Update the maintainer
> entry as well.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v2:
> - Create a new build instead of messing with CI
>=20
>  MAINTAINERS                         |   1 +
>  configs/sandbox_nocmdline_defconfig | 365 ++++++++++++++++++++++++++++
>  2 files changed, 366 insertions(+)
>  create mode 100644 configs/sandbox_nocmdline_defconfig

Please use the #include mechanism instead of a full config that will
also now have to be kept in sync.

--=20
Tom

--r95b2y+CHJk1rJm2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcdbkoACgkQFHw5/5Y0
tyxAUQv+LgqsBo1HA9Cf1HLwsPHlDY7LGn2ZI3voltkR9vpmeycJmK4pnZgk1vj1
Dz+Uu+VuWRtMCPEgvRv+NUHTzwhwqlZ2ECJ/CRTieuM3iliV3/6MZyDEs3nktYb8
lLkoOab3QIjwv/Op/36oF2VqqG3U1xjRTtgHzzJyGEG5X0RVqowZvEmAM8RhoODE
1iEWdCa3Lcxxq5n7JrG6MY5URL+f4n3gXDlsksK+xjskEfBge3QdZwfkYhwQ2iNY
ZzAxNn0bCuC7upoWhQwQYau4CEHi1EWcL8x2f22xnmPUzK6lv2Jqt984UXLw/zgR
7C+vmGxspI4Win+9qFeIW102QDMyeEHhHESW9TyeD3buefTZq0chEJIp4RJVEe24
wKERIyyOxI+iB/Jxu3FrjOrz889x8zxkdbUX+AG/gCgjfI4qds63q8qnsOYR21S+
LSh24sqKSK8MHokNgV3QyhPy28Z4L4M88SEtUrTVyXXfXsGWBoH9oWjxWvwby4L2
5dkXofVb
=2GiC
-----END PGP SIGNATURE-----

--r95b2y+CHJk1rJm2--

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017EEC3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 13:04:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 700D288708;
	Fri, 26 Jul 2024 14:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DCQD2zmg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D91E87C7E; Fri, 26 Jul 2024 14:59:30 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3F5388729
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6b7a3773a95so3734986d6.2
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998765; x=1722603565; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wORB9pXoZxUVrCdK04fSgSjvkRQSECTphUOqpLrixM4=;
 b=DCQD2zmg1Grnw1Jidg7/CVN4FjerVlJmJvOtz0EZ0HH3VZXSizmfqdHClN9dyg+Lxg
 6AZzqgGYUiKF1ml6YC8zjVmZ4itdMnVgLm4IQzLcGQ7liE0Qjp30YF6GBWDSPxFRDzqV
 BRa6lyFCc7CUTOF/oWa1NSAUkxX6j4frvQo78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998765; x=1722603565;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wORB9pXoZxUVrCdK04fSgSjvkRQSECTphUOqpLrixM4=;
 b=paMlfDjJG83HyXXw1I4lLqShiLF2RftZgcgBD+x3F7oz+ZV9FMsNRFD1eNmAXpLb1i
 Ftb2Aa8GdM6sRp0qEN2lE1giFfaOx23CJw5nkn1xKdJzAVmLSalRPX6j1p29Rhnv38Tz
 Y8UCMesqoDX0Tf1IO2Aqk9v9vNYFSS6JJ8C51xnvn0QwhV8FVpnU5twwHhwrMae5aU3D
 r7ZOIalI5rSxR1oXrmCZRhJ8r7ugghEIOsBXi5q2/bgAgaFBjGhZObrFSL8pypc49srF
 F8CxhtYAQzZHCDli86Lkd60Tc2TRVute7F+N20k4jl7yBxJPPe6a+bakq2VjjQylFyCk
 FTdw==
X-Gm-Message-State: AOJu0YwgTP8xZ6SsQUQm3485wBU1jdebB7I5p9eB1rjBNmorvx7PqyqZ
 E6JXi5r9IYY8rftOk3S1gg6jmBcSisYxSigZhR0zH/Uo+I3yckEBbkK+dFkKkVbFqIFHTIfzfkp
 vXtEE+l6aZV+rK6TKQiUM/xnA94fDLq/L50qy
X-Google-Smtp-Source: AGHT+IEkM1VHfwtH8T0nAZFFgnWfc3nIyCpudIjKF0gUR76gyskEN9bGlkyAD5wN472U5krx+/WFghOMFLBgNQq4rV8=
X-Received: by 2002:a05:6214:212e:b0:6b5:7e70:3537 with SMTP id
 6a1803df08f44-6bb408714damr63258136d6.50.1721998765562; Fri, 26 Jul 2024
 05:59:25 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:59:24 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTg96myB7u_GfjwBQ6N0LX-u1_UoX184+UZxdBb_ftjYVQ@mail.gmail.com>
References: <CAFLszTg96myB7u_GfjwBQ6N0LX-u1_UoX184+UZxdBb_ftjYVQ@mail.gmail.com>
 <20240701-python-3-12-fix-patman-license-v2-1-7de3d039e6ac@collins.com>
Date: Fri, 26 Jul 2024 05:59:23 -0700
X-Google-Sender-Auth: ZXsmCHcwNONNCP12KkaG0PKo4dY
Message-ID: <CAFLszTjvOfN=d8uKUt9eefPsod1wymo53GBvLaxE-eWVwBO8JQ@mail.gmail.com>
Subject: Re: [PATCH v2] tools: patman: fix `pip install` with Python 3.12
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Brandon Maier <brandon.maier@collins.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, 1 Jul 2024 at 18:51, Brandon Maier <brandon.maier@collins.com> wrot=
e:
>
> Installing patman with `cd ./tools/patman && pip install -e .` fails
> with the error below.
>
> As described in the error output below, the license line is not allowed
> to be only defined in the setup.py. We remove the 'license' field
> entirely, as the Python Packaging User Guide recommends using projects
> classifiers instead[1] and we already set the GPL-2.0+ classifier.
>
> > $ cd ./tools/patman && pip install -e .
> > Obtaining file:///.../u-boot/tools/patman
> >   Installing build dependencies ... done
> >   Checking if build backend supports build_editable ... done
> >   Getting requirements to build editable ... error
> >   error: subprocess-exited-with-error
> >
> >   =C3=97 Getting requirements to build editable did not run successfull=
y.
> >   =E2=94=82 exit code: 1
> >   =E2=95=B0=E2=94=80> [61 lines of output]
> >       /tmp/pip-build-env-mqjvnmz8/overlay/lib/python3.12/site-packages/=
setuptools/config/_apply_pyprojecttoml.py:76:
> >           _MissingDynamic: `license` defined outside of `pyproject.toml=
` is ignored.
> >       !!
> >
> >       *****************************************************************=
***************
> >       The following seems to be defined outside of `pyproject.toml`:
> >
> >       `license =3D 'GPL-2.0+'`
> >
> >       According to the spec (see the link below), however, setuptools C=
ANNOT
> >       consider this value unless `license` is listed as `dynamic`.
> >
> >       https://packaging.python.org/en/latest/specifications/pyproject-t=
oml/#declaring-project-metadata-the-project-table
> >
> >       To prevent this problem, you can list `license` under `dynamic` o=
r alternatively
> >       remove the `[project]` table from your file and rely entirely on =
other means of
> >       configuration.
> >       *****************************************************************=
***************
> >
> >       !!
>
> [1] https://packaging.python.org/en/latest/guides/writing-pyproject-toml/=
#license
>
> Signed-off-by: Brandon Maier <brandon.maier@collins.com>
> ---
> Changes in v2:
> - drop the license in favor of license classifiers
> ---
>  tools/patman/setup.py | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks

Applied to u-boot-dm, thanks!

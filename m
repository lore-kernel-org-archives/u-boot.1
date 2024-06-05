Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E37C27C50
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 02:14:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D20AE8833B;
	Wed,  5 Jun 2024 04:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VUwKxEx6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CD32882F9; Wed,  5 Jun 2024 04:13:52 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D68C88297
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 04:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-62a2424ecb8so21012797b3.1
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 19:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717553628; x=1718158428; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W/pmIGbkiSPBXGj6j/lB9ltNjPX6Ye4MET/lVqaUnII=;
 b=VUwKxEx6rsMisgOOCMLV1H639yUAgQUV/+qVjMEfvDRmHUYAO4y3XA8nKWkljUy2t0
 Ot/t520m42tWN0a3hM4zMUj+j1YH6bk65UcZG93Q3bY/1izEDSwkZ9vZbNgSMLyEvspg
 bnwerksMWY58cISS6xHxUOg+CRY5g9YavL8/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717553628; x=1718158428;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W/pmIGbkiSPBXGj6j/lB9ltNjPX6Ye4MET/lVqaUnII=;
 b=NwyZek7z3zTdvNyu0Ss72SGuNDjHMrHrolClhggttUvU5Ml9DMeUj0ntR12wO7Bd7d
 DugvkMrg6L6gfH2pbCDVpJ4M9WrCQEhO5VhW3DgAo5FZA9GW/4lYudiIITjqivYGufPC
 a+v1RSEymAdDVA8A+RctQYOqC/SZJoLYJ9dIfoJjUO1clG/vIkh3f98yGLgi9hNM43Me
 wmipT/uIPEVDpVdd6xaNTJtiicLXqAaqQzhSbINACbuLzvmTetykuuJ6gXykYC6EMKcg
 lOn0uYfRt6En8+cc1E15q9qBD7L/ThRzKuh0NGQxYZxD6zMh9KuAfLgu9B1YOQ3GKWue
 BWvQ==
X-Gm-Message-State: AOJu0YxfT6vcSGdRA9nXZ9aqNE/qNHOBhM82Nx9BcqPw2OdHBnPfViak
 59ENfeg5E73jevCYUJQSGDUOXUy9nwIa6/ZYArIyzxjBNS4oc8UXDv8i3MHctnak+2ti1dTpq/a
 Di0Ha+lXEgi1l0bdqZKK3KefS/wsHZahUQWg3S8sEWTT/k/g=
X-Google-Smtp-Source: AGHT+IGDSLERDS6bwTXFIzyjnASSSIFKkFyAmZHdHeolycJPeeueFcD7ornP0oP2rY9fn30Ef0c1/NM6sEw0npl8LtU=
X-Received: by 2002:a81:b383:0:b0:615:15fe:3cb8 with SMTP id
 00721157ae682-62cbb5048damr12231527b3.28.1717553628079; Tue, 04 Jun 2024
 19:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240604163134.1149752-1-brandon.maier@collins.com>
In-Reply-To: <20240604163134.1149752-1-brandon.maier@collins.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Jun 2024 20:13:37 -0600
Message-ID: <CAFLszTg++xwrcHyt-3hficWSMm=wBJ+bS1oTrjcDY7HYJD7pEg@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools: patman: fix `pip install` with Python 3.12
To: Brandon Maier <brandon.maier@collins.com>
Cc: u-boot@lists.denx.de
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

On Tue, 4 Jun 2024 at 10:31, Brandon Maier <brandon.maier@collins.com> wrot=
e:
>
> Installing patman with `cd ./tools/patman && pip install -e .` fails
> with the error below.
>
> As described in the error output, the license line is not allowed to be
> only defined in the setup.py.
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
> Signed-off-by: Brandon Maier <brandon.maier@collins.com>
> CC: Simon Glass <sjg@chromium.org>
> ---
>  tools/patman/pyproject.toml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

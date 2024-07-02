Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B81C3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 15:52:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6712887837;
	Tue,  2 Jul 2024 17:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ABVZSORP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7AB88871F; Tue,  2 Jul 2024 17:51:49 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EC4488746
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 17:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-44639c3d8e7so25249771cf.1
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 08:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719935505; x=1720540305; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=44UGTsrsCi2xRcj6/DkVZYbZFYiA3wAa9RA3H3YNPZo=;
 b=ABVZSORP/kNzKEz/3gxRPZaVhCEqVZpubNCtH2T7LcLe/Qaz6PrGz6HcsoooqCMx1z
 Zz355XC1Ddu1ZmZOnDdP1J01gAo8YRs2BZH1/+wncsh6xP6Udr1kiuplp/Byq/898Ads
 H6d4LL2svCNYb3HhwJXb5la8VRFtE/Ngk/Zcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719935505; x=1720540305;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=44UGTsrsCi2xRcj6/DkVZYbZFYiA3wAa9RA3H3YNPZo=;
 b=Tx51JMZga8pC0Np0OWhdLldRsJA6iW57H0h8sG7H8R5Gp4cMHFKEN98MFKpFCvaKld
 hoQd+J7U9rMFzkz2g53DvgLDcgR/RMDvR3A4+Mkk2MpTsSwKITMe1Q/EetqiVC5GHpMF
 IhLeyV/zSX43ESZe1xXRlkbu+rz4hvqIt/aReQ4QaUPB2uI0jZ7x8bl93RxbuhAkMwHP
 7poyfrCrAp5cLZdVkpi1GXkq1jlJRiB6bf5SVsmjnSHOwUAaUAHsmruXA7pn9oDtrBVo
 b2Nptth8HruipOWwdINTUVyYANtlnmU/weuiFjXsD52BVoum+s9tDjogziXbitysF8rS
 9p4A==
X-Gm-Message-State: AOJu0YxK+PHCfMdA8qwlRxRgzNPerTgfN2jvLa8Hds4Uy5r39awR3tuO
 zqHzFot2QXZa9H84rI5oXUkSpthIz6Ssf5QhK4KXz93mV6EX/ipMpdvjdiGr8qV28LQWmbqBT+u
 /+fBg7ldmm6i5BOksHrTSRUuKWddWnXINbxpc
X-Google-Smtp-Source: AGHT+IFkPbjILN7QhzrJTwpZe+eqcC+DXTMNUza6ZMMvYB24IpI3LCNY/keQ3PZYB2mEqFNqjSbP5QC3OkLu5VQxv38=
X-Received: by 2002:ad4:574e:0:b0:6b4:f644:9d87 with SMTP id
 6a1803df08f44-6b5b70cb13bmr118660706d6.21.1719935505221; Tue, 02 Jul 2024
 08:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240701-python-3-12-fix-patman-license-v2-1-7de3d039e6ac@collins.com>
In-Reply-To: <20240701-python-3-12-fix-patman-license-v2-1-7de3d039e6ac@collins.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 2 Jul 2024 16:51:34 +0100
Message-ID: <CAFLszTg96myB7u_GfjwBQ6N0LX-u1_UoX184+UZxdBb_ftjYVQ@mail.gmail.com>
Subject: Re: [PATCH v2] tools: patman: fix `pip install` with Python 3.12
To: Brandon Maier <brandon.maier@collins.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

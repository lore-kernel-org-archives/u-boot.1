Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDD5C2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 14:35:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA05D884D2;
	Mon,  1 Jul 2024 16:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lZteZALI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA77D88096; Mon,  1 Jul 2024 16:35:03 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E78F08863E
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 16:35:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-79c0bbff48aso245415885a.1
 for <u-boot@lists.denx.de>; Mon, 01 Jul 2024 07:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719844500; x=1720449300; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iqV/jhs5qaYRKXd45iljGdsX20mP20nvPbY0qsgS/oQ=;
 b=lZteZALIr05bnHPqLTyhvYQkH9kND6Le/V6y8Pc+cly68QjT1P49HYXw/Y7VtqJMl4
 IOQ3vWC7jQrqUnc++mesA5U8nmcTCA1+YoAhD8jQmNNHsbIYm1i+wL2naYm269rCQd3y
 xyclsBkCJ0rWyFKPrPOdlbI7kkV6FzE7sLIIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719844500; x=1720449300;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iqV/jhs5qaYRKXd45iljGdsX20mP20nvPbY0qsgS/oQ=;
 b=RZgmCjrED24sQstNJfTDRwiU2iIzDc34fJSF+qMfPS048fglRpifa8kEuXSqWkZQUl
 DpQUyZrxrAHoh8GhpLvKVfVr3T7dJI5QOicIJD1kSKXH+bfTXfajnNZb7fWhhUks8MXJ
 sARySAizMYrnRbgXC0oiuOGRtFtm8zkzfRCN0ZO7zzznlA0XiUpOPFGoXDTAbWpF5Jst
 YjN9W52xNkZ2lLEjcNKkRztNKNvQ3hTC/Lh/7I0v05zhg2Jb41K+6Taxr7yAv5tbfUaV
 mtCumAa+qslpHRzo1pUy4ie3vyYDoU6aQqfHdEoLzq/k4mqeze9LqtLDR9W56h82jkU7
 C+gw==
X-Gm-Message-State: AOJu0YwEopQfL4qObvRm85ScupA6koox1GbRoxjyI4tsrvxryc53dhoT
 kyY4GI0FMYFJk5bqB30bnl6fCc0wDR3de3V+l/qmQ1aaFSEH6LanY48ljAMtipBifCODx8/IACS
 Mm7bHh+oRH0GRMrvPO1N7PqXIbuwTfv1iAVg4SchZ0OBUGo0=
X-Google-Smtp-Source: AGHT+IGz6iS2s5XGtSUvtEVLX4tUOH/fbKlAP2HLPEbijs1rdPInGTLJp1AlXL4pQ+S4D6+FZhSe9b/pufDHl/0fwVQ=
X-Received: by 2002:a05:620a:472a:b0:79c:9431:f71a with SMTP id
 af79cd13be357-79d7b9edad4mr701483185a.11.1719844499742; Mon, 01 Jul 2024
 07:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240604163134.1149752-1-brandon.maier@collins.com>
 <CAFLszTg++xwrcHyt-3hficWSMm=wBJ+bS1oTrjcDY7HYJD7pEg@mail.gmail.com>
In-Reply-To: <CAFLszTg++xwrcHyt-3hficWSMm=wBJ+bS1oTrjcDY7HYJD7pEg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jul 2024 15:34:48 +0100
Message-ID: <CAFLszTgc5D52ARKVANyWOimyB6VpbtwZ_S+jzO8vtEPyXKRmkA@mail.gmail.com>
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

Hi Brandon,

On Wed, 5 Jun 2024 at 03:13, Simon Glass <sjg@chromium.org> wrote:
>
> On Tue, 4 Jun 2024 at 10:31, Brandon Maier <brandon.maier@collins.com> wr=
ote:
> >
> > Installing patman with `cd ./tools/patman && pip install -e .` fails
> > with the error below.
> >
> > As described in the error output, the license line is not allowed to be
> > only defined in the setup.py.
> >
> > > $ cd ./tools/patman && pip install -e .
> > > Obtaining file:///.../u-boot/tools/patman
> > >   Installing build dependencies ... done
> > >   Checking if build backend supports build_editable ... done
> > >   Getting requirements to build editable ... error
> > >   error: subprocess-exited-with-error
> > >
> > >   =C3=97 Getting requirements to build editable did not run successfu=
lly.
> > >   =E2=94=82 exit code: 1
> > >   =E2=95=B0=E2=94=80> [61 lines of output]
> > >       /tmp/pip-build-env-mqjvnmz8/overlay/lib/python3.12/site-package=
s/setuptools/config/_apply_pyprojecttoml.py:76:
> > >           _MissingDynamic: `license` defined outside of `pyproject.to=
ml` is ignored.
> > >       !!
> > >
> > >       ***************************************************************=
*****************
> > >       The following seems to be defined outside of `pyproject.toml`:
> > >
> > >       `license =3D 'GPL-2.0+'`
> > >
> > >       According to the spec (see the link below), however, setuptools=
 CANNOT
> > >       consider this value unless `license` is listed as `dynamic`.
> > >
> > >       https://packaging.python.org/en/latest/specifications/pyproject=
-toml/#declaring-project-metadata-the-project-table
> > >
> > >       To prevent this problem, you can list `license` under `dynamic`=
 or alternatively
> > >       remove the `[project]` table from your file and rely entirely o=
n other means of
> > >       configuration.
> > >       ***************************************************************=
*****************
> > >
> > >       !!
> >
> > Signed-off-by: Brandon Maier <brandon.maier@collins.com>
> > CC: Simon Glass <sjg@chromium.org>
> > ---
> >  tools/patman/pyproject.toml | 1 +
> >  1 file changed, 1 insertion(+)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Unfortunately this causes 'make pip' to fail. Can you please take a look?

Regards,
Simon

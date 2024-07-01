Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA670C2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 13:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60A2C886F1;
	Mon,  1 Jul 2024 15:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T+eL/zcc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83373886D7; Mon,  1 Jul 2024 15:57:59 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5529C886B5
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 15:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b4f7541d7eso15299376d6.0
 for <u-boot@lists.denx.de>; Mon, 01 Jul 2024 06:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719842276; x=1720447076; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1N3GnET7EHkDFlZ5sLf75UNmqOr5wUqS4dOlRtpmLqE=;
 b=T+eL/zccx3aUkuHD2sUBrAYU0a7wA10DH/zIvGp0xo/mwS4KLlCArYOhOFaPcRb7Rt
 Cb8y6KdzA4ZjO68LK0JnD74TfMnkOkI1TZ4CpKRYM5dALElZ3zjoZeQY2Tp19yD8GqrV
 fYamaHlOg4N+33OQOj9+WVVec4amG3NMHzkaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719842276; x=1720447076;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1N3GnET7EHkDFlZ5sLf75UNmqOr5wUqS4dOlRtpmLqE=;
 b=o7u0GId/Tm+TjK2IDSTXLJJJNTPxgHqMmVGJzjjeyfFP3JKZ9BHrFf4IivN9uCXCoz
 c2LhMbrMCeWmks/ryq+vgGCxqGD39S0XVTCnjMwBnRZ40a1iLMhTvboyuJQNDfmOclwN
 DrB5LYO11ZyYNjKGd2mVYLvtvGa0Ejm76xmuCDcber/5teKxlMUn5dKcyt1hGYSt4/vr
 9zfy2dVup0Fw/6TC5yD9YOS0LwTEigxw2hkS1u7fSKs9f2bc0EfMqMiVSXjJjkWmHdLL
 lYVNd2RDaw1GuP6QWWE7PU/PL9bKJbzvAe5bXsdfCPqEyxGoUFEG3+flxAGmvdMWAIV9
 ijHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/kiGDP/KgBNl1we8mH0JL2VCUM2gpB36mXlfzhPpGmWsoqcxV3g37aJUHT3pF08dQb7dakXyj1jtd5JQPM2pCQ91oWw==
X-Gm-Message-State: AOJu0Ywmyy2Vu/tBGbehbf74Dktt1ahNvbGOmSoFXqoFGCvBDCu6xfif
 C/8ZKfGSvWAb2/iFaEudHaAj23Joeb5BeHzytUuvt2YQAmsbsOKO4xCIXWA4ohkwnIQw3ZNig1n
 lAxjN0DuWqpU0t9q7tjBJAzIeSxJpWJEmTgJaOgAV1t2NXSA=
X-Google-Smtp-Source: AGHT+IGZpMC1MRLkzto0sdIvKl52zBrlF5kuPRshUt84rQLu6liBLwe6120PbHqqak9i8qx7fDKaRXeZ21XXIh8ZgiE=
X-Received: by 2002:ad4:5766:0:b0:6b5:2655:4518 with SMTP id
 6a1803df08f44-6b5b70a3b52mr90493026d6.20.1719842276287; Mon, 01 Jul 2024
 06:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240419023632.29078-1-seanga2@gmail.com>
 <20240419023632.29078-4-seanga2@gmail.com>
 <CAD=FV=Unkeyszq8FZOG3NODgTK2ke8OrHNR=K06k55ZmUoTA8g@mail.gmail.com>
In-Reply-To: <CAD=FV=Unkeyszq8FZOG3NODgTK2ke8OrHNR=K06k55ZmUoTA8g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jul 2024 14:57:45 +0100
Message-ID: <CAFLszTi4YW_NRzX1=mn2q82X8pf6aZFX9YwC41ODZEfthDw+fQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] patman: Add a tag for when a patch gets added to a
 series
To: Doug Anderson <dianders@chromium.org>
Cc: Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
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

On Mon, 29 Apr 2024 at 17:49, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Apr 18, 2024 at 7:36=E2=80=AFPM Sean Anderson <seanga2@gmail.com>=
 wrote:
> >
> > When a patch is added to a series after the initial version, there are =
no
> > changes to note except that it is new. This is typically done to suppre=
ss
> > the "(no changes in vN)" message. It's also nice to add a change to the
> > cover letter so reviewers know there is an additional patch. Add a tag =
to
> > automate this process a bit.
> >
> > There are two nits with the current approach:
> >
> > - It favors '-' as a bullet point, but some people may prefer '*' (or
> >   something else)
> > - Tags (e.g. 'patman: ' in 'patman: foo bar') are not stripped. They ar=
e
> >   probably just noise in most series, but they may be useful for treewi=
de
> >   series to distinguish 'gpio: frobnicate' from 'reset: frobnicate', so
> >   I've left them in.
> >
> > Suggestions for the above appreciated.
> >
> > Suggested-by: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Sean Anderson <seanga2@gmail.com>
> > ---
> >
> >  tools/patman/func_test.py                           |  2 ++
> >  tools/patman/patchstream.py                         |  5 +++++
> >  tools/patman/patman.rst                             | 13 +++++++++++++
> >  ...t-cast-for-sandbox-in-fdtdec_setup_mem_siz.patch |  1 +
> >  tools/patman/test/test01.txt                        |  1 +
> >  5 files changed, 22 insertions(+)
>
> I love it, thanks!
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Simon Glass <sjg@chromium.org>

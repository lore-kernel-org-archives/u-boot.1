Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5D1C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D239C88966;
	Mon, 15 Jul 2024 15:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B9USMsas";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31105888CF; Mon, 15 Jul 2024 15:32:03 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A926088928
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-44f5df38e64so11374781cf.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050316; x=1721655116; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+V62QipstA86o9FWuuzOA7FbZsEQV1ZXuzri+CKEX8Y=;
 b=B9USMsas+AGUMlB40KiIemClSxai37J+KqPqVQ5KX/SvMvc8L0bvqZfRU39DC2ZW3/
 BKnBEk7wnRWsbFbwYUNveHS7OF7c8xTXr6cQqPMV9Yg9TfiQC1iEIBV+slfbOAJRCepY
 z4zK8NaGRQ7gEMeTZG0zS4Cunyw9nSRBFV8ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050316; x=1721655116;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+V62QipstA86o9FWuuzOA7FbZsEQV1ZXuzri+CKEX8Y=;
 b=vKI0WSlJbtyRRYCatuauEvScz1/EG4GQpuxThaI4+dnoM1abLwS5KoK2xmt6+B+nla
 Izm90/As3AugViFtpW4SSricLunxg9oiDVLIcPw6z4ouwv1c54dmVelLxhxmu3KDRtMC
 /joOyb2W5eFJYy67o7QRbYkFfSHg4sLImC6oyRPVvWf1sAg6lz+nzrQUwMibjwIDJArn
 39mvDgEyVSCkSqAjYumShYbvjUCJPzxeKrOKnFCIxEn9DUMrJUZVXi2Bs+A1jvD6/+CX
 Kra7MKwvJQdyQR/kvpT2Ez5N9XqNdNEUIl4SsZ0ihj5hFOQHioyEc1lCCTUqDpgTREIb
 b0Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+2+XoOxj7RoKpm5d3hd0Veux6zUKmkXOJzdMqbq3lAXB7D6pLd0YdQ92XB23uJyZhekq8BkogTV2+mw+4lg7IyAOiAw==
X-Gm-Message-State: AOJu0YyPGhD4ukbogUljs/xFckzkxM99Xb1sk2P8uqnbhmYkp/v4eakf
 N8keGpxLlUjponzFsgPEu3NFYPmqTPyIyYBYmx+N1kIY2ckpYiK90TLWaFYfwr/jV/yP9+eOATD
 7eoFcQwW4C/yG41bOTUEz+UdU2YQJP7sATHgRmnHdjdBNKDY=
X-Google-Smtp-Source: AGHT+IG0V5lP2lbwA9j0FiLOlDWykLnFPeZjW31J3MXyEPQ+d6CbVtNIHT/CjXOSzHfiEGZa7OA9Z7kWITeXesXscrI=
X-Received: by 2002:a05:6214:ca9:b0:6b5:5f3:3f31 with SMTP id
 6a1803df08f44-6b61c1d0b1amr238484786d6.52.1721050316486; Mon, 15 Jul 2024
 06:31:56 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 08:31:56 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTi4YW_NRzX1=mn2q82X8pf6aZFX9YwC41ODZEfthDw+fQ@mail.gmail.com>
References: <CAFLszTi4YW_NRzX1=mn2q82X8pf6aZFX9YwC41ODZEfthDw+fQ@mail.gmail.com>
 <20240419023632.29078-1-seanga2@gmail.com>
 <20240419023632.29078-4-seanga2@gmail.com>
 <CAD=FV=Unkeyszq8FZOG3NODgTK2ke8OrHNR=K06k55ZmUoTA8g@mail.gmail.com>
Date: Mon, 15 Jul 2024 08:31:56 -0500
X-Google-Sender-Auth: fDV5N7hHRkLYwq-XC6RMrFbN_yo
Message-ID: <CAFLszTjP1jbNJesFdFpErj2Kz+t234Wy7yOTJy=SiydDox=_Uw@mail.gmail.com>
Subject: Re: [PATCH 3/3] patman: Add a tag for when a patch gets added to a
 series
To: Simon Glass <sjg@chromium.org>
Cc: Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, 
 Doug Anderson <dianders@chromium.org>
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

Applied to u-boot-dm, thanks!

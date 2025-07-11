Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C88AC83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 17:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11C7E82FCA;
	Fri, 11 Jul 2025 19:41:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bp6lelJn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9EAF82C84; Fri, 11 Jul 2025 19:22:40 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6B5E8277D
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 19:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=davidzangcs@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3137c20213cso2320032a91.3
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 10:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752254557; x=1752859357; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QzeshgnaOkHvJ6j1QF6Th8Qu+sraLXqrngaJ964fKts=;
 b=bp6lelJn04xG/xpky5beIQR3YIWRQ9z3rHokvK3mF353/kG1gdlPwJHp+lvKQne4Du
 x9o0J66Q81Dymp207iXL/gQcLAMoXP/y2w3gg84Rkg0s/bMY7rwozaYK7M5xt/ErsQ81
 WEZiQbUNiD2uYeNMk+s94O+utkFPiBsO48CBeOoijMaHNev0i4v7sCkA0XKLuH+f99UJ
 sATjTmLuwxa0r6AKthG0MPaq2s5Syt12hXpzOvDZtDqmediIkzVy7y0uWKk0bTo3nCr3
 jNfi2i17ez/ZGMjU3l1TtG0BanjWR5uOFITojl6dckk+4VZNAVexaeoaflwDmS3jURzm
 1NOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752254557; x=1752859357;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QzeshgnaOkHvJ6j1QF6Th8Qu+sraLXqrngaJ964fKts=;
 b=MEP8YLpOtp7Ih/QTlx8QIzE2iYezfmW6cyeQ67XgOMd7MY2tTgE9wekA79dOVm6VAP
 i9vUygNN6jrPoKrKl19X6z3R1P5IIBoPuLUFB/dPHVr0IJJO/hkiImXUha08z2EZpRHD
 vnrV5DniY2kKa1Y932vQXdVsWJDKUOHjwjO7YoCoWMBiazsxWjUgkBSv0akLXLp+SRwn
 AZmZIYBcLeGNh1GhTZNb7z6v0KuMxk+V2W9GVmXul3zcl0sJixLePBuSFEpavpl6dbZC
 Zv7WaVrHWZO0MAXXC7+jbOQaBB9HV1EmZLUtnEmu6+tF4fcu3KjRsDbpi+LoA3S4q4Xj
 UUxw==
X-Gm-Message-State: AOJu0Yz3R53Eb+RU+ACD1mOX4qNuyDf+G0kj9ZhdsNr26Rq2E/aSh7wl
 vh5fD/mBMUokMA6IGS3I6m1IhaMHnNctei07WtxPNrtUbskMhEtVhLZtn2g94O9/T2+Q45wEECc
 Ya1sSGw68lrPDgnFPUCa4g5sfmmTpC9Y=
X-Gm-Gg: ASbGncudojamymudE4vRHMzPEJFqas/pYbVDkAn3bLQUAU9vhGx8jcc0ct0fEmd+qRk
 Lkkdx9VN2oRhXVbhGkYnnb13Z2HdMSECWPe4w2abR3b61MAtXBJk4CxzJ0OnR4MnEssbnDeYT25
 zCwuXkD9GyADPS5nwqovvEublWjX8A7nsBqT67IAZb1CFVc5rFVeduBIcQXGSViauXm7DqyqziP
 tPw
X-Google-Smtp-Source: AGHT+IHE0a+b2LjHVTRbZbmBbv4lPndenkPdEGA9m5dJaQuqIzpw0uFLku/MhyvfVe0U8VDyqCTDkZ6mKY5mIaruny8=
X-Received: by 2002:a17:90b:2ecb:b0:311:f99e:7f4a with SMTP id
 98e67ed59e1d1-31c4ccedab5mr5811407a91.26.1752254556878; Fri, 11 Jul 2025
 10:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250709234918.140919-1-davidzangcs@gmail.com>
 <CAOMZO5D1d=Y9i9E+Pcm0sbyKE+M=zUj_9Rs_QHbaE5DPvWFA=w@mail.gmail.com>
In-Reply-To: <CAOMZO5D1d=Y9i9E+Pcm0sbyKE+M=zUj_9Rs_QHbaE5DPvWFA=w@mail.gmail.com>
From: David Zang <davidzangcs@gmail.com>
Date: Fri, 11 Jul 2025 12:22:25 -0500
X-Gm-Features: Ac12FXxGFAZjVUiOipmFYOwGnJTTO8iF2gLMCcWOZYijUZwf4gnTAWXIj7Kv_WU
Message-ID: <CACwB3C-KKZS_5JOfFvF5hWsXr4AXUU+OTR1+rBSd5NpkH4r+rg@mail.gmail.com>
Subject: Re: [PATCH] soc: imx8ulp: Add celsius unit for temperature
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, uboot-imx@nxp.com
X-Mailman-Approved-At: Fri, 11 Jul 2025 19:41:30 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Thu, Jul 10, 2025 at 5:59=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:

> Hi David,
>
> On Wed, Jul 9, 2025 at 9:44=E2=80=AFPM David Zang <davidzangcs@gmail.com>=
 wrote:
> >
> > Signed-off-by: David Zang <davidzangcs@gmail.com>
> > ---
> >  arch/arm/mach-imx/imx8ulp/soc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mach-imx/imx8ulp/soc.c
> b/arch/arm/mach-imx/imx8ulp/soc.c
> > index bbcd862caa3..5de15b59b96 100644
> > --- a/arch/arm/mach-imx/imx8ulp/soc.c
> > +++ b/arch/arm/mach-imx/imx8ulp/soc.c
> > @@ -400,7 +400,7 @@ int print_cpuinfo(void)
> >         if (!ret) {
> >                 ret =3D thermal_get_temp(udev, &temp);
> >                 if (!ret)
> > -                       printf("CPU current temperature: %d\n", temp);
> > +                       printf("CPU current temperature: %dC\n", temp);
>
> Your change looks good, but please add a short commit log and send a v2.
>
> Since it is a simple fix, do I really need a commit log?

David

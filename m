Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA74DC4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 10:13:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 210FB87134;
	Fri, 12 Jan 2024 11:13:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="cAoZEVn+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79DAE87937; Fri, 12 Jan 2024 11:13:25 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC7FA87067
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 11:13:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50e759ece35so7062459e87.3
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 02:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1705054402; x=1705659202; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qcH0ykeoZRhZca5f2hbrnKoz6hzD6NJGGfdus+mNHM8=;
 b=cAoZEVn+4AtimCjzzrH3QfdefHUDz6HS1DuEe6AzcajKMfKlNo0WFN/eb1V2pckbZi
 1gt7TS/7eiTGlIWsKIPVEafWmyHBA2+ZfMqXUcOkmO6bSYeIBB5c9/PwoGsdRbybqQ08
 aRxeoTBETESbU+gnLS3/N+ShIJQqJAk2eRZgwXrITfRSrpopVUbq/avo89hbNRsiJW40
 TzU/xun94PtpqnITb6tDpF2+px9kR/ia4rFNovl3Cru5JhSWWQ9saZEJLcQ+llIoKJKt
 qRIU9WyPdHEY/SNiOV+fYcRf2cxRWJvVOef2v4gzN/p2KmK2IMdKqPdkb+YCxgnH1Jfh
 NbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705054402; x=1705659202;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qcH0ykeoZRhZca5f2hbrnKoz6hzD6NJGGfdus+mNHM8=;
 b=WAJeQmnjc7TbtZIzdPmh8yV2mYOe30xI0pWNblUv45USrEhUHzlFWgvaKhN9AfeLk6
 XZ2DShNmnviDKIeRFKHR/Jx5gjV4xzsI4/PmqceIiqgmtJ+auqDkAFx1vf/zhccvqgnK
 KTsLe+jENP+tbYs7keCnApRkG2v7A4NXVr0lE4QLjLVZrvU8swR/9y3b6F0gphc5C/z0
 3NBgG65xdFDQjFeiv41iQHh++bhBTk0UdYz1ljzUkIbynXymPSKHC0MRnFUhLHzm4T4T
 XVqCs1RHHnEsWwHi1CKZZvVM/cRctV/TMRWcbroHeqQeDpXrTtfWqwom1TahCMlCwJb8
 SS4g==
X-Gm-Message-State: AOJu0YxmfprujPoIzCE840Y7LFhkcHtxhB+j7d6IVasjzTjQtLMAuYoW
 G4xTHdQH4kDs5QglF1CYOeFmN/qQwVOSY+LJbc0vN6iEn5fkqQ==
X-Google-Smtp-Source: AGHT+IFr7GKDvAxUU7jlx6y4HhMK5detRBLYx/k69ChACIRHTpM4o2GNpj+DyWaMhq9KPmb7+uktuQnnh8j3qFbtY6w=
X-Received: by 2002:a19:8c1d:0:b0:50e:d378:2fd5 with SMTP id
 o29-20020a198c1d000000b0050ed3782fd5mr466859lfd.79.1705054402065; Fri, 12 Jan
 2024 02:13:22 -0800 (PST)
MIME-Version: 1.0
References: <20240112-maintainers-ab-v1-0-f2a538eab18a@baylibre.com>
 <20240112-maintainers-ab-v1-2-f2a538eab18a@baylibre.com>
 <CAL6CDME2sQohvKDcUR+6Y8jR8NMELZ6wNVmg7Xj69-5z1iL+qQ@mail.gmail.com>
In-Reply-To: <CAL6CDME2sQohvKDcUR+6Y8jR8NMELZ6wNVmg7Xj69-5z1iL+qQ@mail.gmail.com>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Fri, 12 Jan 2024 11:13:10 +0100
Message-ID: <CAL6CDMH500V75XX5sMYRMfbBO6DT+uVdVW_-d-r-g2qq9Ua5Hw@mail.gmail.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: add Mattijs for Android AVB
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, u-boot@lists.denx.de
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

On Fri, Jan 12, 2024 at 11:08=E2=80=AFAM Igor Opaniuk <igor.opaniuk@foundri=
es.io> wrote:
>
> Hello Mattijs,
>
> On Fri, Jan 12, 2024 at 9:41=E2=80=AFAM Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
> >
> > Igor has not been active for quite some time on lore:
> > https://lore.kernel.org/all/?q=3Digor.opaniuk@gmail.com
> >
> > I'm interested in helping with maintaining the android_avb
> > command. I'm a long time android/aosp developer and my daily job is
> > still doing android work.
> >
> > Add myself as maintainer for Android AVB.
> >
> > Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3c73d8c35c4a..4978470c1664 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -70,6 +70,7 @@ F:    test/py/tests/test_android/test_ab.py
> >
> >  ANDROID AVB
> >  M:     Igor Opaniuk <igor.opaniuk@gmail.com>
> > +M:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
> >  S:     Maintained
> >  F:     cmd/avb.c
> >  F:     common/avb_verify.c
> >
> > --
> > 2.43.0
> >
>
> Thanks for volunteering your time to review/maintain AVB and A/B
> related changes. Unfortunately I'm not involved in any AOSP-related
> work at the moment nor even have a board at hand with up-to-date AOSP set=
up.
> If the situation changes in the future, I'll be happy to assist.
>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>
> --
> Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations
>
> Igor Opaniuk
> Senior Software Engineer, Embedded & Security
> E: igor.opaniuk@foundries.io
> W: www.foundries.io

Acked-by: Igor Opaniuk <igor.opaniuk@foundries.io>

--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Senior Software Engineer, Embedded & Security
E: igor.opaniuk@foundries.io
W: www.foundries.io

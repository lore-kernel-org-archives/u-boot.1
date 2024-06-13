Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78538C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 05:05:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11C698855F;
	Thu, 13 Jun 2024 07:05:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Izu8lrPQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB8AC885D0; Thu, 13 Jun 2024 07:05:03 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 992918839D
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 07:05:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a6265d48ec3so77243066b.0
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 22:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718255101; x=1718859901; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UXXg8FZ/MRY/fRoNXCmYVOzA0UCmUG5CSTt1cokzIhs=;
 b=Izu8lrPQqqCYF/Qxxc0tm7eVnCEIAvQ05iRrBfXFRoJ0oNm6T0yZDVAMP3s9R/q/AI
 845O/Yz2XYbXr6IJtxcGNzqmna5f+XVKpImCySbXByRxysdW6TMzGN7hJ9fOdm+pzVgX
 Mmt0WQneq1fcBkbLJsHBGiXg0Mv+k31ui/yH6/HWD4h1mQPOVzcKuYaN0fPXdmFX/7fr
 hrXKgeWLSq8G8ZS2+92ScDet4nUFJfwIcXSITEoOAJcSRXgbMU5FtR5rlMZ/AaPrlqA4
 wOlkzF3VtQIoRqghAIONwjHBnECybXIvvGnT1kYb5hTeMLOFyr5S6sEagMHaPsHU3Nf+
 HBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718255101; x=1718859901;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UXXg8FZ/MRY/fRoNXCmYVOzA0UCmUG5CSTt1cokzIhs=;
 b=MK7fWzizv9Bz2yid0zGQKjtXetJKdLNngUf4igazYPf9dhxEhAp7tjRGUFK82kgyJX
 fGzBMMPgxdAJIzcmn7+vQ6V40R35xlswu4sdhtoslSPfkgSk09209uWgQPIh0gHQMFbi
 aVtyjHSypo4e1OaPCgva9CqEpSRvbGrTeVQXY+xznNtcgkEVupFgbZ5tPY85GCDZr/v6
 NWFam5YWZR7EUBsklnK0nBx0NG0DTSfpcWei7S0f3uV3u4aRtO0+Yj2/xzgBqz0jY/R9
 vLRrrPYUEGKECoA63ibHQjdg+Q3hN5a+8OPSTzDaLNJXy7QCqb8wBfiU3vPJwP9TiDsW
 xu2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJlyTbnXVk1qWO6rsNc5ofF2qUlkznJyDLb7olaPQmUTM4PHvVRvL29iU8kRBJJMRKEn6hzVu46TTL50y4SkBEY5ibaA==
X-Gm-Message-State: AOJu0YxUigohpngJnKPzW2v147qmx9adnBOwF+F6COlq6+RGDf2L9ksD
 6mrReddoMuXpP3eFRLExfN8ZvSuyr5yeaRmZDtFwVG5eW3VH5wpYfbEdbc6JrhCnPEoksn8bvHw
 UuhS3wOtTWlt6E3ek71C+Hmi4P0o=
X-Google-Smtp-Source: AGHT+IHKRvDeR972z4g21oK/ECjZqmW9i6/XOdHapmkkjRTaMhfqMnAVh5BGrFcBzuHLzpJNjCQ2rKNpcPavaLYmKpQ=
X-Received: by 2002:a17:907:86a9:b0:a6f:256c:8163 with SMTP id
 a640c23a62f3a-a6f47b4eefdmr244549066b.0.1718255100799; Wed, 12 Jun 2024
 22:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240603150749.507797-1-patrick.barsanti@amarulasolutions.com>
 <CAOf5uwkjz0qNkvsWzEQ+kPy66X9Eassq0b1PMDG2r7fYv94_OQ@mail.gmail.com>
 <20240612172527.GH68077@bill-the-cat>
 <CAOf5uw=quLMOhD5c2_ZbEkmV9KtHsfNW=HFfuJOLiwCfLtcS+A@mail.gmail.com>
In-Reply-To: <CAOf5uw=quLMOhD5c2_ZbEkmV9KtHsfNW=HFfuJOLiwCfLtcS+A@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Wed, 12 Jun 2024 22:04:49 -0700
Message-ID: <CAJaLiFyXXTfQMQX3fh_5kucLthTuZhjqHyC6huZCroXFugu01w@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: Fix include directory for OF_UPSTREAM
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>, u-boot@lists.denx.de,
 sjg@chromium.org, xypron.glpk@gmx.de, marek.vasut+renesas@mailbox.org, 
 sumit.garg@linaro.org, afd@ti.com, bb@ti.com, mr.bossman075@gmail.com, 
 leon@georgemail.eu
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

Hi Michael,

On Wed, Jun 12, 2024 at 12:46=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> HI
>
> On Wed, Jun 12, 2024 at 7:25=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Wed, Jun 12, 2024 at 10:17:12AM +0200, Michael Nazzareno Trimarchi w=
rote:
> > > Hi Tom
> > >
> > > On Mon, Jun 3, 2024 at 5:08=E2=80=AFPM Patrick Barsanti
> > > <patrick.barsanti@amarulasolutions.com> wrote:
> > > >
> > > > Always prioritizing u-boot includes causes problems when trying to =
migrate
> > > > boards to OF_UPSTREAM that have different local devicetree files wi=
th
> > > > respect to the upstream ones, if local DT headers are not dropped.
> > > > At the same time if local and upstream files are the same, migratio=
ns
> > > > can be, and have been, introduced without dropping local DT headers=
.
> > > > This also causes problems whenever upstream DTS and DT headers are =
patched.
> > > >
> > > > For example, now migrating a board based on `imx6ul.dtsi` to OF_UPS=
TREAM
> > > > breaks it, as there are some missing defines in a local DT header f=
ile
> > > > (`imx6ul-clock.h`); the solution would be to drop it, which has not=
 always
> > > > been done in previous OF_UPSTREAM migration patches for other board=
s
> > > > because most of the time the two are the same. This solution is als=
o
> > > > vulnerable to ABI breakage, although this has not yet happened sinc=
e the
> > > > introduction of OF_UPSTREAM support and is unlikely.
> > > >
> > > > Maintainers assure backwards compatibility for DT headers when sync=
ing the
> > > > upstream folder with the kernel.
> > > > The problem is that, at the current state, all boards that have not=
 dropped
> > > > their local headers when migrating to OF_UPSTREAM will break once t=
he
> > > > upstream devicetrees are patched, for example, to use any newly add=
ed
> > > > define which is not present in the local DT header file, even if th=
ose
> > > > changes are backwards compatible.
> > > >
> > > > This patch fixes these problems by prioritizing upstream includes w=
hen
> > > > `CONFIG_OF_UPSTREAM=3Dy`, while keeping current prioritization when=
 it is
> > > > not.
> > >
> > > Do you have some comments here? We would like to move upstream dts fo=
r
> > > imx6 boards
> > > too
> >
> > I've been waiting for the people that wanted the commit message
> > clarified to Ack/Review the patch. Did I just miss that? Sorry.
> >
>
> Agreed, let's wait for more feedback

I have migrated to OF_UPSTREAM for ARCH_KIRWOOD boards, and also for a
single board (DS116, Armada 385), and have given a lot of thoughts
about this problem. I agreed with Michael. Either the whole Arch is
migrated at the same time, or we need to prioritize upstream includes
to avoid breakage for boards that have been migrated and also boards
that have not been.

Reviewed-by: Tony Dinh <mibodhi@gmail.com>

All the best,
Tony

>
> Michael
>
> > --
> > Tom

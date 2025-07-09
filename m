Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BAAC83F0A
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 18:39:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CBE883599;
	Wed,  9 Jul 2025 20:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="mhy7E0e5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09A37835A5; Wed,  9 Jul 2025 20:39:51 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D11B283564
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 20:39:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2efdd5c22dfso108826fac.3
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 11:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1752086387; x=1752691187; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pz7IZwRswvEJ87NAgOLnQdXFO/jlkYhJ/c3IFL7BqdE=;
 b=mhy7E0e5WNYy618hc+YQctlQaRm8DQEZj0B8rRcziH+0kzN30+csPW4vf8FiZdqudV
 5BcpUpy7hiQYTlh1Qgxee6nvtS59RFJ6JIvh4lgOuRw6hB/w2pArp70Zlw2HCMH1tF6p
 BY2HUQ53yTtjsim7W3zS3ysTUoDKUR1j8Dvp86E5wq6zleTNFHj/uYbnC/7KbdrqBytd
 qVm0NWjCN9vvLt61PjcwAIaXxJCkTgEEKqHf/TU7QvzLEKg1hFBPowX/k8l4DFhSWu4v
 ccPvOp6/MgPYmPYLBVhnD8+wEyJtIygw6e/Yw0zh2CpKjpJeGQAMaxH4FW++H/rFVPD7
 ybVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752086387; x=1752691187;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pz7IZwRswvEJ87NAgOLnQdXFO/jlkYhJ/c3IFL7BqdE=;
 b=NyBhN6SmSUkXsoRX81Cge6jQBRr+dFCv+07J0rU+AledyMmHws3vSqwW7Cw4XBxfR1
 iDK4cT16fKiUAZTj4MFwEK3QDoESxRHTobLCgBX59hfzVmi9Z41QkzJvyDbI5Zav31B1
 EgyWicU0IxOfSN95BGKAJ9lHUT4EQNjvvHyC8ZmyRajtjVEep5DlzFyS6EMyFy9F2hcs
 HfghKU/7Mf/OQJgc5Ehaq12P7op+KMEu3lpgOq6utAnTkzVyePskyEKh5mhcfCQmJvV3
 MLFJ9oZl7iR3lY6xBgbb7ZXDutf8C0O4VzkV+S1wR94ol3rxGkGEgG/QaWTGRt5/a0fN
 v6nw==
X-Gm-Message-State: AOJu0YxcG9IHmCz+I187XLucD/4zjePQxMTiy8Xat+hwirCC8f9JiLh4
 2/Y7TifHAjeo286n+21kLHxWIFKQbgprBiWXorl62Qjbc7qcT0/Jb5Vxg5Jz588MiRkrHzBr+O9
 JrkuhwwHNuK4uFqrmJGffSnKlxlrEc683FM3LWoYksw==
X-Gm-Gg: ASbGnctHgbpbRIATDFPUC5SucEXochONYcSWzS8gofpfl04r5E1tt0mIa8PxguMGJgB
 kzGXbVc/OGZrC3GS10+qWWt3DkO0EXfCa5X0yLCZAtlEaxKEDpLRf2a3Pyp4xMqPRKVrPbwo251
 G50ZmExPojU82vSvnORMVktwS+tAARNd1GqfJft8pTI+g=
X-Google-Smtp-Source: AGHT+IG/1tqt2/NpeH22JWz+raBut14vvAHG/4YqcIeCWTEIbfA+nrs8Rs4salObwiyusRptOIF3htl8N3BCocXykFY=
X-Received: by 2002:a05:6870:c85:b0:2c8:5db8:f23a with SMTP id
 586e51a60fabf-2fef860ca7fmr2446747fac.20.1752086387340; Wed, 09 Jul 2025
 11:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250709183217.3392140-1-tharvey@gateworks.com>
 <20250709183217.3392140-4-tharvey@gateworks.com>
 <CAOMZO5DsDXkEziirU_BPBVg0Z9Ky08Ucdc+pWZH1hzj1u2OBJQ@mail.gmail.com>
In-Reply-To: <CAOMZO5DsDXkEziirU_BPBVg0Z9Ky08Ucdc+pWZH1hzj1u2OBJQ@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 9 Jul 2025 11:39:36 -0700
X-Gm-Features: Ac12FXyjJd-8CtwrEOrfZuXJAIBhaR-CEf4YZYfKhS6jC_OMQd6YLkOub9OVQJg
Message-ID: <CAJ+vNU1rpp8962sk5Vc=8KRXCHVgtpAff76BiKHEuzwPy_yuHA@mail.gmail.com>
Subject: Re: [PATCH 4/4] venice: display DRAM MR registers and decoding if
 debug enabled
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
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

On Wed, Jul 9, 2025 at 11:35=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Tim,
>
> On Wed, Jul 9, 2025 at 3:32=E2=80=AFPM Tim Harvey <tharvey@gateworks.com>=
 wrote:
> >
> > While this is interesting and useful for debugging there isn't extremel=
y
> > useful information so we will only show it if debug is enabled.
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  board/gateworks/venice/spl.c | 61 +++++++++++++++++++++++++++++++++++-
> >  1 file changed, 60 insertions(+), 1 deletion(-)
> >
> > diff --git a/board/gateworks/venice/spl.c b/board/gateworks/venice/spl.=
c
> > index d9bc593fa0d5..5f621ade9287 100644
> > --- a/board/gateworks/venice/spl.c
> > +++ b/board/gateworks/venice/spl.c
> > @@ -2,6 +2,7 @@
> >  /*
> >   * Copyright 2021 Gateworks Corporation
> >   */
> > +#define DEBUG
>
> I believe this DEBUG definition was left by mistake?

Sure was! Thanks for catching that.

I'll submit a v2 in a few days if there are no other comments.

Best Regards,

Tim

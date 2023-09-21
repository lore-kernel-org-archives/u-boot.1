Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AD3CD4938
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBD0A86D3A;
	Thu, 21 Sep 2023 03:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kaIqEV7Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B11386D22; Thu, 21 Sep 2023 03:06:04 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E622986D23
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-59be8a2099bso5732907b3.0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695258357; x=1695863157; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AwT8s7T33SnIDtx5FzPjq+0enwuIAPVo2HGxxB+95yg=;
 b=kaIqEV7YoRarOmT2ha740TnAt9S9WnVOMidnQQC7nJH00P5/l2RkN+8TgngrT10VgD
 Oh8zm9VbUEwhufh29BfFyCijwQzi5s2ST036zkVgiswGsCla4f91SfmjhPKReX/ReUxk
 FqbMNT0OH7fWqkCO9mI39xJwOnOxZT8U9q2Cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258357; x=1695863157;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AwT8s7T33SnIDtx5FzPjq+0enwuIAPVo2HGxxB+95yg=;
 b=xIQlCJxmYCa2fn+fqr6Nhiw9/sGOnFZbR3eA9kKL75Z39CPUcw3DgIXG1bkNoCoZ5J
 LkxhLsL/P3EN3Oj6GfY+wEnMdaNpO1RB98wG6b/PhxyI8HfPQEPG0Yn17TZAZEyQvcS1
 k3RaPUENdyK2LdWlnAPSMPqIQiuOYMTpjRWUh9AIv04s47qd0dIUty795VX1gLWg9bF+
 MCNtfyznSOdJHPFaoQqqCRivCp8X2DfP2+Xunrf4bMTYupl+AfekDlLPdK5AbMiSMusv
 Jm/71vbG7BxjsYs6L+gNylb2KIWCDBpQxFQGZSgz9TBQuvPaUWglquTkC02JV8bMLYQW
 e9QQ==
X-Gm-Message-State: AOJu0YwzYhYGS4cDHpi/nyE8iY5J2/cpbc8coZ4R4of/C+y3CokvmO1X
 Oum1kMwS4/KzvAW8IJ5j6APnCCQK0FR1VI59Z/fz8g==
X-Google-Smtp-Source: AGHT+IEG7EUt0Igc7WpFPM6oC3cxBhN9Pp8KTfxOgnbRhplF/xynBCT4i5jTR/vcUsgG5GrpHmuHef0isre3PTZt26s=
X-Received: by 2002:a81:4e02:0:b0:59b:1b87:a95b with SMTP id
 c2-20020a814e02000000b0059b1b87a95bmr3616499ywb.20.1695258357439; Wed, 20 Sep
 2023 18:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-6-sjg@chromium.org>
 <20230831175055.GN3101304@bill-the-cat>
In-Reply-To: <20230831175055.GN3101304@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Sep 2023 19:03:31 -0600
Message-ID: <CAPnjgZ3FNvR3JGrSFHwMGqny5JHtA7qoX5g13ZBO8Rib67EUmg@mail.gmail.com>
Subject: Re: [PATCH 05/32] spl: mx6: powerpc: Drop the condition on
 timer_init()
To: Tom Rini <trini@konsulko.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>, 
 Andy Fleming <afleming@gmail.com>, Mario Six <mario.six@gdsys.cc>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nikhil M Jain <n-jain1@ti.com>, 
 Priyanka Jain <priyanka.jain@nxp.com>, Stefan Roese <sr@denx.de>
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

Hi Tom,

On Thu, 31 Aug 2023 at 11:51, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Aug 30, 2023 at 12:04:36PM -0600, Simon Glass wrote:
>
> > It doesn't make sense to have some boards do this differently. Drop the
> > condition in the hope that the maintainers can figure out any run-time
> > problems.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  common/spl/spl.c | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > index 78db9ef5318..3f513b0563a 100644
> > --- a/common/spl/spl.c
> > +++ b/common/spl/spl.c
> > @@ -766,13 +766,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
> >               if (spl_init())
> >                       hang();
> >       }
> > -#if !defined(CONFIG_PPC) && !defined(CONFIG_ARCH_MX6)
> > -     /*
> > -      * timer_init() does not exist on PPC systems. The timer is initi=
alized
> > -      * and enabled (decrementer) in interrupt_init() here.
> > -      */
> >       timer_init();
> > -#endif
>
> PowerPC might be a little tricky, did qemu-ppce500 run?  And please
> reach out to some of the iMX folks instead of just dropping this and
> hoping it works.

Yes, CI passes.

+Christophe Leroy
+Marek Beh=C3=BAn

PowerPC people, does this look OK?

Regards,
Simon

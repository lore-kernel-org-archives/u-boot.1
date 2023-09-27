Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44227E80AAF
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 14:20:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B139C86E02;
	Wed, 27 Sep 2023 16:19:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bh0rhfLc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29A1E86B95; Wed, 27 Sep 2023 16:19:58 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A66986E16
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 16:19:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-503056c8195so18657465e87.1
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 07:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695824395; x=1696429195; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q+ow6kwoI09ftEx1dC2A/iDV4qYubW8Ho6D2RmU746o=;
 b=Bh0rhfLcs1fHrZuYyttODpsK4mWJYYPgucxFw3s2gau1aSonGQ5XOwN5Pxeg+Ie2Kz
 1E6F/IT8WAMleCgj8UlzC3uKhx4EW4v63kK62XqVkC5gHXnXfGWk6vM8j3s/eCyIxuOm
 EZiGsIA4wrb5vSy14zT93LogJOTk87MnntPCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695824395; x=1696429195;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q+ow6kwoI09ftEx1dC2A/iDV4qYubW8Ho6D2RmU746o=;
 b=Y9TRjK87FAcqVNAJOldyqC6eL1ChBKpa2+v9QmAVndDTZD246RE5jg3tkQIMe4V8KG
 AB0+GDLJokT/d8p5Se0x55SNQjsvF4fnN79SH6WvWbvK2g1y0LiuKwJIu8ya+RMXo8s3
 aCkpvzU3r5t1SVMSZiozpgsLi7VPZQNjrkVXxmxNYOV0RZppmB8qfYEu+odRVX+cO8o3
 Sf3JXgeIVQlxdyqX2IK/SIQbHFpjtf2oauZwGtYGMfY14ld3/YBXI04WPO7tJH2oMrMv
 mcc+H4p793Hi9TBvGY3Z8k7UgDnTN5DPDVbI2bz1KFgh0AuztPpZSE+e7BMhFrX2YvmC
 y2qQ==
X-Gm-Message-State: AOJu0Ywl7OXEYO15EkjJzMaQHFoNSgGX6iuw0RzRPdT1SaVNw4eG3ozt
 W7gbDWP588PJjOItIf+f6YBIgTcGDUalcR7ufryS6Q==
X-Google-Smtp-Source: AGHT+IH9uIKNdRG4O18/sbGysB5zbTVPtGTvdMESVTvCbJLlcN2nudDeBBtEAd5+GsCDv1v8RTu2xqWyp7UIMO5GIh0=
X-Received: by 2002:ac2:455a:0:b0:500:7f71:e46b with SMTP id
 j26-20020ac2455a000000b005007f71e46bmr1755472lfm.1.1695824395128; Wed, 27 Sep
 2023 07:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230924192536.1812799-1-sjg@chromium.org>
 <20230924192536.1812799-5-sjg@chromium.org>
 <19d0cda7-1943-74f2-03aa-f5be970fff26@csgroup.eu>
In-Reply-To: <19d0cda7-1943-74f2-03aa-f5be970fff26@csgroup.eu>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Sep 2023 08:19:43 -0600
Message-ID: <CAPnjgZ3-uHC-cJxDyUgAsrLdZLUzcobJkr6bPjzko+7+GRWGMA@mail.gmail.com>
Subject: Re: [PATCH v3 04/38] spl: mx6: powerpc: Drop the condition on
 timer_init()
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Andy Fleming <afleming@gmail.com>,
 Bin Meng <bmeng@tinylab.org>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Mario Six <mario.six@gdsys.cc>, Nikhil M Jain <n-jain1@ti.com>, 
 Priyanka Jain <priyanka.jain@nxp.com>, Stefan Roese <sr@denx.de>,
 Wolfgang Denk <wd@denx.de>
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

Hi Christophe,

On Tue, 26 Sept 2023 at 00:46, Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 24/09/2023 =C3=A0 21:24, Simon Glass a =C3=A9crit :
> > It doesn't make sense to have some boards do this differently. Drop the
> > condition in the hope that the maintainers can figure out any run-time
> > problems.
>
> This was added by commit ea8256f072 ("SPL: Port SPL framework to
> powerpc"), and the commit log explains why.
>
> Then commit 70e2aaf380 ("board_f: powerpc: Use timer_init() instead of
> init_timebase()") brought timer_init() to powerpc.
>
> All timer_init() does it reset the timebase register to 0 instead of
> leaving a potentially random value. That should just be fine.
>
> Therefore this change should be ok for powerpc.
>
> Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>

OK thank you.

>
> >
> > This has been tested on qemu-ppce500
> >
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Mention testing on qemu-ppce500
> >
> > Changes in v2:
> > - Explicitly copy two maintainers as it seems only Mario was auto-cc'd
> >
> >   common/spl/spl.c | 6 ------
> >   1 file changed, 6 deletions(-)
> >
> > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > index 5cc86288145b..4233390d7de2 100644
> > --- a/common/spl/spl.c
> > +++ b/common/spl/spl.c
> > @@ -762,13 +762,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
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
> >       if (CONFIG_IS_ENABLED(BLOBLIST)) {
> >               ret =3D bloblist_init();
> >               if (ret) {

Regards,
Simon

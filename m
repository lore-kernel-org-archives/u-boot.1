Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1311E7E628
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 11:37:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0390886C1D;
	Tue, 26 Sep 2023 13:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DM554Lv8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D92D86D58; Tue, 26 Sep 2023 13:37:47 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9184F86BEB
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 13:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-533c5d10dc7so6583570a12.3
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 04:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695728263; x=1696333063; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=devcw+zP6YA5NMnclH4tyMKdsPJY3yekMwXp5me0cgs=;
 b=DM554Lv83XT1qjB5YTQ1w6Z5KcmgJ0A5/3g4ijiSvS57eqTwFsi6YgaW/1+aJ8rwwW
 f/Wt+aUhgL1KlRx/NBzKfLdQ+8aEAzDwe1ZcB8+pk6caAr8/Ywc2qvj2eBfyBEkitxVS
 2d6WWVfdPeYfx+thA+uG4mUkUUkDgenlmO3PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695728263; x=1696333063;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=devcw+zP6YA5NMnclH4tyMKdsPJY3yekMwXp5me0cgs=;
 b=IZ6QMW3JrCtYRhuhSwNGTmFF9OioHV6Wf5a6LIfY7zh/uzQ7ClznzsOslkdo2RzDPh
 UMV5nNHAczneeZh2vHALcjY8vhILIosKT4RLwCecYmDEHQTkEst9kK5IPdaQU7ffL4Om
 foJEzB71lGatxxH6enzRwkm22PJRxgvm3huX8XsD+uKFWgZPQund2VdJd+PKAc2zk/n2
 MxMHZ1XnNMRc8ZkfyJ6996ZPyVMLool+TaIMD07pNCKouV/1QPqdGjMyrsie00ky5x6u
 KQ2zDpp8VFdAFK18iAmDyx3eEEktXt4+Us4UXeNbUotFP5+qPNMYhUZbKSnF/lGDMj4Y
 2XHQ==
X-Gm-Message-State: AOJu0Yz4oN20RqfN2a0fpB2cRcAMsr4UbndklCVlPcdjY8oRbrTJhy/n
 DnOvhKy5tZH+DgZII3DGdLqDNfg723yS4p+0MwfDsp15H7AuQ9MGFeI=
X-Google-Smtp-Source: AGHT+IGP0eAxMW8ZaGPDlgR+RObvrGKJyBeUkMzgzU4h1pxltdDIvx0rXHAhgdwdOnkaVDm0puIg42bZuk4Gpgp2OoE=
X-Received: by 2002:aa7:d3d5:0:b0:532:e4b0:557e with SMTP id
 o21-20020aa7d3d5000000b00532e4b0557emr8453609edr.36.1695728262878; Tue, 26
 Sep 2023 04:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-6-sjg@chromium.org>
 <20230831175055.GN3101304@bill-the-cat>
 <CAPnjgZ3FNvR3JGrSFHwMGqny5JHtA7qoX5g13ZBO8Rib67EUmg@mail.gmail.com>
In-Reply-To: <CAPnjgZ3FNvR3JGrSFHwMGqny5JHtA7qoX5g13ZBO8Rib67EUmg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Sep 2023 05:37:29 -0600
Message-ID: <CAPnjgZ0vw2ROHAGeat3Pvzn0LGqh6Y-8TFuQ0xzVgM8atUVDpQ@mail.gmail.com>
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

Hi,

On Wed, 20 Sept 2023 at 19:03, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
> On Thu, 31 Aug 2023 at 11:51, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Aug 30, 2023 at 12:04:36PM -0600, Simon Glass wrote:
> >
> > > It doesn't make sense to have some boards do this differently. Drop t=
he
> > > condition in the hope that the maintainers can figure out any run-tim=
e
> > > problems.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  common/spl/spl.c | 6 ------
> > >  1 file changed, 6 deletions(-)
> > >
> > > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > > index 78db9ef5318..3f513b0563a 100644
> > > --- a/common/spl/spl.c
> > > +++ b/common/spl/spl.c
> > > @@ -766,13 +766,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
> > >               if (spl_init())
> > >                       hang();
> > >       }
> > > -#if !defined(CONFIG_PPC) && !defined(CONFIG_ARCH_MX6)
> > > -     /*
> > > -      * timer_init() does not exist on PPC systems. The timer is ini=
tialized
> > > -      * and enabled (decrementer) in interrupt_init() here.
> > > -      */
> > >       timer_init();
> > > -#endif
> >
> > PowerPC might be a little tricky, did qemu-ppce500 run?  And please
> > reach out to some of the iMX folks instead of just dropping this and
> > hoping it works.
>
> Yes, CI passes.
>
> +Christophe Leroy
> +Marek Beh=C3=BAn
>
> PowerPC people, does this look OK?

Are there any active maintainers for PowerPC?

Apart from this patch, is there any word on the DM_SERIAL migration?

Regards,
Simon

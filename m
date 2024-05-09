Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04001C10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 15:23:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D956880D5;
	Thu,  9 May 2024 17:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ggl1YLiH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21B148810E; Thu,  9 May 2024 17:23:29 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D44D186E40
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 17:23:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5ce6b5e3c4eso680203a12.2
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 08:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715268205; x=1715873005; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qqlib1C0r389cwt8BmFcs9yvEOKQvF3LKjn3rb5t9KM=;
 b=ggl1YLiHzykPTVzXz1fKbYUfFT+QvC09ICkhh3NOHuCKmo+6aJb3lxEgY4N6+FVmdE
 SLq0Q68gHj78ojkgPyGI6RnVD97ocLtps+lRJ3+Ka7SU+VRXWxEoL2cXLNij/ZPz86+k
 GU6q4AJ+/T3WtyXCRc8uD0PNFmeyxKm1zJloIvAibAIG551+B7X2mZijKrvMW+adSnTB
 0U2E9fqKzR8ET21LSaD2LoET9FAGO2BCCHYpUkz43PyIOMhpg5x/aaKq5nEddZjDH3Bf
 coeCnWuWz2+vAzuLpgPOaHNpJ3V/Hax+vGxfdTPboHBjdUsnCmBvJr+FQx1fURlYtLDr
 eqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715268205; x=1715873005;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qqlib1C0r389cwt8BmFcs9yvEOKQvF3LKjn3rb5t9KM=;
 b=Eh6fhlH3aU2TyGYP00lLcI+FLuEcpuvVieUtf7eoDyFb1x31jzypH3CQldqI3z3qHF
 LVMDpjtcSDDU2UL4RFEIkTfApcUVERJTsUWpWQnsQoULGt2ud6rq9kgCCRqfnGrpy9h5
 tW7VISzyMyoF+Joqm5fStSJnT20k3eQWWtV/QIrQwogf0l9KpCKw8kVK0JzXRw4Bvip8
 42IvU6IFkAzs2fiabMnYtS36Jo+m+AuMXYsyoA1/TJjHWJhHGeUPk/u+PDsMmmDjcnJL
 8LHLNSLw11X4L+RiEEWBXMFcEJWMqDRdhoPONMo2tbnbcttlH5UxQYQUGBx9AQ06G6Kh
 0KbA==
X-Gm-Message-State: AOJu0Yxz2Eldc1+ZfOAa1rDHYHU0up92lM//5BU7tiTCaIIRxwFg5bsy
 vCKQjevOIJYgrMZRn703QKf8guSqXWAXegBF78LmqEf+ipbigKbTHZgmiOy89YoPDJYgFaVijVG
 Yp/RMG/t3YAB45y7S/LgCKSw01wDBbiF8J1ge1g==
X-Google-Smtp-Source: AGHT+IGMKu8Rl5MrpUbUYq64vU3g2yb9J8osGJwtT6NrIEm8EI5NKg6ahFIyOl2/qdMOo46TAeyTyCFM8MuvKCsaXc0=
X-Received: by 2002:a17:90a:9603:b0:2b5:4ee8:e5e8 with SMTP id
 98e67ed59e1d1-2b6165a6906mr5575886a91.16.1715268205259; Thu, 09 May 2024
 08:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-4-raymond.mao@linaro.org>
 <20240507211643.GY2568172@bill-the-cat>
 <CAEfUkULdF1R2c=QEOQHQH+8go7VnXnSBKXh2AVYXQt5LkMXy_w@mail.gmail.com>
 <20240509151133.GJ2568172@bill-the-cat>
In-Reply-To: <20240509151133.GJ2568172@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 9 May 2024 11:23:11 -0400
Message-ID: <CAEfUkU+Ax6o8NnL=e3Tm+-75HMbXpa5zqMm5TS3EpqY79GAEXw@mail.gmail.com>
Subject: Re: [PATCH v2 03/28] mbedtls: add mbedtls into the build system
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, Andrew Davis <afd@ti.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Sergei Antonov <saproj@gmail.com>, Ilya Lukin <4.shket@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Thu, 9 May 2024 at 11:11, Tom Rini <trini@konsulko.com> wrote:

> On Thu, May 09, 2024 at 11:04:07AM -0400, Raymond Mao wrote:
> > Hi Tom,
> >
> > On Tue, 7 May 2024 at 17:16, Tom Rini <trini@konsulko.com> wrote:
> >
> > > On Tue, May 07, 2024 at 10:50:45AM -0700, Raymond Mao wrote:
> > >
> > > > Port mbedtls with dummy libc header files.
> > > > Add mbedtls default config header file.
> > > > Optimize mbedtls default config by disabling unused features to
> > > > reduce the target size.
> > > > Add mbedtls kbuild makefile.
> > > > Add Kconfig and mbedtls config submenu.
> > > [snip]
> > > > diff --git a/include/stdio.h b/include/stdio.h
> > > > index 3241e2d493f..874279c60dd 100644
> > > > --- a/include/stdio.h
> > > > +++ b/include/stdio.h
> > > > @@ -3,6 +3,7 @@
> > > >
> > > >  #include <stdarg.h>
> > > >  #include <linux/compiler.h>
> > > > +#include <vsprintf.h>
> > > >
> > > >  /* stdin */
> > > >  int getchar(void);
> > >
> > > Is this really needed? I know our include structure is a bit odd.
> Should
> > > we perhaps look at moving a prototype or two around to be more broadly
> > > compatible?
> > >
> > Then we need to move  prototypes of snprintf, _vprintf, putc_outstr and
> > printf_info from tiny-printf to stdio.h. Is this good for you?
>
> I don't quite follow you but yes, please work it up for review at least
> as I'm not too thrilled with adding <vsprintf.h> to <stdio.h> after the
> work I did removing <common.h> showed some fun around those headers as
> well, and I'd like to sort it out correctly.  Thanks.
>
> When MbedTLS native codes include <stdio.h>, they expect to have a
prototype
'snprintf', that is the reason why I hijacked <stdio.h> as we are not going
to
change MbedTLS native codes.
I mean in v3, I can move 'snprintf' related stuff to <stdio.h> so that we
don't
need to include <vsprintf.h>.

Regards,
Raymond

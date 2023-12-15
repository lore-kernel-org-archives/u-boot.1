Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0FCC4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 17:53:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AFDF87C30;
	Fri, 15 Dec 2023 18:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m08apf44";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5168487C36; Fri, 15 Dec 2023 18:53:43 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E62C87BFC
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 18:53:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a1e2f34467aso78310166b.2
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 09:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702662820; x=1703267620; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QLkqVT8m2OC4MJ2UCuHuoY/ltwY+JoMYufFC+/4ANBg=;
 b=m08apf44B4GEazAcLCkb2rwjk0xkAhEpWF5cu8BHKsS1iLcxEgZYBaga+/HxP39oNw
 MN8uPsJzjUKERn0NucmnZpCEO8eQjs+SkwisvfmcfMqYi7ae2uvQGf4mm2osv1k+WJh5
 kWRWsiQQTP5Yu1l0aGaQjU9lD5rePM+kzhW34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702662820; x=1703267620;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QLkqVT8m2OC4MJ2UCuHuoY/ltwY+JoMYufFC+/4ANBg=;
 b=d7SHsdI8OOEdzMeFq2d/7/gsBsxQcopERfQE6Knpx+ZxbySnniivNkxPKrflvnrkk6
 7RM+K2FUYorhLSK/ojROprwETvye/+HQ62uZ5Z2pQ405bcB9Wqh2mTvaMoSsVoK/QP9l
 Mb6uw+HaZCSFQ1Vhxket/IWJHK+t1y68Jk2tltZOtFmf+yyEr3yaiqAfXpHum9JyKKoQ
 R7cMwH9NmSX4eTPvoMMKMmyPvMEJ9xaKE/8XPSdTINmjrMq9VVoOvgdM7hspOG5yxDXj
 f0jpVjzWi0R6AlSQ49WIUgFDM5m9hFNeTxx8E3TieOcMHW0ZSXI4RlDDktJ+/ThkQm3F
 mTfA==
X-Gm-Message-State: AOJu0YzYIbkBb+rHiOKHHSad/XhB4TYUnLDc4aqyRzZK4JiIHpfI4uFB
 4jCanzIRygMko+neB7HldYVj1iv2XdV3oMvwrhk1Cg==
X-Google-Smtp-Source: AGHT+IFUdP20LOGwKWwhXZRGbNgoDoISYRivZpBtKB7eeTZ9vRzuw+ry9bkbyJQ0a667v/E4WUI3aO9gHfa7mbcyyyk=
X-Received: by 2002:a17:906:d970:b0:a09:7c04:461f with SMTP id
 rp16-20020a170906d97000b00a097c04461fmr7289873ejb.65.1702662819981; Fri, 15
 Dec 2023 09:53:39 -0800 (PST)
MIME-Version: 1.0
References: <LO2P265MB2605C61E483A315CC62D1DCFDB8DA@LO2P265MB2605.GBRP265.PROD.OUTLOOK.COM>
 <CAPnjgZ37QpGjJHevWDF_N=eNUKNL5TguewG-y7JMNuDkss2o2g@mail.gmail.com>
 <LO2P265MB26056606FC59BFEDCDE78DA1DB93A@LO2P265MB2605.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <LO2P265MB26056606FC59BFEDCDE78DA1DB93A@LO2P265MB2605.GBRP265.PROD.OUTLOOK.COM>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 Dec 2023 10:53:22 -0700
Message-ID: <CAPnjgZ21WgxARj2f6M8_HpWMceF+Xg1=H0fA5=9SWYH0qn7ZXA@mail.gmail.com>
Subject: Re: whitelist commands
To: Thomas McCann <Tmccann@drumgrange.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Thomas,

On Fri, 15 Dec 2023 at 02:12, Thomas McCann <Tmccann@drumgrange.com> wrote:
>
> Hello Simon,
>
> Firstly my apologies I very new to U-Boot and just trying to make sense o=
f it all. My chip currently does not boot because the commands "bootelf" co=
mmend is not whitelisted.
> My question was two-fold really, it the whitelisting done by u-boot or is=
 specified in the device tree?
> How does one modify the u-boot boot.scr so that I can boot my device to n=
ot use bootelf?

Please can you keep the ML copied with replies? (and BTW we try to add
posts to the bottom)

To find this:
- look up do_bootelf()   (~all commands start with do_ and end with
the command name)
- this is in cmd/elf.c
- then look up cmd/Makefile to see where elf.o is enabled:
obj-$(CONFIG_CMD_ELF) +=3D elf.o
- then look up cmd/Kconfig to see 'config CMD_ELF'

So probably your board has CMD_ELF disabled. It is enabled by default,
so perhaps you have '# CONFIG_CMD_ELF is not set' in the
config_xxx_defconfig for your board? If you remove that, then the
command should be enabled. You can check using 'make menuconfig' or by
using grep on the .config file produced.

Regards,
Simon


>
>
> Yours sincerely,
>
> Thomas McCann | Software Engineer
>
> -----Original Message-----
> From: Simon Glass <sjg@chromium.org>
> Sent: Wednesday, December 13, 2023 7:50 PM
> To: Thomas McCann <Tmccann@drumgrange.com>
> Cc: u-boot@lists.denx.de
> Subject: Re: whitelist commands
>
> CAUTION: This email originated from outside the organisation, do not clic=
k links or open attachments unless you recognise the sender and know the co=
ntent is safe. Forward this email to it@drumgrange.com<mailto:IT@drumgrange=
.com> if you believe it is suspicious.
>
> Hi Thomas,
>
> On Wed, 13 Dec 2023 at 07:29, Thomas McCann <Tmccann@drumgrange.com> wrot=
e:
> >
> > How do I add commands to the whitelist.
>
> Which whitelist are you referring to? I am not aware of one for commands.
>
> Regards,
> Simon
>
>
> >
> >
> > Yours sincerely,
> >
> > [cid:image001.png@01DA2DCD.383194D0]<http://www.drumgrange.com/>
> >
> > Thomas McCann
> > Software Engineer
> > =F0=9F=93=A7 Tmccann@drumgrange.com
> >
> > [cid:image002.png@01DA2DCD.383194D0]<https://linkedin.com/company/drum
> > grange-ltd>[cid:image003.png@01DA2DCD.383194D0]<https://www.adsgroup.o
> > rg.uk/about/>. [cid:image004.png@01DA2DCD.383194D0]
> > <https://hellios.com/joscar/> . [cid:image005.png@01DA2DCD.383194D0]
> > <https://www.cyberaware.gov.uk/cyberessentials/>
> > ..[cid:image006.jpg@01DA2DCD.383194D0]<https://www.drumgrange.com/abou
> > t-us/armed-forces-corporate-covenant/>
> >
> > .
> > Drumgrange is recruiting! For more information, click
> > here.<https://www.drumgrange.com/careers/>
> > .
> >
> > =F0=9F=8C=B2  Please consider the environment before printing this e-ma=
il This
> > communication may contain information which is subject to UK Export Con=
trol Law, commercial-in-confidence and/or legally privileged and is intende=
d only for the addressee named above. If you are not the named addressee, t=
he communication has been sent to you in error. Any copying, distribution o=
r other use of the information is strictly prohibited. Please note we do no=
t accept liability for any viruses which may be transmitted in or with this=
 message.
> >
> > Drumgrange Ltd. is a company registered in England and Wales with compa=
ny registration number 1460044 Registered office address. Drumgrange Ltd. U=
nit A, The Forum, Hanworth Lane, Chertsey, Surrey, KT16 9JX.
> >

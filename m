Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB22C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 15:24:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08C028877C;
	Fri, 19 Apr 2024 17:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="QDNzmyFP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42A708878B; Fri, 19 Apr 2024 17:24:45 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7383388777
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 17:24:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a44ad785a44so220851566b.3
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1713540282; x=1714145082; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NLeg++Y8E8gIeAwtbYE21MC56AVcPAW8yy68nqDmV3o=;
 b=QDNzmyFP6fGM7k1ApVzQYIEux+ykhTLcS0HOP106DkbxfAsQxVauLZ15i6kvMzVv0I
 v4fd/tTfKp27+tgxDDoJMphBy84mSXB7X32Vwp21IrMOS9fVXN89gcz75ldIrQGuMDcq
 5llJ1AhrCKkbbmgiNcCX05FX/UXiqueRRuIKYfrxRPXWZgBgH1N2fm3F+YAo0QpBbywJ
 ALwYsP50k7skl4LdOxuFSXruBPcHpOB3D+nzZfjUNGhMpRDpGQZuJ1sCE/7VsnkwhqVN
 T1qho2/8krgfeonpXOPh25OSTDROsqPUtyYlwipoY703w/82L+sfwEzpbWql/2u4+MlJ
 xhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713540282; x=1714145082;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NLeg++Y8E8gIeAwtbYE21MC56AVcPAW8yy68nqDmV3o=;
 b=k0QzmAjcfw7GjAlP5yTwQu9qnRrbE8vmm7p56jWTLXyfZsFnJhjYk8o7tDUsfHX/r8
 6YQy9g0vind2Vl1h+787/4JSt6SbqhJ9AbAE+1L3oBkarLiVyW2pw3KyBylAd5HHlGQ7
 y4mTH0kebGfj2Oj41yFzjUNPuZ2NQnPTkUrX3GvGXwpyT/o3jsXoHi9xryZQxT6E10rX
 SGHjA/U9YOB1PnUmXFGxUKoQ8YfPHPhpKsUsZqS+zH0EBaII+OCdYyom2wXFojH0HBEL
 LHK8VgKmytUUvtRqR+cPoFUI/hE/KTL4PIzL88WOjIgZgVrpOR+4tYO7u+mdhJApKYNf
 90jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2weII4XzDJM+619Pndg9aQXUJMcOibVnMc4OVO2mY0sbGNVjZxwPOfI6Y5PduIucg7VOhXyNrVj/Zkt+N+gs/NqOd2w==
X-Gm-Message-State: AOJu0YxEhzbp5cLT4YmLJd8H9z9k5D0Yxf5LAjUEwuxfG1VBqzL+MEsz
 f/r7fIAEJ796act/Xj1F5PyCHEcfoeCPb23R6XHci1Tk9Iqvw+noalUTWM2KLsO6zojb/3N8fwl
 4TgQp5l/p+97+K/yh3QdYlS7AE5AJuhKaLtPJ/A==
X-Google-Smtp-Source: AGHT+IEIyywxFOru4sl0jEnEkw1iWiUFiXaqIPfOthaKNcPixs/e4/WOvTP/lyusNAWE3Uk8n7zGSCasS19OTquA3mM=
X-Received: by 2002:a17:906:7016:b0:a52:6435:ef09 with SMTP id
 n22-20020a170906701600b00a526435ef09mr1775673ejj.76.1713540281773; Fri, 19
 Apr 2024 08:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240120003610.124981-1-marex@denx.de>
 <CAJ+vNU31BNnThbDDrvaThPy01roPTGXYWJbp4wbJeD-K0gjpzQ@mail.gmail.com>
 <2e4997d2-1f10-46f8-b2f2-6ac641368f04@denx.de>
 <CAJ+vNU0Og=g-xxjgWdu9g4U=DR6fuKoDWNUr9PB0VnL99bcu2Q@mail.gmail.com>
 <CAOMZO5DL683849BczPa9aJvMJxZm536vp-wE5P+jcCK1KLkGEg@mail.gmail.com>
 <6783be1a-ade0-4cf2-89d6-b6ec29df5ce0@denx.de>
In-Reply-To: <6783be1a-ade0-4cf2-89d6-b6ec29df5ce0@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 19 Apr 2024 08:24:30 -0700
Message-ID: <CAJ+vNU13yh8K4UbK2xLCwS74gn25NGFUFHd_n_EqbknyVmAdSg@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Enable kaslrseed command on DH i.MX8M Plus DHCOM
To: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Fabio Estevam <festevam@denx.de>,
 u-boot@lists.denx.de, 
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com,
 Claudius Heine <ch@denx.de>
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

On Thu, Apr 18, 2024 at 11:42=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 4/18/24 8:02 PM, Fabio Estevam wrote:
> > Hi Tim,
> >
> > On Thu, Apr 18, 2024 at 2:54=E2=80=AFPM Tim Harvey <tharvey@gateworks.c=
om> wrote:
> >
> >> Fabio, if you enable CONFIG_DM_RNG on an imx8m{m,p}_evk do you get the
> >> following in the SPL?
> >> Couldn't bind rng driver (-96)
> >> SEC0:  RNG instantiated
> >>
> >> sec_init failed!
> >
> > Yes, if I add CONFIG_DM_RNG=3Dy to imx8mm_evk_defconfig I get:
> >
> > U-Boot SPL 2024.04-00793-g3434b88d2c2f-dirty (Apr 18 2024 - 14:58:57 -0=
300)
> > No pmic
> > Couldn't bind rng driver (-96)
> > SEC0:  RNG instantiated
> >
> > sec_init failed!
>
> Interesting. Which TFA blob version do you use ? I used the mainline
> 2.10 for my tests.

Marek,

Were you able to reproduce this as well with the board you enabled
DM_RNG for? If it does work fine what dtb were you using... perhaps
there is something in its u-boot.dtsi that we need?

The error -EPFNOSUPPORT is interesting and helps point to the only
place it can be where the comment says the strange errno is to make
this easier to find:
https://elixir.bootlin.com/u-boot/latest/source/drivers/core/uclass.c#L70:
        if (!uc_drv) {
                debug("Cannot find uclass for id %d: please add the
UCLASS_DRIVER() declaration for this UCLASS_... id\n",
                      id);
                /*
                 * Use a strange error to make this case easier to find. Wh=
en
                 * a uclass is not available it can prevent driver model fr=
om
                 * starting up and this failure is otherwise hard to debug.
                 */
                return -EPFNOSUPPORT;
        }

I'm not very familiar with the dm driver binding - does the
U-BOOT_DRIVER usage in drivers/crypto/fsl/rng.c need to be refactored
to use UCLASS_DRIVER for it to be usable in both SPL and U-Boot?

Honestly I don't know why we need DM_RNG in SPL anyway and we could
just add support for disabling it there to avoid unwanted bloat.

Tim

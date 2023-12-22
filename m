Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1BCC41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 14:09:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D0E2877E2;
	Fri, 22 Dec 2023 15:09:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iAj/oVoR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B83EB8775F; Fri, 22 Dec 2023 15:09:06 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 633BB877F1
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 15:09:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3bb87bd6884so661190b6e.3
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 06:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703254140; x=1703858940; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=17GXyaS2fxO5LiO+TC8Wxk3iIbCu0MCR/bji4+fxoDQ=;
 b=iAj/oVoRYsm0YYWTh45zY2i30cMHR6OLeaMU3xKbGu0ryNCMPN2+geU36WIMjanFcZ
 vhdmYyTS4+pYaAGLkNmkGjB8wQ/0Akn/B/yxiKD/XDpN8ulfNBV+hOWTOcDdZmMlr4hk
 mgkLxDVbV80vOF7do9MGu1QqBVVZWzxLWAWpbkUzTVJA8LW6Xc3HT+SsqsweC41YyADy
 cevbZurvtD3tyjQ4LPBQVUktCk8mcEY03z6dXUcwnN9OiRZ5neI7F8vi8LQHLIjcKUdx
 9QMG3sH9W99lrFr083GECk0zKmnu0xeRCaJzSxxYcBWJSpY9/94hm0PD3JYTdn+uKmJ1
 oLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703254140; x=1703858940;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=17GXyaS2fxO5LiO+TC8Wxk3iIbCu0MCR/bji4+fxoDQ=;
 b=IvcqYDljq5GfnR2AW4kLvoKQFJw5b773HGpidjdRRpqcKNopsSev/IpPZKX02GqLUk
 RwOAuk6Lv4i/L5Wg4QfPysEGAah61b5ayXnkp9Sg8uoW313IrHVaAafvetZOkPm9GcPL
 DLLbBEL1UCk+PUNsc6k5Qmw7GDB7Gss0gOfyQitad75CvyUb7Ms77ch2lsXveP/PiczF
 ht2dYZV5wfA+ADgh7iHVI6AXoQjkDVB4GcVjebicgHCa8nSyPkRsscEbN35XQ7cPKmdO
 0jrs/296omGDIWd9xAaHE70HdSFy359mkNJDFRuvEmFm9IEdFOwHXWXXQF552+R5E+k1
 Z7qw==
X-Gm-Message-State: AOJu0YwSDhU3eEkiuUuCUD/ECYcb9F1JfElupM8LjKXT4BZuzL4/dPjP
 0ONeDvlwSzZD9uPqdOkmkjDhNWHsPMqW52JbRw9iwDftnZnLKg==
X-Google-Smtp-Source: AGHT+IF0EBO4VEDd9rCiFdOBaT/bfsW7WinaIYgqzq0CjOuRaqmWWNiTPzdnuCbOPMylezliV5Js42Y7RohI6lHHozo=
X-Received: by 2002:a05:6808:320f:b0:3bb:7c06:a713 with SMTP id
 cb15-20020a056808320f00b003bb7c06a713mr1333111oib.112.1703254139818; Fri, 22
 Dec 2023 06:08:59 -0800 (PST)
MIME-Version: 1.0
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <20231222061208.3009970-6-sumit.garg@linaro.org>
 <20231222123504.GA2513409@bill-the-cat>
 <CAFA6WYNo3mNE94tHo0-iogbk49ZSo4WXzRWPME=XPZ7F1H5a8g@mail.gmail.com>
 <20231222135639.GC2513409@bill-the-cat>
In-Reply-To: <20231222135639.GC2513409@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 22 Dec 2023 19:38:48 +0530
Message-ID: <CAFA6WYOWqwOwhLYooNSS32E-WwAfGRyXZjG=dgXXJyOjnzGA3Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] doc: devicetree: Updates for devicetree-rebasing
 subtree
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, sjg@chromium.org, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 22 Dec 2023 at 19:26, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Dec 22, 2023 at 07:18:05PM +0530, Sumit Garg wrote:
> > On Fri, 22 Dec 2023 at 18:05, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Dec 22, 2023 at 11:42:05AM +0530, Sumit Garg wrote:
> > >
> > > > Encourage SoC/board maintainers to migrate to using devicetree-rebasing
> > > > subtree and maintain a regular sync with Linux kernel devicetree files
> > > > and bindings.
> > > >
> > > > Along with that add documentation regarding how to run DT bindings
> > > > schema checks.
> > > >
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > ---
> > > >  doc/develop/devicetree/control.rst | 108 +++++++++++++++++++++++------
> > > >  1 file changed, 86 insertions(+), 22 deletions(-)
> > > [snip]
> > > > @@ -81,18 +94,21 @@ Failing that, you could write one from scratch yourself!
> > > >  Configuration
> > > >  -------------
> > > >
> > > > -Use::
> > > > +Traditionally, U-Boot placed copies of devicetree source files from Linux
> > > > +kernel into `arch/<arch>/dts/<name>.dts` which can be selected via::
> > > >
> > > > -   #define CONFIG_DEFAULT_DEVICE_TREE        "<name>"
> > > > +    #define CONFIG_DEFAULT_DEVICE_TREE       "<name>"
> > >
> > > Oh, oof. This never got updated for Kconfig rather than config.h. Can
> > > you please include re-wording this to be setting <name> when prompted
> > > for DEFAULT_DEVICE_TREE by Kconfig? And the rest of the text you're
> > > updating as well to match, thanks.
> > >
> >
> > Sure but how about changing it to say via board defconfig as
> > CONFIG_DEFAULT_DEVICE_TREE="<name>", since AFAIK most people use
> > defconfig to configure U-Boot.
>
> Well, do kernel docs tell people to modify defconfigs, or to use the
> config menu/etc?
>

Okay I see your point, I will use wording to select
DEFAULT_DEVICE_TREE by Kconfig instead.

-Sumit

> --
> Tom

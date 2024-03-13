Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11092C54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 11:39:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D5E287DB0;
	Wed, 13 Mar 2024 12:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K+Lahluh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BB0287DB0; Wed, 13 Mar 2024 12:39:31 +0100 (CET)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6914287E75
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 12:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-475fd9809a5so18061137.3
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 04:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710329966; x=1710934766; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=08SSfqAFfu9Ux1eHf9tgI7i4U5VrdB0qrgVcVeoHNM0=;
 b=K+LahluhD7t4DV+KQz/Ymj4VtkivbMqiBGTmzAnWo+5+TJ0zsC1Exq3/qu6QnOR+pB
 smBkiKIIyst8M9Q+qVH+hnbMwngaP7Rd+eRn9VtdsUsO6YgNFokAko21BZ0aR802eZ7B
 Hm+kCsZEmJIQiXoygaZKn9jP9NdrTEdneSFus3j0sgntOWffVGiOct7+tPSNPZtuGlF8
 Xu+2tTmoZfweBRDvkHa/vLLvCEuUSGOmWET2Y15dXvoizQReGuRnSs7lVZqAEF30w9lv
 fq3csMEmgxAEF4itLM63Y6bivm4DCPYt0aVqQs2fTi0Zt1bGCFPcXMXQvhofu3lB3ZuQ
 rMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710329966; x=1710934766;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=08SSfqAFfu9Ux1eHf9tgI7i4U5VrdB0qrgVcVeoHNM0=;
 b=EMqagPmQp9VATtX7aiWdfiXW/P1RY+FqxhnPJ8B7aRLh7DbrCN8nVaZTFMHkX26uQC
 2V7FZ1OAY1iaLTwGbpgVaGiZ2tUURkVfIyXm7qq23NvCPv9eY9XwZRcYDZWQsiGX6LbP
 Vuni/Jakkt589Y+3W0aXnvLyxjrW43B2UhjIgK93u+nNYvjxemfOGR1c0KF3qG+A3b+u
 SGJRiy8Nsc56JSbzxm7vf+ggtu4yrXTJJiw1sq/F/UqM62LH8sEMXtcV6JijnSFLW3Ll
 Y+FH4Z4AF8dudI9XZTBjJ0VkqExVEHLVIF9GDZ4nrug254JUawvZYCfWLZXruwBc1atx
 DeFw==
X-Gm-Message-State: AOJu0Yyjo3V2a+0vxGbvgxz8ym3nTPJ4vBAQdvCyiA54/aJfmTH5hXqF
 aT3AkCd71PGgFq1St4haNLePsTvfvR8hNf/kTZtGYYmqgbAu+twq773eV7WmHPjvtQyFHvpjq2x
 FRzk2KonFNp/66jkLLvgYIp1ojpIa0c6DpHQU0g==
X-Google-Smtp-Source: AGHT+IGS8FJDmyiLO4ttlE4CA2K+c8+78GJ/XGxQCt/efrID4eWdwmITHVCBka9mFEU+tHRqKmD4e+1m2a2WNSyMSe8=
X-Received: by 2002:a05:6102:97:b0:474:cf77:802 with SMTP id
 t23-20020a056102009700b00474cf770802mr1278865vsp.15.1710329966039; Wed, 13
 Mar 2024 04:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240311111027.44577-1-sumit.garg@linaro.org>
 <20240311111027.44577-6-sumit.garg@linaro.org>
 <Ze8XM9cvZt7fSYg5@gerhold.net>
 <CAFA6WYOP2Y2byfTWVKv5j6Yu61q64hG_JHBRDspabnybh5KMSA@mail.gmail.com>
 <ZfGN9j3Nb2CIoy_e@gerhold.net>
In-Reply-To: <ZfGN9j3Nb2CIoy_e@gerhold.net>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 13 Mar 2024 17:09:15 +0530
Message-ID: <CAFA6WYNoiZPu7VTYs7Q=+Frc9WACpQE=a3JbrrHOy9nVR9d92A@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] board: add support for Schneider HMIBSC board
To: Stephan Gerhold <stephan@gerhold.net>
Cc: u-boot@lists.denx.de, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 trini@konsulko.com, lukma@denx.de, seanga2@gmail.com, sjg@chromium.org, 
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com, 
 jimmy.lalande@se.com, benjamin.missey@non.se.com, daniel.thompson@linaro.org
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

On Wed, 13 Mar 2024 at 16:59, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Wed, Mar 13, 2024 at 12:08:58PM +0530, Sumit Garg wrote:
> > On Mon, 11 Mar 2024 at 20:07, Stephan Gerhold <stephan@gerhold.net> wrote:
> > > On Mon, Mar 11, 2024 at 04:40:26PM +0530, Sumit Garg wrote:
> > > > Support for Schneider Electric HMIBSC. Features:
> > > > - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> > > > - 2GiB RAM
> > > > - 64GiB eMMC, SD slot
> > > > - WiFi and Bluetooth
> > > > - 2x Host, 1x Device USB port
> > > > - HDMI
> > > > - Discrete TPM2 chip over SPI
> > > >
> > > > Features enabled in U-Boot:
> > > > - RAUC updates
> > > > - Environment protection
> > > > - USB based ethernet adaptors
> > > >
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > >
> > [...]
> > > > +     gpio_rs232_high: gpio_rs232_high {
> > >
> > > Pretty sure DT schema checks would complain about this node name (need
> > > -state suffix, no underscores).
> >
> > We have the dtbs_check in U-Boot too. I will use that before posting
> > the next version.
> >
> > >
> > > > +             bootph-all;
> > > > +             pins = "gpio99";
> > > > +             function = "gpio";
> > > > +
> > > > +             drive-strength = <16>;
> > > > +             bias-disable;
> > > > +             output-high;
> > > > +     };
> > > > +
> > > > +     gpio_rs232_low: gpio_rs232_low {
> > >
> > > Same here.
> > >
> > > Also, since I'm looking at this a bit more closely now, are there maybe
> > > more clear label/node names you could use here, or a comment you could
> > > add what exactly these pins do? I guess this enables something about
> > > RS232 but it's not clear what exactly.
> >
> > Actually these GPIOs are a mux to select among different UART modes
> > (RS232/422/485). This configuration allows you to select RS232 mode.
> > How about following label/node names?
> >
> > uart1_mux0_rs232_high: uart1-mux0-rs232-state
> >
> > uart1_mux1_rs232_low: uart1-mux1-rs232-state
> >
>
> Hm, is it a 2 bit mux selector like
>
>         gpio99  gpio100 UART mode
>         0       0       ?
>         0       1       ?
>         1       0       RS232
>         1       1       ?
>
> and the others are RS422 and RS485?

Yeah, just to complete that table:

         gpio100  gpio99 UART mode
         0             0            loopback
         0             1            RS-232
         1             0            RS-485
         1             1            RS-422

> If yes, a comment with the table of
> the function assignments would help a lot for clarity.

Sure I will add that.

> With that,
> precise naming would not be that important anymore. :-)
>

I will keep the updated naming too.

-Sumit

> Thanks,
> Stephan

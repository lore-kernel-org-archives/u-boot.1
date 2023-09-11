Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0A5EE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 05:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4350B86583;
	Mon, 11 Sep 2023 07:23:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eQaE+tSg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAF1786410; Mon, 11 Sep 2023 07:23:17 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66B7386583
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 07:23:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bf7b5e1f06so7324535ad.0
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 22:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694409793; x=1695014593; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D4RzJmiYCzTefHGKldBRhnjjjDsCDGI0zcGmac4AE+I=;
 b=eQaE+tSgewbQP8dxT5oaZCoDSkpDT/58G+JDeoH0uagBX47I/BRuHzsaX+mszZkJP1
 F4+kHa06FqoSC6wDAP8YPQh+IcaCoF1gTXXhiXRmvGVJSvqX6fy//nIWcCH8i7KKqxZG
 KLwE3hlvePb2fh+fQxoZhe9cIrS13WNyGfuH2dNIGvJnnYLn89rEMUOMX+xG6M0dr0fk
 OPFNuS8YYaUKw8G28Ll2RupoPg/Y/yFIWTBBQZfiaiu6SkGKM+hSf+rqLFNGl7LNpevy
 y64wFOuoXFUzF7EX9Fhp2v8FEqsgmwVYzHNNBdpfszshUvJdI8lwzenwQqyQUbsg73G6
 1xLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694409793; x=1695014593;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D4RzJmiYCzTefHGKldBRhnjjjDsCDGI0zcGmac4AE+I=;
 b=ct2e+Tz+mInKkEbAiH3W+7tOLRTmmqL5E94I/9wfqCh4ENQN99WjOzHAu2jEO25xAm
 Fxyd2LbAok0d5TzMBgO/+y8OS1SDU6IPiQJcHKQvAXuZ364N1tbaV5y6h0tuqTXmsaEl
 0/kN/ArK6Xf1nqQwBmM8vHt6fm7Ri/p8OBno79PM2Yk/LVC5LKeS4+XJvCJGDVWl5u2L
 JgsG7F29se6/wbY/UJxE8I5Q+FiAxGUZgChvDapmn8zXElYzHEHnEWX9p4Jfe9N6gr5b
 h0y+kqbEqgbJwJ0qlYWzxreZ2k8dT+xTel43RmCICqa+COqdsrigFY5W3tb50uXLniqb
 kSog==
X-Gm-Message-State: AOJu0Yxa8lHVTR43jasEj8Rg4Q0ksg+Ks5ji3lYXY6P1B2NhOwejM35F
 EHtZndh0yxsj2UV0GRh/LRS6UOMNm6IIWaJG7j6+LQ==
X-Google-Smtp-Source: AGHT+IEh52g13hqHOw2UvttrK9A7G2X4DEqZBivYrE7r6ZGNOOzzRJb+hlqtwx9gKrIExyBzSAoMOA==
X-Received: by 2002:a17:903:2448:b0:1c1:ee23:bb75 with SMTP id
 l8-20020a170903244800b001c1ee23bb75mr10567193pls.1.1694409792688; 
 Sun, 10 Sep 2023 22:23:12 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:91f5:5d19:aad:686c])
 by smtp.gmail.com with ESMTPSA id
 d7-20020a170902cec700b001c0a4146961sm5474491plg.19.2023.09.10.22.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 22:23:12 -0700 (PDT)
Date: Mon, 11 Sep 2023 14:23:09 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, etienne.carriere@st.com, michal.simek@amd.com,
 linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com
Subject: Re: [RFC 5/6] firmware: scmi: add pseudo pinctrl protocol support on
 sandbox
Message-ID: <ZP6kPVk9AGoO5T/z@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 etienne.carriere@st.com, michal.simek@amd.com,
 linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com
References: <20230906024011.17488-1-takahiro.akashi@linaro.org>
 <20230906024011.17488-6-takahiro.akashi@linaro.org>
 <CAPnjgZ2GwRi4TyNVzcm9UZOtvmhj+2ZwH77Z62VvNNH56D6spQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2GwRi4TyNVzcm9UZOtvmhj+2ZwH77Z62VvNNH56D6spQ@mail.gmail.com>
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

On Sun, Sep 10, 2023 at 01:13:28PM -0600, Simon Glass wrote:
> Hi AKASHI,
> 
> On Tue, 5 Sept 2023 at 20:41, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > With this patch, sandbox SCMI agent can handle pinctrl protocol.
> > This feature is used in an unit test for SCMI pinctrl.
> >
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  arch/sandbox/dts/test.dts                  | 115 ++++
> >  drivers/firmware/scmi/sandbox-scmi_agent.c | 722 +++++++++++++++++++++
> >  2 files changed, 837 insertions(+)
> >
> > diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> > index dc0bfdfb6e4b..d2ddea801995 100644
> > --- a/arch/sandbox/dts/test.dts
> > +++ b/arch/sandbox/dts/test.dts
> > @@ -723,9 +723,124 @@
> >                                         };
> >                                 };
> >                         };
> > +
> > +                       pinctrl_scmi: protocol@19 {
> > +                               reg = <0x19>;
> > +
> > +                               pinctrl-names = "default","alternate";
> > +                               pinctrl-0 = <&scmi_pinctrl_gpios>, <&scmi_pinctrl_i2s>;
> > +                               pinctrl-1 = <&scmi_pinctrl_spi>, <&scmi_pinctrl_i2c>;
> > +
> > +#if 0
> 
> Are these alternatives that you are testing?

I should have had more explanation.
Yes, as I mentioned in the cover letter (and patch#4), there
are two alternatives for defining SCMI pinctrl based gpio devices.
Actually, this "#if" corresponds to the case (B) where gpio node
is located under scmi node.

Since I didn't come up with any good way to switch two cases dynamically
in the test, I had modified this option manually.
(I left two "#if" here as the patch was an RFC, any way.)

Thanks,
-Takahiro Akashi

> 
> The bindings  look OK to me - is this how it is done in Linux?
> 
> Regards,
> Simon

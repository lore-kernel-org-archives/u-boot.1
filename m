Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A0EEE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 04:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29D3E86C5E;
	Mon, 11 Sep 2023 06:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QWJX72FO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0232B86CF2; Mon, 11 Sep 2023 06:58:23 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 706618652B
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 06:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2684e225a6cso545287a91.1
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 21:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694408297; x=1695013097; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L/t3vfMkOY+mumYRC118JDXb4yTlWzC4S2XKqfHyxaY=;
 b=QWJX72FOSTegb0XAWofjh8IX+J3lj6lWol1aQWZvU6UTE8uwsYcnhgQlyFSWEgE0OK
 SgcchI8iUrZFcEwFzxFClCSpUMebsUvi+qnQEIbgcRRW/fuIlVfkdKwoZXAB3oo1cF/j
 d2WU1m9pSsO/InO93ZQESvyFmx76YxyrDApkNfPplCv/GTrRnDu/AcSHlqEVjovs4Kxc
 zmdxYxE6EF+BhVHF+2VDwANTvH2foElhpr9/FbdbNukRNnth3mjxupOYmFjjs6+v4jvd
 NqihwTJdeL5bKxmDKIYYr8d4TD41xPYuXWbRbfPqkZMgzSEsx82tiwKPF4fGP5iR8yRM
 /cLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694408297; x=1695013097;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L/t3vfMkOY+mumYRC118JDXb4yTlWzC4S2XKqfHyxaY=;
 b=Axn7x9tV6Bj8/fck1pLMvGQOa88WYBepwHW4J+qgVWM5j4fLrXDZKuwBbW/ncxzEdr
 tsjy/5g+FxIlZ2t7fxF1uEVsxYOmm0eKZDMkc4BnXjKAhAR+gP1RXh5xzoBKyOwaXAEN
 kSImcos4pHwVechh/Y3b/ZwMXDBe3Vv+D6p2PgocrHATm5DaoCtyIweccms/x53xFthF
 ALP0Stzzzhf1Ze/zl0zGzQ97onZKAHYlhEa37G3c8cECIBn/E/aDhXL0asfqBYYVLl+1
 3clsVP+ULhUCThV7xSU9oD/ugQerC6cCbrffcbKfpxW+gk/a8/vbY0y/ziTAKzYWgIXZ
 tp/Q==
X-Gm-Message-State: AOJu0YwHfGdAOLWPVBvFVbORUPD4aTaqUkKiSrWZIWsV22mrDbu8NdzK
 6TT5x46ILvUVsqLaq0B2XOlmXA==
X-Google-Smtp-Source: AGHT+IFXgGzou8g7yGtSYwiXWAfJMggoyQZSCjX6X+Q3qjJpviSEoEFX7e8g2vySKuXL9u99zrufIg==
X-Received: by 2002:a17:90a:9bc4:b0:273:e4a7:ce72 with SMTP id
 b4-20020a17090a9bc400b00273e4a7ce72mr6042696pjw.3.1694408297488; 
 Sun, 10 Sep 2023 21:58:17 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:91f5:5d19:aad:686c])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a17090aae0500b0026b3ed37ddcsm4714458pjq.32.2023.09.10.21.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 21:58:16 -0700 (PDT)
Date: Mon, 11 Sep 2023 13:58:13 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, etienne.carriere@st.com, michal.simek@amd.com,
 linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com
Subject: Re: [RFC 1/6] firmware: scmi: fix protocol enumeration logic
Message-ID: <ZP6eZS29gQhQ9x3z@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 etienne.carriere@st.com, michal.simek@amd.com,
 linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com
References: <20230906024011.17488-1-takahiro.akashi@linaro.org>
 <20230906024011.17488-2-takahiro.akashi@linaro.org>
 <CAPnjgZ0kxE3NXD_pLTm5Oc3Sb9HRUz5pbWETCqrvr4XwSUzKcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0kxE3NXD_pLTm5Oc3Sb9HRUz5pbWETCqrvr4XwSUzKcA@mail.gmail.com>
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

Hi Simon,

On Sun, Sep 10, 2023 at 01:13:26PM -0600, Simon Glass wrote:
> Hi AKASHI,
> 
> On Tue, 5 Sept 2023 at 20:41, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > The original logic in enumerating all the protocols accidentally
> > modifies a *loop* variable, node, at Voltage domain protocol.
> > So subsequent protocol nodes in a device tree won't be detected.
> >
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  drivers/firmware/scmi/scmi_agent-uclass.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
> > index 46a2933d51a4..79584c00a066 100644
> > --- a/drivers/firmware/scmi/scmi_agent-uclass.c
> > +++ b/drivers/firmware/scmi/scmi_agent-uclass.c
> > @@ -422,8 +422,11 @@ static int scmi_bind_protocols(struct udevice *dev)
> >                 case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
> >                         if (IS_ENABLED(CONFIG_DM_REGULATOR_SCMI) &&
> >                             scmi_protocol_is_supported(dev, protocol_id)) {
> > -                               node = ofnode_find_subnode(node, "regulators");
> > -                               if (!ofnode_valid(node)) {
> > +                               ofnode sub_node;
> > +
> > +                               sub_node = ofnode_find_subnode(node,
> > +                                                              "regulators");
> > +                               if (!ofnode_valid(sub_node)) {
> >                                         dev_err(dev, "no regulators node\n");
> >                                         return -ENXIO;
> >                                 }
> > --
> > 2.34.1
> >
> 
> This function is very ugly...could we instead rely on driver model to


I think you are talking about scmi_bind_protocols() itself,
not the hunk above in my patch, which is merely a bug fix
in the existing code.
If so,

> bind the devices? It seems unfortunate to have to write code for
> something which could be done with no extra code.

We will discuss in the threads on your comment [1].

[1] https://lists.denx.de/pipermail/u-boot/2023-September/530200.html

-Takahiro Akashi


> Regards,
> Simon

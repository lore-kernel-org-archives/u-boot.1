Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA48C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 12:54:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01A8387B9D;
	Wed, 31 Jan 2024 13:54:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SD3aK1Uv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE42487BC4; Wed, 31 Jan 2024 13:54:07 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB5338753A
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 13:54:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5100cb238bcso9353643e87.3
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 04:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706705645; x=1707310445; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=erok/9EjA9HfJ/lbMOiOZpog4wB1Rp/l2MzXA9DIjWU=;
 b=SD3aK1Uv1g7pekQHw4vy2klGBb7bdzZ3x4uwM0Ks4eTC+f6QOZgXFx/dnQtlU/KW98
 aD70WU05iQOv6HqSwV9NJ/wRGs+QOWZG1/q6DEv7Wt5TflQirJg6TitXtxcJSMiKrEwh
 ZDXf11OQSsvLb4cJXuMo2dK1J7onCBsKnRPv8gRFhRfot+yBxbUAVqLfJgHcNm6vCv8c
 iaYx2Gqa7F5VZCWdfi63c+BCoCtlkdyvciPcKoJYnvP0MaAvEoQ3CqK2u9o9Rl0UiQpu
 wkmDA2VvpO5eeTzxH35+2sXDoGrQbNqiwpqvD7cqlPpXKUtrA/llBWXyNjNCZtP31tJb
 jFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706705645; x=1707310445;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=erok/9EjA9HfJ/lbMOiOZpog4wB1Rp/l2MzXA9DIjWU=;
 b=OqXhy+QS6HX4dcQ9W3qbyi6mDeFFv5VnJEPYdqtT2FwT1MggHvu7m0up7mmhL1/zEs
 i4lUzayU86XPG04zMbUWBqDxqF1lrclig8s/YMTYHfi8nVHaddQBbX10AmO79jlM1Nx6
 7VTwr3hYskOR40woq/y8Z2fzBP13L5/5ud671rkTK4UGWFo+UvT374vrrXMMVo3sMsZF
 WR5OJ6xpe7elKgbtMrvZQVvpJu02jokqDFyx4iK5rfXFTTS+PNPoZP5huU4rQQ1OXgCE
 fBN7LXiot8lHkice/EsF+tu6km80o5WFa9X10V9eqW4IqxcaZUwl4nrVIkL6EIgg+LXK
 n2Aw==
X-Gm-Message-State: AOJu0YwqIbe0YMBFjWP0k8BOba8URInDDtx6MT5o1vPI9qcprlzHJkBD
 DkveT2EBx7tvEQq3DTDLtC3zbOrj9n2QAzPQHI5YyBFDJWW0Tj+oqsROuZ54G6RFn1/jVzRJuI1
 hFk2BLrHTYJ6TKriPoskflJADV1JlylWeLl1KHQ==
X-Google-Smtp-Source: AGHT+IHSJOprH9keZPGL4b0IW3QC+nx9o4cWoQ6g28sI1EZRAR7eHMwUgTzG4eznC9Zt5Y+I6eJLMaxGm+MTbNv9ux0=
X-Received: by 2002:ac2:4c41:0:b0:510:1ac1:652a with SMTP id
 o1-20020ac24c41000000b005101ac1652amr1396993lfk.53.1706705645033; Wed, 31 Jan
 2024 04:54:05 -0800 (PST)
MIME-Version: 1.0
References: <20240131111217.30124-1-o451686892@gmail.com>
 <20240131111217.30124-3-o451686892@gmail.com>
 <eb91a882-332a-4bce-8547-4f212b5b6982@moroto.mountain>
In-Reply-To: <eb91a882-332a-4bce-8547-4f212b5b6982@moroto.mountain>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 31 Jan 2024 14:53:28 +0200
Message-ID: <CAC_iWjLhS8SRnXbz1ZLLwKSUAYh_oo+GK4osd3KbmSOWbkn2Mg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] driver: rng: Fix SMCCC TRNG crash
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Weizhao Ouyang <o451686892@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, 
 Peng Fan <peng.fan@nxp.com>, Jens Wiklander <jens.wiklander@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de, 
 Etienne Carriere <etienne.carriere@foss.st.com>
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

+cc Etienne

On Wed, 31 Jan 2024 at 13:49, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> Etienne should have been on the CC list.  He's in
> ./scripts/get_maintainer.pl so I'm not sure what went wrong there...
> I've added him.
>
> On Wed, Jan 31, 2024 at 11:12:16AM +0000, Weizhao Ouyang wrote:
> > Fix a SMCCC TRNG null pointer crash due to a failed smccc feature
> > binding.
> >
> > Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> > ---
> >  drivers/rng/smccc_trng.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/rng/smccc_trng.c b/drivers/rng/smccc_trng.c
> > index 3a4bb33941..3087cb991a 100644
> > --- a/drivers/rng/smccc_trng.c
> > +++ b/drivers/rng/smccc_trng.c
> > @@ -166,7 +166,7 @@ static int smccc_trng_probe(struct udevice *dev)
> >       struct smccc_trng_priv *priv = dev_get_priv(dev);
> >       struct arm_smccc_res res;
> >
> > -     if (!(smccc_trng_is_supported(smccc->invoke_fn)))
> > +     if (!smccc || !(smccc_trng_is_supported(smccc->invoke_fn)))
>
> To me it seems a bit strange that dm_priv_to_rw() can return NULL...
> Anyway, probably the Fixes tag should point to when the driver was
> added.
>
> Fixes: 53355bb86c25 ("drivers: rng: add smccc trng driver")
>
> regards,
> dan carpenter
>

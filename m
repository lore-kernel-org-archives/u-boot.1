Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37856C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 12:31:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DA8B87B8A;
	Wed, 31 Jan 2024 13:31:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GfdXhUAs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8723C87B8F; Wed, 31 Jan 2024 13:31:09 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 838B487B71
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 13:31:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-51120e2864fso1494558e87.1
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 04:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706704267; x=1707309067; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uyvnwKSECxXWFLfU+ZIOD5q/19iPQ9hc28xZS+hRfBE=;
 b=GfdXhUAsI7lOzR0yL0XVzaLOTA+Ggu67+DTBv6C8Agqp2MLLKj4LDy6L3KB6Z+z/KX
 Dl7jDnmlaasfriNMZ4u3N/KREzLcSPrGf88GPODPVGxHcqRftSNYb7bxxm7UuIJEoeyW
 yDYhdlI5DlDI2OotmYE7FRDel++lkIuOG61P2dtmnvJVaQvshv5efTeukEeq9jEyf0xI
 53w8fRxqUvnWE1/j+pgTyd9vB2ThRaq7PZHUeeZcmPapGssz3bpGptsnB/6uCXm73M1W
 2BazdREjo8/IpAb+uTtPNOh8Iv0NqWmE/b+SbSuHuZALmUWcVXkr1utrnMfu1PVWw93Y
 9q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706704267; x=1707309067;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uyvnwKSECxXWFLfU+ZIOD5q/19iPQ9hc28xZS+hRfBE=;
 b=gWY9SL743yUPgi6sRPDb7kcawGcO2i0vogKXxJVVRuun86lugnPsKCLtA9QEMefUoH
 A6MpJzaDWeJ52henX4CcGGx8dwat1c+dPB2cKqWGV36fh2u+eNe2yIAPGiF4rOwhPNkO
 xi1bBifWcBbkEv+GJG/umCY+W9oMO+VslWQaVimVWtJDvnVMqUCUuXgr0hrcdNUABbme
 tIMbybg71qghX2+8aZQc8gkN8ZP7N9dRg7dZ3XcbnFBRPEBX7IsQn5ghtrrAv7ejN0Zb
 SkFCuZiskK3kOypAVzg8Aw0erO15z4F4VM25U8JvV/1nKcr2+y146OoNJScHWZ50LYQC
 y4nQ==
X-Gm-Message-State: AOJu0YzRDxEVjFBtg8cIzLIiZE4DRsH+nTryKTN6tvqRvY3EUyv0XTXW
 0c7fIp6uIz7f2jRjjjBJk2q+WCk4j3IbL2fl5LdSqiLf5ij66c1Z4YP3qyGdgwE=
X-Google-Smtp-Source: AGHT+IGfzmfH18NJ6I/R/sBxTGPFCH6U4mvMTaZi9BtHxLo1qnWKRXvPqTKoF65hfWGQlYf8oobkgg==
X-Received: by 2002:a05:6512:33cb:b0:511:9dc:d8bf with SMTP id
 d11-20020a05651233cb00b0051109dcd8bfmr1280136lfg.67.1706704266769; 
 Wed, 31 Jan 2024 04:31:06 -0800 (PST)
Received: from localhost ([102.140.226.10]) by smtp.gmail.com with ESMTPSA id
 g10-20020a05600c4c8a00b0040ef702a338sm1446186wmp.25.2024.01.31.04.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 04:31:05 -0800 (PST)
Date: Wed, 31 Jan 2024 15:31:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Weizhao Ouyang <o451686892@gmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/3] driver: rng: Fix SMCCC TRNG crash
Message-ID: <f9408182-0586-488c-8fac-dcad824556e5@moroto.mountain>
References: <20240131111217.30124-1-o451686892@gmail.com>
 <20240131111217.30124-3-o451686892@gmail.com>
 <eb91a882-332a-4bce-8547-4f212b5b6982@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb91a882-332a-4bce-8547-4f212b5b6982@moroto.mountain>
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

On Wed, Jan 31, 2024 at 02:48:58PM +0300, Dan Carpenter wrote:
> Etienne should have been on the CC list.  He's in
> ./scripts/get_maintainer.pl so I'm not sure what went wrong there...
> I've added him.
> 

Hm...  Etienne's @linaro.org address bounces.  Apparently MAINTAINERS
needs to be updated.

regards,
dan carpenter


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
> >  	struct smccc_trng_priv *priv = dev_get_priv(dev);
> >  	struct arm_smccc_res res;
> >  
> > -	if (!(smccc_trng_is_supported(smccc->invoke_fn)))
> > +	if (!smccc || !(smccc_trng_is_supported(smccc->invoke_fn)))
> 
> To me it seems a bit strange that dm_priv_to_rw() can return NULL...
> Anyway, probably the Fixes tag should point to when the driver was
> added.
> 
> Fixes: 53355bb86c25 ("drivers: rng: add smccc trng driver")
> 
> regards,
> dan carpenter

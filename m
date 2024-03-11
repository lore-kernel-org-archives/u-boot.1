Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71833C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 11:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E019987F02;
	Mon, 11 Mar 2024 12:20:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rRAQtbIE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAC6B876F3; Mon, 11 Mar 2024 12:20:47 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4F2D876F3
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 12:20:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33e8e9a4edaso1825416f8f.2
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 04:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710156044; x=1710760844; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rv9fUdo78SvnZYwjXHLyf1WmJBswyG7bL1xBdvBqWIE=;
 b=rRAQtbIE6YSwHb8IumVHbz/nwgJOQ4sp9bl4V8jPJXm5vQpP4xyRr7BH5E54fw3s4M
 SdCdY4nyhW/TqJFXpRAfEuiC1qfaAcg7ifQvRbCF19l3JVoeBchctQWmTvDcTVL7TT7N
 dBHRVAjBHo7nxiZmO78w+P1VLjZnNZPJAsdsIdnlTqJuERiAhRnEu4f+4bDcOryIQrmA
 zxFtEIpwN98oxtyg9MzkvfIXG9Je+xycfkZ71dMz4OxYSL+OtOTauBW7lk0ewPoThS2o
 JEek3z6Y/XpWnT/wFrjA/uqXCUZNhbD84IDZHU1GyXQkOqhyUbU+hsZeHen0eorw9SgJ
 BbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710156044; x=1710760844;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rv9fUdo78SvnZYwjXHLyf1WmJBswyG7bL1xBdvBqWIE=;
 b=gDP2+FCqicUV4eRkEM+3HENNiT88s6GCx9wMGdEdLyXoertXXht42Jf1EroMMgJFRH
 +BjvSLdkwnqUNwA0LOzdkLjcTOJGyDaiwo0+lXBUJ7afmdsb+EzR7P1kG60hYrb/PNfo
 mMA8/XIgIzak1Ge7bhAI4d+YJSEToFflYLxjVl6aafi33oc89hQUZDn5XTk0Cx1q1T3P
 16s+w1ECz4YI/T+zVsJSg1QRgL1xELKiriz+nJOxHJM6u8anhqp6vlAV3t0g9+zpIWVK
 CmzQH/aTFsD5JCed7v7+fC0yHYyqtmT5O1DcYuOeMdZJLOqMcC6zItfhd/YvMbEyiERJ
 7opw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbRKXacgPycC1J4RDOXOh5FPl3YloSZj1XRB6njcRd7Js5l6UnpCvzWtyi426Hk5jmTQggLdNjpxe2kopmhZEGNJIDEA==
X-Gm-Message-State: AOJu0YzucA+pPxYtzHnid4LxHWkKqvZ8ZKKBRiOPUHw8aGOxzcwTqdNj
 OHNxklX1jhQLW+LKKj2ay1BNWOrL+KmRoxCd/XgG28PZL/d1JNNh/PWNtF0xn1Y=
X-Google-Smtp-Source: AGHT+IGltXn7M8lgem9NF3uPj36AyUIPjXCJ/pZSNYrw57fNzyEmUa39+BIi6QCqJ8mLc2QdDwoB1Q==
X-Received: by 2002:a05:6000:104f:b0:33e:1629:6523 with SMTP id
 c15-20020a056000104f00b0033e16296523mr67375wrx.42.1710156043919; 
 Mon, 11 Mar 2024 04:20:43 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 h9-20020a05600016c900b0033e45c3f026sm6341215wrf.4.2024.03.11.04.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 04:20:43 -0700 (PDT)
Date: Mon, 11 Mar 2024 14:20:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/2] sandbox: select CONFIG_64BIT for SANDBOX64
Message-ID: <5ec7d4c6-e85b-416c-a48b-aeaf8b24156e@moroto.mountain>
References: <4ee938f4-7e75-4348-9237-6d2cbe4ae67a@moroto.mountain>
 <32e53e2a-6269-46bf-93e6-21d616a9ff5c@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32e53e2a-6269-46bf-93e6-21d616a9ff5c@gmx.de>
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

On Wed, Mar 06, 2024 at 09:50:06AM +0100, Heinrich Schuchardt wrote:
> On 3/5/24 16:16, Dan Carpenter wrote:
> > Select CONFIG_64BIT so that we pass the -m64 option (instead of -m32) to
> > static analysis tools.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >   arch/sandbox/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/sandbox/Kconfig b/arch/sandbox/Kconfig
> > index 0ce77de2fcb4..c431da60e8c4 100644
> > --- a/arch/sandbox/Kconfig
> > +++ b/arch/sandbox/Kconfig
> > @@ -12,6 +12,7 @@ config SYS_CPU
> > 
> >   config SANDBOX64
> >   	bool "Use 64-bit addresses"
> > +	select 64BIT
> 
> SANDBOX64 seems only to control the size of phys_addr_t, phys_size_t,
> dma_addr_t.

Heh.  I assumed SANDBOX64 was much more important than it was...

> 
> Please, have a look at symbol SANDBOX_BITS_PER_LONG. It is controlled by
> HOST_64BIT, not by SANDBOX64. Isn't this closer related to the -m32/-m64
> choice?

What about if I just did something like this.  It seems to work okay.

regards,
dan carpenter

diff --git a/arch/sandbox/Kconfig b/arch/sandbox/Kconfig
index 0ce77de2fcb4..ebffad32e94f 100644
--- a/arch/sandbox/Kconfig
+++ b/arch/sandbox/Kconfig
@@ -46,6 +46,7 @@ config HOST_32BIT
 
 config HOST_64BIT
 	def_bool $(cc-define,_LP64)
+	select 64BIT
 
 config HOST_HAS_SDL
 	def_bool $(success,sdl2-config --version)



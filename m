Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68382CF9C64
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 10:22:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1742887FA;
	Sat, 21 Sep 2024 12:22:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C2ZqXLt1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 857588878A; Sat, 21 Sep 2024 12:22:17 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92DA2887FA
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 12:22:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cba6cdf32so24691925e9.1
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 03:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726914135; x=1727518935; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:subject:cc:to:from:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+CbBbaHjvI0d0TGmaP8+RYRPFvKwgoR0hx0MlG3vM5I=;
 b=C2ZqXLt1wvoIKW4YZesOW1oJ30s0ZHxSrIZLyrHbJ0kv6H/2Jt1ANWhZrMor9UmFTY
 7uvxrTxJo73EWZdEVryUKCbwe/hh5R7tLUVNee0SZBiTjDiPAnHIOTCN7oBfAHRfI4+1
 v1s4oy8I49D189UVb+PIFwif6M/uMAotrLT/yeEeSJ6JqCRypYZIJiJsD9BJp9EO7kVP
 eK3GaHuUYyRwhQIhTgjJDhkACnj/OpCdCXUZ+hJ7libzgnMGrWcvapP289ZnJB1DdboZ
 YZuvJGG3H52jW72HUSx61HaeKHUy9O/rfK27CdkTpfC6QS2wll7IzTnfxbEBcng6ahsb
 VraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726914135; x=1727518935;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:subject:cc:to:from:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+CbBbaHjvI0d0TGmaP8+RYRPFvKwgoR0hx0MlG3vM5I=;
 b=sZ5Sj93LMIO42uvnGTY36gcoRLdZf/jB0C5XIroyaqmGMrSA1TThQtiU5m6I44uAKM
 +WMI9t6/LoTJlpcgfd/hC6Bgfu+cKlfikA741XHl1YVOWefnYRbR/XktUkgN1OK9VlOy
 b0EViB0cI2Wezt9ASoCMUM3eIbmKWdc4Xy4I8nNmkwvh7UlrxaCzO3M+DjyAccnzp1D/
 jSDwncL74Pyi9L/fucqdjTyoYoR43wcGZ/CvibxywhLNPtO9or8/FG7HF0lNqh/NT1SQ
 oFPoaCbaaS/A/FeaZTXP0dzO6L7GGzuQ6xWtLIxrd+CaGBW9FlxJHKgaJ02rbaFWF5Tl
 uzTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLh/C0Bh8GBrhlBuDNUjmAxKVT9hL8BNwEDXyNQbTtVuO476H8NkCdU8+UNwq5fXAf7sx/+KA=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8ThgZoQO+sKRrvvfoMigStV3dWtEoZItzk10vHRz14s7roR4+
 kng4pbbNrPEg14N+0RN6cP0kSvTMv6okKAtwS8NrcgZlmTiHnyGZ
X-Google-Smtp-Source: AGHT+IHCWFXwTNKK9EDN8Gw8UwnkITLLYSg3K9Fax1HzLdFbskeiPeSML2w48R24pb2MJvdaSSRAtQ==
X-Received: by 2002:a5d:6e92:0:b0:371:88a6:80d8 with SMTP id
 ffacd0b85a97d-37a422b8184mr3106057f8f.28.1726914134687; 
 Sat, 21 Sep 2024 03:22:14 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7affa701sm47289235e9.43.2024.09.21.03.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Sep 2024 03:22:14 -0700 (PDT)
Message-ID: <66ee9e56.050a0220.ae0a.dd5d@mx.google.com>
X-Google-Original-Message-ID: <Zu6eUrY6tD_1305b@Ansuel-XPS.>
Date: Sat, 21 Sep 2024 12:22:10 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sean Anderson <seanga2@gmail.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Artur Rojek <artur@conclusive.pl>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Subject: Re: [PATCH v4 07/11] mtd: implement support for LED activity
References: <20240920225101.2008-1-ansuelsmth@gmail.com>
 <20240920225101.2008-8-ansuelsmth@gmail.com>
 <20240921121334.530610b6@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240921121334.530610b6@xps-13>
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

On Sat, Sep 21, 2024 at 12:13:34PM +0200, Miquel Raynal wrote:
> Hi Christian,
> 
> ansuelsmth@gmail.com wrote on Sat, 21 Sep 2024 00:50:00 +0200:
> 
> > Implement support for LED activity. If the feature is enabled,
> > make the defined ACTIVITY LED to signal mtd write or erase operations.
> 
> I'm curious, why did you not consider reads in your proposal? I think
> in general as long as you use a device the LED should blink. While
> you're performing a read you cannot do anything else with the chip so I
> would definitely consider the read path as well.
> 
> Also, I would expect the blinking to continue when the device is
> accessed, no matter who is asking for it. So for instance when I load
> my kernel into RAM, I believe it should blink. Hence, why not
> considering the mtd layer rather than the command .c file?
>

My idea for the feature was really for recovery and flashing usage, soo
everything that is initiated by the user or that does change thing.

Example a button trigger an automatic recovery procedure from an
attached USB drive. Having the LED blink signal the user the procedure
is actually working and something is happening.

But yes yours is not a bad idea, I don't think it would make a recovery
procedure confusing, lets see if others agree on that ok?

> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  cmd/mtd.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/cmd/mtd.c b/cmd/mtd.c
> > index 795aaa2b37d..dae90b0e6e4 100644
> > --- a/cmd/mtd.c
> > +++ b/cmd/mtd.c
> 
> Thanks,
> Miquèl

-- 
	Ansuel

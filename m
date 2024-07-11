Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6FBC3DA41
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 05:57:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 227648877E;
	Thu, 11 Jul 2024 07:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Zbs+XLfc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 811FD88763; Thu, 11 Jul 2024 07:56:58 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97C118877E
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 07:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a77c2d89af8so60747166b.2
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 22:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1720677415; x=1721282215;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TjuiH3iKGOIW+8qsbGqoicLVrNNPwdh6Plbid0WJ6+Q=;
 b=Zbs+XLfcUwiF53ZhWQ8ixT4WDOCzVG7r7KYAGY+D8nSwa15CqrGdn/oNpiUx8gZhiw
 +sa7uOavprKlRi/4Kvlc5Qk5vmW6Wkq3Y6FBI7blP2BY5hjihRJ4tNtCfwPtyjg5Jpvx
 u55t0mdKDIArGWmzkXBd95KznPl1j4duV0kR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720677415; x=1721282215;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TjuiH3iKGOIW+8qsbGqoicLVrNNPwdh6Plbid0WJ6+Q=;
 b=M9A1oNh2U6lhr3PEH4lyCxBdYGbYCJeCmptiwyiUjLp3Ea2Rd/VvfaEeOOaNCKtTAg
 I5/ert/PXwY/S+HRdLv1XD2qWTmAdU2CFNNub3Vqiq8CiPLLUANfRsGk/Gr2qf1I4RX4
 5SuUl52NutL3xCJhgkFe3rLjivpbeF8HT1rcWGfQgNGI5/IL13d4j8qZflO//uUXPisC
 XOgMil+CxNu+ro0IGSOp8+bf0ozCnyu0a40RixMng1LefO38xS6PpmVY3TUYPA6L+Eu8
 EiHPa92l1kl7ESjD8sPKH0kWvPKNbcLelpeKhfQm/6bncZfw4NntFUWTm/y4Hzf1c5Tz
 wEvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+bdVKtr+1ffhzGITUZEIk9AbS0iErpAX4OPWsdj8v2vB1jIhj86aX1VWyxhJNUpMC0ycl6bbqi0sPLdmnDh8HOfqWJA==
X-Gm-Message-State: AOJu0YxzlM8COflcMepTGavypvyZQNNgd6eGVBTnPxtoc4NHPgn0SypG
 SPz2epy575Mzn/hMpjqP3rQxCh1SaqNQAdqm2r5txcrZPisShq8scOWJSCy8FvQDZ0YvJs3W+9s
 WAmfOIpLlh0fvEYzO/5skPL/i6OsLDYjOpJjc0Q==
X-Google-Smtp-Source: AGHT+IFLMvwyiDKWRhkpGmZI4qY9kZljGRIHGQIyF7dWnTsWU7x3/o0RApb2i2C1uWUIPopxdGorss65zc7B8h3mBTw=
X-Received: by 2002:a17:906:35cf:b0:a74:78d1:847 with SMTP id
 a640c23a62f3a-a780b89f67cmr488804166b.76.1720677414921; Wed, 10 Jul 2024
 22:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240707082001.20746-1-michael@amarulasolutions.com>
 <20240707082001.20746-2-michael@amarulasolutions.com>
 <CAOMZO5Ddm_2rerosTctkCzcd_+ku7VfsrxfXOEU1NynEOgoQbA@mail.gmail.com>
 <CAOf5uw=wktwcRrPOXmCjehKSsQvzAAhmM4KKsbdxyE6cRVBMrw@mail.gmail.com>
 <CAOMZO5CyFvpa_Fkfjmte9FvPROdNyTS3X1gzweeatu_Evpz2_A@mail.gmail.com>
In-Reply-To: <CAOMZO5CyFvpa_Fkfjmte9FvPROdNyTS3X1gzweeatu_Evpz2_A@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 11 Jul 2024 07:56:42 +0200
Message-ID: <CAOf5uw=_dqeehnj7xk9J_M430nt8OAU78gyTi7eEOTLLn0tqEw@mail.gmail.com>
Subject: Re: [PATCH 1/4] clk: imx: clk-imx8mn Fix nand and spi clock parent
To: Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 linux-amarula@amarulasolutions.com, u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>
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

HI Fabio

On Wed, Jul 10, 2024 at 3:43=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> On Wed, Jul 10, 2024 at 10:39=E2=80=AFAM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
>
> > clk dump
> >
> > It's how uboot is registering the clk in dts. My idea now was not to
> > change it to not impact other architectures.
> > I have a lot of changes but I don't want to address regression and fix
> > and test before send more patches
>
> Ok, I see that 'clock-osc-24m' is already used in U-Boot by the other
> peripherals.
>
> Your change looks correct.
>
> Ideally, we should use 'osc_24m' in the future to align with the
> kernel, but that's a different task.

I will rephrase the commit message

Michael


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

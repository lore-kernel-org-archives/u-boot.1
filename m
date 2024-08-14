Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2766C52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 01:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FBAB8899D;
	Wed, 14 Aug 2024 03:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MBFOnoDf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B83E988056; Wed, 14 Aug 2024 03:17:32 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E338889A0
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 03:17:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6aab656687cso4325907b3.1
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 18:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723598248; x=1724203048; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q3ZTHY9OxTCipuL6VHpARloeXjkcyQsu48GGgpDEwl4=;
 b=MBFOnoDfNLAUO8rMLJq9Q7ex/GAYntREMW4INniH9a447p5nNGocT41Xl1xsliqr2C
 cIjbQtTXHtIp8S01iQhaUpKumzfC1eNMDeSs+PT91nqC5TXwQJShAeelpXjBFEQy1+nv
 UDArnKEXT8KIcd6MY9IgmMgcHZ53rrNBjBAvmc3PpLsFukMOnmrv+PYapzpA7jyHVQjv
 YGUsBKIYs3Pv7p8c75quUkX3B/boXqCPztEW/RcWzJaDh4QGgvPr/QLB3q1GfrVyeLae
 F1659ALZgIEMeOytFI9hwArRZLEWYCP8jJceE7s5vm7rc8pr49Ro0B2oriPvy7qyfQF6
 0mcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723598248; x=1724203048;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q3ZTHY9OxTCipuL6VHpARloeXjkcyQsu48GGgpDEwl4=;
 b=ndzRz9ndL6hWMhALTKqc14OoHJzomGghn9tL7rRAZNwOp4WxmqkI6LgEybVB9TUwsy
 yfbTZkZbVYLI4EOwwbEVVdPupOjxw/lfYacrbD7xTVTaSAowYOvyXJDHt+t52eAaFZ/a
 fNzRPxGvfUn7GlWvcvI0S2ELzNP7O5uKbgaBwqCHQnk3PBScspj+uTwGY7bIAfgY9by6
 sHKhJyrcsczT9BDmNM62VrqI/GnnSwOXVAXgNmsMSCecusp3VxonDyD8SQ8sSiR/JAvH
 tTvNIfIbVjQ1UbPKEPXIGNKtV3qo79gCDDZStUkv2SAJRIibe+meueE2PNteQu1x2YvN
 iLkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUym2cydy2oxbci0hVMDyn5qmafjUQiNxUVmRJ8jGQek/+NH7u6oo2OjEM6C8xbrr5iBjWpe157lFxKabDoXC6oH3DnQw==
X-Gm-Message-State: AOJu0Ywe0rcP9zi0cJjEovX0LWV8sOOoSw/Elta2+CPC2UZ/SM9i3a/2
 xmtoOirJg1wlrFDmNb71Osh9POn9uEsAXyhNlqpFBk+XEPp9w3qtMeuV15HkqT/DhqLEBIQEBiQ
 dt0uGex1bk/vU3wV9xvjB+4izZdvaJEoscg3byw==
X-Google-Smtp-Source: AGHT+IHp1g8C9DAjwBVbBWlOga2Awo3iBaLcHns2IPP/RySsuSc8KLdArpCo2hpUeRzOD344ksMQ+TPL5lXxWRVvb6I=
X-Received: by 2002:a05:690c:1b:b0:65f:96e9:42f4 with SMTP id
 00721157ae682-6ad1d0795f8mr3724767b3.15.1723598248128; Tue, 13 Aug 2024
 18:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240308000432.32369-1-semen.protsenko@linaro.org>
 <a135888e-0d97-1382-c1f9-5bf097a7ffe3@gmail.com>
 <CAPLW+4=f1AcZRde8e+rWWpCm9BtFAACqdWCfMryRBcSFn4OinA@mail.gmail.com>
 <CAPLW+4kBMcO8xOyHYeOqi+npCT651990Efyuanzq8jDgnaqX5Q@mail.gmail.com>
 <CAPLW+4kP_Y4YMtsYpK_uA4B4s-a36UA7ZPZNiV_KYBuDb_qJwg@mail.gmail.com>
 <20240613153310.GM68077@bill-the-cat>
 <CAOf5uwm8ez2MxirkxYQ=VXQOnV9z2s3zeKMPMJnhBa-QRXV9eA@mail.gmail.com>
 <CAPLW+4mN1iOC7nZ6pJttgp2UdO0RdW2yv69P5kPOf_2YE+TO5A@mail.gmail.com>
 <CAOf5uwm+LvC38EUough8RcPzyah01xuibP5rxnTYSam9dfNJUA@mail.gmail.com>
 <CAPLW+4kzPmy4zgjiuay=T2y2ciRRf1ejUNM=tGjj4JCA8AdVLA@mail.gmail.com>
 <CAPLW+4n-WxKM4Kz-uZA5XvBEHNBgwucjnxb5Dk-7TdG3UPFrqA@mail.gmail.com>
In-Reply-To: <CAPLW+4n-WxKM4Kz-uZA5XvBEHNBgwucjnxb5Dk-7TdG3UPFrqA@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 13 Aug 2024 20:17:17 -0500
Message-ID: <CAPLW+4mGGqgpnqSNEDEOT_DO5S3=eB8oHToKZDiEN6__JP36gQ@mail.gmail.com>
Subject: Re: [PATCH] clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE
 present
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Michal Simek <michal.simek@amd.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>,
 Yang Xiwen <forbidden405@outlook.com>, 
 Julien Masson <jmasson@baylibre.com>, U-Boot-Denx <u-boot@lists.denx.de>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
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

Hi Sean,

This series has been pending for 5 months now. If there are no
objections, can you please apply it?

Thanks!

On Wed, Jul 31, 2024 at 3:05=E2=80=AFPM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> On Thu, Jul 25, 2024 at 3:57=E2=80=AFPM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
> >
> > [snip]
> >
> > >>
> > >> If anything, that shows there is a rising need in this propagation
> > >> feature. I'd like to encourage the maintainers to take a look at bot=
h
> > >> implementations, and maybe at least comment on why there is hesitanc=
e
> > >> to accept this patch. It's been almost 5 months that I'm trying to
> > >> push that through, and my MMC work (DDR mode on E850-96 board to be
> > >> precise) still very much depends on this.
> > >
> > > My series is still not ready and I have no problem to go with your wh=
ile for now
> > >
> >
> > Hi Sean,
> >
> > Can you please apply this patch, if it's ok with you?
> >
>
> Gentle reminder.
>
> > Thanks!
> >
> > [snip]

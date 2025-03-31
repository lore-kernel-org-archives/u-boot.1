Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5DFC36011
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 17:00:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66A1681DE3;
	Mon, 31 Mar 2025 19:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="wW6Agw2X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82EB18171B; Mon, 31 Mar 2025 18:03:50 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92B7E81026
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 18:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-30bfc8faef9so46410791fa.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 09:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1743437027; x=1744041827;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6h1YFfjdlFl5xQwzmQn4EO4/swDTxirmhL6bexEnhYE=;
 b=wW6Agw2XSYYRDWjX0yVc6YrzC7lNY6X2kmA3WbPu96gBkerLIdUv2cXebFHb3yOM03
 1U3H+JtJOugvn+BtY5joEhGFi1vg/GF9sL+m8E2EVX/1TQN6QqaNuGXVem4hzBO83z6V
 08oZ0dEO8pt2Gc39Mba4lfl4D6euk8IYoYGbIPwHu7obUH2rSABFzQXDWtQqe/v8IbTH
 rH1qty3omryjLb3RDmJz5cOoLq7P18DLduaaoPqn04rcGYXyvLbYwUazcNUfd/OwuuHe
 3zCpi6OQS7dql3lrDtbsMe7FrqMdMajhWdZR+aknCKTvwumf7NRuLsrmmUV4RqLBh6kS
 /RAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743437027; x=1744041827;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6h1YFfjdlFl5xQwzmQn4EO4/swDTxirmhL6bexEnhYE=;
 b=YuESN/R4PMIIVQhr/W2Z3nzzjfH8pmh0FqaDeEVwThui/uqnt7faB/mKmycS7xHK1l
 8H/VyOrTjEHbloxCypJbtxGb04bO2QJwS7M7JyoGvuCCmpAY4E1gTWQCqhrMpkQ4utSv
 nYAgMtKQsl4Xfvn5y/B7N3eViAtfiumvi0KlYz18cLgL0mpxtSfvjopBqwZRxM9fbjt1
 RCYKEkE/L5NFx7r7jj4G9vq5tIh2Putd2hnVFEhTpZt3nUMV57rrUxCagixP1GIqgdiK
 FP9drO3IayerEdJ1F3mN5pdE4mRbC2renzikgi/nRIrUUSKDIJQ2z2DmtX5JEBgG/tt2
 QBEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsfpfvDiE4kJRF0dNc0N+zSS8292/SHLYuioKhx/f70DHaL47yhc9Qm+Mx5T7qDzZN5SD7nZ4=@lists.denx.de
X-Gm-Message-State: AOJu0YxMwIS52xhajNmMkeig0ShclCNP7jowW3u/62/HE+XaR+04rSh3
 6A+VJ5pllf2LBsVLQqX/pOVUppW32ZiunYAiex3M5pbCaQrOZJWOjWV4L0cAcEXmRtNTgCLgbBf
 +GaBNOSWZpU5hd29uj27HdAa0tbTzaVzqw6aMlA==
X-Gm-Gg: ASbGncsrWaukui55P+kQy3rpUK9HC7Vrdqs0KWTNrtSDQryWHsvarCOxgGF9Tx2EIfJ
 iUVQpMrrHnnJ0YaSyARRPJ+rc248SSxyVii7t9ALzqw4jim+XgIcqim4whmrgnqbt8yduSrUSrA
 pQQh0IhXGc0pyXcyzL47i8QvHquQ==
X-Google-Smtp-Source: AGHT+IFYgpdPJcHSJQoKDamWm7TeiwG1QV/ulIyhKODyWsU/mwLlpKWIrQDjqDrF4RmD6SCkNZQfOgtdQg1JTbmqgQQ=
X-Received: by 2002:a05:651c:1584:b0:30b:b956:53d4 with SMTP id
 38308e7fff4ca-30de022c55dmr27122551fa.5.1743437026104; Mon, 31 Mar 2025
 09:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250322205625.1330306-1-admin@hifiphile.com>
 <68c868ea-33eb-4239-9598-f3d80943a959@linaro.org>
 <875xjppo2c.fsf@baylibre.com>
 <777fde90-8f9d-485f-ae92-6add019bb47a@linaro.org>
 <8734etpmhs.fsf@baylibre.com>
In-Reply-To: <8734etpmhs.fsf@baylibre.com>
From: Zixun LI <admin@hifiphile.com>
Date: Mon, 31 Mar 2025 18:03:50 +0200
X-Gm-Features: AQ5f1JpsLDeGRFrmDigpF-vcWWBKLJui9y038Oh-Dicr3IsYBia7uo3ynPHVuv0
Message-ID: <CA+GyqeafGuaKg3EoFawLvTijvDN-9mF4cYzLE41CNoaZhsbvmA@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: atmel: Add SAM9X60 support
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 31 Mar 2025 19:00:14 +0200
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

On Mon, Mar 31, 2025 at 11:39=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Hi Eugen,
>
> On lun., mars 31, 2025 at 12:26, Eugen Hristev <eugen.hristev@linaro.org>=
 wrote:
>
> > On 3/31/25 12:05, Mattijs Korpershoek wrote:
> >> Hi Eugen, Zixun,
> >>
> >> On lun., mars 24, 2025 at 11:23, Eugen Hristev <eugen.hristev@linaro.o=
rg> wrote:
> > If there is a hardware limitation, or something that allows only one of
> > these to work at the same time, this should be detailed, and have both
> > nodes anyway, with one of them Disabled, possibly two different DTs wit=
h
> > either of the nodes enabled/disabled.
>
> I see. Sorry I misunderstood your point initially.
> I agree with you: we should enable usb0 in
> arch/arm/dts/at91-sam9x60_curiosity.dts as part of this series.

Hi Eugen, Mattijs,

Thank you for the explanation, I was wrong about the gadget host conflict,
in fact on gadget stop it does switch back to host mode. I've also tested
on SAM9X60 that "usb start" works after the ums command is completed.
It's safe to add status=3Dok in board dts.

Zixun

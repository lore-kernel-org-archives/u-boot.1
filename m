Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8DECA0EDC
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 16:21:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 126748353A;
	Tue, 12 Aug 2025 18:21:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fovgrzpA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF89583544; Tue, 12 Aug 2025 18:21:08 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 727D5801DD
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 18:21:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-af66f444488so807991766b.0
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 09:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755015666; x=1755620466; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m2yNvHuo4P4F0p9Gy5LJJIhL8kMMAZdOq/8zQjGDxbg=;
 b=fovgrzpAeTD+gDVpwtbI3YzE5zPN8hLHB2I9etjeCLBY/TnArZcWxMge9Judthl/gq
 YQjP2NNnHPHzSAPBZPf2Ummt/2ql1kMViPll2UbpMiT0SFe/KluPcTRbGUgGeVPCqoF4
 u7WVRkSH2wMD2K+gjPB/V/BqwIllZKImAw1MZoTnco5HDnSnMRSfgZKVjEP79NA7Kydg
 NN22U6AeZ01xKnt2iTLherK3KHNTT2P8JAJLmTDbWx7gGyqnvyrB6zX/TBLOjM/c2102
 O3pquPwDqZr3A7nTQlT4vQNMfE8+5HRztPZj0FdIFyU0GADTRkqPHz8Cav6Ge4EHLjpJ
 M0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755015666; x=1755620466;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m2yNvHuo4P4F0p9Gy5LJJIhL8kMMAZdOq/8zQjGDxbg=;
 b=FXkcjqetu69ahCZMeelAro3N1VB1kzKUUh91s0kCA4RMM4HQX7JssczeRkr0ON2El3
 ZMY8FXoSx8XDBtYTAszO57yleT588IdeofV2Fm3BY8FoyekxsnbHKWEt5V68t2JD7z8C
 VUKhkAX/zP8r72lokwUJEOF5WNDKb33AflpgaHS132MenQWMCMFXJz1VqPvGi11XJ1OP
 f75LXUTtavafN8hb4ePDug6CF5+Zvmk40nIHA7Yq9xNb862zVHN024sMn3hPl1xkMd0s
 xRLPWFu/9UskY5BzLWyUQpmjGiIkOHjeFqmqBr8dSZ5oxkPXSfyoVi6PxXyRP/5f6Tud
 R/QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt71IGbPo2dbmpBUVWnr6cbui5Tn160DVX8kD/UqDLLvL7RJixGDr3UQTY9bDsoNkl7UQXDSk=@lists.denx.de
X-Gm-Message-State: AOJu0Yyv2Bfrnumd6QAm87bC8GGbqoBU5+yxppkAH5XUxR1OvdJ67LZp
 kPgCMjs2Ap5L5BVyjtRhsJT9qBqgZmgDYNa+hAAtAXD6l6rwRtjcZh4t6ChD4vpJaYn7oqQRBMm
 vR8zQ0KRkmh5Nh7A3C28bqLQeRMxctxU=
X-Gm-Gg: ASbGncvBhQAw+cHFPvcdtp3cn9vcAjTvp416Q4xBiBLMezvZytXw5PfHq3fVnFAmdO2
 XPf8qubNUa/v678jhfUBso0RI1AMlE75zE7AoSeNpcXczFMdqRtGnHtMj+KZCe1VIQt4hoMRH+C
 CHpfL3A/odqQn6/zGPHWLZO0sziCf9W3VpHCXv15B4Uay6vlJiAPqdMwd3T6vxQ8/MAWC9oMGVg
 c/wOm2o
X-Google-Smtp-Source: AGHT+IEQpk0MFGQ/B0avR/dSKsTr0mlBVQxgiZbAarYVN/crgEnJAZ9/9Ga0R4qt87xd5fPi92t/h7v4Cm+2iYremmY=
X-Received: by 2002:a17:907:97d2:b0:af9:1be8:c2aa with SMTP id
 a640c23a62f3a-afca3a4b1f4mr30262366b.45.1755015665630; Tue, 12 Aug 2025
 09:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250812153048.2775200-1-andri@yngvason.is>
 <20250812155951.GW124814@bill-the-cat>
 <CAFNQBQzpOej99AE3ZXdTdV7r0o7p6AE8cVeuADHWLkMeTvZRBg@mail.gmail.com>
In-Reply-To: <CAFNQBQzpOej99AE3ZXdTdV7r0o7p6AE8cVeuADHWLkMeTvZRBg@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 12 Aug 2025 17:20:53 +0100
X-Gm-Features: Ac12FXxMf2RAjFUt0j0umfL8t7SRMXMnTgVotgi5fbGQN6uIcS1RQZOTqzZTm98
Message-ID: <CALeDE9Mysz7wR9EX6AJJwMovABcVTeraxOaKD3HomW0w7fUq=g@mail.gmail.com>
Subject: Re: [PATCH] drivers: led: Add WS28XX compatible LED driver
To: Andri Yngvason <andri@yngvason.is>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Tue, 12 Aug 2025 at 17:10, Andri Yngvason <andri@yngvason.is> wrote:
>
> Hi Tom,
>
> =C3=BEri., 12. =C3=A1g=C3=BA. 2025 kl. 15:59 skrifa=C3=B0i Tom Rini <trin=
i@konsulko.com>:
> >
> > On Tue, Aug 12, 2025 at 03:30:18PM +0000, Andri Yngvason wrote:
> > > This is a new LED driver for the WS28XX family of LED controllers fro=
m
> > > Worldsemi and compatible devices from other manufacturers.
> > >
> > > The LED chain must be connected to an SPI output. This driver uses SP=
I
> > > to emulate the required digital signal.
> > >
> > > Each LED gets a fixed colour assigned to it in the device tree.
> > >
> > > Signed-off-by: Andri Yngvason <andri@yngvason.is>
> > > ---
> > >  doc/device-tree-bindings/leds/leds-ws28xx.txt |  48 ++++
> >
> > We have dts/upstream/Bindings/leds/ now, so this needs to be upstream
> > and the driver compatible with that. If the driver is already
> > compatible, we can just omit adding this file. Thanks.
> >
>
> There does not exist a compatible driver in the Linux kernel. Are you
> saying that I also need to implement this for the Linux kernel for
> this to be accepted into u-boot?

You should at least have accepted DT bindings upstream, the bindings
files are now written in yaml so they can be verified.

> I have also written a driver for Linux, but I have no intention of
> upstreaming it as it is much too complex to fit into the LED
> subsystem.

Why is the driver so complex?

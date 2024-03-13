Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2720EC54E58
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 06:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B0A287DE3;
	Wed, 13 Mar 2024 07:46:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="q8HPP4YZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1447A87653; Wed, 13 Mar 2024 07:46:20 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFA6683334
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 07:46:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d28387db09so70403611fa.0
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 23:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1710312376; x=1710917176;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1j9XpSroeNeXpMLmOXDUfo1No5f7/bROcqpX7JdVmIY=;
 b=q8HPP4YZLUevszzIqEJeu3vKFAvh2ClNKu+aaf6YW5KC3t4nDNZWnoaeVjMnu3Ek26
 zad/HX2JaZ/cY0TUW2YUH0F4P0MmxNazHs+ip1UwxxAbJckSLAU05HXE9dnkzIxNwLbk
 sIDwsPB25wSIuvcmwgXMrFSvzC6HF/khJRw3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710312376; x=1710917176;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1j9XpSroeNeXpMLmOXDUfo1No5f7/bROcqpX7JdVmIY=;
 b=glq1PMUr7MYvxIvCJPE4aDs3FuYYr+kXVzQLBodOxIoZf4txhPGV16UgqqmXUcvHS7
 WnDycEzEmn1U+ePFcluUc4NYYK29AptHbldDpraBF3iSWq2jyOpgafczWdcp1U1/rTAm
 fOyS/lX5kasLs2nyV5jXi8cSlVn0BlBgvDv8nM3eX9WdXPbTnNfLAllXcIm/dq5IStYO
 w4aiZRfjXGyrbO8mqBpGAFgYA1e+yNTJ7NRKgFL4V/HTSEgimDmzZuYfoeJ1jD08bIYN
 LwMn56xOUMNTNIz4H2MBZBZmif1jJ+rPNYnlugbw/BXPzNGPrnxucC+y8yAkV27iMNMG
 uT9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6k4raKIFxn/RFjd1uvH0qajAfu6zZN+AkEa5BG7XKjfgTrkJy3imExJyPONFV6JzsmnrQohhjHLuKOgCac3k4O0mYMw==
X-Gm-Message-State: AOJu0Yw0LcYift9y6v7RAGujS0dAPzAge/Q99UbU2BLOLq+EJVIc0R+A
 mUHPcB7E5zZeDFwEP/b3PI1FxUvCd3LGpZJBMBEkBm6l4X/+AMEoI6D528APzOHoBxP+lke8cqL
 uqACgXJ2yBKyO1OsHF73G/HA2KFXlY8KLP2ZqUA==
X-Google-Smtp-Source: AGHT+IExEaN6FGNQKDQy6ELiN5qT7manzHXJH0JaZKZZAFr0iiVBzDn/Jl9sp5a6qbMl7kCd170LRZiE3qOOBpht7+M=
X-Received: by 2002:a2e:740a:0:b0:2d4:5f4f:8ff0 with SMTP id
 p10-20020a2e740a000000b002d45f4f8ff0mr1995077ljc.1.1710312375926; Tue, 12 Mar
 2024 23:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231130112405.92196-1-avkrasnov@salutedevices.com>
 <fa9fc4cc-892c-7c11-877b-330bf173f3bd@salutedevices.com>
 <f79d88f4-0d2e-1d78-065a-5a1f2f2deacf@salutedevices.com>
 <c150440e-191d-bce8-3b99-401186be507f@salutedevices.com>
 <180478dc-23ec-952d-e1ae-6f16d98bd16c@salutedevices.com>
 <969ce8dc-3726-cf66-3241-5eb06f9cb85f@salutedevices.com>
In-Reply-To: <969ce8dc-3726-cf66-3241-5eb06f9cb85f@salutedevices.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 13 Mar 2024 07:46:04 +0100
Message-ID: <CAOf5uw=2hicHHOP1caASJoqmOpZ9vvE3ZMnVQqXxQ0eqbm-CMg@mail.gmail.com>
Subject: Re: [PATCH v1] mtd: rawnand: macronix: OTP access for MX30LFxG18AC
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 kernel@sberdevices.ru, oxffffaa@gmail.com, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Jaime Liao <jaimeliao.tw@gmail.com>,
 Jaime Liao <jaimeliao@mxic.com.tw>
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

Hi  Dario

Can apply this series and put in CI?

Michael

On Wed, Mar 13, 2024 at 7:43=E2=80=AFAM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> Sorry, please ping
>
> Thanks, Arseniy
>
> On 11.02.2024 02:16, Arseniy Krasnov wrote:
> > Sorry, pls ping
> >
> > Thanks, Arseniy
> >
> > On 08.01.2024 21:33, Arseniy Krasnov wrote:
> >> Sorry, pls ping
> >>
> >> Thanks, Arseniy



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

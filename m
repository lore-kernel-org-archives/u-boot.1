Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531D4C87FC9
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 14:25:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52B2B82E26;
	Mon, 28 Jul 2025 16:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d0fdYh9Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EA0D82E52; Mon, 28 Jul 2025 16:25:20 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 840EF82CBB
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 16:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-55502821bd2so5115822e87.2
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 07:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753712718; x=1754317518; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2iN5eSswLbxx8MiTsdnrLn73rrdEcjnprJlx2ONV8aQ=;
 b=d0fdYh9ZPXLSeLRShgo73hv5W0Yjl/mubPjMKfZfNz4mTINq3yPQLzfqBi9kdowWtF
 4NlAlMt0w1jrKOCjBPbzWCWuOO8R1sORnqWX93xDJ4u/29TqPnfuzjCTYortr0SwlZw/
 d/smZcZo9CJyc5MjP9VGykHZNWFQNH36NOpkIdl1x3RG9tST+LQ3KA/KeMGkpcr0Eiif
 pIF0ZccdfLQpLU5SVZx3g2ppVVCa+hzE/I2UiVdS0kdhv6cbNOTSs/nJlpAVBmZuLhe4
 WPf8Ygou35zbf2sBpwMfY7GSk4FQ0h3iltF7RdU3lqD/ya+9DMiikCWkLq6bESfkufKd
 6A0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753712718; x=1754317518;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2iN5eSswLbxx8MiTsdnrLn73rrdEcjnprJlx2ONV8aQ=;
 b=lIEyNvL0UjXgIpx+isPsY9/QZGQsm4b4d4pyDguocwhBknOKCoYou+OJ1ArajEXL3V
 DEV30Cp2O+23kyB/yX33r1b3JuynVze1hfsuSbhl4egh+Myc1BEjUDunwZOzri4ba3gL
 3KezITFloWMRNxBe93z+3Ezy1cBGx/QSi4N3CFTPXQSs/7IGom2+gFdFy4MN5gKVqMbA
 jyLdJ1fOr3aSLocVvhhZQbn4xlfYZFm4pipiuySq9M/pDDke53LiBD17xAOwWilC2vsJ
 WTw7ECEQTz8dm9HvT9GfK1zH0zag2gXQuqNBGuoAJKKa4Nv+JFl/KUeU/8cIFekWFKqD
 d2rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb4BMox3aIR7bnfq/nxC8QHO8J+9jCARtC/CpPC9m6qknOSTiW43RMZlA7OqCJvxCbpC/f714=@lists.denx.de
X-Gm-Message-State: AOJu0YynWqj412q3kVVR2d2fW8HwBWhx2OgfkMJDEaMn0o3I9ASF3HYp
 /OpT0SOn5X00UYF0nXtLwi720AZ1hJQ5p8cLrl+j+jZTcwiAFV59Qrrgo1MURD2ue0hK9Zh4BEu
 SDBiA8r0n68kuUhx3OuMJ1+MDxwfF04Y=
X-Gm-Gg: ASbGncvZFUaNCuCVLTlevp7tXltUPU077Q/wkp59oUpR6rEMbOcz04do4GV+Zgkp1M/
 +cuIc+K3fos7EV477SNeviDwvO5U/wCl0pNgfc9xPXwNTPOcQ7yqQ2p12+73gbcR1l/3JNttLGt
 Tvck4fvbZVzLACNVWVqCIPc1JO0QWk5y4wd0np9aa7RuOHjeeJ+5oUXCfs4dKDxf3r3CabVkrW4
 nZ8kS0o4mUiEybrzLT23eWbGCyRZbp58FJwZFQ=
X-Google-Smtp-Source: AGHT+IEqONhIjdTayHlPRqOegRY+ktZClu5X0N/P3qekmRt5tbXpOtef8CFCF9bKQLjOPKmKnR5cdAZ5nkVGh061Tw8=
X-Received: by 2002:a05:6512:a8e:b0:55b:2242:a9ce with SMTP id
 2adb3069b0e04-55b5f3cf936mr3174130e87.5.1753712717416; Mon, 28 Jul 2025
 07:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250722-v1-fix-imx95-usb-boot-v1-1-dec7f2384405@toradex.com>
 <20250724033822.GE18395@nxa18884-linux.ap.freescale.net>
 <kn34dabjpqywranhgrtpy77bmuviluhzgf2pgtdguqvgwk7e3d@3zud5czxsewc>
 <20250728102923.GA32387@francesco-nb>
In-Reply-To: <20250728102923.GA32387@francesco-nb>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 28 Jul 2025 11:25:04 -0300
X-Gm-Features: Ac12FXwfjHTltTgYH0symNzhafU9UQz2ApWVMhZGc54znYMW2fJUKWymFzuEFkQ
Message-ID: <CAOMZO5DT=ua+vCX5OQq6sx1nfcFjFY0S1hJ8OmNE1RWCQAmxJg@mail.gmail.com>
Subject: Re: [PATCH] arm: imx: imx9: scmi: Fix booting from USB
To: Francesco Dolcini <francesco@dolcini.it>,
 Tim Harvey <tharvey@gateworks.com>
Cc: =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, 
 Peng Fan <peng.fan@oss.nxp.com>, Stefano Babic <sbabic@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, 
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
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

Hi Francesco,

On Mon, Jul 28, 2025 at 7:29=E2=80=AFAM Francesco Dolcini <francesco@dolcin=
i.it> wrote:

> You worked on a similar topic, for imx8m, some time ago, commit
> d175982c207b ("imx8mn/8mp: Allow booting via USB"). What's your opinion
> here? How should we fix this?

The solution on the commit you mentioned is related to the
i.MX8MN/i.MX8MP boot ROM implementation, and it works there.

What confuses me about Jo=C3=A3o's patch is that it was not tested against
the mainline U-Boot.

Can U-Boot mainline boot over serial download on i.MX95?

Adding Tim, as he has been trying to get USB boot to work with i.MX95.

I don't have access to any i.MX95 board to try it myself, so I
appreciate some help here.

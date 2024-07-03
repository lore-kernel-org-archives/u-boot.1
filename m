Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E04CC30653
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 14:38:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4DB188837;
	Wed,  3 Jul 2024 16:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LwEq/q5R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01FEB88842; Wed,  3 Jul 2024 16:38:41 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E49A28883B
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 16:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52cecba8d11so6646620e87.1
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 07:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1720017518; x=1720622318;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w1vUaaaAyDeRRLVTdmWUCUKstCSoxRULRlR/UIRAHQY=;
 b=LwEq/q5RPIKrWuKmxClocsy822FRgAZK8UgbeTukpHTTs4gs+tpNexZEfI8tZOoQjz
 +HttKo6cR1VG7tZaQZGME261Sy855p05RogjFFLlkMCGTIx7OtoaS6963uijszMhdsOc
 K4y0rG22ROFKJM8GoFsaPDkuxyhKEKBMPIpNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720017518; x=1720622318;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w1vUaaaAyDeRRLVTdmWUCUKstCSoxRULRlR/UIRAHQY=;
 b=pktBSyvHdYBIcs/MfTovKtDBGo+uyrFqPhfPQ9pdGcLy8eXbbP9Xt/odSYbNuBclUz
 3z8GO+PdlkFYTspbwyC0BWLsMEhfC7nedAQCPcYXlrk5gma5hD+e3QAF5vleRTe7z2Zw
 /dNxMl5LX/jZWWJHyt5suVaGxc4nO0LKAM5OWXJMqAzZ7PvRYAdBWGJCoYGcdGBEO6nh
 2aMg3oFQfEZbiwsgPdkoDL1ip2+g7623Tz0Zk1aaN4N/nKYC+ngfowBzOyHtiDlKCMOj
 o27Kp95Rz4uIH/EEBuie4nvRm9peiTEqgjsh7YpRtBpePDfOUjUAa+so3XPw8oTq15sK
 jYlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMrdz3m0gvy/U2XYfl2SvWSssbbveyAMkNDElix2C2/3sxZao9VkYlWMEBJbUTnMQKqY4hOucOmCrVYN4ubfMiJjMv8Q==
X-Gm-Message-State: AOJu0Yxp1oBRvqCm0EyMfLIPckqwXZWK21swj95HpilUrRvhMQsyOTMo
 UnMw18dnNeLlje5/oPB7IxY0EHo7GuGdkFZ0UPoLJJjml2hACCTc/fSTRDfqtH00T808Z9fUUYO
 COSkqI7xLcfNaySU9A4j4+sKVQrkmq7GGfAJTkQ==
X-Google-Smtp-Source: AGHT+IGth4/s+dqlJn8v/hwSgN/49mNSIn/hIe5Ajl2NHZ+L72PI2iyYFjIDDUn8QJvDQle2ZQAiztWlkqvONG96w0Y=
X-Received: by 2002:a05:6512:10ca:b0:52c:db04:5a57 with SMTP id
 2adb3069b0e04-52e82686b58mr8687417e87.31.1720017517952; Wed, 03 Jul 2024
 07:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240703090512.92636-1-michael@amarulasolutions.com>
 <20240703090512.92636-3-michael@amarulasolutions.com>
 <CAOMZO5BLx+NPPZTpWajGe75iW+dm7-VE4dkTUeYk4cVvHPFiTw@mail.gmail.com>
In-Reply-To: <CAOMZO5BLx+NPPZTpWajGe75iW+dm7-VE4dkTUeYk4cVvHPFiTw@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 3 Jul 2024 16:38:26 +0200
Message-ID: <CAOf5uwkXCm+Rc4tNzcgrb2kpyxW21uKRPGtkcOaYHUS6eFOwog@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: imx: add mux ops for i.MX8M composite clk
To: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, linux-amarula@amarulasolutions.com, 
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>
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

Hi Fabio

On Wed, Jul 3, 2024 at 3:44=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> Hi Michael,
>
> On Wed, Jul 3, 2024 at 6:15=E2=80=AFAM Michael Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > Upstream Linux commit f90b68d6c8b0.
> ....
>
> > The CORE/BUS root slice has following design, simplied graph:
> > The difference is core not have pre_div block.
> > A composite core/bus clk has 8 inputs for mux to select, saying clk[0-7=
].
> >
> > It support target(smart) interface and normal interface. Target interfa=
ce
> > is exported for programmer easy to configure ccm root. Normal interface
> > is also exported, but we not use it in our driver, because it will
> > introduce more complexity compared with target interface.
> >
> > The normal interface simplified as below:
> >             SEL_A  GA
> >             +--+  +-+
> >             |  +->+ +------+
> > CLK[0-7]--->+  |  +-+      |
> >        |    |  |      +----v---+    +----+
> >        |    +--+      |pre_diva+---->    |  +---------+
> >        |              +--------+    |mux +--+post_div |
> >        |    +--+      |pre_divb+--->+    |  +---------+
> >        |    |  |      +----^---+    +----+
> >        +--->+  |  +-+      |
> >             |  +->+ +------+
> >             +--+  +-+
> >             SEL_B  GB
> >
> > The mux in the upper pic is not the target interface MUX, target
> > interface MUX is hiding SEL_A and SEL_B. When you choose clk[0-7],
> > you are actually writing SEL_A or SEL_B depends on the internal
> > counter which will also control the internal "mux".
> >
> > The target interface simplified as below which is used by Linux Kernel:
> > CLK[0-7]--->MUX-->Gate-->pre_div-->post_div
> >
> > A requirement of the Target Interface's software is that the
> > target clock source is active, it means when setting SEL_A, the
> > current input clk to SEL_A must be active, same to SEL_B.
> >
> > We touch target interface, but hardware logic actually also need
> > configure normal interface.
> >
> > There will be system hang, when doing the following steps:
> > The initial state:
> > SEL_A/SEL_B are both sourcing from clk0, the internal counter
> > choose SEL_A.
> > 1. switch mux from clk0 to clk1
> >    The hardware logic will choose SEL_B and configure SEL_B to clk1.
> >    SEL_A no changed.
> > 2. gate off clk0
> >    Disable clk0, then the input to SEL_A is off.
> > 3. switch from clk1 to clk2
> >    The hardware logic will choose SEL_A and configure SEL_A to clk2,
> >    however the current SEL_A input clk0 is off, the system hang.
> >
> > The solution to fix the issue is in step 1, write twice to
> > target interface MUX, it will make SEL_A/SEL_B both sources
> > from clk1, then no need to care about the state of clk0. And
> > finally system performs well.
>
> Shouldn't this also contain the original kernel commit author's Signed-of=
f-by?
>
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

Fine to me to add. I made a mistake. Let's wait on other reviews

Michael

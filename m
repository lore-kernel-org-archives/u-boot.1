Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7192C4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 20:54:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5306F882DA;
	Sun, 21 Apr 2024 22:54:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rrv4mY+T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A731A882D7; Sun, 21 Apr 2024 22:54:21 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E644882FD
 for <u-boot@lists.denx.de>; Sun, 21 Apr 2024 22:54:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56e6a1edecfso5698410a12.1
 for <u-boot@lists.denx.de>; Sun, 21 Apr 2024 13:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1713732859; x=1714337659;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+wuW4MLHy4LtuA3cPMAkg8YooC1iIFT5v0hRyNaAvqY=;
 b=rrv4mY+TOuwuZ/HAcx6SVwj2q33go3/xLJ74Q9BR9FLJeQ1UGF5uasmomSWGeeiOFG
 g2Hu5g+3BjQt0ZcZ3YdGVC3HdtQ+F9/XIz8OCnCsK3s/RN0A2yodsLyDtIkAw+jEotE8
 CJ0TYMY3c+JWU96vJn+2CqxBdAzXTyxc+BxTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713732859; x=1714337659;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+wuW4MLHy4LtuA3cPMAkg8YooC1iIFT5v0hRyNaAvqY=;
 b=cCjVYzxn82tccszPOmNpEq5HI3lYFghb5xSwxV3tCtd1G+oZymPxtFYmwlplhmDSe3
 D4+Z+2PNC7+NfbNSGmUZlq2VrJ9fC2Qnfe536zieV+9gfDmtoX/virO6RgMZG4TjISuR
 rwf8CUIx8arpLr6AcGAHUJ4uLxuOR4w330yV+rJBHdcEWw89AGJCypQ15emyyEAqFKBC
 SRWHUm1FF8VUna5j+R/PWaUaULnsvBn2gJuP7LXuWrckv3UsgnYfPl7F5R2dRMc+PI8W
 VLv9zeJewlSKc9DAy+GSEJ7/wCxwd5SmMILPpsemUkhx9t2D3X/47rOMJuvJUZ+C+RVg
 +i7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW8NcosQvGMQaS7B67rWI5tTiworBE+Zcab2DDI6HdHi2AbJNEHRSqJB2cDMXKg320rUurpSp7lE1FAPB5P/XmzM/idQ==
X-Gm-Message-State: AOJu0Yzgc0XF+DNLpu6X71CefhmItITQttasPAbNz2lkkL1047cD84Og
 C9/1WNLn0pzyUA+i1iTkWzhZUSvlahUihkcVL3zE2a0oU7ZCOaEmh9AnkoPfyP5gLGCVfcABfzf
 vJafvB7UMfbYFAw60CxKymvqsGNSHC5ndGANkMQ==
X-Google-Smtp-Source: AGHT+IFMffmVZQI5did7b5ERzj3pXda886gSbgBfkwck70XkZtrukP+TzcFjj08+SmIoxH5iuQgY/XNkFFKB8sh69fo=
X-Received: by 2002:a17:906:60d4:b0:a47:31db:d8ff with SMTP id
 f20-20020a17090660d400b00a4731dbd8ffmr6137976ejk.40.1713732858618; Sun, 21
 Apr 2024 13:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240421140745.25870-1-michael@amarulasolutions.com>
 <CAOMZO5DbWbsT==bTczp9b4uHuBR6dPsbsHEfoJTugTp4zwTJjg@mail.gmail.com>
In-Reply-To: <CAOMZO5DbWbsT==bTczp9b4uHuBR6dPsbsHEfoJTugTp4zwTJjg@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 21 Apr 2024 22:54:06 +0200
Message-ID: <CAOf5uwnruzdTfsbMqvU9UEnsL0Y5_xWs8tCsGHCTPAbHbxb=rg@mail.gmail.com>
Subject: Re: [PATCH] clk: imx8mn: add video clocks support
To: Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
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

On Sun, Apr 21, 2024 at 10:24=E2=80=AFPM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> Hi Michael,
>
> On Sun, Apr 21, 2024 at 11:07=E2=80=AFAM Michael Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > Add clocks support for the video subsystem.
> >
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>
> Which target will make use of these clocks?
>
> As-is this patch adds only dead code.
>
> Adding a defconfig that uses these newly introduced clocks would be nice.
>

You are right, I will wrap it and enable only on CONFIG_VIDEO

> Also, to avoid size increase, please protect this code against
> CONFIG_VIDEO or something, like done here:
> https://source.denx.de/u-boot/custodians/u-boot-imx/-/commit/2b3310ef1399=
8dfd03196a0806e03035212b102c

Working on display panel integration on imx8m, trying to progress
merging things up.

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

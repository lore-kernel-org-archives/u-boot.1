Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C93DC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 10:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92E4C8835B;
	Mon, 22 Apr 2024 12:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ajjifd6h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B01588406; Mon, 22 Apr 2024 12:36:34 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCCC88835B
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 12:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a5557e3ebcaso696006066b.1
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 03:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1713782191; x=1714386991;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eiygu8AKnywVY7B+ZAvM6AHVosofb213BcOhYgH5ZSU=;
 b=ajjifd6hgbSeDC45V29Bgs8RRl8FTWWDnYtIiTJ87YbpOv7aK1Hnocv0PG3GNG0n74
 oslFlpnliSpG+jyl7HPaNBf7Klw+X01/h2NTUFU6Tdgrum7MQu+sB7WYFfgaTU1iveqm
 XvOFwDPDkeSOgqypfqQ4pLkRMFG373cEtkM9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713782191; x=1714386991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eiygu8AKnywVY7B+ZAvM6AHVosofb213BcOhYgH5ZSU=;
 b=XJvGilGM/Y9IDTo66B6VmFA3mDEHtSiKTijeUomIt7+HBOFE33kazbcJSDim/lodmu
 T6HnSoDHRgktSHThC48kplmeheZc0SKiwNh/4DwosQd3oCfbZjP2qN9hsZ6rX12oNR0s
 58gbpccCh0iunr8mOc8HiDIjpHnB1Yq7eTNAWawuNFxJt+6fwjCtDSP7yeoDYiVmnWF7
 xxs0VkvLft42zuLFM5CyQq5le4S+kokPMlzYxfK03ABGtXd33lfmRhoZOvtcNBZL0JRB
 E27CWUM6T5jaldl+ge5p0S9lWOBJ7zMJ2I8eKr6T6VHwvSneP1OX97j3qcIsYAuj03E2
 qOiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSnicF+amdJcjfuIRzNKvEqwOkj3TSYoNjf/BJ8p+r3UhEDMJhpjJ+E3dlBwVvKRg2McZGJjR8nQZQeXUBj6ipXAxo3Q==
X-Gm-Message-State: AOJu0Yz8aytpWmhtu4I4TS2gHTZkSMrm2QblAbEtgl6C7KQWjrq43qbe
 Yp5MfQng76lLmn2/BZZLxmKfI9mD+fnJnhv2FKYG2/cGvg7PXHmMtU5FR+HJ9BTsrVq4Eqn3xbM
 V9YtmiuSA4kPPhF4qcpsTBMqGlvsTYWC6hwBodw==
X-Google-Smtp-Source: AGHT+IGGETZFRd2z+zCgTg9DoeTXaKdmTS0Q5ad6grFi9AP/ikTrAjm58QofQAl7JIy2pvRcbG4wpHH7F17AS/nLLgs=
X-Received: by 2002:a17:906:36c5:b0:a52:6e87:77ef with SMTP id
 b5-20020a17090636c500b00a526e8777efmr11283865ejc.6.1713782191263; Mon, 22 Apr
 2024 03:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240421140745.25870-1-michael@amarulasolutions.com>
 <CAOMZO5DbWbsT==bTczp9b4uHuBR6dPsbsHEfoJTugTp4zwTJjg@mail.gmail.com>
 <CAOf5uwnruzdTfsbMqvU9UEnsL0Y5_xWs8tCsGHCTPAbHbxb=rg@mail.gmail.com>
In-Reply-To: <CAOf5uwnruzdTfsbMqvU9UEnsL0Y5_xWs8tCsGHCTPAbHbxb=rg@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 22 Apr 2024 12:36:18 +0200
Message-ID: <CAOf5uwmGtY--s9CNUPVeLYghw=O6+DCpaPUJoBrJnWKkXR7CoA@mail.gmail.com>
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

On Sun, Apr 21, 2024 at 10:54=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Fabio
>
> On Sun, Apr 21, 2024 at 10:24=E2=80=AFPM Fabio Estevam <festevam@gmail.co=
m> wrote:
> >
> > Hi Michael,
> >
> > On Sun, Apr 21, 2024 at 11:07=E2=80=AFAM Michael Trimarchi
> > <michael@amarulasolutions.com> wrote:
> > >
> > > Add clocks support for the video subsystem.
> > >
> > > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> >
> > Which target will make use of these clocks?
> >
> > As-is this patch adds only dead code.
> >
> > Adding a defconfig that uses these newly introduced clocks would be nic=
e.
> >
>
> You are right, I will wrap it and enable only on CONFIG_VIDEO
>
> > Also, to avoid size increase, please protect this code against
> > CONFIG_VIDEO or something, like done here:
> > https://source.denx.de/u-boot/custodians/u-boot-imx/-/commit/2b3310ef13=
998dfd03196a0806e03035212b102c
>
> Working on display panel integration on imx8m, trying to progress
> merging things up.
>

Are you considering if I wrap properly with VIDEO IS_ENABLED?

Michael

> Michael
>
>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com



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

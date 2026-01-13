Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3275AD2F356
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 18:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BF3880B98;
	Tue, 13 Jan 2026 19:16:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ruLsBr4O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E56AE82C7F; Tue, 13 Jan 2026 19:16:50 +0100 (CET)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com
 [IPv6:2607:f8b0:4864:20::1335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30614800AB
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 19:16:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-2b05fe2bf14so12365701eec.1
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 10:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1768328205; x=1768933005;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YOTuSye0BwInli7EdVsR7/GeVHQfKgMqwEfm4d4J1BA=;
 b=ruLsBr4Oia6h357h1ScNHXuzpkqlBwT099X8NvWszNFdcFzKOxh1n+r58rl7tPNwmk
 UzySh12XaLq+yVJKYtSq7ziWphTCzuFuQRgSMn3tRaWjviAIhQHavQesfmgzC+MN20nQ
 mK9UziTNOAfmI18qdmA1WWrtj4eWw2YIpPE1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768328205; x=1768933005;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YOTuSye0BwInli7EdVsR7/GeVHQfKgMqwEfm4d4J1BA=;
 b=olJE9IeYpYGt6RoGrrzh4jA1umRCw/6q2WNG72dTdQXBcmj5y9GpOrJihk9T2uH6iT
 CZ9t4YQjKf/F43wvvYMcrTQuKHxzyO+JWvSXFp8q0rVtVsn052R0fj942vWN4OSEuMKY
 VCPXE3Q+qwaWseX5585C2sUittttVMi/sVug6kfP7xwFTjVowo6zxYyPQSQBUOnrjgod
 Uwton6EBajKnbbepYe2iyHvg+DfgvNd01Q9v8llT6WsbkURowNq4m/nMaYDUFgLWEtDW
 A2jnlAREeVCYxFP2ux7N7g/MvStVKl2/MzfAtg3Yd1suSSt0xRuX0NZviUIsDGAfGINZ
 pmgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUamwA8wbi3B8TPW8FdfYdliPGbPqBohonif7yywOGskUq37grNDVPbKJxX8sqCqhNYoJ7DG8U=@lists.denx.de
X-Gm-Message-State: AOJu0YwM9Ap6EjbmruRNmsP41YyGxY0QloWhsNK8YbE/KVDWNnfp4UxC
 c2huAqH6nP46XwSxR1spee//KtV+ie9XAPLF9+Ob40IKMWCXt6cZ99mDKazsphDY8CDXHfIWKqJ
 DHJD480jv+xw7omx1bxAa81BjA7U4b5XLtlGS0WOmGA==
X-Gm-Gg: AY/fxX6PVWwdjOC1kfd7h7RIJk5Q5L2mdD6SHJ1d+vlXL+T7VKQvJLUGFGiDLLXgHIA
 xRRa9ChBAcWxlhV/nJQne7xlABlZYuwtyaKmrE13fGebazJYQd/TfOg1DZk7f38YVZKHHTwXdO3
 /26C1vphMBUI0E/kDhDa8nT+3AHTQ2Fi1fZQtUXkc/MjHpvn1qbNNHZzYpAyYCvrUMhBrAWLh5r
 nheFURdVY/zXaGc5/gIx/o6zpg4OPW7fqG93Rg7MxLClGNU4i2YA7dCX0/4qrJM8zTKTo1cDi9V
 TgDcd+xwabxTB7bPYQOxSR/zlw==
X-Google-Smtp-Source: AGHT+IEqgC6AjjTCIdHy48QRSPZC5e9SaMO1t48HhpmqUIDz6JUnx/tXjTxkeHe/vo9Vxn1Zt+14rezSrmvHaKqVNf4=
X-Received: by 2002:a05:7301:e06:b0:2b0:5289:8c2c with SMTP id
 5a478bee46e88-2b17d2ba786mr25388677eec.24.1768328205443; Tue, 13 Jan 2026
 10:16:45 -0800 (PST)
MIME-Version: 1.0
References: <20260111082347.1302003-1-michael@amarulasolutions.com>
 <aWYJKl90YEvhVZMV@nxa18884-linux.ap.freescale.net>
 <CAOf5uwmGjw5daQXRcqJzpTsH3xXTGODZRqf1qWhM7Xw2sEHQhQ@mail.gmail.com>
 <DB9PR04MB8461FE81E473E7B5DD8CE557888EA@DB9PR04MB8461.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB8461FE81E473E7B5DD8CE557888EA@DB9PR04MB8461.eurprd04.prod.outlook.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 13 Jan 2026 19:16:34 +0100
X-Gm-Features: AZwV_QhfMkyfm_JJHcJY_Vs1OQkcU-09r89kQDxoa3vefyMxbooOfhSSmpUymXc
Message-ID: <CAOf5uw=jRCiC0rh0a6C2W9M9Dy0cRGUTf5Z_X=kx8cMJh_D2Zw@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] power: regulator: pfuze100: Fix voltage
 calculation and support high-range
To: Peng Fan <peng.fan@nxp.com>, Fabio Estevam <festevam@gmail.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Joy Zou <joy.zou@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "linux-amarula@amarulasolutions.com" <linux-amarula@amarulasolutions.com>
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

On Tue, Jan 13, 2026 at 1:16=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: [PATCH V2 0/2] power: regulator: pfuze100: Fix voltage
> > calculation and support high-range
> ...
> > >
> >
> > I have tested on a new imx6dl design but I can ask Dario to test on
> > some other imx6 board, do I need to include it in the next release?
>

Can you test this series even on your side?

Michael
> Yes, please.
>
> Thanks,
> Peng.
>
> > I will send some other patches end of this week
> >
> > Michael
> >
> > > Thanks,
> > > Peng
> >
> >
> >
> > --
> > Michael Nazzareno Trimarchi
> > Co-Founder & Chief Executive Officer
> > M. +39 347 913 2170
> > michael@amarulasolutions.com
> > __________________________________
> >
> > Amarula Solutions BV
> > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL T. +31 (0)85 111 9172
> > info@amarulasolutions.com
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2F
> > www.amarulasolutions.com%2F&data=3D05%7C02%7Cpeng.fan%40nxp.
> > com%7C52c4909ff9ae46eebeed08de5290fcd7%7C686ea1d3bc2b4c6f
> > a92cd99c5c301635%7C0%7C0%7C639038979850337961%7CUnknow
> > n%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAw
> > MCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%
> > 7C%7C&sdata=3DcLzDG9ZHDZWkzkmyhYMK1Z0elWa1fh6A3sQ25Zh98tw
> > %3D&reserved=3D0



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

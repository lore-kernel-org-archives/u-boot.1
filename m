Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB14D42BBF
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 18:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A84CA8945F;
	Tue, 12 Nov 2024 19:41:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="lre5qR/7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBA4189430; Tue, 12 Nov 2024 17:18:11 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB6B38915D
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 17:18:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2fb561f273eso47532911fa.2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 08:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1731428289; x=1732033089;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gi5GBud3YLjKeG4vr6zEUuj3akeGmIhlUSKAv1JVf6g=;
 b=lre5qR/7fAY4+dCQQFg4Dgo8yB58u/uXtdBpY/MvjhRMi2NP49Pa52ZqGr0y3noSdG
 yIbPoLoBEk0dy461EEuTMGSdxJsexXWEYNpzUG3fRmqSsyI/f6eFIIyoRq2wzrRtXG7z
 pzofgN/eMOhUwx3Iglxu9WN8lTpfWMi2mIPc/OeS55FxsuCCMKaEpvJolOJZAC+s9oDb
 Lkz7xy1Nwthaw1/64hPP6QeKs4KHVJ9euHM2o/eI6qDMzGTm4WeyIb6TP2wnlJxvO/4D
 Bixv7dH68RJtCyvtxdd/1eqjZ5v+lN0JMc+AXKC67FidkXEX59ZIGfqjvQDyXSx7zeo1
 7BhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731428289; x=1732033089;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gi5GBud3YLjKeG4vr6zEUuj3akeGmIhlUSKAv1JVf6g=;
 b=kfDFqrXxDZZqNV5An9126bZ07HiV0HUl56pq6l8ts63SwelYjz5wDzmOXNWoqCA9km
 KjoLRlR8uFs8K8rvnjInzlXXEispRXIVeup1Wvh4yr24AobajfazDYkIOsC5+zOruV1J
 p/ebL+0aox2ZGW4RUBzTKy043KNLSq3l/FcfNiCM4XoerioFPZy81MoVRwpBJsqJ9e5M
 MrDxCs0LMW7MuVR9eQoEjaXBWzFiYonag3m0YqKwgeCZzPvir27DbpGfyAjUYhAY2Py2
 WMDErLOrlrY4p+njlpcir3NiP2eshlcfBeMvdBfKEadXgqPMet7uaqUl6fM1q7efhQsz
 /ipw==
X-Gm-Message-State: AOJu0YzO8tHs3fVzSQ3Amy3skYE+uAzr5HurjGf8p3vT+nVwwNAwIGkf
 6Fhi3+vYWgeZ3fuSJ23vTVXK97XRAQqCK2LciKc9a4PNgQ/TCQCES4BhozsDeZHuSG5gbhZqSi5
 qwqt7MWzOkIgceSWxzO3rFuYkzN9yJgzzx3+9mg==
X-Google-Smtp-Source: AGHT+IHJC3HQFlVpWKMZo9ZCvXo1QW1KbzqRrYWVzM5BIrbSIM/G9uPsKDOASEzz2QA8eRJUMxeHG6tUehjrApQJ3G8=
X-Received: by 2002:a2e:a9a7:0:b0:2fb:3ca8:efcd with SMTP id
 38308e7fff4ca-2ff426a45a0mr19239771fa.12.1731428289044; Tue, 12 Nov 2024
 08:18:09 -0800 (PST)
MIME-Version: 1.0
References: <20241018202715.283011-1-admin@hifiphile.com>
 <2637a7bd-fdc6-4102-80c1-43d0d058cd97@linaro.org>
 <CA+Gyqebjmuiwn0UyUEJK0vh7wimTkGXPeVCrf7feYxzFLF_Oxw@mail.gmail.com>
 <fc0f7532-c260-4b6d-b8aa-5ce2ff2deb6f@linaro.org>
In-Reply-To: <fc0f7532-c260-4b6d-b8aa-5ce2ff2deb6f@linaro.org>
From: Zixun LI <admin@hifiphile.com>
Date: Tue, 12 Nov 2024 17:17:58 +0100
Message-ID: <CA+Gyqebs11SSv2OGtAAg2tO9K_g9kz1uCJK+JG05+0gObgQQCw@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: at91: Implement GPIOF_FUNC in get_function()
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 12 Nov 2024 19:41:23 +0100
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

On Tue, Nov 12, 2024 at 4:59=E2=80=AFPM Eugen Hristev <eugen.hristev@linaro=
.org> wrote:
>
>
>
> On 11/12/24 17:57, Zixun LI wrote:
> > Hello,
> >
> >
> > On Tue, Nov 12, 2024 at 2:13=E2=80=AFPM Eugen Hristev <eugen.hristev@li=
naro.org> wrote:
> >>
> >>
> >>> +static bool at91_get_port_pio(struct at91_port *at91_port, int offse=
t)
> >>
> >> The name get_port_pio is a bit confusing, can you rename it to somethi=
ng
> >> more meaningful, like maybe is_periph_func or something ?
> >
> > How about at91_is_port_pio_active, more inline to the datasheet.
>
>
> I am not sure. It appears confusing to me.
> The pin is either in GPIO or peripheral function mode.
> Being 'PIO active' appears to be something different, or common to both
> options.
> What does the datasheet say exactly ?

From SAM9G25 datasheet, 22.6.3 PIO Status Register

0: PIO is inactive on the corresponding I/O line (peripheral is active).
1: PIO is active on the corresponding I/O line (peripheral is inactive).

"PIO" is the port controller itself but also means GPIO which is not very c=
lear.

Or at91_is_port_gpio ?

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4960DC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 20:05:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 858DF889D9;
	Wed, 31 Jul 2024 22:05:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wnvawfut";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DA1588886; Wed, 31 Jul 2024 22:05:30 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77280889D9
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 22:05:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6519528f44fso46418917b3.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 13:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722456326; x=1723061126; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qGJUSdcXwbSu4RK0RDlRLduaZ0hfUgiMwSTBfWBJ7sA=;
 b=wnvawfutd7NyJ+zxiEbuGsUaF1YGZrXVrLZXKFzthzjsCUSxx7Dv2nU26IwM7P0Rq5
 xD6GxpDcM38iDrq/zWkaXJfO8hbymUNvXLskXmGgw6IIvP1mIVn4lV3ddZb3GLN08X/A
 feIPfatG8K6q8jPWDmV+8QH4IQ7244g0k5U9sizBvp0sXfY1owmp6wbw6pGKebsfzkHX
 74sdCabE0tVPqJhHH2yjgF4HnsqWLdJcRPXpojY4XBbnWEPPaxP9C53N6aPR7EmEAgAY
 KYDlOIhLJV9O3zbmdpaPaE2KIEsr9pxA+8JsqZUwBWnOM6MW2Cg7FsfHP359wEEc6kHf
 ocdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722456326; x=1723061126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qGJUSdcXwbSu4RK0RDlRLduaZ0hfUgiMwSTBfWBJ7sA=;
 b=g8dPIQPr9+sCkCp4qzwylQp8xSm2tNhD3trW1j/hVR+wpCb5s+Ta/0I8DwIVn3POYv
 VC0qIfylfuPUhGZK0O4xLqK8xlsEqegg7ZHZhqPeexqJhqnhA2IKxdxPxkbt4fgqFa6w
 utD1LzWDDPZ6c3lgKcEc9YNTIiW+BeA1SNziHcSPo88MXNQ0569YXykW9ILqX/M7wCln
 LFiyhAFanRpzbw7HTc4y8ou9wLHUna79J1CUlShgSNlAHKmUvPe8ZVBWQwqCW/wYP1ys
 Pt4NTIOhzlwEGaHI9A7lliCkI7dUifWMX44spqmpz/0d7qjOYgVNQzZ9eWK3QCmC2ybA
 K29A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQCjxcDXamyckcaDS8Syt8ozXY83xToVP2kfjXdbm9EDQLoI7hUx3/mun8Bgezq1CSkW1Rto55jwEA1BSceVlK28eh4A==
X-Gm-Message-State: AOJu0Yyc8Lasc2y1NorSvdYR7DLtjtsapxpB6dtHYpb3BPOipNwNZ75h
 NNXN5g506DwfRX/28abZBRAKDYt0mvTnAvLY6EnVoQ/9uF00nr2CK6MhAf4H1qydWXzoN0Mf3e8
 7RGT3R0p5a+yS/s9Yzy6MlnBDo1jvmZRwxNdKYw==
X-Google-Smtp-Source: AGHT+IEKjyF2XdEt9FjdzmDCKdM2DXHPHk/IPaCF811ZyoU3NmvHAacu/JqHEbXj7VnpHvUsHHiaKTt4reXRW3ZCBGw=
X-Received: by 2002:a0d:d381:0:b0:65f:8f77:720f with SMTP id
 00721157ae682-6874ba59975mr2810777b3.5.1722456326260; Wed, 31 Jul 2024
 13:05:26 -0700 (PDT)
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
In-Reply-To: <CAPLW+4kzPmy4zgjiuay=T2y2ciRRf1ejUNM=tGjj4JCA8AdVLA@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 31 Jul 2024 15:05:15 -0500
Message-ID: <CAPLW+4n-WxKM4Kz-uZA5XvBEHNBgwucjnxb5Dk-7TdG3UPFrqA@mail.gmail.com>
Subject: Re: [PATCH] clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE
 present
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Michal Simek <michal.simek@amd.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, 
 Yang Xiwen <forbidden405@outlook.com>, Julien Masson <jmasson@baylibre.com>, 
 U-Boot-Denx <u-boot@lists.denx.de>, 
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

On Thu, Jul 25, 2024 at 3:57=E2=80=AFPM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> [snip]
>
> >>
> >> If anything, that shows there is a rising need in this propagation
> >> feature. I'd like to encourage the maintainers to take a look at both
> >> implementations, and maybe at least comment on why there is hesitance
> >> to accept this patch. It's been almost 5 months that I'm trying to
> >> push that through, and my MMC work (DDR mode on E850-96 board to be
> >> precise) still very much depends on this.
> >
> > My series is still not ready and I have no problem to go with your whil=
e for now
> >
>
> Hi Sean,
>
> Can you please apply this patch, if it's ok with you?
>

Gentle reminder.

> Thanks!
>
> [snip]

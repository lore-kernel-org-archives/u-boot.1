Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B679BC87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 09:20:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ACB5843E3;
	Thu,  7 Aug 2025 11:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UqHnb+9L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4836884496; Thu,  7 Aug 2025 11:20:16 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62330843E2
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 11:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b34a8f69862so547761a12.2
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 02:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1754558411; x=1755163211;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OcrpEC3QnS+3pLwF76NPDI+tMgDlWZBeFpWPZATf+JQ=;
 b=UqHnb+9L57nF68fV8cesHYBBSByDz6xzmCxkF1yvRTySmscJWbWcUR1QasYF5j6xLq
 AfGxCGAyoCVK7IolEyg3shilW9Rb+PVvu8lhE++LXChnDHKFGf3c5DwwM1hYvqauWWVZ
 MwYcLRqUcXM9hUUMJpXpECONYGug39hgJwZM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754558411; x=1755163211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OcrpEC3QnS+3pLwF76NPDI+tMgDlWZBeFpWPZATf+JQ=;
 b=ANUy+dr+kfh2aIR2tUednd4Z1K4La/BUGpxPhGizBRJ8BqF6X3DrOBAdfEEXHOg6/Q
 yAvxqybHkLy4opzAugWl5Obej9xCbUi0eIiYmn1r9ErDzfjkNJBtpF2fPUVAXJ3o9q9f
 mvsWw1bfynklOrLYyLnmNTjnww7vNdde/jAAP3Cu1DAgC87BTAgxJV75nZBPvcz5WlG9
 ee1jMzJCnFRQo7BTs0PSUrQXKKXbS7CRF5wJ26kOyMwM517F1p4PUDIVyzPaNMXqxSsR
 laLaeKZdGk3LQi1ygQwoWvDCy8LUbPVFGebG6pkzONUMMdu8ZSiSNf2TAgAl2Z6CShaw
 hO+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5LOUnP979CMS1fTIyOqsRmMRwXuym+tbvESWKWVHxEwhsCo/9p0lBy69D20khwL8JVnXxgN4=@lists.denx.de
X-Gm-Message-State: AOJu0Yxx7ghFp2rzrOmS3HIeJFjc3DB4Ykek7Eye99wnF5ODEYX0eeL3
 EFt+8cBmByvC19TEuqra2tfcus7AKKcKuSKqpcUxZI4nU27wxbNlpOL/IcM9q2IIMdv0HVJ+3bz
 4RnqAOe/VW5ZmmqQCwTZwtCx/oaZ0QoDpjbTInrgqOeFpxCWqXIlW9rh/fw==
X-Gm-Gg: ASbGncuR+Zfeguq8Cebgb1Xijy84SMGOvFHqPM96p8Nt9ls4J4Cvze+I8eVWj3/zqGn
 N1bjAnnRORPr9wEwMatlBYE1hGcg6JJG7rp7w73T3Qn0WducnQUP0b755+gkEBmwd6o2c0Ayqju
 T5307v7RHr3JMUcmt09+wMj4zfYphSzi2j9nyAcufr1wpoQEb49kPUbmcBdE7NlL3bZwYv74Z6k
 6dBfSJePRhJ4OAYO2xgSNYu9fQgnfgr8MBMIiMtG0pgH/wUtMY=
X-Google-Smtp-Source: AGHT+IGLwZhO6+FVS+FdUqswFt33oRn/rEBA0kzAnMidHT3CKCVaLe/YlFpd1j6PIONAl0X0bG0Rk899D0sDrVefwGk=
X-Received: by 2002:a17:903:b86:b0:242:9bbc:3645 with SMTP id
 d9443c01a7336-242a0bfe727mr63324925ad.55.1754558410743; Thu, 07 Aug 2025
 02:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250807-pinctrl_nexell-v1-1-6f49a0656510@linaro.org>
In-Reply-To: <20250807-pinctrl_nexell-v1-1-6f49a0656510@linaro.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 7 Aug 2025 11:19:58 +0200
X-Gm-Features: Ac12FXyDxgSyBzqtRFG3Q0n4Weef2-9jwjTzxiZgXIH-5843VWoJ2LxfBmHfvLE
Message-ID: <CAOf5uwme53zTzVLe08NrFRqVudNYAXouJ2ggvxCjx49iksm6Pw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: nexell: Cannot test unsigned to be negative
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Stefan Bosch <stefan_b@posteo.net>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Andrew

On Thu, Aug 7, 2025 at 11:17=E2=80=AFAM Andrew Goodbody <andrew.goodbody@li=
naro.org>
wrote:

> In s5pxx18_pinctrl_set_state testing count to be negative will always
> fail as count is unsigned despite receiving the return value of a
> function that returns an int. Change count and idx to be of type int to
> allow the test to work as expected and remove the need for any implicit
> casts. Also change pin to be u32 which is what all called functions
> expect.
>
> This issue was found by Smatch.
>
>
Nice to have the link to the tool. Is it possible to have it on CI?

Michael


> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/pinctrl/nexell/pinctrl-s5pxx18.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
> b/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
> index e7d0994f29e..a6ae5764fbc 100644
> --- a/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
> +++ b/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
> @@ -130,7 +130,8 @@ static int is_pin_alive(const char *name)
>  static int s5pxx18_pinctrl_set_state(struct udevice *dev,
>                                      struct udevice *config)
>  {
> -       unsigned int count, idx, pin;
> +       u32 pin;
> +       int count, idx;
>         unsigned int pinfunc, pinpud, pindrv;
>         unsigned long reg;
>         const char *name;
>
> ---
> base-commit: 3526f990b77fca1c933f1d8b24eb9385010a05bf
> change-id: 20250807-pinctrl_nexell-bc6669ff52e9
>
> Best regards,
> --
> Andrew Goodbody <andrew.goodbody@linaro.org>
>
>

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

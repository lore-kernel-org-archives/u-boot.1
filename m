Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2C0C2BA1A
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 17:31:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E99418840F;
	Thu, 20 Jun 2024 19:31:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZUstsbBL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44F098840F; Thu, 20 Jun 2024 19:31:28 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D99FF8834D
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 19:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57cd26347d3so1250966a12.1
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 10:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718904684; x=1719509484; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XhSQLDv6OrGOQZ+j+MSEXTP5VEbA08Gi3lUsxAX5dT8=;
 b=ZUstsbBLN1/3mb1lkj/abI4+DVOkiCtIcDAi6dpaTAnZklTNOzOsYul+hTt+0FEIpL
 HAm94gsedSrWGFWKulFBn3j+TSDYIa/5upT0ih3SCwdN5Iy14OwkWvKtmT7Dwj9dNBsS
 gOnz7Dq8qGyePJX4jXv9zBLSCFzS34+PjHIbvNaGm8DMcebRIVr66MMbDH8fGrH2vWEz
 nPwDsEV14Qzvo5TROJbisUNR23rZcbheq08PpfuAyqpvJ9EgBd2GSW3Xrh2xaXEYdoUs
 ljyF9Olg4yEkyE12u68beLyzKQgwW3dtoVsEMfYa81shiy3QiUVep3Tg6lHpZAcUA2HH
 oswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718904684; x=1719509484;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XhSQLDv6OrGOQZ+j+MSEXTP5VEbA08Gi3lUsxAX5dT8=;
 b=cW3CrArSoTgqaYYNTiTPTdhb8Jh/Gmf5JV08JbaZ3LMl4xaj50Y7tH7w0NyJcHV4Jx
 ctvOs0HVNGm17VkqbHwBKRr51yt6vtKG3dSsp/V5HEe0C1tItZi9vDhN7ZsQqPD9kmgp
 AGUqpAzMCRXbYvaDVGnHEEXu6WEtNybwydL9evBN5QvCx5LhrArofzTdKoYuDhNm5srh
 jKLdfc48wQQ6Kb4O+/jyMNXjW+vN2QOVMmVkuOxBh30LgyBv7z3ouRZPfWIBsVOsvG7c
 8yyfL6u9/+b75tPnZsqG/I+EvVHtic0/CDsH3qCOk3ThbUM7tN3IQb3eDZx7zeWopHUn
 P6Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJumQAdR6NAJAWvDdfxMgxn68ajziEQYPJWkx5DOhzyHDeF1XYYSInIi+1T7v9m764iFDcMHyUacFz9pdC5qLFwyH9qA==
X-Gm-Message-State: AOJu0YxSam0PPcXVC71fAs0U2bCse0nlVf+8D1sqaCr6EXTuAh35ZE56
 VzrC+yUBlacFR8f1oiZOPLbRuvSPSJDf3YLpLoxFP+qQy7rgPhPLA6f7rlITx8e7xTgihJCYP7W
 +IHmuGuu1LCD6aU080PqcZtC806A=
X-Google-Smtp-Source: AGHT+IFQWEpXFB+t0WdgDWpYYCq1IMo5yva/f+M89EZgQqq6hyrV04xGR9HKnDbldLq+TnyXLcEj+cl3zhwFj9Fdl68=
X-Received: by 2002:a05:6402:1289:b0:57d:10db:488e with SMTP id
 4fb4d7f45d1cf-57d10db4895mr3249271a12.30.1718904684045; Thu, 20 Jun 2024
 10:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240619230400.8459-1-ansuelsmth@gmail.com>
 <20240619230400.8459-5-ansuelsmth@gmail.com>
In-Reply-To: <20240619230400.8459-5-ansuelsmth@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 20 Jun 2024 18:31:12 +0100
Message-ID: <CALeDE9O2p8m6cqZ5pk4ojv+tt=+fpPZEB8Vthskm=cqi99ne4g@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] led: status_led: add warning when an invalid
 Status LED ID is used
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Dmitry Dunaev <dunaev@tecon.ru>, 
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, 
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 20 Jun 2024 at 02:51, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Add a warning when an invalid Status LED ID is used to make the user
> aware of bad configurations.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/misc/status_led.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/status_led.c b/drivers/misc/status_led.c
> index 2b904bfa9c2..7912b4a9448 100644
> --- a/drivers/misc/status_led.c
> +++ b/drivers/misc/status_led.c
> @@ -105,8 +105,10 @@ void status_led_tick(ulong timestamp)
>
>  static led_dev_t *status_get_led_dev(int led)
>  {
> -       if (led < 0 || led >= MAX_LED_DEV)
> +       if (led < 0 || led >= MAX_LED_DEV) {
> +               printf("Invalid Status LED ID %d.", led);

I think this needs a \n to ensure what ever the next message is it
will be on a new line.

>                 return NULL;
> +       }
>
>         if (!status_led_init_done)
>                 status_led_init();
> --
> 2.43.0
>

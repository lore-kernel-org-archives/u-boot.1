Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA40CF9C5B
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 11:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45A3F88413;
	Sat, 21 Sep 2024 13:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JeYxpIfx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 235A58839A; Sat, 21 Sep 2024 13:14:52 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A28E88646
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 13:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c44e1cde53so3578685a12.0
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 04:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726917288; x=1727522088;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RSrKZ6gunJR4O/nUI8kXvl5zy0tLfkDX5/intyCYe7Q=;
 b=JeYxpIfxY/1u8WOlHXQC149/2gpKAkw93k986w7Z9VhOxVhlWkUuwWSWw1+uNvuWFa
 5GBHuSVhd7jchW4H3kEdgYfcSJke41aMi0ui8uzW9XQKJ721+rdFbcpSUr1ASt7722Me
 Zt8vGJU3E7tPwkVvjdeBeQXR31+X62v57zlPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726917288; x=1727522088;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RSrKZ6gunJR4O/nUI8kXvl5zy0tLfkDX5/intyCYe7Q=;
 b=MnhJa/vHWasq2RkQ8Ylfab2ZBg16nhahNtLZuPcX0uNo4QjlWNz+cL15b3f6dSgGoB
 ud5D5BFbsCYfxsRMtBVN6TLNdiMtPWwj9quKtSaxhsWddavTErbSoAH00WePeC18SSMO
 2BaEFtvAoAnaBbHH7+chV8FX5hjj4PyfBGFKmaD2ubpsmNT0SyUMpcsjqEWtfglTtHQG
 HkUvtK9F6Cwq7QfY5WmNg/U3YvKuk8SMmsdeUXzlql87fx9/MAHACOIAQ+C94O+0dr3/
 +yQqrnqG17wuHx8bg7jNJ+/YbJCFPToKqQJYgzC+KG0a8kFOIJuZoialKu/pcYCXujOQ
 iWsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN6xXt8IwT2mdR/3NQjHQGwW+HKi/b7xb0Gjg7AbrEF+ZlwnCiy/sqKUiLASQKZ6sLdLuAx0E=@lists.denx.de
X-Gm-Message-State: AOJu0Yxm/t8awDc5PSsJ+dkfmPLA4jP03r0LfayNEyls9l+Qu6fUNR/L
 drxZzULYdFih7rr4aJwnuTHT51O7UIhwK2lG/r6KK7MImSSPjV9DDwHMau4WCCWrMAWOVyOdiqL
 mDQs04BxM4JzJO15UpBaSvSAke4bYRGajp7spNQ==
X-Google-Smtp-Source: AGHT+IGYbQlj1lFv1KhCIEawy1UIUXrw5bfjz8t/gPjtcd9xDUvv5LhiHoh5WFbxTdBYMfWq7uMnKKlwY0qltpRNz9I=
X-Received: by 2002:a17:907:c7e8:b0:a8d:2faf:d329 with SMTP id
 a640c23a62f3a-a90d4fe01d6mr543007066b.2.1726917287582; Sat, 21 Sep 2024
 04:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240920225101.2008-1-ansuelsmth@gmail.com>
 <20240920225101.2008-2-ansuelsmth@gmail.com>
In-Reply-To: <20240920225101.2008-2-ansuelsmth@gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 21 Sep 2024 13:14:36 +0200
Message-ID: <CAOf5uwm=tNC_avNj8U_AfxqMq3BJsSrsW=wfO4TnvjcTmA1MRQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] led: toggle LED on initial SW blink
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Sean Anderson <seanga2@gmail.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eddie James <eajames@linux.ibm.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Yang Xiwen <forbidden405@outlook.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>, 
 Alexey Romanov <avromanov@salutedevices.com>, 
 Martin Kurbanov <mmkurbanov@salutedevices.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Artur Rojek <artur@conclusive.pl>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, 
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
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

Hi

On Sat, Sep 21, 2024 at 12:51=E2=80=AFAM Christian Marangi <ansuelsmth@gmai=
l.com> wrote:
>
> We currently init the LED OFF when SW blink is triggered when
> on_state_change() is called. This can be problematic for very short
> period as the ON/OFF blink might never trigger.
>
> Toggle the LED (ON if OFF, OFF if ON) on initial SW blink to handle this
> corner case and better display a LED blink from the user.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  drivers/led/led_sw_blink.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/led/led_sw_blink.c b/drivers/led/led_sw_blink.c
> index 9e36edbee47..9d9820720c6 100644
> --- a/drivers/led/led_sw_blink.c
> +++ b/drivers/led/led_sw_blink.c
> @@ -103,8 +103,16 @@ bool led_sw_on_state_change(struct udevice *dev, enu=
m led_state_t state)
>                 return false;
>
>         if (state =3D=3D LEDST_BLINK) {
> +               struct led_ops *ops =3D led_get_ops(dev);
> +               enum led_state_t curr_state =3D led_get_state(dev);
> +
> +               curr_state =3D ops->get_state(dev);


The led_get_state return  curr_state. You need to use a) led_set/get
state or them from ops

if (state =3D=3D LEDST_BLINK) {
        const struct led_ops *ops =3D led_get_ops(dev);
        enum led_state_t curr_state =3D ops->get_state(dev);
        enun led_state_t next_state;

        switch (curr_state) {
        case LEDST_ON:
                sw_blink->state =3D LED_SW_BLINK_ST_OFF;
                next_state =3D LEDST_OFF;
               break;
        case LEDST_OFF:
                sw_blink->state =3D LED_SW_BLINK_ST_ON;
                next_state =3D LEDST_ON;
                break;
        }

        ops->set_state(dev, next_state);
        return true;
}

Michael

> +               /* toggle led initially */
> +               ops->set_state(dev, curr_state =3D=3D LEDST_ON ? LEDST_OF=
F :
> +                              LEDST_ON);
>                 /* start blinking on next led_sw_blink() call */
> -               sw_blink->state =3D LED_SW_BLINK_ST_OFF;
> +               sw_blink->state =3D curr_state =3D=3D LEDST_ON ? LED_SW_B=
LINK_ST_OFF :
> +                                 LED_SW_BLINK_ST_ON;


>                 return true;
>         }
>
> --
> 2.45.2
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

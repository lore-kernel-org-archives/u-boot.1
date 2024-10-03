Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BE5CF34A8
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 12:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9483D88815;
	Thu,  3 Oct 2024 14:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gxHmaKcu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AE0188936; Thu,  3 Oct 2024 08:22:38 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB568897F
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 08:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c87c7d6ad4so730644a12.3
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 23:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1727936554; x=1728541354;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x4vbt38f9q74p+/0onqxlJWxFqdFgbs3yzhbkFZnUdw=;
 b=gxHmaKcuaZu/0R27FKSg2cSNPZ7dQbdJZPs97C/AroMtIPpsREyCxwt0BKADUlbpU2
 xB0A6f7i1WSP9ZPP0XyS9WXQrO6JgQYPQq3VeVYTT0bX9AiueVoUadZ3n1kC7BD4XBw9
 IRlI5ytj5BnwAforOk0GXaI7AzWzSWTEtB5Uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727936554; x=1728541354;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x4vbt38f9q74p+/0onqxlJWxFqdFgbs3yzhbkFZnUdw=;
 b=LjbIGiHYiJpVOuI3xYizZuxo7HMZPNRwnVKEygxTQhzFGLIBPiX314gZR8ji6jq79Z
 JO0YfnpbKSbVWwfu+JcaLYmHDNYv903m3XcSuatQbwltMUB5qgxBnuUlE6UeSkEu/fFa
 d9ZZ7pSP0+3eKPwseTM4trOqEZP3TsOkMsLB4Mae3grGoUSq9suOXW4tx9pt4Gg1zLt8
 pDsJ3li189bUy7M2e0dq4gnjv2Bb9QgY0E/BVEnDKPwty4rj0CUpIDc+Q2VCeO/722XE
 vNQYg8r+4eou/eIOff9sUQ3vXVdITMNzptB1Q+evkWvUNHlHfBICWo68HdFqK+2i4tF1
 KyZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkDKCH3mkmQ98xGzAxAlyCrLx6xNo6aSR6GH+AN4QVZwufGt/SNSKQOOx3BW2Jn24yzYvwEfc=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7i5kPtcQFO5/GVSXwFIwMlw1OJ3TUmFbWyumU6Q6r4wl2n6h+
 3BYGc0jNS89Z+sNioWFLrnoadoDPooVuDcAxKQ85A3YwB72jrcgrTp05DYDOy0mD+HQ0kZA90U4
 0TCI+Q1TQv2qzEOfVHbMre80DH/reXrE/bc/7FQ==
X-Google-Smtp-Source: AGHT+IHHzdzda8oZbsuWMg7It4BYE9nJIDl17Pjp7ey5X1ykqT0swYfZwFzEmwywU0Py9NfKZ883DjLoi4wKJFpemr8=
X-Received: by 2002:a05:6402:378a:b0:5c8:8b6c:bdd7 with SMTP id
 4fb4d7f45d1cf-5c8b1a36975mr4407184a12.18.1727936553849; Wed, 02 Oct 2024
 23:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20241001122511.8832-1-ansuelsmth@gmail.com>
 <20241001122511.8832-2-ansuelsmth@gmail.com>
In-Reply-To: <20241001122511.8832-2-ansuelsmth@gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 3 Oct 2024 08:22:21 +0200
Message-ID: <CAOf5uwn0JiCbJEZ4COMDKMwLbGxcN__8=wW404w=Xat4=T2tnw@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] led: toggle LED on initial SW blink
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Alexander Gendin <agendin@matrox.com>, Yang Xiwen <forbidden405@outlook.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>, 
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>, 
 Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, 
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 03 Oct 2024 14:51:36 +0200
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

On Tue, Oct 1, 2024 at 2:25=E2=80=AFPM Christian Marangi <ansuelsmth@gmail.=
com> wrote:
>
> We currently init the LED OFF when SW blink is triggered when
> on_state_change() is called. This can be problematic for very short
> period as the ON/OFF blink might never trigger.
>
> Toggle the LED (ON if OFF, OFF if ON) on initial SW blink to handle this
> corner case and better display a LED blink from the user.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/led/led_sw_blink.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/led/led_sw_blink.c b/drivers/led/led_sw_blink.c
> index 9e36edbee47..06a43db340c 100644
> --- a/drivers/led/led_sw_blink.c
> +++ b/drivers/led/led_sw_blink.c
> @@ -103,8 +103,21 @@ bool led_sw_on_state_change(struct udevice *dev, enu=
m led_state_t state)
>                 return false;
>
>         if (state =3D=3D LEDST_BLINK) {
> -               /* start blinking on next led_sw_blink() call */
> -               sw_blink->state =3D LED_SW_BLINK_ST_OFF;
> +               struct led_ops *ops =3D led_get_ops(dev);
> +
> +               /*
> +                * toggle LED initially and start blinking on next
> +                * led_sw_blink() call.
> +                */
> +               switch (ops->get_state(dev)) {
> +               case LEDST_ON:
> +                       ops->set_state(dev, LEDST_OFF);
> +                       sw_blink->state =3D LED_SW_BLINK_ST_OFF;
> +               default:
> +                       ops->set_state(dev, LEDST_ON);
> +                       sw_blink->state =3D LED_SW_BLINK_ST_ON;
> +               }
> +
>                 return true;

I think here error is not take in account. Is somenthing that we
should care? and if not we should
warning the user?

Apart of that
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

michael

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

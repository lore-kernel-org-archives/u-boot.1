Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3439CD98D3
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 19:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14F6E84005;
	Thu, 13 Nov 2025 20:33:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MFAIrQMi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9698284006; Thu, 13 Nov 2025 20:33:35 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 417B783FF7
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 20:33:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-343d73d08faso1245874a91.0
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 11:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763062412; x=1763667212; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nZh7kmB5dPDTKUVY07k4gXfS+J6YQsFwrHKZB2vCxIk=;
 b=MFAIrQMidSwCvLgCB3wMrDYkqdreKhh7tU5mVCnjiJljxZdeLVNs+LOEv6Am1X7rTr
 r2l6621O2SiloJXI4xyOl2KxZf3PnxkYuYu7upR84ed2lhQAq9wFYhC7Wka8zKpw9INj
 vBYdzBq754MTEEs2a5iDEapEqu2mCYJRVIaRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763062412; x=1763667212;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nZh7kmB5dPDTKUVY07k4gXfS+J6YQsFwrHKZB2vCxIk=;
 b=s2wrnirttDzskFylRdmXBbsO7rr6R+b6SgXZUPGjUKliyu9mi1BlI7azg7r4ofk7PC
 AFuWW4ZOGg+6z5Oju2MvepJzGZymgUP2NlCkFFW+LM2cofJojpvoo5QqD4+CCv1rjM6K
 vol2Co8joZ2ETAbNYEy/GEEJ/RijRsRhe5kgMUjokMzuYiki1/ZTosTW5Olpl1k/v78Q
 WK2/Dw70U7Ul2X067+7whscBBr6+rJWkXNfUOYjYCRRvA7EvFMoChxytTYkAloq0k75H
 Vib1MHKfPtsp44IaUl9JYyaEvLt8TrO0Zv+af9bifjEKB7YmuUpsrkiHuf3kQoDrRKyo
 MH7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1MBT2rvxb0QKDjL6LcpLqmiTU6avWaVQgeK/Tz1jAOrol1YhHgzYFrs1q7l8uqV3UXENuCHk=@lists.denx.de
X-Gm-Message-State: AOJu0YzJCoHDGsBf7H7+aKkF8ioBuEZYEjyfTj6WxT786n3EURjDmP1a
 he0/RWz+idj4JgbjwBE0uoK5ArB9wtSdTSv/Z2hz2+alzhIRRhmmLZB4c6Xdwi/yifNMh5zpKiT
 FKhDOhm+GLwfl19hYJg30ffs7YUKL8y/yvf3Qj3Un
X-Gm-Gg: ASbGnctPFbwYiY6d7c3L9qMtq5MFSm43qCgyRs1tE13K5HNcvKNHFZ4VqBkXqj2NHwg
 u9D7OzeObFbJwF2vbWB25BUnTnyS0pbNK3I2GA5U8k6f7VjoJggpXVCdJiyOlpXzTSht5Oexynu
 nyWO0RmWi2odSCHc+VrQn02d2uqi5r5DrvoNl7krHVFTr3DbaH9uWjOfO/f+En5io9nPGwOy4i4
 Jr8DGsLL/xgMO2bmFIuvrjeHB5mqQbL823kDwnW/gSowurDWxvKKiWIbRrTIG8bJKiVKw==
X-Google-Smtp-Source: AGHT+IF3xDR+L0YMfmr5yxUE1HqWnWmFB3YlhFc0jyPBikzh4IkmPHMUftj5OWVamBzWczE+KJw97KIx+UKOYZMIUUg=
X-Received: by 2002:a17:90b:5905:b0:343:7410:5b66 with SMTP id
 98e67ed59e1d1-343eac9cd2cmr5191683a91.11.1763062411672; Thu, 13 Nov 2025
 11:33:31 -0800 (PST)
MIME-Version: 1.0
References: <20251112-led-old-dt-v1-0-2892d49517db@cherry.de>
 <20251112-led-old-dt-v1-3-2892d49517db@cherry.de>
 <c10c2b6b-5daa-4128-aeae-977bb0f72be9@cherry.de>
 <20251113174622.GL6688@bill-the-cat>
In-Reply-To: <20251113174622.GL6688@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Nov 2025 12:33:04 -0700
X-Gm-Features: AWmQ_bkwu9YRbhRbwJJQGG1VMH99PQbtE_EYoQwJAIFbLysuTneokCgrRJqCq6k
Message-ID: <CAFLszTg6BMiSJteuJ1yBZ7HYng5CjbX0rcz5oY0W7hsv644yQA@mail.gmail.com>
Subject: Re: [PATCH 03/11] doc: cmd: document the led shell command
To: Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>, 
 Ziping Chen <techping.chan@gmail.com>, u-boot@lists.denx.de, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Johan Jonker <jbx6244@gmail.com>, Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Klaus Goger <klaus.goger@cherry.de>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Durai Manickam KR <durai.manickamkr@microchip.com>, Stefan Roese <sr@denx.de>, 
 Zixun LI <admin@hifiphile.com>, Patrice CHOTARD <patrice.chotard@foss.st.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>
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

Hi Tom,

On Thu, 13 Nov 2025 at 10:46, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Nov 13, 2025 at 11:58:23AM +0100, Quentin Schulz wrote:
> > Hi all,
> >
> > On 11/12/25 6:48 PM, Quentin Schulz wrote:
> > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > >
> > > This adds documentation on how to use the led shell command.
> > >
> > > Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > > ---
> > >   doc/usage/cmd/led.rst | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 95 insertions(+)
> > >
> > > diff --git a/doc/usage/cmd/led.rst b/doc/usage/cmd/led.rst
> > > new file mode 100644
> > > index 00000000000..b5623895c7e
> > > --- /dev/null
> > > +++ b/doc/usage/cmd/led.rst
> > > @@ -0,0 +1,95 @@
> > > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > > +
> > > +.. index::
> > > +   single: led (command)
> > > +
> > > +led command
> > > +===========
> > > +
> > > +Synopsis
> > > +--------
> > > +
> > > +::
> > > +
> > > +    led <led_label> <on|off|toggle>
> > > +    led <led_label> blink <blink-freq in ms>
> > > +    led <led_label>
> > > +    led list
> > > +
> > > +led <led_label>
> > > +---------------
> > > +
> > > +Get state of the LED whose label is the one passed as ``<led_label>`` argument.
> > > +
> > > +Provided ``<led_label>`` is *module_led*, the possible outputs for this command
> > > +are::
> > > +
> > > +    LED 'module_led': off
> > > +    LED 'module_led': on
> > > +    LED 'module_led': blink
> > > +
> > > +led <led_label> on|off|toggle
> > > +-----------------------------
> > > +
> > > +Turn on, off or toggle state of the LED whose label is the one passed as
> > > +``<led_label>`` argument.
> > > +
> > > +led <led_label> blink <blink-freq in ms>
> > > +----------------------------------------
> > > +
> > > +Make the LED whose label is the one passed as ``<led_label>`` argument blink at
> > > +a frequency specified by the argument ``<blink-freq in ms>``.
> > > +
> > > +The frequency is parsed as a decimal number and its unit is milliseconds. The
> > > +duty cycle is 50%. Example::
> > > +
> > > +    led blue blink 1000
> > > +
> > > +will make the *blue*-labeled LED blink with a state (on or off) kept for 500ms
> > > +before switching to the other state (respectively off or on) for 500ms,
> > > +looping endlessly.
> > > +
> > > +led list
> > > +--------
> > > +
> > > +List all available LEDs by their label and provide their known state, which can
> > > +be either *off*, *on* or *blink*.
> > > +
> > > +If a LED has not been probed yet, its state will be shown as *<inactive>* in the
> > > +list.
> > > +
> > > +Examples
> > > +--------
> > > +
> > > +::
> > > +
> > > +    => led list
> > > +    module_led      on
> > > +    sd_card_led     <inactive>
> > > +    => led module_led
> > > +    LED 'module_led': on
> > > +    => led module_led off
> > > +    => led module_led
> > > +    LED 'module_led': off
> > > +    => led module_led toggle
> > > +    => led module_led
> > > +    LED 'module_led': on
> > > +    => led module_led toggle
> > > +    => led module_led
> > > +    LED 'module_led': off
> > > +    => led module_led blink 1000
> > > +    => led module_led
> > > +    LED 'module_led': blink
> > > +    => led sd_card_led
> > > +    LED 'sd_card_led': off
> > > +    => led list
> > > +    module_led      blink
> > > +    sd_card_led     off
> > > +
> > > +Configuration
> > > +-------------
> > > +
> > > +The *led* commands are only available if ``CONFIG_CMD_LED=y``.
> > > +
> > > +The *led <led_label> blink* command is only available if ``CONFIG_CMD_LED=y``
> > > +and either ``CONFIG_LED_BLINK=y`` or ``CONFIG_LED_SW_BLINK=y``.
> > >
> >
> > It seems like there's another led shell command that you can build with
> > CONFIG_LED_STATUS_CMD=y that uses the legacy LED API... Should it be
> > mentioned/have its own documentation page?
> >
> > Maybe we should spend time porting the 5 defconfigs that make use of this
> > legacy API to the new one and entirely retire the legacy LED API. However,
> > there seems to be some discrepancies between the LED_BOOT behavior and that
> > of CONFIG_LED_STATUS_BOOT. The former blinks for a brief period of time and
> > then is solid on once reaching U-Boot's main loop. The latter is blinking
> > sometime after relocation and then turned off on first BOOTP packet.
> >
> > Out of the 5 defconfigs, 3 are using GPIO LEDs with CONFIG_LED_STATUS_GPIO=y
> > so it shouldn't be too difficult to migrate to the new API just to get the
> > LEDs working (I am not talking about keeping the same behavior). The other
> > two are configs/eb_cpu5282_defconfig and
> > configs/eb_cpu5282_internal_defconfig which I assume are for the same
> > product, but it has not seen actual updates (aside from tree-wide
> > migrations) in the last 13 years. From what I could tell, this is also GPIO
> > leds, but controlled by writing directly to the GPIO registers instead of
> > using a driver. Maybe we can issue a deprecation notice and tell the
> > maintainers/users of that board they have X releases to migrate else it gets
> > support for the LEDs removed.
> > For the other boards, we probably need to check how to use the DT for the
> > LEDs that are currently configured via the legacy API.
> >
> > This is at the end of my todo list though.
>
> Yes, when discussions around the legacy LED stuff have come up, it's
> come down to now that we finally have nominal parity in APIs, can we
> migrate the older users? For the two m68k platforms, I'm OK with just
> removing the code and letting someone that has interest and can test
> re-introducing the functionality. Of the other three, I think pinephone
> is the hardest / most important case. I forget if previous migration
> attempts ran in to non-obvious problems.

The last I remember someone was going to get one out of a drawer and
try it. But that was probably last year sometime.

Regards,
SImon

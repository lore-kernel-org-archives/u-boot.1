Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4633C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 18:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17DFB88875;
	Mon, 15 Jul 2024 20:02:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TDWZtUk6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2666788831; Mon, 15 Jul 2024 20:02:58 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16B0388835
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 20:02:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2eabd22d3f4so52428491fa.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 11:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721066575; x=1721671375; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DZWDi/p7xF/U8RNna8BuiY25roEpB3Du4vSzogWpmwg=;
 b=TDWZtUk6IDGDnKF58WYyBGmOCTL5CraHmsRQZxozEm2KPrmnaYyt6ld5uDLdDjPN+W
 GxSVzqt+c2++/x+/lzhW00ifGSC8v7vN0ZPZf+WdSmKs1R8gluC3n8sd74U5u13PgI9Q
 E/UVKv1Xoo9d8lXBd620olAyWekz17OiIO1OWaR0WQfepAMnhHfOFh8GwJ9oOzZH89MR
 UNS62mSNJD3rpW6/6BDk+FFlGQipBXQHT+c2BCie64wyBfpb8oKPAi0dPWy1A+Vd4Yg0
 chq2FDPuf7sBxDaEMFxeNYhccWFIeIhjxa+MKGGZmhH8ihNJeWo9BuH6ZwZKRhepth0y
 bAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721066575; x=1721671375;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DZWDi/p7xF/U8RNna8BuiY25roEpB3Du4vSzogWpmwg=;
 b=jNgEEQ2U3/gLVZOLduPSYllU7yp6RDM8oeb8JBx+ZO27i1wI4xPms72I+oU6YMdXiL
 lQeD+5N/l+490Kk9ZF8R38lzG3APIOnINE9TA6s8HccTO6HOpIfvCPWq5nH6wiXevKEb
 TmXgHrQPkfSgzn8is6oiDM8LohTisnmw/L+neRn4l8xmXMvn6DLLfvU+MgHbVRuBza7I
 sreBhtFcs8QRASbH7a2OxcTeAQYCNDUrFBDYnK91opcO0VFvYTd43dsfw9tsFsXxFwCe
 hv0NwXl//+7qRr3JfnprbjDeWTzMSo0+dAH0xLZEyh+QYzoWSf7MKqTdlxilNmA40SFS
 tg5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwuZGUiGo1CF6y5oyJUThx+0RdwmnimSqRMNoyVQ7Q9kbAodwuBPPAgf7wqsaQ04fe9vSs+J/zfcaufeQ3Q+pQNEpwRw==
X-Gm-Message-State: AOJu0YxN7gPlGRt6yAYeTuG3YNOHaDlsRH1hT0pzBe9DGymuENILaAYe
 sLcttA0gFrjFFrTgbipXBJtVVzLZNpno7vICc9+N/lUwDfZMG2Ijc5Qh8BlItQBMLU+GZXk4vYQ
 rxnQD3Y5sQdv6x3xOfdVIz+MwAq/SlrQh
X-Google-Smtp-Source: AGHT+IHy9wNkb5CfEr+MgvGcmi8nkWY1H1awClFvhy3KQvp1uyjJ3Om7OXPHRZjyCNnrV5lFsc3PXzZAUcQBTFYfyvY=
X-Received: by 2002:a2e:b611:0:b0:2ec:5f85:61d8 with SMTP id
 38308e7fff4ca-2eef2d7653amr4357891fa.16.1721066574994; Mon, 15 Jul 2024
 11:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240714194948.1271135-1-caleb.connolly@linaro.org>
 <c8e6a53d96a89e54585bfe28a647f44f@manjaro.org>
 <948a0d04-a0a2-4c36-8c8d-5f3ad70dfdeb@linaro.org>
In-Reply-To: <948a0d04-a0a2-4c36-8c8d-5f3ad70dfdeb@linaro.org>
From: E Shattow <lucent@gmail.com>
Date: Mon, 15 Jul 2024 11:02:43 -0700
Message-ID: <CANV2PTN7Ch+PyxycqUT8MWjhD9Lf6X+P9H_Y2A5=-g1ypQu4NQ@mail.gmail.com>
Subject: Re: [PATCH] dm: button: support remapping phone keys
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Dragan Simic <dsimic@manjaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
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

Adding my casual opinion to this naming decision:

On Sun, Jul 14, 2024 at 11:24=E2=80=AFPM Caleb Connolly
<caleb.connolly@linaro.org> wrote:
>
> Hi Dragan,
>
> On 14/07/2024 22:47, Dragan Simic wrote:
> > Hello Caleb,
> >
> > On 2024-07-14 21:49, Caleb Connolly wrote:
> >> We don't have audio support in U-Boot, but we do have boot menus. Add =
an
> >> option to re-map the volume and power buttons to up/down/enter so that
> >> in situations where these are the only available buttons (such as on
> >> mobile phones) it's still possible to navigate menus built in U-Boot o=
r
> >> an external EFI app like GRUB or systemd-boot.
> >>
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >> ---
> >> Cc: u-boot-qcom@groups.io
> >
> > Very nice, thanks for this patch!  Looking good to me, with a few
> > suggestions available below.  Anyway, please feel free to add:
> >
> > Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> >
> >> ---
> >>  drivers/button/Kconfig         | 11 +++++++++++
> >>  drivers/button/button-uclass.c | 22 +++++++++++++++++++++-
> >>  2 files changed, 32 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/button/Kconfig b/drivers/button/Kconfig
> >> index 3918b05ae03e..6cae16fcc8bf 100644
> >> --- a/drivers/button/Kconfig
> >> +++ b/drivers/button/Kconfig
> >> @@ -8,8 +8,19 @@ config BUTTON
> >>        U-Boot provides a uclass API to implement this feature. Button
> >> drivers
> >>        can provide access to board-specific buttons. Use of the device
> >> tree
> >>        for configuration is encouraged.
> >>
> >> +config BUTTON_REMAP_PHONE_KEYS
> >> +    bool "Remap phone keys for navigation"
> >> +    depends on BUTTON
> >> +    help
> >> +      Enable remapping of phone keys to navigation keys. This is
> >> useful for
> >> +      devices with phone keys that are not used in U-Boot. The phone
> >> keys
> >> +      are remapped to the following navigation keys:
> >> +      - Volume up: Up
> >> +      - Volume down: Down
> >> +      - Power: Enter
> >> +
> >
> > Frankly, "phone keys" sounds a bit strange to me, maybe because there
> > are also tablets that have the same style of reduced-set keys.  Thus,
> > I'd suggest that the following language is used:
> >
> > - "BUTTON_REMAP_PHONE_KEYS" instead of "BUTTON_REMAP_REDUCED_KEYS"
> > - "reduced smartphone-style keys" instead of "phone keys"
>
> I would have assumed that anyone working on a tablet would immediately
> guess what this option does and that it might be useful given the name.
> I would argue that seeing "BUTTON_REMAP_REDUCED_KEYS" instead makes it
> harder to guess what this option does.
>
> I think of it not as "this option remaps the keys on your phone" but as
> "this option remaps the keys that phones have", as in, the volume and
> power buttons.
>
> If you'd prefer, maybe we can meet somewhere in the middle with "mobile"?
>

> how's BUTTON_REMAP_MOBILE_KEYS?

The distinction is about what it is not, rather than what it is. It is
not a full keyboard layout but there may be some limited keyboard or
button events. That is not necessarily a mobile device, nor a phone,
or any other specific device. Certainly "reduced" makes sense but may
not translate well for all people who would need to interact with this
code.

What I have known over the existence of keyboards is that "media keys"
are describing functionality that is not typical for a keyboard input
device. The other thought is "menu" keys which is more UX-derived but
confusingly may be assumed to be arrow or pagination keys that do
exist on a full keyboard layout. Most keyboards sold (circa 2024) now
include these media keys and are listed as such, so would be familiar.

> >
> > Using "reduced" would also allow us to have this remapping logic more
> > easily extended to also cover some other buttons found on some other
> > devices with reduced-set keys.
>
> If such a device exists and gains support in U-Boot, the switch/case
> could be extended, or a new option added if it doesn't make sense to
> lump everything together. Without knowing about such a device I think
> it's impossible to make a judgement here.
>
> >
> >>  config BUTTON_ADC
> >>      bool "Button adc"
> >>      depends on BUTTON
> >>      depends on ADC
> >> diff --git a/drivers/button/button-uclass.c
> >> b/drivers/button/button-uclass.c
> >> index cda243389df3..729983d58701 100644
> >> --- a/drivers/button/button-uclass.c
> >> +++ b/drivers/button/button-uclass.c
> >> @@ -9,8 +9,9 @@
> >>
> >>  #include <button.h>
> >>  #include <dm.h>
> >>  #include <dm/uclass-internal.h>
> >> +#include <dt-bindings/input/linux-event-codes.h>
> >>
> >>  int button_get_by_label(const char *label, struct udevice **devp)
> >>  {
> >>      struct udevice *dev;
> >> @@ -36,16 +37,35 @@ enum button_state_t button_get_state(struct
> >> udevice *dev)
> >>
> >>      return ops->get_state(dev);
> >>  }
> >>
> >> +static int button_remap_phone_keys(int code)
> >
> > Pretty much the same suggestion as above applies here.
> >
> >> +{
> >> +    switch (code) {
> >> +    case KEY_VOLUMEUP:
> >> +        return KEY_UP;
> >> +    case KEY_VOLUMEDOWN:
> >> +        return KEY_DOWN;
> >> +    case KEY_POWER:
> >> +        return KEY_ENTER;
> >> +    default:
> >> +        return code;
> >> +    }
> >> +}
> >> +
> >>  int button_get_code(struct udevice *dev)
> >>  {
> >>      struct button_ops *ops =3D button_get_ops(dev);
> >> +    int code;
> >>
> >>      if (!ops->get_code)
> >>          return -ENOSYS;
> >>
> >> -    return ops->get_code(dev);
> >> +    code =3D ops->get_code(dev);
> >> +    if (CONFIG_IS_ENABLED(BUTTON_REMAP_PHONE_KEYS))
> >> +        return button_remap_phone_keys(code);
> >> +    else
> >> +        return code;
> >>  }
> >>
> >>  UCLASS_DRIVER(button) =3D {
> >>      .id        =3D UCLASS_BUTTON,
>
> --
> // Caleb (they/them)

-E

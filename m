Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E56EE67A81
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 07:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3F8583F2D;
	Tue,  3 Mar 2026 08:13:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dj0DBHAM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D67C883F30; Tue,  3 Mar 2026 08:13:51 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 389CE8063E
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 08:13:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439af00d33cso2104368f8f.1
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 23:13:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772522028; cv=none;
 d=google.com; s=arc-20240605;
 b=Vwc3Nvwmb2KMlA8u63Mz7rH+oRToFgeWwMAwrArTw9L/qSwgKlccXryD5Fdv3L41GQ
 ThP1OuQC6xLo9FUouDletu37p+GNsP80dNFAwPlcdzCozUbGvzapB1bhywO+bWgZnIiu
 PjfEmH1A7FgNorPiPyATnP/uDgr5tfEBkQmLnQvs20A3xkFuzE+8kd71NdhLc7osTYfO
 942lMBY3CWjzABiKbEN/RkVDduZ1JK05/eKqvjSE6EBGzN8BniS+Uiim/zOIuvsZ6XX/
 1aHhHlimlUTYQwf1I5wA7lOMpXEs5j4n/Y0WmDQAPQ6kOl5a5wx6q0ofKyoOjWeM0JdW
 Q/3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=chMLpIXRS9JNXtPxQXb9i/eIRG5vVDmpZecgviys6QQ=;
 fh=R+57Z9LKwwX94+2l4P9iCqOXXnEAiLXjIBiXRemyTtY=;
 b=ReyF3QD9QhtvobUbh2NkseqPI756hv1+JVgvyYj0d6IWP/H4yZNk6L4xNlssTgldzt
 t/8qgMvzmUIzYsnxpAV9msvDTQ8bUz3JPIM9LcFBzKQLzP3w9pFAD0GyVvP3jh8NUf5N
 0JtfFfTCJUSx0q7qlp6UiL1Xoii6JYAgIF+IHOMtgovA8O7adddhSvsv1EmSDm8lCwMn
 03nZ77dTd4PlO/3SbrV1d0mPBeezS91dQOAa8CLj9yOe6gTUsMVBccew8xXJmdkOr2cP
 TkqSukrUyUBU73JAcb9nZmx6MsP/k8SZV+ULeifH7FI0HLZtQ8mDcYWEgwsiKzF2+uyf
 t1Pg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772522028; x=1773126828; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=chMLpIXRS9JNXtPxQXb9i/eIRG5vVDmpZecgviys6QQ=;
 b=dj0DBHAMIvMmEuRxdbVNpn+A5W0HMNmdunO8MTh4D7hUCl3afOZSUkTqr4ZVeaUQzj
 agmT1L+JY4Mo9h5hwkc/GcAggRbZWjBZJ7HQVvB8Vom6PlLiGnxrWcNH3Nqtxzf8yrK/
 wYO4drWH/8iLseVwFD/gVCltO0RaYAZbhUhB0f0tYeZ3lmcQHZSwFR/Sv/aegHfSq623
 8eAtCNO3vfNWO6jiDRdlh4wgnz7O8H7i+U/Tw4kyzqSAR4cC0kVlK276ixOdAFNiNd4J
 pRSpB4RkHcFkkZoDPw/EGdTKOgVsNAhPK66dAToRnSDmsrawUA6QlzzI7xXf7ebAlUBE
 nOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772522028; x=1773126828;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=chMLpIXRS9JNXtPxQXb9i/eIRG5vVDmpZecgviys6QQ=;
 b=FpFmzaHfauGFFJE6hk5p3o7m6ny6W5TCMjjn5PCh9Itihf++EQ/eUEYm+G7U4ika6q
 Tt3xhshtX3TW5+Fo9f2fRq4pRls7ccfQKUPd3j/OrjqNKkKlxZVP4FbkLtWfVKmrdr4G
 gmEHUVMhQctSa1RXIjS9eybusYa41wMdikfZPB388Oz8UF8JHmhByWOzkEIIgz0J9ZHt
 eMgsI7lF3op+txDkFz8B0SjVtWVvdB2XMZqklwpxApEg7U98svumg4kFSBYyryHKXMqO
 XauCngnjZvhbMdvQfMsML8+1D3aT3/jkCnIf9W9ji0M7cOSU97IxFrR7/1k3nkp3N5iv
 cEcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5/2jhq/3ZFCYyHtQ/cosGTHjm4sib6hR/a5Mf1cxWP0JFuRoSKsMJzZVP1xLAIhunrCBZo5Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwtXvaC1Ij1XBDSRKeWoAkeyolgMMEgfcBRL/5QU8Ghz1sQL/ey
 aSQS2UG/4QHx6Bi6xcO77K30+EFmbVd33wJkriEtlCiin5UIZPhQXosMKqM0KD2x3axejD+xCAo
 mEt49ycyWwybrBc0tSy335z/+qTKna5CAMeJq
X-Gm-Gg: ATEYQzy0ijueKQkxdBdWrMTURUJf9HBKUOu/F04/9V2vWYEOIlrDqWWxWANMH6+Frpt
 Lg7GROjZ5EN5T7akoEt8HyxchKFocky8Wjugl10+BZoQzHYztO4KzQlTTn7w+Z/xl0qKnY4ZDs3
 g2AyUJq/YWm+rLAY0xutM438uFhnp9XM+RYJ2OZrS+MuBv4ikJzgs7H7fjnwkuMRpKQr2PAGfCS
 CZ/ShBE/AZ8HCTfy0DyxMiFr1AdJwKvUCtlElDAIgjJr/K8uzmL7DAj8U42MYLYGJi3tEb/sKSl
 aFvqKxNz
X-Received: by 2002:adf:fec5:0:b0:439:ac32:9117 with SMTP id
 ffacd0b85a97d-439ac3291camr13506730f8f.6.1772522028249; Mon, 02 Mar 2026
 23:13:48 -0800 (PST)
MIME-Version: 1.0
References: <20260209180718.32451-1-clamor95@gmail.com>
 <20260209180718.32451-2-clamor95@gmail.com>
 <d194a890-6921-472b-935f-8b2d01c1289c@cherry.de>
In-Reply-To: <d194a890-6921-472b-935f-8b2d01c1289c@cherry.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 3 Mar 2026 09:13:36 +0200
X-Gm-Features: AaiRm53NjHdKEClIz-3N0wOdVj7NW0Ur3-CQ1gnQV8UYdteKTusm5rg2_1_BQgg
Message-ID: <CAPVz0n3Tsx2rvfmBhDQDyW-_fLm3XLiPzzna3ZCxbt=LeQAF3w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] led: led_pwm: fix active-low behavior
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Ivan Vozvakhov <i.vozvakhov@vk.team>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 u-boot@lists.denx.de
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

=D0=BF=D0=BD, 2 =D0=B1=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 15:07 Quent=
in Schulz <quentin.schulz@cherry.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav, Jonas,
>
> On 2/9/26 7:07 PM, Svyatoslav Ryhel wrote:
> > From: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
> >
> > In the case of active-low behavior the Duty Cycle needs to be set to 10=
0%.
> > The PWM driver takes care of this but the LED_PWM driver does not take
> > this into account. Adjust LED_PWM to take into account polarity of PWM.
> >
> > Signed-off-by: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >   drivers/led/led_pwm.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/led/led_pwm.c b/drivers/led/led_pwm.c
> > index 15dd836509b..7edfa286468 100644
> > --- a/drivers/led/led_pwm.c
> > +++ b/drivers/led/led_pwm.c
> > @@ -34,7 +34,7 @@ static int led_pwm_enable(struct udevice *dev)
> >       if (ret)
> >               return ret;
> >
> > -     ret =3D pwm_set_enable(priv->pwm, priv->channel, true);
> > +     ret =3D pwm_set_enable(priv->pwm, priv->channel, priv->active_low=
);
> >       if (ret)
> >               return ret;
> >
> > @@ -52,7 +52,7 @@ static int led_pwm_disable(struct udevice *dev)
> >       if (ret)
> >               return ret;
> >
> > -     ret =3D pwm_set_enable(priv->pwm, priv->channel, false);
> > +     ret =3D pwm_set_enable(priv->pwm, priv->channel, priv->active_low=
);
>
> This feels wrong. Why would both enable and disable paths use the exact
> same value for pwm_set_enable()?
>

Hello Quentin!

You are mixing up the LED with the PWM that controls it.
pwm_set_enable() triggers a PWM configuration update; therefore, the
process is the same for both enabling and disabling.

> I can also see that the disable path doesn't actually call
> pwm_set_invert() unlike in the enable path. I'm assuming this means we
> cannot call disable before enable and have consistent behavior?
>

The inversion setting is only relevant when the PWM is enabled. Since
the disable operation forces the duty cycle to 0, the inversion state
is inconsequential.

> The kernel seems to use active_low as a way to invert the duty cycle if
> I'm understanding the code properly. In U-Boot, it seems we don't handle
> that at all and always pass the "normal" duty cycle. Maybe there's
> something we need to do there.
>

In U-Boot PWM should handle this in the set_invert operation.

> I'm also assuming there are setups where PWM should be enabled but with
> a duty cycle of 0?
>

A duty cycle of 0 is equivalent to pwm being turned off. In general
most devices won't work on very low duty cycles. Fan needs at least
30%, LEDs make no sense below 10%, also most Display are not usable
below 10%

> I'm also unsure what's the difference between active-low and
> PWM_POLARITY_INVERTED (I've seen them both mentioned or mixed in the
> kernel DTSes).
>

These are properties of two different device classes: active-low is
used with PWM-LEDs, while PWM_POLARITY_INVERTED is strictly a PWM
property.

> I don't have experience with PWM so maybe that's a just a
> misunderstanding from my side?
>
> Cheers,
> Quentin

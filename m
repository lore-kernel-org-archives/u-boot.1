Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58029EFCE2A
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 18:12:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2EC7839A8;
	Wed,  4 Mar 2026 19:12:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XnTbFfHk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1378883AA9; Wed,  4 Mar 2026 19:12:42 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB58083642
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 19:12:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439c9eb5d36so849022f8f.2
 for <u-boot@lists.denx.de>; Wed, 04 Mar 2026 10:12:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772647959; cv=none;
 d=google.com; s=arc-20240605;
 b=H9tiGPYduE0ugQKl8Pd+md8+bGl1cpMWtbHyPUdu8/bvPp/iTK8CYgWubwOOq2OvRh
 ke04eDRDMv5h7gLI7I3fq7ETicVPLSUJps7MSq7PhusjE7ujBtczdWJNmsb262mqpjlT
 FOAt/ZLAJsA5xHVTStdEnKUndRHtTvbnD583i2nqgS64l4Z3G7cO8RyNFOLMfl7IK7xG
 BSsjVDsdux9JG1DzTKYPDifps1oYmXShqFBMIDvVj18euqLPuXtVi6VKhWno6EsBOsLI
 HtjV+1UJeDdSaq6QEcZkyZLrZqRKtEZC7mZkWAEDfsjA1T/LpDNBCUg4i2zjO3ICTplI
 pIow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BeVMkBDJo1beqLPvVyT2F7nH7Nb+SMTgf+ETTXN9dwQ=;
 fh=SS9qq9k6rdeZqG5o8AMFhY+kR5VW/fJAoTmLxNWnpOQ=;
 b=Y0YSBzXvZTXpmiNr1xonRptiM+mfAJY/cX/gZ/8on6tMyE7pMLo3OzRRIyfX+Id5+Y
 d8JQZYMIpDOneK7zk882pYQsBFZUC3Z3O9cUrOuIAcDsEa/FyCJgcK9OplwrLEh76fdN
 tyXvN2TVfgQXLfIwNZfWtUAn1bDUQ9T/B8isxqBvUFtFE41AiIywG8TWjh8iNwODouH2
 LdeCyfzU2u/0TJXTQIBS7zv/Kj3wxjyltN2andhCt7zOOEKqY3mEtJGc6jwEwxfHzbdd
 12MiogEHUkd6skdlc8uIkx1ZqMnEv5xxVC1K0Bv6o2pcHYjwBDBa+oLlNH4Kt/liHcCn
 Iv8w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772647959; x=1773252759; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BeVMkBDJo1beqLPvVyT2F7nH7Nb+SMTgf+ETTXN9dwQ=;
 b=XnTbFfHkSfuMmCUgAHPLdi1gSBce+VmJjROwNim8Sr6XhbpWv8AoIUORlW5xcHn4hF
 19gzskllz35qAJTQXvIk8iG3PwSIRAffoATk6u5JzkfhVR10xxQTg7DpMevm92K6NSU1
 SzM93pX+flwtqLqQfWPe7QPZvktweiNuZNZjyL9DKEpHcy4vTOf7kWUddPjkTQu9ML8C
 tfBWUpJkjSwPuIasg2UqOA0WpCxK76IPjaly0NX0IUhg6SY/2xN33REZ7rAJkngG0Sj8
 80CJgA2SGXuOVF1VZMnWNuvhchGmxljUkWpFWl5HWFPemKeu3xP0WJa7caAWHXFWfBvn
 MzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772647959; x=1773252759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BeVMkBDJo1beqLPvVyT2F7nH7Nb+SMTgf+ETTXN9dwQ=;
 b=l0Reij0Q6vNrS5JhtiPkiWopItmGItRCkPeAVvRGaKCmXxRrKLTo72F/VGB2aOPyAp
 M4goRzlii9cGz827Ah2BMLribzxra9VFwlPpCJ2UjNkTxL4JZMzWG6Zqd3BjQPK/6uY8
 WPzkC8hYrOJ6S+6FADCZd2oXNOjXHEph6WaRsaBi8fAG3Gf/MwFrAxca3SzTPLmdUf2A
 GccQc3XxJ5e9lUks0c9zv+SzYNN9prXgdLPQl+xA7E6GF1jO3ZdncLFnC5q2X5aSynqE
 b35b/BiIxmcR4hnDJLGc3AO0mYe2S2ELqLlX+0UIDVA+RS5wjyLIJ+yw9vSm/X/+AGEp
 ANNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwQHEgbSPT9546zGPpHM8+lxua26Ve1wZiUf/XFwa6aoqfjRcIFBcE4SWNMRevE+nRSg8BZZA=@lists.denx.de
X-Gm-Message-State: AOJu0YwHZO4n4raMxwY7vkhFCIB3F9u1q18SepLPMYewLXi2FO1KGaMq
 jXxN7WFl7QZSqIfXbVKc/UAXVn6DASuKpS7LoPvmhVnImOENZcJ635DPZP+CWpjxAkSFXc08EVO
 4DBupOYtULpDXFe58huJYPArgOZ6e2yA=
X-Gm-Gg: ATEYQzzivWNKqx+h/l8ADDECHCr79E6wzJN8g78zr/SFreX31aMtfvSkfQRP1HTTI8i
 yWx3Fl79Q5O+52/Thm4a5x/Npc3ABPGyMKB2PwsUXP6KtRIxmNCBSuf5GM7rhiH1+HdoTrdfcup
 4F5id+lqtrkNuwehAMS80lHjabBLSL+PIde2+sHsqcwia8+ri9cU3RvcuvIJug7yx5J+0QMwc3V
 FDWgyfeIwM6CFvBV4viw9VN3CEGTDeRF8VaTRiMDPC7jBsbLdFzP4GJhN43lWIS11v2m0z5bHLS
 Is+Fp6Cq
X-Received: by 2002:a05:6000:2f83:b0:439:b3f1:8011 with SMTP id
 ffacd0b85a97d-439c7fd390bmr5652599f8f.29.1772647958928; Wed, 04 Mar 2026
 10:12:38 -0800 (PST)
MIME-Version: 1.0
References: <20260209180718.32451-1-clamor95@gmail.com>
 <20260209180718.32451-2-clamor95@gmail.com>
 <d194a890-6921-472b-935f-8b2d01c1289c@cherry.de>
 <CAPVz0n3Tsx2rvfmBhDQDyW-_fLm3XLiPzzna3ZCxbt=LeQAF3w@mail.gmail.com>
 <9a229a29-7ba1-4f23-8940-7be3d56ad7da@cherry.de>
In-Reply-To: <9a229a29-7ba1-4f23-8940-7be3d56ad7da@cherry.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 4 Mar 2026 20:12:27 +0200
X-Gm-Features: AaiRm53drpCogG_WBCmUEsXRVuJmO65TBS06OWc7IOTKRCzRttwE3kY3ck42gFE
Message-ID: <CAPVz0n0JPaSQt_9Lt8=jcEM6V0RDYWdjkZwdX6C6BZ+iR4uMXQ@mail.gmail.com>
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

=D0=B2=D1=82, 3 =D0=B1=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 13:07 Quent=
in Schulz <quentin.schulz@cherry.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On 3/3/26 8:13 AM, Svyatoslav Ryhel wrote:
> > =D0=BF=D0=BD, 2 =D0=B1=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 15:07 Q=
uentin Schulz <quentin.schulz@cherry.de> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> Hi Svyatoslav, Jonas,
> >>
> >> On 2/9/26 7:07 PM, Svyatoslav Ryhel wrote:
> >>> From: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
> >>>
> >>> In the case of active-low behavior the Duty Cycle needs to be set to =
100%.
> >>> The PWM driver takes care of this but the LED_PWM driver does not tak=
e
> >>> this into account. Adjust LED_PWM to take into account polarity of PW=
M.
> >>>
> >>> Signed-off-by: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
> >>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >>> ---
> >>>    drivers/led/led_pwm.c | 4 ++--
> >>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/led/led_pwm.c b/drivers/led/led_pwm.c
> >>> index 15dd836509b..7edfa286468 100644
> >>> --- a/drivers/led/led_pwm.c
> >>> +++ b/drivers/led/led_pwm.c
> >>> @@ -34,7 +34,7 @@ static int led_pwm_enable(struct udevice *dev)
> >>>        if (ret)
> >>>                return ret;
> >>>
> >>> -     ret =3D pwm_set_enable(priv->pwm, priv->channel, true);
> >>> +     ret =3D pwm_set_enable(priv->pwm, priv->channel, priv->active_l=
ow);
> >>>        if (ret)
> >>>                return ret;
> >>>
> >>> @@ -52,7 +52,7 @@ static int led_pwm_disable(struct udevice *dev)
> >>>        if (ret)
> >>>                return ret;
> >>>
> >>> -     ret =3D pwm_set_enable(priv->pwm, priv->channel, false);
> >>> +     ret =3D pwm_set_enable(priv->pwm, priv->channel, priv->active_l=
ow);
> >>
> >> This feels wrong. Why would both enable and disable paths use the exac=
t
> >> same value for pwm_set_enable()?
> >>
> >
> > Hello Quentin!
> >
> > You are mixing up the LED with the PWM that controls it.
> > pwm_set_enable() triggers a PWM configuration update; therefore, the
> > process is the same for both enabling and disabling.
> >
>
> Does it? All drivers in drivers/pwm actually write to their registers in
> the set_config callback, some even re-enable the PWM controller if it
> was running before entering the set_config function.
>
> The sunxi driver notably does not do anything on set_invert callback,
> it's only applied on next call to set_enable.
>
> pwm_set_enable() clearly states it's for enabling or disabling the PWM.
> So why would we call pwm_set_enable(,,false) in led_pwm_enable() if
> active-low property isn't set in the DT? Why would we call
> pwm_set_enable(,,true) in led_pwm_disable() if the active-low property
> is set?
>

ok, fair, it seems that this commit got here accidentally, my bad. It
will be dropped.

> >> I can also see that the disable path doesn't actually call
> >> pwm_set_invert() unlike in the enable path. I'm assuming this means we
> >> cannot call disable before enable and have consistent behavior?
> >>
> >
> > The inversion setting is only relevant when the PWM is enabled. Since
> > the disable operation forces the duty cycle to 0, the inversion state
> > is inconsequential.
> >
>
> If you have inverted polarity, I'm assuming you need 100% duty cycle to
> turn the LED off.. So we definitely need to have the PWM running and the
> inversion setting configured, no?
>

pwm_set_invert sets an invert flag and PWM driver should handle this.

> >> The kernel seems to use active_low as a way to invert the duty cycle i=
f
> >> I'm understanding the code properly. In U-Boot, it seems we don't hand=
le
> >> that at all and always pass the "normal" duty cycle. Maybe there's
> >> something we need to do there.
> >>
> >
> > In U-Boot PWM should handle this in the set_invert operation.
> >
> >> I'm also assuming there are setups where PWM should be enabled but wit=
h
> >> a duty cycle of 0?
> >>
> >
> > A duty cycle of 0 is equivalent to pwm being turned off. In general
>
> I don't think that's necessarily true? What happens to the PWM pin when
> the PWM controller is disabled? You're not driving the line low (or high
> for inverted polarity) so who's to say the state of the LED is off?
>
> > most devices won't work on very low duty cycles. Fan needs at least
> > 30%, LEDs make no sense below 10%, also most Display are not usable
> > below 10%
> >
> >> I'm also unsure what's the difference between active-low and
> >> PWM_POLARITY_INVERTED (I've seen them both mentioned or mixed in the
> >> kernel DTSes).
> >>
> >
> > These are properties of two different device classes: active-low is
> > used with PWM-LEDs, while PWM_POLARITY_INVERTED is strictly a PWM
> > property.
> >
>
> Sure... but don't they mean the same thing? It seems we are not reading
> the flag property in the PWM cell in the PWM LED driver and only read
> the active-low property to decide on the polarity. What are we supposed
> to do if we only have one of both enabled? Assume it's inverted
> polarity? Then what do we do if both are enabled, is it doubly-inverted,
> meaning normal polarity? Or is it a simple binary OR?
>

I am not the right person to ask this question. Ask Linux kernel
PWM/PWM-LED/schema maintainers. They will definitely provide a
complete explanation.


> I unfortunately don't have HW to test this.
>
> Cheers,
> Quentin

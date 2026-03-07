Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F71FC9ED3
	for <u-boot@archiver.kernel.org>; Sat,  7 Mar 2026 07:40:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE25F83A8C;
	Sat,  7 Mar 2026 08:40:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=yahoo.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=yahoo.de header.i=@yahoo.de header.b="gM0Mhwo6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2170883CEE; Sat,  7 Mar 2026 08:02:15 +0100 (CET)
Received: from sonic309-26.consmr.mail.ir2.yahoo.com
 (sonic309-26.consmr.mail.ir2.yahoo.com [77.238.179.84])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5459D838FA
 for <u-boot@lists.denx.de>; Sat,  7 Mar 2026 08:02:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=yahoo.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jonasschwoebel@yahoo.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s2048;
 t=1772866927; bh=0PTRa1XRZQe92yGsiJWO3nT/MHHE2cyEXvOI8a2S+Bs=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To;
 b=gM0Mhwo6S27Q9yoa91MMn5m8L/lVteg4ObfRIJIJ0tTGHUj2v8ql/FZE0kntCZ/MklDh8F0S9dL2B7Z2IV115yJDtGKCpUNXS89hAVTxpo/9UILHH8AP1srklnHu3nL8rIq06u1RUVJQ12IDiCHGQ0sgT7oIfhegspN+loP/u1Mowrj7DZycVHaL0rINQUpK6wDon693MMTFcS0PEHmn1Cy75gFw4iBv0LAenBX7QqPwZODIKfNsxG1THjxd55CTkIvnOCZxeFVHLRsBiRSttH57YUQq2yv9+6wjle0q0SNDzp0wSzI/WBZWs1RxOnrZx7VSnZhqgbfIm0EloB7DyA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1772866927; bh=/HlGce/qVYxZdq8hFqNBTdP6cyeUjz9wpTpxdHYBtJU=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=FZLIrbqO266PnSmSnO6BMfjuaoSX4I3UIZNsUoMMQdameDHDuC71wJSvY9zIkucRzefJd2bZmLwD8c5XlarHlF7suGOVpDQfeW/ghMAsw/DRR0NqLJLNj3LdS25tITK3Ay5PBl49ZluTfKezwtJPRhdxYQSinI1LW+savSLQKGbFI1UPjcmjKvPrl3eEjE9xXTjA2Gk4BJ1/19dpzzffson2wttw6XUL0Y88FGlzRVOxf6d0yRD35gySUfjJD2s+tK4PzpIlSI+SGZDzbWVsHxDIrmI1PlLh4JufrLut8OQPW6O0SmPLnaBCAOVAc8knYhQX8NkZVrnzMincLMP+iQ==
X-YMail-OSG: KLsXr2oVM1lSNd2UJO.gF9HHAJKc_zSJhRXa5LKl4cLhwPTpoJTsfEtQrct.tgr
 cnZIb.R0Jm5lhQWxxP4t.pnL7d1jnUn4tBgYfpfMK3ilh3ykwfBTeS9sVVNmHn4Tf3xAgx0GdEQN
 EdsBHbc_R.TwIJePghH5FcxwADLcOCb1rOTtsDgq6TD_SX.G_DNDxYoRS7wJWtQSl6ar_2rngWb2
 FtPK34VzysgUyUEbCGrZ9.8DMNL5wdDTUsLCSxmrIH87GNKUs387QQsucm4fU5P5.3F6DntVkHZ3
 VdK.oWJSFb86OyXxwetr5aQGGLoU6pGmBRDcqHm7e0Hvki1auhYNWK67ZBKS.Aue3H42o0yG1pm7
 GR02g782wOJWWJmzD9LNOLeg66bDUwOx0hgg0PWM_BLi7MkNxRKPgeEHh9ooEnF9bLPaSr585qCb
 W8xauwKC_EqniKUKYo2rvabMMhULMLiU9kvO2daw1MhtX3kye77YYqLmYjdQVdbnZ70jgVCioHdt
 cfcEu6BQD2TDrEN2KRoLZSKMlCAqrk4DyGPZAJdRa0XeOnIP6cJp.VnIt_Fhhz_f9TZ7huiOHH65
 .U3tgnrFVNXmn2K1MfJcqnWLhb9Z_8awch_5f1wGxXHzPKwjFF0RlNrCjWLnqKT2w90Cbx9mIk4W
 Ge9kequEZqkr_OlLVZVoQKbSvbg3l3PDLr9tukMVBLdXWcuu6XuQFEP3cm_1OdIL3K6tFaVAgSOQ
 K4PP4fb8yHIa5lkIgh507bZcjuZzxnTMJ.qZjNHmhqx8JXq9.cTN8iAW0ID2Iw6Y4BpPkHOYo8cS
 K9MM29dHwazky6t3dzvatRNrWEt.SQGHVJIwfcv9IHW7twjHe8Sq9aKszdZF939QqHvV2FvHHKXp
 03ZdpjtD8_XgO0st.abZT4nbQVnZRBQI4eqBtu5KyXbnjdkW7rAYjyKx60Z.uSgjnksEErKe8mdq
 fY5IyGYdeQi40sy0fJl6XaPdKwdo9eBjOSzT2DCxY4GwodL3aeFA6TrFyqFhIfMl6eWtdXkxmKUJ
 DpqMZrPfLlR.XkhDWc2_88QLfQQ5wd.eSrf2h55rFgSnoVMDwr3CdkhA7gJdd5CsObWiIwOL4HTo
 zMhi_E7eaIalxWDeOIg3RluW9fPEHhDJf7tMChZLpxoGlgysLdiMRqtTeHDG0T7Fi4hXdXkcHdkA
 JXXQUXjpC.H0g0PEIXZebj9sKHXZc0KbtKDBwZMLP2swpHjK1hvdrzgCdXLPjC2du5KXmo_vRVf6
 bdyI.CbQEemA09pw3A6Hgr8BlmHrxfNnlI5Oan6g1fgNx7.jxyewQR0VuYqRB.HpS.rmn7SgVghk
 nJd3NJqaVC0Dw.MyDRSfw.P10_UG0HlliFBftR2_KaS0z9t2DBXGMooTJYXaGJTUmJ0vWt_ueBbB
 q05yjsJEQu9GLubBtz3QIHnr0ppkybMDrWcWenltqRKcPBxPoA9JJSXjoMynefUAJOVYa8V0qB61
 JPkaM7SXsDz5jG7kZEonksJQUOjRDwyKM_tIWo8SNvDPyx3_0JesUwg1KiyR.Yau58yOAc9Wqy1r
 svvGK_JOcircvCs593GKqCIXs9yk.EyuDOO7tESnnLWE.HH.oLFVheUVrMLL.RnNONDg4sHIuzWY
 96f3A2_7sAmHi7Z6jc329d3SLkel5UHK8yBoVcjvg.mkOfdJcnvKPt4CY10xmgNPRzkMyZVyZhqg
 pHHoSPAX1Qwi3UDfZoCZvcjfNixM5d0XvUz.iWEGFVgDQbw.QLuVhXnvJhyj9TkBRVCa8b.uwGD3
 wH3ujCeIhhZDY0HBRWugpaGtOf7HXKTR8XcdCSkM3YmQczQ3hRTjGXUco09cwOoduG5P_GkeCwne
 m2L3YhKLQTOfO8iE.I.iqqiq_.hKTjoG7EbqWj_Y2b90MnUDT8JacHpcbySC9e6F7CR34zVRYMRF
 onzcsZ5vd2nKzmAszOUPqiIkR_CrO04TMKDuvOOjv4c6G2lMD0rXJ_0zC1p805e3TvQeRe6kIEkf
 xxAAPHbBNxBg4Wf8ldph2tI8PljY53w5GWj7wzXoPXERtuPFeK2b9E01gfVNshN5JO561N.493AL
 7WI.pHVpvvrdCBFXScwJ.tqxrVavUeZQzdLhQTZ6t.z7V_t6STB6jgpH6Jro7fj8iXNDDg6JjyUC
 WSyVixK8zgd8ouFuKJe6RIvoYpLocqaffNiRN7..fouMzBo.Ojh72Lxvw4lKR3P0pmYHBao6msSo
 w1uHTq_pd5rPRIjtbF0_WHCbOM22lqtbpPi5.71oyhQ1L30SFslP_CE7qF0IEIU4phQCl2KkPLX8
 Ww9nwRLFOJspH3d.P
X-Sonic-MF: <jonasschwoebel@yahoo.de>
X-Sonic-ID: c299f0af-e682-4411-9871-a60d55518a01
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.ir2.yahoo.com with HTTP; Sat, 7 Mar 2026 07:02:07 +0000
Date: Sat, 7 Mar 2026 07:02:02 +0000 (UTC)
From: =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
To: Quentin Schulz <quentin.schulz@cherry.de>, 
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Ivan Vozvakhov <i.vozvakhov@vk.team>, Tom Rini <trini@konsulko.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Message-ID: <844270160.6833726.1772866923004@mail.yahoo.com>
In-Reply-To: <CAPVz0n0JPaSQt_9Lt8=jcEM6V0RDYWdjkZwdX6C6BZ+iR4uMXQ@mail.gmail.com>
References: <20260209180718.32451-1-clamor95@gmail.com>
 <20260209180718.32451-2-clamor95@gmail.com>
 <d194a890-6921-472b-935f-8b2d01c1289c@cherry.de>
 <CAPVz0n3Tsx2rvfmBhDQDyW-_fLm3XLiPzzna3ZCxbt=LeQAF3w@mail.gmail.com>
 <9a229a29-7ba1-4f23-8940-7be3d56ad7da@cherry.de>
 <CAPVz0n0JPaSQt_9Lt8=jcEM6V0RDYWdjkZwdX6C6BZ+iR4uMXQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] led: led_pwm: fix active-low behavior
MIME-Version: 1.0
X-Mailer: WebService/1.1.25266 YMailNovation
X-Mailman-Approved-At: Sat, 07 Mar 2026 08:40:24 +0100
Content-Type: text/plain; charset=UTF-8
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

=20
Hey Quentin,

While working with a Active-Low RGB LED i noticed that it doesn't
work correctly. I traced this problem back to the LED PWM driver.

The driver currently disables the PWM hardware when the LED should be=C2=A0
turned off. This works for the common active-high case, where driving=C2=A0
the output low keeps the LED off. However this does not work correctly=C2=
=A0
for active-low LEDs.
For an active-low LED the polarity is inverted:
- LED on -> output low
- LED off -> output high

With PWM this means that a fully-off LED corresponds to a 0% duty cycle=C2=
=A0
with inverted polarity, i.e. the output is constantly driven high.

If the PWM controller is disabled instead, the output typically returns=C2=
=A0
to the controller's idle state (often low or high-Z depending on the
hardware).In that case the LED may end up unintentionally turned on or=C2=
=A0
left in an undefined state.
Because of this, disabling the PWM device to represent the LED off state
is not generally correct. Instead the PWM should remain enabled and the=C2=
=A0
LED state should be expressed through the duty cycle while respecting=C2=A0
the configured polarity. This ensures correct behaviour for both=C2=A0
active-high and active-low LEDs and avoids relying on
controller-specific idle levels.
(I even tried to force the idle level with pull-up-down settings=C2=A0
but without success)

This is further backed by the Linux kernel LED PWM driver:
https://github.com/torvalds/linux/blob/
5ee8dbf54602dc340d6235b1d6aa17c0f283f48c/drivers/leds/leds-pwm.c#L59-L64

Therefore i suggest that we keep the PWM enabled when turning off the LED.
This behavior was "accidentally" matched when setting it to=C2=A0
priv->active_low which, in my special active-low case, was true and kept
PWM enabled when turning the LED off. I didn't have any active-high PWM
LED to test/verify my change and therefore it slipped through.
I am sorry for that. Thank you for catching that little mistake :)


I suggest to match the Linux kernel behavior and keep the PWM running=C2=A0
at all times. Let us know if you agree and we will update the patch.

Greetings Jonas
    Am Mittwoch, 4. M=C3=A4rz 2026 um 19:12:39 MEZ hat Svyatoslav Ryhel <cl=
amor95@gmail.com> Folgendes geschrieben: =20
=20
 =D0=B2=D1=82, 3 =D0=B1=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 13:07 Quen=
tin Schulz <quentin.schulz@cherry.de> =D0=BF=D0=B8=D1=88=D0=B5:
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
> >>>=C2=A0 =C2=A0 drivers/led/led_pwm.c | 4 ++--
> >>>=C2=A0 =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/led/led_pwm.c b/drivers/led/led_pwm.c
> >>> index 15dd836509b..7edfa286468 100644
> >>> --- a/drivers/led/led_pwm.c
> >>> +++ b/drivers/led/led_pwm.c
> >>> @@ -34,7 +34,7 @@ static int led_pwm_enable(struct udevice *dev)
> >>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)
> >>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> >>>
> >>> -=C2=A0 =C2=A0 ret =3D pwm_set_enable(priv->pwm, priv->channel, true)=
;
> >>> +=C2=A0 =C2=A0 ret =3D pwm_set_enable(priv->pwm, priv->channel, priv-=
>active_low);
> >>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)
> >>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> >>>
> >>> @@ -52,7 +52,7 @@ static int led_pwm_disable(struct udevice *dev)
> >>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)
> >>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> >>>
> >>> -=C2=A0 =C2=A0 ret =3D pwm_set_enable(priv->pwm, priv->channel, false=
);
> >>> +=C2=A0 =C2=A0 ret =3D pwm_set_enable(priv->pwm, priv->channel, priv-=
>active_low);
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
 =20

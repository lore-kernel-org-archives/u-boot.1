Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9508AC3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 13:56:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3173588908;
	Mon,  5 Aug 2024 15:56:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="qy21y5ey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C623888F6; Mon,  5 Aug 2024 14:48:25 +0200 (CEST)
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch
 [185.70.40.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFD43888D7
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 14:48:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=emil.kronborg@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1722862102; x=1723121302;
 bh=v7ZmJHs4cGAZv8uCnkbl0omLfwLiQX0WFICZKBpLrJA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=qy21y5eyk51UVV6pEWMKctHQMZq2RyqnFJWNoeNkJbrHxCSWwD0094za+XiQGk59d
 kxWTup5zRKJlfN3iaCqkuVhdV8HdC8Bs+A6o4L4V8CUuyvMGq5e5JI1YVRMaKLN0Ys
 VSKI7lNoQ7kBHZ7yFwMm6yMU2PkUp3m/nByQn2ZzkJ3bQWKGuaI6jzfIEg4XZ0Ex4V
 piGLKSl81MJBDaFgdH7JGf+KLB66oxQDOrsYLVVhEIBS35jl+b9h2ci18UjVMrhSjS
 TSBK1Hx1BR7lyvgQahH/3Leeo8nXCkDrISyKM8bNobvCm6RJigm1wjWxecvU05Lhbg
 mm2AhDsOb15+A==
Date: Mon, 05 Aug 2024 12:48:19 +0000
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
From: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: quentin.schulz@cherry.de, u-boot@lists.denx.de, trini@konsulko.com
Subject: Re: [PATCH v3] doc: document the pwm command
Message-ID: <4wpyedjfdtu77bdq3nmfd47vedbgkodpfdabka7rzqou4shyen@cjij2bx7veih>
In-Reply-To: <27d5a36b-1485-4837-9427-c9cf44310837@canonical.com>
References: <20240801100754.44732-1-emil.kronborg@protonmail.com>
 <27d5a36b-1485-4837-9427-c9cf44310837@canonical.com>
Feedback-ID: 20949900:user:proton
X-Pm-Message-ID: d90193a05191fe26dce4cbc07bc08a50ae764393
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 05 Aug 2024 15:56:32 +0200
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

On Fri, Aug 02, 2024 at 17:28 GMT, Heinrich Schuchardt wrote:
> On 01.08.24 12:07, Emil Kronborg wrote:
> > [...]
> > +Synopsis
> > +--------
> > +
> > +::
> > +
> > +    pwm invert <pwm_dev_num> <channel> <polarity> - invert polarity
> > +    pwm config <pwm_dev_num> <channel> <period_ns> <duty_ns> - config =
PWM
> > +    pwm enable <pwm_dev_num> <channel> - enable PWM output
> > +    pwm disable <pwm_dev_num> <channel> - disable PWM output
>=20
> To stay consistent with other pages, please, remove the descriptions
> here. They are available below.
>=20

Hm, all other documented commands in /doc/usage/cmd have a Synopsis
section except for the write command, which refers to the read command.
Wouldn't this break the consistency?

> > +pwm invert
> > +----------
> > +
> > +The signal's active and inactive states are swapped.
>=20
> This would imply that all invocations irrespective of the polarity value
> swap the active and inactive state.
>=20
> I guess we could say here:
>=20
> The polarity of the signal is set.
>=20
> If the value of `polarity` is 0, the default polarity is used.
> If the value of `polarity` is 1, the polarity is inverted.

Your suggestion is more precise. I will include it in the next revision.

> > +pwm config
> > +----------
> > +
> > +Configure the period and duty cycle in nanoseconds.
>=20
> According to https://en.wikipedia.org/wiki/Duty_cycle "duty cycle" is
> the ratio of "pulse active time" and "total period". This implies that
> it is dimensionless.
>=20
> %s/duty cycle/pulse width/ or "duty period" as in pwm.h.

That's a good point. I will also include this change.

> > +
> > +pwm enable
> > +----------
> > +
> > +Enable output on the configured device and channel.
>=20
> What happens if the device-channel combination is not configured yet?

The device is enabled with whatever period and duty period are currently
set. My guess is that the default reset values of the SoC are used.

    =3D> pwm enable 0 0
    =3D> echo $?
    0
    =3D> pwm config 0 0 20000 14000
    =3D> pwm enable 0 0
    =3D> echo $?
    0

> > +
> > +pwm disable
> > +-----------
> > +
> > +Disable output on the configured device and channel.
>=20
>=20
>=20
> Please, describe the parameters here:
>=20
> pwm_dev_num
>     Device number of the pulse width modulation device
>=20
> channel
>     Output channel of the PWM device
>=20
> polarity
>     * 0 - use normal polarity
>     * 1 - use inverted polarity
>=20
> duty_ns
>     pulse width in ns
>=20
> period_ns
>     cycle time in ns
>=20

The common arguments, namely pwm_dev_num and channel, are already
described in the Description section. The parameters polarity, duty_ns,
and period_ns are detailed within the command descriptions. Including
them again here might be redundant.

It seems like you want some specific layout. Is there some described
command I can use as reference? Or is it documented somewhere how to
describe a command properly? I used some of the commonly used commands
as reference, but even those are documented differently.

> > +
> > +Examples
> > +--------
> > +
> > +Configure device 0 channel 0 to 20 us period and 14 us (that is, 70%) =
duty cycle::
>=20
> Please, add comma, use '=C2=B5s', and don't misuse 'duty cycle':
>=20
> "Configure device 0, channel 0 to 20 =C2=B5s period time and 14 =C2=B5s (=
that is,
> 70%) pulse width::"
>=20

I wasn't sure if it was allowed to use characters like '=C2=B5', but it's
good to know that it is allowed; I think it looks better.

Thanks for reviewing.

--=20
Emil Kronborg


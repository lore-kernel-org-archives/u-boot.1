Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C84EE77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 19:20:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B66E78021D;
	Wed, 18 Dec 2024 20:20:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=writeme.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=writeme.com header.i=sinan@writeme.com header.b="l+ouPQKK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70DCE80291; Wed, 18 Dec 2024 20:20:27 +0100 (CET)
Received: from mout.gmx.com (mout.gmx.com [74.208.4.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00A3D8021A
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 20:20:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=writeme.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sinan@writeme.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=writeme.com;
 s=s1089575; t=1734549622; x=1735154422; i=sinan@writeme.com;
 bh=WVXB2R5vlwjZIB9uqvoRmFMLbDEL6CzBAfj36FcHAMI=;
 h=X-UI-Sender-Class:Content-Type:Message-ID:Date:MIME-Version:
 Subject:To:Cc:References:From:In-Reply-To:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=l+ouPQKKdC0wV8HHchiNmvRm38t8JOQdYxOYqhwOfTqJmPoUUXlez//DTh7QuBnh
 e18utTGgyuInakFQXT+JuHpXUX5VhFxd8kz/RTz/PiCJsCo4kILRg9X52X1RHjvjR
 8HjT6V0YZ6QRf9+q/iIQPhdNobR7wFpN2qixExe3tBD1WQbhNxNpdTtkC5QZQPPgF
 EHZmrO/q45lj5+Ets79pwDSnt7SwgREt4cSV2x1WG3sanxMIIlJn/+d3U8Fs/GEMF
 PdR69zldqoulzx0r6ef6n8YU2l6xrUu0FFqpw/MSlkHJ0hcX258SEPOff3GE4CdDL
 zBJ59i+48YKTZ9GpDw==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [192.168.4.12] ([208.111.77.233]) by smtp.mail.com (mrgmxus003
 [74.208.5.15]) with ESMTPSA (Nemesis) id 0LaW6L-1tqz970R5D-00cRp9;
 Wed, 18 Dec 2024 20:20:22 +0100
Message-ID: <30176d01-b244-47ac-82c9-8ee2b1f44a6b@writeme.com>
Date: Wed, 18 Dec 2024 14:20:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] gpio: mpc8xxx: Preserve pre-init state of outputs
To: j.ne@posteo.net, Mario Six <mario.six@gdsys.cc>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241215-mpc83xx-misc-v1-0-8cd6daae4f93@posteo.net>
 <20241215-mpc83xx-misc-v1-4-8cd6daae4f93@posteo.net>
Content-Language: en-US
From: Sinan Akman <sinan@writeme.com>
In-Reply-To: <20241215-mpc83xx-misc-v1-4-8cd6daae4f93@posteo.net>
X-Provags-ID: V03:K1:Z7okVaCGFHqz5SK1NSfDlfXgxw/DbQugbrmdHMKF3pKXU1akL4/
 PaJubXnnLHvsBVR7Ym+13c+lrb+MrfxprV5QQnnCcF/R1rttp+HDM5qZDCga4eVTyMtKFnd
 +i3adU+Gk5Y+vxL3FAZ7dN4dHLsjyF0EzFqXYQLbD9+xTNHV6ipfiiRLenqzEbwKzlx0HS4
 dCKWlVLvC1HGplqQOAmOA==
UI-OutboundReport: notjunk:1;M01:P0:T2rJBNQkL+Y=;qJAK3yiR8DkvaEyCfUFgtP2FRgI
 R+hjI37ziynE13JgfH1BnKqeTJT0NqZrM2XlyOnd5bMc+KJV4T+ovrBSu8j91+vm+7Qz76v/C
 Kp+8b53Ye+IwL9Ga03MwBEgr8iTAilo9NH4+ZZ3vnLFmtU5fWRovNONhlTzlai33Xrlit41A2
 ATmREqzTK8KQE5tYDX6cP2ZZ1juguHhyopN91yt/Iev/ImWzOscpWhlLy8vrhreSnGf6fzgVp
 h1fRrtKjYwfrPf00pMYcbJnnOLDLyrJD8wGTzp3mIlJXU+qbxu8OGa8V6JbrGjt9vINM29acD
 qw7HxTVIWuZP7GG5zPkmjUni6PGbX3Y+BF31qhHWIlgje9RVP3MaxyNZ0fjP11JAzy7jGIMG5
 RBoEEANhhdOoPvdO4PxqO2zVRGZYSgC07Qt85Ufah3hO47tJi2craopYUlETRMHJR40AlzT2e
 TxdVgeFdS+7wekkcuaTmt+wCIQsWz2n4N8S7jm3WFLu0bOxRdBiKjWfifT9FCjkGHVxyvie3S
 13qn+fm9qDcJ8DjV6rlee+9nZbCHXjh//oVSEQDkJ2T/Q0gKL3X3SR5Q9TXShd6CSj4PM2opO
 P4RmTw0qZAMrxVry7FhKdE19CuZcIxuzT67dRZOE2pAEvMKDaID6kMFJ01ECQLyqF7oZtHEKR
 U1hESEtoOq6sTdsQMAcDnbs2zIZ+o7tlN9oAvAn2PoJ7G+cQnm6nkDsFwlK8mNojYfyfgfK0l
 8PSAmSljRlE6Oz0sb6vgHBhp5fo3fZMrKkjM7LEWXjvQdtV9ReD/dFP4lz0IS9+dNG/Z/VPKQ
 tB2xIJtGB1qqD60iUYfhIQq0aDEaEX2uGie01QN8iIsfAU0VJbmPBzExcHzL2Le072dbdm1zW
 wsY/QL4wZbds9YizxsvRlNl0irO9wApJniC+FIndBe8I4h4yoUQKl/c4dXTIZ5rwsxRgyZkVF
 aEmvLJPG7dR0tN7cPsKRY4/1nkCpMZHyiv0X+orfVl3sctclHv9KJnOUOlgK9Z8a2kF21AiAc
 ffd/+tZL00szciqKvFjbTEVcQXqTPnR8gkwbZ4TPiCWKagk/tVTbibvS1LSQmJu22LuGJZHDq
 NFS+llUmK5fM26Uo9B9Od0+g1rcsqDPqbja4wLOCorFIUigbr89oLR6+gYJ7RcqwbVEsicHtY
 =
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi

On 2024-12-15 10:18, J. Neusch=C3=A4fer via B4 Relay wrote:
> From: "J. Neusch=C3=A4fer"<j.ne@posteo.net>
>
> The mpc8xxx_gpio driver contains a workaround for certain chips
> where the previously written state of outputs cannot be read back
> from the GPIO data (GPDAT) register (MPC8572/MPC8536). This workaround
> consists of tracking the state of GPDAT in a "shadow register" (i.e. a
> software variable). The shadow register is initialized to zero.
>
> This results in a problem w.r.t. outputs that are configured to a
> high (1) state before U-Boot runs, but not touched by U-Boot itself:
> Due to the zero-initialization, these GPIOs end up being set to zero,
> the first time that any other output is set.
>
> To avoid such issues initialize the GPDAT shadow register to the value
> previously held by any outputs, if possible. On MPC8572/MPC8536 this
> should make no difference,

 =C2=A0Did you test this on a MPC83xx board ?

> i.e. the shadow register should be
> initialized to zero on these chips.
>
> Signed-off-by: J. Neusch=C3=A4fer<j.ne@posteo.net>
> ---
>   drivers/gpio/mpc8xxx_gpio.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/mpc8xxx_gpio.c b/drivers/gpio/mpc8xxx_gpio.c
> index e9bd38f162c10c76460bc63f93c03a711cb4d38e..709d04017d154ecae1e8d16d=
7c35ced521157c4d 100644
> --- a/drivers/gpio/mpc8xxx_gpio.c
> +++ b/drivers/gpio/mpc8xxx_gpio.c
> @@ -204,7 +204,17 @@ static int mpc8xxx_gpio_plat_to_priv(struct udevice=
 *dev)
>   		return -ENOMEM;
>
>   	priv->gpio_count =3D plat->ngpios;
> -	priv->dat_shadow =3D 0;
> +
> +	/*
> +	 * On platforms that do support reading back output values, we want to
> +	 * try preserving them, so that we don't accidentally set unrelated
> +	 * GPIOs to zero in mpc8xxx_gpio_set_value.
> +	 */
> +	if (priv->little_endian)
> +		priv->dat_shadow =3D in_le32(&priv->base->gpdat) & in_le32(&priv->bas=
e->gpdir);
> +	else
> +		priv->dat_shadow =3D in_be32(&priv->base->gpdat) & in_be32(&priv->bas=
e->gpdir);
> +
>
>   	priv->type =3D driver_data;
>
>

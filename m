Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C195CE7D1A
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 12:02:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05DB488D39;
	Tue,  1 Oct 2024 14:02:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a8Km+pjG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AD4F88E3A; Tue,  1 Oct 2024 14:02:30 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C23E88606
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 14:02:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42cbe624c59so43460055e9.3
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 05:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727784147; x=1728388947;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mFVkVqMBZ1QMGckR/b+E7ok0uSIU2NJWoHUcL4zOavI=;
 b=a8Km+pjGfvONoe2GKSnboTaM4b0JKeeAIQmtmv94kvOJbFdM9KmOn7aUmUCd85qzFx
 43XkWVToJjqQY9vZq57Lgik99yKxp6g738eEQ7iAq5l0PkBkYMG44Qktzm53xnhBRAw3
 G538cisf77s+S4fahJ38j1Q+X72aQ/yQk2EgkHvADvPBTHGIfDciBIOw/dCUdIPhc5hX
 wDnH48uOt09p0Naf5K/8HmjQwIkoSu2655OmsHj03DXgshzGXn07/1cxsoKFPhRr9rjn
 Iakd/1eD670V75U3/GthwZuQEwsI2fkTj4+g0ietgaU+nENecuATnTFXcQ9Z5cTMZF1K
 ZkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727784147; x=1728388947;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mFVkVqMBZ1QMGckR/b+E7ok0uSIU2NJWoHUcL4zOavI=;
 b=EhQMYHMoR97ww95MgzwHUZI4Bpj2UUkwCshTJ9abVbrXvy25BdCMJzVhfY8vbXHLCz
 d3JLkbyvWNHme6zAuOB3tdhmsZQpS/1PLbBkd22ftX2z+zw4W2Hg8vrAE4p8sckTHFHX
 9sh1EmS7Auw7VQlDR49HBXuSRyLdWsQtfYr7PbO7EexYk7iuKHn6b4TPP6ol+9VSBvsC
 zRQe+xrxeYnORs11HhSHYJCouPaIYTnBPJecxLPPGfw4zi/IukrVdRc+XVuq4SpABlQN
 Nul48Wy7c5r3apTWblBvegkkiH9NL0trhm5R8sU1BqBvSFC82RmGQEsXGMV6rmrkglwX
 ZS9w==
X-Gm-Message-State: AOJu0Yx+E9VGecqTKL1HH42tz65c9XhCHiyPZH++fpyOsJ4UHqLSJcVd
 orGfAhn7eYJxB4SQAKe25s4dOm/7S+pHrtbu9xAlLn7qDTnLVaDfVdh1AnTpzjzOHu3QiJnv/Vx
 r
X-Google-Smtp-Source: AGHT+IG9BNkc1m1rOJQxztPFjfF794D4hitm1zNE4wsR/keHwF1l2gs9TEvUs/6Vc7BssPg5/lj3gQ==
X-Received: by 2002:a05:600c:4e86:b0:42c:bb75:4f86 with SMTP id
 5b1f17b1804b1-42f58498ba3mr104522255e9.32.1727784147366; 
 Tue, 01 Oct 2024 05:02:27 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f57e2fe7dsm129253665e9.46.2024.10.01.05.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 05:02:26 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: neil.armstrong@linaro.org, Lukasz Majewski <lukma@denx.de>, Tom Rini
 <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] dfu: sf: rely on DT for spi speed and mode
In-Reply-To: <9726572a-61e8-457d-aa02-720aa1d5b54b@linaro.org>
References: <20240917-uboot-topic-dfu-sf-dt-v1-1-8cf38451eea4@linaro.org>
 <87ldz8cij3.fsf@baylibre.com>
 <d350e3d8-557e-4f7f-a4a5-983746d554b5@linaro.org>
 <9726572a-61e8-457d-aa02-720aa1d5b54b@linaro.org>
Date: Tue, 01 Oct 2024 14:02:23 +0200
Message-ID: <87frpgc9ps.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On mar., oct. 01, 2024 at 12:13, Neil Armstrong <neil.armstrong@linaro.org>=
 wrote:

> On 01/10/2024 12:01, Neil Armstrong wrote:
>> On 01/10/2024 10:52, Mattijs Korpershoek wrote:
>>> Hi Neil,
>>>
>>> Thank you for the patch and sorry the review delay.
>>>
>>> On mar., sept. 17, 2024 at 14:24, Neil Armstrong <neil.armstrong@linaro=
.org> wrote:
>>>
>>>> Align with cmd_sf, and try to rely on DT for spi speed and mode,
>>>> and still fallback on spi_flash_probe() if it fails.
>>>>
>>>> With the current scheme, spi_flash_probe() will be called
>>>> with CONFIG_SF_DEFAULT_SPEED and CONFIG_SF_DEFAULT_MODE
>>>> with are set to 0 by default on DT platforms using DM_SPI_FLASH.
>>>>
>>>> Like cmd_sf, keep the option to specify the speed and mode
>>>> from the dfu_alt_mode string, but rely on DT properties
>>>> if not specified.
>>>>
>>>> Using CONFIG_SF_DEFAULT_SPEED and CONFIG_SF_DEFAULT_MODE
>>>> makes the SPIFC controller on Amlogic Meson G12B & SM1
>>>> hardware fail and is unable to recover until a system reboot.
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>> =C2=A0 drivers/dfu/dfu_sf.c | 22 ++++++++++++++++++++++
>>>> =C2=A0 1 file changed, 22 insertions(+)
>>>>
>>>> diff --git a/drivers/dfu/dfu_sf.c b/drivers/dfu/dfu_sf.c
>>>> index 7c1c0f9e2dc..b5d875be5ea 100644
>>>> --- a/drivers/dfu/dfu_sf.c
>>>> +++ b/drivers/dfu/dfu_sf.c
>>>> @@ -123,6 +123,9 @@ static struct spi_flash *parse_dev(char *devstr)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int mode =3D CONFIG_SF_DEFAULT=
_MODE;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *s, *endp;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct spi_flash *dev;
>>>> +#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
>>>> +=C2=A0=C2=A0=C2=A0 bool use_dt =3D true;
>>>> +#endif
>>>
>>> Can we use if (IS_ENABLED(CONFIG...)) for this logic instead of #if ?
>>>
>>> checkpatch.pl seems to warn about this:
>>>
>>> $ ./scripts/checkpatch.pl --u-boot --git HEAD^..HEAD
>>> WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' wh=
ere possible
>>> #36: FILE: drivers/dfu/dfu_sf.c:126:
>>> +#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
>>>
>>> I know we will have an unused local variable (use_dt) when
>>> DM_SPI_FLASH=3Dn but to me that is fine.
>>> We already have unused local variables based on KConfig symbols in
>>> dfu_flush_medium_sf()
>>=20
>> Sure, let me check !
>
> OK so there's:
> u-boot/drivers/dfu/dfu_sf.c: In function =E2=80=98parse_dev=E2=80=99:
> u-boot-upstream/u-boot/drivers/dfu/dfu_sf.c:163:8: warning: implicit decl=
aration of function =E2=80=98spi_flash_probe_bus_cs=E2=80=99; did you mean =
=E2=80=98spi_flash_protect=E2=80=99? [-Wimplicit-function-declaration]
>    163 |   if (!spi_flash_probe_bus_cs(bus, cs, &new))
>        |        ^~~~~~~~~~~~~~~~~~~~~~
>        |        spi_flash_protect
>
> because there's no dummy spi_flash_probe_bus_cs fallback when !DM_SPI_FLA=
SH

Ok,
Can we add a dummy function?

If you'd prefer not to, we can keep the #if block for that part and
use if (IS_ENABLED) on the other 3 occurences.

>
> Neil
>>=20
>> Neil
>>=20
>>>
>>> Thanks,
>>> Mattijs
>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s =3D strsep(&devstr, ":");
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!s || !*s || (bus =3D simple_strtou=
l(s, &endp, 0), *endp)) {
>>>> @@ -143,6 +146,9 @@ static struct spi_flash *parse_dev(char *devstr)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 printf("Invalid SPI speed %s\n", s);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return NULL;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use_dt =3D false;
>>>> +#endif
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s =3D strsep(&devstr, ":");
>>>> @@ -152,9 +158,25 @@ static struct spi_flash *parse_dev(char *devstr)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 printf("Invalid SPI mode %s\n", s);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return NULL;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use_dt =3D false;
>>>> +#endif
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
>>>> +=C2=A0=C2=A0=C2=A0 if (use_dt) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct udevice *new;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!spi_flash_probe_bus_c=
s(bus, cs, &new))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v =3D dev_get_uclass_priv(new);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v =3D NULL;
>>>> +=C2=A0=C2=A0=C2=A0 } else {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D spi_flash_probe(bu=
s, cs, speed, mode);
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +#else
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D spi_flash_probe(bus, cs, speed,=
 mode);
>>>> +#endif
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!dev) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("Failed =
to create SPI flash at %u:%u:%u:%u\n",
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus, cs, speed, mode);
>>>>
>>>> ---
>>>> base-commit: 19dbc09405d3503ce3efef3c2e4b4f0f1a03372d
>>>> change-id: 20240917-uboot-topic-dfu-sf-dt-8ae62e5c7d79
>>>>
>>>> Best regards,
>>>> --=20
>>>> Neil Armstrong <neil.armstrong@linaro.org>
>>=20

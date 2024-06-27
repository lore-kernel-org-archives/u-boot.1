Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53932C3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:10:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7246388581;
	Thu, 27 Jun 2024 13:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YwduUQHP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C84AB8815E; Thu, 27 Jun 2024 11:10:01 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CDCC8823D
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 11:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a724b3a32d2so586635266b.2
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 02:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719479398; x=1720084198; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=BT/AxhHsjewpcb7QDDDof9jr1tiiKF8MnOwNAwI5wVE=;
 b=YwduUQHPzwPuZxxmkdMhoamn2AjQezSSfG5RhR6fFxKdkVsS1jJZ7l1P86ZJwWc5A7
 u1/eYXZyhtjzqfVcw23WqE+phmLaDah7I4G1B3tshQbvhmG04h4x34R3NlNuifsC9xk9
 RP6HldUXkmR3WzO9NXJgWGG18VE3klXrWrtyaYZQdCXHVQBt3sU+Prm7hPc6WtN7MW/N
 2RmH4CnaFG+TvLWxGK0qP+XxWhAvZLPKZCk7BhT9HRkPJyxSXLFYJRuOXGZTA1wI+gpz
 KKdOZavnwaSSdAWmnLmrAGkXFqWJXrGu7WOdnsUdpH4cLgIuLlm9vdF+U5vaCWA179yE
 UXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719479398; x=1720084198;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BT/AxhHsjewpcb7QDDDof9jr1tiiKF8MnOwNAwI5wVE=;
 b=N2l52uwCrfhqBoBDa4MvjzNZezAIWFfOTuSiTqnWuyLa2ucIQuUV/GTnTqTDeGBw/P
 uEGbDUskFsJsaQsdnL1bD+xEMrzDQVAC7AgopLOVdTGCB48vL/ZWGUfRVnHU5dmN/lNC
 60Vy/wGZMYkM/+rLNtcWkxgDBWwYCl0hgEOQt6KP4Tb7Fw7HXbFZXroMs+31mv12w1UB
 9phIebSCgtrc1a7BvZMiIXk7wQ/qJxRFDerpU3UinX41MCSlNi0EKWA/rBeBzUH+5gPK
 Ht9GbCxpZtkFYWYsSix7RZYbg1n1s4g0+TVh0fGbl6DQ/kogDz1UmIgaSc5M1BSdA+sj
 A1GQ==
X-Gm-Message-State: AOJu0Yzra7MhNUyf6PdbrJZ6Vb14AXOi6iD5vAKfpm9tNM+y2KHW7IRT
 saQcOaRGjRkw2U7PT04e6e4LjpjqtodMNDFXfYXxbvjvTwb3PPZq
X-Google-Smtp-Source: AGHT+IELyBNOR6adIzlaOfamfQf2QvDbvuBDUAvJa/9xJCICVQOGF/hkvPmvx6s6mKbCx9k7oiR+dw==
X-Received: by 2002:a17:906:81b:b0:a6f:cf64:a5d9 with SMTP id
 a640c23a62f3a-a7245c483a1mr737939266b.49.1719479397849; 
 Thu, 27 Jun 2024 02:09:57 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.174.53]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a729d779515sm39317066b.107.2024.06.27.02.09.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 02:09:57 -0700 (PDT)
Date: Thu, 27 Jun 2024 12:08:54 +0300
From: Svyatoslav <clamor95@gmail.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>
CC: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kostya Porotchkin <kostap@marvell.com>,
 Matteo Lisi <matteo.lisi@engicam.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>,
 Sumit Garg <sumit.garg@linaro.org>, Thierry Reding <treding@nvidia.com>,
 Tom Rini <trini@konsulko.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-amlogic@groups.io,
 u-boot-qcom@groups.io, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/4=5D_power=3A_regulator=3A_Trigger_prob?=
 =?US-ASCII?Q?e_of_regulators_which_are_always-on_or_boot-on?=
User-Agent: K-9 Mail for Android
In-Reply-To: <b84e8b10-8698-41f2-9648-0b3f5c399b02@linaro.org>
References: <20240626235717.272219-1-marex@denx.de>
 <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
 <b84e8b10-8698-41f2-9648-0b3f5c399b02@linaro.org>
Message-ID: <96AEFD59-B8D3-4298-8867-E94D474E16BE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 27 Jun 2024 13:09:53 +0200
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



27 =D1=87=D0=B5=D1=80=D0=B2=D0=BD=D1=8F 2024=E2=80=AF=D1=80=2E 11:48:46 GM=
T+03:00, Caleb Connolly <caleb=2Econnolly@linaro=2Eorg> =D0=BD=D0=B0=D0=BF=
=D0=B8=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>
>
>On 27/06/2024 10:37, Simon Glass wrote:
>> Hi Marek,
>>=20
>> On Thu, 27 Jun 2024 at 00:57, Marek Vasut <marex@denx=2Ede> wrote:
>>>=20
>>> In case a regulator DT node contains regulator-always-on or regulator-=
boot-on
>>> property, make sure the regulator gets correctly configured by U-Boot =
on start
>>> up=2E Unconditionally probe such regulator drivers=2E This is a prepar=
atory patch
>>> for introduction of =2Eregulator_post_probe() which would trigger the =
regulator
>>> configuration=2E
>>>=20
>>> Parsing of regulator-always-on and regulator-boot-on DT property has b=
een
>>> moved to regulator_post_bind() as the information is required early, t=
he
>>> rest of the DT parsing has been kept in regulator_pre_probe() to avoid
>>> slowing down the boot process=2E
>>>=20
>>> Signed-off-by: Marek Vasut <marex@denx=2Ede>
>>> ---
>>> Cc: Ben Wolsieffer <benwolsieffer@gmail=2Ecom>
>>> Cc: Caleb Connolly <caleb=2Econnolly@linaro=2Eorg>
>>> Cc: Chris Morgan <macromorgan@hotmail=2Ecom>
>>> Cc: Dragan Simic <dsimic@manjaro=2Eorg>
>>> Cc: Eugen Hristev <eugen=2Ehristev@collabora=2Ecom>
>>> Cc: Francesco Dolcini <francesco=2Edolcini@toradex=2Ecom>
>>> Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>>> Cc: Jaehoon Chung <jh80=2Echung@samsung=2Ecom>
>>> Cc: Jagan Teki <jagan@amarulasolutions=2Ecom>
>>> Cc: Jonas Karlman <jonas@kwiboo=2Ese>
>>> Cc: Kever Yang <kever=2Eyang@rock-chips=2Ecom>
>>> Cc: Kostya Porotchkin <kostap@marvell=2Ecom>
>>> Cc: Matteo Lisi <matteo=2Elisi@engicam=2Ecom>
>>> Cc: Mattijs Korpershoek <mkorpershoek@baylibre=2Ecom>
>>> Cc: Max Krummenacher <max=2Ekrummenacher@toradex=2Ecom>
>>> Cc: Neil Armstrong <neil=2Earmstrong@linaro=2Eorg>
>>> Cc: Patrice Chotard <patrice=2Echotard@foss=2Est=2Ecom>
>>> Cc: Patrick Delaunay <patrick=2Edelaunay@foss=2Est=2Ecom>
>>> Cc: Philipp Tomsich <philipp=2Etomsich@vrull=2Eeu>
>>> Cc: Quentin Schulz <quentin=2Eschulz@cherry=2Ede>
>>> Cc: Sam Day <me@samcday=2Ecom>
>>> Cc: Simon Glass <sjg@chromium=2Eorg>
>>> Cc: Sumit Garg <sumit=2Egarg@linaro=2Eorg>
>>> Cc: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>>> Cc: Thierry Reding <treding@nvidia=2Ecom>
>>> Cc: Tom Rini <trini@konsulko=2Ecom>
>>> Cc: Volodymyr Babchuk <Volodymyr_Babchuk@epam=2Ecom>
>>> Cc: u-boot-amlogic@groups=2Eio
>>> Cc: u-boot-qcom@groups=2Eio
>>> Cc: u-boot@dh-electronics=2Ecom
>>> Cc: u-boot@lists=2Edenx=2Ede
>>> Cc: uboot-stm32@st-md-mailman=2Estormreply=2Ecom
>>> ---
>>>   drivers/power/regulator/regulator-uclass=2Ec | 22 +++++++++++++++---=
----
>>>   1 file changed, 15 insertions(+), 7 deletions(-)
>>>=20
>>> diff --git a/drivers/power/regulator/regulator-uclass=2Ec b/drivers/po=
wer/regulator/regulator-uclass=2Ec
>>> index 66fd531da04=2E=2Eccc4ef33d83 100644
>>> --- a/drivers/power/regulator/regulator-uclass=2Ec
>>> +++ b/drivers/power/regulator/regulator-uclass=2Ec
>>> @@ -433,6 +433,8 @@ static int regulator_post_bind(struct udevice *dev=
)
>>>          const char *property =3D "regulator-name";
>>>=20
>>>          uc_pdata =3D dev_get_uclass_plat(dev);
>>> +       uc_pdata->always_on =3D dev_read_bool(dev, "regulator-always-o=
n");
>>> +       uc_pdata->boot_on =3D dev_read_bool(dev, "regulator-boot-on");
>>>=20
>>>          /* Regulator's mandatory constraint */
>>>          uc_pdata->name =3D dev_read_string(dev, property);
>>> @@ -444,13 +446,21 @@ static int regulator_post_bind(struct udevice *d=
ev)
>>>                          return -EINVAL;
>>>          }
>>>=20
>>> -       if (regulator_name_is_unique(dev, uc_pdata->name))
>>> -               return 0;
>>> +       if (!regulator_name_is_unique(dev, uc_pdata->name)) {
>>> +               debug("'%s' of dev: '%s', has nonunique value: '%s\n",
>>> +                     property, dev->name, uc_pdata->name);
>>> +               return -EINVAL;
>>> +       }
>>>=20
>>> -       debug("'%s' of dev: '%s', has nonunique value: '%s\n",
>>> -             property, dev->name, uc_pdata->name);
>>> +       /*
>>> +        * In case the regulator has regulator-always-on or
>>> +        * regulator-boot-on DT property, trigger probe() to
>>> +        * configure its default state during startup=2E
>>> +        */
>>> +       if (uc_pdata->always_on && uc_pdata->boot_on)
>>> +               dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
>>>=20
>>> -       return -EINVAL;
>>> +       return 0;
>>>   }
>>>=20
>>>   static int regulator_pre_probe(struct udevice *dev)
>>> @@ -473,8 +483,6 @@ static int regulator_pre_probe(struct udevice *dev=
)
>>>                                                  -ENODATA);
>>>          uc_pdata->max_uA =3D dev_read_u32_default(dev, "regulator-max=
-microamp",
>>>                                                  -ENODATA);
>>> -       uc_pdata->always_on =3D dev_read_bool(dev, "regulator-always-o=
n");
>>> -       uc_pdata->boot_on =3D dev_read_bool(dev, "regulator-boot-on");
>>>          uc_pdata->ramp_delay =3D dev_read_u32_default(dev, "regulator=
-ramp-delay",
>>>                                                      0);
>>>          uc_pdata->force_off =3D dev_read_bool(dev, "regulator-force-b=
oot-off");
>>> --
>>> 2=2E43=2E0
>>>=20
>>=20
>> This is reading a lot of DT stuff very early, which may be slow=2E It i=
s
>> also reading from the DT in the bind() step which we sometimes have to
>> do, but try to avoid=2E
>
>Could we set up the livetree pre-bind? What about MMU? On armv8 at least =
this would have a huge impact on performance=2E I've done some measurements=
 and there is at least 1 order of magnitude difference between parsing FDT =
with no caches vs parsing livetree with, it's huge=2E
>>=20
>> Also this seems to happen in SPL and again pre-reloc and again in
>> U-Boot post-reloc?

Not so long ago I proposed a similar patchset with the same goal
and I have discovered massive issues with SPL and relocation
interfering with driver loading=2E=20

The issue which I have personally encountered was i2c driver failure
due to double probing=2E This behavior was triggered by
always-on/boot-on regulators provided by pmic which in most
cases is an i2c device=2E

At that time everyone just ignored me, so idk if tegra i2c is the only
driver which has this response or there are more, but be aware that
this patch set may cause cascade failure on many devices=2E

Best regards,
Svyatoslav R=2E

>>=20
>> Should we have a step in the init sequence where we set up the
>> regulators, by calling regulators_enable_boot_on() ?
>>=20
>> Regards,
>> Simon
>

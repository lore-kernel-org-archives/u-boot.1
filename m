Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D790DC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:10:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05D3887A9C;
	Thu, 27 Jun 2024 13:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UxPdPP5R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D969487FA7; Thu, 27 Jun 2024 10:48:53 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67AF2880A5
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 10:48:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a6fdd947967so584530666b.2
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 01:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719478130; x=1720082930; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PQWX+luspyCXe7Er1ZSMyswIEZzqq2frk40BZPN/01Y=;
 b=UxPdPP5Rl9ZvmNkAGk4+PE0rAXk7KYKBedmyATSHHCOaIlKVFPAKwh3MFZC5lpGYSp
 7SKSGOLLIhqB+gFrSmCZEceQctplvgVKR5VTWaewJ3SXM5/JDFzL4wdpULHS/s5TJcaE
 uAFkXp0eoTcppTZY+HxUj6X+s3IeB35xLySXvP4xLFKObItvAjSD+dhdetPiaQWm8oMR
 u7qdAxF5n98CfkDiD9sjdAIzxnR2NHVOnRgP9DMb1PqDigGQ4CYzFM3vixhjBfwn2Aht
 Ed9Snr1djguOqfx3ZC820C/L+XX8Y9ETnO588UyP742RhcxRQRuWlIWagdHE8iD2OAMQ
 9WCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719478130; x=1720082930;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PQWX+luspyCXe7Er1ZSMyswIEZzqq2frk40BZPN/01Y=;
 b=coHVievENVe8wKmzSP/aSxydPVjE5OOXbdxIhQRhBlY+KH+hOpyyhyIz8XQAolYteW
 D234nZQOp1cO1+au8p0JyG9XnHYKFD/GPVx/LjjXCBS6fyFiA+ZDSJslk3rDIBnFpppd
 Co9yCA/oqA8DBpH7blXMwS6qxb0RqQ0l2dEhAO19HFWrTnRtsL3x0wrY6qCHlSNNcFVW
 uxWzC3bqK8jt34U0K2BcHiIo8TSNBPdNExwwpmqqMiZSaJLUbNlY81gERmVTzcW4qubb
 RGy2Udp/qIFGMLX2Z1ubPyYxJKYIc5GYF4RtTMwJ/IBcu5maDN0lUCnNxgNGReYx44Pv
 LD7w==
X-Gm-Message-State: AOJu0Yw1kiHiiA6lypjz/RLXQi6sOg4PZ7AGANqLge6brkaR9oP39E16
 iaiM7CJKn4hS7QKOP4kDo/zc5IdvPpHXlzVV8K0vcNBGR2Ei58CDfrXxpyO2yBW0gy1wSNZc9Gt
 h/8M=
X-Google-Smtp-Source: AGHT+IHx00dY630Um06yB7PSZgoB5BMl1TlmFaISRXKiaH+xdDQo+IeYUMNUQ7mjfln6sy8TSDV3GA==
X-Received: by 2002:a17:907:9726:b0:a72:a05a:6601 with SMTP id
 a640c23a62f3a-a72a05a674dmr73486066b.14.1719478129673; 
 Thu, 27 Jun 2024 01:48:49 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::18f8? ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a729d71f5b7sm38416266b.75.2024.06.27.01.48.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 01:48:49 -0700 (PDT)
Message-ID: <b84e8b10-8698-41f2-9648-0b3f5c399b02@linaro.org>
Date: Thu, 27 Jun 2024 10:48:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
To: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kostya Porotchkin <kostap@marvell.com>, Matteo Lisi
 <matteo.lisi@engicam.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>,
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-amlogic@groups.io,
 u-boot-qcom@groups.io, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20240626235717.272219-1-marex@denx.de>
 <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 27/06/2024 10:37, Simon Glass wrote:
> Hi Marek,
> 
> On Thu, 27 Jun 2024 at 00:57, Marek Vasut <marex@denx.de> wrote:
>>
>> In case a regulator DT node contains regulator-always-on or regulator-boot-on
>> property, make sure the regulator gets correctly configured by U-Boot on start
>> up. Unconditionally probe such regulator drivers. This is a preparatory patch
>> for introduction of .regulator_post_probe() which would trigger the regulator
>> configuration.
>>
>> Parsing of regulator-always-on and regulator-boot-on DT property has been
>> moved to regulator_post_bind() as the information is required early, the
>> rest of the DT parsing has been kept in regulator_pre_probe() to avoid
>> slowing down the boot process.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Ben Wolsieffer <benwolsieffer@gmail.com>
>> Cc: Caleb Connolly <caleb.connolly@linaro.org>
>> Cc: Chris Morgan <macromorgan@hotmail.com>
>> Cc: Dragan Simic <dsimic@manjaro.org>
>> Cc: Eugen Hristev <eugen.hristev@collabora.com>
>> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>> Cc: Jagan Teki <jagan@amarulasolutions.com>
>> Cc: Jonas Karlman <jonas@kwiboo.se>
>> Cc: Kever Yang <kever.yang@rock-chips.com>
>> Cc: Kostya Porotchkin <kostap@marvell.com>
>> Cc: Matteo Lisi <matteo.lisi@engicam.com>
>> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> Cc: Max Krummenacher <max.krummenacher@toradex.com>
>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
>> Cc: Sam Day <me@samcday.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Sumit Garg <sumit.garg@linaro.org>
>> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
>> Cc: Thierry Reding <treding@nvidia.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
>> Cc: u-boot-amlogic@groups.io
>> Cc: u-boot-qcom@groups.io
>> Cc: u-boot@dh-electronics.com
>> Cc: u-boot@lists.denx.de
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>>   drivers/power/regulator/regulator-uclass.c | 22 +++++++++++++++-------
>>   1 file changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
>> index 66fd531da04..ccc4ef33d83 100644
>> --- a/drivers/power/regulator/regulator-uclass.c
>> +++ b/drivers/power/regulator/regulator-uclass.c
>> @@ -433,6 +433,8 @@ static int regulator_post_bind(struct udevice *dev)
>>          const char *property = "regulator-name";
>>
>>          uc_pdata = dev_get_uclass_plat(dev);
>> +       uc_pdata->always_on = dev_read_bool(dev, "regulator-always-on");
>> +       uc_pdata->boot_on = dev_read_bool(dev, "regulator-boot-on");
>>
>>          /* Regulator's mandatory constraint */
>>          uc_pdata->name = dev_read_string(dev, property);
>> @@ -444,13 +446,21 @@ static int regulator_post_bind(struct udevice *dev)
>>                          return -EINVAL;
>>          }
>>
>> -       if (regulator_name_is_unique(dev, uc_pdata->name))
>> -               return 0;
>> +       if (!regulator_name_is_unique(dev, uc_pdata->name)) {
>> +               debug("'%s' of dev: '%s', has nonunique value: '%s\n",
>> +                     property, dev->name, uc_pdata->name);
>> +               return -EINVAL;
>> +       }
>>
>> -       debug("'%s' of dev: '%s', has nonunique value: '%s\n",
>> -             property, dev->name, uc_pdata->name);
>> +       /*
>> +        * In case the regulator has regulator-always-on or
>> +        * regulator-boot-on DT property, trigger probe() to
>> +        * configure its default state during startup.
>> +        */
>> +       if (uc_pdata->always_on && uc_pdata->boot_on)
>> +               dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
>>
>> -       return -EINVAL;
>> +       return 0;
>>   }
>>
>>   static int regulator_pre_probe(struct udevice *dev)
>> @@ -473,8 +483,6 @@ static int regulator_pre_probe(struct udevice *dev)
>>                                                  -ENODATA);
>>          uc_pdata->max_uA = dev_read_u32_default(dev, "regulator-max-microamp",
>>                                                  -ENODATA);
>> -       uc_pdata->always_on = dev_read_bool(dev, "regulator-always-on");
>> -       uc_pdata->boot_on = dev_read_bool(dev, "regulator-boot-on");
>>          uc_pdata->ramp_delay = dev_read_u32_default(dev, "regulator-ramp-delay",
>>                                                      0);
>>          uc_pdata->force_off = dev_read_bool(dev, "regulator-force-boot-off");
>> --
>> 2.43.0
>>
> 
> This is reading a lot of DT stuff very early, which may be slow. It is
> also reading from the DT in the bind() step which we sometimes have to
> do, but try to avoid.

Could we set up the livetree pre-bind? What about MMU? On armv8 at least 
this would have a huge impact on performance. I've done some 
measurements and there is at least 1 order of magnitude difference 
between parsing FDT with no caches vs parsing livetree with, it's huge.
> 
> Also this seems to happen in SPL and again pre-reloc and again in
> U-Boot post-reloc?
> 
> Should we have a step in the init sequence where we set up the
> regulators, by calling regulators_enable_boot_on() ?
> 
> Regards,
> Simon

-- 
// Caleb (they/them)

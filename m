Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C03CC30653
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 21:18:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98BE5884A9;
	Thu, 27 Jun 2024 23:18:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719523093;
	bh=0NJ7EQtkD4lEE6F/SVXOfE4V/RtaZwjonSi2d0jkSz0=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P/LLJ1iCrEcT3o3smpnSGkmCn+DCO4IXD4XiZ6uzpjO9mt/PgRK0uEq/2pbnyPC7D
	 uSmzZm78MGBRxWoFndaSIyQSZnrL+1ROAUBPwzXwGILdBFNj3NXo2rr42ShPbzP+KX
	 fcMBweEsF6oq07lTSA+R6VD2XrvUUyl4Cvua0V2x4mivkyd0HIXwBBbGnTDxO3FOQn
	 9y3bNPlTpGURbKzNTG4HyYTghrGs/SOLsLYrQcDjjHJ0OOQuAhmGrELIu0Xlu2tSDK
	 u4pWYkqx4iEklSjoplDWdJJf67V/FjAgJDC0/NB7/z3I3zEYEyZeuFTPmYMpRuq9mq
	 +etgXiuPt9bcA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 81FB6880A5;
 Thu, 27 Jun 2024 18:05:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719504314;
 bh=0NJ7EQtkD4lEE6F/SVXOfE4V/RtaZwjonSi2d0jkSz0=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=yXYAKgsV0PiziaUn6F1ui/Sm2lYwWT74aa1m3fC/j77evxW2Ko8Z8i/ZYVSIKVCfa
 16pd+OAJUIxqSAc+49xAdP3ieC+iqvrB9Ugx1dMiV52tG94et2JpbRock5KVUtQYQg
 4nUNwGSjxc5UvMKVDPLLcurUeIYuSCSs60MbkjNqLDvo8U3XLD3ap+oD1X7HrSIcve
 7Ydzb120SXL8BOqdNLE0tTUFDuOOBNxfGnENH4zWq45bwaP1zvalbOszkU+GVYtU8m
 7wAybHMyjENwLwzWd0VbRzvZV3k4DZdxrTSPoC6g7rY96Zo/iJvqetwmtFHiOMLzQ+
 QNDHnWCKAmIsw==
Message-ID: <6abad4ba-b29a-47a3-addb-91e8f46ee425@denx.de>
Date: Thu, 27 Jun 2024 18:04:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
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
In-Reply-To: <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 27 Jun 2024 23:18:12 +0200
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

On 6/27/24 10:37 AM, Simon Glass wrote:
> Hi Marek,

Hi,

[...]

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

Actually, it is reading only the bare minimum very early in bind, the 
always-on and boot-on, the rest is in pre_probe, i.e. later.

> Also this seems to happen in SPL and again pre-reloc and again in
> U-Boot post-reloc?

What does, the uclass post_bind ?

> Should we have a step in the init sequence where we set up the
> regulators, by calling regulators_enable_boot_on() ?

Let's not do this , the entire point of this series is to get rid of 
those functions and do the regulator configuration the same way LED 
subsystem does it -- by probing always-on/boot-on regulators and 
configuring them correctly on probe.

To me regulators_enable_boot_on() and the like was always an 
inconsistently applied workaround for missing DM_FLAG_PROBE_AFTER_BIND , 
which is now implemented, so such workarounds can be removed.

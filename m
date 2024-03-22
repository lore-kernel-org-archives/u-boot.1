Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E38C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 16:39:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ED64881BF;
	Fri, 22 Mar 2024 17:39:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711125554;
	bh=rgwixXaJknUOhb4kM69KgifCQ+4Iu4zmbLGy5I6MfYc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kX4UqsSGZZD3hmEUO3Su5WefnLe0RWy56v/czvlhg9E4WY0xtahGn8GXmT7lne90v
	 GL35FN59m9w7waDyaqKLxPJHIVoPFyankjBMMRPvj96JU3r5W7EANWuXf81WYwP2vM
	 7h9ema9Qaq7rDvbPZ4OMZGNpOn/UZOL7PLSqjQCBqfFRxOwy5Hey61+7OO1ox+GsIM
	 1QWmSr1XnjVc81SgBI9wU26ZPuz2Vb2Vj48g0GPK/diYz3yECPSoTwG2GANqh5Ukyj
	 ovbwm5NGZh4Sw3iZ4hLXP7AnEG2BJpFuGDnQoxg4FtOmRsvM9v3N716RXckp3n+qBO
	 Ya3Oc0vpfD3sg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 07411875FA;
 Fri, 22 Mar 2024 17:39:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711125553;
 bh=rgwixXaJknUOhb4kM69KgifCQ+4Iu4zmbLGy5I6MfYc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tk8VZPajrAt9VTByo6Tdl9B1GwTNNtN2FDu3Y9iYaiGIWnXdbV80iCq5MwfN1MfWE
 qZPl/poFVvbgbqAWJzISZAgQiSP9a1MV/s5502seezglgnZGcv+4+Jm9/FiqEsr25t
 dS4B5zDMmHZHyztcjJh8QPiZdClloHAc+Qy+vI0NHlcBRYm4QHYZdEG7if5iVdyI4j
 D0rncirm4+8uynjiPim1bw+elM4VHRu1oVqii0klQgjmJ+DBL990M2tBeHfvbhe/aC
 gWLc93+8fyK+pAPRUvJryNqhG3DHrido7cCY2sjeE+46fXo2hmi2qEk6IL09y5sDvX
 xJqHDgE7oCh0w==
Message-ID: <e5691237-a4dd-470c-84da-d0583190c28a@denx.de>
Date: Fri, 22 Mar 2024 17:39:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/11] imx8mp: power-domain: Don't power off pd_bus
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, tharvey@gateworks.com,
 marcel.ziswiler@toradex.com, francesco@dolcini.it, lukma@denx.de,
 seanga2@gmail.com, jh80.chung@samsung.com, sjg@chromium.org,
 festevam@denx.de, andrejs.cainikovs@toradex.com, peng.fan@nxp.com,
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240312070338.86127-1-sumit.garg@linaro.org>
 <20240312070338.86127-5-sumit.garg@linaro.org>
 <dbd4f385-d93f-48db-a7e9-88b86f3d7445@denx.de>
 <CAFA6WYO8k=qyexUSRs_X-YMtKZTAzM5ZeSCNEO+sJ7z91z7ohg@mail.gmail.com>
 <f789292a-7c46-4b98-935f-86bfea39ab05@denx.de>
 <CAFA6WYPHqdWiL=8foFDD9Rs+_L+E-=D+VMC=FZrnKeQdcooNMQ@mail.gmail.com>
 <1d7ad0f4-2463-4b1c-9020-5444366438fb@denx.de>
 <CAFA6WYOygxNUGWu3jDF7=4px5gBSoCOjzU=s+eTcH0rRFSGJUQ@mail.gmail.com>
 <09b0dbae-208b-439a-bb75-a79902522eed@denx.de>
 <CAFA6WYNcfQ6Szb81thXJDYUd1GEF7zcdnAAuZCiSagYBzbAqvQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFA6WYNcfQ6Szb81thXJDYUd1GEF7zcdnAAuZCiSagYBzbAqvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 3/22/24 5:55 AM, Sumit Garg wrote:

Hi,

>>>>> I think if people are concerned about power consumption then it
>>>>> should be implemented properly in U-Boot to remove all the DT based
>>>>> devices before passing on control to the next stage.
>>>>
>>>> I would expect imx8mp_hsiomix_off() to be called either on 'usb stop' or
>>>> just before Linux boots (esp. at that point), so if you do not power off
>>>> the bus domain before booting Linux, you may hand over a device which
>>>> was not fully power cycled.
>>>
>>> Unfortunately that's the current situation I see. IMO, the better
>>> solution would be to just remove all the DT devices before passing on
>>> control to Linux. That should automatically power off devices.
>>
>> Doesn't CONFIG_DM_DEVICE_REMOVE=y do something like that already ?
> 
> I just did simple experiment via following diff:
> 
> diff --git a/drivers/power/domain/imx8mp-hsiomix.c
> b/drivers/power/domain/imx8mp-hsiomix.c
> index 6188a04c45e..0ddcd39923a 100644
> --- a/drivers/power/domain/imx8mp-hsiomix.c
> +++ b/drivers/power/domain/imx8mp-hsiomix.c
> @@ -101,6 +101,7 @@ static int imx8mp_hsiomix_set(struct power_domain
> *power_domain, bool power_on)
>                  if (gpr_reg0_bits)
>                          setbits_le32(priv->base + GPR_REG0, gpr_reg0_bits);
>          } else {
> +               while(1);
>                  if (gpr_reg0_bits)
>                          clrbits_le32(priv->base + GPR_REG0, gpr_reg0_bits);
> 
> The boot doesn't hang suggesting that CONFIG_DM_DEVICE_REMOVE=y isn't
> effective to remove any DT devices. It can for sure be another
> followup series to make it effective.

That's odd. Please try and edit drivers/core/device-remove.c , look up 
device_remove() at the end , and see if the remove is being called on 
the hsiomix device . You might need to add some sort of printf() there, 
but that's where the removal happens.

The removal before boot is I think called from drivers/core/root.c 
dm_remove_devices_flags(), which itself is called from 
arch/arm/lib/bootm.c announce_and_cleanup() .

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93610C83F16
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 15:38:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2EC488C15;
	Thu, 29 Aug 2024 17:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nCk4WyU/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB6DD88C4D; Thu, 29 Aug 2024 17:38:47 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2267C88C15
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 17:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a86984e035aso95799366b.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 08:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724945924; x=1725550724; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V/qsMwghuHLIqbdxzAGPhhG8omKTUQ9RQbV0inpAC1Q=;
 b=nCk4WyU/FcTAmTy6R9qSPTC1YJkTnF45Ocr4z3lPrA22xGCCJne3DJwfibL178w/7v
 0MY3nOpfkzje+fLfiI1+dTsW7oWhJJIu6tQ737tDPcUvys/1shvXEZOXtRPZghWMtRWy
 9F7dVoHPLahJLXQa1/MeQIKmkoh/VSXQSdMG33hUn6SH+k7gqSwLKHsQ3viU+d6vg7H+
 6FSV6OhEF+fssnB85PYyzce1OwwlzT7F28mlXnlAOXUN4hXtVQJV+IryVT8xAu5lFCDt
 RoxyWO3JJME3M7Asmc4lhImfKjlBJyWyrSS3WB0pjUjny5l1/0X6iXyNy7dVsQ3r51Ax
 hHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724945924; x=1725550724;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V/qsMwghuHLIqbdxzAGPhhG8omKTUQ9RQbV0inpAC1Q=;
 b=JWOgYNWcvfBdmU6Xm6YUvWpVP6vBiMesFjHnTYNhBu7NdjDkyE0JHoSzddohjRMiQb
 gm432Ffmkg5RP9mzvXXT3z6qHeWjzTd9n1llnDbOPGzt0B5kmI4pI09Cnj6fopoO881r
 7mlD2JccsZeS/hzTM5DGcHLFe8SkzgKLVZPFMHRwBN4c7x2Kp+M1ZoCivZZXixURdXxm
 7nbWfZXbb5Qr9BFfFEEgE39bEFl5DKolZ6aM/udPI9OMNqsPMb5ZSE4FhgUqQxpDupZg
 2Z8F363tqHj8EwiFFwind/H53cQ3Z4A1iLA8snyZ8hLRngfgjNtYNwYWYZr4eFlLajkG
 O3Kg==
X-Gm-Message-State: AOJu0YwdZ50wZdjGG8dGHGJoHj2BnCT+4zUsIltQU1F7Vo0OqEe4dd7c
 T3Ydan5oTMHtzKWoWyQqV5KARQSuS/5U60qj7p58RemUH4cA6D/2qr+YydWO1QU=
X-Google-Smtp-Source: AGHT+IEAYlG3uA8rVOAEBbd0BOxV7E4CsIH29S4p9EJ2P4o0ftoIqXpEsh9Dgq2R8b6MHdH2JrRGvw==
X-Received: by 2002:a17:907:97cf:b0:a86:c9f5:68df with SMTP id
 a640c23a62f3a-a897fa74e79mr195217566b.44.1724945924439; 
 Thu, 29 Aug 2024 08:38:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:dda4:b3aa:27ae:d28a?
 ([2a01:e0a:3cb:7bb0:dda4:b3aa:27ae:d28a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a89940980a1sm35517566b.47.2024.08.29.08.38.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2024 08:38:44 -0700 (PDT)
Message-ID: <a2490f6e-6fd3-4d1d-9260-9a5e7a16bfda@linaro.org>
Date: Thu, 29 Aug 2024 17:38:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 18/37] net: eth-uclass: add function eth_start_udev()
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, William Zhang <william.zhang@broadcom.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Fabio Estevam <festevam@denx.de>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Michal Simek <michal.simek@amd.com>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
 <64779fa9e2c5988a347fe7b9ee55fdf03b464fba.1724419624.git.jerome.forissier@linaro.org>
 <CAFLszTju=hPXe5S+Kik=nbNY4sb79eVc9H6wEEnWUnQVYr40Fg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAFLszTju=hPXe5S+Kik=nbNY4sb79eVc9H6wEEnWUnQVYr40Fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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



On 8/29/24 16:05, Simon Glass wrote:
> Hi Jerome,
> 
> On Fri, 23 Aug 2024 at 07:49, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Add a function to start a given network device, and update eth_init()
>> to use it.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> Reviewed-by: Tom Rini <trini@konsulko.com>
>> ---
>>  drivers/mtd/altera_qspi.c |  4 ++--
>>  include/net-common.h      |  1 +
>>  net/eth-uclass.c          | 38 +++++++++++++++++++++++++-------------
>>  3 files changed, 28 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/mtd/altera_qspi.c b/drivers/mtd/altera_qspi.c
>> index c26615821c8..e5c8df750b7 100644
>> --- a/drivers/mtd/altera_qspi.c
>> +++ b/drivers/mtd/altera_qspi.c
>> @@ -96,7 +96,7 @@ int flash_erase(flash_info_t *info, int s_first, int s_last)
>>         ret = mtd_erase(mtd, &instr);
>>         flash_set_verbose(0);
>>         if (ret)
>> -               return ERR_PROTECTED;
>> +               return FL_ERR_PROTECTED;
> 
> Could you put these in another patch?

Oops! They belong in "flash: prefix error codes with FL_" [1] in
my "Miscellaneous fixes" series which I will update too.

[1] https://lists.denx.de/pipermail/u-boot/2024-August/563326.html


>>         puts(" done\n");
>>         return 0;
>> @@ -114,7 +114,7 @@ int write_buff(flash_info_t *info, uchar *src, ulong addr, ulong cnt)
>>
>>         ret = mtd_write(mtd, to, cnt, &retlen, src);
>>         if (ret)
>> -               return ERR_PROTECTED;
>> +               return FL_ERR_PROTECTED;
>>
>>         return 0;
>>  }
>> diff --git a/include/net-common.h b/include/net-common.h
>> index 26674ec7e90..43bc6b9a0d5 100644
>> --- a/include/net-common.h
>> +++ b/include/net-common.h
>> @@ -192,6 +192,7 @@ int eth_env_set_enetaddr_by_index(const char *base_name, int index,
>>  int usb_ether_init(void);
>>
>>  int eth_init(void);                    /* Initialize the device */
>> +int eth_start_udev(struct udevice *dev);
> 
> Please add a proper function comment to all exported functions.

OK
 
>>  int eth_send(void *packet, int length);           /* Send a packet */
>>  #if defined(CONFIG_API) || defined(CONFIG_EFI_LOADER)
>>  int eth_receive(void *packet, int length); /* Receive a packet*/
>> diff --git a/net/eth-uclass.c b/net/eth-uclass.c
>> index e34d7af0229..6dd9b9bb98e 100644
>> --- a/net/eth-uclass.c
>> +++ b/net/eth-uclass.c
>> @@ -284,6 +284,27 @@ static int on_ethaddr(const char *name, const char *value, enum env_op op,
>>  }
>>  U_BOOT_ENV_CALLBACK(ethaddr, on_ethaddr);
>>
>> +int eth_start_udev(struct udevice *dev)
>> +{
>> +       struct eth_device_priv *priv = dev_get_uclass_priv(dev);
>> +       int ret;
>> +
>> +       if (priv->running)
>> +               return 0;
>> +
>> +       if (!device_active(dev))
>> +               return -EINVAL;
>> +
>> +       ret = eth_get_ops(dev)->start(dev);
>> +       if (ret >= 0) {
> 
> It is better to have the error path jump out, so:
> 
> if (ret < 0)
>    return ret;

OK
 
>> +               priv->state = ETH_STATE_ACTIVE;
>> +               priv->running = true;
>> +               ret = 0;
>> +       }
>> +
>> +       return ret;
> 
> return 0

OK
 
>> +}
>> +
>>  int eth_init(void)
>>  {
>>         struct udevice *current = NULL;
>> @@ -328,20 +349,11 @@ int eth_init(void)
>>                 if (current) {
>>                         debug("Trying %s\n", current->name);
>>
>> -                       if (device_active(current)) {
>> -                               ret = eth_get_ops(current)->start(current);
>> -                               if (ret >= 0) {
>> -                                       struct eth_device_priv *priv =
>> -                                               dev_get_uclass_priv(current);
>> -
>> -                                       priv->state = ETH_STATE_ACTIVE;
>> -                                       priv->running = true;
>> -                                       ret = 0;
>> -                                       goto end;
>> -                               }
>> -                       } else {
>> +                       ret = eth_start_udev(current);
>> +                       if (ret < 0)
>>                                 ret = eth_errno;
>> -                       }
>> +                       else
>> +                               goto end;
> 
> Can that be just a 'break' ?

Yep.

>>
>>                         debug("FAIL\n");
>>                 } else {
>> --
>> 2.40.1
>>
> 
> Regards,
> Simon

Thanks,
-- 
Jerome

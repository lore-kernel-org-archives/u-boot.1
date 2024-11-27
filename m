Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAA6D6ACD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 14:00:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B11BA896C7;
	Wed, 27 Nov 2024 15:00:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="S/HBVrw8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F20FB89775; Wed, 27 Nov 2024 15:00:44 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDA3B89657
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 15:00:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 636C43F767
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 14:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732716042;
 bh=fvb25oe7owaXQcWGJeaXUAZF0G2falZ/QacwEM8fpfg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=S/HBVrw8bGfSNSBmmB/KsVya9dh+vYXC/tRKmnYkBbOUvMw3O2NDbMNbMfHE2qj+M
 Kcn30HGSJCWhbn+lSutHaYisq2GhdZ3VQzTwqOYPTNyjy+VBIudyNi531qS4jExcCK
 hY/NVlDYG5HsZx5DKnj1rMLPXF+BaFOyGYPUha2zKhrI+SMvhiXTyJEBMlT2zAs5KX
 R8xy76ZnlWBTpj66ESg+hfGRZV32EtyiBQdH7KqoJA/HYJWFBkF2nqOrLPBIKsLvpg
 WUqkFoJSStXoA8b/dh+MS6PstPiuYWtNxGvBaEV8S2+enCqmNQ+qDToi5yBbRFcZVW
 l9J9winzcw6Sg==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38233ea8c1bso475086f8f.0
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 06:00:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732716042; x=1733320842;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fvb25oe7owaXQcWGJeaXUAZF0G2falZ/QacwEM8fpfg=;
 b=QSguHvHt2KgyqqrTpUk90Fa8UdvVySjJWljEq18ygMuTDXpTE3K1vmtUpLyh7auD6m
 1Nmw1hAd9qEkMCk3tW+x4dVyLxOy/I7lyRzhUaDZtWGwASsGXTBiQNz00MvHsb4ZmqJ/
 lDU6q0eNAh1TMqi2qXoxadn7UwMyEhaOfY1nAdPIaYLhHrMvE6vnBRX9hoFdW6J2Oz7A
 UPrl1yj03i9Tco+wBBPF+FoArp0fUMa/inYDdW1pj62QZ3xBmyn8iSssKy8PB9qkOZcZ
 3H4WAOJ5NMUL6enJbcySU9F5BKQtIxDn2CeJTYezh28DWMQgcOn0UxNGsEVoNKcBzChF
 3h2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTNEgBbzh5N/eiHXu42uNN2B3a/aYnxF4LOR3X6aK2s6UOkLcO/pykVltZMRGwYDwzNuVY1JQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyj4Y+3ZCKk/U66HC6zxrNZdNaFMAbaCCvKZGkE0wudNlWasnzl
 TCUZVMA47juSeuFuBEeaTbmb/rsqAj9EoPB/pCPfA5Q2DcZnRFHwR1WAH+BHIQAD+H7L1aWOSRq
 6LDJn9zGP3AFizhgNfMxSiCWfxAMSSADEn/mEHjxXpSf65Y1tqwsJHov2D+3V3cRrRNo=
X-Gm-Gg: ASbGncvWWntvAIu5d/HJ+CI+gna3QHVVoVfbx2Z+9louJUamZ/17Usz9iEBOXH/KbAL
 zASZ1XgNPXVjbILQZu44DUYH1zXza5OOmndsOR3bijXePzypN1IM4RANN4Et2ldOWv/mYmoVMPq
 sF0/lEDUx204XThHGG+XF9/W4kiWwrNDFu8KizsBRAx50o433fhm9h7ern8ljUDq0e8Y+7hdCN7
 Cu8eCe0qoauN6h0GqpVIfTkh6Y4qeb1cl1+++PG75hpe1LsqUPVlshYLSkAkVSTF55ncYZEzaqL
 kkVlhIPK7Tl8SbesgIzIYbXjSdCrECyHj6tq1K2l
X-Received: by 2002:a05:6000:1a8b:b0:382:228b:4c44 with SMTP id
 ffacd0b85a97d-385c6828cc5mr2499520f8f.17.1732716041660; 
 Wed, 27 Nov 2024 06:00:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5Y9v5TlB+s0QvZzUr9UNQ4VnpuxPYnCfF+hxGBubXPnSFJOLeM+T+yVUWQR2AUdasaNp51A==
X-Received: by 2002:a05:6000:1a8b:b0:382:228b:4c44 with SMTP id
 ffacd0b85a97d-385c6828cc5mr2499233f8f.17.1732716039150; 
 Wed, 27 Nov 2024 06:00:39 -0800 (PST)
Received: from ?IPV6:2a02:3035:6e0:b718:b90b:9391:e0a8:69cc?
 ([2a02:3035:6e0:b718:b90b:9391:e0a8:69cc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fad60e5sm16959499f8f.3.2024.11.27.06.00.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 06:00:38 -0800 (PST)
Message-ID: <df1e66dd-7b69-4d28-baef-8e992778d5c2@canonical.com>
Date: Wed, 27 Nov 2024 15:00:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] net: eth_bootdev_hunt() should not run DHCP
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Weijie Gao <weijie.gao@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, u-boot@lists.denx.de
References: <20241127070631.16412-1-heinrich.schuchardt@canonical.com>
 <20241127070631.16412-5-heinrich.schuchardt@canonical.com>
 <CAFLszTjWzN0xmyCeMQEirNuhUQvAAjYUz+SaPTozy-+FFQJ_1w@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTjWzN0xmyCeMQEirNuhUQvAAjYUz+SaPTozy-+FFQJ_1w@mail.gmail.com>
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

On 27.11.24 14:07, Simon Glass wrote:
> Hi Heinrich,
> 
> On Wed, 27 Nov 2024 at 00:07, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Currently when booting dhcp_run() may be executed multiple times:
>> once in eth_bootdev_hunt() and once in the network booting bootmeth.
>>
>> We need to call eth_bootdev_hunt() when setting up the EFI sub-system to
>> supply the simple network protocol. We don't need an IP address set up.
>>
>> We can reduce the bootime by not executing dhcp_run() in
>> eth_bootdev_hunt().
>>
>> Furthermore eth_bootdev_hunt() with autostart=yes leads on the legacy
>> network statck leads to downloading a file via TFTP and to booting the
> 
> spelling
> 
>> downloaded file.
> 
> I have now found the feature you're referring to - the calls to
> env_get_autostart(). Perhaps we can remove this feature? It seems
> pretty old and I don't see boards using it.
> 
> That feature stops bootstd working properly.
> 
> But if we don't remove it, we need to disable autostart in dhcp_run(),
> since in that case it does not behave correctly. I can do a patch for
> that if needed.
> 
>>
>> Instead of running dchp_run() just check that there is a network device
>> in eth_bootdev_hunt().
>>
>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v2:
>>          reword the commit message
>> ---
>>   net/eth_bootdev.c | 30 ++++++++++++++++++------------
>>   1 file changed, 18 insertions(+), 12 deletions(-)
>>
>> diff --git a/net/eth_bootdev.c b/net/eth_bootdev.c
>> index 6ee54e3c790..b0fca6e8313 100644
>> --- a/net/eth_bootdev.c
>> +++ b/net/eth_bootdev.c
>> @@ -64,9 +64,23 @@ static int eth_bootdev_bind(struct udevice *dev)
>>          return 0;
>>   }
>>
>> +/**
>> + * eth_bootdev_hunt() - probe all network devices
>> + *
>> + * Network devices can also come from USB, but that is a higher
>> + * priority (BOOTDEVP_5_SCAN_SLOW) than network, so it should have been
>> + * enumerated already. If something like 'bootflow scan dhcp' is used,
>> + * then the user will need to run 'usb start' first.
>> + *
>> + * @info:      info structure describing this hunter
>> + * @show:      true to show information from the hunter
>> + *
>> + * Return:     0 if device found, -EINVAL otherwise
>> + */
>>   static int eth_bootdev_hunt(struct bootdev_hunter *info, bool show)
>>   {
>>          int ret;
>> +       struct udevice *dev = NULL;
>>
>>          if (!test_eth_enabled())
>>                  return 0;
>> @@ -78,19 +92,11 @@ static int eth_bootdev_hunt(struct bootdev_hunter *info, bool show)
>>                          log_warning("Failed to init PCI (%dE)\n", ret);
>>          }
>>
>> -       /*
>> -        * Ethernet devices can also come from USB, but that is a higher
>> -        * priority (BOOTDEVP_5_SCAN_SLOW) than ethernet, so it should have been
>> -        * enumerated already. If something like 'bootflow scan dhcp' is used
>> -        * then the user will need to run 'usb start' first.
>> -        */
> 
> Please keep this comment

I have moved the comment to the function description. See above. I think 
that is the adequate place.

> 
>> -       if (IS_ENABLED(CONFIG_CMD_DHCP)) {
>> -               ret = dhcp_run(0, NULL, false);
>> -               if (ret)
>> -                       return -EINVAL;
>> -       }
>> +       ret = -EINVAL;
>> +       uclass_foreach_dev_probe(UCLASS_ETH, dev)
>> +               ret = 0;
> 
> There is a uclass_probe_all() function.
> 
> My suggestion from the original series was to just do the dhcp once.
> 
> How does probing the ethernet devices actually help EFI? It is not
> needed for bootstd, since it probes any devices it uses.

bootstd is not the only way to start an EFI application, you could use 
bootefi or bootm.

Best regards

Heinrich

> 
>>
>> -       return 0;
>> +       return ret;
>>   }
>>
>>   struct bootdev_ops eth_bootdev_ops = {
>> --
>> 2.45.2
>>
> 
> Regards,
> Simon


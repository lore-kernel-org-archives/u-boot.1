Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41627E7716D
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 09:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4170989229;
	Wed,  4 Dec 2024 10:10:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="psSzib+Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45D3E893BC; Wed,  4 Dec 2024 10:10:20 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1282A89229
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 10:10:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4EC813F31C
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 09:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1733303414;
 bh=DgbGzpC36gBuwzcA57UWoC3CfidfbamYG04XMFa/2cI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=psSzib+Qx9iT0x8oytS4Uf2LfNEnUokXEtgMur7bXux7yVb9r+41mGzP11w8hEBPU
 8kVx+27+r1JVf2xie9Yh6fcC7foZ/t+vJzE8gLF3x5oUKVbzX7RqxF6sg45hJR+5Kb
 mP3YwbBKYSgwreHS5kzrXS3+pi7skVkG+3NSvXXHsVOuccBxNaSl7faPJB3i5DxMo1
 13SmP3wz3jsgrOJ3wHM9sje1BZEM0Samrt7QoaUo/8NvVxI+1jXK3054ThFYNdukXv
 SOJPAROehu4niM+nsz9+2nYbULs7+Txfl7hdblW/wT8z7xcsUaD9DCjO3PsnC8tqby
 p7Q6KLo8uAAIg==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385eb060d4fso317150f8f.1
 for <u-boot@lists.denx.de>; Wed, 04 Dec 2024 01:10:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733303414; x=1733908214;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DgbGzpC36gBuwzcA57UWoC3CfidfbamYG04XMFa/2cI=;
 b=LECEGQGZn0byVX4khsmqkhD40UCwtOdbQmj46jqZcspV4EBubpJagrWIAm2NBLid+6
 d1bmkgZmbXK7gXQM6fKPwPhEQpqG5FZg3dtjrv3K8/Dqc3cxi/DE90cv/rNsEf+4Y2O8
 HUqVI4sLeTSLBWJVQ35d7yTXl46wCpuvyAgTjx4MxwCzqjdlrop3e3nofB9aa06KKE8l
 2nELfvvKz6N8Jq9vAfqFSSRu4e2KtoxOOAhdy/2pPG7CvFQ900Ql4gffgJkb61SKEY5P
 Yt0s3oJXYZ9tPC56Lx885QaO+Ko2X4z/nF+R+nSC7L8Yqqof8lu9+YFx3XAOeKdwM3Pj
 PH2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKVx8BrY8GXsaVgz6W5Nh3hIh/vueH7WDg3ZAGqdBcOI/+qEfdkdnDldr85wAxhqrl2vXRD7M=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2k9WIA+ERboUaoAAiY2N0fQggKDkb7QKBLZuxEknztc/xiDAw
 hMDJawdhrBG/PR9dxNKadHjQkOWYb7sbjb4iTAc9/zlZqObe8O8JhjKLueo+b2+MeTV9MeucUtr
 kxSOF/60knEfY07K7KBk7SzbTP7kXW0K7bX8d1ltZvinZJepT5Ed9lE/dnaKKRWsMptk=
X-Gm-Gg: ASbGncvYnEaQVhmid/pd4R63O+RLE2CYYdjZRQsCsvnMf7j7vj/8id1/MsaNuyK2tOw
 Ou3cUJFkxbfjkHDSIsJ/LAJDTriHAoEcGnDmb/4gBQNEUYm9u2557maimvfzSn+T+Z1W5+i/CWG
 g6kPF+8f54uVIUtA92IfzUTNZmJgd6uXKgdSlYJBuin+fZkFHuBVdusDgbkuotkXUvZoYdSdzMh
 Z0aB85A+RYJdw5HbkitSfzwmJjMLgUYk/wX5D/VT6KcfeKK7TUxWqP9mQWKtg2EZ1zmlvjcJqUo
 7LCJGE0rug6lAIkuZaqQ3AWSAuirttRaUBoOFDrS
X-Received: by 2002:a5d:5c05:0:b0:385:d7f9:f15f with SMTP id
 ffacd0b85a97d-385d7f9f229mr21135068f8f.19.1733303413792; 
 Wed, 04 Dec 2024 01:10:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZNdwiwS/xZpSXH2xmqm8hYxUj0LvrYF6S7vsG8Q7gUMkXhk4BpXjcOMgEJf8BGOTJy0I6Xw==
X-Received: by 2002:a5d:5c05:0:b0:385:d7f9:f15f with SMTP id
 ffacd0b85a97d-385d7f9f229mr21135043f8f.19.1733303413356; 
 Wed, 04 Dec 2024 01:10:13 -0800 (PST)
Received: from ?IPV6:2a02:3035:6e0:9b8a:adf8:337c:7d0b:35d9?
 ([2a02:3035:6e0:9b8a:adf8:337c:7d0b:35d9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d52cbefasm17716285e9.43.2024.12.04.01.10.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 01:10:12 -0800 (PST)
Message-ID: <02a3fcf7-bdc7-4d44-9d0e-1a05bd5216a8@canonical.com>
Date: Wed, 4 Dec 2024 10:10:09 +0100
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
 <df1e66dd-7b69-4d28-baef-8e992778d5c2@canonical.com>
 <CAFLszTiS-2MCZih4CzM-3YjgvX0MraxvY_thSDdHVy0_T_do3Q@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTiS-2MCZih4CzM-3YjgvX0MraxvY_thSDdHVy0_T_do3Q@mail.gmail.com>
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

On 27.11.24 15:14, Simon Glass wrote:
> Hi Heinrich,
> 
> On Wed, 27 Nov 2024 at 07:00, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 27.11.24 14:07, Simon Glass wrote:
>>> Hi Heinrich,
>>>
>>> On Wed, 27 Nov 2024 at 00:07, Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>> Currently when booting dhcp_run() may be executed multiple times:
>>>> once in eth_bootdev_hunt() and once in the network booting bootmeth.
>>>>
>>>> We need to call eth_bootdev_hunt() when setting up the EFI sub-system to
>>>> supply the simple network protocol. We don't need an IP address set up.
>>>>
>>>> We can reduce the bootime by not executing dhcp_run() in
>>>> eth_bootdev_hunt().
>>>>
>>>> Furthermore eth_bootdev_hunt() with autostart=yes leads on the legacy
>>>> network statck leads to downloading a file via TFTP and to booting the
>>>
>>> spelling

I will handle that in my pull request.

>>>
>>>> downloaded file.
>>>
>>> I have now found the feature you're referring to - the calls to
>>> env_get_autostart(). Perhaps we can remove this feature? It seems
>>> pretty old and I don't see boards using it.

Commands controlled by autostart include bootelf, dhcp, tftboot.

For tftpboot autostart=no makes sense if you may want to download 
multiple files (kernel, initrd, dtb) before booting or the downloaded 
file is a firmware upgrade.

But for PXE booting you will need autostart=yes. Many routers allow 
recovery via TFTP.

For bootelf autostart=no leads to only checking the file in memory but 
not actually booting.

I don't think that we can simply remove the setting looking at the 
diverse use cases.

>>>
>>> That feature stops bootstd working properly.
>>>
>>> But if we don't remove it, we need to disable autostart in dhcp_run(),
>>> since in that case it does not behave correctly. I can do a patch for
>>> that if needed.

That change can be implemented separately from this patch series.

>>>
>>>>
>>>> Instead of running dchp_run() just check that there is a network device
>>>> in eth_bootdev_hunt().
>>>>
>>>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> ---
>>>> v2:
>>>>           reword the commit message
>>>> ---
>>>>    net/eth_bootdev.c | 30 ++++++++++++++++++------------
>>>>    1 file changed, 18 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/net/eth_bootdev.c b/net/eth_bootdev.c
>>>> index 6ee54e3c790..b0fca6e8313 100644
>>>> --- a/net/eth_bootdev.c
>>>> +++ b/net/eth_bootdev.c
>>>> @@ -64,9 +64,23 @@ static int eth_bootdev_bind(struct udevice *dev)
>>>>           return 0;
>>>>    }
>>>>
>>>> +/**
>>>> + * eth_bootdev_hunt() - probe all network devices
>>>> + *
>>>> + * Network devices can also come from USB, but that is a higher
>>>> + * priority (BOOTDEVP_5_SCAN_SLOW) than network, so it should have been
>>>> + * enumerated already. If something like 'bootflow scan dhcp' is used,
>>>> + * then the user will need to run 'usb start' first.
>>>> + *
>>>> + * @info:      info structure describing this hunter
>>>> + * @show:      true to show information from the hunter
>>>> + *
>>>> + * Return:     0 if device found, -EINVAL otherwise
>>>> + */
>>>>    static int eth_bootdev_hunt(struct bootdev_hunter *info, bool show)
>>>>    {
>>>>           int ret;
>>>> +       struct udevice *dev = NULL;
>>>>
>>>>           if (!test_eth_enabled())
>>>>                   return 0;
>>>> @@ -78,19 +92,11 @@ static int eth_bootdev_hunt(struct bootdev_hunter *info, bool show)
>>>>                           log_warning("Failed to init PCI (%dE)\n", ret);
>>>>           }
>>>>
>>>> -       /*
>>>> -        * Ethernet devices can also come from USB, but that is a higher
>>>> -        * priority (BOOTDEVP_5_SCAN_SLOW) than ethernet, so it should have been
>>>> -        * enumerated already. If something like 'bootflow scan dhcp' is used
>>>> -        * then the user will need to run 'usb start' first.
>>>> -        */
>>>
>>> Please keep this comment
>>
>> I have moved the comment to the function description. See above. I think
>> that is the adequate place.
>>
>>>
>>>> -       if (IS_ENABLED(CONFIG_CMD_DHCP)) {
>>>> -               ret = dhcp_run(0, NULL, false);
>>>> -               if (ret)
>>>> -                       return -EINVAL;
>>>> -       }
>>>> +       ret = -EINVAL;
>>>> +       uclass_foreach_dev_probe(UCLASS_ETH, dev)
>>>> +               ret = 0;
>>>
>>> There is a uclass_probe_all() function.
>>>
>>> My suggestion from the original series was to just do the dhcp once.
>>>
>>> How does probing the ethernet devices actually help EFI? It is not
>>> needed for bootstd, since it probes any devices it uses.
>>
>> bootstd is not the only way to start an EFI application, you could use
>> bootefi or bootm.
> 
> That's fine, but I'm just trying to understand what probing does, in
> this particular case. Doesn't EFI probe a device before it uses it? I
> think I am just missing some context.

EFI block devices will not even exist if not probed. See function 
efi_disk_probe().

For network devices I would like to change the code in a similar fashion 
in future to make all network devices available in the EFI sub-system.

Best regards

Heinrich

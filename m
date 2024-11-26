Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2694D5A6EB
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 07:42:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CDAF89BEB;
	Tue, 26 Nov 2024 08:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="JVHeOnId";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D89B89BEF; Tue, 26 Nov 2024 08:42:10 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 445C289BCD
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 08:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AD9763F84D
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 07:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732606927;
 bh=LLJXO03XIHTrPmjz4jBMyRAlF0VRHxO8zfS/ECJ6UiI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=JVHeOnIdA5d40e7ZhvpTvj89DIsMNe9dncS4kPzFVu0K/xBBiys/WwsJHdknPrgRM
 Wv6rPYFJynwjNWWaC9cZXcY3eWvQp5RvnCcIzM0wmMg8cIJ0Bszru0EW/OCCCvMrZt
 cawkXFLf6JHOikcpzZHJVcxZivf+DloFlamX1SSmFOYwbGQmxlFmet7AG3V89xOJ0+
 orGTTVNsJ/x8VCXdfDwjogjSU/qvni8myDsXhx1Ldj0MCAFIR6FNqtAUK994/1CUEe
 7KsKmEcgbSntpGSZcJu+8bhw/8mXiwxnD5PCd71eaPYbqeg2zfikOUOsiId6ZNyW+d
 B6Z3iL9Kk+H5w==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43499c1342aso18293815e9.1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 23:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732606927; x=1733211727;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LLJXO03XIHTrPmjz4jBMyRAlF0VRHxO8zfS/ECJ6UiI=;
 b=TV3ffMKFO7MGkpM1ZaM8AqKLg16sfGaoS5eNb+etaPXhHa8KHzxEQY9TDOT3PZmBDP
 73LLUog6Hyw+NzKCO6oSONuR3ZVkNOckGKD6PECtefvgHyKeVCFAUgOJd354ARlknSCs
 8H19ggg3d1Nfj/71MqmE+LkUsIlE9OicB6xhQwt0kysfDLmb73wR+Nh3LSkgCb1+INEh
 tmm+D5URM9Q+XQFJPxMZSBWLpX5OebNWa616rcrKntP4IQL1krhTS4OvKu73lPHEGC6a
 PGhGHoHoiL+Xk60KpZ8YODwVSt77mvjBaAo21R4PU5nDdPZi5nh6MTyAUyU4wWFeOr2b
 piUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwtHeg96XpuVfRlWOKhKqJ5FEYj+qfFwxiaYm8R/4G5KgrX6zoUpZS/WZmOEZylpxfEegfDMM=@lists.denx.de
X-Gm-Message-State: AOJu0YwqjNvLTdTWZOcTJHu5dBcHqQFoe6LCY7XSef8JMQFa/VyCRWxa
 jwDy5AnkWU0nkytKNLVjy0hBsZLKewcr9l2dD9WopLzsOeLNubTMXq5ZYgdvTtdL2JEg5dsQkvJ
 0E6sEo4y7NqJGVPx8lf7UAXFdRXJFsgehFgdIb0xlPVud6zM6mG701qBPxrRFYrOIGLc=
X-Gm-Gg: ASbGncvihoZCWz9ShreZZPk5bmJbEPXb78shIYo9a6rrXaw6OqJ6CeiU/n5pb5LntZb
 tE/JQvfmc4z8COJz1ifoQ6OS3hb5v5MwDqHy2AnqWoXy7pJYIwLb2AAJtMnRrSpb9iTKWvvT7AO
 S2Bglv6JWokxZEU3UxvTe2DErMfU+eNMFOs4qwdn/L9pw2yi/u5v5zlzTJR4W9Ptochtkslw21b
 XRvshbDTLPMCcLM/z5xA8ctFu+Vi3qNnQjYTyZT39UxNdCDsCurWREWb+wLpwjR5DVdaH1uQ5T6
 dAH/Y66x0ObqNSvG5lYCHmSeiRTb828xH8TZMGTdA92DVZY=
X-Received: by 2002:a05:6000:18ab:b0:382:5066:6f38 with SMTP id
 ffacd0b85a97d-38260b67c52mr12864893f8f.23.1732606927062; 
 Mon, 25 Nov 2024 23:42:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/6xXBC6Iptp5eMaj+IB/wrY9hK7p/fi0U2S4pHesR1JQsCTS6oHaZTCMvdlH0irJgIOK2bw==
X-Received: by 2002:a05:6000:18ab:b0:382:5066:6f38 with SMTP id
 ffacd0b85a97d-38260b67c52mr12864866f8f.23.1732606926690; 
 Mon, 25 Nov 2024 23:42:06 -0800 (PST)
Received: from [192.168.123.161]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825faf9a5asm12477127f8f.23.2024.11.25.23.42.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 23:42:06 -0800 (PST)
Message-ID: <f7706753-d4bc-484a-bf5d-f4b85205ac8e@canonical.com>
Date: Tue, 26 Nov 2024 08:42:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] net: eth_bootdev_hunt() must not try to boot
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
 <20241123214554.305285-5-heinrich.schuchardt@canonical.com>
 <CAFLszTgNguURurFAnX4W4mw8_Fokj2iCQOw15MCnFtT_zea6hw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTgNguURurFAnX4W4mw8_Fokj2iCQOw15MCnFtT_zea6hw@mail.gmail.com>
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

On 11/26/24 01:32, Simon Glass wrote:
> Hi Heinrich,
> 
> On Sat, 23 Nov 2024 at 14:46, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> eth_bootdev_hunt() should not execute dhcp_run() as this itself would load
>> a file and boot it if autostart=yes.
>>
>> Instead just check that there is a network device.
> 
> If you look at dhcp_run() you will see an 'autoload' parameter. This
> is 'false' in this code, so it never loads a file.

This is not the complete truth.

If $autostart=true and CONFIG_NET=y, dhcp_run(false) still tries to load 
a file.

In all cases dhcp_run() wastes boot time.

CONFIG_NET=y
=> dhcp_run
BOOTP broadcast 1
BOOTP broadcast 2
BOOTP broadcast 3
DHCP client bound to address 10.0.2.15 (1004 ms)

=> setenv autostart true
=> dhcp run
BOOTP broadcast 1
BOOTP broadcast 2
BOOTP broadcast 3
DHCP client bound to address 10.0.2.15 (1002 ms)
Using e1000#0 device
TFTP from server 10.0.2.2; our IP address is 10.0.2.15
Filename 'run'.
Load address: 0x40200000
Loading: *
TFTP error: 'File not found' (1)
Not retrying...

CONFIG_NET_LWIP=y
=> dhcp_run
DHCP client bound to address 10.0.2.15 (1007 ms)

Where command dhcp_run is provided by:

#include <command.h>
#include <env.h>
#include <net-common.h>
#include <vsprintf.h>

static int do_dhcp_run(struct cmd_tbl *cmdtp, int flag, int argc,
                   char *const argv[])
{
         ulong addr = hextoul(env_get("loadaddr"), NULL);

         dhcp_run(addr, NULL, false);

         return 0;
}

U_BOOT_CMD(
         dhcp_run,       CONFIG_SYS_MAXARGS,     1,      do_dhcp_run,
         "dhcp_run",
         NULL
);

Best regards

Heinrich

>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v2:
>>          new patch
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
>> -       if (IS_ENABLED(CONFIG_CMD_DHCP)) {
>> -               ret = dhcp_run(0, NULL, false);
>> -               if (ret)
>> -                       return -EINVAL;
>> -       }
>> +       ret = -EINVAL;
>> +       uclass_foreach_dev_probe(UCLASS_ETH, dev)
>> +               ret = 0;
>>
>> -       return 0;
>> +       return ret;
>>   }
>>
>>   struct bootdev_ops eth_bootdev_ops = {
>> --
>> 2.45.2
>>


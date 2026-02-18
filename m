Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9223AE9A04B
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 21:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC99B83AC5;
	Wed, 18 Feb 2026 22:36:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bltBv1B0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57CEC83B99; Wed, 18 Feb 2026 22:09:39 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62F6983AA9
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 22:09:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=filip.kokosinski@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4362507f0feso166738f8f.0
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 13:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771448977; x=1772053777; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language:subject
 :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jUrJ3qzEkcZICGC3XwNBaRa/h66e0038wLArOaD2oBc=;
 b=bltBv1B0EOD9X6BJ3MekWgU0r4E43BVFeXpCVKXjttqxH65kJWIaQbPI+RQB90yIlh
 Zyk3EUNdqiG84GMg6CnK0BKiqlMQ5lEvLgxCaEHHgwK4F578SqAFGh0414gm9EyHhvOL
 BeXrrTqeAPkzxj/3GpkSZo+4Y3Xxe+5LjB5JRvIFcl0JRy2AGzQxv5zWQCAP+ErVIZzm
 mvfMP0zX0cWQQ3ILnIl/nHtPvYJXEbkkFDvWJZ/LmMf6L1HeHB2PrCePtpwgcx647gps
 9VwvnuRmHIvZbTW6jd/sc4glUmG1X7qYfCi8c5d5XYCIhNBK+GmKGeziaiYj1XmL1JHF
 buEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771448977; x=1772053777;
 h=content-transfer-encoding:in-reply-to:from:content-language:subject
 :references:cc:to:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jUrJ3qzEkcZICGC3XwNBaRa/h66e0038wLArOaD2oBc=;
 b=YqLsrptYbkPiV+/6Bmj2GfSZHJJhZcNs/lDTE36nmw9Ay1dQrGNnAg68cwy1hdtTFw
 V1/QFuylS/gsSXgQcGHfU8t4kY53DHAt34PfKozFKDY6coCk144HJidiUYFK+MtmPcC0
 3j8fJw7jqosTysOqnoX0gaEXgCdKm4JsQUU3pp34xq2I8vReG/hgqpRONUxrY7C6BWk+
 kDaoQVNNNmBcp0rKrg1OlM9cgv0LsygQt2zJNcUtkWzCyChU1D7e6RpiOjDq2kXJwEUO
 iWR1MsQLsIId3cyUj+CTcACBwLikIjhBBxwiYXUn6Izk+3EzaOxxxeOWtycZwkC5YJ9a
 OOfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyeNqVoiqm3oaZXDr8bywxHmsYDmlr5z5mqVqqe7IHfce2sDU7TB8nPSXmKAjkZVz5hXIFqQI=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0HyxUaxylkFamtrvQhoJzI6vNaJ1py6nYc22WHrDa+ykMuxrp
 p+Oji55ba6LvW4cWC2OOxrZ4E1k7JvoMAoi7TTU26vmXUM5wp3UhspGN
X-Gm-Gg: AZuq6aKS7/mJgArLjz4x3h1r4483WGcyAAFO/HLxUmZrDFbogUyeIUnEtz5YlkJljn6
 gByG4EbggvvavtVHp+ztGNCvIMv+sVFV64C6iHnleMkQXikyV/i4VdIbPsNyy9NOVvtn1zQoMS+
 x1c3UeMBje07BRfIxUrgJoYQRfEuk/eSJpXpVY1mw+cYwrzOkvXFjp5gnwF4D29YrEX75Y9OYwr
 fcCaFRRBby7lfW0pWUCi5ujC5tblMatY1W6ke55a2K422302hhgiwA0AILpNcMcZrPos496lMrV
 3Oyye6BMtJg6jtCvROywO6LFvCstxv+3F2NmpjWmV2z6sj/13hZSsEp3+dC7IDWCma5egskUCMZ
 lBs+CDZsTEY1FTxdq0oEsAyA2nsQ7c6csCTC1rfFeaKWIFMQRbnVojVbKaQmIgzDRuBAiW8WpdC
 Pj3vfu7q3/rHavR0534eqRzruIN6JMBZAtk/boPDuM84ai+B9+zXisoHIqWdXPpvKYbWDqXmC7P
 A==
X-Received: by 2002:a05:6000:4381:b0:436:32ea:6ac7 with SMTP id
 ffacd0b85a97d-43796aefc72mr32369738f8f.40.1771448976569; 
 Wed, 18 Feb 2026 13:09:36 -0800 (PST)
Received: from [192.168.1.21] (83.23.192.36.ipv4.supernova.orange.pl.
 [83.23.192.36]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6a5f0sm42540972f8f.11.2026.02.18.13.09.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 13:09:36 -0800 (PST)
Message-ID: <f33431ba-85b1-47c0-9431-055a2f519c61@gmail.com>
Date: Wed, 18 Feb 2026 22:09:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: pbrobinson@gmail.com
Cc: filip.kokosinski@gmail.com, mbrugger@suse.com, u-boot@lists.denx.de
References: <CALeDE9MTfGaVt3p9h2oTt2KkJ8JDjauNT7oA4bnsHbP8C8aB7Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] board/raspberry: add FDT for bcm2712d0
Content-Language: en-US
From: =?UTF-8?Q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>
In-Reply-To: <CALeDE9MTfGaVt3p9h2oTt2KkJ8JDjauNT7oA4bnsHbP8C8aB7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Feb 2026 22:36:25 +0100
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

Hi Peter,

Thanks for taking a look at these patches and taking them for a spin!

 > Can you also provide details of which revisions of rpi devices you
 > tested this on?

I've tested this on the 16gb v1.1 -- it's the only bcm2712 device I've got,
unfortunately.

The EEPROM bootloader reports:

     4.07 BOOTMODE: 0x06 partition 0 build-ts BUILD_TIMESTAMP=1756339608 
serial b36eabd9 boardrev e04171 stc 4076083

The board_revision from environment is set to:

     U-Boot> printenv board_revision
     board_revision=0xE04171

Which matches what I can see in the dtb:

     U-Boot> fdt print /system
     system {
         linux,serial = <0xf849b6d5 0xb36eabd9>;
         linux,revision = <0x00e04171>;
     };

In Linux, /proc/cpuinfo reports:

     Serial        : f849b6d5b36eabd9
     Model        : Raspberry Pi 5 Model B Rev 1.1

Additionally, I can see that the EEPROM bootloader lists these dtbos, even
though I don't have them on my boot partition:

     9.15  /overlays/overlay_map.dtb
     9.16  /overlays/bcm2712d0.dtbo

I wonder what it lists for the c1 variant.

 > I have an 8gb v1.0, and I thought I had a v1.1 2Gb but looking closer
 > it looks like that's the old c1 SoC rev (I read their original
 > announcement for the 2Gb variant as they were all 1.1, it appears
 > not).

Do I understand correctly that the c1 reports as v1.1 as well, which causes
the bcm2712d0-rpi-5-b.dtb to match? If that's the case, I wonder how the 
EEPROM
bootloader differentiates between c1 and d0, as both have the 0x17 type.

 > I have ordered the new 1Gb variant so I have a revD I can test
 > against.

Looking forward to hearing about that from you!

Best
FK


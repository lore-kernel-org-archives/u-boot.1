Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A676CA1009
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 12:03:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 344A08350A;
	Wed,  3 Sep 2025 14:03:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="WAcdAy8f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D22F835B3; Wed,  3 Sep 2025 14:03:34 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD0B9834E5
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 14:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 138AB3F10A
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 12:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1756901011;
 bh=yULI7PK4V7tiocRSQJsEP64kv1WKJz1mEUhUDAvR38o=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=WAcdAy8fyxPX8mUO8e8qK9xXwVFZV3L0/KR42+SB90qZrZ4vuZJLoXGrWRm9Ulnge
 s2lG2xN7QwgsY45+kHsr3ml2Xdy//+ojznIhj/wG5fhFisXawF6rEDNQ1c29jCMalx
 ZV82WGbV9oBZXZS+q58xjfY+vggdztjuenBZJZ0F8haufbXLvXptCJ4uviLk7xljyl
 ZOzzWCztNP+/kHZqJQPr4tJywLZ3LQMVT9puGydcHnJQ5dk2S4VzDQ3VRYR6X8yfcC
 PbNQ+heqY3pm7ef/Pvv7KnFaS1RzfPvKOSqYLjHtddDWeKcXdh37tZu9haMEu08bej
 wtoA+ZiDoOQtQ==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45b71eef08eso34112935e9.0
 for <u-boot@lists.denx.de>; Wed, 03 Sep 2025 05:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756901010; x=1757505810;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yULI7PK4V7tiocRSQJsEP64kv1WKJz1mEUhUDAvR38o=;
 b=ESL8pWFzRYNTDhn8DelqCOowOCnFcOuaoZ5m+9iLGyl8NfEzh4h14B5THaNDVZNSMv
 4TJ5t4YnE8fBX2589oeUAjY7ggkMmL3HVp2QRQWvatjye4T3L3lInw0CExc/8FlpPSlG
 uGfNY6koAxsR5pFlgrvHAbRF72BzGK0o0zL2U99H2jlKx90aoCrewqySs3esZGoiIJyX
 VgE+UI/GGV3hL7RVwKFYFMKOc8UT0ui7ImplnHTaot+JbfiHzQ8a/FzsRo7xHik4Am1e
 3aRF27M8WEysbmkv8802mS9wsVClubfwTb9tqtqqnN8n63XQpTskC1KL+bANVoO16Qi6
 4FOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsmtgByP/uTo5rNl49aRpoNVuAgB1iBC43NMtXLv3G7WyWajNOZY1dN42koV3X/xFM9ROnTUU=@lists.denx.de
X-Gm-Message-State: AOJu0YyE/gTBcoG4UYO7+2FwRQTpglyU6vEvuIZEGPKdezk+03c0VNqY
 pNdrbFoBejwHbvw2hzYZyJD7JHjIBZ0cGxKMi2W/bhj3Ibs1+9OLShHBx3b35RnzIy8YHJc2nOl
 lsuqawB7wRf5kZTOadVQWyFTnmwJe7I58Ke9eGY0eL+SzWd77clqi4ivXEB2qt08yR2Hkp+I=
X-Gm-Gg: ASbGncsNS0hohkiTT+jVfX5tz2cYZKJP8Lac9I1p0+yXOxjEDtNefaC2s3BVKhM3tgY
 btBTYqb9LOeaJv3uG2XkUbuEIrrsQ2uKRr0sO4/W2GvDiFX/fWhNo2klM0oLZdtizVryqWJeQ98
 IC3y0I/qybOW8ZOlv5R2bidv7gtBip0YbrX7IliF0x+LlI2NgNeTdb8ZBQAbhAi7SScjGJQfsHE
 Nnb9Tew6djbBxoDQYkY5B5YvLnaHlzuIcthd+1HDe+HmIN68S4qfNnIfIYIee7dnWj3qdohe+IE
 48O1uRtpWNbCxylSS7ZP0HnmGNoyTXsE00qHsR2PHB5r7oeCJVGrczOroqttThzPIs1hEc2gQFY
 qZlsgIsD3L3dhROK64qu+P/Ow5HWu84uFPeS0Sw==
X-Received: by 2002:a05:6000:1ace:b0:3cf:74e0:55bc with SMTP id
 ffacd0b85a97d-3d1dd81ced7mr7611740f8f.8.1756901010054; 
 Wed, 03 Sep 2025 05:03:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqo2jMegQRv7w+vDaTjpJ58/hfagIw/gc8Nnr1N4S9XnmAdEMEpTAOoMZ0Pd1H2gSdB78L3A==
X-Received: by 2002:a05:6000:1ace:b0:3cf:74e0:55bc with SMTP id
 ffacd0b85a97d-3d1dd81ced7mr7611723f8f.8.1756901009560; 
 Wed, 03 Sep 2025 05:03:29 -0700 (PDT)
Received: from [192.168.103.116]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e8ab832sm237033655e9.23.2025.09.03.05.03.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 05:03:28 -0700 (PDT)
Message-ID: <8e2da9d1-b215-4af8-81d7-2e31690ce092@canonical.com>
Date: Wed, 3 Sep 2025 14:03:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 02/10] riscv: dts: starfive: Add VisionFive 2 Lite board
 device tree
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Hal Feng <hal.feng@starfivetech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 u-boot@lists.denx.de, E Shattow <e@freeshell.de>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-3-hal.feng@starfivetech.com>
 <3b75e20f-261e-4a23-b2b6-d4f4596b5fb3@freeshell.de>
 <aLghZaUyZZpUHOzP@sumit-X1>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <aLghZaUyZZpUHOzP@sumit-X1>
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

On 9/3/25 13:07, Sumit Garg wrote:
> On Tue, Sep 02, 2025 at 01:03:09PM -0700, E Shattow wrote:
>> Hi Hal,
>>
>> On 8/28/25 23:09, Hal Feng wrote:
>>> VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S SoC.
>>>
>>> Board features:
>>> - JH7110S SoC
>>> - 2/4/8 GiB LPDDR4 DRAM
>>> - AXP15060 PMIC
>>> - 40 pin GPIO header
>>> - 1x USB 3.0 host port
>>> - 3x USB 2.0 host port
>>> - 1x M.2 M-Key (size: 2242)
>>> - 1x MicroSD slot (optional non-removable eMMC)
>>> - 1x QSPI Flash
>>> - 1x I2C EEPROM
>>> - 1x 1Gbps Ethernet port
>>> - SDIO-based Wi-Fi & UART-based Bluetooth
>>> - 1x HDMI port
>>> - 1x 2-lane DSI
>>> - 1x 2-lane CSI
>>>
>>
>> Prefer to see subject line and URL of recent upstream discussion or git
>> web commit for the new or modified dts changes from upstream of
>> devicetree-rebasing in this commit and not just in the cover letter.
>>
>> + From upstream LKML discussion "[RFC 3/3] riscv: dts: starfive: Add
>> VisionFive 2 Lite board device tree" [1].
>> + 1:
>> https://lore.kernel.org/all/20250821100930.71404-4-hal.feng@starfivetech.com/
>>
>>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>>> ---
>>>   .../jh7110s-starfive-visionfive-2-lite.dts    | 152 ++++++++++++++++++
>>>   1 file changed, 152 insertions(+)
>>>   create mode 100644 dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts
>>>
>>> diff --git a/dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts b/dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts
>>> new file mode 100644
>>> index 00000000000..a0cb9912eb8
>>> --- /dev/null
>>> +++ b/dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts
>>
>> No, do not directly add or modify upstream dts in dts/upstream/src
>> subtree. We are not permitted in U-Boot to merge out-of-band devicetree
>> changes to the devicetree-rebasing subtree as this creates more work for
>> Tom, if I understand correctly?
>>
>> Instead add or modify this dts as
>> arch/riscv/dts/jh7110s-starfive-visionfive-2-lite-u-boot.dtsi filename.
> 
> That's right. dts/upstream subtree isn't allowed to be directly patched
> but it is rather synced regularly with devicetree-rebasing. So please
> follow documentation documentation here [1].
> 
> [1] https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing-with-devicetree-rebasing
> 
> -Sumit

Is mixing upstream dtbs and non upstream dtbs in CONFIG_OF_LIST 
supported by buildman?
Do files in arch/risc-v/dts/ override upstream files of the same name?

Best regards

Heinrich

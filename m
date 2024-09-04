Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1861CD37B4
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 14:10:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C074E88B88;
	Wed,  4 Sep 2024 16:10:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CpeEVRA3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EF8188C87; Wed,  4 Sep 2024 09:54:21 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DBBA8876E
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 09:54:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-374b9761eecso3151041f8f.2
 for <u-boot@lists.denx.de>; Wed, 04 Sep 2024 00:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725436458; x=1726041258; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vbHQxCb19vJW7viNThD6wnjzXXW6xPUCqSKxpFgtQPc=;
 b=CpeEVRA3+ZlSHqYKKL4Xvd7QWSJHCKJru+oZttQLpmQVRRwGhVR7weCYJ7bW+5po2X
 AQ89fCaHNWBroLj70xk3bBY+XXymtH5fiL+0P8xV4HR+i4KEhQuYPjBvLavWD7rKYuAR
 K6GFDyTDqoYpJH6jHtPv5MrP9eVqcphZOOO/O9qz/5Qwr3ESqqJxUa4n43iwNidOmzeV
 JUHP9HItByrhYfXfCZew3Wc8Bq7R7BSdKD4X56rbifWyJ3GAnDj++xbX/7Gwg8wIDUD/
 ZwQiUv79Qc3CYVGclPexUSIRX4nQWCpvi/tik/z9Sbjh6d5fcKKMIogCIjf4of9XEt0l
 tO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725436458; x=1726041258;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vbHQxCb19vJW7viNThD6wnjzXXW6xPUCqSKxpFgtQPc=;
 b=ekzCnVzOt7B/EWWADFGN/pJnFz2HZisaTLKTrL2wi1VZsKmmeANhWxTfoHGqFuoJiW
 Ye0kp4sJmX7m6GhNZ+zkJKTTyd5mLXMOBtCHHPZWSpqZjB6KhRngvzucP/WUHoPxqW4K
 ZR6Y/2uXXBI7qXwwLDi8ojeYtSjvSZWuimRyTouBq7nWbX0eOwIIlEvqPMrIzkUMRwds
 rR6UL/em0qt0Iq3LH/Pf8qcLa+2ChFCQdcgrFQfEI06WQtDhTH86cfAsYBlsJCoC0nRt
 /hPl4M9rWYEb/LgHZr9HMYRweeB9qyl7HjXtKAmt2tUsZNF/+YZ/3gFtl1oxGxu4wei0
 tsaQ==
X-Gm-Message-State: AOJu0YwTu3fvtJ5HEw7W6aZ8P9fEa61phfSDkdn0dxHAEPgyQ2wBJ0p/
 eJNM7Fs0OGqw4mXJ81+qMeloi6ez39T1mRWuspK9gSYFOOV7pHYaYuJbDN1nQ+s=
X-Google-Smtp-Source: AGHT+IH+wJG3e7YYy3rQZe08lKZgNLvmyqxPgtGBTmXGlomY8+q+mGXwPM4lCyWGNH5QkyeV4fGNkg==
X-Received: by 2002:adf:e9cc:0:b0:368:3731:1613 with SMTP id
 ffacd0b85a97d-374bce97f9dmr8246547f8f.13.1725436457789; 
 Wed, 04 Sep 2024 00:54:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:5602:dc19:f2fc:9ef3?
 ([2a01:e0a:3cb:7bb0:5602:dc19:f2fc:9ef3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374ba3da654sm12537935f8f.89.2024.09.04.00.54.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Sep 2024 00:54:17 -0700 (PDT)
Message-ID: <a946cdb4-648c-46a7-83c5-302ab0d666d3@linaro.org>
Date: Wed, 4 Sep 2024 09:54:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 20/37] net-lwip: add DHCP support and dhcp commmand
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>, Tom Rini <trini@konsulko.com>,
 Gilles Talis <gilles.talis@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Nishanth Menon <nm@ti.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Petr Zejdl <petr.zejdl@cern.ch>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Eddie James <eajames@linux.ibm.com>, AKASHI Takahiro
 <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Maxim Moskalets <maximmosk4@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>, Artur Rojek <artur@conclusive.pl>,
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
 Yang Xiwen <forbidden405@outlook.com>, Gabor Juhos <j4g8y7@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Boon Khai Ng <boon.khai.ng@intel.com>, Robert Marko <robert.marko@sartura.hr>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
 <36a13357261f734187444b48b74dec2540e73b86.1724419624.git.jerome.forissier@linaro.org>
 <CAFLszTi3YRpf4krkAYE1u7Sex0=Dn_YscSKxE8mQEh9Mxcgjow@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAFLszTi3YRpf4krkAYE1u7Sex0=Dn_YscSKxE8mQEh9Mxcgjow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 04 Sep 2024 16:09:57 +0200
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

Hi Simon,

On 8/29/24 16:05, Simon Glass wrote:
> Hi Jerome,
> 
> On Fri, 23 Aug 2024 at 07:49, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Add what it takes to enable NETDEVICES with NET_LWIP and enable DHCP as
>> well as the dhcp command. CMD_TFTPBOOT is selected by BOOTMETH_EFI due
>> to this code having an implicit dependency on do_tftpb().
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  board/engicam/imx8mp/icore_mx8mp.c            |   2 +-
>>  .../imx8mp_debix_model_a.c                    |   2 +-
>>  board/ti/am335x/board.c                       |   3 +-
>>  board/xilinx/common/board.c                   |   3 +-
>>  boot/Kconfig                                  |   3 +-
>>  cmd/Kconfig                                   |  91 +++---
>>  cmd/Makefile                                  |   6 +-
>>  cmd/elf.c                                     |   2 +-
>>  cmd/net-lwip.c                                |  13 +
>>  common/board_r.c                              |   4 +-
>>  common/usb_kbd.c                              |   2 +-
>>  drivers/net/Kconfig                           |   2 +-
>>  include/net-lwip.h                            |   3 +
>>  lib/tiny-printf.c                             |   3 +-
>>  net/Makefile                                  |  14 +-
>>  net/lwip/Makefile                             |   5 +
>>  net/lwip/dhcp.c                               | 125 ++++++++
>>  net/lwip/eth_internal.h                       |  35 +++
>>  net/lwip/net-lwip.c                           | 286 ++++++++++++++++++
>>  net/lwip/tftp.c                               |  11 +
>>  20 files changed, 560 insertions(+), 55 deletions(-)
>>  create mode 100644 cmd/net-lwip.c
>>  create mode 100644 net/lwip/Makefile
>>  create mode 100644 net/lwip/dhcp.c
>>  create mode 100644 net/lwip/eth_internal.h
>>  create mode 100644 net/lwip/net-lwip.c
>>  create mode 100644 net/lwip/tftp.c
>>
>> diff --git a/board/engicam/imx8mp/icore_mx8mp.c b/board/engicam/imx8mp/icore_mx8mp.c
>> index e2ed70caa43..bfdc447c478 100644
>> --- a/board/engicam/imx8mp/icore_mx8mp.c
>> +++ b/board/engicam/imx8mp/icore_mx8mp.c
>> @@ -33,7 +33,7 @@ static void setup_fec(void)
>>         setbits_le32(&gpr->gpr[1], BIT(22));
>>  }
>>
>> -#if CONFIG_IS_ENABLED(NET)
>> +#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)
> 
> How about making NET mean 'net', rather than having two options?
> 
> Perhaps the existing NET needs to be renamed to NET_INTERNAL or
> something like that?

The problem with that is it will make it a bit harder to remove
the legacy NET implementation, because every occurrence of
"if NET" would need to be questioned if it is applicable to
NET_INTERNAL only or to NET_LWIP too. IOW, some of the thinking
already done here would need to be done again.


>>  int board_phy_config(struct phy_device *phydev)
>>  {
>>         if (phydev->drv->config)
>> diff --git a/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c b/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c
>> index 112770ba493..c709d017483 100644
>> --- a/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c
>> +++ b/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c
>> @@ -29,7 +29,7 @@ static void setup_fec(void)
>>         setbits_le32(&gpr->gpr[1], BIT(22));
>>  }
>>
>> -#if CONFIG_IS_ENABLED(NET)
>> +#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)
>>  int board_phy_config(struct phy_device *phydev)
>>  {
> 
> [..]
> 
> Regards,
> Simon

Regards,
-- 
Jerome

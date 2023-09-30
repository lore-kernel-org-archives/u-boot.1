Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84D6E748F0
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 23:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD42E87083;
	Sun,  1 Oct 2023 01:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="n+fexnWX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3993E87086; Sun,  1 Oct 2023 01:05:48 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70C6487078
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 01:05:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 71E3F421D6
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 23:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1696115143;
 bh=muLuvxM6kwEGi6tFltPaZM6+XhVc41+5i+genwbmwJE=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=n+fexnWXCTBXtsPo6PxL2m73uQCe8N2CxKpR9BOFe+c46XfJfuXKkFSrYV3ZYWDj9
 ZuXLQ3xuT0Am5PaOKwxwIPCtKuYlctYTWk4xKWdzs/fw/Xl7VA74D+LV9A8B1+vc2V
 ACSGmrETb9ee+8xpuMUUIpH+UsA6Zy7YTOwPkfgQnatYmXyCAEsN+EwKyO2ThQA6Gf
 VGhYRhdlxXXvnUlHyHus1hdogCIquBBqGfV3LulmjQip1e3T+1bUwU+T3amMZ2gv58
 eZ0kLjbXQWecwBZZQmdhSBRY6af/XkJnoKN6uPHuCze/D6gjeHruLmogiOtDguFqTs
 UN3UasfHzGN/w==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3231d7d4ac4so9352377f8f.0
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 16:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696115142; x=1696719942;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=muLuvxM6kwEGi6tFltPaZM6+XhVc41+5i+genwbmwJE=;
 b=Lkbh894i2SiOVum/aeauZ4znUmrRcNTDMVyD2eae1++83fUNVecJG9ZT0rSFmYGFIw
 C/YWWMnVvCqC+0eArqTPNiClAlu3j0al9d/USxqvtgk4qePhwqzLtFzh6SdglSb0bKXx
 huI1UQ5DWNpyEoWLyqaDwSJ4ir25ooqF1G/7nXXRwIiASVj4Oxoxu31NSfYIlg9N/Z8n
 wikuMMbJdLvUlki+HKK4nj1WvNlyRRR+gVnYSYKTw8B629rjyIdMXCnvzS9Ph9VJdx01
 jmZC3Tpilp/4f3MuGB8iwDBTUVh8vJZlYnfD1MOL8yRtH+4PJCMY//8oqCq8l9mEvV1N
 MB3A==
X-Gm-Message-State: AOJu0YxjXgeUiIHIA9e1t8KaCbR9UkbAzN8rUNHuEF3VbaX4EYmoZvCJ
 HxGGw0ApJVBof9sLm+we5hWIkZk7oUt6F/xctZqHDXHkY34wy7myc+rhytEtCjW9RK7c6v1g65x
 UHy/uIc+vM6EramYfAnJz4uRZcHfuReU=
X-Received: by 2002:a5d:6a02:0:b0:31f:facb:e1ba with SMTP id
 m2-20020a5d6a02000000b0031ffacbe1bamr6021335wru.70.1696115142061; 
 Sat, 30 Sep 2023 16:05:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEQ5CeuDyJnwDOyZ71ltnm1tJCYvdXzHUaVBuJqJpimgZ0Qg5IbVWECiNBGdB0UKRAx3lE8Q==
X-Received: by 2002:a5d:6a02:0:b0:31f:facb:e1ba with SMTP id
 m2-20020a5d6a02000000b0031ffacbe1bamr6021309wru.70.1696115141589; 
 Sat, 30 Sep 2023 16:05:41 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 k10-20020adfd22a000000b0032320a9b010sm16724358wrh.28.2023.09.30.16.05.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Sep 2023 16:05:41 -0700 (PDT)
Message-ID: <4f4cf98d-a228-44e6-a014-0afff12357e3@canonical.com>
Date: Sun, 1 Oct 2023 01:05:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] cmd mac: separate implementations
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Green Wan <green.wan@sifive.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Roger Knecht
 <rknecht@pm.me>, Neil Armstrong <neil.armstrong@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Dzmitry Sankouski <dsankouski@gmail.com>, u-boot@lists.denx.de
References: <20230930120147.59482-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20230930120147.59482-1-heinrich.schuchardt@canonical.com>
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

On 9/30/23 14:01, Heinrich Schuchardt wrote:
> There are three implementations of the 'mac' command:
> 
> * Freescale (NXP)
> * SiFive Unmatched
> * StarFive VisionFive 2
> 
> They all use different sets of sub-commands and hence should display
> a different long text help.
> 
> This series moves the command definition to the three implementations.
> 
> The following fixes are added for the StarFive implementation:
> 
> * Provide a hexdump if the data format is unknown.
> * Provide a raw sub-command to force a hexdump.

I have tested the series on the Unmatched and VisionFive 2 boards but 
lack access to NXP hardware. So these patches need to be tested by one 
of the NXP maintainers.

Best regards

Heinrich

> 
> Heinrich Schuchardt (6):
>    cmd: move mac command
>    freescale: fix long help handling in mac command
>    eeprom: SiFive Unmatched: re-implement mac command
>    eeprom: starfive: re-implement mac command
>    eeprom: starfive: raw dump if unsupported data version
>    eeprom: starfive: add 'mac raw' command
> 
>   board/freescale/common/sys_eeprom.c           | 30 +++++++-
>   .../unmatched/hifive-platform-i2c-eeprom.c    | 30 +++++++-
>   .../visionfive2/visionfive2-i2c-eeprom.c      | 68 ++++++++++++-------
>   cmd/Makefile                                  |  1 -
>   cmd/mac.c                                     | 33 ---------
>   5 files changed, 98 insertions(+), 64 deletions(-)
>   delete mode 100644 cmd/mac.c
> 


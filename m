Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F71C9830E
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 12:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3655481BA8;
	Thu, 24 Sep 2026 12:02:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wJBMeWc7X6jq; Thu, 24 Sep 2026 12:02:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2880481916
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790251374;
	b=aoyl/Irt+yKNcTgWpZk38kIlyYQndjNU4MNyl4Vao+P2IpF45laAGCJwS8UtcaU4wUJi
	 G5V6hh+8YmL2Fijuwy7569cinWf47DH2K/4T7AqpHIKq3Xi3a8HUc4xsbBWg3nLQ2BjzU
	 cGnd181Wum0iq9yAltLe/Cb7i7JT1WD5dbiAx++elTuMh/OaCPY+elXy6yopegcu/hiPd
	 g2SBPK2oBJwg/MTKS7ayaZemmXTN6d/50acW2MGnN94zFxxRIrqOoJcGbMwu+CkenEio+
	 QE1t0Ulg9XlitNh8+8AeVX/s3rOc8VM2aO9HjW0bUmA+yJ+PmcbHDA6C4WNeN1kPF9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790251374;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IGkO8y97O98E1WAmhwm4a3OabdiVbk9I7mymNOwDC2Q=;
	b=Fl0Lks0vpTBV8zkaf9tmvHFFA4895yiyDeHPekgvgLdO5lrhYIiAXfgroABtpTiExvyt
	 JPR+JlerOKWk6DNHFX6YOhc8Ppqr4yzRGbruwF+X6YbzEwJCyo4me1MhDhwP4+eenjPkQ
	 VutEwJmrneHtcMrsYxjGZBiBX831jihSzCKNnrEc22PkCX+UlV9wd7pPZKAbx5+93Vkai
	 9SeSevZuHZ/+d68lnoXe1U5qJ4vlbwF9fTzQRWnRGi7QbApY0q4XEoHV+hR4wA2gfoA3c
	 owhtBiQ6qGzoPxGkaC7q2/0+i+MgsR0vb/OItJrQwixvDaSYkjMRCu3y5MeOWQsWfcg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790251374;
	bh=IGkO8y97O98E1WAmhwm4a3OabdiVbk9I7mymNOwDC2Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HY+//wwotIs7LRwPsYCfTZLEnIF3D/eamJA4YwK/T+ac1bre4SojTpYpesB6jm2cy
	 a7Hin3+ga/agUgW7eV8KRBZvAkjupy2dkw2TwPod6GjTSfTDB19133S8fUIneJJjQm
	 hMDiqiXiIicTk/t32vFw6YmTy6IdbDB7NIcN8fFf4IiX9hp598lz8tIx4yHunOJmT0
	 fFgWdWIMbAPuaIIXjVtrppp0D0i9hxNDul06XEIoEGj/1/bokYQlNYO5sHx0+f29Cv
	 McUt6MnvTV+PoEyQ1/P+fj3PFjaXieX7qO2cmB8Mm6zHb6fvIJ1O2uwLQU4gJ3pk23
	 frNduGUM2A7sQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2880481916;
	Thu, 24 Sep 2026 12:02:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E85B2F5
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:02:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 57FA440456
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:02:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ORhUWa5fGjsb for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 12:02:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1F0FD40390
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790251371;
 b=a7i9eQkcUwGve/1da3qPYzYkcyL9Shs0cwU4/f/w5+GCWLubW8RNX/qsStd6cnSetKG4
 71yEmjgtJ0fBIsLbbhBvJ/0WuGTQmGeM2am4qIBKYWDoi7dqQqIlXHHYOtQdbnqeKupAK
 f3pF3bzkWJzUXInrTIgirbtIY3bW2Cde+3WxY1r0oePuAoT1VClLBUoeRBZ7VmuqveBGW
 R13J4lJlnvcvbiHYNtcTD54U6o+zz2pvuWa8THShyqM3U4K+JAq8QZFgP7v1s/6Xt4YIA
 iNSYoCdiM41mvuudKLuO2zVbBlNe3B8+LCUC8oMYRgTT11uyUHsVluQHHjMzfoA5Ysg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790251371;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=IGkO8y97O98E1WAmhwm4a3OabdiVbk9I7mymNOwDC2Q=;
 b=N8uGM9lmiCxML+MLYDiDrBbpXvLui5AKqYeuGjFbVBy1nkdTB4mqTirEP1mdL8ApT7Qh
 I5VIE0TOBHX7/lhOOZk1nlgfFuoL1pvFi7dAIZXmVtsxbhD3eXd0mJoa42qPhxHMLBATR
 uHxfO8zeCZOspwpx4wVFg95z9pfiBqVwFG/4Q5V6d/T1l5y60l/bj11L5uJ48W4+ayc+u
 a25JUbVckoGQI6dGAwfC9Bz5KExi3yPO8Z8rG7UbevbBUxKV19y7LPDJHmpycAZSIPDoi
 3/srF4n0pTfI0xbU3zUjArbKdRXe5u+FnX+0+QXQk0lGIAJw1XRNi6id14NlIWkmwxQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=FSsKZ0Mq; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=FSsKZ0Mq
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1F0FD40390
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:02:50 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485b1d2874fso773984f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790251368; x=1790856168;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IGkO8y97O98E1WAmhwm4a3OabdiVbk9I7mymNOwDC2Q=;
 b=FSsKZ0MqckLwyo9UNalOCOPZ6rvhSxeL3E+qpeewqj3fnoibDtVLxtp1WC4jZy5JXc
 fYag+SA+A7myfSfVWIamMmodlx/nIItGjcxpaxoIZSyIs0hjCjukG1kA1wEOBTNd34KY
 8sho0v+InyJ5xBYzxdc19nyHZ6sTDk5C/Z2Q9R0D7gKwWpL5LgMy9MiQict5Qlz2f+QP
 S1UrbjqJ6pbUo6Pc61R3fwBraG0ctSHTCi6uR/nOJqUM3zFMWOaIXkuRgSqo6eeIKr7V
 m757ENMPJthwQRn8U/8TLgcI2roSH3BkwtpU68jc0FlhVdOh5gM25t8tou8gg4snBAq2
 q29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790251368; x=1790856168;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IGkO8y97O98E1WAmhwm4a3OabdiVbk9I7mymNOwDC2Q=;
 b=a7/rm5hfZ4B32ghgW6YSeY8SvO0m6WicWylubB9ZXslp43RjWb3pxqUtxxu+sIZyqy
 Wf6upgmQeacmR1BnAe66svKH3yJpfqCnc+KGDQPkX0ibGhvzkSlXG2r//joHoy4Bri2P
 wBS2jVIxHK3FEOFKivW5zKaUG+mx5pvAtt/Npp2Htd4RJLilIVghUr7witBEPAS13XUd
 8HEsJd46B/kd0JimbCkXfAverGSBQG9mJksG8dOk8a5jVTmL7PblF8ROfkSO3316Dize
 nM4rlmiTx7r+yA6QlpRddaJtl40d6UBqtP2vj1GNhyRwPhIpt3atSVNZKkoz+MkD2ZEo
 Opmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSmp2veTWkGq4XdUFep4dAqvxeQ0LWpWqPTCwPy+RSb+jcgcjeiGp9Z8FSc18iNvPOXTAwwKQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lfEbiFEmoCr/7W8GV5HxqQH/Yz1qsCe+6ow09kx1MVR6YEfLUX
 S6+KeSRyOr1H441HVA2goVYqygChYh3ZUmy8+LzXHnEcguyoaOfsOX/rddCtT1ZwkLY=
X-Gm-Gg: AYBFou19bAqsfY8hwpTEKf8J8Qek9/Sy+73GWDy1d+fNLaftsHcawSWjvuof2pOK6C2
 Mz+sLppw/mKg24hFNEpPjVuvgaMIu/OgDb94BZ95H6dhho4OmT6ZXunIkQ/H+UwRwJL9cLWYOHN
 Wm0DghVzWfOAApslPcafk8AI2VVDwmfK4YoII9M45P/cKcFTpGfG9gUDA/U5wxnVqtVtPeoHzmb
 MlNPmwLjqXQz9509iillKtG2t1iOV5HoM/PoOJH1uufNU16Fi5yQ6e+JTlExC7aMLcY5AmCKzUE
 shEMIWEzTQ20ZKjZ7Ilp48pvCCg3TYLW3xlbMWYlx3ZHqxOBcjHo7B5tNFY3LEo9hiLVJ1GCKiA
 3pg0BX9ZxH+2YohvD4bQK0qlgKyLar7G91Qy1+hEu3GCqxJ+Jywo4DEWSpe65+Xgu+x4/3viEN8
 jvDycHK3PS7xxgz4T32nETPvSEMNaqzZMti7PeJmoXe+RpkN7xhyLdOx8rnx/GYkm1Z53C7hGJ3
 eMTR/16I0M=
X-Received: by 2002:a05:600c:609b:b0:49f:ddbd:1f51 with SMTP id
 5b1f17b1804b1-49fe66fa2c9mr38555855e9.15.1790251366922; 
 Thu, 24 Sep 2026 05:02:46 -0700 (PDT)
Received: from [172.18.183.38] ([185.104.138.114])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe0c77b8csm85011225e9.3.2026.09.24.05.02.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 05:02:46 -0700 (PDT)
Message-ID: <00b6f81d-9dd0-43ca-861f-37981098b4f0@linaro.org>
Date: Thu, 24 Sep 2026 14:02:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cmd: qcom_geni: add idempotent qcom_geni fw init
 command
To: test <vandhiadevan.karunamoorthy@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Peter Robinson <pbrobinson@gmail.com>
References: <20260924-series3-oem-spi-nor-init-v2-0-fd8ac27e7057@test.com>
 <20260924-series3-oem-spi-nor-init-v2-2-fd8ac27e7057@test.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260924-series3-oem-spi-nor-init-v2-2-fd8ac27e7057@test.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org



On 9/24/26 12:24, test wrote:

i think your gitconfig might be missing something heh

> From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
> 
> geni_se_of_to_plat() caches need_firmware_load once at bind time by
> scanning each child's FW_REVISION_RO register. qcom_geni_fw_initialise()
> only ever consults that cached flag, so it cannot detect firmware that
> was loaded after bind time, and a second call cannot pick up a wrapper
> that still needs firmware if storage became available later in boot
> (e.g. after a fastboot-triggered re-probe).

your llm context is leaking

this is barely comprehensible and I can only even guess based on your 
other series, which takes a specific approach to solve the specific 
problem where this is just a recipe for a huge mess of horrible 
intertwined dependencies.


> 
> Extract the scan into geni_se_needs_firmware() and re-run it inside
> qcom_geni_fw_initialise() against live hardware state instead of only
> trusting the cached flag, so repeated calls are safe: a call with

"live hardware state" who is this email for??

> nothing left to load is a no-op that returns success.

so many wasted words

> 
> Expose qcom_geni_fw_initialise() and add the 'qcom_geni fw init'
> command so a retry can be triggered manually or from other subsystems
> without hardcoding SoC-specific calls into generic code.

why would we ever want this? no, if you have a specific workflow for 
factory flashing or something that you want to support here, then we can 
look at how to do that in a non-invasive way

there absolutely are issues with how this all works today, these should 
be fixed in DM ideally, but before that we need to drill down what the 
issues actually are.

NAK>
> Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
> ---
>   cmd/Kconfig                    |  9 +++++++++
>   cmd/Makefile                   |  1 +
>   cmd/qcom_geni.c                | 26 ++++++++++++++++++++++++++
>   drivers/misc/qcom_geni.c       | 24 ++++++++++++++++--------
>   include/soc/qcom/qup-fw-load.h |  7 +++++++
>   5 files changed, 59 insertions(+), 8 deletions(-)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index c71c6824a19..453ee94f6f5 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2884,6 +2884,15 @@ config CMD_SCMI
>   	  This command provides user interfaces to several SCMI (System
>   	  Control and Management Interface) protocols available on Arm
>   	  platforms to manage system resources.
> +
> +config CMD_QCOM_GENI
> +	bool "qcom_geni - Qualcomm GENI SE firmware control"
> +	depends on QCOM_GENI
> +	help
> +	  Provides the 'qcom_geni fw init' command, which (re)loads firmware
> +	  for Qualcomm GENI SE wrappers that still need it and probes their
> +	  dependent children (SPI/I2C/UART). Useful to retry firmware loading
> +	  once it was previously skipped.
>   endmenu
>   
>   menu "Filesystem commands"
> diff --git a/cmd/Makefile b/cmd/Makefile
> index bbbdfcc4ded..1db96718938 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -164,6 +164,7 @@ obj-$(CONFIG_CMD_KASLRSEED) += kaslrseed.o
>   obj-$(CONFIG_CMD_RKMTD) += rkmtd.o
>   obj-$(CONFIG_CMD_ROCKUSB) += rockusb.o
>   obj-$(CONFIG_CMD_RTC) += rtc.o
> +obj-$(CONFIG_CMD_QCOM_GENI) += qcom_geni.o
>   obj-$(CONFIG_SANDBOX) += host.o
>   obj-$(CONFIG_CMD_SATA) += sata.o
>   obj-$(CONFIG_CMD_NVME) += nvme.o
> diff --git a/cmd/qcom_geni.c b/cmd/qcom_geni.c
> new file mode 100644
> index 00000000000..31cb3f454d4
> --- /dev/null
> +++ b/cmd/qcom_geni.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2026 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <command.h>
> +#include <linux/string.h>
> +#include <soc/qcom/qup-fw-load.h>
> +
> +static int do_qcom_geni(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +{
> +	if (argc != 3 || strcmp(argv[1], "fw") || strcmp(argv[2], "init"))
> +		return CMD_RET_USAGE;
> +
> +	if (qcom_geni_fw_initialise())
> +		return CMD_RET_FAILURE;
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
> +U_BOOT_CMD(qcom_geni, 3, 1, do_qcom_geni,
> +	   "Qualcomm GENI SE firmware control",
> +	   "fw init\tLoad QUP firmware for GENI SE wrappers that still need it and\n"
> +	   "\t\tprobe their dependent children (SPI/I2C/UART). Safe to run again\n"
> +	   "\t\tonce firmware is already loaded.\n"
> +);
> diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
> index 2e8f72d5c8e..41a6fd153a3 100644
> --- a/drivers/misc/qcom_geni.c
> +++ b/drivers/misc/qcom_geni.c
> @@ -396,14 +396,11 @@ int qcom_geni_load_firmware(phys_addr_t qup_base,
>    * We need to determine if firmware loading is necessary. Best way to do that is to check the FW
>    * revision of each QUP and see if it has already been loaded.
>    */
> -static int geni_se_of_to_plat(struct udevice *dev)
> +static bool geni_se_needs_firmware(struct udevice *dev)
>   {
>   	ofnode child;
>   	struct resource res;
>   	u32 proto;
> -	struct geni_se_plat *plat = dev_get_plat(dev);
> -
> -	plat->need_firmware_load = false;
>   
>   	dev_for_each_subnode(child, dev) {
>   		if (!ofnode_is_enabled(child))
> @@ -417,9 +414,18 @@ static int geni_se_of_to_plat(struct udevice *dev)
>   		proto >>= FW_REV_PROTOCOL_SHFT;
>   
>   		if (proto == GENI_SE_INVALID_PROTO)
> -			plat->need_firmware_load = true;
> +			return true;
>   	}
>   
> +	return false;
> +}
> +
> +static int geni_se_of_to_plat(struct udevice *dev)
> +{
> +	struct geni_se_plat *plat = dev_get_plat(dev);
> +
> +	plat->need_firmware_load = geni_se_needs_firmware(dev);
> +
>   	return 0;
>   }
>   
> @@ -496,7 +502,7 @@ static int probe_children_load_firmware(struct udevice *dev)
>    * Load firmware for QCOM GENI peripherals from the dedicated partition on storage and bind/probe
>    * all the peripheral devices that need firmware to be loaded.
>    */
> -static int qcom_geni_fw_initialise(void)
> +int qcom_geni_fw_initialise(void)
>   {
>   	debug("Loading firmware for QCOM GENI SE\n");
>   	struct udevice *geni_wrapper, *blk_dev;
> @@ -506,19 +512,21 @@ static int qcom_geni_fw_initialise(void)
>   	size_t fw_size = MAX_FW_BUF_SIZE;
>   	struct geni_se_plat *plat;
>   
> -	/* Find the first GENI SE wrapper that needs fw loading */
> +	/* Find the first GENI SE wrapper that still needs fw loading */
>   	for (uclass_first_device(UCLASS_MISC, &geni_wrapper);
>   	     geni_wrapper;
>   	     uclass_next_device(&geni_wrapper)) {
>   		if (device_get_uclass_id(geni_wrapper) == UCLASS_MISC &&
>   		    !strcmp(geni_wrapper->driver->name, "geni-se-qup")) {
>   			plat = dev_get_plat(geni_wrapper);
> +			/* Refresh against live hardware state for repeated calls. */
> +			plat->need_firmware_load = geni_se_needs_firmware(geni_wrapper);
>   			if (plat->need_firmware_load)
>   				break;
>   		}
>   	}
>   	if (!geni_wrapper) {
> -		pr_err("GENI SE wrapper not found\n");
> +		debug("GENI firmware is already initialized\n");
>   		return 0;
>   	}
>   
> diff --git a/include/soc/qcom/qup-fw-load.h b/include/soc/qcom/qup-fw-load.h
> index a67a93c72a4..f4417fc1baf 100644
> --- a/include/soc/qcom/qup-fw-load.h
> +++ b/include/soc/qcom/qup-fw-load.h
> @@ -175,4 +175,11 @@ struct udevice;
>   
>   int qcom_geni_load_firmware(phys_addr_t qup_base, struct udevice *dev);
>   
> +/*
> + * Load firmware for QCOM GENI SE wrappers that still need it and probe
> + * their dependent children. Idempotent: a call with nothing left to load
> + * is a no-op that returns success.
> + */
> +int qcom_geni_fw_initialise(void);
> +
>   #endif /* _LINUX_QCOM_QUP_FW_LOAD */
> 


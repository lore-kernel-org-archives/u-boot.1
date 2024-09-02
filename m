Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24508CD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 13:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AF9888B4B;
	Mon,  2 Sep 2024 15:24:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rC9sMoYV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35FC388BFB; Mon,  2 Sep 2024 15:24:36 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25E3788B49
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 15:24:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f50f1d864fso48392831fa.1
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 06:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725283473; x=1725888273; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MEr+V1nwUl8MonHhzdGso9Fmx0TBJwlEY12+4+wIit0=;
 b=rC9sMoYVlNhZBvwfk5+8VgGhoj/sVpUasZcVgttlPp7HBChzLEBPvDXnD1wlQjtl3S
 wvqlKV2DnhCbe/E4yXZiOBBBfnACnQJnl2gHVGtKfiA7ExEcnLS3aRgISJJcipdw6Bd3
 AS3saRa2cCf1KTLwkfsPCwO/042H0QIKYlUhwZuCLeb0WXm1gqPZ4zeS7hH+9pSM6NTK
 Rqb2eZ8DxtP1We3z32vu+m6TpiLwMowMEzyDe2bnymp0NKyIWEUbmxY6mOWjMHgkrIkX
 q3B3i2fbpcQ6CBeYpyyMR316JaQqB5j1LPSRnLOZ1j5Ix9zngfhklfoP/MWBM1ss34Qx
 uL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725283473; x=1725888273;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MEr+V1nwUl8MonHhzdGso9Fmx0TBJwlEY12+4+wIit0=;
 b=EWaGuxbInoGxsiEFvBEdrtxS2aRlovt1chIz/BpLH86vnGZ+WslF90DOeWaJw4kyi9
 NVc2RgFmalSpR9xQL0Dlqiu0RoCUHW0siFhMlXtsgpVQa1QIXRiBOzTf6p95OJuzqSnv
 xrKfuweYid6QJfyG2pBaaKzCgOUbUBObCB183h0Tvi48ZKurNCtQGepM4iCGW1t6BXon
 JhhsuU2QXOmiMQk42a7c28o2PkY8KC1I9ooAjxY1aHL40oMFVBoRox8xXLi0E3iAjPA/
 9UIicOp/oi5AjYYscWQHMEdlDblVMJs53ux1Tg31E45f9Kkue4aTFJCEvdPfRLf6oCEY
 mDHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtGAw0msvsQTFjUt5/SuBd5iQm2BI/sNZcpFF8nNBG0qabRKSIqwOfRcIcvPigG40KlbtWDyI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7+zXTxQ3dB5OLSyfXle4flaLg8lwNkJrEb8+WQ7DFYvMrIzff
 RsIz6lIhtu1dWY9CeTuuXjiAfnngAeqIaKPs1W6FnZrpYjlSUQnPyFZDRvTcSfc=
X-Google-Smtp-Source: AGHT+IE1QPV14L1rvW7SoHj2xNGoLK3dZmePD2ADPFWR7GR1K/Qho0lGSb4jjvuwzod5BhJEDkaIbg==
X-Received: by 2002:a05:6512:ea7:b0:52e:f950:31f5 with SMTP id
 2adb3069b0e04-53546b1c55dmr6792366e87.18.1725283473203; 
 Mon, 02 Sep 2024 06:24:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9?
 ([2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a1900d4fcsm24965766b.144.2024.09.02.06.24.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Sep 2024 06:24:32 -0700 (PDT)
Message-ID: <56b0792d-0b21-446d-b1f0-7b6e60eb5ae1@linaro.org>
Date: Mon, 2 Sep 2024 15:24:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: guard call to tftp_start() with #if
 defined(CONFIG_CMD_TFTPBOOT)
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240902125917.119941-1-jerome.forissier@linaro.org>
 <ccdf5291-604b-48bb-9e3d-8f3214483237@cherry.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <ccdf5291-604b-48bb-9e3d-8f3214483237@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Quentin,

On 9/2/24 15:09, Quentin Schulz wrote:
> Hi Jerome,
> 
> On 9/2/24 2:59 PM, Jerome Forissier wrote:
>> net_auto_load() cannot call tftp_start() if CONFIG_CMD_TFTPBOOT is
>> disabled.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>   net/net.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/net/net.c b/net/net.c
>> index d9bc9df643f..35961ba1c7d 100644
>> --- a/net/net.c
>> +++ b/net/net.c
>> @@ -334,6 +334,7 @@ void net_auto_load(void)
>>           net_set_state(NETLOOP_SUCCESS);
>>           return;
>>       }
>> +#if defined(CONFIG_CMD_TFTPBOOT)
> 
> I think we're supposed to use if IS_ENABLED(CONFIG_CMD_TFTPBOOT) now.

Ah yes. I thought it was only with an if () construct but I suppose that
works fine with #if too.
 
> Additionally, it's highly recommended to rather use "normal" if's wherever possible, i.e.:
> 
>         if (IS_ENABLED(CONFIG_CMD_TFTPBOOT)) {
>             if (net_check_prereq(TFTPGET)) {
>                 if (IS_ENABLED(CONFIG_BOOTP_SERVERIP)) {
> [...]
>                 return;
>             }
>             tftp_start(TFTPGET);
>         }
>     }
> 
> Would that work?

Absolutely. I thought about doing just that but I wrongly assumed tftp_start()
would not even be defined as a prototype if CMD_TFTPBOOT was disabled, which
is clearly not the case.

So yes, that works and I will send a v2.

Thanks,
-- 
Jerome

> 
> Cheers,
> Quentin

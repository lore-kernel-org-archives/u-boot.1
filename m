Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C04CEFC5D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 09:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A825C89189;
	Wed,  9 Oct 2024 11:39:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ya/hz2BX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 300BC8918A; Wed,  9 Oct 2024 11:39:27 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE6B889166
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 11:39:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37cfa129074so4386327f8f.1
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 02:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728466764; x=1729071564; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j1NHtOpwoy0Ff0Bk9iINYGT8eF3f+iD2om/Szcp8A/g=;
 b=ya/hz2BX9VeG/PVwS9p1xzSjU2yXZ+IFmrtQvtINUhBb5oduCnPiW6vAPdvOO2hdHV
 ZUrUUrGM+4uTgGSzajtKwFVtAlEcA7KVGirnzegGJejOw0pDhs6QF45nFDDebYLuylh8
 h2ofpzA4zeAJ1IEpCVXVXj52B3ytuD7jk+2HR4SahLQK5v/97UmDUkCV96J41E3I2lgD
 XvheiWMDYlZdSWtb7TJzEeU6nT6H6TX6qB4PQFe+foRUjIQOtDlGrM3oKrxxPM2FHw64
 xHZbtF73ELzQdjLJX1cWoRshTpw6ZydcNYO2JHkHSenkCtCHRHuZFx6Oy/9zjmCDLkJH
 /voQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728466764; x=1729071564;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j1NHtOpwoy0Ff0Bk9iINYGT8eF3f+iD2om/Szcp8A/g=;
 b=BpN5q5ynQvARPrjszqMviF3DcMqyD3QKXuQ3w4fgG1fiSSMausSHtg/0qPdz17GpHN
 SGrDxS0nAYloFliMHV4OG55gZ0N7p/zXSunNMkOkbzvZWZQMynqNnfESEOnC3JI7zezP
 LronwUgxu0kXrEWe3D31Y4n+TVRiXc258nzfbf1Pp4JPyH7QdnnTbbr7Dnlh4JX1217n
 MxzqXxa+fW96PD95Ss4isJuRyUveFH1EYscDhLBOU1sp3lCkPsZDSTQ0X/1xJuIQIO1P
 UQfO+Q1h7Pnx7S4okMFKRsehXebVpEaElyjqcFFPWel7L9/9vDx7ll5ACkxsmMzyt3aA
 roMw==
X-Gm-Message-State: AOJu0Yz5XHlAQPmIOhGKHa0HtqYSAMA1piw3R56DHGtujGKtaAw/+pkf
 w+WUZTD4Fdgt9gQ1I857UhLH+hA/YuekP8l3SDduSAH7sWryFeMN1HV5Ef63t28=
X-Google-Smtp-Source: AGHT+IEnuARcKQnrcrV4tnb2CscGqK47ychVovw7UXVlE0n0AC1PQRcwYQokiDhBy8XHyqexO9jPXA==
X-Received: by 2002:adf:9b97:0:b0:37d:ff4:dc64 with SMTP id
 ffacd0b85a97d-37d3aa8e572mr1097359f8f.25.1728466764100; 
 Wed, 09 Oct 2024 02:39:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:3363:964:de3b:212f?
 ([2a01:e0a:3cb:7bb0:3363:964:de3b:212f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d32ea1d98sm2982728f8f.68.2024.10.09.02.39.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 02:39:23 -0700 (PDT)
Message-ID: <a40b7d94-008b-435f-9034-3872c82919fc@linaro.org>
Date: Wed, 9 Oct 2024 11:39:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 01/29] net: recv(): return -EAGAIN instead of 0 when
 no cleanup is expected
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Maxim Uvarov <maxim.uvarov@linaro.org>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <f980100c26995da542aff85bf89788e19aceb7b6.1727968902.git.jerome.forissier@linaro.org>
 <CAFLszTg3rconzzG89SddKT1cSQy0DgHkJsE9hNzbXZLBHaaxxA@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAFLszTg3rconzzG89SddKT1cSQy0DgHkJsE9hNzbXZLBHaaxxA@mail.gmail.com>
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



On 10/9/24 03:51, Simon Glass wrote:
> On Thu, 3 Oct 2024 at 09:23, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Note: patch posted separately [0].
>>
>> [0] http://patchwork.ozlabs.org/project/uboot/patch/20240927142038.879037-1-jerome.forissier@linaro.org/
>>
>> Some drivers do not behave properly when free_pkt() is called with a
>> length of zero. It is an issue I observed when developing the lwIP
>> series [1] (see "QEMU CI tests for r2dplus_i82557c, r2dplus_rtl8139"
>> in the change log) and which I fixed incorrectly by not calling
>> free_pkt() when recv() returns 0. That turned out to be wrong for two
>> reasons:
>>
>> 1. The DM documentation [2] clearly requires it:
>>
>>   "The **recv** function polls for availability of a new packet. [...]
>>    If there is an error [...], return 0 if you require the packet to
>>    be cleaned up normally, or a negative error code otherwise (cleanup
>>    not necessary or already done).
>>
>>    If **free_pkt** is defined, U-Boot will call it after a received
>>    packet has been processed [...]. free_pkt() will be called after
>>    recv(), for the same packet [...]"
>>
>> 2. The imx8mp_evk platform will fail with OOM errors if free_pkt() is
>>    not called after recv() returns 0:
>>
>>    u-boot=> tftp 192.168.0.16:50M
>>    Using ethernet@30be0000 device
>>    TFTP from server 192.168.0.16; our IP address is 192.168.0.48
>>    Filename '50M'.
>>    Load address: 0x40480000
>>    Loading: #######################fecmxc_recv: error allocating packetp
>>    fecmxc_recv: error allocating packetp
>>    fecmxc_recv: error allocating packetp
>>    ...
>>
>> Therefore, make recv() return -EINVAL instead of 0 when no packet is
>> available and the driver doesn't expect free_pkt() to be called
>> subsequently.
> 
> Do you mean -EAGAIN ? Otherwise, it seems like this comment relates to
> a different patch.

Yes, good catch. I will fix the description and resend patch [1] as v2.

[1] https://patchwork.ozlabs.org/project/uboot/patch/20240927142038.879037-1-jerome.forissier@linaro.org/

> 
>>
>> [1] https://lists.denx.de/pipermail/u-boot/2024-August/562861.html
>> [2] doc/develop/driver-model/ethernet.rst
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  drivers/net/eepro100.c | 2 +-
>>  drivers/net/rtl8139.c  | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks,
-- 
Jerome

> 
>> diff --git a/drivers/net/eepro100.c b/drivers/net/eepro100.c
>> index d18a8d577ca..f64dbb7d6a1 100644
>> --- a/drivers/net/eepro100.c
>> +++ b/drivers/net/eepro100.c
>> @@ -678,7 +678,7 @@ static int eepro100_recv_common(struct eepro100_priv *priv, uchar **packetp)
>>         status = le16_to_cpu(desc->status);
>>
>>         if (!(status & RFD_STATUS_C))
>> -               return 0;
>> +               return -EAGAIN;
>>
>>         /* Valid frame status. */
>>         if (status & RFD_STATUS_OK) {
>> diff --git a/drivers/net/rtl8139.c b/drivers/net/rtl8139.c
>> index 2e0afad089f..5f4b1e2d3a0 100644
>> --- a/drivers/net/rtl8139.c
>> +++ b/drivers/net/rtl8139.c
>> @@ -433,7 +433,7 @@ static int rtl8139_recv_common(struct rtl8139_priv *priv, unsigned char *rxdata,
>>         int length = 0;
>>
>>         if (inb(priv->ioaddr + RTL_REG_CHIPCMD) & RTL_REG_CHIPCMD_RXBUFEMPTY)
>> -               return 0;
>> +               return -EAGAIN;
>>
>>         priv->rxstatus = inw(priv->ioaddr + RTL_REG_INTRSTATUS);
>>         /* See below for the rest of the interrupt acknowledges.  */
>> --
>> 2.40.1
>>

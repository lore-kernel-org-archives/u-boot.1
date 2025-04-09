Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBB0C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 10:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FE9983612;
	Wed,  9 Apr 2025 12:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="Q+GeSHTm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E13F83616; Wed,  9 Apr 2025 12:27:15 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97686835FE
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 12:27:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-391342fc1f6so5734954f8f.1
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 03:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744194432; x=1744799232; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=rSXJ0Q8VRC+YBfOG4bpUHq7Wb8gjUmp8Q2oVktJu/6I=;
 b=Q+GeSHTmmQ4L6bktuNKDQ7JQ0eBDQO9WXvbQMVeAeFienT9myVS1I6azDRmUceOLW4
 40mYXgHqihYTE/nwwK2lvc0dJf0wYqiuNdQwpXE6FJvadw5a8v6faQKviVX/U6uXf69f
 eyHbApyWCgsuNJSV9IWoSgLedKFneJuZZDH6P0LvdTL8yNCRIiiEGDeF9d5GvZinYslr
 tnXEwrjM1iCLlxJ/qhgR78Ehe1PzofaJGDSgghQRocfcswer+6ERSX6f6gwG+kv/p12D
 jTVmLyVfwFhWQ/h5E6CwntpoQCEgbRB0jX5l2OwkK4vONewGF0SEW4wFlJtPsHDbdAza
 Ec1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744194432; x=1744799232;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rSXJ0Q8VRC+YBfOG4bpUHq7Wb8gjUmp8Q2oVktJu/6I=;
 b=MJe/j0w8vrpdgXYeZbrk7AAHyxjfN0+aCQYGyRadPzCfanijULmttHLtlICB4cIvyh
 33HK5Rit+8RoErQIptddQJjbzDoJ1M+1A4PgH/RQk/aMobx5TWwPvMg5Ej2tyERgD9Ag
 BVDILuwPj6/MZWVndDD8TViVkHoECZnn06Kdo9DJY7xovwM85QEFtiga52bKu8pn7PP9
 j8t6cuobyd1zOTvDYsmotVXzuJEIsPxn/tgwENyz1wlisp/gryXeM6l4XbZ4X5zasifp
 QsFMslD41Xax5/fel84HkTIGve+iil5f+/pAuvwdYvBMR449BSCzcuQUpUP3DNDb5HTL
 teaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjkslVglQ0lGR6luxCM3Eif0A0+CXH/JIrvErgBRykQWCHCs4NUsQ1OECwVttLLfzl650cJSo=@lists.denx.de
X-Gm-Message-State: AOJu0YwyXu+AxiHvClz8aL54Cfr6E+aZrhbXsC0fXPEb626x05enBdhr
 t8iA0Z5qyEAGkfc2yxQbUFXRM8XkzxyVHPUWSlzXoz+MaXYEGUsYI+R55PBq8z0=
X-Gm-Gg: ASbGncvtXmjw2+f3cVbN3w6YBlNMWVMI4ilR4Wf3OVO4RhFMwl97qvGtj8cdhcb2Oso
 hgNr/cHNwKOt9YLenwGA2oFOnqp449d0PPcrOpKxAIFcxHDPaquC4iV7Jxf5Zo2lv29lDigC6pd
 CuKDTx6KE5N8wgoLd39attxhyyxfytpN5BfQ5GBYIMIf8+R3tUBBotC4aXmEmXjeIiwVNuKCd0M
 oEbiCUxy7yvpai+w2cgeqo2Ass3V8VNkTNhXKkbEHXvgwNB0qgEfHg6P5EN79WOckwr4APXMmLt
 g2u4b8LJscoeDBN/paz/9Sz4NSZRKOsr0e7QvQ==
X-Google-Smtp-Source: AGHT+IEt0nT7aRxJUvLyvy83y/daJdA8LDZ/x1Zly5V/oKdWAbyPc0WZFNtnJBMRGnjPmP+goMoZZQ==
X-Received: by 2002:a5d:59a5:0:b0:391:3f4f:a17f with SMTP id
 ffacd0b85a97d-39d87cd68e9mr1988067f8f.42.1744194431890; 
 Wed, 09 Apr 2025 03:27:11 -0700 (PDT)
Received: from [192.168.2.177] ([81.0.8.231]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f23158849sm12205535e9.0.2025.04.09.03.27.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Apr 2025 03:27:11 -0700 (PDT)
Message-ID: <337e11aa-e05c-4904-9f29-fdb6cf3bea54@suse.com>
Date: Wed, 9 Apr 2025 12:27:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] configs: add jh7110-deepcomputing-fml13v01 to VF2
 defconfig
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 E Shattow <e@freeshell.de>, Sumit Garg <sumit.garg@kernel.org>,
 H Bell <dmoo_dv@protonmail.com>, Simon Glass <sjg@chromium.org>,
 Andreas Schwab <schwab@suse.de>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@linaro.org>
References: <20250409071836.26629-1-heinrich.schuchardt@canonical.com>
 <20250409071836.26629-2-heinrich.schuchardt@canonical.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20250409071836.26629-2-heinrich.schuchardt@canonical.com>
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



On 09/04/2025 09:18, Heinrich Schuchardt wrote:
> The DeepComputing Framework motherboard is a JH7110 device support by the
> upstream kernel. Add its device-tree to the list of device-trees to be
> included into the starfive_visionfive_defconfig.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
> v3:
> 	no change
> v2:
> 	rebased
> ---
>   configs/starfive_visionfive2_defconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
> index 6a5b247c4b5..e145ced8db8 100644
> --- a/configs/starfive_visionfive2_defconfig
> +++ b/configs/starfive_visionfive2_defconfig
> @@ -80,7 +80,7 @@ CONFIG_CMD_WDT=y
>   CONFIG_CMD_WGET=y
>   CONFIG_CMD_BOOTSTAGE=y
>   CONFIG_OF_BOARD=y
> -CONFIG_OF_LIST="starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b"
> +CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b"
>   CONFIG_MULTI_DTB_FIT=y
>   CONFIG_ENV_OVERWRITE=y
>   CONFIG_ENV_IS_IN_SPI_FLASH=y


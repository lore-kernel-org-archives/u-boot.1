Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48758D1CDD9
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 10:51:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8861088CFB;
	Tue, 22 Oct 2024 12:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kgTwn3sF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E69708899C; Tue, 22 Oct 2024 12:51:43 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1C6488D3A
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 12:51:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a99cc265e0aso809307866b.3
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 03:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729594300; x=1730199100; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3aysVvw80qCAG2HBFIzG7+wgpcuyO2o7LIuN1EpQPFA=;
 b=kgTwn3sFcPjlM2qolDQzJYfJz8AhuFOi5KGhWdfPhle7/dvnhuhAq4pgr4cMVVVmrl
 m9l9bSdWC0RXGzPW5uL+efaVAKTT3F7YICgEnvFNqoh4FfUYp1Jk1J5A2LKJygPCSU3D
 1KBhz8ftVLrGoj00i/44lIkWZ10QyAFskHZlib7U+uFRUS3NuK6J93i8UUS9K6vVwU6f
 mjqWLQ9tcZWBuXwOfTzPAar1Rq+GEFWVIOtHKLc997E8rPljr88FlDEf3qeKSpHVgO2P
 m98tgbuBCZpsovwHbrnhnIuO0xPsoeDkXkfgvwCAYazzxXC13reIelP+8Kjg9paaKRp4
 hnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729594300; x=1730199100;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3aysVvw80qCAG2HBFIzG7+wgpcuyO2o7LIuN1EpQPFA=;
 b=l7o7F5WSZR12twZoCWe2VSrBtxzId3K/ARKjMb7ruNa3mqhljQevVEWps1mYuHdhVn
 MJMiqPb24hMUEvV4Hf5Tk+iPQKKNm0CyL740cwiV6nHcSj1AnjZskTS24zzXESljKLSN
 MnxwlUAobHseLwmieizRWv9yC48HqSe053F/CrDElvX7ZMlRcRgJwbeE1Bq8OGjk6T7E
 AbihZpRpplgF4mUOmHi/rKRsfoBZH0S0beijaodXjclsNWhAkr0X9FBMLpOzPmJIZ9if
 TbvicyNIVS5fFprH7IHbZ3YrTgiJHaJhiIQN+wbbtdjAjPckEa8/zERfzF5IgpX0t3Rd
 dN+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPx6z8yu9+cU9Ac2ssLXjEIPls4P6apw82+P1HRTtij9gRIsD2T1RRyVAztwlkU1LgHDGAUhA=@lists.denx.de
X-Gm-Message-State: AOJu0YwLmUcmqMqhQlkbpwiR23JmFaJvScpCm1SY+Sv1T162F7l7DXfk
 oSktO9Mfz9OIwTCCh2HPbXt3n3QR/IdCYkck+e/NQNG8jh4Ny8bJ0ISn0P//HGA=
X-Google-Smtp-Source: AGHT+IF9mQqRyrDRXFUSsGprqeKvQdefnBsg/4TPKtV4HPHMlOTR4dYhHARzkfZCnYY4VCLxMdg+jQ==
X-Received: by 2002:a17:907:1c2a:b0:a99:4261:e9f7 with SMTP id
 a640c23a62f3a-a9a69b84f55mr1249376666b.39.1729594299456; 
 Tue, 22 Oct 2024 03:51:39 -0700 (PDT)
Received: from ?IPV6:2a02:8109:888d:ff00::2? ([2a02:8109:888d:ff00::2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912f7c32sm325952666b.90.2024.10.22.03.51.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 03:51:39 -0700 (PDT)
Message-ID: <af90c7ce-610e-4745-8141-6e7a2723809c@linaro.org>
Date: Tue, 22 Oct 2024 12:51:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] common: Move autoprobe out to board init
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Svyatoslav <clamor95@gmail.com>,
 Artur Rojek <artur@conclusive.pl>, Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
References: <20241021155133.29557-1-sjg@chromium.org>
 <20241021155133.29557-4-sjg@chromium.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241021155133.29557-4-sjg@chromium.org>
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

Hi Simon,

Just a typo/nit

On 21/10/2024 17:51, Simon Glass wrote:
> Rather than doing autoprobe within the driver model code, move it out to
> the board-init code. This makes it clear that it is a separate step from
> binding devices.
> 
> For now this is always done twice, before and after relocation, but we
> should discuss whether it might be possible to drop the post-relocation
> probe.
> 
> This patch also drops autoprobe from SPL. If that is needed, we could
> add a call in SPL.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   common/board_f.c    |  4 ++++
>   common/board_r.c    |  4 ++++
>   drivers/core/root.c | 17 ++++++++++++++---
>   include/dm/root.h   | 10 ++++++++++
>   4 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/common/board_f.c b/common/board_f.c
> index 8684ed71284..6564b2ac2f7 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -822,6 +822,10 @@ static int initf_dm(void)
>   	if (ret)
>   		return ret;
>   
> +	ret = dm_autoprobe();
> +	if (ret)
> +		return ret;
> +
>   	if (IS_ENABLED(CONFIG_TIMER_EARLY)) {
>   		ret = dm_timer_init();
>   		if (ret)
> diff --git a/common/board_r.c b/common/board_r.c
> index e5f33f40643..a2948b7b55c 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -243,6 +243,10 @@ static int initr_dm(void)
>   	if (ret)
>   		return ret;
>   
> +	ret = dm_autoprobe();
> +	if (ret)
> +		return ret;
> +
>   	return 0;
>   }
>   #endif
> diff --git a/drivers/core/root.c b/drivers/core/root.c
> index 2d4f078f97f..f6bda84b2b9 100644
> --- a/drivers/core/root.c
> +++ b/drivers/core/root.c
> @@ -281,7 +281,7 @@ void *dm_priv_to_rw(void *priv)
>   }
>   #endif
>   
> -static int dm_probe_devices(struct udevice *dev)
> +static int dm_probe_devices_(struct udevice *dev)
>   {
>   	struct udevice *child;
>   
> @@ -294,7 +294,18 @@ static int dm_probe_devices(struct udevice *dev)
>   	}
>   
>   	list_for_each_entry(child, &dev->child_head, sibling_node)
> -		dm_probe_devices(child);
> +		dm_probe_devices_(child);
> +
> +	return 0;
> +}
> +
> +int dm_autoprobe(void)
> +{
> +	int ret;
> +
> +	ret = dm_probe_devices_(gd->dm_root);
> +	if (ret)
> +		return log_msg_ret("pro", ret);
>   
>   	return 0;
>   }
> @@ -331,7 +342,7 @@ static int dm_scan(bool pre_reloc_only)
>   	if (ret)
>   		return ret;
>   
> -	return dm_probe_devices(gd->dm_root);
> +	return 0;
>   }
>   
>   int dm_init_and_scan(bool pre_reloc_only)
> diff --git a/include/dm/root.h b/include/dm/root.h
> index b2f30a842f5..2ba5104ce1f 100644
> --- a/include/dm/root.h
> +++ b/include/dm/root.h
> @@ -136,6 +136,16 @@ int dm_scan_other(bool pre_reloc_only);
>    */
>   int dm_init_and_scan(bool pre_reloc_only);
>   
> +/**
> + * dm_autoprobe() - Prove devices which are marked for probe-after-bind

s/prove/probe

Kind regards,

> + *
> + * This probes all devices with a DM_FLAG_PROBE_AFTER_BIND flag. It checks the
> + * entire tree, so parent nodes need not have the flag set.
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +int dm_autoprobe(void);
> +
>   /**
>    * dm_init() - Initialise Driver Model structures
>    *

-- 
// Caleb (they/them)


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B17D44D48
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 10:42:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2428C88D8D;
	Wed,  6 Nov 2024 11:42:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XGGJq+Yh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7734788D35; Wed,  6 Nov 2024 11:42:39 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E3CF88D8D
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 11:42:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-539f72c8fc1so6974845e87.1
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 02:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730889756; x=1731494556; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8ivQ/AE1S+y8EWNsKKyeS8CHV5LBlPVHgONVto71K88=;
 b=XGGJq+YhTHxuqwCFzadrEbP1HWeDITA95Ve6iPkEL5V8UdRiTk32sWN/dBNv68i2TJ
 eT91pQvAhcfG8SkwnhugCWX09ANFsd770rO2bCORZ9/nrP4h6/VI57nEOX7ID3/YnPYF
 t9E9yWTWqQOie0NMimItTgOQN1ToY6zRooYeWYAeGF1ROzmtAv5y5Q5ynz6RVWhRC3VL
 Jd1H2IHPDfTvpEGB9i29uVD7QzfRsJ393/P1wqD5FxgSxs+tgBNCqMNZEF532zbEtIRC
 jFrzqlNasncXAgVHlFJgNwArQGMeha2z4Pyj0GdZjSHkLr5MB60HuWJpEQQhdWWoz905
 rPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730889756; x=1731494556;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8ivQ/AE1S+y8EWNsKKyeS8CHV5LBlPVHgONVto71K88=;
 b=O/efO9wVkpxBbKZ00jbbbqMtBsMhSm0tlM8eVzDtmXRGRY/y8IiGrKuFZcCP1s5qBM
 VCDClsp9+qCBNwU71hLE9rNd/U2RibuYKsKa2hBEgrrCdX+wW7Bg7mjTS+u7UQxc3xur
 8j8foB3sM9/NmSVf1e+mW2uS8Ene2pzN6lC3eUH20gIwOMLsjjmfA8w2a58crZ063vzX
 TbzoUPbr7zyFo0tIsltThxnnQzCsjtw1yQn5ZfN64kKOwD8VZrSTUzTDoMXvIqVKFCrn
 RD+vXxuVPItdbd5hZvXmtdtCqDaCakltDs1tyWpLgRDv+Xafd+TMtso8FTLws8XnYBN0
 6qbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVlMehPQF2AYoCjJFVypi4YaKxSGs7GkexRKjX2bK/QRJaUA0OkGfMRByUcFXxW9gcHtaszNk=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/IiRm5o0cb1z/YLqjD6RZkKmMaVSQrKCP2k5UqMPNnbw7YA7x
 1/mPerhykPsO7Vgfi/TgoxaTsk4S0IrDa7VdUyrrq6SDki2WtwgsuqhczPj5hCU=
X-Google-Smtp-Source: AGHT+IFP2FH+ljTgov5BEd+tIsFYqcZm9ln6eShnj3lBp9ta4rfCaGOz1vOUNJNUQOVBhFpJJqaFNw==
X-Received: by 2002:a05:6512:a87:b0:53b:27ba:2d11 with SMTP id
 2adb3069b0e04-53b7ece09bamr14815096e87.16.1730889755654; 
 Wed, 06 Nov 2024 02:42:35 -0800 (PST)
Received: from [172.16.24.28] ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6bee9asm18176105e9.19.2024.11.06.02.42.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 02:42:35 -0800 (PST)
Message-ID: <382f3881-1af0-4ca0-ac57-a36e012e4506@linaro.org>
Date: Wed, 6 Nov 2024 11:42:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] lib: uuid: fix uuid_str_to_le_bin() on 32-bit
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <20241103224223.195255-1-heinrich.schuchardt@canonical.com>
 <20241103224223.195255-3-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241103224223.195255-3-heinrich.schuchardt@canonical.com>
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

Hi Heinrich,

Thanks a lot for figuring this out.

On 03/11/2024 23:42, Heinrich Schuchardt wrote:
> hextoul() cannot convert a string to a 64-bit number on a 32-bit system.
> Use function hextoull() instead.
> 
> Reported-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Fixes: 22c48a92cdce ("lib: uuid: supporting building as part of host tools")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

> ---
> v2:
> 	no change
> ---
>   lib/uuid.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/uuid.c b/lib/uuid.c
> index c6a27b7d044..19f33dd1477 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -35,6 +35,7 @@
>   #ifdef USE_HOSTCC
>   /* polyfill hextoul to avoid pulling in strto.c */
>   #define hextoul(cp, endp) strtoul(cp, endp, 16)
> +#define hextoull(cp, endp) strtoull(cp, endp, 16)
>   #endif
> 
>   int uuid_str_valid(const char *uuid)
> @@ -339,7 +340,7 @@ int uuid_str_to_le_bin(const char *uuid_str, unsigned char *uuid_bin)
>   	tmp16 = cpu_to_le16(hextoul(uuid_str + 19, NULL));
>   	memcpy(uuid_bin + 8, &tmp16, 2);
>   
> -	tmp64 = cpu_to_le64(hextoul(uuid_str + 24, NULL));
> +	tmp64 = cpu_to_le64(hextoull(uuid_str + 24, NULL));
>   	memcpy(uuid_bin + 10, &tmp64, 6);
>   
>   	return 0;

-- 
// Caleb (they/them)


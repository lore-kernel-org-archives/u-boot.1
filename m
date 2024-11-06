Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DA2D44D46
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 10:42:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76A898905E;
	Wed,  6 Nov 2024 11:42:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qc7xMpVB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 236908919A; Wed,  6 Nov 2024 11:42:51 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C96188D35
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 11:42:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso55102685e9.1
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 02:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730889769; x=1731494569; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gy9ua8aiIKj4oo2vE8YG90VUECAOULTGW0Qx2w7W1+U=;
 b=qc7xMpVBbFqWE+f1a3WNrTdocSIzLuMGLlIz8cmj8gxqpIZxfKvXyBPGxRlG/88rRT
 5dSxV5j6h6O9oM1tTg+rRq2Dnjhl4RnyBrZB3JejVi2gMPw0Yv+VuK5nXDRcjBlaivE/
 5902Fhq2k81BHYHV1xPIRUp/G9ecgmfDXRZcxt9uUONd6e5+ULjPjafjMLSm/lYclxhG
 uj+vOWn50KxDMKrS3N+H9koQeRbeTQzf0HY54ygzAmKwsFYyDFFR3XEYq+3ItxLVRD5j
 0R5Z/vafIDyuZyg4XOf6+m655ABMRK97cesNqb+UrbtimMXqdCEDAggG7fGEu13hzCRm
 FQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730889769; x=1731494569;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gy9ua8aiIKj4oo2vE8YG90VUECAOULTGW0Qx2w7W1+U=;
 b=OLQ+5AyyNEfNhfngJMHt+g2uZj03ZgKXxeGZTf5nb8IP7t00/7iebyJ/H5MChXuyA9
 ntLu7Ab2hi9nMir5GR7/O3T4OHnxR/x326UzWT3lVGrT4pL87BUhLicWE5yaVeDQholq
 HTkYmrHTH8o3SXP3sI7okI9VktRXA7VF3AwqVylKFfBvPk7j4tXpzc7CLv/qD6C59zRd
 ujOaH+WWbr1duGG22YkN37urczhD4qupxt2JjNSWPkzKnSwp2w34VYwJf58xIWABhAvC
 +A/jK0q/Z/SBPeZIqZJKBTJFK4CucTyKj/acB6ayWgRFoIi6IM0CTz6Za4dBybg1W4tQ
 jqQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQiC+bwX3no1d843WGdiVPY3b1xUtDPfGttF5Gj4l5JW7CA2VOPWb4O472qcY5eZyqAaXy9pM=@lists.denx.de
X-Gm-Message-State: AOJu0YxDC4oA3XmpHQp00191o6tRNaj0Lgc3QwuHcDMzsTFROszJuehi
 Ah4ORRRUmBmIkLwAmQVoGTzgtNinXPIVO0iOFKPtccM8ealGNSVfuqk6xjSlxmM=
X-Google-Smtp-Source: AGHT+IHwlgU5EPj+spCRBTsOtLXTkFFYjreKtWxhmeqpo+PO3Qde+67gfAHKg93ine0RtmDXKqkYAg==
X-Received: by 2002:a05:600c:138d:b0:42c:bae0:f065 with SMTP id
 5b1f17b1804b1-4328323f762mr158590865e9.5.1730889768683; 
 Wed, 06 Nov 2024 02:42:48 -0800 (PST)
Received: from [172.16.24.28] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6da94fsm17672905e9.29.2024.11.06.02.42.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 02:42:48 -0800 (PST)
Message-ID: <816ce434-01ce-4d31-8fa2-d429fa106502@linaro.org>
Date: Wed, 6 Nov 2024 11:42:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] lib: uuid: fix uuid_str_to_bin() on 32-bit
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <20241103224223.195255-1-heinrich.schuchardt@canonical.com>
 <20241103224223.195255-4-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241103224223.195255-4-heinrich.schuchardt@canonical.com>
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
> 	new patch
> ---
>   lib/uuid.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/uuid.c b/lib/uuid.c
> index 19f33dd1477..538a1ba6aa8 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -313,7 +313,7 @@ int uuid_str_to_bin(const char *uuid_str, unsigned char *uuid_bin,
>   	tmp16 = cpu_to_be16(hextoul(uuid_str + 19, NULL));
>   	memcpy(uuid_bin + 8, &tmp16, 2);
>   
> -	tmp64 = cpu_to_be64(hextoul(uuid_str + 24, NULL));
> +	tmp64 = cpu_to_be64(hextoull(uuid_str + 24, NULL));
>   	memcpy(uuid_bin + 10, (char *)&tmp64 + 2, 6);
>   
>   	return 0;

-- 
// Caleb (they/them)


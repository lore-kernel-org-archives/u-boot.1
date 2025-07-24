Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A581C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 08:17:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBAE583655;
	Thu, 24 Jul 2025 10:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Jg4dYd9z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CD4F8365C; Thu, 24 Jul 2025 10:17:41 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D62C883616
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 10:17:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4561ca74829so7595185e9.0
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 01:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753345058; x=1753949858; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vQboIouKRvIh2pZgZwTY/udkx+X2W/PMFUexpobexNY=;
 b=Jg4dYd9zWDRKk44tt4tgqGLcUuuKZ9MvqJPxfypeWQ3usHpQZMr6RVu5pR6nSb3sa5
 QWlIbLPq5sfLWjOwDBUM4rULtscAHqXzU7ey80j3n0y9nZWT7DqIW/8d5m7t2k4S1bCT
 NexUjIgPpf8rk5qQxNGXg4wNG7U+0j8kRATqahLkBQ1FytTK+hEaCU7QwWq9/2K3y6kh
 oQ9FF9l6zZT8WHCbbAZuPbiqPvJ7711EBSkO8hclaCbYRMlTzcXGpwvT4Z2yjttJcWBj
 PZzoIUJZzA18eliW88AaRhRP0UUCRSce0S97/MX4hXd+l100UY2PkbSDjJH8pnM9HJAx
 HDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753345058; x=1753949858;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vQboIouKRvIh2pZgZwTY/udkx+X2W/PMFUexpobexNY=;
 b=hcg8RioHu9uwzK15rDGM5XE1591/F9SoyE8SWXXkAAnUnG3fWxWaIAUT9C/qkIMidY
 EmJR4gvOx2Ysq4ax6Ci5Tpz5ECZ4j+yrhiivxklrQI/P8LJ8Juvwy4+IaiQtWj6MNbxp
 HLeSJEggVQ17aOsn4mn9+amqLTbHrNjYBgktgjuLagzftsSCWs3vIL7pkDE7zq3xHZrs
 nG79Bv2pbyhhiBrnGLjk5b1xdFMFkL3FAGXTgKlp2lLFgFRb7KNuTWbe87dyLtt6qy1A
 2XuQTgNrb7Ubs0crQrZnVeWN50nVsrte64hi/UV4OBlRb7OqlD1EVrmlXnBT0V0blKpB
 XtFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+qVbi+SHG9dr9wfviLnholBo5rjgrv05gokOmJIDIBXQilHhtUe+RBMi5EwYGQdYP/Hezlco=@lists.denx.de
X-Gm-Message-State: AOJu0Ywp6r1y9cqpija7DQYu3lmNSQPref6rd8fVaAIQ7BjRaGlKKOnA
 MEAf8DhlwAlhNZMu/I964BHtqPs4sxaEzGPQitqc+C4PYgQeEL77pe+ApREaVdxozVU=
X-Gm-Gg: ASbGncvFhw1EjL9c0QrkBkNZYKYNJ2LIqRw1Na7w26xrm9n8+v0WUJm1db0jGiqOqGM
 RkGO6e1W/pnBXP8dyzgoK1WcyvjomgDbAySn1DDNhfZbVu+lBjfNGkg5dhikcxVfcxOvx7F1j4b
 69vDiZ2OhIit9nrnhcuPowzbXRSQRZ6P1PyIGr5ItES2DM+lLbjG5kT+XsTlwpIyZrOSrH2Ltrv
 JnBfOilp0V0tvZwfDkRigg6Toi7cuxLw5qHh4O6kJcbZHm0uvUP/Lbt5E8VCY8m3U6KcKsQHTSk
 ClUx931dYb5Oj8nshnUoEmqhqXhipnhUBN29Omf+DI1BXXPBccAN6eAth/bNDb52muu3x+vgORq
 B3tYpOGlGGO3m1kgju8QNVHE3z8eAf4PSJe7/EGcs4x6leu24rJkUDa66zmqZIU1MrkkVNvWT2F
 pR3w==
X-Google-Smtp-Source: AGHT+IEcLrD6isgkbk8Sn0cxMdMqnc8LHaOX0S8AOYldSnHi3nQDLm58BeffRIQGksE9QO1cGskACA==
X-Received: by 2002:a05:600c:6216:b0:43c:fe5e:f03b with SMTP id
 5b1f17b1804b1-45868d76075mr60868525e9.30.1753345057942; 
 Thu, 24 Jul 2025 01:17:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:e4d2:a911:6ad2:b1ce?
 ([2a0a:ef40:f9e:3c01:e4d2:a911:6ad2:b1ce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fcbb21asm1390709f8f.70.2025.07.24.01.17.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 01:17:37 -0700 (PDT)
Message-ID: <d6b95fa5-2e9b-4799-b17b-f05fb68993d1@linaro.org>
Date: Thu, 24 Jul 2025 09:17:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spl: spl_imx_container: Delete uninitialized variable
To: Fabio Estevam <festevam@gmail.com>, uboot-imx@nxp.com
Cc: seanga2@gmail.com, javier.viguera@digi.com, trini@konsulko.com,
 u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
References: <20250723180016.2021172-1-festevam@gmail.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250723180016.2021172-1-festevam@gmail.com>
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

On 23/07/2025 19:00, Fabio Estevam wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> The 'overhead' variable is uninitialized and actually shall not be used.
> Delete it to fix coverity CID 37041718 - Uninitialized scalar variable.
> 
> Fixes: 73c40fcb7367 ("spl: Refactor spl_load_info->read to use units of bytes")
> Reported-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>   common/spl/spl_imx_container.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/spl/spl_imx_container.c b/common/spl/spl_imx_container.c
> index b3565efb225a..79d021f81dcd 100644
> --- a/common/spl/spl_imx_container.c
> +++ b/common/spl/spl_imx_container.c
> @@ -31,7 +31,7 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
>   					  ulong container_offset)
>   {
>   	struct boot_img_t *images;
> -	ulong offset, overhead, size;
> +	ulong offset, size;
>   	void *buf, *trampoline;
>   
>   	if (image_index > container->num_images) {
> @@ -54,7 +54,7 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
>   	debug("%s: container: %p offset: %lu size: %lu\n", __func__,
>   	      container, offset, size);
>   
> -	buf = map_sysmem(images[image_index].dst - overhead, images[image_index].size);
> +	buf = map_sysmem(images[image_index].dst, images[image_index].size);
>   	if (IS_ENABLED(CONFIG_SPL_IMX_CONTAINER_USE_TRAMPOLINE) &&
>   	    arch_check_dst_in_secure(buf, size)) {
>   		trampoline = arch_get_container_trampoline();

Reviewed-by: Andrew Goodbody <andrew.goodbody@linaro.org>

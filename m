Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BAAC3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 12:39:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 326FC82162;
	Mon,  5 May 2025 14:38:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ONux0WAm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E08138291D; Mon,  5 May 2025 14:38:44 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE3FF8272A
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 14:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-acb415dd8faso653751766b.2
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 05:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746448722; x=1747053522; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lo40uWW8QXDTPg/OLkrAuSvjxZUAfx70+oM/sHZ4au8=;
 b=ONux0WAmTyJ76yhb1irs48XFos4t0qw3Vfwi3sPvP12swQVJ+p48Sq6YdoGRDou3OL
 OB635Na4n0WnMdUXkr2vpDi+tIIs38WcgAC82Cc/A4v08wndAwBH3hc2m7uNfmC4kEux
 Jjlf9j8M5Jhm5HQwygsU6tlZZuaxJlWDx0p5R4lMWmW5dr7H74MhoTtNMBCCsPmo/En2
 Kqh5kFM4ILErskfrchdbi0F3mGShSo0EMRjzuMFKzaKIu7vxpBye6LuT+YZuVWhLng8i
 8ZEk2ExEWo1T4i9h0u5KssjrC9Y3aHct3e2c4wQnAjZGmSNxotalAn1+/BJr0hhPzJWS
 70pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746448722; x=1747053522;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lo40uWW8QXDTPg/OLkrAuSvjxZUAfx70+oM/sHZ4au8=;
 b=nQ4bbopDUklghScKsrBvFBbPpc/vH5qEggDDKpWCm3ut+w5pThPwYKK5LhuPNT3wHs
 wzcLu2PquMOpFIEla0Z/kxy19EgF9vPUffXB9RQ5t+RSJehZZsPVlmKYsc4Jjj6OJFYG
 bURV62M38s1Dx5zxOGme3kslLqQjr7LkKZ2M7KssEYAKzD3hkbmWAmkLcMN331EkSJDQ
 36iyA65aU9UZTa2dw5tZzN+yPfL1g3nHU7/hIapsM7Tn026aPHuceO4N5tk2S6tXzShc
 riO/1QWvjAHuvbbXmanWLwWQttfh4SSRykreSXqxcpgUeQpBFzwr69jQ8VWHt7IzGY5Y
 YvHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGemYbxms/URL8qfgEZCQnePsBDVH04fNAUVFZ6nhyIHlFmLprkCBiz078VbXjvOH1KvAbecE=@lists.denx.de
X-Gm-Message-State: AOJu0YwCuYUjqfKfTaA3QoFYxIiCyoKCwzxwEvZvI0WOpqt5G1U31Oqz
 /zNKs29QC3EFjmaIdzhtj230vgAPH8NvMtzlHCuWdkOucbP1F7AxBRk6uqLg5TE=
X-Gm-Gg: ASbGnctRb6rPgph4irdxQF1yj6bwLB9RBuljA6PWYYJKW3aWBUVAjsagQVISuEAYijW
 gaAC2tEdj+rrAhp3BJDHJs/vSXAFfzu7P0Ys0+k8jFDKv3uC2PV4uHTyVJI2OgOzisv+q7GSG6a
 d7aAxyo63J7iHE1uhQxTfwr13K/bDqLCqS/p+Z9sC7sOJWbhMKx0PwPXZnU/DsGNTnJ0opD8Yl/
 FeL1i0gkhPf0+cZYUp0S8Udx01C3nD9Jji49gQfbBShvpq6AK3LgbuXb/NCPJX7d0QR+Syf1Laq
 DxMzKNQoipUxWqZCLbO6R0o/NygDGfnD2M6AzdDm9GZjwj++aaHUKWqGhFcnywHpcuXfO43xo4s
 axbkwydJsczvvDJ4fIDUz
X-Google-Smtp-Source: AGHT+IHPPfUVSGg2NHRRQXGayKlbadIxfr73W6nhqYiX3z0FrwG6OxT7P4y9HbalP+LveksYkREEVQ==
X-Received: by 2002:a17:907:9411:b0:aca:aeb4:9bd6 with SMTP id
 a640c23a62f3a-ad1a48bc8cfmr588041866b.10.1746448722244; 
 Mon, 05 May 2025 05:38:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:b8df:70b2:49d6:1b94?
 ([2a01:e0a:3cb:7bb0:b8df:70b2:49d6:1b94])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad18e2d7a88sm433660466b.36.2025.05.05.05.38.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 05:38:42 -0700 (PDT)
Message-ID: <36d755bb-84bf-48d3-9c31-0140b4afc343@linaro.org>
Date: Mon, 5 May 2025 14:38:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/22] net: Include string.h in net-legacy.h
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20250501010456.3930701-1-sjg@chromium.org>
 <20250501010456.3930701-20-sjg@chromium.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250501010456.3930701-20-sjg@chromium.org>
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



On 5/1/25 03:04, Simon Glass wrote:
> This file uses memcpy() but does not include the header file. Update it.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  include/net-legacy.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/net-legacy.h b/include/net-legacy.h
> index 1f62ebff51d..a43ab9db589 100644
> --- a/include/net-legacy.h
> +++ b/include/net-legacy.h
> @@ -17,6 +17,7 @@
>  #include <log.h>
>  #include <time.h>
>  #include <linux/if_ether.h>
> +#include <linux/string.h>
>  
>  struct bd_info;
>  struct cmd_tbl;

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome

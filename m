Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0130F10F6FDB
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 22:47:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53B3084011;
	Thu,  2 Apr 2026 00:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K1lkYZMX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F0FA84020; Thu,  2 Apr 2026 00:47:24 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C1AB83CF5
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 00:47:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b9bfcbaa81eso35563466b.1
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 15:47:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775083641; cv=none;
 d=google.com; s=arc-20240605;
 b=C4gQ3GSUehFwaamSBeYYBiCUakfIuAQa4hI+eMKKwNXG/CwKDSCupEw1dyoQdan5cP
 I92WNdnvq+wL4kMJ2cRhUm3uKzkCsH9EL6jkBG4Acd4pqFjGyRvX8Ugehn/H1OK1UDJV
 71reMJpqa6Q2ZaNuNVdVNzFKVEZcZzzce+ksezXP884/9W4CZSbNhHyIEUaXzgD17JN3
 bCyJNourAEJXgz0J2PSFPiu0AiyjKVX5+yFNbRVp/fymV7BZ4aqzrH9lRQx8FqDyN8Ny
 4Lp+AEQwsGRxRcoX6Pam+9Sitkr4gocEnc5u2xRfnXLxb8I0BT0P9s2Hv3S51qXSAsrQ
 kDug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eb5w7th9w5gh/w8wKM0Ssvm2USTOM6Vfh4xAmg/FnCU=;
 fh=KTCl5WEHMQPh0ByidW1UA8JUh8JpkZwJ62zNVEPI3Bs=;
 b=L2nHHMmeCzLnCY4O7Ceo62xD73jBjM/PwuxcpCwuOT1zKqgb0BXLMmrcrVWVKS2zO3
 kFcH8CFGUs7qiywHr1LmXN2dVueoCnkJQKnH+p/o6ecoA08nvCCfvUZ2GW47Xr1D5RIT
 nLW+sCMQhwGdlQAExUeF1JNsIh8OWCUFd1gn2LgI7AcNPlmXnNxV4uB78tCWDzJA8ZKn
 M7U7PQCA/CY64Pk/eSV7MsqmtTC9wrVoiE7/Tf8jzGtvmgKG0t4BE56td3hqN7slqCau
 oYlw3Rlugmrvjp0wUgSy+Xhcn+0fE5wR6vWLDTSzSHSvVpk0mB9F774voKxheqv7AqBn
 1d2A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775083641; x=1775688441; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eb5w7th9w5gh/w8wKM0Ssvm2USTOM6Vfh4xAmg/FnCU=;
 b=K1lkYZMXVK6YtDlb58EIC4wYNuXcuFYBwCBw92P66cIj+ByB0Q6SsfdYZ3ZM1t+BKD
 4Qxa4p3+xjYEa57tTbfEP8w9nDuzP+OlTqvC+pyKIV64te7y4kof9uvDVYRVO7wQdKj+
 aNkvlHad77FLKy9FL5Skb7rYjP+1MloMM5AaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775083641; x=1775688441;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eb5w7th9w5gh/w8wKM0Ssvm2USTOM6Vfh4xAmg/FnCU=;
 b=NR3mHdgT5vl2GfV/GJMEsjc/TOh2uNJBgW7/SNMSQ7tTz0gNNSqzyqB/AWLKhN+4DD
 +nv+fJMZA1NUgqLBlgjEd2IDfqyYaniaXTKP88kjbiZkx2oDbpMxH5c/zeoaD8LyXHje
 qdeYSwG8n38PeeyVjxZDPf1s4reij32XatyzAmCUH1V3d5lhdfm3QtWY6+FS906lNzZT
 USsitEo3VqZXuXfOi2IqNpNB/+gGLCP435/llXCK3TugaMSKyxwViP+JuiA1Ny2G50jw
 2EvPQisYUh0eht9VtnD3Yy6p69iB1KSn+qdFrTpZ0dtE8YkCOA+N7rb8sX9KK+aT+/Yl
 /n6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnRPjtq+APevJ4Wet4XrrhJJ12jG2ordftGCTaXPSI35v+z6l4Y9FWGTlrXgwzm58PZa7rDwU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2f4suhUqu8Jw0mSOu3l4esMwDcgPv967uRA/gf2Buy2YY5vqa
 E7JSD/eZeKd553o5nMFPQSXGuieD0NmD3P5CHXq0tVi0ZVPRy87tsLBUjAwZN+dBVVzjuz7mk+g
 iET2LOzSJ21Jx+qAVqyVdheQvqLRhbcyPr7h5qvoX
X-Gm-Gg: ATEYQzzGftFjPSpFkv5GURWd81kC1g0uZYA+eaOHGI2K86kM11nBWPJ3LcxOqj47upV
 xKA3+E9twKWRMcTEobYpHc8Z88wNkQJfRKiuVnDE9VATJdSl/R7Jvjht9TY7hPPxvFI0T+dGMZP
 e1cBb1luKU1c6WzrumcaeZQPg09utGCISdlmJ0uiwEvkE+jViymiYu+TKtntdKX5ny1pviaNAcY
 f1q6RdBXsqps6/Tm8fyYaH81ESwhReRHctjx+feEwP9SnzEp3K8pSw/igpU11PPmn6ad40bp9OA
 0v3DTw==
X-Received: by 2002:a17:907:3895:b0:b98:435d:9939 with SMTP id
 a640c23a62f3a-b9c1379918cmr374253066b.9.1775083641522; Wed, 01 Apr 2026
 15:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
 <20260331100047.34618-13-philippe.reynes@softathome.com>
In-Reply-To: <20260331100047.34618-13-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 18:47:07 -0400
X-Gm-Features: AQROBzCh-XdEOmpT0OYzZBT-SwnVwFUv5yYs6W8wGMTcfcUivQLnoSXzBz1c6dY
Message-ID: <CAFLszTiXam=fRk8Ne6LED3+s00Z5uwp_MbMUUGGc355GdgT_WA@mail.gmail.com>
Subject: Re: [v3,12/15] boot: pre-load: add support of ecdsa
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Philippe,

On 2026-03-31T10:00:34, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> diff --git a/boot/image-pre-load.c b/boot/image-pre-load.c
> @@ -70,6 +70,18 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
> +static int is_ecdsa(const void *algo_name)
> +{
> +     struct crypto_algo *crypto = image_get_crypto_algo(algo_name);
> +     int ret = 0;
> +
> +     if (crypto && !strncmp(crypto->name, "ecdsa", strlen("ecdsa")))
> +             return 1;
> +
> +     return ret;
> +}

This function is called three times in image_pre_load_sig_setup(),
calling image_get_crypto_algo() each time.

Coudl we call image_get_crypto_algo() once early in
image_pre_load_sig_setup() and then check crypto->name directly in the
conditional blocks? This also avoids looking up the algorithm
repeatedly.

Also, the return value pattern is a bit awkward - you initialise ret
to 0 but never use it since you return 1 directly. Please can you
simplify to just return the strncmp result (using !! to get 0/1), or
use a simpler pattern like:

if (crypto && !strncmp(crypto->name, "ecdsa", 5))
   return 1;
return 0;

Regards,
Simon

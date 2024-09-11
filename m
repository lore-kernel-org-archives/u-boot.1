Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1071EE01FA
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 00:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C56BF89149;
	Wed, 11 Sep 2024 02:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MIwG+7ka";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 463D089138; Wed, 11 Sep 2024 02:48:34 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C92489149
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 02:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-458267a9e40so4010841cf.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 17:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726015711; x=1726620511; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yRuU0rsat9B9kn1vsDRHvJLLc1AVqOwPYxh+sCOI3qw=;
 b=MIwG+7kaIeU4me/wsXsa/p6tgHMUinXi3F6eUAio9qVPqivpOyH4flpG50ShzxbXLE
 +iXRlpi35H4eGT1x/o48uIBTV+quogkH0UqQzbvz9neV3n2TRWMZXQPej1X+N9aZ1w87
 ZzRUiy2+/FNn0dnlQTMCye7Dycl1qSJ2Jv/jMiYwpkaE5QQPcgDDm4UB5B0Er/NZclaE
 e2XczcLmNOi+N+G6IWqogZkmitbZLq9dshDzcYfJuxFxT+DCfytdOMy9lk34FlylzE1E
 ifk5KecHleo5nbNWiGuoNHbOcwc2IHaqNwXcFtNSUZnKaBgYqV9Mqz9oJBmZJcT1Hf+x
 Nj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726015711; x=1726620511;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yRuU0rsat9B9kn1vsDRHvJLLc1AVqOwPYxh+sCOI3qw=;
 b=LobGrqBHDjkmLBnGTNaBjWmCkpxRWTgE88MYqj6C4JAoG/fZjaIYU/+qzvgmaMXYUk
 6jIvrlja9+eGj+S8kw/0GOoDcx46hmXNA1yUlA6fwJS7g5bCDtLmZlWd5l6oPf6TXgLw
 i9eA1pyzKqNBoYiXfHkL9YDqlJGmy77Ql9OrJ9CtAGjoy0dqG4WaJkT2j8+iGoRNExNZ
 ckyknqLJfN/076tb+MnGfdyabGoQR/Jctc5RgoRmy0AC1R/I7rQnRif5hSSohx3Ulbe/
 IuGbxtfO+AU1CbiQjKePPAXgKDwXx/1YD3O+e725OMxoR4ngU+4EsZxWU860e4Kk7wdZ
 8xhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcxwF7mM3MiNpWQ3jLIxxHmzHnbYc64+djVYNJ5sTgBWTGCxRUIUdUc35mcFO5gkaBcpTKscs=@lists.denx.de
X-Gm-Message-State: AOJu0YxSni/ggyqY2Byw3woTBUU5Q3jex5r9ZhhmhZl/rxTA15uLTA6k
 67Ye67nqFAijcb95tWefeohnVTwoM4CxFH7bDykLlrr3wK8zCtoa
X-Google-Smtp-Source: AGHT+IHP0Si/wjgwONuu8CabErlUE9E6oIxZFjlPDAN6laL9vHSdKWASh4ifSwyeBiSyGRiCuUi4nQ==
X-Received: by 2002:ac8:5f0b:0:b0:44f:89e4:131f with SMTP id
 d75a77b69052e-4580c7685fbmr94854061cf.12.1726015710733; 
 Tue, 10 Sep 2024 17:48:30 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822e60974sm34780941cf.8.2024.09.10.17.48.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 17:48:30 -0700 (PDT)
Message-ID: <ac8e80ca-8cb6-b7f6-1930-c60923b47672@gmail.com>
Date: Tue, 10 Sep 2024 20:48:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] spl: spl_load: fix comparison between negative error code
 and unsigned size
Content-Language: en-US
To: Daniel Palmer <daniel@0x0f.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org
References: <20240831031706.2654697-1-daniel@0x0f.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240831031706.2654697-1-daniel@0x0f.com>
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

On 8/30/24 23:17, Daniel Palmer wrote:
> read could be a negative error value but size in spl_image is unsigned
> so when they are compared read is used as if it's a unsigned value
> and if it's negative it'll most likely be bigger than size and the
> result will be true and _spl_load() will return 0 to the caller.

Then cast spl_image->size to long.

> This results in the caller to _spl_load() not seeing that an error happened
> as it should and continuing as if the load was completed when it might
> not have been.
> 
> Check if read is negative and return it's value if it is before comparing
> against size in spl_image.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>   include/spl_load.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/spl_load.h b/include/spl_load.h
> index 1c2b296c0a2c..7de834f402b8 100644
> --- a/include/spl_load.h
> +++ b/include/spl_load.h
> @@ -83,6 +83,10 @@ static inline int _spl_load(struct spl_image_info *spl_image,
>   
>   	read = info->read(info, offset + image_offset, size,
>   			  map_sysmem(spl_image->load_addr - overhead, size));
> +
> +	if (read < 0)
> +		return read;
> +
>   	return read < spl_image->size ? -EIO : 0;
>   }
>   


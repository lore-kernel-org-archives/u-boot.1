Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237AAC5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 15:41:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4633A87EEA;
	Mon, 26 Feb 2024 16:41:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qx8motZu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C861287EFE; Mon, 26 Feb 2024 16:41:09 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45CF287EDC
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 16:41:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-41298159608so14952345e9.0
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 07:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708962066; x=1709566866; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dZ09ClLqwt9rELdohj2xL9biKGlmVJzQ5U2s5t2K4A4=;
 b=Qx8motZu/nsuwbIQdCzzGzjG+0BO5cFqxzOE7rUNVx2EkJZrkFVkPUb0WYeKZmArpL
 ar0c+syj74vYfCOEctZ4ef1bNdKdyK1gqwb4A9RCtgLwFlgrzfAyYAcy6xz3j97PzoCu
 R4Q25krOo2gXhwKl3QGt/H1WMshCmNZ06MTu/QNJiTGLdlGRd2ntcH/7ez7qiSStCuNp
 0yFVyQkSXyBXaUyZ+3l01Nv2snY/a5CM8IYzjTszMacJ9ufzRxBRqYs6KN8H5OhZncjM
 DUHT9r5Eax1MwVQHVMPMJ7DHDAI24vJiOUKhqodOmv+GrmEe9mOJnts5F8mtDbd/9EKu
 Js/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708962066; x=1709566866;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dZ09ClLqwt9rELdohj2xL9biKGlmVJzQ5U2s5t2K4A4=;
 b=EqSoYwEkd94we9UpxWnurL5+iSI+XYqcRzkRQsAMFmvkoA64nf7KYOYNVgnlGpTDPo
 XWJGug+5q55noBhfxLCIhEK1sr2dYanbBZOpW+WOEHJinYhxLZqebexeKgs90xKHgOlU
 DHhB6ThXb1XAf5ZJVGB1OdP9xU1A/J2gzeoW09KP0kLgGjqOJfFTMVFeXGseRX9l0000
 TP2Q5bW5rhz42Tlxl/ROZ1DRq9W5VHAXeVRd+xGEC+ca3Gf7Eg5pk5hwaYrP0qHeBUHK
 8CUQas3A4rqY1cXIeRoTU/mZSJsAJsmQGRaCEIFQQ0SFjgWlkyyy11RUN25xTURmibDk
 h1XQ==
X-Gm-Message-State: AOJu0YxU3KJ/5TRNX1mjEcoRRmiJ+u1PfCYfOy3r5mCMLaFvwzxAfvhC
 /SxK+bzOGDn9wht8dbOW3zw2DDL3fYvrOeu8ZEyWXlAWywfZwuIizMXvl4s2dME=
X-Google-Smtp-Source: AGHT+IGcwCiYtqYc/9H25iPTNubdt2XUHUx6kJp1p6LXDsfDv75VKz8PanOXQ1a+3+xDIF8BDKsUbQ==
X-Received: by 2002:a05:600c:1987:b0:412:a5cb:5aab with SMTP id
 t7-20020a05600c198700b00412a5cb5aabmr2335038wmq.16.1708962066680; 
 Mon, 26 Feb 2024 07:41:06 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 n12-20020a05600c294c00b004101f27737asm12223148wmd.29.2024.02.26.07.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 07:41:06 -0800 (PST)
Date: Mon, 26 Feb 2024 18:41:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 05/10] mach-snapdragon: Update gd->ram_size in
 msm_fixup_memory
Message-ID: <953a99fe-831d-4b42-ab34-8a9a3b7e8fd5@moroto.mountain>
References: <20240226100807.1095607-1-quic_varada@quicinc.com>
 <20240226100807.1095607-6-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226100807.1095607-6-quic_varada@quicinc.com>
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

On Mon, Feb 26, 2024 at 03:38:02PM +0530, Varadarajan Narayanan wrote:
> 
> * Update FDT only if 'blob' is not null

It seems that this is patching up a bug that was introduced in patch
1/10.  Please fold it into patch 1.

> @@ -91,9 +93,9 @@ int msm_fixup_memory(void *blob)
>  		return -ENODEV;
>  	}
>  
> -	ret = fdt_fixup_memory_banks(blob, bank_start, bank_size, count);
> -	if (ret)
> -		return ret;
> +	if (blob)
> +		return fdt_fixup_memory_banks(blob, bank_start,
> +					      bank_size, count);
>  
> -	return 0;
> +	return ret;

Please leave this as return 0;

regards,
dan carpenter


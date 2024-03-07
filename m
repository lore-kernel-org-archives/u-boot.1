Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4E4C48BF6
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 11:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDD2D87E6C;
	Thu,  7 Mar 2024 12:36:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nzn9Bih1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AFAF87E92; Thu,  7 Mar 2024 12:36:31 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D604987A00
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 12:36:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-513173e8191so955523e87.1
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 03:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709811387; x=1710416187; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YQbd8BbyAqELGJTOpaL6E4lc45fJb3pYkwWfJst2jG0=;
 b=nzn9Bih1De4q1ADC6mKorgSiZmuwdySRsi2zwTUONgxVMJSBpWK+QB5EknhH3E3PWD
 9nCq5cPlIaDOrOiIlXL2IJQepqIOAx/GdJY6Qf5RNnZXWmLMnpTn8GbagE1Esga677lW
 IsAH1E3/PePHpJ3ZgQb+Qj5dMfyqXHbfMy1kA7UG9p5nxo6UfWHtj7CJVwK3Je4QmH/u
 hEsGD0Ni5Sbjs8f8FyySJqCPYviSFX0Ex6qBgy4i/qmznB99Wh6GjL8r8ZbTi4B6pJVe
 dNI5Wh7GbrUxY+pkKvg1PMpUUCyyGDorQKqkiJ//M007DJLNBUWgeN35adRQ1pGt5UBU
 f7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709811387; x=1710416187;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YQbd8BbyAqELGJTOpaL6E4lc45fJb3pYkwWfJst2jG0=;
 b=jIXZJezT/V4rugWpF+IQhYgrs9zF17ydyDWiQmQarumx9yU3dMECTaSW0jBKvBNs2u
 6Q4a4bv2C1BfJHgPyml5Gz8rSjm6wGf9y9uNiF5K+rRyR8tKHHcN5Duhvn4Z3bo7pEec
 acDIY82weUKAnk0ICRXehD7sHY0ehxZINwOAQPFBfYNPkg9uETrLiT60JWuwHHslkr7u
 f7zwIf7Wl9N+xXOr4iDDtT9DPFVXUrOL9QkypOdTFzDkI4vkBKSjFsG8vdsrkfH/NwMf
 yrhFRpcMHKS7zXb8Dh6AWmS/xFXcKT0JwWo0jwzGkk7SOUKSQ27ffHttxnsLjL351dzE
 cO2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRf4m/6fut4Ae+WwitDiqwXNSkNaNZOh4EGoI4HnyBcdzdN3kv7MAeetpFlzoMBqO0jt1M6hg6D/9+xyDuxfWybEPNVQ==
X-Gm-Message-State: AOJu0YxGSrFIxcoWxswXlH1odtbTJk6kcHCNzZsXzVUpSN8wlBM2uvYi
 1K9f8orUnkC1m9gx3gwj55XQuwJZvu8Ja6m9zwS7OOq0JH+P/EI5h3p0ibrxa/M=
X-Google-Smtp-Source: AGHT+IGmdUbRPZKYlQfCRgN0Cng4yV96+F03ncdx4hLSEdKnbgdNUCLnDh/fd98U1MlTEuaLTxjgyA==
X-Received: by 2002:ac2:5b43:0:b0:513:1a44:61e2 with SMTP id
 i3-20020ac25b43000000b005131a4461e2mr1271079lfp.10.1709811386882; 
 Thu, 07 Mar 2024 03:36:26 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 bd26-20020a05600c1f1a00b0041313c55ba4sm123903wmb.16.2024.03.07.03.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 03:36:26 -0800 (PST)
Date: Thu, 7 Mar 2024 14:36:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: sbi: Correctly display unknown implementation IDs
Message-ID: <b9e459cd-ea96-4387-8015-263b0721c9eb@moroto.mountain>
References: <20240306144402.175957-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306144402.175957-1-heinrich.schuchardt@canonical.com>
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

On Wed, Mar 06, 2024 at 03:44:02PM +0100, Heinrich Schuchardt wrote:
> For an unknown implementation ID an output like
> 
>     SBI 1.0Unknown implementation ID 16777216
>     Extensions:
>       sbi_set_timer
>       ...
> 
> was shown. The number 16777216 is not the implementation ID.
> 
> * Show the correct number
> * Use a hexadecimal output format
> * Add a missing line feed
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

Fixes: 89a86dcf6191 ("cmd: sbi: show SBI implementation version")

regards,
dan carpenter


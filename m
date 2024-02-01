Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5474CC4828C
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 13:56:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F19B87C75;
	Thu,  1 Feb 2024 14:56:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RGavioEQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CB7F87C78; Thu,  1 Feb 2024 14:56:41 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6580887C69
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 14:56:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so1299308a12.0
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 05:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706795799; x=1707400599; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1jVhRlLvjQ2AnB9D5Jejl4w+j47NFXMYrJuc3J3RNg4=;
 b=RGavioEQnLWr2xVaTMfY+Z4+dBnJn5Dau75rbtJnQa2MX9QJTO4+txUA2JASvoNy/F
 DDYcUjveh0C8KRCHmNkD9lkqp0ogSnkAr5+gQUbdY74pu9oQ5g0uqwpQcK1OkO1FaUGy
 Kv1CcVYWNrqjDE3pEwGQTkZrVyu0d8entJ/MVZiraMkbkaPXwGRr3Wk2AV2HlRRfw/Jz
 Ws5gqu1NLiRJX7XwDKX0oclxDSSH6jtRGSqWtpsUrEsmBAXmZTjuX1gvb+RENVwRhgiQ
 rZ1Tj58lQvG7LSTa6OpgXDCCCS35JA6d2cQEJHRlIAqtBp60hztaLhJC6JpTqyWohgCk
 1Bsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706795799; x=1707400599;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1jVhRlLvjQ2AnB9D5Jejl4w+j47NFXMYrJuc3J3RNg4=;
 b=A7i+uVqt2In7DKMckzHvPaRrmIRDO7IGwDrRrsDEN7ThAliYQkzw1gWGWZW0P+KSLa
 /yBESNqDvPV2b4NTKseXehVF8jkT2l2o0GvbrMdHzNJmBQNqknZeAPNxTMcNu5jNjsU1
 A3t+gf0fZQkKzXJjll5JCrs8RHG18HdjGSGQvHbQSDw88yeWRO3noq3FnXR2Y2IgnjBW
 E1StMPYI3p3y8fpTlkZlOJzhG+W/YI9V/50vY9uy6aBFL/p+cKl4NmJ+zueLO6M79ZgB
 kxUKF0zjW9XugAA+GXw3b8EYeGi33cTgk8pgVr03Sv2kPy85OeB+AK44oD/1InAseikH
 4jOQ==
X-Gm-Message-State: AOJu0YwhShHdK6uOjRtilOrEE/sfIncYA+lXNYKVXs3Dp0NPMDDONc5t
 dXtLUCRxC2FebJR+dXKdGJCHOKMuHtofzp5MoesDDgXDNTo93orT7NMK7hgmOo8=
X-Google-Smtp-Source: AGHT+IFgTHwvIi56fo6u4d9eGKGuOhtL9eHykxsl4OyA2iMhwxupW4lNLAmkf+83QQxc8c+QeA76oQ==
X-Received: by 2002:aa7:df1a:0:b0:55f:abe7:c958 with SMTP id
 c26-20020aa7df1a000000b0055fabe7c958mr1678045edy.21.1706795798787; 
 Thu, 01 Feb 2024 05:56:38 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCW0PEK9zaWdN/qN23PuJl8bv9Lp/WQ2W0csjCbtZ4E8FLfBeCatQ6C70tB3j5gi3DDeto7zAq7I4T3iCHQZ5HUD+D65U4WPDcJJXDzvwg97tfqSPt6jvtqNNzWPEh0taa2d7SaggzBCHhqah467HSnI5u0txLuY/e4sQXe8BCuipePtwyRR577OkkNR3w6i2/JMVhr4IyJ3PnwPV9JGuUiO3QYRp9BCinipkGbQ0IduclLYUUAaqdhtrAguL/mjTXmmSWUj/ZLITpZAzMyQb8IavkA9f4pRT1t69e8fZpORPQM+m3mOvkOel7wx
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 ew10-20020a056402538a00b0055c46f452c2sm6748033edb.65.2024.02.01.05.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 05:56:37 -0800 (PST)
Date: Thu, 1 Feb 2024 16:56:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: sjg@chromium.org, hs@denx.de, sean.anderson@seco.com,
 dimorinny@google.com, mkorpershoek@baylibre.com,
 patrick.delaunay@foss.st.com, kernel@salutedevices.com,
 u-boot@lists.denx.de
Subject: Re: [RFC PATCH v2 2/2] board: ad401: example of fastboot oem board
 realization
Message-ID: <fc0bc1b6-6ae8-4331-a0b2-3ebd2d30699d@moroto.mountain>
References: <20240201092027.6258-1-avromanov@salutedevices.com>
 <20240201092027.6258-3-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201092027.6258-3-avromanov@salutedevices.com>
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

On Thu, Feb 01, 2024 at 12:20:27PM +0300, Alexey Romanov wrote:
> +static int fastboot_nand_write_tpl(struct mtd_info *mtd, void *buffer,
> +				   u32 offset, size_t size, int flags)
> +{
> +	int boot_cpy_num = meson_bootloader_copy_num(BOOT_TPL);
> +	u64 size_per_copy = meson_bootloader_copy_size(mtd, BOOT_TPL);
> +	int i;
> +
> +	for (i = 0; i < boot_cpy_num; i++) {
> +		size_t retlen, len = size;
> +		int ret;
> +
> +		ret = nand_write_skip_bad(mtd, offset + (i * size_per_copy),
> +					  &len, &retlen, offset + size_per_copy,
                                                         ^^^^^^^^^^^^^^^^^^^^^^
Sorry if I'm missing something obvious, but why is the limit
"offset + size_per_copy"?  I would have expected it to be just
"size_per_copy" or maybe some kind of limit minus the offset...

> +					  buffer, flags);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

regards,
dan carpenter


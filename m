Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B40C54FB3
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 10:45:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B985982045;
	Mon,  2 Jun 2025 12:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rEqb1fRI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBB0C820EB; Mon,  2 Jun 2025 12:45:52 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 947F681FFC
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 12:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-450ce671a08so26307335e9.3
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 03:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748861150; x=1749465950; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G0qurNggAOaAT0zF28hApeKIJMthxyIoOQLywxd5A0w=;
 b=rEqb1fRIcnHIDszYQlCuXvo5nFNKNgjr8btXkbZYZWI5ZOOyFjWWNXFjyylVbfwK4q
 hlx6L6A+KNefDotGeLIYCrRlT7meNExDlXC50N1axYo2Om3iBirNEpXwtkEVFhgvCBqL
 j7ffO5alhopcB80hPTrJIxfyNJs5asRLbO6VDUwiU8/2o8iSh9rF2xoZD7P8HQjp+z8z
 qviqV8ph6fbyJNFlFBPTx+RhKig3Uy1jhvIigXRGSnklOC1qVJKWzemTgUzd6Iozymcm
 bm+YTVqHoURzgc0Aci4bUGyrrSm+j+3oHyAgrJLemkvyDTI52S0ZwwTj+iqdF1om9/aB
 4blA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748861150; x=1749465950;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G0qurNggAOaAT0zF28hApeKIJMthxyIoOQLywxd5A0w=;
 b=LBgfJHTNf6WcwQ05waIyK7wAECVTQaFdouBc6xiNELLkJb3GIQKLP62NZX4LnjqR+D
 MumQ8qJVYJ1GXZ9Sf5PQuNlGRYSAD3Y7g/yP5uUXw0LceML95I4Lwj+7/e01rPlQZK6Z
 M/4kKpwryvnT6K4ymFtTWv50Lzpd2qulQSU+F0/4lC61F14JiRb+81Ca2iDDFrzf3ahy
 FXgXOv3x02INy1wvEBMUesfB8LCg7lJ8OcfWyOkF1NFg42zfNxqdFMY3HZfn1XKDi4np
 Kn62VLNHHbtR6D0+o5v93Z+aHR43oOMfuCsxYVxbULPUoWRk8/TO4xijE0giqFY7le7p
 GdtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWECviVn5BGpmjLeAYE/7d0AyWDH7XoQRptObW6d4LtGrn1iDi8ujuxV2pk2cx8Di0S/uljzkk=@lists.denx.de
X-Gm-Message-State: AOJu0YwrSjil+L+ILwbH4z383QB/14hvRQtmHqSH9WpS33T84qWtzvat
 m88JEG4S4ATSsyO4qWvxSS+k7MuUxp4GXCvU+y9LiEuX6DicF/NkSaMaUNSYwHnfSQY=
X-Gm-Gg: ASbGncudAFf3XwPuwahhc50ib7aDtdikIZD6INkzCy3cj4LR7vMXGPDP6FWiGKRtT4U
 ksHtKzUuEiUq5MI01S2Mr8lsWeCif5jAhRHNC2JcOW9X5Emqc+R0ot6BjGBkKCdb4clXvzaii0v
 zVWTTaNuCsm6hc4Vw97JBazZHcxU59lyc9LsHAF8akGI1ekhxvbVGUHsGDDRaVAxExnFMO7tNC2
 7qqC6powKFJaoCWrSjbylgjPWJaIrDw+XPZs24h8SvTKtKuU/jN53KmyHjxTYLjAJV0T1oKmN7k
 9Y5P/U1jIPPwgqje6OdZX7c+mgTMmQNWC5rglbAEvuLehFD9wlVyaqSRwYmSuQqEEEveXw==
X-Google-Smtp-Source: AGHT+IGLH4WgrWEp82sd+08aBz9qdmnaIhAU43jvWUMX9zsydNcwzgTRUvf6ZECf1wzha2Xw4Asv2g==
X-Received: by 2002:a05:600c:1e07:b0:43d:abd:ad1c with SMTP id
 5b1f17b1804b1-451191fd50dmr61348525e9.6.1748861149995; 
 Mon, 02 Jun 2025 03:45:49 -0700 (PDT)
Received: from [192.168.1.221] ([5.30.189.74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f0803fsm86121585e9.1.2025.06.02.03.45.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 03:45:49 -0700 (PDT)
Message-ID: <9127b627-21f0-410a-b851-fe4b43ea6046@linaro.org>
Date: Mon, 2 Jun 2025 13:45:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: sama5d27_wlsom1_ek: Get RAM size and base from
 devicetree
To: Fabio Estevam <festevam@gmail.com>
Cc: nicolas.ferre@microchip.com, trini@konsulko.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
References: <20250508000710.1196995-1-festevam@gmail.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250508000710.1196995-1-festevam@gmail.com>
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



On 5/8/25 03:07, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Instead of using defines for the RAM size and base address, retrieve these
> information from the devicetree.
> 
> This aligns with the sama5d27_som1_ek board in commit 73c1589f025d9
> ("board: sama5d27_som1_ek: Get dram size and base from device tree").
> 
> While at it, remove a spurious '/* SPL */' comment.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>


Applied to u-boot-at91/next , thanks !


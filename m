Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA222CCD184
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 15:18:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4054880107;
	Tue, 21 Oct 2025 17:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XWQ1N8Kd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15587807C0; Tue, 21 Oct 2025 17:18:53 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AF5A800D7
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 17:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b4736e043f9so967746566b.0
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 08:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761059930; x=1761664730; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HqbF8HKrXkDwhjGTWJVS+pn+NqZmH/S/AZfhrPEb9Ww=;
 b=XWQ1N8KdVTT75q6kmPoZfldmc8aq/OFtjTlBRQvDCdHwdosAPisR9XxXtpneaNINfB
 wzlvr+h3bvpYj4g6J7ZhM4wHFdpbnkQ3ghVNi9h5yWxtAmCffgDCCq/6Q2rot/DjzfEm
 5ZZkPtzPb1NgCM9h3gRFaxyxqIGfXpjO0N0jBTUuBrainGASQF/RhDKMqkguUgQf27mD
 Itm9vGrrC4whQVWPjc7dj3hkfKrd7+36MuWInpAoAhrta6ADaqTJgVVZepYbEjjA0MTd
 uMpA9gdFC9h2MRNm6o2U9l/ysrfIHBbQW4WuhPEnKQ1f4bAFGg4DPmIEZYqjdiqJgG0K
 22eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761059930; x=1761664730;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HqbF8HKrXkDwhjGTWJVS+pn+NqZmH/S/AZfhrPEb9Ww=;
 b=qxq1Ig3mHwX+Hx8m06LsZkxxFwi1/rWfgYZ5H1AbFuwJJ66cxfFUM51IzMv5qm/aXw
 lYVMwtEK+1Sh4nOtbyy8y2CTPrdG1OY18sQ18Wsfy2N27fKkH9mzJZFxupxGZrukHYtD
 0mkpKx6lUONk36HUwo8ufeqPx/c8VOmJJ4Y+11C54ovAZFdh8Z4HSx0xHg//GNv2cbI4
 8fiQQ/R0gzbGbIWTF1ZcjtZGur5hC5Bbq2GTf2Oca++0NIsHlJ0CR55+28lyqGf+JqZq
 I7+kl3WhvULAHgu0pL5vXxVe5Ap5RUQez9OLGsYYyyrMD7UMzodshWYU042Nkx1qq9+m
 vEAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWGCFmmQynm2eIgG6mFxAg9sqtHdjNBCmZ0T22HNrsZu0GvY5r9lUGd1/+0GaOONDKSMJjk0E=@lists.denx.de
X-Gm-Message-State: AOJu0YxcmRNWl2krUs6VFeAQXR1B9FWPdowR98fyG429fVY7cB7j8Wtc
 ZhJso3hawMjTE0L2pIaSPBO9YQrUJvBULuN+mxi9CwslVgquLziaeUUKQUg9j8COdko=
X-Gm-Gg: ASbGnctx887t/lFv4Gx7//wNY7vDUriQRPB6zwZkfEH7+9zrP4e7Fud0QU1Uu0YTP99
 KipD2r54uAaw2QMuBV+9VpG+ahrWFOMCL9fQpdEehuc9tQDJhALm6CHfSmaqb3WrW/z6YfOf0mu
 OlnqYECNdrKMKTIRTs9UP/JhadSoc+f332yZftoBTWW9Hqw3Mwc8IrqTfAb40OIw1AzdqI+QJbC
 27k6XV4ebR/+SyRNuP6HCEjqVAvMOC+nNtUbsUO3yPUg/RrlAR3Rn0IUuwcu7RHKA4MVhoAvTVU
 inhPOZwzfJ+jyowQDz6FlcH8mevpnj4BT9/m4AbCAmX8g7D9E2dzpc68h+gntK6gwqCvxzp6BDr
 gfp/yFE+JSUjKuRZsp7Uw9qaxn+MAP0c8SUoNKwjOeMsHxjzpML5agCJqhNticNlROTl+rgbAAO
 p1nA7JYnD5/4QABwbuSg==
X-Google-Smtp-Source: AGHT+IEW0lFuboeZ9OPhfbj6OrzJr50NWD046wzuCKKcULu29HkeGlPIBFsyBbXv0yidCx3I3L7GBg==
X-Received: by 2002:a17:907:3ea6:b0:b49:a362:323b with SMTP id
 a640c23a62f3a-b646f15a130mr2123939566b.0.1761059930601; 
 Tue, 21 Oct 2025 08:18:50 -0700 (PDT)
Received: from [192.168.0.39] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b65e89713ffsm1099947166b.36.2025.10.21.08.18.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 08:18:50 -0700 (PDT)
Message-ID: <e7c19dda-8530-44db-9dbb-8119eeca2e93@linaro.org>
Date: Tue, 21 Oct 2025 18:18:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] clk: at91: Add ACR in all PLL setting.
To: Manikandan Muralidharan <manikandan.m@microchip.com>,
 Lukasz Majewski <lukma@denx.de>, seanga2@gmail.com,
 varshini.rajendran@microchip.com, Ryan.Wanner@microchip.com,
 balamanikandan.gunasundar@microchip.com, romain.sioen@microchip.com,
 u-boot@lists.denx.de
References: <20250923095818.441917-1-manikandan.m@microchip.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250923095818.441917-1-manikandan.m@microchip.com>
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



On 9/23/25 12:58, Manikandan Muralidharan wrote:
> Add ACR in all PLL setting. Add correct ACR value for each PLL used in
> different SoCs.
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---

Applied both to u-boot-at91/master , thanks !

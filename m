Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20ACECA0EC4
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 15:25:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 880E682E37;
	Mon, 11 Aug 2025 17:24:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gx5NNS8b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85C6D82F5E; Mon, 11 Aug 2025 17:24:57 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B8B382DA1
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 17:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-458b885d6eeso28681835e9.3
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 08:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754925895; x=1755530695; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t6M8EI/pab2deWZkibiP/LTbYU0J6QUknKE7OWWdjTc=;
 b=Gx5NNS8bIX7kNxwNqS/VXaEl0nLvxM2UB8/Ra4CdvGQtWeIzNNdh3jHwa1aFVB9I1r
 N9ioO6bmGY5NP8MwN0HWB2fev+qZyk0k0wUJNEkm/j9kXaP/YfQWn1ZQcqgsGi2Dfv7a
 +eE2fJCPXiCSK9jd2p75qgvtT45tO+CdWztMZXhpQ7ro6vOlLofxqGzoS0+uLHYVHWij
 Lj2rXzusjNRg5bR58lofHIzaaJE3p+JvlKTmCbADLingbjohW0A24w5k88qLWDguQIjV
 ilxgeds/iT3aTC9Bqc2otXPFClPGogWNxEa+R+aNNUYKvOkfUULdsqqIOsgoomnSjvc7
 rvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754925895; x=1755530695;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=t6M8EI/pab2deWZkibiP/LTbYU0J6QUknKE7OWWdjTc=;
 b=j5p+hEnYZN+fUlxfL5kJnfhyiAeK2Tm4D7FYKM4yFftJFNXhsCcCLw1HCOh1UG0UgP
 6fbKT7ix1d4CanEdcnwi/ofs9V3VCt/rMHBOXaA8xLBJp+mVduG63hqpfNlW8E7dCKu3
 NO8eGL/j54yxAON/slEepzrm3oTUDWdldp6KHm+HEnVzRtNApQl/7sPSFtq3Sb9e4yOu
 JHZpdhC4LVnISO1f1pKw/2iBJHrevsKzZyncOe7jM6K9+LdWbW/PczFUSnjvKYsIhnyo
 /a2+95TiywB2NyPuxdNYyQ3wqeEtikJvtt1rXv4rS6VJiQLSJmzfdiz2FbapmoRvgfqn
 8lTg==
X-Gm-Message-State: AOJu0YxFddlIvC4pOJFZ3K/9zOkGdrBJfcx+lW/atVivfnWR39zk43D+
 770JHaYlAq2lGgQh+va/cXKTgkm/MpkS8HWJ1M6OWw01gMaCfrVC0RDNMpaPHRSuPrCjX919q1V
 B6g8M
X-Gm-Gg: ASbGncuL99O1HPSTUtMRZPeJ10U8lyTzuMf0HGhChprVyoJ4iTHpn0LeXTYcR3gtHOc
 5HOWA73S97adAorBg8bnyY3wgTRiSdiu20x/31VTUkyR9GsDsfvHGyFPMqot50xxzYO/gVXUy08
 wosGYZf9vQAVOShQ6zkvNlLCotXOSaTsqglByetti5vdBaxix0aFE8hFhh3dvTysTTax0Dqk+jm
 xjaib3IWrWW84xe05bCpDOvuq7G31F4Ggmwgt8CNRW+u0fJthmbvPAW7MfGwnElXInjJ2Zdiwrx
 AED3u75wviDZohi+b8m6kTaU9JyLiuBmR4d4OX2EDpdqR2yLn5k+lmJZgen5lQbcdiQ4KmW3jNM
 4COPilgrGWQjYVsTSGHDwqmzvWjUxQzi0QDZgkkgPTfuaFZ9egWaXE0G4msFqgY4Y5Ce7j1ZJyW
 KIbQ==
X-Google-Smtp-Source: AGHT+IHHf0aJJ9tYZfOV0Bj4uZ5BICJr6oAQbmMpzNLiKkXXpPz2qgMLoWvQUnGGw9OJ21pXvI3Gng==
X-Received: by 2002:a05:600c:468d:b0:43c:f0ae:da7 with SMTP id
 5b1f17b1804b1-45a10b9f391mr1235995e9.7.1754925894651; 
 Mon, 11 Aug 2025 08:24:54 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:3e73:96b1:418e:3053?
 ([2a0a:ef40:f9e:3c01:3e73:96b1:418e:3053])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3abf0csm40155592f8f.14.2025.08.11.08.24.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 08:24:54 -0700 (PDT)
Message-ID: <f5c94319-8ef8-459d-88b2-836702779cfb@linaro.org>
Date: Mon, 11 Aug 2025 16:24:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Seeking advice on API return type inconsistency
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

Hi,

I was wondering what people's thoughts were on API return types. In 
particular there is this and other examples in include/clk-uclass.h

/**
  * get_rate() - Get current clock rate.
  * @clk:	The clock to query.
  *
  * This returns the current rate of a clock. If the clock is disabled, it
  * returns the rate at which the clock would run if it was enabled. The
  * following pseudo-code should hold::
  *
  *   disable(clk)
  *   rate = get_rate(clk)
  *   enable(clk)
  *   assert(get_rate(clk) == rate)
  *
  * Return:
  * * The rate of @clk
  * * -%ENOSYS if this function is not implemented for @clk
  * * -%ENOENT if @clk->id is invalid. Prefer using an assert instead, 
and doing
  *   this check in request().
  * * Another negative error value (such as %EIO or %ECOMM) if the rate 
could
  *   not be determined due to a bus error.
  */
ulong get_rate(struct clk *clk);


get_rate is declared as returning a ulong but the description says that 
it can return negative errors. A simple test of the return value for 
being less than 0 will always fail so errors can go undetected. Casting 
to a signed type seems less than ideal.

What is the best way to deal with this? Cast to a signed or update the 
API to be signed or...?

Andrew

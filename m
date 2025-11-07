Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDCBCCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 21:35:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9835883E44;
	Fri,  7 Nov 2025 22:35:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hTSLg5fw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 790D983E42; Fri,  7 Nov 2025 22:35:00 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70D0383E23
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 22:34:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3c73e93eadfso418577fac.3
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 13:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762551297; x=1763156097; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cceea9cGWKwSFrJOKeiaIgcCgF0oiPSdR2gFQffl1UQ=;
 b=hTSLg5fwgG6COuBtTfB8WDSFFeVWSeZZUSUm8mRc9OlQKSQfdLujF6nKo5JquP5kBj
 O+SwQS4ai2xgiCxxO9qnexsuWjkY6H6y8bFw/OIVStBczORPMa/BV1osGuQrOC7VyDRN
 1dVXril1gpJAxKTTet5V5fITjI2T9YSLN2o1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762551297; x=1763156097;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cceea9cGWKwSFrJOKeiaIgcCgF0oiPSdR2gFQffl1UQ=;
 b=s9NwZifoGa1XNwN4XK/f488NvNqCXRf9zGmTpPF54e3pDQww9ZKQ/Zo9P4Zc3GfwRT
 BnHh9YqAq645fiS3NyJsrvgoX++pMUgfnK22SE2RPif0z9TzKs1ATE7hXxUOyOKAzNQH
 9JBf/5woEb3vkXpILQgaCNzvnLqHgIz/MS3CIDE6rKuWKvbQcMlAcCjdEAPXZj49L2H5
 e9ePJF44qpVkuL6BWwlbmvZ3MKsZL30hj5gnc01k+CMEryLp/G3oYC1dqit4Q31qfPeR
 pv4pTZnM12TitS37cMfCqIg12IVw0uCcjxF6R1r4Q88+IlL2Mo/23dfr6WP1KkK1zVMW
 h7nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzL3KIImaSADVCO1BnP/35HoXqRInXmNNuyO7VX80rOB1pK9+fvkmubqVC7GLRcAa9ByIAMqY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7jPXaZTB9QLjEY9r/lqKAmWJcEZedPmFR01AZDD/RXfmTq2tZ
 aVINlFmxh5rEwtVG1CaV0TeuzX/QGlzPD3DrJ/XDlV5fXhcoknSqRDaccAIKrHRkvlMsykMoBFl
 QDzTeVaEVSg==
X-Gm-Gg: ASbGncvFN0kF9DXdCxZnSycgAB3R7hMYr47Fq9VrM+RFeL5SYxsiy8jCkD02FN/F0Xq
 iHEFUh4luea2mfU/HGwlrr7iW+ujV/jONVuqlbRcZrb8JNnQnp3EC/FLvh7Z+8cHlmEgTDrTSng
 muujPsEMZKusVGmubARJC3MaHADchAwnMdMMhjfGiEZYKwNkO67ClZaAiUkEW56B2GOmBDsVawl
 YjQaZ2FX8fQWa8YbDJMSd0OeU2cyzuQZ08oHxGl4bURaDcdTKDJcvWvTAwzzuX20qA1QYfZvEcO
 Cr1ZOzJWt3/b1J0J0ODLmu26bZXM91H4HLSb4rEihYwwQu7Ln7wfOm03p3tr182dMQkPwGJbcuN
 p422s7te+S4KiOeaHlfAE9d8xo+1T9hvUjIVnp1AQjTsFDXvZh/8Ph8WJYPsPFwp11ecH4bcYnO
 6re22axhgS1M9IWO1SXf7hL65j3quZScxLKSFvnA==
X-Google-Smtp-Source: AGHT+IF9eBczpiu1zalMqTNVFMuQrJzEP46sy1PCu95Xc4cIbRPmqT7X78PtfYCYyHmki6CY+fEDcA==
X-Received: by 2002:a05:6870:910d:b0:3c9:8eb0:e595 with SMTP id
 586e51a60fabf-3e7c2bebb94mr591743fac.50.1762551297178; 
 Fri, 07 Nov 2025 13:34:57 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e41ebb0fc6sm2507000fac.2.2025.11.07.13.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 13:34:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Frederic Leroy <fredo@starox.org>, u-boot@lists.denx.de, 
 Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251028-ext-blk-h-v1-1-bba1828fc73d@cherry.de>
References: <20251028-ext-blk-h-v1-1-bba1828fc73d@cherry.de>
Subject: Re: [PATCH] ext4: include missing blk.h
Message-Id: <176255129589.3424353.12660327506710751878.b4-ty@konsulko.com>
Date: Fri, 07 Nov 2025 15:34:55 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 28 Oct 2025 15:02:19 +0100, Quentin Schulz wrote:

> If missing, lbaint_t typedef will not be found in some cases.
> 
> [The proper fix for the commit above at the time would have been to
>  include ide.h as only since 1a73661bc7a7 ("dm: Add a new header for
>  block devices") is the typedef in blk.h]
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] ext4: include missing blk.h
      commit: 6e817d51ef52062d3f4352ab957321025e0f3406
-- 
Tom



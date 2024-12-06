Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF1FE77181
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 18:59:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 150FC896EE;
	Fri,  6 Dec 2024 19:59:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gM8v4HYW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D58B18974A; Fri,  6 Dec 2024 19:58:56 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9CFD8921B
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 19:58:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6d8878ec049so17564186d6.3
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 10:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733511533; x=1734116333; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yH6drm0Ga3Bh53bP3tL1oN1DxRxVXor4oJayDNNv2QM=;
 b=gM8v4HYWCGw7Pd08OURvYG7dGnqKr5Gyn2frkD4jDPnFRxvcdv/yCQvclrEwODGQ0h
 cqOX+qESXXstkxkeWCL6EGiJqjdGgc0HPss74XK2w731QDR34jeRetXM02vHd1IG/UwY
 yCUP1IVj7Axwb0sd2Cp6bd435xrjmIBCcGGL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733511533; x=1734116333;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yH6drm0Ga3Bh53bP3tL1oN1DxRxVXor4oJayDNNv2QM=;
 b=L+Ki/LonCGO4rGttQ67dzrdmFXQwAkhRCkIo6WuEuUs+2JE9t2xNvuquEOFIEDrkkZ
 3ieDXVk4O0pN9hG2ryprjLMYnpjQC584t3x6VRD169L0Id9WoWRWWA4YgUfRDGdQru9l
 2HtfxnbmZXBj0yOBuQNHqDr7EwDg4MqgnvGLNKrWkxDH4sqlSjnIWwfN3erbhVS+pYMe
 DoWRIqOqWWTyM6VL8PNaiSb1763lVGDfr4PfbuLl+5Z3OoIK7wG36KMocERQj08wgHIz
 MdNCC6emMBnnyKkI5Z1kabVuRl4dztsj+JpY0PkYRLCM9JzML8OA1ciTSqJjPTLG4OET
 bELA==
X-Gm-Message-State: AOJu0Yz/cA/DYt/7JCXXb5p4qnXFY15bhiymu3Or3gicz5EwToAtHQaI
 wq+zHHPuXfXHF8jeJt5l2KDpDPEp8tHve3gH334uDLLijHMebRHrr1V+NCCUT7E=
X-Gm-Gg: ASbGncsw9wxX464Tc04ebZk07t4htDLks686L3qaT5+B9IQn0tyyTv61h2H8vUAe2tK
 3wfFNUmgod2+zmsl/1p3KQZb+MoeXKs3kg0mxO4sMLkCGq6iGlCe2E96abEDGQWidCssqA+uwS3
 E9fh+OxrM1LIJFPe/WczrN3L42zTrBT15Bqy1eg0Fx09UdDpzBT4CGByxypQ7KhELRtQJhUq08k
 zePMxE+b8Uk7jI48WSEmJ9XgK+VIrJSBiTHO0gpw0T205Ih
X-Google-Smtp-Source: AGHT+IG3Yia8w9YISc9JYk0r2szyxDesR28BU0J3pHrPpHgXMzUVMy3wsAV9+pg80kNh2uhK37d2MQ==
X-Received: by 2002:a05:6214:1c44:b0:6d3:65ad:af2f with SMTP id
 6a1803df08f44-6d8e70cfee2mr50561746d6.16.1733511533709; 
 Fri, 06 Dec 2024 10:58:53 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da673441sm21909066d6.1.2024.12.06.10.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 10:58:53 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Zixun LI <admin@hifiphile.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241021150451.1858427-1-admin@hifiphile.com>
References: <20241021150451.1858427-1-admin@hifiphile.com>
Subject: Re: [PATCH] dm: gpio: Return error when pull up/down is requested
 but set_flags ops is not implmentated
Message-Id: <173351153263.2516797.4463814476290868177.b4-ty@konsulko.com>
Date: Fri, 06 Dec 2024 12:58:52 -0600
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

On Mon, 21 Oct 2024 17:04:51 +0200, Zixun LI wrote:

> Currently in _dm_gpio_set_flags() when set_flags ops is not implemented
> direction_output()/_input() is used, but pull up/down is not supported by
> these ops.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom



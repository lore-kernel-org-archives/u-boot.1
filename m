Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43449C021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 14:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E045801DE;
	Thu, 20 Feb 2025 15:32:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NqrQ2UwI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECA55806FE; Thu, 20 Feb 2025 15:32:15 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 672618007D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 15:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2fc11834404so1652101a91.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 06:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740061930; x=1740666730; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dMBdw0e9dMXIMrENPd9v2HlkbkNjaIgiTbURYSwja34=;
 b=NqrQ2UwIK4FbQHguq8w8RJN0sJ1fCQVe1srDk7aqPwqtErwsDRoCQyeHLuPkF4DVXx
 WCQosagk45/qezygBYw6HLA3QLlA16edShKymZHFpcHfwfEfl+JAaUnmTgYR3WhY9GCz
 Ex/GzLAdSE4FwgULJirHXqkfY3tT7NTPK7aEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740061930; x=1740666730;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dMBdw0e9dMXIMrENPd9v2HlkbkNjaIgiTbURYSwja34=;
 b=Db6JrbzEiXGex6U9gZxsrkX51WSmoMy+kG4cj56qxwoP8fJLSpwtubcV8BYg1t3k4A
 R5vHaai+vLK6S8+XmWnoz12XG2f9eKT26RmQlhVc29yyiGaCt5bhhimKJH9lMix8Us1B
 QpbfEyVaKPR9bjxpyl9YNPoql5kLXFHbQKreoIrPKKsHQr4NgdIIgNj2itFgiKcLo4a1
 TZeWvpExQOBr/swuJzao/CPKO+FrmXYQsP/Axo71iMKy/EIPYzJ0sjfrHA+OfWNUDA6l
 VGoB/k5cMe5kEM/MYrC48tpmiQ6u4IVXtBDuKI5mdHZEjp4PRsiTw1FcdCz9RAFvVsRU
 8Pgw==
X-Gm-Message-State: AOJu0Yyn2rRniY0A4StE8XDyYNpH5v4TIHW72/TcFm0SU/QpDKusdIIs
 rPfsVae5KHR5S8Tn6SX7SU39Z7sK8Lc3rfS/e2NN5+muYruwkcXKwOXMQ6BJP/34BSAdOpQ91D9
 f
X-Gm-Gg: ASbGncugpGj3xOwnW/tvovU5DKxYUH8urMYTydtNkt9We81OfsUNAaH1kGlRMFgC72B
 Tq9mgfjFTi2XFQPhfhKEKywUs8OmdNkE/B4C+gwvMmfNp+K4MCSph8hvAia0ciacA2xSfSFQS3D
 DJ7/0o2FwhIEas0XIqSyeEhOFkhABAICkabaJTFQm4ypCvuHRJU89R0dt3c0D3f11hqLWaQXQvh
 Y2bZb+r7KkcKsQPAvi0dTnPa3sQgQVOCbkYyMIZUQzyDPB1od2RvOCAbsUv2txIVpY02JIqS5fl
 6dVjrVmEk4bF
X-Google-Smtp-Source: AGHT+IHCS85T4GAnFLg7essTEpKOI8xR2lUGWobg5VsLHcNtxS56FhdgvIQyoZy2ib8oCEdPr4aEdw==
X-Received: by 2002:a17:90b:4ac4:b0:2fa:1a8a:cffc with SMTP id
 98e67ed59e1d1-2fc4115408amr30306568a91.34.1740061929781; 
 Thu, 20 Feb 2025 06:32:09 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d55963b5sm122294055ad.249.2025.02.20.06.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 06:32:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Raymond Mao <raymond.mao@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Stefan Roese <sr@denx.de>, 
 Harrison Mutai <harrison.mutai@arm.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Alex Shumsky <alexthreed@gmail.com>, Joshua Watt <jpewhacker@gmail.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, Levi Yun <yeoreum.yun@arm.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 This contributor prefers not to receive mails <noreply@example.com>, 
 Richard Weinberger <richard@nod.at>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>
In-Reply-To: <20250220000223.1044376-1-raymond.mao@linaro.org>
References: <20250220000223.1044376-1-raymond.mao@linaro.org>
Subject: Re: [PATCH v2 1/2] bloblist: refactor xferlist and bloblist
Message-Id: <174006192584.2910161.7983832016334879680.b4-ty@konsulko.com>
Date: Thu, 20 Feb 2025 08:32:05 -0600
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

On Wed, 19 Feb 2025 16:02:19 -0800, Raymond Mao wrote:

> Refactor the xferlist to remove the relocating when bloblist passed
> from the boot args.
> Refactor bloblist init to use incoming standard passage by default
> if a valid transfer list exists in the boot args.
> For bloblist relocation, use the actual total size if it has a smaller
> BLOBLIST_SIZE_RELOC.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom



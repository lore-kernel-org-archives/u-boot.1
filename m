Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E450C7113E
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 18:56:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7523C82A4B;
	Wed, 11 Jun 2025 20:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nNgWCb5a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9581A82B0F; Wed, 11 Jun 2025 20:56:45 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75212828A2
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 20:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7387f21daadso694966a34.0
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 11:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749668202; x=1750273002; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FcufqmgY39CPaA8/K6YMmbikTcpGKft8grJ7N4ZSKSY=;
 b=nNgWCb5aGRAnXfoN/RqcFtYRKeqoajVyy91t5B5N51rsVN8aplhntjvU8lpXVZyjUx
 p5Er1ttd4Ac8lsUVidWxG7ZOswo4Z0sQ1qRlR8bL5KwuGQTaYdlseReOnCUXhYbgVemL
 pNGjz80EnLocO9CO/l1Xq3khklWLWljVHAiaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749668202; x=1750273002;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FcufqmgY39CPaA8/K6YMmbikTcpGKft8grJ7N4ZSKSY=;
 b=YHCXZmBHOcVB/obRln3pGfBjJe9LwXOX9L9SvvFGnKto/vLbaL+x8pyFNoKz52GfAK
 Lf8tvA32EAKN94Hys6flrjDvRSF5YcXbRG32s3GVAGVHlWApfDI6I8Iqn/oWLE4W5ePt
 LkpHiXplwAd2/ocWroSt7SCfuri8YGg59ZoGVQGDsvdwkZrQMNqkQlCgDAyZY92t80Pu
 +Msp64EW+N7M0DRjiQ3CsrRVDQCx8e6U6UTXJsmsVMJIZol6+5iUtgw4KRly2biLPGJS
 qfHqHYG+6wmLC9cBWJQZFn8+jDNoKBAOxoq1D+hmRzLzPrStp5t+RfCZLWYQZ7AC979F
 J9Og==
X-Gm-Message-State: AOJu0YxCVGXWQj3Md9Kb+N6H79ZbjRZR0dRHYWjCgU/9KKP1kjAD48Aw
 AkSBfNL0jl3/cwVFnXU6EK5iNM5HBVvYW8t0l9ZoF90h6MeBuEMQB0ud6sz3bBcSZB0=
X-Gm-Gg: ASbGncvJFc3xdMWo3OR1trmVR3lX1Ga4vwSTMccE7CArrgRBv8ifoPiiFvqjOkKzIJa
 vfX5udYFJdz3LGem8uEwkuoqSYRWWZu7VyzW8YPftWbyT5W00Ra0ZlIjQknLIRylwJFji2yFJ4f
 MGT4zNCeTp0znG+akYDb6B296cwFoF0pogT2MBRJLHQX36TP/dcm56tHb6w+a+orULuSl7Ars+m
 idGTabzorvMBt77wEYQlPfJjiXof9UXNTG7WlzizWflV5C/xEj3Q68uipXZEkwg83QO5wgghNEC
 RpUrM3wBQSLXmgDIzQUsd/Q0qWuGAJn0hs3VL0o4SXtlA6dKRS9MaMdkZ7YyON59bv7F20/HykJ
 BkxHKFOIGbap4TMt9XlAGLw==
X-Google-Smtp-Source: AGHT+IET7YWAKZruQRN4vqdf1lhroZjX5961VON3DMnmW12Dgw8Gg7MYuvJZDvhA5QYGG8M858j6BQ==
X-Received: by 2002:a05:6808:23d2:b0:403:304:6b06 with SMTP id
 5614622812f47-40a66015927mr482463b6e.10.1749668202144; 
 Wed, 11 Jun 2025 11:56:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a06faba86sm411040a34.2.2025.06.11.11.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 11:56:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: sjg@chromium.org
In-Reply-To: <20250610191503.1708064-1-ilias.apalodimas@linaro.org>
References: <20250610191503.1708064-1-ilias.apalodimas@linaro.org>
Subject: Re: Pull request for tpm-next-10062025
Message-Id: <174966820133.4178798.6091716937807462761.b4-ty@konsulko.com>
Date: Wed, 11 Jun 2025 12:56:41 -0600
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

On Tue, 10 Jun 2025 22:15:03 +0300, Ilias Apalodimas wrote:

> Small updates for testing TPMs for -next
> 
> The following changes since commit 59d00e20fced23e6463aa09db889dd548baee677:
> 
>   Merge tag 'v2025.07-rc4' into next (2025-06-09 16:28:28 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom



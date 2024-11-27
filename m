Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC6AD6ACCD
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 13:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A145897DC;
	Wed, 27 Nov 2024 14:07:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hGgVcLZN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19AD0897DC; Wed, 27 Nov 2024 14:07:50 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D9EB897F9
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 14:07:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9a0ec0a94fso951656366b.1
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 05:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732712867; x=1733317667; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kcAhEOPurZ/rEZvbWqzFJelXMGkEIsLWRz8MxuhzCS0=;
 b=hGgVcLZN6lBnhltKgXLYOELc6MXGFuH6Ak74igJWTyIsvAvyQ2XFnLK29EiKOxSdy8
 6q3Kx+ZJVVsegUyRCCS7HOSu13zameYU0i/UOvaLPEjCyKphEo+e/MatPZb1HLaRfU9e
 bxiGHF6wTmhCi5WxLie2xSJSBZArpTr71bxDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732712867; x=1733317667;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kcAhEOPurZ/rEZvbWqzFJelXMGkEIsLWRz8MxuhzCS0=;
 b=v72FwoBWsF2MxJum/rQzeylIZPSCliT2jtOkb1+Ct7MmC2v6BYf7NI+io+QbR6P0ZV
 cuwnNLmN7SSUHawenq6lIW1bi2pdv5ohdhuz2qf1IDS7Y5fcKW7yZmycZEO9eiJYFqfd
 j+UMzs1IIFI73UHtBAkxz623NAmFcqLtV+hmxb/oBc8oAwoJx5cmdmZ6NHITeI1RwL47
 jj3AnUlzZvr/hfnd+9j/fm+zvsX8M5v4WhvT7eMYd4g/xczkOhd74edb+G/7nleEvZxr
 AQbYEqybomuv+fRi9Lr4Pqdcr+yGpU970VLp+U99Y3hSBbr2Z/ymrRrWR1N52InsZU4O
 Uhgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJqc4ek+GGPj0svyP8CC/RxCmZKrMPvqzvYIhqVLuOqAOhHX9PZMc56FY11j1+fPYSExeYars=@lists.denx.de
X-Gm-Message-State: AOJu0Yw86fNqUon8mTHcIv29DQSihXC1tIKDX8KnH5fRb5nJcdkpV26u
 6wYgpmyWwZzcM9OpeVtHoYiV6A3nJ4LlrC9Lmuu1Us31R2mYdxtWcteVsbA3/8Ys5MYdkHNy6E7
 5dNXnVcZFO3+5MM1GWWVwK6vKfJ9v91MX1ruNzDvWXftdy3M=
X-Gm-Gg: ASbGncuWNGS2e7XoBX4kOH+cKCWv/iMya47uJaFwIL35LEjya8wtnGMTHtcKBct9876
 N1zze4USGcKZ11322yKMbwqqfv6uyE/U=
X-Google-Smtp-Source: AGHT+IG/6Tr9z+5QhJ0JiWbTss2Me07zuEoHIhyNlPFVtMYDD4+C1W1+X7whoygfzHYji+No1ZusYKT9WQSNzsDQC0I=
X-Received: by 2002:a17:907:7756:b0:aa5:4cc1:1965 with SMTP id
 a640c23a62f3a-aa580ee874fmr189869666b.3.1732712866881; Wed, 27 Nov 2024
 05:07:46 -0800 (PST)
MIME-Version: 1.0
References: <20241126105131.43359-1-g-praveen@ti.com>
 <20241126105131.43359-2-g-praveen@ti.com>
In-Reply-To: <20241126105131.43359-2-g-praveen@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Nov 2024 06:07:31 -0700
Message-ID: <CAFLszTh8LcvuxrVfDd3eEWyPuDpa4rqg_yQLaqQhyOgcKuhFeQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: ns16550: Increase scope of ops functions
To: Gokul Praveen <g-praveen@ti.com>
Cc: trini@konsulko.com, rasmus.villemoes@prevas.dk, sr@denx.de, 
 pbrobinson@gmail.com, jonas@kwiboo.se, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 26 Nov 2024 at 03:51, Gokul Praveen <g-praveen@ti.com> wrote:
>
> Increase scope of ops functions and do some clean up for usage in device
> -specific UART drivers.
>
> Remove the static functionality of ops functions and migrate certain macros
> to header file for usage in device-specific drivers.
>
> Signed-off-by: Gokul Praveen <g-praveen@ti.com>
> ---
>  drivers/serial/ns16550.c | 25 ++++++++-----------------
>  include/ns16550.h        | 18 ++++++++++++++++++
>  2 files changed, 26 insertions(+), 17 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

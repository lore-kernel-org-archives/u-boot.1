Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CF5D1039D
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 10:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E7F784011;
	Wed, 26 Nov 2025 11:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S4vNw+tq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7735584088; Wed, 26 Nov 2025 11:56:04 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5449B83FFE
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 11:56:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c75387bb27so1931906a34.1
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 02:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764154561; x=1764759361; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aNAoQKrdfkuqn30uKVfBPHXjpo2b9r9IA2FeRJPTJvQ=;
 b=S4vNw+tqxo3S6uLYfA253FcdSEO8HmgKJi3mUOL8BGIo8IxRjyxP6NnzX9+Wz4EN17
 agJKM+DdYBMgQS4z1BPIWcyrnWjgeahQgKQs4NeR8EDgjC+V9M3iFOVpuSBXEzPXO2ZJ
 YdK+AvH5TDjSjDADgfjc7TwUwUX3atd0sCmzzRrShKtwnTq5+J8SQ0Lj2hRBb86flyOL
 ADNLVGm/O3e9uAELmTj0YOPgdMI2qbcSRSXFDc4AMcRdWjYF69A/1W7fx8FhxbJS+mxv
 QdgqAHUJkjyTJlwBFtko6FrQOfePwjnt2D5RPtotUyw4DbTW3c/Lw7nF8ZdwsGstPSyb
 I8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764154561; x=1764759361;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNAoQKrdfkuqn30uKVfBPHXjpo2b9r9IA2FeRJPTJvQ=;
 b=PjybB/bHeTBfObf3q99GMv1udUfnaftC6p0Y3nczGPDrabQBi9JIoZjDLPxIkICQ1R
 bSH2veQ8wSEZbg7OY7KT5mhy3cc9V8Q093tHXrXCqSovvgAz+18B89Wphn5BaIDgsLdz
 lRwNS/MOOKukq2UZgFLqqx326FxwMJUbNwS+KGhI1K5ocpp/mGkEHBg88aQuKpyPzdw1
 hA5o0TVHgBalmAla1y+1MiTxVNyB30uN4yP1K9r41cnbuUMf39nGhh7AG3bVE2qZekIv
 IhPBB+lcJKKJWrE+8gVDBf5zQed33Jmy9n/fp0J5OYchxUlN6sxQf5TTfPmp7Uu5ZfzZ
 y4xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2aq16bYtkIsnNAgtORZXln0pQDYJtNOpPCHG4wUp+srCrfJjalp7B73Q7qUcwPoPpH7Ucsm4=@lists.denx.de
X-Gm-Message-State: AOJu0YwUlFJeULb63Vvuu0pzLTeCprktUM0I6D4Uy+eh8tGXVDDJOtw8
 PZOT/0xox/pBrY0XBPfohrS3/eIJRueKpUOT2wTZwkza3xx1d81hNnIoAhPkdXr8r36zx/mLT8L
 eGQa/yhGetgywjTjuO7sPq62k55mqCL0=
X-Gm-Gg: ASbGncv8Bjx4OtV5Us4sJMbGEHYzBeAB3a+hk1Tv0uGJ1dVUJ70nygaNweXIQXFKTOe
 BoIHa0Kg0IMIMo54ipWvhsMv74sFF0/HR1eCE6ysV3tOfu4ZOIAm4LVhsn5fCcKR5fMuHZoVpzk
 PnxJC1uObolIo1axPN+NNsipKYfvNX/V0ldr7bslDFeMeXQJyJbDbY6Z8070W8J32csQN1pfV8h
 lMcIZUbrIwPjZ1/ZHBQ5XO6res5GFP1jaD0lhIOelVNfa6oeRxVQ8+yI3zZ3pF5PSdHvSvCB0N1
 Tp7M
X-Google-Smtp-Source: AGHT+IHz1/HXhd9X5rAv9CtSeHNzbwDpe0qAiNQdlxV48bYec9l4vDmpUzhYIOFkJurjQzwtPPXu9rlDWY5vh7vYNDA=
X-Received: by 2002:a05:6830:3885:b0:7c7:58e9:8e16 with SMTP id
 46e09a7af769-7c798b322a1mr7915874a34.14.1764154561026; Wed, 26 Nov 2025
 02:56:01 -0800 (PST)
MIME-Version: 1.0
References: <20251125123847.307-1-briansune@gmail.com>
 <05987960-b2fa-4798-9504-78aab483e146@cherry.de>
 <CAN7C2SAh5cfXKWxVq1omhtTkgbbFCZ2-kcG8A-+tggWuPUWqpA@mail.gmail.com>
 <54428bab-5189-48d1-9b96-977487648327@cherry.de>
In-Reply-To: <54428bab-5189-48d1-9b96-977487648327@cherry.de>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 26 Nov 2025 18:55:49 +0800
X-Gm-Features: AWmQ_bmZz_UvhQTTkQ2iZZYOdimaCGWwXAtgEODs_diQwk1jIXBKU2ambdxTfVw
Message-ID: <CAN7C2SANa72etXcE+C9q4UkprmfbHXOgTBP1fhWxGcVPH3Ongw@mail.gmail.com>
Subject: Re: [PATCH v3] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

> Yes, but I only want at least one board this happens on so we can try
> figure out exactly what happens with this watchdog.

I am a bit confused. Sounds like this is affecting the entire U-Boot?
Isn't this just a Cyclone V GEN5 socfpga issue?

It is a very generic setup.
clone from fresh

make clean
make mrproper
make socfpga_cyclone5_defconfig
make prepare

Now please cp .config to .config_default

Ok now
make menuconfig
/WDT turn on and save
make menuconfig
turn all those you have enabled
save again.

then gvimdiff .config .config_default

You will see what I meant.

Enjoy~
Brian

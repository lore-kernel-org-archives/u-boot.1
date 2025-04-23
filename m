Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0A4C369D7
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 12:28:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A38F181E25;
	Wed, 23 Apr 2025 14:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LcWbCFbI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9351819D2; Wed, 23 Apr 2025 14:28:49 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C07BD80050
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 14:28:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aaee2c5ee6eso664868366b.1
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 05:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745411327; x=1746016127; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xt965EmaoGeDAoV6lnx2Vn/RDGDwDvUq5qhAYC6rGfM=;
 b=LcWbCFbITxH+zngwv8//5yu5sji3I6erYwJ/ACfGtp/HzkNMW+F6+lJ9XqiFCE13gN
 kbw5ZIh7qnj59FQdja41bwDJ8Srn+IsJ1aHQjX/V3XISgoNGDIOvOhm/KvLbuIzI4UKM
 7fx5sHhjX9bD9iBBNrJDWdp5zVkrC1J3TzWqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745411327; x=1746016127;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xt965EmaoGeDAoV6lnx2Vn/RDGDwDvUq5qhAYC6rGfM=;
 b=Y3uQZcCGuSUtYW64SgYyu7oQKW5Mb8WMNezpXXtsAPOL5i1eKk2xsqDymJ8zEyEs7V
 6IAWJvVZ4FPw+lc0ShPFnoQcOyaAGFkE1ocka9z6Gp1KH8sksqwi5n47T82zycLkQ+aV
 vKVjLVHavLYqgVNytanI9RK9RyQMU0hBOBTMiLnhuH4Vft0d2jQ9m6odbFUH6gBA00qq
 cmb+9E4MW1yBrKJqtD7/I+V5aLAs6FrJ5z2TamY/ijWpxuOcrwzq61OE8baReM2x4n/3
 P9bb1JJpf28DaMwyvWeO0r0diQrTodetnEkJMZny5didih8h3OAwXGDpgPrk/MsYtqDQ
 EUhw==
X-Gm-Message-State: AOJu0YyyGHj8Q5vD2B0+Nsd6hh9RG/zvEaOUn2wsPjlvpzQZNw56NPGh
 2Z4RwjXSUaMBKWj+1rL0Z26nxhJxs6AgdAbjt+ATEWH2kzckHM1UNqu4+PBmmQIuN6xqOJNRqdx
 9eGl40YUuyy8VEACmICc5qlITW5tgESjBhidf
X-Gm-Gg: ASbGncun0Aj4A1GQN+VwFTldSXbFTyW1982GOM0pdJ7yEShTa2k91FgrZT58ytSJ1V/
 2bnyROf95DuRyBb5AZ9Pf52iwkvOP7n2N3sBFg9ob8EFt7UrtDlfp+zPkHWafLFb+3eEGeJlf3y
 9IKKP61PXgVn3e1rVjfSLWrng=
X-Google-Smtp-Source: AGHT+IHdB8DP2Mf2ZJf11WVQPsLovNjttUbGPwRKa1t4f6Mko4wYB1Jq5saUAM/8fr8ctThpRvFERpkzYREWzhw12tM=
X-Received: by 2002:a17:906:4e9a:b0:acb:94d6:a841 with SMTP id
 a640c23a62f3a-acb94d6a908mr1048198066b.16.1745411327264; Wed, 23 Apr 2025
 05:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <D9DXL95MTQ8I.3EUY0C6M2L4NE@ti.com>
In-Reply-To: <D9DXL95MTQ8I.3EUY0C6M2L4NE@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 23 Apr 2025 06:28:34 -0600
X-Gm-Features: ATxdqUFjUymJ-ulPmQS03ZUMAhtwyyEBYnkNHFl2nQcP6fuaJSj4WrVZw4Shbuc
Message-ID: <CAFLszTg72Ai2V-L3MKvqDx8ROk97jiW4bvAbvFtZEAFBBp6qfQ@mail.gmail.com>
Subject: Re: [RFC] Expected behavior of the go command
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, rick@andestech.com, 
 mporter@konsulko.com
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

Hi Anshul,

On Wed, 23 Apr 2025 at 04:04, Anshul Dalal <anshuld@ti.com> wrote:
>
> Hi all,
>
> I was trying to understand how the go command is expected to work when
> used to load custom OSes. My use case requires getting a proprietary OS
> to boot using the go command on a TI K3 platform. The OS expects caches
> to be flushed and the mmu to be disabled before we jump to it.
>
> The go command (do_go func in cmd/boot.c) calls the do_go_exec function
> underneath which does not seem to have a consistent implementation
> across various architectures.
>
> In RISC-V the implementation (arch/riscv/lib/boot.c:10) calls
> cleanup_before_linux before jumping to the loaded binary. This behaviour
> would enable the direct use of the go command for booting a custom OS
> (like in my use case). Though no such generic implementation exists for
> ARM64.
>
> I was wondering why we have the call to cleanup_before_linux for RISCV
> and not ARM64?
>
> Also, is booting a custom OS using the go command a supported use-case?
> If yes, it might be better to rename the function to be more generic
> like cleanup_before_os from *_linux and call it for each invocation of
> the go command.

Yes it is supposed to do what you say. You could rationalise the code
a bit, so that all archs do a similar thing, or perhaps just RISC-V
and ARM for now.

Regards,
Simon

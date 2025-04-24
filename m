Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80433C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 18:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CDF78056A;
	Thu, 24 Apr 2025 20:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hpblGPxY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DF888082A; Thu, 24 Apr 2025 20:30:58 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80874803CC
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 20:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-acb5ec407b1so232370766b.1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 11:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745519455; x=1746124255; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K7KB7JfTV2QsJ1V5QQBzymIdzx3AVUTOludkbyGS5wY=;
 b=hpblGPxYocYbumb/cjlgdrN+n2QaiT7SmDYM2lfCfxm4zS93HOXufDcGsEpuIJzwls
 9SAukVZDtG4+wlkj/mRfoaMF8wlXc4o9RaB4cYi+w87dgxohyMZU1j0kBx0oVkDt8wdF
 vklkpH6wAnwSL773yQ+/PYxDXtDbQooouNhlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745519455; x=1746124255;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K7KB7JfTV2QsJ1V5QQBzymIdzx3AVUTOludkbyGS5wY=;
 b=ZGUCXHb5t1ZNQcsBnb8L47jo7NJxTc4BS+5FtxH6xO2fCxQmAVz0b/LwIe8GcgM7/c
 Ai2Mqc0kLfqOeGz96ZG6ROOgg+xyATux/u06/t6EFXJMkVCd4iTR1g3nJoXP5OKmEDYq
 cTUWVj4R/z+BRvr1sgnpvNZL1+KEtwXAhCKdwAPxSy96xEl6/LGXJ5BZ3JCAWVCOyLMp
 U95C3IEUuy7EYnvebJFAtk0pU9CgEq4nhRjaVXXgkKqX17h7y2U8t3BUWXCxXFaX3A3Y
 ucZ/K7J9G0iZrqtBaJ1afOjdJb2g/5ltoB273HPGLY6JFy6bsTKEx6X/hzab9Y5jcdpd
 xSdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz6K/NKyVrbie6qPg7PhUbaqtd8/iWAAMf4irJ1V9PyokDp4VXoQVlNUactxdP8YDCac8LERc=@lists.denx.de
X-Gm-Message-State: AOJu0YypmRvfTrc9RHINHPNFznmY/qiFDRha27S+3PaqhuBq9mHBme7V
 6cNuVyNc72imIWSX0RLm6eBHdnMJgOQ2oRLUf7jxw+SUeXvJMduEqRo/lYoKUS+BI0wOXoqgJja
 BSYVojhFn3vPw5NkGNp1pZIT3pF6X+6VQPG4g
X-Gm-Gg: ASbGnctelX5aAQoFvDjXb4k/M7QTm9iLM7Zzcqu7wjLDn4UnU8UovAakEjGA/DWH+Mv
 PyD5+zsEwLsU6ditjuG31QCkI4q7gScX/ItxPbuLC7isR0UcL5uzOMiihVBxQlPVCnfsbH8XuDY
 zGZhxjR0mbQQ+TB92iwfD2Jzk=
X-Google-Smtp-Source: AGHT+IGQpFN5wvx7ZTjHWIi7Z7CRkKAjG4Iim7cR6HoGl+UP9HE2xTR0jEIic4O0FjbS0iotUIuHnE1ogryqgalnLrg=
X-Received: by 2002:a17:907:1c1e:b0:ac7:805f:905a with SMTP id
 a640c23a62f3a-ace6b3ed7efmr58528266b.28.1745519454859; Thu, 24 Apr 2025
 11:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <D9DXL95MTQ8I.3EUY0C6M2L4NE@ti.com>
 <CAFLszTg72Ai2V-L3MKvqDx8ROk97jiW4bvAbvFtZEAFBBp6qfQ@mail.gmail.com>
 <ad4a911f-681a-4fea-b79c-8489b47d7360@pengutronix.de>
In-Reply-To: <ad4a911f-681a-4fea-b79c-8489b47d7360@pengutronix.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 24 Apr 2025 12:30:41 -0600
X-Gm-Features: ATxdqUH1itaHGfow5fl_muD9P6GsDAylp_GKDJCbwzRcUrO4eBSkjlna1AxEVwQ
Message-ID: <CAFLszTh=P6UECz6s6eWULVNgPLrQFX-jmHqOkJwzqY=c0m4=AQ@mail.gmail.com>
Subject: Re: [RFC] Expected behavior of the go command
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de, vigneshr@ti.com, 
 rick@andestech.com, mporter@konsulko.com
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

Hi,

On Wed, 23 Apr 2025 at 08:22, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hi,
>
> On 4/23/25 14:28, Simon Glass wrote:
> > Hi Anshul,
> >
> > On Wed, 23 Apr 2025 at 04:04, Anshul Dalal <anshuld@ti.com> wrote:
> >>
> >> Hi all,
> >>
> >> I was trying to understand how the go command is expected to work when
> >> used to load custom OSes. My use case requires getting a proprietary OS
> >> to boot using the go command on a TI K3 platform. The OS expects caches
> >> to be flushed and the mmu to be disabled before we jump to it.
> >>
> >> The go command (do_go func in cmd/boot.c) calls the do_go_exec function
> >> underneath which does not seem to have a consistent implementation
> >> across various architectures.
> >>
> >> In RISC-V the implementation (arch/riscv/lib/boot.c:10) calls
> >> cleanup_before_linux before jumping to the loaded binary. This behaviour
> >> would enable the direct use of the go command for booting a custom OS
> >> (like in my use case). Though no such generic implementation exists for
> >> ARM64.
> >>
> >> I was wondering why we have the call to cleanup_before_linux for RISCV
> >> and not ARM64?
> >>
> >> Also, is booting a custom OS using the go command a supported use-case?
> >> If yes, it might be better to rename the function to be more generic
> >> like cleanup_before_os from *_linux and call it for each invocation of
> >> the go command.
> >
> > Yes it is supposed to do what you say. You could rationalise the code
> > a bit, so that all archs do a similar thing, or perhaps just RISC-V
> > and ARM for now.
>
> I ran into issues with go too trying to start barebox and I always
> assumed that go is rather meant to start programs that call back into
> U-Boot using the jump table mechanism. In that case, you likely don't
> want to turn off caches.
>
> What I settled on is having the barebox build generate a FIT image that
> can be used from U-Boot, barebox, coreboot ...etc.
>
> Maybe the same would be also suitable for you? Alternatively, you could
> compile your custom OS as an ELF image and boot that properly as if it
> were a kernel. Both ways would also allow you to specify a load address
> if your OS is not relocatable and pass along arguments.
>
> I went with the FIT route for barebox, because we can now ship device
> trees for all enabled boards in the same FIT image alongside one generic
> second stage barebox with DT support. If you want to support different
> boards with your OS image that might be of interest to you as well.

Yes, FIT is a better route and we can even add an OS type IH_OS_xxx

There's also the option of adding a flag to the 'go' command so that it can

Regards,
Simon

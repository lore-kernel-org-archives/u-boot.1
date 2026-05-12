Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D635CD343F
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 18:13:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 414AB83C2B;
	Tue, 12 May 2026 20:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HLMwZPhZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33DA6838BB; Tue, 12 May 2026 20:13:32 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0247C8341A
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 20:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ba545100a13so1003381766b.2
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 11:13:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778609609; cv=none;
 d=google.com; s=arc-20240605;
 b=DlZiyTn9wlW452ub6CGfhgg0YjGyuNJXm7LxxQRqsPm9W9Gg87o8gE0Xq7EhFKcIbq
 I/ghPoKVw4ERlTHwIfRx2dA9pnI1wgsxiJ4KCOoO+3bjTb355sMbB4BrIrar4k2tJAwL
 K6oc4+rGmbKyHY3F3gKb+GgAU+kPJtrkxFHdbBvY2vQ1+3F/9Vt5Fas3vYUeUVUloOPA
 yqmHXVyDxc6H2xboUmXt0RyHpkFD3W5TcbNv/AOl+V3jPrWBtcEad8n6AaDcXRTAE5AY
 zjo9re8J2YA6vlY3PmYNNEfXlpJSd0Uh2fhsRfV6Eq7yIu6j9qTEdNjen3rOtlbPgTHJ
 UD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pS8gPDW8ofTqYXivI74N7OkX/bgp9zRMAir6UAeSoLo=;
 fh=BsH0Kx5UM60s7rlnN26WIKDveEm89bwRV0dUXUky/AU=;
 b=PmuZds/ZZVgCEZGOw5Op4DuyhkyYWr5BPCLSw06ieKUrWNa8njnF+BB6x9WOBnUpkd
 JPg1dnfGaxNJ7+A3ruKVS90D4RWroqg7pe3S+2Jynz1Y41yUdwvplcjcU9tbLRoTb1Hq
 7vtNJVr+9U63ctaIz5aCwa8WHItpS9DKNb6TZZzwMYFd4ga9bexjGIl/GUh+eg99u7cu
 mKxUKkGSV0Q8DyulwCvpd+22lsXZ+kifH1VoI15Rbzyqu/gqcJLExDqRBD0qiKmTp2F/
 HjOKKDwuXprufqRoAc1YMEgl8I4M9QRyt7qd5F+XxtdHfGtMrg8m7pZDrtC1iDPnBqIm
 lsdQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778609609; x=1779214409; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pS8gPDW8ofTqYXivI74N7OkX/bgp9zRMAir6UAeSoLo=;
 b=HLMwZPhZI4fb7zJ2maJQGVscI1BA/sKbQc+zcnz6/nImalkUmTseH8DyTuk/Z81Weo
 Pi7PMjqFRMHIfITq7VaGnWK7P+0TC0Z8p8Y7U45bc7x/rAlabUYVunBSr9Q+6EVEFEwq
 AZZ57UgKdcRoZqp6yq+gYjktcR5KRsWHTc+og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778609609; x=1779214409;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pS8gPDW8ofTqYXivI74N7OkX/bgp9zRMAir6UAeSoLo=;
 b=kS+MjYGXQEEXLnE7U+aIe6xXLw2GyVX2qiJPHb0Yhnq2z+ml81fqjCBjyKAHcWPX5T
 lPGPuumzCqX7KaqqTSYWOQFaTAapohq5ACustX+19EeCW5PF3BzE1BxXdCUa1CFAAXpT
 ghNqeRTMX/9Y03d767WbsT7KT0VBzNjvrrvJvKLF3HF9+tAwqHsFHDLWxk9nfYSSmk0L
 4JlUHrFoQFdsN3BF38dmMUGpwWxRUC2QFBV9VOq+05tADmzYRr29gXOEko0VfrzSIXmN
 QbPmFYXTxAns9LA5EsPc9LuYOvZwEedVjQed7my6O/rPdHqcPFpcAV5gMBPb+xw95ERL
 kunA==
X-Gm-Message-State: AOJu0YzgApfR1tnUZvudM5X+M45zQtEOUfIaWZIzFFaNNLd+B9tixu+S
 zaZjx6Th2T4QFUN8tRUKg+jOmFrW71kLA/LzLK9edUB9Gk3VUVst4BvtMvRYSwGcgoi9f8k9e5d
 9+mL6KdS+KuAV+OHHG285Kl6B0b6ur7G6sGE1+mPL
X-Gm-Gg: Acq92OGdF4YGGf0XM4nQDeFXIIM84sxLOx3QtljN9gOD9rkRIPWBq4AefPBCtY2T9Z5
 EQDB1IkzAgJzs5fbBEKl+qDMLRJGnatwAGE/oyZJog0Gw7sH9g3FujBIzo7G4frvEIRcNLVYPDu
 NsTtrcjXUrr+pW+ql3lscNzwkODL4OMKwsbrIPXl0yFVqbNgY6qcOtMwaELcSwrffiRROW/Rq5D
 gytE6CG9ahgdzwFfFE16YKmLT+yH+idQnEzlmY+qqhC3ZAjXK0OeCAsEPTWZ7x/gfVqcOluodVt
 cscK2w==
X-Received: by 2002:a17:907:61a2:b0:bd2:47dd:e0c3 with SMTP id
 a640c23a62f3a-bd247dde148mr235995766b.20.1778609609463; Tue, 12 May 2026
 11:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <cb01c903e27bd1aa6198a51b138409c08abd3373.camel@pbarker.dev>
In-Reply-To: <cb01c903e27bd1aa6198a51b138409c08abd3373.camel@pbarker.dev>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 12 May 2026 12:13:17 -0600
X-Gm-Features: AVHnY4IfVMlsFLzy63O40u0UMxEtdsmj3w9zApe7DUJxO8vMWWdQScchsdZ4pgA
Message-ID: <CAFLszTg4v5H2T_NqJ8FbzKNpv2LwULm8iUqQsONJdgeLfu0Cuw@mail.gmail.com>
Subject: Re: Status of CVE-2025-24857 in U-Boot
To: Paul Barker <paul@pbarker.dev>
Cc: u-boot@lists.denx.de, yoann.congal@smile.fr, 
 Hongxu Jia <hongxu.jia@windriver.com>, Tom Rini <trini@konsulko.com>
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

+Tom

Hi Paul,

On Tue, 12 May 2026 at 04:39, Paul Barker <paul@pbarker.dev> wrote:
>
> Hi folks,
>
> We recently had a patch sent to Yocto Project to backport a fix for
> CVE-2025-24857 to our Scarthgap branch which uses U-Boot 2024.01.
> Looking at the CVE info, this has confused me a lot. It says [1]:
>
>   Improper access control for volatile memory containing boot code in
>   Universal Boot Loader (U-Boot) before 2017.11 and Qualcomm chips
>   IPQ4019, IPQ5018, IPQ5322, IPQ6018, IPQ8064, IPQ8074, and IPQ9574
>   could allow an attacker to execute arbitrary code.
>
> The NVD page says it affects U-Boot "Up to (excluding) 2017.11".
>
> But, the patch that says it addresses CVE-2025-24867 was committed to
> U-Boot in December 2025 [2]. The first release containing this patch was
> v2026.01.
>
> Is this commit actually needed to resolve that CVE? Or is it some other
> change back in 2017 that fixed the issue? (A yes/no is fine, I don't
> need a link to the exact commit)

I believe this was the commit, from December 2016, which landed in 2017.01:

6c1a808052b fs/fat: Avoid corruption of sectors following the FAT

Tom's recent commit in [2] was just a belt-and-braces check on top.

Regards,
Simon

>
> [1]: https://nvd.nist.gov/vuln/detail/CVE-2025-24857
> [2]: https://source.denx.de/u-boot/u-boot/-/commit/87d85139a96a39429120cca838e739408ef971a2

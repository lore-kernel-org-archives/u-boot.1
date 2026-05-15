Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D30CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82D87846CF;
	Fri, 15 May 2026 20:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B/bmUEOQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71562847C5; Fri, 15 May 2026 20:30:20 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 800A4846AE
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 20:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bce386d5b85so10158866b.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 11:30:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778869818; cv=none;
 d=google.com; s=arc-20240605;
 b=hfPDcHkgMNSrs2oB5clDEi0sUwPHR/9SReR90zGQAIh07L4wTYh0s0MvSeF88q6fno
 1nDu5qLPuS2v5PSkoUeK7l3RHtOOQewQHs4n/FmFIpQ8qptAKYgBUkYTtMWeTLouZV69
 4ILF2lg0lkiQ4Lb2AfujcDCVaPIA4rpKcv4HrO2qIZBvn+Cq8aUMUEaQQtImxlGkpbX4
 VsQdtmsQ9tKgOULHOcIvty8YNHKzvj1LEWe3wuGwGVWlqGTdMmiAobAKpZqBuVJdp8Y4
 /L2WCTaqmTOixBxtWVTcqFkRe3IAzPXJI35Tl1e5/CvPGXYGVG6xwMskK/9hSZdWZoiZ
 wUwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AARfB5tUTi0+HQlfQMYHvSCmUgrqVdLKyDY2xThI8vE=;
 fh=sKlYf1RYFkU7W57k8Hb0RqRH+ropi6os4Aw4ruwQ2Xw=;
 b=i7okEc1BLLFZUEIg26iI9YtUBkMzcy79lGhueUMsYCVCPtyoibVZqKkiRLn2Vp8MY1
 zgbi5Xt5GL+6GvXovNPUaoAo0qHE2XTXENeiM/tPbenaAZggKGyVwfjcUes7bZJET3sc
 5HV1nfxzERE/ejotpB8iK63KRQbedtGr+o+691S4mQ1gcNKWs0q0eHPqLWsG0oSBb337
 pg3TbuIFSNxmOWZcnHuQfSCaJVWB67zhc8DT7vfy0imZfagkYTemNtiu7wrh/r/vrXwZ
 WgZYeT8OfGxmftORheFrTSDFcyiVOHY1TFGU9bM75uGXZoWjRJPIALNwWzi/FUT8+Fbf
 SCNw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778869818; x=1779474618; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AARfB5tUTi0+HQlfQMYHvSCmUgrqVdLKyDY2xThI8vE=;
 b=B/bmUEOQYnWsjW4rbUXWrYRFfMW8KgCtaijHLHHUQRY+38KGtOsMEaQp8kH08Ve0G2
 8wbRLOtXcWEAlj0p9uNC82Gl6hM3OAMHU5GU6BmW2SiVtXgKwbT9W7spDyNlJtf9x1ui
 2BuLufQald7rdcU/SBJHgYc6NZa3lrZKM7Gik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778869818; x=1779474618;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AARfB5tUTi0+HQlfQMYHvSCmUgrqVdLKyDY2xThI8vE=;
 b=HYTGyEUHkJLH3B8ageFC7eGHJYXWxWldJTH3tj8TTHrlmlY/X2C7JUIXAOdcCU1LpN
 gDxDxfT6yj8Yj7EMjRoWIvniaKdeaIQt0D0AgP+vSq1T5ZdMRoGKigSnBnshsqjzKDi/
 QU1Wr7lG26auP05AughGhGrTQIqsNNkgdPPam8ecA58blm8BS5s7RJK1FpIB569Jo4lD
 lI9QtcuvkjJSclG6qDnLzwxAlE3oDc9TkEeJgOu/9ixXyjPPyiLGoewJp+XEyOIaBElN
 xTTDN+bnR4PhDms3d82mG0TiF95mY0elqxplFlvKGuha5cP+RL+AD6PwlFmYY1hTKS/F
 a02A==
X-Gm-Message-State: AOJu0Ywi6niu4azFCQia8hBFRyGJWEGoC1hh9r8V3AgIRh1jrfL8biGW
 DAhtgEBMaQm5//PQK2gUyY3c6AyYrpM8v4pLJjHL6iiOm5ocYkuKZRlTqtTHojxLbN49O0tklhp
 glVsVaXZqZVMHPwVbc+WDWTGC/u5ctSY/mhgM42nx
X-Gm-Gg: Acq92OEjac/eHvgD/Jc1tLJGS7BJTAHtUq8BdlSULeyq5r9nNov9DHJJReSQhdxcXUK
 dlV0rPTj1ieSDnuQVSTqj2mzcBxE/+HBw/IQFRoF9KK2Z0W9enTqgsyhxtgGiYk/LpgeWsmkXLZ
 067tTJz/+XvlZLkbSJVzqiMMzKXa/7igNMJuVqnCCfgi+vo8M5v88oDm2yi2YspMmfQ57+9xPcL
 zgdmo4nn/J7ZqAwfMtXkOLXN5jC51bNkiw5S7lrQ1OnX1B4vTYbE+9ir2zL72DkwUDLcGDrv86m
 XXvpmQ==
X-Received: by 2002:a17:907:c705:b0:b9c:5cf3:50a6 with SMTP id
 a640c23a62f3a-bd5179300a0mr314118666b.30.1778869817918; Fri, 15 May 2026
 11:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-11-harsimransingh.tungal@arm.com>
In-Reply-To: <20260514124924.1804332-11-harsimransingh.tungal@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 12:30:06 -0600
X-Gm-Features: AVHnY4LHOc-cBbwmBhJR2z3CZjiyIgrqfzmnX41-THCPUZD7d8pROraGagONBgM
Message-ID: <CAFLszTjEfsc0EO3kZhQmPOgi+WvfaoqW9XkoEUu3yjnbQaP-yw@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] doc: arm64: document FF-A runtime path for EFI
 variables
To: harsimransingh.tungal@arm.com
Cc: u-boot@lists.denx.de, abdellatif.elkhlifi@arm.com, trini@konsulko.com, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, hugues.kambampiana@arm.com, 
 sjg@chromium.org
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

Hi Harsimran,

On 2026-05-14T12:49:13, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
> doc: arm64: document FF-A runtime path for EFI variables
>
> The arm64 FF-A documentation still said EFI runtime support was a
> future development, so readers had no description of the current FF-A
> runtime transport or how EFI runtime variable services use it.
>
> Document the FF-A runtime transport, the shared MM communication path,
> and the EFI runtime variable flow on arm64. Also clarify that the
> armffa command is boot-time only and point readers to the architecture
> documentation for EFI runtime variable services over FF-A.
>
> Acked-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
>
> doc/arch/arm64.ffa.rst   | 86 ++++++++++++++++++++++++++++++++++++++++++++----
>  doc/usage/cmd/armffa.rst | 11 +++++++
>  2 files changed, 90 insertions(+), 7 deletions(-)

> diff --git a/doc/arch/arm64.ffa.rst b/doc/arch/arm64.ffa.rst
> @@ -158,6 +164,71 @@ they want to use (32-bit vs 64-bit). Selecting the protocol means using
> +At runtime, the driver model is no longer available. Runtime users should
> +use the resident FF-A runtime transport, which verifies the runtime context
> +before issuing FF-A calls.

Please name the actual API the runtime user is expected to call (the
helpers from include/arm_ffa_runtime.h), otherwise the reader is told
to use the resident runtime transport without being pointed at the
entry points.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon

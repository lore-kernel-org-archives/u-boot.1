Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B316ECDB47F
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 08:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E77A0847C8;
	Thu, 25 Jun 2026 10:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kZRqSG/B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 909E484894; Thu, 25 Jun 2026 10:03:45 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92AE684704
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:03:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bed19623d6eso321711366b.1
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 01:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782374623; cv=none;
 d=google.com; s=arc-20260327;
 b=n/5KSqundhPP+BS3NhmO1574JbkwqQrlqdzx+NpPH72A054By487tNdvy5RPv4o4b9
 HIUjdFj7PEk3I0Pj1o6xSpXdLV/tcPTcwOtN6BnXQWKJgG2SZyPnxIKirF57NDCPAGqu
 ICiClU0rgYH8Ww83f+Q7YYCEbjCWmfE5bGRqTnUldrMV1pjQPiE+x71wHxOYBNahWQwx
 vVhH9rQ05kkvPWfF0CHZCaegDSVfzx1JD6MFB2LV7z6azWGETktGeUZbwvrWetRYKQr4
 JaKAgtOlvFKaf9z2SnJzGlt5UP01ks/S/89EXkpF4pK8IJXrtyXaENDDXpj2ji3Ms6Kc
 SH6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gL4kp8GzfPu+ONpjUOu1YQNXNN1Yu6RUcQToNBQ1qqE=;
 fh=LI8+INkLzzoRu4ENIv4WWgUUefmR4YBUllTyPBoZuOk=;
 b=XHcYDeVIkvdwHK4EraXGq2kJ8+g5M79b51U9/mBpkgvchHkJhQhJpuD6QjAXGLfkoh
 ZXgP4ithyjAfYw3fuw0nEhCP3IIYfCC56uPUautspEg5GwUKRCAsPnlR90WzQ2/sZrIk
 OYSXGFOZ6yZvZryQo2X7XqG/S7+N3C+ZFDvn1HAxLfqRurA9feg/yy0JJxjSLw9lH8Fs
 KCwBbW8TwtHJf+Jfx+DvAy751GUaX4iuEb4odjwB8OJnvK7F6DMfnVrOjeimzdQVm0Ub
 CFu7HeRjbeaUqn7bLvhtUPjvdDNXp/HEzvLOtVPXQ9y6KkoGeuDzVzz67vCXV2jaGUIM
 xc7g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782374623; x=1782979423; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gL4kp8GzfPu+ONpjUOu1YQNXNN1Yu6RUcQToNBQ1qqE=;
 b=kZRqSG/BPqQDsDgZMoZkM3MQ7nBDdlBcFxT/IyVDJssV6yPfUh2vod1JRmEAQ/bIvD
 UE1PYRBaKUsDSbRiFwiPTlzNxqxTiL7lyLgcvSp70eTtdMIx8GoPlpKJsIAJ7t16s9rl
 qDGJugLtm9erTrGms/EKrf2951Tj/2zBEfgVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782374623; x=1782979423;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gL4kp8GzfPu+ONpjUOu1YQNXNN1Yu6RUcQToNBQ1qqE=;
 b=BFGUZmBQNbhwlfifgt4/jjQ2rTyVrLzcgzU9L9OwhDzLbRU2fmm3D506P0SnIJlwsH
 9Qu0xXKfUeIrsbNTB9De/3XX3HsHubcSObFeWQqK61s7pgjdugIqfUAchVzNgn7CuRU0
 Wk6a4nUcnB5lakNxQ27C+CWmV29r23PLJDJc51T4NDP894ABnObLace5SlLo8GuZnt4V
 xvDWl2w0lUbIPo4tz9mU7ILwhUgQc8R0qI6rDFKi3ZF+0nQoC3Jrq75o+ArD7M8Vkymp
 GGYto+gSbHwuNsJ5QobabpKlfrkg3WB8maFdyS1TVzreu7achbzJQHD+yLwMcFVJAFv7
 npDA==
X-Gm-Message-State: AOJu0YzHoocKL4AugOus1xBke1uenvXNzxYrFm3xzFMn7PT9QUxNpYds
 AQURjGzCrKFD6/IYjt3beq14+u7vzTdgRVHT8qkrHJa0OcPNqZhiirZenC5CeIWqP+ACADK62Mt
 o3vA+x7tBE8+RkEujwDGyKN8fZNEjSX1aAR1/n2jr
X-Gm-Gg: AfdE7cmR11wpuDQJlbhi20gyWSMpSE/hE1X3DL9+EEKPYHW9Gjs+f/H2oXt994X8onh
 YwlCj8ImmyxG56YdtX1T5PnpWh18n3ZddB1o1y6P0omQHJlLMDQ0TW1GV2QpMgZ6f5jpOPAw3h8
 NQ+pOa+J2Ger4qZGvYqn2dV9A0UqrhFrU7KC49LOYOPEXrr8naqXsahtODfiBFOh/FuzzoGbGDw
 QoixKv9tngPt74S5t5D59w1mXPxltVEfL+tl1TPuQ4r2gbOCyrbOfuVowx5oLKW7LhoYonQNA==
X-Received: by 2002:a17:907:1c93:b0:c08:3409:b747 with SMTP id
 a640c23a62f3a-c1205e9e280mr86255266b.33.1782374622801; Thu, 25 Jun 2026
 01:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260619144554.5963-1-aristo.chen@canonical.com>
In-Reply-To: <20260619144554.5963-1-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 09:03:31 +0100
X-Gm-Features: AVVi8Cdz4SKFDeNdSvjwxRwW3DfU8iCIe_K2lsaCRPd23rUTf6k4NQ-EQ6JJP14
Message-ID: <CAFLszTjNDjTGw_GjsF6CntUa1x8S7oFxnfvd3JscQo_H-QFmMg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] bootm: move OS index bound check into the legacy
 path
To: aristo.chen@canonical.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Ludwig Nussel <ludwig.nussel@siemens.com>, Daniel Golle <daniel@makrotopia.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>
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

On 2026-06-19T14:45:51, Aristo Chen <aristo.chen@canonical.com> wrote:
> bootm: move OS index bound check into the legacy path
>
> Commit 103b1e7ce8cc ("bootm: bound-check OS index in
> bootm_os_get_boot_func()") added a range check to the shared accessor so
> an out-of-range OS id can no longer drive an out-of-bounds read of
> boot_os[]. That accessor is reached by every image format, but only a
> legacy uImage can deliver an unchecked value. bootm_find_os() takes the
> raw 8-bit ih_os byte straight from image_get_os() for legacy images,
> whereas the FIT path reaches the accessor only after fit_image_load()
> has rejected any image whose os is not one of the supported types, and
> the Android path hardcodes IH_OS_LINUX. The check can therefore never
> fail for FIT, where it only adds confusion and code.
>
> Move the test to the legacy branch of bootm_find_os(), rejecting an
> out-of-range OS where the untrusted byte enters. This keeps the FIT path
> clear and lets the check be compiled out when CONFIG_LEGACY_IMAGE_FORMAT
> is disabled. A valid OS id that has no handler is still reported by the
> existing NULL return path in bootm_run_states().
>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> boot/bootm.c    | 4 ++++
>  boot/bootm_os.c | 2 --
>  2 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

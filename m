Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C82CE8E8A
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 15:57:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A62E88DFE;
	Thu, 24 Oct 2024 17:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KZlyXUw+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1060488E17; Thu, 24 Oct 2024 17:57:03 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 904EC88D61
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 17:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2e3fca72a41so871761a91.1
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 08:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729785417; x=1730390217; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g84UnqT1P3kJdjsssFQ4CR0HiK1MYyoZzc2/45VrJ1g=;
 b=KZlyXUw+UaeHqjJVvzeMnlj10jC6EXCAJQ1nLfCZEoBfsPm2P1tWI7M2ZrQV2MdcHR
 cx4zsN6v7bUx9gMxaUkCVSfex+RWwkAI0HuTh5Ruyk6i5pYYb8ShCtGE5nGaS2hCog3b
 yyxMTvr0BA28spFcphr2qD6hd87EStVTJyu0CDfn3bHS84tq3SoWn1h/CTyiivusO9pi
 lto14e2ErDyog23apxB4JB6cEx1IViq2Z7K2mM9PndGOngW1EIuNT0iZTmsRtMdMpnkR
 6j+GrEAb/oKjG3upmcj3ZVxFDtbk3mC5pBh0x34iKYmAfPzQT47BP/BMp/iX8nvDhFYr
 tMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729785417; x=1730390217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g84UnqT1P3kJdjsssFQ4CR0HiK1MYyoZzc2/45VrJ1g=;
 b=SkXbL+Uw5IVZ3CgOGPM/PPEbp3E5O6H/BeJ6ZtV5TnFdmu5b1XYQ0sbU441ReDj9o0
 fJnYSLcC0wWkjudeTnMxQKNBjM3kepc8MqDLwg8UAUQnS3IOmsLt2PGTnTbRGT7GwuSR
 UYCkT+Gq8NllH/lujlo8OviFHs6xfzDVhpnNUB4LSRoG/ysgTfzLn9by/LQ8VNCfsmsM
 kFK4zTi6LAluBiW54EzDJKW6xrC5ABomvT8EMLtemEY57Uthakx4cNhQjZ9trIwoEVd7
 U/FVREBKjDDJo2j0a8G1qgnFVAxkaJJ+LmjPEWmgWabRMogyT/qFdjt3Pnl2dImJWYxV
 Y6cQ==
X-Gm-Message-State: AOJu0YxLMBPQwuqQzSMTpHsqfri0D0IEnt7IMq7QmAzfYb2kLNOmN6/P
 yvJKRphTg29lyj7ybOIK7PMtUne+I9VyRBBm1TZJfdwzsWRZBsiSRL1ljPA52SDZ6N701ac3kyh
 an5a01YGkUQhCYyO5r6Llr6IJRVApJMfVVl1ssA==
X-Google-Smtp-Source: AGHT+IGC6NI6GA4nJXzCZT20FtMOn5CYYlZS/XmVaRSvjvCJjwmh3K4l2yQfezG1euYLNtUXapE5iJKXh8bdyLwk4g8=
X-Received: by 2002:a17:90b:4b04:b0:2e5:632e:68ee with SMTP id
 98e67ed59e1d1-2e76b60e495mr3661814a91.19.1729785416736; Thu, 24 Oct 2024
 08:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20241018145157.3918429-1-sjg@chromium.org>
 <20241018145157.3918429-3-sjg@chromium.org>
In-Reply-To: <20241018145157.3918429-3-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 24 Oct 2024 18:56:20 +0300
Message-ID: <CAC_iWj+JHyqk_KGzOw9HtLYqv-+py2PznVs5doGqd_wt10Zkxw@mail.gmail.com>
Subject: Re: [PATCH 2/6] efi: Make efi_run_image() static
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>
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

Hi Simon,

Please mark the patches as efi_loader. I didn't notice this one up to now

On Fri, 18 Oct 2024 at 17:52, Simon Glass <sjg@chromium.org> wrote:
>
> This function is not called from outside this file and has no entry in
> the header file, so mark it static.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  lib/efi_loader/efi_bootbin.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index a0ab677ee1a..eb9b9c4afe0 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -141,7 +141,7 @@ void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
>   * @source_size:       size of the UEFI image
>   * Return:             status code
>   */
> -efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
> +static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
>  {
>         efi_handle_t mem_handle = NULL, handle;
>         struct efi_device_path *file_path = NULL;
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

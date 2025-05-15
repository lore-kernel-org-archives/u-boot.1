Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6558EC2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 19:27:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B4F782C87;
	Thu, 15 May 2025 21:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D+5wutRl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2B6382C84; Thu, 15 May 2025 21:27:20 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB22A82C67
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 21:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5fd32c133ccso2075900a12.0
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 12:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1747337238; x=1747942038; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7EZ5oZm0wN7SaJbrrdwSS7MeKAS1XhA1r7w0yKmU34Q=;
 b=D+5wutRlDSLLOqMmOyoqh2/HYTM9QzK2nhWgcRfB+HKWv9B853IirGK5MVTJwmfQqw
 7VYFigac133gf3Z2YRmcSFk2uNE3Bc9imD0RiodHP9LNtUicjCiBCIuX/bO4QJGH7B9m
 uzlQ2PolrurNZvMr5dvhxlaTVJOXqTyuZ2qmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747337238; x=1747942038;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7EZ5oZm0wN7SaJbrrdwSS7MeKAS1XhA1r7w0yKmU34Q=;
 b=Szjhcwv7ggutwU+eh0etVeJeFkpEWLakjp7Ij92SG6ylzAziWQTzPkyVYxLNxs0gYy
 eYW9N58m+nmS6GaaedJskuvfv0M0Yf7FsjRtvRIkeo78iH3Ky6frwSxkirFnh7e7mAw9
 CrgJshJcT9kDXUatY/fBnnHVSVg56iEhc8UEUq1b4sf1JxFaHJSOWY0sz0ezM7SrC+Z5
 zfs5UgDTUGJBNYnZIKFOutzVua0vc220JursMq9zP1OOLcl8BAOidnVB+CPhBDNdL+Tt
 OQq+jls54RxABDPgFO9bVrnLmdgvUcVDHX4IctgqNSMXuVjV64SYSHVIHyblcRvdnvR5
 NE0g==
X-Gm-Message-State: AOJu0YxCuymLDn1KNAXtEnU6b4xtStS4qjYd+rgxMGJQ2kB9U4XKYfiB
 W4Hcy7f3eq3BdPV7oZ4se4RMeewgvI7MCMNLD9eBl8X3sUZ3m3U8dk6Ecip6yM4gL01dXIEMjZR
 OX5CpEK9sX1s+CW9PTiV+PXcj46Q+8y1ZIc7a0A4y
X-Gm-Gg: ASbGncsG7Wb/zQUAKY9Lt86p2q4lVzzmu2fqQudMDakUNNjSFtmoG2TKWFouoQRn5yD
 hkaYoTVptHe3sIVGLyQn2ddTbgM8fjLm5bOpdOZOJxpxNzdzWeS7wp09ujEb8HIhvlVWphmCc3Z
 +OI7HFW1zSwrKXg5xkJBJhS5dubr4b5yTd9w==
X-Google-Smtp-Source: AGHT+IEGXWCSYAD48C47rDGdAuRoer2lPlZiPeEZfGrnvmc7NMbNG7K+Z4dy9jYge97Sm+w2G06FQExPFexrbY61ZJQ=
X-Received: by 2002:a05:6402:13cf:b0:5ec:9e6e:c48f with SMTP id
 4fb4d7f45d1cf-60090156a2emr475912a12.29.1747337238218; Thu, 15 May 2025
 12:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250512161033.146396-1-marek.vasut@mailbox.org>
In-Reply-To: <20250512161033.146396-1-marek.vasut@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 May 2025 21:27:06 +0200
X-Gm-Features: AX0GCFsLzT6LibdksWKwfEgAgXGk2EX8lWtEQcqV5mFf_byPeyXdWPIgixINZxg
Message-ID: <CAFLszTjuAXS_3oBaX5EM4SOtt6Xr+UO5r-CEqZ76sFf4gG9tsw@mail.gmail.com>
Subject: Re: [PATCH] ARM: Align image end to 8 bytes to fit DT alignment
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sam Edwards <cfsworks@gmail.com>, Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Mon, 12 May 2025 at 18:11, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> Align U-Boot image end to 8 bytes to make sure DT alignment requirement
> is fulfilled. This fixes a possible failure in fdt_find_separate() in
> case the U-Boot image is aligned to 4 Bytes and DT is appended at the
> end at already 8 Byte aligned offset.
>
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Sam Edwards <cfsworks@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  arch/arm/cpu/u-boot.lds | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> index 817e7a983ae..b2109e03ce3 100644
> --- a/arch/arm/cpu/u-boot.lds
> +++ b/arch/arm/cpu/u-boot.lds
> @@ -153,14 +153,14 @@ SECTIONS
>                 __efi_runtime_rel_stop = .;
>         }
>
> -       . = ALIGN(4);
> +       . = ALIGN(8);
>         __image_copy_end = .;
>
>         /*
>          * if CONFIG_USE_ARCH_MEMSET is not selected __bss_end - __bss_start
>          * needs to be a multiple of 4 and we overlay .bss with .rel.dyn
>          */
> -       .rel.dyn ALIGN(4) : {
> +       .rel.dyn ALIGN(8) : {
>                 __rel_dyn_start = .;
>                 *(.rel*)
>                 __rel_dyn_end = .;
> --
> 2.47.2
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Does the same need apply to SPL?

Regards,
Simon

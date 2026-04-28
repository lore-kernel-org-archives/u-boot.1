Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1792EFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 18:09:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D2608467E;
	Tue, 28 Apr 2026 20:09:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J360DbE/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 023A584669; Tue, 28 Apr 2026 20:09:19 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB95984693
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:09:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6764e36dc88so149950a12.1
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:09:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777399752; cv=none;
 d=google.com; s=arc-20240605;
 b=abHL6Zyusb9f4zNTrKFbxV2ccuXbe6JQoPxlkY5i8hHyZ3WPHit925SwWytLprpe49
 AKt7CyD6db0XzpSivkuzjsZbwIZAdSqEnRkneOeVi/TIwlcvsdOaEa5z1XGtqryL6PML
 N2LnOcSLm3LhXYgyEBXY98yRAunnW5tyw6ENZK6+6T0AsqFEuxfCYSk6ajaNcU3ImwnK
 JIAiiek2TusN4UkMeclcye/3Pm6k0gMRBhK/bMRohCzRnjPTxbyw3BQA2aJM76IGgJSL
 saCFb3VVkZySwOOwU4MpigrMvEG/WXwhLw//CMukboRZxM7xLkUB/Nrf+p948wA5BYny
 EHQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KdJLbWJlY4gmdRZ/MXFVdLRZBibe6kC81WYF8dlWuAk=;
 fh=GYIekQEhESPWanXHuipF/cx0w9AeOdHDaa7vPtUoRvA=;
 b=Ev04WfujL5wwe/TNXEn0H5GIAYpbRGMCkkqn+jP9JBVSuBsn3zGPFTE4VE+e4tl9pj
 hD1zqfcHb/x5mxaf1uUEpPJ5EoPoNQV5iSmggn3HzlowBNT0TcRTwDlT/C13BXH36cf7
 92UPeAVPL+YQR3sSN7q7Hj0oD3wbBgOeO2NzJ/CkUURYa+aOkHgbvakBbFFbLb57FiVO
 xGhExzLPJVEYtsMbsuo6L1NIvtzsyvBZBbI3cDguJSmGl0qYKJ1F8gCHY3VTRFlX9X0K
 +z5YrDzN4mtobf1V82QCv19Hi1B+y37YfjkY9ODAHuZeuNmIISAN2r6niw5QfnH52Xlq
 3vWw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777399752; x=1778004552; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KdJLbWJlY4gmdRZ/MXFVdLRZBibe6kC81WYF8dlWuAk=;
 b=J360DbE/vsecUWf6UUw4KvKOKNmu81bFkuO1A9kXVsLmI9kYNo4X35UKpA0AcQ2H/I
 i3c2/XUAkmy7fls9lyX5jfWnm4bwUWVwW/Kw3wYsOlxGokmFJk5lUqLdJIY3toAf+39o
 uKn0gWRqoEGnBRu3/d3yK4UhinlNrJMEQLLS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777399752; x=1778004552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KdJLbWJlY4gmdRZ/MXFVdLRZBibe6kC81WYF8dlWuAk=;
 b=pdSL+fzXJJ1J451nkKl1HX46fammgBIOMlnkXzc0R7pT6Md5dfRU2YrfdJx2lpYco8
 u7Ui0s2VaQklvHXZp2WQfrpR+VexxkCS7gL1kE6MgxxVGIzrSyTdEyqRfR9bret5qNz2
 RJi4n3ehpq5ZNd1Wo0+cNdUe3w2c7rJfPx66L/FWXzjh3yvQYg9ZtDPFPVPmIOryMFk2
 H5LqIX4otg4L9KGBt7ZUuGQHzNWNlWNOdOguJhiaYkmnD9uP1wfcAWedSfUua+1+zUTK
 4MbdBu8E9fibqcDlSwPjPQyn6L7CxCUFvTq1dxBl7aQtT3odMcXgqY5y5amMv9ljY72N
 AdOQ==
X-Gm-Message-State: AOJu0Yz5i1i7BuQ3uQxQeEsPNV7lw9wjY08sutWGrgo4tXfroFkMPLkZ
 oo7rtyUy24WGM4dtrrcKUE/LrE77NqH68YVeFfdO674c27ALS9ICUpSmeus2D17oVjHbTaOi8JO
 IHDD6pwklA+czmu/HEvIUNE/vurnKlEtZnf54ooQdsAjVCLhNpnU=
X-Gm-Gg: AeBDieuM9z3OoUh8xQKoziz+b73ngqhFJMvDHMq49VNurqfp6bOKvm6qqS4yoonki2S
 jb+5o/zT+6hgbkWcn4dsmcE7uy690ULArM/DHWYuWq29droxFJ3hsqtpfr2c8tRNwN5TuYa7B7U
 EDTh5onzdYzWsyXQmzmRwvwQGLXv3mJod/BpdB5CZMy8isQHOawHWVto0njEGQ7oVOHos4O5RX4
 YEkSH7UVR8F0RZdknFIq5S2QHxrsbGHAR3rAz3kI40NqLlU6uuT/2xYKt7xc2A8jBtQWIveqRlp
 NQ5GlkmHBjuFLV61
X-Received: by 2002:a17:906:9fc4:b0:b9d:14e9:d06d with SMTP id
 a640c23a62f3a-bb951349e86mr4596166b.8.1777399751847; Tue, 28 Apr 2026
 11:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-2-harsimransingh.tungal@arm.com>
In-Reply-To: <20260424173151.371134-2-harsimransingh.tungal@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 12:08:59 -0600
X-Gm-Features: AVHnY4JxFXL0nPgFa_313x58T9nX2YX3cMAwxQMcLSpTYJXbnJaFHtuAElYp6wI
Message-ID: <CAFLszTgfKTVFxj6Z93dbecjHeY=oAGoGtUmBhYiC8EtrOzVsdg@mail.gmail.com>
Subject: Re: [PATCH 01/12] efi_loader: add runtime memset helper
To: harsimransingh.tungal@arm.com
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>, 
 Simon Glass <sjg@chromium.org>
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

On 2026-04-24T17:31:50, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
> efi_loader: add runtime memset helper
>
> Add efi_memset_runtime() for EFI runtime paths
>
> This keeps buffer initialization in runtime-resident code after
> ExitBootServices() and avoids relying on non-runtime helpers.
>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
>
> include/efi_loader.h         |  3 +++
>  lib/efi_loader/efi_runtime.c | 21 +++++++++++++++++++++
>  2 files changed, 24 insertions(+)

> diff --git a/include/efi_loader.h b/include/efi_loader.h
> @@ -1151,6 +1151,9 @@ void efi_memcpy_runtime(void *dest, const void *src, size_t n);
>  /* runtime implementation of memcmp() */
>  int efi_memcmp_runtime(const void *s1, const void *s2, size_t n);
>
> +/* runtime implementation of memset */
> +__efi_runtime void *efi_memset_runtime(void *dest, int c, size_t n);
> +

Two inconsistencies with the neighbouring declarations: the comment
should say memset() to match memcpy() / memcmp() above, and the
section attribute does not belong in the prototype, as
efi_memcpy_runtime() and efi_memcmp_runtime() carry __efi_runtime only
on the definition. Please drop it from the header.

> diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> @@ -233,6 +233,27 @@ int __efi_runtime efi_memcmp_runtime(const void *s1, const void *s2, size_t n)
> +/**
> + * efi_memset_runtime() - fill a memory region with a byte value
> + *
> + * At runtime memset() is not available.
> + *
> + * @dest:   pointer to the block of memory to fill.
> + * @c:      value to be set. The value is passed as an int, but the
> + *          function fills the block of memory using the u8 conversion of this value.
> + * @n:      number of bytes to be set to the value.
> + * Return:  dest is returned
> + */
> +__efi_runtime void *efi_memset_runtime(void *dest, int c, size_t n)

Please match the kernel-doc style of the two helpers above: tabs after
the ':' in the parameter list, no trailing periods, one-line @c
description. The @c line is also over 80 columns. Flip the attribute
to 'void * __efi_runtime efi_memset_runtime(...)' to match
efi_memcpy_runtime() / efi_memcmp_runtime() in this same file.

> diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> @@ -233,6 +233,27 @@ int __efi_runtime efi_memcmp_runtime(const void *s1, const void *s2, size_t n)
> +__efi_runtime void *efi_memset_runtime(void *dest, int c, size_t n)
> +{
> +     u8 *d = dest;
> +
> +     for (; n; --n)
> +             *d++ = c;
> +
> +     return dest;
> +}

Just to check, was there a reason not to mask 'c' to a byte (i.e.
'*d++ = (u8)c') as the doc comment promises? An explicit cast matches
the comment and silences future -Wconversion noise.

Regards,
Simon

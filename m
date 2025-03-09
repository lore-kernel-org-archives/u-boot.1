Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71590C28B28
	for <u-boot@archiver.kernel.org>; Sun,  9 Mar 2025 08:52:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0A99801DE;
	Sun,  9 Mar 2025 09:52:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ynbji00d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1682180FDE; Sun,  9 Mar 2025 09:52:07 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8C5380107
 for <u-boot@lists.denx.de>; Sun,  9 Mar 2025 09:52:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e60ad903382so2037936276.0
 for <u-boot@lists.denx.de>; Sun, 09 Mar 2025 00:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741510324; x=1742115124; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yaunk4WH3KUFo+XRWFjigBPWuqD2YjdIN+f+44OzXoE=;
 b=Ynbji00dM999/7R39ZVPh16nZ6YHZAAogx8VL1JvG593KjeLduvkJLBGcsXK5jxG09
 Qw1z2Dz51RMNxYcmuA4CnxCSuuFgHy2KVliACHukg+wTMZHZaBaS92YS4beiIarAd0IO
 NASoN+0SEKk/vy8dQMeyWtqKpifYhS1gvliGrvWCRADksa82psBVZfOU6v+EpuAHWsTJ
 I95f6lfThIOYyctNQy9KfDBOxc3VY2hzyL9ivuiHLtsiwJeYymmoRLNYmVxVdxTpsOpc
 BmS4TyvrztbtVQgZ14yfYqSGuW3+im3QEZI1AbBYTUy1wbPM2UqTy42NUDevvshbaSx+
 Yu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741510324; x=1742115124;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yaunk4WH3KUFo+XRWFjigBPWuqD2YjdIN+f+44OzXoE=;
 b=LxyHMzJy95tnk72zhKOqt0+S4fwPebxfat9F/wAbvoP5nXRmV1MlSIDE1zWF3/BaF4
 Iu1+YCZlchWdF/PYs3QmuW9VhMPSRrR+iYwn/7N0vd8kDFgaBTf/dG5O3zJ9JEFTdHJr
 8KLxHOfSxRJQtINvCRy97ETalNRueeE0JH+OFOZ6ZkRBUJnTeOM78a3oGVmwxcaVmXVw
 rvb+gtQQT7H9o+MgQAuHZbTqgvcM7eo3ntzi/Vb48rQ2vmjdXQluJu/j3GSQJSdwLWaG
 AeuZFA5xvWK8wCWNzHGpe9arq7PIcDOoJM5+MYh7voTfQ20WwQNScoZXLJPxRXcxiMFB
 cv2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI4kvPRo3if893AFM31FSRAHgXEoaROkbGT3cAK+dbd1TZTnhrB7paW16CEF2K62hzBdieCdg=@lists.denx.de
X-Gm-Message-State: AOJu0YwQqCVtJQrasrnid5x9bZYf2EbQWS5x5RdCUW9uTFver9Ppe8j3
 5fmIzYV8FX/hBY5HBXacJg1QLJ6O3sgSmD3ysqbjOviLkEMwhjj+sVYOdYbpD1dh9zt/KXkw+SX
 uPnjJ4k5uUmTSx0fUZLeCwY/3ThliuiNSeQztAg==
X-Gm-Gg: ASbGncvsqKdcGlsnUvuZqVpzaO5c2FgkuxyLMFDX0wCc5/eIVAcr860V86uCC4E0bR5
 Ou8rFNd5qRNnkqy1nWfzyhgzw1SHQkkClnUNIOB7in34a60SRMsUizcFnTk5Q+Ym2THBEw4KY2M
 XP/So0Z0OfLU+CdbLgKwkZtYTKEPo=
X-Google-Smtp-Source: AGHT+IE2lh/LVn/HIviv1vAM7jAv/5r0UOZPiSGljmprRgvgJodVJbH/ZkDPUC4udxcOOmex1wdluZQaEd48teB38vw=
X-Received: by 2002:a05:6902:1693:b0:e5d:ad43:9b36 with SMTP id
 3f1490d57ef6-e635c18118bmr14046015276.20.1741510323788; Sun, 09 Mar 2025
 00:52:03 -0800 (PST)
MIME-Version: 1.0
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <20250224055524.1334929-5-CFSworks@gmail.com>
In-Reply-To: <20250224055524.1334929-5-CFSworks@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 9 Mar 2025 10:51:28 +0200
X-Gm-Features: AQ5f1JobZuumMc0wa8rz9ivTjTqehiJiWmzzodKqweHusSTQBwog8fs3MCjoH0E
Message-ID: <CAC_iWjJP3M_kSBZctoDL5FwRfkmYM=RaAdkN+NAoruNiRu_BGw@mail.gmail.com>
Subject: Re: [PATCH 04/17] arm: Add aligned-memory aliases to eabi_compat
To: Sam Edwards <cfsworks@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de
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

On Mon, 24 Feb 2025 at 07:56, Sam Edwards <cfsworks@gmail.com> wrote:
>
> These are sometimes used by LLVM's code-generator, when it can guarantee that
> the memory buffer being passed is aligned on a (4- or 8-byte) boundary. They
> can safely be aliased to the unaligned versions.
>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  arch/arm/lib/eabi_compat.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/lib/eabi_compat.c b/arch/arm/lib/eabi_compat.c
> index e4190c049a3..e6cafcc5f2b 100644
> --- a/arch/arm/lib/eabi_compat.c
> +++ b/arch/arm/lib/eabi_compat.c
> @@ -33,12 +33,24 @@ void __aeabi_memcpy(void *dest, const void *src, size_t n)
>         (void) memcpy(dest, src, n);
>  }
>
> +void __aeabi_memcpy4(void *dest, const void *src, size_t n) __alias(__aeabi_memcpy);
> +
> +void __aeabi_memcpy8(void *dest, const void *src, size_t n) __alias(__aeabi_memcpy);
> +
>  void __aeabi_memset(void *dest, size_t n, int c)
>  {
>         (void) memset(dest, c, n);
>  }
>
> +void __aeabi_memset4(void *dest, size_t n, int c) __alias(__aeabi_memset);
> +
> +void __aeabi_memset8(void *dest, size_t n, int c) __alias(__aeabi_memset);
> +
>  void __aeabi_memclr(void *dest, size_t n)
>  {
>         (void) memset(dest, 0, n);
>  }
> +
> +void __aeabi_memclr4(void *dest, size_t n) __alias(__aeabi_memclr);
> +
> +void __aeabi_memclr8(void *dest, size_t n) __alias(__aeabi_memclr);
> --
> 2.45.2
>


Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

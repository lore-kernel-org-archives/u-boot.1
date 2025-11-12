Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FFECCFA1A
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 12:24:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F86883BDD;
	Wed, 12 Nov 2025 13:24:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vXe5Ut0S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D90E83C08; Wed, 12 Nov 2025 13:24:32 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7226A83B1A
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 13:24:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-78817f3af10so3872617b3.2
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 04:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762950269; x=1763555069; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3guYru47Czic8KFRBAlkR2Fs9Xyirv0IfAi9DILYg9A=;
 b=vXe5Ut0SFg4RxrEwdOpzDW4M1CTWMpZpywPasxtZfPC0wlI8KpX+QYmeZGqZukLqaH
 HfwXxBAeWamF5CxSWX0PLTyF4xXBFS8SviaEhZ/+baxAu1FRnTV6bxrSjbHg00mnYL4t
 rbIu0McnCoq5OBCexFjIdUIg91ddcX31e2FUVhzTeYzMxsVqR0BavnP4pocy14BZvxu1
 9zK7lippBSXtE1q4inV/a86uTAtU/lIPenKJujCrsTnUBq5dlFb56Dih3Reo9UEVLwk4
 wa0AbnRvA39jF7DSHVdR3z4rfSeAYAnxgaYTxC+ruPJZJHoHaE/0o/NE/O3j+acuepY2
 Pe9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762950269; x=1763555069;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3guYru47Czic8KFRBAlkR2Fs9Xyirv0IfAi9DILYg9A=;
 b=Ys+j+lBPnv+kga4xUR5F0ePCuec5HttR+XnA9+wt0YpBfZs/9TCmFtB0o7XUFdkE6k
 xVjWlA5OGF25y4QroHewUdm0yQPH/zdjhA9RkitlKci2AjzBySXI/WG4TOGsOi8+nfVo
 NHhBaukcWvuFCRhWRerVFgkmv2YKVYHDoziOjUn8rwW0WThn+p8ZV2jbKYtffH+tj/Ak
 MNgpf83Z/aODyUufzckMPRXykFPIqYejb94jlSOHnPy7afwm4FsrpiIzwQcJjdTYrK7U
 kLXwqDgCnDoIy9rN79pWitJmrFVjWabYgDiv+2SZ1GUOQiX7dgTpPa7MA9xkBuwg32Io
 bfdg==
X-Gm-Message-State: AOJu0YwzBD+UFxlxhLPkL7JPYaGC4qMymDcUgXnS9Rzw2wIgVddh3FeV
 /M37Od+JE2sTngFoMqc2+Xld4A8uRv0+PKRd3pobPG/GZNPTAo++fsti2s6euDKTdbA+60YTh2j
 F56Wlf9HQOo8X5Ixsmz/nCJ6M884GBfvkfRW1qakW2cdFe/uVT3EpgTU=
X-Gm-Gg: ASbGncsycncpHI9Jtv0x4PUSiZ3xYc9jHvoBgNcz1VjJA9BOHGiyoL+5fM/OKzjAkQE
 YepusWrAMovXq7fp83BIPAMJ/ygPwpYVYXRKhj2IzY0YDarU2Ep+bJu1XP4peRTXBnAFnJDYnAv
 sQz4nw3xbCZyw5VZ1+3oTOM4ydsMTKugczuUOZbov4yCsdsQLxKDQuCO64CEZ4BEAmqhwonTSLd
 gC7MzUzqlcbChICUMAHEF/75jj5XkPv/EYATRWr0dnXEBB0z90FJBbwy/L3wFInEMnnbaTp8jFO
 ylVuQM4pQQqXKZOxHEAXWo0xRZSwr/YgHZrYeFr+
X-Google-Smtp-Source: AGHT+IH3kEpVOsNPHYhdhbwTL1ViN43YBkh2/EPdkjXwEWvii4+1yTBTZsWXvUp2DrfVz7sPobRG0ELcjNi0mxNiQZY=
X-Received: by 2002:a05:690c:fd1:b0:786:91ac:e15d with SMTP id
 00721157ae682-78813627136mr22924867b3.27.1762950269141; Wed, 12 Nov 2025
 04:24:29 -0800 (PST)
MIME-Version: 1.0
References: <20251106232838.3243607-1-trini@konsulko.com>
In-Reply-To: <20251106232838.3243607-1-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 12 Nov 2025 14:23:53 +0200
X-Gm-Features: AWmQ_bl7-bqE9bz4pD_oNA-mvhjYK1McWjEaGGyMnzmlppx7qBGpBXOUP6LMngM
Message-ID: <CAC_iWjLZsDGtNE9POzdcG92DV1ABCFmss2H2f09kKhr40XVizw@mail.gmail.com>
Subject: Re: [PATCH] smbios: Fix warning when building with clang
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Raymond Mao <raymondmaoca@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Fri, 7 Nov 2025 at 01:28, Tom Rini <trini@konsulko.com> wrote:
>
> When building with clang, we see warnings such as:
> error: field max_size within 'struct smbios_type7' is less aligned than
> 'union cache_size_word' and is usually due to 'struct smbios_type7'
> being packed, which can lead to unaligned accesses
> [-Werror,-Wunaligned-access]
> when building drivers/sysinfo/smbios.c. Resolve this error by packing
> the unions as well after verifying they are complete (16 or 32 bits).
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Raymond Mao <raymondmaoca@gmail.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  include/smbios.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/smbios.h b/include/smbios.h
> index b5fed57aba21..f2f7483bce5a 100644
> --- a/include/smbios.h
> +++ b/include/smbios.h
> @@ -204,7 +204,7 @@ struct __packed smbios_type4 {
>         char eos[SMBIOS_STRUCT_EOS_BYTES];
>  };
>
> -union cache_config {
> +union __packed cache_config {
>         struct {
>                 u16 level:3;
>                 u16 bsocketed:1;
> @@ -217,7 +217,7 @@ union cache_config {
>         u16 data;
>  };
>
> -union cache_size_word {
> +union __packed cache_size_word {
>         struct {
>                 u16 size:15;
>                 u16 granu:1;
> @@ -225,7 +225,7 @@ union cache_size_word {
>         u16 data;
>  };
>
> -union cache_size_dword {
> +union __packed cache_size_dword {
>         struct {
>                 u32 size:31;
>                 u32 granu:1;
> @@ -233,7 +233,7 @@ union cache_size_dword {
>         u32 data;
>  };
>
> -union cache_sram_type {
> +union __packed cache_sram_type {
>         struct {
>                 u16 other:1;
>                 u16 unknown:1;
> --
> 2.43.0
>

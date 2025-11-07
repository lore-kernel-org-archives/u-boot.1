Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1ABCCFA13
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 00:51:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A63583BEB;
	Fri,  7 Nov 2025 01:51:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IppI4rEH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3A0983C08; Fri,  7 Nov 2025 01:51:56 +0100 (CET)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com
 [IPv6:2607:f8b0:4864:20::92e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB0983BDD
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 01:51:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-93516cbe2bbso69770241.2
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 16:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762476713; x=1763081513; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ng/Kmh7x/658zMJgwLpTVYZXXYpZnNCnmQgEMfOKOI4=;
 b=IppI4rEHDjbrTFYCCdOpiNngo8Hgct8tT4lqpCGIPHg4fMgle/4krnwjERbADley75
 2qSIdFyEzYIIJZ6FitQCE7DoQy4Gxb5yS1GgehjYbGMCo0xL0AYG1AVLLcFZXQ8gHL9T
 wNvaAh0GaFCeuColzE2+XIlynJKfF3jOtsXfcKacqUtnJd5L+Nk28n+8RM27LiAXiTAm
 n3qXlRCzcdGJP9KZjyt6W5knqWP/h1xH5aL8Hsq1TZLX2omtQ/I2vl5zn5rpf5b++kVg
 2+1kN880iJ3ZKKXhwdMgcHJfV4NQ7uaB6mkSts6MmGkCAd4k91dCdTWrhLFQ4V5eDxGk
 ipIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762476713; x=1763081513;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ng/Kmh7x/658zMJgwLpTVYZXXYpZnNCnmQgEMfOKOI4=;
 b=t+1pWu2IwOh8gi9OSQhWPriNVi7XWR7hUPHcaAyF9MxAd86E/78zKeesrHYhmBJpEm
 n7XM/U3Ic0g7VDV1gxOBckaW9yRM8bCwgP7h/Xx37wZBmbJl6ZlVnfWtps91cY1o63Nd
 hyAxoPjI5KI/GPCyf8kNGB2nMySrdONjeJea3PcNSVnAMepxB4yU7eq8yQAcs5g53wpq
 Us1eJcxQpyAlwJzG8vu3VlXUiV0VUoqXY6OZ9Z9e0iUb3+bzVbSw+AIFbP0UuKsaM5E8
 Fe5fQAQzmX1b67TRIIHA3JRpLb7nc561Vt3/6PPxfkL3hSKH1RLC6SMEfbUt2bET0YYO
 8HMg==
X-Gm-Message-State: AOJu0Yw3ofNESTOHTvzadGiJX0scTVyW75JjKPggT65LFYM3y5GWGXoO
 628GCE7FkxUGrR/9B3nXKTrgDkD+Zk5b+18a7Y1Ev0BrdT9NbPeJU6MaN9Vl5a8ZlnYEOxQuwsO
 MM1R+l0nBOrBFrdz027N526YjszNE3C0=
X-Gm-Gg: ASbGncup+kgsE6a1n9TUTLyb57PICfJvQAIoajj89AZlpnKYaAwf504pVg8XG/Ytao0
 KAFBmo9NrlzGu5Kepbs+9J1n0xi9BC5FeSOHFYAc7k/3Dv/dCcsP2CkcONyDhzEWLI2G9R9QVfw
 O8oxmgbIYsCzjU1CW80jlBqRjcmQnfD5r6+2Lauu9eEEze4gL4QdpCiKRTSpHDntfMAyj25z6M6
 4CIkcdxoSYe2cQG7/LdKYjFdL6q4zc4mxK/4xJ8wUARBqQBm5pr0ebtc7OL0XszrcCLoA==
X-Google-Smtp-Source: AGHT+IGZkmYvdBr5FicK15G/t7tGU3jCYK0hH7neVUBk+2PTRc2fNCeaixh2DWPK5yp2fzAi6eVDBFGTO1DJVdISozY=
X-Received: by 2002:a05:6102:418b:b0:5db:ca9e:b589 with SMTP id
 ada2fe7eead31-5ddb2290a99mr589173137.33.1762476713015; Thu, 06 Nov 2025
 16:51:53 -0800 (PST)
MIME-Version: 1.0
References: <20251106232838.3243607-1-trini@konsulko.com>
In-Reply-To: <20251106232838.3243607-1-trini@konsulko.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Thu, 6 Nov 2025 19:51:43 -0500
X-Gm-Features: AWmQ_bkiWkkDnYwMXY2uTzoWnQjdW1HOWC1jNDZrWWxTlU-h3miMkwh-sDlXkMk
Message-ID: <CAMDkj5wgRA=WQfWSfVw=qO6NiGGm2U6mi0mfd1WfsJLq2AMG3Q@mail.gmail.com>
Subject: Re: [PATCH] smbios: Fix warning when building with clang
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tom,

On Thu, Nov 6, 2025 at 6:28=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:

> When building with clang, we see warnings such as:
> error: field max_size within 'struct smbios_type7' is less aligned than
> 'union cache_size_word' and is usually due to 'struct smbios_type7'
> being packed, which can lead to unaligned accesses
> [-Werror,-Wunaligned-access]
> when building drivers/sysinfo/smbios.c. Resolve this error by packing
> the unions as well after verifying they are complete (16 or 32 bits).
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Raymond Mao <raymondmaoca@gmail.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  include/smbios.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Raymond


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
>

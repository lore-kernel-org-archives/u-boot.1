Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AFFE7716E
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 12:46:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C638A896BA;
	Wed,  4 Dec 2024 13:46:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hCtCOm4p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEFC9896E0; Wed,  4 Dec 2024 13:46:19 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDA38893DB
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 13:46:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6ef4b6719d1so62286307b3.2
 for <u-boot@lists.denx.de>; Wed, 04 Dec 2024 04:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733316376; x=1733921176; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r4B4q8T2cDruMm+I0NeW+AcTZ5wTdMFq9g7xTremQl0=;
 b=hCtCOm4p7/1uuuUUm/fbz5XbuBAni3lKQTfw1lt0V/UVjz6P6bYeA/diC9FGkoUvxq
 evwpFIWM6xhhh3YaJPF+BU3+I22k4bTZ16w/q2j3rNP2nPBhznEFfPauM8/hFUmVa/PI
 PewqZNKGC79FLS88EtG7dzmOG8fUm2IJy0btLlZuWVKLo03T2ftWWFrHLYwjHVAQT+T5
 +U+CMPdeXI+sYwK1CbYpJiM5JBZ+vUs9tmKjB+dIT2+oojuSsBwUoo9m1YsQF4NvWCmy
 gPS8I/FqZtX7YIVNScU5yd8ryyU1IPNF71ZI8IIYfA1nrjyTHTrAscJiuIgJCMiSYKaB
 mNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733316376; x=1733921176;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r4B4q8T2cDruMm+I0NeW+AcTZ5wTdMFq9g7xTremQl0=;
 b=tuG5Ww0HTkEO9G+2BQTWUsJcoWUeH+alUyKhvhjyH3M7/Ny1aNFhpdmp3UqqUI/qOR
 XkYavPrPhkswwegwuAcQJEVwSNU4hT7wAlWiZzCmscOjLyZSXZey6jFduxQU0sH1s7k1
 /6nnl4t8ekgmpmg/17J19VRXw4g66BaRhu8AHPj8uM0nw9zKrstO/XAgv29AOQy2upSC
 Us/LV1PIGjixBjhftIjfkUHdz63ZUP/zSndqrK1SciByvzLH2QXmtfCe6JOJnQ/KRqaW
 CSuQR8J/7JPSN5uVzdG3nsiySYYJgfZ/lcqc6Y0socA35uRvdRGec4qMNmD+YXAKIlUb
 WMFg==
X-Gm-Message-State: AOJu0Yz8udxbqPc0XRe6Z976t724o+DRGhSAF6Zt/W66SKme0bR4y2Y3
 kITj2WKwWeOQ8xOPCDM0sbreqsMRTIiW7y9i5gNAzTPevr+WD5OE+czILgPiNU6fXlt0AAwte9j
 I2nX7XF8t+2E83BjpmPreG0hriYMV4AzHLSuXUw==
X-Gm-Gg: ASbGncs14xo6AnM0bDQRJHLNVympJ3MVfTiXAqBP9/+TrAPqHoA/jnWD3VewVgKXrHn
 sFexu8kxjpUlBBg6C4GVO9WI1gZlM+gU=
X-Google-Smtp-Source: AGHT+IGni+Pa2/+cM99HGxU2KOUtHxYoVhpk1lW8x5CoZcRHOZ7Mnb446mn9GDOhpq/cHRtcn/ITPEzD4a+S4T/vZCg=
X-Received: by 2002:a05:690c:6f09:b0:6ef:5097:5daa with SMTP id
 00721157ae682-6efad2d9b49mr80779317b3.34.1733316376507; Wed, 04 Dec 2024
 04:46:16 -0800 (PST)
MIME-Version: 1.0
References: <20241203134257.5067-1-peng.fan@oss.nxp.com>
In-Reply-To: <20241203134257.5067-1-peng.fan@oss.nxp.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 4 Dec 2024 14:45:40 +0200
Message-ID: <CAC_iWj+VTTFxCY+XqoPsCduhrv+6v98Ls7z2OhCdRqcxiGA7Xg@mail.gmail.com>
Subject: Re: [PATCH] smbios: address build warning
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 3 Dec 2024 at 14:38, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> include display_options.h to address build warning:
> lib/smbios.c: In function =E2=80=98smbios_update_version=E2=80=99:
> lib/smbios.c:305:9: warning: implicit declaration of function =E2=80=98pr=
int_buffer=E2=80=99
> [-Wimplicit-function-declaration]
>          print_buffer((ulong)ptr, ptr, 1, old_len + 1, 0);
>          ^~~~~~~~~~~~
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  lib/smbios.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/smbios.c b/lib/smbios.c
> index a36d4b4e54a..defb6b42f45 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -7,6 +7,7 @@
>
>  #define LOG_CATEGORY   LOGC_BOARD
>
> +#include <display_options.h>
>  #include <dm.h>
>  #include <env.h>
>  #include <linux/stringify.h>
> --
> 2.35.3
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

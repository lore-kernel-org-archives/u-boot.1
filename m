Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4B6C5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 07:16:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50FED8070C;
	Tue, 10 Jun 2025 09:16:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J9J6MmOM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8142F80C83; Tue, 10 Jun 2025 09:16:00 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50C48805D7
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-70e1d8c2dc2so47441597b3.3
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 00:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749539757; x=1750144557; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fTbjVQ15DQQUT/8M8aZuYiOOYcXOjhOmaNFlstWEUgk=;
 b=J9J6MmOMkHkQen3lTooYygvBg4sUJAj40zobUfyaJ9aj/CE6lDeCGPJTOa4bqdM1sq
 MU+yDjiyWfS2wsFW/xrBR0JGiu1hlXEyLxHMLLEBQdhcjdXfKHA2st8Jr2ZSddo4fN3d
 KJ25T9cbi5WW94H1RlflTztpQnk2rj5Kj4KDuwNbm3YcQY6WKbj5MGXHbQVVO+JdD30x
 qyTqTNxUHv1F3jQLWakwoUr5Ey1MSNieev873TuMyE8Vvo05FSGyDNM6K4NPcgFmJA5e
 QWCKfsRvl88ZnEYRB73XeiOK0BEHy+1d3WHJBUHmvrlSUYrDiz+VOaOIVd5+FdHSIA5S
 1KGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749539757; x=1750144557;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fTbjVQ15DQQUT/8M8aZuYiOOYcXOjhOmaNFlstWEUgk=;
 b=PHh0n8SO84DJpJPTtINyThGO5wRlgBGDXOBQdSo87qKB3PIM9G9lpCovVgLswjT8Fi
 oJWS7t6cpvM2Y7So3hnM/YMcdXEok8FQ4kj8wbZbSh9PTryJnbTx8G77RgZOPwINXTPR
 T9Vr7L/XeOw9fawSgmYbRyDqQbL9DycK8vO4pg6ySTFowuvxCghjSD/qLXXejhFvBSIc
 3Uh10TniuDUuIjUMewpIQwYOTnrySRM+P2GQkqDZH3yH7XAarRNL6tIGZdgeJ7YSof/X
 FEqzeWl7hQW0gSl6Izf2gU0RrVpVdDQuv5pmrc1kX8QkCsmTqz7vccGiNo6B8+fDgFeC
 OORg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf+pRBHbYeN96egSKBksW7Pz2kmgAl7L/fQSEtv9VMgtofEDMHtbhEO4jsxUgy2aPD5vmLFug=@lists.denx.de
X-Gm-Message-State: AOJu0YyDiL4QUrS/89GjJVVdW3VuoPGC0oYJU7yQpgC2dixV1lzOJtcF
 vV/g8dCCenpHUOSVZ2rsaSzNU+IPmNdj0NaBeZIEZNv81sXq0Ai0TJCKdivalAQWdSOHNpxktle
 4Nj2Q9Ls7KKzAudIOglAPXmQcYLBWOzVbnJw5giS5qv8kQLPgRS5lkns=
X-Gm-Gg: ASbGncvk5aZNHxiEM6Gbp2Uj31qYNtG7PQ2LZCSkqfuc4Zpl1vTN3+8cHCimKHCvDmw
 3u/HwdIN5D0AhIwQOtd+eWNUf/or1jVA2qQPInlH+xCd/BPALv90N1qyxZ5grI2SvDRF68F/hEi
 d3qfrdJ0qC1wDzAPkQMNTC90elwYEX+aHnBWD2PNz+3l7U
X-Google-Smtp-Source: AGHT+IFIzRd+Lem9qCzRoQm/y0ceJWGRYveAeGgK6j7Br+pdU5fjH3ZZJCi88fQV2dCiZQY6+aYJ10EQt1Ql1aneu0U=
X-Received: by 2002:a05:690c:680a:b0:70d:f338:8333 with SMTP id
 00721157ae682-710f769c829mr224530497b3.22.1749539757188; Tue, 10 Jun 2025
 00:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250608075428.32631-1-heinrich.schuchardt@canonical.com>
 <20250608075428.32631-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250608075428.32631-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 10 Jun 2025 10:15:21 +0300
X-Gm-Features: AX0GCFtzHzWJLOTYEZ7DBJb03NnT5AdQMHmmWG37J6yQpRkbAHC4Zkd4zcRQCeY
Message-ID: <CAC_iWj+qg49bVZmWh4c6ZFMVv2cxzW9xFe1R=Og-o0kzzKTT8g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] sandbox: align LMB memory
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mario Six <mario.six@gdsys.cc>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Ying-Chun Liu <paul.liu@linaro.org>, u-boot@lists.denx.de
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

On Sun, 8 Jun 2025 at 10:54, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> To implement the EFI_SYSTEM_TABLE_POINTER we need 4 MiB aligned
> memory.
>
> On the sandbox LMB uses addresses relative to the start of a page aligned
> RAM buffer allocated with mmap(). This leads to a mismatch of alignment
> between EFI which uses pointers and LMB which uses phys_addr_t.
>
> Ensure that the RAM buffer used for LMB is 4 MiB aligned.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
> v2:
>         rename define CFG_SYS_SDRAM_ALIGN to SB_SDRAM_ALIGN
> ---
>  arch/sandbox/cpu/state.c         | 6 ++++--
>  arch/sandbox/include/asm/state.h | 1 +
>  include/configs/sandbox.h        | 2 ++
>  3 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/sandbox/cpu/state.c b/arch/sandbox/cpu/state.c
> index 49236db99c2..6a15c8b0a18 100644
> --- a/arch/sandbox/cpu/state.c
> +++ b/arch/sandbox/cpu/state.c
> @@ -480,7 +480,9 @@ int state_init(void)
>         state = &main_state;
>
>         state->ram_size = CFG_SYS_SDRAM_SIZE;
> -       state->ram_buf = os_malloc(state->ram_size);
> +       state->mmap_addr = os_malloc(state->ram_size + SB_SDRAM_ALIGN);
> +       state->ram_buf = (uint8_t *)ALIGN((uintptr_t)state->mmap_addr,
> +                                         SB_SDRAM_ALIGN);
>         if (!state->ram_buf) {
>                 printf("Out of memory\n");
>                 os_exit(1);
> @@ -533,7 +535,7 @@ int state_uninit(void)
>                 trace_set_enabled(0);
>
>         os_free(state->state_fdt);
> -       os_free(state->ram_buf);
> +       os_free(state->mmap_addr);
>         memset(state, '\0', sizeof(*state));
>
>         return 0;
> diff --git a/arch/sandbox/include/asm/state.h b/arch/sandbox/include/asm/state.h
> index dc21a623106..9dea0980bfc 100644
> --- a/arch/sandbox/include/asm/state.h
> +++ b/arch/sandbox/include/asm/state.h
> @@ -75,6 +75,7 @@ struct sandbox_state {
>         char **argv;                    /* Command line arguments */
>         const char *jumped_fname;       /* Jumped from previous U-Boot */
>         const char *prog_fname;         /* U-Boot executable filename */
> +       uint8_t *mmap_addr;             /* Memory allocated via mmap */
>         uint8_t *ram_buf;               /* Emulated RAM buffer */
>         unsigned long ram_size;         /* Size of RAM buffer */
>         const char *ram_buf_fname;      /* Filename to use for RAM buffer */
> diff --git a/include/configs/sandbox.h b/include/configs/sandbox.h
> index db2ac7f83bb..44d4960d487 100644
> --- a/include/configs/sandbox.h
> +++ b/include/configs/sandbox.h
> @@ -14,6 +14,8 @@
>  #define CFG_SYS_SDRAM_BASE             0
>  #define CFG_SYS_SDRAM_SIZE \
>                 (SB_TO_UL(CONFIG_SANDBOX_RAM_SIZE_MB) << 20)
> +/** define SB_SDRAM_ALIGN - Alignment of emulated RAM */
> +#define SB_SDRAM_ALIGN                 0x400000
>
>  #define CFG_SYS_BAUDRATE_TABLE {4800, 9600, 19200, 38400, 57600,\
>                                         115200}
> --
> 2.48.1
>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E042CCD6E68
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 06:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41D028485F;
	Thu,  4 Jun 2026 08:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YxfUF9Sa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2116184868; Thu,  4 Jun 2026 08:44:24 +0200 (CEST)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA07A83314
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 08:44:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-66077f6c438so359157d50.2
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 23:44:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780555459; cv=none;
 d=google.com; s=arc-20240605;
 b=U2dkIC52vReDJBznuY9ZtuCHX+J04QesVfB9T/wR9wCy69rGzZH8eDuZXPQpXTNrPJ
 cOB8YcgKqAyrmjEgfO+XbpUlNbIcLzglEywNN10kl1sIjup046gfJqPsFQS2GR7v4Hbv
 9Bm1SRIbCapUBNZBICmuT9e2i98gYqFgBj4zr+wrmVxgA14xSlk6e4Yc7Yt3JY9nAiQq
 ZDZ1s5zTRUrsw1COVmkeGXEyTo3TCRCgxKfC7fZrFmrFNGBu9sNId7cBwAaCQ0gYjnG9
 aILI+OWPysSp1A0Msp5ecZWI+hCubSEW4bfjuJA6X4IfqlaYmE8Z0sVBjH7c0pDqTPBD
 GwaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Azs2ZCiQL6DjapMumaMXnnu6srma4BX/7xKK0JkByOI=;
 fh=Ubq2n/ToFTSHUURX1fmzYQxOaEILDlPksjbqvzzOh4s=;
 b=QFDzOgcGqSdBRdvChoMKOr7w/c8e/OdyKESHaWkYM3ZK5kmv4P4HOIBQPtTULjEiV7
 nIgJ044CWl3HKIJB6FdWseRgX8OPjpbCzIWDtXc9GVq5XQkJOSqomaiEupoGm2t2bFsi
 CjLivkacgQqTTYwFM2gqIueJAEas96YAMCOsO3qKBUWy3GbQB/lVSxj2sFCf4NEwxS5D
 JXkfR0Zz5zSpL1sH85yl7RjsEQCmNObz/TcGEgjWsUWnIYxxpjAEvIjejUET7acSOV8N
 X779AMsEkbR7pCF9kouQ37yBOs9hzb9VyZe4q4zMnAUkR2Ha9Vhazkzc+RMz49cbw54u
 8jJA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780555459; x=1781160259; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Azs2ZCiQL6DjapMumaMXnnu6srma4BX/7xKK0JkByOI=;
 b=YxfUF9SaCwUZZ4FLwqH8sZ0CFuu9UJQ6ZTYgpBelvloBs5p9uUWrRHMk54tj9gbvyd
 LDKftUncv3vpwjjU3L7dzCwlilCOvdtREnWTGwVoT3ke74FXQMwoqArhv2EGpU/FPSGT
 6J6RHhZGB770XZrkw2rw3FViijxHWcARtIDys7tC/NB5kVkaUngoS/mjdRvieuhaz430
 fQ9UgqMr9ruB/Kk3EzLTjivjLiefRZEYZbrJ7H/iKCqCOE/KV7NUh1SgvQF4TXoxNGDr
 mSxldLn9K8prKR1fD8k8FcTG9rawTpXHjnqsFFbSQAHVMeN/Xwy0ME0DC/2k4xC3/l7X
 lIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780555459; x=1781160259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Azs2ZCiQL6DjapMumaMXnnu6srma4BX/7xKK0JkByOI=;
 b=siMIo0fjwkBP5D9sUZOsQUGqi+I/qFBQvDAKd+uEYWIHx8gVBg8SNsaupU9DAAL77R
 u0Nbl5BSQdYm2M+fDG1q+CcVHtoJOtXLBux7eXVutWngZ/KGsO5tu8kDCeqjPWX3G04A
 e+5NWNcc+WTn5v1Fy65nu9yybKbTI8WGR7TduIkP0b+4Iqgvl2q3bKTq8bk20TvQ3wSq
 XbClSvjWFv100C3bpYZtiJVU5GoAnfGuIV0iVFHMg4LpIl2NkRINCyyu0YaGavbWx2P7
 0WtnVHdqKzEAijyKmq7zscZGX44wBCR/Hg9p5qnZcRk0KCLJVz0yxwinhztsRELBsMzo
 tt9A==
X-Gm-Message-State: AOJu0YyPz+k9eamV8YdeNRUmSEqff0chS8k9o6/49Em7vj/jMiGwCG2r
 wz63VuhIqR+JPZUiQEYuRzora1No0dNqtWa6o+z3Z0ZH7AKZcsbryheVo0RKPnrFWEu/mUFKu7N
 +dvrsZkrGcazqJ/Bj9/JfM9adoMR06qJStlg+7ARszGno5OYUJZKnzjqZtA==
X-Gm-Gg: Acq92OEzWj0dIsYNfFYjp0Rmf5CzQ4cywWKZmLofYEiqyweuc2wmYnsHuMIMBCYfNen
 dxhqyNKLD6Pde4ZsmLC7l19uX3uVboSfYY0GRggOFuMNwEda4HQm159YBjCPJuDT+DC8sjJ7cZs
 lax1osr5akOtayDKMx30p+VwTgjFiB2MeifdNXsov/hth1vnskmRe9CXFez2Owh5IZyeo48e7q9
 t6BDsPdXB9LZrfGsW2A4j9srWWrwd2YdE7QstEZBP/NfVW977RnsK8nJIhPxSDJEZMkdRBrPmu4
 b2iLyJ7SdpFYJ25LqP9C5JI5Uo9Ahhha8X+LVVUjr+a0a7H2QLjjEt4AZlX42Ag9d8xzmu24dMH
 mGZmx9B4IzTy1+MYUmcq+6o7QKbTpsMtz27rWgO+CNWFg5XcBsJSTlP482g0qdOY8hUlm2fqcow
 n03M2/A3sXne6BhWNouScMD4J13GNprW8VuZwJYoVACuswjUnor5bCXmKH2D/SHYmDAtGFooP9I
 P+EUhkI6wsicXMZwTvYhJP7qPqhzdsilPsEhIJZFxRDTN+4kTX2X/2wd3Y0rsT/LTGDsKoJXMBX
 wXSfdPKrCSZRvil4aG4lDPSmzy2nIMAjiC9eIU/xWHH80oDNFctgShzvu5lllY794w5PqjjxFYq
 1OZ1U83X6D4TyjQWrtNcl18zJoz4=
X-Received: by 2002:a05:690e:d8d:b0:660:5dc3:3fe0 with SMTP id
 956f58d0204a3-660dbfbd3a5mr5918400d50.14.1780555459482; Wed, 03 Jun 2026
 23:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260603141814.12672-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260603141814.12672-1-marek.vasut+renesas@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 4 Jun 2026 09:43:43 +0300
X-Gm-Features: AVHnY4JPMZLtpK4vyjIdnvFfOXuOQPQWswJIY22Cy3yRLMEjn5omCAvd38wImcU
Message-ID: <CAC_iWjL13SZ6uN2RgQO2EsT+YRfaz=poOCEQuEWBLt8RgahWgQ@mail.gmail.com>
Subject: Re: [PATCH v1] lmb: Optionally limit available memory to 4 GiB on
 limited systems
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>
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

On Wed, 3 Jun 2026 at 17:18, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Some architectures can not DMA above 4 GiB boundary,
> limit available memory to memory below 4 GiB boundary.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Heiko Schocher <hs@nabladev.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Holger Brunck <holger.brunck@hitachienergy.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sughosh Ganu <sughosh.ganu@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> V1: Invert the IS_ENABLED(CONFIG_LMB_LIMIT_DMA_BELOW_4G) conditional
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org> #rpi4 8GiB

>  lib/Kconfig |  8 ++++++++
>  lib/lmb.c   | 20 +++++++++++++++++++-
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 77ebc79e1db..29911068a69 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1295,6 +1295,14 @@ config SPL_LMB_ARCH_MEM_MAP
>           memory map. Enable this config in such scenarios which allow
>           architectures and boards to define their own memory map.
>
> +config LMB_LIMIT_DMA_BELOW_4G
> +       bool
> +       depends on LMB
> +       default y if ARCH_BCM283X
> +       help
> +         Some architectures can not DMA above 4 GiB boundary,
> +         limit available memory to memory below 4 GiB boundary.
> +
>  config PHANDLE_CHECK_SEQ
>         bool "Enable phandle check while getting sequence number"
>         help
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 8f12c6ad8e5..a2aeb526e29 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -611,6 +611,7 @@ static __maybe_unused void lmb_reserve_common_spl(void)
>  static void lmb_add_memory(void)
>  {
>         int i;
> +       phys_addr_t bank_end;
>         phys_size_t size;
>         u64 ram_top = gd->ram_top;
>         struct bd_info *bd = gd->bd;
> @@ -625,8 +626,25 @@ static void lmb_add_memory(void)
>         for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
>                 size = bd->bi_dram[i].size;
>
> -               if (size)
> +               if (size) {
>                         lmb_add(bd->bi_dram[i].start, size);
> +                       if (!IS_ENABLED(CONFIG_LMB_LIMIT_DMA_BELOW_4G))
> +                               continue;
> +
> +                       bank_end = bd->bi_dram[i].start + size;
> +
> +                       /*
> +                        * Reserve memory above ram_top as
> +                        * no-overwrite so that it cannot be
> +                        * allocated
> +                        */
> +                       if (bd->bi_dram[i].start >= ram_top)
> +                               lmb_reserve(bd->bi_dram[i].start, size,
> +                                           LMB_NOOVERWRITE);
> +                       else if (bank_end > ram_top)
> +                               lmb_reserve(ram_top, bank_end - ram_top,
> +                                           LMB_NOOVERWRITE);
> +               }
>         }
>  }
>
> --
> 2.53.0
>

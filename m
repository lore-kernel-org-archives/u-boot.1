Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7051EC531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 20:48:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7622D88C6D;
	Fri, 23 Aug 2024 22:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nO2hlZeX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B852988BE4; Fri, 23 Aug 2024 22:47:42 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDABD88BEF
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 22:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7a1e2ac1ee5so156467785a.2
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 13:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724446059; x=1725050859; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QRs2sK8uCiHQ55z1Tqx37q17IzVvO2WrZez9abNhiiY=;
 b=nO2hlZeXghvNAb/FET6/MykP3wPScC6Od3DNZhGYZyEcaBO0CNpbrtnn6Tpt/rbsgY
 Ark9slne9lLt+ei1FIjfrOwRbQf5QaqFQqx0DVq+4K9qsZBgC03/PrTgSC0kllM6WZzQ
 k2GMD0PcZhRk3AjA+E+1vBfw9pSs9VR8QXBNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724446059; x=1725050859;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QRs2sK8uCiHQ55z1Tqx37q17IzVvO2WrZez9abNhiiY=;
 b=XvoS+DEApXRHusBMY4PffZqJ5crjs79ET0NXx24AaXBUVvrX3jwsFs/C89Ytj23Bwm
 72rUHuA9lXODFJL9596kYOSQC9knCM2K1+7CjmT5oSYdoexkq+I03SmUuHthh+iBNQoX
 dew3KApnfLFCQgsgD1i23p8LM3u2YvF7e87HFiTLvuMwRbAOpv+bqOuHw/10kz7qL9bM
 zM2wXHuCyViA9IlIqQBZlKTzL+d4rUq9dGSi2pi848Dl/IrVMuLT/HfP9mwC1CifMs58
 3+dAef81X8dda2zGqvo7h8DfhK9hGaOztOhy9tfOZ8zrZm8Mt2HGY1J6LV0XMrI9pfFn
 8U0Q==
X-Gm-Message-State: AOJu0YyLLXfNi9d30zJ17B/vgcYDxqm5rXWYTkXkdNjntRmP4DmT/BRt
 7PAb35b6MSya6DvyNvo6Acj6VdNWay580YhbnTBpJFK7ADFqRkAPSQw09gfCOc8eUTORu23f+tJ
 PF/XOwFVwff0ymAhcqsNW+PV3RGQUmmML90vq
X-Google-Smtp-Source: AGHT+IG0YQXKxePH9cOqqDBpH6fOwa6mqK4YGor42mfPGbZci8nImS1Y1a6BOHCSFDNDfhrmrZUPMCdcDXZPK8upmsU=
X-Received: by 2002:a05:6214:4904:b0:6bf:6a19:b89f with SMTP id
 6a1803df08f44-6c16dc6da58mr43594936d6.28.1724446058736; Fri, 23 Aug 2024
 13:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240821105839.2870293-1-sughosh.ganu@linaro.org>
 <20240821105839.2870293-20-sughosh.ganu@linaro.org>
In-Reply-To: <20240821105839.2870293-20-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Aug 2024 14:47:28 -0600
Message-ID: <CAFLszThc1O50c+OmYHJ5dVuZRGUm=mtXQX2j4nUyLDSj8nLa0g@mail.gmail.com>
Subject: Re: [PATCH v3 19/27] sandbox: move the TCG event log to the start of
 ram memory
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
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

Hi Sughosh,

On Wed, 21 Aug 2024 at 05:00, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The TCG event log buffer is being set at the end of ram memory. This
> region of memory is to be reserved as LMB_NOMAP memory in the LMB
> memory map. The current location of this buffer overlaps with the
> memory region reserved for the U-Boot image, which is at the top of
> the usable memory. This worked earlier as the LMB memory map was not
> global but caller specific, but fails now because of the overlap.
>
> Move the TCG event log buffer to the start of the ram memory region
> instead. Move the location of the early trace buffer and the load
> buffer for U-Boot(spl boot) accordingly.
>

On condition that we can move this to the bloblist and avoid this
problem once your series is in:

Reviewed-by: Simon Glass <sjg@chromium.org>


> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V2:
> * Move the TCG event log to a location such that it does not clash
>   with any load addresses in the tests.
> * Adjust the values of CONFIG_TRACE_EARLY_ADDR and U-Boot load address
>   for SPL accordingly.
>
>  arch/sandbox/dts/test.dts     | 2 +-
>  configs/sandbox_spl_defconfig | 2 +-
>  doc/arch/sandbox/sandbox.rst  | 5 +++--
>  lib/Kconfig                   | 2 +-
>  4 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index 5fb5eac862..8412506c17 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -78,7 +78,7 @@
>
>                 event_log: tcg_event_log {
>                         no-map;
> -                       reg = <(CFG_SYS_SDRAM_SIZE - 0x2000) 0x2000>;
> +                       reg = <(CFG_SYS_SDRAM_BASE + 0x100000) 0x2000>;
>                 };
>         };
>
> diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
> index f7b92dc844..826a82d092 100644
> --- a/configs/sandbox_spl_defconfig
> +++ b/configs/sandbox_spl_defconfig
> @@ -1,4 +1,4 @@
> -CONFIG_TEXT_BASE=0x200000
> +CONFIG_TEXT_BASE=0x400000
>  CONFIG_SPL_GPIO=y
>  CONFIG_SPL_LIBCOMMON_SUPPORT=y
>  CONFIG_SPL_LIBGENERIC_SUPPORT=y
> diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandbox.rst
> index 5f8db12665..4967551724 100644
> --- a/doc/arch/sandbox/sandbox.rst
> +++ b/doc/arch/sandbox/sandbox.rst
> @@ -662,7 +662,8 @@ Addr      Config                     Usage
>     b000   CONFIG_BLOBLIST_ADDR       Blob list
>    10000   CFG_MALLOC_F_ADDR          Early memory allocation
>    f0000   CONFIG_PRE_CON_BUF_ADDR    Pre-console buffer
> - 100000   CONFIG_TRACE_EARLY_ADDR    Early trace buffer (if enabled). Also used
> + 100000   TCG Event log              TCG Event Log
> + 200000   CONFIG_TRACE_EARLY_ADDR    Early trace buffer (if enabled). Also used
>                                       as the SPL load buffer in spl_test_load().
> - 200000   CONFIG_TEXT_BASE           Load buffer for U-Boot (sandbox_spl only)
> + 400000   CONFIG_TEXT_BASE           Load buffer for U-Boot (sandbox_spl only)
>  =======   ========================   ===============================
> diff --git a/lib/Kconfig b/lib/Kconfig
> index e352b5550a..5f282ecb54 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -403,7 +403,7 @@ config TRACE_EARLY_CALL_DEPTH_LIMIT
>  config TRACE_EARLY_ADDR
>         hex "Address of early trace buffer in U-Boot"
>         depends on TRACE_EARLY
> -       default 0x00100000
> +       default 0x00200000
>         help
>           Sets the address of the early trace buffer in U-Boot. This memory
>           must be accessible before relocation.
> --
> 2.34.1
>

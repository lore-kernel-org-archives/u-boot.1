Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB46CF3943
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E7F6891D8;
	Thu, 19 Sep 2024 16:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DfnblcfI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A6B2891C1; Thu, 19 Sep 2024 16:10:08 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6472891C5
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6c354091616so7258946d6.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755005; x=1727359805; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Df4Q6Tb5wOhSep7wAwVJa1Nhc10l9los0GY3yHQgIPw=;
 b=DfnblcfIJ8vKNHQoqeV0bR4f6Swx56oSDq4c+G363KH4sMQ/HaeZqdiNqkvlhQ8sib
 vpV7VMVamBT8zCPjFNkjB3LG3fsjOCSTln+pY1hA20wwczwJ4ub4R16a1gk4v3CkCFV+
 RVMaeoaZx+wAtVK1fDaNmzfXLwh35dXKFVs8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755005; x=1727359805;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Df4Q6Tb5wOhSep7wAwVJa1Nhc10l9los0GY3yHQgIPw=;
 b=M4EGUHPUWwQDgk8dTKu5mcXb8pdBIrcZmxCb3yUEdw/TXLFSw6SeJvXudTRnwq7dTk
 PdI9UbutCTdgxyPF+cghShA6frKGENamTlehR/Jv9iLgp2QiiEVEHxCmZhr2p5SNaeu9
 c8+z/T+C7b5TSnjVHji7E5hw6wmmFUAAv2j9tRPlzEm98czgLAQ4Bnk7q9w3ZJGLo28X
 SIfpkiiLOPpZW3IhMArzlcUAzX8ffk1gO0zNB5HgUQaROd9Tu6h81S7tir/etEx8JaBU
 mU/DLsofP6x9P4KseF/qvs1j9Y9tNWM+OlmQ2UNTKncTEnKcGRX7/wbEfItENGQAh8g7
 6q3w==
X-Gm-Message-State: AOJu0YwZZMJ69CyJEq95/xssH0L1GncvIjA1bpXqcaOg5ZQYEr6UYOHG
 Klorifrn5UHfZ3Z0jbpN5I1z+ssOp762joIVZucl9+NbxnCXD757l+ls3aIqXRHjhYZiQmvpNvX
 bGYV0XEzTmCFipPGAgovzF2I4dC3QzfNCsUX5
X-Google-Smtp-Source: AGHT+IHZu6CqxxwQZXxcO7fi/uXb4QYVVJtrf+k1bewjUAGp97fhnNoi8xNkhz5PGQqByxt+rArucOty7z5a/1Z8VRI=
X-Received: by 2002:a05:6214:3f81:b0:6c5:72c1:8d4e with SMTP id
 6a1803df08f44-6c57352dffdmr439114206d6.27.1726755004647; Thu, 19 Sep 2024
 07:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-27-patrick.rudolph@9elements.com>
In-Reply-To: <20240918152136.3395170-27-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:09:53 +0200
Message-ID: <CAFLszThVt6ifZh99TeXY-c=iuiYTwo=b8wgFM0tUrn6TM1=Qbg@mail.gmail.com>
Subject: Re: [PATCH v4 26/35] arm: mach-bcm283x: Map the ARM local MMIO as well
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
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

On Wed, 18 Sept 2024 at 17:26, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Cover the "ARM local MMIO" range as well in the default MMU mapping in
> order to allow future code to access the GIC-400 without crashing. For
> now the GIC is not touched in u-boot, thus this change is a noop.

U-Boot

>
> See [1](BCM2711 ARM Peripherals) for reference.
>
> TEST: Enabled CONFIG_GICV2 and accessed the GIC in C code without crash.
>
> 1: https://datasheets.raspberrypi.com/bcm2711/bcm2711-peripherals.pdf
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> ---
>  arch/arm/mach-bcm283x/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
> index 1b459707bc..7a1de22e0a 100644
> --- a/arch/arm/mach-bcm283x/init.c
> +++ b/arch/arm/mach-bcm283x/init.c
> @@ -50,7 +50,7 @@ static struct mm_region bcm2711_mem_map[MEM_MAP_MAX_ENTRIES] = {
>         }, {
>                 .virt = 0xfc000000UL,
>                 .phys = 0xfc000000UL,
> -               .size = 0x03800000UL,
> +               .size = 0x04000000UL,
>                 .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>                          PTE_BLOCK_NON_SHARE |
>                          PTE_BLOCK_PXN | PTE_BLOCK_UXN
> --
> 2.46.0
>

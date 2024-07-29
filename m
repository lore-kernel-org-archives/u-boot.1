Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB32C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 07:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7702988747;
	Mon, 29 Jul 2024 09:58:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="k2UujY4K";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="aK+GFnJf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7587C88056; Mon, 29 Jul 2024 09:58:30 +0200 (CEST)
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7C82887E3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id 3007e422;
 Mon, 29 Jul 2024 07:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=s1; bh=KR
 90DrRWbFtDjwiXqS0UK3xB5+U=; b=k2UujY4KoEMAmCrPdmfHVm2aUn8sBjWAc7
 RZmfbY+m1nyNqblGebi2kwcKtMOw2spjDSGQ7oKd+IAxZi1ZbYXtIxKT2hkmQIIs
 aotKqhJIH/lx6JH/qWBDOHNyPYq5TlzfJKLOyPfbElMvG/r8S4jrVtc8D5FCE8z7
 ulowvluv4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
 odwO4o0LwkEC73YFlytbP2jfzoIM/w3R6ImrFANw1nDOFMo0SRtQCWFJuHm8PzMy
 0ZrFH7B1FkN1T4trXT4G8hnAF7yrG93+/qST3nlHOH3LbW3b8K81uLPGxrNs/WXC
 zJrv1lPek6RYjdDXFh86O3KtABOKxDb80PwXNwOik8Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1722239773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B5W9TUvhpYSTnK25Z+SB5KjcFPVTjME8CQte2E2Lc60=;
 b=aK+GFnJfIvTjR5LT6pQN3Bm7YNUsJhdBn3u7XRt+R6plzmg9XCssSxecL6TjVvvtv8xK6u
 qbfQEUHdL7h2Y1C19Wjbh2qR1sdCDAIVOJLV/gVw/N84mtfCiH/DbDKKt+F9Cnssph3Elb
 TZvjVuovifA8CD1/Kx5Bfxi7UspgQ4s=
Received: from [192.168.0.2] (host-87-5-224-154.retail.telecomitalia.it
 [87.5.224.154])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id 5860d940
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Mon, 29 Jul 2024 07:56:13 +0000 (UTC)
Message-ID: <9b88aef5-be01-43e4-973b-5742256a4ef4@kernel-space.org>
Date: Mon, 29 Jul 2024 09:57:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Acked
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Huan Wang <alison.wang@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Mario Six <mario.six@gdsys.cc>, Sean Anderson <seanga2@gmail.com>
References: <20240724150922.2343249-1-sjg@chromium.org>
 <20240724150922.2343249-2-sjg@chromium.org>
Content-Language: en-US
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20240724150922.2343249-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Acked-by: Angelo Dureghello <angelo@kernel-space.org>

On 24/07/24 5:08 PM, Simon Glass wrote:
> Only m68k and powerpc use this field, so move it to the arch-specific
> info, to reduce the size for other archs.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   arch/m68k/cpu/mcf5445x/cpu.c           | 2 +-
>   arch/m68k/include/asm/global_data.h    | 2 ++
>   arch/m68k/lib/bdinfo.c                 | 2 +-
>   arch/powerpc/cpu/mpc83xx/pci.c         | 4 ++--
>   arch/powerpc/cpu/mpc83xx/speed.c       | 2 +-
>   arch/powerpc/include/asm/global_data.h | 2 ++
>   drivers/clk/mpc83xx_clk.c              | 2 +-
>   include/asm-generic/global_data.h      | 5 -----
>   8 files changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/arch/m68k/cpu/mcf5445x/cpu.c b/arch/m68k/cpu/mcf5445x/cpu.c
> index b811ac355e4..3fbd6a58c7d 100644
> --- a/arch/m68k/cpu/mcf5445x/cpu.c
> +++ b/arch/m68k/cpu/mcf5445x/cpu.c
> @@ -92,7 +92,7 @@ int print_cpuinfo(void)
>   		       strmhz(buf3, gd->arch.flb_clk));
>   #ifdef CONFIG_PCI
>   		printf("       PCI CLK %s MHz INP CLK %s MHz VCO CLK %s MHz\n",
> -		       strmhz(buf1, gd->pci_clk),
> +		       strmhz(buf1, gd->arch.pci_clk),
>   		       strmhz(buf2, gd->arch.inp_clk),
>   		       strmhz(buf3, gd->arch.vco_clk));
>   #else
> diff --git a/arch/m68k/include/asm/global_data.h b/arch/m68k/include/asm/global_data.h
> index 93efc722ba8..4ac886933c6 100644
> --- a/arch/m68k/include/asm/global_data.h
> +++ b/arch/m68k/include/asm/global_data.h
> @@ -26,6 +26,8 @@ struct arch_global_data {
>   #if defined(CONFIG_FSL_ESDHC)
>   	unsigned long sdhc_per_clk;
>   #endif
> +	/** @pci_clk: PCI clock rate in Hz */
> +	unsigned long pci_clk;
>   };
>   
>   #include <asm-generic/global_data.h>
> diff --git a/arch/m68k/lib/bdinfo.c b/arch/m68k/lib/bdinfo.c
> index cf6ae5adddf..891e94bbd3f 100644
> --- a/arch/m68k/lib/bdinfo.c
> +++ b/arch/m68k/lib/bdinfo.c
> @@ -22,7 +22,7 @@ int arch_setup_bdinfo(void)
>   	bd->bi_busfreq = gd->bus_clk;	/* Bus Freq,      in Hz */
>   
>   	if (IS_ENABLED(CONFIG_PCI))
> -		bd->bi_pcifreq = gd->pci_clk;
> +		bd->bi_pcifreq = gd->arch.pci_clk;
>   
>   #if defined(CONFIG_EXTRA_CLOCK)
>   	bd->bi_inpfreq = gd->arch.inp_clk;	/* input Freq in Hz */
> diff --git a/arch/powerpc/cpu/mpc83xx/pci.c b/arch/powerpc/cpu/mpc83xx/pci.c
> index 6f378c4e221..aef1123a2b7 100644
> --- a/arch/powerpc/cpu/mpc83xx/pci.c
> +++ b/arch/powerpc/cpu/mpc83xx/pci.c
> @@ -45,7 +45,7 @@ void ft_pci_setup(void *blob, struct bd_info *bd)
>   			do_fixup_by_path(blob, path, "bus-range",
>   				&tmp, sizeof(tmp), 1);
>   
> -			tmp[0] = cpu_to_be32(gd->pci_clk);
> +			tmp[0] = cpu_to_be32(gd->arch.pci_clk);
>   			do_fixup_by_path(blob, path, "clock-frequency",
>   				&tmp, sizeof(tmp[0]), 1);
>   		}
> @@ -60,7 +60,7 @@ void ft_pci_setup(void *blob, struct bd_info *bd)
>   			do_fixup_by_path(blob, path, "bus-range",
>   				&tmp, sizeof(tmp), 1);
>   
> -			tmp[0] = cpu_to_be32(gd->pci_clk);
> +			tmp[0] = cpu_to_be32(gd->arch.pci_clk);
>   			do_fixup_by_path(blob, path, "clock-frequency",
>   				&tmp, sizeof(tmp[0]), 1);
>   		}
> diff --git a/arch/powerpc/cpu/mpc83xx/speed.c b/arch/powerpc/cpu/mpc83xx/speed.c
> index 72464962613..0185ab50ad9 100644
> --- a/arch/powerpc/cpu/mpc83xx/speed.c
> +++ b/arch/powerpc/cpu/mpc83xx/speed.c
> @@ -456,7 +456,7 @@ int get_clocks(void)
>   #if defined(CONFIG_ARCH_MPC837X)
>   	gd->arch.sata_clk = sata_clk;
>   #endif
> -	gd->pci_clk = pci_sync_in;
> +	gd->arch.pci_clk = pci_sync_in;
>   	gd->cpu_clk = gd->arch.core_clk;
>   	gd->bus_clk = gd->arch.csb_clk;
>   	return 0;
> diff --git a/arch/powerpc/include/asm/global_data.h b/arch/powerpc/include/asm/global_data.h
> index a9efbbdd3d4..cc2ce617350 100644
> --- a/arch/powerpc/include/asm/global_data.h
> +++ b/arch/powerpc/include/asm/global_data.h
> @@ -87,6 +87,8 @@ struct arch_global_data {
>   #if defined(CONFIG_LWMON5)
>   	unsigned long kbd_status;
>   #endif
> +	/** @pci_clk: PCI clock rate in Hz */
> +	unsigned long pci_clk;
>   };
>   
>   #include <asm-generic/global_data.h>
> diff --git a/drivers/clk/mpc83xx_clk.c b/drivers/clk/mpc83xx_clk.c
> index a29ad0d7a68..a43fff2e7ed 100644
> --- a/drivers/clk/mpc83xx_clk.c
> +++ b/drivers/clk/mpc83xx_clk.c
> @@ -358,7 +358,7 @@ static int mpc83xx_clk_probe(struct udevice *dev)
>   	gd->mem_clk = priv->speed[MPC83XX_CLK_MEM];
>   
>   	if (mpc83xx_has_pci(type))
> -		gd->pci_clk = priv->speed[MPC83XX_CLK_PCI];
> +		gd->arch.pci_clk = priv->speed[MPC83XX_CLK_PCI];
>   
>   	gd->cpu_clk = priv->speed[MPC83XX_CLK_CORE];
>   	gd->bus_clk = priv->speed[MPC83XX_CLK_CSB];
> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
> index aa336d63e3a..970053892e1 100644
> --- a/include/asm-generic/global_data.h
> +++ b/include/asm-generic/global_data.h
> @@ -59,11 +59,6 @@ struct global_data {
>   	 * @bus_clk: platform clock rate in Hz
>   	 */
>   	unsigned long bus_clk;
> -	/**
> -	 * @pci_clk: PCI clock rate in Hz
> -	 */
> -	/* We cannot bracket this with CONFIG_PCI due to mpc5xxx */
> -	unsigned long pci_clk;
>   	/**
>   	 * @mem_clk: memory clock rate in Hz
>   	 */

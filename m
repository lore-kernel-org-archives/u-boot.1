Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04ADACDB482
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:15:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D56286EA8;
	Sun, 15 Oct 2023 08:38:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="txW0VXan";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="l63mBAdJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A806786529; Sun, 15 Oct 2023 08:37:50 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CD7386F33
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:35:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4S7Dk44hXWz9sm2;
 Sat, 14 Oct 2023 21:59:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697313596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ay1YRNF/oOwExzd41jfomkvZoofLPlmYZY+xpV9ZIjA=;
 b=txW0VXanaJJm0AK4qWD5delFAQqmvnjvYIIsshSFrBPOcuYwYEBDqg6o6W6hP24t7eWr9C
 uZBTDqj+mtMNHe64EV+QMTyPWUYDQD57w0CES1TNqHX+oQkjt/JLktsHkU6XqZxCAJdqcl
 vs47yV0ckGT44vQtdx1MUfANLT5P5BybKw2/Z9/4QKNvZZXq/WthsjEmsKncy9J/Q6eGkK
 1u3OVPYkYlA2+A5d0i/ma9kXQVPpqaM+XGF7J8jnVibZCUWPxn7rOzAhDL4NiYklc3jfF4
 wqIRs7OJ2EdGEWqTDxrj+H7WZXvZRdYUJjHH4xphNl8Bt8Rqrusr6E6msl1NHg==
Message-ID: <96d9bc00-9f48-4545-b43a-a94c9439164c@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697313594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ay1YRNF/oOwExzd41jfomkvZoofLPlmYZY+xpV9ZIjA=;
 b=l63mBAdJXF/XdMVUe3egdxzgo1ve2Lcab62N09ALf5PIVM4/AKsye2xCvO6LtdEuVCbU2b
 HUPqEBBF0LbkHQC8qClzyFO5mlCBHp5VtVEf1w45N45CCnjHpQ1yV1ykux++xRVv3SnjeT
 7yUsMIoYuZCslDkheCYyYYquAZHP/brKCutDZFEqZBG4Z6WWgd7pF0aauJn0ITJrs0bFhk
 EGNJ/HrLwdYwQwAjOxU152Itj8ZU9HTIDAJz99c/VuDO36BY9GkfHeHjSvfgXeF0HPmB1p
 B8Iuk8jP8bEueW6FI0//gxzVzRKSGDKkWxjhzMQYWQXUJKvgR18RsYQdvWdjNA==
Date: Sat, 14 Oct 2023 21:59:51 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 19/19] board: rzg2l: Add RZ/G2L SMARC EVK board
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
 <20231009164645.164464-20-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231009164645.164464-20-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: t1tyyxbswenc8ixtsou71dh5b7mp7of4
X-MBO-RS-ID: a4b8ad3f61015cdcf5c
X-Rspamd-Queue-Id: 4S7Dk44hXWz9sm2
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

On 10/9/23 18:46, Paul Barker wrote:
> The Renesas RZ/G2L SMARC Evaluation Board Kit consists of the RZ/G2L
> System-on-Module (SOM) based on the R9A07G044L2 SoC, and a common SMARC
> carrier board.
> 
> The ARM TrustedFirmware code for the Renesas RZ/G2L SoC family passes a
> devicetree blob to the bootloader as an argument in the same was
> previous R-Car gen3/gen4 SoCs. This blob contains a compatible string
> which can be used to identify the particular SoC we are running on and
> this is used to select the appropriate device tree to load.
> 
> The configuration renesas_rzg2l_smarc_defconfig is added to support
> building for this target. In the future this defconfig will be extended
> to support other SoCs and evaluation boards from the RZ/G2L family.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
>   * Move dram_init() & dram_init_banksize() to memmap-rzg2l.c
>   * Add a TODO note for reset support.
> 
>   arch/arm/mach-rmobile/Kconfig.rzg2l   | 14 ++++++
>   arch/arm/mach-rmobile/memmap-rzg2l.c  | 12 +++++
>   board/renesas/rzg2l/Kconfig           | 18 +++++++
>   board/renesas/rzg2l/MAINTAINERS       |  6 +++
>   board/renesas/rzg2l/Makefile          |  4 ++
>   board/renesas/rzg2l/rzg2l.c           | 67 +++++++++++++++++++++++++++
>   configs/renesas_rzg2l_smarc_defconfig | 52 +++++++++++++++++++++
>   include/configs/rzg2l-smarc.h         | 14 ++++++
>   8 files changed, 187 insertions(+)
>   create mode 100644 board/renesas/rzg2l/Kconfig
>   create mode 100644 board/renesas/rzg2l/MAINTAINERS
>   create mode 100644 board/renesas/rzg2l/Makefile
>   create mode 100644 board/renesas/rzg2l/rzg2l.c
>   create mode 100644 configs/renesas_rzg2l_smarc_defconfig
>   create mode 100644 include/configs/rzg2l-smarc.h
> 
> diff --git a/arch/arm/mach-rmobile/Kconfig.rzg2l b/arch/arm/mach-rmobile/Kconfig.rzg2l
> index 039d6b0a45aa..dc30bdf3e5c2 100644
> --- a/arch/arm/mach-rmobile/Kconfig.rzg2l
> +++ b/arch/arm/mach-rmobile/Kconfig.rzg2l
> @@ -9,6 +9,20 @@ config R9A07G044L
>   	help
>   	  Enable support for the Renesas R9A07G044L (RZ/G2L) SoC.
>   
> +choice
> +	prompt "Renesas RZ/G2L Family Board selection"
> +	default TARGET_RZG2L_SMARC_EVK
> +
> +config TARGET_RZG2L_SMARC_EVK
> +	bool "Renesas RZ/G2L SMARC EVK"
> +	imply R9A07G044L
> +	help
> +	  Enable support for the RZ/G2L SMARC evaluation board.
> +
> +source "board/renesas/rzg2l/Kconfig"
> +
> +endchoice
> +
>   config MULTI_DTB_FIT_UNCOMPRESS_SZ
>   	default 0x80000 if TARGET_RZG2L_SMARC_EVK
>   
> diff --git a/arch/arm/mach-rmobile/memmap-rzg2l.c b/arch/arm/mach-rmobile/memmap-rzg2l.c
> index d0509424fb73..a08d0ea08fc0 100644
> --- a/arch/arm/mach-rmobile/memmap-rzg2l.c
> +++ b/arch/arm/mach-rmobile/memmap-rzg2l.c
> @@ -113,3 +113,15 @@ void enable_caches(void)
>   
>   	dcache_enable();
>   }
> +
> +int dram_init(void)
> +{
> +	return fdtdec_setup_mem_size_base();
> +}
> +
> +int dram_init_banksize(void)
> +{
> +	fdtdec_setup_memory_banksize();
> +
> +	return 0;
> +}


You could add this piece ^ in patch 17/19 already.

[...]

> diff --git a/board/renesas/rzg2l/rzg2l.c b/board/renesas/rzg2l/rzg2l.c
> new file mode 100644
> index 000000000000..5b919f0b495a

[...]

> +int ft_board_setup(void *blob, struct bd_info *bd)
> +{
> +	return 0;
> +}
> +
> +int __weak board_init(void)

This one shouldn't be __weak anymore, DTTO for the reset_cpu().
The board specific functions are the final ones.

> +{
> +	return 0;
> +}
> +
> +void __weak reset_cpu(void)
> +{
> +	/*
> +	 * TODO: Implement reset support once TrustedFirmware supports
> +	 * the appropriate call.
> +	 */
> +}

[...]

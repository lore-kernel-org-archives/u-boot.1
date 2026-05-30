Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32C5CD5BD0
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 15:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BD1184671;
	Sat, 30 May 2026 17:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bTIQF00P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D35A084693; Sat, 30 May 2026 17:06:58 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B1F88405A
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 17:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gSNqL2P5nz9tV9;
 Sat, 30 May 2026 17:06:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780153614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RooLbbVhY/Y7hg8RFbCxNceq6+/95LFWTZmT5E4Uuik=;
 b=bTIQF00PsWkAS+k23Tn08bbw12m1IK8Ch+4HemlDR6hv8FpDOgHBrmSe6ZtQXjEX/70vaV
 DolYvQ57M1LdyzKDuowJSPVtJtVV8FtBOpC/2KWr51N4F0fQK/g3lrVa26EXGZASquJonh
 2o10wZkdJxIMN7jjzOM1e8Xfu4bjdz5cuj3r/R/w91/xX+2m4oBABFXDi6GD+PnuO9Esf/
 K0RXCQ1B/toFo07VqM6hRbStQJDw8MrewxYalC7CAyDgNE/4yNedamzxo5Piv6uanEkWFo
 His8A6lnjCwipyn/XbwJWTygpIpcBU256JLxZXhEz2NFgvkQX040923Mh36I2A==
Message-ID: <8e28ea5f-039e-4620-bb88-8e992290da58@mailbox.org>
Date: Sat, 30 May 2026 17:06:51 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] [RFC] lmb: Optionally limit available memory to 4 GiB on
 limited systems
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
References: <20260530144604.71190-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260530144604.71190-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 5okdbnz6ayk5trnengnh8zcufp4yxtsk
X-MBO-RS-ID: 41f97b3b2fd91be9870
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

On 5/30/26 4:45 PM, Marek Vasut wrote:
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
>   lib/Kconfig |  8 ++++++++
>   lib/lmb.c   | 20 +++++++++++++++++++-
>   2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 77ebc79e1db..29911068a69 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1295,6 +1295,14 @@ config SPL_LMB_ARCH_MEM_MAP
>   	  memory map. Enable this config in such scenarios which allow
>   	  architectures and boards to define their own memory map.
>   
> +config LMB_LIMIT_DMA_BELOW_4G
> +	bool
> +	depends on LMB
> +	default y if ARCH_BCM283X
> +	help
> +	  Some architectures can not DMA above 4 GiB boundary,
> +	  limit available memory to memory below 4 GiB boundary.
> +
>   config PHANDLE_CHECK_SEQ
>   	bool "Enable phandle check while getting sequence number"
>   	help
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 8f12c6ad8e5..a8a988eedc0 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -611,6 +611,7 @@ static __maybe_unused void lmb_reserve_common_spl(void)
>   static void lmb_add_memory(void)
>   {
>   	int i;
> +	phys_addr_t bank_end;
>   	phys_size_t size;
>   	u64 ram_top = gd->ram_top;
>   	struct bd_info *bd = gd->bd;
> @@ -625,8 +626,25 @@ static void lmb_add_memory(void)
>   	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
>   		size = bd->bi_dram[i].size;
>   
> -		if (size)
> +		if (size) {
>   			lmb_add(bd->bi_dram[i].start, size);
> +			if (IS_ENABLED(CONFIG_LMB_LIMIT_DMA_BELOW_4G))

This conditional should be inverted.

Peter Robinson , can you test this change on RPi ?

> +				continue;
> +
> +			bank_end = bd->bi_dram[i].start + size;
> +
> +			/*
> +			 * Reserve memory above ram_top as
> +			 * no-overwrite so that it cannot be
> +			 * allocated
> +			 */
> +			if (bd->bi_dram[i].start >= ram_top)
> +				lmb_reserve(bd->bi_dram[i].start, size,
> +					    LMB_NOOVERWRITE);
> +			else if (bank_end > ram_top)
> +				lmb_reserve(ram_top, bank_end - ram_top,
> +					    LMB_NOOVERWRITE);
> +		}
>   	}
>   }
>   

[...]

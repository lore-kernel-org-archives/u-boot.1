Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426C5E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 14:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C72E3805E2;
	Tue,  7 Jan 2025 15:23:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lxZkq7vi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E552805E2; Tue,  7 Jan 2025 15:23:45 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11641805E9
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 15:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id CB6AA5C5D6D;
 Tue,  7 Jan 2025 14:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C359C4CED6;
 Tue,  7 Jan 2025 14:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736259818;
 bh=0k3x1EkoZ3SpvrmcN597Dssju4g8i1RbOMDEZj7snCY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lxZkq7vih4BS9mE8j2V5T5VFtnoYyzboV9XwI//vp5lltov3wDRfib1exc3qVF0w5
 Y7TS/WBcCzhAL8yIBbAQe5PCaHMMK2J1vWJrcb+t0h8uTya5yc2F7GePbHyNHvpHnA
 RRQ6sy45Il3Q8HCDIfSFl2zFQO9QRutd//AfVFhUq3lIJWsiZYDUPO9Vh2/P0sCTM+
 w8pcLEDiIBTpCaM1rY2HGT9p9QLO7zBJUWPrWSgwsgrEgXWFLHZ8fVAnt44X+P/5jf
 z0L/71Syem/cpIDA3hW9ZylUCh0j8d7FPYKMwVKVYngxJhGGzF224qOxivqBUfEXd3
 TVaZGDlAWrdIw==
Message-ID: <cba88987-e2db-4c40-9a17-e31b57456183@kernel.org>
Date: Tue, 7 Jan 2025 16:23:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] board: ti: am62px: evm: Enable cache for AM62p
To: Chintan Vankar <c-vankar@ti.com>, AKASHI Takahiro
 <akashi.tkhro@gmail.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Nishanth Menon <nm@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Simon Glass <sjg@chromium.org>,
 Jayesh Choudhary <j-choudhary@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Tom Rini <trini@konsulko.com>
Cc: srk@ti.com, s-vadapalli@ti.com, danishanwar@ti.com, u-boot@lists.denx.de
References: <20250107093840.2211381-1-c-vankar@ti.com>
 <20250107093840.2211381-11-c-vankar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20250107093840.2211381-11-c-vankar@ti.com>
Content-Type: text/plain; charset=UTF-8
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



On 07/01/2025 11:38, Chintan Vankar wrote:
> From: Andreas Dannenberg <dannenberg@ti.com>
> 
> Enable cache to support Ethernet boot for AM62p-SK.

Please give more details in commit log.

What happens to Ethernet boot if you don't enable cache?
Is this a requirement by Ethernet hardware?


> 
> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
>  board/ti/am62px/evm.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/board/ti/am62px/evm.c b/board/ti/am62px/evm.c
> index 7362fa4520a..2a85af980c7 100644
> --- a/board/ti/am62px/evm.c
> +++ b/board/ti/am62px/evm.c
> @@ -9,6 +9,7 @@
>  #include <efi_loader.h>
>  #include <asm/arch/hardware.h>
>  #include <asm/io.h>
> +#include <cpu_func.h>
>  #include <dm/uclass.h>
>  #include <env.h>
>  #include <fdt_support.h>
> @@ -53,6 +54,13 @@ int board_init(void)
>  	return 0;
>  }
>  
> +#if IS_ENABLED(CONFIG_SPL_BUILD)
> +void spl_board_init(void)
> +{
> +	enable_caches();
> +}
> +#endif
> +
>  int dram_init(void)
>  {
>  	return fdtdec_setup_mem_size_base();

-- 
cheers,
-roger


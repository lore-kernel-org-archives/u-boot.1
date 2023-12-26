Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2B6C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 07:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C55B787646;
	Tue, 26 Dec 2023 08:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7FEC87687; Tue, 26 Dec 2023 08:35:07 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 721F886F56
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 08:35:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peterlin@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3BQ7YwWi015158
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 15:34:58 +0800 (+08)
 (envelope-from peterlin@andestech.com)
Received: from APC323 (10.0.12.98) by ATCPCS16.andestech.com (10.0.1.222) with
 Microsoft SMTP Server id 14.3.498.0; Tue, 26 Dec 2023 15:34:56 +0800
Date: Tue, 26 Dec 2023 15:34:56 +0800
From: Yu-Chien Peter Lin <peterlin@andestech.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>
CC: <u-boot@lists.denx.de>, <randolph@andestech.com>
Subject: Re: [PATCH v2 2/6] andes: ae350: Implement cache switch via Kconfig
Message-ID: <ZYqCIE81m07KprNc@APC323>
References: <20231226061736.482416-1-ycliang@andestech.com>
 <20231226061736.482416-2-ycliang@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231226061736.482416-2-ycliang@andestech.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Originating-IP: [10.0.12.98]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3BQ7YwWi015158
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

On Tue, Dec 26, 2023 at 02:17:33PM +0800, Leo Yu-Chi Liang wrote:
> Kconfig provides SYS_[I|D]CACHE_OFF config options to switch off caches.
> Provide the corresponding implementation to the options.
> 
> Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>

Reviewed-by: Yu Chien Peter Lin <peterlin@andestech.com>

> ---
>  arch/riscv/cpu/andesv5/cpu.c  | 25 ++++++++++++++++---------
>  board/AndesTech/ae350/ae350.c |  3 ++-
>  2 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/riscv/cpu/andesv5/cpu.c b/arch/riscv/cpu/andesv5/cpu.c
> index 63bc24cdfc..e764f6c5c0 100644
> --- a/arch/riscv/cpu/andesv5/cpu.c
> +++ b/arch/riscv/cpu/andesv5/cpu.c
> @@ -32,18 +32,25 @@ void harts_early_init(void)
>  	if (CONFIG_IS_ENABLED(RISCV_MMODE)) {
>  		unsigned long mcache_ctl_val = csr_read(CSR_MCACHE_CTL);
>  
> -		mcache_ctl_val |= (MCACHE_CTL_DC_COHEN | MCACHE_CTL_IC_EN |
> -				   MCACHE_CTL_DC_EN | MCACHE_CTL_CCTL_SUEN);
> +		mcache_ctl_val |= MCACHE_CTL_CCTL_SUEN;
> +
> +		if (!CONFIG_IS_ENABLED(SYS_ICACHE_OFF))
> +			mcache_ctl_val |= MCACHE_CTL_IC_EN;
> +
> +		if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
> +			mcache_ctl_val |= (MCACHE_CTL_DC_EN | MCACHE_CTL_DC_COHEN);
>  
>  		csr_write(CSR_MCACHE_CTL, mcache_ctl_val);
>  
> -		/*
> -		 * Check mcache_ctl.DC_COHEN, we assume this platform does
> -		 * not support CM if the bit is hard-wired to 0.
> -		 */
> -		if (csr_read(CSR_MCACHE_CTL) & MCACHE_CTL_DC_COHEN) {
> -			/* Wait for DC_COHSTA bit to be set */
> -			while (!(csr_read(CSR_MCACHE_CTL) & MCACHE_CTL_DC_COHSTA));
> +		if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) {
> +			/*
> +			 * Check mcache_ctl.DC_COHEN, we assume this platform does
> +			 * not support CM if the bit is hard-wired to 0.
> +			 */
> +			if (csr_read(CSR_MCACHE_CTL) & MCACHE_CTL_DC_COHEN) {
> +				/* Wait for DC_COHSTA bit to be set */
> +				while (!(csr_read(CSR_MCACHE_CTL) & MCACHE_CTL_DC_COHSTA));
> +			}
>  		}
>  	}
>  }
> diff --git a/board/AndesTech/ae350/ae350.c b/board/AndesTech/ae350/ae350.c
> index 772c6bf1ee..bef9e3149e 100644
> --- a/board/AndesTech/ae350/ae350.c
> +++ b/board/AndesTech/ae350/ae350.c
> @@ -102,7 +102,8 @@ void *board_fdt_blob_setup(int *err)
>  void spl_board_init()
>  {
>  	/* enable v5l2 cache */
> -	enable_caches();
> +	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
> +		enable_caches();
>  }
>  #endif
>  
> -- 
> 2.34.1
> 

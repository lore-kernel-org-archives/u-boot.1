Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDA9C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 07:42:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42A4D87646;
	Tue, 26 Dec 2023 08:42:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A98C187687; Tue, 26 Dec 2023 08:42:27 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7755C87032
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 08:42:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peterlin@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3BQ7gJHv018680
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 15:42:19 +0800 (+08)
 (envelope-from peterlin@andestech.com)
Received: from APC323 (10.0.12.98) by ATCPCS16.andestech.com (10.0.1.222) with
 Microsoft SMTP Server id 14.3.498.0; Tue, 26 Dec 2023 15:42:16 +0800
Date: Tue, 26 Dec 2023 15:42:16 +0800
From: Yu-Chien Peter Lin <peterlin@andestech.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>
CC: <u-boot@lists.denx.de>, <randolph@andestech.com>
Subject: Re: [PATCH v2 3/6] andes: cpu: Enable memboost feature
Message-ID: <ZYqD2J4XWRHslKcT@APC323>
References: <20231226061736.482416-1-ycliang@andestech.com>
 <20231226061736.482416-3-ycliang@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231226061736.482416-3-ycliang@andestech.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Originating-IP: [10.0.12.98]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3BQ7gJHv018680
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

On Tue, Dec 26, 2023 at 02:17:34PM +0800, Leo Yu-Chi Liang wrote:
> Andes CPU has memboost feature including prefetch,
> write-around and non-blocking load. Enable them by default.
> 
> Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>

Reviewed-by: Yu Chien Peter Lin <peterlin@andestech.com>

> ---
>  arch/riscv/cpu/andesv5/cpu.c            | 9 ++++++++-
>  arch/riscv/include/asm/arch-andes/csr.h | 6 ++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/cpu/andesv5/cpu.c b/arch/riscv/cpu/andesv5/cpu.c
> index e764f6c5c0..a23b7948d9 100644
> --- a/arch/riscv/cpu/andesv5/cpu.c
> +++ b/arch/riscv/cpu/andesv5/cpu.c
> @@ -31,8 +31,11 @@ void harts_early_init(void)
>  	/* Enable I/D-cache in SPL */
>  	if (CONFIG_IS_ENABLED(RISCV_MMODE)) {
>  		unsigned long mcache_ctl_val = csr_read(CSR_MCACHE_CTL);
> +		unsigned long mmisc_ctl_val = csr_read(CSR_MMISC_CTL);
>  
> -		mcache_ctl_val |= MCACHE_CTL_CCTL_SUEN;
> +		mcache_ctl_val |= (MCACHE_CTL_CCTL_SUEN | \
> +				MCACHE_CTL_IC_PREFETCH_EN | MCACHE_CTL_DC_PREFETCH_EN | \
> +				MCACHE_CTL_DC_WAROUND_EN | MCACHE_CTL_L2C_WAROUND_EN);
>  
>  		if (!CONFIG_IS_ENABLED(SYS_ICACHE_OFF))
>  			mcache_ctl_val |= MCACHE_CTL_IC_EN;
> @@ -52,5 +55,9 @@ void harts_early_init(void)
>  				while (!(csr_read(CSR_MCACHE_CTL) & MCACHE_CTL_DC_COHSTA));
>  			}
>  		}
> +
> +		mmisc_ctl_val |= MMISC_CTL_NON_BLOCKING_EN;
> +
> +		csr_write(CSR_MMISC_CTL, mmisc_ctl_val);
>  	}
>  }
> diff --git a/arch/riscv/include/asm/arch-andes/csr.h b/arch/riscv/include/asm/arch-andes/csr.h
> index 12d5eb6f6c..3f3f05b348 100644
> --- a/arch/riscv/include/asm/arch-andes/csr.h
> +++ b/arch/riscv/include/asm/arch-andes/csr.h
> @@ -19,9 +19,15 @@
>  #define MCACHE_CTL_IC_EN		BIT(0)
>  #define MCACHE_CTL_DC_EN		BIT(1)
>  #define MCACHE_CTL_CCTL_SUEN		BIT(8)
> +#define MCACHE_CTL_IC_PREFETCH_EN	BIT(9)
> +#define MCACHE_CTL_DC_PREFETCH_EN	BIT(10)
> +#define MCACHE_CTL_DC_WAROUND_EN	BIT(13)
> +#define MCACHE_CTL_L2C_WAROUND_EN	BIT(15)
>  #define MCACHE_CTL_DC_COHEN		BIT(19)
>  #define MCACHE_CTL_DC_COHSTA		BIT(20)
>  
> +/* mmisc_ctl register */
> +#define MMISC_CTL_NON_BLOCKING_EN	BIT(8)
>  
>  #define CCTL_L1D_WBINVAL_ALL 6
>  
> -- 
> 2.34.1
> 

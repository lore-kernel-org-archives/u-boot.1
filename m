Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851B6C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 07:33:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A15586FCE;
	Tue, 26 Dec 2023 08:33:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8AB38715C; Tue, 26 Dec 2023 08:33:18 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 956FF86F56
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 08:33:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peterlin@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3BQ7X7iU014028
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 15:33:07 +0800 (+08)
 (envelope-from peterlin@andestech.com)
Received: from APC323 (10.0.12.98) by ATCPCS16.andestech.com (10.0.1.222) with
 Microsoft SMTP Server id 14.3.498.0; Tue, 26 Dec 2023 15:33:05 +0800
Date: Tue, 26 Dec 2023 15:33:02 +0800
From: Yu-Chien Peter Lin <peterlin@andestech.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>
CC: <u-boot@lists.denx.de>, <randolph@andestech.com>
Subject: Re: [PATCH v2 1/6] andes: csr.h: Clean up CSR definition
Message-ID: <ZYqBo-51BudcSvJD@APC323>
References: <20231226061736.482416-1-ycliang@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231226061736.482416-1-ycliang@andestech.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Originating-IP: [10.0.12.98]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3BQ7X7iU014028
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

On Tue, Dec 26, 2023 at 02:17:32PM +0800, Leo Yu-Chi Liang wrote:
> Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>

Reviewed-by: Yu Chien Peter Lin <peterlin@andestech.com>

>  arch/riscv/include/asm/arch-andes/csr.h | 20 ++++++++------------
>  arch/riscv/include/asm/csr.h            |  1 +
>  2 files changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/arch-andes/csr.h b/arch/riscv/include/asm/arch-andes/csr.h
> index 393d51c6dd..12d5eb6f6c 100644
> --- a/arch/riscv/include/asm/arch-andes/csr.h
> +++ b/arch/riscv/include/asm/arch-andes/csr.h
> @@ -12,20 +12,16 @@
>  
>  #define CSR_MCACHE_CTL 0x7ca
>  #define CSR_MMISC_CTL 0x7d0
> -#define CSR_MARCHID 0xf12
>  #define CSR_MCCTLCOMMAND 0x7cc
>  
> -#define MCACHE_CTL_IC_EN_OFFSET 0
> -#define MCACHE_CTL_DC_EN_OFFSET 1
> -#define MCACHE_CTL_CCTL_SUEN_OFFSET 8
> -#define MCACHE_CTL_DC_COHEN_OFFSET 19
> -#define MCACHE_CTL_DC_COHSTA_OFFSET 20
> -
> -#define MCACHE_CTL_IC_EN BIT(MCACHE_CTL_IC_EN_OFFSET)
> -#define MCACHE_CTL_DC_EN BIT(MCACHE_CTL_DC_EN_OFFSET)
> -#define MCACHE_CTL_CCTL_SUEN BIT(MCACHE_CTL_CCTL_SUEN_OFFSET)
> -#define MCACHE_CTL_DC_COHEN BIT(MCACHE_CTL_DC_COHEN_OFFSET)
> -#define MCACHE_CTL_DC_COHSTA BIT(MCACHE_CTL_DC_COHSTA_OFFSET)
> +/* mcache_ctl register */
> +
> +#define MCACHE_CTL_IC_EN		BIT(0)
> +#define MCACHE_CTL_DC_EN		BIT(1)
> +#define MCACHE_CTL_CCTL_SUEN		BIT(8)
> +#define MCACHE_CTL_DC_COHEN		BIT(19)
> +#define MCACHE_CTL_DC_COHSTA		BIT(20)
> +
>  
>  #define CCTL_L1D_WBINVAL_ALL 6
>  
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 1a15089cae..986f951c31 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -142,6 +142,7 @@
>  #define CSR_CYCLEH		0xc80
>  #define CSR_TIMEH		0xc81
>  #define CSR_INSTRETH		0xc82
> +#define CSR_MARCHID		0xf12
>  #define CSR_MHARTID		0xf14
>  
>  #ifndef __ASSEMBLY__
> -- 
> 2.34.1
> 

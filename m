Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEF5C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 07:44:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A776686FCE;
	Tue, 26 Dec 2023 08:44:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3051D87032; Tue, 26 Dec 2023 08:44:31 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA506807A7
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 08:44:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peterlin@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3BQ7iLc7019731
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 15:44:21 +0800 (+08)
 (envelope-from peterlin@andestech.com)
Received: from APC323 (10.0.12.98) by ATCPCS16.andestech.com (10.0.1.222) with
 Microsoft SMTP Server id 14.3.498.0; Tue, 26 Dec 2023 15:44:18 +0800
Date: Tue, 26 Dec 2023 15:44:18 +0800
From: Yu-Chien Peter Lin <peterlin@andestech.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>
CC: <u-boot@lists.denx.de>, <randolph@andestech.com>
Subject: Re: [PATCH v2 5/6] andes: ae350: Save cpu name to env
Message-ID: <ZYqEUnDfTRkwNWfv@APC323>
References: <20231226065427.1130286-1-ycliang@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231226065427.1130286-1-ycliang@andestech.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Originating-IP: [10.0.12.98]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3BQ7iLc7019731
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

On Tue, Dec 26, 2023 at 02:54:27PM +0800, Leo Yu-Chi Liang wrote:
> Detect CPU name through marchid and then save it to env.
> 
> Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>

Reviewed-by: Yu Chien Peter Lin <peterlin@andestech.com>

> ---
>  board/AndesTech/ae350/ae350.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/board/AndesTech/ae350/ae350.c b/board/AndesTech/ae350/ae350.c
> index bef9e3149e..4e53fee5d2 100644
> --- a/board/AndesTech/ae350/ae350.c
> +++ b/board/AndesTech/ae350/ae350.c
> @@ -13,7 +13,9 @@
>  #if defined(CONFIG_FTMAC100) && !defined(CONFIG_DM_ETH)
>  #include <netdev.h>
>  #endif
> +#include <asm/csr.h>
>  #include <asm/global_data.h>
> +#include <asm/sbi.h>
>  #include <linux/io.h>
>  #include <faraday/ftsmc020.h>
>  #include <fdtdec.h>
> @@ -27,6 +29,27 @@ DECLARE_GLOBAL_DATA_PTR;
>  /*
>   * Miscellaneous platform dependent initializations
>   */
> +#if IS_ENABLED(CONFIG_MISC_INIT_R)
> +int misc_init_r(void)
> +{
> +    long csr_marchid = 0;
> +    const long mask_64 = 0x8000;
> +    const long mask_cpu = 0xff;
> +    char cpu_name[10] = {};
> +
> +#if CONFIG_IS_ENABLED(RISCV_SMODE)
> +    sbi_get_marchid(&csr_marchid);
> +#elif CONFIG_IS_ENABLED(RISCV_MMODE)
> +    csr_marchid = csr_read(CSR_MARCHID);
> +#endif
> +    if (mask_64 & csr_marchid)
> +        snprintf(cpu_name, sizeof(cpu_name), "ax%lx", (mask_cpu & csr_marchid));
> +    else
> +        snprintf(cpu_name, sizeof(cpu_name), "a%lx", (mask_cpu & csr_marchid));
> +
> +    return env_set("cpu", cpu_name);
> +}
> +#endif
>  
>  #if CONFIG_IS_ENABLED(LOAD_FIT) || CONFIG_IS_ENABLED(LOAD_FIT_FULL)
>  #define ANDES_SPL_FDT_ADDR	(CONFIG_TEXT_BASE - 0x100000)
> -- 
> 2.34.1
> 

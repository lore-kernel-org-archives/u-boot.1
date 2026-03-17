Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB441F3381E
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 09:07:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BBFE84172;
	Tue, 17 Mar 2026 10:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D992E8418A; Tue, 17 Mar 2026 10:07:20 +0100 (CET)
Received: from Atcsqr.andestech.com (unknown [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E417D84159
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 10:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 62H96wOl066148;
 Tue, 17 Mar 2026 17:06:58 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Mar
 2026 17:06:58 +0800
Date: Tue, 17 Mar 2026 17:06:55 +0800
From: Leo Liang <ycliang@andestech.com>
To: Uros Stajic <uros.stajic@htecgroup.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>, <trini@konsulko.com>
Subject: Re: [PATCH v5 7/8] libfdt: Allow non-64b aligned memreserve entries
Message-ID: <abkZr1hBcosqgBZd@swlinux02>
References: <20251224154449.946780-1-uros.stajic@htecgroup.com>
 <20251224154449.946780-8-uros.stajic@htecgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251224154449.946780-8-uros.stajic@htecgroup.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 62H96wOl066148
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

Hi Uros,

On Wed, Dec 24, 2025 at 03:47:17PM +0000, Uros Stajic wrote:
> From: Chao-ying Fu <cfu@mips.com>
> 
> Although memreserve entries in an FDT are 64-bit aligned relative to the
> start of the FDT, we cannot guarantee that the FDT itself is 64-bit aligned
> in memory. This is especially common when using a FIT image, where the
> alignment of the embedded DTB cannot be controlled.
> 
> On systems that do not support unaligned 64-bit memory accesses, this leads
> to faults when accessing the memreserve section before the FDT is relocated.
> To resolve this, copy the 64-bit values into suitably aligned on-stack
> variables before accessing them.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
> ---
>  scripts/dtc/libfdt/fdt_ro.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/dtc/libfdt/fdt_ro.c b/scripts/dtc/libfdt/fdt_ro.c
> index d65656aaa8b..1c18aea66ab 100644
> --- a/scripts/dtc/libfdt/fdt_ro.c
> +++ b/scripts/dtc/libfdt/fdt_ro.c
> @@ -174,6 +174,7 @@ static const struct fdt_reserve_entry *fdt_mem_rsv(const void *fdt, int n)
>  
>  int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *address, uint64_t *size)
>  {
> +	uint64_t u64;
>  	const struct fdt_reserve_entry *re;
>  
>  	FDT_RO_PROBE(fdt);
> @@ -181,8 +182,10 @@ int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *address, uint64_t *size)
>  	if (fdt_chk_extra() && !re)
>  		return -FDT_ERR_BADOFFSET;
>  
> -	*address = fdt64_to_cpu(re->address);
> -	*size = fdt64_to_cpu(re->size);
> +	memcpy(&u64, &re->address, sizeof(u64));
> +	*address = fdt64_to_cpu(u64);
> +	memcpy(&u64, &re->size, sizeof(u64));
> +	*size = fdt64_to_cpu(u64);

There are API for unaligned access: fdt64_ld().

>  	return 0;
>  }
>  
> @@ -190,9 +193,11 @@ int fdt_num_mem_rsv(const void *fdt)
>  {
>  	int i;
>  	const struct fdt_reserve_entry *re;
> +	uint64_t u64;
>  
>  	for (i = 0; (re = fdt_mem_rsv(fdt, i)) != NULL; i++) {
> -		if (fdt64_to_cpu(re->size) == 0)
> +		memcpy(&u64, &re->size, sizeof(u64));
> +		if (fdt64_to_cpu(u64) == 0)

Ditto.

>  			return i;
>  	}
>  	return -FDT_ERR_TRUNCATED;


But other than that, this issue seemed to be discussed before
and decided to use API that does not support unaligned access.
https://github.com/dgibson/dtc/commit/a7c40409934971ac1bd934ccc411bc6932b86564

Hi Tom,

Should we accept this patch in u-boot?

Best regards,
Leo

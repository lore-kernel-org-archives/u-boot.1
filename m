Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4993ECA0FED
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 19:00:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DABF83903;
	Fri,  5 Sep 2025 21:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xEEckskR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85B1783906; Fri,  5 Sep 2025 21:00:45 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01331838F3
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 21:00:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 585J0fmH3385206;
 Fri, 5 Sep 2025 14:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757098841;
 bh=sV2uFZIglWuEMzLT9tHnfGyQVgdtlx2fgBS18+sDuOk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=xEEckskRFA1UDdF7JAboNbddNyMeQnEcPE1ZkZCqUKRsXRddHdB2MFxbrhSk9Wwnd
 AOiASZGLwM3KgLvEovXJh0DkuTZhLn2xQinkpy8nmoPHYW4Mc9vBus3tKgUZeoYLE4
 bbkIwyjTOyJvTW5OjQgfld4Ynrp5fa0cEHQjmstM=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 585J0eXh562134
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 5 Sep 2025 14:00:41 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 14:00:40 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 14:00:40 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 585J0dQj888497;
 Fri, 5 Sep 2025 14:00:40 -0500
Date: Sat, 6 Sep 2025 00:30:38 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <trini@konsulko.com>
Subject: Re: [PATCH v1] mach-k3: fix reading size and addr from fdt on R5
Message-ID: <20250905190038.vmttonz6lcv7icsr@lcpd911>
References: <20250903111704.530700-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250903111704.530700-1-anshuld@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Sep 03, 2025 at 16:47:02 +0530, Anshul Dalal wrote:
> fdtdec_get_addr_size uses architecture dependent datatypes which causes
> the 32-bit R5 to fail when reading the 64-bit size and addr fields of
> reg nodes from the fdt.
> 
> Therefore change it to a common api for both 64 and 32 bit platforms to
> allow for fdt fixups from R5.
> 
> Fixes: 8b0fc29de0e3 ("arm: mach-k3: am62: Fixup TF-A/OP-TEE reserved-memory node in FDT")
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  arch/arm/mach-k3/common_fdt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-k3/common_fdt.c b/arch/arm/mach-k3/common_fdt.c
> index 2777354c6ab..1e6786f6c20 100644
> --- a/arch/arm/mach-k3/common_fdt.c
> +++ b/arch/arm/mach-k3/common_fdt.c
> @@ -140,7 +140,9 @@ int fdt_fixup_reserved(void *blob, const char *name,
>  			return -EINVAL;
>  		if (!strncmp(node_name, name, strlen(name))) {
>  			/* Read out old size first */
> -			addr = fdtdec_get_addr_size(blob, subnode, "reg", &size);
> +			addr = fdtdec_get_addr_size_auto_parent(
> +				blob, nodeoffset, subnode, "reg", 0, &size,
> +				false);

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

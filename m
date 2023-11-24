Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDFFC61DF4
	for <u-boot@archiver.kernel.org>; Fri, 24 Nov 2023 12:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B198C871C7;
	Fri, 24 Nov 2023 13:09:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700827766;
	bh=Zl2pRw3WflG4q1rgs/enaJiOSEuh2NrfmRXbDW8LFUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=befI5SrTeHF1aOHH569jC+39OU1vap3rRP3BWECIa1g3+FgJoTo/f5sHN9fmtHZgD
	 kH1sCOT1idCR+6fPglr8qQs+GKUoNkPR9NDCB5KImqpgsMZeiXMk/dg4AEOdLH5xMn
	 ZDBIWdxcG743YlFCKaT2qJKENX0tUWC+XemXoFTY+IFQQSd5vVDP+UJ4YwEthv8X5i
	 +Awqquv9SeE1qE4YP7RN3grzC/KvjXiL5OSBODgnBQIlVZ48HUCqDwRu33w0y4rUTp
	 8MTlwg7ZVUVlrKRNVg9BnnDoEC8AYllcjJXwfbRyrz6pIl/pcHBgMuUCOItIN7VEp3
	 9O+SfHSi7x/Cg==
Received: from eryximachos (unknown
 [IPv6:2a01:cb18:989:a700:90fa:3f82:fe6a:48f9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 300788711D;
 Fri, 24 Nov 2023 13:09:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1700827764;
 bh=Zl2pRw3WflG4q1rgs/enaJiOSEuh2NrfmRXbDW8LFUo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MMB3kWhX0bg0U/VqxvhtcyYafJAcd5tk08WufTTMIM79PDy+695MgdLmmVL54Ql3J
 juu5PH1bKo74EmoMXJ8LFWV5rzVGSPN6FRyE8q5LqDx/Px8tklo/U6R2eOlE3aKOw5
 jWY2WM4Al6FKdBbgwZxo5UptGrbes7IXpOQPg+8qY/fZrISVJXi1KXUYw03i5SXQIl
 79hnvQ2oaAQ8tOot0MPj+atIpdvZKATmvgBOWmieqxmkL8Rzf0FyLTyowmfBApdeWu
 T3NCccUKok9RQmaQxXnZqvsCKGwI3G/5cwtYTULW2uGGRQ9iqI2FbCCXIMHOS2vGnE
 Dos0r5J+gLWGA==
Date: Fri, 24 Nov 2023 13:09:22 +0100
From: Philip Oberfichtner <pro@denx.de>
To: Moritz Fischer <moritzf@google.com>
Cc: sjg@chromium.org, u-boot@lists.denx.de, bmeng.cn@gmail.com,
 marex@denx.de, xypron.glpk@gmx.de, stcarlso@linux.microsoft.com
Subject: Re: [PATCH] pci: Enable dm_pci_map_bar() for 64-bit BARs
Message-ID: <ZWCScp6HHX9gj9Ow@eryximachos>
References: <20231124101520.1077082-1-moritzf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124101520.1077082-1-moritzf@google.com>
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

Hi,

On Fri, Nov 24, 2023 at 10:15:20AM +0000, Moritz Fischer wrote:
> Allow dm_pci_map_bar() usage on systems with CONFIG_PCI_SYS_64BIT.
<snip>
>  
> +	/*
> +	 * This assumes that dm_pciauto_setup_device() will allocate
> +	 * a 64-bit address if CONFIG_SYS_PCI_64BIT is enabled and
> +	 * the device advertises that it supports it.
> +	 */

This patch is also useful if the previous bootstage, e.g. coreboot,
allocated a 64-bit address. In fact I recently did something very
similar (downstream), so

Reviewed-by: Philip Oberfichtner <pro@denx.de>


-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-22  Fax: +49-8142-66989-80   Email: pro@denx.de
=====================================================================

> +	if (IS_ENABLED(CONFIG_SYS_PCI_64BIT) &&
> +	    (bar_response & PCI_BASE_ADDRESS_MEM_TYPE_64)) {
> +		dm_pci_read_config32(udev, bar + 4, &bar_response);
> +		pci_bus_addr |= (pci_addr_t)bar_response << 32;
> +	}
> +
>  	if (~((pci_addr_t)0) - pci_bus_addr < offset)
>  		return NULL;
>  
> diff --git a/include/pci.h b/include/pci.h
> index 2f5eb30b83..0d1ac7b015 100644
> --- a/include/pci.h
> +++ b/include/pci.h
> @@ -1350,8 +1350,8 @@ pci_addr_t dm_pci_phys_to_bus(struct udevice *dev, phys_addr_t addr, size_t len,
>   *
>   * Looks up a base address register and finds the physical memory address
>   * that corresponds to it.
> - * Can be used for 32b BARs 0-5 on type 0 functions and for 32b BARs 0-1 on
> - * type 1 functions.
> + * Can be used for 32b/64b BARs 0-5 on type 0 functions and for 32b BARs 0-1
> + * on type 1 functions.
>   * Can also be used on type 0 functions that support Enhanced Allocation for
>   * 32b/64b BARs.  Note that duplicate BEI entries are not supported.
>   *
> -- 
> 2.43.0.rc1.413.gea7ed67945-goog
> 

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA04C7EE31
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 12:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A631182E35;
	Fri, 27 Jun 2025 14:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="TjLB+qcM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C763982E9A; Fri, 27 Jun 2025 14:23:41 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 112C082E27
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 14:23:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id B8E9926080;
 Fri, 27 Jun 2025 14:23:37 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZOqpAKE3f6jq; Fri, 27 Jun 2025 14:23:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1751027016; bh=1SHGLwz2J0E6OOeaSp7hD1LUq8lAlURn3aYkVK6XG7s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=TjLB+qcM9Q9zmzqFS5juzo0+th2w5tUZORlu4+dAF7Y+nRWTd/zc4mcpTke7Xa+4P
 bbQRFwOThRei3kowqnimxLwTHUugWzlFPBaNKDjMpXGoyVPetkaecz5rl9eoGfwtrF
 mcpaSWk63u9fO5fCrfgQHXzQ1u9I0J1wg9Rt5d4VijJdiZhuHEihazhQMq/maEJpz/
 3+uahvkRqMy5bKhxfLO/uADxVu91jmd6UoqEGvlGm9b/eSoNMpBWtUjk1yftj5qsq1
 vlaBCXE1i3GHVnYZYXaouiTLY6dt1MlaPRrC+uUVde64DNDs31dWuj8F/yhS+nmGlS
 WB4zIa37nAHwQ==
Date: Fri, 27 Jun 2025 12:23:31 +0000
From: Yao Zi <ziyao@disroot.org>
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] boot: Ensure that ranges is not used uninitialised
Message-ID: <aF6NQ2zt5qKS0UsD@pie>
References: <20250627-boot_fdt_fix-v1-1-d2e0c4b13762@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627-boot_fdt_fix-v1-1-d2e0c4b13762@linaro.org>
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

On Fri, Jun 27, 2025 at 12:51:02PM +0100, Andrew Goodbody wrote:
> The local variable ranges may be used uninitialised if the function
> fdt_get_dma_range is called with node < 0. Ensure this does not
> happen by initialising ranges when declared.

It doesn't harm. When node < 0, parent is less than zero as well, and
the first while loop is skipped. The control flow just fails into the
error path where parent < 0 stays true.

Furthermore, it doesn't seem valid to call fdt_get_dma_range() with a
negative node parameter, does it?

> /**
>  * fdt_get_dma_range() - get DMA ranges to perform bus/cpu translations
>  *
>  * @blob: pointer to device tree blob
>  * @node_offset: node DT offset
>  * @cpu: pointer to variable storing the range's cpu address
>  * @bus: pointer to variable storing the range's bus address
>  * @size: pointer to variable storing the range's size
>  *
>  * Get DMA ranges for a specifc node, this is useful to perform bus->cpu and
>  * cpu->bus address translations
>  *
>  * Return: translated DMA address or OF_BAD_ADDR on error
>  */
> int fdt_get_dma_range(const void *blob, int node_offset, phys_addr_t *cpu,
>                       dma_addr_t *bus, u64 *size);

Regards,
Yao Zi

> This issue was found with Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  boot/fdt_support.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 92f2f534ee0..4f63ce9a763 100644
> --- a/boot/fdt_support.c
> +++ b/boot/fdt_support.c
> @@ -1547,7 +1547,7 @@ int fdt_get_dma_range(const void *blob, int node, phys_addr_t *cpu,
>  {
>  	bool found_dma_ranges = false;
>  	struct of_bus *bus_node;
> -	const fdt32_t *ranges;
> +	const fdt32_t *ranges = NULL;
>  	int na, ns, pna, pns;
>  	int parent = node;
>  	int ret = 0;
> 
> ---
> base-commit: 359e3012921f2fc2d43f3c4e320a752173f82b82
> change-id: 20250627-boot_fdt_fix-e4e56d956c8a
> 
> Best regards,
> -- 
> Andrew Goodbody <andrew.goodbody@linaro.org>
> 

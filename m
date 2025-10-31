Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20108CCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 14:40:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8309A838FA;
	Fri, 31 Oct 2025 15:40:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="x1TIKFkj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C1C58391E; Fri, 31 Oct 2025 15:40:06 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71D27838E5
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 15:40:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cykCh5W0gz9skH;
 Fri, 31 Oct 2025 15:40:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761921600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tuqrFVt+kgfHSN2Fp1e2DdOpdfO0iTMg7iSCwuBx5po=;
 b=x1TIKFkjQZ2vLMPM1EOJrpGgBDEWakKdkEV6wA6PM/vc6RNLJsAP/9Mi7Qm2Tq+iPiUDBN
 PFJs4AYfjlmUdAUvY7dkUYV0mE4k1Hi6crIvhPteehLNj4c4eA2NNqe77wUJzgk5fUM6VO
 h4TAN1ZBznkLKMuiveP5tWh7QcG5X4xiEfCLaGbCc3pyfeUCrscSZEawSj5GHiu1Wv18pT
 p0LJyV0oEYfZu+rfy9WFxohgcaiozLAbKoTSt5TRAIiHomijpUvYHknRRYy8aO4dPrarh1
 +hA2f9MFv/Eh7C3oW39agC7BHKGAI8OlQsdv1/rlYflKToy3McltqzDtOULfRg==
Message-ID: <8b1698b9-5ca3-4372-a866-8ce0a6384142@mailbox.org>
Date: Fri, 31 Oct 2025 15:39:57 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v1] arm64: imx8ulp: Split SRAM0 mapping to isolate the
 SCMI shared memory as non-cacheable
To: alice.guo@oss.nxp.com, u-boot@lists.denx.de, uboot-imx@nxp.com,
 sbabic@nabladev.com, festevam@gmail.com, trini@konsulko.com
Cc: davidzangcs@gmail.com, sjg@chromium.org, ye.li@nxp.com, peng.fan@nxp.com, 
 alice.guo@nxp.com
References: <20251031074902.2066064-1-alice.guo@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251031074902.2066064-1-alice.guo@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b46f8a92be9f0e31c7f
X-MBO-RS-META: 764yci88rty4uccybdej4iy64qadrb4d
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

On 10/31/25 8:49 AM, alice.guo@oss.nxp.com wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> This patch splits the 2MB SRAM0 mapping into three regions:
> - 0x22000000~0x2201f000: cacheable normal memory
> - 0x2201f000~0x22020000: non-cacheable device memory
> - 0x22020000~0x22200000: cacheable normal memory
> 
> The change ensures the SCMI shared memory is non-cacheable, which
> avoids cache-related issues after removing
> mmu_set_region_dcache_behaviour() from scmi_dt_get_smt_buffer().
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>   arch/arm/mach-imx/imx8ulp/soc.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/imx8ulp/soc.c b/arch/arm/mach-imx/imx8ulp/soc.c
> index 04c6f064130..6cb6b0e7429 100644
> --- a/arch/arm/mach-imx/imx8ulp/soc.c
> +++ b/arch/arm/mach-imx/imx8ulp/soc.c
> @@ -384,7 +384,21 @@ static struct mm_region imx8ulp_arm64_mem_map[] = {
>   		/* SRAM0 (align with 2M) */
>   		.virt = 0x22000000UL,
>   		.phys = 0x22000000UL,
> -		.size = 0x200000UL,
> +		.size = 0x1f000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +			 PTE_BLOCK_OUTER_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {

Please add a comment that this is used for mailboxes and must be 
non-cacheable here.

> +		.virt = 0x2201f000UL,
> +		.phys = 0x2201f000UL,
> +		.size = 0x1000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

Thanks !

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E7BC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 19:26:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64D41882BC;
	Fri, 26 Apr 2024 21:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="RHnAzX3k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69058882B0; Fri, 26 Apr 2024 21:26:48 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1B7E882BC
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 21:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1714159605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eqFcNJjSmZHA3QHUJKO0+PpENKz8RoZ8UxhiCfYdZ10=;
 b=RHnAzX3k5azXK8LeSOavys66iekkDvWqD1w5j8AygOBi4hqJuYKjIjBXaEStocjqmty2Mm
 2C5roMo26QUuJgIdOaRFPatTheL3AmncID+2zwuFgA/xKREFlwDE6vts345n6wtwyB+jJ2
 vSW77vIWMjXPjVbEL5MJlIIyJHQAEXw56uhiWoqqS9Fs64j76jssRSMEpuMgf4KFkXHkYG
 r6U7lTFIEsVZGrXZTgVCLR4uLk69ruYKzCAJfE0CA61rvkhNPioizrPiDJwXXGKWERUycd
 pUjKydc1WxOXF4gwgKgrAbM/kkEBjsajtlb/ieh5Bf/KRsZxHkeRu1RBwLibmg==
Date: Fri, 26 Apr 2024 21:26:43 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de, Marek Vasut
 <marex@denx.de>
Subject: Re: [PATCH] venice: show emmc boot hardware partition
In-Reply-To: <20240426165554.1376497-1-tharvey@gateworks.com>
References: <20240426165554.1376497-1-tharvey@gateworks.com>
Message-ID: <cf40b1dd10eb915984717a9ae2247003@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Tim,

Please see my comments below.

On 2024-04-26 18:55, Tim Harvey wrote:
> To aid in understanding what emmc hardware partition is being
> used to boot on power-up, display the hardware partition name in the
> SPL.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  board/gateworks/venice/spl.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/board/gateworks/venice/spl.c 
> b/board/gateworks/venice/spl.c
> index 3b0f11f2fd0f..531bad260b6d 100644
> --- a/board/gateworks/venice/spl.c
> +++ b/board/gateworks/venice/spl.c
> @@ -366,9 +366,25 @@ unsigned long
> board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc, unsigned long
> 
>  const char *spl_board_loader_name(u32 boot_device)
>  {
> +	struct mmc *mmc;
> +	int part;
> +
>  	switch (boot_device) {
>  	/* SDHC2 */
>  	case BOOT_DEVICE_MMC1:
> +		mmc_init_device(0);
> +		mmc = find_mmc_device(0);
> +		mmc_init(mmc);
> +		part = EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config);
> +		switch (part) {
> +		case 1:
> +			return "eMMC boot0";
> +		case 2:
> +			return "eMMC boot1";
> +		case 0:
> +		case 7:
> +			return "eMMC user";
> +		}
>  		return "eMMC";
>  	/* SDHC3 */
>  	case BOOT_DEVICE_MMC2:

Your other patch on the mailing list does something similar. [1]
Perhaps this is a good oportunity to extract and unify the logic
that produces the names of eMMC partitions?  That would also allow
other boards to use the same logic.

[1] 
https://lore.kernel.org/u-boot/a1e9206f-0cbf-44b2-a5e7-351f77c0d2b5@denx.de/T/#u

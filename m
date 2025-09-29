Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F767CAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 07:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E1B28206E;
	Mon, 29 Sep 2025 09:33:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CXccsdxD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C38682A9E; Mon, 29 Sep 2025 09:33:52 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C73CC808AF
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 09:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2E41842BAA;
 Mon, 29 Sep 2025 07:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BBFC4CEF4;
 Mon, 29 Sep 2025 07:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759131223;
 bh=HI7tSvgsfyTWW6WoyzLufFwOogKp3pkLBtA/GFWRL7k=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=CXccsdxDtfrA3rAFwCFOQl93/KpTSrTfBUWi8Wcnew/jT/LeteW0pupYTSBmNa3nW
 q2WJVDNuk/3nJxbX4bxoPH2g8DY/n/MC3/8lcb8IotKQ3GXCXqydfzxGYbzBFyNwlo
 EJHAse7R8n+o7CqtkSf0AVNH7mhVb1RuvO/QuA5/xUG/WN+PnR6zr8RJkDKQu/aFq+
 N/8BoGlrdL1h89EYccaqNYWvJZtKVd9cj3EZVtyE7xDkeMqsUhWCq3EkHPVgnNoqh5
 U8VF9F69dSyoJZrsDGcT0n+j8UInFkox8b8Hg0UZxEQ2cc0ODvo9zPW/NlUUvci2Zw
 fi16+VlonfwZA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Chance Yang <chance.yang@kneron.us>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, morgan.chang@kneron.us, Chance Yang
 <chance.yang@kneron.us>
Subject: Re: [PATCH v2] fastboot: Fix has-slot command always returning yes
 for fb_nand
In-Reply-To: <20250826-master-v2-1-30b787a2f9fd@kneron.us>
References: <20250826-master-v2-1-30b787a2f9fd@kneron.us>
Date: Mon, 29 Sep 2025 09:33:40 +0200
Message-ID: <87h5wlk90r.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Chance,

Thank you for the patch.

On Tue, Aug 26, 2025 at 11:36, Chance Yang <chance.yang@kneron.us> wrote:

> The issue was a mismatch in return value conventions between functions:
> - getvar_get_part_info() expects >= 0 for success
> - fb_nand_lookup() returns 0 on success, 1 on failure (from
> mtdparts_init and find_dev_and_part)
>
> When partition didn't exist, fb_nand_lookup returned 1, but
> fastboot_nand_get_part_info passed it directly to getvar_get_part_info,
> which treated 1 >= 0 as success, causing has-slot to always return yes.
>
> Fix by converting positive return values to -ENOENT in
> fastboot_nand_get_part_info to match the expected error convention.
>
> Signed-off-by: Chance Yang <chance.yang@kneron.us>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
> Changes in v2:
> - cover all the failure paths in fb_nand_lookup()
> - Link to v1: https://lore.kernel.org/r/20250708-master-v1-1-574f8bec645d@kneron.us
> ---
>  drivers/fastboot/fb_nand.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fastboot/fb_nand.c b/drivers/fastboot/fb_nand.c
> index afc64fd5280717ae4041ed70268ccc01cfbb0496..6df3917e129556fef71640ebb1347c5eb86e648a 100644
> --- a/drivers/fastboot/fb_nand.c
> +++ b/drivers/fastboot/fb_nand.c
> @@ -157,8 +157,13 @@ int fastboot_nand_get_part_info(const char *part_name,
>  				struct part_info **part_info, char *response)
>  {
>  	struct mtd_info *mtd = NULL;
> +	int ret;
> +
> +	ret = fb_nand_lookup(part_name, &mtd, part_info, response);
> +	if (ret)
> +		return -ENOENT;
>  
> -	return fb_nand_lookup(part_name, &mtd, part_info, response);
> +	return ret;
>  }
>  
>  /**
>
> ---
> base-commit: d1d53c252a4a746db5ebcdf0d6de3aa0feec504e
> change-id: 20250708-master-b6a53395df05
>
> Best regards,
> -- 
> Chance Yang <chance.yang@kneron.us>

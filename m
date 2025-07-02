Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C9AC83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 10:29:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C55D682103;
	Wed,  2 Jul 2025 12:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="q1vVqNLR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52EED82ADA; Wed,  2 Jul 2025 12:29:22 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B65A80E9A
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 12:29:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id ECC645C553D;
 Wed,  2 Jul 2025 10:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48173C4CEED;
 Wed,  2 Jul 2025 10:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751452158;
 bh=mb6hAGeO/2xHHDiMehZjBW4p1wZ/sGDSLhZdUpGjfec=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=q1vVqNLRULLwPhQb54RJhFeYqosBmk54vwdA5ZY+fJd1hfVWEcEXqVUoYFNb4iPWC
 DvzOvIWFrQkv5ESv3QabfWPbjMMA0zSJb4MXxcwUHUJy1C6sIDPRJIpvlfXdUhAhf1
 hx/qCjITxlfxYr7KjRrK7+4GjmjsClFWzaG8v+432oujGfcQDh4M6yDGX3z7VFq++g
 +Msl9douo5GHaqc2U/l4XrGKa4dISOFGEYTwUvumEFQdGqrIfesncpzdHyRlxR/Rgp
 /ZoBBOCsw7xplUl6ptaMJEpVLF+TAgiQpXXl+gOxu+wYOaydf0/f4G8azhZsWD4y6n
 NiZNwwGpZKudA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH 2/2] common/avb_verify.c: Make use of LBAF for printing
 lbaint_t
In-Reply-To: <20250702010603.19354-2-trini@konsulko.com>
References: <20250702010603.19354-1-trini@konsulko.com>
 <20250702010603.19354-2-trini@konsulko.com>
Date: Wed, 02 Jul 2025 12:29:16 +0200
Message-ID: <87a55mubr7.fsf@kernel.org>
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

Hi Tom,

Thank you for the patch.

On Tue, Jul 01, 2025 at 19:06, Tom Rini <trini@konsulko.com> wrote:

> When printing the contents of an lbaint_t variable we need to use LBAF
> to print it in order to get the correct format type depending on 32 or
> 64bit-ness.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  common/avb_verify.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/common/avb_verify.c b/common/avb_verify.c
> index cff9117d92f1..29a3272579cf 100644
> --- a/common/avb_verify.c
> +++ b/common/avb_verify.c
> @@ -320,7 +320,7 @@ static unsigned long mmc_read_and_flush(struct mmc_part *part,
>  	}
>  	if ((start + sectors) > (part->info.start + part->info.size)) {
>  		sectors = part->info.start + part->info.size - start;
> -		printf("%s: read sector aligned to partition bounds (%ld)\n",
> +		printf("%s: read sector aligned to partition bounds (" LBAF ")\n",
>  		       __func__, sectors);
>  	}
>  
> @@ -363,7 +363,7 @@ static unsigned long mmc_write(struct mmc_part *part, lbaint_t start,
>  	}
>  	if ((start + sectors) > (part->info.start + part->info.size)) {
>  		sectors = part->info.start + part->info.size - start;
> -		printf("%s: sector aligned to partition bounds (%ld)\n",
> +		printf("%s: sector aligned to partition bounds (" LBAF ")\n",
>  		       __func__, sectors);
>  	}
>  	if (unaligned) {
> -- 
> 2.43.0

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3BEC48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 19:38:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3C8287C35;
	Fri,  9 Feb 2024 20:38:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="n9TN+sHs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7631487CC1; Fri,  9 Feb 2024 20:38:02 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 989D987C13
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 20:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707507479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dYld7J3GOlCvFuK0RPMKolci29/KX/R3t+HJH9GeJJc=;
 b=n9TN+sHshPibAFXzGM4QjUTIc0LmhSAr8PLy/YYefVkSG7PKbL4t978ckn9pQ9dRc5Oz62
 Tj8fCsCzOtHL/aKn2dPLpsxbvBkE/F7/Vh+UAijVTB8vIe3HfcvKoQ3tlMXnETQKw9mDLr
 C/cebsB8wEc6bThuloMZxFxXidxirHXRtWw1wNJdGnpnkPR/bF609db+TD+OXvvlqa8zSx
 caN1Fk7JGGX51rasISthKra2fvCvQwyW6QCzomU2UhE/PzwjqbjAMYkGn0oIfTaYT4ljR4
 hsujBiLlTUj8JINsAn/hSTCLg5wgSmAYmfWR7NkBdoaJV0CandaHHiRgCmi2TQ==
Date: Fri, 09 Feb 2024 20:37:59 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ivan Khoronzhuk
 <ivan.khoronzhuk@gmail.com>, Jens Wiklander <jens.wiklander@linaro.org>, Tom
 Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 1/7] common: avb_verify: don't call mmc_switch_part for
 SD
In-Reply-To: <20240209192045.3961832-2-igor.opaniuk@foundries.io>
References: <20240209192045.3961832-1-igor.opaniuk@foundries.io>
 <20240209192045.3961832-2-igor.opaniuk@foundries.io>
Message-ID: <0faf0593b8e3d61f45df359b2576a83a@manjaro.org>
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

On 2024-02-09 20:20, Igor Opaniuk wrote:
> From: Igor Opaniuk <igor.opaniuk@gmail.com>
> 
> mmc_switch_part() is used for switching between hw partitions
> on eMMC (boot0, boot1, user, rpmb).
> There is no need to do that for SD card.
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> 
> Changes in v2:
> - Mattijs Korpershoek R-b tag applied
> 
>  common/avb_verify.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/common/avb_verify.c b/common/avb_verify.c
> index 48ba8db51e5..59f2c25e0de 100644
> --- a/common/avb_verify.c
> +++ b/common/avb_verify.c
> @@ -358,9 +358,11 @@ static struct mmc_part *get_partition(AvbOps
> *ops, const char *partition)
>  		goto err;
>  	}
> 
> -	ret = mmc_switch_part(part->mmc, part_num);
> -	if (ret)
> -		goto err;
> +	if (IS_MMC(part->mmc)) {
> +		ret = mmc_switch_part(part->mmc, part_num);
> +		if (ret)
> +			goto err;
> +	}
> 
>  	mmc_blk = mmc_get_blk_desc(part->mmc);
>  	if (!mmc_blk) {

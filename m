Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D761C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 05:29:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A87AB87EAF;
	Tue, 16 Apr 2024 07:29:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="ASy91YaN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B76487ECC; Tue, 16 Apr 2024 07:29:00 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3522987E95
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 07:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1713245337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J4MSmA2GYciAOeuNhIACcMjW3BenIRtHU6RNvbwJstY=;
 b=ASy91YaNsQuWKuryEjGY0L0yJ9pFEqLwiRnZlvm5eVWImd+ZXcD869oA8JQ8PNbU8reIPF
 hA82vVc60Wf16aazjwGrsPzlQjWCQLTQG1tkmn8GFxkEBeSwbvVwholE3bMIdPBOaGMh65
 2d7FRu55oIwQ+RC0E80W9IkdfgW6gn9+0/qy2zBMf+5PzTqUPeZqXqOrrF0CaC1xjNwZSW
 4DTMWkvaG8udTqDfoVHnOcWuYhg6Q4qA5naMvZOIojqp/DFLTWflgtYtKHsLRACb0XO7A8
 gutmJc/OGRmGxTQyXWPEkSCQCU3B0LvJkSNXQQaA+SWUN+5AADtTWcdb+Nu4PQ==
Date: Tue, 16 Apr 2024 07:28:57 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH] env: mmc: print MMC device being read
In-Reply-To: <20240415-mmc-loadenv-dev-v1-1-4dd649e0c298@theobroma-systems.com>
References: <20240415-mmc-loadenv-dev-v1-1-4dd649e0c298@theobroma-systems.com>
Message-ID: <f26062d931917d0adf3f21036d115a27@manjaro.org>
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

On 2024-04-15 14:43, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> This prints the MMC device being read similar to how we print the MMC
> device we write to when e.g. calling saveenv.
> 
> One of the side effects is that the boot log now shows from which MMC
> device the env was loaded:
> 
> Loading Environment from MMC... Reading from MMC(1)... OK
> 
> This is useful to identify which MMC device the environment was loaded
> from for boards where there are more than one (e.g. eMMC and SD card)
> without adding some debug messages manually.
> 
> Sadly, there's no way to know which of the default or redundant
> environment is being read from env_mmc_load before env_import_redund is
> called so it is printing a bit later (and possibly after error/warning
> messages).
> 
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Looking great to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  env/mmc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/env/mmc.c b/env/mmc.c
> index da84cddd74f..7afb733e890 100644
> --- a/env/mmc.c
> +++ b/env/mmc.c
> @@ -436,6 +436,7 @@ static int env_mmc_load(void)
> 
>  	ret = env_import_redund((char *)tmp_env1, read1_fail, (char 
> *)tmp_env2,
>  				read2_fail, H_EXTERNAL);
> +	printf("Reading from %sMMC(%d)... ", gd->env_valid == ENV_REDUND ?
> "redundant " : "", dev);
> 
>  fini:
>  	fini_mmc_for_env(mmc);
> @@ -475,6 +476,8 @@ static int env_mmc_load(void)
>  		goto fini;
>  	}
> 
> +	printf("Reading from MMC(%d)... ", dev);
> +
>  	ret = env_import(buf, 1, H_EXTERNAL);
>  	if (!ret) {
>  		ep = (env_t *)buf;
> 
> ---
> base-commit: b03b49046af5dfca599d2ce8f0aafed89b97aa91
> change-id: 20240415-mmc-loadenv-dev-ced678171e98
> 
> Best regards,

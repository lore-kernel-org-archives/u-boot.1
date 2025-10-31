Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0027CCF9FE
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 15:18:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23D2883979;
	Fri, 31 Oct 2025 16:18:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="t2BgaJfX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 934D48397A; Fri, 31 Oct 2025 16:18:19 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65E3383952
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 16:18:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id ADF7743CB0;
 Fri, 31 Oct 2025 15:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEF6C4CEE7;
 Fri, 31 Oct 2025 15:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761923895;
 bh=I/FQbMyQnbrU6NB4ZUOzXXE34u3Ar/uLZRLvUwWP04k=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=t2BgaJfXGLXDdbgvANYRenuZzYrtXylD484gfLABi4EpPqExG4TYwKTbCAnjYUgwS
 eNt6IAgRum00m1Zj9rP6Pu+RRfvznNGbzqog+FdcIiTgk2227TfFdd81cy5fmnIQrO
 6nsfnE8Jd1i+yCSschc+zfOhHv4yM2iQdAY0D/Ib77te4LPlWTzhRMd67HDNJoxBBl
 dxwW8PdlYMpt75vOQ/GXMZxk/hKMzvnMX5fLDeyjuS4YV3lYogQnCbA0tDE0vXMXPb
 TRPt9yYdiGqj23OkMHGFIIieoouUBB0Qw84xYGbMXl4W2FeFZdQA7egv9k57qBMd4i
 kEI5eIdAJjddA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>, Julien Masson
 <jmasson@baylibre.com>, "Nicolas Belin (TI.com)" <nbelin@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, george chan
 <gchan9527@gmail.com>, "Guillaume La Roque (TI.com)"
 <glaroque@baylibre.com>
Subject: Re: [PATCH] bootstd: android: add the bootargs env to the commandline
In-Reply-To: <20251024-botargsappend-v1-1-0b78f05f9132@baylibre.com>
References: <20251024-botargsappend-v1-1-0b78f05f9132@baylibre.com>
Date: Fri, 31 Oct 2025 16:18:11 +0100
Message-ID: <87ldkr5ccs.fsf@kernel.org>
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

Hi Guillaume,

Thank you for the patch.

On Fri, Oct 24, 2025 at 16:23, "Guillaume La Roque (TI.com)" <glaroque@baylibre.com> wrote:

> From: "Nicolas Belin (TI.com)" <nbelin@baylibre.com>
>
> When previously using script based bootflows, the U-Boot
> environment variable bootargs was used to customize the kernel
> commandline at boot time.
> In order to get the same behaviour, concatenate the bootflow
> commandline with the contents the bootargs environment variable.
>
> Signed-off-by: Nicolas Belin (TI.com) <nbelin@baylibre.com>
> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  boot/bootmeth_android.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> index 8c2bde10e17..1374551dbeb 100644
> --- a/boot/bootmeth_android.c
> +++ b/boot/bootmeth_android.c
> @@ -512,6 +512,37 @@ static int run_avb_verification(struct bootflow *bflow)
>  }
>  #endif /* AVB_VERIFY */
>  
> +static int append_bootargs_to_cmdline(struct bootflow *bflow)
> +{
> +	char *bootargs;
> +	int len = 0;
> +
> +	/*
> +	 * Check any additionnal bootargs coming from U-Boot env. If any,
> +	 * merge them with the current cmdline
> +	 */
> +	bootargs = env_get("bootargs");
> +	if (bootargs) {
> +		len += strlen(bootargs) + 1; /* Extra space character needed */
> +		len += strlen(bflow->cmdline);
> +
> +		char *newcmdline = malloc(len + 1); /* +1 for the '\0' */
> +
> +		if (!newcmdline)
> +			return log_msg_ret("newcmdline malloc", -ENOMEM);
> +
> +		strcpy(newcmdline, bootargs);
> +		strcat(newcmdline, " ");
> +		strcat(newcmdline, bflow->cmdline);
> +
> +		/* Free the previous cmdline and replace it */
> +		free(bflow->cmdline);
> +		bflow->cmdline = newcmdline;
> +	}
> +
> +	return 0;
> +}
> +
>  static int boot_android_normal(struct bootflow *bflow)
>  {
>  	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
> @@ -546,6 +577,10 @@ static int boot_android_normal(struct bootflow *bflow)
>  	if (priv->slot)
>  		free(priv->slot);
>  
> +	ret = append_bootargs_to_cmdline(bflow);
> +	if (ret < 0)
> +		return log_msg_ret("bootargs append", ret);
> +
>  	ret = bootm_boot_start(loadaddr, bflow->cmdline);
>  
>  	return log_msg_ret("boot", ret);
>
> ---
> base-commit: b10c055d4e1b5153a331a61ef82a5b01b5bb4c45
> change-id: 20251024-botargsappend-38a4371cb6dc
>
> Best regards,
> -- 
> Guillaume La Roque (TI.com) <glaroque@baylibre.com>

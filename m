Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0BFC369C2
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 05:24:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21CEF80F03;
	Mon,  5 May 2025 07:24:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lPIbVKpO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 348D981F66; Mon,  5 May 2025 07:24:08 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28F6380BAE
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 07:24:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 7575FA4C3CA;
 Mon,  5 May 2025 05:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5B7C4CEE4;
 Mon,  5 May 2025 05:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746422644;
 bh=FGjaKpQMxCjYVUVJb7V3xLzVAc1zg2V95rR0NHll/7k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lPIbVKpOn+JfJJh5d1Wd0YKna6exB9J2WxWTJynyUfAKJTjRnPUbdseTl4DNcJtSx
 +gQti3F8tGl1fSUOZyguDXww0Oi8eNcdOXJKvk0PFh2sEfIb4D03J9lvWOAeRieFn2
 ThB3Ybl/3VAu3oHzEfyZ/+qi/+VQRXx0uScj144zOhHZIyYQiVXdWRhtVtNm6Muc3N
 FD1ZesH716FwRUUBrpCVwqyurqyKdDwwO1vsszVsTXgWIbhvSqqhFS/kn/vhH3xZSu
 Iz06DXANc0/mICqJBEIqGWs8dGtq36NAgiF3IoBcdbzhGLG/bIQDPiS0mVbyrtspzj
 E6d6L1NO7WoGg==
Date: Mon, 5 May 2025 10:53:58 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, trini@konsulko.com,
 loic.minier@oss.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH] mach-snapdragon: Update fdtfile logic to work for RB1
 and RB2
Message-ID: <aBhLbqrMxfk2tjtK@sumit-X1>
References: <20250423051132.292329-1-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423051132.292329-1-sumit.garg@kernel.org>
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

On Wed, Apr 23, 2025 at 10:41:32AM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> RB1 and RB2 have three root compatibles where the last one can't be used
> to decode fdtfile name (qcm* vs qrb*). So rather just rely on the first
> compatible to retrieve the SoC name.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/board.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>

Gentle ping for this fix review, I will like to see this landed in
2025.07.

-Sumit

> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index deae4d32378..dc8220e89b4 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -437,16 +437,24 @@ static void configure_env(void)
>  
>  	/* The Qualcomm reference boards (RBx, HDK, etc)  */
>  	if (!strncmp("qcom", buf, strlen("qcom"))) {
> +		char *soc;
> +
>  		/*
>  		 * They all have the first compatible as "qcom,<soc>-<board>"
>  		 * (e.g. "qcom,qrb5165-rb5"). We extract just the part after
>  		 * the dash.
>  		 */
> -		if (!strsep(&tmp, "-")) {
> +		if (!strsep(&tmp, ",")) {
> +			log_warning("compatible '%s' has no ','\n", buf);
> +			return;
> +		}
> +		soc = strsep(&tmp, "-");
> +		if (!soc) {
>  			log_warning("compatible '%s' has no '-'\n", buf);
>  			return;
>  		}
> -		/* tmp is now "rb5" */
> +
> +		env_set("soc", soc);
>  		env_set("board", tmp);
>  	} else {
>  		if (!strsep(&tmp, ",")) {
> -- 
> 2.43.0
> 

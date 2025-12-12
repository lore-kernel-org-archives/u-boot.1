Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04585D4335B
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 01:00:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D534835B3;
	Fri, 12 Dec 2025 02:00:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pMz4G6cv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FC3E8367F; Fri, 12 Dec 2025 02:00:11 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A566F8334F
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 02:00:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B87D760121;
 Fri, 12 Dec 2025 01:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EC9C4CEF7;
 Fri, 12 Dec 2025 01:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765501205;
 bh=fb+XFQzRLwl+4ot5eFYveJFIYSveaXdIKzaecF9KfIA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pMz4G6cv4+p32Tn8OvAjL6Okwe05ZGPZUW5jyqr6qbYW8Ixe8p+ezXtcp1cIWR+dv
 hA54G0YFJNmKOajVsTzkXyoGCrbfoGXvxAK3E6kR7FX1f2f4euVxZF0sVfUc3u9Q1D
 Z7vqxScyFp30hUQBm8PGN/keiiR/qddBiLNrwyrgxUGCoKP+aO4GqgsuZSjBXaRZwv
 uEONnlTmSZm3zUmn0axIMLL6eO9+ckbVYJFPHqLlTy3oT7a0rN8NTgX1v3kPiLyIap
 yDQMCPWNvrRNNtepjKA5ZXQj1+tOEhr/fAf8DY6oQMRf98Fs68phpU5XQBxElVVwcb
 RUiZKDR1GjWmQ==
Date: Fri, 12 Dec 2025 09:59:56 +0900
From: Sumit Garg <sumit.garg@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: lukma@denx.de, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 trini@konsulko.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] mmc: msm_sdhci: Fix incorrect divider calculation
 for SDCLK
Message-ID: <aTtpDCVNZflD-rfi@sumit-X1>
References: <20251210155454.1561611-1-loic.poulain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210155454.1561611-1-loic.poulain@oss.qualcomm.com>
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

On Wed, Dec 10, 2025 at 04:54:52PM +0100, Loic Poulain wrote:
> When 'max-clk' is not specified, the SDHCI core retrieves the base clock
> from the SDHCI_CAPABILITIES register (bits [15:8]). However, this field
> is unreliable on MSM SDHCI controllers, as noted by the Linux driver
> using the SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN flag. In addition, the field
> is only 8 bits wide and cannot represent base clocks above 255 MHz.
> 
> On platforms like Agatti/QCM2290, the firmware sets the SDHCI clock to
> 384 MHz, but the capabilities register reports 200 MHz. As a result,
> the core calculates a divider of 4, producing a 96 MHz SDCLK instead of
> the intended ~52 MHz. This overclocking can cause sporadic CRC errors
> with certain eMMC.
> 
> To fix this, use the actual clock rate reported by the SDHCI core clock
> instead of relying on the capabilities register for divider calculation.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/mmc/msm_sdhci.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index ac77fb06bf7..ec003991928 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -114,6 +114,9 @@ static int msm_sdc_clk_init(struct udevice *dev)
>  		return -EINVAL;
>  	}
>  
> +	/* This is the base clock sdhci core will use to configure the SDCLK */
> +	prv->host.max_clk = clk_rate;
> +
>  	writel_relaxed(CORE_VENDOR_SPEC_POR_VAL,
>  		       prv->host.ioaddr + var_info->core_vendor_spec);
>  
> -- 
> 2.34.1
> 

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9893EF4ED4
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 12:52:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D90E8352B;
	Mon,  6 Apr 2026 14:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ffctsBeI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AB8A83936; Mon,  6 Apr 2026 14:52:39 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DBD18341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 14:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8809342A7A;
 Mon,  6 Apr 2026 12:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0451C4CEF7;
 Mon,  6 Apr 2026 12:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775479955;
 bh=CghyAeAkIc9qLoYhY/5/UeHIi0XVshq4eluLmZQTuEE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ffctsBeInWt2aYnYdCcgizxRJ+3knpLCcZ4ZFlOuPcrqbfOgu2RS7LPSz1v5NISip
 lzRuoeVtrMyN++aWwVRpCA/7wnhqyDTabl7cToVLot2Xi+C/9tpEDBuGw+K9902lO8
 aImezCkJdw2KNc/mJZfbZ4Yp5BBCF7r4377ibg0iMsN52z3/G+uLTzjczmi+h+ayYN
 k66tcf9r+YBnokOIW8kvfbArWPWhsxh970c60GrQOxrhKrhLb3AsQbr0Uo+o6IjZWn
 cJUPndPyFd7dzi6kHMT9X3EDPeYb+R/OkJo0eNI9oluL9NemWD1k+A2Rgq9wc70UZW
 0jveHQkCoe9gQ==
Date: Mon, 6 Apr 2026 18:22:29 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Tom Rini <trini@konsulko.com>,
 Julien Stephan <jstephan@baylibre.com>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/6] env: scsi: rename ENV_SCSI_PART_UUID
Message-ID: <adOsjXA70ICRS4hD@sumit-xelite>
References: <20260326-env-scsi-hw-part-support-v1-0-55c9dd07a2cb@baylibre.com>
 <20260326-env-scsi-hw-part-support-v1-1-55c9dd07a2cb@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-env-scsi-hw-part-support-v1-1-55c9dd07a2cb@baylibre.com>
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

On Thu, Mar 26, 2026 at 05:59:23PM -0500, David Lechner wrote:
> Rename SCSI_ENV_PART_UUID to ENV_SCSI_PART_UUID. All other environment-
> related config names are of the form ENV_<name>, so this is more
> consistent.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  configs/qcom_qcs9100_defconfig | 2 +-
>  env/Kconfig                    | 2 +-
>  env/scsi.c                     | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/configs/qcom_qcs9100_defconfig b/configs/qcom_qcs9100_defconfig
> index 371448b8b1b..082106157bb 100644
> --- a/configs/qcom_qcs9100_defconfig
> +++ b/configs/qcom_qcs9100_defconfig
> @@ -11,6 +11,6 @@ CONFIG_REMAKE_ELF=y
>  CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
>  CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"
>  CONFIG_ENV_IS_IN_SCSI=y
> -CONFIG_SCSI_ENV_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
> +CONFIG_ENV_SCSI_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
>  # CONFIG_ENV_IS_DEFAULT is not set
>  # CONFIG_ENV_IS_NOWHERE is not set
> diff --git a/env/Kconfig b/env/Kconfig
> index 2feff0b382e..5824f762870 100644
> --- a/env/Kconfig
> +++ b/env/Kconfig
> @@ -762,7 +762,7 @@ config ENV_MMC_USE_DT
>  	  The 2 defines CONFIG_ENV_OFFSET, CONFIG_ENV_OFFSET_REDUND
>  	  are not used as fallback.
>  
> -config SCSI_ENV_PART_UUID
> +config ENV_SCSI_PART_UUID
>  	string "SCSI partition UUID for saving environment"
>  	depends on ENV_IS_IN_SCSI
>  	help
> diff --git a/env/scsi.c b/env/scsi.c
> index 207717e17b1..f376f731870 100644
> --- a/env/scsi.c
> +++ b/env/scsi.c
> @@ -35,7 +35,7 @@ static inline struct env_scsi_info *env_scsi_get_part(void)
>  {
>  	struct env_scsi_info *ep = &env_part;
>  
> -	if (scsi_get_blk_by_uuid(CONFIG_SCSI_ENV_PART_UUID, &ep->blk, &ep->part))
> +	if (scsi_get_blk_by_uuid(CONFIG_ENV_SCSI_PART_UUID, &ep->blk, &ep->part))
>  		return NULL;
>  
>  	ep->count = CONFIG_ENV_SIZE / ep->part.blksz;
> @@ -83,12 +83,12 @@ static int env_scsi_load(void)
>  	int ret;
>  
>  	if (!ep) {
> -		env_set_default(CONFIG_SCSI_ENV_PART_UUID " partition not found", 0);
> +		env_set_default(CONFIG_ENV_SCSI_PART_UUID " partition not found", 0);
>  		return -ENOENT;
>  	}
>  
>  	if (blk_dread(ep->blk, ep->part.start, ep->count, &envbuf) != ep->count) {
> -		env_set_default(CONFIG_SCSI_ENV_PART_UUID " partition read failed", 0);
> +		env_set_default(CONFIG_ENV_SCSI_PART_UUID " partition read failed", 0);
>  		return -EIO;
>  	}
>  
> 
> -- 
> 2.43.0
> 

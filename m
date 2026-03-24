Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6CFE9A777
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 11:56:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41853807C0;
	Tue, 24 Mar 2026 12:56:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="St9lWzx3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F6D4807C0; Tue, 24 Mar 2026 12:56:29 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7260380517
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 12:56:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-486b96760easo10821915e9.2
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 04:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774353385; x=1774958185; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lz2gCT1ifgN3PZxWCYU81eDJ9QiFJlIa7LS3bRO+cro=;
 b=St9lWzx3SOgT8t8X8GJu4Qx0UAMRHhY4wy86DdUrHnJsQGXpsHSR3/acfL1gUEueC2
 LBSvKYxS5N6kwc9o45shXkCTaN5WlGSekHVS4syF6Sch1KzRxf0NRGluNE1rgfgY4Kfp
 78eYUzgMW/MJESTqUEhZOdngJcMFZMnQe/M6X9bnBisRgfNVCGCl8zF2B0s36918IatA
 20rb8oMOY0hxzenNxG7LBLQZkBCMPqSYqGGpeeZgVhwlL5ai2C6XqTz+YGmycls48h5G
 rMRHe8kCFWdipQySoOQK6RAjNbbzhIy5TyrSA1HHi3CMeA6FNEJLhW3tdBPP2FQBaPBk
 HgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774353385; x=1774958185;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lz2gCT1ifgN3PZxWCYU81eDJ9QiFJlIa7LS3bRO+cro=;
 b=L1lZP/YmtCVDCRYXzqrQhBo8FAEtFLRPPf6lDCfv8nQQbHKt8MY2OfZt3WnNN1KBLc
 L9E8CoG1D5qDeejHZsP6tQH/MI1QOIKbmnOqSxGS3ysvALGqUuyT0RXRc+lMgcw35c2D
 IaREAjoLBTg9QBTXOQb6I123qtvCS+cpT3APlIdW7SluAlfIbmsLM5B3sRAhtJ0ZS+nf
 +qUPck/NeLmfh2eXoBonKZcRvi9KyQ0UiO63r89hjz08YM3FkVuEsX5gS73Mi2eBm+7I
 wJTutOlEKNfAJMrCtK2g06fZun4Mpa5BEIrTRywO7Pq0lcZo6G40yflw9ABQlRc/oGTE
 NilA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH87tq5L3cBeSLs4WUIZZnCBeJDEwOL/yETrHCJ2cvcjLmu4NfXkvxE6IK6VezNGLi4hHUcZs=@lists.denx.de
X-Gm-Message-State: AOJu0YxR7VCSn3rCt5wHQmyn7b1/J9mSB3ACJ9OJoI+k+vaSvZJt+rJa
 baAUaZ4EaexPeS9R4tONuk9PZknYdciC/XIeP07wO7Pnz68mD7SsHpDUtM3hBHPjQlg=
X-Gm-Gg: ATEYQzw8Ndh3eyvmar8XxpYa6dIIffKaKlet1ajNIwqswh189FWupJkBsjvK+rOXKY1
 +D9j3RkWcjuZy1uccwoUVzEkSk5XFKQPPolafhURw1X7QxPteEi675t7jHWTbflAM5uTmfa7WN0
 HLgOp1+879k3IJRFjvss3TbtQdT1IiyhgTeV6Pd06BIJeUGIReMjPBLM1y6StQt2NeC9bVmK5x4
 69VzKyDegaZi9whv8r4egEfxOxunCrC6EcEJW/3GrdrmxZ+2fWfVPqZacSUoC52CpJvpgs84TuB
 cgF+itSsphgWUmo3x/BZvnhJY5lJ8DLrmhFsn2BhHDaERZN0GeDE3rzUuQT0yzcZlEIaTUhlrEB
 AijtjEHfj/0RGw/k4hkrb8/1JLNaPiinUhdaRWT5OxNZqSNU6d2bdccAwp7553Vw9Q1l+ABNxKS
 NvW94pSnIgi07Zrr9UT5PRWOCjRPQcRp6D+lNQ8pl2FM2CrClf+cwkqAVXm4NoBI8=
X-Received: by 2002:a05:600c:3f16:b0:485:3f38:3de3 with SMTP id
 5b1f17b1804b1-486fedab1aamr220211615e9.3.1774353384707; 
 Tue, 24 Mar 2026 04:56:24 -0700 (PDT)
Received: from [192.168.1.36] (p5b29eb0d.dip0.t-ipconnect.de. [91.41.235.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48710fd2c4esm30300935e9.4.2026.03.24.04.56.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 04:56:24 -0700 (PDT)
Message-ID: <a8c8f3f7-15ca-49b2-872e-aded2a424ff0@linaro.org>
Date: Tue, 24 Mar 2026 12:56:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] fs: fat: Limit transfer size to prevent SDHCI
 controller timeout
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>, Peng Fan
 <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Simon Glass <sjg@chromium.org>, Jean-Jacques Hiblot <jjhiblot@ti.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20260324-emmc_sd-v1-0-883a45538b6e@oss.qualcomm.com>
 <20260324-emmc_sd-v1-3-883a45538b6e@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260324-emmc_sd-v1-3-883a45538b6e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Balaji,

On 24/03/2026 06:52, Balaji Selvanathan wrote:
> Some SDHCI controllers have limitations on maximum transfer sizes
> and can timeout on large block operations.
> 
> Break large read and write operations into chunks of 16384 blocks
> to stay within controller limits. This prevents timeout errors during
> large file transfers on FAT filesystems while maintaining
> compatibility with all platforms.

Shouldn't this be split into two transfers at the MMC layer? Perhaps
with a quirk flag?

In fact this seems to be already totally supported, just change
CONFIG_SYS_MMC_MAX_BLK_COUNT to 16384 (see mmc_get_b_max() in mmc_bread()).

Kind regards,

> 
> This patch builds on top of the work from:
> https://lore.kernel.org/u-boot/20260224035000.1617869-1-varadarajan.narayanan@oss.qualcomm.com/
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  fs/fat/fat.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fat/fat.c b/fs/fat/fat.c
> index 85b511f75af..6ec241af584 100644
> --- a/fs/fat/fat.c
> +++ b/fs/fat/fat.c
> @@ -30,6 +30,9 @@
>  /* maximum number of clusters for FAT12 */
>  #define MAX_FAT12	0xFF4
>  
> +/* maximum blocks per read/write to avoid SDHCI timeout */
> +#define MAX_BLOCKS_PER_TRANSFER 16384
> +
>  /*
>   * Convert a string to lowercase.  Converts at most 'len' characters,
>   * 'len' may be larger than the length of 'str' if 'str' is NULL
> @@ -136,18 +139,26 @@ static int disk_rw(__u32 sect, __u32 nr_sect, void *buf, bool read)
>  	if (rem > blksz) {
>  		n = rem / blksz;
>  
> -		if (read)
> -			ret = blk_dread(cur_dev, start + s, n, buf);
> -		else
> -			ret = blk_dwrite(cur_dev, start + s, n, buf);
> +		/* Break large reads/writes into chunks */
> +		while (n > 0) {
> +			__u32 transfer_count = (n > MAX_BLOCKS_PER_TRANSFER) ? MAX_BLOCKS_PER_TRANSFER : n;
>  
> -		if (ret != n) {
> -			ret = -1;
> -			goto exit;
> +			if (read)
> +				ret = blk_dread(cur_dev, start + s, transfer_count, buf);
> +			else
> +				ret = blk_dwrite(cur_dev, start + s, transfer_count, buf);
> +
> +			if (ret != transfer_count) {
> +				ret = -1;
> +				goto exit;
> +			}
> +
> +			buf += transfer_count * blksz;
> +			s += transfer_count;
> +			n -= transfer_count;
>  		}
> -		buf += n * blksz;
> +
>  		rem = rem % blksz;
> -		s += n;
>  	}
>  
>  	/* Do part 3, read a block and copy the trailing sectors */
> 

-- 
// Casey (she/her)


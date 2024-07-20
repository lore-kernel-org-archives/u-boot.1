Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C67BC3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 15:45:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B92DF886AA;
	Sat, 20 Jul 2024 17:45:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EJxUvNMA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CF3488753; Sat, 20 Jul 2024 17:45:23 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DC7A88618
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 17:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6b79c969329so15603756d6.0
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 08:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721490320; x=1722095120; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nl5CfRXkg3cLWPhb6b+dXizmaRz+BzSz2klLEgQY26c=;
 b=EJxUvNMAJJpuewENEShYKIA7yW7VspevEs4VTERz8s0NjUwH2ElmXhACcJrWibxT/t
 1kWOpDf5Pyg/BkesGitZh8QvlU9k3OSdu7260uOFn9gYmFFIwq8WU9QRe3K5JNPY16sO
 dnBf8JPKOU4+3un8MLrQXH/7Sbe9LoWtlUC7RbrIIZ4I+796ydSaKZmV6ob3ygDnIKa+
 tf0/r7tfP1QDmXq8UYN2kBIRVMufybl4dDU0xhDAKTbYplLCeSlj2HxiwiL0gJVzNwJQ
 H6bceiRqz33HBytzxgZgCiL3waarxmuPyJ2D6SNWcohzMjgaCM/GZaEhZX2XDv1zmkmp
 QfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721490320; x=1722095120;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nl5CfRXkg3cLWPhb6b+dXizmaRz+BzSz2klLEgQY26c=;
 b=O8bSvk1O6S49BaYNh6OeCZyAMVeEc3ctOOWqF5v4qwppVPLIR6wIBDYW+rrG6gYH91
 ClfAm3VjeG7hQD5spRPrOSBEZEX39NBoLUkXRgWzbH1Q24pGq8yBbA+kk5ijKrj3+zIt
 F40dPM+MZRZgYBG7GKhkUk5TEa4H6KQGNTwVq9xgoP2df6emRchGohmdOPnNmrad/5/9
 3NoY+Z8A4hndXaPvZQrrViJ3UXumdvkJ+QpG+HfHGQZXp9xa8/vsbCiPYStUXnunzCQq
 TXaCciKBxDwhBndStoc9P+vrJcFW9k6wdjsC2BxS5VK3gleNuIWVZq9FKc8L6JL5+LoU
 V6SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsa6T8g2tOQXaWn37Y7rTDWtY488R1RgDeTN8lMuFoPb2c1mJ/InVfFyuGW9m7gha6d2cyFfY7rH5C/ko/tLD4kBiWDQ==
X-Gm-Message-State: AOJu0YyN17FsvLy4umD9C/mNPp5oK9TTgLhHJqvpIM8TKv/ZGZayrMVC
 e6wmsvsVaQSAISq0h0RJTC3hatzL+tsNOz3KKKh2+0zifXd4oIgDClIdOQ==
X-Google-Smtp-Source: AGHT+IG9n0dL2OLH4S2EZWykBH8i873ZkRBJdmb/BB2cfB+zasMt2hJuiLdTiD8ixRFq7Q1VIb8jGQ==
X-Received: by 2002:a05:6214:21ef:b0:6b7:b3b8:e882 with SMTP id
 6a1803df08f44-6b961092137mr23313676d6.25.1721490319967; 
 Sat, 20 Jul 2024 08:45:19 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b7ac9c3462sm18446176d6.76.2024.07.20.08.45.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jul 2024 08:45:19 -0700 (PDT)
Message-ID: <97d82989-7fb2-b229-0fd2-3997c003f6bd@gmail.com>
Date: Sat, 20 Jul 2024 11:45:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 06/14] mmc: Use logging instead of pr_err()
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Dragan Simic <dsimic@manjaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
References: <20240720061706.2644229-1-sjg@chromium.org>
 <20240720061706.2644229-7-sjg@chromium.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240720061706.2644229-7-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 7/20/24 02:16, Simon Glass wrote:
> Use the log subsystem instead of dev, to avoid including function names
> in the code.
> 
> The CONFIG_LOGF_FUNC option can be used to enable the function name.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   drivers/mmc/mmc.c | 49 ++++++++++++++++++++++++-----------------------
>   1 file changed, 25 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> index b18dc331f78..b0105afe5d6 100644
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -294,7 +294,7 @@ int mmc_poll_for_busy(struct mmc *mmc, int timeout_ms)
>   
>   		if (status & MMC_STATUS_MASK) {
>   #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> -			pr_err("Status Error: 0x%08x\n", status);
> +			log_err("Status Error: %08x\n", status);
>   #endif
>   			return -ECOMM;
>   		}
> @@ -307,7 +307,7 @@ int mmc_poll_for_busy(struct mmc *mmc, int timeout_ms)
>   
>   	if (timeout_ms <= 0) {
>   #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> -		pr_err("Timeout waiting card ready\n");
> +		log_err("Timeout waiting card ready\n");
>   #endif
>   		return -ETIMEDOUT;
>   	}
> @@ -449,7 +449,7 @@ static int mmc_read_blocks(struct mmc *mmc, void *dst, lbaint_t start,
>   	if (blkcnt > 1) {
>   		if (mmc_send_stop_transmission(mmc, false)) {
>   #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> -			pr_err("mmc fail to send stop cmd\n");
> +			log_err("mmc fail to send stop cmd\n");
>   #endif
>   			return 0;
>   		}
> @@ -500,8 +500,8 @@ ulong mmc_bread(struct blk_desc *block_dev, lbaint_t start, lbaint_t blkcnt,
>   
>   	if ((start + blkcnt) > block_dev->lba) {
>   #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> -		pr_err("MMC: block number 0x" LBAF " exceeds max(0x" LBAF ")\n",
> -		       start + blkcnt, block_dev->lba);
> +		log_err("MMC: block number " LBAF " exceeds max(" LBAF ")\n",
> +			start + blkcnt, block_dev->lba);
>   #endif
>   		return 0;
>   	}
> @@ -997,7 +997,7 @@ static int mmc_get_capabilities(struct mmc *mmc)
>   		return 0;
>   
>   	if (!ext_csd) {
> -		pr_err("No ext_csd found!\n"); /* this should enver happen */
> +		log_err("No ext_csd found!\n"); /* this should enver happen */
>   		return -ENOTSUPP;
>   	}
>   
> @@ -1109,17 +1109,17 @@ int mmc_hwpart_config(struct mmc *mmc,
>   		return -EINVAL;
>   
>   	if (IS_SD(mmc) || (mmc->version < MMC_VERSION_4_41)) {
> -		pr_err("eMMC >= 4.4 required for enhanced user data area\n");
> +		log_err("eMMC >= 4.4 required for enhanced user data area\n");
>   		return -EMEDIUMTYPE;
>   	}
>   
>   	if (!(mmc->part_support & PART_SUPPORT)) {
> -		pr_err("Card does not support partitioning\n");
> +		log_err("Card does not support partitioning\n");
>   		return -EMEDIUMTYPE;
>   	}
>   
>   	if (!mmc->hc_wp_grp_size) {
> -		pr_err("Card does not define HC WP group size\n");
> +		log_err("Card does not define HC WP group size\n");
>   		return -EMEDIUMTYPE;
>   	}
>   
> @@ -1127,8 +1127,7 @@ int mmc_hwpart_config(struct mmc *mmc,
>   	if (conf->user.enh_size) {
>   		if (conf->user.enh_size % mmc->hc_wp_grp_size ||
>   		    conf->user.enh_start % mmc->hc_wp_grp_size) {
> -			pr_err("User data enhanced area not HC WP group "
> -			       "size aligned\n");
> +			log_err("User data enhanced area not HC WP group size aligned\n");
>   			return -EINVAL;
>   		}
>   		part_attrs |= EXT_CSD_ENH_USR;
> @@ -1146,8 +1145,8 @@ int mmc_hwpart_config(struct mmc *mmc,
>   
>   	for (pidx = 0; pidx < 4; pidx++) {
>   		if (conf->gp_part[pidx].size % mmc->hc_wp_grp_size) {
> -			pr_err("GP%i partition not HC WP group size "
> -			       "aligned\n", pidx+1);
> +			log_err("GP%i partition not HC WP group-size aligned\n",
> +				pidx + 1);
>   			return -EINVAL;
>   		}
>   		gp_size_mult[pidx] = conf->gp_part[pidx].size / mmc->hc_wp_grp_size;
> @@ -1158,7 +1157,7 @@ int mmc_hwpart_config(struct mmc *mmc,
>   	}
>   
>   	if (part_attrs && ! (mmc->part_support & ENHNCD_SUPPORT)) {
> -		pr_err("Card does not support enhanced attribute\n");
> +		log_err("Card does not support enhanced attribute\n");
>   		return -EMEDIUMTYPE;
>   	}
>   
> @@ -1171,8 +1170,8 @@ int mmc_hwpart_config(struct mmc *mmc,
>   		(ext_csd[EXT_CSD_MAX_ENH_SIZE_MULT+1] << 8) +
>   		ext_csd[EXT_CSD_MAX_ENH_SIZE_MULT];
>   	if (tot_enh_size_mult > max_enh_size_mult) {
> -		pr_err("Total enhanced size exceeds maximum (%u > %u)\n",
> -		       tot_enh_size_mult, max_enh_size_mult);
> +		log_err("Total enhanced size exceeds maximum (%x > %x)\n",
> +			tot_enh_size_mult, max_enh_size_mult);
>   		return -EMEDIUMTYPE;
>   	}
>   
> @@ -1205,7 +1204,7 @@ int mmc_hwpart_config(struct mmc *mmc,
>   
>   	if (ext_csd[EXT_CSD_PARTITION_SETTING] &
>   	    EXT_CSD_PARTITION_SETTING_COMPLETED) {
> -		pr_err("Card already partitioned\n");
> +		log_err("Card already partitioned\n");
>   		return -EPERM;
>   	}
>   
> @@ -1876,7 +1875,7 @@ error:
>   		}
>   	}
>   
> -	pr_err("unable to select a mode\n");
> +	log_err("unable to select a mode\n");
>   	return -ENOTSUPP;
>   }
>   
> @@ -2254,7 +2253,7 @@ error:
>   		}
>   	}
>   
> -	pr_err("unable to select a mode : %d\n", err);
> +	log_err("unable to select a mode: %d\n", err);
>   
>   	return -ENOTSUPP;
>   }
> @@ -2921,8 +2920,10 @@ retry:
>   
>   		if (err) {
>   #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> -			if (!quiet)
> -				pr_err("Card did not respond to voltage select! : %d\n", err);
> +			if (!quiet) {
> +				log_err("Card did not respond to voltage select! : %d\n",
> +					err);
> +			}
>   #endif
>   			return -EOPNOTSUPP;
>   		}
> @@ -2955,7 +2956,7 @@ int mmc_start_init(struct mmc *mmc)
>   						   | MMC_CAP(MMC_LEGACY) |
>   						   MMC_MODE_1BIT);
>   			} else {
> -				pr_err("bus_mode requested is not supported\n");
> +				log_err("bus_mode requested is not supported\n");
>   				return -EINVAL;
>   			}
>   		}
> @@ -2975,7 +2976,7 @@ int mmc_start_init(struct mmc *mmc)
>   	if (no_card) {
>   		mmc->has_init = 0;
>   #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> -		pr_err("MMC: no card present\n");
> +		log_err("MMC: no card present\n");
>   #endif
>   		return -ENOMEDIUM;
>   	}
> @@ -3104,7 +3105,7 @@ static int mmc_probe(struct bd_info *bis)
>   	uclass_foreach_dev(dev, uc) {
>   		ret = device_probe(dev);
>   		if (ret)
> -			pr_err("%s - probe failed: %d\n", dev->name, ret);
> +			log_err("%s - probe failed: %d\n", dev->name, ret);
>   	}
>   
>   	return 0;

Reviewed-by: Sean Anderson <seanga2@gmail.com>

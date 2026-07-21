Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257EAC44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 11:35:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A97AE80B83;
	Tue, 21 Jul 2026 11:35:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pWg3N4souWef; Tue, 21 Jul 2026 11:35:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 78CAF80B78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784633711;
	bh=Rgy/gGLvqert9Kf7TAGKjGahADs73nIeeBd8RcJtM30=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=WYrSGjVu8PFZnfY90lQ7Y3qho/ZxU2lVJx8f39oxMKt5nvuz8vlLXaYUorxD7qzn6
	 MVv95VRaYDtttzQh86DFMZ8rHAdIH9JvLycCmzF67Ry8C9BTS/aWyWUXTLoTof4j2I
	 yT6++K8SS9OWQDhYFSLW2cStpv+/yIAr8ELFNxXiuK1/p879xToQ7czcsdyUk1Msz4
	 czZ0A7DgbcKIkLRBrBxM1ClX0GTBlahs79qkRSR7RyErZyJniWXOCk0fVEd8jzTHcF
	 QD1L5YM/MMcZORG+FrjJNO5CH3vJ3Yjrm11h6fXZUYAL3p5+FtToH+MI/1dSLXSnLj
	 zG4iLgRH4shoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 78CAF80B78;
	Tue, 21 Jul 2026 11:35:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1190E96C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 11:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E2F03400D5
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 11:35:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VH6yMjUDOEfh for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 11:35:10 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=neil.armstrong@linaro.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8E584400FE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8E584400FE
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8E584400FE
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 11:35:09 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14E2B84659; Tue, 21 Jul 2026 13:35:07 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64F0A803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 13:35:04 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so1542634f8f.2
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 04:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784633703; x=1785238503;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Rgy/gGLvqert9Kf7TAGKjGahADs73nIeeBd8RcJtM30=;
 b=sgtbjUeiDoRHs9gh9YszukGCvVbRBqZ5s85EDEwJHY5EFpFp/ZxWnccdZXr8y2mhth
 qxXud01Dri1xOvW4gyHAoVJu+YQt2bcmYXqO+97A2pnMBiU5HiSPBY8iKQIr6JzJcEEB
 NfhQcVSUDzYsnXtROEoXwvr1gAjPE558cYtftcXNiKYHwPE82i+UVZ6zgV6s8oqxjyxA
 0PhgG5QHDTVqyr25grRIR1bGWTNNGK2RakQMLC/JikCCThIvV1mEeSxtenXNu72UysJG
 d9fxtl4mP138BuFZGV4qzaNjQK/HSN3Jtq8ODEGaNBcwS9qTckdpRVQiGNfAzChvfdB7
 CxaQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrzuRzO5jszs3knjEt0EHuavVx4ZStLjJ3ZPn68TQnkcdilyFoHraBclD21PVA9zRN1IcuQAl4=@lists.denx.de
X-Gm-Message-State: AOJu0YzwWWrnc6/2y2WSRuXT/dchfG3kE+Cp+KiP/ccCER2qQV9uhkHz
 8MpYRtZiamL/GKJkUFRouKdVzkJd4B8DYjapiuDmETGtakOrj1+aqc+0JHuRgTrkrdo=
X-Gm-Gg: AR+sD12oRpU6iytT4XtftRKPkeTB/krmeV6GaBu374Uava/dWixz26mjvGrdn7eTdMr
 yp2hdshHYH1j+I+4Z4E6uuikkLHHJqk3IOPmyfJ8QDNiSM8Wy/boCpJ+TJeNbmrNEjgU+bdMtla
 D7O/bRqyoZPUIoXd2HTIE1hkAzz3jra7APASzUwwop/gQXxrdR6tOds3WceM3ettmhHEAwwYKWi
 chOl62/wVlwPUhzeWQg4iqS7MinmMTbAOAULpR5QAtP7P2oS1K3Ks8u4+G9DIckDT2aBX79rkRc
 l09BbHjTduuR5XKSDXbbWMqrD6NOKrmz9EDwb/490hNOEZdDrS/TJQv0DTWqVz0FwWZ9x30ZfBj
 H2ARO4Jgya8bDnvYhvlcxJtvo5LQM6Y/WQI/B4jS3z8++A76kfrP+Ff9Ba0gCj1v6fqVmhwUr48
 /iApCSwDZC835q6846Yzjs0ofMgXxl+lzL9XwJ2GTVgEdioQ4AHXvt8+U=
X-Received: by 2002:a05:6000:400f:b0:47f:8152:e568 with SMTP id
 ffacd0b85a97d-47f8152e595mr2566438f8f.60.1784633702972; 
 Tue, 21 Jul 2026 04:35:02 -0700 (PDT)
Received: from ?IPV6:2001:861:c12:13d0:dcef:c045:96d5:c1b3?
 ([2001:861:c12:13d0:dcef:c045:96d5:c1b3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e519f4sm36678440f8f.14.2026.07.21.04.35.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 04:35:02 -0700 (PDT)
Message-ID: <749b1a2f-d46a-4f30-8fa1-ce3e08720dd0@linaro.org>
Date: Tue, 21 Jul 2026 13:35:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] nvme: Fix missing address translation for PCIe
 inbound access
To: Torsten Duwe <duwe@lst.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Martin Schwan <m.schwan@phytec.de>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Prashant Kamble <prashant.kamble223@gmail.com>,
 Denis Mukhin <dmukhin@ford.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 u-boot@lists.denx.de
References: <20260706172028.C148E68BEB@verein.lst.de>
 <20260706172152.5257168BFE@verein.lst.de>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260706172152.5257168BFE@verein.lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784633703; x=1785238503; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rgy/gGLvqert9Kf7TAGKjGahADs73nIeeBd8RcJtM30=;
 b=HBcp4qsTZnWF7d4Rs/YX8TeRRgNsPPf6KZ7dqxYkARF09aDrzkRqUWz7YTkqIAS6E2
 TPELiITZBnPfi5qtiDdh5U9lYXnqLmjJn0cJjUz+vMb+5tPJ4CaOv9cEmJ8gUHaepb6/
 8TELHNK6R1Gc+Ez4mEWVNyLpwPUVPI9MUa0+50xEjANFHaeHMzRNVs6U+8PhQVDlSYSZ
 DVRiuTf/jAdQffUczAmP8+pyOiPfepLO++3a66QK5GPxWcX88DxsNnrwRE/Hh0ZneVio
 dFijBvS1mEBbQ3/j56t81K+GBgU3mzaKezvPv9Ye1fYZrMCO4GI2zq/tIUoAqHSnMhea
 uoZA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=HBcp4qsT
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=neil.armstrong@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="HBcp4qsT"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Neil Armstrong via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/6/26 19:21, Torsten Duwe wrote:
> From: Torsten Duwe <duwe@suse.de>
> 
> U-Boot currently does not account for PCIe bridges with a non-zero
> inbound access offset when talking NVMe, it only works on platforms
> where this offset happens to be zero.
> 
> This patch enhances the NVMe driver with the ability to also handle
> these cases. It also removes the unused function nvme_get_features().
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> Tested-by: Peter Robinson <pbrobinson@gmail.com>
> ---
> I tried to consistently use uintptr_t when doing arithmetic on pointers
> and dma_addr_t to hold, well, DMA addresses ;)
> 
> nvme_get_features mentions it's unused; so far it causes fruitless
> maintenance work and causes dead extra bytes in das U-Boot binary.
> It hasn't been neccessary for 9 years; one can revive it from git
> once needed.
> 
> ---
>   drivers/nvme/nvme.c | 71 +++++++++++++++++----------------------------
>   drivers/nvme/nvme.h |  3 ++
>   2 files changed, 29 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
> index 147a104149e..54284c0242b 100644
> --- a/drivers/nvme/nvme.c
> +++ b/drivers/nvme/nvme.c
> @@ -8,10 +8,10 @@
>   #include <bootdev.h>
>   #include <cpu_func.h>
>   #include <dm.h>
> -#include <errno.h>
>   #include <log.h>
>   #include <malloc.h>
>   #include <memalign.h>
> +#include <phys2bus.h>
>   #include <time.h>
>   #include <dm/device-internal.h>
>   #include <linux/compat.h>
> @@ -101,6 +101,8 @@ static int nvme_setup_prps(struct nvme_dev *dev, u64 *prp2,
>   			printf("Error: malloc prp_pool fail\n");
>   			return -ENOMEM;
>   		}
> +		dev->prp_pool_dma = dev_phys_to_bus(dev->udev,
> +						    (uintptr_t)dev->prp_pool);
>   		dev->prp_entry_num = num_pages * (prps_per_page - 1) + 1;
>   	}
>   
> @@ -108,8 +110,10 @@ static int nvme_setup_prps(struct nvme_dev *dev, u64 *prp2,
>   	i = 0;
>   	while (nprps) {
>   		if ((i == (prps_per_page - 1)) && nprps > 1) {
> -			*(prp_pool + i) = cpu_to_le64((ulong)prp_pool +
> -					page_size);
> +			dma_addr_t prp_pool_dma =
> +			    dev_phys_to_bus(dev->udev, (uintptr_t)prp_pool);
> +			*(prp_pool + i) = cpu_to_le64(prp_pool_dma +
> +								page_size);
>   			i = 0;
>   			prp_pool = (u64 *)((uintptr_t)prp_pool + page_size);
>   		}
> @@ -117,7 +121,7 @@ static int nvme_setup_prps(struct nvme_dev *dev, u64 *prp2,
>   		dma_addr += page_size;
>   		nprps--;
>   	}
> -	*prp2 = (ulong)dev->prp_pool;
> +	*prp2 = dev->prp_pool_dma;
>   
>   	flush_dcache_range((ulong)dev->prp_pool, (ulong)dev->prp_pool +
>   			   num_pages * page_size);
> @@ -258,11 +262,15 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev,
>   	nvmeq->cqes = (void *)memalign(4096, NVME_CQ_ALLOCATION);
>   	if (!nvmeq->cqes)
>   		goto free_nvmeq;
> +	nvmeq->cq_dma_addr = dev_phys_to_bus(dev->udev,
> +					     (uintptr_t)nvmeq->cqes);
>   	memset((void *)nvmeq->cqes, 0, NVME_CQ_SIZE(depth));
>   
>   	nvmeq->sq_cmds = (void *)memalign(4096, NVME_SQ_SIZE(depth));
>   	if (!nvmeq->sq_cmds)
>   		goto free_queue;
> +	nvmeq->sq_dma_addr = dev_phys_to_bus(dev->udev,
> +					     (uintptr_t)nvmeq->sq_cmds);
>   	memset((void *)nvmeq->sq_cmds, 0, NVME_SQ_SIZE(depth));
>   
>   	nvmeq->dev = dev;
> @@ -410,8 +416,8 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
>   	dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
>   
>   	writel(aqa, &dev->bar->aqa);
> -	nvme_writeq((ulong)nvmeq->sq_cmds, &dev->bar->asq);
> -	nvme_writeq((ulong)nvmeq->cqes, &dev->bar->acq);
> +	nvme_writeq(nvmeq->sq_dma_addr, &dev->bar->asq);
> +	nvme_writeq(nvmeq->cq_dma_addr, &dev->bar->acq);
>   
>   	result = nvme_enable_ctrl(dev);
>   	if (result)
> @@ -437,7 +443,7 @@ static int nvme_alloc_cq(struct nvme_dev *dev, u16 qid,
>   
>   	memset(&c, 0, sizeof(c));
>   	c.create_cq.opcode = nvme_admin_create_cq;
> -	c.create_cq.prp1 = cpu_to_le64((ulong)nvmeq->cqes);
> +	c.create_cq.prp1 = cpu_to_le64(nvmeq->cq_dma_addr);
>   	c.create_cq.cqid = cpu_to_le16(qid);
>   	c.create_cq.qsize = cpu_to_le16(nvmeq->q_depth - 1);
>   	c.create_cq.cq_flags = cpu_to_le16(flags);
> @@ -454,7 +460,7 @@ static int nvme_alloc_sq(struct nvme_dev *dev, u16 qid,
>   
>   	memset(&c, 0, sizeof(c));
>   	c.create_sq.opcode = nvme_admin_create_sq;
> -	c.create_sq.prp1 = cpu_to_le64((ulong)nvmeq->sq_cmds);
> +	c.create_sq.prp1 = cpu_to_le64(nvmeq->sq_dma_addr);
>   	c.create_sq.sqid = cpu_to_le16(qid);
>   	c.create_sq.qsize = cpu_to_le16(nvmeq->q_depth - 1);
>   	c.create_sq.sq_flags = cpu_to_le16(flags);
> @@ -464,13 +470,13 @@ static int nvme_alloc_sq(struct nvme_dev *dev, u16 qid,
>   }
>   
>   int nvme_identify(struct nvme_dev *dev, unsigned nsid,
> -		  unsigned cns, dma_addr_t dma_addr)
> +		  unsigned cns, dma_addr_t cpu_addr)
>   {
>   	struct nvme_command c;
>   	u32 page_size = dev->page_size;
> +	dma_addr_t dma_addr = dev_phys_to_bus(dev->udev, cpu_addr);
>   	int offset = dma_addr & (page_size - 1);
>   	int length = sizeof(struct nvme_id_ctrl);
> -	dma_addr_t orig_dma_addr = dma_addr;
>   	int ret;
>   
>   	memset(&c, 0, sizeof(c));
> @@ -488,49 +494,22 @@ int nvme_identify(struct nvme_dev *dev, unsigned nsid,
>   
>   	c.identify.cns = cpu_to_le32(cns);
>   
> -	nvme_invalidate_cache_aligned((uintptr_t)orig_dma_addr,
> +	nvme_invalidate_cache_aligned((uintptr_t)cpu_addr,
>   				      sizeof(struct nvme_id_ctrl));
>   
>   	ret = nvme_submit_admin_cmd(dev, &c, NULL);
>   	if (!ret)
> -		nvme_invalidate_cache_aligned((uintptr_t)orig_dma_addr,
> +		nvme_invalidate_cache_aligned((uintptr_t)cpu_addr,
>   					      sizeof(struct nvme_id_ctrl));
>   
>   	return ret;
>   }
>   
> -int nvme_get_features(struct nvme_dev *dev, unsigned fid, unsigned nsid,
> -		      dma_addr_t dma_addr, u32 *result)
> -{
> -	struct nvme_command c;
> -	int ret;
> -
> -	memset(&c, 0, sizeof(c));
> -	c.features.opcode = nvme_admin_get_features;
> -	c.features.nsid = cpu_to_le32(nsid);
> -	c.features.prp1 = cpu_to_le64(dma_addr);
> -	c.features.fid = cpu_to_le32(fid);
> -
> -	ret = nvme_submit_admin_cmd(dev, &c, result);
> -
> -	/*
> -	 * TODO: Add some cache invalidation when a DMA buffer is involved
> -	 * in the request, here and before the command gets submitted. The
> -	 * buffer size varies by feature, also some features use a different
> -	 * field in the command packet to hold the buffer address.
> -	 * Section 5.21.1 (Set Features command) in the NVMe specification
> -	 * details the buffer requirements for each feature.
> -	 *
> -	 * At the moment there is no user of this function.
> -	 */
> -
> -	return ret;
> -}
> -
>   int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned dword11,
> -		      dma_addr_t dma_addr, u32 *result)
> +		      dma_addr_t cpu_addr, u32 *result)
>   {
>   	struct nvme_command c;
> +	dma_addr_t dma_addr = dev_phys_to_bus(dev->udev, cpu_addr);
>   
>   	memset(&c, 0, sizeof(c));
>   	c.features.opcode = nvme_admin_set_features;
> @@ -769,7 +748,7 @@ static ulong nvme_blk_rw(struct udevice *udev, lbaint_t blknr,
>   	u64 prp2;
>   	u64 total_len = blkcnt << desc->log2blksz;
>   	u64 temp_len = total_len;
> -	uintptr_t temp_buffer = (uintptr_t)buffer;
> +	uintptr_t dma_addr = dev_phys_to_bus(udev, (uintptr_t)buffer);
>   
>   	u64 slba = blknr;
>   	u16 lbas = 1 << (dev->max_transfer_shift - ns->lba_shift);
> @@ -797,19 +776,19 @@ static ulong nvme_blk_rw(struct udevice *udev, lbaint_t blknr,
>   		}
>   
>   		if (nvme_setup_prps(dev, &prp2,
> -				    lbas << ns->lba_shift, temp_buffer))
> +				    lbas << ns->lba_shift, dma_addr))
>   			return -EIO;
>   		c.rw.slba = cpu_to_le64(slba);
>   		slba += lbas;
>   		c.rw.length = cpu_to_le16(lbas - 1);
> -		c.rw.prp1 = cpu_to_le64(temp_buffer);
> +		c.rw.prp1 = cpu_to_le64(dma_addr);
>   		c.rw.prp2 = cpu_to_le64(prp2);
>   		status = nvme_submit_sync_cmd(dev->queues[NVME_IO_Q],
>   				&c, NULL, IO_TIMEOUT);
>   		if (status)
>   			break;
>   		temp_len -= (u32)lbas << ns->lba_shift;
> -		temp_buffer += lbas << ns->lba_shift;
> +		dma_addr += lbas << ns->lba_shift;
>   	}
>   
>   	if (read)
> @@ -884,6 +863,8 @@ int nvme_init(struct udevice *udev)
>   		printf("Error: %s: Out of memory!\n", udev->name);
>   		goto free_queue;
>   	}
> +
> +	ndev->prp_pool_dma = dev_phys_to_bus(udev, (uintptr_t)ndev->prp_pool);
>   	ndev->prp_entry_num = MAX_PRP_POOL >> 3;
>   
>   	ret = nvme_setup_io_queues(ndev);
> diff --git a/drivers/nvme/nvme.h b/drivers/nvme/nvme.h
> index bc1d612dde4..7c6ed4d9b55 100644
> --- a/drivers/nvme/nvme.h
> +++ b/drivers/nvme/nvme.h
> @@ -619,6 +619,7 @@ struct nvme_dev {
>   	u32 page_size;
>   	u8 vwc;
>   	u64 *prp_pool;
> +	uintptr_t prp_pool_dma;
>   	u32 prp_entry_num;
>   	u32 nn;
>   };
> @@ -637,7 +638,9 @@ enum nvme_queue_id {
>   struct nvme_queue {
>   	struct nvme_dev *dev;
>   	struct nvme_command *sq_cmds;
> +	dma_addr_t sq_dma_addr;
>   	struct nvme_completion *cqes;
> +	dma_addr_t cq_dma_addr;
>   	u32 __iomem *q_db;
>   	u16 q_depth;
>   	s16 cq_vector;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

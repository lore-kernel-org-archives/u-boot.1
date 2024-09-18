Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C3ECCD18D
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 08:06:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32D2A889ED;
	Wed, 18 Sep 2024 10:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tjbwm5NA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10A8588E4A; Wed, 18 Sep 2024 10:06:46 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0728C87042
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 10:06:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3780c8d689aso4738115f8f.0
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 01:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726646803; x=1727251603; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=2Y3Gx2JKLGoH1VyiWYYbccpU3DX1951YTZo8vcX7k9Y=;
 b=tjbwm5NA1e7XHPozEtCOyRAoQsrNz4WVVlqnlSHFCvFDjTDDhv/6qclEwUoOyKMflI
 2Ncz6G+z/0PC+3tCTYdY1kdwn8AICz7OA8jTGhqCXzo8wtdzycIn+5fHBdXuUH4jh3Hc
 y6nQzRlYIQtS8ZUBRWj4fLWHDOkiwnz2EeSgONcrRD0YM0McTd0f+2v0q2uN9A6lx81Z
 FNOxCLlXzpyMke8sEkiCIr8HRNUSR9f01znstnZU9MoIQoWWvp2K5XGGrxRtPqrQ9JDO
 HrcKG+XkvgImDVXB1mqim+w/vFb2knE7iceMtWNxbgc0Yyh4Q36lpG5gdu8xd+EzxDEy
 6YcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726646803; x=1727251603;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2Y3Gx2JKLGoH1VyiWYYbccpU3DX1951YTZo8vcX7k9Y=;
 b=ecHM96W7h+7aGMFeyv7VVCVu5+VJlccbdWdXXNq/kZHzBPB26TRd9m8ACqkpWx+REJ
 s3UH7QWKodk+89gjJPi+3bwbNgHDVmriz3m/4QzCA1fnn/jKqK5or66uOXrNlX0vs48P
 UPaXRoEWqMYRPVQhQ5z7p8fPxi63tE09ew7oDp5fRdFlG0NDJg2ZoG83JO3SvY/0p/Py
 VGSmi8pjazGFqo9s1GFAYrUbeuTtT6QnrODX73fKT8s/dA1Td1PB0wAgHX93xs8F9gOe
 nz41BZgR7gG0SwQ15g4HDoKG7BBrRmnCk56lmDOILzJh2p4gfCoAMn307MRcdwzv0tGl
 tjUg==
X-Gm-Message-State: AOJu0YwTYqqEEYSX3+OqgaQvq70MmjcS21OXnnjI71ChC8N+nBb16jvD
 0KasJ7pqVGiiOQmI3qWJPFRicQii8bSkbezYbAVCup575toGXBmlswHqfEX1HP4=
X-Google-Smtp-Source: AGHT+IGSgvKJktLj+u2m8o0c7z3Z8ZECp07FV61ZNOQ9O7zKKdOtq/m1u2jdoQdhTo3+pfTeGDYJKw==
X-Received: by 2002:adf:8b9e:0:b0:377:205f:c494 with SMTP id
 ffacd0b85a97d-378c2cfebc6mr12517855f8f.11.1726646803154; 
 Wed, 18 Sep 2024 01:06:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:2782:e782:f1c:dcad?
 ([2a01:e0a:982:cbb0:2782:e782:f1c:dcad])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e704ec8a1sm10072015e9.14.2024.09.18.01.06.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2024 01:06:42 -0700 (PDT)
Message-ID: <bff9ce50-b5a6-45d8-9969-f116d91f75dd@linaro.org>
Date: Wed, 18 Sep 2024 10:06:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 00/13] ufs: enhancements to support Qualcomm UFS
 controllers
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>, bmeng.cn@gmail.com
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Bhupesh Sharma <bhupesh.linux@gmail.com>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
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
In-Reply-To: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Marek, Manorit, Tom, Michal,

On 10/09/2024 11:20, Neil Armstrong wrote:
> This serie regroups all the fixes and base enhancements required to
> support the Qualcomm UFS controllers in U-Boot.
> 
> This syncs headers & defines from Linux, and includes 2 set of
> fixes that were sent separately:
> - ufs: core: remove link_startup_again logic
> - ufs: properly fix cache operations
> 
> Without those 2 sets, UFS cannot initialize on Qualcomm controlers
> since v5, and a numerous of Cache issues makes any UFS controller
> fail to initialize.
> 
> Since UFS core hasn't changed for a while, and since UFS is core
> technology for the Qualcomm SoCs, I volunteer maintaininig the
> UFS subsystem if Bhupesh & Neha Malcom Francis are ok with that.

Could you run this serie on the r8a779f0_spider, j721s2_evm_a72, j721e_evm_a72,
j7200_evm_a72, amd_versal2_virt and qemu-riscv and check for possible regressions ?

It seems the only user of UFS_PCI is qemu-riscv, is there other users ?

Thanks,
Neil

> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Bhupesh Sharma (5):
>        ufs/ufs.h: Add definition of 'ufshcd_rmwl()'
>        ufs: Clear UECPA once due to LINERESET has happened during LINK_STARTUP
>        ufs: Sync possible UFS Quirks with Linux UFS driver
>        ufs: Add missing memory barriers
>        ufs: Fix debug message in 'ufs_start'
> 
> Marek Vasut (2):
>        ufs: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS
>        ufs: Add UFSHCD_QUIRK_HIBERN_FASTAUTO
> 
> Neil Armstrong (6):
>        ufs: allocate descriptors with size aligned with DMA_MINALIGN
>        ufs: fix dcache flush and invalidate range calculation
>        ufs: split flush and invalidate to only invalidate when required
>        ufs: use dcache helpers for scsi_cmd data and only invalidate if necessary
>        ufs: core: remove link_startup_again logic
>        MAINTAINERS: Add myself to the list of UFS maintainers
> 
>   MAINTAINERS       |   1 +
>   drivers/ufs/ufs.c |  98 ++++++++++++++++++++--------------
>   drivers/ufs/ufs.h | 157 +++++++++++++++++++++++++++++++++++++++++++++++-------
>   3 files changed, 197 insertions(+), 59 deletions(-)
> ---
> base-commit: ca55cf8104c0dd78aae45fa66dd8400ef1b3d0ac
> change-id: 20240910-topic-ufs-enhancements-fe8ef9ce39d8
> 
> Best regards,


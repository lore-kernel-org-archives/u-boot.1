Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7561CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 08:14:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63B5F839DF;
	Tue, 28 Oct 2025 09:14:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d6Wwm6k9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89B8A839E4; Tue, 28 Oct 2025 09:14:47 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AA48839D6
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 09:14:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4298a028de6so3389177f8f.0
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 01:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761639284; x=1762244084; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=1CwNYLnfkbdQI2iuPjc5AzjvWXNtM/PHwgQldblonbQ=;
 b=d6Wwm6k9wGDM6bBREsuZASCdvXaN6Hx31MkMNXR6hDYAjuPfQWz5902UO6Ca5NQaQU
 FNVgxJwLU5s0JJuhPmhMK6dYMPaIAajPK84kAJbTHLPA/Ej2TODldYIlb3FszMJXyhQp
 Qtk4NgEiQN/ltoWYap0gz4gUOfe7tVdRg7+OIYxirFmgsucB34PYkttUSVn4mVDUlueF
 lrZQGxJRN3MDU1hv5EtXostOmoC6bnn9M4+tj23/wI78q0HGHfotA41ZctCxPi7RbOlr
 p/gqno5cDsDFivTi117AvcdyklI6+DHb9NuufAPAM/g/TNB/fRTwJVUzFvFRIjr1ty4u
 cN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761639284; x=1762244084;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1CwNYLnfkbdQI2iuPjc5AzjvWXNtM/PHwgQldblonbQ=;
 b=Bqjxf1oHDPVaH/I0M4iabE938tzIRXnDMJRXfMLwzixMsjVcBaOY9ZILxYDg73+NWy
 DR3txSIjJ1vU220YT3cBUDFsDB4GMt4oWD2MEgeNjqg4qemItPzCKotPpeqjrSRsD+Th
 A35z6CJMQUiVAWWUIxbZYHClu/941RyDXTnn+2z/8Z0Vr8aJ/+GXyVfbsaepNqY7B+Jy
 WvJeaF8y1KwdL/xhX5nF1ctVaGjX4ect8YObqd9ApNSZQkkTWKfxRF3TYWycBumMoN5f
 gfXITIrzM4TdPf2q5cxtTH2YwfynkdpgNcPuF3PUgBl4ER+5ypczSduOBPS6M8GC1Bpm
 WS4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnLQrY4z+qDqcDm/b5XKN2Akj1xHFHLLPEr6bhbw7fj8HyFmObxh31Wys93mnudbvlGC2SAdA=@lists.denx.de
X-Gm-Message-State: AOJu0YxkRNwpWxdCVAHOWnp33F+gMqm0mCHpLotYnd/0jrstGXP4KAYp
 lB/KXReCK84UG9lxyZoUjpr4cHdWhISTRZTlANQu/Nbi1lF4DRcg0Aba1FuzetPG4J8=
X-Gm-Gg: ASbGncsyYHZAv1Z1cTDtljOwPpch8a6vG+Cg0hC/QWiO3+gwQYnp6YIQgVMbI9nbFth
 TcZ+k1z7PnTmp+jwUnPaIn7Z1XC7Z5fhNzZVtHSlMIQIN9v0lziL8qdr+xnxSTtERpsbksaM5QO
 Q4SNbbnTNkYurTKBeaGofsJJl5P6d1ZN1U3EoGtFvFmnHjIh9f5EGP0v87GsRNzz6kEvtJIRL5K
 lVRWuxsPOQqGzjk6rQp+2aLL3CevfK14wnlt+Bp1qFkQQAInzuO5gDDa3F6y/TB9TJltpQ4/wDK
 KPgRANBomWYpOCJmqQitpFY9qtd/3hDauxO3IoD2VLUBSm/5n5H+Xq5cTapQY7nZcoVQB37z2hO
 lfOUrTI4XSby1TtGrqaJRRDGx/RiXFH1C1cnMNC4+mBl2AzQvwNw54D8iuCzlyTqI00jwaK+dYV
 8SQgvVmByiwII7Zq7F9Ns35qBNfap0+Qt56c0MHMkuvAes0bL/eteFS1wD16lP
X-Google-Smtp-Source: AGHT+IFSa9PYvlmzokfJpR4YoPu2JdXbJgCrpHrewsgwFa0e3ybJkS3xtzTUH78JbnDlL0iiVEjCDQ==
X-Received: by 2002:a05:6000:2085:b0:428:56c5:b305 with SMTP id
 ffacd0b85a97d-429a81a8444mr1927844f8f.6.1761639283804; 
 Tue, 28 Oct 2025 01:14:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:ebe6:df10:d28d:aa5?
 ([2a01:e0a:cad:2140:ebe6:df10:d28d:aa5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd4cba64sm179949685e9.14.2025.10.28.01.14.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 01:14:43 -0700 (PDT)
Message-ID: <9b134447-f653-4521-a559-9510d3d02d33@linaro.org>
Date: Tue, 28 Oct 2025 09:14:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/6] ufs: core: Fold ufs-uclass into ufs
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Neha Malcom Francis <n-francis@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Sumit Garg
 <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, u-boot-qcom@groups.io
References: <20251027170706.29302-1-marek.vasut+renesas@mailbox.org>
 <20251027170706.29302-2-marek.vasut+renesas@mailbox.org>
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
In-Reply-To: <20251027170706.29302-2-marek.vasut+renesas@mailbox.org>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/27/25 18:06, Marek Vasut wrote:
> Move the few lines of ufs-uclass.c into ufs.c and remove the
> ufs-uclass.c . No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Neha Malcom Francis <n-francis@ti.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Sumit Garg <sumit.garg@kernel.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>
> Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: u-boot-qcom@groups.io
> Cc: u-boot@lists.denx.de
> ---
>   drivers/ufs/Makefile     |  2 +-
>   drivers/ufs/ufs-uclass.c | 17 -----------------
>   drivers/ufs/ufs.c        |  6 ++++++
>   3 files changed, 7 insertions(+), 18 deletions(-)
>   delete mode 100644 drivers/ufs/ufs-uclass.c
> 
> diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
> index 548306fb99e..2ac410cf7c3 100644
> --- a/drivers/ufs/Makefile
> +++ b/drivers/ufs/Makefile
> @@ -3,7 +3,7 @@
>   # Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
>   #
>   
> -obj-$(CONFIG_UFS) += ufs.o ufs-uclass.o
> +obj-$(CONFIG_UFS) += ufs.o
>   obj-$(CONFIG_CADENCE_UFS) += cdns-platform.o
>   obj-$(CONFIG_QCOM_UFS) += ufs-qcom.o
>   obj-$(CONFIG_TI_J721E_UFS) += ti-j721e-ufs.o
> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> deleted file mode 100644
> index 334bfcfa06a..00000000000
> --- a/drivers/ufs/ufs-uclass.c
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/**
> - * ufs-uclass.c - Universal Flash Storage (UFS) Uclass driver
> - *
> - * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
> - */
> -
> -#define LOG_CATEGORY UCLASS_UFS
> -
> -#include "ufs.h"
> -#include <dm.h>
> -
> -UCLASS_DRIVER(ufs) = {
> -	.id	= UCLASS_UFS,
> -	.name	= "ufs",
> -	.per_device_auto	= sizeof(struct ufs_hba),
> -};
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index 57e6e8c013b..c1f3301b37e 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -2091,3 +2091,9 @@ U_BOOT_DRIVER(ufs_scsi) = {
>   	.name = "ufs_scsi",
>   	.ops = &ufs_ops,
>   };
> +
> +UCLASS_DRIVER(ufs) = {
> +	.id			= UCLASS_UFS,
> +	.name			= "ufs",
> +	.per_device_auto	= sizeof(struct ufs_hba),
> +};

This breaks the implicit rule to have a <uclass>-uclass.c file, but I'm fine with that

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

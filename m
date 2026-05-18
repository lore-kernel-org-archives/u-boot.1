Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3BCCD4F49
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 14:37:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 188928467A;
	Mon, 18 May 2026 16:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SGzKff2u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29F3B84683; Mon, 18 May 2026 16:36:58 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40EE383EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 16:36:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so35566075e9.2
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 07:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779115016; x=1779719816; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=xT/uZ3sA+/nVitXBWq2XuPeu34VjBaTZKpSCEAd8+pA=;
 b=SGzKff2uHnHTf3r6P+V3LPkn/d3kHXLsrzRQBxUzj0oD1YCiWKwWIgPXDNR7X9LCW0
 0wu3jzEjKiItC5oqV6UVOyqf63Pf8fp1IKH7SykW/wElyQn/XLRko4Jta3TJ3B1VmWtT
 0Ml1YBck0ohopzKJ+06OPP7XorWf0vTO2vjNrgxmWpYtZPC+IUNnZ3aEQ0x6igbfHXxo
 z+zYIoTJ4xmj1pMmfrcFJ1cA3F1t4SULm5OAWrzmLhvBpjtOUZ0vqlVCrVjQCcfp0CpN
 Lh1s3ooAs22fAy7UdR09hI0fNKrpStLHUg0IZ3D4mHqMSoZARI2faXBwk2xnCPfCSC91
 gR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779115016; x=1779719816;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xT/uZ3sA+/nVitXBWq2XuPeu34VjBaTZKpSCEAd8+pA=;
 b=m+oPHee1G4x2Ve6i0U7XXQfeuyjL6BnsTHBhDNSBx+9GV9s6gLrKrLMEiYH7KRBxnq
 kSD1JWAnf1d6hBksO+OVw+nOS4ty5n70NL/x6T5C9hzGD+uBH/Ailjtnsfar2on8mTxd
 506snbftmEbrzwydg+ctYy63W36nj3JPNFoardYyXoGFMEeNp0AjpUYZnWs/aNsweKFo
 cHbjig3ywqPdYSG3HwqGG6oxYsyvwS9C4aaG7W7sq3DjshSHrLjZYzBrMGSblraVL5/Z
 6Ab70MlhMr2YJb/YYFWHy/OWYZN7WkJIKeL8LCloNDMTfCH5FSotJIqx6BcKKqVqDs4x
 N2SA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/X79TTMSuO6+Kr5We4R1s5cyz1ayVVGR8Y37is4uyS346QBKaTfpg1SE8SnIz3y/YdiNqIU48=@lists.denx.de
X-Gm-Message-State: AOJu0YxAxDipyGSSqfcMDsXMq4vTnjCDBMvvi9cft0A8FQYqYlSJS6dl
 yVj6BrmX8O3phuDASebJXo4vG1h1al8eoJw9uIum9SJg5WQe3SIGkR+9AmLlIy8bl8o=
X-Gm-Gg: Acq92OHTCYrXhyn3zvh0VVSzj4kOvMrfkmxVBe/jtNR8vcSMsp9tSAO61T8YQBwQHie
 fQctph44FcMcTMb0Ua75vFM3IACScg2qm84hhRPPC0LdUU/I9sYPuHvSvTOOS+c0/0/QhGiZPxF
 qsEvebl/gTthOuiggI0MdrNoLcc6iIFobwNbznRIAK9fmXSCoRGZmRffo/McusioAqDm/pmLQl7
 mgc2PRqiALGQWwtXicPmESECuu1bVJ1X+nfdyxM0/9giMzpXCQBu9wkd4ZUg7TTdBG6BeWW7FDv
 ilaYOCvXcEIkLVFAjO2npNKl/tLbgGQ2EsE+qJ42tG8imyGW7koUMWKMB/G7bikg7qrDLkDwdZj
 93AqDTb29VQvr1n1uO0k+1Nlz8Tyd6B4JL3t95cz/BqkDwM35IPLxSx4n/5Cp1A6H1ItgtdbTrF
 SSSd7tdCyLN+rulwoX88HfaUSJh5cc4Xlm9SOLxuLd5PNcoBRkV0fGCSWGStZS1M9s3p7NqOgFI
 +sGvE8=
X-Received: by 2002:a05:600c:46ce:b0:48f:d2b5:d7 with SMTP id
 5b1f17b1804b1-48fe60edd2dmr225212035e9.12.1779115015536; 
 Mon, 18 May 2026 07:36:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1029:e3c5:362e:1250?
 ([2a01:e0a:106d:1080:1029:e3c5:362e:1250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2949asm120026135e9.1.2026.05.18.07.36.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 07:36:54 -0700 (PDT)
Message-ID: <4fc09277-1a42-47f8-91b8-837ba6ed6b96@linaro.org>
Date: Mon, 18 May 2026 16:36:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 07/15] soc: qcom: smem: adjust headers for U-Boot
To: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>,
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
 <20260504-b4-modernise-smem-v2-7-c01ec2ff3886@linaro.org>
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
In-Reply-To: <20260504-b4-modernise-smem-v2-7-c01ec2ff3886@linaro.org>
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

On 5/4/26 20:57, Casey Connolly wrote:
> Drop Linux headers for the U-Boot ones.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   drivers/soc/qcom/smem.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index 8515b8ae7777..7143856e85c3 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -3,19 +3,17 @@
>    * Copyright (c) 2015, Sony Mobile Communications AB.
>    * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
>    */
>   
> -#include <linux/hwspinlock.h>
> +#include <dm/device.h>
> +#include <dm/device_compat.h>
> +#include <dm/ofnode.h>
> +#include <linux/bug.h>
>   #include <linux/io.h>
> -#include <linux/module.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_reserved_mem.h>
> -#include <linux/platform_device.h>
> +#include <linux/ioport.h>
>   #include <linux/sizes.h>
> -#include <linux/slab.h>
> -#include <linux/soc/qcom/smem.h>
> -#include <linux/soc/qcom/socinfo.h>
> +#include <soc/qcom/smem.h>
> +#include <soc/qcom/socinfo.h>
>   
>   /*
>    * The Qualcomm shared memory system is a allocate only heap structure that
>    * consists of one of more memory areas that can be accessed by the processors
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAD4CD4F49
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 14:34:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7BD884683;
	Mon, 18 May 2026 16:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TuzJXTnw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04F35803C6; Mon, 18 May 2026 16:34:43 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1684E84683
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 16:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-45297094718so1847092f8f.3
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 07:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779114880; x=1779719680; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=oPiwsd+TX8wMDHRdro2X04xhUlbWDS55Wo6yvgyjtTY=;
 b=TuzJXTnwPohpPcDW3n/JemJ5eWlhgIWsoW6m4IO7xqgiAb7c+byYlIkG1EG4xMLJy0
 FlWTliPbuXFrnvcDtr86PResAG5i3kQc8F5zEgatmvn92QrXP4fUI9EbEnx4v7WgCGgf
 7DiSknlrFyZk3X6wQb1bIeVeY3+AVDtg64UTcxqC1VDSCZUEsgumvUd/U7/szmYD+EMq
 7fbHtWyg28LUfPSNAe9lEcH1RD7Ls7u1Fy2R5FEcRqVH4omfSRSeNMpw5JUhpKkA7qEb
 hoeYouDGtjE/nvkyT0mkVu3RQitRjwsh4VrjLD+z7P5uPIWh06fbWh2QGzDtfflepC18
 y6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779114880; x=1779719680;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oPiwsd+TX8wMDHRdro2X04xhUlbWDS55Wo6yvgyjtTY=;
 b=QNSNIH16mJh/IQmvMDOyfaWRgJAXSqDTi2dnYabFg2hc9g7EBzw4F2Aejbp2EhNdUf
 mkQz1TOq7za6hKbzhKpII6uEPKcxX0QhxRmNWQtkXQ7OkrgKf5a2gX4FV9iPkJ2h+gMz
 mWNbKllx4pyUT9cVOKAm4amjrUDyGXy66C6t2uhruu+XoptoUuzcTizgCpqcoDjmGEnE
 whZdZ2Whsdn2iFRGflm1AoUKSd12fVrMOLFKP56QYjcUEMfTXjxOyAo4EpYNAE30LvMI
 0TEPcGUJH8LnDdFuhcvwKPqO+5bpEF67FW7KJ7NCNykuE0HDRTbfZT2eCXryAu28Se1S
 vcFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ90DFQgBCwNvcj7/MtoxUmxkFR1B9mQq32m4b535qP4lt14Lqfe8CY/anJJSD+iAnnUmF2FCe8=@lists.denx.de
X-Gm-Message-State: AOJu0YxvvIy5VfgTkcknBHCNO0mVHymRVkyevMdlu4WJMCzNKU/gtlIz
 xTa/kX5+LNwDEwMyrHmPEOoWXUGs+Kg1AUubqaeEjo/QQ8zixGxkFdrggqUz98tvQ4A=
X-Gm-Gg: Acq92OEIyWTR/1SUCXhxtA51Iprak290pt8OpoceoWd/3egX1O9pmpfwctkefNi6nJt
 eDvTGDMWXEn1XsJB8Iz5OENR8bBY0QttaKm6YXGMKfYNhsJpFfqJrrwP9PMdAHLqcJeRkkpgo5j
 uhoCu62uy460c9LRQY3t2SE2mzukJ5McJJBQfeKxrRlkSDL6u6OYB3neeC+Ck+qDL1QK2Zmp/Bm
 Rmvb5DZZUH7PcRr3C+w8r8e3fg/WEHPKn94SxLqDzwlJmXLxsLcawYKCSC2nyx31XclEjy10mNw
 8eE1T7aRDQ5VIte8jLxoQ9GHenSLuzJEjW7TxrTtHZbfspF9AJ+i5YJJR3plsslX+C9TmLeeEDu
 rezurNWoha4TgMWbyniibu+VN/mqmbzPgFTOzXekdrOJzwuD33RiqfFn0P4QX0gemQFovC5eeXo
 SISBUl3dcMi89lLB5dCaemq0MbL4c0IEDmzxHcOZnbOPKHTarvP2t/xS7p4U7InxKGpOmt4dHvH
 anSFwnBwtQdkeGjWQ==
X-Received: by 2002:a05:6000:2f83:b0:43b:3d02:7806 with SMTP id
 ffacd0b85a97d-45e5c58ed80mr25731158f8f.28.1779114880309; 
 Mon, 18 May 2026 07:34:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1029:e3c5:362e:1250?
 ([2a01:e0a:106d:1080:1029:e3c5:362e:1250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3b18fsm35055720f8f.11.2026.05.18.07.34.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 07:34:39 -0700 (PDT)
Message-ID: <ae2be551-c90d-426a-bfa7-215532e04448@linaro.org>
Date: Mon, 18 May 2026 16:34:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 03/15] Revert "test: smem: add basic smem test"
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
 <20260504-b4-modernise-smem-v2-3-c01ec2ff3886@linaro.org>
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
In-Reply-To: <20260504-b4-modernise-smem-v2-3-c01ec2ff3886@linaro.org>
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
> This reverts commit 20e7705764c4e5ea924f1ea54bb36ebbbeffffe7.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   test/dm/Makefile |  1 -
>   test/dm/smem.c   | 26 --------------------------
>   2 files changed, 27 deletions(-)
> 
> diff --git a/test/dm/Makefile b/test/dm/Makefile
> index 771b703b737d..ace149d4a2b4 100644
> --- a/test/dm/Makefile
> +++ b/test/dm/Makefile
> @@ -111,9 +111,8 @@ obj-$(CONFIG_SCSI) += scsi.o
>   obj-$(CONFIG_DM_SERIAL) += serial.o
>   obj-$(CONFIG_DM_SPI_FLASH) += sf.o
>   obj-$(CONFIG_SIMPLE_BUS) += simple-bus.o
>   obj-$(CONFIG_SIMPLE_PM_BUS) += simple-pm-bus.o
> -obj-$(CONFIG_SMEM) += smem.o
>   obj-$(CONFIG_SOC_DEVICE) += soc.o
>   obj-$(CONFIG_SOUND) += sound.o
>   obj-$(CONFIG_DM_SPI) += spi.o
>   obj-$(CONFIG_SPMI) += spmi.o
> diff --git a/test/dm/smem.c b/test/dm/smem.c
> deleted file mode 100644
> index 89e74cccc574..000000000000
> --- a/test/dm/smem.c
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Copyright (C) 2018 Ramon Fried <ramon.fried@gmail.com>
> - */
> -
> -#include <dm.h>
> -#include <smem.h>
> -#include <dm/test.h>
> -#include <test/test.h>
> -#include <test/ut.h>
> -
> -/* Basic test of the smem uclass */
> -static int dm_test_smem_base(struct unit_test_state *uts)
> -{
> -	struct udevice *dev;
> -	size_t size;
> -
> -	ut_assertok(uclass_get_device(UCLASS_SMEM, 0, &dev));
> -	ut_assertnonnull(dev);
> -	ut_assertok(smem_alloc(dev, -1, 0, 16));
> -	ut_asserteq(0, smem_get_free_space(dev, -1));
> -	ut_assertnull(smem_get(dev, -1, 0, &size));
> -
> -	return 0;
> -}
> -DM_TEST(dm_test_smem_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

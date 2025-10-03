Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30264CAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 11:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A721483710;
	Fri,  3 Oct 2025 13:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YrFYQY45";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A9E083759; Fri,  3 Oct 2025 13:38:14 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDE8383700
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 13:38:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e4ad36541so23992655e9.0
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 04:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759491491; x=1760096291; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Zpgfdvg20+Rtu4TZWg9/8Zn8sL0Y493ru2Se5uQsIyk=;
 b=YrFYQY45wmgF5dA21sHaEn7t2BeQugGs3BJnPYF0/Z6iwLLKNtXyvalWQOuSL8v/9P
 eJOPBMRMOz8b8psEKBZ9iMdHXIeYo0kByZuYrTW/Nf9HMEKJ3gNoqF0D7F6PtG4F3Xpz
 45IVRXkklQk66DrpQdm/5OuGoE23VE1DoTmcbaQtNmJGDF/RERcFEiRyLaExbYSbJn9R
 Dr/zQhOIMjEgJGGIVzJW5/6kzrmkaHo+btIBxRL19iredljgMbf8J43f3z3lYJuArMTv
 ThMZ0ahme8Jl1hA3wur/XgU57vsNFdgPN/9vtO8h5z6krInM5Khj2wVNxFzXYd/l8Cq6
 hVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759491491; x=1760096291;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Zpgfdvg20+Rtu4TZWg9/8Zn8sL0Y493ru2Se5uQsIyk=;
 b=kfghkVVtb7lHd8Cqq/pTJKpBoBHqmQntNjKOFu+LgBt4zcmQ/OYkyeoPCXqkKJsmth
 95CphHQG54FnJFNBrM6atQcGCZG1caodyKGCK9Tn1oRjtL7uJDwZwdZyNNERGJkcQzCY
 XKix6pFnPWA8cittCDkcGa8HRM8KoJKgNzKNQlN+7hA0EnuMIymOSrvrNmC4rfUHL8ON
 Eff2ukoAfTqUuZel+2UT8rfkSJV+73a2NRdi19Knrw9++XKF7FUl7d58xRBPWcvjlV8A
 U+G5rXAPVqziCWDsgOmHERbTXU8LEEMVOpz8EvGA5K2ys2GKTAcVY7eeFT8n+JDKbxge
 O8Uw==
X-Gm-Message-State: AOJu0YwCkqlusOJlRua4A+2VEhtqaaOQXQ9V9I6ZdMQ0tnvyuTXrd8U7
 UfrJ6I/n2A6c5n6M1XO/iSjICv+RxRgpiIw2Y+LvuUlUfgm5Zn+nKgDYqY8q30cGojmU4EqTax0
 nmX7U
X-Gm-Gg: ASbGncvWapc6i7uQuQ8JAdn4jCkp+BSCNFXg2NoHqbC1WVBFKVnCq+iw2UKz04gW9np
 BtP5i2RAzXt46dKi7bMAtUdSUYw2X70kimmBm2gSKQ2oXc/JaGbBIAGWHiUP6/ZvCXEBFtIbnxK
 LSgpPDflK0xLs18VBBa7VYrn4yx+q9TwaZbhI+nsffL/o981CPCuPCBqwEK5iCCJbh00ZZjNdeV
 7EIVZDgG0uxeQMK5ZouuuS6xeElqw93DjVnNmypPwOUXAEN+HlyzF+Nf01UdyeG/i/E1IiwmPZ7
 e/rJAeTzLSUuqrfKHwmdL8CEH1+Plidg1ty/wteyz83e2aw173nTz5QyG1tRcFy2P560UIV3Su0
 cAyYq6eH38Db+8nt5+CL19lxEKps/Mmb3+oHQjQI29ZyhB+DGBq9i5Y0sjp8JvONtvR5ZI3vIk0
 462J2voKHtIV1BY8s+FAAw39vkIeg=
X-Google-Smtp-Source: AGHT+IGmIPvS7yxHqzctcoLWJF3H+y8YrBDqQoKBkLYvde07kaYHtpBpaoN5BrF2EaHXB6UzfaZoxg==
X-Received: by 2002:a05:600c:1389:b0:45f:27fb:8016 with SMTP id
 5b1f17b1804b1-46e711043b1mr16175315e9.1.1759491490956; 
 Fri, 03 Oct 2025 04:38:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:1516:b5be:def8:9a0b?
 ([2a01:e0a:3d9:2080:1516:b5be:def8:9a0b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a029a0sm122873235e9.13.2025.10.03.04.38.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Oct 2025 04:38:10 -0700 (PDT)
Message-ID: <c8ad27f5-11d4-4d21-a2bd-543a9f95a792@linaro.org>
Date: Fri, 3 Oct 2025 13:38:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC 3/6] interconnect: add support for the Qualcomm RPMh
 helpers
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Bhupesh Sharma
 <bhupesh.linux@gmail.com>, Neha Malcom Francis <n-francis@ti.com>
Cc: u-boot-qcom@groups.io
References: <20251003-topic-interconnect-next-v1-0-955eef068b6e@linaro.org>
 <20251003-topic-interconnect-next-v1-3-955eef068b6e@linaro.org>
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
In-Reply-To: <20251003-topic-interconnect-next-v1-3-955eef068b6e@linaro.org>
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

On 10/3/25 10:56, Neil Armstrong wrote:
> The Qualcomm SoCs votes for common resources via the RPMh subsystem.
> 
> Implement the necessary helpers for Interconnect providers to add the
> nodes and vote via the RPPh "BCM" voters, which are vote endpoints for
> each SoC subsystems. The APPS (ARM subsystem) has a dedicated endpoint.
> 
> The BCM voter will aggregate all the bandwidth for all the nodes associated
> with a BCM voter, and internally the RPMh with allso aggregate all the votes
> from all the SoC subsystems for the same BCM voter.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/interconnect/Kconfig               |   6 +
>   drivers/interconnect/Makefile              |   1 +
>   drivers/interconnect/interconnect-uclass.c |  20 +-
>   drivers/interconnect/qcom/Kconfig          |   6 +
>   drivers/interconnect/qcom/Makefile         |   6 +
>   drivers/interconnect/qcom/bcm-voter.c      | 340 +++++++++++++++++++++++++++++
>   drivers/interconnect/qcom/bcm-voter.h      |  19 ++
>   drivers/interconnect/qcom/icc-rpmh.c       | 226 +++++++++++++++++++
>   drivers/interconnect/qcom/icc-rpmh.h       | 128 +++++++++++
>   9 files changed, 745 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> index 38d39651ab56d441070d3e19a4af60e44fc926d4..c7fa6860bb8dd6979a8a84863ea82f552b5e6995 100644
> --- a/drivers/interconnect/Kconfig
> +++ b/drivers/interconnect/Kconfig
> @@ -7,4 +7,10 @@ config INTERCONNECT
>   	  Enable support for the interconnect driver class. Many SoCs allow
>   	  bandwidth to be tuned on busses within the SoC.
>   
> +if INTERCONNECT
> +
> +source "drivers/interconnect/qcom/Kconfig"
> +
> +endif
> +
>   endmenu
> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
> index 1f276e980510e015e56465a48751b07e54d84f1a..db698579996c60fd7dccea3b153d072c08cd8e4f 100644
> --- a/drivers/interconnect/Makefile
> +++ b/drivers/interconnect/Makefile
> @@ -4,3 +4,4 @@
>   #
>   
>   obj-$(CONFIG_$(PHASE_)INTERCONNECT) += interconnect-uclass.o
> +obj-y += qcom/
> diff --git a/drivers/interconnect/interconnect-uclass.c b/drivers/interconnect/interconnect-uclass.c
> index 4f2420b02b21af0decec0fe24bc40c1a984fe55e..74fafcbce2946412e51dc8f1343c7b9b74473102 100644
> --- a/drivers/interconnect/interconnect-uclass.c
> +++ b/drivers/interconnect/interconnect-uclass.c
> @@ -124,6 +124,9 @@ void icc_put(struct icc_path *path)
>   
>   	for (i = 0; i < path->num_nodes; i++) {
>   		node = path->reqs[i].node;
> +
> +		device_remove(node->dev, DM_REMOVE_NORMAL);
> +
>   		hlist_del(&path->reqs[i].req_node);
>   		if (node->provider->users)
>   			node->provider->users--;
> @@ -266,7 +269,8 @@ static struct icc_path *icc_path_init(struct icc_node *dst, ssize_t num_nodes)
>   {
>   	struct icc_node *node = dst;
>   	struct icc_path *path;
> -	int i;
> +	struct udevice *dev;
> +	int i, ret;
>   
>   	path = calloc(sizeof(struct icc_req), num_nodes);
>   	if (!path)
> @@ -280,6 +284,12 @@ static struct icc_path *icc_path_init(struct icc_node *dst, ssize_t num_nodes)
>   		debug("%s: req %s\n", __func__, node->dev->name);
>   		path->reqs[i].node = node;
>   		path->reqs[i].enabled = true;
> +
> +		/* Probe this node since used in an active path */
> +		ret = uclass_get_device_tail(node->dev, 0, &dev);
> +		if (ret)
> +			return ERR_PTR(ret);
> +
>   		/* reference to previous node was saved during path traversal */
>   		node = node->reverse;
>   	}
> @@ -444,9 +454,6 @@ struct icc_node *icc_node_create(const struct icc_provider *provider,
>   
>   	device_set_name_alloced(dev);
>   
> -	ret = uclass_get_device_tail(dev, 0, &dev);
> -	if (ret)
> -		return ERR_PTR(ret);
>   
>   	node = dev_get_uclass_plat(dev);
>   	node->id = id;
> @@ -515,7 +522,6 @@ static int interconnect_pre_remove(struct udevice *dev)
>   
>   	list_for_each_entry_safe_reverse(n, tmp, &provider->nodes, node_list) {
>   		list_del(&n->node_list);
> -		device_remove(n->dev, DM_REMOVE_NORMAL);
>   		device_unbind(n->dev);
>   	}
>   
> @@ -524,7 +530,7 @@ static int interconnect_pre_remove(struct udevice *dev)
>   	return 0;
>   }
>   
> -static int icc_node_pre_remove(struct udevice *dev)
> +static int icc_node_pre_unbind(struct udevice *dev)
>   {
>   	struct icc_node *node = dev_get_uclass_plat(dev);
>   
> @@ -549,6 +555,6 @@ U_BOOT_DRIVER(icc_node) = {
>   UCLASS_DRIVER(icc_node) = {
>   	.id		= UCLASS_ICC_NODE,
>   	.name		= "icc_node",
> -	.pre_remove	= icc_node_pre_remove,
> +	.pre_unbind	= icc_node_pre_unbind,
>   	.per_device_plat_auto = sizeof(struct icc_node),
>   };

Oops those changes should be squashed on the previous patch.

Neil

> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..ab5b19567ec783a8d3dd11776fa7015fd9e59462
> --- /dev/null
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -0,0 +1,6 @@
> +config INTERCONNECT_QCOM_RPMH
> +	bool "Enable interconnect support for SoCs with RPMh"
> +	depends on QCOM_RPMH
> +	help
> +	  Enable support for the interconnect helpers to vote with
> +	  the RPMh subsystems in Qualcomm SoCs
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..4369ca07f611f9a61103f6aa893841e137e68aea
> --- /dev/null
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (c) 2025 Linaro Limited
> +#
> +
> +obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_RPMH) += icc-rpmh.o bcm-voter.o
> diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..361b03f207a9f0e0629d1a95b9bb35d218a576f3
> --- /dev/null
> +++ b/drivers/interconnect/qcom/bcm-voter.c
> @@ -0,0 +1,340 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2025 Linaro Limited
> + */
> +
> +#include <dm.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <linux/err.h>
> +#include <div64.h>
> +#include <dm/device_compat.h>
> +#include <linux/list_sort.h>
> +
> +#include "bcm-voter.h"
> +
> +/* TODO drop WAKE/SLEEP buckets fills if we really don't need them */
> +
> +/**
> + * struct bcm_voter - Bus Clock Manager voter
> + * @dev: reference to the device that communicates with the BCM
> + * @np: reference to the device node to match bcm voters
> + * @commit_list: list containing bcms to be committed to hardware
> + * @ws_list: list containing bcms that have different wake/sleep votes
> + * @voter_node: list of bcm voters
> + * @tcs_wait: mask for which buckets require TCS completion
> + */
> +struct bcm_voter {
> +	struct udevice *dev;
> +	struct list_head commit_list;
> +	struct list_head ws_list;
> +	u32 tcs_wait;
> +};
> +
> +static int cmp_vcd(void *priv, struct list_head *a, struct list_head *b)
> +{
> +	struct qcom_icc_bcm *bcm_a = list_entry(a, struct qcom_icc_bcm, list);
> +	struct qcom_icc_bcm *bcm_b = list_entry(b, struct qcom_icc_bcm, list);
> +
> +	return bcm_a->aux_data.vcd - bcm_b->aux_data.vcd;
> +}
> +
> +static u64 bcm_div(u64 num, u32 base)
> +{
> +	/* Ensure that small votes aren't lost. */
> +	if (num && num < base)
> +		return 1;
> +
> +	do_div(num, base);
> +
> +	return num;
> +}
> +
> +/* BCMs with enable_mask use one-hot-encoding for on/off signaling */
> +static void bcm_aggregate_mask(struct qcom_icc_bcm *bcm)
> +{
> +	struct qcom_icc_node *node;
> +	int bucket, i;
> +
> +	for (bucket = 0; bucket < QCOM_ICC_NUM_BUCKETS; bucket++) {
> +		bcm->vote_x[bucket] = 0;
> +		bcm->vote_y[bucket] = 0;
> +
> +		for (i = 0; i < bcm->num_nodes; i++) {
> +			node = bcm->nodes[i];
> +
> +			/* If any vote in this bucket exists, keep the BCM enabled */
> +			if (node->sum_avg[bucket] || node->max_peak[bucket]) {
> +				bcm->vote_x[bucket] = 0;
> +				bcm->vote_y[bucket] = bcm->enable_mask;
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (bcm->keepalive) {
> +		bcm->vote_x[QCOM_ICC_BUCKET_AMC] = bcm->enable_mask;
> +		bcm->vote_x[QCOM_ICC_BUCKET_WAKE] = bcm->enable_mask;
> +		bcm->vote_y[QCOM_ICC_BUCKET_AMC] = bcm->enable_mask;
> +		bcm->vote_y[QCOM_ICC_BUCKET_WAKE] = bcm->enable_mask;
> +	}
> +}
> +
> +static void bcm_aggregate(struct qcom_icc_bcm *bcm)
> +{
> +	struct qcom_icc_node *node;
> +	size_t i, bucket;
> +	u64 agg_avg[QCOM_ICC_NUM_BUCKETS] = {0};
> +	u64 agg_peak[QCOM_ICC_NUM_BUCKETS] = {0};
> +	u64 temp;
> +
> +	for (bucket = 0; bucket < QCOM_ICC_NUM_BUCKETS; bucket++) {
> +		for (i = 0; i < bcm->num_nodes; i++) {
> +			node = bcm->nodes[i];
> +			temp = bcm_div(node->sum_avg[bucket] * bcm->aux_data.width,
> +				       node->buswidth * node->channels);
> +			agg_avg[bucket] = max(agg_avg[bucket], temp);
> +
> +			temp = bcm_div(node->max_peak[bucket] * bcm->aux_data.width,
> +				       node->buswidth);
> +			agg_peak[bucket] = max(agg_peak[bucket], temp);
> +		}
> +
> +		temp = agg_avg[bucket] * bcm->vote_scale;
> +		bcm->vote_x[bucket] = bcm_div(temp, bcm->aux_data.unit);
> +
> +		temp = agg_peak[bucket] * bcm->vote_scale;
> +		bcm->vote_y[bucket] = bcm_div(temp, bcm->aux_data.unit);
> +	}
> +
> +	if (bcm->keepalive && bcm->vote_x[QCOM_ICC_BUCKET_AMC] == 0 &&
> +	    bcm->vote_y[QCOM_ICC_BUCKET_AMC] == 0) {
> +		bcm->vote_x[QCOM_ICC_BUCKET_AMC] = 1;
> +		bcm->vote_x[QCOM_ICC_BUCKET_WAKE] = 1;
> +		bcm->vote_y[QCOM_ICC_BUCKET_AMC] = 1;
> +		bcm->vote_y[QCOM_ICC_BUCKET_WAKE] = 1;
> +	}
> +}
> +
> +static inline void tcs_cmd_gen(struct tcs_cmd *cmd, u64 vote_x, u64 vote_y,
> +			       u32 addr, bool commit, bool wait)
> +{
> +	bool valid = true;
> +
> +	if (!cmd)
> +		return;
> +
> +	memset(cmd, 0, sizeof(*cmd));
> +
> +	if (vote_x == 0 && vote_y == 0)
> +		valid = false;
> +
> +	if (vote_x > BCM_TCS_CMD_VOTE_MASK)
> +		vote_x = BCM_TCS_CMD_VOTE_MASK;
> +
> +	if (vote_y > BCM_TCS_CMD_VOTE_MASK)
> +		vote_y = BCM_TCS_CMD_VOTE_MASK;
> +
> +	cmd->addr = addr;
> +	cmd->data = BCM_TCS_CMD(commit, valid, vote_x, vote_y);
> +
> +	/*
> +	 * Set the wait for completion flag on command that need to be completed
> +	 * before the next command.
> +	 */
> +	cmd->wait = wait;
> +}
> +
> +static void tcs_list_gen(struct bcm_voter *voter, int bucket,
> +			 struct tcs_cmd tcs_list[MAX_VCD],
> +			 int n[MAX_VCD + 1])
> +{
> +	struct list_head *bcm_list = &voter->commit_list;
> +	struct qcom_icc_bcm *bcm;
> +	bool commit, wait;
> +	size_t idx = 0, batch = 0, cur_vcd_size = 0;
> +
> +	memset(n, 0, sizeof(int) * (MAX_VCD + 1));
> +
> +	list_for_each_entry(bcm, bcm_list, list) {
> +		commit = false;
> +		cur_vcd_size++;
> +		if ((list_is_last(&bcm->list, bcm_list)) ||
> +		    bcm->aux_data.vcd != list_next_entry(bcm, list)->aux_data.vcd) {
> +			commit = true;
> +			cur_vcd_size = 0;
> +		}
> +
> +		wait = commit && (voter->tcs_wait & BIT(bucket));
> +
> +		tcs_cmd_gen(&tcs_list[idx], bcm->vote_x[bucket],
> +			    bcm->vote_y[bucket], bcm->addr, commit, wait);
> +		idx++;
> +		n[batch]++;
> +		/*
> +		 * Batch the BCMs in such a way that we do not split them in
> +		 * multiple payloads when they are under the same VCD. This is
> +		 * to ensure that every BCM is committed since we only set the
> +		 * commit bit on the last BCM request of every VCD.
> +		 */
> +		if (n[batch] >= MAX_RPMH_PAYLOAD) {
> +			if (!commit) {
> +				n[batch] -= cur_vcd_size;
> +				n[batch + 1] = cur_vcd_size;
> +			}
> +			batch++;
> +		}
> +	}
> +}
> +
> +/**
> + * of_bcm_voter_get - gets a bcm voter handle from DT node
> + * @dev: device pointer for the consumer device
> + * @name: name for the bcm voter device
> + *
> + * This function will match a device_node pointer for the phandle
> + * specified in the device DT and return a bcm_voter handle on success.
> + *
> + * Returns bcm_voter pointer or ERR_PTR() on error. EPROBE_DEFER is returned
> + * when matching bcm voter is yet to be found.
> + */
> +struct bcm_voter *of_bcm_voter_get(struct udevice *dev, const char *name)
> +{
> +	struct ofnode_phandle_args args;
> +	struct udevice *bcm_dev;
> +	int ret, idx = 0;
> +
> +	if (name) {
> +		idx = dev_read_stringlist_search(dev, "qcom,bcm-voter-names", name);
> +		if (idx < 0)
> +			return ERR_PTR(idx);
> +	}
> +
> +	ret = dev_read_phandle_with_args(dev, "qcom,bcm-voters", NULL, 0,
> +					 idx, &args);
> +	if (ret)
> +		return ERR_PTR(idx);
> +
> +	ret = uclass_get_device_by_ofnode(UCLASS_MISC, args.node,
> +					  &bcm_dev);
> +	if (ret) {
> +		debug("%s: uclass_get_device_by_ofnode failed: %d\n",
> +		      __func__, ret);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return dev_get_priv(bcm_dev);
> +}
> +
> +/**
> + * qcom_icc_bcm_voter_add - queues up the bcm nodes that require updates
> + * @voter: voter that the bcms are being added to
> + * @bcm: bcm to add to the commit and wake sleep list
> + */
> +void qcom_icc_bcm_voter_add(struct bcm_voter *voter, struct qcom_icc_bcm *bcm)
> +{
> +	if (!voter)
> +		return;
> +
> +	if (list_empty(&bcm->list))
> +		list_add_tail(&bcm->list, &voter->commit_list);
> +
> +	if (list_empty(&bcm->ws_list))
> +		list_add_tail(&bcm->ws_list, &voter->ws_list);
> +}
> +
> +/**
> + * qcom_icc_bcm_voter_commit - generates and commits tcs cmds based on bcms
> + * @voter: voter that needs flushing
> + *
> + * This function generates a set of AMC commands and flushes to the BCM device
> + * associated with the voter. It conditionally generate WAKE and SLEEP commands
> + * based on deltas between WAKE/SLEEP requirements. The ws_list persists
> + * through multiple commit requests and bcm nodes are removed only when the
> + * requirements for WAKE matches SLEEP.
> + *
> + * Returns 0 on success, or an appropriate error code otherwise.
> + */
> +int qcom_icc_bcm_voter_commit(struct bcm_voter *voter)
> +{
> +	struct qcom_icc_bcm *bcm;
> +	struct qcom_icc_bcm *bcm_tmp;
> +	int commit_idx[MAX_VCD + 1];
> +	struct tcs_cmd cmds[MAX_BCMS];
> +	int ret = 0;
> +
> +	if (!voter)
> +		return 0;
> +
> +	list_for_each_entry(bcm, &voter->commit_list, list) {
> +		if (bcm->enable_mask)
> +			bcm_aggregate_mask(bcm);
> +		else
> +			bcm_aggregate(bcm);
> +	}
> +
> +	/*
> +	 * Pre sort the BCMs based on VCD for ease of generating a command list
> +	 * that groups the BCMs with the same VCD together. VCDs are numbered
> +	 * with lowest being the most expensive time wise, ensuring that
> +	 * those commands are being sent the earliest in the queue. This needs
> +	 * to be sorted every commit since we can't guarantee the order in which
> +	 * the BCMs are added to the list.
> +	 */
> +	list_sort(NULL, &voter->commit_list, cmp_vcd);
> +
> +	/*
> +	 * Construct the command list based on a pre ordered list of BCMs
> +	 * based on VCD.
> +	 */
> +	tcs_list_gen(voter, QCOM_ICC_BUCKET_AMC, cmds, commit_idx);
> +	if (!commit_idx[0])
> +		goto out;
> +
> +	for (int i = 0 ; commit_idx[i] ; ++i) {
> +		ret = rpmh_write(voter->dev, RPMH_ACTIVE_ONLY_STATE,
> +				 &cmds[i], commit_idx[i]);
> +		if (ret) {
> +			pr_err("Error sending AMC RPMH requests (%d)\n", ret);
> +			goto out;
> +		}
> +	}
> +
> +	/* TOFIX vote for WAKE & SLEEP ?? */
> +
> +out:
> +	list_for_each_entry_safe(bcm, bcm_tmp, &voter->commit_list, list)
> +		list_del_init(&bcm->list);
> +
> +	return ret;
> +}
> +
> +static int qcom_icc_bcm_voter_probe(struct udevice *dev)
> +{
> +	struct bcm_voter *voter = dev_get_priv(dev);
> +
> +	voter->dev = dev;
> +
> +	if (dev_read_u32(dev, "qcom,tcs-wait", &voter->tcs_wait))
> +		voter->tcs_wait = QCOM_ICC_TAG_ACTIVE_ONLY;
> +
> +	INIT_LIST_HEAD(&voter->commit_list);
> +	INIT_LIST_HEAD(&voter->ws_list);
> +
> +	return 0;
> +}
> +
> +static const struct udevice_id qcom_icc_bcm_voter_ids[] = {
> +	{ .compatible = "qcom,bcm-voter" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(qcom_icc_bcm_voter) = {
> +	.name		= "qcom_bcm_voter",
> +	.id		= UCLASS_MISC,
> +	.priv_auto	= sizeof(struct bcm_voter),
> +	.probe		= qcom_icc_bcm_voter_probe,
> +	.of_match	= qcom_icc_bcm_voter_ids,
> +};
> diff --git a/drivers/interconnect/qcom/bcm-voter.h b/drivers/interconnect/qcom/bcm-voter.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..5acb5822e0e04c5d4e0ca553397692d1fd919c51
> --- /dev/null
> +++ b/drivers/interconnect/qcom/bcm-voter.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef __DRIVERS_INTERCONNECT_QCOM_BCM_VOTER_H__
> +#define __DRIVERS_INTERCONNECT_QCOM_BCM_VOTER_H__
> +
> +#include <soc/qcom/cmd-db.h>
> +#include <soc/qcom/rpmh.h>
> +#include <soc/qcom/tcs.h>
> +
> +#include "icc-rpmh.h"
> +
> +struct bcm_voter *of_bcm_voter_get(struct udevice *dev, const char *name);
> +void qcom_icc_bcm_voter_add(struct bcm_voter *voter, struct qcom_icc_bcm *bcm);
> +int qcom_icc_bcm_voter_commit(struct bcm_voter *voter);
> +
> +#endif
> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..fb90b8f05440357e167b7fad8fb93c0ae1d74fc9
> --- /dev/null
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -0,0 +1,226 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2025 Linaro Limited
> + */
> +
> +#include <dm.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <interconnect-uclass.h>
> +#include <dt-bindings/interconnect/qcom,icc.h>
> +#include <linux/err.h>
> +#include <dm/device_compat.h>
> +
> +#include "icc-rpmh.h"
> +#include "bcm-voter.h"
> +
> +static inline struct qcom_icc_provider *to_qcom_provider(struct icc_provider *provider)
> +{
> +	return dev_get_priv(provider->dev);
> +}
> +
> +static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
> +{
> +	struct qcom_icc_provider *qp;
> +	struct icc_node *node;
> +
> +	if (!src)
> +		node = dst;
> +	else
> +		node = src;
> +
> +	qp = to_qcom_provider(node->provider);
> +	qcom_icc_bcm_voter_commit(qp->voter);
> +
> +	return 0;
> +}
> +
> +static int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
> +			      u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
> +{
> +	size_t i;
> +	struct qcom_icc_node *qn;
> +
> +	qn = node->data;
> +
> +	if (!tag)
> +		tag = QCOM_ICC_TAG_ALWAYS;
> +
> +	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
> +		if (tag & BIT(i)) {
> +			qn->sum_avg[i] += avg_bw;
> +			qn->max_peak[i] = max_t(u32, qn->max_peak[i], peak_bw);
> +		}
> +
> +		if (node->init_avg || node->init_peak) {
> +			qn->sum_avg[i] = max_t(u64, qn->sum_avg[i], node->init_avg);
> +			qn->max_peak[i] = max_t(u64, qn->max_peak[i], node->init_peak);
> +		}
> +	}
> +
> +	*agg_avg += avg_bw;
> +	*agg_peak = max_t(u32, *agg_peak, peak_bw);
> +
> +	return 0;
> +}
> +
> +static void qcom_icc_pre_aggregate(struct icc_node *node)
> +{
> +	size_t i;
> +	struct qcom_icc_node *qn;
> +	struct qcom_icc_provider *qp;
> +
> +	qn = node->data;
> +	qp = to_qcom_provider(node->provider);
> +
> +	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
> +		qn->sum_avg[i] = 0;
> +		qn->max_peak[i] = 0;
> +	}
> +
> +	for (i = 0; i < qn->num_bcms; i++)
> +		qcom_icc_bcm_voter_add(qp->voter, qn->bcms[i]);
> +}
> +
> +static struct icc_node *qcom_icc_xlate(struct udevice *dev,
> +				       const struct ofnode_phandle_args *spec)
> +{
> +	struct icc_provider *priv = dev_get_uclass_plat(dev);
> +	unsigned int idx = spec->args[0];
> +
> +	if (idx >= priv->xlate_num_nodes) {
> +		pr_err("%s: invalid index %u\n", __func__, idx);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	return priv->xlate_nodes[idx];
> +}
> +
> +static bool qcom_icc_has_node_id(struct udevice *dev, int id)
> +{
> +	const struct qcom_icc_desc *desc = (const struct qcom_icc_desc *)dev_get_driver_data(dev);
> +	int i;
> +
> +	for (i = 0; i < desc->num_nodes; i++)
> +		if (desc->nodes[i] && desc->nodes[i]->id == id)
> +			return true;
> +
> +	return false;
> +}
> +
> +struct interconnect_ops qcom_icc_rpmh_ops = {
> +	.set = qcom_icc_set,
> +	.pre_aggregate = qcom_icc_pre_aggregate,
> +	.aggregate = qcom_icc_aggregate,
> +	.of_xlate = qcom_icc_xlate,
> +	.has_node_id = qcom_icc_has_node_id,
> +};
> +
> +/**
> + * qcom_icc_bcm_init - populates bcm aux data and connect qnodes
> + * @bcm: bcm to be initialized
> + * @dev: associated provider device
> + *
> + * Return: 0 on success, or an error code otherwise
> + */
> +int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct udevice *dev)
> +{
> +	struct qcom_icc_node *qn;
> +	const struct bcm_db *data;
> +	size_t data_count;
> +	int i;
> +
> +	/* BCM is already initialised*/
> +	if (bcm->addr)
> +		return 0;
> +
> +	bcm->addr = cmd_db_read_addr(bcm->name);
> +	if (!bcm->addr) {
> +		dev_err(dev, "%s could not find RPMh address\n",
> +			bcm->name);
> +		return -EINVAL;
> +	}
> +
> +	data = cmd_db_read_aux_data(bcm->name, &data_count);
> +	if (IS_ERR(data)) {
> +		dev_err(dev, "%s command db read error (%ld)\n",
> +			bcm->name, PTR_ERR(data));
> +		return PTR_ERR(data);
> +	}
> +	if (!data_count) {
> +		dev_err(dev, "%s command db missing or partial aux data\n",
> +			bcm->name);
> +		return -EINVAL;
> +	}
> +
> +	bcm->aux_data.unit = le32_to_cpu(data->unit);
> +	bcm->aux_data.width = le16_to_cpu(data->width);
> +	bcm->aux_data.vcd = data->vcd;
> +	bcm->aux_data.reserved = data->reserved;
> +	INIT_LIST_HEAD(&bcm->list);
> +	INIT_LIST_HEAD(&bcm->ws_list);
> +
> +	if (!bcm->vote_scale)
> +		bcm->vote_scale = 1000;
> +
> +	/* Link Qnodes to their respective BCMs */
> +	for (i = 0; i < bcm->num_nodes; i++) {
> +		qn = bcm->nodes[i];
> +		qn->bcms[qn->num_bcms] = bcm;
> +		qn->num_bcms++;
> +	}
> +
> +	return 0;
> +}
> +
> +int qcom_icc_rpmh_probe(struct udevice *dev)
> +{
> +	struct icc_provider *priv = dev_get_uclass_plat(dev);
> +	struct qcom_icc_provider *qp = dev_get_priv(dev);
> +	struct qcom_icc_node * const *qnodes, *qn;
> +	struct icc_node *node;
> +	size_t num_nodes, i, j;
> +
> +	qp->desc = (const struct qcom_icc_desc *)dev_get_driver_data(dev);
> +	if (!qp->desc)
> +		return -EINVAL;
> +
> +	qnodes = qp->desc->nodes;
> +	num_nodes = qp->desc->num_nodes;
> +
> +	priv->xlate_num_nodes = num_nodes;
> +	priv->xlate_nodes = calloc(sizeof(node), num_nodes);
> +	if (!priv->xlate_nodes)
> +		return -ENOMEM;
> +
> +	qp->dev = dev;
> +
> +	qp->voter = of_bcm_voter_get(qp->dev, NULL);
> +	if (IS_ERR(qp->voter))
> +		return PTR_ERR(qp->voter);
> +
> +	for (i = 0; i < qp->desc->num_bcms; i++)
> +		qcom_icc_bcm_init(qp->desc->bcms[i], dev);
> +
> +	for (i = 0; i < num_nodes; i++) {
> +		qn = qnodes[i];
> +		if (!qn)
> +			continue;
> +
> +		node = icc_node_create(priv, qn->id, qn->name);
> +		if (IS_ERR(node))
> +			return PTR_ERR(node);
> +
> +		node->data = qn;
> +		icc_node_add(node, priv);
> +
> +		for (j = 0; j < qn->num_links; j++)
> +			icc_link_create(node, qn->links[j]);
> +
> +		priv->xlate_nodes[i] = node;
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..2fe145a99cfc766e972d4ca1c726e4fc9e415222
> --- /dev/null
> +++ b/drivers/interconnect/qcom/icc-rpmh.h
> @@ -0,0 +1,128 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef __DRIVERS_INTERCONNECT_QCOM_ICC_RPMH_H__
> +#define __DRIVERS_INTERCONNECT_QCOM_ICC_RPMH_H__
> +
> +#include <dt-bindings/interconnect/qcom,icc.h>
> +
> +/**
> + * struct qcom_icc_provider - Qualcomm specific interconnect provider
> + * @dev:
> + * @desc:
> + */
> +struct qcom_icc_provider {
> +	struct udevice *dev;
> +	const struct qcom_icc_desc *desc;
> +	struct bcm_voter *voter;
> +};
> +
> +/**
> + * struct bcm_db - Auxiliary data pertaining to each Bus Clock Manager (BCM)
> + * @unit: divisor used to convert bytes/sec bw value to an RPMh msg
> + * @width: multiplier used to convert bytes/sec bw value to an RPMh msg
> + * @vcd: virtual clock domain that this bcm belongs to
> + * @reserved: reserved field
> + */
> +struct bcm_db {
> +	__le32 unit;
> +	__le16 width;
> +	u8 vcd;
> +	u8 reserved;
> +};
> +
> +#define MAX_PORTS		2
> +
> +#define MAX_LINKS		128
> +#define MAX_BCMS		64
> +#define MAX_BCM_PER_NODE	3
> +#define MAX_VCD			10
> +
> +/**
> + * struct qcom_icc_node - Qualcomm specific interconnect nodes
> + * @name: the node name used in debugfs
> + * @links: an array of nodes where we can go next while traversing
> + * @id: a unique node identifier
> + * @link_nodes: links associated with this node
> + * @node: icc_node associated with this node
> + * @num_links: the total number of @links
> + * @channels: num of channels at this node
> + * @buswidth: width of the interconnect between a node and the bus
> + * @sum_avg: current sum aggregate value of all avg bw requests
> + * @max_peak: current max aggregate value of all peak bw requests
> + * @bcms: list of bcms associated with this logical node
> + * @num_bcms: num of @bcms
> + */
> +struct qcom_icc_node {
> +	const char *name;
> +	u16 links[MAX_LINKS];
> +	u16 id;
> +	struct qcom_icc_node **link_nodes;
> +	struct icc_node *node;
> +	u16 num_links;
> +	u16 channels;
> +	u16 buswidth;
> +	u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
> +	u64 max_peak[QCOM_ICC_NUM_BUCKETS];
> +	struct qcom_icc_bcm *bcms[MAX_BCM_PER_NODE];
> +	size_t num_bcms;
> +};
> +
> +/**
> + * struct qcom_icc_bcm - Qualcomm specific hardware accelerator nodes
> + * known as Bus Clock Manager (BCM)
> + * @name: the bcm node name used to fetch BCM data from command db
> + * @type: latency or bandwidth bcm
> + * @addr: address offsets used when voting to RPMH
> + * @vote_x: aggregated threshold values, represents sum_bw when @type is bw bcm
> + * @vote_y: aggregated threshold values, represents peak_bw when @type is bw bcm
> + * @vote_scale: scaling factor for vote_x and vote_y
> + * @enable_mask: optional mask to send as vote instead of vote_x/vote_y
> + * @dirty: flag used to indicate whether the bcm needs to be committed
> + * @keepalive: flag used to indicate whether a keepalive is required
> + * @aux_data: auxiliary data used when calculating threshold values and
> + * communicating with RPMh
> + * @list: used to link to other bcms when compiling lists for commit
> + * @ws_list: used to keep track of bcms that may transition between wake/sleep
> + * @num_nodes: total number of @num_nodes
> + * @nodes: list of qcom_icc_nodes that this BCM encapsulates
> + */
> +struct qcom_icc_bcm {
> +	const char *name;
> +	u32 type;
> +	u32 addr;
> +	u64 vote_x[QCOM_ICC_NUM_BUCKETS];
> +	u64 vote_y[QCOM_ICC_NUM_BUCKETS];
> +	u64 vote_scale;
> +	u32 enable_mask;
> +	bool dirty;
> +	bool keepalive;
> +	struct bcm_db aux_data;
> +	struct list_head list;
> +	struct list_head ws_list;
> +	size_t num_nodes;
> +	struct qcom_icc_node *nodes[];
> +};
> +
> +struct qcom_icc_fabric {
> +	struct qcom_icc_node **nodes;
> +	size_t num_nodes;
> +};
> +
> +struct qcom_icc_desc {
> +	const struct regmap_config *config;
> +	struct qcom_icc_node * const *nodes;
> +	size_t num_nodes;
> +	struct qcom_icc_bcm * const *bcms;
> +	size_t num_bcms;
> +	bool qos_requires_clocks;
> +	bool alloc_dyn_id;
> +};
> +
> +extern struct interconnect_ops qcom_icc_rpmh_ops;
> +int qcom_icc_rpmh_probe(struct udevice *dev);
> +
> +#endif
> 


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3AAC44527
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 09:42:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA1DD844F6;
	Mon, 20 Jul 2026 11:42:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iu5Xk7sE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC6A6846B0; Mon, 20 Jul 2026 11:42:34 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3D4180517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:42:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49547fc63a0so12885625e9.2
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 02:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784540552; x=1785145352; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Td+ZecpWjOP1gNxRhZZoR/XsrX5XUXLZbD0/nQNr+iU=;
 b=iu5Xk7sEy4SUTpYdpssGeK/BOr5hFT/u4VrJVxBIvLDBxdPR4OP9TqKzYWPNrTL48Q
 nUATMOG7XQLAB+H9nXgZCHIkTE8P/regmhV2qXhP6glomju/R/RQtj+f0zPd6y6iaFqS
 gvQGxeikdEBXerYO4IfVJRsBieYtCext3Ai8TtNiwAO8KLWe0apUpMH5VRiSJG3C76Hx
 S/ij5SFLxC9plUUb1qlaY6cs+/4+FhR+btAPerKbY4pMGaKtwql/CNklxmED3D3il7x/
 kqUjAjmjNH4Lkmf1mgrR2Ge1RKCRQhGWneWJkXTTKGxqO/7IY1mJB9M2FKuCZxhNwHZU
 iteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784540552; x=1785145352;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Td+ZecpWjOP1gNxRhZZoR/XsrX5XUXLZbD0/nQNr+iU=;
 b=S0VwWHR3twmy1OF/OBu3zbI3L8tcbG7yYdtKFNjKOeZRtMds1iy3B3dBuJQ2A0arum
 XGIQQdDUlsJDlMyVe3/wctGjcIkt1TPXV7B4HaEX4uB/Or6+hszXHZImCleVBO/p3+ER
 X+3WdWNsgFipkOeWYEZbbgXUIUUNCon1IccW5Oi/yImbDPgttAA3OMb6NPZQYlefbrJ3
 KdA3AmMod0EkD4HgANeMbAfmLmqVLNYs3SpS/JtS8f5OEBNDmYAJgDG3SJ++MouTR2FW
 HfCKh0tnz2A5+G/FEyYPrEAGhuzrLVbWeGET6MBKUIqSuk8ZtAgPAk+VPC1s+14J+ncD
 CvDg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr8OsyizFMCAM6yZul4eWihg9vCgBEu92iU13CBilprZaePvOdkBS/3llPLNHTrwGK7cwOalH0=@lists.denx.de
X-Gm-Message-State: AOJu0YyJE1bXOX9hHY67DBy0vA/dpodvdH/odofYyr11XGOnsHLAdL0j
 bKpoxXp8LJYcRtH/abbJ2esSgoOq9zS1MQAZNnu08JQzWfLDUcATAj8Tz8z0iEn6aqI=
X-Gm-Gg: AfdE7ckQOrT+UDms1mTR9W2upeqK5hsQkE4jGtGkPcueuxD8JmNtCTndcveQ7wHcYut
 lwaOGNaWVKsfJZZ9j8lGN/IOHndnR07X3azGGH8G37ZgxJwl6/hMqUCH5Ubml7OoIzkAvnoWIXu
 chzj+yjGNhDgnsrF6QTNoLOKpsZ58kpqPk/sw9UAfYhI3qayXi5gUrRgSc54Jwx5jpqzicJsVf0
 wLmSG2ky6EXeEDK9dvHlFsm25/RlMdzU5ktabQ8A8L0A5YrnJ0qM4Dgwa/284XNz67wUP6mpw0W
 uAHgAu8wBUfkfmqv8xVZJpuh7g/nwSo8Pqsbox9fqUghf9pjzQVnv8uOXepJEd6txGR5KHHDzpu
 vrB4JH+34zh/XVOsn181dq5nvMz5J1myXNiZFGSJEhP0++AQsrVVqEEwVI16p5eVpqgLGkB8Ym2
 NER/w1+4oBdTxGlnCHRsbb6pu5Jm8qTyJl12KfEg2ymNLS/0E2y3I+ReK/01ND2/pyP30T
X-Received: by 2002:a05:600c:1382:b0:495:49da:e15a with SMTP id
 5b1f17b1804b1-4954a40d1d4mr141323665e9.30.1784540551972; 
 Mon, 20 Jul 2026 02:42:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6048:6804:bc89:a6b1?
 ([2a01:e0a:106d:1080:6048:6804:bc89:a6b1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2e8529sm257472345e9.11.2026.07.20.02.42.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 02:42:31 -0700 (PDT)
Message-ID: <9c8fa6c1-3d03-44e1-be58-8cef38979073@linaro.org>
Date: Mon, 20 Jul 2026 11:42:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 5/7] drivers: nvme: Export nvme_shutdown()
To: dmukhin@ford.com, u-boot@lists.denx.de
Cc: seanga2@gmail.com, sjg@chromium.org, trini@konsulko.com
References: <20260716223401.378989-1-dmukhin@ford.com>
 <20260716223401.378989-6-dmukhin@ford.com>
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
In-Reply-To: <20260716223401.378989-6-dmukhin@ford.com>
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

On 7/17/26 00:33, dmukhin@ford.com wrote:
> From: Denis Mukhin <dmukhin@ford.com>
> 
> Make nvme_shutdown() public so that it can be re-used in
> board-specific board_quiesce_devices() before OS hand-off.
> 
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> ---
> Changes since v2:
> - fixup for apple device
> 
> Changes since v1:
> - n/a
> ---
>   drivers/nvme/nvme.h       |  7 -------
>   drivers/nvme/nvme_apple.c |  1 +
>   include/nvme.h            | 11 +++++++++++
>   3 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/nvme.h b/drivers/nvme/nvme.h
> index a938da728506..cc1477717391 100644
> --- a/drivers/nvme/nvme.h
> +++ b/drivers/nvme/nvme.h
> @@ -703,11 +703,4 @@ struct nvme_ops {
>    */
>   int nvme_init(struct udevice *udev);
>   
> -/**
> - * nvme_shutdown() - Shutdown NVM Express device
> - * @udev:	The NVM Express device
> - * Return: 0 if OK, -ve on error
> - */
> -int nvme_shutdown(struct udevice *udev);
> -
>   #endif /* __DRIVER_NVME_H__ */
> diff --git a/drivers/nvme/nvme_apple.c b/drivers/nvme/nvme_apple.c
> index 7e7538553e3f..a36f15a3ff4e 100644
> --- a/drivers/nvme/nvme_apple.c
> +++ b/drivers/nvme/nvme_apple.c
> @@ -6,6 +6,7 @@
>   #include <dm.h>
>   #include <mailbox.h>
>   #include <mapmem.h>
> +#include <nvme.h>
>   #include "nvme.h"
>   #include <reset.h>
>   
> diff --git a/include/nvme.h b/include/nvme.h
> index 2cdf8ce320c1..c7b301300097 100644
> --- a/include/nvme.h
> +++ b/include/nvme.h
> @@ -90,4 +90,15 @@ int nvme_print_info(struct udevice *udev);
>    */
>   int nvme_get_namespace_id(struct udevice *udev, u32 *ns_id, u8 *eui64);
>   
> +/**
> + * nvme_shutdown() - Shutdown NVM Express device
> + *
> + * Must be called before booting an OS to ensure cache is flushed
> + * and the controller is in a clean state for OS to re-initialize.
> + *
> + * @udev:	The NVM Express device
> + * Return: 0 if OK, -ve on error
> + */
> +int nvme_shutdown(struct udevice *udev);
> +
>   #endif /* __NVME_H__ */

Could you instead add the DM_FLAG_ACTIVE_DMA flag to the PCI NVMe driver and
then call nvme_shutdown() from a new nvem_remove in nvem_pci.c

This will automatically shutdown the NVMe devices when booting an OS and you could
trigger this manually by calling:

dm_remove_devices_flags(DM_REMOVE_ACTIVE_DMA)

Neil

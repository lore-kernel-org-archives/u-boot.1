Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89275E7C4D9
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:00:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9114186EE7;
	Wed,  4 Oct 2023 18:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ItkkN9WH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C292874CA; Wed,  4 Oct 2023 18:00:45 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CC1F8723E
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:00:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3231df054c4so31450f8f.0
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696435237; x=1697040037; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=XsBGWuhWhDrzlY5Ar9QKF4+YnosDaZnkKurpFU/qcEg=;
 b=ItkkN9WHpPD5MbwieYJsF4ABIyC1TjB/v6T6xXBPAGsMMUihB5wsDxJbtwKNn8CTYN
 UMqqEh5DMzyEScbiJW73e5OUoN27sxLGOLrE5TCmOG4031/62r4tFqbxQ3265KW1nN7+
 lzkU4GYwHp/CE5FYAh1HlNNity1NEcmbxUZY/ySx+lxZ5My4iliC8Ed9BkdPGx78lJxH
 S4/5aBPkJFZ4IdiAWqEMFSuxkfeac7n+qvVsjaEHzh+bmmgfZEdOrVnyD8IhZBRUISDK
 TxSwWYCnK8bw50R0mlMkxdFd7cEa9Pk+vXAjjb/3oUeMEjqnAgzM3MKIZeaSKLNsB2u5
 s1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696435237; x=1697040037;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XsBGWuhWhDrzlY5Ar9QKF4+YnosDaZnkKurpFU/qcEg=;
 b=BkVumI4Y9yUyAunsqRBmZHLkEL3OnH5OKbLzo8RVjntPmTNqEHQuD1ZxWUEnfw3A3V
 e68Aidu3XRicy27fRUY7h3Qm9k9Vvvt+gkgMZs5ayWh3xuwb/nY++WfOYDZOXauhSrhN
 XTF3yiniqChePySBUrzG9WWGt2XM2SVFPXywWK90GkeVqWWfa0q6rz2HvlqP1Dxo/k97
 FJjLzThBim3zceYS3JXH+1eB4s+fYkxAOCaRDU7a8o8SOX9dV+Fz5QLntqknuiCe+aQI
 FNdsGMql75BuBbG+Yd5aogZRt2aHjtxrjcdGDqlJys9Vv15xanXnLSqvaWiai4DqWVwW
 LIfw==
X-Gm-Message-State: AOJu0Yx5Werr96KUkkW5T4ZM5xvYCJcUjfqtM3w1FUX9+Y8gPeobA1UP
 6fcwznGZn3+BwBEbBpC3SP/kEg==
X-Google-Smtp-Source: AGHT+IGtbl91fic0Vfof0yYehSzucdOsv8YZPh7BZx5YTY/6X5O8U5gNC4odTamH/zjoYqfH3iKhqw==
X-Received: by 2002:a5d:4d8c:0:b0:323:36a3:8ca with SMTP id
 b12-20020a5d4d8c000000b0032336a308camr2526059wru.28.1696435236139; 
 Wed, 04 Oct 2023 09:00:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5bcc:9741:3ed2:97f5?
 ([2a01:e0a:982:cbb0:5bcc:9741:3ed2:97f5])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a5d6d42000000b003232d122dbfsm4317216wri.66.2023.10.04.09.00.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 09:00:35 -0700 (PDT)
Message-ID: <7521ff4a-4e7f-48c2-be6e-c1489e5bfd19@linaro.org>
Date: Wed, 4 Oct 2023 18:00:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 6/8] drivers: introduce Meson Secure Monitor driver
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com,
 sjg@google.com, takahiro.akashi@linaro.org, ilias.apalodimas@linaro.org,
 post@lespocky.de, marex@denx.de, msuchanek@suse.de, sughosh.ganu@linaro.org,
 jh80.chung@samsung.com, paul.barker@sancloud.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru,
 Simon Glass <sjg@chromium.org>
References: <20230921081346.22157-1-avromanov@salutedevices.com>
 <20230921081346.22157-7-avromanov@salutedevices.com>
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
Organization: Linaro Developer Services
In-Reply-To: <20230921081346.22157-7-avromanov@salutedevices.com>
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

Hi,

On 21/09/2023 10:13, Alexey Romanov wrote:
> This patch adds an implementation of the Meson Secure Monitor
> driver based on UCLASS_SM.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>   MAINTAINERS           |   1 +
>   drivers/sm/Kconfig    |   7 ++
>   drivers/sm/Makefile   |   1 +
>   drivers/sm/meson-sm.c | 198 ++++++++++++++++++++++++++++++++++++++++++
>   include/meson/sm.h    |  19 ++++
>   5 files changed, 226 insertions(+)
>   create mode 100644 drivers/sm/meson-sm.c
>   create mode 100644 include/meson/sm.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6c64427782..bdc364fd4c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -158,6 +158,7 @@ F:	drivers/net/phy/meson-gxl.c
>   F:	drivers/adc/meson-saradc.c
>   F:	drivers/phy/meson*
>   F:	drivers/mmc/meson_gx_mmc.c
> +F:	drivers/sm/meson-sm.c
>   F:	drivers/spi/meson_spifc.c
>   F:	drivers/pinctrl/meson/
>   F:	drivers/power/domain/meson-gx-pwrc-vpu.c
> diff --git a/drivers/sm/Kconfig b/drivers/sm/Kconfig
> index 6cc6d55578..b4cc3f768e 100644
> --- a/drivers/sm/Kconfig
> +++ b/drivers/sm/Kconfig
> @@ -1,2 +1,9 @@
>   config SM
>   	bool "Enable Secure Monitor driver support"
> +
> +config MESON_SM
> +	bool "Amlogic Secure Monitor driver"
> +	depends on SM
> +	default n

I get:
WARNING: unmet direct dependencies detected for MESON_SM
   Depends on [n]: SM [=n]
   Selected by [y]:
   - MESON64_COMMON [=y] && ARM [=y] && ARCH_MESON [=y]


so I think this should be:
   select SM
instead of:
   depends on SM

Could you post a fix so I can send the PR ?

Neil


> +	help
> +	  Say y here to enable the Amlogic secure monitor driver.
> diff --git a/drivers/sm/Makefile b/drivers/sm/Makefile
> index af5f475c2b..da81ee898a 100644
> --- a/drivers/sm/Makefile
> +++ b/drivers/sm/Makefile
> @@ -2,3 +2,4 @@
>   
>   obj-y += sm-uclass.o
>   obj-$(CONFIG_SANDBOX) += sandbox-sm.o
> +obj-$(CONFIG_MESON_SM) += meson-sm.o
> diff --git a/drivers/sm/meson-sm.c b/drivers/sm/meson-sm.c
> new file mode 100644
> index 0000000000..25adaf4560
> --- /dev/null
> +++ b/drivers/sm/meson-sm.c
> @@ -0,0 +1,198 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2023 SberDevices, Inc.
> + *
> + * Author: Alexey Romanov <avromanov@salutedevices.com>
> + */
> +
> +#include <common.h>
> +#include <dm.h>
> +#include <regmap.h>
> +#include <sm.h>
> +#include <sm-uclass.h>
> +#include <stdlib.h>
> +#include <syscon.h>
> +#include <asm/ptrace.h>
> +#include <asm/system.h>
> +#include <meson/sm.h>
> +#include <linux/bitfield.h>
> +#include <linux/err.h>
> +#include <linux/sizes.h>
> +
> +struct meson_sm_cmd {
> +	u32 smc_id;
> +};
> +
> +#define SET_CMD(index, id)	\
> +	[index] = {		\
> +		.smc_id = (id),	\
> +	}
> +
> +struct meson_sm_data {
> +	u32 cmd_get_shmem_in;
> +	u32 cmd_get_shmem_out;
> +	unsigned int shmem_size;
> +	struct meson_sm_cmd cmd[];
> +};
> +
> +struct meson_sm_priv {
> +	void *sm_shmem_in;
> +	void *sm_shmem_out;
> +	const struct meson_sm_data *data;
> +};
> +
> +static unsigned long __meson_sm_call(u32 cmd, const struct pt_regs *args)
> +{
> +	struct pt_regs r = *args;
> +
> +	r.regs[0] = cmd;
> +	smc_call(&r);
> +
> +	return r.regs[0];
> +};
> +
> +static u32 meson_sm_get_cmd(const struct meson_sm_data *data,
> +			    u32 cmd_index)
> +{
> +	struct meson_sm_cmd cmd;
> +
> +	if (cmd_index >= MESON_SMC_CMD_COUNT)
> +		return 0;
> +
> +	cmd = data->cmd[cmd_index];
> +	return cmd.smc_id;
> +}
> +
> +static int meson_sm_call(struct udevice *dev, u32 cmd_index, s32 *retval,
> +			 struct pt_regs *args)
> +{
> +	struct meson_sm_priv *priv = dev_get_priv(dev);
> +	u32 cmd, ret;
> +
> +	cmd = meson_sm_get_cmd(priv->data, cmd_index);
> +	if (!cmd)
> +		return -ENOENT;
> +
> +	ret = __meson_sm_call(cmd, args);
> +	if (retval)
> +		*retval = ret;
> +
> +	return 0;
> +}
> +
> +static int meson_sm_call_read(struct udevice *dev, void *buffer, size_t size,
> +			      u32 cmd_index, struct pt_regs *args)
> +{
> +	struct meson_sm_priv *priv = dev_get_priv(dev);
> +	s32 nbytes;
> +	int ret;
> +
> +	if (!buffer || size > priv->data->shmem_size)
> +		return -EINVAL;
> +
> +	ret = meson_sm_call(dev, cmd_index, &nbytes, args);
> +	if (ret)
> +		return ret;
> +
> +	if (nbytes < 0 || nbytes > size)
> +		return -ENOBUFS;
> +
> +	/* In some cases (for example GET_CHIP_ID command),
> +	 * SMC doesn't return the number of bytes read, even
> +	 * though the bytes were actually read into sm_shmem_out.
> +	 * So this check is needed.
> +	 */
> +	ret = nbytes;
> +	if (!nbytes)
> +		nbytes = size;
> +
> +	memcpy(buffer, priv->sm_shmem_out, nbytes);
> +
> +	return ret;
> +}
> +
> +static int meson_sm_call_write(struct udevice *dev, void *buffer, size_t size,
> +			       u32 cmd_index, struct pt_regs *args)
> +{
> +	struct meson_sm_priv *priv = dev_get_priv(dev);
> +	s32 nbytes;
> +	int ret;
> +
> +	if (!buffer || size > priv->data->shmem_size)
> +		return -EINVAL;
> +
> +	memcpy(priv->sm_shmem_in, buffer, size);
> +
> +	ret = meson_sm_call(dev, cmd_index, &nbytes, args);
> +	if (ret)
> +		return ret;
> +
> +	if (nbytes <= 0 || nbytes > size)
> +		return -EIO;
> +
> +	return nbytes;
> +}
> +
> +static int meson_sm_probe(struct udevice *dev)
> +{
> +	struct meson_sm_priv *priv = dev_get_priv(dev);
> +	struct pt_regs regs = { 0 };
> +
> +	priv->data = (struct meson_sm_data *)dev_get_driver_data(dev);
> +	if (!priv->data)
> +		return -EINVAL;
> +
> +	priv->sm_shmem_in =
> +		(void *)__meson_sm_call(priv->data->cmd_get_shmem_in, &regs);
> +
> +	if (!priv->sm_shmem_in)
> +		return -ENOMEM;
> +
> +	priv->sm_shmem_out =
> +		(void *)__meson_sm_call(priv->data->cmd_get_shmem_out, &regs);
> +
> +	if (!priv->sm_shmem_out)
> +		return -ENOMEM;
> +
> +	pr_debug("meson sm driver probed\n"
> +		 "shmem_in addr: 0x%p, shmem_out addr: 0x%p\n",
> +		 priv->sm_shmem_in,
> +		 priv->sm_shmem_out);
> +
> +	return 0;
> +}
> +
> +static const struct meson_sm_data meson_sm_gxbb_data = {
> +	.cmd_get_shmem_in  = 0x82000020,
> +	.cmd_get_shmem_out = 0x82000021,
> +	.shmem_size = SZ_4K,
> +	.cmd = {
> +		SET_CMD(MESON_SMC_CMD_EFUSE_READ,  0x82000030),
> +		SET_CMD(MESON_SMC_CMD_EFUSE_WRITE, 0x82000031),
> +		SET_CMD(MESON_SMC_CMD_CHIP_ID_GET, 0x82000044),
> +		SET_CMD(MESON_SMC_CMD_PWRDM_SET,   0x82000093),
> +	},
> +};
> +
> +static const struct udevice_id meson_sm_ids[] = {
> +	{
> +		.compatible = "amlogic,meson-gxbb-sm",
> +		.data = (ulong)&meson_sm_gxbb_data,
> +	},
> +	{ }
> +};
> +
> +static const struct sm_ops sm_ops = {
> +	.sm_call = meson_sm_call,
> +	.sm_call_read = meson_sm_call_read,
> +	.sm_call_write = meson_sm_call_write,
> +};
> +
> +U_BOOT_DRIVER(meson_sm) = {
> +	.name = "meson_sm",
> +	.id = UCLASS_SM,
> +	.of_match = meson_sm_ids,
> +	.probe = meson_sm_probe,
> +	.priv_auto = sizeof(struct meson_sm_priv),
> +	.ops = &sm_ops,
> +};
> diff --git a/include/meson/sm.h b/include/meson/sm.h
> new file mode 100644
> index 0000000000..fbaab1f1ee
> --- /dev/null
> +++ b/include/meson/sm.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2023 SberDevices, Inc.
> + *
> + * Author: Alexey Romanov <avromanov@salutedevices.com>
> + */
> +
> +#ifndef __MESON_SM_CMD_H__
> +#define __MESON_SM_CMD_H__
> +
> +enum meson_smc_cmd {
> +	MESON_SMC_CMD_EFUSE_READ,  /* read efuse memory */
> +	MESON_SMC_CMD_EFUSE_WRITE, /* write efuse memory */
> +	MESON_SMC_CMD_CHIP_ID_GET, /* readh chip unique id */
> +	MESON_SMC_CMD_PWRDM_SET,   /* do command at specified power domain */
> +	MESON_SMC_CMD_COUNT,
> +};
> +
> +#endif


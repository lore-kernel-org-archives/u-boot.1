Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F68CC3ABBC
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 08:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66AD4805D7;
	Mon, 12 May 2025 10:10:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vbloNJfj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26C2B8091A; Mon, 12 May 2025 10:10:36 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F25B800C1
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 10:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso41602605e9.2
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 01:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747037433; x=1747642233; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=ws0jxm8tvd9iWMpodoX3DrDXb+Wgy/LfUsZqbzMK5kE=;
 b=vbloNJfjrYKmNCKhZvOm2wmSTCy0iPNvoVX4mDcDl5VlYY6mJ+qBHApmqBrcTsKZyM
 A6v1+lnp7bVqDvaHqx7J5m8XZYHN91t2Fa6g9u47JeBiybee36SBkty7oo7xdM8fpDGz
 +UjHNA/qSXMaTQFonqMlcyfe5YJoDch08UFl5Tt1V/lyjhfrHB3/L4bawVztOKVdFX/z
 xe+mbumE4AVY4F5zV02TCixQ5Tr42YhaW2M1RCLFq1Qb3WhxDl6lNudb0OAWpWyIoVly
 gkQMguCWiCGAT+ZkLYxJZEUaZJZ7/zJdT/Wyr423Cjyh/AHn1kwxQ/9bl8hdaiws+r4y
 u/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747037433; x=1747642233;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ws0jxm8tvd9iWMpodoX3DrDXb+Wgy/LfUsZqbzMK5kE=;
 b=E6LzXKx0z7cVurKTtosqB/XYrL0mEIsGA1d8HbmT6fVG38/Oo70clG4yTvLUh3RV7p
 qy0zjdSmN6rwfCSvbp8g0myCGiJaXPlcHSIzJ9ICnZySzrvje6wFvpRnwinkfvqCdXyw
 iy63H4xyetFySVoI/wYmtswk5VzYHpR+ob1rxYwFjnqAAYlLcd6Ok2+gl1TTpLlfLN44
 3G8hIX+8301aCVT9XOs6QbMtmI1He1of03laEXi8cKK3AFSnVI5tTe5aHl/yLVlXWxYG
 dy5nq2XxqLJgeCtkJXdvigAnyjDBXELeKD5tFKgJkgV0Y6IG062qqKD6zifam9QosRlP
 tfKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVszFLGJQjdltXJy4eoY5s+GZb8yed7BK62huJ968J1+tcxAwc8HAqHJ4D/RP6efZ6g2DySio=@lists.denx.de
X-Gm-Message-State: AOJu0YyZJgaaMzaRKvIbKeXKWluhV8b9q4QnhIffcMpHUuvpsyIfLZ5W
 HgBt/IXWw+y6mJ28DXBcP5Be7g8PXnSxx1piboXl9pC0SyYpVt60ACcoigc/h0A=
X-Gm-Gg: ASbGnctZDNUPjCSgx8c5/2GESZi54AIu3GvM3J3Z4W2G0oVWrEGh81APmJM9KGtvEd5
 mB1mBm7vIsbccaRT+yS06aK7S8KIfGorpnZ+puqJiZsdI9w0bcJvnsa8c1+0W7yJRgHpwpClQD4
 wAC+TtQLgt2d4/rHFKhAziy3TvUCfO+0z6urvFZLOlQryu5aBJcdsAjKpjKc8yVjJDTifjjASeD
 XIzpaG4PaUcxSXBkFASdjo4UVPYocnB95e5iKjab1tFc1d5e+6l0ICWID6wd0zRQGwxBfNNxEdy
 7y9XSbtHF51F2RhUP1qPgi01L70qyiEpb/5c1mhnAo/93fl0LAvADl1K3e4I5zZZz22+k25jQHN
 SclDz9WHS0W9zrHRxb6g3P61j2h2q
X-Google-Smtp-Source: AGHT+IFlifHdWUW+utjEg2XcmHTe8hqHPaFnKI9rznuoRv3tk4bFMfVsgGVANfHDQ2DCWTrPXg86gA==
X-Received: by 2002:a05:600c:6818:b0:442:cd03:3e2 with SMTP id
 5b1f17b1804b1-442d6d18ad5mr117196955e9.2.1747037432672; 
 Mon, 12 May 2025 01:10:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:a88a:91be:2fd8:4f9f?
 ([2a01:e0a:3d9:2080:a88a:91be:2fd8:4f9f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d67e0ff1sm115713535e9.14.2025.05.12.01.10.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 01:10:32 -0700 (PDT)
Message-ID: <91db507e-8fab-42cd-88dc-300372ceee68@linaro.org>
Date: Mon, 12 May 2025 10:10:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 1/1] Initial support for Wiznet W5500
To: verdun@hpe.com, jmverdun3@gmail.com, u-boot@lists.denx.de
References: <20250511180207.42945-1-verdun@hpe.com>
 <20250511180207.42945-2-verdun@hpe.com>
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
In-Reply-To: <20250511180207.42945-2-verdun@hpe.com>
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

Hi,

Thanks for fixing it !

On 11/05/2025 20:02, verdun@hpe.com wrote:
> From: Jean-Marie Verdun <verdun@hpe.com>
> 
> Add support for the Wiznet W5500 spi to ethernet controller
> 
> Signed-off-by: Jean-Marie Verdun <verdun@hpe.com>
> ---
>   drivers/net/Kconfig  |   9 +
>   drivers/net/Makefile |   1 +
>   drivers/net/w5500.c  | 584 +++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 594 insertions(+)
>   create mode 100644 drivers/net/w5500.c
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 950ed0f25a9..74668f477ae 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -19,6 +19,15 @@ config SPL_DM_ETH
>   	depends on SPL_NET
>   	def_bool y
>   
> +config W5500
> +	bool "W5500 device driver"
> +	depends on SPI
> +	help
> +	  Enable w5500 driver
> +
> +	  Adds support for Wiznet W5500 device. The device must be attached
> +	  to a SPI bus.
> +
>   config DM_MDIO
>   	bool "Enable Driver Model for MDIO devices"
>   	depends on PHYLIB
> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> index 67bba3a8536..6d85c38d869 100644
> --- a/drivers/net/Makefile
> +++ b/drivers/net/Makefile
> @@ -103,6 +103,7 @@ obj-$(CONFIG_SUN8I_EMAC) += sun8i_emac.o
>   obj-$(CONFIG_TSEC_ENET) += tsec.o fsl_mdio.o
>   obj-$(CONFIG_TULIP) += dc2114x.o
>   obj-$(CONFIG_VSC7385_ENET) += vsc7385.o
> +obj-$(CONFIG_W5500) += w5500.o
>   obj-$(CONFIG_XILINX_AXIEMAC) += xilinx_axi_emac.o
>   obj-$(CONFIG_XILINX_AXIMRMAC) += xilinx_axi_mrmac.o
>   obj-$(CONFIG_XILINX_EMACLITE) += xilinx_emaclite.o
> diff --git a/drivers/net/w5500.c b/drivers/net/w5500.c
> new file mode 100644
> index 00000000000..a15255bb457
> --- /dev/null
> +++ b/drivers/net/w5500.c
> @@ -0,0 +1,584 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Copyright Hewlett Packard Enterprise Development LP.
> + *
> + * Jean-Marie Verdun <verdun@hpe.com>
> + *
> + * Inspired from the linux kernel driver from:
> + * - Copyright (C) 2006-2008 WIZnet Co.,Ltd.
> + * - Copyright (C) 2012 Mike Sinkovsky <msink@permonline.ru>
> + *
> + * available at
> + * - https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/wiznet/w5100.c
> + *
> + * Datasheet:
> + * - http://www.wiznet.co.kr/wp-content/uploads/wiznethome/Chip/W5100/Document/W5100_Datasheet_v1.2.6.pdf
> + * - http://wiznethome.cafe24.com/wp-content/uploads/wiznethome/Chip/W5200/Documents/W5200_DS_V140E.pdf
> + * - http://wizwiki.net/wiki/lib/exe/fetch.php?media=products:w5500:w5500_ds_v106e_141230.pdf
> + *
> + */
> +
> +#include <dm.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <spi.h>
> +#include <net.h>
> +#include <asm/global_data.h>
> +#include <dm/device_compat.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +#include <net.h>
> +#include <malloc.h>
> +
> +#define BUFFER_SZ       16384
> +#define MAX_PACKET_SZ	9000
> +#define W5100_SPI_WRITE_OPCODE 0xf0
> +#define W5100_SPI_READ_OPCODE 0x0f
> +#define W5100_SHAR              0x0009	/* Source MAC address */
> +#define W5500_S0_REGS           0x10000
> +#define S0_REGS(priv)           ((priv)->s0_regs)
> +#define W5100_MR                0x0000	/* Mode Register */
> +#define   MR_RST                  0x80	/* S/W reset */
> +#define   MR_PB                   0x10	/* Ping block */
> +
> +#define W5100_Sn_MR             0x0000	/* Sn Mode Register */
> +#define W5100_Sn_CR             0x0001	/* Sn Command Register */
> +#define W5100_Sn_IR             0x0002	/* Sn Interrupt Register */
> +#define W5100_Sn_SR             0x0003	/* Sn Status Register */
> +#define W5100_Sn_TX_FSR         0x0020	/* Sn Transmit free memory size */
> +#define W5100_Sn_TX_RD          0x0022	/* Sn Transmit memory read pointer */
> +#define W5100_Sn_TX_WR          0x0024	/* Sn Transmit memory write pointer */
> +#define W5100_Sn_RX_RSR         0x0026	/* Sn Receive free memory size */
> +#define W5100_Sn_RX_RD          0x0028	/* Sn Receive memory read pointer */
> +
> +#define W5100_S0_MR(priv)       (S0_REGS(priv) + W5100_Sn_MR)
> +
> +#define   S0_MR_MACRAW            0x04	/* MAC RAW mode */
> +#define   S0_MR_MF                0x40	/* MAC Filter for W5100 and W5200 */
> +#define   W5500_S0_MR_MF          0x80	/* MAC Filter for W5500 */
> +#define W5100_S0_MR(priv)       (S0_REGS(priv) + W5100_Sn_MR)
> +
> +#define   S0_MR_MACRAW            0x04	/* MAC RAW mode */
> +#define   S0_MR_MF                0x40	/* MAC Filter for W5100 and W5200 */
> +#define   W5500_S0_MR_MF          0x80	/* MAC Filter for W5500 */
> +
> +/*
> + * W5100 and W5200 common registers about the same with the W5500
> + */
> +#define W5100_IMR               0x0016	/* Interrupt Mask Register */
> +#define   IR_S0                   0x01	/* S0 interrupt */
> +#define W5100_RTR               0x0017	/* Retry Time-value Register */
> +#define   RTR_DEFAULT             2000	/* =0x07d0 (2000) */
> +#define W5500_SIMR              0x0018	/* Socket Interrupt Mask Register */
> +#define W5500_RTR               0x0019	/* Retry Time-value Register */
> +
> +#define W5100_S0_CR(priv)       (S0_REGS(priv) + W5100_Sn_CR)
> +#define   S0_CR_OPEN              0x01	/* OPEN command */
> +#define   S0_CR_CLOSE             0x10	/* CLOSE command */
> +#define   S0_CR_SEND              0x20	/* SEND command */
> +#define   S0_CR_RECV              0x40	/* RECV command */
> +#define W5100_S0_IR(priv)       (S0_REGS(priv) + W5100_Sn_IR)
> +#define   S0_IR_SENDOK            0x10	/* complete sending */
> +#define   S0_IR_RECV              0x04	/* receiving data */
> +#define W5100_S0_SR(priv)       (S0_REGS(priv) + W5100_Sn_SR)
> +#define   S0_SR_MACRAW            0x42	/* mac raw mode */
> +#define W5100_S0_TX_FSR(priv)   (S0_REGS(priv) + W5100_Sn_TX_FSR)
> +#define W5100_S0_TX_RD(priv)    (S0_REGS(priv) + W5100_Sn_TX_RD)
> +#define W5100_S0_TX_WR(priv)    (S0_REGS(priv) + W5100_Sn_TX_WR)
> +#define W5100_S0_RX_RSR(priv)   (S0_REGS(priv) + W5100_Sn_RX_RSR)
> +#define W5100_S0_RX_RD(priv)    (S0_REGS(priv) + W5100_Sn_RX_RD)
> +
> +#define W5500_TX_MEM_START      0x20000
> +#define W5500_TX_MEM_SIZE       0x04000
> +#define W5500_RX_MEM_START      0x30000
> +#define W5500_RX_MEM_SIZE       0x04000
> +
> +#define W5500_Sn_RXMEM_SIZE(n)  \
> +		(0x1001e + (n) * 0x40000)	/* Sn RX Memory Size */
> +#define W5500_Sn_TXMEM_SIZE(n)  \
> +		(0x1001f + (n) * 0x40000)	/* Sn TX Memory Size */
> +
> +/**
> + * struct eth_w5500_priv - memory for w5500 driver
> + */
> +struct eth_w5500_priv {
> +	uchar host_hwaddr[ARP_HLEN];
> +	bool disabled;
> +	uchar * recv_packet_buffer[PKTBUFSRX];
> +	int recv_packet_length[PKTBUFSRX];
> +	int recv_packets;
> +	const struct dm_spi_ops *spi_ops;
> +	struct udevice **spi_dev;
> +	u32 s0_regs;
> +	u32 s0_tx_buf;
> +	u16 s0_tx_buf_size;
> +	u32 s0_rx_buf;
> +	u16 s0_rx_buf_size;
> +	bool promisc;
> +	u32 msg_enable;
> +	u16 offset;
> +	void *priv;
> +};
> +
> +static int xfer(struct udevice *dev, void *dout, unsigned int bout, void *din,
> +		unsigned int bin)
> +{
> +	/* Ok the xfer function in uboot is symmetrical
> +	 * (write and read operation happens at the same time)
> +	 * w5500 requires bytes send followed by receive operation on the MISO line
> +	 * So we need to create a buffer which contain bout+bin bytes and pass the various
> +	 * pointer to the xfer function
> +	 */
> +
> +	struct udevice *bus = dev_get_parent(dev);
> +	u8 buffin[BUFFER_SZ];
> +	u8 buffout[BUFFER_SZ];

It's dangerous to allocate 2 16k buffers on the stack, move them global
or allocate them at probe and store the pointers in eth_w5500_priv

> +
> +	if ((bout + bin) < BUFFER_SZ) {
> +		for (int i = 0; i < bout; i++) {
> +			buffout[i] = ((u8 *)(dout))[i];
> +			buffin[i] = 0;
> +		}
> +		for (int i = bout; i < (bin + bout); i++) {
> +			buffin[i] = 0;
> +			buffout[i] = 0;
> +		}
> +		if (!bus)
> +			return -1;
> +		dm_spi_xfer(dev, 8 * (bout + bin), buffout, buffin,
> +			    SPI_XFER_BEGIN | SPI_XFER_END);
> +		for (int i = bout; i < (bin + bout); i++)
> +			((u8 *)(din))[bin + bout - i - 1] = buffin[i];
> +	}
> +
> +	return 0;
> +}
> +
> +static int w5500_spi_read(struct udevice *dev, u32 addr)
> +{
> +	u8 cmd[3];
> +	int ret;
> +	u8 bank;
> +	u8 data;
> +
> +	bank = (addr >> 16);
> +
> +	if (bank > 0)
> +		bank = bank << 3;
> +
> +	cmd[0] = addr >> 8;
> +	cmd[1] = addr & 0xff;
> +	cmd[2] = bank;
> +
> +	ret = xfer(dev, cmd, sizeof(cmd), &data, 1);
> +	if (ret != 0)

if (ret)

> +		return ret;
> +
> +	return data;
> +}
> +
> +static int w5500_spi_write(struct udevice *dev, u32 addr, u8 data)
> +{
> +	u8 cmd[4];
> +	u8 bank;
> +	u8 din;
> +
> +	bank = (addr >> 16);
> +	din = 0;
> +
> +	if (bank > 0)
> +		bank = bank << 3;
> +
> +	cmd[0] = (addr >> 8) & 0xff;
> +	cmd[1] = addr & 0xff;
> +	cmd[2] = bank | 0x4;
> +	cmd[3] = data;
> +
> +	return xfer(dev, cmd, sizeof(cmd), &din, 0);
> +}
> +
> +static int w5500_spi_read16(struct udevice *dev, u32 addr)
> +{
> +	u8 cmd[3];
> +	u16 data;
> +	int ret;
> +	u8 bank;
> +
> +	bank = (addr >> 16);
> +
> +	if (bank > 0)
> +		bank = bank << 3;
> +
> +	cmd[0] = addr >> 8;
> +	cmd[1] = addr & 0xff;
> +	cmd[2] = bank;
> +
> +	ret = xfer(dev, cmd, sizeof(cmd), &data, 2);
> +	if (ret != 0)

if (ret)

> +		return ret;
> +
> +	return data;
> +}
> +
> +static int w5500_writebulk(struct udevice *dev, u32 addr, const u8 *buf,
> +			   int len)
> +{
> +	int i;
> +	u8 bank;
> +	u8 cmd[9000];
> +	u8 din = 0;
> +
> +	bank = (addr >> 16);
> +	if (bank > 0)
> +		bank = bank << 3;
> +
> +	cmd[0] = (addr >> 8) & 0xff;
> +	cmd[1] = addr & 0xff;
> +	cmd[2] = bank | 0x4;
> +
> +	for (i = 0; i < len; i++)
> +		cmd[i + 3] = buf[i];
> +
> +	return xfer(dev, cmd, len + 3, &din, 0);
> +}
> +
> +static int w5500_spi_write16(struct udevice *dev, u32 addr, u16 data)
> +{
> +	u8 buf[2];
> +
> +	buf[0] = data >> 8;
> +	buf[1] = data & 0xff;
> +
> +	return w5500_writebulk(dev, addr, &buf[0], 2);
> +}
> +
> +static int w5500_readbulk(struct udevice *dev, u32 addr, u8 *buf, int len)
> +{
> +	u8 cmd[3];
> +	u8 *data;
> +	int i;
> +	int ret;
> +	u8 bank;
> +
> +	data = (u8 *)malloc(MAX_PACKET_SZ);

Why not malloc(len) ?

> +
> +	if (!data)
> +		return -1;
> +
> +	bank = (addr >> 16);
> +
> +	if (bank > 0)
> +		bank = bank << 3;
> +
> +	cmd[0] = addr >> 8;
> +	cmd[1] = addr & 0xff;
> +	cmd[2] = bank;
> +
> +	ret = xfer(dev, cmd, sizeof(cmd), &data, len);
> +
> +	if (ret != 0) {

if (ret) {

> +		free(data);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < len; i++)
> +		buf[(len - 1) - i] = data[i];
> +	free(data);
> +	return 0;

or add:
	out:
		free(data)
		return ret;

and replace with:
	if (ret)
		goto out;

> +}
> +
> +static int w5500_readbuf(struct udevice *dev, u16 offset, u8 *buf, int len)
> +{
> +	struct eth_w5500_priv *priv = dev_get_priv(dev);
> +	u32 addr;
> +	const u32 mem_start = priv->s0_rx_buf;
> +	int remain = 0;
> +	int ret;
> +	const u16 mem_size = priv->s0_rx_buf_size;

Order by line length

> +
> +	offset %= mem_size;
> +	addr = mem_start + offset;
> +
> +	if (offset + len > mem_size) {
> +		remain = (offset + len) % mem_size;
> +		len = mem_size - offset;
> +	}
> +
> +	ret = w5500_readbulk(dev, addr, buf, len);
> +	if (ret || !remain)
> +		return ret;
> +
> +	return w5500_readbulk(dev, mem_start, buf + len, remain);
> +}
> +
> +static int w5500_writebuf(struct udevice *dev, u16 offset, const u8 *buf,
> +			  int len)
> +{
> +	struct eth_w5500_priv *priv = dev_get_priv(dev);
> +	u32 addr;
> +	const u32 mem_start = priv->s0_tx_buf;
> +	int ret;
> +	int remain = 0;
> +	const u16 mem_size = priv->s0_tx_buf_size;

Ditto

> +
> +	offset %= mem_size;
> +	addr = mem_start + offset;
> +
> +	if (offset + len > mem_size) {
> +		remain = (offset + len) % mem_size;
> +		len = mem_size - offset;
> +	}
> +
> +	ret = w5500_writebulk(dev, addr, buf, len);
> +	if (ret || !remain)
> +		return ret;
> +
> +	return w5500_writebulk(dev, mem_start, buf + len, remain);
> +}
> +
> +static int w5500_command(struct udevice *dev, u8 cmd)
> +{
> +	struct eth_w5500_priv *priv = dev_get_priv(dev);
> +	u8 val;
> +	u16 check;
> +
> +	w5500_spi_write(dev, W5100_S0_CR(priv), cmd);
> +	check = read_poll_timeout(w5500_spi_read, val, val != 0,
> +				  10, 5000, dev, W5100_S0_CR(priv));
> +	if (check != 0)

if (check)

> +		return -EIO;

return ret

> +
> +	return 0;
> +}
> +
> +static int w5500_eth_start(struct udevice *dev)
> +{
> +	struct eth_w5500_priv *priv = dev_get_priv(dev);
> +
> +	debug("eth_w5500: Start\n");
> +
> +	u8 mode = S0_MR_MACRAW;
> +
> +	if (!priv->promisc)
> +		mode |= W5500_S0_MR_MF;
> +
> +	w5500_spi_write(dev, W5100_S0_MR(priv), mode);
> +	w5500_command(dev, S0_CR_OPEN);

Please check return values of w5500_spi_write() & w5500_command() & co on all calls

> +	priv->offset = 0;
> +
> +	return 0;
> +}
> +
> +static int w5500_eth_send(struct udevice *dev, void *packet, int length)
> +{
> +	struct eth_w5500_priv *priv = dev_get_priv(dev);
> +	u16 offset;
> +
> +	if (priv->disabled)
> +		return 0;
> +
> +	offset = w5500_spi_read16(dev, W5100_S0_TX_WR(priv));
> +	w5500_writebuf(dev, offset, packet, length);
> +	w5500_spi_write16(dev, W5100_S0_TX_WR(priv), offset + length);
> +	w5500_command(dev, S0_CR_SEND);

Ditto

> +
> +	return 0;
> +}
> +
> +static int w5500_eth_recv(struct udevice *dev, int flags, u8 **packetp)
> +{
> +	struct eth_w5500_priv *priv = dev_get_priv(dev);
> +	u16 rx_len;
> +	u16 offset;
> +	u8 data[9000];
> +	u16 tmp;
> +	u16 rx_buf_len;
> +
> +	rx_buf_len = w5500_spi_read16(dev, W5100_S0_RX_RSR(priv));
> +
> +	/*
> +	 * w5500 is updating rx_buf_len as soon as bytes are received
> +	 * to avoid reading partial data we must wait for that register to
> +	 * stay stable between to read otherwise we might be issuing
> +	 * reading operations while buffer hasn't been completed by the driver
> +	 * per architectural specifications

Weird because the linux driver doesn't do that at all, perhaps check for the
W5100_S0_IR S0_IR_RECV flag instead ?

> +	 */
> +
> +	while ((tmp =
> +		w5500_spi_read16(dev, W5100_S0_RX_RSR(priv))) != rx_buf_len)
> +		rx_buf_len = tmp;
> +
> +	if (rx_buf_len == 0)
> +		return 0;
> +
> +	offset = w5500_spi_read16(dev, W5100_S0_RX_RD(priv));
> +	rx_len = rx_buf_len - 2;
> +	w5500_readbuf(dev, offset + 2, data, rx_len);
> +	w5500_spi_write16(dev, W5100_S0_RX_RD(priv), offset + 2 + rx_len);
> +	w5500_command(dev, S0_CR_RECV);
> +	*packetp = data;
> +
> +	priv->offset += rx_buf_len;
> +
> +	return rx_len;
> +}
> +
> +static int w5500_eth_free_pkt(struct udevice *dev, u8 *packet, int length)
> +{
> +	struct eth_w5500_priv *priv = dev_get_priv(dev);
> +	int i;
> +
> +	if (!priv->recv_packets)
> +		return 0;
> +
> +	--priv->recv_packets;
> +	for (i = 0; i < priv->recv_packets; i++) {
> +		priv->recv_packet_length[i] = priv->recv_packet_length[i + 1];
> +		memcpy(priv->recv_packet_buffer[i],
> +		       priv->recv_packet_buffer[i + 1],
> +		       priv->recv_packet_length[i + 1]);
> +	}
> +	priv->recv_packet_length[priv->recv_packets] = 0;
> +
> +	return 0;
> +}
> +
> +static void w5500_eth_stop(struct udevice *dev)
> +{
> +	dev_dbg(dev, "eth_w5500: Stop\n");
> +}
> +
> +static void w5500_socket_intr_mask(struct udevice *dev, u8 mask)
> +{
> +	w5500_spi_write(dev, W5500_SIMR, mask);
> +}
> +
> +static void w5500_disable_intr(struct udevice *dev)
> +{
> +	w5500_socket_intr_mask(dev, 0);
> +}
> +
> +static void w5500_enable_intr(struct udevice *dev)
> +{
> +	w5500_socket_intr_mask(dev, IR_S0);
> +}
> +
> +static int w5500_eth_write_hwaddr(struct udevice *dev)
> +{
> +	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct eth_w5500_priv *priv = dev_get_priv(dev);
> +	u8 eth[6];
> +
> +	if (memcmp(priv->host_hwaddr, pdata->enetaddr, ARP_HLEN) != 0) {
> +		memcpy(priv->host_hwaddr, pdata->enetaddr, ARP_HLEN);
> +		w5500_writebulk(dev, W5100_SHAR, priv->host_hwaddr, ARP_HLEN);
> +	}
> +
> +	w5500_readbulk(dev, W5100_SHAR, eth, 6);
> +
> +	w5500_spi_write(dev, W5100_S0_MR(priv), 0x84);
> +	w5500_command(dev, S0_CR_OPEN);
> +	w5500_enable_intr(dev);

This is already done in w5500_eth_start(), so drop

> +
> +	return 0;
> +}
> +
> +static const struct eth_ops w5500_eth_ops = {
> +	.start = w5500_eth_start,
> +	.send = w5500_eth_send,
> +	.recv = w5500_eth_recv,
> +	.free_pkt = w5500_eth_free_pkt,
> +	.stop = w5500_eth_stop,
> +	.write_hwaddr = w5500_eth_write_hwaddr,
> +};
> +
> +int w5500_eth_of_to_plat(struct udevice *dev)
> +{
> +	u8 mac[8];
> +	const void *ptr;
> +	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct eth_w5500_priv *priv = dev_get_priv(dev);
> +	ofnode remote;
> +	int size;
> +
> +	size = 0;
> +	ptr = ofnode_read_prop(remote, "local-mac-address", &size);
> +	if (size != 6)
> +		return -1;
> +	mac[0] = ((u8 *)ptr)[0];
> +	mac[1] = ((u8 *)ptr)[1];
> +	mac[2] = ((u8 *)ptr)[2];
> +	mac[3] = ((u8 *)ptr)[4];
> +	mac[4] = ((u8 *)ptr)[5];
> +	mac[5] = ((u8 *)ptr)[5];
> +
> +	memcpy(pdata->enetaddr, (void *)mac, ARP_HLEN);


This looks fishy, no 3 and 5 is duplicated.

And this is not the driver role to set this value, it will be set
by eth_post_probe() or board code so drop this entirely.


> +
> +	priv->disabled = false;

plat is allocated zero-ed, so this can also be dropped,
so drop the whole w5500_eth_of_to_plat()

> +
> +	return 0;
> +}
> +
> +int w5500_eth_probe(struct udevice *dev)
> +{
> +	struct eth_w5500_priv *priv = dev_get_priv(dev);
> +	u8 cmd[3];
> +	int i;
> +
> +	if (device_get_uclass_id(dev->parent) != UCLASS_SPI) {
> +		debug("Error device not attached to a SPI controlled\n");
> +		return -ENODEV;
> +	}
> +
> +	cmd[0] = 0x00;
> +	cmd[1] = 0x19;
> +	cmd[2] = 0;

This is unused

> +
> +	w5500_spi_write(dev, W5100_MR, MR_RST);
> +	w5500_spi_write(dev, W5100_MR, MR_PB);
> +
> +	if (w5500_spi_read16(dev, W5500_RTR) != RTR_DEFAULT) {
> +		debug("RTR issue in probe .... %x\n",
> +		      w5500_spi_read16(dev, W5500_RTR));
> +		return -ENODEV;
> +	}
> +
> +	w5500_disable_intr(dev);
> +
> +	/* Configure internal RX memory as 16K RX buffer and
> +	 * internal TX memory as 16K TX buffer
> +	 */
> +
> +	w5500_spi_write(dev, W5500_Sn_RXMEM_SIZE(0), 0x10);
> +	w5500_spi_write(dev, W5500_Sn_TXMEM_SIZE(0), 0x10);
> +
> +	for (i = 1; i < 8; i++) {
> +		w5500_spi_write(dev, W5500_Sn_RXMEM_SIZE(i), 0);
> +		w5500_spi_write(dev, W5500_Sn_TXMEM_SIZE(i), 0);
> +	}
> +
> +	priv->s0_regs = W5500_S0_REGS;
> +	priv->s0_tx_buf = W5500_TX_MEM_START;
> +	priv->s0_tx_buf_size = W5500_TX_MEM_SIZE;
> +	priv->s0_rx_buf = W5500_RX_MEM_START;
> +	priv->s0_rx_buf_size = W5500_RX_MEM_SIZE;
> +	priv->offset = 0;
> +
> +	return 0;
> +}
> +
> +static const struct udevice_id w5500_eth_ids[] = {
> +	{.compatible = "wiznet,w5500" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(eth_w5500) = {
> +	.name = "eth_w5500",
> +	.id = UCLASS_ETH,
> +	.of_match = w5500_eth_ids,
> +	.of_to_plat = w5500_eth_of_to_plat,
> +	.probe = w5500_eth_probe,
> +	.ops = &w5500_eth_ops,
> +	.priv_auto = sizeof(struct eth_w5500_priv),
> +	.plat_auto = sizeof(struct eth_pdata),
> +};

Thanks,
Neil

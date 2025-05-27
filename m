Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E3EC54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 08:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93D6E82AFC;
	Tue, 27 May 2025 10:21:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ddF8/Qa4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2356582B0E; Tue, 27 May 2025 10:21:57 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35B5F82A36
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 10:21:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a36e950e41so1916450f8f.0
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 01:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748334114; x=1748938914; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:in-reply-to
 :content-language:references:to:reply-to:subject:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=+kP6idfXG+1144Oba68MSwZ15/wdk/c51egbD7VW6Zc=;
 b=ddF8/Qa47MuDi+1bqY5JBpF6jlOMPpIXN5aaCDCPfRN3+R7LhUYcxy7Wa0eChi5KVt
 Q7Rcubxb664k6PyCl06Pn4CGcsZJAF2ZQ6sKiBA6khRIhXUbHncVAzP0waqfJDKB3Mo8
 oMvTG3o9bIjZo/WBb1WXL6t/5XoW1fYvcsXajRPak8WQR45LmIUUPoLqiEgTQm2jwgL0
 Ntzwzr8ITBAmlhA1RiEv+JoB8OfjRMlPLetJiStQSgKTd1XXJzKzuB4YYPcTZyNT0t/W
 b8BM0DrM2c8kvGR74ESmLylDGAPj5+oAjfuXmM2DmKNmxDHxyNr1srpy6/MB0cp95wxL
 SHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748334114; x=1748938914;
 h=content-transfer-encoding:organization:autocrypt:in-reply-to
 :content-language:references:to:reply-to:subject:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+kP6idfXG+1144Oba68MSwZ15/wdk/c51egbD7VW6Zc=;
 b=EeNHRTJhB1xMPPn9pFgFWEcHIeiAcDbWPLcpO69G00m9sTUbHbQd2Y3sARB5PMxygP
 Iu5x7K1KVcS6lw0aOAgTONqzDQmzjcFYGlcv898c5SSAdGg3Doot/pCwPAsrKdtNGZa4
 NRYVhkD46z+28vYX+2k922PRbik0UPHKc3lnX7fSsNC+oBLVH9xmJIa8KxyURE2P1pye
 BV/h5yzqjqWw0iyedx3cyhehHwq4VNd4rPGm9Vtafoem1PmkOXgkU7dJiR+ANNWA+eON
 tj1AsD2uYH9+bu59a6juR/JK4RFXp5mpMysBsk/DSXKkK7VHsGr3tgf4lXYsZU9YdCXQ
 Uojg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUygbdkxKJe62haPjlGrld8X6DppPPWeJdBe5BMoK7xbqyUFDBIw5HFmsUYUxT0hYImkKUtZ7Y=@lists.denx.de
X-Gm-Message-State: AOJu0YwKJn3sVBtdJgNlIAlndl37RdK/3eCXzqzysoJyvqZee2+V+whd
 R1csuTwPHAbGS8G7NBZYYdznYNwSM63bLy/LtmttQcU8ssWI6ooi33l1D9AP4gtioN8jPOypiMz
 tlSzY
X-Gm-Gg: ASbGnctSES7oU4fr9m965nML+wivd0K1v+ZCLCG7B40YlrNpD65agQAcJBZmMOYm7xn
 mU6xpDTHXxBe2Kb2OcgbAXkQsiBhvvUmJhnYl3Yh+FQ1+phLgOZU7QVSZWCq7H7Li2TBwW1zCQ3
 MAL4Rt9Lk2W1uU/ilipcGWg1Z27JxACEG3y73gG2XuQPUntuArF7ocIWr29jtiJ45UsOhKitx8U
 n3WLg05A+32D+0cU6fBd+OA1YR+umJXAfrcYIZSh+0Dy9I0sMCCtSh/cLwjm7Jh29EkYUruB2+V
 TDZOpvZfdqqEmnVA18k0kzEq+PJcA6kSwXZ0B6cIvIxlgrCJB8efK8LkeOyFENKORAqLqsnuN1A
 wPegM7eCNJXeFcRQ8R5ZlTiI0ymDy
X-Google-Smtp-Source: AGHT+IFL9j4J41jkSi7Zrx5P87mLC4Sm27JzEHtghdtf1v4UfqbzSlQ2YVD2OhoWz+/QdINTYoZUlw==
X-Received: by 2002:a05:6000:3111:b0:391:2f2f:818 with SMTP id
 ffacd0b85a97d-3a4cb445323mr9500423f8f.9.1748334113524; 
 Tue, 27 May 2025 01:21:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:5dfc:9515:c83d:f59c?
 ([2a01:e0a:3d9:2080:5dfc:9515:c83d:f59c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cc52ab88sm10121475f8f.11.2025.05.27.01.21.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 01:21:53 -0700 (PDT)
Message-ID: <3f95d2c1-9099-4a2f-a31a-d37cdebfa6f8@linaro.org>
Date: Tue, 27 May 2025 10:21:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v7 1/1] Initial support for Wiznet W5500
To: verdun@hpe.com, jmverdun3@gmail.com, u-boot@lists.denx.de
References: <20250526194734.4195-1-verdun@hpe.com>
 <20250526194734.4195-2-verdun@hpe.com>
Content-Language: en-US, fr
In-Reply-To: <20250526194734.4195-2-verdun@hpe.com>
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

On 26/05/2025 21:47, verdun@hpe.com wrote:
> From: Jean-Marie Verdun <verdun@hpe.com>
> 
> Add support for the Wiznet W5500 spi to ethernet controller
> 
> Signed-off-by: Jean-Marie Verdun <verdun@hpe.com>
> ---
>   drivers/net/Kconfig  |   9 +
>   drivers/net/Makefile |   1 +
>   drivers/net/w5500.c  | 610 +++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 620 insertions(+)
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
> index 00000000000..4cc6e3f3ede
> --- /dev/null
> +++ b/drivers/net/w5500.c
> @@ -0,0 +1,610 @@
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
> +#define MAX_PACKET_SZ	1500
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
> +	bool disabled;
> +	u32 msg_enable;
> +	u16 offset;
> +	u8 *buffin;
> +	u8 *buffout;
> +	void *priv;
> +};
> +
> +static int xfer(struct udevice *dev, void *dout, unsigned int bout,
> +		void *din, unsigned int bin)
> +{
> +	/* Ok the xfer function in uboot is symmetrical
> +	 * (write and read operation happens at the same time)
> +	 * w5500 requires bytes send followed by receive operation on the MISO line
> +	 * So we need to create a buffer which contain bout+bin bytes and pass the various
> +	 * pointer to the xfer function
> +	 */
> +
> +	struct udevice *bus = dev_get_parent(dev);
> +	struct eth_w5500_priv *priv = dev_get_priv(dev);
> +	u8 *buffin = priv->buffin;
> +	u8 *buffout = priv->buffout;
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

Check spi_xfer error and propagate it, otherwise all the code checking
ther xfer() return is dead code.

> +		for (int i = bout; i < (bin + bout); i++)
> +			((u8 *)(din))[bin + bout - i - 1] = buffin[i];
> +	}
> +
> +	return 0;
> +}
> +
> +static int w5500_writebulk(struct udevice *dev, u32 addr, const u8 *buf,
> +			   int len)
> +{
> +	u8 *cmd;
> +	int i;
> +	int ret;
> +	u8 bank;
> +	u8 din = 0;
> +
> +	bank = (addr >> 16);
> +	if (bank > 0)
> +		bank = bank << 3;
> +	cmd = (u8 *)malloc(3 + len);
> +	if (!cmd)
> +		return -ENOMEM;
> +
> +	cmd[0] = (addr >> 8) & 0xff;
> +	cmd[1] = addr & 0xff;
> +	cmd[2] = bank | 0x4;
> +
> +	switch (len) {
> +	case 1:
> +		cmd[3] = *buf;
> +		break;
> +	case 2:
> +		cmd[3] = buf[1];
> +		cmd[4] = buf[0];
> +		break;
> +	default:
> +		for (i = 0; i < len; i++)
> +			cmd[i + 3] = buf[i];
> +	}
> +	ret = xfer(dev, cmd, len + 3, &din, 0);
> +	free(cmd);
> +	return ret;
> +}
> +
> +static int w5500_readbulk(struct udevice *dev, u32 addr, u8 *buf, int len)
> +{
> +	u8 *data;
> +	u8 cmd[3];
> +	int i;
> +	int ret;
> +	u16 twobytes;
> +	u8 bank;
> +	u8 onebyte;
> +
> +	switch (len) {
> +	case 1:
> +		data = &onebyte;
> +		break;
> +	case 2:
> +		data = (u8 *)&twobytes;
> +		break;
> +	default:
> +		data = (u8 *)malloc(len);
> +		if (!data) {
> +			buf = NULL;
> +			return -ENOMEM;
> +		}
> +	}
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
> +	ret = xfer(dev, cmd, sizeof(cmd), data, len);
> +
> +	if (ret) {
> +		if (len > 2)
> +			free(data);
> +		return ret;
> +	}
> +	if (len > 2) {
> +		for (i = 0; i < len; i++)
> +			buf[(len - 1) - i] = data[i];
> +		free(data);
> +	} else {
> +		for (i = 0; i < len; i++)
> +			buf[i] = data[i];
> +	}
> +
> +	return 0;
> +}
> +
> +static int w5500_readbuf(struct udevice *dev, u16 offset, u8 *buf, int len)
> +{
> +	struct eth_w5500_priv *priv = dev_get_priv(dev);
> +	const u32 mem_start = priv->s0_rx_buf;
> +	u32 addr;
> +	int remain = 0;
> +	int ret;
> +	const u16 mem_size = priv->s0_rx_buf_size;
> +
> +	offset %= mem_size;
> +	addr = mem_start + offset;
> +
> +	if (offset + len > mem_size) {
> +		remain = (offset + len) % mem_size;
> +		len = mem_size - offset;
> +	}
> +	ret = w5500_readbulk(dev, addr, buf, len);
> +	if (ret || !remain)
> +		return ret;
> +	return w5500_readbulk(dev, mem_start, buf + len, remain);
> +}
> +
> +static int w5500_writebuf(struct udevice *dev, u16 offset, const u8 *buf,
> +			  int len)
> +{
> +	struct eth_w5500_priv *priv = dev_get_priv(dev);
> +	const u32 mem_start = priv->s0_tx_buf;
> +	u32 addr;
> +	int ret;
> +	int remain = 0;
> +	const u16 mem_size = priv->s0_tx_buf_size;
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
> +static u8 w5500_cmd_poll(struct udevice *dev, u32 addr, int len)
> +{
> +	u8 cmd[3];
> +	u8 bank;
> +	u8 data;
> +	u8 ret;
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

ret is unused here, the best would to be to return int here,
and either return ret if < 0 or data.

> +	return data;
> +}
> +
> +static int w5500_command(struct udevice *dev, u8 cmd)
> +{
> +	struct eth_w5500_priv *priv = dev_get_priv(dev);
> +	u8 val;
> +	u8 check;
> +
> +	if (w5500_writebulk(dev, W5100_S0_CR(priv), &cmd, 1))
> +		return -EIO;

Return the real error instead of -IO, same in other functions.

> +
> +	check = read_poll_timeout(w5500_cmd_poll, val, val == 0,
> +				  10, 5000, dev, W5100_S0_CR(priv), 1);
> +
> +	if (check)
> +		return -EIO;

The read_poll_timeout() can return -ETIMEDOUT so use an int instead.

If you change w5500_cmd_poll to return int, you can change this to:

int ret, val;

ret = read_poll_timeout(w5500_cmd_poll, val, (val < 0 || val == 0),
			10, 5000, dev, W5100_S0_CR(priv), 1);

if (val < 0)
	return val;

return ret;

so you can propagate errors from w5500_cmd_poll() & from read_poll_timeout().

> +
> +	return 0;
> +}
> +
> +static int w5500_eth_send(struct udevice *dev, void *packet, int length)
> +{
> +	struct eth_w5500_priv *priv = dev_get_priv(dev);
> +	int ret;
> +	u16 offset;
> +	u16 addr;
> +
> +	if (priv->disabled)
> +		return 0;
> +
> +	ret = w5500_readbulk(dev, W5100_S0_TX_WR(priv), (u8 *)&offset, 2);
> +	if (ret)
> +		return ret;
> +
> +	ret = w5500_writebuf(dev, offset, packet, length);
> +	if (ret)
> +		return ret;
> +
> +	addr = offset + length;
> +	if (w5500_writebulk(dev, W5100_S0_TX_WR(priv), (u8 *)&addr, 2))
> +		return -EIO;
> +
> +	ret = w5500_command(dev, S0_CR_SEND);
> +	if (ret)
> +		return ret;

Just return w5500_command(dev, S0_CR_SEND) like:

return w5500_command(dev, S0_CR_SEND);

> +
> +	return 0;
> +}
> +
> +static int w5500_eth_recv(struct udevice *dev, int flags, u8 **packetp)
> +{
> +	struct eth_w5500_priv *priv = dev_get_priv(dev);
> +	u8 *data;
> +	int ret;
> +	u16 rx_len;
> +	u16 offset;
> +	u16 tmp;
> +	u16 rx_buf_len;
> +	u8 i;
> +
> +	ret = w5500_readbulk(dev, W5100_S0_RX_RSR(priv), (u8 *)&rx_buf_len, 2);
> +	if (ret)
> +		return -EAGAIN;
> +
> +	/*
> +	 * w5500 is updating rx_buf_len as soon as bytes are received
> +	 * to avoid reading partial data we must wait for that register to
> +	 * stay stable between two read otherwise we might be issuing
> +	 * reading operations while buffer hasn't been completed by the driver
> +	 * per architectural specifications
> +	 * (W5500 Datasheet specifies "Therefore, it is recommended that you
> +	 * read all 16-bits twice or more until getting the same value." into
> +	 * Sn_RX_RSR Register description.
> +	 */
> +	ret = w5500_readbulk(dev, W5100_S0_RX_RSR(priv), (u8 *)&tmp, 2);
> +	if (ret)
> +		return -EAGAIN;
> +	while (tmp != rx_buf_len) {
> +		rx_buf_len = tmp;
> +		ret = w5500_readbulk(dev, W5100_S0_RX_RSR(priv), (u8 *)&tmp, 2);
> +		if (ret)
> +			return -EAGAIN;
> +	}
> +
> +	if (rx_buf_len == 0)
> +		return -EAGAIN;
> +
> +	ret = w5500_readbulk(dev, W5100_S0_RX_RD(priv), (u8 *)&offset, 2);
> +	if (ret)
> +		return -EAGAIN;
> +
> +	rx_len = rx_buf_len - 2;
> +
> +	for (i = 0; i < PKTBUFSRX ; i++)
> +		if (priv->recv_packet_length[i] == 0)
> +			break;
> +
> +	if (i > PKTBUFSRX)
> +		return -ENOMEM;
> +
> +	data = (u8 *)priv->recv_packet_buffer[i];
> +	priv->recv_packet_length[i] = rx_len;
> +
> +	ret = w5500_readbuf(dev, offset + 2, data, rx_len);
> +	if (ret)
> +		return -EIO;
> +
> +	tmp = offset + 2 + rx_len;
> +	if (w5500_writebulk(dev, W5100_S0_RX_RD(priv), (u8 *)&tmp, 2))
> +		return -EIO;
> +
> +	ret = w5500_command(dev, S0_CR_RECV);
> +	if (ret)
> +		return ret;
> +
> +	*packetp = data;
> +	priv->offset += rx_buf_len;
> +	return rx_len;
> +}
> +
> +static int w5500_eth_free_pkt(struct udevice *dev, u8 *packet, int length)
> +{
> +	struct eth_w5500_priv *priv = dev_get_priv(dev);
> +	u8 i;
> +
> +	for (i = 0; i < PKTBUFSRX ; i++)
> +		if (priv->recv_packet_buffer[i] == packet)
> +			priv->recv_packet_length[i] = 0;
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
> +	w5500_writebulk(dev, W5500_SIMR, &mask, 1);
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
> +static int w5500_eth_start(struct udevice *dev)
> +{
> +	struct eth_w5500_priv *priv = dev_get_priv(dev);
> +	int ret;
> +
> +	dev_dbg(dev, "eth_w5500: Start\n");
> +
> +	u8 mode = S0_MR_MACRAW;
> +
> +	if (!priv->promisc)
> +		mode |= W5500_S0_MR_MF;
> +
> +	if (w5500_writebulk(dev, W5100_S0_MR(priv), &mode, 1))
> +		return -EIO;
> +	ret = w5500_command(dev, S0_CR_OPEN);
> +	if (ret)
> +		return ret;
> +	priv->offset = 0;
> +	w5500_enable_intr(dev);
> +
> +	return 0;
> +}
> +
> +static int w5500_eth_write_hwaddr(struct udevice *dev)
> +{
> +	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct eth_w5500_priv *priv = dev_get_priv(dev);
> +
> +	if (memcmp(priv->host_hwaddr, pdata->enetaddr, ARP_HLEN) != 0) {
> +		memcpy(priv->host_hwaddr, pdata->enetaddr, ARP_HLEN);
> +		w5500_writebulk(dev, W5100_SHAR, priv->host_hwaddr, ARP_HLEN);
> +	}
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
> +int w5500_eth_probe(struct udevice *dev)
> +{
> +	struct eth_w5500_priv *priv = dev_get_priv(dev);
> +	int i;
> +	u8 tmp;
> +	u16 buf;
> +	int ret;
> +
> +	if (device_get_uclass_id(dev->parent) != UCLASS_SPI) {
> +		dev_dbg(dev, "Error device not attached to a SPI controller\n");
> +		return -ENODEV;
> +	}
> +
> +	priv->buffin = (u8 *)malloc(BUFFER_SZ);
> +	priv->buffout = (u8 *)malloc(BUFFER_SZ);
> +
> +	for (i = 0; i < PKTBUFSRX ; i++) {
> +		priv->recv_packet_buffer[i] = (u8 *)malloc(MAX_PACKET_SZ);
> +		if (!priv->recv_packet_buffer[i])
> +			goto exit2;
> +		priv->recv_packet_length[i] = 0;
> +	}
> +
> +	if (!(priv->buffin && priv->buffout)) {
> +		if (priv->buffin)
> +			free(priv->buffin);
> +		if (priv->buffout)
> +			free(priv->buffout);
> +		return -ENOMEM;
> +	}

Just check buffin & buffout right after allocating then
instead, and before allocation the recv_packet buffers.

> +
> +	tmp = MR_RST;
> +	if (w5500_writebulk(dev, W5100_MR, &tmp, 1))
> +		goto exit1;
> +	tmp = MR_PB;
> +	if (w5500_writebulk(dev, W5100_MR, &tmp, 1))
> +		goto exit1;
> +
> +	ret = w5500_readbulk(dev, W5500_RTR, (u8 *)&buf, 2);
> +	if (ret)
> +		goto exit1;
> +	if (buf != RTR_DEFAULT) {
> +		dev_dbg(dev, "RTR issue in probe .... %x\n", buf);
> +		goto exit1;
> +	}
> +
> +	w5500_disable_intr(dev);
> +
> +	/* Configure internal RX memory as 16K RX buffer and
> +	 * internal TX memory as 16K TX buffer
> +	 */
> +	tmp = 0x10;
> +	if (w5500_writebulk(dev, W5500_Sn_RXMEM_SIZE(0), &tmp, 1))
> +		goto exit1;
> +	if (w5500_writebulk(dev, W5500_Sn_TXMEM_SIZE(0), &tmp, 1))
> +		goto exit1;
> +
> +	tmp = 0;
> +	for (i = 1; i < 8; i++) {
> +		if (w5500_writebulk(dev, W5500_Sn_RXMEM_SIZE(i), &tmp, 1))
> +			goto exit1;
> +		if (w5500_writebulk(dev, W5500_Sn_TXMEM_SIZE(i), &tmp, 1))
> +			goto exit1;
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
> +exit1:
> +	if (priv->buffin)
> +		free(priv->buffin);
> +	if (priv->buffout)
> +		free(priv->buffout);
> +exit2:
> +	for (i = 0; i < PKTBUFSRX ; i++)
> +		if (priv->recv_packet_buffer[i])
> +			free(priv->recv_packet_buffer[i]);
> +	return -EIO;
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
> +	.probe = w5500_eth_probe,
> +	.ops = &w5500_eth_ops,
> +	.priv_auto = sizeof(struct eth_w5500_priv),
> +	.plat_auto = sizeof(struct eth_pdata),
> +};

The driver is in much better shape, fixup the error propagation and it will be all good !

Neil

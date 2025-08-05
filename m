Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028E8C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 06:18:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36E8C83253;
	Tue,  5 Aug 2025 08:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754374723;
	bh=WW2J6Z18YMWh5aISeX64cXk0BTA+BaaWLDjU1Fsz9Tw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=toDNgqN/zxp693uNoBLYWdoJO7jK/tkqFuH/mHiNsSAjvw6SIbflK4i0WYFNGVK0I
	 kx0mOdl9QlDw1eCRIwRmjXP5DzGdCfyd3kw/F13YFtoNFOZG2/F21VR3f84z4dhQXI
	 b49/viH0Mx5+ruCw8RhW4esILSJMQ9NH5LlUocQ8Ks+xHZxvjVjVaC8ajGlPa3A3t5
	 XqdunHulONuS8NeFU24ZfvkP4grnGwFyATFJ0LpyIFobjvPt6RIDv3ieUWYhGBbbj5
	 lumI7srnYlk5KP+34q1MYy13EHoOmAup9nVcJmVb1cb84akE2I4vKrHW0selJjJQ6J
	 ZQgNryRBmyuGQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C06BE840FB; Tue,  5 Aug 2025 08:18:41 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB68483106
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 08:18:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="AirLdPl6"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E447B1038C126; 
 Tue,  5 Aug 2025 08:18:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754374718;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=WW2J6Z18YMWh5aISeX64cXk0BTA+BaaWLDjU1Fsz9Tw=;
 b=AirLdPl6qcapZ29cw6byvJeQxjYfuTjK3XW5yeo55GESjnNrOotRplbQ9uZJRwCDNmCDqi
 gCeYBOt9RD5rpYMfJLmM9b3tUtPPMpPRb1q3lKaG1uMV/nBr8acOxjD0XvS7GtMju+KuNK
 iXz1LM+ILd7hhM0oXx9c9E+Dl7BO8JWBe3/N9l+EAQSrP3TmirTCCOwQcR7hIiBPfRNRGs
 DX6z341GRCBlLpeciUbLxdH4OSWVVfoYuJGoq6HX91VnobarbJ3+vk1V1NCGpZMtX2ljKb
 Uzuxuu9jhK0FNdgDABU6/R0sNEBzzkY/vFiPlP5rM3hMMamMiM/A2qPCrGPMEw==
Message-ID: <83871143-5441-5208-55fa-ced2b64cff37@denx.de>
Date: Tue, 5 Aug 2025 08:19:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v7 03/12] drivers: i3c: Add i3c uclass driver.
Content-Language: en-US
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, Jonas Karlman
 <jonas@kwiboo.se>, Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
References: <20250728065612.6039-1-dinesh.maniyam@altera.com>
 <20250728065612.6039-4-dinesh.maniyam@altera.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250728065612.6039-4-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Dinesh,

On 28.07.25 08:56, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> 
> Enable i3c general uclass driver. This uclass driver will have
> genaral read and write api to call the specific i3c driver.
> 
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   doc/api/i3c.rst          |  8 +++++
>   doc/api/index.rst        |  1 +
>   drivers/i3c/i3c-uclass.c | 38 +++++++++++++++++++++++
>   include/dw-i3c.h         |  1 +
>   include/i3c.h            | 67 ++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 115 insertions(+)
>   create mode 100644 doc/api/i3c.rst
>   create mode 100644 drivers/i3c/i3c-uclass.c
>   create mode 100644 include/i3c.h
> 
> diff --git a/doc/api/i3c.rst b/doc/api/i3c.rst
> new file mode 100644
> index 00000000000..7906face080
> --- /dev/null
> +++ b/doc/api/i3c.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +.. Copyright (C) 2025 Altera Corporation <www.altera.com>
> +
> +I3C Subsystem
> +===============
> +
> +.. kernel-doc:: include/i3c.h
> +   :internal:
> diff --git a/doc/api/index.rst b/doc/api/index.rst
> index a108718ea99..f3b6aefd854 100644
> --- a/doc/api/index.rst
> +++ b/doc/api/index.rst
> @@ -15,6 +15,7 @@ U-Boot API documentation
>      fs
>      getopt
>      interrupt
> +   i3c

please keep this list sorted.

>      led
>      linker_lists
>      lmb
> diff --git a/drivers/i3c/i3c-uclass.c b/drivers/i3c/i3c-uclass.c
> new file mode 100644
> index 00000000000..72944424c1d
> --- /dev/null
> +++ b/drivers/i3c/i3c-uclass.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
> + */
> +
> +#include <dm.h>
> +#include <i3c.h>
> +#include <errno.h>
> +#include <log.h>
> +#include <dm/device-internal.h>
> +#include <linux/ctype.h>
> +
> +int dm_i3c_read(struct udevice *dev, u32 dev_number,
> +		u8 *buf, u32 num_bytes)
> +{
> +	struct dm_i3c_ops *ops = i3c_get_ops(dev);
> +
> +	if (!ops->read)
> +		return -ENOSYS;
> +
> +	return ops->read(dev, dev_number, buf, num_bytes);
> +}
> +
> +int dm_i3c_write(struct udevice *dev, u32 dev_number,
> +		 u8 *buf, u32 num_bytes)
> +{
> +	struct dm_i3c_ops *ops = i3c_get_ops(dev);
> +
> +	if (!ops->write)
> +		return -ENOSYS;
> +
> +	return ops->write(dev, dev_number, buf, num_bytes);
> +}
> +
> +UCLASS_DRIVER(i3c) = {
> +	.id		= UCLASS_I3C,
> +	.name		= "i3c",
> +};
> diff --git a/include/dw-i3c.h b/include/dw-i3c.h
> index e37fd4dc325..920f18bccb4 100644
> --- a/include/dw-i3c.h
> +++ b/include/dw-i3c.h
> @@ -7,6 +7,7 @@
>   #define _DW_I3C_H_
>   
>   #include <clk.h>
> +#include <i3c.h>
>   #include <reset.h>
>   #include <dm/device.h>
>   #include <linux/bitops.h>
> diff --git a/include/i3c.h b/include/i3c.h
> new file mode 100644
> index 00000000000..59c787c21db
> --- /dev/null
> +++ b/include/i3c.h
> @@ -0,0 +1,67 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
> + */
> +
> +#include <linux/i3c/master.h>
> +
> +/**
> + * struct dm_i3c_ops - Driver operations for the I3C uclass
> + *
> + * This structure defines the set of operations that a driver must implement
> + * for interacting with an I3C controller in U-Boot.
> + *
> + */
> +struct dm_i3c_ops {
> +/**
> + * @i3c_xfers: Transfer messages in I3C
> + *
> + * @dev: I3C controller device instance.
> + * @xfers: List of I3C private SDR transfer messages.
> + * @nxfers: The number of messages to transfer.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +	int (*i3c_xfers)(struct i3c_dev_desc *dev,
> +			 struct i3c_priv_xfer *xfers,
> +			 u32 nxfers);
> +};
> +
> +/**
> + * i3c_get_ops - Retrieve the I3C operation functions for a device
> + * @dev: The I3C controller device.
> + *
> + * This macro returns the set of operation functions (`dm_i3c_ops`) implemented
> + * by the driver associated with the specified device. These operations define
> + * how the driver performs I3C communication tasks such as reading, writing,
> + * and message transfers.
> + *
> + * Return: The I3C operation structure for the device.
> + */
> +#define i3c_get_ops(dev)	((struct dm_i3c_ops *)(dev)->driver->ops)
> +
> +/**
> + * dm_i3c_write - Perform I3C write transaction
> + *
> + * @dev: Chip to write to
> + * @dev_number: The target device number from the driver model.
> + * @buf: Buffer containing data to write
> + * @num_bytes: Number of bytes to write.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int dm_i3c_write(struct udevice *dev, u32 dev_number,
> +		 u8 *buf, u32 num_bytes);
> +
> +/**
> + * dm_i3c_read - Perform I3C read transaction
> + *
> + * @dev: Chip to read from
> + * @dev_number: The target device number from the driver model.
> + * @buf: Place to put data
> + * @num_bytes: Number of bytes to read.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int dm_i3c_read(struct udevice *dev, u32 dev_number,
> +		u8 *buf, u32 num_bytes);
> \ No newline at end of file
> 

beside of the nitpick:

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

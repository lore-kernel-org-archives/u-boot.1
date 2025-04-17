Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB09C369CA
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 07:39:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9243182FC8;
	Thu, 17 Apr 2025 09:39:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="IRjkzSqh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38FAD82FD4; Thu, 17 Apr 2025 09:39:46 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D010982FC7
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 09:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744875576; x=1745480376; i=xypron.glpk@gmx.de;
 bh=x0ZAB+TpKyIqHmMRwmnfCVOH/knpkOuUUMK4XJQJ3vM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=IRjkzSqhooys2wp6muAYIzpmaD3Flvos4iLNCThV41Yq5MwhG4J3Qtul4YojcyMN
 ztCRBvuOk2fFmhS5oXwUOUmSvLl+w8gH0jsaik6EJp2hbADREEACgg4TxjJiljl12
 bsCxzsApWDzlIV2Ee1M4wk0NE27jPebMDms6Xu64joJcA21H1vcGKN/ktnaGSf/mr
 GewfAuUarYs53e7sN4mqJwC773cXqu+3apAH5AVgSBnNzB7uQwF7+7LNJcWARTg7j
 GWD8u83lSYlx1sglN950N7yqt6RYRJM5ZI6cIpyP9s5g2ML58v/279Auglzc6Fq5d
 ScU/jS8nl3ae+W+9IQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.106.153]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqb1c-1urWki0NYO-00jYZV; Thu, 17
 Apr 2025 09:39:36 +0200
Message-ID: <9a0ea314-8ff8-4ab3-8d75-4c5acdfb2c7d@gmx.de>
Date: Thu, 17 Apr 2025 09:39:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [resend v4 03/12] drivers: i3c: Add i3c uclass driver.
To: dinesh.maniyam@altera.com
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, Jonas Karlman
 <jonas@kwiboo.se>, Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>, u-boot@lists.denx.de
References: <20250417021840.6212-1-dinesh.maniyam@altera.com>
 <20250417021840.6212-4-dinesh.maniyam@altera.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250417021840.6212-4-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U4GIACBvHKlN3jn0CCnPS0DaTUvnfrroqHR05yCpK2y0v7sFDWO
 SU3kfdHPFLEqwOobfTdPqpXe2MEfPKRk7brR9Rm9kjTzsgLHAzTexn5qJuh77VW4JEULIcO
 B9U6qnzTZiyMCmJ7GpTmSw+l1E29CnjUWV0FOOyJnnG/wzvzI1ao82BRG8aNFkjT1avDDdG
 Y9d1CCyVCtdI7eAUFS0yg==
UI-OutboundReport: notjunk:1;M01:P0:yipgKymZvIY=;2OdDEe+jUCRdOL6QIcfDkYLMNcq
 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
 o65qX1NG1QbH+9kfoBPie8=
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/17/25 04:18, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>=20
> Enable i3c general uclass driver. This uclass driver will have
> genaral read and write api to call the specific i3c driver.
>=20
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   drivers/i3c/i3c-uclass.c | 38 ++++++++++++++++++++++++
>   include/dw-i3c.h         |  1 +
>   include/i3c.h            | 63 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 102 insertions(+)
>   create mode 100644 drivers/i3c/i3c-uclass.c
>   create mode 100644 include/i3c.h
>=20
> diff --git a/drivers/i3c/i3c-uclass.c b/drivers/i3c/i3c-uclass.c
> new file mode 100644
> index 00000000000..644f5788898
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
> +int dm_i3c_read(struct udevice *dev, u8 dev_number,
> +		u8 *buf, int num_bytes)
> +{
> +	struct dm_i3c_ops *ops =3D i3c_get_ops(dev);
> +
> +	if (!ops->read)
> +		return -ENOSYS;
> +
> +	return ops->read(dev, dev_number, buf, num_bytes);
> +}
> +
> +int dm_i3c_write(struct udevice *dev, u8 dev_number,
> +		 u8 *buf, int num_bytes)
> +{
> +	struct dm_i3c_ops *ops =3D i3c_get_ops(dev);
> +
> +	if (!ops->write)
> +		return -ENOSYS;
> +
> +	return ops->write(dev, dev_number, buf, num_bytes);
> +}
> +
> +UCLASS_DRIVER(i3c) =3D {
> +	.id		=3D UCLASS_I3C,
> +	.name		=3D "i3c",
> +};
> diff --git a/include/dw-i3c.h b/include/dw-i3c.h
> index e37fd4dc325..920f18bccb4 100644
> --- a/include/dw-i3c.h
> +++ b/include/dw-i3c.h
> @@ -7,6 +7,7 @@
>   #define _DW_I3C_H_
>  =20
>   #include <clk.h>
> +#include <i3c.h>
>   #include <reset.h>
>   #include <dm/device.h>
>   #include <linux/bitops.h>
> diff --git a/include/i3c.h b/include/i3c.h
> new file mode 100644
> index 00000000000..6ef4982dcf6
> --- /dev/null
> +++ b/include/i3c.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
> + */
> +
> +#include <linux/i3c/master.h>
> +
> +/**
> + * struct dm_i3c_ops - driver operations for i3c uclass
> + *
> + * Drivers should support these operations unless otherwise noted. Thes=
e
> + * operations are intended to be used by uclass code, not directly from
> + * other code.
> + */
> +struct dm_i3c_ops {
> +	/**
> +	 * Transfer messages in I3C mode.
> +	 *
> +	 * @see i3c_transfer
> +	 *
> +	 * @param dev Pointer to controller device driver instance.
> +	 * @param target Pointer to target device descriptor.
> +	 * @param msg Pointer to I3C messages.
> +	 * @param num_msgs Number of messages to transfer.

We follow
https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation

@param looks wrong.

Please, provide formally valid descriptions.

> +	 *
> +	 * @return @see i3c_transfer

%s/@return/Return:/

> +	 */

Please, add the header to doc/api/ and run `make htmldocs`. This will=20
highlight all formal documentation errors.

> +	int (*i3c_xfers)(struct i3c_dev_desc *dev,
> +			 struct i3c_priv_xfer *i3c_xfers,
> +			 int i3c_nxfers);

Why do you allow negative values of i3c_nxfers?

The parameter names should match the description.
> +};
> +

Please, add the missing documentation of the macro.

> +#define i3c_get_ops(dev)	((struct dm_i3c_ops *)(dev)->driver->ops)
> +
> +/**
> + * @brief Do i3c write
> + *
> + * Uclass general function to start write to i3c target
> + *
> + * @udevice pointer to i3c controller.
> + * @dev_number target device number.
> + * @buf target Buffer to write.
> + * @num_bytes length of bytes to write.

After each parameter a colon ':' is missing.

> + *
> + * @return 0 for success

%s/@return/Return:/

> + */
> +int dm_i3c_write(struct udevice *dev, u8 dev_number,
> +		 u8 *buf, int num_bytes);

What would be the meaning of a negative value of num_bytes?
An unsigned type probably would be more appropriate.

> +
> +/**
> + * @brief Do i3c read
> + *
> + * Uclass general function to start read from i3c target
> + *
> + * @udevice pointer to i3c controller.
> + * @dev_number target device number.
> + * @buf target Buffer to read.
> + * @num_bytes length of bytes to read.
> + *
> + * @return 0 for success
> + */
> +int dm_i3c_read(struct udevice *dev, u8 dev_number,
> +		u8 *buf, int num_bytes);

ditto

Best regards

Heinrich

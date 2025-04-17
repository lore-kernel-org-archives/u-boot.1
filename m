Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBFDC369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 07:25:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82E8282FC8;
	Thu, 17 Apr 2025 09:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="VWM5t6J+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0D4282FD4; Thu, 17 Apr 2025 09:25:24 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DF2E82FC7
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 09:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744874701; x=1745479501; i=xypron.glpk@gmx.de;
 bh=nv2eA4/Q00rV8b4iK7B6YFIwwO0Ey698dS5DOClGZBw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=VWM5t6J+Jqc7CYSmXJgluxciD+ZdQyvFlCMT3ZRrVR1uGV52gcp21MBhoL4YQcpX
 qGXb/dLVLhj3gmyfaOLmQkFw9XXDTvqYRZH2kjt8hAlfZwJdQbe4kP5x0pMQ92vT1
 81b9gi0honCy/4aPQyaatSaMBvRt1/9cMLRPg1WnbeH787Oit+QQgBE8OULz7wUUJ
 +Mj9rC3yh2Kz/SDxMEduAgxB2MPvKb/yk9vzx+mlWVEDo8FpQzK376Ai/1Wgwa0wo
 uHWCFqXkZ6yGUS82R4GkaDLBNyGdbDVs9lTWOwb+IBaRrUFMPZl3RY8c46CUjgZhJ
 cvwfHr70EB0k/m4b7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.106.153]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEV3C-1uLF023GP4-00CxxW; Thu, 17
 Apr 2025 09:25:01 +0200
Message-ID: <b9588495-6565-4101-a765-efad1b6f3cd1@gmx.de>
Date: Thu, 17 Apr 2025 09:24:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [resend v4 09/12] cmd: Add i3c command support.
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
 <20250417021840.6212-10-dinesh.maniyam@altera.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250417021840.6212-10-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yg9cq4HoMrn1lsKPK70FUzLNLyh2OfsRyIWR/aHlsPguUmKr+Ga
 yROgQRe54UM7SIyHDoF+CNj4mYzxEvmVeXZWoDU1J2fH1uO2Dt/PLkzIpBDBlDCBv5BIRYD
 TSKq8Pl8yFFJyZj7eOZdTbaCpXhW5LPoTrRi9t2uIhI2F/aIPimz5SyP/0rhbqZoz9OqIPF
 OZAt55ry0Q/5I/tFurU7g==
UI-OutboundReport: notjunk:1;M01:P0:dHfeosOWqiU=;+CsOwsCjFNe5+sd0UGr7uBpedT9
 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
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
> Add i3c command file to support select, get i3c device
> target list, read and write operation.
>=20
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   cmd/Kconfig                        |   6 +
>   cmd/Makefile                       |   1 +
>   cmd/i3c.c                          | 193 +++++++++++++++++++++++++++++
>   doc/usage/cmd/i3c.rst              |  98 +++++++++++++++
>   doc/usage/index.rst                |   1 +
>   drivers/i3c/master/dw-i3c-master.c |  35 +++++-
>   include/dw-i3c.h                   |   2 +
>   include/i3c.h                      |   4 +
>   8 files changed, 339 insertions(+), 1 deletion(-)
>   create mode 100644 cmd/i3c.c
>   create mode 100644 doc/usage/cmd/i3c.rst
>=20
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 642cc1116e8..551959731f0 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1327,6 +1327,12 @@ config CMD_I2C
>   	help
>   	  I2C support.
>  =20
> +config CMD_I3C
> +	bool "i3c"
> +	help
> +	  Enable command to list i3c devices connected to the i3c controller
> +	  and perform read and write on the connected i3c devices.
> +
>   config CMD_W1
>   	depends on W1
>   	default y if W1
> diff --git a/cmd/Makefile b/cmd/Makefile
> index 8410be576bb..082470fa104 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -95,6 +95,7 @@ obj-$(CONFIG_CMD_GPIO) +=3D gpio.o
>   obj-$(CONFIG_CMD_HISTORY) +=3D history.o
>   obj-$(CONFIG_CMD_HVC) +=3D smccc.o
>   obj-$(CONFIG_CMD_I2C) +=3D i2c.o
> +obj-$(CONFIG_CMD_I3C) +=3D i3c.o
>   obj-$(CONFIG_CMD_IOTRACE) +=3D iotrace.o
>   obj-$(CONFIG_CMD_HASH) +=3D hash.o
>   obj-$(CONFIG_CMD_IDE) +=3D ide.o disk.o
> diff --git a/cmd/i3c.c b/cmd/i3c.c
> new file mode 100644
> index 00000000000..5631f487cc2
> --- /dev/null
> +++ b/cmd/i3c.c
> @@ -0,0 +1,193 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2023 Intel Coporation.
> + */
> +
> +#include <bootretry.h>
> +#include <cli.h>
> +#include <command.h>
> +#include <console.h>
> +#include <dm.h>
> +#include <dw-i3c.h>
> +#include <edid.h>
> +#include <errno.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <asm/byteorder.h>
> +#include <linux/compiler.h>
> +#include <linux/delay.h>
> +#include <u-boot/crc.h>
> +#include <linux/i3c/master.h>
> +
> +static struct udevice *currdev;
> +static struct udevice *prevdev;
> +static struct dw_i3c_master *master;
> +
> +void low_to_high_bytes(void *data, size_t size)
> +{
> +	unsigned char *byte_data =3D (unsigned char *)data;
> +	size_t start =3D 0;
> +	size_t end =3D size - 1;
> +
> +	while (start < end) {
> +		unsigned char temp =3D byte_data[start];
> +
> +		byte_data[start] =3D byte_data[end];
> +		byte_data[end] =3D temp;
> +		start++;
> +		end--;
> +	}
> +}
> +
> +/**
> + * do_i3c() - Handle the "i3c" command-line command
> + * @cmdtp:    Command data struct pointer
> + * @flag:    Command flag
> + * @argc:    Command-line argument count
> + * @argv:    Array of command-line arguments
> + *
> + * Returns zero on success, CMD_RET_USAGE in case of misuse and negativ=
e
> + * on error.
> + */
> +static int do_i3c(struct cmd_tbl *cmdtp, int flag, int argc, char *cons=
t argv[])
> +{
> +	struct uclass *uc;
> +	int ret;
> +	struct udevice *dev_list;
> +	u32 length, bytes;
> +	u8 *data;
> +	u8 *rdata;
> +	u8 device_num;
> +
> +	if (argc > 1) {
> +		ret =3D uclass_get_device_by_name(UCLASS_I3C, argv[1], &currdev);
> +		if (ret) {
> +			if (!strcmp(argv[1], "help"))
> +				return CMD_RET_USAGE;

You don't need to check for "help". Just return CMD_RET_USAGE if the=20
first argument does not match any of the subcommands.

> +
> +			currdev =3D prevdev;
> +			if (!currdev) {
> +				ret =3D uclass_get(UCLASS_I3C, &uc);
> +				if (ret)
> +					return CMD_RET_FAILURE;
> +
> +				uclass_foreach_dev(dev_list, uc)
> +					printf("%s (%s)\n", dev_list->name, dev_list->driver->name);
> +
> +				printf("i3c master controller is not initialized: %s\n", argv[1]);
> +				return CMD_RET_FAILURE;
> +			}
> +		} else {
> +			master =3D dev_get_priv(currdev);
> +			printf("current dev: %s\n", currdev->name);
> +			prevdev =3D currdev;
> +		}
> +	} else {
> +		if (!currdev) {
> +			printf("No i3c device set!\n");
> +			return CMD_RET_FAILURE;
> +		}
> +		printf("dev: %s\n", currdev->name);
> +	}
> +
> +	if (!strcmp(argv[1], "list")) {

Why would you want to reach this if statment for argc =3D=3D 1?

> +		ret =3D uclass_get(UCLASS_I3C, &uc);
> +		if (ret)
> +			return CMD_RET_FAILURE;
> +
> +		uclass_foreach_dev(dev_list, uc)
> +		printf("%s (%s)\n", dev_list->name, dev_list->driver->name);
> +	}
> +
> +	if (!strcmp(argv[1], "current")) {
> +		if (!currdev)
> +			printf("no current dev!\n");
> +		else
> +			printf("current dev: %s\n", currdev->name);
> +	}
> +
> +	if ((!strcmp(argv[1], "write")) && !(argv[2] =3D=3D NULL) && !(argv[3]=
 =3D=3D NULL) &&
> +	    !(argv[4] =3D=3D NULL)) {
> +		length =3D hextoul(argv[3], NULL);
> +
> +		data =3D (u8 *)malloc(sizeof(u8) * length);
> +		if (!data) {
> +			debug("Memory allocation for data failed\n");
> +			return -ENOMEM;
> +		}
> +
> +		device_num =3D hextoul(argv[4], NULL);

device_num is u8. You should check that the value returned by hextoul=20
does not exceed 0xff.

> +		bytes =3D hextoul(argv[2], NULL);

Bytes is only 32bit wide. But the number returned by hextoul can be=20
larger than UINT_MAX leading to truncation.

Please, check the value range.

> +
> +		for (int i =3D 0; i < length; i++)
> +			data[i] =3D (u8)((bytes >> (8 * i)) & 0xFF);
> +
> +		low_to_high_bytes(data, length);
> +		ret =3D dm_i3c_write(currdev, device_num, data, length);

For unknown reasons you have defined the num_bytes parameter as signed=20
int. So length > INT_MAX will be transferred as a negative number.

Please, be consistent.

> +		if (ret) {
> +			ret =3D CMD_RET_FAILURE;
> +			goto write_out;
> +		}
> +	}
> +
> +	if (!strcmp(argv[1], "read") && !(argv[2] =3D=3D NULL) && !(argv[3] =
=3D=3D NULL)) {
> +		length =3D hextoul(argv[2], NULL);

Each subcommand should be handled in a separate static function to avoid=
=20
sphaghetti code.

> +
> +		rdata =3D (u8 *) malloc(sizeof(u8) * length);

This is not C++ code. Please, remove the (u8 *) conversion.

I would not expect sizeof(u8) to differ from 1. So remove it.

> +		if (!rdata) {
> +			debug("Memory allocation for rdata failed\n");
> +			return -ENOMEM;
> +		}
> +
> +		device_num =3D hextoul(argv[3], NULL);

Check that hextoul() returns a number in the 0 - 255 range.

> +
> +		ret =3D dm_i3c_read(currdev, device_num, rdata, length);
> +		if (ret) {
> +			ret =3D  CMD_RET_FAILURE;

Please, avoid duplicate space after '=3D'.

> +		} else {
> +			printf("Read buff: ");
> +			for (size_t i =3D 0; i < length; ++i)

length is u32. Why use a larger type for the index?

> +				printf("%02x", rdata[i]);

Please, use print_hex_dump() here. This is especially helpful when=20
reading hundres of bytes.

To be honest, it would make more sense to provide an address in memory=20
to receive the data than printing up to INT_MAX bytes.

> +
> +			printf("\n");
> +		}
> +
> +		goto read_out;
> +	}
> +
> +	if (!strcmp(argv[1], "device_list")) {
> +		if (master) {
> +			for (int i =3D 0; i < master->num_i3cdevs; i++) {
> +				printf("device:%d\n", i);
> +				printf("dynamic address:0x%X\n", master->i3cdev[i]->info.dyn_addr);
> +				printf("PID:%llx\n", master->i3cdev[i]->info.pid);
> +				printf("BCR:%X\n", master->i3cdev[i]->info.bcr);
> +				printf("DCR:%X\n", master->i3cdev[i]->info.dcr);
> +				printf("Max Read DS:%X\n", master->i3cdev[i]->info.max_read_ds);
> +				printf("Max Write DS:%X\n", master->i3cdev[i]->info.max_write_ds);
> +				printf("\n");
> +			}
> +		}
> +	}
> +
> +	return CMD_RET_SUCCESS;
> +
> +read_out:
> +	free(rdata);
> +	return ret;
> +
> +write_out:
> +	free(data);
> +	return ret;
> +}
> +
> +U_BOOT_CMD(
> +	i3c,    5,    1,     do_i3c,
> +	"access the system i3c\n",
> +	"i3c write<data><length><device_number> - write to device.\n"
> +	"i3c read<length><device_number> - read from device.\n"
> +	"i3c device_list   - List valid target devices\n"
> +	"i3c <i3c name>   - Select i3c controller.\n"

%s/i3c name/host controller/

> +	"i3c list   - List all the available i3c controller.\n"
> +	"i3c current   - print current i3c controller.\n"
> +);
> diff --git a/doc/usage/cmd/i3c.rst b/doc/usage/cmd/i3c.rst
> new file mode 100644
> index 00000000000..ade7b5c7fc4
> --- /dev/null
> +++ b/doc/usage/cmd/i3c.rst
> @@ -0,0 +1,98 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. index::
> +   single: i3c (command)
> +
> +i3c command
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Synopsis
> +--------
> +
> +::
> +
> +    i3c <i3c name>

%s/i3c name/host_controller/

> +    i3c current
> +    i3c list
> +    i3c device_list
> +    i3c write <data> <length> <device_number>

For sending large amounts of data it would be preferable to replace=20
direct data by a memory start address.

I would not want to type all bytes needed for displaying an image on an=20
LCD screen.


> +    i3c read <length> <device_number>

Same for reading. When reading a camera image you don't want megabytes=20
of data flooding the screen.

> +
> +
> +Description
> +-----------
> +
> +The ``i3c`` command is used to probe i3c master controller and perform =
read

%s/i3c master/an I3C host/

> +and write on the i3c devices.

%s/write on the i3c/write operations on the connected I3C/

i3c
=2D--

Probe an I3C host controller and select it for the other sub-commands.

host_controller
     name of the host controller to be probed and selected

> +
> +i3c current
> +------------
> +
> +* Display the current probed i3c controller.

%s/current probed i3c/currently selected I3C host/

> +
> +i3c list
> +----------
> +
> +List all the i3c controllers defined in the DT.

%s/i3c/I3C/

%s/DT/device-tree/

> +
> +i3c device_list
> +----------------
> +
> +List all the i3c devices' device number, dynamic address, PID, BCR, DCR=
,
 > +Max Write Speed and Max Read Speed of the probed i3c controller.

List all the I3C devices connected to the current host controller,=20
displaying

* device number
* dynamic address
* provisional ID (PID)
* value of the Bus Characteristics Register (BCR)
* value of the Device Characteristics Register (DCR)
* maximum write speed in MHz
* maximum read speed in MHz

Why wouldn't you print the static address, too?

> +
> +i3c write
> +-----------
> +
> +Perform write to the i3c device.
> +
> +i3c read
> +-----------
> +
> +Perform read from the i3c device.


Parameters
=2D---------

> +
> +i3c name

host_controller

> +    i3c name defined in DT

Name of the host controller as defined in the device-tree

> +
> +length
> +    Size of the data.
> +
> +device_number
> +    device number that connected to i3c controller.

It is unclear what is meant by device number. Is it the static address=20
or a device number in the driver model?

> +
> +data
> +    Bytes to be written to device.
> +
> +Examples
> +--------
> +
> +Probe i3c0::
> +
> +    =3D> i3c i3c0
> +
> +Check cuurent i3c controller::

Display current I3C host controller::

> +
> +    =3D> i3c current
> +
> +Check the device number and PID of the connected devices::
> +
> +    =3D> i3c device_list
> +
> +Perform write AA byte to a device 0::

Do you mean:

Write a single byte 0xaa to the device with static address 0 on the=20
selected host controller.

> +
> +    =3D> i3c write AA 1 0

It is unclear how to format multiple bytes to be written. Please,=20
provide an example with multiple bytes.

Does the data have to be capitalized or is lower case working, too?

> +
> +Perform read from a device 0::
> +
> +    =3D> i3c read 1 0

Where is the example output?

Best regards

Heinrich


> +
> +Configuration
> +-------------
> +
> +The ``i3c`` command is only available if CONFIG_CMD_I3C=3Dy.
> +
> +Return value
> +------------
> +
> +If the command succeeds, the return value ``$?`` is set to 0. If an err=
or occurs, the
> +return value ``$?`` is set to 1.
> diff --git a/doc/usage/index.rst b/doc/usage/index.rst
> index bf2335dc8f0..718b606b162 100644
> --- a/doc/usage/index.rst
> +++ b/doc/usage/index.rst
> @@ -80,6 +80,7 @@ Shell commands
>      cmd/if
>      cmd/itest
>      cmd/imxtract
> +   cmd/i3c
>      cmd/load
>      cmd/loadb
>      cmd/loadm
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-=
i3c-master.c
> index bf5d57937c7..623f5b01dbb 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -674,8 +674,11 @@ static int dw_i3c_master_daa(struct i3c_master_cont=
roller *m)
>   	newdevs &=3D ~olddevs;
>  =20
>   	for (pos =3D 0; pos < master->maxdevs; pos++) {
> -		if (newdevs & BIT(pos))
> +		if (newdevs & BIT(pos)) {
>   			i3c_master_add_i3c_dev_locked(m, master->addrs[pos]);
> +			master->i3cdev[pos] =3D m->this;
> +			master->num_i3cdevs++;
> +		}
>   	}
>  =20
>   	dw_i3c_master_free_xfer(xfer);
> @@ -1010,8 +1013,38 @@ err_assert_rst:
>   	return ret;
>   }
>  =20
> +static int dw_i3c_master_priv_read(struct udevice *dev, u8 dev_number,
> +				   u8 *buf, int buf_size)
> +{
> +	struct dw_i3c_master *master =3D dev_get_priv(dev);
> +	struct i3c_dev_desc *i3cdev =3D master->i3cdev[dev_number];
> +	struct i3c_priv_xfer i3c_xfers;
> +
> +	i3c_xfers.data.in =3D buf;
> +	i3c_xfers.len =3D buf_size;
> +	i3c_xfers.rnw =3D I3C_MSG_READ;
> +
> +	return dw_i3c_master_priv_xfers(i3cdev, &i3c_xfers, 1);
> +}
> +
> +static int dw_i3c_master_priv_write(struct udevice *dev, u8 dev_number,
> +				    u8 *buf, int buf_size)
> +{
> +	struct dw_i3c_master *master =3D dev_get_priv(dev);
> +	struct i3c_dev_desc *i3cdev =3D master->i3cdev[dev_number];
> +	struct i3c_priv_xfer i3c_xfers;
> +
> +	i3c_xfers.data.out =3D buf;
> +	i3c_xfers.len =3D buf_size;
> +	i3c_xfers.rnw =3D I3C_MSG_WRITE;
> +
> +	return dw_i3c_master_priv_xfers(i3cdev, &i3c_xfers, 1);
> +}
> +
>   static const struct dm_i3c_ops dw_i3c_ops =3D {
>   	.i3c_xfers =3D dw_i3c_master_priv_xfers,
> +	.read =3D dw_i3c_master_priv_read,
> +	.write =3D dw_i3c_master_priv_write,
>   };
>  =20
>   static const struct udevice_id dw_i3c_ids[] =3D {
> diff --git a/include/dw-i3c.h b/include/dw-i3c.h
> index 42c37d6dfa2..c652de77404 100644
> --- a/include/dw-i3c.h
> +++ b/include/dw-i3c.h
> @@ -241,6 +241,8 @@ struct dw_i3c_master {
>   	char type[5];
>   	u8 addrs[MAX_DEVS];
>   	bool first_broadcast;
> +	struct i3c_dev_desc *i3cdev[I3C_BUS_MAX_DEVS];
> +	u16 num_i3cdevs;
>   };
>  =20
>   struct dw_i3c_i2c_dev_data {
> diff --git a/include/i3c.h b/include/i3c.h
> index 6ef4982dcf6..969753ae49d 100644
> --- a/include/i3c.h
> +++ b/include/i3c.h
> @@ -28,6 +28,10 @@ struct dm_i3c_ops {
>   	int (*i3c_xfers)(struct i3c_dev_desc *dev,
>   			 struct i3c_priv_xfer *i3c_xfers,
>   			 int i3c_nxfers);
> +	int (*read)(struct udevice *dev, u8 dev_number,
> +		    u8 *buf, int num_bytes);
> +	int (*write)(struct udevice *dev, u8 dev_number,
> +		     u8 *buf, int num_bytes);
>   };
>  =20
>   #define i3c_get_ops(dev)	((struct dm_i3c_ops *)(dev)->driver->ops)


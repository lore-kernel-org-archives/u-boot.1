Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7966AC83F10
	for <u-boot@archiver.kernel.org>; Sat, 12 Jul 2025 08:16:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E62368006D;
	Sat, 12 Jul 2025 10:16:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1752308174;
	bh=lyWfOL57HShfn0qiInuhQLOnfcN6TrHY3VJHjleWB1E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=dRqES99cy97chd6JChBfemMK7LfyNKNnP+GiBHIoqmBDyikULg5iQfuxae7wIG+P4
	 f4qXWlsd6tyUudWR5Fi4oy+QAVFH0/PZj7U/mCHDXVcTTxFNngl+CbH7sS9Q9Eu853
	 Rz8yV9YQVGiDV99InNyhg0+Cvsp74RgDXxxhxrKuByqFGEdjNQTehLw6/6QyepM9X1
	 qVLmW74jQvJ4yQ2u4S5A4DzWRQxd04XVbjGiLCJOn+LIeLOf4EG/QkzCMHNw1L4cOi
	 NZUtaVq/fT3fr0uMKYqUv4BpaGPCKA5m7VGwAYO8tyv+ionnkuf/6QPdpUO78jufJy
	 8O0VwBqayxC6A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 641AC800D7; Sat, 12 Jul 2025 10:16:13 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52B5E8003E
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 10:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="B2CyEVcH"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5B79F10380104; 
 Sat, 12 Jul 2025 10:16:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1752308169;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=lyWfOL57HShfn0qiInuhQLOnfcN6TrHY3VJHjleWB1E=;
 b=B2CyEVcH+eKPalh8aSk+maXcHdk4na7n5L7fcuF91MnJc0j21r8QZByxfRxP1j59STzE/F
 B+/djvGajxNdJN6fF6H+q+vK3LJIE7cAdwDh1HQXfVVBJRLMg6av65KrDwsTmZB3eN63h4
 kjKxu+8jERmvIfoO4+6lJu9LmViFdrq00cqXA9TqmkGOClDNvaZ9dF6twamHhrVF1MEo6x
 jxnlKnxdPQzw4702MR8lKM1zfOnfkcCW3zvcFgEt70IHG5eEb6lZxG50UagR9I6JCSG1U5
 EQcvV47sRoWSx7u6lfDho7MJFctbwIpag7DIpJ7QBVA+O5SckGyn4+rsbxEqpw==
Message-ID: <49fb76ab-5e5a-9975-7992-2180349aedff@denx.de>
Date: Sat, 12 Jul 2025 10:16:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5 09/12] cmd: Add i3c command support.
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
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
References: <20250513101913.30880-1-dinesh.maniyam@altera.com>
 <20250513101913.30880-10-dinesh.maniyam@altera.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250513101913.30880-10-dinesh.maniyam@altera.com>
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

sorry for late reply...

On 13.05.25 12:19, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> 
> Add i3c command file to support select, get i3c device
> target list, read and write operation.
> 
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   cmd/Kconfig                        |   6 +
>   cmd/Makefile                       |   1 +
>   cmd/i3c.c                          | 261 +++++++++++++++++++++++++++++
>   doc/usage/cmd/i3c.rst              | 146 ++++++++++++++++
>   doc/usage/index.rst                |   1 +
>   drivers/i3c/master/dw-i3c-master.c |  35 +++-
>   include/dw-i3c.h                   |   2 +
>   include/i3c.h                      |  28 +++-
>   8 files changed, 478 insertions(+), 2 deletions(-)
>   create mode 100644 cmd/i3c.c
>   create mode 100644 doc/usage/cmd/i3c.rst

[...]

> diff --git a/cmd/i3c.c b/cmd/i3c.c
> new file mode 100644
> index 00000000000..7d2bde714cd
> --- /dev/null
> +++ b/cmd/i3c.c
> @@ -0,0 +1,261 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
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
> +#include <hexdump.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <asm/byteorder.h>
> +#include <linux/compiler.h>
> +#include <linux/delay.h>
> +#include <u-boot/crc.h>
> +#include <linux/i3c/master.h>
> +#include <linux/printk.h>
> +#include <linux/types.h>
> +
> +static struct udevice *currdev;
> +static struct udevice *prevdev;
> +static struct dw_i3c_master *master;
> +
> +static void low_to_high_bytes(void *data, size_t size)
> +{
> +	u8 *byte_data = data;
> +	size_t start = 0;
> +	size_t end = size - 1;
> +
> +	while (start < end) {
> +		u8 temp = byte_data[start];
> +
> +		byte_data[start] = byte_data[end];
> +		byte_data[end] = temp;
> +		start++;
> +		end--;
> +	}
> +}
> +
> +static int handle_i3c_select(const char *name)
> +{
> +	struct uclass *uc;
> +	struct udevice *dev_list;
> +	int ret = uclass_get_device_by_name(UCLASS_I3C, name, &currdev);
> +
> +	if (ret) {
> +		currdev = prevdev;
> +		if (!currdev) {
> +			ret = uclass_get(UCLASS_I3C, &uc);
> +			if (ret)
> +				return CMD_RET_FAILURE;
> +
> +			uclass_foreach_dev(dev_list, uc)
> +				printf("%s (%s)\n", dev_list->name, dev_list->driver->name);
> +
> +			printf("i3c: Host controller not initialized: %s\n", name);
> +			return CMD_RET_FAILURE;
> +		}
> +	} else {
> +		master = dev_get_priv(currdev);
> +		printf("i3c: Current controller: %s\n", currdev->name);
> +		prevdev = currdev;
> +	}
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
> +static int handle_i3c_list(void)
> +{
> +	struct uclass *uc;
> +	struct udevice *dev_list;
> +	int ret = uclass_get(UCLASS_I3C, &uc);
> +
> +	if (ret)
> +		return CMD_RET_FAILURE;
> +
> +	uclass_foreach_dev(dev_list, uc)
> +		printf("%s (%s)\n", dev_list->name, dev_list->driver->name);
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
> +static int handle_i3c_current(void)
> +{
> +	if (!currdev)
> +		printf("i3c: No current controller selected\n");
> +	else
> +		printf("i3c: Current controller: %s\n", currdev->name);
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
> +static int handle_i3c_device_list(void)
> +{
> +	if (!master) {
> +		printf("i3c: No controller active\n");
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	for (int i = 0; i < master->num_i3cdevs; i++) {
> +		struct i3c_device_info *info = &master->i3cdev[i]->info;
> +
> +		printf("Device %d:\n", i);
> +		printf("  Static Address  : 0x%02X\n", info->static_addr);
> +		printf("  Dynamic Address : 0x%X\n", info->dyn_addr);
> +		printf("  PID             : %016llx\n", info->pid);
> +		printf("  BCR             : 0x%X\n", info->bcr);
> +		printf("  DCR             : 0x%X\n", info->dcr);
> +		printf("  Max Read DS     : 0x%X\n", info->max_read_ds);
> +		printf("  Max Write DS    : 0x%X\n", info->max_write_ds);
> +		printf("\n");
> +	}
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
> +static int handle_i3c_write(int argc, char *const argv[])
> +{
> +	if (argc < 5)
> +		return CMD_RET_USAGE;
> +
> +	if (!currdev) {
> +		printf("i3c: No I3C controller selected\n");
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	u32 mem_addr = hextoul(argv[2], NULL);
> +	u32 num_bytes = hextoul(argv[3], NULL);
> +	u32 dev_num_val = hextoul(argv[4], NULL);

Please move the variable declaration to top of the function. Please
fix this for all appearances, thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

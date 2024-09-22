Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B05CF9C6D
	for <u-boot@archiver.kernel.org>; Sun, 22 Sep 2024 21:42:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D663988CE7;
	Sun, 22 Sep 2024 23:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727041317;
	bh=lrnRr/bbNITCvpDQr646bJ+cvKd1sRJm6bBY31rEhdg=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wcM64fPYb/5bikmGWLPvTdaEMcvVr78h1K5FOX/y/bEvQyMRCfBEDZ0QEaUZjcPkI
	 9AsFxaF9QG8nCjrz2ZcgOKJ1HfPjW6xQTZqUx/64v3xMIt+xkt4UNwBqV4MSEZ1wQo
	 nISU9JzYmxhmTuewYjj333cDpN8dM1SPWk9Svr1UYdqx3nfWWSxYAh+nUCsOKLEPTK
	 e1zz8q+9A06/MTK/spLs25K6uYzM+ZIl+2+XPayIOzfgAhUpvuxMxiDXfS6kl1mZG0
	 GVJTQLmBgiVtIeFkFRdaITYf80YaW3+MLHzN4Zk2XxLg+O0kmM+i8R8u4+q7lYcYg1
	 Bs5VLcFpwuQIA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 477D788CA2;
 Sun, 22 Sep 2024 23:41:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727041315;
 bh=lrnRr/bbNITCvpDQr646bJ+cvKd1sRJm6bBY31rEhdg=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=rEnmUq5G1+QkJI3/pVNtdbrJ/0Jr5D6+Kp4lOLx5NkS4/FLGGIyX4TW9h92rysaQJ
 I+orDGQV0kWuw5++2fbh8A9cmmlH45AGpROpYjStxbMf5Qdz25w66BtYSRL2YhcJLg
 DdE7aWoVPk9I7qFjyCvEueW0gQztikw+5Blj1rCCGwZjnL8wy8sxDntG8gfLIv93BR
 xTwDTJmIqsDkFV7xXMR8iZYsPY/dVATIlAX4onNuCoz/xwksR4YpeUciOJYK+F1kJF
 VUI4ldiuUO7sQKjOKx6r3bBzZsGH3FBJfRoENndPxj3ZdKDs/jLa7cKK0i6MJwF31g
 yEP/IpWKuNTUQ==
Message-ID: <66fd47a5-36ee-4e4c-b249-a741df567ba4@denx.de>
Date: Sun, 22 Sep 2024 23:30:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] ARM: socfpga: add Enclustra AA1 demo env files
To: Lothar Rubusch <l.rubusch@gmail.com>, u-boot@lists.denx.de,
 trini@konsulko.com, simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
References: <20240917062157.3181-1-l.rubusch@gmail.com>
 <20240917062157.3181-6-l.rubusch@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240917062157.3181-6-l.rubusch@gmail.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/17/24 8:21 AM, Lothar Rubusch wrote:
> Provide additional uboot.env text environment files meant as a generic
> demo. The default environment uses a uboot.env. The default environment
> works somehow.

What does this "somehow" mean ?

> This environment provides better support but only shows
> one possible approach used in the Enclustra reference design setups.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>   board/enclustra/mercury_aa1/mercury_aa1.env | 65 +++++++++++++++++++++
>   1 file changed, 65 insertions(+)
>   create mode 100644 board/enclustra/mercury_aa1/mercury_aa1.env
> 
> diff --git a/board/enclustra/mercury_aa1/mercury_aa1.env b/board/enclustra/mercury_aa1/mercury_aa1.env
> new file mode 100644
> index 0000000000..07b4a95a75
> --- /dev/null
> +++ b/board/enclustra/mercury_aa1/mercury_aa1.env
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 Enclustra GmbH
> + * <info@enclustra.com>
> + *
> + * This is an example configuration file for uboot.env generation.
> + *
> + * Given ENV_FAT_FILE defaults to "uboot.env" and ENV_SIZE defaults to 0x80000
> + * (see configuration options). Then adjust the configuration to your needs and
> + * build the a binary .env file as follows
> + * $ ./tools/mkenvimage -s 0x80000 -o uboot.env ./board/enclustra/mercury_aa1/mercury_aa1.env
> + *
> + * NB: Without providing this binary uboot.env the board is supposed to come up

What does NB: mean ?

> + * with the generic environment based on the architecture. This can be helpful
> + * when upgrading and/or recuding environments.
> + */

Can you please pick one method of specifying board environment ? Either 
this or include/configs/board.h, but do not use both, that is confusing.

> +bitstream_size=0xD00000
> +bootargs=earlycon console=ttyS0,115200 rw rootwait root=/dev/mmcblk0p3
> +bootargs_qspi=earlycon console=ttyS0,115200 rw root=/dev/ram0
> +bootm_size=0x0a000000
> +devnum=0
> +devtype=mmc
> +distro_bootpart=1
> +env_size=0x80000
> +fdt_addr_r=0x10000000
> +fdtfile=system.dtb
> +fdtload=
> +	load ${devtype} ${devnum}:${distro_bootpart} ${fdt_addr_r} ${bootdir}/${fdtfile};
> +	load ${devtype} ${devnum}:${distro_bootpart} ${fdto_addr_r} ${bootdir}/${fdtofile};

&& instead of ;

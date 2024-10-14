Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5008BD1813C
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 18:42:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE32188E8E;
	Mon, 14 Oct 2024 20:42:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728931324;
	bh=ZPgxcSJ4cAEeVTeSclXRjhkjEmrMpQTBIMLDQzonMZ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZqRlE3mgEd3ICBIN+9O12evm9MT2YEmXeS3KyAD16o3GyOzOkl5LiyngDWa3mFlit
	 kIYKVeYB7N2MTdlqqANTAOaT01XoQJXhnwT94sjB88CC3mjGjv89Ka2uNoKf0cfhiv
	 WcQNgnLPicvSP58zf2b9Q1trYNQUsRNaLHMCZj75orOpuBPTbF7p7Zl8OL/c/iY6M3
	 Npp8TeAeaYYwa00ie3sC8b9+niUG8AEwZCTwzF7xVVP8fhc3Pv0wneTw3Qxp05m1Im
	 RgO08zedaBs/C7PBgPximiGSci2qXqO7dHK/K3NU5Jh5EEB2gNNmq72AH7J9LJNyMQ
	 qUK+KqCWA0/lg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8DC2788C63;
 Mon, 14 Oct 2024 20:42:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728931323;
 bh=ZPgxcSJ4cAEeVTeSclXRjhkjEmrMpQTBIMLDQzonMZ8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Mi+dzB86jfn0bIabr7BArnnR/NUsf0nbbv0j8vtQBoSCD/Q7DoSfofNMc9CECjHsx
 yFVZfRZ6f4/P7Nsu1Q8+4/ByFXOEv5o7zSej4uj1TXoMroRdYgbQM6/410Sq0BphFp
 /nvvf/tDIavOAtI2RoVfYU66S0bSsF4exCLxA/8//xt5XsYVYQu43ltVq3OqbiWyd2
 /2Sjnvd2utTB1uK4hXklb8QYQyMWeVUUoeWhWJfCVFHtktIn7Kox0K512mi8yxSmf3
 Lv/72sNo89GgVY8S6GSkcmDnpJVqcndJ7C195vjCPc35WxVPGqrLSP/m9aBYCuaLz0
 cuokAmLpUJACg==
Message-ID: <ce29c957-4198-4947-b7de-7e10ed385eab@denx.de>
Date: Mon, 14 Oct 2024 19:43:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] ARM: socfpga: add Mercury+ AA1 SoM support
To: Lothar Rubusch <l.rubusch@gmail.com>, u-boot@lists.denx.de,
 trini@konsulko.com, simon.k.r.goldschmidt@gmail.com,
 tien.fong.chee@intel.com, sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com
References: <20241013143232.2090645-1-l.rubusch@gmail.com>
 <20241013143232.2090645-3-l.rubusch@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241013143232.2090645-3-l.rubusch@gmail.com>
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

On 10/13/24 4:32 PM, Lothar Rubusch wrote:

[...]

> +++ b/board/enclustra/mercury_aa1/MAINTAINERS
> @@ -0,0 +1,10 @@
> +Enclustra Mercury+ AA1
> +M:	Lothar Rubusch <l.rubusch@gmail.com>
> +S:	Maintained
> +F:	board/enclustra/mercury_aa1/
> +F:	board/enclustra/common/
> +F:	configs/socfpga_enclustra_mercury_aa1_defconfig
> +F:	doc/board/enclustra/mercury-aa1.rst
> +F:	include/configs/socfpga_mercury_aa1.h
> +N:	enclustra
> +N:	mercury_aa1

I think the N: will match on all the files listed in F: above too, so 
you can remove the F:

> diff --git a/board/enclustra/mercury_aa1/fpga.its b/board/enclustra/mercury_aa1/fpga.its
> new file mode 100644
> index 0000000000..cb42d61fbd
> --- /dev/null
> +++ b/board/enclustra/mercury_aa1/fpga.its
> @@ -0,0 +1,32 @@
> +/dts-v1/;
> +
> +/ {
> +	description = "FIT image with FPGA bistream";
> +	#address-cells = <1>;
> +
> +	images {
> +		fpga-periph-1 {
> +			description = "FPGA peripheral bitstream";
> +			data = /incbin/("../../../bitstream.periph.rbf");
> +			type = "fpga";
> +			arch = "arm";
> +			compression = "none";
> +		};
> +
> +		fpga-core-1 {
> +			description = "FPGA core bitstream";
> +			data = /incbin/("../../../bitstream.core.rbf");
> +			type = "fpga";
> +			arch = "arm";
> +			compression = "none";
> +		};
> +	};
> +
> +	configurations {
> +		default = "config-1";
> +		config-1 {
> +			description = "Boot with FPGA early IO release config";
> +			fpga = "fpga-periph-1", "fpga-core-1";
> +		};
> +	};
> +};

Can this be generated using binman instead ?

[...]

> diff --git a/doc/board/enclustra/mercury-aa1.rst b/doc/board/enclustra/mercury-aa1.rst
> index c4b3359220..6a96bf70e3 100644
> --- a/doc/board/enclustra/mercury-aa1.rst
> +++ b/doc/board/enclustra/mercury-aa1.rst
> @@ -165,7 +165,7 @@ The demo shows booting a AA1 + ST1 setup and stopping at the u-boot shell.
>   
>   Here is the console output::
>   
> -  U-Boot SPL 2024.10-rc4-00416-gf0b9c383e6c3 (Sep 08 2024 - 14:03:59 +0000)
> +  U-Boot SPL 2024.10-rc4-00416-gf0b9c383e6c3 (Sep 27 2024 - 14:03:59 +0000)

Remove the commit hash and timestamp from the examples, so they wouldn't 
get updated randomly. Also, this change(s) should be in patch 1/10 I think.

[...]

> diff --git a/include/configs/socfpga_mercury_aa1.h b/include/configs/socfpga_mercury_aa1.h
> new file mode 100644
> index 0000000000..a5b63336e8
> --- /dev/null
> +++ b/include/configs/socfpga_mercury_aa1.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2024 Enclustra GmbH
> + * <info@enclustra.com>
> + */
> +
> +#ifndef __CONFIG_SOCFGPA_MERCURY_AA1_H__
> +#define __CONFIG_SOCFGPA_MERCURY_AA1_H__
> +
> +#include <asm/arch/base_addr_a10.h>
> +
> +/*
> + * U-Boot general configurations
> + */
> +
> +/* Memory configurations  */
> +#define PHYS_SDRAM_1_SIZE		0x80000000
> +
> +/*
> + * Serial / UART configurations
> + */
> +#define CFG_SYS_BAUDRATE_TABLE {4800, 9600, 19200, 38400, 57600, 115200}
Maybe the default baudrate table is OK too ?

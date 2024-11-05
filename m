Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5438D1266B
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 08:39:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E21588E63;
	Tue,  5 Nov 2024 09:39:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730795955;
	bh=xryEgUPot00nbxUQoium8P2RVo1jose2jmtpSFAJ228=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=fAiuJrjjpmXkHe5KJIDwjLXyR+MYNmyDbrkiZghjq0mCxN3EO9Md0Eq0FrK7FEt8F
	 O8xnz6IAYdE4bpgfA8VifraicIVQW4hGnzM0Q5xoNqhVYK75rtFeMSzT5FShA7roD4
	 NGmfBpAs9N+O2xxWZTC5W5BUef/vocqm/+6N4719yOsv7WGsIOmgmJxJYW0mUyUNJI
	 xhatruIf9kTsVZ+WwU+hkThOgrEkrTdTAuk8tTvfrRm5QfWidkQ9LMS5liFRBL4BjZ
	 QOEZInHsuGffxI44GEtyCqmR19uc/qowRs7CpGk31b17PY9uIzpzApPnDSIfaOzpj5
	 TyQ2UVMvZ48Ow==
Received: from [192.168.1.107] (87-97-112-21.pool.digikabel.hu [87.97.112.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1863A88E63;
 Tue,  5 Nov 2024 09:39:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1730795953;
 bh=xryEgUPot00nbxUQoium8P2RVo1jose2jmtpSFAJ228=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=BfdQCtcQuukzJs65XxK9582TUEVyT6AwHGhj1Wezdg4llArsWAl8uOO8AN+3MPAIX
 +QW8Uvtz2O5HTmLA0BTYxq47MjYWW2NPDSTXJ92Neg5mg7Gfxh0Q4cGPgnvROqNd8g
 9WyvxNEzY7iRleT+5OffWCdgt8A3WoSrZy2fbJ8fAuYI+bGNJcnlkuluoEyW7g1EH+
 3RxhPfTR8CVT5bu2a4gnhzqu0NLLxjHKv5Y1XIPpJ6XX778rnKYfNOvqtnarxKlxZr
 J06OGazhDPeA5Qa9mSix4lgil75tsj89nQ3fFw7dTZavKYeh4hHkpHSbmFC3pbsPV+
 YI6yhrkB3QzNg==
Message-ID: <a9283eeb-b186-e0a0-b9db-d77048ea0fb3@denx.de>
Date: Tue, 5 Nov 2024 09:36:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/1] drivers: bootcount: Add ZynqMP specific bootcount
 support
Content-Language: en-US
To: Vasileios Amoiridis <vassilisamir@gmail.com>, trini@konsulko.com,
 michal.simek@amd.com, pro@denx.de, sjg@chromium.org
Cc: vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
References: <20241105074917.546887-1-vassilisamir@gmail.com>
 <20241105074917.546887-2-vassilisamir@gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20241105074917.546887-2-vassilisamir@gmail.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Amoiridis,

On 05.11.24 08:49, Vasileios Amoiridis wrote:
> From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> 
> Add native support of the bootcount mechanism in the ZynqMP by
> utilising internal PMU registers. The Persistent Global Storage
> Registers of the Platform Management Unit can keep their value
> during reboot cycles unless there is a POR reset, making them
> appropriate for the bootcount mechanism.
> 
> Signed-off-by: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> ---
>   MAINTAINERS                                  |  1 +
>   arch/arm/mach-zynqmp/include/mach/hardware.h |  2 +
>   drivers/bootcount/Kconfig                    |  6 +++
>   drivers/bootcount/Makefile                   |  1 +
>   drivers/bootcount/bootcount_zynqmp.c         | 47 ++++++++++++++++++++
>   5 files changed, 57 insertions(+)
>   create mode 100644 drivers/bootcount/bootcount_zynqmp.c

Please add a history of changes you did, see:

https://docs.u-boot.org/en/latest/develop/sending_patches.html#sending-updated-patch-versions

Hint: I prefer to use patman for this.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0399ed1dbf..bc27a514e8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -860,6 +860,7 @@ M:	Michal Simek <michal.simek@amd.com>
>   S:	Maintained
>   T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
>   F:	arch/arm/mach-zynqmp/
> +F:	drivers/bootcount/bootcount_zynqmp.c
>   F:	drivers/clk/clk_zynqmp.c
>   F:	driver/firmware/firmware-zynqmp.c
>   F:	drivers/fpga/zynqpl.c
> diff --git a/arch/arm/mach-zynqmp/include/mach/hardware.h b/arch/arm/mach-zynqmp/include/mach/hardware.h
> index 49e449ebd6..3c372bd6dc 100644
> --- a/arch/arm/mach-zynqmp/include/mach/hardware.h
> +++ b/arch/arm/mach-zynqmp/include/mach/hardware.h
> @@ -188,6 +188,8 @@ struct pmu_regs {
>   	u32 gen_storage4; /* 0x40 */
>   	u32 reserved1[1];
>   	u32 gen_storage6; /* 0x48 */
> +	u32 reserved2[3];
> +	u32 pers_gen_storage2; /* 0x58 */
>   };
>   
>   #define pmu_base ((struct pmu_regs *)ZYNQMP_PMU_BASEADDR)
> diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
> index fa6d8e7128..f91074d5b4 100644
> --- a/drivers/bootcount/Kconfig
> +++ b/drivers/bootcount/Kconfig
> @@ -164,6 +164,12 @@ config DM_BOOTCOUNT_SYSCON
>   
>   	  Accessing the backend is done using the regmap interface.
>   
> +config DM_BOOTCOUNT_ZYNQMP
> +	bool "Support ZynqMP PMUFW as a backing store for bootcount"
> +	help
> +	  Enable support for the bootcount API by utilising the Persistent
> +	  Global General Storage Register 2 of the PMU.
> +
>   endmenu
>   
>   endif
> diff --git a/drivers/bootcount/Makefile b/drivers/bootcount/Makefile
> index 245f879633..0cf79e428d 100644
> --- a/drivers/bootcount/Makefile
> +++ b/drivers/bootcount/Makefile
> @@ -16,3 +16,4 @@ obj-$(CONFIG_DM_BOOTCOUNT_I2C_EEPROM)	+= i2c-eeprom.o
>   obj-$(CONFIG_DM_BOOTCOUNT_I2C)	+= bootcount_dm_i2c.o
>   obj-$(CONFIG_DM_BOOTCOUNT_SPI_FLASH)	+= spi-flash.o
>   obj-$(CONFIG_DM_BOOTCOUNT_SYSCON) += bootcount_syscon.o
> +obj-$(CONFIG_DM_BOOTCOUNT_ZYNQMP)	+= bootcount_zynqmp.o
> diff --git a/drivers/bootcount/bootcount_zynqmp.c b/drivers/bootcount/bootcount_zynqmp.c
> new file mode 100644
> index 0000000000..060bbdbae9
> --- /dev/null
> +++ b/drivers/bootcount/bootcount_zynqmp.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-FileCopyrightText: 2024 CERN (home.cern)
> +
> +#include <asm/arch/hardware.h>
> +#include <bootcount.h>
> +#include <dm.h>
> +#include <dm/platdata.h>
> +#include <stdio.h>
> +#include <zynqmp_firmware.h>
> +
> +static int bootcount_zynqmp_set(struct udevice *dev, const u32 val)
> +{
> +	int ret;
> +
> +	ret = zynqmp_mmio_write((ulong)&pmu_base->pers_gen_storage2, 0xFF, val);
> +	if (ret)
> +		pr_info("%s mio write fail\n", __func__);

Nitpick: I think you do not need "mio" ...

> +
> +	return ret;
> +}
> +
> +static int bootcount_zynqmp_get(struct udevice *dev, u32 *val)
> +{
> +	int ret;
> +
> +	*val = 0;
> +	ret = zynqmp_mmio_read((ulong)&pmu_base->pers_gen_storage2, val);
> +	if (ret)
> +		pr_info("%s mio write fail\n", __func__);

Here too... remove mio and s/write/read

> +
> +	return ret;
> +}
> +
> +U_BOOT_DRVINFO(bootcount_zynqmp) = {
> +	.name = "bootcount_zynqmp",
> +};
> +
> +static const struct bootcount_ops bootcount_zynqmp_ops = {
> +	.get = bootcount_zynqmp_get,
> +	.set = bootcount_zynqmp_set,
> +};
> +
> +U_BOOT_DRIVER(bootcount_zynqmp) = {
> +	.name = "bootcount_zynqmp",
> +	.id = UCLASS_BOOTCOUNT,
> +	.ops = &bootcount_zynqmp_ops,
> +};
> 

Thanks! Beside of the nitpicks

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

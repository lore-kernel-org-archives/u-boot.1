Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D31C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 09:54:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C558786EE0;
	Tue, 19 Dec 2023 10:54:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1702979663;
	bh=ZOdGzy0KA4MXeUwAQi4u1Qbv6wZzWHDL3L/CJ21CCHQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rMfBlCVXwfjjVzmj0gLLqb8eC9D2kVvyXV/LpIw3vdMgcwavCmVTZVilZ9qlKJQ+R
	 mPOB2OoacuVBtfl73OisecTU90t7IJ8ThJ/3rqt01vtS1fDtiGNNUeNpoNdjp1Z/BU
	 rZRnHeheOtWTeBCrRpI+2lMMeLGamQqNI+aaE0F+f4uBrlezuSRGkUNK8tx+bzIzAo
	 nJW1Sn+yYhs2MN9JhQBHHIEZ4gbdHdZnLUdcl92lmOgI4lzNLlMb0mgHzsG7APZ6ef
	 7F/WQ+3qao283FF+bhdmOIbBacRV7BOhJCM7Mtex1yWxKrfhlNJIhvwanWWMQmFBLP
	 3vYnxNuKeqrww==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BF39A86EEB;
 Tue, 19 Dec 2023 10:54:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1702979662;
 bh=ZOdGzy0KA4MXeUwAQi4u1Qbv6wZzWHDL3L/CJ21CCHQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UjLePv1/SOAx9l8ChUZU0mkgGLYmVV4nOWIwc2WAAtRr+Uc0hj39cemBPnXiv1wIe
 rptpkwpcda7/DvVDLl9pHOxMoEiOgBQNAN9Mj7RilYN8yrkTxkknFEK1YDCnVh+Bwi
 HNMdkCIFc98jtdH0I3jSp0ybwOzr3qFTlX9I5XLObPYjGZXKKzdkcLwnIZU+ZHJIgc
 ytyHA3+HaYsc+p8v8kyn3kvXbVQU8VDSDveuBLaMgzBETWKPqgcGyFIGWzPRtUIaMJ
 7eoB7DNMPWBqx5xxSQ+RUX3wYQTHk3Frjug+K/XICuySBBX2Exf9Vk+y6JW/SPShA3
 siLZ5281wqbwg==
Message-ID: <edccf82f-2c65-4f09-bd9d-f94765ae015d@denx.de>
Date: Tue, 19 Dec 2023 10:54:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] drivers: misc: Add socfpga_dtreg driver for Intel
 SoCFPGA
To: "Chee, Tien Fong" <tien.fong.chee@intel.com>,
 "Lau, Wan Yee" <wan.yee.lau@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Bin Meng <bmeng.cn@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jean-Marie Lemetayer <j.lemetayer@kerlink.fr>, Peng Fan <peng.fan@nxp.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@intel.com>,
 "Maniyam, Dinesh" <dinesh.maniyam@intel.com>,
 "Ng, Boon Khai" <boon.khai.ng@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>,
 "Chong, Teik Heng" <teik.heng.chong@intel.com>,
 "Zamri, Muhammad Hazim Izzat" <muhammad.hazim.izzat.zamri@intel.com>,
 "Lim, Jit Loon" <jit.loon.lim@intel.com>,
 "Tang, Sieu Mun" <sieu.mun.tang@intel.com>
References: <20231208083726.26906-1-wan.yee.lau@intel.com>
 <DM8PR11MB5592CA687BF05641806BA22BD297A@DM8PR11MB5592.namprd11.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <DM8PR11MB5592CA687BF05641806BA22BD297A@DM8PR11MB5592.namprd11.prod.outlook.com>
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

On 12/19/23 08:03, Chee, Tien Fong wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Lau, Wan Yee <wan.yee.lau@intel.com>
>> Sent: Friday, December 8, 2023 4:37 PM
>> To: u-boot@lists.denx.de
>> Cc: Simon Glass <sjg@chromium.org>; Kever Yang <kever.yang@rock-
>> chips.com>; Bin Meng <bmeng.cn@gmail.com>; Jonas Karlman
>> <jonas@kwiboo.se>; Jean-Marie Lemetayer <j.lemetayer@kerlink.fr>; Peng
>> Fan <peng.fan@nxp.com>; Vladimir Zapolskiy
>> <vladimir.zapolskiy@linaro.org>; Konrad Dybcio <konrad.dybcio@linaro.org>;
>> Marek Vasut <marex@denx.de>; Simon Goldschmidt
>> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
>> <tien.fong.chee@intel.com>; Hea, Kok Kiang <kok.kiang.hea@intel.com>;
>> Maniyam, Dinesh <dinesh.maniyam@intel.com>; Ng, Boon Khai
>> <boon.khai.ng@intel.com>; Yuslaimi, Alif Zakuan
>> <alif.zakuan.yuslaimi@intel.com>; Chong, Teik Heng
>> <teik.heng.chong@intel.com>; Zamri, Muhammad Hazim Izzat
>> <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
>> <jit.loon.lim@intel.com>; Tang, Sieu Mun <sieu.mun.tang@intel.com>
>> Subject: [PATCH v1 1/1] drivers: misc: Add socfpga_dtreg driver for Intel
>> SoCFPGA
>>
>> From: Wan Yee Lau <wan.yee.lau@intel.com>
>>
>> This driver can be used to provide user a clean interface and all register
>> settings are centralized in one place, device tree without need for
>> hardcoding in the source code.
>>
>> Signed-off-by: Wan Yee Lau <wan.yee.lau@intel.com>
>> ---
>>   .../misc/socfpga_dtreg.txt                    |  66 ++++++++++
>>   drivers/misc/Kconfig                          |   7 ++
>>   drivers/misc/Makefile                         |   1 +
>>   drivers/misc/socfpga_dtreg.c                  | 117 ++++++++++++++++++
>>   4 files changed, 191 insertions(+)
>>   create mode 100644 doc/device-tree-bindings/misc/socfpga_dtreg.txt
>>   create mode 100644 drivers/misc/socfpga_dtreg.c
>>
>> diff --git a/doc/device-tree-bindings/misc/socfpga_dtreg.txt b/doc/device-
>> tree-bindings/misc/socfpga_dtreg.txt
>> new file mode 100644
>> index 0000000000..5458103f88
>> --- /dev/null
>> +++ b/doc/device-tree-bindings/misc/socfpga_dtreg.txt
>> @@ -0,0 +1,66 @@
>> +* Firewall and privilege register settings in device tree
>> +
>> +Required properties:
>> +--------------------
>> +
>> +- compatible: should contain "intel,socfpga-dtreg"
>> +- reg: Physical base address and size of block register.
>> +- intel,offset-settings: 32-bit offset address of block register,
>> +			 followed by 32-bit value settings and
>> +			 the masking bits, only masking bit
>> +			 set to 1 allows modification.
>> +
>> +This driver can be used to provide user a clean interface and all
>> +register settings are centralized in one place, device tree without
>> +need for hardcoding in the source code.
>> +
>> +General setup would be to set the memory address used by the register,
>> +followed by the offset-settings containing the 32-bit offset address of
>> +the block register, then the 32-bit value settings and lastly the
>> +masking bits.
>> +
>> +Example:
>> +--------
>> +
>> +Configuration for multiple dtreg node support in device tree:
>> +
>> +	socfpga_mainfirewall: socfpga-mainfirewall {
>> +		compatible = "intel,socfpga-dtreg";
>> +                	#address-cells = <1>;
>> +                        #size-cells = <1>;
>> +		        bootph-all;
>> +
>> +                        coh_cpu0_bypass_OC_Firewall_main_Firewall@f7100200 {
>> +                        	reg = <0xf7100200 0x00000014>;
>> +                                intel,offset-settings =
>> +                                	/* Disable ocram security at CCU for non secure
>> access */
>> +                                        <0x0000004 0x8000ffff 0xe007ffff>,
>> +                                        <0x0000008 0x8000ffff 0xe007ffff>,
>> +                                        <0x000000c 0x8000ffff 0xe007ffff>,
>> +                                        <0x0000010 0x8000ffff 0xe007ffff>;
>> +                                bootph-all;
>> +                        };
>> +                };
>> +
>> +	socfpga_mpfefirewall: socfpga-mpfefirewall {
>> +        	compatible = "intel,socfpga-dtreg";
>> +                	#address-cells = <1>;
>> +                        #size-cells = <1>;
>> +			bootph-all;
>> +
>> +                        soc_noc_fw_mpfe_csr_inst_0_mpfe_scr@f8020000 {
>> +                                reg = <0xf8020000 0x0000001c>;
>> +                                intel,offset-settings =
>> +                                        /* Disable MPFE firewall for SMMU */
>> +                                        <0x00000000 0x00010101 0x00010101>,
>> +                                        /* Disable MPFE firewall for HMC adapter */
>> +                                        <0x00000004 0x00000001 0x00010101>;
>> +				bootph-all;
>> +                        };
>> +                };
>> +
>> +To call the nodes use:
>> +
>> +	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-
>> mainfirewall", &dev);
>> +	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-
>> mpfefirewall",
>> +&dev);
>> +
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig index
>> fccd9b89b8..c423905ba2 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -683,4 +683,11 @@ config SL28CPLD
>>   	  the base driver which provides common access methods for the
>>   	  sub-drivers.
>>
>> +config SPL_SOCFPGA_DT_REG
>> +	bool "Enable register setting from device tree in SPL"
>> +	depends on SPL
>> +	help
>> +	  Enable register setting from device tree. This also
>> +	  provides user a clean interface and all register settings are
>> +	  centralized in one place, device tree.
>>   endmenu
>> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile index
>> b67b82358a..8f813edd84 100644
>> --- a/drivers/misc/Makefile
>> +++ b/drivers/misc/Makefile
>> @@ -89,3 +89,4 @@ obj-$(CONFIG_K3_AVS0) += k3_avs.o
>>   obj-$(CONFIG_ESM_K3) += k3_esm.o
>>   obj-$(CONFIG_ESM_PMIC) += esm_pmic.o
>>   obj-$(CONFIG_SL28CPLD) += sl28cpld.o
>> +obj-$(CONFIG_SPL_SOCFPGA_DT_REG) += socfpga_dtreg.o
>> diff --git a/drivers/misc/socfpga_dtreg.c b/drivers/misc/socfpga_dtreg.c new
>> file mode 100644 index 0000000000..982f9592cb
>> --- /dev/null
>> +++ b/drivers/misc/socfpga_dtreg.c
>> @@ -0,0 +1,117 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2023 Intel Corporation <www.intel.com>  */
>> +
>> +#include <asm/io.h>
>> +#include <common.h>
>> +#include <dm.h>
>> +#include <errno.h>
> 
> Please move <asm/io.h> above to here
> 
>> +#include <linux/sizes.h>

A good starting point would be to have socfpga 64bit maintainer , 
without that , these patches are only being archived .

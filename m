Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3929D49209
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 10:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FF9589464;
	Mon, 18 Nov 2024 11:59:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731927547;
	bh=PDqVYwMWj6uakUvpSTq4GU4f05XHk9NU84yIXHNp6tc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=nw4oj6c+3ANmfGfoEwv7Y5sQ/TSEB7sVZOq4I8Rf7UsooZxyeOaDij7vJBNzwLF0V
	 5T6csZWPllAh0sjRl0uwmGkm/CL7WaU+d1Bi5RPKTgKXJ0V1Za/FHwEzpIAOHJbSHD
	 DSkHZ/kuKFHQuvBaDU1Wy9CsxUXCHo+Dm+jhdvxqTDoDc7cQ53eXMMrJQUGSVGY1SY
	 p/q7BHq3H5cqCbGSCgV3zeUdqft/OhVqU1yuxxVDjyLY2GYQRvTQfEYrzo7D0/t9Rg
	 tGW8ikuBra983ogkFmDFfXJt642Z2dq07gJh/tOKTj1gIVa11dk6OjX6qUcaI9sNNo
	 uTaiZCZDAKInQ==
Received: from [192.168.1.107] (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2AACD88DEA;
 Mon, 18 Nov 2024 11:59:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731927546;
 bh=PDqVYwMWj6uakUvpSTq4GU4f05XHk9NU84yIXHNp6tc=;
 h=Date:Subject:To:Cc:References:From:Reply-To:In-Reply-To:From;
 b=vffQFlAnm3R0lgad71HE5li9hhJUVABNNwOvbl3OMFXU3bRfwPTvSyonoNanCQJOb
 sbxncJvscdx1Z73BkYtFvEK9tm2eIhKwKK4ymBZzUb2WsPyc54/rQz0xrX9jywBRNu
 lF8CYZhblXjAg2n81nBDcux2DCue3hPjD6mH7rpv2EGKsF1eJO3vKLEUz4UyrOS0wk
 Hvlc5rKwnaxnsB0TZV91y6N3K2ox/UcTRkweqF/399Ws0FrdWC4FL6gHh3KSBuK/ir
 hliSknh5L6k4gFMyzn2TJ3bHWDidN47ufEAA2y4CNMpYklvhtWv/pGWWNbmq/tLZKh
 xdGD4J47P1hBA==
Message-ID: <cb05307b-14c5-15b3-3fbf-f839b7e16982@denx.de>
Date: Mon, 18 Nov 2024 11:56:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 01/20] wdt: imx8qxp: add option to control external
 PMIC wdt via IMX8 SCU
Content-Language: en-US
To: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Andrej Valek <andrej.valek@siemens.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 CL Wang <cl634@andestech.com>, Chanho Park <chanho61.park@samsung.com>,
 Fabio Estevam <festevam@denx.de>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Randolph <randolph@andestech.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
References: <20241118062715.32989-1-hs@denx.de>
 <20241118062715.32989-2-hs@denx.de>
 <CAL6CDMF=z+wH1xhfwVj=yUBdPe+zQ=odi_FtQsXbR832JaXW8g@mail.gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <CAL6CDMF=z+wH1xhfwVj=yUBdPe+zQ=odi_FtQsXbR832JaXW8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hello Igor,

On 18.11.24 11:39, Igor Opaniuk wrote:
> Hello Heiko,
> 
> some nitpicks below:

Thanks!

> On Mon, Nov 18, 2024 at 7:27 AM Heiko Schocher <hs@denx.de> wrote:
>>
>> Driver for a PMIC watchdog timer controlled via Siemens SCU firmware
>> extensions. Only useful on some Siemens i.MX8-based platforms as
>> special SCFW is needed which provides the needed SCU API.
>>
>> Signed-off-by: Andrej Valek <andrej.valek@siemens.com>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> ---
>>
>> Changes in v2:
>> - work on comments from Stefan:
>>    - rename driver file from scu_wdt.c to scu_pmic_wdt.c
>>    - rename Kconfig symbol from CONFIG_WDT_IMX_SCU to CONFIG_WDT_SCU_PMIC
>>    - reworked Kconfig help text
>>    - add comment that TIMER_FUNC_CTRL_PMIC_WDOG is a siemens specific
>>      SCU API extension in their SCFW.
>>    - reworked commit message
>>
>>   drivers/misc/imx8/scu_api.c     | 21 ++++++++++++
>>   drivers/watchdog/Kconfig        |  7 ++++
>>   drivers/watchdog/Makefile       |  1 +
>>   drivers/watchdog/scu_pmic_wdt.c | 59 +++++++++++++++++++++++++++++++++
>>   include/firmware/imx/sci/rpc.h  |  3 ++
>>   include/firmware/imx/sci/sci.h  |  1 +
>>   6 files changed, 92 insertions(+)
>>   create mode 100644 drivers/watchdog/scu_pmic_wdt.c
>>
>> diff --git a/drivers/misc/imx8/scu_api.c b/drivers/misc/imx8/scu_api.c
>> index 591d71b096a..edb6923151a 100644
>> --- a/drivers/misc/imx8/scu_api.c
>> +++ b/drivers/misc/imx8/scu_api.c
>> @@ -951,6 +951,27 @@ int sc_timer_set_wdog_window(sc_ipc_t ipc, sc_timer_wdog_time_t window)
>>          return ret;
>>   }
>>
>> +int sc_timer_control_pmic_wdog(sc_ipc_t ipc, u8 cmd)
>> +{
>> +       struct udevice *dev = gd->arch.scu_dev;
>> +       struct sc_rpc_msg_s msg;
>> +       int size = sizeof(struct sc_rpc_msg_s);
>> +       int ret;
>> +
>> +       RPC_VER(&msg) = SC_RPC_VERSION;
>> +       RPC_SVC(&msg) = (u8)SC_RPC_SVC_TIMER;
>> +       RPC_FUNC(&msg) = (u8)TIMER_FUNC_CTRL_PMIC_WDOG;
>> +       RPC_U8(&msg, 0U) = (u8)cmd;
>> +       RPC_SIZE(&msg) = 2U;
>> +
>> +       ret = misc_call(dev, SC_FALSE, &msg, size, &msg, size);
>> +       if (ret)
>> +               printf("%s: res:%d\n",
>> +                      __func__, RPC_R8(&msg));
>> +
>> +       return ret;
>> +}
>> +
>>   int sc_seco_authenticate(sc_ipc_t ipc, sc_seco_auth_cmd_t cmd,
>>                           sc_faddr_t addr)
>>   {
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index 0e45f0a0922..f317d0922cb 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -428,6 +428,13 @@ config WDT_ARM_SMC
>>            Select this to enable Arm SMC watchdog timer. This watchdog will manage
>>            a watchdog based on ARM SMCCC communication.
>>
>> +config WDT_SCU_PMIC
>> +       bool "Enable PMIC Watchdog Timer support for siemens platforms"
> 
> s/siemens/Siemens/g

Fixed.

>> +       depends on IMX8 && WDT
> depends on ARCH_IMX8 && WDT ?
> IMX8 Kconfig symbol implies additional dependency on CAAM module,
> which is not the case with this driver.

Ah, good point! Thanks!

> 
>> +       help
>> +         Select this to enable the PMIC watchdog driver controlled via
>> +         IMX8 SCU API found on Siemens platforms.
>> +
>>   config SPL_WDT
>>          bool "Enable driver model for watchdog timer drivers in SPL"
>>          depends on SPL_DM
>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>> index 0b107c008f7..fed924f7e01 100644
>> --- a/drivers/watchdog/Makefile
>> +++ b/drivers/watchdog/Makefile
>> @@ -45,6 +45,7 @@ obj-$(CONFIG_WDT_OCTEONTX) += octeontx_wdt.o
>>   obj-$(CONFIG_WDT_OMAP3) += omap_wdt.o
>>   obj-$(CONFIG_WDT_SBSA) += sbsa_gwdt.o
>>   obj-$(CONFIG_WDT_K3_RTI) += rti_wdt.o
>> +obj-$(CONFIG_WDT_SCU_PMIC) += scu_pmic_wdt.o
>>   obj-$(CONFIG_WDT_SL28CPLD) += sl28cpld-wdt.o
>>   obj-$(CONFIG_WDT_SP805) += sp805_wdt.o
>>   obj-$(CONFIG_WDT_STARFIVE) += starfive_wdt.o
>> diff --git a/drivers/watchdog/scu_pmic_wdt.c b/drivers/watchdog/scu_pmic_wdt.c
>> new file mode 100644
>> index 00000000000..e7ca00de654
>> --- /dev/null
>> +++ b/drivers/watchdog/scu_pmic_wdt.c
>> @@ -0,0 +1,59 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Driver for a PMIC watchdog timer controlled via Siemens SCU firmware
>> + * extensions. Only useful on some Siemens i.MX8-based platforms as
>> + * special NXP SCFW is needed which provides the needed SCU API.
>> + *
>> + * Copyright (C) 2024 Siemens AG
>> + */
>> +
>> +#include <dm.h>
>> +#include <wdt.h>
>> +#include <firmware/imx/sci/sci.h>
>> +
>> +/* watchdog commands */
>> +#define CMD_START_WDT 0x55
>> +#define CMD_STOP_WDT  0x45
>> +#define CMD_PING_WDT  0x35
>> +
>> +static int scu_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
>> +{
>> +       /* start external watchdog via Timer API */
>> +       return sc_timer_control_pmic_wdog(-1, CMD_START_WDT);
>> +}
>> +
>> +static int scu_wdt_stop(struct udevice *dev)
>> +{
>> +       /* stop external watchdog via Timer API */
>> +       return sc_timer_control_pmic_wdog(-1, CMD_STOP_WDT);
>> +}
>> +
>> +static int scu_wdt_reset(struct udevice *dev)
>> +{
>> +       return sc_timer_control_pmic_wdog(-1, CMD_PING_WDT);
>> +}
>> +
>> +static int scu_wdt_probe(struct udevice *dev)
>> +{
>> +       debug("%s(dev=%p)\n", __func__, dev);
>> +       return 0;
>> +}
>> +
>> +static const struct wdt_ops scu_wdt_ops = {
>> +       .reset          = scu_wdt_reset,
>> +       .start          = scu_wdt_start,
>> +       .stop           = scu_wdt_stop,
>> +};
>> +
>> +static const struct udevice_id scu_wdt_ids[] = {
>> +       { .compatible = "siemens,scu-wdt" },
>> +       { }
>> +};
>> +
>> +U_BOOT_DRIVER(scu_wdt) = {
>> +       .name           = "scu_wdt",
>> +       .id             = UCLASS_WDT,
>> +       .of_match       = scu_wdt_ids,
>> +       .probe          = scu_wdt_probe,
>> +       .ops            = &scu_wdt_ops,
>> +};
>> diff --git a/include/firmware/imx/sci/rpc.h b/include/firmware/imx/sci/rpc.h
>> index 28adec2a8e1..6f16cf4a8b6 100644
>> --- a/include/firmware/imx/sci/rpc.h
>> +++ b/include/firmware/imx/sci/rpc.h
>> @@ -231,4 +231,7 @@ struct sc_rpc_msg_s {
>>   #define TIMER_FUNC_SET_SYSCTR_PERIODIC_ALARM 17U /* Index for sc_timer_set_sysctr_periodic_alarm() RPC call */
>>   #define TIMER_FUNC_CANCEL_SYSCTR_ALARM 18U /* Index for sc_timer_cancel_sysctr_alarm() RPC call */
>>
>> +/* siemens specific API extension from Siemens */
> please drop one "siemens"

Fixed!

Thanks for your comments!

bye,
Heiko

>> +#define TIMER_FUNC_CTRL_PMIC_WDOG 20U  /*!< Index for sc_timer_ctrl_pmic_wdog() RPC call */
>> +
>>   #endif /* SC_RPC_H */
>> diff --git a/include/firmware/imx/sci/sci.h b/include/firmware/imx/sci/sci.h
>> index 7d8499f070a..b971b62836d 100644
>> --- a/include/firmware/imx/sci/sci.h
>> +++ b/include/firmware/imx/sci/sci.h
>> @@ -123,6 +123,7 @@ int sc_rm_set_master_sid(sc_ipc_t ipc, sc_rsrc_t resource, sc_rm_sid_t sid);
>>
>>   /* Timer API */
>>   int sc_timer_set_wdog_window(sc_ipc_t ipc, sc_timer_wdog_time_t window);
>> +int sc_timer_control_pmic_wdog(sc_ipc_t ipc, u8 cmd);
>>
>>   /* SECO API */
>>   int sc_seco_authenticate(sc_ipc_t ipc, sc_seco_auth_cmd_t cmd,
>> --
>> 2.20.1
>>
> 
> 

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

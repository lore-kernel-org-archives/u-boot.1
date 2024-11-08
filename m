Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62840D5E140
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 07:19:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4A7388DFA;
	Fri,  8 Nov 2024 08:19:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731050356;
	bh=wt0TmMAMgsR0EUJaNzrEkiy8zO7mM1t+pZ9IkpOiU90=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MMDJb47u9+Gpg/h3PU5Zh5JaeBNVy6aJlNN2fReW50GSGFLNetoVAA5VeY2U/6Mxb
	 9pf0Q11KLd3kVN9kiwNUlMRLoWFxwog8IP/SiTYSXfijKxLk6Sv+Ol34ra1UyOGT7f
	 UkcieCccXLX5m6FUxh52XoCa+d2dMfdSZt+JOPLHE9mkhnJxJF0KziolBS3h0ZLNjC
	 S55HgKVAMfWY1nwBG6fLhHvfaIFce64aeFiRx7fC4NEbricvOi0Mexh/nwJuavzPk2
	 RKBOFcJ/IYKNBRnQ/thFWaaTZQhtpvSBPSzJL2Des88sTF5nvBbnS5sRf6OXZiFzSW
	 8fPs1BUFgXzxg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D386288DFA; Fri,  8 Nov 2024 08:19:14 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE8B188DF1
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 08:19:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4Xl9Kr1h4lz9tQH;
 Fri,  8 Nov 2024 08:19:12 +0100 (CET)
Message-ID: <ee022055-6bec-4326-b9bf-3823211d94b6@denx.de>
Date: Fri, 8 Nov 2024 08:19:06 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v1 01/22] wdt: imx8qxp: add option to control external
 PMIC wdt via IMX8 SCU
To: Heiko Schocher <hs@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Enrico Leto <enrico.leto@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Andrej Valek <andrej.valek@siemens.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Chanho Park <chanho61.park@samsung.com>, Devarsh Thakkar <devarsht@ti.com>,
 Igor Opaniuk <igor.opaniuk@foundries.io>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Randolph <randolph@andestech.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20241108052143.26874-1-hs@denx.de>
 <20241108052143.26874-2-hs@denx.de>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241108052143.26874-2-hs@denx.de>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Heiko,

On 11/8/24 06:21, Heiko Schocher wrote:
> control the watchdog in the PMIC through SCU.

A few more details would be good here (please see below).

> Signed-off-by: Andrej Valek <andrej.valek@siemens.com>
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> 
>   drivers/misc/imx8/scu_api.c    | 21 ++++++++++++++
>   drivers/watchdog/Kconfig       |  7 +++++
>   drivers/watchdog/Makefile      |  1 +
>   drivers/watchdog/scu_wdt.c     | 52 ++++++++++++++++++++++++++++++++++
>   include/firmware/imx/sci/rpc.h |  1 +
>   include/firmware/imx/sci/sci.h |  1 +
>   6 files changed, 83 insertions(+)
>   create mode 100644 drivers/watchdog/scu_wdt.c
> 
> diff --git a/drivers/misc/imx8/scu_api.c b/drivers/misc/imx8/scu_api.c
> index 591d71b096a..edb6923151a 100644
> --- a/drivers/misc/imx8/scu_api.c
> +++ b/drivers/misc/imx8/scu_api.c
> @@ -951,6 +951,27 @@ int sc_timer_set_wdog_window(sc_ipc_t ipc, sc_timer_wdog_time_t window)
>   	return ret;
>   }
>   
> +int sc_timer_control_pmic_wdog(sc_ipc_t ipc, u8 cmd)
> +{
> +	struct udevice *dev = gd->arch.scu_dev;
> +	struct sc_rpc_msg_s msg;
> +	int size = sizeof(struct sc_rpc_msg_s);
> +	int ret;
> +
> +	RPC_VER(&msg) = SC_RPC_VERSION;
> +	RPC_SVC(&msg) = (u8)SC_RPC_SVC_TIMER;
> +	RPC_FUNC(&msg) = (u8)TIMER_FUNC_CTRL_PMIC_WDOG;
> +	RPC_U8(&msg, 0U) = (u8)cmd;
> +	RPC_SIZE(&msg) = 2U;
> +
> +	ret = misc_call(dev, SC_FALSE, &msg, size, &msg, size);
> +	if (ret)
> +		printf("%s: res:%d\n",
> +		       __func__, RPC_R8(&msg));

Nitpicking: Does the printf statement above fit into one line?

> +
> +	return ret;
> +}
> +
>   int sc_seco_authenticate(sc_ipc_t ipc, sc_seco_auth_cmd_t cmd,
>   			 sc_faddr_t addr)
>   {
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 0e45f0a0922..eb9e75abe48 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -428,6 +428,13 @@ config WDT_ARM_SMC
>   	  Select this to enable Arm SMC watchdog timer. This watchdog will manage
>   	  a watchdog based on ARM SMCCC communication.
>   
> +config WDT_IMX_SCU
> +	bool "Enable external Watchdog Timer support for IMX"
> +	depends on IMX8 && WDT
> +	help
> +	  Select this to enable the external IMX watchdog driver
> +	  controlled via IMX8 SCU.

I don't know the details here, but what exactly is "external" here?
If it's still inside the i.MX then external sounds a bit misleading.

> +
>   config SPL_WDT
>   	bool "Enable driver model for watchdog timer drivers in SPL"
>   	depends on SPL_DM
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 0b107c008f7..e943b904bae 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_WDT_DA9063) += da9063-wdt.o
>   obj-$(CONFIG_WDT_DAVINCI) += davinci_wdt.o
>   obj-$(CONFIG_WDT_FTWDT010) += ftwdt010_wdt.o
>   obj-$(CONFIG_$(SPL_TPL_)WDT_GPIO) += gpio_wdt.o
> +obj-$(CONFIG_WDT_IMX_SCU) += scu_wdt.o

Perhaps better to add some "imx" to the source file name?

>   obj-$(CONFIG_WDT_MAX6370) += max6370_wdt.o
>   obj-$(CONFIG_WDT_MCF) += mcf_wdt.o
>   obj-$(CONFIG_WDT_MESON_GXBB) += meson_gxbb_wdt.o
> diff --git a/drivers/watchdog/scu_wdt.c b/drivers/watchdog/scu_wdt.c
> new file mode 100644
> index 00000000000..ad8766dc132
> --- /dev/null
> +++ b/drivers/watchdog/scu_wdt.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <dm.h>
> +#include <wdt.h>
> +#include <firmware/imx/sci/sci.h>
> +
> +/* watchdog commands */
> +#define CMD_START_WDT 0x55
> +#define CMD_STOP_WDT  0x45
> +#define CMD_PING_WDT  0x35
> +
> +static int scu_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
> +{
> +	/* start external watchdog via Timer API */
> +	return sc_timer_control_pmic_wdog(-1, CMD_START_WDT);
> +}
> +
> +static int scu_wdt_stop(struct udevice *dev)
> +{
> +	/* stop external watchdog via Timer API */
> +	return sc_timer_control_pmic_wdog(-1, CMD_STOP_WDT);
> +}
> +
> +static int scu_wdt_reset(struct udevice *dev)
> +{
> +	return sc_timer_control_pmic_wdog(-1, CMD_PING_WDT);
> +}
> +
> +static int scu_wdt_probe(struct udevice *dev)
> +{
> +	debug("%s(dev=%p)\n", __func__, dev);
> +	return 0;
> +}
> +
> +static const struct wdt_ops scu_wdt_ops = {
> +	.reset		= scu_wdt_reset,
> +	.start		= scu_wdt_start,
> +	.stop		= scu_wdt_stop,
> +};
> +
> +static const struct udevice_id scu_wdt_ids[] = {
> +	{ .compatible = "siemens,scu-wdt" },

Really siemens specific? Is this also available in Linux btw?
Looking into the Linux source, is this driver somehow related to
this one:

drivers/watchdog/imx_sc_wdt.c ?

Thanks,
Stefan

> +	{ }
> +};
> +
> +U_BOOT_DRIVER(scu_wdt) = {
> +	.name		= "scu_wdt",
> +	.id		= UCLASS_WDT,
> +	.of_match	= scu_wdt_ids,
> +	.probe		= scu_wdt_probe,
> +	.ops		= &scu_wdt_ops,
> +};
> diff --git a/include/firmware/imx/sci/rpc.h b/include/firmware/imx/sci/rpc.h
> index 28adec2a8e1..9470f9e7178 100644
> --- a/include/firmware/imx/sci/rpc.h
> +++ b/include/firmware/imx/sci/rpc.h
> @@ -230,5 +230,6 @@ struct sc_rpc_msg_s {
>   #define TIMER_FUNC_SET_SYSCTR_ALARM 16U /* Index for sc_timer_set_sysctr_alarm() RPC call */
>   #define TIMER_FUNC_SET_SYSCTR_PERIODIC_ALARM 17U /* Index for sc_timer_set_sysctr_periodic_alarm() RPC call */
>   #define TIMER_FUNC_CANCEL_SYSCTR_ALARM 18U /* Index for sc_timer_cancel_sysctr_alarm() RPC call */
> +#define TIMER_FUNC_CTRL_PMIC_WDOG 20U  /*!< Index for sc_timer_ctrl_pmic_wdog() RPC call */
>   
>   #endif /* SC_RPC_H */
> diff --git a/include/firmware/imx/sci/sci.h b/include/firmware/imx/sci/sci.h
> index 7d8499f070a..b971b62836d 100644
> --- a/include/firmware/imx/sci/sci.h
> +++ b/include/firmware/imx/sci/sci.h
> @@ -123,6 +123,7 @@ int sc_rm_set_master_sid(sc_ipc_t ipc, sc_rsrc_t resource, sc_rm_sid_t sid);
>   
>   /* Timer API */
>   int sc_timer_set_wdog_window(sc_ipc_t ipc, sc_timer_wdog_time_t window);
> +int sc_timer_control_pmic_wdog(sc_ipc_t ipc, u8 cmd);
>   
>   /* SECO API */
>   int sc_seco_authenticate(sc_ipc_t ipc, sc_seco_auth_cmd_t cmd,

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

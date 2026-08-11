Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16281C5AC67
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 11:55:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6941C80C9B;
	Tue, 11 Aug 2026 11:55:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RpQJO13RTOHK; Tue, 11 Aug 2026 11:55:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5989F80C1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786449351;
	bh=CuvMKvIwfTdjq1uglxv5k8qvzxRw0qix685pdvgQ9W4=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ClibmIZhkTCegf6s5g4JqQdYeDkVz2sikzoDJaGMbMfQHPeiBPDyq0XTVoTzSUnZd
	 FNJHuXPyr/R+PCtkjEh4doCQRLdPqNzyLG7nXGrhQDtK5rULZV38lw6qQFl5RBvuEy
	 78Qp5zSMLbnuLdKSSrzoZyPIVJq/7R14HWCcIJywOfFXyN/ofx9fqvM013AuOMOTBe
	 nZCaNLpCJ3TsoD2ZRziqh5CkA9h/ZVbvQC2lI8ha7VctHA07zCjMjp/swc6Hq5iqL4
	 DmknfAI7gUVsa/zw4nxXQP00RSxysE7a71D4g377DsS4e4fH9GA4KoLTERhHdwRykR
	 luUVhbm9aMdcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5989F80C1C;
	Tue, 11 Aug 2026 11:55:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A932259
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 11:55:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 10E5880C1C
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 11:55:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SzCExkLct4jW for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 11:55:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.14;
 helo=smtp-bc0e.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 894A980C16
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 894A980C16
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch
 [45.157.188.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 894A980C16
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 11:55:47 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hK9723z5pzfGG;
 Tue, 11 Aug 2026 13:55:42 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hK97108CwzLr4; Tue, 11 Aug 2026 13:55:40 +0200 (CEST)
Message-ID: <d4d49e17-e125-4121-b0be-e486e1be5393@0leil.net>
Date: Tue, 11 Aug 2026 13:55:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] rockchip: rk3399: Add ROC-PC-PLUS board detection
To: Fabio Estevam <festevam@gmail.com>
Cc: trini@konsulko.com, sjg@chromium.org, kever.yang@rock-chips.com,
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>
References: <20260722194638.1285159-1-festevam@gmail.com>
 <20260722194638.1285159-3-festevam@gmail.com>
Content-Language: en-US
In-Reply-To: <20260722194638.1285159-3-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1786449342;
 bh=CuvMKvIwfTdjq1uglxv5k8qvzxRw0qix685pdvgQ9W4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=aA6CMK/TMIUmxjnA0R3bDb9kxfkUOZ6NKbZF1zIZ7YQArgCKCwtQ9XlH15JeIJdWf
 +6Rfgz97a8B6ivmPZg8yopxvXHQYAykDXm05IUOwcYfEHjPCZYhKzEHbwzYlg7Dt7D
 amzhWzqqUhTvW+bN2RKsXHOOhB17lLO0pIhLpfv9MQ6dZ5Tn+/YwLt8eIZZRZphMB7
 n2feBvfZqhhM2KHRb1YQlrD32eJtEVCmf2VCiWbdUwCwFlBl5P3cet/KQohMYWZnNu
 lfUT3XNRNQPVtXO60xkF5rtBnia2Fk7+3gwENTpljwv6vdHaWEKGC3lAuTCw3AcIPI
 UIb/QvrAKpMdg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=aA6CMK/T
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Fabio,

On 7/22/26 9:46 PM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@nabladev.com>
> 
> The ROC-RK3399-PC has an MP8859 regulator on I2C7 at address 0x66,
> while the ROC-RK3399-PC-PLUS does not. Probe for the regulator in SPL
> and use the result to select the matching devicetree from the U-Boot
> FIT. Fall back to the original board if the I2C bus cannot be probed.
> 
> Build both devicetrees from the existing roc-pc-rk3399_defconfig and
> enable the XMC SPI NOR driver used by the Plus variant. Set fdtfile
> from the selected U-Boot devicetree so the matching Linux devicetree
> is used as well.
> 
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> ---
> Changes since v3:
> - Explicitly sets fdtfile for both PC and PC-PLUS.
> 
>   arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi |  3 ++
>   arch/arm/dts/rk3399-roc-pc-u-boot.dtsi      |  8 +++++
>   board/firefly/roc-pc-rk3399/roc-pc-rk3399.c | 39 +++++++++++++++++++++
>   configs/roc-pc-rk3399_defconfig             |  3 ++
>   doc/board/rockchip/rockchip.rst             |  2 +-
>   5 files changed, 54 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
> 
> diff --git a/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
> new file mode 100644
> index 000000000000..c80529a62b97
> --- /dev/null
> +++ b/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include "rk3399-roc-pc-u-boot.dtsi"
> diff --git a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> index a85e9549c83e..e7e4a2c89072 100644
> --- a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> @@ -12,6 +12,14 @@
>   	};
>   };
>   
> +&i2c7 {
> +	bootph-pre-ram;
> +};
> +
> +&i2c7_xfer {
> +	bootph-pre-ram;
> +};
> +
>   &gpio4 {
>   	bootph-pre-ram;
>   };
> diff --git a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
> index 6937a27176f9..a12180e65573 100644
> --- a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
> +++ b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
> @@ -5,14 +5,24 @@
>   
>   #include <dm.h>
>   #include <env.h>
> +#include <fdtdec.h>
> +#include <i2c.h>
> +#include <image.h>
>   #include <log.h>
>   #include <spl_gpio.h>
> +#include <asm/global_data.h>
>   #include <asm/io.h>
>   
>   #include <asm/arch-rockchip/cru.h>
>   #include <asm/arch-rockchip/gpio.h>
>   #include <asm/arch-rockchip/grf_rk3399.h>
>   
> +#define ROC_PC_MP8859_BUS	"i2c@ff160000"
> +#define ROC_PC_MP8859_ADDR	0x66
> +#define ROC_PC_PLUS_FDTFILE	"rockchip/rk3399-roc-pc-plus.dtb"
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
>   #ifdef CONFIG_XPL_BUILD
>   
>   #define PMUGRF_BASE	0xff320000
> @@ -54,4 +64,33 @@ void led_setup(void)
>   	spl_gpio_output(gpio0, GPIO(BANK_B, 5), 1);
>   }
>   
> +static bool is_roc_pc_plus(void)
> +{
> +	struct udevice *bus, *dev;
> +
> +	if (uclass_get_device_by_name(UCLASS_I2C, ROC_PC_MP8859_BUS, &bus))
> +		return false;
> +
> +	return dm_i2c_probe(bus, ROC_PC_MP8859_ADDR, 0, &dev);

This fails to build due to undefined reference to dm_i2c_probe in SPL:

+Some images are invalid
    aarch64:  +   roc-pc-mezzanine-rk3399
+aarch64-linux-ld: board/firefly/roc-pc-rk3399/roc-pc-rk3399.o: in 
function `is_roc_pc_plus':
+board/firefly/roc-pc-rk3399/roc-pc-rk3399.c:74:(.text.board_fit_config_name_match+0x38): 
undefined reference to `dm_i2c_probe'
+make[2]: *** [scripts/Makefile.xpl:546: spl/u-boot-spl] Error 1
+make[1]: *** [Makefile:2448: spl/u-boot-spl] Error 2
+make: *** [Makefile:189: __sub-make] Error 2

c.f. 
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/jobs/67143#L592

Note this applies to the roc-pc-mezzanine-rk3399 defconfig which is only 
slightly different from roc-pc-rk3399.

Ideally, we should be able to automatically detect whether it's a 
roc-pc-mezzanine-rk3399, but I couldn't find schematics for it and from 
the Device Tree, there doesn't seem to be something we could use to 
detect it like we do for ROC-PC-PLUS/ROC-PC. So instead I recommend to 
check for CONFIG_IS_ENABLED(DM_I2C). If it ever gets enabled for 
roc-pc-mezzanine-rk3399_defconfig, the logic will return that it's NOT a 
ROC-PC-PLUS and thus use CONFIG_DEFAULT_FDT_FILE which is 
rockchip/rk3399-roc-pc-mezzanine.dtb which is correct.

What do you think? Can you send a v5 for this? Please pick Takahiro's 
R-b and the Link that was suggested to be added to the commit log of 
patch 1.

Thanks!
Quentin

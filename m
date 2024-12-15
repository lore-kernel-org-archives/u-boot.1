Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D7EE7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 01:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB5348006E;
	Sun, 15 Dec 2024 02:38:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B3818006F; Sun, 15 Dec 2024 02:38:37 +0100 (CET)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 081378006D
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 02:38:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtpip2t1734226680tcs85u6
X-QQ-Originating-IP: 1XeVhICMZBjuPbEr7J+Uws8QASVItWerDcHrvGW/0AI=
Received: from [IPV6:240f:10b:7440:1:95e0:ea9a ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sun, 15 Dec 2024 09:37:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14681587849142026819
Message-ID: <115020791DA19920+c09c7adb-9fe7-47f4-99cb-2c8c862fe1c5@radxa.com>
Date: Sun, 15 Dec 2024 10:37:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] rockchip: Add support for Radxa ROCK 5C
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 sumit.garg@linaro.org, jonas@kwiboo.se
References: <20241211033934.23044-1-naoki@radxa.com>
 <20241211033934.23044-6-naoki@radxa.com>
 <2600bdcb-3c57-4d52-97d1-c63758b25ed2@cherry.de>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <2600bdcb-3c57-4d52-97d1-c63758b25ed2@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OKkKo7I1HxIeB/XG+KGdetr6X6wNPDbjFAqtJA/gfTsQgUHq8QljHF1p
 8Z16Eu3Yn+NA9cxatihLyxgisqIJUkwc8LHm1V/Wp5W5551xcQtoMakx/DN4swfofkx1Dw/
 E5kapb+u5fPKHej4Z/nd1vT7OTuUK1E+GHdFVbIOemIQZjEU4NTKrCBvgve+rwpTAgn8rbq
 SgQPBNhaoI0BVrI1fRahUiUSYg5H+F0reBzZEH9ARRA7ghv+xzUkvskTJDbs9OCbNgvW5aB
 39zcKsRpEQAGsGlaZhnZKvLkCAaxvDigjwOHfse+V4uaJY+2RJFnoNfC2hd4ND3IQyNlF8o
 0UVKVV4D5fRurEaImsnppYvq8jDPpwB/E8HvcCFVy6hMyNrk/InJuMEiZexEevIUzOjFl7l
 55wBxvPgAc/1FEZjGuFSfj9Uzdpbb7TpjGdRBdZKHtg5Bak9BTdBnMiXK7gwJPzpkcpS4UU
 TpVNr8IjS2+KNsaKdKdrbg5ctOciCmHE4KrEfckMF33EwV7FCJFnxren3JHR88phrlIs+c2
 Uyay+awB0wEbaGdxLy2UO6ouRBgKcjXttNP3RXeJ+RKpGB+9d0KOHy0s2VBO+YCvdsIheXl
 MSRGVf+m76MONJmdr6wqtTBIMkTXdSgR22/TfzEdfcxL4U42JWPGpEJ3YiJB1xSwn9LeJvi
 JY2xuonlFyzV6jS5Udhdat/7Ga+qDkcfpaLLofk56FkIMjeZ2w8zveQFW2G2Du1qblE0b4W
 o91+8dSKCungmYEmivDhY9WGDNMXn//UqgWHNz+zx7Yrpw334e4/TVy1MX3E0LUrespKRLP
 z4EEqYxeQ5ZRHYwtEp5fadoITju1mgF3I1NimrGr+8xQWhGkMnwJ3cKSeiBGswhOVIn5Nlr
 bJsvF+bf64Owxd/874WNPvPeVSRXI2sXyRi+aEyii6L7SnM70ciOUhodLK2Kpa0Q
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0
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

Hi Quentin,

Thank you very much for your review!

On 12/13/24 22:11, Quentin Schulz wrote:
> Hi Naoki,
> 
> On 12/11/24 4:39 AM, FUKAUMI Naoki wrote:
>> Radxa ROCK 5C[1] is a Rockchip RK3588S2 based single board computer.
>>
>> [1] https://radxa.com/products/rock5/5c
>>
>> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
>> ---
>> Changes in v3:
>> - fix compile error
>> Changes in v2:
>> - arch/arm/dts/rk3588s-rock-5-u-boot.dtsi: remove unused node
>> - include/configs/rock-5-rk3588s.h: fix include order
>> ---
>>   arch/arm/dts/rk3588s-rock-5-u-boot.dtsi     | 16 ++++
>>   arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi    |  6 ++
>>   arch/arm/mach-rockchip/rk3588/Kconfig       |  7 ++
>>   board/radxa/rock-5-rk3588s/Kconfig          | 12 +++
>>   board/radxa/rock-5-rk3588s/MAINTAINERS      |  8 ++
>>   board/radxa/rock-5-rk3588s/Makefile         |  3 +
>>   board/radxa/rock-5-rk3588s/rock-5-rk3588s.c | 77 +++++++++++++++++
>>   configs/rock-5-rk3588s_defconfig            | 94 +++++++++++++++++++++
>>   doc/board/rockchip/rockchip.rst             |  1 +
>>   include/configs/rock-5-rk3588s.h            | 15 ++++
>>   10 files changed, 239 insertions(+)
>>   create mode 100644 arch/arm/dts/rk3588s-rock-5-u-boot.dtsi
>>   create mode 100644 arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
>>   create mode 100644 board/radxa/rock-5-rk3588s/Kconfig
>>   create mode 100644 board/radxa/rock-5-rk3588s/MAINTAINERS
>>   create mode 100644 board/radxa/rock-5-rk3588s/Makefile
>>   create mode 100644 board/radxa/rock-5-rk3588s/rock-5-rk3588s.c
>>   create mode 100644 configs/rock-5-rk3588s_defconfig
>>   create mode 100644 include/configs/rock-5-rk3588s.h
>>
>> diff --git a/arch/arm/dts/rk3588s-rock-5-u-boot.dtsi b/arch/arm/dts/ 
>> rk3588s-rock-5-u-boot.dtsi
>> new file mode 100644
>> index 000000000000..be1a2f9ae7bb
>> --- /dev/null
>> +++ b/arch/arm/dts/rk3588s-rock-5-u-boot.dtsi
>> @@ -0,0 +1,16 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2024 Radxa Computer (Shenzhen) Co., Ltd.
>> + */
>> +
>> +#include "rk3588s-u-boot.dtsi"
>> +
>> +&saradc {
>> +    bootph-pre-ram;
>> +    vdd-microvolts = <1800000>;
>> +};
>> +
>> +&sdhci {
>> +    cap-mmc-highspeed;
>> +    mmc-hs200-1_8v;
>> +};
>> diff --git a/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi b/arch/arm/dts/ 
>> rk3588s-rock-5c-u-boot.dtsi
>> new file mode 100644
>> index 000000000000..bb1cc9e4a279
>> --- /dev/null
>> +++ b/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
>> @@ -0,0 +1,6 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2024 Radxa Computer (Shenzhen) Co., Ltd.
>> + */
>> +
>> +#include "rk3588s-rock-5-u-boot.dtsi"
>> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach- 
>> rockchip/rk3588/Kconfig
>> index b5a0e624a532..e1487ecb0464 100644
>> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
>> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
>> @@ -260,6 +260,12 @@ config TARGET_ROCK_5_ITX_RK3588
>>         Front-panel connectors for audio and case-power, -leds
>>         Powered by either 12V, ATX power-supply or PoE
>> +config TARGET_ROCK_5_RK3588S
> 
> This should be TARGET_ROCK_5C_RK3588S?

rock-pi-4-rk3399_defconfig uses CONFIG_TARGET_ROCKPI4_RK3399.
I'm doing same thing.

>> +    bool "Radxa ROCK 5C RK3588S2 board"
>> +    select BOARD_LATE_INIT
>> +    help
>> +      Radxa ROCK 5C is a Rockchip RK3588S2 based single board computer.
>> +
>>   config TARGET_SIGE7_RK3588
>>       bool "ArmSoM Sige7 RK3588 board"
>>       select BOARD_LATE_INIT
>> @@ -398,6 +404,7 @@ source "board/turing/turing-rk1-rk3588/Kconfig"
>>   source "board/radxa/rock5a-rk3588s/Kconfig"
>>   source "board/radxa/rock5b-rk3588/Kconfig"
>>   source "board/radxa/rock-5-itx-rk3588/Kconfig"
>> +source "board/radxa/rock-5-rk3588s/Kconfig"
> 
> Where's the c gone?

There is board/radxa/rockpi4-rk3399/.

>>   source "board/rockchip/evb_rk3588/Kconfig"
>>   source "board/rockchip/toybrick_rk3588/Kconfig"
>>   source "board/theobroma-systems/jaguar_rk3588/Kconfig"
>> diff --git a/board/radxa/rock-5-rk3588s/Kconfig b/board/radxa/rock-5- 
>> rk3588s/Kconfig
>> new file mode 100644
>> index 000000000000..86830be1eeca
>> --- /dev/null
>> +++ b/board/radxa/rock-5-rk3588s/Kconfig
>> @@ -0,0 +1,12 @@
>> +if TARGET_ROCK_5_RK3588S
>> +
>> +config SYS_BOARD
>> +    default "rock-5-rk3588s"
>> +
>> +config SYS_VENDOR
>> +    default "radxa"
>> +
>> +config SYS_CONFIG_NAME
>> +    default "rock-5-rk3588s"
>> +
>> +endif
>> diff --git a/board/radxa/rock-5-rk3588s/MAINTAINERS b/board/radxa/ 
>> rock-5-rk3588s/MAINTAINERS
>> new file mode 100644
>> index 000000000000..ead6356131c1
>> --- /dev/null
>> +++ b/board/radxa/rock-5-rk3588s/MAINTAINERS
>> @@ -0,0 +1,8 @@
>> +ROCK-5-RK3588S
>> +M:    FUKAUMI Naoki <naoki@radxa.com>
>> +S:    Maintained
>> +F:    arch/arm/dts/rk3588s-rock-5-u-boot.dtsi
>> +F:    arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
>> +F:    board/radxa/rock-5-rk3588s/
>> +F:    configs/rock-5-rk3588s_defconfig
>> +F:    include/configs/rock-5-rk3588s.h
> 
> Why are all those files missing the c character?

Same reason as above.

>> diff --git a/board/radxa/rock-5-rk3588s/Makefile b/board/radxa/rock-5- 
>> rk3588s/Makefile
>> new file mode 100644
>> index 000000000000..d9be0f42e6b9
>> --- /dev/null
>> +++ b/board/radxa/rock-5-rk3588s/Makefile
>> @@ -0,0 +1,3 @@
>> +# SPDX-License-Identifier: GPL-2.0+
>> +
>> +obj-y += rock-5-rk3588s.o
>> diff --git a/board/radxa/rock-5-rk3588s/rock-5-rk3588s.c b/board/ 
>> radxa/rock-5-rk3588s/rock-5-rk3588s.c
>> new file mode 100644
>> index 000000000000..a840ca7698d4
>> --- /dev/null
>> +++ b/board/radxa/rock-5-rk3588s/rock-5-rk3588s.c
>> @@ -0,0 +1,77 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +
>> +#include <linux/errno.h>
>> +#include <linux/kernel.h>
>> +#include <adc.h>
>> +#include <env.h>
>> +
>> +#define BOARD_ID    5
>> +
>> +struct board_model {
>> +    unsigned int low;
>> +    unsigned int high;
>> +    const char *board;
>> +    const char *board_name;
>> +    const char *fdtfile;
>> +};
>> +
>> +static const struct board_model board_models[] = {
>> +    {
>> +        0,
>> +        50,
>> +        "rock-5a-rk3588s",
>> +        "Radxa ROCK 5A",
>> +        "rockchip/rk3588s-rock-5a.dtb",
> 
> We already have a config and board files for the rock-5a... There should 
> probably something to be done to merge them together or remove this part?

I'll drop this part from this patch.

>> +    },
>> +    {
>> +        2375,
>> +        2425,
>> +        "rock-5c-rk3588s",
>> +        "Radxa ROCK 5C",
>> +        "rockchip/rk3588s-rock-5c.dtb"
>> +    },
>> +};
>> +
>> +static const struct board_model *get_board_model(void)
>> +{
>> +    unsigned int val;
>> +    int i, ret;
>> +
>> +    ret = adc_channel_single_shot("adc@fec10000", BOARD_ID, &val);
>> +    debug("adc_channel_single_shot ret %d val %u\n", ret, val);
>> +    if (ret)
>> +        return NULL;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(board_models); i++) {
>> +        unsigned int min = board_models[i].low;
>> +        unsigned int max = board_models[i].high;
>> +
>> +        if (min <= val && val <= max)
>> +            return &board_models[i];
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +int rk_board_late_init(void)
>> +{
>> +    const struct board_model *model = get_board_model();
>> +
>> +    if (model) {
>> +        env_set("board", model->board);
>> +        env_set("board_name", model->board_name);
>> +        env_set("fdtfile", model->fdtfile);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +int board_fit_config_name_match(const char *name)
>> +{
>> +    const struct board_model *model = get_board_model();
>> +
>> +    if (model && !strcmp(name, model->fdtfile))
>> +        return 0;
>> +
>> +    return -ENOENT;
>> +}
>> diff --git a/configs/rock-5-rk3588s_defconfig b/configs/rock-5- 
>> rk3588s_defconfig
>> new file mode 100644
>> index 000000000000..54043264de48
>> --- /dev/null
>> +++ b/configs/rock-5-rk3588s_defconfig
>> @@ -0,0 +1,94 @@
>> +CONFIG_ARM=y
>> +CONFIG_SKIP_LOWLEVEL_INIT=y
>> +CONFIG_SYS_HAS_NONCACHED_MEMORY=y
>> +CONFIG_COUNTER_FREQUENCY=24000000
>> +CONFIG_ARCH_ROCKCHIP=y
>> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-rock-5a"
>> +CONFIG_ROCKCHIP_RK3588=y
>> +CONFIG_SPL_SERIAL=y
>> +CONFIG_TARGET_ROCK_5_RK3588S=y
>> +CONFIG_SYS_LOAD_ADDR=0xc00800
>> +CONFIG_DEBUG_UART_BASE=0xFEB50000
>> +CONFIG_DEBUG_UART_CLOCK=24000000
>> +CONFIG_PCI=y
>> +CONFIG_DEBUG_UART=y
>> +CONFIG_AHCI=y
>> +CONFIG_FIT=y
>> +CONFIG_FIT_VERBOSE=y
>> +CONFIG_SPL_FIT_SIGNATURE=y
>> +CONFIG_SPL_LOAD_FIT=y
>> +CONFIG_LEGACY_IMAGE_FORMAT=y
>> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-rock-5a.dtb"
> 
> And now we default to ROCK 5A DTB... This is all very confusing with 
> this little explained in the commit log.

Same as rock-pi-4-rk3399_defconfig, but I'll change them.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> Cheers,
> Quentin
> 


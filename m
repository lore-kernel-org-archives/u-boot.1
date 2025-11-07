Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE717CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 07:08:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3450F83BA1;
	Fri,  7 Nov 2025 08:08:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47ACD83C94; Fri,  7 Nov 2025 08:08:32 +0100 (CET)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B4B683C63
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 08:08:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: zesmtpip3t1762499273t74af372a
X-QQ-Originating-IP: do2d9VWwpmIRslY6IhcF/qg4W53nQahlXM36be6w25s=
Received: from [IPV6:240f:10b:7440:1:d7b:b10a: ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 07 Nov 2025 15:07:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2695408792576452869
Message-ID: <3D603F632CE14F3F+0b6c8abd-8022-4761-bd4e-683ea1544534@radxa.com>
Date: Fri, 7 Nov 2025 16:07:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rock5b-rk3588: Add support for Radxa ROCK 5T
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, eugen.hristev@linaro.org, jonas@kwiboo.se,
 heiko@sntech.de, cnsztl@gmail.com, xuhui.lin@rock-chips.com
References: <20251107064716.27196-1-naoki@radxa.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20251107064716.27196-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NEAuM+RWOyST+89yl7XDYP490IT2NVqQYonx+zNj5yq1uiI1A0MWuG6u
 JWx7isE3p2iXRzBMr/YrdhMf80n8xVqwjLNnJx4ZIT57SjHYQpsIh2+FMwkmpQs9nWXwYvn
 taBq+CBXDu9KVw3f4TRwZDHH44KQ0RC97iWccC16sQCIJdNWAry8O0hpcgf35ATR//BbDo+
 1wvDjXXZzt3BDAEcFPDpN+kumI0ztMVMYmRAASI73fW2uAouv0iwob5TdFfEJKSJoR6SBJd
 gBgEgR2iKIlrCk1MUAcGjZRCh5HWqabGrldCia4s3N6IywtYE0OCSPLCX2Stj/EFHU7ofHa
 YZ5iFBQQjS08CyPwA9CoeDajHkPHPQfgghGH7vjyyuMSx6GJc5Sc/OK++JaB3ihUBBs6yZu
 sJS1uGmnGFCU9Fupt2Um3vle0MzYHj1v3YCSIB8VtUEmRhxTBlzSSb3l2f4Mx7Qm2cXwVCh
 B+bm65A2aBMYK+5rCNFSz2Q4Byqag7StPnnDmovFSU416MH9CvpIQWDGXTRgO7aU+kumCZ3
 xXgmyoV1eDeb5TYxBfOcj5Qdivf5DdD7HYcSS8eZyhCdhrlkwZKhcfW9V6of6/K1tm/el5w
 3wKkRr+WUx3rxnODcx2sOUr83Ge0b2gSHKPNq9CqNHcaf/j7pZyJGhmup+CgVleZpXNGnwB
 jOQvdJRS/k0CvDto1DE/+Owr9dkWMey5KxEFpondeHoS/IYK035epxxi183iqaBGyr2e0v5
 /qVmkYXw1uTZLs2QJmKCqCB6z63CuCIPo36ulHRQEwfYRJfI+JUwAvKFU756m3gPFV3lck/
 diLRwxO4t87SqW75h3bpFyT2XlfBr1KzxoR62dJNuyLCmyK6xwRSeW3xeEZiiokW0rOedbS
 OereSqxa6NdqhgFEjgXVQmTV6zirLblUztaO9kZrkgDxzefDRX60/oe49n9NHFLZ5QzFhIu
 jSMr4qK9nBCYSRdp/Oto7w5kIXZOX+efXtZ1ZlSrNppgM6w==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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

Hi,

On 11/7/25 15:47, FUKAUMI Naoki wrote:
> Include the FDT for Radxa ROCK 5T in the FIT, in addition to those for
> 5B and 5B+, and add board selection code to load the 5T FDT when the
> DRAM type is LPDDR5 and ADC channel 5 value is close to 1016.

I forgot to write...

  Features tested on a Radxa ROCK 5T v1.2:
  - uSD card (boot/mmc info)
  - eMMC (mmc info)
  - SPI flash (sf probe)
  - PCIe (pci enum)
  - NVMe (nvme scan)
  - Ethernet(RJ45_2) (ping)
  - USB (usb start)

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
> This patch depends on the following Jonas's patch series:
>   https://patchwork.ozlabs.org/project/uboot/list/?series=467612
> ---
>   arch/arm/dts/rk3588-rock-5t-u-boot.dtsi   | 3 +++
>   board/radxa/rock5b-rk3588/rock5b-rk3588.c | 1 +
>   configs/rock5b-rk3588_defconfig           | 2 +-
>   doc/board/rockchip/rockchip.rst           | 2 +-
>   4 files changed, 6 insertions(+), 2 deletions(-)
>   create mode 100644 arch/arm/dts/rk3588-rock-5t-u-boot.dtsi
> 
> diff --git a/arch/arm/dts/rk3588-rock-5t-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5t-u-boot.dtsi
> new file mode 100644
> index 00000000000..c07696c8391
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-rock-5t-u-boot.dtsi
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3588-rock-5b-u-boot.dtsi"
> diff --git a/board/radxa/rock5b-rk3588/rock5b-rk3588.c b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
> index 6bf4497ce3a..2c172d04499 100644
> --- a/board/radxa/rock5b-rk3588/rock5b-rk3588.c
> +++ b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
> @@ -23,6 +23,7 @@ struct board_model {
>   };
>   
>   static const struct board_model board_models[] = {
> +	{ LPDDR5,  926, 1106, "rockchip/rk3588-rock-5t.dtb" },
>   	{ LPDDR5, 4005, 4185, "rockchip/rk3588-rock-5b-plus.dtb" },
>   };
>   
> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
> index 967cebc2054..567f649ea69 100644
> --- a/configs/rock5b-rk3588_defconfig
> +++ b/configs/rock5b-rk3588_defconfig
> @@ -47,7 +47,7 @@ CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
> -CONFIG_OF_LIST="rockchip/rk3588-rock-5b rockchip/rk3588-rock-5b-plus"
> +CONFIG_OF_LIST="rockchip/rk3588-rock-5b rockchip/rk3588-rock-5b-plus rockchip/rk3588-rock-5t"
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SPL_REGMAP=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 9af701feb5d..6ae4d4371ff 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -162,7 +162,7 @@ List of mainline supported Rockchip boards:
>        - Pine64 QuartzPro64 (quartzpro64-rk3588)
>        - Radxa ROCK 5 ITX (rock-5-itx-rk3588)
>        - Radxa ROCK 5A (rock5a-rk3588s)
> -     - Radxa ROCK 5B/5B+ (rock5b-rk3588)
> +     - Radxa ROCK 5B/5B+/5T (rock5b-rk3588)
>        - Radxa ROCK 5C (rock-5c-rk3588s)
>        - Rockchip Toybrick TB-RK3588X (toybrick-rk3588)
>        - Theobroma Systems RK3588-SBC Jaguar (jaguar-rk3588)



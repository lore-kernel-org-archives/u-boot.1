Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B517E67816
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 23:08:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C77F188FD6;
	Sun,  3 Nov 2024 00:08:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="XM0fs5aF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BD7588FD6; Sun,  3 Nov 2024 00:08:14 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7150188FFC
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 00:08:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4e10=R6=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1730588884;
 bh=gJ4puArxPobdw/bKKJe1HEkMbtpCabTdaEykarBkTAs=;
 b=XM0fs5aF/kbE66hfA6Z5KW8I3EvEcKjjTtYjiXjHYxPf+ZQd8PqsbXhYrcPW5cT50YJK0Vorv
 RF++Ah+b+vm22rRkcRGFfF3pxGGIzNN/r8n5cmmCxl+5F/hHpO3MKWOnnyDw4aHgi6QT/eHfAsJ
 B+6EDv6H9ehbuMkCCJdsXkyZARsqCWUviCrjDJZI8gFzy0rJ7Y2ItWPYFzZFw6C3Ib6+0t/CtvV
 bt/urSiwj05tLlSUwfhforNF5f0+tHtwg9X2k9IHYz14aXFW0cbO55rF9Xy53uo+EG9Pa54paXs
 X5I7Ii7hFE/ZMfqk+JZIQ0uSH6xdKShrrJM8lCbzgL8A==
Message-ID: <c8d4dcb5-58a1-4251-a37f-6d5006194c23@kwiboo.se>
Date: Sun, 3 Nov 2024 00:07:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] board: rockchip: Add support for rk3588 GenBook
To: Andy Yan <andyshrk@163.com>, kever.yang@rock-chips.com
Cc: u-boot@lists.denx.de
References: <20241101120644.420384-1-andyshrk@163.com>
 <20241101120644.420384-3-andyshrk@163.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20241101120644.420384-3-andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 6726b0d3922720f2eae9247b
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

Hi Andy,

On 2024-11-01 13:06, Andy Yan wrote:
> Add support for Cool Pi GenBook, it works as a carrier board
> connect with CM5 SOM.
> 
> Specification:
> - Rockchip RK3588
> - LPDDR5X 8/32 GB
> - eMMC 64 GB
> - HDMI Type A out x 1
> - USB 3.0 Host x 1
> - USB-C 3.0 with DisplayPort AltMode
> - PCIE M.2 E Key for RTL8852BE Wireless connection
> - PCIE M.2 M Key for NVME connection
> - eDP panel with 1920x1080
> 
> Tested by Armbian boot on USB disk.
> 
> Signed-off-by: Andy Yan <andyshrk@163.com>
> 
> ---
> 
> Changes in v5:
> - Fix document isn't included in any toctree error ini rst doc
> 
> Changes in v4:
> - Fix a underline too short error in rst doc
> 
> Changes in v3:
> - Remove upstreamed dt in genbook-u-boot.dtsi
> - Remove MMC releated config as there is no SD-card on this machine
> - Enable LED config
> - Enable rk8xx pmic
> - rename defconfig to coolpi-cm5-genbook-rk3588_defconfig
> - redefine BOOT_TARGETS
> 
> Changes in v2:
> - split the dts to a separate commit
> - rename to genbook_cm5_rk3588
> - move readme to doc/board, and write as reStructuredText format
> - alphabetically reorder
> - update doc/board/rockchip
> 
>  .../dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi |  20 ++++
>  arch/arm/mach-rockchip/rk3588/Kconfig         |  19 ++++
>  board/coolpi/genbook_cm5_rk3588/Kconfig       |  12 +++
>  board/coolpi/genbook_cm5_rk3588/MAINTAINERS   |   7 ++
>  configs/coolpi-cm5-genbook-rk3588_defconfig   | 101 ++++++++++++++++++
>  doc/board/coolpi/genbook_cm5_rk3588.rst       |  68 ++++++++++++
>  doc/board/coolpi/index.rst                    |   9 ++
>  doc/board/index.rst                           |   1 +
>  doc/board/rockchip/rockchip.rst               |   1 +
>  include/configs/genbook-cm5-rk3588.h          |  31 ++++++
>  10 files changed, 269 insertions(+)
>  create mode 100644 arch/arm/dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi
>  create mode 100644 board/coolpi/genbook_cm5_rk3588/Kconfig
>  create mode 100644 board/coolpi/genbook_cm5_rk3588/MAINTAINERS
>  create mode 100644 configs/coolpi-cm5-genbook-rk3588_defconfig
>  create mode 100644 doc/board/coolpi/genbook_cm5_rk3588.rst
>  create mode 100644 doc/board/coolpi/index.rst
>  create mode 100644 include/configs/genbook-cm5-rk3588.h
> 

[snip]

> diff --git a/include/configs/genbook-cm5-rk3588.h b/include/configs/genbook-cm5-rk3588.h
> new file mode 100644
> index 00000000000..f71f735b113
> --- /dev/null
> +++ b/include/configs/genbook-cm5-rk3588.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + */
> +
> +#ifndef __GENBOOK_CM5_RK3588_H
> +#define __GENBOOK_CM5_RK3588_H
> +
> +#define ROCKCHIP_DEVICE_SETTINGS \
> +		"stdout=serial,vidconsole\0" \
> +		"stderr=serial,vidconsole\0"
> +
> +#include <configs/rk3588_common.h>
> +
> +#undef BOOT_TARGETS
> +#define BOOT_TARGETS "usb mmc0"
> +
> +#undef CFG_EXTRA_ENV_SETTINGS
> +
> +/*
> + * As a laptop, there is no sdmmc, and we want to
> + * set usb the highest boot priority for third-part
> + * os installation.
> + */
> +#define CFG_EXTRA_ENV_SETTINGS \
> +	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
> +	"partitions=" PARTS_DEFAULT		\
> +	ENV_MEM_LAYOUT_SETTINGS			\
> +	ROCKCHIP_DEVICE_SETTINGS \
> +	"boot_targets=" BOOT_TARGETS "\0"

Having to re-define CFG_EXTRA_ENV_SETTINGS seem redundant, please try
including below diff for rockchip-common.h and use something like this:

  #define ROCKCHIP_DEVICE_SETTINGS \
		"stdout=serial,vidconsole\0" \
		"stderr=serial,vidconsole\0"

  /*
   * As a laptop, there is no sdmmc, and we want to
   * set usb the highest boot priority for third-part
   * os installation.
   */
  #define BOOT_TARGETS "usb mmc0"

  #include <configs/rk3588_common.h>

> +
> +#endif /* __GENBOOK_CM5_RK3588_H */

diff --git a/include/configs/rockchip-common.h b/include/configs/rockchip-common.h
index 9b8ab3cdf207..d5550a46575a 100644
--- a/include/configs/rockchip-common.h
+++ b/include/configs/rockchip-common.h
@@ -13,7 +13,9 @@
 
 #ifndef CONFIG_XPL_BUILD
 
+#ifndef BOOT_TARGETS
 #define BOOT_TARGETS	"mmc1 mmc0 nvme scsi usb pxe dhcp spi"
+#endif
 
 #ifdef CONFIG_ARM64
 #define ROOT_UUID "B921B045-1DF0-41C3-AF44-4C6F280D3FAE;\0"

Regards,
Jonas

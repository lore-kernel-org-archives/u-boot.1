Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF88CCA0FFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 14:36:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3930883826;
	Sat, 30 Aug 2025 16:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="fdRAhjMW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13CBE83826; Sat, 30 Aug 2025 16:36:09 +0200 (CEST)
Received: from mail-m49248.qiye.163.com (mail-m49248.qiye.163.com
 [45.254.49.248])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82D1282E34
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 16:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123985ec;
 Sat, 30 Aug 2025 22:36:03 +0800 (GMT+08:00)
Message-ID: <7916509d-8d21-495f-93e2-1f98a1a74793@rock-chips.com>
Date: Sat, 30 Aug 2025 22:36:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: unblock CAN bus in spl_board_init on
 Jaguar
To: Jakob Unterwurzacher <jakobunt@gmail.com>,
 Klaus Goger <klaus.goger@cherry.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
Cc: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de
References: <20250617084253.1756035-1-jakob.unterwurzacher@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250617084253.1756035-1-jakob.unterwurzacher@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb68256803afkunm9ef22770407422
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGBpPVkxNSkgdTE0ZQhkdHVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=fdRAhjMWe0JYB+ZR9f1SIjVSDvsYfVlcGa9zqgfRv7IXCBe7Kidd9LmjxgksY9DfbEd8KXWITrDhbHuFJRc9cOK6bRvS7yGsQvmPIUlRrEigmVvF/Vj2ij/aXUJ4dx9PCjg2gjj9V0895aBPKCK8ZWkztGtUyE4BuG12ns6VE+Q=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=bxwBJvFayoor3xi1UXG5VA42OJJns9peioNMwragAYU=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/6/17 16:42, Jakob Unterwurzacher wrote:
> GPIO0_B7 is routed to TXI of the on-board CAN transceiver. The
> line has a pull-down per SoC default.
>
> This means the CAN transceiver transmits a dominant zero
> and blocks the CAN bus until Linux boots and reconfigures the pin.
>
> Let's switch to pull-up as soon as we can (i.e. in SPL).
> This cuts down the "bus is blocked" time from 10 seconds to < 1 second.
>
> Of course, to this needs CONFIG_SPL_BOARD_INIT, so enable it
> the Jaguar defconfig.
>
> Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../jaguar_rk3588/jaguar_rk3588.c             | 19 +++++++++++++++++++
>   configs/jaguar-rk3588_defconfig               |  1 +
>   2 files changed, 20 insertions(+)
>
> diff --git a/board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c b/board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c
> index a6d44f10db3..3f484646701 100644
> --- a/board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c
> +++ b/board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c
> @@ -51,3 +51,22 @@ int rockchip_early_misc_init_r(void)
>   
>   	return 0;
>   }
> +
> +#define GPIO0B7_PU_EN BIT(15)
> +
> +void spl_board_init(void)
> +{
> +	/*
> +	 * GPIO0_B7 is routed to CAN TX. This SoC pin has a pull-down per default.
> +	 * So on power-up, we block the CAN bus with a dominant zero. We want to keep
> +	 * this blocking time to a minimum, so we want to get this pin high in SPL.
> +	 *
> +	 * The CAN driver in Linux disables the pull-down and sets the pin to
> +	 * output high. We don't have a CAN driver in U-Boot and don't need one,
> +	 * so we just use the easiest way to get the pin high, which is setting a
> +	 * pull-up.
> +	 */
> +	struct rk3588_pmu2_ioc * const ioc = (void *)PMU2_IOC_BASE;
> +
> +	rk_setreg(&ioc->gpio0b_p, GPIO0B7_PU_EN);
> +}
> diff --git a/configs/jaguar-rk3588_defconfig b/configs/jaguar-rk3588_defconfig
> index 03d38274b15..272f1ca8ded 100644
> --- a/configs/jaguar-rk3588_defconfig
> +++ b/configs/jaguar-rk3588_defconfig
> @@ -27,6 +27,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-jaguar.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_CYCLIC=y
>   CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_BOARD_INIT=y
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   CONFIG_SPL_ATF=y
>   # CONFIG_BOOTM_NETBSD is not set

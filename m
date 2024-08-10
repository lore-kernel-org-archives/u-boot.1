Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DCFC52D7D
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 00:11:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37CC088C0C;
	Sat, 10 Aug 2024 02:11:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0040688C39; Sat, 10 Aug 2024 02:11:23 +0200 (CEST)
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC6C388BB5
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 02:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtp82t1723248639tlpe5p7g
X-QQ-Originating-IP: MX5nS2mEPcdiwkA4TukIx4BDEBy6bdgt65Yts0RiiBE=
Received: from [192.168.159.131] ( [106.150.157.243])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 10 Aug 2024 08:10:36 +0800 (CST)
X-QQ-SSF: 01100000000000C0H000000A0000000
X-QQ-FEAT: +HVWQWZs/U1xBaA4Oqq22ApbyVcmdC6FrlcHf5I0Y3krMtRaPwwD8ZCKZ0sym
 PklgREsgf/EyZr1lKJtYUIlozP8e3Ik2BLgE2Bh71gwEjzx1NhO9XvKpSQPiI38rYov93fd
 xPvJ4j9AO1TGUMUQKIBzTgY16VLTKtdicygUdSNYUySRc+SYLd2BvvxuiAPLzgF8AMQT+8d
 K+bqU0d+fMyqHMo6c4qFXcCypqddJwqSItZwLlMoB6KvRZHDkfDnaApx9AnGivXxV/1Trr1
 4lW9DmWlXbl/IWENnTfk9IR+hXVkxEESRvxiSv3bTpOD/hJCcrUiaSEx+feug8qiaC7doFl
 seBhrxo8GminsneFxQ58sZ+G2FxCA2GtDb6jAPanokYhjxpcIYfOqz0AFWO6Q==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2711908975251547366
Message-ID: <C2C56BE822C9C219+80d78515-b219-4f7c-9598-93b1f43c46ad@radxa.com>
Date: Sat, 10 Aug 2024 09:10:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] rockchip: rk3308-rock-pi-s: Enable LED and IO Domain
 driver
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de
References: <20240730145148.849245-1-jonas@kwiboo.se>
 <20240730145148.849245-9-jonas@kwiboo.se>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20240730145148.849245-9-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
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

On 7/30/24 23:51, Jonas Karlman wrote:
> Add LED=y and LED_GPIO=y to support the onboard leds.
> 
> Add ROCKCHIP_IODOMAIN=y to configure correct io voltage domains.
> 
> Add DM_MDIO=y now that the DT contain a Ethernet phy node.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

for the whole series,

Tested-by: FUKAUMI Naoki <naoki@radxa.com>

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> ---
>   configs/rock-pi-s-rk3308_defconfig | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
> index e450a0618020..54f7744c9895 100644
> --- a/configs/rock-pi-s-rk3308_defconfig
> +++ b/configs/rock-pi-s-rk3308_defconfig
> @@ -38,10 +38,14 @@ CONFIG_CLK=y
>   # CONFIG_USB_FUNCTION_FASTBOOT is not set
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_PHY_REALTEK=y
> +CONFIG_DM_MDIO=y
>   CONFIG_DM_ETH_PHY=y
>   CONFIG_ETH_DESIGNWARE=y
>   CONFIG_GMAC_ROCKCHIP=y

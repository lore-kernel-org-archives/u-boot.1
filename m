Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D43C27C6E
	for <u-boot@archiver.kernel.org>; Sun, 16 Jun 2024 09:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5192788054;
	Sun, 16 Jun 2024 11:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="XlZUDwd8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE1E6880CC; Sun, 16 Jun 2024 11:24:15 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DB058804F
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 11:24:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e15e=NS=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1718529845;
 bh=TWwTn8xJKGMHn/u2VF07RrWKyXWO1b4R7WlOl5E1P0w=;
 b=XlZUDwd8Wu6tQ7dBCSdOxpbwsr6EC+IpqAC6dywd5Hgm8jo2i3WHEwotrWcpxQ1fzZTG84X1w
 CTxwq/7h36wXHAvDnjAeqSMwsPmEeyfaa2po0JnfITvbNB3hXIA6gDP1c/QVg6USdGKtnDnd9jn
 wibaRQfpU9a3Na+T8qCr4TTuvqPwMeY2tXGEEEIBCV6HyNjqycXX0WN34uBrfHuTKMCasBZaOWu
 JpyOm3NEJycpBjfSe6FqwbmUI+wzPFPmp2EXX2kIeYglBKNBEkv9mjSlyrxanSDGO8YsmSC9i8/
 Tv/jWGCOJc5Kewjin1PKGW9xEeFPJzzEAKyGsZ0OB30g==
Message-ID: <479eaab5-509a-4f30-97d3-e8fa60c8d117@kwiboo.se>
Date: Sun, 16 Jun 2024 11:24:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rockchip: rock-3a: rock5a: rock5b: add USB GADGET
 related configs
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: u-boot@lists.denx.de, eugen.hristev@collabora.com, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 gajjar04akash@gmail.com
References: <20240615074639.1686-1-naoki@radxa.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240615074639.1686-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 666eaf3501f41f7e8a21dd71
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

On 2024-06-15 09:46, FUKAUMI Naoki wrote:
> add USB GADGET related configs for USB OTG port on ROCK 3A/5A/5B.
> 
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
>  configs/rock-3a-rk3568_defconfig | 6 ++++++
>  configs/rock5a-rk3588s_defconfig | 6 ++++++
>  configs/rock5b-rk3588_defconfig  | 1 +
>  3 files changed, 13 insertions(+)
> 
> diff --git a/configs/rock-3a-rk3568_defconfig b/configs/rock-3a-rk3568_defconfig
> index 66ac2f6d7a..0568a73038 100644
> --- a/configs/rock-3a-rk3568_defconfig
> +++ b/configs/rock-3a-rk3568_defconfig
> @@ -37,6 +37,8 @@ CONFIG_CMD_MMC=y
>  CONFIG_CMD_PCI=y
>  CONFIG_CMD_POWEROFF=y
>  CONFIG_CMD_USB=y
> +CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
>  # CONFIG_CMD_SETEXPR is not set
>  CONFIG_CMD_PMIC=y
>  CONFIG_CMD_REGULATOR=y
> @@ -50,6 +52,7 @@ CONFIG_SPL_SYSCON=y
>  CONFIG_SCSI_AHCI=y
>  CONFIG_AHCI_PCI=y
>  CONFIG_SPL_CLK=y
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
>  CONFIG_ROCKCHIP_GPIO=y
>  CONFIG_SYS_I2C_ROCKCHIP=y
>  CONFIG_MISC=y
> @@ -90,4 +93,7 @@ CONFIG_USB_OHCI_HCD=y
>  CONFIG_USB_OHCI_GENERIC=y
>  CONFIG_USB_DWC3=y
>  CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_USB_FUNCTION_ROCKUSB=y
>  CONFIG_ERRNO_STR=y
> diff --git a/configs/rock5a-rk3588s_defconfig b/configs/rock5a-rk3588s_defconfig
> index c09e6655f0..e06052cd80 100644
> --- a/configs/rock5a-rk3588s_defconfig
> +++ b/configs/rock5a-rk3588s_defconfig
> @@ -27,6 +27,8 @@ CONFIG_CMD_GPT=y
>  CONFIG_CMD_I2C=y
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_USB=y
> +CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
>  # CONFIG_CMD_SETEXPR is not set
>  CONFIG_CMD_REGULATOR=y
>  # CONFIG_SPL_DOS_PARTITION is not set
> @@ -37,6 +39,7 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
>  CONFIG_SPL_REGMAP=y
>  CONFIG_SPL_SYSCON=y
>  CONFIG_SPL_CLK=y
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
>  CONFIG_ROCKCHIP_GPIO=y
>  CONFIG_SYS_I2C_ROCKCHIP=y
>  CONFIG_MISC=y
> @@ -67,4 +70,7 @@ CONFIG_USB_OHCI_HCD=y
>  CONFIG_USB_OHCI_GENERIC=y
>  CONFIG_USB_DWC3=y
>  CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_USB_FUNCTION_ROCKUSB=y

I do not think there is any usb port that use dr_mode otg/peripheral,
so enabling gadget support probably have no impact on ROCK 5A.

Regards,
Jonas

>  CONFIG_ERRNO_STR=y
> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
> index fc118cea7b..80a2f2fed5 100644
> --- a/configs/rock5b-rk3588_defconfig
> +++ b/configs/rock5b-rk3588_defconfig
> @@ -39,6 +39,7 @@ CONFIG_CMD_MMC=y
>  CONFIG_CMD_PCI=y
>  CONFIG_CMD_USB=y
>  CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
>  # CONFIG_CMD_SETEXPR is not set
>  CONFIG_CMD_REGULATOR=y
>  # CONFIG_SPL_DOS_PARTITION is not set


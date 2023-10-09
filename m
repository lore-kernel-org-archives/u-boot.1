Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA840E95A67
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 00:12:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3A7586D2E;
	Mon,  9 Oct 2023 02:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1696810359;
	bh=MGwyc7h9FHbAXhXZmZjdnef0yFakMbUTdsbMTios3Po=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oSrCddqVx9FhI/CdU4Ohx+gthVqy8hLvezgU9scQz7r+LHWrqFh1FwU4MesIH923e
	 RVum/2OErvPG66ML1U5ZSSVmvtLlX3CvdpgAM+OaNxC3J5bl0Vf0086jG3LIy6jBri
	 wbyMNqk+GuTmi/sd2XCqa10fkfVXBfS/5m5+i4fHXXNUVk2KhV1HXJTU1McIf/rdSK
	 vtt743jerQgla9HCLCU3l+4/S9r8P/se3qbMiJ0LXIfjHMYO9db/tpmzch5vbphcZM
	 H/fRKwzfA/OTKJG3OkPegC+2nzdCpsf6T6gT1Mst4fhRB7PUPi3Pyu+I9an+3R1w2/
	 fSyC/B9V4ZlWQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7BF2686D56;
 Mon,  9 Oct 2023 02:12:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1696810358;
 bh=MGwyc7h9FHbAXhXZmZjdnef0yFakMbUTdsbMTios3Po=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=vWAeMp/s7pohHbkltE/9ebzxTXbj9dYFnoImDbIO2zMFy8GfsO8OyUkeCHUf0ebJk
 iqL8lpchUCRnEaTYJXy7UYXIEntm/i2DGr9PxJNWcV8Tdr4AWuyOQ7MXgvMuYrK5tg
 6+GbZpZp2Ijf9je4J8hqvOjw6RIntALrRH9YgCXE4n/+jnRoA6IeiUmBFIi1Mfd7ne
 xQtEtodX+tdCKaQqsTMM6IBCNAY2I14QIC8FQ0Xf4jmQi1iXiNhJFeREANceL8xUQM
 mJhYAbeuGTb9No7maoCoJGNBiKuXvGW7fgUK3sc0sswohue5hn1uVb3cvT4Nv+jNgs
 MvY72VcA197HA==
Message-ID: <52a2d5b3-3025-46df-871a-ce1b0b2fdd43@denx.de>
Date: Mon, 9 Oct 2023 02:12:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mx28evk: Add USB Mass Storage support
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
References: <20231008205939.3332647-1-festevam@gmail.com>
 <20231008205939.3332647-3-festevam@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231008205939.3332647-3-festevam@gmail.com>
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

On 10/8/23 22:59, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Select the USB options to allow running "ums 0 mmc 0".
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v1:
> - Remove unrelated config options. (Marek)
> 
>   configs/mx28evk_defconfig | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/configs/mx28evk_defconfig b/configs/mx28evk_defconfig
> index df0cceaea719..0b7c4b252ff0 100644
> --- a/configs/mx28evk_defconfig
> +++ b/configs/mx28evk_defconfig
> @@ -32,6 +32,8 @@ CONFIG_CMD_DM=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_NAND_TRIMFFS=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_DATE=y
>   CONFIG_CMD_EXT4=y
> @@ -65,3 +67,13 @@ CONFIG_RTC_MXS=y
>   CONFIG_DM_SERIAL=y
>   CONFIG_SPI=y
>   CONFIG_USB=y
> +CONFIG_SPL_USB_HOST=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_MAX_CONTROLLER_COUNT=2
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_MANUFACTURER="FSL"
> +CONFIG_USB_GADGET_VENDOR_NUM=0x0525
> +CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
> +CONFIG_CI_UDC=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_SPL_USB_SDP_SUPPORT=y

But the SPL SDP is still here ^ , how come ?

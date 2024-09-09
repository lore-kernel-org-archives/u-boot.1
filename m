Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8034ECE579
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 14:36:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D4DE88E08;
	Mon,  9 Sep 2024 16:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725892561;
	bh=lJzk+9ny7cayKlLBK6vIImh8AF+NU7rlyCEfDc/RMJQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rIgbWl4fY52HGunLzzOFVsaGKYCp49XLilOMV67gQ3/m90pVIeznSgtVpN0pfiilQ
	 LrHIevr5pz15hB6fd9iEJy6Dj8A/GUaw5/M+aHG4z9kZH2jNIJ1w8px3h7hcwB1RhI
	 U2mlRVtax8pmCE/71dHItKuxBNrP3IMTeK4b34pAkiK8qu2O1H99sMpjdzU+3gMkFX
	 nx//4gf26Snaf7z+NpCzG3HIaGXZUBH3OqZRtyXPblPvmntvbuyppX/Jhn/PNe+l4P
	 bQhzW3USwYTsK+Td5mec1n18C3DYtd6v3ClpX4tGIX+FbymXkxWU+4a3I1JaG5/E0o
	 xA5mSbL1rlzMw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 95F3988D00;
 Mon,  9 Sep 2024 16:35:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725892560;
 bh=lJzk+9ny7cayKlLBK6vIImh8AF+NU7rlyCEfDc/RMJQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qqmA90I6j29HsfdwEfTK0hk4zTS8ROeBI1m9HOKrHn5e6bwREP9zgMPW555j6rKV/
 U+/X1WtADeYwBN/fE+g/LU4QdylExvVZPMuA5Qlqe34JrAlazX5GIW3bzn/TpvRq22
 EbR3/gSv/OTQDXuczbjCtA7FYn6brhrq5E1+HBgjQrP6KGQnxe6javscTBpd031fwo
 CoLKF0mC6YWWUrzT8z6lLe9S5oo7flbx0ZVPmfPscDl1gOJsCdGbaX3bm1IupaKGdt
 15vCeUhxP50HR1u9jmovm4yJG2+1HNfQBhiwo7/gAqVEftVeMOJVim0mML9sWLtErk
 Mz62Y/S7nmPMA==
Message-ID: <0571d892-caa7-4f36-a094-bedb77ac33df@denx.de>
Date: Mon, 9 Sep 2024 16:35:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 21/25] Kconfig: fix undefined symbols (g_dnl*) when
 NET_LWIP is default enabled
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Miquel Raynal <miquel.raynal@bootlin.com>
References: <cover.1725625913.git.jerome.forissier@linaro.org>
 <9462e25d33d93c670a882e6ee329ca7e6668d7ab.1725625913.git.jerome.forissier@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <9462e25d33d93c670a882e6ee329ca7e6668d7ab.1725625913.git.jerome.forissier@linaro.org>
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

On 9/6/24 2:33 PM, Jerome Forissier wrote:
> Fix for link errors on am62px_evm_a53and other platforms when NET_LWIP
> is enabled:
> 
>   common/dfu.c:34:(.text.run_usb_dnl_gadget+0x68): undefined reference to `g_dnl_clear_detach
>   [...]
>   common/spl/spl_dfu.c:29:(.text.spl_dfu_cmd+0xb0): undefined reference to `run_usb_dnl_gadget'
> 
> - DFU_OVER_USB compiles common/dfu.c which calls g_dnl_clear_detach()
> which is implemented in drivers/usb/gadget/g_dnl.c which needs
> USB_GADGET_DOWNLOAD
> - SPL_DFU compiles common/spl/spl_dfu.c which calls run_usb_dnl_gadget()
> which is implemented in common/dfu.c which needs DFU_OVER_USB
> 
> Therefore add these dependencies to Kconfig.
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>   drivers/dfu/Kconfig        | 1 +
>   drivers/usb/gadget/Kconfig | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
> index d034b501360..7de629f103a 100644
> --- a/drivers/dfu/Kconfig
> +++ b/drivers/dfu/Kconfig
> @@ -8,6 +8,7 @@ config DFU_OVER_USB
>   	bool
>   	select HASH
>   	depends on USB_GADGET
> +	depends on USB_GADGET_DOWNLOAD

Is it necessary to 'depends' on both USB_GADGET and USB_GADGET_DOWNLOAD 
? The later should imply the former is already selected, no ?

>   config DFU_OVER_TFTP
>   	bool
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 03fe3bca197..ce9364c3172 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -324,6 +324,7 @@ config SPL_DFU
>   	select SPL_HASH
>   	select SPL_DFU_NO_RESET
>   	depends on SPL_RAM_SUPPORT
> +	depends on DFU_OVER_USB
Keep the list sorted please.

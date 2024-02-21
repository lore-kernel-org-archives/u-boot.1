Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16399C48BC3
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 07:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6B0087E23;
	Wed, 21 Feb 2024 08:55:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="XtMQXTGZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E8AF87E23; Wed, 21 Feb 2024 08:55:30 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4913E88026
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 08:55:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
 by mail11.truemail.it (Postfix) with ESMTPA id 0B3F3207BE;
 Wed, 21 Feb 2024 08:55:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1708502121;
 bh=80BNjOQGhWMpb80OVOA6bPP+kksAnTbWBIAPXSaiaZk=; h=From:To:Subject;
 b=XtMQXTGZElLuiiUK0b2HD1cAuyDQWH/kuZ2oTndkkJWtPYN8nMHxyeHLEe2xnskGT
 c15BZPlCAasauDRyGSvugUQLjhNBRMC2F+bkzbXIP1SJ1fZkOOcVH96Jub9rCy3C6O
 SPSxqcWDpxHbqTkILMQFz25tlazAY86MxSV4Ikkef+eKtEAPn66nq/TsqkFZOkwKg0
 MgbZwAtR1tahxOTmlF3Z0nno6Ly85totosrL+wBYanp0Cb51aVszmCev13vLcWF72Z
 10AUIcE9qxsFhksCdI11y2FNqyy0jhy4HBXBvowvn2Ya2HVs+MH5QNjqNhLA/QndT4
 cNoBTXaTIdNlg==
Date: Wed, 21 Feb 2024 08:55:16 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com,
 festevam@denx.de, andrejs.cainikovs@toradex.com, sjg@chromium.org,
 peng.fan@nxp.com, aford173@gmail.com, marex@denx.de,
 ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
Subject: Re: [PATCH 7/7] verdin-imx8mp_defconfig: Enable PCIe/NVMe support
Message-ID: <20240221075516.GA5131@francesco-nb>
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-8-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220131056.2962331-8-sumit.garg@linaro.org>
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

Hello Sumit,

On Tue, Feb 20, 2024 at 06:40:56PM +0530, Sumit Garg wrote:
> Also, enable reset driver which is a prerequisite for PCIe support.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  configs/verdin-imx8mp_defconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
> index 22b8a334dfa..d8bd644322b 100644
> --- a/configs/verdin-imx8mp_defconfig
> +++ b/configs/verdin-imx8mp_defconfig
> @@ -185,3 +185,12 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
>  CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
>  CONFIG_IMX_WATCHDOG=y
>  CONFIG_HEXDUMP=y
> +CONFIG_DM_RESET=y
> +CONFIG_RESET_IMX=y
> +CONFIG_PCI=y
> +CONFIG_PCIE_DW_IMX8=y
> +CONFIG_PHY_IMX8M_PCIE=y
> +CONFIG_CMD_PCI=y
> +CONFIG_NVME=y
> +CONFIG_NVME_PCI=y
> +CONFIG_CMD_NVME=y

This will increase the u-boot proper size and marginally increase the
boot time (because of a bigger binary to be read from the eMMC).

Apart of that do you expect any other impact on those changes? SPL
binary size should not be affected, correct?

Asking this out loudly to confirm that nothing unexpected is going to
happen because of these changes.

For my curiosity, care to share what's the use case? Do you plan to have
the OS stored into an NVME device?

Francesco


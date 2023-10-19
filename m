Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86970C001DF
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 23:51:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76238871C3;
	Fri, 20 Oct 2023 01:51:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="gRcbxqeT";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="RUGW6Rhi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B8F3871CD; Fri, 20 Oct 2023 01:51:40 +0200 (CEST)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 102758718D
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 01:51:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id DCC175C00DF;
 Thu, 19 Oct 2023 19:51:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 19 Oct 2023 19:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
 1697759491; x=1697845891; bh=8SrQq97Gxqc/1JRC/D4HQF/naWPPb745MAb
 MeSTnFT4=; b=gRcbxqeT4hM5o3Sw855RQ0jpcgMNdr5Vc+frCaLDk2kq7+YN9eM
 NJn/2qTYZOE48etDUZP+6gOepqTBeeNYTW5SsutYV7p4+bk9nxC4CE/tf5yYUiPu
 3ZDLFxajwWa63L0xgkZIjR3OwG5QQnyC5OYWXf88MnNMIB1yryPKXVFiVku28dik
 MnO18B8K3UllmXFBkFMN9Lq7xgBhoeNBxFuGClU079jqlJbmgvHRWbWIkqcsp3hn
 biTIalfWWgCPAan4Aty99CxsP37UaMF3nfP6pMIjHMuEghYEwMUFbJOE39U+M4EO
 09NIkYObGRhQTjYrloVVpv+9ETZf+oBitaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1697759491; x=1697845891; bh=8SrQq97Gxqc/1JRC/D4HQF/naWPPb745MAb
 MeSTnFT4=; b=RUGW6RhiQj+5d9+wgUybj9KQ+KlrYy0GB/fm81rbUezBJvOGFak
 DLBkaOOBj6Kq0khtdZLquk3Q0oE88i9QSrLcvvRF6W1L81sf3LlwIgmvksdATxPk
 sx/AbOZbg1iRTCMVgtV6D2r2GdUEF0IrN2owQQu19qI3nbIV6SweOOcpq44gaL+o
 B6hfOUdf7L+i2i+kx29vzTYDPiz7p8+/QlpeA3lDG10l9w7qTax2WNwGaMVp79Az
 Zd90OhZSoE2hSgJZCFGPEIqrFCcCRqgXkIvz/9OqCGRSZLXo4ySUFQGq3g2S62j+
 uZlP2f8NIwhLcjAwiRdDb9Vwwlz3yLncw9w==
X-ME-Sender: <xms:A8ExZTj5qevioGULjEXsiawtOaGqGgOFA7gqooMUr2k6SFe9kg2d2w>
 <xme:A8ExZQCJ3aRUoy6D1-nkC2i6Sj6YR61AadT2rtc1UzyVCrxkAneSZ7KusmtsgZA-X
 yw6B0XW61OiFq_-vg>
X-ME-Received: <xmr:A8ExZTGtyX7OYyuY5CD3F7go7Tgvs4j5-0pEavohNwMrt4FXrWHUgnSP32a_cNj7JuIetOIKBev8Z_KmY1j9jgyiH7fpJAmdBT4I4EQiniFPiVf28Ns1fuWvew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeejgddviecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
 vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
 ftrfgrthhtvghrnhepkeejleelfeeitdfhtdfgkeeghedufeduueegffdvhfdukeelleef
 tdetjeehuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:A8ExZQQwiJmD5IFgeEfobRrXZQvPnXG33Lvs-Deq1hUxyjowtn3AtQ>
 <xmx:A8ExZQzOE7KkEV4V8NuzCecDJBGg0dZUhKwE7_vdR7HWhBEBxS4OEg>
 <xmx:A8ExZW4fhHmwoQGgx3g75g6LDuCrhvyQXN4JZjsi2SVwWT3Dm-JdjQ>
 <xmx:A8ExZflDctalGBg5lE3_Jybl3-E2ZN0ke990IGEDuqC1S_wv2ztbzg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Oct 2023 19:51:30 -0400 (EDT)
Message-ID: <9ee155e3-7bd0-ed70-b4b7-33f4760a507c@sholland.org>
Date: Thu, 19 Oct 2023 18:51:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 01/22] sunxi: remove CONFIG_SATAPWR
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng
 <uwu@icenowy.me>, Maxim Kiselev <bigunclemax@gmail.com>,
 Sam Edwards <cfsworks@gmail.com>, Okhunjon Sobirjonov
 <okhunjon72@gmail.com>, linux-sunxi@lists.linux.dev,
 andre.przywara@foss.arm.com, Jagan Teki <jagan@amarulasolutions.com>,
 u-boot@lists.denx.de
References: <20230928215455.28094-1-andre.przywara@arm.com>
 <20230928215455.28094-2-andre.przywara@arm.com>
From: Samuel Holland <samuel@sholland.org>
In-Reply-To: <20230928215455.28094-2-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
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

On 9/28/23 16:54, Andre Przywara wrote:
> The CONFIG_SATAPWR Kconfig symbol was used to point to a GPIO that
> enables the power for a SATA harddisk.
> In the DT this is described with the target-supply property in the AHCI
> DT node, pointing to a (GPIO controlled) regulator. Since we need SATA
> only in U-Boot proper, and use a DM driver for AHCI there, we should use
> the DT instead of hardcoding this.
> 
> Add code to the sunxi AHCI driver to check the DT for that regulator and
> enable it, at probe time. Then drop the current code from board.c, which
> was doing that job before.
> This allows us to remove the SATAPWR Kconfig definition and the
> respective values from the defconfigs.
> We also select the generic fixed regulator driver, which handles those
> GPIO controlled regulators.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  arch/arm/Kconfig                             |  2 ++
>  arch/arm/mach-sunxi/Kconfig                  |  8 --------
>  board/sunxi/board.c                          | 16 +---------------
>  configs/A10-OLinuXino-Lime_defconfig         |  1 -
>  configs/A20-OLinuXino-Lime2-eMMC_defconfig   |  1 -
>  configs/A20-OLinuXino-Lime2_defconfig        |  1 -
>  configs/A20-OLinuXino-Lime_defconfig         |  1 -
>  configs/A20-OLinuXino_MICRO-eMMC_defconfig   |  1 -
>  configs/A20-OLinuXino_MICRO_defconfig        |  1 -
>  configs/A20-Olimex-SOM-EVB_defconfig         |  1 -
>  configs/A20-Olimex-SOM204-EVB-eMMC_defconfig |  1 -
>  configs/A20-Olimex-SOM204-EVB_defconfig      |  1 -
>  configs/Cubieboard2_defconfig                |  1 -
>  configs/Cubieboard_defconfig                 |  1 -
>  configs/Cubietruck_defconfig                 |  1 -
>  configs/Itead_Ibox_A20_defconfig             |  1 -
>  configs/Lamobo_R1_defconfig                  |  1 -
>  configs/Linksprite_pcDuino3_Nano_defconfig   |  1 -
>  configs/Linksprite_pcDuino3_defconfig        |  1 -
>  configs/Sinovoip_BPI_M3_defconfig            |  1 -
>  configs/orangepi_plus_defconfig              |  2 +-
>  drivers/ata/ahci_sunxi.c                     |  9 +++++++++
>  22 files changed, 13 insertions(+), 41 deletions(-)
> 
> [...]
> diff --git a/configs/orangepi_plus_defconfig b/configs/orangepi_plus_defconfig
> index 76de72aa228..ed585881d49 100644
> --- a/configs/orangepi_plus_defconfig
> +++ b/configs/orangepi_plus_defconfig
> @@ -7,7 +7,6 @@ CONFIG_DRAM_CLK=672
>  CONFIG_MACPWR="PD6"
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=2
>  CONFIG_USB1_VBUS_PIN="PG13"
> -CONFIG_SATAPWR="PG11"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_SPL_I2C=y
>  CONFIG_SPL_SYS_I2C_LEGACY=y
> @@ -16,3 +15,4 @@ CONFIG_SUN8I_EMAC=y
>  CONFIG_SY8106A_POWER=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB3_VBUS_PIN="PG11"

This change is unrelated to the purpose of this commit.

Regards,
Samuel



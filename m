Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48ACEC7EE30
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 14:31:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94D7082E40;
	Sun, 29 Jun 2025 16:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Ucessm8e";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ns54ri96";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFDDA82E6A; Sun, 29 Jun 2025 16:31:55 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB6EA81FEE
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 16:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bVWvV4tl1z9tRx;
 Sun, 29 Jun 2025 16:31:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751207510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LtPFVKaTjC91f/NUQKy9uZywZTxxlexTXPk5tRyXtno=;
 b=Ucessm8e9pS3p/nh2bdGKbj6kK+DUKoByE7AZbdFZwaJmAE23LRtrDzDvxijaohIf854O3
 JqnKeOL1i/OMbE6EMwJteg/B6tqPT98aT3hJbRFFyWEzYvqU7EhDFj3g+JACrbLgCpwYei
 c5vLaSa5ZfbQ2KKJLbjko0m3w3gRsM4aHx/dON4P1eFDm9xSVkRTD8+2YO00phx3ckGUhV
 DLpY7xr9JsvkJB1eOqxliV/31HcnX0ECv48ivFtplCJiY+Sopi9AxTtG+wazjEuhLf93vI
 Q17hpcCkIsb+SVsstXYtZnE5OiRAL1iYvzWm016hq+vYRJQYM5YixBSGnjyO9g==
Message-ID: <995a016a-f873-440c-acb7-b18568003e41@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751207508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LtPFVKaTjC91f/NUQKy9uZywZTxxlexTXPk5tRyXtno=;
 b=Ns54ri96Dc/OtdoxUntkV+MXOPDz17SqsPqeCuIODrQ15OwFjFClL96wwLNYWb5X97y4c2
 IoWWSnkCUT71bhrWT9Og1gsk1EjgtpNnB+K0I9R3MMY3rib1mnucL1UcWoVBG0QSrZ39I3
 lvbriXDoqw0KGJPBUJDgdwtF+CFoikyDGAeVL/5zCm3ak+SFspaQCGIatXrIIk5wws9aSx
 bF25SLY9dhYgIyiQ4QqKgbH3hEhNonBuuq8FhsnQFpzMJf7P00yE5sDy4A8xhTz9AzzfZm
 VmtYIY8ZC1AVwooltms9bonrWdNfhJ9d9DiZUHvjolJR4kKZK0aMv3JiMoHsmA==
Date: Sun, 29 Jun 2025 16:31:45 +0200
MIME-Version: 1.0
Subject: Re: [U-Boot, v2, 1/1] net: phy: Add the Airoha EN8811H PHY driver
To: "Lucien.Jheng" <lucienzx159@gmail.com>, ilias.apalodimas@linaro.org,
 jerome.forissier@linaro.org, marek.vasut+renesas@mailbox.org,
 paul.barker.ct@bp.renesas.com, pbrobinson@gmail.com, u-boot@lists.denx.de
Cc: joseph.lin@airoha.com, wenshin.chung@airoha.com, lucien.jheng@airoha.com, 
 frank-w@public-files.de, daniel@makrotopia.org, ericwouds@gmail.com,
 albert-al.lee@airoha.com
References: <20250615131243.30770-1-lucienzx159@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250615131243.30770-1-lucienzx159@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: ada3b4a98d1e3138035
X-MBO-RS-META: zzsdm4cs4idrx1b7nypzx8hqrz573t7o
X-Rspamd-Queue-Id: 4bVWvV4tl1z9tRx
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

On 6/15/25 3:12 PM, Lucien.Jheng wrote:
> Add the driver for the Airoha EN8811H 2.5 Gigabit PHY. The PHY supports
> 100/1000/2500 Mbps with auto negotiation only.
> 
> The driver uses two firmware files, for which updated versions are added to
> linux-firmware already.
> 
> Locating the AIROHA FW within the filesystem at the designated partition
> and path will trigger its automatic loading and writing to the PHY via MDIO.
> If need board specific loading override,
> please override the en8811h_read_fw function on board or architecture level.
> 
> Linux upstream AIROHA EN8811H driver commit:
> 71e79430117d56c409c5ea485a263bc0d8083390
> 
> Based on the Linux upstream AIROHA EN8811H driver code(air_en8811h.c),
> I have modified the relevant process to align with the U-Boot boot sequence.
> and have validated this on Banana Pi BPI-R3 Mini.
> 
> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
> ---
> Change in PATCH v2:
> air_en8811h.c:
>   * Fix: Indentation and coding style
>   * Fix: Invert conditionals in some APIs to reduce indent.
>   * Correct en8811h_read_fw(): Integrate malloc to allow other users to
>     fully override the loading process and return a buffer containing the firmware from its source.
> 
>   drivers/net/phy/Kconfig       |  43 ++
>   drivers/net/phy/Makefile      |   1 +
>   drivers/net/phy/air_en8811h.c | 857 ++++++++++++++++++++++++++++++++++
>   3 files changed, 901 insertions(+)
>   create mode 100644 drivers/net/phy/air_en8811h.c
> 
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 3132718e4f8..f053f8196c2 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -79,6 +79,49 @@ config PHY_ADIN
>   	help
>   		Add support for configuring RGMII on Analog Devices ADIN PHYs.
> 
> +menuconfig PHY_AIROHA
> +	bool "Airoha Ethernet PHYs support"
> +
> +config PHY_AIROHA_EN8811H
> +	bool "Airoha Ethernet EN8811H support"
> +	depends on PHY_AIROHA
> +	help
> +	  AIROHA EN8811H supported.
> +
> +choice
> +	prompt "Location of the Airoha PHY firmware"
> +	default PHY_AIROHA_FW_IN_MMC
> +	depends on PHY_AIROHA_EN8811H
> +
> +config PHY_AIROHA_FW_IN_MMC
> +	bool "Airoha firmware in MMC partition"
> +	help
> +	  Airoha PHYs use firmware which can be loaded automatically
> +	  from storage directly attached to the PHY, and then loaded
> +	  via MDIO commands by the boot loader. The firmware is loaded
> +	  from a file specified by the PHY_AIROHA_FW_PART,
> +	  PHY_AIROHA_FW_DM_FILEPATH and PHY_AIROHA_FW_DSP_FILEPATH options.
I ran into the same firmware loading problem recently. I took a 
different approach, have a look at [1] and specifically function 
rcar_gen4_pcie_load_firmware() . This invokes U-Boot shell script , 
which has to be defined by the user, and which loads the firmware by 
whatever means necessary, from whatever storage or location . I think 
that might be the generic approach to U-Boot firmware loading . If the 
user needs to change the firmware loading location, they do not need to 
rebuild the U-Boot itself, they simply update their environment and the 
matching script. What do you think ?

[1] 
https://patchwork.ozlabs.org/project/uboot/patch/20250617081641.8385-5-marek.vasut+renesas@mailbox.org/

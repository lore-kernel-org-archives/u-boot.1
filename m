Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5465ACDB467
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 16:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5467886DCE;
	Wed, 11 Oct 2023 18:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="FslZwJag";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C6E88082A; Wed, 11 Oct 2023 18:57:30 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 661AA86DCE
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.obbard@collabora.com
Received: from [IPv6:2a00:23c8:b70a:ae01:9fa:2310:80c6:3ab0] (unknown
 [IPv6:2a00:23c8:b70a:ae01:9fa:2310:80c6:3ab0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: obbardc)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id D97D866072FC;
 Wed, 11 Oct 2023 17:57:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1697043447;
 bh=gaABHNpGofWLM0Ga1gxezBnVk7qaMAxJS9UwMu4bqR8=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=FslZwJagJxNNKOCAjMOJC/77nAoy+YcXtR5td92Go92CM0uNX40GGZ4ulXtCRKyVw
 7gmGLnkyKCmCqP/m18uo40nwfbtIVlxrELrxBmpXzgRKSmYMDmcCbO7CHWNfvb3Ph+
 k3mjtGzc8gNiyfzEaaStOZTXT1Ic0XkW7iWf/lFPd0GeGjGXcH6+fnxOh4j5alNWdA
 P8eIJpIRgX0nLOkKkuByUfozmHXKrLUf7NQt6T89VSJlwxnXR0/oKHzH+fhu1lgWND
 ReEpuROlpK+nq8N7AzcYLOP6pNYxv9TTxKHatMFbPYptp2aK85T1KW9BAQxRRPCnWm
 vED/HCgiXL6qw==
Message-ID: <d5109ab1461917c5fd43dfc9555979ec47121fa1.camel@collabora.com>
Subject: Re: [PATCH 2/4] rockchip: rk3588-rock-5b: Enable support for PCIe
 SATA cards
From: Christopher Obbard <chris.obbard@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Eugen Hristev <eugen.hristev@collabora.com>,
 Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, kernel mailing list <kernel@lists.collabora.co.uk>
Date: Wed, 11 Oct 2023 17:57:24 +0100
In-Reply-To: <20231010222344.3436526-3-jonas@kwiboo.se>
References: <20231010222344.3436526-1-jonas@kwiboo.se>
 <20231010222344.3436526-3-jonas@kwiboo.se>
Autocrypt: addr=chris.obbard@collabora.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
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

Hi Jonas,

On Tue, 2023-10-10 at 22:23 +0000, Jonas Karlman wrote:
> Enable support for PCIe SATA cards and the on-board SATA controller.
>=20
> This also revert use of CONFIG_PCI_INIT_R in order to speed up boot from
> eMMC or SD-cards. Standard boot will initialize pci after faster boot
> media have been enumerated.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

With this patch applied, things work perfectly and the boot falls back to b=
ooting from ethernet
just fine. Thank you!

Reviewed-by: Christopher Obbard <chris.obbard@collabora.com>
Tested-by: Christopher Obbard <chris.obbard@collabora.com>

> ---
> Cc: Christopher Obbard <chris.obbard@collabora.com>
> ---
> =C2=A0configs/rock5b-rk3588_defconfig | 6 +++++-
> =C2=A01 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defc=
onfig
> index 447913faccc4..ec22e70033a0 100644
> --- a/configs/rock5b-rk3588_defconfig
> +++ b/configs/rock5b-rk3588_defconfig
> @@ -26,6 +26,7 @@ CONFIG_SPL_SPI=3Dy
> =C2=A0CONFIG_SYS_LOAD_ADDR=3D0xc00800
> =C2=A0CONFIG_PCI=3Dy
> =C2=A0CONFIG_DEBUG_UART=3Dy
> +CONFIG_AHCI=3Dy
> =C2=A0CONFIG_FIT=3Dy
> =C2=A0CONFIG_FIT_VERBOSE=3Dy
> =C2=A0CONFIG_SPL_FIT_SIGNATURE=3Dy
> @@ -35,7 +36,6 @@ CONFIG_OF_BOARD_SETUP=3Dy
> =C2=A0CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3588-rock-5b.dtb"
> =C2=A0# CONFIG_DISPLAY_CPUINFO is not set
> =C2=A0CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> -CONFIG_PCI_INIT_R=3Dy
> =C2=A0CONFIG_SPL_MAX_SIZE=3D0x40000
> =C2=A0CONFIG_SPL_PAD_TO=3D0x7f8000
> =C2=A0CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> @@ -63,6 +63,8 @@ CONFIG_OF_SPL_REMOVE_PROPS=3D"clock-names interrupt-par=
ent assigned-clocks assigne
> =C2=A0CONFIG_SPL_DM_SEQ_ALIAS=3Dy
> =C2=A0CONFIG_SPL_REGMAP=3Dy
> =C2=A0CONFIG_SPL_SYSCON=3Dy
> +CONFIG_AHCI_PCI=3Dy
> +CONFIG_DWC_AHCI=3Dy
> =C2=A0CONFIG_SPL_CLK=3Dy
> =C2=A0# CONFIG_USB_FUNCTION_FASTBOOT is not set
> =C2=A0CONFIG_ROCKCHIP_GPIO=3Dy
> @@ -89,6 +91,8 @@ CONFIG_SPL_PINCTRL=3Dy
> =C2=A0CONFIG_REGULATOR_PWM=3Dy
> =C2=A0CONFIG_PWM_ROCKCHIP=3Dy
> =C2=A0CONFIG_SPL_RAM=3Dy
> +CONFIG_SCSI=3Dy
> +CONFIG_DM_SCSI=3Dy
> =C2=A0CONFIG_BAUDRATE=3D1500000
> =C2=A0CONFIG_DEBUG_UART_SHIFT=3D2
> =C2=A0CONFIG_SYS_NS16550_MEM32=3Dy



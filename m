Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DC4C3DA7F
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 12:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4734088722;
	Sat, 10 Aug 2024 14:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="qcBgjbyX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7003288829; Sat, 10 Aug 2024 14:29:04 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57DA88870B
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 14:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1723292936; x=1723897736; i=frank-w@public-files.de;
 bh=le1UmfV5nwg0hWnbOLIL+QusEjSquzuF5nDkSNp3GyQ=;
 h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
 Content-Type:Date:In-Reply-To:References:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=qcBgjbyX8zERFfiqGMZ3esSrX+/TodMVGK3FkxUnVjJsV/DE3Gv6TxEATbflw9Fq
 7w4gz4VN8ZISlVQLPj1MbVkHMW6KKanQlpkFQ6hpMK+5rOebOWhBKnQlPgQJVU7ZL
 dVDiZACM1mHtZ9zkKGz2xmGHGvAd4UVspC8Gv4lm5KC+x/GtMCZeBmlPFP5hMkjbA
 Ezj884j7ETrT0+PWOJ18xubTX7j0wya/exCouJEzsdPaogBojjbTK6IMN7BcmVZrK
 vdn7wwwqyZfYkqBZyb4fSU4N2e7Q0DACZLHYnGrc1MvsE1b8BT+XB8b0VkXsK9Wkt
 9as+Bx1mCupIsj/wMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.148.248] ([217.61.148.248]) by web-mail.gmx.net
 (3c-app-gmx-bs48.server.lan [172.19.170.101]) (via HTTP); Sat, 10 Aug 2024
 14:28:56 +0200
MIME-Version: 1.0
Message-ID: <trinity-7294f828-ff71-43c4-9847-c5366fd1d1f6-1723292936031@3c-app-gmx-bs48>
From: Frank Wunderlich <frank-w@public-files.de>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: Aw: [PATCH 5/5] clk: mediatek: mt7623: remap peri clock ID and add MUX
Content-Type: text/plain; charset=UTF-8
Date: Sat, 10 Aug 2024 14:28:56 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20240802134511.23608-6-ansuelsmth@gmail.com>
References: <20240802134511.23608-1-ansuelsmth@gmail.com>
 <20240802134511.23608-6-ansuelsmth@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:TAZFcjh2zJn1kkFQjoF6pmrhF+dUQKj8ARb9DjAWHG3jDcTFihsXVPgRcJjbX/hoQQQRt
 i1HAhdlLK2epzjmUWpBTaTjEF5wrIVOpQLTp5yFpovYB7oKdajFqsokM3ggFS2CixfYhwoD4Seem
 RkYkavE4zBAny8F9NN2Lnyza7fSP/fKMI61dNE44Im0I9F3Ffu0uj4JUyJTSSHOLgRfTrgsxrBAo
 a29wWiFLTz3Weh0Wa0KX565dXcULbBCumhOeXnDZ6dLZ1AqG3c88iuSLILJnv1SE7dcynOljMCGc
 u4=
UI-OutboundReport: notjunk:1;M01:P0:uTY17A3uzIs=;OXnu6E8U2DzunpzKsrTa9sd72je
 G4kB1Qt484NO/5FqBY0Otfi9vZak/2tPCbplwJ9qStKcQs2c0V3utpHNOsRj4dCfy8Tve/SCG
 uVkQ/9/E0erAvt1DCeROy6F0kzFODDWhZqJFDhpU6Uv4WrkPm1XPHks/xUF3NPl1TDrr3BjBp
 HB12lRFyrr/gSDcNMyFW6woD0g12oKxNocEyVa2wdRvxnH1fRTn6ffWxBxH2jASjrOLCfNMeZ
 ZPsSErrmwImwnOa3+FxiTh65e+jZcTLsXHAZMo84hopj03wmhx+NbwuyLQMCOCtGHODRbMVSB
 RfFbeEbenFXiJ+4ingRdJzxnAdMzzurIKUZyN6+NlriRm1oyj3siPhWoxhWkb3VNqjsDZszrP
 6og7TZjO2aMPYioLK7QxYVaXRrFYQ0VKngeHbg5Dy+5FFWy9X7r1yrQMHpE89K3o35L743pM9
 cPZlHfXB+VhOXeuLB47xoBIv7SajY28ZACYoEU9O1uveKIklftIM5QufWpRNBSfmDVB7pwS7I
 KXuIhis2iGUpxr6UDEGSLri0KnVZ2W6+VN7DYXZISkodBYGBXjQjE5PM/PAS4/Ogl2hQl9wFd
 qpNaCnTuRujOKi+rrXBX2ARWb4EyDS2lbICl4nkUrdJz0d9Tg5+oWjuJEpXAN1Y/V8gFA37le
 cNsFK6eM7fP2345daAw/4JQwCxCCRHS45DqjBuqpgw==
Content-Transfer-Encoding: quoted-printable
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

does not break downstream dts (still have some issues with ethernet withou=
t the series, which i cannot nail down) so only tested: usb,mmc,pci,sata

also works with upstream dts and a bunch of modifications (i still need to=
 clean)

Tested-by: Frank Wunderlich <frank-w@public-files.de>

regards Frank


> Gesendet: Freitag, 02. August 2024 um 15:45 Uhr
> Von: "Christian Marangi" <ansuelsmth@gmail.com>
> An: "Lukasz Majewski" <lukma@denx.de>, "Sean Anderson" <seanga2@gmail.co=
m>, "Ryder Lee" <ryder.lee@mediatek.com>, "Weijie Gao" <weijie.gao@mediate=
k.com>, "Chunfeng Yun" <chunfeng.yun@mediatek.com>, "GSS_MTK_Uboot_upstrea=
m" <GSS_MTK_Uboot_upstream@mediatek.com>, "Tom Rini" <trini@konsulko.com>,=
 "Christian Marangi" <ansuelsmth@gmail.com>, u-boot@lists.denx.de
> Betreff: [PATCH 5/5] clk: mediatek: mt7623: remap peri clock ID and add =
MUX
>
> Upstream kernel linux makes use of peri clock MUX to setup UART.
>
> Add definition for these and add remap table as in the upstream clock ID
> order gates are before MUX but we require MUX first and then clocks in
> our downstream driver.
>
> Convert the peri clk tree to MUX + GATE implementation.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/clk/mediatek/clk-mt7623.c | 83 +++++++++++++++++++++++++++++--
>  1 file changed, 80 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/cl=
k-mt7623.c
> index 78e390d49f8..d0b80f48b0a 100644
> --- a/drivers/clk/mediatek/clk-mt7623.c
> +++ b/drivers/clk/mediatek/clk-mt7623.c
> @@ -807,6 +807,74 @@ static const struct mtk_gate infra_cgs[] =3D {
>  };
>
>  /* pericfg */
> +static const int peri_id_offs_map[] =3D {
> +	/* MUX CLK */
> +	[CLK_PERI_UART0_SEL]			=3D 1,
> +	[CLK_PERI_UART1_SEL]			=3D 2,
> +	[CLK_PERI_UART2_SEL]			=3D 3,
> +	[CLK_PERI_UART3_SEL]			=3D 4,
> +	/* GATE CLK */
> +	[CLK_PERI_NFI]				=3D 5,
> +	[CLK_PERI_THERM]			=3D 6,
> +	[CLK_PERI_PWM1]				=3D 7,
> +	[CLK_PERI_PWM2]				=3D 8,
> +	[CLK_PERI_PWM3]				=3D 9,
> +	[CLK_PERI_PWM4]				=3D 10,
> +	[CLK_PERI_PWM5]				=3D 11,
> +	[CLK_PERI_PWM6]				=3D 12,
> +	[CLK_PERI_PWM7]				=3D 13,
> +	[CLK_PERI_PWM]				=3D 14,
> +	[CLK_PERI_USB0]				=3D 15,
> +	[CLK_PERI_USB1]				=3D 16,
> +	[CLK_PERI_AP_DMA]			=3D 17,
> +	[CLK_PERI_MSDC30_0]			=3D 18,
> +	[CLK_PERI_MSDC30_1]			=3D 19,
> +	[CLK_PERI_MSDC30_2]			=3D 20,
> +	[CLK_PERI_MSDC30_3]			=3D 21,
> +	[CLK_PERI_MSDC50_3]			=3D 22,
> +	[CLK_PERI_NLI]				=3D 23,
> +	[CLK_PERI_UART0]			=3D 24,
> +	[CLK_PERI_UART1]			=3D 25,
> +	[CLK_PERI_UART2]			=3D 26,
> +	[CLK_PERI_UART3]			=3D 27,
> +	[CLK_PERI_BTIF]				=3D 28,
> +	[CLK_PERI_I2C0]				=3D 29,
> +	[CLK_PERI_I2C1]				=3D 30,
> +	[CLK_PERI_I2C2]				=3D 31,
> +	[CLK_PERI_I2C3]				=3D 32,
> +	[CLK_PERI_AUXADC]			=3D 33,
> +	[CLK_PERI_SPI0]				=3D 34,
> +	[CLK_PERI_ETH]				=3D 35,
> +	[CLK_PERI_USB0_MCU]			=3D 36,
> +	[CLK_PERI_USB1_MCU]			=3D 37,
> +	[CLK_PERI_USB_SLV]			=3D 38,
> +	[CLK_PERI_GCPU]				=3D 39,
> +	[CLK_PERI_NFI_ECC]			=3D 40,
> +	[CLK_PERI_NFI_PAD]			=3D 41,
> +	[CLK_PERI_FLASH]			=3D 42,
> +	[CLK_PERI_HOST89_INT]			=3D 43,
> +	[CLK_PERI_HOST89_SPI]			=3D 44,
> +	[CLK_PERI_HOST89_DVD]			=3D 45,
> +	[CLK_PERI_SPI1]				=3D 46,
> +	[CLK_PERI_SPI2]				=3D 47,
> +	[CLK_PERI_FCI]				=3D 48,
> +};
> +
> +#define TOP_PARENT(_id) PARENT(_id, CLK_PARENT_TOPCKGEN)
> +#define XTAL_PARENT(_id) PARENT(_id, CLK_PARENT_XTAL)
> +
> +static const struct mtk_parent uart_ck_sel_parents[] =3D {
> +	XTAL_PARENT(CLK_XTAL),
> +	TOP_PARENT(CLK_TOP_UART_SEL),
> +};
> +
> +static const struct mtk_composite peri_muxes[] =3D {
> +	MUX_MIXED(CLK_PERI_UART0_SEL, uart_ck_sel_parents, 0x40C, 0, 1),
> +	MUX_MIXED(CLK_PERI_UART1_SEL, uart_ck_sel_parents, 0x40C, 1, 1),
> +	MUX_MIXED(CLK_PERI_UART2_SEL, uart_ck_sel_parents, 0x40C, 2, 1),
> +	MUX_MIXED(CLK_PERI_UART3_SEL, uart_ck_sel_parents, 0x40C, 3, 1),
> +};
> +
>  static const struct mtk_gate_regs peri0_cg_regs =3D {
>  	.set_ofs =3D 0x8,
>  	.clr_ofs =3D 0x10,
> @@ -980,6 +1048,7 @@ static int mt7623_topckgen_probe(struct udevice *de=
v)
>  static const struct mtk_clk_tree mt7623_clk_gate_tree =3D {
>  	/* Each CLK ID for gates clock starts at index 1 */
>  	.gates_offs =3D 1,
> +	.xtal_rate =3D 26 * MHZ,
>  };
>
>  static int mt7623_infracfg_probe(struct udevice *dev)
> @@ -988,10 +1057,18 @@ static int mt7623_infracfg_probe(struct udevice *=
dev)
>  					infra_cgs);
>  }
>
> +static const struct mtk_clk_tree mt7623_clk_peri_tree =3D {
> +	.id_offs_map =3D peri_id_offs_map,
> +	.muxes_offs =3D peri_id_offs_map[CLK_PERI_UART0_SEL],
> +	.gates_offs =3D peri_id_offs_map[CLK_PERI_NFI],
> +	.muxes =3D peri_muxes,
> +	.gates =3D peri_cgs,
> +	.xtal_rate =3D 26 * MHZ,
> +};
> +
>  static int mt7623_pericfg_probe(struct udevice *dev)
>  {
> -	return mtk_common_clk_gate_init(dev, &mt7623_clk_gate_tree,
> -					peri_cgs);
> +	return mtk_common_clk_infrasys_init(dev, &mt7623_clk_peri_tree);
>  }
>
>  static int mt7623_hifsys_probe(struct udevice *dev)
> @@ -1098,7 +1175,7 @@ U_BOOT_DRIVER(mtk_clk_pericfg) =3D {
>  	.of_match =3D mt7623_pericfg_compat,
>  	.probe =3D mt7623_pericfg_probe,
>  	.priv_auto	=3D sizeof(struct mtk_cg_priv),
> -	.ops =3D &mtk_clk_gate_ops,
> +	.ops =3D &mtk_clk_infrasys_ops,
>  	.flags =3D DM_FLAG_PRE_RELOC,
>  };
>
> --
> 2.45.2
>
>

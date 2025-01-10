Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DC2E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 17:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91E4C800D0;
	Fri, 10 Jan 2025 18:35:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ziswiler.com header.i=marcel@ziswiler.com header.b="omMwPfLc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2281801F5; Fri, 10 Jan 2025 18:35:32 +0100 (CET)
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AD5580050
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 18:35:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel@ziswiler.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziswiler.com;
 s=s1-ionos; t=1736530480; x=1737135280; i=marcel@ziswiler.com;
 bh=nZ9IMOd8ZCpKnzl1BnLT0tDloVNiSxqvntyJLFGQOx8=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=omMwPfLcFZEV/kCv+6gnIXR2BN2QOt78E3W08PSaYnEjP/pdT3zZu56AK56KAsul
 Io7n7xN6CVeOFjB9cc5vnWEcZKnvoPylPzYMRGCB0zw58lKm1oZS+QUpjVBPICPEH
 H7JPhMPZ4uYjmjU282L0/xoKRJuw9WB6vHn5+h4o4c5dh/8snsL4usE47zTq4yh/Z
 82PzdbeiEH/hGbo/kIoIP7MLq5VSls/YjE4D/iG0nVol1UKGAVK+/1fODfbTDyAdI
 RvDH9GBW5XNjPqEHs7DqST0CVDj+54KO2N3eGnF6VDGYPStoZS5bxbSE4BSIOPlNq
 +kUzqNcb3GnkCfQcYg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.217.253] ([213.55.187.66]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MeyiN-1tu8Nd0qZF-00R2i0; 
 Fri, 10 Jan 2025 18:34:40 +0100
Message-ID: <49db8b2b0a7c261165c9ff1f38510734b556c95e.camel@ziswiler.com>
Subject: Re: [PATCH] riscv: spacemit: k1: probe dram size during boot phase.
From: Marcel Ziswiler <marcel@ziswiler.com>
To: Huan Zhou <me@per1cycle.org>, u-boot@lists.denx.de
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Bin Meng <bmeng@tinylab.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, Yixun Lan <dlan@gentoo.org>, Frieder
 Schrempf	 <frieder.schrempf@kontron.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>,  Jonas =?ISO-8859-1?Q?Schw=F6bel?=	
 <jonasschwoebel@yahoo.de>, Kever Yang <kever.yang@rock-chips.com>, Leo	
 <ycliang@andestech.com>, Michal Simek <michal.simek@amd.com>, Nishanth
 Menon	 <nm@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>, Randolph	
 <randolph@andestech.com>, Rick Chen <rick@andestech.com>, Samuel Holland	
 <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, Yu Chien Peter Lin	
 <peterlin@andestech.com>, Huan Zhou <pericycle.cc@gmail.com>, Kongyang Liu	
 <seashell11234455@gmail.com>, Padmarao Begari <padmarao.begari@amd.com>
Date: Fri, 10 Jan 2025 18:34:30 +0100
In-Reply-To: <20250108-get-dram-size-v1-1-4bae32ecf756@per1cycle.org>
References: <20250108-get-dram-size-v1-1-4bae32ecf756@per1cycle.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (by Flathub.org) 
MIME-Version: 1.0
X-Provags-ID: V03:K1:dNaGBrHfwo5Y//yYyKqsi9Co7hdA5+4+UVj/a2+59Ds8dDIrY4A
 Yps4PWkJF3M2a6wxH2f7g/77f0B+V6m8OkwCXq/648WC9c/RVdJIXPDu9+W+jiTXR0cLOdb
 fPsOYvf33qjeWtmUD6vOQRScsQTpn10bsWWiV6fEER0lNhcjKJnbR0BrEjrMzXNNyPfvYsd
 OUzlKSITWzOymTJ6NJYTg==
UI-OutboundReport: notjunk:1;M01:P0:rxuFoDRscKc=;g5cV5vYBW7DuXpJwfvHuc2B7t9t
 ADqVSEnT5own5SgtNW5KLbv+8/I5JBTa2ZOD0TxSbUCulaherP+U/hNZUCtzJt6bM8D21RUTP
 oJOROQ2czRxF1MJuI8bzR+m2SE1y5WOqz+QKshBOqQeWqDm6NILanFNaGxRijZO0v910Xu5CM
 akURwzuyZvmxPusjXBAcB0vqKNqELTBiI/4+EdQZ7oVYZSGFqsArqp2O1RZdpxdHCkUpRu/GJ
 ruL/76nW9cHZR3hojDKnJivZMCBu5F5upe0zY3lSvJ1rpp2ulYtjc8GvhiMLV84czCBuxzwMy
 Jx5WI3ILLtFyBmMUDjHfBHTxwEJln8slA4q+WSscg1mMnC9P+6oRdqrVwbKMI7U2kanxHP3xS
 GN0v/LvI+oXLHj7xbj56zGYA9gELKVKfWlpV53WO4KZcD3mS7qQx7JNWINQGdg74ecK8Jo+Xl
 FuMRJrtpsNKw6dodV1vutSW3LA1R/qD8R7sngxmxQ0bNgv0PZlqjNhRTDfsFaS05LfZbLtbP9
 j5rrsfdNqOO9w3bu96ZVyc+8yJHSKnjJCvstYje8E/my2wrBQ/v5ImePZZOCSrpF3Yt411UO5
 AdUJVeDA/FnZQ6hTncTYL/8ybkJ34FcwgOLs4aZATnQIwpFoj3E880fAVRsCEqo9ed3ptxaSP
 +ESPnpW/rMrCMyOMUjpciqxKwQvfvWJhDbv7H9MVQIF3SxIkRnMz9C5rqWGrwgEkGDC/Dsm6r
 LdBj4cflvrTo16UJyUhKx3iVoROW+29xoWhWlYmljA9Bo2EfP3yBi/U1MJeDzT9kyMQp7ayaL
 rcTQy38hS33cuyezL06Do6n4oO2xChtZubgbV0IlA4xmNjpdmcZXvmELWbWB2COiayvjF4Cr9
 wEZiP9bFY2LJnAI7WProJmorKgAMePLcYPZTOZYI/fXKkhytjytmNcMtC6o9+rcHfzfSD577K
 e0dmpVD+HKugpiG/QSHA7Ck4LA5wnkybEz/vhwRyVBzTldFOMeJ9GNJJkVkHbldAy1D0ohl+s
 Injo/3kB319uuaPtsIrsITwBnRcSvnWgXRx5XU1
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

Hi Huan Zhou

Thanks!

On Wed, 2025-01-08 at 16:49 +0800, Huan Zhou wrote:
>=20
> ---
> This patch introduce improvement for get dram size on bananapi BPI-F3,
> retrieving the dram size dynamically.
> Have tested on bananapi BPIF3 4G and jupiter 8G.
>=20
> Signed-off-by: Huan Zhou <me@per1cycle.org>

Tested-by: Marcel Ziswiler <marcel@ziswiler.com> # BPI-F3 16G

> ---
> =C2=A0arch/riscv/cpu/k1/dram.c | 40 +++++++++++++++++++++++++++++++++++++=
+--
> =C2=A01 file changed, 38 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/riscv/cpu/k1/dram.c b/arch/riscv/cpu/k1/dram.c
> index c477c15cbfb19f0e3a0ee72985b602f5bda352d7..095217f2a4c053f7477d62c07=
76bcb51e623db47 100644
> --- a/arch/riscv/cpu/k1/dram.c
> +++ b/arch/riscv/cpu/k1/dram.c
> @@ -4,17 +4,53 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#include <asm/global_data.h>
> +#include <asm/io.h>
> =C2=A0#include <config.h>
> +#include <bitfield.h>
> =C2=A0#include <fdt_support.h>
> =C2=A0#include <linux/sizes.h>
> =C2=A0
> +#define DDR_BASE 0xC0000000
> =C2=A0DECLARE_GLOBAL_DATA_PTR;
> =C2=A0
> +static inline u32 map_format_size(u32 val)
> +{
> +	u32 tmp;
> +
> +	if (val & 0x1 =3D=3D 0)
> +		return 0;
> +
> +	tmp =3D bitfield_extract(val, 16, 5);
> +	switch (tmp) {
> +	case 0xd:
> +		return 512;
> +	case 0xe:
> +		return 1024;
> +	case 0xf:
> +		return 2048;
> +	case 0x10:
> +		return 4096;
> +	case 0x11:
> +		return 8192;
> +	default:
> +		pr_info("Invalid DRAM density %x\n", val);
> +		return 0;
> +	}
> +}
> +
> +u32 ddr_get_density(void)
> +{
> +	u32 cs0_size =3D map_format_size(readl((void *)DDR_BASE + 0x200));
> +	u32 cs1_size =3D map_format_size(readl((void *)DDR_BASE + 0x208));
> +	u32 ddr_size =3D cs0_size + cs1_size;
> +
> +	return ddr_size;
> +}
> +
> =C2=A0int dram_init(void)
> =C2=A0{
> =C2=A0	gd->ram_base =3D CFG_SYS_SDRAM_BASE;
> -	/* TODO get ram size from ddr controller */
> -	gd->ram_size =3D SZ_4G;
> +	gd->ram_size =3D (u64)ddr_get_density() * SZ_1M;
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
>=20
> ---
> base-commit: 19fc0b7f7d907119a13e9c207991899f0817f8fc
> change-id: 20250108-get-dram-size-65cf59a15201
>=20
> Best regards,
> --
> Huan Zhou <me@per1cycle.org>

Cheers

Marcel

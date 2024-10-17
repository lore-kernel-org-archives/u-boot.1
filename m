Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68920D21267
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 09:19:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73A2088EBA;
	Thu, 17 Oct 2024 11:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F51288EF7; Thu, 17 Oct 2024 11:19:44 +0200 (CEST)
Received: from smtprelay02.ispgateway.de (smtprelay02.ispgateway.de
 [80.67.31.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6048188E36
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 11:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=LW@KARO-electronics.de
Received: from [89.1.81.74] (helo=karo-electronics.de)
 by smtprelay02.ispgateway.de with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98)
 (envelope-from <LW@KARO-electronics.de>) id 1t1MfT-000000006Df-3JMA;
 Thu, 17 Oct 2024 11:19:39 +0200
Date: Thu, 17 Oct 2024 11:19:36 +0200
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 trini@konsulko.com, uboot-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] cpu: imx8_cpu: Avoid revision to corrupt device tree
Message-ID: <20241017111936.6688fce9@karo-electronics.de>
In-Reply-To: <20241017081236.26742-1-peng.fan@oss.nxp.com>
References: <20241017081236.26742-1-peng.fan@oss.nxp.com>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kb21haW5mYWN0b3J5LWt1bmRlLmRl
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

On Thu, 17 Oct 2024 16:12:36 +0800 Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> U-Boot device tree is padded just after U-Boot proper.
> After the whole stuff loaded to DRAM space, the device tree
> area is conflict with BSS region before U-Boot relocation.
>=20
> So any write to BSS area before reloc_fdt will corrupt the
> device tree. Without the fix, there is issue that =E2=80=9Cbinman_init
> failed:-2=E2=80=9D on i.MX8MP-EVK board.
>=20
Placing the 'revision' variable into the 'data' section would achieve
the same goal without any further code change:
static char revision[4] __section(".data");

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>=20
> V2:
>  move the rev to malloc area in cpu_imx_plat
>  tested on i.MX8MP EVK
>=20
>  drivers/cpu/imx8_cpu.c | 35 ++++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
> index 6c0a8c0cbe4..b11f8dc0c91 100644
> --- a/drivers/cpu/imx8_cpu.c
> +++ b/drivers/cpu/imx8_cpu.c
> @@ -20,10 +20,11 @@
> =20
>  DECLARE_GLOBAL_DATA_PTR;
> =20
> +#define IMX_REV_LEN	4
>  struct cpu_imx_plat {
>  	const char *name;
> -	const char *rev;
>  	const char *type;
> +	char rev[IMX_REV_LEN];
>  	u32 cpu_rsrc;
>  	u32 cpurev;
>  	u32 freq_mhz;
> @@ -69,28 +70,32 @@ static const char *get_imx_type_str(u32 imxtype)
>  	}
>  }
> =20
> -static const char *get_imx_rev_str(u32 rev)
> +static void get_imx_rev_str(struct cpu_imx_plat *plat, u32 rev)
>  {
> -	static char revision[4];
> -
>  	if (IS_ENABLED(CONFIG_IMX8)) {
> +		char rev;
> +
>  		switch (rev) {
>  		case CHIP_REV_A:
> -			return "A";
> +			rev =3D 'A';
> +			break;
>  		case CHIP_REV_B:
> -			return "B";
> +			rev =3D 'B';
> +			break;
>  		case CHIP_REV_C:
> -			return "C";
> +			rev =3D 'C';
> +			break;
>  		default:
> -			return "?";
> +			rev =3D '?';
> +			break;
>  		}
> +		plat->rev[0] =3D rev;
> +		plat->rev[1] =3D '\0';
>  	} else {
> -		revision[0] =3D '1' + (((rev & 0xf0) - CHIP_REV_1_0) >> 4);
> -		revision[1] =3D '.';
> -		revision[2] =3D '0' + (rev & 0xf);
> -		revision[3] =3D '\0';
> -
> -		return revision;
> +		plat->rev[0] =3D '1' + (((rev & 0xf0) - CHIP_REV_1_0) >> 4);
> +		plat->rev[1] =3D '.';
> +		plat->rev[2] =3D '0' + (rev & 0xf);
> +		plat->rev[3] =3D '\0';
>  	}
>  }
> =20
> @@ -318,7 +323,7 @@ static int imx_cpu_probe(struct udevice *dev)
>  	set_core_data(dev);
>  	cpurev =3D get_cpu_rev();
>  	plat->cpurev =3D cpurev;
> -	plat->rev =3D get_imx_rev_str(cpurev & 0xFFF);
> +	get_imx_rev_str(plat, cpurev & 0xFFF);
>  	plat->type =3D get_imx_type_str((cpurev & 0x1FF000) >> 12);
>  	plat->freq_mhz =3D imx_get_cpu_rate(dev) / 1000000;
>  	plat->mpidr =3D dev_read_addr(dev);


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________

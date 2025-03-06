Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD5BC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 05:42:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1B41808A2;
	Thu,  6 Mar 2025 06:42:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C43280F9E; Thu,  6 Mar 2025 06:42:02 +0100 (CET)
Received: from dd54918.kasserver.com (dd54918.kasserver.com [85.13.167.58])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A3C680805
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 06:42:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=LW@KARO-electronics.de
Received: from karo-electronics.de (unknown [89.1.81.74])
 by dd54918.kasserver.com (Postfix) with ESMTPSA id 6DD5B772172F;
 Thu,  6 Mar 2025 06:41:59 +0100 (CET)
Date: Thu, 6 Mar 2025 06:41:58 +0100
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Stefano Babic
 <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot
 Team" <uboot-imx@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, marex@denx.de, u-boot@lists.denx.de, Peng
 Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v7 10/19] imx9: scmi: add i.MX95 SoC and clock related code
Message-ID: <20250306064158.4d7d708b@karo-electronics.de>
In-Reply-To: <20250305-imx95-v1-10-286d15acbb8a@oss.nxp.com>
References: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
 <20250305-imx95-v1-10-286d15acbb8a@oss.nxp.com>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ---
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

On Wed, 05 Mar 2025 21:28:22 +0800 Alice Guo (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> This patch adds i.MX95 SoC and clock related code. Because they are
> based on SCMI, put them in the scmi subfolder.
>=20
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/include/asm/arch-imx/cpu.h        |   2 +
>  arch/arm/include/asm/arch-imx9/clock.h     |  10 +
>  arch/arm/include/asm/arch-imx9/imx-regs.h  |   5 +
>  arch/arm/include/asm/arch-imx9/sys_proto.h |   1 +
>  arch/arm/include/asm/mach-imx/sys_proto.h  |  39 ++
>  arch/arm/mach-imx/imx9/scmi/Makefile       |   6 +
>  arch/arm/mach-imx/imx9/scmi/clock.c        | 105 ++++
>  arch/arm/mach-imx/imx9/scmi/clock_scmi.c   | 133 +++++
>  arch/arm/mach-imx/imx9/scmi/soc.c          | 788 +++++++++++++++++++++++=
++++++
>  arch/sandbox/include/asm/scmi_test.h       |   2 +-
>  10 files changed, 1090 insertions(+), 1 deletion(-)
>=20
[...]
> diff --git a/arch/arm/mach-imx/imx9/scmi/clock.c
b/arch/arm/mach-imx/imx9/scmi/clock.c
> new file mode 100644
> index 0000000000..9ebd380976
> --- /dev/null
> +++ b/arch/arm/mach-imx/imx9/scmi/clock.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#include <asm/arch/clock.h>
> +#include <dm/uclass.h>
> +#include <scmi_agent.h>
> +#include "../../../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
>
"Interesting" include path...
Shouldn't this file be located under dts/upstream/include/dt-bindings/
like all the other imx*-clock.h files?
Then the file should be picked up via
#include <dt-bindings/imx95-clock.h>

> +#define UNLOCK_WORD 0xD928C520 /* unlock word */
> +#define REFRESH_WORD 0xB480A602 /* refresh word */
>
useless comments.

> +static void disable_wdog(void __iomem *wdog_base)
> +{
> +	u32 val_cs =3D readl(wdog_base + 0x00);
> +
> +	if (!(val_cs & 0x80))
> +		return;
> +
> +	/* default is 32bits cmd */
> +	writel(REFRESH_WORD, (wdog_base + 0x04)); /* Refresh the CNT */
> +
> +	if (!(val_cs & 0x800)) {
> +		writel(UNLOCK_WORD, (wdog_base + 0x04));
> +		while (!(readl(wdog_base + 0x00) & 0x800))
> +			;
> +	}
> +	writel(0x0, (wdog_base + 0x0C)); /* Set WIN to 0 */
> +	writel(0x400, (wdog_base + 0x08)); /* Set timeout to default 0x400 */
> +	writel(0x2120, (wdog_base + 0x00)); /* Disable it and set update */
> +
> +	while (!(readl(wdog_base + 0x00) & 0x400))
> +		;
>
indefinite loops polling hardware bits will lead to silent hangs when
the hardware misbehaves.

[...]
> +void imx_get_mac_from_fuse(int dev_id, unsigned char *mac)
> +{
> +	u32 val[2] =3D {};
> +	int ret;
> +
> +	if (dev_id =3D=3D 0) {
> +		ret =3D fuse_read(39, 3, &val[0]);
> +		if (ret)
> +			goto err;
> +
> +		ret =3D fuse_read(39, 4, &val[1]);
> +		if (ret)
> +			goto err;
> +
> +		mac[0] =3D val[1] >> 8;
> +		mac[1] =3D val[1];
> +		mac[2] =3D val[0] >> 24;
> +		mac[3] =3D val[0] >> 16;
> +		mac[4] =3D val[0] >> 8;
> +		mac[5] =3D val[0];
> +
> +	} else {
> +		ret =3D fuse_read(39, 5, &val[0]);
> +		if (ret)
> +			goto err;
> +
> +		ret =3D fuse_read(39, 4, &val[1]);
> +		if (ret)
> +			goto err;
> +
> +		if (is_soc_rev(CHIP_REV_1_0)) {
> +			mac[0] =3D val[1] >> 24;
> +			mac[1] =3D val[1] >> 16;
> +			mac[2] =3D val[0] >> 24;
> +			mac[3] =3D val[0] >> 16;
> +			mac[4] =3D val[0] >> 8;
> +			mac[5] =3D val[0];
> +		} else {
> +			mac[0] =3D val[0] >> 24;
> +			mac[1] =3D val[0] >> 16;
> +			mac[2] =3D val[0] >> 8;
> +			mac[3] =3D val[0];
> +			mac[4] =3D val[1] >> 24;
> +			mac[5] =3D val[1] >> 16;
> +		}
> +	}
> +
> +	debug("%s: MAC%d: %02x.%02x.%02x.%02x.%02x.%02x\n",
> +	      __func__, dev_id, mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
>
The format "%pM" exists for printing MAC addresses.

[...]
> +int print_cpuinfo(void)
> +{
> +	u32 cpurev, max_freq;
> +	int minc, maxc;
> +
> +	cpurev =3D get_cpu_rev();
> +
> +	printf("CPU:   i.MX%s rev%d.%d",
> +	       get_imx_type((cpurev & 0x1FF000) >> 12),
> +	       (cpurev & 0x000F0) >> 4, (cpurev & 0x0000F) >> 0);
> +
> +	max_freq =3D get_cpu_speed_grade_hz();
> +	if (!max_freq || max_freq =3D=3D mxc_get_clock(MXC_ARM_CLK)) {
> +		printf(" at %dMHz\n", mxc_get_clock(MXC_ARM_CLK) / 1000000);
> +	} else {
> +		printf(" %d MHz (running at %d MHz)\n", max_freq / 1000000,
> +		       mxc_get_clock(MXC_ARM_CLK) / 1000000);
>
"%u" to match the data types.

[...]
> +enum env_location env_get_location(enum env_operation op, int prio)
> +{
>
should be declared as __weak to give others the chance to override this
function in board specific code.



Lothar Wa=C3=9Fmann

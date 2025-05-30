Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95D8C5B549
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 09:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B55882A9E;
	Fri, 30 May 2025 11:38:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e61bBLdI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1457882BB5; Fri, 30 May 2025 11:38:10 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AADE582998
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 11:38:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id AE98FA4CCCC;
 Fri, 30 May 2025 09:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18122C4CEE9;
 Fri, 30 May 2025 09:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748597886;
 bh=yLS6jGJ8Rj709UocysZt0OxTv8RjpEtNjZOreNpfOEA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=e61bBLdI0DZXtLGCsrbmG77kVxxEVzUGsgBaFtjRqAt68nS1a+CHQadPIbA621+Ko
 LNfiD/tloaXIpRntp0AEG2SWVf1Hxz9N4xTHZoHuvyW6sxIPOxxeXW2aEXk1KgB9Ga
 QNSOlkmNVeZ+kX2xLE+MQ5mFYhtwuyAwgUyXVfYU5GMioX8Tf+MeYJiAdkpoUoi1l4
 SV6tq3ZnevHSIqhgmzNpfsWTbqiLHU+khflbjrhFMqxvT4LKVKgfNaFbJKaLD8iN+A
 NXT57Gd8KttTqVlf/dih87HCu6VruCQRxSwkOonls8x4C0Xw8Wjx1uJYswuCvIKOtw
 H09aCAG1dV3bg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Shmuel Melamud via B4 Relay <devnull+smelamud.redhat.com@kernel.org>,
 Tom Rini <trini@konsulko.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Stefan Roese
 <sr@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Shmuel Leib Melamud <smelamud@redhat.com>
Subject: Re: [PATCH v2] renesas: Renesas R-Car Gen4 watchdog driver
In-Reply-To: <20250530-us-renesas-watchdog-v2-1-b0d8f96c64dc@redhat.com>
References: <20250530-us-renesas-watchdog-v2-1-b0d8f96c64dc@redhat.com>
Date: Fri, 30 May 2025 11:38:04 +0200
Message-ID: <87h612phfn.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Shmuel,

Thank you for the patch.

On ven., mai 30, 2025 at 01:58, Shmuel Melamud via B4 Relay <devnull+smelam=
ud.redhat.com@kernel.org> wrote:

> From: Shmuel Melamud <smelamud@redhat.com>
>
> Add support of Renesas R-Car Gen4 watchdog timer. Timeouts up to
> 8184.0s are supported (CKS1 register is not involved). The watchdog
> uses the clock type CLK_TYPE_GEN4_MDSEL, so handling of this constant
> is added to gen3_clk_get_rate64() function.

Since the driver is based on the linux driver, could you include a
commit HASH from linux on which this has been based.

An example commit in U-Boot:
commit 20f1383bad59 ("mtd: spi-nor: Call spi_nor_post_sfdp_fixups() only af=
ter spi_nor_parse_sfdp()")

Something alongs the lines of:

This driver is based on upstream linux commit:
<sha>(<"title">)

>
> The timeout is set in
> dts/upstream/src/arm64/renesas/r8a779f0-spider-cpu.dtsi section &rwdt.
>
> This patch was tested on real Renesas R8A779F0 hardware. If the watchdog
> driver is enabled at the build time, the watchdog timer is initialized
> when U-Boot starts. Under normal circumstances, U-Boot loads the kernel,
> it starts systemd and systemd continues to pet the watchdog. If systemd
> is not started before the timeout expires, the watchdog resets the
> board.
>
> Signed-off-by: Shmuel Leib Melamud <smelamud@redhat.com>

=E2=97=8F checkpatch.pl: 293: WARNING: From:/Signed-off-by: email name mism=
atch: 'From: Shmuel Melamud <smelamud@redhat.com>' !=3D 'Signed-off-by: Shm=
uel Leib Melamud <smelamud@redhat.com>'

Could you fix that if you send another version?

> ---
>  drivers/clk/renesas/clk-rcar-gen3.c |   4 +-
>  drivers/watchdog/Kconfig            |   8 ++
>  drivers/watchdog/Makefile           |   1 +
>  drivers/watchdog/renesas_wdt.c      | 172 ++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 184 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/renesas/clk-rcar-gen3.c b/drivers/clk/renesas/cl=
k-rcar-gen3.c
> index 375cc4a4930873ad0d5509c19ad04a0ea5545aa0..5745acf4023c9114f6fa13b5e=
4baa306c5b57d33 100644
> --- a/drivers/clk/renesas/clk-rcar-gen3.c
> +++ b/drivers/clk/renesas/clk-rcar-gen3.c
> @@ -68,7 +68,7 @@ static int gen3_clk_get_parent(struct gen3_clk_priv *pr=
iv, struct clk *clk,
>  		if (ret)
>  			return ret;
>=20=20
> -		if (core->type =3D=3D CLK_TYPE_GEN3_MDSEL) {
> +		if (core->type =3D=3D CLK_TYPE_GEN3_MDSEL || core->type =3D=3D CLK_TYP=
E_GEN4_MDSEL) {
>  			shift =3D priv->cpg_mode & BIT(core->offset) ? 0 : 16;
>  			parent->dev =3D clk->dev;
>  			parent->id =3D core->parent >> shift;
> @@ -318,6 +318,8 @@ static u64 gen3_clk_get_rate64(struct clk *clk)
>  						"FIXED");
>=20=20
>  	case CLK_TYPE_GEN3_MDSEL:
> +		fallthrough;
> +	case CLK_TYPE_GEN4_MDSEL:
>  		shift =3D priv->cpg_mode & BIT(core->offset) ? 0 : 16;
>  		div =3D (core->div >> shift) & 0xffff;
>  		rate =3D gen3_clk_get_rate64(&parent) / div;
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 1bb67f5035231df9f6ce01adb08d074855393143..a0f2948335f9c3b74b7823f03=
9e578ff4030e97c 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -335,6 +335,14 @@ config WDT_K3_RTI_FW_FILE
>=20=20
>  endif
>=20=20
> +config WDT_RENESAS
> +	bool "Renesas watchdog timer support"
> +	depends on WDT && R8A779F0
> +	select CLK
> +	select CLK_RENESAS
> +	help
> +	  Enables Renesas SoC R8A779F0 watchdog timer support.
> +
>  config WDT_SANDBOX
>  	bool "Enable Watchdog Timer support for Sandbox"
>  	depends on SANDBOX && WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index e6bd4c587af6133c405dde6dbada8050debc781c..c4467d6e126d0c3e119bf8014=
b302e5b1432f541 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_WDT_MTK) +=3D mtk_wdt.o
>  obj-$(CONFIG_WDT_NPCM) +=3D npcm_wdt.o
>  obj-$(CONFIG_WDT_OCTEONTX) +=3D octeontx_wdt.o
>  obj-$(CONFIG_WDT_OMAP3) +=3D omap_wdt.o
> +obj-$(CONFIG_WDT_RENESAS) +=3D renesas_wdt.o
>  obj-$(CONFIG_WDT_SBSA) +=3D sbsa_gwdt.o
>  obj-$(CONFIG_WDT_K3_RTI) +=3D rti_wdt.o
>  obj-$(CONFIG_WDT_SIEMENS_PMIC) +=3D siemens_pmic_wdt.o
> diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wd=
t.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..97550794a2e7108ee63aa0011=
f55c8c0fa77adb9
> --- /dev/null
> +++ b/drivers/watchdog/renesas_wdt.c
> @@ -0,0 +1,172 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright 2025 Red Hat, Inc., Shmuel Leib Melamud <smelamud@redhat.co=
m>
> +
> +#include <clk.h>
> +#include <dm.h>
> +#include <wdt.h>
> +#include <asm/io.h>
> +#include <dm/device_compat.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +
> +#define usleep_range(a, b) udelay((b))
> +
> +struct renesas_wdt {
> +	u32 cnt;
> +	u32 csra;
> +	u32 csrb;
> +};
> +
> +#define RWTCSRA_WOVF	BIT(4)
> +#define RWTCSRA_WRFLG	BIT(5)
> +#define RWTCSRA_TME		BIT(7)
> +
> +#define CSR_MASK	0xA5A5A500
> +#define CNT_MASK	0x5A5A0000
> +
> +/*
> + * In probe, clk_rate is checked to be not more than 16 bit * biggest cl=
ock
> + * divider (12 bits). d is only a factor to fully utilize the WDT counte=
r and
> + * will not exceed its 16 bits. Thus, no overflow, we stay below 32 bits.
> + */
> +#define MUL_BY_CLKS_PER_SEC(p, d) \
> +	DIV_ROUND_UP((d) * (p)->clk_rate, clk_divs[(p)->cks])
> +
> +/* d is 16 bit, clk_divs 12 bit -> no 32 bit overflow */
> +#define DIV_BY_CLKS_PER_SEC(p, d) ((d) * clk_divs[(p)->cks] / (p)->clk_r=
ate)
> +
> +static const unsigned int clk_divs[] =3D { 1, 4, 16, 32, 64, 128, 1024, =
4096 };
> +
> +struct renesas_wdt_priv {

Any reason for this to be named renesas_wdt_wriv (and not rwdt_priv like
done in the linux driver) ?

I'm asking this because having differences between upstream linux driver
and U-Boot driver makes long-term maintenance harder.

> +	struct renesas_wdt __iomem *wdt;
> +	unsigned long clk_rate;
> +	u8 cks;
> +	struct clk clk;
> +};
> +
> +static void rwdt_wait_cycles(struct renesas_wdt_priv *priv, unsigned int=
 cycles)
> +{
> +	unsigned int delay;
> +
> +	delay =3D DIV_ROUND_UP(cycles * 1000000, priv->clk_rate);
> +
> +	usleep_range(delay, 2 * delay);
> +}
> +
> +static int renesas_wdt_start(struct udevice *dev, u64 timeout, ulong fla=
gs)

Same goes for this function, and all function prefixes. Why renesas_wdt_
instead of rwdt_ ?
Especially since in the previous function we used rwdt_wait_cycles().

Would it be possible to use the rwdt_ prefix everywhere so that the
driver is easier to compare with the linux driver?

> +{
> +	struct renesas_wdt_priv *priv =3D dev_get_priv(dev);
> +	u64 max_timeout;
> +	u8 val;
> +
> +	max_timeout =3D DIV_BY_CLKS_PER_SEC(priv, 65536);
> +	timeout =3D min(max_timeout, timeout / 1000);
> +
> +	/* Stop the timer before we modify any register */
> +	val =3D readb_relaxed(&priv->wdt->csra) & ~RWTCSRA_TME;
> +	writel_relaxed(val | CSR_MASK, &priv->wdt->csra);
> +	/* Delay 2 cycles before setting watchdog counter */
> +	rwdt_wait_cycles(priv, 2);
> +
> +	while (readb_relaxed(&priv->wdt->csra) & RWTCSRA_WRFLG)
> +		cpu_relax();
> +
> +	writel_relaxed((65536 - MUL_BY_CLKS_PER_SEC(priv, timeout)) | CNT_MASK,
> +		       &priv->wdt->cnt);
> +
> +	writel_relaxed(priv->cks | RWTCSRA_TME | CSR_MASK, &priv->wdt->csra);
> +
> +	return 0;
> +}
> +
> +static int renesas_wdt_stop(struct udevice *dev)
> +{
> +	struct renesas_wdt_priv *priv =3D dev_get_priv(dev);
> +
> +	writel_relaxed(priv->cks | CSR_MASK, &priv->wdt->csra);
> +
> +	return 0;
> +}
> +
> +static int renesas_wdt_reset(struct udevice *dev)
> +{
> +	struct renesas_wdt_priv *priv =3D dev_get_priv(dev);
> +	u8 val;
> +
> +	/* Stop the timer before we modify any register */
> +	val =3D readb_relaxed(&priv->wdt->csra) & ~RWTCSRA_TME;
> +	writel_relaxed(val | CSR_MASK, &priv->wdt->csra);
> +	/* Delay 2 cycles before setting watchdog counter */
> +	rwdt_wait_cycles(priv, 2);
> +
> +	writel_relaxed(0xffff | CNT_MASK, &priv->wdt->cnt);
> +	/* smallest divider to reboot soon */
> +	writel_relaxed(0 | CSR_MASK, &priv->wdt->csra);
> +
> +	readb_poll_timeout(&priv->wdt->csra, val, !(val & RWTCSRA_WRFLG), 100);
> +
> +	writel_relaxed(RWTCSRA_TME | CSR_MASK, &priv->wdt->csra);
> +
> +	/* wait 2 cycles, so watchdog will trigger */
> +	rwdt_wait_cycles(priv, 2);
> +
> +	return 0;
> +}
> +
> +static int renesas_wdt_probe(struct udevice *dev)
> +{
> +	struct renesas_wdt_priv *priv =3D dev_get_priv(dev);
> +	unsigned long clks_per_sec;
> +	int ret, i;
> +
> +	priv->wdt =3D dev_remap_addr(dev);
> +	if (!priv->wdt)
> +		return -EINVAL;
> +
> +	ret =3D clk_get_by_index(dev, 0, &priv->clk);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D clk_enable(&priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	priv->clk_rate =3D clk_get_rate(&priv->clk);
> +	if (!priv->clk_rate)
> +		return -ENOENT;

If we go through this error path, &priv->clk stays enabled.
Shouldn't we disable it if the probe fails?

> +
> +	for (i =3D ARRAY_SIZE(clk_divs) - 1; i >=3D 0; i--) {
> +		clks_per_sec =3D priv->clk_rate / clk_divs[i];
> +		if (clks_per_sec && clks_per_sec < 65536) {
> +			priv->cks =3D i;
> +			break;
> +		}
> +	}
> +
> +	/* can't find a suitable clock divider */
> +	if (i < 0)
> +		return -ERANGE;
> +
> +	return 0;
> +}
> +
> +static const struct wdt_ops renesas_wdt_ops =3D {
> +	.start =3D renesas_wdt_start,
> +	.reset =3D renesas_wdt_reset,
> +	.stop =3D renesas_wdt_stop,
> +};
> +
> +static const struct udevice_id renesas_wdt_ids[] =3D {
> +	{ .compatible =3D "renesas,r8a779f0-wdt" },
> +	{ .compatible =3D "renesas,rcar-gen4-wdt" },
> +	{}

Linux driver seems to have:

	{ .compatible =3D "renesas,rcar-gen2-wdt", },
	{ .compatible =3D "renesas,rcar-gen3-wdt", },
	{ .compatible =3D "renesas,rcar-gen4-wdt", },

Any reason why the compatibles are different here?

> +};
> +
> +U_BOOT_DRIVER(wdt_renesas) =3D {
> +	.name =3D "wdt_renesas",
> +	.id =3D UCLASS_WDT,
> +	.of_match =3D renesas_wdt_ids,
> +	.ops =3D &renesas_wdt_ops,
> +	.probe	=3D renesas_wdt_probe,
> +	.priv_auto =3D sizeof(struct renesas_wdt_priv),
> +};
>
> ---
> base-commit: 3b6760ddeb4ef940226921017cd9088c89784b01
> change-id: 20250530-us-renesas-watchdog-2c79dbbd5cd2
>
> Best regards,
> --=20
> Shmuel Leib Melamud <smelamud@redhat.com>

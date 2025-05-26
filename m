Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DBDC5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 12:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0743A82DA1;
	Mon, 26 May 2025 14:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fQJeCiV2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EF1682DB7; Mon, 26 May 2025 14:43:25 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7222782D6F
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 14:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 74613A4E695;
 Mon, 26 May 2025 12:43:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DEDC4CEE7;
 Mon, 26 May 2025 12:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748263401;
 bh=Nt6FoEh8hVXktQk5jGo5/Z5sOohyqBaYRpPsBvssr7s=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=fQJeCiV2bllybTYHr9VXHX8bw5vcfTWeToqkyH4upJ7nwT6LNUK98o5kKbcwDvYfO
 S7Bv6qW+FuvwdQCv61DODZyKTyt2RGHG5BiV88GxnweJoDahTDpnk86MuaG4IPOpo6
 Of8NN1Kdqj/6rRp85B2IXGPM7mSNjOw8uJemQGVKgdZRzjzEpFWtmYR1T3FGrI0Xou
 ectPe9deG3j/CiBPquOzxLy2+8b2EbbTNuSrw1zRb1oFitjZIvgLNyZ8KkNEI/yhci
 ZKMv1iuBOqGgMa4l4UxeM3OaEiiLimuDfyqNF7xPCuDxyt8Pq9I+dBqyhOj5+y3Zwt
 w5kvIsMLxzwow==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Shmuel Melamud <smelamud@redhat.com>, u-boot@lists.denx.de
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Marek Vasut <marex@denx.de>,
 Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] renesas: Renesas R-Car Gen4 watchdog driver
In-Reply-To: <CAMFVLy31c0ypTGpKx3ZE1kmjN_HpqCJh-GHBC+JAmPLMdCs6uQ@mail.gmail.com>
References: <CAMFVLy31c0ypTGpKx3ZE1kmjN_HpqCJh-GHBC+JAmPLMdCs6uQ@mail.gmail.com>
Date: Mon, 26 May 2025 14:43:18 +0200
Message-ID: <87v7pnczkp.fsf@kernel.org>
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

Thank you for the patch and for contributing to U-Boot.

On ven., mai 09, 2025 at 01:23, Shmuel Melamud <smelamud@redhat.com> wrote:

> Add support of Renesas R-Car Gen4 watchdog timer. Timeouts up to
> 8184.0s are supported (CKS1 register is not involved). The watchdog
> uses the clock type CLK_TYPE_GEN4_MDSEL, so handling of this constant
> is added to gen3_clk_get_rate64() function.
>
> Signed-off-by: Shmuel Leib Melamud <smelamud@redhat.com>
> ---
>  drivers/clk/renesas/clk-rcar-gen3.c |   4 +-
>  drivers/watchdog/Kconfig            |   8 ++
>  drivers/watchdog/Makefile           |   1 +
>  drivers/watchdog/renesas_wdt.c      | 172 ++++++++++++++++++++++++++++
>  4 files changed, 184 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/watchdog/renesas_wdt.c

I've tried to apply this with b4 but it seems to complain about
whitespace corruption:

$ b4 shazam -s -l --check CAMFVLy31c0ypTGpKx3ZE1kmjN_HpqCJh-GHBC+JAmPLMdCs6=
uQ@mail.gmail.com

 =E2=9C=93 [PATCH] renesas: Renesas R-Car Gen4 watchdog driver
    + Link: https://lore.kernel.org/r/CAMFVLy31c0ypTGpKx3ZE1kmjN_HpqCJh-GHB=
C+JAmPLMdCs6uQ@mail.gmail.com
    + Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
    =E2=97=8F checkpatch.pl: 121: ERROR: patch seems to be corrupt (line wr=
apped?)

[...] (lots of more whitespace errors.)

Can you please double check that the patch has been formatted properly
when sending?

See: https://docs.u-boot.org/en/latest/develop/sending_patches.html

Thanks,
Mattijs

>
> diff --git a/drivers/clk/renesas/clk-rcar-gen3.c
> b/drivers/clk/renesas/clk-rcar-gen3.c
> index 375cc4a4930..5745acf4023 100644
> --- a/drivers/clk/renesas/clk-rcar-gen3.c
> +++ b/drivers/clk/renesas/clk-rcar-gen3.c
> @@ -68,7 +68,7 @@ static int gen3_clk_get_parent(struct gen3_clk_priv
> *priv, struct clk *clk,
>          if (ret)
>              return ret;
>
> -        if (core->type =3D=3D CLK_TYPE_GEN3_MDSEL) {
> +        if (core->type =3D=3D CLK_TYPE_GEN3_MDSEL || core->type =3D=3D
> CLK_TYPE_GEN4_MDSEL) {
>              shift =3D priv->cpg_mode & BIT(core->offset) ? 0 : 16;
>              parent->dev =3D clk->dev;
>              parent->id =3D core->parent >> shift;
> @@ -318,6 +318,8 @@ static u64 gen3_clk_get_rate64(struct clk *clk)
>                          "FIXED");
>
>      case CLK_TYPE_GEN3_MDSEL:
> +        fallthrough;
> +    case CLK_TYPE_GEN4_MDSEL:
>          shift =3D priv->cpg_mode & BIT(core->offset) ? 0 : 16;
>          div =3D (core->div >> shift) & 0xffff;
>          rate =3D gen3_clk_get_rate64(&parent) / div;
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 1bb67f50352..a0f2948335f 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -335,6 +335,14 @@ config WDT_K3_RTI_FW_FILE
>
>  endif
>
> +config WDT_RENESAS
> +    bool "Renesas watchdog timer support"
> +    depends on WDT && R8A779F0
> +    select CLK
> +    select CLK_RENESAS
> +    help
> +      Enables Renesas SoC R8A779F0 watchdog timer support.
> +
>  config WDT_SANDBOX
>      bool "Enable Watchdog Timer support for Sandbox"
>      depends on SANDBOX && WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index e6bd4c587af..c4467d6e126 100644
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
> index 00000000000..97550794a2e
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
> +    u32 cnt;
> +    u32 csra;
> +    u32 csrb;
> +};
> +
> +#define RWTCSRA_WOVF    BIT(4)
> +#define RWTCSRA_WRFLG    BIT(5)
> +#define RWTCSRA_TME        BIT(7)
> +
> +#define CSR_MASK    0xA5A5A500
> +#define CNT_MASK    0x5A5A0000
> +
> +/*
> + * In probe, clk_rate is checked to be not more than 16 bit * biggest cl=
ock
> + * divider (12 bits). d is only a factor to fully utilize the WDT counte=
r and
> + * will not exceed its 16 bits. Thus, no overflow, we stay below 32 bits.
> + */
> +#define MUL_BY_CLKS_PER_SEC(p, d) \
> +    DIV_ROUND_UP((d) * (p)->clk_rate, clk_divs[(p)->cks])
> +
> +/* d is 16 bit, clk_divs 12 bit -> no 32 bit overflow */
> +#define DIV_BY_CLKS_PER_SEC(p, d) ((d) * clk_divs[(p)->cks] / (p)->clk_r=
ate)
> +
> +static const unsigned int clk_divs[] =3D { 1, 4, 16, 32, 64, 128, 1024, =
4096 };
> +
> +struct renesas_wdt_priv {
> +    struct renesas_wdt __iomem *wdt;
> +    unsigned long clk_rate;
> +    u8 cks;
> +    struct clk clk;
> +};
> +
> +static void rwdt_wait_cycles(struct renesas_wdt_priv *priv, unsigned
> int cycles)
> +{
> +    unsigned int delay;
> +
> +    delay =3D DIV_ROUND_UP(cycles * 1000000, priv->clk_rate);
> +
> +    usleep_range(delay, 2 * delay);
> +}
> +
> +static int renesas_wdt_start(struct udevice *dev, u64 timeout, ulong fla=
gs)
> +{
> +    struct renesas_wdt_priv *priv =3D dev_get_priv(dev);
> +    u64 max_timeout;
> +    u8 val;
> +
> +    max_timeout =3D DIV_BY_CLKS_PER_SEC(priv, 65536);
> +    timeout =3D min(max_timeout, timeout / 1000);
> +
> +    /* Stop the timer before we modify any register */
> +    val =3D readb_relaxed(&priv->wdt->csra) & ~RWTCSRA_TME;
> +    writel_relaxed(val | CSR_MASK, &priv->wdt->csra);
> +    /* Delay 2 cycles before setting watchdog counter */
> +    rwdt_wait_cycles(priv, 2);
> +
> +    while (readb_relaxed(&priv->wdt->csra) & RWTCSRA_WRFLG)
> +        cpu_relax();
> +
> +    writel_relaxed((65536 - MUL_BY_CLKS_PER_SEC(priv, timeout)) | CNT_MA=
SK,
> +               &priv->wdt->cnt);
> +
> +    writel_relaxed(priv->cks | RWTCSRA_TME | CSR_MASK, &priv->wdt->csra);
> +
> +    return 0;
> +}
> +
> +static int renesas_wdt_stop(struct udevice *dev)
> +{
> +    struct renesas_wdt_priv *priv =3D dev_get_priv(dev);
> +
> +    writel_relaxed(priv->cks | CSR_MASK, &priv->wdt->csra);
> +
> +    return 0;
> +}
> +
> +static int renesas_wdt_reset(struct udevice *dev)
> +{
> +    struct renesas_wdt_priv *priv =3D dev_get_priv(dev);
> +    u8 val;
> +
> +    /* Stop the timer before we modify any register */
> +    val =3D readb_relaxed(&priv->wdt->csra) & ~RWTCSRA_TME;
> +    writel_relaxed(val | CSR_MASK, &priv->wdt->csra);
> +    /* Delay 2 cycles before setting watchdog counter */
> +    rwdt_wait_cycles(priv, 2);
> +
> +    writel_relaxed(0xffff | CNT_MASK, &priv->wdt->cnt);
> +    /* smallest divider to reboot soon */
> +    writel_relaxed(0 | CSR_MASK, &priv->wdt->csra);
> +
> +    readb_poll_timeout(&priv->wdt->csra, val, !(val & RWTCSRA_WRFLG), 10=
0);
> +
> +    writel_relaxed(RWTCSRA_TME | CSR_MASK, &priv->wdt->csra);
> +
> +    /* wait 2 cycles, so watchdog will trigger */
> +    rwdt_wait_cycles(priv, 2);
> +
> +    return 0;
> +}
> +
> +static int renesas_wdt_probe(struct udevice *dev)
> +{
> +    struct renesas_wdt_priv *priv =3D dev_get_priv(dev);
> +    unsigned long clks_per_sec;
> +    int ret, i;
> +
> +    priv->wdt =3D dev_remap_addr(dev);
> +    if (!priv->wdt)
> +        return -EINVAL;
> +
> +    ret =3D clk_get_by_index(dev, 0, &priv->clk);
> +    if (ret < 0)
> +        return ret;
> +
> +    ret =3D clk_enable(&priv->clk);
> +    if (ret)
> +        return ret;
> +
> +    priv->clk_rate =3D clk_get_rate(&priv->clk);
> +    if (!priv->clk_rate)
> +        return -ENOENT;
> +
> +    for (i =3D ARRAY_SIZE(clk_divs) - 1; i >=3D 0; i--) {
> +        clks_per_sec =3D priv->clk_rate / clk_divs[i];
> +        if (clks_per_sec && clks_per_sec < 65536) {
> +            priv->cks =3D i;
> +            break;
> +        }
> +    }
> +
> +    /* can't find a suitable clock divider */
> +    if (i < 0)
> +        return -ERANGE;
> +
> +    return 0;
> +}
> +
> +static const struct wdt_ops renesas_wdt_ops =3D {
> +    .start =3D renesas_wdt_start,
> +    .reset =3D renesas_wdt_reset,
> +    .stop =3D renesas_wdt_stop,
> +};
> +
> +static const struct udevice_id renesas_wdt_ids[] =3D {
> +    { .compatible =3D "renesas,r8a779f0-wdt" },
> +    { .compatible =3D "renesas,rcar-gen4-wdt" },
> +    {}
> +};
> +
> +U_BOOT_DRIVER(wdt_renesas) =3D {
> +    .name =3D "wdt_renesas",
> +    .id =3D UCLASS_WDT,
> +    .of_match =3D renesas_wdt_ids,
> +    .ops =3D &renesas_wdt_ops,
> +    .probe    =3D renesas_wdt_probe,
> +    .priv_auto =3D sizeof(struct renesas_wdt_priv),
> +};
> --
> 2.49.0

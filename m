Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F7CC4828D
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 16:24:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E41B387C93;
	Thu,  1 Feb 2024 17:24:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AEFA87CA3; Thu,  1 Feb 2024 17:24:55 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id F04B8875FA
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 17:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16889DA7;
 Thu,  1 Feb 2024 08:25:35 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B6EF3F738;
 Thu,  1 Feb 2024 08:24:51 -0800 (PST)
Date: Thu, 1 Feb 2024 16:24:44 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Ludwig Kormann <ludwig.kormann@ict42.de>, "linux-sunxi@lists.linux.dev"
 <linux-sunxi@lists.linux.dev>
Cc: jagan@amarulasolutions.com, trini@konsulko.com, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] sunxi: sun4i: add missing sdelay() to
 clock_init_safe()
Message-ID: <20240201162444.1cf81b0b@donnerap.manchester.arm.com>
In-Reply-To: <20240201084550.200913-1-ludwig.kormann@ict42.de>
References: <20240201084550.200913-1-ludwig.kormann@ict42.de>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Thu,  1 Feb 2024 09:45:50 +0100
Ludwig Kormann <ludwig.kormann@ict42.de> wrote:

Hi,

> This delay is required after switching the clock source.
>=20
> See =E2=80=9CA20 Reference manual v1.4=E2=80=9D Page 50 / section
> =E2=80=9C1.5.4.16. CPU/AHB/APB0 CLOCK RATIO=E2=80=9D: =E2=80=9CIf the clo=
ck
> source is changed, at most to wait for 8 present running
> clock cycles.=E2=80=9D
>=20
> This is already implemented in clock_set_pll1(), but was
> still missing in clock_init_safe().
>=20
> Signed-off-by: Ludwig Kormann <ludwig.kormann@ict42.de>

Good catch, thanks for sending this!

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arch/arm/mach-sunxi/clock_sun4i.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm/mach-sunxi/clock_sun4i.c b/arch/arm/mach-sunxi/cloc=
k_sun4i.c
> index 8f1d1b65f0..ac3b7a801f 100644
> --- a/arch/arm/mach-sunxi/clock_sun4i.c
> +++ b/arch/arm/mach-sunxi/clock_sun4i.c
> @@ -25,6 +25,7 @@ void clock_init_safe(void)
>  	       APB0_DIV_1 << APB0_DIV_SHIFT |
>  	       CPU_CLK_SRC_OSC24M << CPU_CLK_SRC_SHIFT,
>  	       &ccm->cpu_ahb_apb0_cfg);
> +	sdelay(20);
>  	writel(PLL1_CFG_DEFAULT, &ccm->pll1_cfg);
>  	sdelay(200);
>  	writel(AXI_DIV_1 << AXI_DIV_SHIFT |
> @@ -32,6 +33,7 @@ void clock_init_safe(void)
>  	       APB0_DIV_1 << APB0_DIV_SHIFT |
>  	       CPU_CLK_SRC_PLL1 << CPU_CLK_SRC_SHIFT,
>  	       &ccm->cpu_ahb_apb0_cfg);
> +	sdelay(20);
>  #ifdef CONFIG_MACH_SUN7I
>  	setbits_le32(&ccm->ahb_gate0, 0x1 << AHB_GATE_OFFSET_DMA);
>  #endif


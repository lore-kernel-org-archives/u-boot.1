Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D461CD3424
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 12:38:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D717844CF;
	Fri,  1 May 2026 14:38:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="X+SLOhzM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D17E980F0E; Fri,  1 May 2026 11:03:01 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8502480086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 11:02:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 0E37726F41;
 Fri,  1 May 2026 11:02:59 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id leC32887GL_J; Fri,  1 May 2026 11:02:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1777626178; bh=Y2Hmj/CaXM9r1J/6oC1cxO5FrRgdUkXs4Sa5w6zbxFc=;
 h=Date:Cc:Subject:From:To:References:In-Reply-To;
 b=X+SLOhzMZnOaQk+DZe9OOkR5CenqrmHFH2Ar2GlnGJq3E6KJjsFxTq5bG0IsQWysZ
 Pk5j1SHE8H6/iLF0xYFvSYJGJaNlvmAzKaU4z17YGA3Ct89TDxnpOnkmsFuNN0BaL+
 qa6SfrjA2EH3mMm6SXFGTl70sX8dcdoe71HdoGmCeva9lT60NkNj+GkSzCBYpLLN4D
 FRexNlEnXaT9Welpvmja97nmY9fhxfJ7HiWU7sWZuYd4iTPtO4fkYB+r97oqcE89RH
 scshkFnTYqZRiY7/yA3QZZPeMR63CEHAurVPT6U/kPP94xXn6Nr4gKMZfadlpqrwWv
 UxEkG540a5TUQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 May 2026 14:32:50 +0530
Message-Id: <DI77VWX0XZXF.2H0WQMKJ4UWKT@disroot.org>
Cc: "Peng Fan" <peng.fan@nxp.com>, <u-boot@lists.denx.de>, "Minkyu Kang"
 <mk7.kang@samsung.com>, "Tom Rini" <trini@konsulko.com>, "Jaehoon Chung"
 <jh80.chung@samsung.com>, "Anand Moon" <linux.amoon@gmail.com>, "Sam
 Protsenko" <semen.protsenko@linaro.org>, "Lukas Timmermann"
 <uboot@timmermann.space>
Subject: Re: [PATCH 1/4] mmc: exynos_dw_mmc: add proper init sequence for
 HS400 support
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "Henrik Grimler" <henrik@grimler.se>, "Kaustabh Chakraborty"
 <kauschluss@disroot.org>
References: <20260427-dwmmc-exynos-hs400-es-v1-0-3495df40a9ac@disroot.org>
 <20260427-dwmmc-exynos-hs400-es-v1-1-3495df40a9ac@disroot.org>
 <20260430172638.GA17167@localhost> <DI6QUD531HSA.2VQ3A6S1JC9BC@disroot.org>
 <20260501065840.GA13244@grimfrac.localdomain>
In-Reply-To: <20260501065840.GA13244@grimfrac.localdomain>
X-Mailman-Approved-At: Fri, 01 May 2026 14:38:15 +0200
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

On 2026-05-01 08:58 +02:00, Henrik Grimler wrote:
> Hi Kaustabh,
>
> On Fri, May 01, 2026 at 01:11:29AM +0530, Kaustabh Chakraborty wrote:
>> On 2026-04-30 19:26 +02:00, Henrik Grimler wrote:
>> > Hi Kaustabh,
>> >
>> > On Mon, Apr 27, 2026 at 11:22:49AM +0530, Kaustabh Chakraborty wrote:
>> >> HS400 support was added, but configuration necessary for HS400 suppor=
t
>> >> was left out. Add necessary changes, which includes:
>> >> - Device tree properties, such as "samsung,dw-mshc-hs400-timing" and
>> >>   "samsung,read-strobe-delay", which function as per dt-bindings.
>> >> - Registers related to HS400, which are necessary to enable HS400+ su=
pport.
>> >> - Appropriate timing tunings for the HS400 mode.
>> >>=20
>> >> Note that these changes are loosely based off of its Linux kernel
>> >> counterpart.
>> >>=20
>> >> Fixes: bbe3b9fa0922 ("mmc: exynos_dw_mmc: add support for MMC HS200 a=
nd HS400 modes")
>> >> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> >> ---
>> >>  arch/arm/mach-exynos/include/mach/dwmmc.h |  5 ++
>> >>  drivers/mmc/exynos_dw_mmc.c               | 80 +++++++++++++++++++++=
++++++++++
>> >>  2 files changed, 85 insertions(+)
>> >>=20
>> >> diff --git a/arch/arm/mach-exynos/include/mach/dwmmc.h b/arch/arm/mac=
h-exynos/include/mach/dwmmc.h
>> >> index 4432deedef7..50081326c25 100644
>> >> --- a/arch/arm/mach-exynos/include/mach/dwmmc.h
>> >> +++ b/arch/arm/mach-exynos/include/mach/dwmmc.h
>> >> @@ -15,6 +15,11 @@
>> >>  #define DWMCI_SET_DRV_CLK(x)		((x) << 16)
>> >>  #define DWMCI_SET_DIV_RATIO(x)		((x) << 24)
>> >> =20
>> >> +/* HS400 Related Registers */
>> >> +#define DWMCI_HS400_DQS_EN		0x180
>> >> +#define DWMCI_HS400_ASYNC_FIFO_CTRL	0x184
>> >> +#define DWMCI_HS400_DLINE_CTRL		0x188
>> >> +
>> >>  /* Protector Register */
>> >>  #define DWMCI_EMMCP_BASE		0x1000
>> >>  #define EMMCP_MPSECURITY		(DWMCI_EMMCP_BASE + 0x0010)
>> >> diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.=
c
>> >> index 7ccd113bd79..d5e90a9bd5c 100644
>> >> --- a/drivers/mmc/exynos_dw_mmc.c
>> >> +++ b/drivers/mmc/exynos_dw_mmc.c
>> >> @@ -8,6 +8,7 @@
>> >>  #include <dwmmc.h>
>> >>  #include <asm/global_data.h>
>> >>  #include <malloc.h>
>> >> +#include <mmc.h>
>> >>  #include <errno.h>
>> >>  #include <asm/arch/dwmmc.h>
>> >>  #include <asm/arch/clk.h>
>> >> @@ -30,6 +31,14 @@
>> >>  #define CLKSEL_UP_SAMPLE(x, y)		(((x) & ~CLKSEL_CCLK_SAMPLE(7)) | \
>> >>  					 CLKSEL_CCLK_SAMPLE(y))
>> >> =20
>> >> +/* RCLK_EN register defines */
>> >> +#define DATA_STROBE_EN			BIT(0)
>> >> +#define AXI_NON_BLOCKING_WR	BIT(7)
>> >> +
>> >> +/* DLINE_CTRL register defines */
>> >> +#define DQS_CTRL_RD_DELAY(x, y)		(((x) & ~0x3FF) | ((y) & 0x3FF))
>> >> +#define DQS_CTRL_GET_RD_DELAY(x)	((x) & 0x3FF)
>> >> +
>> >>  /**
>> >>   * DOC: Quirk flags for different Exynos DW MMC blocks
>> >>   *
>> >> @@ -71,6 +80,11 @@ struct dwmci_exynos_priv_data {
>> >>  	struct clk clk;
>> >>  	u32 sdr_timing;
>> >>  	u32 ddr_timing;
>> >> +	u32 hs400_timing;
>> >> +	u32 tuned_sample;
>> >> +	u32 dqs_delay;
>> >> +	u32 saved_dqs_en;
>> >> +	u32 saved_strobe_ctrl;
>> >>  	const struct exynos_dwmmc_variant *chip;
>> >>  };
>> >> =20
>> >> @@ -162,6 +176,27 @@ static u8 exynos_dwmmc_get_ciu_div(struct dwmci_=
host *host)
>> >>  				& DWMCI_DIVRATIO_MASK) + 1;
>> >>  }
>> >> =20
>> >> +static void exynos_config_hs400(struct dwmci_host *host, enum bus_mo=
de mode)
>> >> +{
>> >> +	struct dwmci_exynos_priv_data *priv =3D exynos_dwmmc_get_priv(host)=
;
>> >> +	u32 dqs, strobe;
>> >> +
>> >> +	dqs =3D priv->saved_dqs_en;
>> >> +	strobe =3D priv->saved_strobe_ctrl;
>> >> +
>> >> +	switch (mode) {
>> >> +	case MMC_HS_400:
>> >> +		dqs |=3D DATA_STROBE_EN;
>> >> +		strobe =3D DQS_CTRL_RD_DELAY(strobe, priv->dqs_delay);
>> >> +		break;
>> >> +	default:
>> >> +		dqs &=3D ~DATA_STROBE_EN;
>> >> +	}
>> >> +
>> >> +	dwmci_writel(host, DWMCI_HS400_DQS_EN, dqs);
>> >> +	dwmci_writel(host, DWMCI_HS400_DLINE_CTRL, strobe);
>> >> +}
>> >> +
>> >>  /* Configure CLKSEL register with chosen timing values */
>> >>  static int exynos_dwmci_clksel(struct dwmci_host *host)
>> >>  {
>> >> @@ -170,6 +205,9 @@ static int exynos_dwmci_clksel(struct dwmci_host =
*host)
>> >>  	u32 timing;
>> >> =20
>> >>  	switch (host->mmc->selected_mode) {
>> >> +	case MMC_HS_400:
>> >> +		timing =3D CLKSEL_UP_SAMPLE(priv->hs400_timing, priv->tuned_sample=
);
>> >> +		break;
>> >>  	case MMC_DDR_52:
>> >>  		timing =3D priv->ddr_timing;
>> >>  		break;
>> >> @@ -186,6 +224,8 @@ static int exynos_dwmci_clksel(struct dwmci_host =
*host)
>> >> =20
>> >>  	dwmci_writel(host, priv->chip->clksel, timing);
>> >> =20
>> >> +	exynos_config_hs400(host, host->mmc->selected_mode);
>> >> +
>> >
>> > This breaks emmc in Linux for existing devices without hs400 support:
>> > exynos_config_hs400 is run no matter if the dt has the hs400
>> > parameters, meaning 0x0 is written to DWMCI_HS400_DQS_EN and
>> > DWMCI_HS400_DLINE_CTRL. U-boot does not seem to care, it loads the
>> > kernel and initramfs without issues, but Linux later gives errors:
>>=20
>> Is it that the same defconfig is used for two devices, one with and one
>> without HS400 support? If that's the case, guarding the call with
>> HS400_SUPPORT config options won't be a real fix.
>
> A family of devices are using the same defconfig. I assume the
> hardware in all of them supports hs400, but at the moment only one
> device seems to be configured to use hs400 _in Linux_, and none in
> u-boot.

It won't. If one of the devices supports HS400 and others don't (not
specifically in your case, but a general scenario), then the config
would have HS400 support enabled. As a result non-HS400 hardware would
also try to assume HS400.

>
> Adding a config guard around exynos_config_hs400() would probably
> work. I see Linux uses a check like
> if (priv->ctrl_type >=3D DW_MCI_TYPE_EXYNOS5420)
> instead.
>
>> mmc_of_parse() in mmc-uclass.h seems promising, this needs to be
>> integrated with dwmci_setup_cfg() in dw_mmc.c, and this change _may_ be
>> regressive in nature, so I may also need to add some safety guards for
>> this.
>>=20
>> I will thus add this patch in the next rev. Would you be up to test the =
patch
>> for the concerned devices too?
>
> Yeah I can test on these older devices.
>
> Best regards,
> Henrik Grimler
>
>> >
>> > ```
>> > [   20.741025] mmc_host mmc0: Bus speed (slot 0) =3D 50000000Hz (slot =
req 400000Hz, actual 396825HZ div =3D 63)
>> > [   20.886686] mmc_host mmc0: Bus speed (slot 0) =3D 50000000Hz (slot =
req 52000000Hz, actual 50000000HZ div =3D 0)
>> > [   20.895138] mmc_host mmc0: Bus speed (slot 0) =3D 200000000Hz (slot=
 req 200000000Hz, actual 200000000HZ div =3D 0)
>> > [   20.905990] mmc_host mmc0: Bus speed (slot 0) =3D 50000000Hz (slot =
req 52000000Hz, actual 50000000HZ div =3D 0)
>> > [   20.914988] mmc_host mmc0: Bus speed (slot 0) =3D 400000000Hz (slot=
 req 200000000Hz, actual 200000000HZ div =3D 1)
>> > [   21.099546] I/O error, dev mmcblk0, sector 1000001 op 0x1:(WRITE) f=
lags 0x800 phys_seg 16 prio class 2
>> > [   21.099853] I/O error, dev mmcblk0, sector 1000825 op 0x1:(WRITE) f=
lags 0x800 phys_seg 8 prio class 2
>> > [   21.107443] Buffer I/O error on dev mmcblk0p2, logical block 0, los=
t async page write
>> > [   21.107473] Buffer I/O error on dev mmcblk0p2, logical block 1, los=
t async page write
>> > [   21.116657] Buffer I/O error on dev mmcblk0p2, logical block 824, l=
ost async page write
>> > [   21.124408] Buffer I/O error on dev mmcblk0p2, logical block 2, los=
t async page write
>> > [   21.132206] Buffer I/O error on dev mmcblk0p2, logical block 825, l=
ost async page write
>> > [   21.140178] Buffer I/O error on dev mmcblk0p2, logical block 3, los=
t async page write
>> > [   21.147973] Buffer I/O error on dev mmcblk0p2, logical block 826, l=
ost async page write
>> > [   21.155960] Buffer I/O error on dev mmcblk0p2, logical block 4, los=
t async page write
>> > [   21.163749] Buffer I/O error on dev mmcblk0p2, logical block 827, l=
ost async page write
>> > [   21.171720] Buffer I/O error on dev mmcblk0p2, logical block 5, los=
t async page write
>> > [   21.200708] I/O error, dev mmcblk0, sector 1000873 op 0x1:(WRITE) f=
lags 0x800 phys_seg 8 prio class 2
>> > [   21.201043] I/O error, dev mmcblk0, sector 1000929 op 0x1:(WRITE) f=
lags 0x800 phys_seg 8 prio class 2
>> > [   21.218287] I/O error, dev mmcblk0, sector 1000945 op 0x1:(WRITE) f=
lags 0x800 phys_seg 80 prio class 2
>> > [   21.218623] I/O error, dev mmcblk0, sector 1001033 op 0x1:(WRITE) f=
lags 0x800 phys_seg 24 prio class 2
>> > [   21.236813] I/O error, dev mmcblk0, sector 1001097 op 0x1:(WRITE) f=
lags 0x800 phys_seg 8 prio class 2
>> > [   21.237146] I/O error, dev mmcblk0, sector 1001121 op 0x1:(WRITE) f=
lags 0x800 phys_seg 24 prio class 2
>> > [   21.255370] I/O error, dev mmcblk0, sector 1001161 op 0x1:(WRITE) f=
lags 0x800 phys_seg 56 prio class 2
>> > [   21.256253] I/O error, dev mmcblk0, sector 1001249 op 0x1:(WRITE) f=
lags 0x800 phys_seg 8 prio class 2
>> > ```
>> >
>> > Specifically it seems to be writing 0x0 to DWMCI_HS400_DQS_EN that is
>> > the issue, if I comment out that line it works also for my odroid-xu4
>> > in non-hs400 mode.
>> >
>> > Tested on odroid-xu4 with odroid-xu3_defconfig after applying the
>> > entire series, without any other changes.
>> >
>> > Best regards,
>> > Henrik Grimler
>>=20


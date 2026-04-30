Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E560DCD13DA
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 19:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5A278464D;
	Thu, 30 Apr 2026 21:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="TO/UQiYk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C95B680433; Thu, 30 Apr 2026 21:41:41 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 366CD80086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 21:41:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id BA40B27121;
 Thu, 30 Apr 2026 21:41:37 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id So8omeIaaGkS; Thu, 30 Apr 2026 21:41:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1777578097; bh=qawlnzyBSBMS2JuYctE7lJOpfCOFHtpFRKp0Y5brhe4=;
 h=Date:To:Cc:Subject:From:References:In-Reply-To;
 b=TO/UQiYkvDK74V2JcqdOOZQip1jZxJ2NifyWLOpdZZ68Hhl+XcWwCRTFj/iV2HSdU
 tBnozJnJpuSH5aWeZtS/FSWNypYSK2QRXfwlaZy8ncBaEKbSeDjTvjCOFO9Zvh/LTA
 PyjT1JrnzY+ZBaIVbfMiUJVj9U2r6U/qLN5AFemNK6rcY/Uk1axwD5kqrhIDbN47ht
 b49fnHhE48Lk853mig7Zxe/riNmsXDZKocnoY+Tu/+16jA/2pQ4y0va956K4FaQNpZ
 QF3TZZSaTpKUOOHj0KKsPEeVQaHxWTHwbIPqIkJnPog+n4Z1abC+LPjRBPJwOibjG7
 l770x6QV74GRw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 May 2026 01:11:29 +0530
Message-Id: <DI6QUD531HSA.2VQ3A6S1JC9BC@disroot.org>
To: "Henrik Grimler" <henrik@grimler.se>, "Kaustabh Chakraborty"
 <kauschluss@disroot.org>
Cc: "Peng Fan" <peng.fan@nxp.com>, <u-boot@lists.denx.de>, "Minkyu Kang"
 <mk7.kang@samsung.com>, "Tom Rini" <trini@konsulko.com>, "Jaehoon Chung"
 <jh80.chung@samsung.com>, "Anand Moon" <linux.amoon@gmail.com>, "Sam
 Protsenko" <semen.protsenko@linaro.org>, "Lukas Timmermann"
 <uboot@timmermann.space>
Subject: Re: [PATCH 1/4] mmc: exynos_dw_mmc: add proper init sequence for
 HS400 support
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
References: <20260427-dwmmc-exynos-hs400-es-v1-0-3495df40a9ac@disroot.org>
 <20260427-dwmmc-exynos-hs400-es-v1-1-3495df40a9ac@disroot.org>
 <20260430172638.GA17167@localhost>
In-Reply-To: <20260430172638.GA17167@localhost>
X-Mailman-Approved-At: Thu, 30 Apr 2026 21:54:39 +0200
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

On 2026-04-30 19:26 +02:00, Henrik Grimler wrote:
> Hi Kaustabh,
>
> On Mon, Apr 27, 2026 at 11:22:49AM +0530, Kaustabh Chakraborty wrote:
>> HS400 support was added, but configuration necessary for HS400 support
>> was left out. Add necessary changes, which includes:
>> - Device tree properties, such as "samsung,dw-mshc-hs400-timing" and
>>   "samsung,read-strobe-delay", which function as per dt-bindings.
>> - Registers related to HS400, which are necessary to enable HS400+ suppo=
rt.
>> - Appropriate timing tunings for the HS400 mode.
>>=20
>> Note that these changes are loosely based off of its Linux kernel
>> counterpart.
>>=20
>> Fixes: bbe3b9fa0922 ("mmc: exynos_dw_mmc: add support for MMC HS200 and =
HS400 modes")
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> ---
>>  arch/arm/mach-exynos/include/mach/dwmmc.h |  5 ++
>>  drivers/mmc/exynos_dw_mmc.c               | 80 ++++++++++++++++++++++++=
+++++++
>>  2 files changed, 85 insertions(+)
>>=20
>> diff --git a/arch/arm/mach-exynos/include/mach/dwmmc.h b/arch/arm/mach-e=
xynos/include/mach/dwmmc.h
>> index 4432deedef7..50081326c25 100644
>> --- a/arch/arm/mach-exynos/include/mach/dwmmc.h
>> +++ b/arch/arm/mach-exynos/include/mach/dwmmc.h
>> @@ -15,6 +15,11 @@
>>  #define DWMCI_SET_DRV_CLK(x)		((x) << 16)
>>  #define DWMCI_SET_DIV_RATIO(x)		((x) << 24)
>> =20
>> +/* HS400 Related Registers */
>> +#define DWMCI_HS400_DQS_EN		0x180
>> +#define DWMCI_HS400_ASYNC_FIFO_CTRL	0x184
>> +#define DWMCI_HS400_DLINE_CTRL		0x188
>> +
>>  /* Protector Register */
>>  #define DWMCI_EMMCP_BASE		0x1000
>>  #define EMMCP_MPSECURITY		(DWMCI_EMMCP_BASE + 0x0010)
>> diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
>> index 7ccd113bd79..d5e90a9bd5c 100644
>> --- a/drivers/mmc/exynos_dw_mmc.c
>> +++ b/drivers/mmc/exynos_dw_mmc.c
>> @@ -8,6 +8,7 @@
>>  #include <dwmmc.h>
>>  #include <asm/global_data.h>
>>  #include <malloc.h>
>> +#include <mmc.h>
>>  #include <errno.h>
>>  #include <asm/arch/dwmmc.h>
>>  #include <asm/arch/clk.h>
>> @@ -30,6 +31,14 @@
>>  #define CLKSEL_UP_SAMPLE(x, y)		(((x) & ~CLKSEL_CCLK_SAMPLE(7)) | \
>>  					 CLKSEL_CCLK_SAMPLE(y))
>> =20
>> +/* RCLK_EN register defines */
>> +#define DATA_STROBE_EN			BIT(0)
>> +#define AXI_NON_BLOCKING_WR	BIT(7)
>> +
>> +/* DLINE_CTRL register defines */
>> +#define DQS_CTRL_RD_DELAY(x, y)		(((x) & ~0x3FF) | ((y) & 0x3FF))
>> +#define DQS_CTRL_GET_RD_DELAY(x)	((x) & 0x3FF)
>> +
>>  /**
>>   * DOC: Quirk flags for different Exynos DW MMC blocks
>>   *
>> @@ -71,6 +80,11 @@ struct dwmci_exynos_priv_data {
>>  	struct clk clk;
>>  	u32 sdr_timing;
>>  	u32 ddr_timing;
>> +	u32 hs400_timing;
>> +	u32 tuned_sample;
>> +	u32 dqs_delay;
>> +	u32 saved_dqs_en;
>> +	u32 saved_strobe_ctrl;
>>  	const struct exynos_dwmmc_variant *chip;
>>  };
>> =20
>> @@ -162,6 +176,27 @@ static u8 exynos_dwmmc_get_ciu_div(struct dwmci_hos=
t *host)
>>  				& DWMCI_DIVRATIO_MASK) + 1;
>>  }
>> =20
>> +static void exynos_config_hs400(struct dwmci_host *host, enum bus_mode =
mode)
>> +{
>> +	struct dwmci_exynos_priv_data *priv =3D exynos_dwmmc_get_priv(host);
>> +	u32 dqs, strobe;
>> +
>> +	dqs =3D priv->saved_dqs_en;
>> +	strobe =3D priv->saved_strobe_ctrl;
>> +
>> +	switch (mode) {
>> +	case MMC_HS_400:
>> +		dqs |=3D DATA_STROBE_EN;
>> +		strobe =3D DQS_CTRL_RD_DELAY(strobe, priv->dqs_delay);
>> +		break;
>> +	default:
>> +		dqs &=3D ~DATA_STROBE_EN;
>> +	}
>> +
>> +	dwmci_writel(host, DWMCI_HS400_DQS_EN, dqs);
>> +	dwmci_writel(host, DWMCI_HS400_DLINE_CTRL, strobe);
>> +}
>> +
>>  /* Configure CLKSEL register with chosen timing values */
>>  static int exynos_dwmci_clksel(struct dwmci_host *host)
>>  {
>> @@ -170,6 +205,9 @@ static int exynos_dwmci_clksel(struct dwmci_host *ho=
st)
>>  	u32 timing;
>> =20
>>  	switch (host->mmc->selected_mode) {
>> +	case MMC_HS_400:
>> +		timing =3D CLKSEL_UP_SAMPLE(priv->hs400_timing, priv->tuned_sample);
>> +		break;
>>  	case MMC_DDR_52:
>>  		timing =3D priv->ddr_timing;
>>  		break;
>> @@ -186,6 +224,8 @@ static int exynos_dwmci_clksel(struct dwmci_host *ho=
st)
>> =20
>>  	dwmci_writel(host, priv->chip->clksel, timing);
>> =20
>> +	exynos_config_hs400(host, host->mmc->selected_mode);
>> +
>
> This breaks emmc in Linux for existing devices without hs400 support:
> exynos_config_hs400 is run no matter if the dt has the hs400
> parameters, meaning 0x0 is written to DWMCI_HS400_DQS_EN and
> DWMCI_HS400_DLINE_CTRL. U-boot does not seem to care, it loads the
> kernel and initramfs without issues, but Linux later gives errors:

Is it that the same defconfig is used for two devices, one with and one
without HS400 support? If that's the case, guarding the call with
HS400_SUPPORT config options won't be a real fix.

mmc_of_parse() in mmc-uclass.h seems promising, this needs to be
integrated with dwmci_setup_cfg() in dw_mmc.c, and this change _may_ be
regressive in nature, so I may also need to add some safety guards for
this.

I will thus add this patch in the next rev. Would you be up to test the pat=
ch
for the concerned devices too?

>
> ```
> [   20.741025] mmc_host mmc0: Bus speed (slot 0) =3D 50000000Hz (slot req=
 400000Hz, actual 396825HZ div =3D 63)
> [   20.886686] mmc_host mmc0: Bus speed (slot 0) =3D 50000000Hz (slot req=
 52000000Hz, actual 50000000HZ div =3D 0)
> [   20.895138] mmc_host mmc0: Bus speed (slot 0) =3D 200000000Hz (slot re=
q 200000000Hz, actual 200000000HZ div =3D 0)
> [   20.905990] mmc_host mmc0: Bus speed (slot 0) =3D 50000000Hz (slot req=
 52000000Hz, actual 50000000HZ div =3D 0)
> [   20.914988] mmc_host mmc0: Bus speed (slot 0) =3D 400000000Hz (slot re=
q 200000000Hz, actual 200000000HZ div =3D 1)
> [   21.099546] I/O error, dev mmcblk0, sector 1000001 op 0x1:(WRITE) flag=
s 0x800 phys_seg 16 prio class 2
> [   21.099853] I/O error, dev mmcblk0, sector 1000825 op 0x1:(WRITE) flag=
s 0x800 phys_seg 8 prio class 2
> [   21.107443] Buffer I/O error on dev mmcblk0p2, logical block 0, lost a=
sync page write
> [   21.107473] Buffer I/O error on dev mmcblk0p2, logical block 1, lost a=
sync page write
> [   21.116657] Buffer I/O error on dev mmcblk0p2, logical block 824, lost=
 async page write
> [   21.124408] Buffer I/O error on dev mmcblk0p2, logical block 2, lost a=
sync page write
> [   21.132206] Buffer I/O error on dev mmcblk0p2, logical block 825, lost=
 async page write
> [   21.140178] Buffer I/O error on dev mmcblk0p2, logical block 3, lost a=
sync page write
> [   21.147973] Buffer I/O error on dev mmcblk0p2, logical block 826, lost=
 async page write
> [   21.155960] Buffer I/O error on dev mmcblk0p2, logical block 4, lost a=
sync page write
> [   21.163749] Buffer I/O error on dev mmcblk0p2, logical block 827, lost=
 async page write
> [   21.171720] Buffer I/O error on dev mmcblk0p2, logical block 5, lost a=
sync page write
> [   21.200708] I/O error, dev mmcblk0, sector 1000873 op 0x1:(WRITE) flag=
s 0x800 phys_seg 8 prio class 2
> [   21.201043] I/O error, dev mmcblk0, sector 1000929 op 0x1:(WRITE) flag=
s 0x800 phys_seg 8 prio class 2
> [   21.218287] I/O error, dev mmcblk0, sector 1000945 op 0x1:(WRITE) flag=
s 0x800 phys_seg 80 prio class 2
> [   21.218623] I/O error, dev mmcblk0, sector 1001033 op 0x1:(WRITE) flag=
s 0x800 phys_seg 24 prio class 2
> [   21.236813] I/O error, dev mmcblk0, sector 1001097 op 0x1:(WRITE) flag=
s 0x800 phys_seg 8 prio class 2
> [   21.237146] I/O error, dev mmcblk0, sector 1001121 op 0x1:(WRITE) flag=
s 0x800 phys_seg 24 prio class 2
> [   21.255370] I/O error, dev mmcblk0, sector 1001161 op 0x1:(WRITE) flag=
s 0x800 phys_seg 56 prio class 2
> [   21.256253] I/O error, dev mmcblk0, sector 1001249 op 0x1:(WRITE) flag=
s 0x800 phys_seg 8 prio class 2
> ```
>
> Specifically it seems to be writing 0x0 to DWMCI_HS400_DQS_EN that is
> the issue, if I comment out that line it works also for my odroid-xu4
> in non-hs400 mode.
>
> Tested on odroid-xu4 with odroid-xu3_defconfig after applying the
> entire series, without any other changes.
>
> Best regards,
> Henrik Grimler


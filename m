Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0090C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 20:14:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36630879D3;
	Wed, 25 Oct 2023 22:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="qLedyJXY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C447C871A0; Wed, 25 Oct 2023 21:16:08 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12olkn2080c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::80c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ADDD86FC8
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 21:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+zYbp8n0PBFi4g4TpRIllytmykiicqIC7Draiw7njQpyW/V8A72Vh+SJ+oW/YgnTnzSkx7Z58KnxpWzcRHWR4/lD4Rb/v5tagStHvbumMpuZwlIyej1BotdDsHOwPNbZxrZDsSZ10pvRxSCQWrnGjwYZHxJPdUNnT+KhP4nnGJhMY4WgrPNTIJNo5MXZwf7M0OxToXPW/lAeCtimp4XZ5cQwXopGq4oCTP+mRew1Xh2mh7M5osIrX7qoE5VqjLOAB/4aSjlSZJ30PG/GZMpLqBRY82GAODcwSdFhMpKicTvJI3Ab6nysZQQuNx88niLPOu8qMAIcfSSFGYhYMWraQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4iFEN/rx9ITL6VaRF73zpVLVRr+NkBsrAsXT5tXfEY=;
 b=ILZjXgw58So+tQzyPoG/5idS9H65l4QtecWDwJaLNHxda7XhzGIqgYACuyFQVtoMBWnvEw3QhvE0UACKoX15S8NcHc5kQK4CjoJ5qBSRBtsAeZ1ZFyezzEcu1BHKNwx9uv9ZQ7wvCvSqBIMspcHMDjmkOgbvjw+N3ImYsHYvmsIckEPiKlVkouf7CxnxHCaCow53miHLfeLJw0Fa4I2XWGfpJklLgzqZwWPztaz7HOnKQ/LiKpPZ3/AdqPYBVEXl1fWFF2GF0NhrLLzzg/Liq8LXe3hqcYWRr/4eTbdbkHqTkM94wPGbxccMLftZue1MWrsRqL+NsVHCHnboMCOsPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4iFEN/rx9ITL6VaRF73zpVLVRr+NkBsrAsXT5tXfEY=;
 b=qLedyJXYUHsmNcTaM9MdS0zCX37EOTO7p8ewyhwt02Mtr/E8UoBcAJpmhFCaGp3DiLqCgdteTxHOknSwMreA6CSVm1VJCpIMRuWDfvuo86Xp/Ir9cxRQRcwP3n2N9vbRtUp70dSeiAfzNsGdpB4Jedc6U+yrzWQJ0UlD+ke8dxK+1D5Y39/tt1ZdbGdiLLO+DdaGOoklNdOApVvGpM4yxtATwQrWs9gPq6d/6nb0T0qR2EGMJx3nojNHYypZVHnjMs6gJXfV6ePEYfd83f4n3qpSSe0kD+H66l1ir2s/3ZQ8cjhEH4+ocCJhdYYbyK1xSta65MfFh3LNJU1BlERkWg==
Received: from SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
 by LV8PR06MB9302.namprd06.prod.outlook.com (2603:10b6:408:180::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 19:16:00 +0000
Received: from SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::c40c:bbc8:b103:459c]) by SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::c40c:bbc8:b103:459c%2]) with mapi id 15.20.6863.032; Wed, 25 Oct 2023
 19:16:00 +0000
Date: Wed, 25 Oct 2023 14:15:57 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, sjg@chromium.org
Subject: Re: [PATCH 2/3] board: rockchip: Add Maskrom Mode for Anbernic RGxx3
Message-ID: <SN6PR06MB53425F96974335DCD143BEC0A5DEA@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20231017182414.321411-1-macroalpha82@gmail.com>
 <20231017182414.321411-3-macroalpha82@gmail.com>
 <3ea38028-1ab1-4dfd-8b5e-eb6eb79dd0eb@rock-chips.com>
 <SN6PR06MB5342813C5A872A749D01A588A5D8A@SN6PR06MB5342.namprd06.prod.outlook.com>
 <f6247d64-78ea-477c-a877-aa591cd3508a@kwiboo.se>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6247d64-78ea-477c-a877-aa591cd3508a@kwiboo.se>
X-TMN: [PqrOVi4DSVPnKLFgiavDoKndZ4dZPVNf]
X-ClientProxiedBy: DS7PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::17) To SN6PR06MB5342.namprd06.prod.outlook.com
 (2603:10b6:805:f9::31)
X-Microsoft-Original-Message-ID: <ZTlpbYsaNUnBlFU6@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR06MB5342:EE_|LV8PR06MB9302:EE_
X-MS-Office365-Filtering-Correlation-Id: bd160b96-e029-4a7f-e6bc-08dbd58ed2c1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6B7pweRs2nZ7StPLdjd3Zv21TXmnLLe0KJdmcY1oBenm4zUeZISnhUaWxdohnlHMB1bulIpnSuHiZ5r31P8PtTDIvj1VVPyDaDtnKHhFJlg1j1yYMaJiC14ggLtuThLWnDeDueDF2oNGphmjxQxbalgXgNJrBat6gd2XfibLBIKWdONlbaZCE++9WDZEbl7aJfqx1wwSx1H5diEF2YT+6vM8f0n51fQqWKupTKe1s1h/PbwX8msEBZ9+GKQl4/Bt95RjkXGCukpKHBzEBJh+dP8ztALNjxTHt/A7EIWE4zsHo2ntmUS9No7d96KlAUaIN+I8S2M6zFz0+Vi8ZqaOXGZbOBKGjR2jb65bMZpdq+NXh8VkaDSV4sU4IHzsvKWubVgVIspRq8GAUwMYpWVKbqoOdqhpuzg2Xdgn89P9oYSq6vxuexAFzUTKZjL92HwT2TBKtxshLVYFumHLVRL/3FfAqRCNevZOx+YIjGkXWyjCF/lQHad9xVRbIzbA75AdBhbIN+Xm7eYZkkL6cZ4q6zF67d1gpcRV/UAZuHHCCFc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v4GEzVKqclTjqkrqhJpgxqhuXFB0HtTj56ltQIHGCPjnSEN15KdXbGpWt6jr?=
 =?us-ascii?Q?quI5+lw1QxpVbcR3ixmlAgzvbHvUm3MJ8YuZ4zIcX8ODRkRfLQp7qxKCGhTm?=
 =?us-ascii?Q?PZXBCqu46YPxFWAOxzorc04w3+vlP6arLIKDcPAUmCZAZ3WL6zKA0WCNS2nI?=
 =?us-ascii?Q?VZNCimiHFgvd7pw0ByNOvKDfokBV5B0OE9y7FN/jNWBI91QveQHzNpwTripT?=
 =?us-ascii?Q?BKK8oRXdLIwgHvi52xwSmQg6ArOP8YuvuiiiPZ8dOnmcLrLiKvpX2kKXJK1H?=
 =?us-ascii?Q?C58VY2uctjGSVEtjWX8UKtUEXo9Xds+PkxmSI+A8fgQ5AeSVYniJbR+BycLB?=
 =?us-ascii?Q?zLbFfCpSnnaP58LCCTbDQIhJujWBpqrHOK6Urv4v8nQ4GTM6xQqn9Y4S7g97?=
 =?us-ascii?Q?F53LXjEvBJOKJ15J8Ss0R/y0LQ9HYADGt5pL4myfBDTdOSovXCTvZvXMi/N1?=
 =?us-ascii?Q?UsB3pyhZZzTlyjsYCra7Ydgr/071qqKcW+QzkvVybUUFC8cEQUaBVsnD1sY1?=
 =?us-ascii?Q?C8lrwByDqTjFiT+vEeYTxPsMSdjEDS9m/Ou9p+Ud5PUIHiN1SjNGaa2fTOmr?=
 =?us-ascii?Q?ExAswjFY1C9fmX8pW91fhaJYJ5wkmtVfn1ze84dG1JcCqYxpNMZ2LE6M0TIV?=
 =?us-ascii?Q?Tn0qSXKZWGbeF6bdQS77vDs5HA7/WvznF9oePG6L6P86mdMODDw4N1AK4KzM?=
 =?us-ascii?Q?ZaaawaeWsy6ImTiGKcOYTQ79blYJlVf9BCst3O1f5bh0HN9erD5iKFId/Q4w?=
 =?us-ascii?Q?HpXVRYNZ16Q5dqWRgx2jdpoaJyX199LcakLzYqcO7ZQO1DOszqtF/pRT1RXs?=
 =?us-ascii?Q?6OTMeqImzBIODBjzVfLsfxprQOYBy8bT7t6DI0cQ0o56eEF+tshoecmUiKKS?=
 =?us-ascii?Q?8bNpeBaBpyfIYU9qxtmAi3io2m1wzI8sedo0CdgZtm6y4BZA0KWscZAOsWM3?=
 =?us-ascii?Q?xzMdQzXRnjzS4T3mBCpbQ840rQnx1jCUuOA0as34vBtGEP03letkbPuNSr99?=
 =?us-ascii?Q?I9jtxIuwCvLvO0jsTcJkh+Bjz5T3T1LseBicrNQEpEKLNLWIMmCaH2mZsO3t?=
 =?us-ascii?Q?+OBnJrlOUAp38giilNcG6wO40DAeUiksuqxxuFky5QF6lvT0L4J3aTGL+cVe?=
 =?us-ascii?Q?GzSGTcLotXLmPAvRKjwx+V2OAFBDChga0srQXDLlIRK+bZfVVawGCp22Aahf?=
 =?us-ascii?Q?xwV26Y0sQyvn3zb+O6q8REQ5imcbsxb3U9Dli7N9r8OQsHmZ+oACkRao+J0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-89723.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bd160b96-e029-4a7f-e6bc-08dbd58ed2c1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB5342.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 19:16:00.7984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR06MB9302
X-Mailman-Approved-At: Wed, 25 Oct 2023 22:14:31 +0200
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

On Mon, Oct 23, 2023 at 07:12:14PM +0200, Jonas Karlman wrote:
> Hi Chris,
> 
> On 2023-10-23 17:18, Chris Morgan wrote:
> > On Mon, Oct 23, 2023 at 06:10:07PM +0800, Kever Yang wrote:
> >> Hi Chris,
> >>
> >> On 2023/10/18 02:24, Chris Morgan wrote:
> >>> From: Chris Morgan <macromorgan@hotmail.com>
> >>>
> >>> Add support for users to enter maskrom mode by holding the function
> >>> button when they power up the device.
> >>>
> >>> Since the device has soldered eMMC and sometimes does not expose a clk
> >>> pin on the mainboard
> >>
> >> This board already available, so does this clk pin available?
> >>
> >> Not only clk, other cmd/data pin is also OK to make the soc get into maskrom
> >> mode.
> > 
> > No, as near as I can tell some boards (such as the 353P and 353V) don't
> > expose a clk, cmd, or data pin. The 353M does expose a clk pin though.
> > 
> >>
> >>> there is a small chance that a user who flashes a
> >>> bad bootloader may not be able to recover if the headers themselves
> >>> are valid. As a result this check is done during spl_early_init() to
> >>> ensure that it runs as early as possible, and it does so by directly
> >>> manipulating the ADC hardware in lieu of loading the ADC driver.
> >>
> >> This key seems like a "recovery" adc key instead of "maskrom" key, right?
> >>
> >> I think we don't need to add this patch if the hardware does not really have
> >> a "maskrom" key.
> >>
> >> Basically the "maskrom" key should not depends on any software.
> > 
> > Okay, so should I rename it as a "recovery" key? Basically it's just
> > a button hooked up to ADC channel 0. I'm trying to make as simple a
> > failsafe as possible, because for the boards without the clk/cmd pads
> > I want to make it easy to debrick in the event of something like a
> > bad U-Boot stage or a bad A-TF stage.
> 
> Isn't this very similar to what arch/arm/mach-rockchip/boot_mode.c and
> rockchip_dnl_key_pressed() already does, or is supposed to do?
> 
> Maybe this existing code can be changed/fixed to work earlier in SPL and
> possible also read recovery button information from DT or Kconfig to
> work with more rockchip boards?
> 
> Would be nice if a hang/panic in SPL make rk devices reset into maskrom
> usb mode. Maybe even the watchdog can be of some use here.
> 
> Btw, you could probably also enable CONFIG_SPL_FIT_SIGNATURE for added
> protection against starting corrupt/bitrot FIT images. To speed up boot
> after adding a sha256 checksum test, you can use following rfc/patch:
> 
> [RFC] rockchip: spl: Enable caches to speed up checksum validation
> https://patchwork.ozlabs.org/patch/1802303/
> 
> Regards,
> Jonas

Thank you, yes I will look into that. That said even if we detect a
corrupt SPL stage we're still stuck unless we add the additional
reset stuff like you mention.

Yes, this is more or less identical to the rockchip_dnl_key_pressed()
function with 2 distinct differences; one this doesn't require the ADC
driver since we're manipulating the controller directly (this makes it
easier to support in SPL or maybe even one day TPL), and two the
existing function has hard-coded checks for channel 1 whereas the board
here uses channel 0 for the function button. The comments for the
existing function suggest that it's meant to be "generic" and boards
are welcome to override with their own function, which is what I'm
doing though at an earlier stage in the boot process.

Thank you,
Chris

> 
> > 
> > Thank you.
> > 
> >>
> >>
> >> Thanks,
> >>
> >> - Kever
> >>
> >>>
> >>> Ideally, once we have an open source TPL stage we can move this to
> >>> the TPL stage, so it will run even earlier.
> >>>
> >>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> >>> ---
> >>>   board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 64 ++++++++++++++++++++++
> >>>   1 file changed, 64 insertions(+)
> >>>
> >>> diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> >>> index 3d0c614623..a93b11cd47 100644
> >>> --- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> >>> +++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> >>> @@ -6,12 +6,14 @@
> >>>   #include <abuf.h>
> >>>   #include <adc.h>
> >>>   #include <asm/io.h>
> >>> +#include <command.h>
> >>>   #include <display.h>
> >>>   #include <dm.h>
> >>>   #include <dm/lists.h>
> >>>   #include <env.h>
> >>>   #include <fdt_support.h>
> >>>   #include <linux/delay.h>
> >>> +#include <linux/iopoll.h>
> >>>   #include <mipi_dsi.h>
> >>>   #include <mmc.h>
> >>>   #include <panel.h>
> >>> @@ -20,6 +22,8 @@
> >>>   #include <stdlib.h>
> >>>   #include <video_bridge.h>
> >>> +#define BOOT_BROM_DOWNLOAD	0xef08a53c
> >>> +
> >>>   #define GPIO0_BASE		0xfdd60000
> >>>   #define GPIO4_BASE		0xfe770000
> >>>   #define GPIO_SWPORT_DR_L	0x0000
> >>> @@ -33,6 +37,14 @@
> >>>   #define GPIO_WRITEMASK(bits)	((bits) << 16)
> >>> +#define SARADC_BASE		0xfe720000
> >>> +#define SARADC_DATA		0x0000
> >>> +#define SARADC_STAS		0x0004
> >>> +#define SARADC_ADC_STATUS	BIT(0)
> >>> +#define SARADC_CTRL		0x0008
> >>> +#define SARADC_INPUT_SRC_MSK	0x7
> >>> +#define SARADC_POWER_CTRL	BIT(3)
> >>> +
> >>>   #define DTB_DIR			"rockchip/"
> >>>   struct rg3xx_model {
> >>> @@ -118,12 +130,64 @@ static const struct rg353_panel rg353_panel_details[] = {
> >>>   	},
> >>>   };
> >>> +/*
> >>> + * The device has internal eMMC, and while some devices have an exposed
> >>> + * clk pin you can ground to force a bypass not all devices do. As a
> >>> + * result it may be possible for some devices to become a perma-brick
> >>> + * if a corrupted TPL or SPL stage with a valid header is flashed to
> >>> + * the internal eMMC. Add functionality to read ADC channel 0 (the func
> >>> + * button) as early as possible in the boot process to provide some
> >>> + * protection against this. If we ever get an open TPL stage, we should
> >>> + * consider moving this function there.
> >>> + */
> >>> +void read_func_button(void)
> >>> +{
> >>> +	int ret;
> >>> +	u32 reg;
> >>> +
> >>> +	/* Turn off SARADC to reset it. */
> >>> +	writel(0, (SARADC_BASE + SARADC_CTRL));
> >>> +
> >>> +	/* Enable channel 0 and power on SARADC. */
> >>> +	writel(((0 & SARADC_INPUT_SRC_MSK) | SARADC_POWER_CTRL),
> >>> +	       (SARADC_BASE + SARADC_CTRL));
> >>> +
> >>> +	/*
> >>> +	 * Wait for data to be ready. Use timeout of 20000us from
> >>> +	 * rockchip_saradc driver.
> >>> +	 */
> >>> +	ret = readl_poll_timeout((SARADC_BASE + SARADC_STAS), reg,
> >>> +				 !(reg & SARADC_ADC_STATUS), 20000);
> >>> +	if (ret) {
> >>> +		printf("ADC Timeout");
> >>> +		return;
> >>> +	}
> >>> +
> >>> +	/* Read the data from the SARADC. */
> >>> +	reg = readl((SARADC_BASE + SARADC_DATA));
> >>> +
> >>> +	/* Turn the SARADC back off so it's ready to be used again. */
> >>> +	writel(0, (SARADC_BASE + SARADC_CTRL));
> >>> +
> >>> +	/*
> >>> +	 * If the value is less than 30 the button is being pressed.
> >>> +	 * Reset the device back into Rockchip download mode.
> >>> +	 */
> >>> +	if (reg <= 30) {
> >>> +		printf("download key pressed, entering download mode...");
> >>> +		writel(BOOT_BROM_DOWNLOAD, CONFIG_ROCKCHIP_BOOT_MODE_REG);
> >>> +		do_reset(NULL, 0, 0, NULL);
> >>> +	}
> >>> +};
> >>> +
> >>>   /*
> >>>    * Start LED very early so user knows device is on. Set color
> >>>    * to red.
> >>>    */
> >>>   void spl_board_init(void)
> >>>   {
> >>> +	read_func_button();
> >>> +
> >>>   	/* Set GPIO0_C5, GPIO0_C6, and GPIO0_C7 to output. */
> >>>   	writel(GPIO_WRITEMASK(GPIO_C7 | GPIO_C6 | GPIO_C5) | \
> >>>   	       (GPIO_C7 | GPIO_C6 | GPIO_C5),
> 

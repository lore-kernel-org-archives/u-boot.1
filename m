Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB5AC4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 04:31:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F7E987B1D;
	Tue,  6 Feb 2024 05:30:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="N7fz7ESD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7624E87613; Tue,  6 Feb 2024 04:29:16 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d001::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A26086F8E
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 04:29:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jg9s1GNlVcbv1de2x+XxQUbwSlN5nADi6iuVRrq1vv+VUxJ/xx4VUi8D10ScOJ3K39BlCaWWORy4f1dwepOMHXIbta4teRONAwf9sZPTUedTffbmJoIkN0RNdUN+PypTChylIggun50iXTdV4+wrkXNU8peX7tqowCrsHQvMR3wJ23+PjcMvZThKrXnDTMmhWwXz8P1BlQ95Ew/3oiivJ3eh6q0z9kz/SskFXf2wNAK45L0H5Hj2/aolh7oHp7BiOVfbRsW6kBkKNwVjWKCcjldrF4QejBntLmcob9BgUzZxJGqUWDK06hX045P+OAJF3HgmPRJbv6YhVFD6MYZB/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecH7y52v0W7MZHGz/mE1730qd0oS1mhzPpM/WkOltiE=;
 b=i3IoRRuy6lGAL9P+ypoU7BUQDlDjTMEuBaOyRNwNqHg0Q8dBNr52+Vr+ce9LE2x4MCV22togC5iPkTTO8gFKXBO/LkjQexlklFqP8DMgXgFC4oQ0hFaYezh48eKJrD3X6T0043Dsebv9BMSGFWf7cBPZ6Yquhj9IMo+Y87sXXWM8jONtHCi1LHeNEX0ThGkbndTmfMLQizcOm8XePqy9DVta25JvqsdDn89is+ZswKqUjmzSQgCCFhcOVtOUeigbq1hKrhBIbBrCWQ0tjj1UR1kCRc8+FBGtT43tYfFGznrKkNWn3T7QFXJfarFOv4r78KWSvug943zns8nDN3+IoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecH7y52v0W7MZHGz/mE1730qd0oS1mhzPpM/WkOltiE=;
 b=N7fz7ESDGGFZEHNFydigWW7RmDWp5y1HOIXxRhX/Mti5TWJe9vCf9Msfy03W06Kf/Nlecl8zMJ0FHVuOblw81DCQYxzcEe4VlKu0n2g8jpTy4Y/eRb73G4dSCGPZTRZFotne93pSqxfvD9r8UgNG4ll2V1N127xT5CUbnJxYJ2GEdun8J0BD+K6/fembDpuie2LiiqpKZJ1Oa06c65xCVNuYxsrs33VJqJ63A3N4K2BPYtqbWGeFc9dxchsbd3ZvEnZ/f3QoUD2Ebkdhe9k6S7eLPWjjiQwJxevVZbiHC2VwpWujoJZrz6q2Ys9oVA04q8aVNq1fyB+gYUF4gIhOuw==
Received: from DM4PR05MB9229.namprd05.prod.outlook.com (2603:10b6:8:88::20) by
 SJ0PR05MB8245.namprd05.prod.outlook.com (2603:10b6:a03:393::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 03:29:10 +0000
Received: from DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::7592:72b0:48c8:ec43]) by DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::7592:72b0:48c8:ec43%5]) with mapi id 15.20.7249.032; Tue, 6 Feb 2024
 03:29:10 +0000
Date: Mon, 5 Feb 2024 21:29:08 -0600
From: Chris Morgan <macromorgan@hotmail.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, sjg@chromium.org, jonas@kwiboo.se,
 jagan@amarulasolutions.com
Subject: Re: [PATCH 4/4] board: rockchip: Add early ADC button detect for RGxx3
Message-ID: <DM4PR05MB92299F1EE25CBD786458A9BBA5462@DM4PR05MB9229.namprd05.prod.outlook.com>
References: <20240205185855.21508-1-macroalpha82@gmail.com>
 <20240205185855.21508-5-macroalpha82@gmail.com>
 <c8d71ac6-42ee-43e0-bd9c-385599cc5821@rock-chips.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8d71ac6-42ee-43e0-bd9c-385599cc5821@rock-chips.com>
X-TMN: [pMvNS5rlZ3knchE6+v/nrfatjWt4zFgZ]
X-ClientProxiedBy: DS7PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:8:2b::31) To DM4PR05MB9229.namprd05.prod.outlook.com
 (2603:10b6:8:88::20)
X-Microsoft-Original-Message-ID: <ZcGnhMf1LMThTV7j@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR05MB9229:EE_|SJ0PR05MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: fa2d38f8-1022-4af5-b8aa-08dc26c3c809
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: smY71CrTbXKulGaZVZGD4ww56vo8TAKlWQCcDteFKoEmwFoEvDY54vUzwMhtWfkRA265Hz9gjrD1DvHuh1awH7OyhIIq57wwuYJ73gHGGmC+ZGBtw/3OUhVRpJphVAcXiM+Cb8bk07GDgUtcosJPUWI0DmsFGWMaFlgfkmZf5+TvORlO3/powr5TpkCU0Q/7htaM1blM0KLC4tKuO/9sQ1hGP9CmbB+3HxLvjv3Jmrzury+m40gUpXSeVHTSglf7Ca2rGlrZHQGBmTyBtDSmaiWdvmwuVNVqZ7Tb3ri1AGSeVJCWCBqNvi8OY5XvHtnw8ORLWy8+dpi9GPOAKuISLgeecn1canF3+RGvnSr58b6G0jsCz6qhOcwOlJEi4W0I5HVurAa7axbQORkBYJk8SjwfTTNBtSd0v9X3NPyG4As+kZ1t0Nsk67lGRrKi++4NDtHEGGT+Q6C2xmoLrFD33BNI+OMQDoE0M+DO93RJ1awQQFd3YYm6+IoJ34SRmtwLew3mXFW23hah5gnYo8FtwzKMB1GHdt8xN5PJWrIPKwnAsyfzV9as2Tdeg0zzwMfZYxmO7QMr8MZj9FpytzKNXpwmobLx+zpAgPMOxhIlTw4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f5gUgCEwnKvi4mQeSDYfG0KMUlP53TdJHGJ5watpfw6nK0YzYJ8001enj1hc?=
 =?us-ascii?Q?uIoLOuoXqZ4npToDjvNsNB782ARsdLkoEi1rdD2KqoD/TU3+3QcNHE37Be2f?=
 =?us-ascii?Q?lGiqqiu2NiN3uq9VvnWbNlpPzuApVgPmveBRUwMZn3zYBEd4/oRLmOCmlNdO?=
 =?us-ascii?Q?qr+Uy9erxDogQS/uGAdOixnJ+UF2I6+PncGx5yHTDChC7gi63/awKqNXHeYN?=
 =?us-ascii?Q?Gf5IHgHtJfCutfFF386VvbAhczB8mO6hlcy+mjcZ3j+ar2A1kXq1PX5+0FM3?=
 =?us-ascii?Q?7rkvz8153IrM8jZQNh8AGoQg5a3A/eqBBZg0x0F1hETRFmVz7WEXPYtwvRI+?=
 =?us-ascii?Q?G3FHcnNPnZMPc8/elddHM3K+hm/BZLwq/AOhEPHujNIDB++AEpBll9bXVJvj?=
 =?us-ascii?Q?xpHsvHid+9/JMFDRGBjSiouUPGz2lP57OwRPOng2w/e4kckVsB63cAgp1r/e?=
 =?us-ascii?Q?WXUCe+QF/McxPV6pG7KEQgaZXQgbjqtDiO/lBtyW5ASzAhjX7BOXqp//anGd?=
 =?us-ascii?Q?marjxpazZxJ1fEG1RvHIAcwht3JUHx69cm3ZpapbzFfccbPPloeopu9Wyue0?=
 =?us-ascii?Q?UkC0s2y4jEubHWHcDC30eCoVtWqfYbLzKIJVmT4chmMdb5WU7XsSRg3h+ciX?=
 =?us-ascii?Q?2bbRwX/89OLIT8S3pmtGuWbCU+j+ikBKWq4L0MgtPmJY360LPwb5F4pwI3ZK?=
 =?us-ascii?Q?FuCZUzoMGqRLEhPxVgoKlAc5z1+dU9Jca+m3H3uDRfqf6xMMjmfiJj6BQQQd?=
 =?us-ascii?Q?k4aqnsZlRz9At2byO854iEcWC4EC5o8/cZJx33W4MsCchrvz5evK0xZ9BMIa?=
 =?us-ascii?Q?C96TutU7r8JBxI0RGGABd6ct8+myGUCwGPTKi3jyC4mB1qS1q3yJThglw+SA?=
 =?us-ascii?Q?UQeHfGy3+2dEY0q72B3ksdI/5t+VhpwAEPwVhjR9s8XovDhAHO7v/Bpdgm+Y?=
 =?us-ascii?Q?vWpuf0Fjkeki/Iaf3W8rhGwdYmshsdv21d9aWKPUSPu0lM6Y77fgaA3ObRuV?=
 =?us-ascii?Q?QdkciLc7Y/Rr1fXWWe+/MNUHhSFzbjKCf935ka/ouXIiehSMSBACcxDlbYBz?=
 =?us-ascii?Q?12hsqjyD3sjPiY/uG//K8DF997LQfGTdu7uZci6VQi+b36pZmVTX6abEwwFk?=
 =?us-ascii?Q?0na2jDQFV8/hM0D4vpd5lp4FL+TsON2N3oR7sW/pStbTlmLDSsPrOXpdj6bV?=
 =?us-ascii?Q?F0VTbqRVM7akiNCwYZBBl82klL547gmFO9qrV/MIp/Z/xtbErJ5g3Di9Csg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4823-7-msonline-outlook-84f76.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2d38f8-1022-4af5-b8aa-08dc26c3c809
X-MS-Exchange-CrossTenant-AuthSource: DM4PR05MB9229.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 03:29:09.9007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB8245
X-Mailman-Approved-At: Tue, 06 Feb 2024 05:30:45 +0100
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

On Tue, Feb 06, 2024 at 10:53:13AM +0800, Kever Yang wrote:
> 
> On 2024/2/6 02:58, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add ADC button detect for early SPL stage for RGxx3 device. This is
> > important because on at least the RG353P and RG353V a clk pin is not
> > exposed that would allow us to take the eMMC out of the boot path.
> 
> This is another version of below patch, right?
> 
> https://patchwork.ozlabs.org/project/uboot/patch/20240102154654.191055-5-macroalpha82@gmail.com/
> 
> 
> Compare to this one, I would prefer previous version :(

It is another version of the patch. I did (redid) this in response to
comments on that patch series.

I basically face a unique set of constraints, and am trying to solve
for it. Those constraints are 1) I have a few boards, namely the
Anbernic RG353P and RG353V that do not have exposed pads that would
allow me to remove the eMMC from the boot path, 2) The SDMMC slot
present is after the eMMC in the boot path, and 3) after the binary
A-TF loads the reset to usb loader fails to work properly and simply
resets the board (but not to maskrom as needed/requested).

Your past comments suggested it would not be needed/useful to have this
done in a board generic way, which I understand; so I'm simply doing
it again in a board specific way. Note that I will shortly be
resubmitting another U-Boot request for the Powkiddy X55 which also
needs this; I'm not aware of any other boards currently that will
though.

So I guess my questions that would answer the path forward are
1) should this be done in a board specific way (like so) or should I
go back to the board generic method. 2) Will the binary A-TF be fixed
to allow me to reboot to maskrom mode or is that by design?

Note I've tested this also with the pending A-TF source at
trustedfirmware.org. Sadly I need SCMI clk support before I can replace
the binary A-TF with the open source one.

Thank you,
Chris

> 
> 
> Thanks,
> 
> - Kever
> 
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >   board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 64 ++++++++++++++++++++++
> >   1 file changed, 64 insertions(+)
> > 
> > diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> > index 5c57b902d1..099eea60c3 100644
> > --- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> > +++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> > @@ -6,12 +6,14 @@
> >   #include <abuf.h>
> >   #include <adc.h>
> >   #include <asm/io.h>
> > +#include <command.h>
> >   #include <display.h>
> >   #include <dm.h>
> >   #include <dm/lists.h>
> >   #include <env.h>
> >   #include <fdt_support.h>
> >   #include <linux/delay.h>
> > +#include <linux/iopoll.h>
> >   #include <mipi_dsi.h>
> >   #include <mmc.h>
> >   #include <panel.h>
> > @@ -19,6 +21,8 @@
> >   #include <stdlib.h>
> >   #include <video_bridge.h>
> > +#define BOOT_BROM_DOWNLOAD	0xef08a53c
> > +
> >   #define GPIO0_BASE		0xfdd60000
> >   #define GPIO4_BASE		0xfe770000
> >   #define GPIO_SWPORT_DR_L	0x0000
> > @@ -32,6 +36,14 @@
> >   #define GPIO_WRITEMASK(bits)	((bits) << 16)
> > +#define SARADC_BASE		0xfe720000
> > +#define SARADC_DATA		0x0000
> > +#define SARADC_STAS		0x0004
> > +#define SARADC_ADC_STATUS	BIT(0)
> > +#define SARADC_CTRL		0x0008
> > +#define SARADC_INPUT_SRC_MSK	0x7
> > +#define SARADC_POWER_CTRL	BIT(3)
> > +
> >   #define DTB_DIR			"rockchip/"
> >   struct rg3xx_model {
> > @@ -157,12 +169,64 @@ static const struct rg353_panel rg353_panel_details[] = {
> >   	},
> >   };
> > +/*
> > + * The device has internal eMMC, and while some devices have an exposed
> > + * clk pin you can ground to force a bypass not all devices do. As a
> > + * result it may be possible for some devices to become a perma-brick
> > + * if a corrupted TPL or SPL stage with a valid header is flashed to
> > + * the internal eMMC. Add functionality to read ADC channel 0 (the func
> > + * button) as early as possible in the boot process to provide some
> > + * protection against this. If we ever get an open TPL stage, we should
> > + * consider moving this function there.
> > + */
> > +void read_func_button(void)
> > +{
> > +	int ret;
> > +	u32 reg;
> > +
> > +	/* Turn off SARADC to reset it. */
> > +	writel(0, (SARADC_BASE + SARADC_CTRL));
> > +
> > +	/* Enable channel 0 and power on SARADC. */
> > +	writel(((0 & SARADC_INPUT_SRC_MSK) | SARADC_POWER_CTRL),
> > +	       (SARADC_BASE + SARADC_CTRL));
> > +
> > +	/*
> > +	 * Wait for data to be ready. Use timeout of 20000us from
> > +	 * rockchip_saradc driver.
> > +	 */
> > +	ret = readl_poll_timeout((SARADC_BASE + SARADC_STAS), reg,
> > +				 !(reg & SARADC_ADC_STATUS), 20000);
> > +	if (ret) {
> > +		printf("ADC Timeout");
> > +		return;
> > +	}
> > +
> > +	/* Read the data from the SARADC. */
> > +	reg = readl((SARADC_BASE + SARADC_DATA));
> > +
> > +	/* Turn the SARADC back off so it's ready to be used again. */
> > +	writel(0, (SARADC_BASE + SARADC_CTRL));
> > +
> > +	/*
> > +	 * If the value is less than 30 the button is being pressed.
> > +	 * Reset the device back into Rockchip download mode.
> > +	 */
> > +	if (reg <= 30) {
> > +		printf("download key pressed, entering download mode...");
> > +		writel(BOOT_BROM_DOWNLOAD, CONFIG_ROCKCHIP_BOOT_MODE_REG);
> > +		do_reset(NULL, 0, 0, NULL);
> > +	}
> > +};
> > +
> >   /*
> >    * Start LED very early so user knows device is on. Set color
> >    * to red.
> >    */
> >   void spl_board_init(void)
> >   {
> > +	read_func_button();
> > +
> >   	/* Set GPIO0_C5, GPIO0_C6, and GPIO0_C7 to output. */
> >   	writel(GPIO_WRITEMASK(GPIO_C7 | GPIO_C6 | GPIO_C5) | \
> >   	       (GPIO_C7 | GPIO_C6 | GPIO_C5),

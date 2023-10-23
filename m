Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469CCC25B41
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 16:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E66AC8792C;
	Mon, 23 Oct 2023 18:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="qM24MCyl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37584878E7; Mon, 23 Oct 2023 17:18:41 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12olkn20820.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::820])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED06C87825
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 17:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCjfNBTRnKIIqgtYPbyH9ar0cf5oXhkYtUkRN+T7c+Sh0c8HQ9lQIYQvz63ORkgOWrqOJrUcbm7LwXr7jE8A17iL4hV2L7c85tSZeJcWu4FCi6ymP91hoSQ/AGKb2cX11dBUUFq0CjGOzF+61/MZA05qyyacF3H7Eqy/HMP2NUDe984UAkweU+fSpRZi1FbR2ExSP635z2uas7DEfC3rGno3X2Z+WXn6yKQRcakzGz6ahd3zU3Jv5KkFgOWvwwPI8hjgaIWZ0fqLGhJHJhBzxBdGl1Mg4s1jGk3MPGo04Vy874ye3qk1CUSXp4J9GeK4wCbrPpVh91OtPdtT/w0LIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQz7b0fWiFzL/sH3fn5jGdErw7WO74gO+8Mpd4MadKU=;
 b=oA1cLzLmshRjfoTny6OADWqT3zu0BckEIdS148J7X/J8o6yf29lRnCYSpqaexVytFRxXanBuWquGerfwoO7aX+dGZRzxumwR60UHjlws+9LbCs8M4Qfxo6NiUCS+Q1uJZNwof4iJwiFGyZOx3gEcr9EszMAxbFZDBRlCLt9kIybAIgPIHQsbTye1pEj7oGKCsXhhXqy/CXi4ljUTUouRxMRflXJ2JIcjn9+uHbMBNRz53fEwRg+QQWz8jNUhv/rLB4XpJ+ZzyKdx9P0fSad6K0z6UVAtWLhtLomMVvCkIi+fEBiuGrkThcCtYkoFTykCwUd8lSyDW5T2Y0eF9KlGsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQz7b0fWiFzL/sH3fn5jGdErw7WO74gO+8Mpd4MadKU=;
 b=qM24MCylj4gn0InVTPd8RNf3T33UTJe8FrLnlqLIP4JmzuzYy3RxMhQK0B8tdJsE9IKncS7M/PjA5v9/T2GsEemi1NqxsqcX3cJQEnQI9lXtaDrBkHDJoMKPzersYN5roNsYjRokE1jglmPvwcw3sZ+T02few28Q4Vzohuzviw5j42KrJ57KSINCh64nm1EB+voIpRYAsh9RRhcm1vognYJCt0xD2/3cT2ppvUsj3wz/yXT+te4V000QzMz8xvH4yNQ5nv/VTlFTfDgFq55pmvK7HU+EngRUYuIEJvJrGmsmFQ1S98SgoX6dwpEbhUer+5NaiQ25zhHl1mr0zpKIWw==
Received: from SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
 by CH2PR06MB6680.namprd06.prod.outlook.com (2603:10b6:610:83::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Mon, 23 Oct
 2023 15:18:35 +0000
Received: from SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::c40c:bbc8:b103:459c]) by SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::c40c:bbc8:b103:459c%2]) with mapi id 15.20.6863.032; Mon, 23 Oct 2023
 15:18:35 +0000
Date: Mon, 23 Oct 2023 10:18:32 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, sjg@chromium.org
Subject: Re: [PATCH 2/3] board: rockchip: Add Maskrom Mode for Anbernic RGxx3
Message-ID: <SN6PR06MB5342813C5A872A749D01A588A5D8A@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20231017182414.321411-1-macroalpha82@gmail.com>
 <20231017182414.321411-3-macroalpha82@gmail.com>
 <3ea38028-1ab1-4dfd-8b5e-eb6eb79dd0eb@rock-chips.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ea38028-1ab1-4dfd-8b5e-eb6eb79dd0eb@rock-chips.com>
X-TMN: [twPvNO2dYPXrSQzvcFFhEQl8iw687WPk]
X-ClientProxiedBy: SN7P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::24) To SN6PR06MB5342.namprd06.prod.outlook.com
 (2603:10b6:805:f9::31)
X-Microsoft-Original-Message-ID: <ZTaOyHxK92AEoFNx@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR06MB5342:EE_|CH2PR06MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: 9700ebd9-331a-4ce6-714e-08dbd3db52f4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XLwamf8NDtERsGNE5YWWiZ3YH9Jsr4fi8Z07kFTKltSN01fKRjswq4xzxLHxgW/ODra9W9VQUJLa0uvVFVuf60yYxI3kS6E1vg3rTZujIzhklz1c316Okq07W33uoCBPFh4zbx+YrlGPK4hJw5qVYrj8PGRFBUTgBZDJ6R34jU510YHdc+c19FzbHJLo6cqn0QgXNzFOC24gam81zM/HKaCQ82uc64Yu06Yv3Le+xddtnJ2LQUC1KgCSCScKJn0K153N2nCXTRc0c9MhrovjDjlov9OO5cYi/srA5DjN2sjFgGbqqPTSmUlaVWPbNyWfo/rtvSr1Pthgsk79P8qzFRtP0e/tGbXJbGmCHMrTBfivkjdsV1SQ+ZDZHTdQmveSEgR9gbLqZGX72VWe90XP72lCK+kWlNDw9D8FzBWrsPGPBXUEe2vUtKGYvgvVOt0VTlLwV/JSgMUktazqo9PjyoBKgmdGTxUBHHlQWGy/OpKaNPwKJ/WwosFaw9+zIPrxBoIGsZxnwGd8fFmgQV8pLCf19VZ31XyOCIDKzf20YjM5k5VBSJXg5HOmEBf6NoSk
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HI6Iq3QtR4QmtmH+Gsa+/qdYF3VV5n4ummZEv/wLPouFb5Yk10Qr5Jtc6uzs?=
 =?us-ascii?Q?Y0+O7T/VnQ/fx0ujoRXyvaEajdXNacTON9lxlHRiVWHYqtDICdwQFax/GqTf?=
 =?us-ascii?Q?0rPy97w4211aqoAK0mOR6JeePMEhasEoYIsrWbMh0ZKZHUagaPYoJEssj4lJ?=
 =?us-ascii?Q?sC6MVoMWwhQmfiNON+Wqv8V000fe4ADjo+uQg4G+29aFaxeg3hYqrWpWSwTO?=
 =?us-ascii?Q?TDKmmogpnrTeLWnsNxWZlNYRxW0MEkfCQR0fT72SZqAfWHtRIRChQ3YYaIdw?=
 =?us-ascii?Q?8J0my2u3wAdl+RRegi8o0TJjpGSivrkmFoZ0a5V+ysD3LtiZ9skqYsTkQFZI?=
 =?us-ascii?Q?5sq54aZ0qi7aUBCRy8cgzLHJ4C7VB5wLCPwlMAu/FEz8qMYQpVMHrcSmX5KI?=
 =?us-ascii?Q?K9ag77nOytwL+kw5+2uvzwAunPjI6zvEiMdlThUQWL9Mw1xynGxoZPfEQa3F?=
 =?us-ascii?Q?OUDMDIP8SBS3tBYEQE2dw+fr6palarVBqNAvIwvDO2NSBGzzRDI+FXUxlzW3?=
 =?us-ascii?Q?ycun6KSHX7FekELeEewHLUAeCIVCmxbzxhIBbuM+tHgQOTp6UAWIeKum0jwG?=
 =?us-ascii?Q?EAu2doE2RSUVc84BgF8JC3ofglonwPbpM/DT7oG4hDuJEbqCMowbOd20w2eI?=
 =?us-ascii?Q?Q6xzskll5VVd9YtC+UciefC2dLCbAl9JV2Wb4O1VoqQin9X8xizB67lqvoXC?=
 =?us-ascii?Q?5eNJMLpK0sXmbPiWzZxMYWsV7lntAcbHFGpWkx7izS47gN4/YrGZJSed72WA?=
 =?us-ascii?Q?iEq0t3vMP/OshiGfFvyCO6WTE3sdICvuhyrN/IyXezf9YsC2FYq6mQQiOhnZ?=
 =?us-ascii?Q?YL+vvErTmCI3Ff0tjOtpNymxd5E89U5ZauDNMj9RK3aA2wcQWvrFtgjbykan?=
 =?us-ascii?Q?3+f7GgTvRI0bziHVIU4ch5Pz9xiQ7HcsHOJwFvExopuZGn+wHbYBi9zm+cIM?=
 =?us-ascii?Q?FhV8drjc0nBVBx66WpMhAO+XBo/5rAML7pqvRearbNlivKDttvMa8JwLHFOV?=
 =?us-ascii?Q?kkvtQ16KSclzy0gRT9LP4IWsw9PRyiu3JHRp+P9JXnPhMTuSdzq6JsoohMeA?=
 =?us-ascii?Q?bPrn8dzVQVfsTzJbdSp4SF5y8/Q7usciJ7WwEo+YPmNUBXuGVjsL8sWlS4bP?=
 =?us-ascii?Q?Pv4iKq1rdkLG/2vpXpQJnbXimVPOgs8Lo0hf+FFfceHw2sl1eob2Uobcps7R?=
 =?us-ascii?Q?WcIWwvVBO3wJjYyJS58u/z3jAH6oe+J4UH7JLm3irvLLFDIjQM2Yqa4S/7A?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-89723.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9700ebd9-331a-4ce6-714e-08dbd3db52f4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB5342.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 15:18:35.5488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR06MB6680
X-Mailman-Approved-At: Mon, 23 Oct 2023 18:53:56 +0200
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

On Mon, Oct 23, 2023 at 06:10:07PM +0800, Kever Yang wrote:
> Hi Chris,
> 
> On 2023/10/18 02:24, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add support for users to enter maskrom mode by holding the function
> > button when they power up the device.
> > 
> > Since the device has soldered eMMC and sometimes does not expose a clk
> > pin on the mainboard
> 
> This board already available, so does this clk pin available?
> 
> Not only clk, other cmd/data pin is also OK to make the soc get into maskrom
> mode.

No, as near as I can tell some boards (such as the 353P and 353V) don't
expose a clk, cmd, or data pin. The 353M does expose a clk pin though.

> 
> > there is a small chance that a user who flashes a
> > bad bootloader may not be able to recover if the headers themselves
> > are valid. As a result this check is done during spl_early_init() to
> > ensure that it runs as early as possible, and it does so by directly
> > manipulating the ADC hardware in lieu of loading the ADC driver.
> 
> This key seems like a "recovery" adc key instead of "maskrom" key, right?
> 
> I think we don't need to add this patch if the hardware does not really have
> a "maskrom" key.
> 
> Basically the "maskrom" key should not depends on any software.

Okay, so should I rename it as a "recovery" key? Basically it's just
a button hooked up to ADC channel 0. I'm trying to make as simple a
failsafe as possible, because for the boards without the clk/cmd pads
I want to make it easy to debrick in the event of something like a
bad U-Boot stage or a bad A-TF stage.

Thank you.

> 
> 
> Thanks,
> 
> - Kever
> 
> > 
> > Ideally, once we have an open source TPL stage we can move this to
> > the TPL stage, so it will run even earlier.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >   board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 64 ++++++++++++++++++++++
> >   1 file changed, 64 insertions(+)
> > 
> > diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> > index 3d0c614623..a93b11cd47 100644
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
> > @@ -20,6 +22,8 @@
> >   #include <stdlib.h>
> >   #include <video_bridge.h>
> > +#define BOOT_BROM_DOWNLOAD	0xef08a53c
> > +
> >   #define GPIO0_BASE		0xfdd60000
> >   #define GPIO4_BASE		0xfe770000
> >   #define GPIO_SWPORT_DR_L	0x0000
> > @@ -33,6 +37,14 @@
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
> > @@ -118,12 +130,64 @@ static const struct rg353_panel rg353_panel_details[] = {
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

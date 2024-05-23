Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F07CC25B79
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 21:54:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B92928820C;
	Thu, 23 May 2024 23:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="UrnpL1hp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36641885C5; Thu, 23 May 2024 22:53:54 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azolkn190140000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d005::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDB8E885C5
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 22:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WscPnJ94952dpFA+Ul+cjp8OOSnm65qF4OxjCTedSixnb+jf1TcWJioMbtGqJHnSaZuPKxPEnBvvfNrrReFdj2T+U3U4YkU5nJ3XfEEmTPyutExqZvZ3Hn4uFXDboY1BCZB/ENo5ZoefS9xdoLX82bkewHuIsE5tjRiRm6ppamQaf/0jnCVSIE6fGgxf8xr+gBllxuEJus94OUHVx/2HpAITXxT2iLPYmPwgA98yAaZBBG2FWBVUxDgzPKMcZAYhlYfOisnQwBs90398bcg02eEXLArdY1hKj4JdTUjORny2pOZjBLLKdw+muaJP2akGSzbMtM8L7fvqL6vIXl2iag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8+ugwDWL0Kh++wIi6fIQlEMrhD2cHIStHgCayySzik=;
 b=aZvURngDKijlIagC8OG6BIKQBvuzndnvZyUUd4xctwnMSYKrg0AHOl8+9YGRNJ6PHfTRYdQUhaHQ+E7WSQvPKIPY7LZqNdKLZN+CyYFqKho7Y2/gO28IQ5IB5GMcXKTfWW2t2+nOUXTsjD0yeIqg/PZbWUzzMbHFEH310WcXSyk4UDhumrpkTFWu9ePhPD14jDIUmUGvcfxEmyUFILFJCTefpTsuVgzuJMrqWMJGu+ueFfH4tGAol1bOxM8xDOj/IS0/ezJupspS3bWjQAHIBqVgWzw92foAEx0mpe10fWD9n6GI2ckM/uNoJxnOZNedp/hMkIeOaN2eLzNKOxAm9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8+ugwDWL0Kh++wIi6fIQlEMrhD2cHIStHgCayySzik=;
 b=UrnpL1hp4WEpEXkZFcZ6fY3/V9QIeN6KXmnKLosHBckYnTQM6RSH+NDGtASDcMvqjiuCt6c8y8qOLeJ++hgRkXZ2EY6cDJ5lUug2YJcw+u1SNKrE1HEgbWgo4+3UhSaf1a7ODW8MVLTEFmSZ8u78InG2ipek0JJOtea0jgovjBMO+tcgnrDZisjWaBZXW/fQWBrWB6LCbtu0Hd90N0TXNXPnBq4kSg/cKiNSBGdsT7Sbq+yXXblWH6pdwH1pTsqqVOJbklUyfflaU5HbDJq3lyefvDhAMB31G6GhJCIs9XneZpwb1KWdJ1ovqhsHcPxIX+KD3TT1Xmsepb6L50iXbA==
Received: from DM4PR05MB9229.namprd05.prod.outlook.com (2603:10b6:8:88::20) by
 SA3PR05MB9646.namprd05.prod.outlook.com (2603:10b6:806:311::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.16; Thu, 23 May
 2024 20:53:49 +0000
Received: from DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::d720:e9e5:929:c7ff]) by DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::d720:e9e5:929:c7ff%4]) with mapi id 15.20.7633.001; Thu, 23 May 2024
 20:53:48 +0000
Date: Thu, 23 May 2024 15:53:46 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 jonas@kwiboo.se, trini@konsulko.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org
Subject: Re: [PATCH 1/2 V2] Revert "board: rockchip: Add early ADC button
 detect for RGxx3"
Message-ID: <DM4PR05MB92292A986D18B341CC975C56A5F42@DM4PR05MB9229.namprd05.prod.outlook.com>
References: <20240521154549.255607-1-macroalpha82@gmail.com>
 <20240521154549.255607-2-macroalpha82@gmail.com>
 <d16dfbc4-a1fe-45fe-b0ee-2b3117704fc2@rock-chips.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d16dfbc4-a1fe-45fe-b0ee-2b3117704fc2@rock-chips.com>
X-TMN: [reOgpdbHSO0L6C8UIX16gBfL0iamukNb]
X-ClientProxiedBy: SA1P222CA0155.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::25) To DM4PR05MB9229.namprd05.prod.outlook.com
 (2603:10b6:8:88::20)
X-Microsoft-Original-Message-ID: <Zk+s2pmkzefxKSHa@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR05MB9229:EE_|SA3PR05MB9646:EE_
X-MS-Office365-Filtering-Correlation-Id: 68bbee4a-c135-483f-b7a1-08dc7b6a71a1
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016;
X-Microsoft-Antispam-Message-Info: vDqdUEC2MYCnQhOE5+xhPrz8PuCdKwSXoyW4H7K5+YdQpnsWA2X5PjAuKGBogpiroFeWbxgZXOMhF+SnQKriCgh3R9criEnHVi7OQBjM8O+TQWbQmtphb8pe0UUXu1p5mAbYFQrxyvH78tdNG7PDXtyvLY/h/dFMltfNiqLiCCmOwF29gvCDXdSS5ydamQCRBLzm3hBwFbt88Cm1CJb/mCp03WAnV/jsJ9BK+blyXYbqDRNQ9eZwP8bRRlLjx/rN0KAitgq7/tlSwjF1+Jz1AAb8aitHx7yXWgudiOljEVvxt4lUJDTqCYau4G+CQ/AD9+ozAQlFj1L5tpgDTKY+KZFhB/UnjnGdODD0iKKH7CvQMPfZ18GWKl8trkxmjA707czGM7CEPAXXRRxsar/U4atXfOUjkPnPUhmBCMTkl6RvyJdGHOewXrXsXqq5ifIdRuW1zklQG10K4kzV9qfYFmtR0vAlQW3iJA8Kb7xO8y89tSlAbsQ0GKu1//b3X4aaQ+3WM3tSIV0gcFM1ZHSQ8/mTPMjYbJyJi4lYQT4FC7FpRDmok6lmnaPSl03m82Mg
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EDEtx0zWplr18AiR4ULWfRsXBDXpyPgfVZTrW108eVLDxuc7G3zYS1I0y649?=
 =?us-ascii?Q?UiQ/lk0OTQsSeBu4S7Qb2O6oDOg0vgglg3W9HH2y4OTK6khLnX5pRT3xAs2S?=
 =?us-ascii?Q?2Kowf5VtW9LVisTgGT6x3E3+6alPzmRaO6ZP2kXaqUxiql+ew6B4iiY4unfJ?=
 =?us-ascii?Q?YkS7EFETe0cYyQler1ppJeO0pbUo7kHYuLq4FTMBSr3zyfhteev19mXkl2Su?=
 =?us-ascii?Q?cqAYlEjBKMqRu2zVxOSFN3AzgS3YbqcktnDOnh/n++7fxsB+mzaRCfz2Pl+U?=
 =?us-ascii?Q?PjZaqXzTNo5ORxWvwjTEPYF1KxB6erGIVtNqv4yQj2As2C8SaAOilg/d14r/?=
 =?us-ascii?Q?WqUF7XS/Ux4l+Dbe9ctNKWjgefESXa0FpTM5uQZZK1DsaYK9Nob6Lg6zwlme?=
 =?us-ascii?Q?YC85L1FDlkxOwz4rT7l1J+U8zWPXGonFvjF6WRyGUYd+JD8LuKKodQmAW5kd?=
 =?us-ascii?Q?cvwTkQNCOVCPx/Eww3AQ/rjF38VjVb5OZQ/LuxjlatvCVFZkvZoiQEaMyiKJ?=
 =?us-ascii?Q?EDrKpf202McBbOCuPobIbxh3qxBkRegvHZ5zzxO5K6ThmePl9gN7WF4ZfWex?=
 =?us-ascii?Q?0TFfhRvg+rQD7awTb47PdxEPmnolREMOGQt+1kQlOakCj0pqcWzyvMAswMJz?=
 =?us-ascii?Q?dsiBGZIZSpXvHUVBhRCOqciZB04J5depv+QONxySCwTwUBqxkH37NqGbK66R?=
 =?us-ascii?Q?DdgYdMJER4oP8QH4g9/qC1dMpnZT2QX6rnYxqxlo33pKBO9K7wrV5mcL1vCQ?=
 =?us-ascii?Q?1yVMW2lzYzZ9/QrhFgdRAfWdPZvBokm8kN/YWVbnaa5lhgWfSptyAv0Glxu5?=
 =?us-ascii?Q?0eHOg4PfLeSDEKzkY2sXCEA8EHFKRNFljSUByDUPl5/v9fgzNp7NCXl/WqRT?=
 =?us-ascii?Q?4kbvBuJqIl7HlW5QCkECfvIaA8pw1IMB2WS3rABOlhFAWTRIWGn/FqPMHLuW?=
 =?us-ascii?Q?tv+rlet6vHwojMptvV1YQf9gdpE4MKIIzMDuENUcnoSPj2gBdhX2pXqXP0FW?=
 =?us-ascii?Q?VVy6Gn/itvfplVdY2l/EcImrrVT4oDz+tIybJC3TsgQQSgvcpcvmsaKKgGu1?=
 =?us-ascii?Q?zCt7jrAmAfxqrEiElz+cm9lJ0JxH1LJDqjjFUTc/QXEUZ4tyascG5UHmnwA8?=
 =?us-ascii?Q?cDclPD3pOGmCjypIBB45x5eZoYIX0Ls+cPwS1IiLbNqlao7P4Vk0WpywA5aR?=
 =?us-ascii?Q?bXqPiSQw9jhGQQPrRDb8gu2oT+/ZnqT8C6xEE4z2XdKKloxP46IVsypwEYA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4823-7-msonline-outlook-84f76.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 68bbee4a-c135-483f-b7a1-08dc7b6a71a1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR05MB9229.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 20:53:48.6774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR05MB9646
X-Mailman-Approved-At: Thu, 23 May 2024 23:53:57 +0200
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

On Thu, May 23, 2024 at 11:47:41AM +0800, Kever Yang wrote:
> 
> On 2024/5/21 23:45, Chris Morgan wrote:
> > From: Chris Morgan<macromorgan@hotmail.com>
> > 
> > This reverts commit 41a60d0e5cef54a59596a58940fa7c9cf071034b.
> > 
> > On some of the supported devices the adc detect code always returns
> > that the button has been pushed, and as a result the device will
> > not boot normally.
> 
> Have you check the key input voltage with voltameter which can identify is
> hardware issue or software issue.

It's a software issue. I confirmed I actually could have fixed it by
using the ADC driver (which sets up the interrupt registers correctly).
However, there is something to be said of keeping things simple. I
should have taken your advice from the get-go and just done that.

Thank you.
Chris

> 
> 
> Thanks,
> 
> - Kever
> 
> > 
> > Signed-off-by: Chris Morgan<macromorgan@hotmail.com>
> > ---
> >   board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 64 ----------------------
> >   1 file changed, 64 deletions(-)
> > 
> > diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> > index 099eea60c3..5c57b902d1 100644
> > --- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> > +++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> > @@ -6,14 +6,12 @@
> >   #include <abuf.h>
> >   #include <adc.h>
> >   #include <asm/io.h>
> > -#include <command.h>
> >   #include <display.h>
> >   #include <dm.h>
> >   #include <dm/lists.h>
> >   #include <env.h>
> >   #include <fdt_support.h>
> >   #include <linux/delay.h>
> > -#include <linux/iopoll.h>
> >   #include <mipi_dsi.h>
> >   #include <mmc.h>
> >   #include <panel.h>
> > @@ -21,8 +19,6 @@
> >   #include <stdlib.h>
> >   #include <video_bridge.h>
> > -#define BOOT_BROM_DOWNLOAD	0xef08a53c
> > -
> >   #define GPIO0_BASE		0xfdd60000
> >   #define GPIO4_BASE		0xfe770000
> >   #define GPIO_SWPORT_DR_L	0x0000
> > @@ -36,14 +32,6 @@
> >   #define GPIO_WRITEMASK(bits)	((bits) << 16)
> > -#define SARADC_BASE		0xfe720000
> > -#define SARADC_DATA		0x0000
> > -#define SARADC_STAS		0x0004
> > -#define SARADC_ADC_STATUS	BIT(0)
> > -#define SARADC_CTRL		0x0008
> > -#define SARADC_INPUT_SRC_MSK	0x7
> > -#define SARADC_POWER_CTRL	BIT(3)
> > -
> >   #define DTB_DIR			"rockchip/"
> >   struct rg3xx_model {
> > @@ -169,64 +157,12 @@ static const struct rg353_panel rg353_panel_details[] = {
> >   	},
> >   };
> > -/*
> > - * The device has internal eMMC, and while some devices have an exposed
> > - * clk pin you can ground to force a bypass not all devices do. As a
> > - * result it may be possible for some devices to become a perma-brick
> > - * if a corrupted TPL or SPL stage with a valid header is flashed to
> > - * the internal eMMC. Add functionality to read ADC channel 0 (the func
> > - * button) as early as possible in the boot process to provide some
> > - * protection against this. If we ever get an open TPL stage, we should
> > - * consider moving this function there.
> > - */
> > -void read_func_button(void)
> > -{
> > -	int ret;
> > -	u32 reg;
> > -
> > -	/* Turn off SARADC to reset it. */
> > -	writel(0, (SARADC_BASE + SARADC_CTRL));
> > -
> > -	/* Enable channel 0 and power on SARADC. */
> > -	writel(((0 & SARADC_INPUT_SRC_MSK) | SARADC_POWER_CTRL),
> > -	       (SARADC_BASE + SARADC_CTRL));
> > -
> > -	/*
> > -	 * Wait for data to be ready. Use timeout of 20000us from
> > -	 * rockchip_saradc driver.
> > -	 */
> > -	ret = readl_poll_timeout((SARADC_BASE + SARADC_STAS), reg,
> > -				 !(reg & SARADC_ADC_STATUS), 20000);
> > -	if (ret) {
> > -		printf("ADC Timeout");
> > -		return;
> > -	}
> > -
> > -	/* Read the data from the SARADC. */
> > -	reg = readl((SARADC_BASE + SARADC_DATA));
> > -
> > -	/* Turn the SARADC back off so it's ready to be used again. */
> > -	writel(0, (SARADC_BASE + SARADC_CTRL));
> > -
> > -	/*
> > -	 * If the value is less than 30 the button is being pressed.
> > -	 * Reset the device back into Rockchip download mode.
> > -	 */
> > -	if (reg <= 30) {
> > -		printf("download key pressed, entering download mode...");
> > -		writel(BOOT_BROM_DOWNLOAD, CONFIG_ROCKCHIP_BOOT_MODE_REG);
> > -		do_reset(NULL, 0, 0, NULL);
> > -	}
> > -};
> > -
> >   /*
> >    * Start LED very early so user knows device is on. Set color
> >    * to red.
> >    */
> >   void spl_board_init(void)
> >   {
> > -	read_func_button();
> > -
> >   	/* Set GPIO0_C5, GPIO0_C6, and GPIO0_C7 to output. */
> >   	writel(GPIO_WRITEMASK(GPIO_C7 | GPIO_C6 | GPIO_C5) | \
> >   	       (GPIO_C7 | GPIO_C6 | GPIO_C5),

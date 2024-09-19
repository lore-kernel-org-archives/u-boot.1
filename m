Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A33FCF3962
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 17:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7647689288;
	Thu, 19 Sep 2024 19:29:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="oP1/9I3N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42A718916B; Thu, 19 Sep 2024 15:15:43 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12olkn20814.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2805::814])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0688289128
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 15:15:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiqrEx6ToQZoC3jFTBsZtF5vn7GI7YfuYL/ztd9OBDnVuyAgQp6XiqmIx96+olwFPzfqLcegBO+wOoaC0MEi0V70d5U5F9pM2hE966ig5Y75N7GMWT8FO2XnOdeNc1kFYCE5EKRCAFSURFCqLRy0vJfHhziOiZpqVXBxMv7PNmLtHzW/IaTWhGW4LJB4z8nxLxvh05cR3TfPGTab+5Ujpyxt9nuzxYE+fqH0y1UKtAuLgh19EVMGtufjr6drYEertjygOy6Q4qKPx8MpyI3xAjJze2BE7MyKsP8xS63G93+CpIvObSME8JxIMJxTMcsavZDcHL+/TLLGj67YGS1c7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rq/BRZi7ZPNA0ejKWBzurZ5tTgfys+MucrmtaWimOog=;
 b=xBmZzjCb2tJ09yXtwJjO3mPq3Q+pGX2T1OvGYztMuaMtAiDTSNv/hy8rAiiTPeAPdDLSpXMcT9tAzTqzST9rBQ595IZ2DaNLhjQC2A2jB+RbvO++rlaeqtWFJmuVSZWQU6ukExCLUgDt4uPUbS/7vvOyvL8po9W4XV7i82dhELc7qdi+m69QbO8Vqc9ZW309hSk2NRaoxJAFt67LdXAQS3SfIzmMxkevXlAlEUb0zAmBQKNP8dQaVCRGap5FoE8/BhAoYys9XRW1hMZyEbTqr1dS9e/WcoLx+ciC6Yvc9wULG+wSMdmVMijBZTV4I5mkjQ+S/UuSURiMUUKrshUmdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rq/BRZi7ZPNA0ejKWBzurZ5tTgfys+MucrmtaWimOog=;
 b=oP1/9I3NJG17888hRzBcUxzQLQo6lpueVzCroIBbP4IqkuUJkIMMzdQh3ahARTjiiYEbEDnDRiMVLHAVIXHzpO8P8tpAJxWJDgdns1L9vg4jQgA9jzNdXa5Qhlq1L5o5NzFT/LEed+CFVZz8xoSFWSbiDHJEgSHAgwcqJSpAzpE84zKDzXPEcSJqsfsDEDfd2oGyyv2lRgGwQNBZj0uZg7qtNpFfVfkTBxza78Jc2AJH68qiAbCN/YJH+y6dcxBxu7lahnyPGYTdInotnzjo30sx7gQu1BBP52Pqp8ifY0x4PW0PB0+rRkFRJpbsIDDaIa0TJN7JL0JCFWXtvfYjaw==
Received: from MN2PR16MB2941.namprd16.prod.outlook.com (2603:10b6:208:e1::15)
 by LV3PR16MB6719.namprd16.prod.outlook.com (2603:10b6:408:279::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Thu, 19 Sep
 2024 13:15:38 +0000
Received: from MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490]) by MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490%5]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 13:15:38 +0000
Date: Thu, 19 Sep 2024 08:15:34 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 jonas@kwiboo.se, trini@konsulko.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, dsimic@manjaro.org, quentin.schulz@cherry.de
Subject: Re: [PATCH 3/3] board: rockchip: Fix panel detection for mainline A-TF
Message-ID: <MN2PR16MB294182BF4056E3BFFE6721FAA5632@MN2PR16MB2941.namprd16.prod.outlook.com>
References: <20240916210137.182493-1-macroalpha82@gmail.com>
 <20240916210137.182493-4-macroalpha82@gmail.com>
 <82810c78-3a7b-4bc3-8c49-803a58292780@rock-chips.com>
 <MN2PR16MB2941BE355B2F4C1623CE946FA5622@MN2PR16MB2941.namprd16.prod.outlook.com>
 <2a073bbf-4ba2-40d0-8ab8-1ece28062474@rock-chips.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a073bbf-4ba2-40d0-8ab8-1ece28062474@rock-chips.com>
X-ClientProxiedBy: SA0PR11CA0017.namprd11.prod.outlook.com
 (2603:10b6:806:d3::22) To MN2PR16MB2941.namprd16.prod.outlook.com
 (2603:10b6:208:e1::15)
X-Microsoft-Original-Message-ID: <Zuwj9oS99utIh9gz@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR16MB2941:EE_|LV3PR16MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: 9839193a-621d-4881-529a-08dcd8ad2722
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5072599009|19110799003|6090799003|8060799006|15080799006|7092599003|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: 0ZaDJZRPlHfXv4sCo2050sPDwLabL+cKMsSA1SA/UXqxByZa22B9if/nfJhBrK0QDOZ4ny5HfhXgahgt76XpEHNg/flXdk4gt5RjL/Xw9iBv2b35g8IurBq4sONzxcf6hgov0qkvtuybsguPq4YOFi6Yl5cB6p10YEq6UKTewKEWgo/PfLU1D1yDLDGkBuUivVwUHSSev+F8w3lLbvnhkmxesleyxgM2P9gxaGwg6+r4z26x5pCvicvSelPH1Mn2yrUOGhVYzLRBFYlXI2f0AufcV/w5QvdvA+3j6YmQzynKxINpdrWxGu3OqwEQsS4tOfsSgPeK2JruuSL8QPor0gwZ1ShQ/I/y5gOv5pNvywnTngBtQ47qY3UYxXynKeAj4fkdXRESJ/4rB3rPxc8wyJGgju451HLqvEQeyEuev3ZqGMp/rcGjOCl0LULyCt9j1gMFlbpyOXCsrossvNECEu0U7JVMXIA1DkxYxOmoUnN41UhX6Mct6fkDwu1ZQ4zeFJpWcARYnHinz0S6BSM3kLr0fqLSt0xdRMe9MfUT2/ZxaxqUqvyH2ES9e6YNGMVs2c7N4k2xWuqRrx1CiRsfgoQrWXKcTJQF+c+yioE8Wk0KBGzTxoZ7KZdnNHBI1+cRMD2AooNJ0LV9G+cB0D6Z3kUDyn9aqE+IkgUFXoT0CgO7dzofw4SSPf14hFY9pRtsqJzB8+8z5zHW8841dDZ60dZrVBrdOmqvmONMQnoIR29yL4asTr15Kja9p40XTLeGH/pQHzWZUyOWg3qPwj/pnA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kUSG/pcGb1/ZFjzQoJFr4+ocLxUZxOuSQRc5NnhMdnVMsmj8AGQX6vLKjull?=
 =?us-ascii?Q?fykY/15KFx7uNZ0AO1xQYwrp25/gQUOMpMh4tuLaEhcR3SvqLEbOwp8u9Lmu?=
 =?us-ascii?Q?xPsBUA2YIWEjSdVtULHqbLNyecdq/uvgwur+XrONCDgd/HNBOYJMMvi8y8Yx?=
 =?us-ascii?Q?gSEhrDtn+AN5+E79+xOpleeS250rQalplGp8qsVIxaWDmg93qely3xjeNoxo?=
 =?us-ascii?Q?2Y6qo9Fq1GbsVSuF3xhwlC+fUx5P/RcB+A8y8onzniuU4P78UmwiEcMQvoeN?=
 =?us-ascii?Q?u2Et7Q/pcX7w7e/Ru+44SWIA3+Omyi+iEOdUjt7NRl7KoJY/Fiqj2kdqX9zl?=
 =?us-ascii?Q?WYukN/78ie2GqdbnCJibMN6qyk/H9YlV5lH86B9hvjmu94IA88QhL9B9Iuze?=
 =?us-ascii?Q?Lq8U8dapyioSkEvgch7i/KiAKMudkTqB9iZ7OhIukW19xZOdNBwQgV3au8Mg?=
 =?us-ascii?Q?/V5rqFGj6wv+M/Hz7Q/2lwz1XvdBxnRqopT0F5g3cWG86qZGmRoHcXuyVqbM?=
 =?us-ascii?Q?PPyyknUUr7hVMlIjy2giXIlTEHE9EgTsAUdwLQ0sQwqInEMwG+yscLhT0SBi?=
 =?us-ascii?Q?BthKHWSGqhUhXQoloeH2zmD0CzCWXeQo26RswZAOOY8dBmY591KNF1fnpkh1?=
 =?us-ascii?Q?Vem8vsNP5mqo/XdA1y7HnSVbGzTfMZqyFc1qu1Ys+834h23NFnDV6bT0HEKn?=
 =?us-ascii?Q?X2hEluQ0zqX7xkEAQC2mjk65eVFMGpYr/mGmDlfcJEmUy9e5GRyaiLWOg6Oj?=
 =?us-ascii?Q?h+m3jMLfvBlfu+lPfMJ2dNHZGoqEoVZ5JvTRabXPhp6h9HOQTi0PXgpx/Sou?=
 =?us-ascii?Q?z/GWx0NWm2dpIf/y51iQrPwSuMabHvfwOybzPpu2/xkejvcCrlsrg6eZtzjN?=
 =?us-ascii?Q?xuy9iqiR9i5zcr4WXdakE/2CZWHGmZdT64X06RLUS2rJrgbbu7fRE6kdha0k?=
 =?us-ascii?Q?xcTPsOM3pWLZObGovkmrNzGJl6/Agqfdna6gRgyXKoPU5mWuqMb51ENExddF?=
 =?us-ascii?Q?3YNdSUHvX5hRvlFrS26HKaaZxXEqY/CXtRBM0W9PzAoB6bqIK78RxBvoPx9y?=
 =?us-ascii?Q?fk6SvlbIz5A3Z4QB0vAulB1Gh7USEKSaJq5SFm34yvwEq1igI1iGww0myPob?=
 =?us-ascii?Q?ZN5zUQFJsWWo3SaU8or1naCexVO0AFdxW+ehQAKH9Bgqvb9t4+itBgVfxRom?=
 =?us-ascii?Q?Kz2sjHk5bhNZkFd5VD/BWnoPeGh3nOpAYxsTbhPEtgZXkubN2nzSjzfBaXaa?=
 =?us-ascii?Q?3eDspO100tVvViOhPEypEpCn9da8SEoR5bwy9YXuvw=3D=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-559fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9839193a-621d-4881-529a-08dcd8ad2722
X-MS-Exchange-CrossTenant-AuthSource: MN2PR16MB2941.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 13:15:38.2610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR16MB6719
X-Mailman-Approved-At: Thu, 19 Sep 2024 19:29:35 +0200
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

On Thu, Sep 19, 2024 at 09:48:58AM +0800, Kever Yang wrote:
> Hi Chris,
> 
> On 2024/9/18 21:38, Chris Morgan wrote:
> > On Wed, Sep 18, 2024 at 11:06:34AM +0800, Kever Yang wrote:
> > > Hi Chris,
> > > 
> > > Please update the subject with something like "Enable the VO PD before
> > > driver access",
> > > 
> > > and the commit message for the change reason is enough.
> > > 
> > > and the config is more soc level, I think you can add this to
> > > arch_cpu_init() for we don't have a power domain driver.
> > To my knowledge I'm the only board trying to access the video before
> > Linux proper. Do you want me to add this for all rk3568 boards then
> > (from within rk3568.c under arch_cpu_init() as you say)?
> Yes, please move it to rk3568.c in case other board need it.
> >   I'm thinking
> > if I do though I can at least get rid of the memory barrier.
> > 
> > > On 2024/9/17 05:01, Chris Morgan wrote:
> > > > From: Chris Morgan <macromorgan@hotmail.com>
> > > > 
> > > > The current panel detection logic crashes when the device boots with
> > > > mainline A-TF, causing a reboot loop. It turns out mainline A-TF
> > > > doesn't enable the VO power domain like the BSP A-TF did.
> > > > 
> > > > Set the VO domain on and use a memory barrier to ensure it is powered
> > > > up before we attempt to do the panel detection.
> > > > 
> > > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > > > ---
> > > >    board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 13 +++++++++++++
> > > >    configs/anbernic-rgxx3-rk3566_defconfig    |  2 --
> > > >    2 files changed, 13 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> > > > index c1d1826fd14..f4e7c1ab360 100644
> > > > --- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> > > > +++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> > > > @@ -22,6 +22,10 @@
> > > >    DECLARE_GLOBAL_DATA_PTR;
> > > > +#define PMU_BASE_ADDR		0xfdd90000
> > > > +#define PMU_PWR_GATE_SFTCON	0xa0
> > > > +#define PMU_PD_VO_DWN_ENA	BIT(7)
> > > > +
> > > >    #define GPIO0_BASE		0xfdd60000
> > > >    #define GPIO4_BASE		0xfe770000
> > > >    #define GPIO_SWPORT_DR_L	0x0000
> > > > @@ -311,6 +315,15 @@ int rgxx3_detect_display(void)
> > > >    	int i;
> > > >    	u8 panel_id[2];
> > > > +	/* Disable VO power domain power-down */
> > > Disable?
> > It's weird verbiage but the data sheet says "Enable power down PD_VO"
> > by writing a 1, so I figure I'm disabling it by writing a 0.
> 
> OK, understand now.
> 
> To make it simple and clear, could you just say "Enable PD_VO for display"?
> 
> > 
> > > > +	writel((PMU_PD_VO_DWN_ENA << 16),
> > > > +	       PMU_BASE_ADDR + PMU_PWR_GATE_SFTCON);
> > > > +	/*
> > > > +	 * System will crash if the power domain isn't enabled before
> > > > +	 * we start trying to talk to the DSI panel.
> > > > +	 */
> > > > +	wmb();
> > > > +
> > > >    	/*
> > > >    	 * Take panel out of reset status.
> > > >    	 * Set GPIO4_A0 to output.
> > > > diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
> > > > index f5e5470df8c..49d3766613e 100644
> > > > --- a/configs/anbernic-rgxx3-rk3566_defconfig
> > > > +++ b/configs/anbernic-rgxx3-rk3566_defconfig
> > > > @@ -49,8 +49,6 @@ CONFIG_SPL_REGMAP=y
> > > >    CONFIG_SPL_SYSCON=y
> > > >    CONFIG_SPL_ADC=y
> > > >    CONFIG_SPL_CLK=y
> > > > -CONFIG_ARM_SMCCC_FEATURES=y
> > > > -CONFIG_SCMI_FIRMWARE=y
> > > This should be a separate patch, and what's the change?
> > > 
> > > 
> > Mainline A-TF seems to get angry with U-Boot when these are enabled.
> > By angry I mean it freezes. It's all a related change to allowing
> > mainline A-TF, though I should probably call it out better as a
> > required change. Again I also specify though in the commit message
> > that mainline A-TF still doesn't work with Linux proper because of
> > the missing psci clk and psci reset bits, but at least with this
> > change U-Boot won't be contributing to the problem (for this board).
> 
> The scmi clock is missing on rk3568 mainline A-TF now, but it should return
> error with something like
> 
> NOT SUPPORT instead of hang inside.
> 
> Any way, this is a separate change, we don't need it if the ATF supports
> scmi clock later.
> 
> Thanks,
> 
> - Kever

I'll opt to disable this for now anyway (but in a commit by itself),
if that's okay. It makes no difference for booting when using binary
A-TF, but it does make a difference when using the *current* mainline
A-TF, even if we do get SCMI later.

Thank you,
Chris

> 
> > > Thanks,
> > > 
> > > - Kever
> > > 
> > > >    CONFIG_ROCKCHIP_GPIO=y
> > > >    CONFIG_SYS_I2C_ROCKCHIP=y
> > > >    CONFIG_MISC=y
> > Thank you,
> > Chris

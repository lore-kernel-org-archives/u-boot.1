Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06DACF8852
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 23:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E3D588AFF;
	Sat,  5 Oct 2024 01:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="qi2tvJZt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F31188B86; Fri,  4 Oct 2024 23:21:55 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11olkn20809.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2c15::809])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5AA9886DF
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 23:21:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhYRungF1FjbsNbm7B+NtIymQtQbd22O78resJq3bcesXOzK7zhC3I1V74I6h1gh9S8LkKzRv1CREzkVM9n1UhO4dxq6xOzjI2JfaL/wnVX/BkvLnNA790zQvaiyspF1f2GiLBSrQxVRKL0hSw6eFXPfRgsMKlPGUMMg3kM720BO1hTSmpXTMpFYvoBimYPOXie9NHxnKDnbslu3ii2kNIVaN5u9mD4cDnACTwgKrz3G5TiGoDc7/QaHlbihoAnfinnfL38xrq2r+HpT8h1OK1P5bVkbzUJ5WHa5DLOeh3SvOQku63p+WLrusJLJ4dup/Zyzvswq7FfSYd0Yx8h+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9wWYSBkqZjT5nLdRb7ANrTVE0efpNNt5U7/OKOm8QA=;
 b=m1tUbBAmm0oV5EROPZUVZNaLRPr9NsEBCHNxADJcbtdmZU+IYTQkw3nzi4dK7lpFDTayh/4XV/G3uQGwWPPMOYeR/MwiDZ2x6uJib37YuQbXJQeD9w7lI1fOtfz6qoRM3vfPLExoqa8/HVt5xSw8fUQkIpUTZiqPyffOe/HiD/fZfj+GzSLXqEZ8ILPQUD2lUehobZnidrBWO4xOxE+ZoqpxF0R7Hi1VsPQu3PL+PZED8XudnhjDMcfem3uCk3GmsnErvZ0jten2+GpXslp/cy1mYCK4YN/ndcJ9QEwTPwStiEIUoU+yt+Mzsof9//2E+F5gIkEEFzwXh5odyEfm8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9wWYSBkqZjT5nLdRb7ANrTVE0efpNNt5U7/OKOm8QA=;
 b=qi2tvJZtSRBPUOTbEQI2OyXC6seW3Msnl38lqKjq5sT0DVn+GPNj6fs2evC/KqWFRlaJH2y28l1d4TwB8F6VoqhMYkOMjLvyCdU041h8kRaOEtqRjR88SKTE/PUMJsBq5qCqueyS9yb0OLDmtLKLuI+4ltEItzovuQj1aj3yVoHWWWpPW3gLHXVNL3lGonvXwE3lgVz9Vp6APeR7KV3yUA5i3/apUYbzI7qDoxLXi8Ui4scF3wkDOWVGbDGDfSMDdFVsTr5WDHQ9aSuPhXG03OtO+QxEjSnZ/A2LnlSFKELo/9A6Bw1vQ6BRj0iYfi6b5Jvm88/FVjGLULVql/2w2g==
Received: from MN2PR16MB2941.namprd16.prod.outlook.com (2603:10b6:208:e1::15)
 by SJ2PR16MB5913.namprd16.prod.outlook.com (2603:10b6:a03:577::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.29; Fri, 4 Oct
 2024 21:21:49 +0000
Received: from MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490]) by MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490%5]) with mapi id 15.20.8005.024; Fri, 4 Oct 2024
 21:21:45 +0000
Date: Fri, 4 Oct 2024 16:21:42 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 jonas@kwiboo.se, trini@konsulko.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, dsimic@manjaro.org, quentin.schulz@cherry.de
Subject: Re: [PATCH 3/3] board: rockchip: Fix panel detection for mainline A-TF
Message-ID: <MN2PR16MB2941F416BF0C37A76AD937A3A5722@MN2PR16MB2941.namprd16.prod.outlook.com>
References: <20240916210137.182493-1-macroalpha82@gmail.com>
 <20240916210137.182493-4-macroalpha82@gmail.com>
 <82810c78-3a7b-4bc3-8c49-803a58292780@rock-chips.com>
 <MN2PR16MB2941BE355B2F4C1623CE946FA5622@MN2PR16MB2941.namprd16.prod.outlook.com>
 <2a073bbf-4ba2-40d0-8ab8-1ece28062474@rock-chips.com>
 <MN2PR16MB294182BF4056E3BFFE6721FAA5632@MN2PR16MB2941.namprd16.prod.outlook.com>
 <947cc3e3-dec2-480d-8911-e87a6b0c88ad@rock-chips.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <947cc3e3-dec2-480d-8911-e87a6b0c88ad@rock-chips.com>
X-ClientProxiedBy: SN7PR18CA0013.namprd18.prod.outlook.com
 (2603:10b6:806:f3::31) To MN2PR16MB2941.namprd16.prod.outlook.com
 (2603:10b6:208:e1::15)
X-Microsoft-Original-Message-ID: <ZwBcZj27ZUPOPn7f@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR16MB2941:EE_|SJ2PR16MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d40f7a-1d47-487d-36c9-08dce4ba8c72
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|6090799003|5072599009|8060799006|19110799003|15080799006|7092599003|3412199025|4302099013|440099028|10035399004|1602099012;
X-Microsoft-Antispam-Message-Info: m4g9EIWwG6mpUlmoucHG1EOFaTTNgLIl+AsUDg4syDpBWkTfpcoxUj+6ttZU9VmDzpL4Yv7TV2GQJk2UKyxGHrEQTqsksyAKC3mbcoxR3IDtIXWL1KenZNU98ZRNkvkGQdQ14/+Vx2IbU4SX6srsKtCqtYyeYzScR0Hw+Jq5EocVBUW6hnFFxYNAoblzB/kcdxR6qpTzfb8qcyCFnoeST2zchM7UTmQoQijChJcfQtG1Rv4wQHFLQTPBExo6htvkqa+x+Q5ecPlrYiG87uhUswx0hqHjTu7HPLjKsAzMirLDH8miPmYu95glwV0CieYnX7snX95ElJVOUPnx8V+3gvf2+7wncg23B6L5Bn9t5Ai3W0wE/pvu3Dgll4JpciVSAeJk7NIvmV7k/3emvfwVCiPbjcg/NcoOrqQzmuD31R5vpuigd8WLcyfueLMybxFmBqk+xnIarbTddkSVERyy4VO2Za7f/oBIW53KRr6Zx1m+O9AXEFnjRaZKHe2trHFyo2M8pW63hR+bBVj4Fxdt0ykUmn5L2maLnvm060VY87wEGiyw5XlfXBz//XrlatwnGxTX3dCSBAYzwht7XBGIDkc/3p2mnzRNApqeHBU79pIL+2ACzhql4Me+o2DNeOB29gDeHor5dCQpafegU3sXH7JL3bMJ/879tx5uY7dP7P5DygACRHB7VuVqnU+bQM1pTqTssw7Mxa+9smt5R/dgD6UN/0LVKi3WJ70z0jFWGmXojA8QhzLhKFZtcUXHf4IT2cF0kbYESjqIEyG6csuotUEa5H5nQP7JP2+g1iLsVzXiNo21OFsoma2gOnr8WFQAXQFCOLGXhNcAiaczEFJyqcmV+b6FqDM/iugaM7uipfmb5oKPrmTUxBMyqygAMboxtcpqGIgjxgxJidz5PpX4qg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?yjf68iAXU4qSaAhYuz0HhNQX06F8R5ni07r3H5guhuAigsv97mMdoDDSap?=
 =?iso-8859-1?Q?dqBUjXOXGzlf0Tcxt/pmfNrioPxWn1yGnLUJn946l+7TJr4KdA+xMJRgHY?=
 =?iso-8859-1?Q?I5YR5rmG/j0PNPsWTtUo04AcClDPHy9qh3Tll+epnbhc2PZZRv3cOr5PA5?=
 =?iso-8859-1?Q?1hhyl5sI+jrRp++a1mt+aHXlEDsT78ZLcqJClUyhfh1E/aZIpQf6LWhguo?=
 =?iso-8859-1?Q?JjT3Fzey0XSVx04gNIVSZ9btH2P9DIsIH+uo382A0N2o9yBnf5JVLQp4Pp?=
 =?iso-8859-1?Q?H+dgkrrTt1KLkZQdWbLMulmAmwOxLMuowj+/OJ2uVj3wfltmIvUSAFBgMt?=
 =?iso-8859-1?Q?XBVBtp41r8aNMs9+n00yzsJZPlqVUQknx0jWLrAreZjdAvUccN4+6TDhHt?=
 =?iso-8859-1?Q?45VU02Dj3N14cePpX1Afm+fWoSiFeo5Quf7zbTxb5r9eqqNdZ3U35u3T8W?=
 =?iso-8859-1?Q?DjONB6CjaM+p+wylzai+pc0lQYfUizekaoXwLEAdmje0orhg2vn54iUlWa?=
 =?iso-8859-1?Q?UiPqzC9JBMGhrZ/2yCPaW1Bmk5sIKY5nltWVfYi4kGSyarSODrqz5u7UFf?=
 =?iso-8859-1?Q?4WtBCYni+OKJ8veKK25plnYgIeWxZ9sDME8sBScUgWQMSs3KjKpn0Ak19j?=
 =?iso-8859-1?Q?bFp2scDquDCZpMKbJKpzebd+iw2W8KQ2NUu+7+HDMkNqr3A2QterRUkR/P?=
 =?iso-8859-1?Q?fBRaWzM4FqIkoPuV2Qh2q8A5zbEkZIi1OCae5Ns21LFuqHvtCYjggtbrN/?=
 =?iso-8859-1?Q?KuCfPomJ/DZ4cOurKOzQiE/2W8iCQa5tBvHJ3DdqQ+5JslSbnxNv01rEqx?=
 =?iso-8859-1?Q?CxFM/ExrPrCxwecUxyXK3rFcsYDLDZy12uOlXnF2ZVLRVWHW/3N21KS3DA?=
 =?iso-8859-1?Q?Yla3z8OVyiYuMM/fleKb6VSl57DozqzZiqOPogLnrjni0Rv2Vy3rih+yUt?=
 =?iso-8859-1?Q?1Jhk2LG8tAkgm/Cl//KoIW+C75QxMDAAFwc814KQPMM2DpJ4/9OpBVrpIb?=
 =?iso-8859-1?Q?2Zp9DTfFnBy2nCijLmdYSjwy+0NqK7chyMODdRhcwo6A3tp0gbJVMM1p7W?=
 =?iso-8859-1?Q?cZO+KO2TE3I4J3R4JxrSBkKgOsJfxLLIdW1RHDlRbY2yOuWnY9DQU7qWQb?=
 =?iso-8859-1?Q?7MHbiy2z4XGHMnJIp0xFsYIXzBYjZLqp4ILFt1/EJF00LyaW4X26bD9N64?=
 =?iso-8859-1?Q?o4TV7TVNL3I873GARWdqlygG95TJFR77OjfMIMR2x/ngWopldu2vZuyak0?=
 =?iso-8859-1?Q?G97aeRjqU1K6Z8UHZ4ij0uxP96mqUmF3NtDDJq5jaZ7apsGFPlDKNhIud2?=
 =?iso-8859-1?Q?60m3rU4iV1oH06kuruxHnSxI1A=3D=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-559fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d40f7a-1d47-487d-36c9-08dce4ba8c72
X-MS-Exchange-CrossTenant-AuthSource: MN2PR16MB2941.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 21:21:45.4841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR16MB5913
X-Mailman-Approved-At: Sat, 05 Oct 2024 01:23:55 +0200
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

On Mon, Sep 30, 2024 at 04:59:41PM +0800, Kever Yang wrote:
> 
> On 2024/9/19 21:15, Chris Morgan wrote:
> > On Thu, Sep 19, 2024 at 09:48:58AM +0800, Kever Yang wrote:
> > > Hi Chris,
> > > 
> > > On 2024/9/18 21:38, Chris Morgan wrote:
> > > > On Wed, Sep 18, 2024 at 11:06:34AM +0800, Kever Yang wrote:
> > > > > Hi Chris,
> > > > > 
> > > > > Please update the subject with something like "Enable the VO PD before
> > > > > driver access",
> > > > > 
> > > > > and the commit message for the change reason is enough.
> > > > > 
> > > > > and the config is more soc level, I think you can add this to
> > > > > arch_cpu_init() for we don't have a power domain driver.
> > > > To my knowledge I'm the only board trying to access the video before
> > > > Linux proper. Do you want me to add this for all rk3568 boards then
> > > > (from within rk3568.c under arch_cpu_init() as you say)?
> > > Yes, please move it to rk3568.c in case other board need it.
> > > >    I'm thinking
> > > > if I do though I can at least get rid of the memory barrier.
> > > > 
> > > > > On 2024/9/17 05:01, Chris Morgan wrote:
> > > > > > From: Chris Morgan <macromorgan@hotmail.com>
> > > > > > 
> > > > > > The current panel detection logic crashes when the device boots with
> > > > > > mainline A-TF, causing a reboot loop. It turns out mainline A-TF
> > > > > > doesn't enable the VO power domain like the BSP A-TF did.
> > > > > > 
> > > > > > Set the VO domain on and use a memory barrier to ensure it is powered
> > > > > > up before we attempt to do the panel detection.
> > > > > > 
> > > > > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > > > > > ---
> > > > > >     board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 13 +++++++++++++
> > > > > >     configs/anbernic-rgxx3-rk3566_defconfig    |  2 --
> > > > > >     2 files changed, 13 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> > > > > > index c1d1826fd14..f4e7c1ab360 100644
> > > > > > --- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> > > > > > +++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> > > > > > @@ -22,6 +22,10 @@
> > > > > >     DECLARE_GLOBAL_DATA_PTR;
> > > > > > +#define PMU_BASE_ADDR		0xfdd90000
> > > > > > +#define PMU_PWR_GATE_SFTCON	0xa0
> > > > > > +#define PMU_PD_VO_DWN_ENA	BIT(7)
> > > > > > +
> > > > > >     #define GPIO0_BASE		0xfdd60000
> > > > > >     #define GPIO4_BASE		0xfe770000
> > > > > >     #define GPIO_SWPORT_DR_L	0x0000
> > > > > > @@ -311,6 +315,15 @@ int rgxx3_detect_display(void)
> > > > > >     	int i;
> > > > > >     	u8 panel_id[2];
> > > > > > +	/* Disable VO power domain power-down */
> > > > > Disable?
> > > > It's weird verbiage but the data sheet says "Enable power down PD_VO"
> > > > by writing a 1, so I figure I'm disabling it by writing a 0.
> > > OK, understand now.
> > > 
> > > To make it simple and clear, could you just say "Enable PD_VO for display"?
> > > 
> > > > > > +	writel((PMU_PD_VO_DWN_ENA << 16),
> > > > > > +	       PMU_BASE_ADDR + PMU_PWR_GATE_SFTCON);
> > > > > > +	/*
> > > > > > +	 * System will crash if the power domain isn't enabled before
> > > > > > +	 * we start trying to talk to the DSI panel.
> > > > > > +	 */
> > > > > > +	wmb();
> > > > > > +
> > > > > >     	/*
> > > > > >     	 * Take panel out of reset status.
> > > > > >     	 * Set GPIO4_A0 to output.
> > > > > > diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
> > > > > > index f5e5470df8c..49d3766613e 100644
> > > > > > --- a/configs/anbernic-rgxx3-rk3566_defconfig
> > > > > > +++ b/configs/anbernic-rgxx3-rk3566_defconfig
> > > > > > @@ -49,8 +49,6 @@ CONFIG_SPL_REGMAP=y
> > > > > >     CONFIG_SPL_SYSCON=y
> > > > > >     CONFIG_SPL_ADC=y
> > > > > >     CONFIG_SPL_CLK=y
> > > > > > -CONFIG_ARM_SMCCC_FEATURES=y
> > > > > > -CONFIG_SCMI_FIRMWARE=y
> > > > > This should be a separate patch, and what's the change?
> > > > > 
> > > > > 
> > > > Mainline A-TF seems to get angry with U-Boot when these are enabled.
> > > > By angry I mean it freezes. It's all a related change to allowing
> > > > mainline A-TF, though I should probably call it out better as a
> > > > required change. Again I also specify though in the commit message
> > > > that mainline A-TF still doesn't work with Linux proper because of
> > > > the missing psci clk and psci reset bits, but at least with this
> > > > change U-Boot won't be contributing to the problem (for this board).
> > > The scmi clock is missing on rk3568 mainline A-TF now, but it should return
> > > error with something like
> > > 
> > > NOT SUPPORT instead of hang inside.
> > > 
> > > Any way, this is a separate change, we don't need it if the ATF supports
> > > scmi clock later.
> > > 
> > > Thanks,
> > > 
> > > - Kever
> > I'll opt to disable this for now anyway (but in a commit by itself),
> > if that's okay. It makes no difference for booting when using binary
> > A-TF, but it does make a difference when using the *current* mainline
> > A-TF, even if we do get SCMI later.
> 
> Could you try with below  patch for rk3568 SCMI support:
> 
> https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/31265

I did. We still need this specific patch to call the panel in U-Boot
(so I can detect it and fix-up the device tree). I noted a few issues
I identified on that commit; they may or may not be related to the
specific commit at hand though since it was the first time I could
boot my devices with mainline A-TF.

Thank you,
Chris

> 
> 
> Thanks,
> 
> - Kever
> 
> > 
> > Thank you,
> > Chris
> > 
> > > > > Thanks,
> > > > > 
> > > > > - Kever
> > > > > 
> > > > > >     CONFIG_ROCKCHIP_GPIO=y
> > > > > >     CONFIG_SYS_I2C_ROCKCHIP=y
> > > > > >     CONFIG_MISC=y
> > > > Thank you,
> > > > Chris

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3722ACE8D45
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:33:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E0DA88853;
	Thu, 19 Sep 2024 05:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="GIZU9+E6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB59C88CA1; Wed, 18 Sep 2024 15:38:14 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02olkn2081f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2c05::81f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 807A98885D
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 15:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBVBCPvrQtSDTNuaw4EstaaHkiRnYsl0JpoT895SQcojcMfsAjFTTX4tUuV4rUzaZXsWG3Oxt+u5UhT0aBCz2ZlNbUE1RqCJnRjayqBJ97iBXwzmNVPv+Uh9tMMjlx1bCxKlLEtr/fp1ioBvJZPttrtNSr2FNti3rW+5LffyhatafIpuVblT01lj2VIAv41tkpmdKtJpG9brrTrbZi8vM4IKJGlprW3ta68gXQy6rbzJA1MRYdRrGCGY7tIFZNwUuJMcDqyIYh/wy8JgQEbrJCXRjok/0xeKmGzbWO1RMABRp86j5lIoBUicAuri38s9jA0cMRIsVThflyip+kDJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/jYyc5W36uuuVo98c7rjkUiIgLZn93SQt+WaPjyXM4=;
 b=WQgKdjuLUJThYF86ShGAeazFsTTV43QNKt6oCYhi+PHfFu9u6xqTPr25ov4uoNOcf9Fnjp3nzCNygVeFeBcVWAib0a3yerhJ5L/WlPbPqYPeukJtKfoVm+9UixdnLJtndPiTn7TF0C1SKvOHJWHbUhEVVdNTB/ZVSqHl5Qyo+hSJtEHzAVB/JcDnsxR0DPeKQGa1uwg826CiTwDQW5Zu+6H9WNSRF42hckC8EiN08atcqe9if3Z+Zlal9Tcu+kYhzmUFG6QYQR31s6gE3F33xHBiZ4bLF30QHW6RPoSdrdfkP+XnMtDsgUpKI3BNCFKWGcdedYabmDTIrcoE/bc7JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/jYyc5W36uuuVo98c7rjkUiIgLZn93SQt+WaPjyXM4=;
 b=GIZU9+E67ZsV8Mz45omhKVpe9E98JnEzx9AW+qM/2go1Tj5ExsiBpHaBM3jignplRE6Nu6IGbVFeRYG3RqbPw74DzIIYgN9zwS8ZgXigOpJjDJiTS0CCahcz1KRfhZg3gtKOoRb8iKd5w3sxr1feaTrRg7FSP3GE5rJACOJnrIcdfjG93Yx8JshgzzkJTlA17q0mbzHdPR12dz9wW2HRNf//YFE95muHpQBetEMSQjqZ94cIqQIq1kqwgFhpd6k2FZvT0uvmo59ZmSJao6mktth6tRYSCJPBPMbg+psUl1E9w3boYL4Mhzi94wFjFD1SM4IWekSucGJrjGMJRYk5kA==
Received: from MN2PR16MB2941.namprd16.prod.outlook.com (2603:10b6:208:e1::15)
 by LV3PR16MB5687.namprd16.prod.outlook.com (2603:10b6:408:1dd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Wed, 18 Sep
 2024 13:38:10 +0000
Received: from MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490]) by MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490%5]) with mapi id 15.20.7982.012; Wed, 18 Sep 2024
 13:38:10 +0000
Date: Wed, 18 Sep 2024 08:38:00 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 jonas@kwiboo.se, trini@konsulko.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, dsimic@manjaro.org, quentin.schulz@cherry.de
Subject: Re: [PATCH 3/3] board: rockchip: Fix panel detection for mainline A-TF
Message-ID: <MN2PR16MB2941BE355B2F4C1623CE946FA5622@MN2PR16MB2941.namprd16.prod.outlook.com>
References: <20240916210137.182493-1-macroalpha82@gmail.com>
 <20240916210137.182493-4-macroalpha82@gmail.com>
 <82810c78-3a7b-4bc3-8c49-803a58292780@rock-chips.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82810c78-3a7b-4bc3-8c49-803a58292780@rock-chips.com>
X-ClientProxiedBy: SA1P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::20) To MN2PR16MB2941.namprd16.prod.outlook.com
 (2603:10b6:208:e1::15)
X-Microsoft-Original-Message-ID: <ZurXuA7svnVDgdQb@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR16MB2941:EE_|LV3PR16MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: a7982121-8c05-42b0-e2c7-08dcd7e720be
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|5072599009|6090799003|19110799003|8022599003|7092599003|15080799006|8060799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: KEP2/rtOY7OIjO0CGs9RakCrMCLhdwAkQEprl5db6hTOl7QTS4X8TJo4ZNhJfCfeKbzPFN01HwOK/knQt2akcnINeMVd2TNZ2ewVftcswPfVzXgy9phjgKLeswuGgdYx3Fu9LW9ffn7rLZ2DfU8khbtKHzf+/u7ryK4cGonucuCIN2Ta7vortBlMBsyokqfGdYZWK9c9TwDgXL9vvu7k+br9OUmEu29/eZtpao5HD5SlDmlpEw+Gec/jdnUd1rBjeybC1i3sJpTaQaiUtNTXt58nz3SNlJCgiHlghCz1XLCBIX7R+n0jFnTovygDD8gp71cZAUDFe+7N8LgCPo8B0yGZnCi2LQ41LK6aj1tgUBFkcUmpRB3hBe7kkzBNFB776S1lHcF5GVi2Fg5M9P65/Z0nw0TKtG+v9d46CqxDVojdFg+qpGxsboqINvlgHWs3eqNqSeM0pcNWuYM/mX4lu1Pwga0rSwOFov2r2B2vZjOEpT0MiBMGnh3IYx32vboJRYH6ID0KhcsAAGQyVfkNLRc1ISMULhErQ/dty8QsdHsEbcWZ41yDO6Vl2H4EPEI68CbMz6PjNjrdW0hbRxuhkMkNpsI5boZV1SDJ4fquTXlOOKdXo492afYeJpBccD1z+mVw1rgIOEkDxnS/q+dpNZzooFwnq/foGBC2BIiJJlOVWXnQHvR+04whtINa8AnE2p8ZAttqnaNAjvkiawLdCDOdHsBCrFE/DxRm7gcm9y+qdpmyeWXlqsHPTvpFsGymor9qbQ0dAcTPOxxbZcdoXW0nfcC2M9YnVYFc8uUyfno=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J8F6WvVuZkQSH8OSsHeNF3Xt7vRyWLyVsU4HjAE0BYO0WGBXia4l+obMFc2D?=
 =?us-ascii?Q?ZOWxqvzDs4Qz/DCjh4x8EOGHnddlXewKOX3W3zYzZ+7nKidleocXmOtLa7s4?=
 =?us-ascii?Q?IrMVpniPrQQKPOLhvY9je71RZ5sbxUMfxBV/Edkd/2Dg7Yd+ULAW5xgrcA1I?=
 =?us-ascii?Q?H9fc7+uqI3LmoMhLsKusD2QPbmcaY8caGEsla6ZlCJk9XNNz+O4XU05eWyji?=
 =?us-ascii?Q?uBSUXncmOaibr26TlVCtGEnGsXlPxzmdjnmI5hOk3V5cdFudKKOWuZeKovAq?=
 =?us-ascii?Q?vb99PScBbNrLwm4WeK5uhoiQmQ6sN2/IrwCK2Wq/lM+8XlmzizpBW8ShogQa?=
 =?us-ascii?Q?cS2pWgSwBCwO/RrXuVyL176eL6TAYOSiOIY9Jx6EXkp2tjAeWtrUtKT+IQwx?=
 =?us-ascii?Q?L5BdySwq54Wkfvzlm7xcSALtxpoEV6553kunRJiH9eJHA2A7uRvJk6YO1WCm?=
 =?us-ascii?Q?9HNZ/zWvGAMrbtkf1QO1OrJ4vP3tpPikX0bR9cL9hUrBu9ZOt+7fIMxOmFP7?=
 =?us-ascii?Q?NrabTOiEjENO726ZKNAiDJIPRG+UWcI2u58VNnUTU9ZSjiuWWQNkBBs4lk1Y?=
 =?us-ascii?Q?pLniFkmQK+uwDAKAASzsYYb7lxO6mXvnsmom19QoSkfz+PC2UzLKcZ/gq9TH?=
 =?us-ascii?Q?L9lWv3nPV3/oDjL8LR9j//u6E1I6h+pCMwA2DLAiLpBCRCGlqyusePOt6Al+?=
 =?us-ascii?Q?Ej2ppMB5RqWc0UcGs+pEwicrI5uQnjryCHl2ilJlVTUSxIFr6Tr0XZwgoEX9?=
 =?us-ascii?Q?b1jcJ8le/gdaB2y6n/4OpuECg9/ydbOGDw3a1fjtMUaxzLvasw+e/msxg7DF?=
 =?us-ascii?Q?UXRJafzlznV21dzuZEPvcLwaWZ+kEjd+UqTseKtSSG6B3Xh0Y+yWdMcCQo3e?=
 =?us-ascii?Q?FaZfnp/rdM36rTZKURQ573SIYVenH2aVB0dHGIG+gOyAh8PUihxh+fJrjoL7?=
 =?us-ascii?Q?SsrtYXRyrxO9V7N8oR0z3tGs4bExfHaDAwaJpFUQ3v4Yyhw3v8vUpqgvFidU?=
 =?us-ascii?Q?ZHOllA6B8jmm2oYUCwLE5BE8kAyMdoSr0uFtCJcQYNRNQI3dcsPtxM1C1NT4?=
 =?us-ascii?Q?U52xiJa3faFW3swFaPIvLt9dSVvlxDaGesvmHPHHMxIy97Djt3fo3MZFGk3T?=
 =?us-ascii?Q?/ebXagQBCVWaVaJzKhwJnMA/Wx+HRU7PVtikZvKmtHBKAjqMWF3wixI0FxKb?=
 =?us-ascii?Q?zEaRJBXahbQ6LsuVrNT0Ko9tjsbKOQ6ufV9MqXPLt6DKKS2b2Y/S7Vd+NPaj?=
 =?us-ascii?Q?gXZwJ6L/B40V3SGoHAXtHzVA0jf2LzYNYJsqihFajw=3D=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-559fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a7982121-8c05-42b0-e2c7-08dcd7e720be
X-MS-Exchange-CrossTenant-AuthSource: MN2PR16MB2941.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 13:38:10.1773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR16MB5687
X-Mailman-Approved-At: Thu, 19 Sep 2024 05:33:36 +0200
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

On Wed, Sep 18, 2024 at 11:06:34AM +0800, Kever Yang wrote:
> Hi Chris,
> 
> Please update the subject with something like "Enable the VO PD before
> driver access",
> 
> and the commit message for the change reason is enough.
> 
> and the config is more soc level, I think you can add this to
> arch_cpu_init() for we don't have a power domain driver.

To my knowledge I'm the only board trying to access the video before
Linux proper. Do you want me to add this for all rk3568 boards then
(from within rk3568.c under arch_cpu_init() as you say)? I'm thinking
if I do though I can at least get rid of the memory barrier.

> 
> On 2024/9/17 05:01, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > The current panel detection logic crashes when the device boots with
> > mainline A-TF, causing a reboot loop. It turns out mainline A-TF
> > doesn't enable the VO power domain like the BSP A-TF did.
> > 
> > Set the VO domain on and use a memory barrier to ensure it is powered
> > up before we attempt to do the panel detection.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >   board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 13 +++++++++++++
> >   configs/anbernic-rgxx3-rk3566_defconfig    |  2 --
> >   2 files changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> > index c1d1826fd14..f4e7c1ab360 100644
> > --- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> > +++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> > @@ -22,6 +22,10 @@
> >   DECLARE_GLOBAL_DATA_PTR;
> > +#define PMU_BASE_ADDR		0xfdd90000
> > +#define PMU_PWR_GATE_SFTCON	0xa0
> > +#define PMU_PD_VO_DWN_ENA	BIT(7)
> > +
> >   #define GPIO0_BASE		0xfdd60000
> >   #define GPIO4_BASE		0xfe770000
> >   #define GPIO_SWPORT_DR_L	0x0000
> > @@ -311,6 +315,15 @@ int rgxx3_detect_display(void)
> >   	int i;
> >   	u8 panel_id[2];
> > +	/* Disable VO power domain power-down */
> Disable?

It's weird verbiage but the data sheet says "Enable power down PD_VO"
by writing a 1, so I figure I'm disabling it by writing a 0.

> > +	writel((PMU_PD_VO_DWN_ENA << 16),
> > +	       PMU_BASE_ADDR + PMU_PWR_GATE_SFTCON);
> > +	/*
> > +	 * System will crash if the power domain isn't enabled before
> > +	 * we start trying to talk to the DSI panel.
> > +	 */
> > +	wmb();
> > +
> >   	/*
> >   	 * Take panel out of reset status.
> >   	 * Set GPIO4_A0 to output.
> > diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
> > index f5e5470df8c..49d3766613e 100644
> > --- a/configs/anbernic-rgxx3-rk3566_defconfig
> > +++ b/configs/anbernic-rgxx3-rk3566_defconfig
> > @@ -49,8 +49,6 @@ CONFIG_SPL_REGMAP=y
> >   CONFIG_SPL_SYSCON=y
> >   CONFIG_SPL_ADC=y
> >   CONFIG_SPL_CLK=y
> > -CONFIG_ARM_SMCCC_FEATURES=y
> > -CONFIG_SCMI_FIRMWARE=y
> 
> This should be a separate patch, and what's the change?
> 
> 

Mainline A-TF seems to get angry with U-Boot when these are enabled.
By angry I mean it freezes. It's all a related change to allowing 
mainline A-TF, though I should probably call it out better as a
required change. Again I also specify though in the commit message
that mainline A-TF still doesn't work with Linux proper because of
the missing psci clk and psci reset bits, but at least with this
change U-Boot won't be contributing to the problem (for this board).

> Thanks,
> 
> - Kever
> 
> >   CONFIG_ROCKCHIP_GPIO=y
> >   CONFIG_SYS_I2C_ROCKCHIP=y
> >   CONFIG_MISC=y

Thank you,
Chris

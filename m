Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108AFCCF9EB
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 02:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1655488CC8;
	Thu, 26 Sep 2024 04:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="aWYQPmfP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66A6988B89; Thu, 26 Sep 2024 02:23:47 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11olkn20812.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2c16::812])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C58BA88972
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 02:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0IixgIc+0YpE/4CRwyDB9lAh+ItzDtXonT+Q/Hz8DbVbn/FvJ6Jg7JbE4x5FqnEc9ad+4PWUgyLrj0E7gPQ6LPiBJVUQifg7jxKQRRbIsA+ngwkcGpPAXkDenSFV/FdC8zgySrF0xFFljTwyjmTiPeKus8jsBWg8EnqoKJUAy/zoypMpN594mvillePBHvfUsiZYEdjPx/LDM8Ld1FTH5Xg69mnuBgz1ebRi/7Jg1E6F/3GQOWUyAMwl8rzK7nDVEPdSGMjNdIZ+qins00Gx/hE8K9PV+FYiHL5eKwBPldbyrscAYTnBapBIA11ifLhrc5qyXZ4grlpDM/10U6iGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/X5xqoJ6kq8aQPwRI+dmVUbOAUjhLNWfGvswLy8n1D0=;
 b=bVh1tIwvOpiaaM72S6dVQrZNRiCutCOHc7Pkd5j4zk1++nocfY5ZZyVBR9AGhz2IzYJSaQaJ+6TfN94fAGR1ayBPjCuet+DDoN0Az8PiRAMopczKTXu1JpX5J2Jz0LJNBRU9p0MCgc8RItE9GxwvZKmu/E9HSQB8++uHL7DfSFAsc2ytInW0AKRx/BVV1ozeNUngDpMr+pVnP2AoWhZqBRJqAeYwejVfQ+xcv7NZJcGk2kDwbl6eMqWnK+OWUv0h5erF2M60mazItMCFka+T+Uq0wjwp38uYli8jn/0jjO652epVOU899UJHN/hktPdaWkEeTXEijjcIc9Pz/ZFadA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/X5xqoJ6kq8aQPwRI+dmVUbOAUjhLNWfGvswLy8n1D0=;
 b=aWYQPmfPOLXiMw3dLR0maDKvSB//FI2Ror87HWdEL3DKABCt97mf+0wE5/L3qQ65RLbZmvD2zZx3hXnsDyFrGaMQ4w3l7mjqXnQHiDOWGMDP+UtzpFTENhY+tjw4yIVl8eQC/sW3nIEh7s5PzMofG9w6bpN+0aCDfkOiVLcxu99oAgOD92C2H+4iPw6p9C0B/bLn6bO10xx/9+CjVACtoCxckJWMQkPgpSvO+K4PJIwdDTL5Wj5hj2p6ak7KQSCSzVMYGWrCDmJA8sqOdKI7K2oNJvPIxBGXgE8uoj+iFp4uOxb3oVpjrjUh1AIIyxNlmW59cX3CaMmxh2qVjCS1vw==
Received: from MN2PR16MB2941.namprd16.prod.outlook.com (2603:10b6:208:e1::15)
 by MW3PR16MB3753.namprd16.prod.outlook.com (2603:10b6:303:4b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Thu, 26 Sep
 2024 00:23:35 +0000
Received: from MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490]) by MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 00:23:35 +0000
Date: Wed, 25 Sep 2024 19:23:31 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 jonas@kwiboo.se, trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, dsimic@manjaro.org
Subject: Re: [PATCH V2 4/4] board: rockchip: Enable PD_VO before driver access
Message-ID: <MN2PR16MB294178BFE5E52AB3B2CCD773A56A2@MN2PR16MB2941.namprd16.prod.outlook.com>
References: <20240919140022.511067-1-macroalpha82@gmail.com>
 <20240919140022.511067-5-macroalpha82@gmail.com>
 <da41ca54-871e-4e40-b7c8-626a3c4a3f1a@cherry.de>
 <MN2PR16MB2941B5324EEF8193605018F1A56F2@MN2PR16MB2941.namprd16.prod.outlook.com>
 <dc3b71ba-2993-4c5a-82cd-4f66f90b86cf@cherry.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc3b71ba-2993-4c5a-82cd-4f66f90b86cf@cherry.de>
X-ClientProxiedBy: SA0PR11CA0105.namprd11.prod.outlook.com
 (2603:10b6:806:d1::20) To MN2PR16MB2941.namprd16.prod.outlook.com
 (2603:10b6:208:e1::15)
X-Microsoft-Original-Message-ID: <ZvSpg6WjxQCwecMP@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR16MB2941:EE_|MW3PR16MB3753:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e41fa4a-68d0-47f2-d559-08dcddc1751a
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799003|461199028|6090799003|8060799006|5072599009|15080799006|7092599003|56899033|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: 0vvFR/iKZxf58hDenUYtGup5SgYnMCiZA2YjVdEIFliszPDoOqfkOC21ciCavuvtu0e36dcSZUe4bzwTLqCryOr/xm4Vr8o0pMGwCtbaPJA6cR0KghhSe3Bn6S+p3+zZQ8xWFtQ35WYvKk3EQAF/2zt4oHgXka4onlmF0OIRZGyxpn/5Rxhda/3GvcU7HVV3TSrTyKX7Np6RoriGxN7yk8pmwJClMZ5/ZzUrPjsAqShtagZlPPHyEpAG9rUa2cjiQPOEWbBUcnxElKUZ/JvQlqgBp3JRmM81JQZUoewtPKQSiD2Ni+s1CjB8IUl1gIQ+xA53jFrUws6O0RH7mzFpbiaoMRG8l0wjQ1boI2YAr+aTRNwsdmJzLbyIeTP9JGX2t6PVxdJPoqGUPPIc4d+Xtd2/iil2Oye0LFl2bC+RzxE+NhLIMTDhhwzj6osyApizZz/7Cat+Y5F+zd2HaB4T5DevOAZ7WCedLguDwhsOVgCWOadNpCLdB5bu3wJamlym2ZtEig8tkjAa3g4PUzKkc+jg/5c6RjUrosmS7gXuJJ3mww5Ng118MDXZb5EkTKujd4+pqk0VD/SHfB8OlUFgAqLm6VZbMIOBZ2z93LJAH2Ak8vPa22vARj3OPQcGWF/faFsNQqdZpai3MOJF+bMJ8pMMwMPBTInKWZiVSERVCYwJ1Ro45Dyht0TDHWwPeVEEOgWmRcsjlFCAJU8QgINQkLXa38vc/dE43vzDDqTkcUpkFBkz0VCg17Sco+kv1FGsGvGrM+nos8jPo67Z0+Dapg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Ptmzy+eni2Ad3KGH54RGMrm4T3TH1TgyqcLREK5wO/6EhIZ9+UN0QfeWeCr?=
 =?us-ascii?Q?irBc/je36fMoOjxId7q4kY8g/9M1A6qtbT1i+o9fuKDZqnMxVkI4HqrrLtiH?=
 =?us-ascii?Q?f6ivX2dlj+UCi32PHWTcMo9B7kfjVnjqXBF6C/bx3vxDwZ2+yuJPBWxUibBH?=
 =?us-ascii?Q?5WHsF4ktH/04kskm+HKlsbrT+ddQbZKn80sNpP43GdYLJCAx43yYEcblHOLW?=
 =?us-ascii?Q?hwaykO9nqKde6b6lp3YlAzIFIiSxAnq1oRTbBqdt2BoXbDL5RFfTE2Wly0A+?=
 =?us-ascii?Q?UBrdH5LIAFGHCjY5sh1KFlrBqVpSvefFYQVNyZXLHmU6X4oWhFaTj+G8ZckH?=
 =?us-ascii?Q?owJR5k88kq+7Q6vpfPsfk8KglaJ00VXtlEM86DsO/jGM1vAjY633ATrqHqOx?=
 =?us-ascii?Q?a2TiPEGXgGeIMrLXoL6kfCZ9h0amQ6A7ASJsUxDF1YiPPflX4dBYCAU/O5+3?=
 =?us-ascii?Q?MlFc1WZacwVqVR/LlunMUsFhAVBHfxeOw1+QWXMOoin2WGG2Hmd4KZPoD40z?=
 =?us-ascii?Q?vVuRaErPj0nUdcpLt12VrLg1cc6pETo0EqpKuANl1RBi4nwa2SpCRG1Cj6mt?=
 =?us-ascii?Q?/ZK7g/xxhnzO3GyTsEHPO5bm2dfRN+3U7bu3CZ4W6V1SlMk16yUeUOzhsA0d?=
 =?us-ascii?Q?UxFxV6AgEn/rV4RFwBeteBBOMdJS9hJxVDRVTr5xJI6HU7mPL/IOf0jopW//?=
 =?us-ascii?Q?7/3eehgvA6HWuANK52Qwf6WtpedSSvk4NWtg5qlarjVJvEKqF03Q2VKgKy6c?=
 =?us-ascii?Q?ftfsKnmM0PWuhks/qjscm7W37n0tPsuMIFN5Gx63Z9f0wefc+u6DLX/fWRYi?=
 =?us-ascii?Q?10F/V7k+n6lZkzglIkGbPUQoVGDWxj9Jlgz7UfixvFURnNHahwe0i2n6rdem?=
 =?us-ascii?Q?KNOmkE9WdZPjfgzRuXBAlpODuWVvs+dWt/5s+IqEClGDUbfckBeEGwyiPngD?=
 =?us-ascii?Q?QpMIdhqL7PNMRykVKrDVsgfAH/6IMPnSG+O0tEusxCClv01DhHKxOM8ybQcp?=
 =?us-ascii?Q?uCHycjDsfdKGb2XFy4vw9xiLyKM49aiwyHq7M8rAbUqn9nLnAfewhlAHXqqv?=
 =?us-ascii?Q?HFwLhgG9AYFl9oTXxIVmB67nqLH9Exiv32JjSuFG1d2DLWgzsnnITIQQN6WZ?=
 =?us-ascii?Q?vQ6eEu5OuCE81aNS6WAROr3ovud4Ng+nK52xCM4MmK8kX/Ms0kUsW7T4qUIB?=
 =?us-ascii?Q?i8IccOn7EUFH2WqtA7NkmUuMUESq26z8g9PVALAbQj40uCRXvu0m1nhPHxgt?=
 =?us-ascii?Q?N7HHn9HJr1TWeHp6AnsVegtOnP8YX/djUJClB38uVw=3D=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-559fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e41fa4a-68d0-47f2-d559-08dcddc1751a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR16MB2941.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 00:23:34.8530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR16MB3753
X-Mailman-Approved-At: Thu, 26 Sep 2024 04:47:21 +0200
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

On Tue, Sep 24, 2024 at 11:19:49AM +0200, Quentin Schulz wrote:
> Hi Chris,
> 
> On 9/23/24 7:38 PM, Chris Morgan wrote:
> > On Mon, Sep 23, 2024 at 01:24:34PM +0200, Quentin Schulz wrote:
> > > Hi Chris,
> > > 
> > > On 9/19/24 4:00 PM, Chris Morgan wrote:
> > > > From: Chris Morgan <macromorgan@hotmail.com>
> > > > 
> > > > Enable the PD_VO power domain before driver access on the rk3568 SoC.
> > > > 
> > > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > > > ---
> > > >    arch/arm/mach-rockchip/rk3568/rk3568.c | 6 ++++++
> > > >    1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
> > > > index 1b3e40074e3..d5742b68d68 100644
> > > > --- a/arch/arm/mach-rockchip/rk3568/rk3568.c
> > > > +++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
> > > > @@ -26,6 +26,8 @@
> > > >    #define PMU_BASE_ADDR		0xfdd90000
> > > >    #define PMU_NOC_AUTO_CON0	(0x70)
> > > >    #define PMU_NOC_AUTO_CON1	(0x74)
> > > > +#define PMU_PWR_GATE_SFTCON	(0xa0)
> > > > +#define PMU_PD_VO_DWN_ENA	BIT(7)
> > > >    #define EDP_PHY_GRF_BASE	0xfdcb0000
> > > >    #define EDP_PHY_GRF_CON0	(EDP_PHY_GRF_BASE + 0x00)
> > > >    #define EDP_PHY_GRF_CON10	(EDP_PHY_GRF_BASE + 0x28)
> > > > @@ -130,6 +132,10 @@ int arch_cpu_init(void)
> > > >    	writel(0x3f3f0707, GRF_BASE + GRF_GPIO1C_DS_1);
> > > >    	writel(0x3f3f0707, GRF_BASE + GRF_GPIO1C_DS_2);
> > > >    	writel(0x3f3f0707, GRF_BASE + GRF_GPIO1C_DS_3);
> > > > +
> > > > +	/* Enable VO power domain for display */
> > > > +	writel((PMU_PD_VO_DWN_ENA << 16),
> > > > +	       PMU_BASE_ADDR + PMU_PWR_GATE_SFTCON);
> > > 
> > > Maybe we want to guard this with a symbol for video stuff in U-Boot? I
> > > assume Linux is capable of handling this just fine without U-Boot's
> > > intervention?
> > > 
> > > At the very least have #if CONFIG_IS_ENABLED(VIDEO) ?
> > > 
> > > What do you think?
> > 
> > I'm game if you are. To me this just brings back the default behavior
> > of the binary A-TF from Rockchip where the PD_VO was enabled, but if
> > we want to guard this I'm okay.
> > 
> 
> Just to be sure I understand correctly...
> 
> Would a device without this power domain enabled by U-Boot still have
> working video in Linux with upstream TF-A?

Ideally yes. I assume this requires a functional power domain driver in
Linux. If you lack such then video won't work without this patch,
conversely if you lack such and don't use video then you'll have higher
power draw with this patch.

Honestly I figure we can guard it for now and if we find upstream video
issues on mainline A-TF we know this is a great place to start for
troubleshooting it.

Chris

> 
> Cheers,
> Quentin

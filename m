Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAE5C52D7C
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 02:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECBFA88403;
	Fri, 16 Aug 2024 04:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="j3nasPwD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D2E888780; Fri, 16 Aug 2024 00:03:43 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12olkn20823.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2805::823])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95AFE88B07
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 00:03:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7GpzZgXfwXpNrRsYWikw7WHVl4sGNtvWMpg85L2LdtR6L3cf9THeBfP93qFJjzkVap/rarVzhryu6PPEy85/ChndcgsugHEHlwphT/kLRck7xjboq28chzel9i/WyEbHC33DsaxBENgIP75MjeNKTwcI6wa/xvBv8i9sQ/HbCC4byIvpalEvjM/Ee5BJY3oaG3lAsH5VegLIp/RLm5PGo2m7hS8CyEQA+U8qYt5CSFeE7kejWO1x8iLQD1Ad8TTu5wGD8FFmOe1LsMnQcYTJj6F7ir+uSrQob+7Kf8lBOXySWtcycIDtWtnl2r4pHLbz6trIV1xXFAQfNePddgGNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGxuJ6epLimXftyjJJYDX1d+hoGfL0sIH7WFSplQrA4=;
 b=JhvD3L7FqhJiKufYPgMoChUIpfkgYSCycc6J1QRU2fzhx83iE5Dw3n0RqJ0tjtjHUQ6AGFRrUrClTY2KBTaOaFgBzDWHsAqoYkzvK6F86XZ9/Nf6pqAYBVRhgIpj4/AZeOkYWuKs82VNV7Lt62oWsHad05RRBA4McM4OXQ3t8hGE1hn9i/CYsWy9XhbuJ/dQPY4dHqOSdylBk5JxhtjHHLE95NvrBRStUa6yyzGZ5pShEJX38mBq8Wk3smTGcA/8SIuXTNOaPnax9/9ZLW3POLcT1pntOScXpfPGCkg/mx2BOZJkAwIEte38/8xDdNckat1kxPhK/aMUwcs/H4a0Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGxuJ6epLimXftyjJJYDX1d+hoGfL0sIH7WFSplQrA4=;
 b=j3nasPwDB9uqS84Im1029rYeM57+LeSobhVTu35JnbxIZoRxwaCRPX04EVaL6YN04aUPB1oWuUDxZg74UWNIp1IrBhA/j7RKbjqO09/ddedCBsRht5JsK0BAnGWvnOtcQdySdBO/uWLNrXVWTKXXJGV8CViSBG2qcqVVy8OvHhaSUgFWUuhgUsQv4b02KruSAuJEAJ9jgHw/bYIyq+jLaYljjl3carEUNgTWHT074gZikGjwSY+0PqDePjb6YIFqIsNWfonqcOf4D9NdVWOaKNo2rthm+BjIh8SnktFVCGmSI1YIdZKNwcWxAAxuoDgABTtBQ/LUH2DvqedQpYg5MA==
Received: from MN2PR16MB2941.namprd16.prod.outlook.com (2603:10b6:208:e1::15)
 by DM6PR16MB3656.namprd16.prod.outlook.com (2603:10b6:5:2b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 22:03:32 +0000
Received: from MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490]) by MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490%4]) with mapi id 15.20.7849.019; Thu, 15 Aug 2024
 22:03:32 +0000
Date: Thu, 15 Aug 2024 17:03:29 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de,
 sjg@chromium.org, jernej.skrabec@gmail.com,
 neil.armstrong@linaro.org, hdegoede@redhat.com,
 andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com
Subject: Re: [PATCH 3/9] sunxi: H616: dram: LPDDR4: adjust settings
Message-ID: <MN2PR16MB2941DD94188EAB2807701C9FA5802@MN2PR16MB2941.namprd16.prod.outlook.com>
References: <20240801225519.336667-1-macroalpha82@gmail.com>
 <20240801225519.336667-4-macroalpha82@gmail.com>
 <9b7db179-1e08-4690-97f8-b040f1c19f37@gmail.com>
 <66bd1c50.4a0a0220.192aee.024e@mx.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66bd1c50.4a0a0220.192aee.024e@mx.google.com>
X-TMN: [26jjbiLQ/sHYT7J1j3gPFwW/A4jWUIQ785Lnfe60Mys=]
X-ClientProxiedBy: SA9P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::35) To MN2PR16MB2941.namprd16.prod.outlook.com
 (2603:10b6:208:e1::15)
X-Microsoft-Original-Message-ID: <Zr57MSpXsuGiDpx7@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR16MB2941:EE_|DM6PR16MB3656:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e84cf3-d7ba-4fb7-505b-08dcbd761a2a
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799003|5072599009|461199028|8060799006|19110799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: FmBG/5KJdg1fnMhs+qo2OfdiYaxSMQ5AoCUcTD7aJXiG2RJDDIUWHxw4Hfak0u6G0ftyM41yJzDTcjA+0qTIV4Ua8EQnX8dvS669LlV2PikifWg1mKU8yRLSeXxGuYuey/KIoy1BMu/Y+coMKN7SEKwcqyMZlbqhaUUHgXjbBKAXytxLKAgpRYxDvb5c4mq84fs0XZGW29vAW2wlA1hLpkXyj2B0kDVQs5i17q8kv6F5V0gkdEOshkSFcPBbvyUctjWSr8poARal0sMZuwISIAP0Qn6WKUGxKFA4Ts4OUfsBq6okBuu6r+tWLfjFaYLr/Iww5lTYqfHzsk1xUyxYAzQOCML0rEnApk5YcrCieEPtOtgx0Nk45GnLx+5jJVGvAn7Oat4aBHFGV4kdWrdL5JX1ub4MgsxQuJIAFhBnShfC2nao5Cv5ZLnhEL8vveZGeoFL9HL2mPkKHDv1mcDUxytJ4vQOnEa8yiNmt5nNzlX4nw+wnNgkZEIvcmp3H6MniSkhHVesT503Ad/7aXbFnL8TBmLrkLzs0Rff4u8yahoiq/fjjd7wAegIUQ8692I5/LOzoHiYFvs6z7iLTojIruATZU5mSsYWQwg8wLXsYl/TrDUHitRcwIemU/iWB7vwc+WY3QNIF2J9Gy6uixS5YAZQ2dKhkbq48bhjPN+pFf4aq7EZ9YWFHhzwpQGL1Rth2KoDZ6LX4Cv8SVcWLmYVwg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tHyPhaHAEn6kXmyBh9QiyctNuegnvEr8vB1jWhCaNRpdcdGJKsoIvkHVr1Y/?=
 =?us-ascii?Q?Sup0Zel73fkm0Bs7oFY50G7XdUiTi7iLq2FFaiYVGClkyyiC6XDMPfWxD5S2?=
 =?us-ascii?Q?Y2ijHD2d90Q1TwVf8PeoMWpaRjVp4N5/bTYj3B2qqcrGhcd9JFwCA2HMi2iQ?=
 =?us-ascii?Q?naZBSs90j5baYS2zAuL1cX+OTqAQBTfOSplBEZ5wBIuEH+CfXxUxvkSRzZwY?=
 =?us-ascii?Q?rcdmNwrRkmFgokH+cuGsc4A+BJAIBJu5Onah0fNXu5rzGQWqUYuaIEs8N1Rw?=
 =?us-ascii?Q?EuNPle19+UQjA31ITMHFbgqMJ1XaimpkAoguo4uMhgZPQvPRE3ODYFp9j7vX?=
 =?us-ascii?Q?9DybleCJ6uJFQN99q8jjrjRA40pnSv8TkbhTS1zVwC0iBWY1CXV41KxrYCb6?=
 =?us-ascii?Q?VPofzXE7faDcEHYmHvN90yO3jeqWmqHZmflzdd1e1MAjnCSb8qf6wseqCczT?=
 =?us-ascii?Q?UKBM9HfTeaFqgIzSEcIPqq1ObrtCUVFwjURAgZf104e44dt+v7eqVx6ZLhQq?=
 =?us-ascii?Q?gBteV2URwNnZ2+ngACyyziuj+Jjo4+rMEYgcV1n7JLVhNlRNKsEOsXNHxeHV?=
 =?us-ascii?Q?XIYNikXO1ZD28q475wI4Pmv8FGJzZOww8QzwjQurrb3qrufOze/7IQNMc2ko?=
 =?us-ascii?Q?zWCFvC21EhI0fyMta23Qww14xIqeefnw9tKO52D1pk/AlesnCAUpOZ/uuvLi?=
 =?us-ascii?Q?tAMnVt2Ct9oDgHWcGN+yZwwrsy7M2xg33aWbr9V3FSaXb05SU38F+o4H7BB+?=
 =?us-ascii?Q?VDO48R8YK3PEovadY8k7xQ/+Yu2MSuYoOT5byiGJlkynWbxUGwJ/wp33hycb?=
 =?us-ascii?Q?oG2NfVbWpZ2/WcBmXBNAoJF9mQktGualCzfbaSiosmn+HtaefYQbHLX5+pQ2?=
 =?us-ascii?Q?MZSDcB9pd8+XeXzgjL+5WOIn3BYP5y43cMiN2f05vGR6omoZw8lOLVhwF0nS?=
 =?us-ascii?Q?CEyesWKL7XGCQHCjS+jh/xYZ0VepLiV55wgmpUnnYa966NUyZq4VcsU8UKej?=
 =?us-ascii?Q?K9BoQ9IeZWmKdpz2yQZ8izwF93/DRoIoyu18V85au+Ys+J444foyR0hJanBG?=
 =?us-ascii?Q?FcqpR/4pymEtHmwjjFRhKUps21DNOhhA7sZ4RSGGpGTb0YBU23e2lPHg+dtX?=
 =?us-ascii?Q?LBDiMNZ2kw6LO0vQdo7Eb0NAR94+vzKpKfD3qFFofxRDyWeSfNuQkVjuX5Pt?=
 =?us-ascii?Q?1XvKj2Ts+46n7uwIzefUxUYOJMtZ7aUYUPRiHgvCSERyupec+Ap5RQcNs4Uk?=
 =?us-ascii?Q?FZPgeMeOBpQ6Q0TnR/X2tNEZohqzij3Rw2r6pjw9IQ=3D=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-559fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e84cf3-d7ba-4fb7-505b-08dcbd761a2a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR16MB2941.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 22:03:32.7900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR16MB3656
X-Mailman-Approved-At: Fri, 16 Aug 2024 04:08:19 +0200
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

On Wed, Aug 14, 2024 at 04:06:23PM -0500, Chris Morgan wrote:
> On Sat, Aug 03, 2024 at 03:29:17PM +0300, Mikhail Kalashnikov wrote:
> > 
> > On 02.08.2024 01:55, Chris Morgan wrote:
> > > From: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > 
> > > Adjust H616 LPDDR4 DRAM settings to be in line with vendor driver.
> > > 
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > Tested-by: Chris Morgan <macromorgan@hotmail.com>
> > > ---
> > >   arch/arm/mach-sunxi/dram_sun50i_h616.c        | 35 +++++++++++++------
> > >   .../dram_timings/h616_lpddr4_2133.c           |  2 +-
> > >   2 files changed, 26 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> > > index a20264d8b4..b6638c519e 100644
> > > --- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
> > > +++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> > > @@ -293,14 +293,22 @@ static void mctl_phy_configure_odt(const struct dram_para *para)
> > >   	dmb();
> > >   }
> > > -static bool mctl_phy_write_leveling(const struct dram_config *config)
> > > +static bool mctl_phy_write_leveling(const struct dram_para *para,
> > > +				    const struct dram_config *config)
> > >   {
> > >   	bool result = true;
> > >   	u32 val;
> > >   	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 0xc0, 0x80);
> > > -	writel(4, SUNXI_DRAM_PHY0_BASE + 0xc);
> > > -	writel(0x40, SUNXI_DRAM_PHY0_BASE + 0x10);
> > > +
> > > +	if (para->type == SUNXI_DRAM_TYPE_LPDDR4) {
> > > +		/* MR2 value */
> > > +		writel(0x1b, SUNXI_DRAM_PHY0_BASE + 0xc);
> > > +		writel(0, SUNXI_DRAM_PHY0_BASE + 0x10);
> > > +	} else {
> > > +		writel(4, SUNXI_DRAM_PHY0_BASE + 0xc);
> > > +		writel(0x40, SUNXI_DRAM_PHY0_BASE + 0x10);
> > > +	}
> > >   	setbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 4);
> > > @@ -859,9 +867,9 @@ static void mctl_phy_ca_bit_delay_compensation(const struct dram_para *para,
> > >   		}
> > >   		break;
> > >   	case SUNXI_DRAM_TYPE_LPDDR4:
> > > -		if (para->tpr2 & 1) {
> > > -			writel(val, SUNXI_DRAM_PHY0_BASE + 0x788);
> > > -		} else {
> > > +		writel(val, SUNXI_DRAM_PHY0_BASE + 0x788);
> > > +		if (config->ranks == 2) {
> > > +			val = (para->tpr10 >> 11) & 0x1e;
> > >   			writel(val, SUNXI_DRAM_PHY0_BASE + 0x794);
> > >   		};
> > >   		break;
> > > @@ -949,6 +957,8 @@ static bool mctl_phy_init(const struct dram_para *para,
> > >   		break;
> > >   	case SUNXI_DRAM_TYPE_LPDDR4:
> > >   		val = para->tpr6 >> 24 & 0xff;
> > > +		if (!val)
> > > +			val = 0x33;
> > 
> > We don't need this as the default value from
> > arch/arm/mach-sunxi/Kconfigcovers
> > this case:
> > 
> > config DRAM_SUN50I_H616_TPR6
> > hex "H616 DRAM TPR6 parameter"
> > default 0x3300c080
> > 
> > >   		break;
> > >   	case SUNXI_DRAM_TYPE_DDR4:
> > >   	default:
> > > @@ -1080,19 +1090,27 @@ static bool mctl_phy_init(const struct dram_para *para,
> > >   		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> > >   		writel(0xb04, &mctl_ctl->mrctrl1);
> > > +		udelay(10);
> > >   		writel(0x80000030, &mctl_ctl->mrctrl0);
> > > +		udelay(10);
> > >   		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> > >   		writel(0xc72, &mctl_ctl->mrctrl1);
> > > +		udelay(10);
> > >   		writel(0x80000030, &mctl_ctl->mrctrl0);
> > > +		udelay(10);
> > >   		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> > >   		writel(0xe09, &mctl_ctl->mrctrl1);
> > > +		udelay(10);
> > >   		writel(0x80000030, &mctl_ctl->mrctrl0);
> > > +		udelay(10);
> > >   		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> > >   		writel(0x1624, &mctl_ctl->mrctrl1);
> > > +		udelay(10);
> > >   		writel(0x80000030, &mctl_ctl->mrctrl0);
> > > +		udelay(10);
> > Looks like something experimental.
> 
> Should I remove it? Sorry but I'm not super familiar with this specific
> code.
> 
> > >   		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> > >   		break;
> > >   	case SUNXI_DRAM_TYPE_DDR4:
> > > @@ -1108,7 +1126,7 @@ static bool mctl_phy_init(const struct dram_para *para,
> > >   	if (para->tpr10 & TPR10_WRITE_LEVELING) {
> > >   		for (i = 0; i < 5; i++)
> > > -			if (mctl_phy_write_leveling(config))
> > > +			if (mctl_phy_write_leveling(para, config))
> > >   				break;
> > >   		if (i == 5) {
> > >   			debug("write leveling failed!\n");
> > > @@ -1234,9 +1252,6 @@ static bool mctl_ctrl_init(const struct dram_para *para,
> > >   	setbits_le32(&mctl_ctl->unk_0x3180, BIT(31) | BIT(30));
> > >   	setbits_le32(&mctl_ctl->unk_0x4180, BIT(31) | BIT(30));
> > > -	if (para->type == SUNXI_DRAM_TYPE_LPDDR4)
> > > -		setbits_le32(&mctl_ctl->dbictl, 0x1);
> > > -
> > 
> > I have this piece of code in the opizero3 mtd dump. This condition depends
> > on tpr13. Judging by the dram_para parameters, it should be performed for
> > lpddr4 (and maybe ddr4) memory. According to the opizero3 dump it should
> > clear all values and set BIT(2). Don't know, why I only set BIT(0) here.
> > This
> > may be a bug or another spl from t507 and the first version of the driver.
> 
> What would be correct here then?

I've tested removing and/or changing this to writel(BIT(2), &mctl_ctl->dbictl);
and it failed to work. Leaving this as it is things do seem to work though.

Let me know what you want me to test here and I will.

Thank you,
Chris

> 
> > 
> > >   	setbits_le32(&mctl_ctl->rfshctl3, BIT(0));
> > >   	clrbits_le32(&mctl_ctl->dfimisc, BIT(0));
> > > diff --git a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
> > > index e6446b9180..6f5c4acbd6 100644
> > > --- a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
> > > +++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
> > > @@ -23,7 +23,7 @@ void mctl_set_timing_params(const struct dram_para *para)
> > >   	u8 trcd		= max(ns_to_t(18), 2);
> > >   	u8 trc		= ns_to_t(65);
> > >   	u8 txp		= max(ns_to_t(8), 2);
> > > -	u8 trtp		= max(ns_to_t(8), 4);
> > > +	u8 trtp		= 4;
> > >   	u8 trp		= ns_to_t(21);
> > >   	u8 tras		= ns_to_t(42);
> > >   	u16 trefi	= ns_to_t(3904) / 32;
> 
> Thank you,
> Chris

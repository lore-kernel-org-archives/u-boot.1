Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3178FD460A
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 02:20:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C15B883642;
	Thu, 26 Feb 2026 03:20:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Mrjyw8NI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AAE983AA9; Thu, 26 Feb 2026 03:20:52 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAAA982A9E
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 03:20:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=han.xu@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pva/kVW/MHymG5FK9CFb3HgTwvQZtSf4d2VKAXHrSmL0MrBE9EP6Ht7FWKlA/z0WTvsxa6jfGuSbkl4lGCFBKZmHq/w86WxNOrSRtISFUke8d0No4qs8uL6zq0uCDSL2C/Wdb1oko2vWFMQLqOv2oO04uFQjuMcEqX6YXYnbMF/dts6sfZhoZzINvPFaD2NkA6aJNLv2EVFJlY1rd68eTgm4BqcSf7CXB9tVPTQq1ISOLjvIHu/lX98llZ7qjje/DotjLfRut709b0cCr+KJ5M8FHlRavNVmCYH9Wopcotlec2TpDoOnfPnXyW72fFC4MJsd26iYqgH7XCJiweBRUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FPd6t1wy2GTrpjqVUaWkVquIlJmWwPw4u6sAQ/wZdo=;
 b=kXXTn12EBaBC4GLjlY/omJ1ie66r0fdQ6EnihQE4c3pP5NZU/mZ5jsPg90ab/tK+AjVbrVy3Y+3X1lMqOis7Tr6KqoykIiLF2ZJqPwrAtE9GuXAOjgLjt2AtEbPltb8Vm91Ah3TrDaz9BK9TSHpu6YUyg+8DlaUOb7VjVXrHPkjzmVSyur23bGq8+bV8IzyjvmY6G5b5SxgDNpwYE/lZMk+4ChQLFCjzpLIXXKMzr01+WXbL2xt2tFeJmH17hUqEgAqi2ep5JmEcBoubgh+5ytNQoC4gcOQaQCTrOwrrCERLbZNLxZ5uOYOsudHHhHoJppjxLhX7O7c9FLuU2k3KSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FPd6t1wy2GTrpjqVUaWkVquIlJmWwPw4u6sAQ/wZdo=;
 b=Mrjyw8NItLqqNZOyrZaxQ8DkvNfb8fshv+ujCwSlL+Ki+rfwnwum1ME5ejyZB0vBJ2qEHNt7F8F1UNaONMewFS9TNWcu4+O9ZfFmK/e8lmPzBMtGw0AN/WpOc6/lWRQ7LvY4uwLRyumMXWWJnF/eyXEQqFgzmlYGKYGN3IUa3EpGwJatTuz8HQMmmrKbhfP2ab/HsAsl+bSOSRDsXzig83awrrAL6/0Cp4xOmGE6lLrTRjCR+tQhqjJzDUKs4Lj2aYR/caSciPwCkR4k9RpyxsP00ZXthEh2bNVdTrIpYOoRXbd9dTOuqjLup04t7K5nZy1+4G8oDxrmPMsDEzORjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by AS5PR04MB9799.eurprd04.prod.outlook.com (2603:10a6:20b:650::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 02:20:47 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::7010:9f6:4361:43bf]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::7010:9f6:4361:43bf%4]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 02:20:47 +0000
Date: Wed, 25 Feb 2026 20:20:42 -0600
From: Han Xu <han.xu@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] mmc: Add support for eMMC 5.1B specification
Message-ID: <20260226022042.36v554sv2jdeav4h@cozumel>
References: <20260225211332.1896252-1-han.xu@nxp.com>
 <PAXPR04MB8459A20AF589F830523FFE008872A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8459A20AF589F830523FFE008872A@PAXPR04MB8459.eurprd04.prod.outlook.com>
X-ClientProxiedBy: SJ0PR05CA0206.namprd05.prod.outlook.com
 (2603:10b6:a03:330::31) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|AS5PR04MB9799:EE_
X-MS-Office365-Filtering-Correlation-Id: d925396b-39e4-4bad-7eed-08de74dda738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: COwZiFEyDlRn+9GYILZvbw1AaVF4tXmDzMQKTIUYlOpweHa25uPaAUfbKO63YiSs9D0x9M+83y4RabIFdS65bZ2vvmKQHka0WEF/bu8giPRiYDcUy2kpmpOyuFbDLqCDxB59KFCwLtwaUFRBOSWr9CfEeFRAs9iNVv7S0aX87UcN/GL3p1C9KPa4ZOka0GrhBSzvcvMTNqXKou2e9pMkK84IOBUvfcJ5gdwnLVpPAWVAd6LPCV7vRDayU3M/LoOIykrBlujLp3+SxUHWezNEy6wq1+pAGNKZP5ZTyn5hpTRdQ8YSHKDqxLineMaS1LlteDyEneTXapM5F6b3tI9q482FKgz/Zsa3Tn/sMf86OM2WC3kDJ208ehCT8nrnJXnz5fQPimBHa8gegtaDtOLku5JBno7wUVbwwRtAUhWDHb+vwRBdgK84gfXkItNGmXD1t2Q4x/1vn2k2UAf9sJYNSI4FLgr4Zymdl9+yVT3CFbFdBEGE9nS1QN+lxxCF8qCb1BNr3oDbWkkCkKDqMvK9kKW2jlZwa7GMTbhanjQpL1ceDMNl9uKr8PMc3mzW8FJYKdntaj6cK36qzWohSJR2cBwHTxtEz7o2/YgyO8NoMoVOcwx8DYZubeBqyNQ4MzwaonHJ44nBqqIXhB1pppY/pnumbH/3f7+ucQQdGsCNhXS6Y8empxDtqV/VGL+jryIIpx9U0CKWlT2uw4P0UgHpML4Knn3ViX9rI1SRjrvpk6eUInMRA3biW4jk/Csg1xu2+ZLTVIOKXm9PZxfzcz+qX8sihQPeunKECqVNypFddEI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9071.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yphHoc4w1Ro4fkn5Kv6B7EpyzsFE+Gl3Wc6jJGzbDXBKtYe2q27hODjuaU1m?=
 =?us-ascii?Q?2SD36CR8e9DliEEBz2NIIR/bpHDsz5fHWuot6wsrHSaxgdG4KdV5bPHf8k5L?=
 =?us-ascii?Q?N/wdq2chVwHu/tEJGWvYuNYA1BYSpylfxuwqsTmhHGcu0WO55ECV+Hn4bMPS?=
 =?us-ascii?Q?bqXeYa/tarzIe21JVHdrn2pvi36hbDwzBKmF5X+riyBvclEV/mH1+l3JAqqB?=
 =?us-ascii?Q?d0WLdUfXC2/KFqNoNCL+Asus2hFb1KIWpdEnenO2pORmI76bRvBk2rzZOe8B?=
 =?us-ascii?Q?QRFVMsrEwQQ6D8GekvCGTpT67ef546jeIJQ2RyQrYYrG50HtaTsDqRDzbv0s?=
 =?us-ascii?Q?jA4/LlCBscuDhR6zceIjUh7hxJHNYAOssCvvrHojdiB94VGrJXzZr97uAtmW?=
 =?us-ascii?Q?/L7SRH+qUoY1sWhKMjQD5Kn+I3IxMwEdxDXPjFiZEQdZCNJDRbMCadGx6gcd?=
 =?us-ascii?Q?cIxWi+1niAwSQ2fAxQtWvFEioR8hGjXGpZZnM5QO5g5HPv7RjDfeCZiqPpJ2?=
 =?us-ascii?Q?apa7Y5t63zXbLAraeOk9E7Dfw7uyt4xk7DJ9pGDWcP3yJq7Q8ySXPIjHnm2+?=
 =?us-ascii?Q?b1HcZU2m0n+SpxPMGNRhkoThO7mDa9bGrbSe0GLzEAXqQT5WbsRAF2A7+Sur?=
 =?us-ascii?Q?0yeQx11wdS4m4DOY8gMqYtB1j1AjnrJZQ0zmHFNzJjbT2UHo9GJOSor5brD6?=
 =?us-ascii?Q?eNU9Bop+DLSAXmypomPrXOmhYwZnNljJUkZsHGBh4fcO9B1xTNpLhPbZPsAA?=
 =?us-ascii?Q?xcDY3ep9/KT9RSj4W6TF4py5REI651tF2jJCKsKUSGCHXvIvsPrmLgJRmoQJ?=
 =?us-ascii?Q?7kls3F2LaJOiCM56IyTEzoyW28646iTisMuIX1piaRwxk0SOvy81PnTS59wK?=
 =?us-ascii?Q?37KvinP8flsqMBvTXo6ESiqsgO/b3MnQI2neGuxXDu/OpT2FlBiRaj8HC0bY?=
 =?us-ascii?Q?iI9WSz/St//n+RJslLd//k5Ak6q7+mGFsfK3P4mDBccmDOo3fzG9Edny82gy?=
 =?us-ascii?Q?1+7MwCV4ozavrIFqA82opY7Sry0N9AUctYuv7J9oTMsL6vKiVQtxO3qNQ7Br?=
 =?us-ascii?Q?v+CQvA1EwGWN1y37D5qPHki1ZIxLsJHi5v3N1NLqL6ZA8mmyPs1Kz7EsdP+5?=
 =?us-ascii?Q?yCfyhNobStFiNa0aazhUJwh9O0ZtQPROpdTScl2ikrFxzUtoQHRCrlTpoIeX?=
 =?us-ascii?Q?m0fLrde9EXVO+m+PSkpIF7ElUwZRBRuTN2Vi0dOW2JS2570NlVxF/DBONvut?=
 =?us-ascii?Q?Ub23OuXoxvZHYFj/ebCUQpTSy7BK+IXVClxMtirFH+dp1Sd0rPEwGjTWES2I?=
 =?us-ascii?Q?sU+b+VtBKF2wsl1aWPPvf9NAY4cQwNEmwvjC64NrWr0AzaNrA/Uinl/QLlit?=
 =?us-ascii?Q?OHUncKKFdY6nx4F9qMwo5z35xlDgbwoo6l5gxaEjT8iueIjCSdtnXYucPYNg?=
 =?us-ascii?Q?OJtuoes6epVUkaM6VDjdts0C3r1aTdra9NBigmhvaWoyw0gUF/cOb28jPI4r?=
 =?us-ascii?Q?HxMvdtG8cfRzgRcncDW0P9ev0b2WJITGbldhy5Qfig48EM7qwnKa4K2PcOv+?=
 =?us-ascii?Q?jpkgs2arHCK3FArjrsfxZXMH5wvG7TyKseElvsNptBSEpWrbb6+x9IBkapAq?=
 =?us-ascii?Q?M5ANZr/iuDExXBHwkONvVV779MYet0yJWw4bTnCq/WooyRyQrvXwklUxS5NC?=
 =?us-ascii?Q?Z9GIhDTQY0H3K/76WPV9oRgI1ZEeUhzemd6BaNjg5i8WzL34?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d925396b-39e4-4bad-7eed-08de74dda738
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 02:20:47.7835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wnj6K0GmGENKsD1Z/dJCl3/2m8L6AwdIqP6bjffoCZHdws/UGILmoI2Ni/Bv8RD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9799
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

On 26/02/25 07:37PM, Peng Fan (OSS) wrote:
> Hi Han,
> 
> > Subject: [PATCH] mmc: Add support for eMMC 5.1B specification
> > 
> > Add support for eMMC specification version 5.1B by defining
> > MMC_VERSION_5_1B and including it in the version array.
> > 
> > eMMC 5.1B (JESD84-B51B) is a minor revision of the 5.1 specification
> > that primarily addresses MDT (Manufacturing Date) adjustment for
> > dates beyond 2025. This aligns with the Linux kernel commit
> > 9996707822f82
> > ("mmc: core: Adjust MDT beyond 2025").
> > 
> > Since the manufacturing date field is not currently used in U-Boot, this
> > change has no functional impact beyond proper device recognition.
> > It allows the driver to correctly identify and initialize eMMC devices
> > that report version 5.1B in their Extended CSD register.
> > 
> > Signed-off-by: Han Xu <han.xu@nxp.com>
> > ---
> >  drivers/mmc/mmc.c | 3 ++-
> >  include/mmc.h     | 1 +
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c index
> > c5705f4f215..f0e38efb262 100644
> > --- a/drivers/mmc/mmc.c
> > +++ b/drivers/mmc/mmc.c
> > @@ -2343,7 +2343,8 @@ static int mmc_startup_v4(struct mmc
> > *mmc)
> >  		MMC_VERSION_4_41,
> >  		MMC_VERSION_4_5,
> >  		MMC_VERSION_5_0,
> > -		MMC_VERSION_5_1
> > +		MMC_VERSION_5_1,
> > +		MMC_VERSION_5_1B
> >  	};
> > 
> >  #if CONFIG_IS_ENABLED(MMC_TINY)
> > diff --git a/include/mmc.h b/include/mmc.h index
> > 51d3f2f8dd5..9509c9e9543 100644
> > --- a/include/mmc.h
> > +++ b/include/mmc.h
> > @@ -54,6 +54,7 @@ struct bd_info;
> >  #define MMC_VERSION_4_5		MAKE_MMC_VERSION(4, 5,
> > 0)
> >  #define MMC_VERSION_5_0		MAKE_MMC_VERSION(5, 0,
> > 0)
> >  #define MMC_VERSION_5_1		MAKE_MMC_VERSION(5, 1,
> > 0)
> > +#define MMC_VERSION_5_1B	MAKE_MMC_VERSION(5, 1, 0xB)
> 
> https://lore.kernel.org/u-boot/aYH6H75gduflgjlR@nxa18884-linux.ap.freescale.net/
> 
> I have same question here.
> 
> Thanks,
> Peng

Yes, I met the issue when testing Samsung KLMBG1REWF-B04Q eMMC, the mmc info
command showed nothing and return error, because the mmc initialization failed
at mmc_startup_v4() function when checking the version array.

With the code change, the mmc device can be recognized and worked properly. 

u-boot=> mmc info
Device: FSL_SDHC
Manufacturer ID: 15
OEM: 0
Name: BRWF4R
Bus Speed: 200000000
Mode: HS400ES (200MHz)
Rd Block Len: 512
MMC version 5.1
High Capacity: Yes
Capacity: 29.8 GiB
Bus Width: 8-bit DDR
Erase Group Size: 512 KiB
HC WP Group Size: 16 MiB
User Capacity: 29.8 GiB WRREL
Boot Capacity: 31.9 MiB ENH
RPMB Capacity: 4 MiB ENH
Boot area 0 is not write protected
Boot area 1 is not write protected

> 
> > 
> >  #define MMC_CAP(mode)		(1 << mode)
> >  #define MMC_MODE_HS		(MMC_CAP(MMC_HS) |
> > MMC_CAP(SD_HS))
> > --
> > 2.34.1
> 

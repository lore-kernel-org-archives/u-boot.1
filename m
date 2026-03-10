Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B27EB1067
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:15:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBE2E83FBC;
	Tue, 10 Mar 2026 16:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bDXBvgqM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3D5684027; Tue, 10 Mar 2026 16:15:51 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9259083F53
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 16:15:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yz6/hcQm4g2Ho3iAigL6WhbyBqYg0A9qVIa/sE6KwOuQyANxBvwgF6vjfj0HOvaE28+x5k68kiUIysbq3fkwqTAN/TIlwltv7ynpRQPOUYEy/H0TmbJ0S2SCOJ/XO0RKkPJ2rrvNkCpjJ7anOP+Y4obWO1blSIIUHycoiQJ7fjlj7pEPfVI9pK9CM3HaPJOBytoqgrX/fmEvkgjJeNcoEjxga1BOwSVJIspSOhW3WeVYIeNhtLEjqPhKg0FyWloqdGrGProC9dCV8k1S1O9qV+h26M2J1WQPwCw3Rk2aIDGTZAs7HuYO5XsN96f3dnXrfb5TYKt3WR5gzwDFWB9MuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hu4/r4MPNeastRbhVYqjSkZmhWyqbdBt4QEXKVDuhGw=;
 b=mB+0bsklCZ3nRzqz2u/f/HKdJozJer9MdnyX0ZDHl3XfEAAhmGF0aeoxz06VdE1qm4ptxtvlD71yLHne3h9L6MKilUGBvOKK4yvo54cof+Q/XOl1PvsK/xdQs/YJYaMFLRNqiS0wIrbyPFQAvPKlBwgyljACavhnHtaOuLA/Ij5+Wkyv56+PHTpAfLRKZxTVmEANFX8Xf6Y8g5fjes4Qf1SOJpjut2BkduqL0YmYdrhd1YEadxV7Ls0lZPYF+5n3q04TCMmRBXT0nvCFZ618zNkvurOrKOrqxnqNmfcKnWXVU4T7apRweeuC8lq4iaBImC2L/lid3kWvNJ+i9h/t0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu4/r4MPNeastRbhVYqjSkZmhWyqbdBt4QEXKVDuhGw=;
 b=bDXBvgqMHhTmVUvwNqXrJG4n9lBBxU7Q0Zonrq8T4E+/nva2l9sZEb0mp40GVSI5LzSnwkznts/dMCrinnoS8hCA+3bfaXrlTCMFT1s6SzQLir0t3aSylB+tHoV5QEp8140VdNFewSJtW3vBHCBBOfN7bcXq36PIaj46ygcFdsIsE93HFZ99Q2RH+LuO2u75Hv1OU4z6qEtmtC/fzEBeqHlVzHOWnBNvz0lmzAeBwetZxze/P6dXsJwse/8qRjmqmssO5fOv0l1R8ipFWAI8BondtYzYp7hoPifQ0GMKCcxDVBW5CbAEa+qC0ajXLjgaW85U6vXLbzucMV0iXxjVBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by DB9PR04MB8108.eurprd04.prod.outlook.com (2603:10a6:10:25e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 15:15:47 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 15:15:47 +0000
Date: Tue, 10 Mar 2026 17:27:45 +0200
From: Simona Toaca <simona.toaca@oss.nxp.com>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, 
 ye.li@nxp.com, simona.toaca@nxp.com, viorel.suman@nxp.com, marex@nabladev.com, 
 ravi@prevas.dk, fedor.ross@ifm.com, sebastien.szymanski@armadeus.com, 
 joao.goncalves@toradex.com, ji.luo@nxp.com, semen.protsenko@linaro.org,
 sjg@chromium.org, 
 tharvey@gateworks.com, ping.bai@nxp.com, qijian.guo@nxp.com
Subject: Re: [PATCH 4/5] board: nxp: imx9{4,5}_evk: Add qb save option in SPL
Message-ID: <llrc46dn7akdpro5bim3egfuuktyvwbrmb4odenspiz7tnwdme@3hc5leohkgzr>
References: <cover.1773137310.git.simona.toaca@nxp.com>
 <bd23b79dc06f39a9f19ee3da956de450aad03aaf.1773137310.git.simona.toaca@nxp.com>
 <34d4475a-8353-47c9-86fe-36e67ceecb69@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34d4475a-8353-47c9-86fe-36e67ceecb69@gmail.com>
X-ClientProxiedBy: AM9P192CA0028.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::33) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|DB9PR04MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 66351db2-bc5c-4234-f839-08de7eb7e7d3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|19092799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: COMFYQ92eN1UvXTBC8WKfaD7h72kdIYP/MyLaA/y1hknUlpyDqCfh06RbFBlRiBoa+XBnIgil5PW1O7kbILhh5MXnX0EZ00W/jAeeX7ZY7jBDJ8B/tKEqBKEZ5q76FUoMEohLrvHgpOyOxGHWCXj/xUmX+9dJbjiKROPgaSdciRbrAOB7Zfdtbf1U06BAXqiYcLKE8NHY76wCpAkEzeX/iD7DPLATzitusfJeP2VHo0ciVVPQWoUNtcORSLDiCq/4EWxNOP+Y2h29w82qnzam2XmBXUhH6vTSVYuZfqVcpMjMQ9ogUMrv+eJe7OreumaA7ln0tEYF5Wb4qKfjIuNPUpe+8RoY5RHSpietl1kLC+3bNgu1HChW0IlYkKPNh/rtcaf+XksEsRhdu8ZQNFRRk4fvTJWUu7g+AIuHqcHjnut4g0I4vvpnOmrynt17g5s8Q4zE54ZhArCc8jKOVO3OyHgZiEmJAKKmP8ZVh8k+V/akEUpORGwqeyTl0DMLKeM3NMa0V5NNs1Qx3ypeCoFoU2B2d7KroWko/Kh5HpQp/E0LunJDbP5NWQYsZMYwQAznxPtnk9SS900JCoTOBUJ7qWzpfAXqDA6oRkKsfbE44Ngth0vQYZGjuCdBj1Ui4WyoapltKvlwjiap3xYR6tvurEt1tYbDufAj/wg6U7hmO7mUqzGB0SOgH8iSanETKBNj5m71fowp+tv3NZxnGkScbNlWTAPinb22sMGuLasigA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(19092799006)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5M7KeR5EE1evLVWFMtW9GtbvG9D6MjFWt9B8lbdDByKo7rm/3y/byVywJeIc?=
 =?us-ascii?Q?TT/xQ3QVheNJkAm+Cbbfynt+xbDfy3GYRlPXjxo5cZwahQU8y5hDi9zFz1b7?=
 =?us-ascii?Q?Zlhe2KKsHkCT4Tm7f48lDzGZa3COmtgxS0p00c/yfqJ55Tbh37NOTY3IbuN4?=
 =?us-ascii?Q?Ujxvn9StANyUIIfiwv5L7HUXARedRFp/FU9yOuRvcSd/53rV4rRtUI/WiClG?=
 =?us-ascii?Q?nUB+yC21ByHHFxgCL6ojL9Lm+f+mOa0B8ZmYNViOu46BWAvbO8oSP33S1bT7?=
 =?us-ascii?Q?2SsFhBfdjPD4onHH4qHnJGwL7op5DbWXTCU4XJyQvmJU//xrPGDSCCAVaYnX?=
 =?us-ascii?Q?VuQtG0KCSAgwhNwaNZ73dpiwhTOhNdKd2Z+oWjnJBopYgYozurmw5ogpMGxY?=
 =?us-ascii?Q?UYp74l3U0VO9x294oAX80Joe3hT6KQg79rNDZ7ZIWVHG36JW/xkjzHFR14Wg?=
 =?us-ascii?Q?LtuvK25xVB1uHreYHWAYe503k4gifs0HZrJyLiUCI6IJVzkXOvJbiP4TahI0?=
 =?us-ascii?Q?Ofp0vUk/NNHFEO/esti2TdbnEoz2LZLEIrhlfAuY3MwmkgF5Pa+PmcjQeDJm?=
 =?us-ascii?Q?bEyzOMeziAmxp7ZMUdxrH0uxS5V+ZQz+9wfsTqetdHciAmXVxhJEv/7StVuv?=
 =?us-ascii?Q?v9sYHOCnhcviB7GQ3FLwc1yQg/DUZJemDd+5Bkr9xJrk5VAZieD5VXV96+Fl?=
 =?us-ascii?Q?wwrAb1dI8dIUUxZSbwGCQn/0fKRyu+d65O75zryQPZHH6MmrUYll9g9a8hjr?=
 =?us-ascii?Q?Y1/IVlhf2e+aq3Ihot5gUFqxLW15z5dpzwVW/M9nkShqsUsrWxL143MlaP1o?=
 =?us-ascii?Q?XFYK2kkelwSvnBMZW4+d+caWs7E9e0I94Eky/jmNKYUdbOPlfxgAaUvISXcN?=
 =?us-ascii?Q?GMJ67XscaFG0viLgbDqWKyxO5w+lhrux41bWxjVHKIWUOvz7KYZBWRc+zbQ2?=
 =?us-ascii?Q?agNFpz+m4SdE53jAkyKculnZHSf/bWidj4FlBo9uGmFMALYeM7YMU1/Nli9b?=
 =?us-ascii?Q?hxf5jQK/KJGjy9BX5Y6nwBK0NgcKbVq8JYcx/ClMPaLkdNacz0l+WYNhA2m/?=
 =?us-ascii?Q?7VKclKclq+FPtJcLf+SuWxYsm4Iu1QklKMRJxIDw5I+0JZQb34kpnnOlOZ5X?=
 =?us-ascii?Q?HZd9krSJ+YWodeBHN4DkayhK8KzbKgfhoVXyH9ZMq1xUa/yly3qOu3/6dsnE?=
 =?us-ascii?Q?OpELNZd1IC7pn5sz0SQQObO8umXHpr5tcJbAi6vhiodiLOOF+lazMSBB0mO1?=
 =?us-ascii?Q?UuB3NX1qgpeoXQp3kBYDhuc7kB6nd2dfWNLYyL+BdzXP0pmrA5pH/DoPZON/?=
 =?us-ascii?Q?NB+skq8wemAUtG6z/QzDAUgTvODcKsQGWs8S0KSPFBY/mZQI89D67GDvpX1C?=
 =?us-ascii?Q?UksiYIYgvM5+saYoTFCNd1wWKmD1xcCFkT8xCCpfVZ87EWb6KGFsU9mUeTKT?=
 =?us-ascii?Q?VoEqfBOVWBMzJ274qVMR0fs0+OdbaWSNYRoKJD2t0EeWbxJjvLVPfpAE/fQp?=
 =?us-ascii?Q?ZlYnyjbizOY43bSNztBDg9L0ZxbAUsVWf5zehKFYDUhA2wkwFkNOmJR/fWE9?=
 =?us-ascii?Q?eWDuzcpXGdCW4OF0WDiyQThxR0eEpBRqFBrksbBtXqJ8mu3LQfJxXv3lxEbt?=
 =?us-ascii?Q?LZBKmV3Wiu6l/RKtgcGtuUFeemcVYNQbKgP0I4Ijdo3clQRRNUHP/KXtoby0?=
 =?us-ascii?Q?nSySaRTSMgIquBTeY35TLYBuvc5p7oreqACRAUjaCfPVhQicgDNAOibmHKHs?=
 =?us-ascii?Q?mYltgMdzMw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66351db2-bc5c-4234-f839-08de7eb7e7d3
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 15:15:46.9058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdwpP4Bqkh7TwmuDH31BeAsATCRtX2ew8UTCOD6dJWspOYljQdXMzWno6/oUeJM3L6nD71npNt+jfn5g88sZtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8108
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

Hi Emanuele,

On Tue, Mar 10, 2026 at 04:04:19PM +0100, Emanuele Ghidoli wrote:
> 
> 
> On 3/10/26 12:54, Simona Toaca (OSS) wrote:
> > From: Simona Toaca <simona.toaca@nxp.com>
> > 
> > Call qb save automatically in the board-specific
> > spl_board_init(), if SPL_QB option is enabled. This
> > makes sure qb_save is called before any image loading
> > is done by the SPL.
> > 
> > Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
> > ---
> >  arch/arm/include/asm/mach-imx/qb.h | 2 ++
> >  arch/arm/mach-imx/Kconfig          | 7 +++++++
> >  arch/arm/mach-imx/imx9/Makefile    | 4 +++-
> >  arch/arm/mach-imx/imx9/qb.c        | 9 +++++++++
> >  board/nxp/imx94_evk/spl.c          | 6 +++++-
> >  board/nxp/imx95_evk/spl.c          | 6 +++++-
> >  6 files changed, 31 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/mach-imx/qb.h b/arch/arm/include/asm/mach-imx/qb.h
> > index 5efe68f0a60..4f923d79e7a 100644
> > --- a/arch/arm/include/asm/mach-imx/qb.h
> > +++ b/arch/arm/include/asm/mach-imx/qb.h
> > @@ -10,4 +10,6 @@
> >  
> >  bool qb_check(void);
> >  int  qb(int qb_dev, int qb_bootdev, bool save);
> > +void spl_qb_save(void);
> > +
> >  #endif
> > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > index 17aad696648..069b25c6241 100644
> > --- a/arch/arm/mach-imx/Kconfig
> > +++ b/arch/arm/mach-imx/Kconfig
> > @@ -71,6 +71,13 @@ config CSF_SIZE
> >  	  Define the maximum size for Command Sequence File (CSF) binary
> >  	  this information is used to define the image boot data.
> >  
> > +config SPL_IMX_QB
> > +	bool "Run qb save during SPL"
> > +	default n
> > +	depends on SPL && IMX_SNPS_DDR_PHY_QB_GEN && (IMX95 || IMX94)
> > +	help
> > +	  Run qb save on bootdev automatically during SPL.
> > +
> >  config CMD_IMX_QB
> >  	bool "Support the 'qb' command"
> >  	default y
> > diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
> > index 7dee144e0f4..3207013812a 100644
> > --- a/arch/arm/mach-imx/imx9/Makefile
> > +++ b/arch/arm/mach-imx/imx9/Makefile
> > @@ -15,7 +15,9 @@ obj-y += imx_bootaux.o
> >  endif
> >  
> >  ifeq ($(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN),y)
> > -ifneq ($(CONFIG_XPL_BUILD),y)
> > +ifeq ($(CONFIG_XPL_BUILD),y)
> > +obj-$(CONFIG_SPL_IMX_QB) += qb.o
> > +else
> >  obj-$(CONFIG_CMD_IMX_QB) += qb.o
> >  endif
> >  endif
> > diff --git a/arch/arm/mach-imx/imx9/qb.c b/arch/arm/mach-imx/imx9/qb.c
> > index fc01d8e22e9..79573741d39 100644
> > --- a/arch/arm/mach-imx/imx9/qb.c
> > +++ b/arch/arm/mach-imx/imx9/qb.c
> > @@ -428,3 +428,12 @@ int qb(int qb_dev, int qb_bootdev, bool save)
> >  
> >  	return 0;
> >  }
> > +
> > +void spl_qb_save(void)
> > +{
> > +	int dev = spl_boot_device();
> > +
> > +	/** Save QB data on current boot device */
> > +	if (qb(dev, dev, true))
> > +		printf("QB save failed\n");
> > +}
> > diff --git a/board/nxp/imx94_evk/spl.c b/board/nxp/imx94_evk/spl.c
> > index cc5b7f9ef0f..1d25795eb17 100644
> > --- a/board/nxp/imx94_evk/spl.c
> > +++ b/board/nxp/imx94_evk/spl.c
> > @@ -1,6 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0+
> >  /*
> > - * Copyright 2025 NXP
> > + * Copyright 2025-2026 NXP
> >   */
> >  
> >  #include <hang.h>
> > @@ -14,6 +14,7 @@
> >  #include <asm/arch/sys_proto.h>
> >  #include <asm/mach-imx/boot_mode.h>
> >  #include <asm/mach-imx/ele_api.h>
> > +#include <asm/mach-imx/qb.h>
> >  
> >  DECLARE_GLOBAL_DATA_PTR;
> >  
> > @@ -44,6 +45,9 @@ void spl_board_init(void)
> >  	ret = ele_start_rng();
> >  	if (ret)
> >  		printf("Fail to start RNG: %d\n", ret);
> > +
> > +	if (IS_ENABLED(CONFIG_SPL_IMX_QB))
> > +		spl_qb_save();
> Does it write to MMC/NOR/SD at every boot? Is that necessary if a quick boot
> was performed and the data has not changed?
> >  }
No, the qb() method calls qb_check, which returns true only if OEI
saved valid data to volatile memory (meaning it has run Training flow).
So, if Quickboot flow is run, the data in volatile memory is not valid,
qb_check fails -> qb returns and does not write anything to the NVM.

Also, another thing to keep in mind is that after a successfull
qb save, the data in volatile memory is invalidated -> qb check will
fail as well even if OEI doesn't run (so on a warm reboot).

> >  
> >  /* SCMI support by default */
> > diff --git a/board/nxp/imx95_evk/spl.c b/board/nxp/imx95_evk/spl.c
> > index 761a1a4a0f6..35e4458f2b7 100644
> > --- a/board/nxp/imx95_evk/spl.c
> > +++ b/board/nxp/imx95_evk/spl.c
> > @@ -1,6 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0+
> >  /*
> > - * Copyright 2025 NXP
> > + * Copyright 2025-2026 NXP
> >   */
> >  
> >  #include <hang.h>
> > @@ -13,6 +13,7 @@
> >  #include <asm/arch/sys_proto.h>
> >  #include <asm/mach-imx/boot_mode.h>
> >  #include <asm/mach-imx/ele_api.h>
> > +#include <asm/mach-imx/qb.h>
> >  
> >  DECLARE_GLOBAL_DATA_PTR;
> >  
> > @@ -41,6 +42,9 @@ void spl_board_init(void)
> >  	ret = ele_start_rng();
> >  	if (ret)
> >  		printf("Fail to start RNG: %d\n", ret);
> > +
> > +	if (IS_ENABLED(CONFIG_SPL_IMX_QB))
> > +		spl_qb_save();
> >  }
> >  
> >  void board_init_f(ulong dummy)
> 
> Kind regards,
> Emanuele
>
Best regards,
Simona

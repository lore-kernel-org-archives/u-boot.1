Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A3CFD875C
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 12:24:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55D868425F;
	Tue, 17 Mar 2026 13:24:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="StH2kN3C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B717D84261; Tue, 17 Mar 2026 13:24:42 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 994D284236
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 13:24:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwcrF+KzQ+xnL+9Rt6dLXxuCYRffMkLDMlw1EqTRQIu6tjxAo8XrM/pXSDZ72lwWjRJwHnI6uCCp5TfXHFYD0JugHsZ9j+f1Th4EjG78CkJ6Loc5Buy9VkETdxXbOU3fJnbpufr+gbLmErBYKBGANVDvBH/J50PgVp3hDQ3CIwfdaVn+P+PJDkGI7ela9CBgdBvwAOHPCxloKiyQ2T+qCtVAM2VX1thm+HOPRw8E2HOjwTbYE5eudU2wRwTwqxphKL7jReIx5F4b7t91SNAZWYgx25dFBZ5Min+gLw8+bze6pncMI59E2dWQ9vWssoDIjHgzFj9an8FEnM7yX+MXTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wfzkhGPtE8Do8I2XddEpJrDDG1wkzR7L1B5xMRAGsI=;
 b=M2LoIZWxjrunae1Xepx+H9B3vzunRXIh9eMUInTR1sRgB+ViI0neHMofJ7pK9TFcjemE7zkzrnWwU07uoq/M87KqeOX9uBU/6DdLAn5Tx0KacJdLoC0vx3EehZrgN7w0jYp080uQWF0VK82mtloYMPbQIyAdLtdrrVH3nnvrlxhIVzvscYxz1fGSbIVApjoBjnm5rRMWxVlKUplmWADCwABAjzj1rBoW+JcUKsO9W54TAG/Z1XQtjvoBU7v3LrBJBL5f/910X9sYU0n2g47SOFmKrTO/8P+1CDvW3FfU4DcnRZ4EirL07alKE0fpTwr+NslWqzY+iWCxw7sj40wXbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wfzkhGPtE8Do8I2XddEpJrDDG1wkzR7L1B5xMRAGsI=;
 b=StH2kN3C20tqXoEfoiIv261VpOVcjnr1kWnJMJt8b9wPrNEA5M1S3MKcp3KlruQ/rnSC29IG4ecKRBMAQSCSY1S9aQTRLlOR5Bq1hE2D36eHheXi6QFATIrA7wNI7y8+Wurz+EeVgQ+wgeBs18ASorS3jNa72ORhZpOEF3YuMYSHQ9aL7zkIdaTeXRajBMpLZPdMiS6SFJUNhHVXzL/hAu03ixsp9on0UcHo6rB10UFhx6wajXysBJd9+EgBEuFrt1aJ5bQjnJn9sklQlad+CjWySJFybUBpHc24n/ZFWzy10lem53XVdB9gcPaELXTigfaORy7WXzhYHOH5ZtOJ+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by DBBPR04MB7579.eurprd04.prod.outlook.com (2603:10a6:10:1f5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 12:24:06 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 12:24:10 +0000
Date: Tue, 17 Mar 2026 14:36:26 +0200
From: Simona Toaca <simona.toaca@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, 
 simona.toaca@nxp.com, ye.li@nxp.com, viorel.suman@nxp.com, ping.bai@nxp.com, 
 sebastien.szymanski@armadeus.com, ravi@prevas.dk, joao.goncalves@toradex.com,
 ji.luo@nxp.com, tharvey@gateworks.com, qijian.guo@nxp.com
Subject: Re: [PATCH v2 1/5] imx9: Add support for saving DDR training data to
 NVM
Message-ID: <zlimv4bpiwiz45sbjesa6d7k76rpaeubqx3dtcbfdvjs5uqzbl@chaau67obpch>
References: <cover.1773648510.git.simona.toaca@nxp.com>
 <5a7a3063ce3a429c67396c1d0bae95444ac3f996.1773648510.git.simona.toaca@nxp.com>
 <04ea62f9-f82a-4c10-9866-0ce78ea90b05@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04ea62f9-f82a-4c10-9866-0ce78ea90b05@nabladev.com>
X-ClientProxiedBy: FR2P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::18) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|DBBPR04MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: a51b37fa-2bf2-413a-9485-08de8420176a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: y1/38IszoUgEeJu2mi7WGYvkBoNDWFi8FMxp5ZWXsq4lH/RknQS5KPGH5Mjsf+/BpXyryb9mh4JP2vx6OOM4gHnIEBH+HPTe0k4fAFpxAyn6BUaAWMy7WCFkp1D0n4WjaIDnjuyOhTNsKlN0pFq9cCET5f6BoStVknbMd/oXZiovMROK82WzZAcDIZJWLUQlUmnNruyUiPN0kT++p5bFSVmTg5r25zcD09NJrMnair8ELu9Ztp08JQcyPcfSQHDsZNFgTRhX43HxNtjfiumAmxI28XKbSzpbVDelxVfR5aAT9wDm0gPhHWJwMw1Y34N2lq921eUG9SFyBorAUnbjf/a+d/cg5PLIAhECeP8z1SUi76A1lv52T4V0Sn44+GdqAI+ZaxltguNImgIJ6jfOkikeRPw9Le1F7FCo2i+CctIaBwKWu7HCIId8Ubim7lvMyml12Cvo6cZx6pcHjFCeJfmnYOmDeWbAsOkeDpMHvmQDO6iK8Aa283I7Uk5SkjNMxLUgIMssVzw5c0OoLALId4LLO+fN/8sjmphb13cCDyVbmAaupQv5WfkvQku5lVPAzdoccqgCzwfWI9bPEMU4UYVdGej0aDALlB0DErotYVX8ZEvtKw/66em3Itgo2vRPlhvPwhjnx+PkZKgQBEvIg3bHk8pLu6ZAG+/gZwB7+SRBvWqD7O2nvD3ciCLYlrFp5uC9j4Ze+/nBsRnJWJ2A8bNSv/D06GwWcgBeTW1PGFA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XlnnwtaBo2fstJcR7vmXAyqoTA1QOI7utmU/TRlJQiRBzqdU2jja05by41b0?=
 =?us-ascii?Q?7BXeKZE6BRuqwu2JBZwHfStCyCZVXLlx1GD0Ydb8uwFKXMGem2mefLbSpCuS?=
 =?us-ascii?Q?9BBNx2S5oZpbhChHG4xupXBIxuXEyA4hrmOsmXClgjMwtEJFkZ401Zgdtuhy?=
 =?us-ascii?Q?lJpn5ZA1Jfft4siOTBEglF2rj3/yAI8FpvAxQxXBicAI4nTJsoM1r1s8lv4c?=
 =?us-ascii?Q?g2L00lRx4fR7Sjwh8+zwgm3TvIbd9TEcoZePt0qgfGjLHqseW2eDByBrtYIA?=
 =?us-ascii?Q?tviBiuTtTh8CQmPqTV97ochds2VHiojX9+SAOr+Q+mOBDfFClpyEn4kVx8mA?=
 =?us-ascii?Q?CUDjFfYI/66cufXUG98rJaHEEa++PRNr1ewOXAOqdvCbtb++rDZaDFhsKNrJ?=
 =?us-ascii?Q?NUcDcJpeqIg1wKHZd9TQE70OhNVB2xBi0V7DnU9/Y+gNofpt4Xtsb+cIxgki?=
 =?us-ascii?Q?1prnstoyS+WPCB4m0uw9xhtPzcpRteoip0MVMBDy7d4VZ6NcMZEu5oolsh+T?=
 =?us-ascii?Q?0+wFoL9rcs3DD+ekv/3rgs+lj463CJPuD+QLPcRdn2XEjvxN+lWyR7CuBw+r?=
 =?us-ascii?Q?813LBm22aqIyyuu5/dIiZQyy9scMKhwWThNyLVmwVQ0Y8dIvas4lzsj/1bog?=
 =?us-ascii?Q?3dTMBvo4VUuAxEpNG1fz9uIPZSCWYI4/j8wU2HdtZsG53SqFu/aLgSQES4Dm?=
 =?us-ascii?Q?wXS1jFA2+8jIaPXGwXZnSwIRe/DVMOd3365jnTU5dyqr+S6EqdHkqo9BB3M6?=
 =?us-ascii?Q?We365UPO4tFq+IfeblX4vuQiLSz9xBEvzyc9qrDFn4aYNgWYGMrlRyQvMCSo?=
 =?us-ascii?Q?OAZmv9xyAZ8efe8g/S9DofNYmQy+jbCSyXaJ/z31Ef9OoJe2V07rtcA7zyDw?=
 =?us-ascii?Q?6nWVxhMQdywQuTqH4XUWhbLH/dpbaJXo1MipQAh5Df+3fsRIYcJORDMaoQB2?=
 =?us-ascii?Q?jUp25lzA+QbWF1/9vlDiQ7K7UJ9s8yhB37Nei1N+rhnYNw3tPdxyJeuZPQDu?=
 =?us-ascii?Q?SvhvqiZ82xdPLmzBX+5IJ1EyIIUJm6frQpjzTre3aQU/watrySmWDqK9FxHE?=
 =?us-ascii?Q?QyByCfj9diEXAcU22Ut6inC9SALJ7Hpf1rv0mvhBELLWdqkak+qJ00Ei2sNO?=
 =?us-ascii?Q?oH8JFVcTE2OLbASyRAOJuCwOoHAupvluNl21OZeCZVxJnW3xg+NYFp0qiFzA?=
 =?us-ascii?Q?u5iod+1iLJ6XkDoGKqvIRw5wsFGkAepT61MlkcjQLlwOA0Mx5OX6QBMf8dzi?=
 =?us-ascii?Q?o6K+bDtGB0FGUAj7yg84+UYYxZ09I1SsOTGnmpANKLwiQ5t9H4+hc6yXfaxV?=
 =?us-ascii?Q?+GCy8OayGSKzYL3Ya341OMBfBWOzY3LQGJQkFIYlVmSw7mAmiXDZ81QK5/lX?=
 =?us-ascii?Q?5DU/fcbd8NZ+VFQvtjGIiCmLxH9VCEXOeNvsLOd0dbBoW3VEdITV82JQ5rUu?=
 =?us-ascii?Q?wb4xfXJEEyIbrHD+53DnvHGL71iNe+OaJATxYCSAuJOCQwUjeRT/p7Ot9aVp?=
 =?us-ascii?Q?6yrh1njUvBSX0C5EaSnpfYahJ2E7yrLNg4qvdfSrI0Cgm2j9nEiLareoI3Qv?=
 =?us-ascii?Q?8cTF+5WbbdPBlgj5gnBpOajk1NiLXklFOQ9XlUmo+g1LjjSvPcxv5kNRdOdl?=
 =?us-ascii?Q?3DFY6N8zcv1t0L9/B3uf4I5tBemduDW47uAYjlCu8eM8SHKvYUZQRyGYstAL?=
 =?us-ascii?Q?aTZhEBFi/vlcfwzHk1cayYEEK8ggynkMFiEQ3k6+5P7PdC+bvWuNZPgFjI/N?=
 =?us-ascii?Q?weU3fIJopg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a51b37fa-2bf2-413a-9485-08de8420176a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 12:24:10.3016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9tmV9AqJpnjcapOZYQiIMdQgAnrgCilRk20Z6ls5tocedmvHRrh6B1RNSwcvNjVay3BdFq46mrbPqrNug/FGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7579
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

Hi Marek,

On Mon, Mar 16, 2026 at 01:13:02PM +0100, Marek Vasut wrote:
> On 3/16/26 9:15 AM, Simona Toaca (OSS) wrote:
> 
> > diff --git a/arch/arm/include/asm/arch-imx9/ddr.h b/arch/arm/include/asm/arch-imx9/ddr.h
> > index a8e3f7354c7..d2afbe59ffb 100644
> > --- a/arch/arm/include/asm/arch-imx9/ddr.h
> > +++ b/arch/arm/include/asm/arch-imx9/ddr.h
> > @@ -1,6 +1,6 @@
> >   /* SPDX-License-Identifier: GPL-2.0+ */
> >   /*
> > - * Copyright 2022 NXP
> > + * Copyright 2022-2025 NXP
> 
> 2026
> 
> >    */
> >   #ifndef __ASM_ARCH_IMX8M_DDR_H
> > @@ -100,6 +100,56 @@ struct dram_timing_info {
> >   extern struct dram_timing_info dram_timing;
> > +#if IS_ENABLED(CONFIG_IMX95) || IS_ENABLED(CONFIG_IMX94) /* CONFIG_IMX95 || CONFIG_IMX94 */
> > +#if IS_ENABLED(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN)
> 
> These are only macros and structure definitions, do they need to be
> conditionally compiled ?
> 

I agree that this might be redundant, especially since IMX_SNPS_DDR_PHY_QB_GEN
depends on IMX94 || IMX95. I would leave the IMX_SNPS_DDR_PHY_QB_GEN
ifdef so that it is clear in which context this structure is used,
if it is also ok with you. If not, I will remove it.

> > +/* Quick Boot related */
> > +#define DDRPHY_QB_CSR_SIZE	5168
> > +#define DDRPHY_QB_ACSM_SIZE	4 * 1024
> 
> (4 * 1024) to avoid side effects
> 
> > +#define DDRPHY_QB_MSB_SIZE	0x200
> > +#define DDRPHY_QB_PSTATES	0
> > +#define DDRPHY_QB_PST_SIZE	DDRPHY_QB_PSTATES * 4 * 1024
> 
> Add ( )

Should I add () to all the numbers so it is consistent, or
just to the macros that contain computations?

[ ... ]

> > +static int do_qb_mmc(int dev, bool save, bool is_bootdev)
> > +{
> > +	struct mmc *mmc;
> > +	int ret = 0, mmc_dev;
> > +	bool has_hw_part;
> > +	u8 orig_part, part;
> > +	u32 offset;
> > +	void *buf;
> > +
> > +	mmc_dev = mmc_get_device_index(dev);
> > +	if (mmc_dev < 0)
> > +		return mmc_dev;
> > +
> > +	ret = mmc_find_device(&mmc, mmc_dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!mmc->has_init)
> > +		ret = mmc_init(mmc);
> 
> mmc_init() already handles the mmc->has_init conditional, drop it.
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	has_hw_part = !IS_SD(mmc) && mmc->part_config != MMCPART_NOAVAILABLE;
> > +
> > +	if (has_hw_part) {
> > +		orig_part = mmc_get_blk_desc(mmc)->hwpart;
> > +		part = EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config);
> > +
> > +		/* Select the partition */
> > +		ret = mmc_switch_part(mmc, part);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	ret = get_qbdata_offset(mmc, MMC_DEV, &offset, is_bootdev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (save) {
> > +		/* QB data is stored in DDR -> can use it as buf */
> > +		buf = (void *)CONFIG_SAVED_QB_STATE_BASE;
> > +		ret = blk_dwrite(mmc_get_blk_desc(mmc),
> > +				 offset / mmc->write_bl_len,
> > +				 QB_STATE_LOAD_SIZE / mmc->write_bl_len,
> > +				 (const void *)buf);
> > +	} else {
> > +		/* erase */
> > +		ret = blk_derase(mmc_get_blk_desc(mmc),
> > +				 offset / mmc->write_bl_len,
> > +				 QB_STATE_LOAD_SIZE / mmc->write_bl_len);
> > +	}
> > +
> > +	ret = (ret > 0) ? 0 : -1;
> 
> Use CMD_RET_SUCCESS and co.
> 

I am using these enum values in cmd_qb. However, here I would have
do this 'if' at every return statement, since the other methods
return 0 or an errno code. Should I still change this?

> > +	/* Return to original partition */
> > +	if (has_hw_part)
> > +		ret |= mmc_switch_part(mmc, orig_part);

[ ... ]

> > diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
> > index 17269ddd2fc..eb9bfe19a69 100644
> > --- a/arch/arm/mach-imx/imx9/scmi/soc.c
> > +++ b/arch/arm/mach-imx/imx9/scmi/soc.c
> > @@ -281,6 +281,15 @@ static struct mm_region imx9_mem_map[] = {
> >   			 PTE_BLOCK_NON_SHARE |
> >   			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> >   	}, {
> > +#if IS_ENABLED(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN)
> > +		/* QB data */
> 
> Is the ifdeffery necessary ?
> 
> Where are the QB data located in this case, DRAM or SRAM ?
> 

It is necessary because CONFIG_SAVED_QB_STATE_BASE is only
defined when CONFIG_IMX_SNPS_DDR_PHY_QB_GEN is enabled. So it
throws a compilation error without this. And this is DRAM.

> > +		.virt = CONFIG_SAVED_QB_STATE_BASE,
> > +		.phys = CONFIG_SAVED_QB_STATE_BASE,
> > +		.size = 0x200000UL,	/* 2M */
> > +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> > +			 PTE_BLOCK_OUTER_SHARE
> > +	}, {
> > +#endif /* CONFIG_IMX_SNPS_DDR_PHY_QB_GEN */
> >   		/* empty entry to split table entry 5 if needed when TEEs are used */
> >   		0,
> >   	}, {
> > diff --git a/drivers/ddr/imx/imx9/Kconfig b/drivers/ddr/imx/imx9/Kconfig
> > index 0a45340ffb6..7c244ddb5dd 100644
> > --- a/drivers/ddr/imx/imx9/Kconfig
> > +++ b/drivers/ddr/imx/imx9/Kconfig
> > @@ -29,4 +29,12 @@ config SAVED_DRAM_TIMING_BASE
> >   	  info into memory for low power use.
> >   	default 0x2051C000
> 
> Please fix ^ that one in separate patch, default goes after depends.
> 

Yes, will do.

> > +config SAVED_QB_STATE_BASE
> 
> IMX_SNPS_DDR_PHY_QB_SAVED_STATE_ADDRESS ... to make the prefix of this
> Kconfig symbol aligned with IMX_SNPS_DDR_PHY_QB_GEN below .
> 
> > +	hex "Define the base address for saved QuickBoot state"
> > +	depends on IMX_SNPS_DDR_PHY_QB_GEN
> 
> "default" goes here.
> 
> > +	help
> > +	  Once DRAM is trained, need to save the dram related timing
> > +	  info into memory in order to be reachable from U-Boot.
> > +	default 0x8fe00000
> > +
> >   endmenu
> > diff --git a/drivers/ddr/imx/phy/Kconfig b/drivers/ddr/imx/phy/Kconfig
> > index d3e589b23c4..e8d0c005689 100644
> > --- a/drivers/ddr/imx/phy/Kconfig
> > +++ b/drivers/ddr/imx/phy/Kconfig
> > @@ -2,3 +2,10 @@ config IMX_SNPS_DDR_PHY
> >   	bool "i.MX Snopsys DDR PHY"
> >   	help
> >   	  Select the DDR PHY driver support on i.MX8M and i.MX9 SOC.
> > +
> > +config IMX_SNPS_DDR_PHY_QB_GEN
> > +	bool "i.MX Synopsys DDR PHY training data saving for QuickBoot mode"
> > +	depends on IMX94 || IMX95
> > +	help
> > +	  Select the DDR PHY training data saving for
> > +	  QuickBoot support on i.MX9 SOC.

Thank you. Will fix these issues in the next version.

Simona

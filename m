Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91394ECD9B7
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 01:23:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBBE9831AC;
	Fri,  6 Feb 2026 02:23:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wbqrHI9M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7E00836D3; Fri,  6 Feb 2026 02:23:10 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B64983015
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 02:23:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFVGlnGCYOecVLXGHOhJLZ2Xn2iMvFhzryfoo1TCSUmXNqSwHm2hwDzOF9YqIIUs0R/cQ9mKvzAxy1tSF0sFVPM487Xaim8Zx1xcC5gBQsN8NDHhGDuwl/WX4F+NBFMgYNwDqJYuXEXILrf4RWbULCefuzNreghbn6ioaQbjqbKjTl6iNR8lXtBox/WABHA0sUvaRS9u4g/o0VGi4FYNqO/PMIksWcu+8oZx0+7fjgD2bcQYCGfbZs1uaVKub53n2o2VsHKc5dd7nzlMKN4TRNLK02p7DfNr78p7fnQIAh3wIDLjnjVXyn76N6CddN6tp0t6CPG09QkhFcfLKA5J8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5IWUer/JWgLBIsV9QywcZOifD/zR8+A+rmff9UidgQ=;
 b=Sahrsd8g2XEfX2TnFVFovr+9jQmAojPVmrEv3rP53IuJkRzFThD42HhUVJ6AzMwbx1YX6yWgZqVj6nLl4w+PkCTiScuIWcg6sUl9Si6MuOXTny9Q7FQprwXobvlVKBwOZ2uiRhsAlKsCRFvI6/L3BLyxYjTCBHTGE/MGq+gjzhP3QuYPjpchihcy2grJcU7LPEW890d8jLNNCHGfoAE6XT6UKWSaGh9Zw0H3+WGyiI6SaprzGUXyet+B4ZLyDP2S1PI8/yfqmweilfjyIp4cjWKHO3IvwUXW+qCoc0+LKR+FHPZVrcrnAMbtIsiQpAwj1+6wVDAO9ikmlsmgyo4m+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5IWUer/JWgLBIsV9QywcZOifD/zR8+A+rmff9UidgQ=;
 b=wbqrHI9M4yn65Xj3TOkxk3CsWE+d8ntpj4WRJ5LMEpE/5fVKYh8frLzkwdgPvcqsf1UIBcwliDdBN6zWJ8eK97w9UZLYdpIJZBU2WLEExVEZdp8HBWFFpSmudEM/kCrTphGAjJ+i1dbMjhR6uY/OH8yUwV1ja18PW23o9Iq+8mNGRiTdAzWXo6b4gn+WXbGh8hapyV+TPDYKFMo1dKKc1DG1dS06Uwdqncw8ootykSyY1nUEyFTDkUcVrQ3EN3BZTMdyEWV4LnKQyDinOGOjA9d3Mhiq7wM0Ge497WijIP2cUq9mPcOs/1tgR4LtgknUrFlDCF6Uq7LERukTQ1GTgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7475.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 01:22:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 01:22:59 +0000
Date: Fri, 6 Feb 2026 09:24:35 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Jindong Yue <jindong.yue@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Fedor Ross <fedor.ross@ifm.com>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>,
 Ji Luo <ji.luo@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 David Zang <davidzangcs@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1 12/12] board: nxp: imx952_evk: Add i.MX952 15x15
 lpddr4x board support
Message-ID: <aYVC07WtB/p6zQWI@shlinux89>
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
 <20260205-imx952-v1-12-2103d0222a0b@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205-imx952-v1-12-2103d0222a0b@nxp.com>
X-ClientProxiedBy: MA0P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: ef94961a-b1ef-447c-dfea-08de651e43a1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6/zga5PjoGoICJ+tgZGGqZkCWEESkNjSIxrJJ21jqhw+J+j6WHQ3T0/q4E0C?=
 =?us-ascii?Q?nXc1Agd9gECA2AByWD60YzMjLNlOUiq3CHVp8NPfN6M8YgFm+JvYqFboNhpn?=
 =?us-ascii?Q?pqGJ+bJ0lGSAfs2Wj21TXPsSkaUssOA2YmUOuRW2rz3xeb9VIDhyGMHQ0xZl?=
 =?us-ascii?Q?lWmPyk2Nhb5fTkTBRExnZ8DRhjdwtPAH2cdHc8H3vEAv3CQqGBqBpFywzjQj?=
 =?us-ascii?Q?Zb4WvQ1k22DKldsttvuNyhTvh/glu9KvFl8nBQnq32T+d0sRvac/A3pxJAU1?=
 =?us-ascii?Q?CO1OvF8LsqRw83Eqks0q3L5RQ4A1dg1ycQrXwpT/WBlerHInjeHj/UewaKxb?=
 =?us-ascii?Q?Qn8znUdBmAQi3gmftvJuFxj/Domh4jEh0P4V2bFLt1KF9VIkVGXJKAAl0Pmd?=
 =?us-ascii?Q?zCKsil+/oAAplvytKzMx3MPlZ0rVTAVahWm1qAwUDw9AXg2dCpBeNx1HY+De?=
 =?us-ascii?Q?X83Psmbdk9oOmITgRNQHDihwV420EWQ1bJQEmKyPlNJLmQmRd6IcKHEnuzby?=
 =?us-ascii?Q?mKT6JtqX4z+BXrwxMN3SNM8yVu+Gk9ZlET2DUzeQuNZWkSUP/Tj5r2B0bORI?=
 =?us-ascii?Q?LREFbp6td0/mF4pLtDkj+mdJJ2Tpsmh4wjjlwM7nro/nctIfa6TEzF74O6c8?=
 =?us-ascii?Q?n28bvutxnj25FD1OppM3v5v3ggC5LVcckpzDQLP5ZTBL57azp1GWEWwexqtM?=
 =?us-ascii?Q?HNXGrayDjupi90ULDJzVaDOJI2VYLGUEvgjbaDWBPq/HHsrnPUCkD9hAQRDX?=
 =?us-ascii?Q?rzSp8hgRI9bIczupMVLiGyZGZc2oRUOsxqQfwZ4RzqV6BKZXkAO/O5PveGUS?=
 =?us-ascii?Q?MW9uvm68UozLCyRuM6YiJmG5hWpK3dxRjLIBPHBB07Ds/0g8qZ741tNwubpn?=
 =?us-ascii?Q?xat3RxraKRGaZhsqkgxeRjHmOiHphJlDtEyGZ6Kpa1bWM0IB8YiUvS3Z9uuv?=
 =?us-ascii?Q?NFkED3HOOa0PfNTA/npoQ9VgZqCfjCciGO/PEinIbnR+JP7wvO50SPMX2XSF?=
 =?us-ascii?Q?dUbbwKzpQ05fRPJjQ1Uzgd5aqFLs0QDsnuXbUTqFMhtQN9VGZyIs3dw8KGR/?=
 =?us-ascii?Q?UalxsMeKL6gaN80tKXoEF5nVqNoy2ZnLZG+GNsaasu/+hqVIY5p9hcN0fm4G?=
 =?us-ascii?Q?hKrF6b4s21hEemxCXTKaxkF2yfMi1xyAG0asQzF3YhRRj9HMUrU6+QiBpVyK?=
 =?us-ascii?Q?p2slwfHjtau8mYw+sIp9YyHeM5Z2vi8ayY+NYamCBGZwkOp7BiGU2P1Xyqed?=
 =?us-ascii?Q?C8MLe0UJjRkxYsAtQK2tfdNH8y6GfZM3GNpPlkcJe4c3fTYZQ8cGv4USzl4Y?=
 =?us-ascii?Q?q9KXrvheO0n9asp1LPNeZ4gPE01Bl2LwlPhEhNVuPPFRnUfNZiVCggfXt8QP?=
 =?us-ascii?Q?HS11Uu9x9cKi29zERTmmwvLvjmcG7f+Dd1tGTkw8tA7gkYLX/flcz/apCQro?=
 =?us-ascii?Q?3Z7anIbeMNrCy2sqww5Xl8yJlJ/oqhXuMVbV91UMRI8Drh8FCOKY7J5CzwRr?=
 =?us-ascii?Q?EsYIAS9S52YFjOcTxNyfuRrYNkvbAdLVbIemdpmsNxPWN99s+6BB+J7hpAKN?=
 =?us-ascii?Q?qNf7MBFku6EswNYS9EYJSipq7M85gfPCiYB6LfSaVne328UGVOamMhQFbmnK?=
 =?us-ascii?Q?T8EfZu6hfh4Tddc18hCAYrI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oUw7GDr6jmDOSqeJ180/2hVCTYCzme1D6ATz9zcMNx+FSGidu53vUV/uh4zp?=
 =?us-ascii?Q?rpWswPmMIV7w5ooJGgn2rhXkYAjhO2tHgwQO8fScQq8HQYEbCr2lA3UU9cSb?=
 =?us-ascii?Q?Bqe7Zhma7LXozhrBaKyvOwfc+HJGMMkmndoLN+tt+suMOH3JfTakThcSAqTf?=
 =?us-ascii?Q?7r+LodOFIIXszTDkSg/Zb4R32TmJgvBsWE7TfbaIK/KAhkEyAhYg7nYNleP2?=
 =?us-ascii?Q?VVDCACWlyHdbQ9Xtznl7/4dSij/wqB1C+oi/onK5qHxlw77FB90LGseYNkxP?=
 =?us-ascii?Q?aR9KOiJzlRqh+pzqoaQqtZjZ3CSJ8FCObah10reMCxi0Z7ttM8ScSVodawQi?=
 =?us-ascii?Q?1keUOEHfG5mmcf0leYFB1v2x/1HfCOaD6hDAQd+NSQ5n1vvAIkeyhURObeIo?=
 =?us-ascii?Q?UwT8Fo8pOsSvvUUlGlFVxwUkCho5gccNfirIFBhTVrm/LjYB1gqJ0Vt7CISr?=
 =?us-ascii?Q?eYqFRLMCSnPaGL2rYb/HUo6+pHDTgEI3RdoV2vaEFukX3R6w7VI3XAIonVax?=
 =?us-ascii?Q?iTwgrvXsUkdL/pZBjHZqtF7dT2WwDV/S4dCbHCggVtZSuYPYqlyjxkFzzg5X?=
 =?us-ascii?Q?axu6f477q7y7Cjtz9k7INGsW7FXOAonftqqcqGb+7/2uxSzOWvXkzTvuOGdL?=
 =?us-ascii?Q?hjtTHPg1txoLphWw3ePkFKZQ6NymX/Xi5S2UasP7BM8wURJGRkBZ1Sd3Pb82?=
 =?us-ascii?Q?GdKt4RkzjZ6usXwEku9xoXrRMMJ4UgQ1FgP91Njv9iXnSauG/vvufBf8shC2?=
 =?us-ascii?Q?Nws8rRs9lH3Yg1cA7TyQkPcET0Khq1mpkpoZVD8JklU6HuviHRRUeNyMWoKH?=
 =?us-ascii?Q?pQ9heMLL9zfZGGT2DI7o2VUiPZ8V+vqYjUIYHW1PoAvBaZZLLUSrKerIVlky?=
 =?us-ascii?Q?TrgSXM22JSV2Kg8RNzixe2vJh+KxIDuD0e/Wc6e0J+LKMAzmWUImuxhNXM5i?=
 =?us-ascii?Q?YbZvEweIgl5icP6huSXbcraOax2fXJk+Nf0CJ9RllR03AMC757zNAKYfD+et?=
 =?us-ascii?Q?cT1YdN3+KKA5h/ixl/UJL0gykLMhiNQx0H5VB6HaXS5fpi5WOyvEMCtczset?=
 =?us-ascii?Q?jMb35vgaY2hCUtEffUhIYQZ1Povs90j6LxmZXlrdKkDXMl4alXM0JcTi/OYI?=
 =?us-ascii?Q?nstFcv2BHVb+IC9eOuotUTYooCDufEhwho9NiNswSdOfFWrHIZ4Q6vj7KIns?=
 =?us-ascii?Q?NULEBcLbDPD3RlblA5D7+luZQsoZZzh7d7sbqipEovyFOGbvggNeZdHLIDif?=
 =?us-ascii?Q?DC/YHUfxprwA4BQ8ataDb1xsDZNm+b6fKO2WtLkp1jotJ7fM+PQG16gMttQq?=
 =?us-ascii?Q?Nt222D9kTrVWe8SJouXdxSiAKTl+cGhq5s6AAX66GTHuZrQuws5TOjZpflmy?=
 =?us-ascii?Q?IfvbrXhXXNSsBa0xJqQm9xIseU/hFk9+TIKcu9+2iuVcYoDwOfJZH3BFw90n?=
 =?us-ascii?Q?u4aw812SEsVoQiLBFO230mwaTkEF5/BAXiUO7YInUFiiL+d/B297gYSlq+yQ?=
 =?us-ascii?Q?5l5cHjrmSK1uPs1ttSHotq7uYdKw51HBswL+9jRCTMqXXcRp3ReEXvTH5wOy?=
 =?us-ascii?Q?PDaBhMaqX5WW0LkdzuDIYqii1aiNqLP+dRQFKQ0WegCCW/dvnUTlVsIcQCeu?=
 =?us-ascii?Q?5W7lCpNg8FBt0viWS45lUU+mTSu9+gRzi0SRz/Ddh2LPLNQ4DuVfU/5lQ0W6?=
 =?us-ascii?Q?PuHmtvtuTRs3qrDKDvAWe3yYkxasgfNlZuLetRSxSJ7X6jU2PO2oFtX+/yQN?=
 =?us-ascii?Q?MIKj/3A7dw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef94961a-b1ef-447c-dfea-08de651e43a1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 01:22:59.4741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVCoGgwLiLzzaKRhRXkk4DBf1+oUdUPagrqGQvH+DKCNZo4MCwfAmXx1QTrGTACQOnFeRPAO16tC1DoqhSh7Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7475
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

On Thu, Feb 05, 2026 at 09:55:18PM +0800, alice.guo@oss.nxp.com wrote:
>From: Peng Fan <peng.fan@nxp.com>
>
>Add support for i.MX952 15x15 lpddr4x board support.
>
>Signed-off-by: Peng Fan <peng.fan@nxp.com>
>Signed-off-by: Ye Li <ye.li@nxp.com>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>
>---
> arch/arm/mach-imx/Makefile          |   2 +-
> arch/arm/mach-imx/imx9/Kconfig      |  14 ++
> board/nxp/imx952_evk/Kconfig        |  12 ++
> board/nxp/imx952_evk/MAINTAINERS    |   6 +
> board/nxp/imx952_evk/Makefile       |  14 ++
> board/nxp/imx952_evk/imx952_evk.c   | 297 ++++++++++++++++++++++++++++++++++++
> board/nxp/imx952_evk/imx952_evk.env | 137 +++++++++++++++++
> board/nxp/imx952_evk/spl.c          | 115 ++++++++++++++
> configs/imx952_evk_defconfig        | 178 +++++++++++++++++++++
> doc/board/nxp/imx952_evk.rst        | 112 ++++++++++++++
> doc/board/nxp/index.rst             |   1 +
> include/configs/imx952_evk.h        |  31 ++++
> 12 files changed, 918 insertions(+), 1 deletion(-)
>
>diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
>index 0f6e737c0b9..bf6820de655 100644
>--- a/arch/arm/mach-imx/Makefile
>+++ b/arch/arm/mach-imx/Makefile
>@@ -223,7 +223,7 @@ endif
> 
> ifeq ($(CONFIG_ARCH_IMX9)$(CONFIG_ARCH_IMX8ULP), y)
> 
>-ifneq ($(and $(CONFIG_BINMAN),$(or $(CONFIG_IMX95),$(CONFIG_IMX94))),)
>+ifneq ($(and $(CONFIG_BINMAN),$(or $(CONFIG_IMX95),$(CONFIG_IMX94),$(CONFIG_IMX952))),)
> SPL: spl/u-boot-spl.bin FORCE
> 	$(call if_changed,mkimage)
> 
>diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
>index 716940930a6..2ba088c49c5 100644
>--- a/arch/arm/mach-imx/imx9/Kconfig
>+++ b/arch/arm/mach-imx/imx9/Kconfig
>@@ -162,6 +162,19 @@ config TARGET_TORADEX_SMARC_IMX95
> 	bool "Support Toradex SMARC iMX95"
> 	select IMX95
> 
>+config TARGET_IMX952_EVK
>+	bool "imx952_evk"
>+	select CMD_REMOTEPROC
>+	select IMX_SM_CPU
>+	select IMX_SM_LMM
>+	select IMX952
>+	select REMOTEPROC_IMX
>+	select REGMAP
>+	select SYSCON

Move the remoteproc related to defconfig.

>+	imply BOOTSTD_BOOTCOMMAND
>+	imply BOOTSTD_FULL
>+	imply OF_UPSTREAM
>+
> endchoice
> 
> source "board/nxp/imx91_evk/Kconfig"
>@@ -175,5 +188,6 @@ source "board/variscite/imx93_var_som/Kconfig"
> source "board/nxp/imx94_evk/Kconfig"
> source "board/nxp/imx95_evk/Kconfig"
> source "board/toradex/smarc-imx95/Kconfig"
>+source "board/nxp/imx952_evk/Kconfig"
> 
> endif
>diff --git a/board/nxp/imx952_evk/Kconfig b/board/nxp/imx952_evk/Kconfig
>new file mode 100644
>index 00000000000..96f01323aca
>--- /dev/null
>+++ b/board/nxp/imx952_evk/Kconfig
>@@ -0,0 +1,12 @@
>+if TARGET_IMX952_EVK
>+
>+config SYS_BOARD
>+	default "imx952_evk"
>+
>+config SYS_VENDOR
>+	default "nxp"
>+
>+config SYS_CONFIG_NAME
>+	default "imx952_evk"
>+
>+endif
>diff --git a/board/nxp/imx952_evk/MAINTAINERS b/board/nxp/imx952_evk/MAINTAINERS
>new file mode 100644
>index 00000000000..cc004f9467e
>--- /dev/null
>+++ b/board/nxp/imx952_evk/MAINTAINERS
>@@ -0,0 +1,6 @@
>+i.MX952 EVK BOARD
>+M:	Alice Guo <alice.guo@nxp.com>
>+S:	Maintained
>+F:	board/nxp/imx952_evk/
>+F:	include/configs/imx952_evk.h
>+F:	configs/imx952_evk_defconfig
>diff --git a/board/nxp/imx952_evk/Makefile b/board/nxp/imx952_evk/Makefile
>new file mode 100644
>index 00000000000..1581721dc78
>--- /dev/null
>+++ b/board/nxp/imx952_evk/Makefile
>@@ -0,0 +1,14 @@
>+#
>+# Copyright 2025-2026 NXP
>+#
>+# SPDX-License-Identifier:      GPL-2.0+
>+#
>+
>+# Add include path for NXP device tree header files from Linux.
>+ccflags-y += -I$(srctree)/dts/upstream/src/arm64/freescale/
>+
>+obj-y += imx952_evk.o
>+
>+ifdef CONFIG_SPL_BUILD
>+obj-y += spl.o
>+endif
>diff --git a/board/nxp/imx952_evk/imx952_evk.c b/board/nxp/imx952_evk/imx952_evk.c
>new file mode 100644
>index 00000000000..8b4b2083a20
>--- /dev/null
>+++ b/board/nxp/imx952_evk/imx952_evk.c
>@@ -0,0 +1,297 @@
>+// SPDX-License-Identifier: GPL-2.0+
>+/*
>+ * Copyright 2025-2026 NXP
>+ */
>+
>+#include <asm/arch/clock.h>
>+#include <asm/arch/sys_proto.h>
>+#include <asm/gpio.h>
>+#include <dm/uclass.h>
>+#include <dm/uclass-internal.h>
>+#include <env.h>
>+#include <fdt_support.h>
>+#include <imx952-power.h>
>+#include <init.h>
>+#include <linux/delay.h>
>+#include <power/regulator.h>
>+#include <scmi_agent.h>
>+#include <usb.h>

sort the headers.

Generic headers
asm/headers
asm/arch/headers
asm/mach/headers

>+
>+#define PD_HSIO_TOP IMX952_PD_HSIO_TOP
>+#define PD_NETC IMX952_PD_NETC
>+#define PD_DISPLAY IMX952_PD_DISPLAY
>+#define PD_CAMERA IMX952_PD_CAMERA

Use tab to align the macros.

>+
>+#if CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT)
>+#define IMX_BOOT_IMAGE_GUID \
>+	EFI_GUID(0x58a661f3, 0xe7c7, 0x4173, 0x80, 0x21, \
>+		0xa3, 0x1b, 0x95, 0xc8, 0x6e, 0x9b)
>+
>+struct efi_fw_image fw_images[] = {
>+	{
>+		.image_type_id = IMX_BOOT_IMAGE_GUID,
>+		.fw_name = u"IMX952-EVK-RAW",
>+		.image_index = 1,
>+	},
>+};
>+
>+struct efi_capsule_update_info update_info = {
>+	.dfu_string = "mmc 0=flash-bin raw 0 0x2000 mmcpart 1",
>+	.num_images = ARRAY_SIZE(fw_images),
>+	.images = fw_images,
>+};
>+#endif /* EFI_HAVE_CAPSULE_SUPPORT */
>+
>+int board_early_init_f(void)
>+{
>+	/* UART1: A55, UART2: M33, UART3: M7 */
>+	init_uart_clk(0);

Drop this. no need.

>+
>+	return 0;
>+}
>+
>+#ifdef CONFIG_USB_TCPC
>+struct tcpc_port port;
>+struct tcpc_port_config port_config = {
>+	.i2c_bus = 6, /* i2c7 */
>+	.addr = 0x50,
>+	.port_type = TYPEC_PORT_DRP,
>+	.disable_pd = true,
>+};
>+
>+static int setup_typec(void)
>+{
>+	int ret;
>+
>+	debug("tcpc_init port 1\n");
>+	ret = tcpc_init(&port, port_config, NULL);
>+	if (ret) {
>+		printf("%s: tcpc port init failed, err=%d\n",
>+		       __func__, ret);
>+	}
>+
>+	return ret;
>+}
>+#endif

Drop the tcpc part. this is not supported in upstream.

>+
>+static int imx9_scmi_power_domain_enable(u32 domain, bool enable)
>+{
>+	struct udevice *dev;
>+	int ret;
>+
>+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
>+	if (ret)
>+		return ret;
>+
>+	return scmi_pwd_state_set(dev, 0, domain, enable ? 0 : BIT(30));
>+}
>+
>+int board_usb_init(int index, enum usb_init_type init)
>+{
>+	int ret = 0;
>+
>+	if (index == 0 && init == USB_INIT_DEVICE) {
>+		ret = imx9_scmi_power_domain_enable(PD_HSIO_TOP, true);
>+		if (ret) {
>+			printf("SCMI_POWWER_STATE_SET Failed for USB\n");
>+			return ret;
>+		}
>+	} else if (index == 0 && init == USB_INIT_HOST) {
>+		return ret;
>+	}
>+
>+	return 0;
>+}
>+
>+int board_usb_cleanup(int index, enum usb_init_type init)
>+{
>+	int ret = 0;
>+
>+	if (index == 0 && init == USB_INIT_HOST) {
>+#ifdef CONFIG_USB_TCPC
>+		ret = tcpc_disable_src_vbus(&port);
>+#endif
>+	}
>+
>+	return ret;
>+}

Drop the tcpc part. one more question, does the usb host and gadget both
work?

>+
>+static void netc_phy_rst(const char *gpio_name, const char *label)
>+{
>+	int ret;
>+	struct gpio_desc desc;
>+
>+	/* ENET_RST_B */
>+	ret = dm_gpio_lookup_name(gpio_name, &desc);
>+	if (ret) {
>+		printf("%s lookup %s failed ret = %d\n", __func__, gpio_name, ret);
>+		return;
>+	}
>+
>+	ret = dm_gpio_request(&desc, label);
>+	if (ret) {
>+		printf("%s request %s failed ret = %d\n", __func__, label, ret);
>+		return;
>+	}
>+
>+	/* assert the ENET_RST_B */
>+	dm_gpio_set_dir_flags(&desc, GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE | GPIOD_ACTIVE_LOW);
>+	udelay(10000);
>+	dm_gpio_set_value(&desc, 0); /* deassert the ENET_RST_B */
>+	udelay(80000);
>+}
>+
>+void netc_init(void)
>+{
>+	int ret;
>+
>+	ret = imx9_scmi_power_domain_enable(PD_NETC, false);

error check is not added.

>+	udelay(10000);
>+
>+	/* Power up the NETC MIX. */
>+	ret = imx9_scmi_power_domain_enable(PD_NETC, true);

An comment is required on why power down , then power up again.

>+	if (ret) {
>+		printf("SCMI_POWWER_STATE_SET Failed for NETC MIX\n");
>+		return;
>+	}
>+
>+	netc_phy_rst("i2c6_io@21_13", "ENET1_RST_B");

This is not good to put here. Could phy rst be done in drivers?

>+
>+	pci_init();
>+}
>+
>+static void pcie_setup(void)
>+{
>+	int ret;
>+	struct udevice *dev;
>+
>+	ret = regulator_get_by_devname("regulator-m2-pwr", &dev);
>+	if (ret) {
>+		printf("Get regulator-m2-pwr regulator failed %d\n", ret);
>+		return;
>+	}
>+
>+	ret = regulator_set_enable_if_allowed(dev, true);
>+	if (ret) {
>+		printf("Enable regulator-m2-pwr regulator %d\n", ret);
>+		return;
>+	}
>+}
>+
>+void lvds_backlight_on(void)
>+{
>+	/* None */
>+}

Drop.

Two much code added from downstream. Please cleanup this patch
to make it as i.MX95/4 EVK board code.

Then add more features step by step.

Regards
Peng

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75060CCFA06
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 13:22:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E6F983942;
	Mon,  3 Nov 2025 14:21:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eJRbeviA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F26F83700; Mon,  3 Nov 2025 08:21:05 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FF9D83642
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 08:21:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLAfcScdH/6UUExTcdjoBFjIcFwr38Y0Mn0xs15dTC56IO5ZioC1H8TD8SUO77rWOw86GqeOFKDXav3K4tfqZA4n2eFLG5vZvKg8RIFkN48pVjlrE7Rd1WDPSVOCZWnxpXquDzOHaBG0ZthaYNwj1u6HENuSawOIm1+RiQpN62PkagCjL4/TJ7gbP1RGK0DteJiHVwwtGh0nh1lkM4WKnjnaiB1blhgnjvKM2So/GmEcYlbIyG5oZOSzOquZOgjQn3+pO8LnAmvz2A9/Oe9QJp4eFWP0lYpv+/7ddZGCPKbSkly8cO0s6S/3LVv11Rp7kDqYgDkfmwUIILVQ3hiEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9V/8kHcA7liA+C3PIIu1NnsGrUnMXuuh5wPVrc/FnGI=;
 b=xRGB6CfXo0bB71SVyoFG54AMEOe9pt67IUlZILh/RzLdpQxgBuBSGxYF92lkMqceOmmQG3HAEm+xM5LUazCvI83x4Z0D8CnWGG8QQsAMCQkOCy+0TAjDRruKerom6G6xtI161f8HtrVxcf//8ZlM4AV5XFzLzGRa7sJgFPliT+tKdItjC3OxSxwpSeWut1lnzvupmHhWCKyn7yNK5Gri8g13hGwPTF7Cya3kiTQtZzrXuQXYj5dwRegyZrRx6BI2eKlLb4TORnSDg+RLM+ctebJ7hdmn5edwdaYZMCeg8ozIwyxnMjsCCzZtRl1gd58k5oAr6YCGcseo6lF4R2I6AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9V/8kHcA7liA+C3PIIu1NnsGrUnMXuuh5wPVrc/FnGI=;
 b=eJRbeviAj/+lMsBYhBUfXypcL8hOVU3CCEynvsTxJgkguL0DnfxSkK/PyuNb4uIlJu/tXqM466cYTEI1NhW+eozs9D2QuhCb1eeAPUT9hyhjoHhBV90XsOMLQ/aRliaKyAhPIToW0M3pnb92xe1xd0v2f6XPHrzlVWUJrDYVlgQIGpLu5Zt/s15zUTOiGD1sU5Gqd1xkhOWRReUtM2rs8JOPJUui8zGBtfPZC09TznxsV6VTkJVoNii0/Y2Nd5z0vGF8bP4MFKSeoYFqOCjWdRdPbArRxOxEswQZyYY91iw6/QliTWM4vJeRz7Q1oOiPXPtpLia4W1pnFPWHfBOaKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7331.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 07:21:01 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 07:21:01 +0000
Date: Mon, 3 Nov 2025 16:33:29 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Alice Guo <alice.guo@nxp.com>, Cristian Marussi <cristian.marussi@arm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Valentin Caron <valentin.caron@foss.st.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v2] firmware: scmi: Add clock v3.2 CONFIG_SET support
Message-ID: <20251103083329.GA1698@nxa18884-linux.ap.freescale.net>
References: <20251027135856.8909-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027135856.8909-1-marek.vasut+renesas@mailbox.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 319b5fd5-90d6-415a-3420-08de1aa98aa0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KKTKOL9Yjxwx8P9e4QNeS1ncD3JCJab7iYex4tfSqH/vxTk6/4K0dfuKK0A0?=
 =?us-ascii?Q?M+IIksMJ71yPpmgROVsUIuqLZeV03uejmhUbursTSSMo85CCCVdpeWogOuLL?=
 =?us-ascii?Q?5PJLGZhsZyNxK84kMSTkCDhPQ0LK+oEJbrfodtVsgtzttKhQJiCZdhigV/wk?=
 =?us-ascii?Q?B8f83lwR6k2Wdt/hDATg1HHCPoESw6QuAEQV9hHY50+HejSoYOks6pcv3pww?=
 =?us-ascii?Q?zssjtoTDvk7yQBNnbC0dTHAUlkuzORMMCWDGmvmJ6jvA7f4wSvBIKyNZvHCD?=
 =?us-ascii?Q?IgF2/AGCrIpuojODzmNId7/Z/uyJsimzx9ie4ByG2V/JMn5cBHCJA793JizW?=
 =?us-ascii?Q?ld8QIYvL582R8GoXYKqYX8nW//fnHBXHhacBmHtL89AKrmNrw5wtrEnmMGto?=
 =?us-ascii?Q?txpThYS2jDEW0WQvvqOCJ4d5n9hntIZY0PrVIeM3jYNr732u/1zuoihaYiF/?=
 =?us-ascii?Q?d67EDFawJ1DROc3a29eo28jNKhzkg1Uj9t/XXU5/fdTXgsHHy+CGynFE3bW0?=
 =?us-ascii?Q?OKAXYrO+kgb3T4C6E1XeHluEznqTc5epRPgOxGXi4tsni6xjw8Skbo1pHrXB?=
 =?us-ascii?Q?vpQMgMrbRuHcJ1Rh9ZQD173BlHIdGUaDlyLBHp+VQhPDpkbt53k8VIma/SwZ?=
 =?us-ascii?Q?ujEtSM8iRItgNKZ9gdWv7Sy0pt2WB4JHZuXoeRynrTMDyttASEVzg6rLiiwh?=
 =?us-ascii?Q?+Gin/HnX78VQmLimYYTIGuzUi7ziWdSC40JZDKzDV8qed09w/B0dgZYUHZQs?=
 =?us-ascii?Q?IQ6YzMWmEaoU7n8SbPeTWg2Z149IjYc3X+whuM3vZItBwR/L4+UlTOMh9H1J?=
 =?us-ascii?Q?8baxKHUtpch9DTwea8unLmXVuZ+os5j+fBHKRVNhJTWUxZr4uqQKUrsK6uc3?=
 =?us-ascii?Q?7nbw+a7V3ZO5JX1xZDmNbH2SYe9DaGMZpFEqHy8L/7j4AF/in4esgRPDHys2?=
 =?us-ascii?Q?oe2/WTqKPzm6iO50caQEn7qWdtVlb5nGWDv8bbsWdiPozxrvTgeb+MtEJEvL?=
 =?us-ascii?Q?DB+vL1ii0Mw7UT0ivdJ5Ppq/AkK5+oD5sdYEOiYbeEpMdngl4VeMxeCmFYn8?=
 =?us-ascii?Q?RvExKkOwUDszms+tO2XIcBz4v9zjLRdmXqpcqkaCmURw53J2NjM7xyyxVgKf?=
 =?us-ascii?Q?jix/8iRP5rqNYNZ/UiIXL+nNOS1M8FwMgx3IQU2bs5II9Zz027062s7o/Lcf?=
 =?us-ascii?Q?7CfxSrtPALnoXX00NPaEzw/++OciP+bgqALDWLS8jNfUawZiJWR4351G0LN3?=
 =?us-ascii?Q?JJpoShM9iK1cFrj+C9jCEvQEkAiLpoCXYIF6oYBl1Gzx9G7Tg893sRlX45Ql?=
 =?us-ascii?Q?RAeyWqKEt0n7c+99zdW69AzVsP8Y4GmZAYU24LMsl6AxhSxnEGoARhLRyCUr?=
 =?us-ascii?Q?ujQ0LkyeYwz8IiP44fJwOXxTiKRHFse98V6sttGuN0MCILxuliKSgpxefcbY?=
 =?us-ascii?Q?MRpKjsuPbvYDbdJbeCbqqveRHw+exNlf0gCOM4xy70icgSFlcdaS1wLgk+ob?=
 =?us-ascii?Q?BGOj76xk0wBr3b64jqs/9kt7+clmqMi4hoVH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l35lZ5ebwahX29IS8DFvC4uHdqOZFcw4pZd7yCtryRr4j6oCyNsl9AJpBTc6?=
 =?us-ascii?Q?uwfbykgXjpujpBoygn0pTLJY2O6U4Uwz36R6S+i3Ddu5F7+n26VGRg76UZDJ?=
 =?us-ascii?Q?5icuhJk2BOKhMabcguAsHb5PRPP+RrxMoOPvQ/EzASKMY+2X8K3e/NOBQ0eO?=
 =?us-ascii?Q?igG/JPjkW0raJXIsOy7Iu57SHSydWB2t0pCY/fcNbFmtt6aOpjsLkQUSu6/V?=
 =?us-ascii?Q?ZTuYLqF55HXZywVoZVK6snKOZBnNLphKgftfwDPWMSvCX7tylAdGoiErzPfr?=
 =?us-ascii?Q?odNBQLbKkZ8oUcqnJZOpVYaGsaMB0cBrKrhEdGPXdB7RJSoHSx8vJyzYM/Za?=
 =?us-ascii?Q?NubFhvnyfwXgJR95AS5oBLInoThuqtctAhpzG2qQtsC2M7H8J6L/rVMflnKi?=
 =?us-ascii?Q?VTvlrAvToEaTZ++wASJbjR8ttODUFziWXulGSUqnIC2djzJCzfyrkqhYuH/a?=
 =?us-ascii?Q?/ehlNfPiRQIRtcU2cXSUmx4w/2cgI7rWT3eFNMWcxf5YbBMR5NbIy+vSjzZ5?=
 =?us-ascii?Q?Cf7A2mStLDu5ky74NdqkiLlq0edptyBlIEVcof3pxRvUi3eVeUc/DZDhO8dA?=
 =?us-ascii?Q?uEoLXDW+Q4YychVbxbcJUKRm1ooyPZZhXJLmM3h8dke6ML9RLZwVCutMfDA0?=
 =?us-ascii?Q?XGmVNa6OKUS88oZA1G4kpA9+yhpDOo4hK8bQCnV2yIthzpgRo3t2LeDQudyf?=
 =?us-ascii?Q?REy6r0F8CqAQcNMLpU6DSkGcxCKn2Eblm+50JXAXZvLn8kc0MgT4H1hzsaxj?=
 =?us-ascii?Q?o+S8x1m0HAhqGv/Z4vzB9XS+fBxHMNBd4ahLal7XdX3IGnEQpLlGDg61xdMZ?=
 =?us-ascii?Q?clBWG77IZgES4uIhfiSoPcuIxpTLuNCxmP/Jpjxn7/FDI6EakWIzAL4QNAf4?=
 =?us-ascii?Q?1Ir+/IqTp75E0J2Gh/PFH/eXAAQ0jesjhYlUtPP/wrNqRlIeiIO1l+msVUM/?=
 =?us-ascii?Q?50TCJPjTuR9rXyLUyxzXy9WdKFu8SAbLBTyoaCRTDnWrX3Y8spVaFJ6fz1Nb?=
 =?us-ascii?Q?jxyb30oou5UZAtSbj6fLbvsA3sTLs75sD3EcqGLQFEw/9mR+ienu+sJsKicz?=
 =?us-ascii?Q?WW0/hQkTT9TIvI1IP5C6uOFIKZpBXUVQLx1ERw+gsj3KqOVd3iq8TIBjC5eH?=
 =?us-ascii?Q?7hsuXvz8uX4QP5v7d46EaCrdubl+p6yMSh66FUyk9CqBuQPUItN4QA28uuJU?=
 =?us-ascii?Q?S+V/rnfcQKMAImWGqAflRyM2IIOeBSsl/OfqthbpAebY46s6KUVYTvRp3RJG?=
 =?us-ascii?Q?+J+XIzG+tT8cHwAeGirnCrYCPKahDa8oSSXOIPi69A3JF7ulZ9UGf5WViPML?=
 =?us-ascii?Q?ldPLmLQgXt8SZX0eCwqKBCV1sMaunLM/ez0x9bIh3vyBJ828E2zMlKMUcGjh?=
 =?us-ascii?Q?/P4uQMIn96mxsuZYqIbAs9hmLbyEzXjOtpHcTHEz+cRJXnO0JmSAK7bC36GC?=
 =?us-ascii?Q?tW+rRbiogfA56/aqhVyjDGZ2PwRNUL5PwyeUMlsxFT398MaUxItJptng/dEc?=
 =?us-ascii?Q?G+VLUB7g4U0dJ428qzb9yJ3Urj7VZzZXnzm1zTeLiF90k10EzGvkUvnSuFPu?=
 =?us-ascii?Q?F5db2B148WFFtDVLhzvto8lMVLmybrYzPKf2fRTe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319b5fd5-90d6-415a-3420-08de1aa98aa0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 07:21:01.3423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxgi4iTfdHThODNLZ8Rg03w67E192IB7MTIu4feieNuJQtFB1FSMzfqfKYhF/diNDfhAyeNT8h/34kyHgAGy4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7331
X-Mailman-Approved-At: Mon, 03 Nov 2025 14:21:42 +0100
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

On Mon, Oct 27, 2025 at 02:58:29PM +0100, Marek Vasut wrote:
>From: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
>
>SCMI v3.2 introduces a new clock CONFIG_SET message format that can
>optionally carry also OEM specific configuration values beside the usual
>clock enable/disable requests. Add support to use such new format when
>talking to a v3.2 compliant SCMI platform.
>
>Support existing enable/disable operations across different clock protocol
>versions: this patch still does not add protocol operations to support the
>new OEM specific optional configuration capabilities.
>
>No functional change for the SCMI drivers users of the related enable and
>disable clock operations.
>
>Signed-off-by: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>[Marek: Remodel after Linux e49e314a2cf7 ("firmware: arm_scmi: Add clock v3.2 CONFIG_SET support")
>        Support both old < 2.1 and new >= 2.1 protocol versions.
>	Update commit message based on Linux one]
>---
>Cc: Alice Guo <alice.guo@nxp.com>
>Cc: Cristian Marussi <cristian.marussi@arm.com>
>Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>Cc: Peng Fan <peng.fan@nxp.com>
>Cc: Sean Anderson <seanga2@gmail.com>
>Cc: Tom Rini <trini@konsulko.com>
>Cc: Valentin Caron <valentin.caron@foss.st.com>
>Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
>Cc: Ye Li <ye.li@nxp.com>
>Cc: u-boot@lists.denx.de
>---
>V2: Fix up iMX95 and sandbox after rework
>---
> arch/arm/mach-imx/imx9/scmi/clock_scmi.c   |  2 +-
> drivers/clk/clk_scmi.c                     | 22 +++++++++++++++++-----
> drivers/firmware/scmi/sandbox-scmi_agent.c |  4 ++--
> include/scmi_protocols.h                   | 17 +++++++++++++++--
> 4 files changed, 35 insertions(+), 10 deletions(-)
>
>diff --git a/arch/arm/mach-imx/imx9/scmi/clock_scmi.c b/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
>index fa15b5f8df9..fc1d5d77799 100644
>--- a/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
>+++ b/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
>@@ -10,7 +10,7 @@
> 
> int imx_clk_scmi_enable(u32 clock_id, bool enable)
> {
>-	struct scmi_clk_state_in in = {
>+	struct scmi_clk_state_in_v1 in = {
> 		.clock_id = clock_id,
> 		.attributes = (enable) ? 1 : 0,
> 	};
>diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
>index a7d89f32cd7..f9e17c38cad 100644
>--- a/drivers/clk/clk_scmi.c
>+++ b/drivers/clk/clk_scmi.c
>@@ -134,17 +134,29 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
> 
> static int scmi_clk_gate(struct clk *clk, int enable)
> {
>-	struct scmi_clk_state_in in = {
>+	struct scmi_clock_priv *priv = dev_get_priv(clk->dev->parent);

This should be changed to find the protocol@14 device, because
assigned-clock-parents could change the scmi clk parent.

Thanks,
Peng

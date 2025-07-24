Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53D1C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 02:29:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FADA83623;
	Thu, 24 Jul 2025 04:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TJGLQkpJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1630A835FE; Thu, 24 Jul 2025 04:29:40 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E85E38362A
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 04:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6/hCKec8dcs4UY2IqyemSwLKqECHF24cTMm3i8xv17EY57tDevvbzemSvhuWSRf6iKrL2AoZNTVAWMp1maJ1zjn/aATES46o7+FnnAWbmUuCMUTGg85X8ObpL21RcuRZMDynW16mzMUbNuiyDzEdb6UmCvVpu71WgqrcZjsycgc9FWfhywAClEse2e0++lMOuqkY0bzuPS84I8iL+EYll0yzzuR2p5t2LdGR/b5zvzgnVjcsTqaYMispJleWX6ajrsFtyDmpBQNCghoPlH02GZm/iVKzzF58ry5wjS7vLvPzHVHqwvrXy+85jorRNNfot4qx2Dj2FAQ9id2UEWKbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lx2ATclGMF/IteUHVJ/Byxp/z7ZxvBn4cm33bIX9zdU=;
 b=gHycY7xUxm0ZvJqEGDI1nN6RaGVMUj3snwy+BC7wwmEkE49uB77sPbXx2buoFpk7CDRirAt0Ro0Vo6wsZBPLi1Ah0HDN7iqXf3M9cf/UiPWoeHRVExuw4OHNx1cN3D4ILtW826w/4+1zmlg2onK8xp6Sv72lkVTobR17pr4yyoiXgtm1pr4ZmYJ7ebrIUx4c4qpkmyiR5IBehjopUVpm1sy/Jz8z2o0+6JJSiJC7bBGIlOa+CzluzTxP1xbIehyu/sh2Z5eIxKGSxFhZ12l747ewmpdKXFu+kKoG4MFo+BUCbRtOXGAL8B+jbcLHjSyGF3bVmgskzDH+wUNIw2SFWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx2ATclGMF/IteUHVJ/Byxp/z7ZxvBn4cm33bIX9zdU=;
 b=TJGLQkpJZ+aN0N9OxvY2hYk5P1l6IoXBhbuGZG48K80RpIirFJx3DPy2k26fheM74ICCcTDta65+b32O14IngwYuBCGWNrx86dslgdcSptZtGFa1to2ynSWmRAxQAkQRnkVD6yWQaYa24iF2aSznicqMLrKI4plCs4N+sc2FXySTnLw76+Dvp8teiJGM23ZEX9G/diNvM1G71TMjg6DrSk2feg+f6CIEXXglYd70/zvGv1NysquMIqHdok3eWbGgz6Z5UtwXQ15rKXCBuzpSPWslV9cEaHOLu5jKhNM+t43MJ2dcqwMWcEzbF+AbQy61lHCEUCPY9cbw5f3u4cy/Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10450.eurprd04.prod.outlook.com (2603:10a6:150:1e6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 02:29:36 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 02:29:36 +0000
Date: Thu, 24 Jul 2025 11:40:10 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Frieder Schrempf <frieder@fris.de>
Cc: u-boot@lists.denx.de, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 2/2] configs: imx6dl_sielaff: Set CONFIG_SDP_LOADADDR
 to fix SDP boot
Message-ID: <20250724034009.GG18395@nxa18884-linux.ap.freescale.net>
References: <20250722103915.105561-1-frieder@fris.de>
 <20250722103915.105561-2-frieder@fris.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722103915.105561-2-frieder@fris.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA1PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::30) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10450:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b39558a-f099-494d-9478-08ddca59ee83
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1y+xH4R31+e8ScpNwsuill1wyHJc9GrqMrJSB9uHUfdHtavSGewKURLTVpBj?=
 =?us-ascii?Q?PcYTwLzKNy97dTAz6rRgHvklrO4yT/u96KVPs1EOPrKquv4kpQYit9RYLgV2?=
 =?us-ascii?Q?USjuWD2Uni5N99O+TauIVFB3Ak/WFyPsIzqZ8IcsK7MbfhNJ9tWYcewHFt16?=
 =?us-ascii?Q?gOfilfQJ+kzZ39sY4U002sfS4s0LcTDRXuKuk1y1HHd/QnnGG3x3JFfHtn8p?=
 =?us-ascii?Q?7eP8P7zhgGGhJqXu2aiXzH+3qEb4kTs3FxgYWxzqQ745BdptJV/5/HH1maHt?=
 =?us-ascii?Q?LPEnkxIMF6qRvQZ8yWymGz+wYH5invXyjiNz4zyRHkvXXMN4oovIpf8sRDzj?=
 =?us-ascii?Q?xc3H6TokWCtw62plD4XCbWI9YhxNJ+Z0RhY4lZp5A/IpYSfCvRfDGaESOqnr?=
 =?us-ascii?Q?OibCvQUljyM8asm0QujgOP4WgKpD7IQ/3ERA5uFiyE2a8t8ajVt90dV7ekUF?=
 =?us-ascii?Q?0Rt30KtaumalFIX71xUPjuo984uj0O8Jzn0uXW8MIjcydFm74uvDTY+XtXAF?=
 =?us-ascii?Q?vNpO/1jmJp1AyzvTbUqKQT9quKVXrZeyLM8mJYUxxNAimpCJfIhUEDQ2YSX+?=
 =?us-ascii?Q?Apqjl2XEAAaVR6DmjbQeqsKP2LmcYBr9510oE23IrXPgGJYANV6G4AUVktri?=
 =?us-ascii?Q?YAbDQ9CuEXbmPqlZNQduBFRtugmnF+zIyLiFo5RaE2WCQspn8QWT9+GpoNDX?=
 =?us-ascii?Q?Iid4oPwiHJ0Twhojh0ds3bvXl5LC35FHP66f0H7z5AtiX3mtdLFvD6qwXJ7m?=
 =?us-ascii?Q?Rtnr+/JwImP+tHUmb1Xz5okIf+NU95wUVrT63/KcsHI0CZW02BBDoMU7bV0w?=
 =?us-ascii?Q?5S0m3yb8GeTFCUyrm0TtyIc4fEISLuS3vusD8M4hxIylcTrhZPakhqq3jwC5?=
 =?us-ascii?Q?BjR5AL3k8cOFK9s6Kl6ISV2nF6nkTVEQjTrpE2Xe2VtoY/IOWSZoXZOq1U9W?=
 =?us-ascii?Q?fC09Gk1TenWiDMqaYFIFo/Jo+JJ3savkKBoymYIwbAhf5g2fM5prTkhmddpH?=
 =?us-ascii?Q?fVLMvIL/gFntSIMXGPrgXWX7I+EHMVUCBaYQDxiD7nQMl4k7dloxaQjwMPTm?=
 =?us-ascii?Q?ZQbAoCZIiE59zR4E3vAOpKdCVYDnFlFzm4C3OjyS3F+gPONdCgPfrlIQhTRE?=
 =?us-ascii?Q?6zorg+Bpo+ucDpfH6Jl0S1iNG8E5JGgc8jvamV7fJ6J9qAY/I8D5uNDveP67?=
 =?us-ascii?Q?P/0q1PgMOuG4KQ4/SmJ1+aOo6J/5L/rBdwftxp3ZkXjCg7ShE+D8rr1HQuum?=
 =?us-ascii?Q?JSYGsA1shQzJd7RXYunYuEK3Mz46zpimVUozB8EENhLXONl2YGlrymZWKdWx?=
 =?us-ascii?Q?ECYNU9HGCpDj3m2TL0sLBfej8+QuGp72yd9CrW+fL+hfVJPSJYWOpMYdzeAF?=
 =?us-ascii?Q?3KaEaxli1qCMjtMO8QoqdSm2qufsR8IAmt7ModIsV9WCYmYSz5Q6JLrQh5In?=
 =?us-ascii?Q?t7CwEltV/s8aoDOgPT+IQ3cU4pHZqXD4kOSHtLXeyYQc+psRB0QpFQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VeKvA9WPEu+4QIgo6qBicQ2bKHYx6jMrLh4SmEZ0aqgu2nEsI6PO85T3oWlK?=
 =?us-ascii?Q?jKn6aLpHrzV/1T1PNlM6iQpe9SFlaioAbjbUY42UgCOxUfSgxrA5o2RFVmuA?=
 =?us-ascii?Q?c5VdmFfqd0Z/iQWv1146jAeiXUXQCiQP+tvSKfxr6dV8Il6wTwtNuNMyZihI?=
 =?us-ascii?Q?4dcW4ffT0v4EAhx7qecNKGk3Rcvnw9v8lR49PFRn1omp2DCcFkqQwTzZCBr1?=
 =?us-ascii?Q?Ot7o0fYEJ7KoxrUM5cqbW+VMBVyTQmNthhQIHQNyibrDCJ1MCfcSt1p65Xbu?=
 =?us-ascii?Q?5ZlYbfIeZSVMxxzTw+0eFEamDNbpWdBi1ptr/emzI9EFZbFdZ5Fn5Yr9KXEw?=
 =?us-ascii?Q?iAAov/Z23pafAknc9bBA1c7g+OwGzy754HRopdCJYoQkSjBULUj6sBIwbAzy?=
 =?us-ascii?Q?PG2KpdSO3KT47WiKOEktt4dWhamuC5t0rB0wEEfLegsvQx++cKVPtyVlCgv8?=
 =?us-ascii?Q?ARIypWfZaCifctb35RaS/SFvcukSssk+wV/Br0FPFwGuW/mEMGFy+qzvAJWX?=
 =?us-ascii?Q?wdTolUsk2JZw7+rreOZWtKVhDUMOUb505lV/GW1kf1JN9EoMDGVOwWzB8f6F?=
 =?us-ascii?Q?MK5UipAx/0ncsGaBSLJHgwdCqC5e/qlUF5eqaEJWnjURywCAYvZkL245DTew?=
 =?us-ascii?Q?9/yB88nWXjMiis7y++BfjOV4AwCji1pLfgVjE4C8XbFEXr9CEutI32yynNzU?=
 =?us-ascii?Q?9xzx9l5wLJdsgOLqpYSsOnMoZz/TLeMF0UJR61r1iXYk/nS6UAdPidEMhn1Y?=
 =?us-ascii?Q?MVPSIDzd30mUGrM9UxM1+AMVHuIE3UhPE5GaB23+e7FhHsJHdhcq6Vp8nJIh?=
 =?us-ascii?Q?pblnIsQpnrNdFyiPR7jkEM0bCYY+fP8NPIDRCXMn1RK4373B1Ep+EEQi8p8T?=
 =?us-ascii?Q?Wq6sGmAwDM3/csMm4LK663sQ42TQDDuYa+e5M3aJAZA04o9nw2AUPCU1jwqM?=
 =?us-ascii?Q?9vVW+fOtwUaRh8XIozDePt/UUeS9mGnh81CrUorCg/m+5fJndcEi5/Q3hrkC?=
 =?us-ascii?Q?1V0rvzOkLt9uh3FA0vYb8CuPoBdW34XEGupkpcG7VmJuI6WbMk7b++YDTBX9?=
 =?us-ascii?Q?WyPwnuWW75UvKLoGDUpP2z6vuW1/bg5V/s/4t8SpQai87ScgaviLzINlxKFL?=
 =?us-ascii?Q?tnGaWaWcOGVHhvDAjCHo/yrFshzYgaEtw7ooVE7s6CQpQlzxLJOYknJ2rMEO?=
 =?us-ascii?Q?ibZ4sFDj+WUX25dvHX69EYw949DfNHBfvu49dpFL0mp0juU60I6D6RkC5/cb?=
 =?us-ascii?Q?JQkbhpRBFI8a+GVUbt60kgNT5pogVjVa7kfP662Yryf2N9cPQVCWVD/IFhQw?=
 =?us-ascii?Q?oMIe4jiEd9YdDaISg58gO+6X2K9sjMa/Npt+4YzAWC5ftoI6Cld6Nv0Z++O4?=
 =?us-ascii?Q?GwvSqH083BYCgd3f+j6sd8uUddpHqBjp6uK2HJ6bMzdc2TBEjVWkpliC3HEy?=
 =?us-ascii?Q?b69LEaN/XYdC1ubIaS/XFR/ElkjF+o+YTo02/QkCBCv6CG0xkL0kuKp/g9LQ?=
 =?us-ascii?Q?6g1YpyxLfW2JAmchSFzMvk6yJl8J8hMlkGG+Yn0AykEHqP4OON0fsrvFiaOV?=
 =?us-ascii?Q?VKx9qzZJYgiwZvOdEiB8+6jTJ+coOXzEmRxePOg+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b39558a-f099-494d-9478-08ddca59ee83
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 02:29:36.0531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndAewP9dZ5IH2aVnZk83Wk8hUvWdoHv62/Qb2P75vdC0rXPJLBnvW2eLxvlIDD2jVi3+O5HC16HMkFJZMnomdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10450
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

On Tue, Jul 22, 2025 at 12:39:11PM +0200, Frieder Schrempf wrote:
>From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
>We need to set CONFIG_SDP_LOADADDR to a reasonable value in order
>to successfully load the U-Boot proper image in SPL via SDP.
>
>Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Acked-by: Peng Fan <peng.fan@nxp.com>

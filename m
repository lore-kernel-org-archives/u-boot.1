Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF0EF5581D
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 11:42:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02F158431C;
	Mon, 20 Apr 2026 13:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="spPTV9mN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9231484329; Mon, 20 Apr 2026 13:42:01 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 712A684312
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 13:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfmhgKtrPFcMGTL6K+dK8Wu90P6gR7b+J4GfwH8AGzfhnvOHQUxiBAyriC7+04hg9167ExnKIIzXU1J/NbXzHfKQ0jONliSkLCfXA+3S60qTna3JkGiwdo0kQtQqC6GB6F1UWhdZAYCWoN3KLNEoFjPQk9RuGpAp2t1NL8PMTCD6hd3bN8yM+IBbVM38utLMxHLp6V/mzySiQ+HXma/apHs+71PyKVS+SMLPfuXvejXcBw9RRxqfi5dGNcktVef+ZaBoncJmc37Y/8yHw2mlHF43SVSmZieEFwtUBnOucHl/sKmKbfSs63sMkCDCy/4as6gBTrc7dE0wcBd834jF9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BE1C1A4BEVxMMdQ/K9CEk+c5MdzGA1ZLrlb6Q+LQt7w=;
 b=MMGl6B33MYPOoaTgWEL4I/nubC0/0ZLgUlR+3hUdNgwC2m3q5gGHWCa+Fzp4KXODqs5MDtCs+CvMd8Zq9gb3DI/EFEPldAGnkmHBQHFWNUped+5W+qY0tetIx61gHRyZGGsK26IvvsvhrTPJ/dlt7Q7sr9ZDhpvheBc+ot7f0ekkoNLBOh4mqzwRFV64+rqUAqopBwYo6+6b93rHP64X/w/MGR+QjUDQarYe+zzWQymH51oAzWN9kIdxtsp7L70ln0m07JcZZQv35S+izkSdpmcuiTsUpgfXgtIqTi3V2/PVV2qunQBVH39KGSizl3yK/To66KZ+RVFPDET52/XWPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BE1C1A4BEVxMMdQ/K9CEk+c5MdzGA1ZLrlb6Q+LQt7w=;
 b=spPTV9mN4r4x/X87zZIMBe0okVEukaxBZ2uqmV63VFynh1l8b8wPhRVy5eiEtDN5cFBubDUmI+SGQKw069gNeWzLir6HCmb6XmF6V8wbdCgl7Mw+sVROguNx/gZ+1TurY8SYBog93huho2f2uMLUF/91ZrLb5fHADx23/gqOndADcPpJAfXwONktS2OmRFMuMZFCeb6c4gMWtOBD30/X1lhoTftzoV1IROgXtrDeaoslYxXysjGSNlPwJhLaNL4LuJINwLvODCoKCDu1xFFDC1D+JLR6+S0iM80mgfcYesCxbPZOJGQsskBOs9X8B1hAl5nNSgpjpp4ARzFZ77EjiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by VI0PR04MB10664.eurprd04.prod.outlook.com (2603:10a6:800:259::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 11:41:54 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::21f6:947a:1f40:18af]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::21f6:947a:1f40:18af%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 11:41:54 +0000
Date: Mon, 20 Apr 2026 20:58:28 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ye Li <ye.li@nxp.com>
Cc: peng.fan@nxp.com, u-boot@lists.denx.de, ye.li@oss.nxp.com,
 uboot-imx@nxp.com, matt@traverse.com.au
Subject: Re: [PATCH 4/4] arm: dts: fsl-ls1088a: Enable USB nodes
Message-ID: <aeYi9KpTEU4DuLLt@nxa18884-linux.ap.freescale.net>
References: <20260417141529.1490622-1-ye.li@nxp.com>
 <20260417141529.1490622-2-ye.li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417141529.1490622-2-ye.li@nxp.com>
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|VI0PR04MB10664:EE_
X-MS-Office365-Filtering-Correlation-Id: aba7f7f7-7e06-4b0c-c6c5-08de9ed1d235
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wMoydecAHSlbDNWRNvs8YpDGRxZy4TptBaW+o9Vta5M0QPpOJhPU5YVa0870oM6Q6I+eCB96xe6ynDwbsYBuHnP5566wEj5nWYOnYb44POB1HrdtEMyIgV7RtXF6nIrtMTRZEqNObR8snBIj4cDvynM31Wh2GWjGolmHvEJC6eE++KGZ0PNAtgc1h6yn3a/DNGcBD9X8vN57D9uLWputGxESapzE+0lE8EMZJeG0Fdpo/7dveF1bIEHIX+7y9odrd4qEouo46UaHpV4+AgkyjI/MZV3Bjab7u++0iZ3YlDkk4cNCzvC39pqaCoTdT1g7pyStzo/6iHtje/phFkF/qojuFS7DJbPQZRcpO/vjPVCMG+AXgfYozUoCXjA/1g88I5qNNBLkOmSc+mOR1vlZEZX3/raFsrYZFIPBZdvZ1TACkYvHsdgjp6Q/9hZNxAlhX12vh78UvtoqOZ7iJF8K3/f6XHZrFcmiZZFeESWxQfCyyiX3jGirS6YqFqcZBiYLA05ctjrt/IXHxVg4XgjC55asNAsNeBgjkUbAlJBfOew4HN9SYKis5ks/J3j8AyOC6t7r9bkF1Ya0YtgR+xo69dIGVp92ie1CP05eKXjKdJtPy7R21NEVfrlQ+tHVW9oCrY7blv4UFiAlHkCH3hd08jK6+/sf10ZHE68T/wIfnj/QQMtOjk6F4IbDaWBSqWyVjZKqplcPin8Z+kDZLMqXHuAEcUULtrWDk7m+mW7fQFOxT/pyg6TgaiBQWjeETHnV76y3TAXpx/jYZEXy4wXZzx3vx1mpgwja7L5nRuVhsSM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jN1C7AhzKj9zc4uJrMHtdSfjNxNT3ma42qpo8fj6+Qt3gPa2taULh2kwwDho?=
 =?us-ascii?Q?IzlhMF6LuqLmFICWlghg4EY7Tzl/94UlLnFaOFyMSGSlZvuGcGRXD5osdcOr?=
 =?us-ascii?Q?s+qssMR5pfBS7GNxQFtzksFtB+iYg8Iw6XQ/yTy7KGDC5e5SZdoXXhq9HvnH?=
 =?us-ascii?Q?cblMiBK9KkpNR+W0Ib+TusfoYrApKKNktT40J/NEKAqQpfEAEa0+e9+3tFyZ?=
 =?us-ascii?Q?tadDvSNfLURgoKMxsZfuli5ZBCaAMEVERuMErvJolWTchfvIIWUdcRWfRelV?=
 =?us-ascii?Q?UFpp9zC6272/cJaYH5lTX1XR7yJGLGdaAFNkD+IUAsknOycqV8zs6qqvva9X?=
 =?us-ascii?Q?V+kIAfFwj72H+EfV3fywam+t3+SHWZazBNJ5eTqJAFbbSWADe4OdnCl0ZKdJ?=
 =?us-ascii?Q?TufK96PcPbgZo6m0RUEiB7Node7bF8cp3ivLajxa1WTNnxhlSTU9ROpB7oZT?=
 =?us-ascii?Q?QxulW37Su29SYpBe6SXORnCpysWj9Q9vS1aAaWlz89YQqATz/OxapQGlGBsw?=
 =?us-ascii?Q?GqDLXlKUTIABK855BSrXLCVKm9Ewi3IYkuWf+QMu36MYSFwpdlSobeHoRz6+?=
 =?us-ascii?Q?q4iLpDHR5d4uWbHuAX3rwN0VDcAJ7o+iNXIfSAlBXuNGXcFaV/N/otcZgCxy?=
 =?us-ascii?Q?b0IVqZvSVeKlVA5r3tNNjJRptCb5gQ9dA/kY+F0BraSpdq1nNCpt0RyrYKpx?=
 =?us-ascii?Q?USPi+r8eE7cSaE0ojO1O7BXzDQ/2/GR6V2kiB9L6M4ZvAvDNpRHq7dBqC3Fv?=
 =?us-ascii?Q?J68EElJ+r+3YyKCRPCtEAGdj6SJeWhVQYTFmCRM3XmRtsKX0izWA/y20kd04?=
 =?us-ascii?Q?GirZRJT5tdVCTr36D3NDAyoWOOltxsRhHbsXzmsMyNMH1v8C0m1BX5n9axYs?=
 =?us-ascii?Q?niow0c2tXGp2WxKa+HlRsWdwd2+21YLt/d+Zuj7t6rUoT3oHOxb4g+EPzGrC?=
 =?us-ascii?Q?7bfo/Jrz3nJlmJJcaIAQEZ/6Q3PUYT0I8zKwaWe3ATo/VC3FtLQK4gNDtgVg?=
 =?us-ascii?Q?JzKG/SG2uJDxrCBj8U2gtwD23+PacTExNW/Rw9Ut1hjpwO4nP31TCA0NYF78?=
 =?us-ascii?Q?Be9KMjSKS2lWJocSYeFHBm0dsIZJ3D6fA60CJIVDVTzOceSkRT6JnxPz2GEx?=
 =?us-ascii?Q?j/+Mzw066sT+jWjWFX2fisyh4QSk2yPbDg2F8aCzZrVf9+sUutBiSnGQBCQE?=
 =?us-ascii?Q?Dq4IWAL7eC/wXBXxp0jXHMZZ6ks+m9ezZtnIMliJnGs7iDdVPudclvBU1cZy?=
 =?us-ascii?Q?h6Bj0bOn+OvtKzeRXt8xzPJJCbMcA1gSb5iZ700GaS5GLrVc0VeEgQFZn0jI?=
 =?us-ascii?Q?gtWlpnXTap4KOJxsclHYLqR9HCPBWiEV9mP16m6BmIRHSQ5xcXGkFGhskDkO?=
 =?us-ascii?Q?K4eZc59D4oFHaqN57s04ap2PMXw20UAi+sHavVfugyN9VfRt1QOCBT7jKtYu?=
 =?us-ascii?Q?7mQam2+9Z9Xbsy/4+cZ2NOGEkEsEWza2F4/tmOliH6IOx/x8w8+YENGALfS0?=
 =?us-ascii?Q?CP/1KG+W4NudRgz4mOf4dLusAaqBMutPd5lxYbHqyygossjLh03PVaTbkklp?=
 =?us-ascii?Q?66HQUNOWorfcdEIv52HTXKcoupfjJGUecTmu55FHpnSx5yxg7IhcXaRZ5xc4?=
 =?us-ascii?Q?dfGOar2weLz1J23EjH6iH3poiDouO+noJG1mOw0vQM2JD40C+HrsozW9grRk?=
 =?us-ascii?Q?lGVLZU5lim5rjKv4vGcF5XHQaqSN9Znx6EJB4mP1ZxdBZGCSYimhY4P6Ffsz?=
 =?us-ascii?Q?fk52JUr89g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba7f7f7-7e06-4b0c-c6c5-08de9ed1d235
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 11:41:54.6947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0dH3XapI9Z41ULmsuGpPkDBlncOHjO/3fh9K0VhozCj2FpKxfRtogU79LbQ4ZR/FQ2+QLU3W9x42eOf6Um1qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10664
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

On Fri, Apr 17, 2026 at 10:15:29PM +0800, Ye Li wrote:
>Enable USB nodes in -u-boot.dtsi. After sync dts with kernel, USB
>nodes status are set to disabled. So "usb start" does not work on
>ls1088ardb and ls1088aqds.
>
>Fixes: 10ff7e6b043b ("arm: dts: fsl-ls1088a: sync usb controller nodes with Linux")
>Signed-off-by: Ye Li <ye.li@nxp.com>
>Tested-by: Wei Lu <w.lu@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

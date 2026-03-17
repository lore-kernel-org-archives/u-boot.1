Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EE7FD875A
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 12:29:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E914D84277;
	Tue, 17 Mar 2026 13:29:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eSXR2pNv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 568278426E; Tue, 17 Mar 2026 13:28:59 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B9B78425F
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 13:28:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/jR5oOD0Mtn7CVOQ3mP4mQl+3DWJ9eO03IXmVIalsWzb5YmgPqR0gpavk+4/pQcBZh96pZG7fEW4HzsbjZq7nQB8UlMZDfFcE3gPeRhmhJquZfwVN+M8ksJPlBysf1fw4N4W0noORt8xg4nv3yl6KkXsgB+IKNNm6g1997v44XkIVcB5e1TwbH6yollnCQuJ8vLpfOAXqBbkTDEGtIUyHDD3L62tu+oA62vMhbN83Uoc2PujEXQHVcZp0dP1rU5HGhNIK2NmlQEuYTnCqpvYXwbfTZlVUiEPsr0HJx4oDc0z7HrzZXJJsT7OjKamslLAVBS4pbBqsMglA+QQUSH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZwStfPmMddRLxi880hDpeiIGo6tlvxrr050L7GRdb8=;
 b=CBcAJjYa2PgfGls+IpY94gzvLIHVY3X83jzHCUPpp0VhWcbLjPFGo8Sqf6KRYtpvjSl654pRYVYowU+CrSMKJ+GpYpxCGUP1mQo+4IuBn1UWZ2BiWAGcMPLIZhVxRVREGBACTK7W884JqrG3qqewjtAULrJ/WLBiUd6igsBQEnxInUvk6yMABSNZL+NtSxskatkvZQ2fsoi2lHVJBHJJ8wp0X8HDsUSeFQT3qz1LeQ8mAd1C1ldRMbzbSX5XTKjO0S762feBgc5YyfiKXYcM03EJ1WBm0PRsSY5TmyUFCp5qAJnhYhRaE4uI/cTuJC7hh91TY7wlFUqwnX5+wLscHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZwStfPmMddRLxi880hDpeiIGo6tlvxrr050L7GRdb8=;
 b=eSXR2pNv2XhTju5YzGvr/5noKBoeDQenAuDqt75xe6RgSbU3v6BBaIcbx/hLSYqs9qsMCNBfVOLg7SpZEG000wNbsHQi7O6YrZ5tIeobKpEF1xIWy/8L3Pdc3sXP5xOMJRea4YsQu+PUezyLmJOOBZKh+Dz2ECBoSj+J+MyhxbOxjAnGd0jUD9enWnqDVxi/CyRQm/zondKtVZ9ZzAFv6ZrGB5BWwK6lUTJ7pm5veWJRIAdUMQkYuYr7Dp+Qb3W4Tdz7MCWpt5XX7/VhFpB0zksZ2ZDMoljZDxb+8Oxsexw3bDvvPqr/JnVADn0U0fgnCcrZCvqZmEYXMGztScxD7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by GVXPR04MB9801.eurprd04.prod.outlook.com (2603:10a6:150:115::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 12:28:46 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 12:28:29 +0000
Date: Tue, 17 Mar 2026 14:40:46 +0200
From: Simona Toaca <simona.toaca@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, 
 simona.toaca@nxp.com, ye.li@nxp.com, viorel.suman@nxp.com, ping.bai@nxp.com, 
 sebastien.szymanski@armadeus.com, ravi@prevas.dk, joao.goncalves@toradex.com,
 ji.luo@nxp.com, tharvey@gateworks.com, qijian.guo@nxp.com
Subject: Re: [PATCH v2 4/5] board: nxp: imx9{4,5}_evk: Add qb save option in
 SPL
Message-ID: <bgv2qs2kotqahuoduagn2pxwvegthjmoy4gnjbzreukwkmo65g@dbvocyanygg3>
References: <cover.1773648510.git.simona.toaca@nxp.com>
 <8f6be77bacc6a9abeaf4e9cf6c6f5e01890bc31a.1773648510.git.simona.toaca@nxp.com>
 <ee133e83-8d13-4771-a306-f5f5c2a62b08@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee133e83-8d13-4771-a306-f5f5c2a62b08@nabladev.com>
X-ClientProxiedBy: FR4P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::7) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|GVXPR04MB9801:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2743f2-00ab-4b05-e9e2-08de8420b208
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|19092799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zZnprnKG2YkpUDUtv122E6L3NQ7TaerTV+yesdtq+LD2LwnFr1eRUCMWg8nM4a2OQjkrKM8Zxumwt8fvyuJrRwJc88vdoGaeDFW/z+ViEkhn28dKO8rHOxsdf9zCuizDtGNelNugXG9gNm7uOYl4xB2eo8PpEsibUni5i/BxVNRxORnsJDtaW9tgLGaeyFzVtZSCRzSVcxQHhI4gTFQlKL7dZ5hyRYTQMCTxDRfbTho0r+htDGkv4gtR5lzbzkVWdPlHFf9kvct3XgrwYqAADAiZquLn5F2G4OarRQ38o/ku1yovyc3R+raowpy+S5/VInIVA9wsSy/GbK195tLcQFE6Emazv35oIQEy6X03LyxV49Ro31c+zKwEEJJgfpHqxTfmvuGBGYV6p9fqJASAAyeUWWgLpux9HKKvtMfV3pbCaA6DJUg0q1eOBN/ZC9BI0r3k5CRBJLI5E+YYg8cj5GblAxoOieUhAb69Bw3miZnZpM68C6o8po5kM8TCcE8O36YMsKRAlXEzDdid0TX9zRqAqmuRJl45hBcy/RPDcnYxjZyuPaCBUDXlBqRicqqhHJ8ZWHh1On+1UpW50wBzZOTKoHrDOqUAbJC9XsrYhsiV+baekOSHZLvSLDiXL40BKvwXD8pMP7mzgZqkqP7gIAho4Skp10vFZpO7iOMPGdGAPW/NIoChm7BX6v2uteof3ajQqeYKYyNjTq2MiX+dPF0YXqGwmQlBlzoqo/09C6s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l+PDJ/gfy+C+FI2TNAxRFQ6dBNOck6x3TAX2LKly/DHKeyIgJ51IxjV9u7VC?=
 =?us-ascii?Q?82RhM4mG8stz8+RuHbPO32ynO8dRBKG9ImAy7Lo11giEdkhO4f/iS+lY8Blw?=
 =?us-ascii?Q?UQ+aeD6nT+ARz19xFWgEr0tyTPAss4FhoL9fhS+M0hZaE2/QfwkPLR8VhlyZ?=
 =?us-ascii?Q?hhJdE0qe0GNhcqCOo6SWdeQ0RuYMJqU7trVqEcU8F1Kz9JvQz3JgEHxk+p/q?=
 =?us-ascii?Q?c0nocdy9u5qVO3KPyvPqoSGZs0d98f5v0hlvt9Go981rPiNHtod3JskZRhUg?=
 =?us-ascii?Q?CiS+DC98fS4FBk0CpxApQbjqmvStuY+GbXriY1/ExakpLy4zzabofp1zAXCN?=
 =?us-ascii?Q?edBT7TBA9x7JwfZua3BS3GfClXe+vhaQ+1yl80yhTie3mxsrLY0v4dDZUtLL?=
 =?us-ascii?Q?IYZ2G0k2hGW4vj7+oM+fc+SNdK9mVrQvzKEqffAvqNll5Ikmmky5iZFDc4iN?=
 =?us-ascii?Q?hpV0JB0m6RZUS14iAHBQgi1gzhj0muapKrvragp+gYquICQj+zliqnfZKf/7?=
 =?us-ascii?Q?KTyP3wc895qXv6J2Ql2xkTHyjtU0SuM8WkXhctpOSLJtVNy0RJCT32Dp2RkZ?=
 =?us-ascii?Q?IWgKKHS3nltN9x6mmvXVM/HVHQ55tRftzVcrvsJi6Emf/4Yoqz/NIZRjyLSX?=
 =?us-ascii?Q?3NVe0MUaiX+jnBbntISm51eR8lGavyn2+dxmeFTDVFzT8AJgf6lA8CuKgwap?=
 =?us-ascii?Q?M0lwZr3HGfNeUO0xJrSzVmWBaVu3Ja3RttZ0z9N5FSiWw7ShVKRqgBff3lQD?=
 =?us-ascii?Q?QYzZGIhJpgDx4AJ3RNe7j8MzrfH+tDwSz8ABqae5BM6fV+xaSuJbgaKpJsYu?=
 =?us-ascii?Q?+hZppi7anuRATfrgYKKaNPa9n+VUa2nv4UMt9iQ1ajBofOPUZ3P8G5Jw4J/S?=
 =?us-ascii?Q?d9ruZNTpKtY6Om+kxhkf3FztmmS0u+JCJQM8PsLquiGcrk1FOaRvuExQ6EJz?=
 =?us-ascii?Q?HqhnKBPBiw0nXsoe2IQW76dKxPd8ixsq/y3y+lEtn+syDHbiA8SCeAZ3XRUu?=
 =?us-ascii?Q?DbsKpDVLchXTrFprObput4TeaXqX6kY1OSItWtRKAvDZHa6l0Nk6P4wMOycH?=
 =?us-ascii?Q?lHdruZM8uZQGe4rZPfgiyzSMkToPulQTfEewFUbPAOxeLAjS6WmfBZ72+cou?=
 =?us-ascii?Q?LQ8KpGOzlTUC2PoTI/iq4cSRPiMGep+fAmWGhTjsk0yYaXXXqjyA4WfUVoyf?=
 =?us-ascii?Q?deC5ntwzPGZoBXMJ7p9pewr3q3fYOg8tvju6tsMu9wrx0tnwhGRTqSrcdqQH?=
 =?us-ascii?Q?lB9nroqr12tzGEyBJr+PbsMRP8t6nVWGEZ84d4x50QAMw9h29hmETezWn/dT?=
 =?us-ascii?Q?N9/lvdPab+B0QPe/DJIleI0oK46YzYdc542H5mZRTzGgnOvm9HmH+IsUNwai?=
 =?us-ascii?Q?aK2QTzkrO+0i9hlN3TDN5CxfUB5M3bYnNhKFMN42l8xEe/ZkYKw66dtO16uj?=
 =?us-ascii?Q?7rdU+96csqPYdKHoPKdAbVsufteIyu1d7R1xJDFg/Q9ZRViWXEAoif4akLwv?=
 =?us-ascii?Q?7+HfUt/vWDLCOpaIn7eBj/3td0HsXPd/c69qHd/0KjlJgrl3fIhxoKHXxnZ3?=
 =?us-ascii?Q?4uM67I09UDBuaNbtaR1KFzCXjkaI3IuD+kIWJnL+QvB6X6wvtA6Zj+AWmCxJ?=
 =?us-ascii?Q?EbiJL5pQtNp+cg29qz/zpuYWpNCdRGfVpKo+cFoi7KLmCr+Ky7n3pxjcFGRA?=
 =?us-ascii?Q?9tfMpMqyVy80oVwm0lk4QtJoNKVOm++tBOm0VGK9viuzlV6LEV/54EjYRUji?=
 =?us-ascii?Q?9SgR9Z3XJg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2743f2-00ab-4b05-e9e2-08de8420b208
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 12:28:29.5458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LnkKXUb50+VcqLNP9y1qKxbD6pHtnKUZT3rp8Dcjz7U/czoUehrHSdogNpK/nWOnze3m46KTOyOlJqTG6f0sUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9801
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

On Mon, Mar 16, 2026 at 01:22:55PM +0100, Marek Vasut wrote:
> On 3/16/26 9:15 AM, Simona Toaca (OSS) wrote:
> 
> [...]
> 
> > +++ b/arch/arm/mach-imx/imx9/qb.c
> > @@ -428,3 +428,12 @@ int qb(int qb_dev, int qb_bootdev, bool save)
> >   	return 0;
> >   }
> > +
> > +void spl_qb_save(void)
> > +{
> > +	int dev = spl_boot_device();
> > +
> > +	/* Save QB data on current boot device */
> > +	if (qb(dev, dev, true))
> > +		printf("QB save failed\n");
> > +}
> 
> Should be in 1/5 ?
>

I thought it would make sense that all the SPL-related changes should be in
a separate patch.

> > diff --git a/board/nxp/imx94_evk/spl.c b/board/nxp/imx94_evk/spl.c
> > index cc5b7f9ef0f..1d25795eb17 100644
> > --- a/board/nxp/imx94_evk/spl.c
> > +++ b/board/nxp/imx94_evk/spl.c
> > @@ -1,6 +1,6 @@
> >   // SPDX-License-Identifier: GPL-2.0+
> >   /*
> > - * Copyright 2025 NXP
> > + * Copyright 2025-2026 NXP
> >    */
> >   #include <hang.h>
> > @@ -14,6 +14,7 @@
> >   #include <asm/arch/sys_proto.h>
> >   #include <asm/mach-imx/boot_mode.h>
> >   #include <asm/mach-imx/ele_api.h>
> > +#include <asm/mach-imx/qb.h>
> >   DECLARE_GLOBAL_DATA_PTR;
> > @@ -44,6 +45,9 @@ void spl_board_init(void)
> >   	ret = ele_start_rng();
> >   	if (ret)
> >   		printf("Fail to start RNG: %d\n", ret);
> 
> Use CONFIG_IS_ENABLED() if this is meant to be enabled in different U-Boot
> stages.
> 

As far as I know, spl.o is only compiled if the U-Boot stage is SPL, so
there can't be any other stage for this file.

> > +	if (IS_ENABLED(CONFIG_SPL_IMX_QB))
> > +		spl_qb_save();

[ ... ]


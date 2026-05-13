Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0BECD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 10:01:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7C508469A;
	Wed, 13 May 2026 12:01:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UhMPgnq3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 091C9846B1; Wed, 13 May 2026 12:01:13 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32FC08341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 12:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUh2KbRwm0DBOPWa9DRF+gawX7rxz5jwZYOflHRLiPRd9RpiU+r0xf6Xbl27tm4TktMbP8kqT3VB5I07zb6OJ66py/M84/ymEb7OAXB27t5fYB2arg3unWsoxnsxsJhEAKkJt6PH14NJoIGkLL90Nd7y+whaxZpKDfLcWhcDVt3qX56bTNfZ2GVVHzP/M03rDGktq2jT1iCi44eBkSkIF/laLAtgJ5VrNEYlIXneRc+dPz6AX8amc6XBFlySYPyEDfGGMfGzHhjksNrdPbISfW8cBxBzcK1uGeceiyUti97kfjpYJBl0zIzX/ziX6wZuNU6Rs9o8QPD/d3gno7tlbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvF3yGMb8vSUQxknrleHDl0J2Py5CFyo0DWN+F2uEOs=;
 b=Xu86DXL+Oz3vrOUVdQHUXwbNZ8F9tPWU7RD+bV3a4fgL+RRZBRGgjZiB1De5Pwwmu0b4pbU3P5jQj05zvDl1jfDM71MtWRJgujEIHWGY5YQa+C6F3waJTvLWTXSY846WxHQuM/mhXrKkJB2/3YYtgfAAtNcmsWTGJ2veMjdTN4/hT+2oFpoks+GLH8VG/DA/RiKZHTVs7anltSd0AL+Vl3+aYEBFJK9k8eIGhlfaHdNNXG3zmMZhKAcbz6jcR7MQIMwvaMYHtI+Go6ZpN3qczNL97K3AkCSZpr6h5bOSKsADhmjsHtT3BHd0EARmPO3/9Mb7UMAfkOJknyv21xXVOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvF3yGMb8vSUQxknrleHDl0J2Py5CFyo0DWN+F2uEOs=;
 b=UhMPgnq3xKuxO1tmi5EoikL+IYKmNnalgtGEuQgtuE+4T6ntaWHTpMk8+C9gSbEg4Mym78OAVa/AYi1eW/Cph2qnWg6JIHFVfReVsOhPGbbazGtmo2BrlOOygG231SS+VZbgIogUicMoj4fKYUNY5n0Q7AIC+9la1+4SVf9UqKZfQxp5NQgMY58Cecd3bgF0nKaLNbvehSfMAgjloIzHjnYsxGLBndhaoMYqoSwP5jWuxIrRE4xPzLJnfTIPAusBIqyZRwdW7U8ziQDjtdnDS4gedvY2PHRStQRi4VWBATNeuk4rgOb7Hj3B0yeLNHB9VYEsQbtswP8F/4QaKRf+wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AM9PR04MB8384.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 10:01:09 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 10:01:06 +0000
Date: Wed, 13 May 2026 18:03:56 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 11/14] power: domain: sandbox: Staticize and constify
 driver ops
Message-ID: <agRMjENIy0IN+Gkv@shlinux89>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
 <20260508122247.512862-11-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508122247.512862-11-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: MA5P287CA0209.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::6) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AM9PR04MB8384:EE_
X-MS-Office365-Filtering-Correlation-Id: b888a1a6-6113-43bc-ff8d-08deb0d68cad
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|52116014|1800799024|22082099003|18002099003|38350700014|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: frsQIMyNjk8JJbaMZy8XBPaNQcB7A9GTRj0lMSx7gMq0WpDHju3gwPCq3Vt9cZ67BywsrwGwpDV/e+ELKQIllYBQW+zX5YU7T5wH17x5PL3qZwnY7YgXb8U6NfeShOhfb9ORQwvi3xkNI+6x3Xdcr/dx1fAEyR92x9Tl0nu+LZMFWx/6QPspI8a2Q5L0U9w0p8wrWX3L2Bl7LqRR1lqAE0ojDDR0hgfyV4Ddwi0DMUbuDL59USwaCOtC813NoBLv24OXUGrLdBNUJhyTpfO5wXpcl9O+6z1JmL+mAinZozPPl9EjxqwQlH1oRNiFUKAmHO7wMB7e+PzyLW0xEmoi+VAqXY230mAJLg3NU2cixr3WOktJD0x69CapcovH+Xw/2lwNxZF8rD4zB+uKqasAkn67SY4rVF2RuMcbl4HJt7kaitWTr0Jc65SprSfNY2QJGwV99aswI/em5Km04eUJCBZGgOAnuos1HnNsLyRv3fuloT9f/wXLF2Sfx64E5SKEW3qiJSsKGRjrIbEtAmbvPP9N26OcHk/sq1IdYMStecupnkbMRE4lfuqt09YKx+eD021BvANamYcL+kMjr0NcAf/90Sl132CAR5KrODcMZUkUck8zePun2sBjCj7CVVfER8iYk/wmMG9SxxyufXn7hbZhp5jqD4g4KT6ibU74vdgE2jfxGfQK7/EgE/Na81ClH1zI8KRIdX1i69lgSq4MLfCx5IWO86cfVFkkiFWIW56Z2CV9xEOty6jRtnfdxETq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(22082099003)(18002099003)(38350700014)(11063799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jHaFtRl5BWJbay8jAKtvD6Zoe2OmnoscfvtckT8XbrIE8xSd+mM7bNJYx59x?=
 =?us-ascii?Q?TA3oIoEd4og8DXyuYnplYhMeQWT4T+VTylU+fo2KFmtmJlMLbzOZffjS2RRj?=
 =?us-ascii?Q?T0gZs7TvGvYH5cjZZYcjsoQhYapT4Zg5IGbYzAdLKMi4Kn9sIT92ng6VSvOy?=
 =?us-ascii?Q?hrhRDRPAROZquCi1a4P1TkdkTr8hQCCob6PzVyWXreXna3gx1NTLm/ph2Grv?=
 =?us-ascii?Q?z6EFE/ZNJ7qq8ABcsKAOH2PmeYlj17Scb3dKqx24je996qWu7sLVZWjD3anr?=
 =?us-ascii?Q?hOztxw2KG1asWTNAhj9LmcjMJ0bCKCNMN++tiWTKScVT4Wpk1a996y3odTGh?=
 =?us-ascii?Q?SFYVG4/A2MeRGVsn5JIEb9cfyQK8Jyv+s/OrZd/t1QIMeyfxLJvS+b2H5q/p?=
 =?us-ascii?Q?cxblG7L5nEpAT9vjR1kFD9bpTr0JxjT2QQIDYR2LWhAzkNwDDtVrymcrFK3M?=
 =?us-ascii?Q?3e7h6IpOP1MLymrnWCXOWPsajeVRJItk/MLzVTPBvHF8BvnSzyonHNsBIpmT?=
 =?us-ascii?Q?I0eerr6sFT60mv4ni3kHGR6SKxu4J9QPjEiiJxYOcgaI/48y6HwNfkA47RmD?=
 =?us-ascii?Q?PhwUpD0mYMYa4uHYC/e90q+z8+l2Tw8S8ZzhkrR4zJtSBKXY0yae3jSs/xW8?=
 =?us-ascii?Q?rNE5suaXQeCqjVLq9zfo6R8BYCmyj0OgFPdDRtfKv282YLrzZ65sp4vdhzwc?=
 =?us-ascii?Q?lanHud239AKf3eOml5ABXOvOMrxebgHSpzwB8HbJBbJGtqVl+Rryp1yujI10?=
 =?us-ascii?Q?eMbhNNJrDuL7+O18RrBl/lD6jATy77P4tldrlo22bZvgs24QvKThEOMTsL7V?=
 =?us-ascii?Q?BUX3I5xbYoOwXIxR3Qh7W9MDaSTc3Ioh78tjECATOy/nqjqoXvcl+pzcvdvE?=
 =?us-ascii?Q?YdmbKzZlOYaAwMnz1KzbSWnxGBikL0uZfV/n60LFSQOK6tdrCElN2h0JfFeB?=
 =?us-ascii?Q?YcNGdlpsqjJsMyNNe5HvAQJW4VscV79ON88jE1Ud6MfwJJKaD/QF6ChXLF18?=
 =?us-ascii?Q?5HodrnxnIFU1q+GyxiSy5gpu+kB+xVZhah2mAVuwz+uTt+G68FMFmaTzFe03?=
 =?us-ascii?Q?v5coc+NyyjGFIhwzEr9d69KjQ3HXiNA9K4Uq+VFe5O0v+8KqGElASljw08q4?=
 =?us-ascii?Q?r+3Lvy7aKnGbDGbhH3P70xuJ7DY/0zbDU/fwtF4woYAIowJ+KSi01t23sNlZ?=
 =?us-ascii?Q?Foeg//tmvIbhT76yDbqsmM5y1N6cO50ZzRmdnYLjxZgzElTDfi6+4DT90pfF?=
 =?us-ascii?Q?pFxqgjcvj05bCwVTYeHjdDPzSguBhYUqdRQWXHQqd7akaV8ajxQwa+WO4dna?=
 =?us-ascii?Q?myb0z7fvo8K1rjXWmcJ+zwlJRQR+3VnUUs2Oencg+nt/T3HTTCGpu700hgV6?=
 =?us-ascii?Q?HfFOUe7uPqnSVxq21MVlnQ9E/asEGbJxMY6JY8Ky21CHhMjtfVNBGWZgCrty?=
 =?us-ascii?Q?wcr2wYO9pHHVpIePqd8a2DPj8vNAIzOXE/Nz+gv1ujfK4msFwb1YMFThvn4P?=
 =?us-ascii?Q?aMrI26gmGVOAlsj3KuKmAStBw3eI5kaiiTd2YSv9uJWSpJPGdzAF5II1R0f2?=
 =?us-ascii?Q?Z/dtYVQK1FmJbiQjKuLZfuIKzU4BJgLlJz17r1V55JjjGNcwjjoYMt4xoWgc?=
 =?us-ascii?Q?vLxjCeoM7M/b1QpLoTN2rJ3QEp33E5rZdpmg0Ot8ohkSLjP21cc+zcHI2iLc?=
 =?us-ascii?Q?29TEz09+TUz6nmHHMvD5FMwclorC9wnwMP1usDUl7hdpw2fjVh6EpesgSqN2?=
 =?us-ascii?Q?o1EF4WSVKQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b888a1a6-6113-43bc-ff8d-08deb0d68cad
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:01:06.3866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNxD7pFQ0FrArOi+scENNWmAdf699cEdDxrzJEiYvHoD7zArOmYqYB0RUiNv2AGJU//SACO9UimjmReQDTKV5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8384
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

On Fri, May 08, 2026 at 02:22:11PM +0200, Marek Vasut wrote:
>Set the ops structure as static const. The structure is not accessible
>from outside of this driver and is not going to be modified at runtime.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

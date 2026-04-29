Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0940FF886F
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 02:29:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 748AE846DD;
	Wed, 29 Apr 2026 04:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TfPPFFX+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE7F3846DE; Wed, 29 Apr 2026 04:29:35 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1D91846DC
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 04:29:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWMPcEQA16TVBWTQ0oVHAcah4qianzG4+4vAE5KfQoInA+IxJmJNzfY17751/RFi+SlBTL93o3ERSye7sX23wApLqoO0M6/SM11oopvXD28DUS+tH0M2tKMzOTt6ApP2R1GRxHgwCDoOINefKg0aRyCwrA+FIXrBYFsh7jNC/GT4RGEVc9P/bACgzRUEKVjTwkBSFBfx0rKnyEgrwDKWN/fcdtcSR4RCn8GcBoy3BzW+h1aKJxwyw/zUA8OS8wNqkTkOByYDgCjnoUND8QiyYd44D582KGeEZ/eI5XcLz/pp1DNhyBFIfZ2wwtae91cMplYOu/aq6KwLIEDfbE8TKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhSphP5bxk4ifnuE8MiNpeJtdX+8F/c02ZiXuOfXZyo=;
 b=vXBsdlHtLaEntESZnhnp2PJezcOaGkjzX7vZkmf1TUsG5efHlp6nZaZbI3wCS76rG53QrZNdGNJb7JZW7YRrAFVZh6s++MSPMS64GfFoym+T3wu+6M5SQBhSiNM1zbavH9hDhmwoUA3sBSAqPHuxr2AxGJg+E/6jX1XBcTMNLTnk6mAdLP6gMvMptPDkVK8x3X7QG8xTTAyLUiklwVLRCcT4R7RLuQyRWQeXSP+TpH3ThFN7jTxWXTqSvsNFHOConi/HEZi4e+jafBEOOPclEPDs+CLKk2Co1boHckPsK899mQBn2VFDRmioiU42TN9dR+Elf3KeZgQuSBPYbM+7WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhSphP5bxk4ifnuE8MiNpeJtdX+8F/c02ZiXuOfXZyo=;
 b=TfPPFFX+iXBCdOWDiLQBrFOQd3CufFA+2NCHR+qlhQ3dReRLRAP6Ie5MbwJj1NJrCtk1iMOk/OPSBH8MxoRukf821IH72OpMwnh0lAMokkka3ZQ6GOWnYN70ZQx6IVVgXqPNFgWIrOY7XGprWBVneDwnzZh48W/0zJfcg7JN2QWP5b26rmmVbOx9MSAmmgbvraGKUuaqKG8goZC9kX/aKEgMPP/18CQNcbHX9Q3cRAUdQaP3kMrn6cIv840lN8duut2f2xgHWkAOqxcd00ELC/pHqU1oK7PAnXUZI3qMV3vPxsMikuoT4Z2TPcHCDdn+iGkorlGz9HppWwPJtzcgFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB10076.eurprd04.prod.outlook.com (2603:10a6:800:1e0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 02:29:31 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%4]) with mapi id 15.20.9846.025; Wed, 29 Apr 2026
 02:29:31 +0000
Date: Wed, 29 Apr 2026 10:32:10 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ye Li <ye.li@nxp.com>
Cc: festevam@gmail.com, u-boot@lists.denx.de, peng.fan@nxp.com,
 uboot-imx@nxp.com, ye.li@oss.nxp.com
Subject: Re: [PATCH] imx: ahab: Use authenticated header for images loading
Message-ID: <afFtqmogk3ED3xa+@shlinux89>
References: <20260428100958.1868472-1-ye.li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428100958.1868472-1-ye.li@nxp.com>
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB10076:EE_
X-MS-Office365-Filtering-Correlation-Id: d06b6b4f-967c-48f2-7a4e-08dea59724da
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|19092799006|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 0E4HE6BzWfqldyHXnHPH9sf6ctD3jf975142S786SrSGP77GirnrARWVnuYa2hLxtvJEKeSA2HsoY06B8aOZc88JAIIpRL5aYNFOAsOAjA9+5rx8+GQFaEL6a95zlwSiRZz7gW4ywKHl8KneyC/z5LC75yUYUqj+HAQYd8+GkKE93BT72wEC55TzIBAnt16exWxHuci0ihE9Ystp5wN7P22DZ2tHBwy/6jrMCarhTMhX3SseHoMw8IgEUG1AvhgyI35Ne1/tBEvw9pgjzATxNye9aweANFu1epoBfIWHloJt1Or1YC3r5gXuyskenUpNys1dACyi11mE2Orwz2fXcV2yZyQEepbv1CC/Nijnee1ofyC64IWGcOo9aUZsG2aszy9N89IkufwWoRbHy6v+7IqqecbwXXzAFniAskwtDF/GmxuAczXe0O3RPOrj5TWa6C5nPQKmGmyG1pQJH/0bPq8kDL3d6IiT0DO6TmvsiSDCupnLk22WgF/xamKG+geP7PE7zW7MORdWz3tyqt8ION1g1K2vdRq9e+QakB0T7MPiW9vIY/NcyZnXRdvOeXtK/q7otegSeXBE6/TwJ7UP2Bhfbj2DTn8AHELW8HG8lnIuUWd2uWnIPZE/Xc9h3wWcFayIgS0+1AHqqFnCllKYQqmQ/w825sF99bT4b07vaXM3Q0gAATSMdFIxhiKvSB9QfK63TrWp5clleDrYiEcjxKYNrzxMRCS1NihokE70n8WNTpJJSYSDHE/4y6T4pFYsp3aNJ9Gzfss4B1upxl4lccVDQ3BJHXfrOrkQnADa9kA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(19092799006)(56012099003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fZNvK2pcpDotgPES+MfcT9ReUKXt2GDwGDQee8IRYn4YHCDAs7Rr/0EVBVLQ?=
 =?us-ascii?Q?QCkX0feQx3sKswXt31D/El6hvWIDfWMpQtl2/vb+UQj1XoyYN8C8nIYI507Z?=
 =?us-ascii?Q?zFDZA6jMFdWy7Fto9rM4NOEnHdI0kfj4TX1ZKZtGkpq0VsbKL8G53WKtSX40?=
 =?us-ascii?Q?N7K/D5Oz6NQIvtActy1REdvt6uxJYIRbo0zECsFUt3jkph59Kh4ahfn4jfFU?=
 =?us-ascii?Q?VNL5E5nUgpdFey5ijb2rcittZeytFw0VuuinolsQge6AGbqGoxlGksCtH6x7?=
 =?us-ascii?Q?8SpcpdJItIWycdZOC+mV4smta0MQ67UMOv/76QJoVQnnSv6AcUWqzOR3kXP4?=
 =?us-ascii?Q?7NFkxryFAlmw/pKHXILzZhus/qfI4UpYr1d5J5micuntbxwPgQK6QMaa8HGW?=
 =?us-ascii?Q?kDYGcFMiN6uJXcMm1O9qUsOhrdBsbZvixhajYv6jQMNvbSsQXV6m+WSBvXSY?=
 =?us-ascii?Q?RXeVFhQj/djKzNmCCTkee9Mv0CpTcPOsCjudgTYwUhvJTfLL8xQTL/qPJYl4?=
 =?us-ascii?Q?yaWnLEVeES8+NqlrBgEYPBF0ojw3Li4GWu++kVo5Y1jQHc/11/rZkyve3UvN?=
 =?us-ascii?Q?Kicld8swaGJFGG6Synr+2qm4FNlEUjzBBuWtBsVT0WBK1t3bUYn1lN5X8M9v?=
 =?us-ascii?Q?JKgxt/v9c2iEaN9TFJIjL8XsoeOAPn6OtgSsX2jznW2Fdh/iHpH2hdXIIG/L?=
 =?us-ascii?Q?c74TdzKTMs0hrFM2Lr0w/6RH6CRJX76NFo0lTPec9IixU5zLjpkZKziUeQ5v?=
 =?us-ascii?Q?Gn7wwlJqWzhrLdNZLuTmbwSHFh3JLbi5Wf8mVntKvZ6z4qcEDXPoVsRYGzjd?=
 =?us-ascii?Q?KKjlORmY9PjvfcSAD0ljHR0G/Jsk9MR/IwjG1YZK5twWQ529MFGpqt3IwoTu?=
 =?us-ascii?Q?MSLFQj9nkudhjQrVK+FCy/nAf6Xnla1lpfNqH4Iz7ggSW1lVEcaqavsBfCNW?=
 =?us-ascii?Q?TuUF8ZoLYDelhjddFh8lmBBH/mpoRQ7Zck+iE5C5ns+akW23mBg1UMmXkIyS?=
 =?us-ascii?Q?AzppBeVglJNmD4yOtoTHmVDrgTPyDHLEVhCvCMBujklecXzg5L90SN7dM4lS?=
 =?us-ascii?Q?NI7UJIG5zy4ORM/xlV1vyvTnPO3/nYkpWz9JpjmmVIXQWrspM4tOW2Sm9asi?=
 =?us-ascii?Q?n+OKUCRD3rD49tDxpygkuUTyIVqCY4kVbaA3okbSe1uUHbX/ZBBAVaApFV98?=
 =?us-ascii?Q?lcTSDzq4V37+DC4Wr2g6otYhUp8doMDTYTlirs3t2ah4zcTAOBuhCSSp+8CR?=
 =?us-ascii?Q?Oa5j3Of8WcMLzqqmomA8uGf5CyBeWYtaDy3XitwUOT4NGe70lN8acPyB9p2K?=
 =?us-ascii?Q?CHuJlPqT0VF+IIq35rDadcJrxyYNXek3gqwIyhgrGZEYdJD4dWUJ9Fxbh2ym?=
 =?us-ascii?Q?Bf2w0TK/teVZmmrKcFB7hnS72gJ1r/8K6bv65QhWOoZiVK1encPiKCazCB3O?=
 =?us-ascii?Q?GpGLcaSb4yT5DT8W1xvS3DsqHZvjSnV6tpgU6b0pfjCDRZ0PvGgFJKzvcktf?=
 =?us-ascii?Q?9f5hpLOs6n/BZ97PVNejBNyaBw7y1TbhlJdYfRHz4dl6+n7GAs/nDY+DMsVs?=
 =?us-ascii?Q?4NHvmsFUiY88q2QFQQxhYiCDQ4ja3jbyT5ktDdmtfBa6jHoafRkZFZL3iBwg?=
 =?us-ascii?Q?0UWOj5PJ/8RwAOj2H7vByx7u11X6/i1J2kD+tL6RRgd63W5ob7SgzQ9dQSOh?=
 =?us-ascii?Q?ZL2YzrHrPQoZ9FKBZselvs1ow36IQVV9mq4dBknkC6yIMHXezURQvjIGVX50?=
 =?us-ascii?Q?f4e8sl94vA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06b6b4f-967c-48f2-7a4e-08dea59724da
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 02:29:31.3477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sr9LClT3dut6h80xVceo8byOgIJMAMjdeup0ZfCOveUFHKoWMJ84cIIsbEs9kEmb9qgD1OyD3sTvQpaW+RD/TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10076
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

On Tue, Apr 28, 2026 at 06:09:58PM +0800, Ye Li wrote:
>When loading container image, the container header is loaded into
>heap memory. If ahab is enabled, the header is be copied to another
>fixed RAM for authentication in ahab_auth_cntr_hdr. The better method
>is using container header memory being authenticated for following
>image loading.
>So update ahab_auth_cntr_hdr to return the address of container header
>being authenticated. Caller uses this header for following parsing
>and image loading.
>
>Signed-off-by: Ye Li <ye.li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

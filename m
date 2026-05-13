Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD03CD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 11:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B631E836AC;
	Wed, 13 May 2026 13:02:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="moGjyo4L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 290A084255; Wed, 13 May 2026 13:02:26 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A1F08341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 13:02:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=humhmKLurBTL4D7VdP5vFK3ZdbTqYCIYxOJNmbPqaTOaHmpH+cS+galMISnasRRFRO+nSVyAkMqIarJKN+f4To6soC6A3KDWojoOboKxHfKuztbZgC1CUitFVXBQAEjOPQcWAgSoBGqIsTDf9R2ijUmFeHxPO+RHh6zXQa/sw4XCcLC6vfupa5PIVz8FkVAqzxchCLuf8CMAL3g6LCqBdKiUKX4qlbij0agf/+FbAMiz7tlThwSFl9aNXtplIJxN9mnKZ4/oD6aAaLXpXjwI9cVCKCr9MjsFNk48UnMAVuYnWDzvWEM6yc7fIH48lumtOlB//xDgJ6UOY2rAYS4KwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmCwUFxB81RS2j+wrcIyyOghCBrxUIwVVLJ/qS7ITRc=;
 b=HsoRReSMNupKfYks3YzCJfaATuDx1U49jcu0XRwaiWs8abHJ8691UUm3lCW5wBZM0hX7An65BIGCQwtIy+zrOkt3jPvbo0aFDx43iu3Dq4yZZqLfoctgECMgjq0TDKDqclCq4fS9jyQxXWmSFosvBX5cfZ+1Vt8l5yeUEwW7WvFHsy0bLyYY5oblQMpc+M+tvipDs79Iv7K6t9lGU8preNWsoUcwXWotrFEUYjcFhdAdeNljSswE7gTgtnmR3Msbk1c+m+FL2xwCRg+bkxNECO/AS/x7/8y7hYpHHwXnyb+/b/tUyxkuxFqsOM9m0yy7jYLWl5abRAHifj6ZqamgIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmCwUFxB81RS2j+wrcIyyOghCBrxUIwVVLJ/qS7ITRc=;
 b=moGjyo4LWKaDBCJbmhcdRhT6OP2B4zP+s1Y5Us+C4zcpB3QbvnEhnhV4AD2n++s+3TJ+Tni07PoKHmDAdQ/XPw3W580sqnWe06bN1F5yaLqZonnCk08xghDAuBXlV8C4QVgYVsorufdM69t32nKhj7+SzY6VVVDqy+H4WPPEFhF8tFZdqhJ0zKwrHBKS0jDArjZuh9OS1tkUBKg8mNZtnAjM0JA0mrQxWQ6rFGDRp52gJ5MtrsnhlsYCkLCKO8tY+2S7BIeDPgcRb7xwf0eaVT90B72+pbzDjgxROsrkdlFvigMWH8v7ZQTTFbVszjl3gnmqAzobQdWToVxl67JG4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI0PR04MB10461.eurprd04.prod.outlook.com (2603:10a6:800:216::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 11:02:21 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 11:02:21 +0000
Date: Wed, 13 May 2026 19:05:11 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH 2/6] mailbox: imx: Staticize and constify driver ops
Message-ID: <agRa59NnR0nZccbm@shlinux89>
References: <20260507220651.209168-1-marek.vasut+renesas@mailbox.org>
 <20260507220651.209168-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507220651.209168-2-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: MA5PR01CA0223.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::9) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI0PR04MB10461:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a392fc5-f6e3-48ff-7bcc-08deb0df1b2f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|19092799006|376014|38350700014|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Sos8Zp6UQ4DIFrGhAEqaWnLHLebVfiY2VoxLMnUYjVnz6FHB3v1N6wRQpLZTAGIfg04c/VB+LD3JF78RWJg1Hiz3Hr2OAiF6K4ika8y94kc7s7Hyymr3X+uMvFSnmTvyZk140argN5Dcs4ThkTX0bjB13OVRrUcC+uEYaezZWJTf0hJhR5ht+BlK3uy9IrYu/6TvNLNd5V8oLEZgdcSQoK5U//CjYsmMEEAcvbB0bzxQC/IKYuJd3GRmh3HNInZC7GRVVrPMtMQy3XhNuvDYCbzw3INl2EzkmR7LuAxLJLdZEYZ6/dp5ipzskEQsRLVzfR9U4HLXCpHUaTHzNS40Hn4v8X/MY6x+4hQS+TzkoGnEiezQ8mCjNNFn4gu/u2SXhDofFaje/EEBkXkxtNcoyfzxz4tQt/KDg+OxJTjhU8rvNn3iyDqwNm/dtf7sKh3DTDwKsigvnWwIHgUXr8IbXtNvJzlbx45YhZzfyAk4dAfERCWC0/l934xy8K29npyP1X84mvcgkpK3s9F5jnM89iL5eWDWSvIz7g63Wqrb7WM99/vkfWC/a7JSrJroQ1s97RCzU1pZ8inVIJHr8iLOJSrbD8ykkRX7Uy3wyUkXp9TLK7VYFyfeD+db/kWVgq6ZUbui1Y9nrU0J4Q9MTfbOR+hs0Hpd8Jfl4DGDO3ghZrtfzux0fvoqPFcVLadkMTv+fcQusBY72Bm3Eo2DiDwVu3AafSTQ8zd3DHeZgo4tOO+SLGiy5EcPvfLNbFKLOlJz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(19092799006)(376014)(38350700014)(11063799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QSysWvhVv/L6Ul/tAmm5YV2UvNWxpEaH1f3TYHWxa1mX32V0do3JBPQfsw0A?=
 =?us-ascii?Q?G8UCpJzTik4c3RoXbXZ8CA35j1hKnzRpR7RDqJmSoHdW+cZCLj5dZnBn26T/?=
 =?us-ascii?Q?0cpZ2JUtYoDWv6/3LR2E03yV9ZTbg6YiA5bbff9IfiajOtXEDR93XZiIsUUp?=
 =?us-ascii?Q?zGNA5ChSv+I+bqcI7Y2y+rQnPgeS2pbDH/spou7JHgKecY1FVop2UniIzhDc?=
 =?us-ascii?Q?gl7s85RZb0lLX6/v33MS+q08btbaBmb77wdMCDIQ5uIwuJMnrclF28b5NaVy?=
 =?us-ascii?Q?joCALSt917AwIUb7d3QQruFf+16sRjyvrk1AANIPk7yQyva4serhWxIOoGl2?=
 =?us-ascii?Q?LkTwsD1zGL/amuXsd72k7HS53aRq8Esp5EPEjzDcHyIXr+ib7H2V2y6C1AbP?=
 =?us-ascii?Q?0DM4l/KB0WuU2GHqx4wEb4LJjAIUHMJxaWfbIJ28qce13cX3yIkdoGREsGr2?=
 =?us-ascii?Q?sAAR4lLi0P2f1c+uFmxpr8l9PT5N+7RGLRwQsld8V299YwpJJqIGrHUVTCjP?=
 =?us-ascii?Q?msA+I04h4n5Tsi6PFghZwWFb/iqiLImjuqtJp+3yEtd3FfN1feKCK7NSCLlv?=
 =?us-ascii?Q?KNoLn8B8nIgBsRgwVM40ctPntVWogycY/TblyFo4ufZjCvfmcuC7lAuEP5oD?=
 =?us-ascii?Q?tLBajVpyzHj4TP17ERX0IvV8pH3wQ3HRNqrMz6zbr3Wu4GpExI1rwTANk6pf?=
 =?us-ascii?Q?O7bWLlb4UHBKDF7hMC+wYLlbw2vREF7/P90EJVBYQE4KAktuqar1AjE7Exsz?=
 =?us-ascii?Q?ZMPt/RfkNPXglajnb+L7LoqmUKMeRyf2VPPIZTKm+HLxdwjhLmj+UJYdPtLb?=
 =?us-ascii?Q?KSYZ4KHRZ+eLDOqZY1r1JFV3jUtek9neGcyrSHsy++OKr7BC3JncpxZ4GYBN?=
 =?us-ascii?Q?zrnb3Ngmr/RcGotq7jaHyoO/0wS3Hvon4OZRqWO6egybQx1+btMLkIPsP2Vp?=
 =?us-ascii?Q?QCrOI2+8VxlJNFGZ9nQ8cTVr4K71xQ/YTSPu4W1N6vox5j/n8LjZXO0fQe6M?=
 =?us-ascii?Q?tNadTDSIrV0sGty/RxhJEnJYMv20FrEliW4TChXhAnT6+wzRfGN6VqzxMYdm?=
 =?us-ascii?Q?asxfgznggkT5P8mTZdMsuAT7+PX7PkWgUoRoqBrYl9Oc6FS16Mfk0+Oas0ge?=
 =?us-ascii?Q?yhIUgo8DSjrfYVKHfZeQQq4dbWeLjPAfLjI2ycQ4eD4zlShTCfZmaGOBprw1?=
 =?us-ascii?Q?nLgXhRVqODjedjsF81TM1zfhrp5d1KnFIacPJVGr9tv28vU2A5IcRanpaNss?=
 =?us-ascii?Q?hVpUgv92vsWrBiGzOV8nB+kYZ2bQ2QErU2+AaKuD20PNLZm2doh0CwdZe9mr?=
 =?us-ascii?Q?bbXb9a5yVFJVAsP043RPXXtXJq5lj6Lv9gjhFGn78BuLo0SKzr/nJi1bAa0s?=
 =?us-ascii?Q?5SdALeE9Pnpwo4lffmjuYoaE889FPc5nH74aB7QuatLMBqrSPYxXdx/D0GZV?=
 =?us-ascii?Q?AVw5TtgDQeV+N5NPL7izhziFzW63Sev+bU8wdQuVCu9ute5tZkLr0jC3wMPC?=
 =?us-ascii?Q?CXqKPoPXZeYMOKV0EiTEoyH9mqC7p2Z/ES+6Ebwl3s5rRbvoJCJpl1SnX/LK?=
 =?us-ascii?Q?Sb1D264YqtDe4uPPkPpBIfGEjJOVa50MRTMBeHyH2EOhI4tGPNES+lxLdceN?=
 =?us-ascii?Q?zJrC105yMgu1fVVCuhsvt3sKwJpfNixLxZ2gbNrh4QpIxMuVkTV9n8CQRkGY?=
 =?us-ascii?Q?JKH0+GWEuaLT4Iq/iKYMje36uRg6COo5VxAwIOd1mwtg7oh33qUngMIAv3JW?=
 =?us-ascii?Q?cRJyGI2brQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a392fc5-f6e3-48ff-7bcc-08deb0df1b2f
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 11:02:21.4591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4I4IWUcwEBURCyGOlGYV/3wWleJ4ReCp5VyveC1/wftA25+f+wo4MKSD2Q6dfkm7vFyMR4n0QABWzJF61bhaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10461
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

On Fri, May 08, 2026 at 12:06:29AM +0200, Marek Vasut wrote:
>Set the ops structure as static const. The structure is not accessible
>from outside of this driver and is not going to be modified at runtime.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

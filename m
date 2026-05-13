Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A282CD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 09:58:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4B738341A;
	Wed, 13 May 2026 11:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hq+D+8le";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A861484663; Wed, 13 May 2026 11:58:08 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E18FA838BB
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 11:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkqrFayRN33Mqx+GMZyFtSlnZ8nv1OsoAetODv2tJ9JjGmrrYIsGAXZTqnAe3Fq0MAKWTNL/AjrNmCw2VswiqFJf8EfEuf+qscO35jYjoUWKE5e3TZ+QQ7IwsJxHUM11PsNwubk1gj0jh0paXbiON8BvhjYUWbeOhSawuYZAcBabR4JdHTwfD1jkPiyHWr+M8pTgHyaX0Q5v9becp8omKoMlmyF2i3hl4BzFSdK/BZVjggxj5xrXCiF50wMu1novzRtdQ80BzA6Xp7rxLpfU5bJXBkAreEzl0XzhcHHnwrDv8m//cySH1LP2JwS5iMD17XZkEqtw1r4kXONAK8egCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lIWcx3us1ydWCf6qTWiUmrkifm4oVzuZVONlDycBDY=;
 b=ITc9yAZdBrJGeN+5m7Yl420oPglWFvzqNwy/sTghveboWtd24ju8eyp2b2KJMGw7v/axz1Lno/dXS92G0qKPBJuA0ikCXMs14u5FLIn42/0JCCTrAOjdvWFH7DtLoC6ENpm8Hq8bNcUiB2ba5pS6uVHH315N6g/H0cEgZ/TMoWEDrDXAz78zTF+s9EfknrDi4qx5l4u8v9AvPvlWSGudWRGYwZqx/GXLxmfKMRgtiKcejGkpSYAB0U1TMLISMegV3oSKSarmRZeIDLEEKxtuG7vNkSGZ0D9515Ziy252zrnSk1JXWd6DnkFy8bbT1K34Nux50k02BTFIPQLEn7rjRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lIWcx3us1ydWCf6qTWiUmrkifm4oVzuZVONlDycBDY=;
 b=hq+D+8lehfwuiHeLdyp2Sc8UAOxxtG3YLISS+fMQJdTLqAlQhxY27NbX6VTeDu8COCeN+HHrEGpJJhkQBNUpQbCQWdWrTl1vum/U78sT1XZ3guy8nAwuCAJkcJIosHMH2FVRsCmP0Wu3nMSNCaJ8OUuaZUTCCSiJ4MsGWUJPiSh2iNXuJsT6REiyDJ9545zuZ7/Fy5Jr3taH5RXjoJQE5cztmz5usdgKFQANH7mJU1foFsmX4C1vqLlUR5onmu5+wM1gZiVpNOO4+kyzr2kmu7+7zARjKGQ2kTqGnf5GGIpf+aF9azSYePWcrLzRRe0Wfd+mU+98VvONUHQDeNFmzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA2PR04MB10085.eurprd04.prod.outlook.com (2603:10a6:102:3ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 09:58:04 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 09:58:04 +0000
Date: Wed, 13 May 2026 18:00:54 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 02/14] power: domain: bcm6328: Staticize and constify
 driver ops
Message-ID: <agRL1mK4IUY7sAj4@shlinux89>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
 <20260508122247.512862-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508122247.512862-2-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: MA5P287CA0171.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::15) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA2PR04MB10085:EE_
X-MS-Office365-Filtering-Correlation-Id: 04421846-299c-453f-368c-08deb0d6204d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014|56012099003|11063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Vym29RNfCPOAg1VLVWbsHK3yzRXaHmDEAQAM18jPEJdYtHK4shd9vrvetEgRFNpOHMzhQ6YpAEaPI5JpTHEcQ9o6gyu+f+2D8msFZEBUq+WZEt55vzpKYUmekd70efU+Bs795BdcFC0Sr7kFtbipjDbWSe6YA9rQnxqpHfssHhEJxM3C78upBZM6W8KEbjV56fwmWwTju3N3s3CfofrIP3uaTRVktJX+eiLmiPF5Np/NeLMmaO+yQMYjA+e5HAtEKEi2XydEPaIDk+WEkTSJ3hOMrlxdCXiq/mvmFVigmqVKYNCtfVFA4IjrZVSTfB+mZKcrm7mtOKxJl/a4gqjaMKTIjb5KaKAz0104D9U6cuqOPezf9MMymZ1wcSzApYYDtJdIF7bPbxHAtq3qR+XZDuC3buHdL5kPerq8iWDlkCPZX+5SlaOZA0vbGRwQaePLbN29ocNZFB0wrkEBFmAYQgGVPWV9IcZTwgTZcvi9L9rHWv6ctxVImNd7iAazjL+sWQbp3hPFjTJEa6PPAb5Ewc5fyNMD7fVjx6e5I/xttF38S6zj2bYxXzWXQlaPrnxXDuZcvsjknpZBk3ow06UUzcBwlvgx3AEqXeZJ7kDQoOBPKljpGQb5qLsRs/gpzOrfw+YGMa4zWcNaHRWtV/zoUenWqE16AEGAcpw+/Jdst2wfxox6f7YZT+8v8NYS/uZmOkbqFM/CnImSElLJsKrhqd1raBe9fy/phFu3dSRnq0H4c1Rkcd3TTkZXdMnNILTw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014)(56012099003)(11063799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P5eaArxDsofuuCBr01XdW23t4dvogIgV3UZSuEPMgpEYFRC2yUWV70OuJy6B?=
 =?us-ascii?Q?MGdM99Upj9/+5bnS+YmrxwOWY+yo5ncmbo8wHnFj6Zq2gco2ytxIoojYBkFa?=
 =?us-ascii?Q?1NPWRgF+hFJKp51qejQVBbP3GHf/lFaxtPbUtm57CzkeinHku+HQ4zgXQ/xA?=
 =?us-ascii?Q?iTsPTdzln+QDyUR/yWzI5IS9evgJc38h4RNke1YCTPzJn0Ker73HFRs6NL03?=
 =?us-ascii?Q?xTw+OoU30K06+n47Bz29ZpfhCSRc+57BlEAvggQomlKfWrGmSnOG97siuWla?=
 =?us-ascii?Q?lMTe9TOLpHlIADTmeaGTvons8d2HrcYZ8DMp/zILAVMQ6Q2n93UaBoiwHTah?=
 =?us-ascii?Q?ssqbFCnpIVq7JVHuzxA7bGdvGKLDS3IPBLRfY0OCvx9kFv0VkNk7bKbz5rX7?=
 =?us-ascii?Q?tjjAxWhkG8Sn3TdMoGgZSryaYdwsprtCdqUIkplFYrnZKraYWIC4cvhzzySN?=
 =?us-ascii?Q?+7yW0dEIDC5OJ+kU6hVMD4OPE7pRA05LZ+AEQCOX2NHeIH/cIAzvf3a80Yz7?=
 =?us-ascii?Q?uSsPlO24CMiUJbl7Us7Q6lRKjCCKMr95kiTPbr+jf7VRBRYWnLNM8ZJXjPFu?=
 =?us-ascii?Q?ibqT2UTjTH7gnyqTtmzVy3OqdPAEhIRMiGZm5jgZhBGNxwswWk1EwnaA2rK0?=
 =?us-ascii?Q?7uEpVhnN5zC51LXBvHq/D6gF38p8/ExBZSFevGf7SP/5w92AKCQjMEGQNU14?=
 =?us-ascii?Q?4supmhKuhINvSlBAhenE4Az36RlsIBHqBRYJpSAZ1GD6OF6idyFmyihwemN5?=
 =?us-ascii?Q?jIITtDJg52mhFz4M13cjSOGUY3f13CE14qMxdj3WXVRz0f5+zVEg2DJcqQuW?=
 =?us-ascii?Q?Tt/5wY/bQMxHccHnFRTKCKbc5ZmRFAy9tuvbkvlyXHjgdu0a30b/rF1SsEwS?=
 =?us-ascii?Q?5pwu70ywgDLwZgSWe4N9QYwaSt3zADuKGvmjW5apV9eNYMGy5KcLgHcaiAY0?=
 =?us-ascii?Q?cin1deJijhxWwl2+HpDCZO2b0WR9RNTMqbKkTD8zOfluMXhPcpLYe7xb8qab?=
 =?us-ascii?Q?96rjvsJDNZtU+/cEEaEwDo8XUcbXWFK4ulfeTBLln05ZGtL9P02i5N6UbJ9v?=
 =?us-ascii?Q?wMAvGdwUGEICRtH2c0k6z4JnuGG32wD/ShhUuh+kY5389CIRPA4EXV84i8yA?=
 =?us-ascii?Q?YSLsMuqDba/mWRmtx25c4eDqSRw7uKYKZDkn5fnZepU1Ef2731Ldq8qyIfTT?=
 =?us-ascii?Q?abrUkt4prTpCMf9h0cz34sNiWEPRAmseGcUT4ZeqgGGzCZwCdqEQkEpLB0I4?=
 =?us-ascii?Q?x+Vdl5cyMaltuedwX2tRmkMid7/nsg4jdYav36GSpftGgphSsDH+lD9hvFqI?=
 =?us-ascii?Q?3na1h8uKlwaYZpgSDrlGRZlH9ZAmG+HmdX78Lww6U2SO3d7H4KVCLigx9K9p?=
 =?us-ascii?Q?xrAhQ3iial+TnI/1KdHmmi4B26vIPWBFxyVW89/trdkwicTMMVYPymMqsdh2?=
 =?us-ascii?Q?kFyorPiNWmxKb8cWv/8cv0096c3OP9mGLrNULiPnzEfIQ7ig0LWFIja3sL2E?=
 =?us-ascii?Q?jUQvJgyQxqGVDJGRRRlR/KGyBTZxowZuSe8VbwugUd10JcgvxDeJC9lt+rKJ?=
 =?us-ascii?Q?vUKnIsiRLmBRSqdVtTETZFBEE5jBIfN5BdM82E1J9cktL9haFAausEVr6qxu?=
 =?us-ascii?Q?J/vJdkr1hOMovUzPgonFXSsrnA0N+Qzdo1sg2RNnKApeoJSBN///0XfC/dts?=
 =?us-ascii?Q?rsIOEwLNZQUcSUDRmCbUINibpp9J/764zoz7219RQwIRPo7NXQByEgVlcyhw?=
 =?us-ascii?Q?OL9NV6KLhQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04421846-299c-453f-368c-08deb0d6204d
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:58:04.5480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjZv+LlROquJ2HZFTvI5f0pXd6tRWAczpttgr+qPNdnMhR/MuAP0jkQTPuyp1uB4lptucz2Cs7aHrIsk48Va3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10085
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

On Fri, May 08, 2026 at 02:22:02PM +0200, Marek Vasut wrote:
>Set the ops structure as static const. The structure is not accessible
>from outside of this driver and is not going to be modified at runtime.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

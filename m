Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4A4CFD624
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 12:39:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FDBC83C4B;
	Wed,  7 Jan 2026 13:39:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RYGBfRmB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF06483BB1; Wed,  7 Jan 2026 02:37:48 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C48D839DE
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 02:37:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvA5d6SHb7H0BytEfj7hYqGNnQmdFGX6Zgayd2zU30d8XKDQ8B7QQOCMljQmAhHMVd571jPek/cfch2/aeZg3SDfVdeOKkR4UzBO0V8N6+KZDMLqfOrsgdjpGsKUb00RaB+i0e6gGtQ6PnWtda3zqOlO+Mzu3iVj2m3KwkjCiQrBzWDdl0kwUYB1HmBBBtpTskcLBkfBIGlqb+aHI4IK9PpSYX7Augzl7YnvLk1b1oPoZ8R3T8szS5Yk+jkjbRe6KO2gD1QJv32dmhECzZt2QggP7fBpXZpS8vOuMv41140+tZbqmWpxjcAvarfNbjX30EtwOLLf5UIafKP1F10WDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtkLF44flsnzC9910vYQ7XyWRfVeHOsVq7BRi5bsC5U=;
 b=hMQvwQU2DGOaPr8OQC2Mz91+bVpEOmjJYlT1ljP75yWutb9fyAopZueRCrbHtGE6u+glmpZgPPuGb8VqgIsR1bz1eHZkgUqQ/s0dlypiZrB0kec+amqew/WYbFvbUwivI6uw2EaYrIH5U5cze09sA3W3YZpmhY8vjF+LDLFKrOJDXTfGI99Sq0yfCQuBf0M9Od3Iws216DFJnsyQOh1jMFJU9UjwcUrwOLNK65jj0oQecCSKVpqGgCTu4EdfOz1uiH1rB8Ll10b0CMYpTiHH0FlV63KLAcAV7rIlJRn0bheV+rRqn4Qp8hGxNG34Bjj7JLFrW5h+Q6tMBJqKDj8W+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtkLF44flsnzC9910vYQ7XyWRfVeHOsVq7BRi5bsC5U=;
 b=RYGBfRmBQVcv4SjIKrO1WO944a97PwFMmENKY26CvPvafULf6kGErJTWGkjRfOIHqVgG+VKk5mv+7OZslRlOCQ3Kqk8kUcU7Utngxu+UogkTTVgSp07tYC1AxvQAg+azFIzLKwTZRPrkI+FWEO0vPIlmCLvqlT9rusblGSM/B5oLLlWJZtkMYXFHTKOZhdRV/FiT1b++Oo7LnTrfb+wXL70is5LGcCB2BlJuHAOYJ7bPpA7DlVn3xBz2Fp78S9TBascZ3CgRZh4KkRzW30NZPTWmgCzBZqOusb8hwVrkWheYQBgtEv3x0XHZc2oGMO0oYQBBbXWf7/HUJAmp2fIFxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA6PR04MB11885.eurprd04.prod.outlook.com (2603:10a6:102:513::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 01:37:42 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 01:37:42 +0000
Date: Wed, 7 Jan 2026 09:39:13 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Francesco Valla <francesco@valla.it>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Joseph Guo <qijian.guo@nxp.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Fabian Pflug <f.pflug@pengutronix.de>
Subject: Re: [PATCH] imx93_frdm: clear and mask TCPC interrupts
Message-ID: <aV25QVMb5CNVN5sw@shlinux89>
References: <20260103-imx93_frdm_tcpc_fix-v1-1-d7ef892697eb@valla.it>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260103-imx93_frdm_tcpc_fix-v1-1-d7ef892697eb@valla.it>
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA6PR04MB11885:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d436bd7-5974-4044-6981-08de4d8d59c9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|52116014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YzXL7NUxIGAV9HWqyaAA0Ea9h5ietqMy9fa8rkvqQ6TmpnAtS/dFg2a0xU0T?=
 =?us-ascii?Q?Qf5iS/Bv51dorY8VHLyJxTGKxBztOiK+brXIDyMKZ1wqo/wNTaxqfSeLe/ER?=
 =?us-ascii?Q?pMAFxEl65LkN3EOAUfwQQ84MYCUEyPtMPqGDOFklvu7XGllsPKHp06gMZKc5?=
 =?us-ascii?Q?2hztWdicucpRSNHwVR2WEUoDymNwYboAJYVKWqR8ci1+V/SQFh0A2FjIrwWE?=
 =?us-ascii?Q?4SqOhE77eX2rKPwX1R3XO/4jGvaCVnYsW1J1aVP5b3N/jQmaXBClLJ9A33cM?=
 =?us-ascii?Q?5R6m//0sXdHmqGSBTLgRw1Ofhu7h+z7pyO3M//h+G/SeWSjY4ySHc7yiS+sB?=
 =?us-ascii?Q?oseYief5EUgsA5ux0fZn/b3/DFmfFjflXXn5Z0rjfNf091Yzl5IeMVE+p21f?=
 =?us-ascii?Q?BEsRoOHPZ4TTiRgRwYRSlNPyE89II/mr4kOw6ai1GHLXuprglIJk50wJsFiS?=
 =?us-ascii?Q?nMnoY+d/wzp1X4UayHKs2NoSVlu402V4c4ESo2KKdoJuPwRhh7WR/jvCsFG4?=
 =?us-ascii?Q?qF0zjCeTDAKFdCPCaI+z8xwtWPotuPWsv0AaR/c/tTgSPHljShR+j7QV5jyJ?=
 =?us-ascii?Q?8ULCqHy+fZ/HKX1B683/BZPz9UaFXSAGvxukGvVVYypNf+oew7C6+DnfuXZJ?=
 =?us-ascii?Q?hXzo+KxuzZwB1fBaDd8KzeggagX6Ggi1gkoWSoZKVilidCjDhQwNYa9fbIQR?=
 =?us-ascii?Q?3kU386PP2lcsX+266mFESYMSIb6+NVPAiPcLoXwzykAR4rVTJl2R0hpXU+fq?=
 =?us-ascii?Q?4pwU3vphtXrG/z9pEj+nZ7uggUHx3shuBoAIzOeGI3AIx5lGfqDcwN834wKB?=
 =?us-ascii?Q?cj6R9hWcYS+ihC1JmW+bOs3bh7Az+q1IN2GFK2B0p1OOrwSfJJtVw+KhMcFg?=
 =?us-ascii?Q?o5gB/OSRdY5ConN9lPqQPzob6TtP3KX7qsEsh9WOk/KBPYfMVWYI49AvHbIW?=
 =?us-ascii?Q?0lwgZQKcylmXa9w6CKtKGCExGRngz+4wYhe71w/9u0CPlGMsEUD59cpzxtjw?=
 =?us-ascii?Q?x860MboWBMcZD5b63TN7ezI2yvPP5sbUzQ2JOJpqbLdX/+0rhLYJJEOI2TsZ?=
 =?us-ascii?Q?5RLneNfV3t69Rxbek4vOvgH0SVhF0AH9z4+vu9mxyxQgRXHiwhj6weVrYSe3?=
 =?us-ascii?Q?M4s/fXJIcSMznSnMKFdPOBsJ6M2M/i9Y4fi+nvytAjba3kFub93uhdiw7X6T?=
 =?us-ascii?Q?70+DdMRS0Ibh8RnVhdAF0+DCp2nDboSItqTL4yaZDPeMuQq6A9+PetBNdZdu?=
 =?us-ascii?Q?HAkUVjcjRR131/teNpkkXMmsvQYIQPYG3rkRStDlSYVd7WEbuyiR9hmwLlg2?=
 =?us-ascii?Q?osNSLY+9YzMm2si1nKarUt0ucvn1fRZop3Wz3Y6uNtIi0g3+D09OMJkF3mtN?=
 =?us-ascii?Q?jtzpdsArHdpJFpnpLpRzSCFpkKLZo6LxR51sxyj5RsSiYaZ71t6eoUddoTHj?=
 =?us-ascii?Q?wZ02aDTcEGOxTDUutCrvwRRs9EZejGIDbB1USUCZF7zTAnrjV5/vXDu+DBqF?=
 =?us-ascii?Q?TyICpoASZ1kDi2MBusRHzf3tgvx98wz7stAx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(52116014)(366016)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lWn7J6QW+GdzDI/7bYUEyBCNdmVzdDdt97frJ/OUhRMxdpBcElwtyVWDSCLn?=
 =?us-ascii?Q?MKche04QvpmMKns9g6fabwO0KDxpCpsrU2N5q36i3AEpCNzVYhP/PeIEbEHm?=
 =?us-ascii?Q?O7lbUtZ4qrNu7gXqazEBaoMHpvRDFH0U3Ndct9GBPtKpu48Oe1+L0kwbxHL9?=
 =?us-ascii?Q?Z/MBaOjT5gOe6v8k+QLjM1Wv7he8LTZHT8q91lK9O+KHU6fYCkC7759/lihM?=
 =?us-ascii?Q?SIAX7GN4Msp+rWf8snWEzu1GTqwYF6BaX534OGEFaRUkLQwhZWTpPelRKK+B?=
 =?us-ascii?Q?JgA/epWivW2HR92xGQ3U0rbVXHLwn49x2O9XigtEVl/XlXgKBliP1OtE4Lcv?=
 =?us-ascii?Q?+b5mTGeDHy3ayDxCWKckE2rNiOet+57cwWrlJcy/VHklS7+7ORZgnh1GuqFf?=
 =?us-ascii?Q?9zQ3bi7oae+dxHwjwjd1P+rdJa9eumiCUJ6kVn3/CMiekFsfqefQUoXzYy2+?=
 =?us-ascii?Q?CDf38zvHeC950pxC9+tSYF9I5tbdZs6eI4IRdBSstUkjemsoiZgZGimRe6Eh?=
 =?us-ascii?Q?mfCUC6PQTd4gaUVe8QLk/yDA3FCQHi8kdRaxnIufoFci7j550n/fAhxMpju8?=
 =?us-ascii?Q?4VFhdBRdKCxbUncMptDoiI//2cTOVPIeAuz4z9hu1z4r6vDfEGaFUMH7Sl1T?=
 =?us-ascii?Q?yTI2lYnrogMITwHAMxgRdQDKCLjnQWy3sMZkdqmJuWZO4ROI3diuN0JNaEOa?=
 =?us-ascii?Q?6ybXl76sRbcw2XH4pIED5bXrha80I16IcCnk4HlFiqLGFz5kj6nVQ+Gwp2yU?=
 =?us-ascii?Q?KajvMv5Hpx4Hz9wnbRi9zHLJkvbSNH8ewU1wGm9QeJv8Tbcvx8aEOvqcD3bI?=
 =?us-ascii?Q?oYD3JtATnNaNAQ+6+/V6XBKLJvheDvvpzV/knJ4P7kUyBT/CABTfeE3zYGoJ?=
 =?us-ascii?Q?yAgDW31ovK3HcYV5Z0LQPlWsGp1vlOKE8XrobaFJh4xg/gqvbRODLmbEPX4c?=
 =?us-ascii?Q?BXzNjd/LHBag3ibLfMzXJc+XnkJOkr5v13ii56gX4f683ZTTYkZGneYsZ3Wi?=
 =?us-ascii?Q?5KEFNZxslIVEczwEduamcX+lgdmqitAEKxpJo93zEaL+3vSxBoKU5iDxbUI0?=
 =?us-ascii?Q?c3beeiZmZhmn6rNC2wwh0P5apGqTTdl02xrGid7y2VeAzbutEZkE+oek3q5d?=
 =?us-ascii?Q?HGhixWrvGeaV4X8MnjuSAMMZXRjBFxNozes4aFOxK+RLL1rz/QlWmGwE1UKe?=
 =?us-ascii?Q?zGvHrSV/99IPagNhNhPGiFSuYUwFBYtTu67B+7KOAeI7BT7HKR5gu5KFj9lP?=
 =?us-ascii?Q?L5E/y0xot8yknUxT8bFT7BU8Ehg69+2zYkNJYhxIizn7xQCZ/P63rc24OgnP?=
 =?us-ascii?Q?NqN3I0LQm13fua+ItFNhBgCfLgcgl7/95h/jAHEJPg6XbDWoJ1/SRG6hQcG2?=
 =?us-ascii?Q?wgFooNmapgJ4NQuyKu6YBO8Lk6l7b7Gkaox+lkJBIix7Nen6z/b2lgaA2gVz?=
 =?us-ascii?Q?3AKeg2ws9RcYy7U7sjO9SJ+rt3NcmL61Ujc/RhTXKnbeLNb0zuGnaH9EjMlB?=
 =?us-ascii?Q?VkHcRvuC3ZB1iI1NlX9vetvpbSLpP4kA2YAF8+3GQMcINrul5Ze7YxxaSwAO?=
 =?us-ascii?Q?ZiKcegAuNo6pe0d03g67uwTeqXrQXhMtkfqvEk/iaujh0GnNgtJqtaw4dbmu?=
 =?us-ascii?Q?QGXkguCb7HkGE55lOmWD670dYI0hJiwhWGEiAtIV/pNfEfy5GW9oaBz78kNL?=
 =?us-ascii?Q?PiP4Ntn0V5eFzO/7ODYvJZIVSjUQrfs8WlLww/V0cTOYTeP/MlzoBLF1t9lX?=
 =?us-ascii?Q?P17t306Fjg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d436bd7-5974-4044-6981-08de4d8d59c9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 01:37:42.6725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/zjM7h7BOwxVIvy+WGFlqjCKGo3qbvilGG3ONr+ouS9BQq2XhHwctEueR083x+LkTsloeIZ61jaZXT3pDm4bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11885
X-Mailman-Approved-At: Wed, 07 Jan 2026 13:39:07 +0100
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

On Sat, Jan 03, 2026 at 10:22:12PM +0100, Francesco Valla wrote:
>One of the two on-board PTN5110 TCPC USB Power Delivery controller on
>the i.MX93 FRDM board shares its interrupt line whith the PCAL6524 power
>controller (GPIO3-27). Since the PTN5110 starts after POR with the
>interrupts enabled, this can lead to an interrupt storm on OS startup if
>only the driver for the PCAL6524 is loaded, because none is servicing
>(and clearing) the interrupt requests from the PTN5110.
>
>Maks and clear all interrupts as part uring board initialization; they
>can be re-enabled later by a proper OS driver if required.
>
>Co-developed-by: Joseph Guo <qijian.guo@nxp.com>
>Signed-off-by: Francesco Valla <francesco@valla.it>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

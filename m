Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA69CD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 10:00:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 345A48464D;
	Wed, 13 May 2026 12:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xvaf6Pzw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A127A8467A; Wed, 13 May 2026 12:00:38 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C871380086
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 12:00:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mylpf3t9WxHMAqHTH7bsVf79K2EmhIkPWPEYyQPcOmThcVHwdMjZgoebIGiqp9D2v5pM5DxULSdF1l4vZWlRtGkhfy/v0xh6BOA1+ThUS0Qrjb+oOIP2DrqQ0wubErv/j5PJFS+Mzfw8QOSXJmC0qBlQxoUPXyGlKt/0aUmMHUx/lyCvZ1y6VG0vhmsqY4rubV4Hcot+zcLZuaZeoAQGRIT3JdPxr7urexpHudd3trQ+kWOzLoqo9KA7HWC/Xqy1zNP/y+Zw1tDDTYKeU229Sd58y/k8M2BYjWJ2yPqD2ZsnDBRJJVGJDAIzx7yoMtokgNmkHXpKYsQVyQg86cF4yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNxxcZgT1JW5gubIcIRwn60jirXx9nx3qjYo5tfPato=;
 b=es+zY4TCmnDg7bglS+U8h4rsScMBRvpEiUAve6cQFHjURdeuV8Zy12d57D9jAUPlbFV38CKJ7eAvlpLCbg/zIRvEWaGFqGfWI6O7wMTiVQ4iLcB6kO76bWM6r9kWKc7h5EjWjsBH6h5z2VyhHCYeQ8I+7CsuzjcCZrvL9cGoKqivpT94umMOEyLJjOf5RFhgAnJHm9V6TGG1ySvvq2g2QG6Ku76z1AdtHF/6yQQXVxNX17H0u/C/WxVZjvbT488oOXnjQ+8D3PBTGe2iJBdC0izjjFgeFm/brAgVzYjS/KC7YyXGeaM2bPQGb1fwA4N3qfYiLBLDAVk04Sn7J2/apw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNxxcZgT1JW5gubIcIRwn60jirXx9nx3qjYo5tfPato=;
 b=xvaf6PzwZ/6SGxdE4b7N0dfzXlXFiZB4Hl7taYnlcyuuCeC+zjKj1eSrWUXxAF1MMxAx2pOlXyE5xHVXUfB3AAgah8l5+WZ3O/d9sk3aVEAhQ+7K7e6nHNZJfxeOt3U93GNcCcK05hxVPnZ2vt+iBbfZ0ZOABdIotMRmW6bSU5MjdO4sW0e32aBjnHUoKKqmE9GHC0xMGrJXhs3o/gRqW17EYpnG3coZa7lp7XyNoLeHDBZy4ScdPF9jCJddLNU5FeU3PZW33kshdDVplPRB5FUYVWfIMZiMuo3KrjRu3Ma0vo1zYIqcBTRMSoswju22pu8LErLThif2egKJNca9tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AM9PR04MB8384.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 10:00:34 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 10:00:34 +0000
Date: Wed, 13 May 2026 18:03:24 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 13/14] power: domain: tegra186: Staticize and constify
 driver ops
Message-ID: <agRMbA/jFU4j0iw0@shlinux89>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
 <20260508122247.512862-13-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508122247.512862-13-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: MA5P287CA0026.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::9) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AM9PR04MB8384:EE_
X-MS-Office365-Filtering-Correlation-Id: f2aa2b2b-f426-443c-b284-08deb0d679df
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|52116014|1800799024|22082099003|18002099003|38350700014|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: 6EgZ+F+GuciQxOkjzgSHk6OxRqrrMsVmBiRL+xEpx7XwAIaGGp3ZeVC316PXDJ8CnMTVCoySuSpaWENyF3J4+Ib2UejBwZ85SaXFwM1NcCID2dnejO7aY+3F64fVq+TullG/qqCeb5nu7DL/2VN5pNSZKcSi+YD/+KzLcMiL3MZL0QxrlkYf2HFXc7YUctNGFslPMZfKJAFesp0JHRv3vY6tSIvkc2DmPYGYC6IiX70MyjE7PRElirRCEek12nAgKa6SgAQ9lgo5JvfjaajaZgul0KkwbEZY1QpYFN0/lcJs03GvKf0UB8uvDxHkcNcx41ujJiaw1q8gHkVgmjHW15urDfU4hGO287+hnN2hYoj5MJgUsSp5JyN4d/LNZUWK4mQnlx28l19TeXnSvxr+19IeYfcHl7KrD2qVtM6oSUHsUkgrm0tptzBOb/D/u/84oegWgMrgvYRc5SrhyIgO42sxcFNR4JdhhPZAWQl4Pm0v/jtyr5BIv97tR+AgOCyMqiMtVIRYGYM3vvfJk2KUmf0yi00Vvif94Kgnt28NTnjLgZiF3OiyagD+HesqRZ6i548l1ifnavo8uTm18Bid8ayBXvVPvNwfrP4yduFhdzhrNha1kJ17axyUlCwWAy546D+TbO91An/R43sfs2q66UsDiFw9+pffcMjQ5lkdoYhZJ/LmizJrcWrkRfnCfHyjBcudbigEgo3p/er8ArS8dpv9xEPRqJqQXeUEpo45vY7H54vriE5FiMj05/2LNfL1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(22082099003)(18002099003)(38350700014)(11063799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T1rzkn2iTTK2yRCmZycWRaYxTX5SDSF5RcaN7g60YlUVf3Gi7Je+sqY1vBah?=
 =?us-ascii?Q?H+f3PsEAp2beG7Io6ouKDGaahaRlmubEEAODmP13Q4MVq/fMJTTN920h3IqK?=
 =?us-ascii?Q?2lOSXw3lvKhCAuKQuq8RzR/fTRcxH9mG3Vtjz8Ecv8yq0qHg0PNZkYu54utT?=
 =?us-ascii?Q?pyfPoWqGYKLszf45nmssfToEbwPkDXF+DxrzsM8iOr7UtPe/MLwl7KyA30qV?=
 =?us-ascii?Q?+lbz77JjhgUIoHTHaRCSu/9tMiFv6HPrnY8RL1hxZuwxg4qGUR54h06Zn7JB?=
 =?us-ascii?Q?wCVSENkNLF0qaaWZvXITwpakj5j0kqUCMd3QBwaaiovJUIII2NN6Iy9Fjb1J?=
 =?us-ascii?Q?NAI/uiz9W0qXQ08snoC7trQld4bF0Y0FLwZrcWkAh/MrT2v/fWKL23EJWqGt?=
 =?us-ascii?Q?uNk9MMXDZy0ECbYvi46lR7RceQpM7YCaEXPwyGlrVu/zj+Tb0DKPDXhFjPmY?=
 =?us-ascii?Q?0kmfKY++zvPM9VTYufSxIjLVY3IMDhRDO/xCHAJ4L14kWWqNl9jS6x4tQCs6?=
 =?us-ascii?Q?+Zds4pb0YJhA7UEGvkLZwAymI5ccfTo7zIs+2ZgWBfhFzwQixMAxbWXJ21C0?=
 =?us-ascii?Q?RzoPJlaEIlqyaC3NhRZfKOjolc+XznvCurPvC3aTUba37U/sQNVBf/0LeJZu?=
 =?us-ascii?Q?YXyoSXyNXQiQyar1GA78UZl+KtrEt6YhCY5++klsZTOrjtVe8pioEmYgYTBC?=
 =?us-ascii?Q?yU6moH17as90jnDX47DbSYzpKmYQFzKicEraFBHEzlRrJyuoBws/UJO9creY?=
 =?us-ascii?Q?xms/CSz986v1T8c9Qqw1wf0ZEVoUqZMdQd1J0r92O3+8K2dPoCcWHrp0EdAy?=
 =?us-ascii?Q?hfRqe7xifce2QCMK3O4plo7ZifhaUzmRwQDqgJQoGAlkCGdVp9p3mBzG0n3o?=
 =?us-ascii?Q?VRFuDC4e5plebiBWOWSJRDnWxatAgfcBq3R32aNTMcDcIt5ZnFT8xvV39v01?=
 =?us-ascii?Q?HSEU666QwsvtslhYvcA+szaxgGLwRgUaXPxyWOOF8ZWIgEi8R8VL+iRmSm7T?=
 =?us-ascii?Q?8i6bXM5UZhM8d05POBb9C+uWybXVfGjqQCSv//2CZ9jRTdartZUa3ItYfWEK?=
 =?us-ascii?Q?ww4zXJgQuiGRxXFlSObSsroaZVMI5QPE6x4MZzouKqEwYERobCNBY3SBFeN7?=
 =?us-ascii?Q?IgCCGBlZg/cPNzIi9P1cTk22BiUnu+NtN4MuvGQEEFDrR5x/NwYfpHKc5luG?=
 =?us-ascii?Q?VKQSL+G+V+VQISh6HI3tcLqxJTqrN2lCNcCeKlGfBJZ7M4PPJl1b6XP8kn1C?=
 =?us-ascii?Q?OqJZdRdzkJKkn3ygHbMt+heWkWIfxt98C88H5BPLrQIbBsEso+QxLOHiWsDx?=
 =?us-ascii?Q?LWkxONBzAgzZ/klrb/bVAkrxcPtNaoIM0gihI1HIQCvX9ZjePtuJqUWNZbBb?=
 =?us-ascii?Q?yuOL/UgYdBRrblCen6SQ/XhFUcPNO79v+XQbSpQCgjfv5yAKCGiHDfsOEbLv?=
 =?us-ascii?Q?N/EfrMFKxBYjQioR12WyuZQVCPiX8J853bmxpkLsPYWh/Slbn1nnq4CHJ2n8?=
 =?us-ascii?Q?8+wKIGToAd4h8iewRq6+MTTRbX+O9MQvrOvKgfjy2fjfxaz4+cyGXoOJ73ez?=
 =?us-ascii?Q?U1iYdZ98vLD2YJG6/Bxsmw9MWEKmD2L9i8SiyQ64YUrqTcTdmS5TR0Ffj6mU?=
 =?us-ascii?Q?bWdCN0MuhcHyF1vM6gAFWe8wdAcMABaFT/AAG0bTHw5qb40sRcCAhdwLAreD?=
 =?us-ascii?Q?bs7lftXeSru8vKcGBkyyZ1IFJ8sCtlZtzKtA5x/UjQ8SuR86QscBrxC+mlA/?=
 =?us-ascii?Q?tnaPQbzvlQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2aa2b2b-f426-443c-b284-08deb0d679df
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:00:34.8442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJd2GvmsIKPhzweCXagT4wLVy+hZ66HnyAM14JnOXWrwFkd5Mw94WM/anqQBpf/mhVSInc70dJQQS7eUCBiLnw==
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

On Fri, May 08, 2026 at 02:22:13PM +0200, Marek Vasut wrote:
>Set the ops structure as static const. The structure is not accessible
>from outside of this driver and is not going to be modified at runtime.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C319C43327
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 07:34:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2802D84A26;
	Wed,  1 Jul 2026 09:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PxrpUA3p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C07A84B41; Wed,  1 Jul 2026 09:34:20 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DF4B84A1D
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 09:34:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgB/uteWSNRF77HcdNysYQqctqYYGU/8txg4ftfnjpzLbU0r8D05it7cT1qYFlZ7LWqglAfqCl5+JbHnCVxfiBtyQv4CIm6Hvp8KW1p6WolEiPIfPEZ4/Nali/F3JjB8Lu/XbApk8XhikaaR4Y2iLZqT86IvbLZuRv0gF5w7AlkPP/gTvCyUmvbbniIm/fl+pYqiVkyP4NynVFMFD7dG8qqcPDh0pDxc1uFDQsLm0RUWG1xDiZA6aXOdYPEwW3D5tmq2OE4D1WTVm3H5sxyxAy51G4Ls2H1D/Yv/LjYy2IOqcHwYGXC7iacFjm6WJpDm04mVIyXHkrxGyiYik8tI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGdvFr+KsAnQ18yoR/STlbU3HZ2Oi6SNYno9cpaQtXI=;
 b=kQ2134JafNxTJ94bQQqGp0dzMjTog0rM7DTNHK7WCEJ3f3PZaJrKbHP7vgn8WXcnTV4vzJcXcUOlkfmgZh8tF8UnEsqTKQZ7mQC0nRugwdaefTnljdMI7JImWfIYZYEiar8UPjevtDAUryscf741WgKrqGm33RP3KnUQybBgMEObV+k1BpYip9eed54aY4vhbwlIEfyU7Wbsd7fG7Bc0Yg43Wo2+MXv58PQi4gbuNaeX7/Zhk2EvyF6/4x+SHNas5q8hJNHNNGss2jftGz75UrBetPklWiRqBKasQ26h0hFn6LjuI0Qrnq8d5UJlMpul59cTslP3zYXydignuZD1JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGdvFr+KsAnQ18yoR/STlbU3HZ2Oi6SNYno9cpaQtXI=;
 b=PxrpUA3pYufSOUA90j4qSpkyH7PLWU100HoXEN26ut0fzUMRYH+4JDEkqnexEIun43MWWI+uep98vG3/TKv6dNOicgJ4VrPFtDAkENQ6r6LpWvF1XrsOcTeBfYINxSAJSoB0yRtEiDsWO63dGKPy93qcdATDhMWznIegbGF8AY8Nh2lVct3wy4/dOQA3r6RUEeAnlNQm4bU41QvXu2Kt6RXDHG8XqtB6JupI8HMTcftTNa42pTM3NcBj1XXevs35HeZzVZXOW1wkKb1Ep4sIZXjVB17AcRQQ7HE0n32pvluyx67zuRbdb7rXk3yMsCk2fYz6gQmxJz6KFOzn8Zcbaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB8751.eurprd04.prod.outlook.com (2603:10a6:102:20d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 07:34:14 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Wed, 1 Jul 2026
 07:34:08 +0000
Date: Wed, 1 Jul 2026 15:37:32 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: Re: [PATCH v2 3/3] arm64: dts: imx8mn: Drop nxp,fspi-header-filename
Message-ID: <akTDvBNlX6EN1jbO@shlinux89>
References: <20260630084112.13259-1-marex@nabladev.com>
 <20260630084112.13259-3-marex@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630084112.13259-3-marex@nabladev.com>
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB8751:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a3aa01-5edf-4cc3-967d-08ded74322b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|23010399003|376014|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GzDQuYNQVbvYNibIbOwh9Kvt/eg5RnIEv61a+q6SH9OqzGtJX6UyhvEc4xR3v+s/Cjv1mMRhsttrep/8BiU+ZcYX8yyEEUf0PXvs9bFHziINM2BZ6s0gT4IHZzTZnGzLga8gYPqw92iNkLzAUcK98ZxRsYz2JcahhwD1n3GqcN/FirDkJaFj85rDiS2x8xyMphMjAlGmSzTIPxLKSvn2s56axzVayXBoIIew1np9HOEESGv+TyObptYylgs6Tr7F10pPQFxkqna+IWdi+7ecYWJx9DbS+Iqralfk5mH6bBz5tquwOYkDhAQWZQ6OMvnburQFjMqUPcKDmvJ5T939hbktrftdt/v7FV2Ua0yyCXDeRTtZxvUsyA2JQuE/pNstAuJ0vMIlmWJuK0TCWGfyR+o0/NMK3M9f5lNMkHgttjJcIkHJgmfrkD3Git6mIXg8LD64zvtWCjTxoBchrF3JhVknixKe8n5ED+iyrHSuYeY+sG1ZENvEzK3aklWfqrfaYHbq2jr91bM/K4E6mSI/E1/L0xGj5mi1gHK6sYo8SEG7ZYqO5llky8FpvKstwnu1nGkL9xAo5owPoqjdiyjx8N3zHKcogH3sRB1wlAuI/UU9N0Zv93RdZ35+OcptltTK99+QRmCZsL1GjzVQ5CborcI2AlfPXffOaZTjmNNKeQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8bbjNDirEY+InNo3LFuGhdk3dDlx9adtZ1ngwLSfKJ4m5FtgH3dZ7XqV/AtN?=
 =?us-ascii?Q?2VX7xxIsKvz3iQZD/MEbNrzdA+FX7KGOQxKSTPGCOApbBbyaszvlpG6RTN01?=
 =?us-ascii?Q?y9+pyrbqZqXLRzqK5RP413MVKiqiCX9D+WIT1FS10lJ3HomnB28D7c+pxBc8?=
 =?us-ascii?Q?iPWbGzbhTYiM9Hr5qVIg6WXF2uddoaS0w4/48IFhHtIUYYJNRb9mSduFLJFF?=
 =?us-ascii?Q?9SRYNMoy7fENUpdnzCTNcQoGOpUz3OHdZURXnNht+Pzxa9sGYI54rlAdHw/J?=
 =?us-ascii?Q?bI5PBNs2cm0vVWG6KjzAYiLO1uPhyhOUTq4+tbb7aNcvCNYwmPFSUJQ3mbsh?=
 =?us-ascii?Q?fw6T/PlBoXaXc1Nza5HkyfOHR1ojKZ3OVR9T1SEJwmRbd9SsIBp2GeuGNi9m?=
 =?us-ascii?Q?Wd60uuMMBdTRz71A1Aox2MUaNIFqQkom7VXB9Gd+NT3PbZMQ0aTxxoWSveP1?=
 =?us-ascii?Q?Z6FhPBfKSXcqJmMGzr0YMvkNRFlY+uAaT9i0zrTmEjqI3R2+BnzmqPkvdXN/?=
 =?us-ascii?Q?RPH7GPhp4GUHdzvPuKS1mcuWP615Qk3/570m6ib5vBBXLxBDu5mifkHzDGq3?=
 =?us-ascii?Q?yxTcsjppM5yljDr2RKSAlc60dQjzPvIY0Xrp8BsUFRpEARQGWlSWWjEIxnkN?=
 =?us-ascii?Q?BkqZUwOxzI4697qKg+C0c3GCn/WeedHjoGSS0bGALCvMVQXUVWetOS+aHVh0?=
 =?us-ascii?Q?iMdzHkSq1JTfHjoxGW0N2S7NGrTddkAs56MngQrTTScJAQQM7fmrPk3pHluC?=
 =?us-ascii?Q?uI3htlcfnpj92TULARBtaXxPjINQ91C1oTJ00bRxSB0fpEdgBG2UmVHK41yK?=
 =?us-ascii?Q?RfzwND3qHpcODPVbrShD2Ft77Pahk4f+3yCZ8YsSdK15rB5jbQFnmZp3L+x2?=
 =?us-ascii?Q?U46TLuecHzRoC1uF3F07KUJIATJKv5zXULz2b0UE0CufflkMMWm9p0dYvS83?=
 =?us-ascii?Q?kx6jaFfTi5aIWbTrnSJdLDpR69EsxKjv/Eu2CMOy57IXGdHcx+y6Ut4HvRg2?=
 =?us-ascii?Q?jJl91iFlDn+rEWy9isC0fy7ORitDuPNgDgl74yL5cWCVKHIB3p83L1z1INba?=
 =?us-ascii?Q?YNvwmiayoCzi/QaysgbVXkHRzTSDALAt3vaYT0+R7W2RGG2Vx8JV27q8b2lE?=
 =?us-ascii?Q?Bt8PU42Y3SBxzi+Zhzf7VcKrlAreh+U2GcDz7Kp+TjgYKaCGzkU3CmvfXd7m?=
 =?us-ascii?Q?RXmTysPO24Xz0GfscEBH8+vI1ZGYTjqo2dQhoAII4argHiTFRc425yUoHpQF?=
 =?us-ascii?Q?84hXGkkJoctDICU2yyYYkXDcHq+cSlf3TUqreNZMGJQovSCfPGDToZwVQJ/h?=
 =?us-ascii?Q?cAzmoQuDzSuaePoJ3rsF7ExLmMqSwvm1X7iSAvorR6R2zZYD8ESI5iuKZXOq?=
 =?us-ascii?Q?UgBRbjoZhaZmqDQGxrMyxcbXRvyzg8z6cPsc7+WlApnZZAfC76jlgCgbz6TG?=
 =?us-ascii?Q?DS0c6/8upTJJmQbmjCpPrcwwmhxzsaVQygAWgKn5ldZ3314OPbkkA3KN0qRE?=
 =?us-ascii?Q?S4ekAeoa6kT2Ab+8m4fRO3HGFn3uBKhGRBQeiBl0dmjLd7H1DSoTjgGXZMOn?=
 =?us-ascii?Q?v7BhBb5W+7bFFSLgdAbE/00mr7D03vtVsOu2dSOwQVHDxlh/u9+/644AqXdH?=
 =?us-ascii?Q?bg9lzXoO5Y2+PYNANn0rnLmKnNK26MnJjjAiqgCjSVC/NVVGW3uF81QhJeyf?=
 =?us-ascii?Q?0LNN+Wwg11HrRJcqzzLC6LfMlNFAmgSM2DUt5dmi6Ik62Uu54vhTyYLII45F?=
 =?us-ascii?Q?9802NKcEJp48d9sxtfYzpBleTHxmDyl7jpfSI3/AkEa7NzhngBqT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a3aa01-5edf-4cc3-967d-08ded74322b7
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:34:07.9496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8b1/uHYh63dRxN02wuxroycdtMYhOfdFRp+Y/Rnbd18/5bT9qepRBAIJoqn8uz7wWeL8qg06IdS4hWl5q8dxLb2SVDZlKNePi3wr+FWXoeq5OIZqPHqf6N6WnVbylJpk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8751
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

On Tue, Jun 30, 2026 at 10:40:48AM +0200, Marek Vasut wrote:
>The FSPI header is now generated purely using binman, drop no longer
>supported nxp,fspi-header-filename property.
>
>Signed-off-by: Marek Vasut <marex@nabladev.com>

Acked-by: Peng Fan <peng.fan@nxp.com>

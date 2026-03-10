Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B80BFCC9DB
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 08:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C095483981;
	Tue, 10 Mar 2026 09:32:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="azFT6AXV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B56783F75; Tue, 10 Mar 2026 09:32:09 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E97FA83952
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 09:32:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vladimir.oltean@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOHkMkCiy62Ah2k1v472TWXSikflLcZ+LLJSZpXNPgqDWqHadsKncz0n9pBD+ZXFDUGUTWmlkiV59Kz+n7VDZG1tp1hZk8CDJUGRkGKql3xE6Gulf21CYbST4U66c48dEP5hwXxM6aaUv3r0pyfrYS6ChU0xyKb1VYqZPhKQ4a2J2czgOrjALH+ftG5+H1vtWNk12W4hk5uvPSKQm3t6v6deBm8ST1kfqMaEYkpNabwEiz55Dee60svZbChEQyPyYRSzG7XJJsMX0MQ71uAwq4bikFoDJPve7FeY5XCDQyHpEA4aQ7nk+YV7uM5uJSnUCk5nCsUuoUPVYL1JmgTXPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24VdoDBi24UHnZ37AwOvIknb13BolDq397g0c0TfSV8=;
 b=B9kJfd+x66UD9EUTe84kUUWDp8/ZmfDGwDs1CnNNfYSx6Uv/43O4JLmiSFDz5FLUXk6z4kiSd4VN35DWBF59UpPGbwWK5bPj4G+4fddhPUjqcNyvIOFgPbESDrnLzIGavvNkShGi9TPNUxZWUCVrXcsVoUr2PRvy79SX58lRNGZ4cBFVznYF82l8HBAEAXrpqOh39ldBXBPYh1D+beNosLnHJNdldndAMhAvMGfpCCcx8gimo0+aRn8MZ+aREtqTR2S6wmdEfhhDjKPQs/LURzWYpzERMgsyXNn7POqFCdyGXE/wgRauX+1xTl05vdf/aGfwC1zGLuPepM7qqk8CPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24VdoDBi24UHnZ37AwOvIknb13BolDq397g0c0TfSV8=;
 b=azFT6AXVvRR4vJ5b+9FvVnK/9qN8kCydtDYsrEagpkZIHwKeQs0Py/OeTixYBuHtPJIjAAIOrB+mzFWuGPIYhP7MMqGK48UlxWVkLuO9uXd3eWW76hHSgEpspxxG7gG1Jp2441idoJ2qXIFmwgS18GquzcedPGGtaVyT0p0TIF0IcX80gXjPjIE8OwYe0WHmVbf1Zar0x/jnQzjNDH8f+QWlPA6W6Ic9D+RCqjFlZhf37eIXDJwPy/jCvdd68oPrmh9k9z3j5XvaMIOJFBfOgRmKJFseAefm05fSvHTSrS8HAHiiI5aRLTWCc0friPDctErMNGpU0nzQPn1Dl8ILPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI0PR04MB12135.eurprd04.prod.outlook.com (2603:10a6:800:324::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 08:32:04 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Tue, 10 Mar 2026
 08:32:04 +0000
Date: Tue, 10 Mar 2026 10:32:00 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org, ericwouds@gmail.com,
 kabel@kernel.org, frank-w@public-files.de, daniel@makrotopia.org,
 ansuelsmth@gmail.com, mkorpershoek@kernel.org,
 skylake.huang@mediatek.com, tommy.shih@airoha.com,
 lucien.jheng@airoha.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/2] phy: add common PHY properties support
Message-ID: <20260310083200.cbcedg4gj5jlgqso@skbuf>
References: <20260308140614.50489-1-lucienzx159@gmail.com>
 <20260308140614.50489-2-lucienzx159@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308140614.50489-2-lucienzx159@gmail.com>
X-ClientProxiedBy: WA2P291CA0028.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::23) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI0PR04MB12135:EE_
X-MS-Office365-Filtering-Correlation-Id: bd25d2e3-31f2-4252-c9eb-08de7e7f81e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|7416014|376014|366016|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: gadMIWTXd3sNQUa1UFxCMy9DGGtztp5mKr99KiFeMo2TuD8+a3AGxWF0fMyqKs09xmNnWiGfFiUM+LkQiViN1zZLIUksHLs+URHMrdH94RrO71KjWqBJ+fzWJV+6yzJCm0MZWKuvS+XoU1yn/hGK/uAdDNkV8u7C65KirMzfyVReXPTBANhk0GvIbgPUEGxZNWjqgY2Isn8OyVoH5sy0XZTCyWBWsQx+gk3xHxxM1X41EXl6U69xefCGmgh6SmWm/gdMH3aBABvzhHSTNg6EeK+Z9vo3PSMvvnk5n+G/fONNY2C8lhPxZG4dv4EhnSD2Wgb73t7pb0KxF3SroblggAFxLZ06i6i288bY2zFY2CfU0nwhloGhSjrSnVPdppLzqxRt/7hHKarHZ6+m7bXUwpxrWjKaoyvfQjw/EJ1FfKRz8kJMRUbjPMjQ/GLTttRL0KmY49FX8DWGlDum49MrVrPKA+R5IZ9RbtWL7Z+j0A90CsCvozSiOmMxG6NYuVVb96I02R4ZQgoihVb9unxPfmY9BacNPJs8zBvppsH26t/ARQcEUndFc5AVY3XhG+uy/VX9GHwl6cYRnpXpNbSODywYSmhRPVTNtbTkrxRLnzcnMCA+LumjlCts9fccWpzaD1GLq0TlQt8AcgAlzY3NyLnJRrXkL8xXggNSoriiqq/x+/Of8+C45tQFc+qOU0PJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8585.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(7416014)(376014)(366016)(10070799003)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Az9/cC4qKUfrV1ombVaU12nJ6GhwetT6btDqNEv/ebI+FjQafW62h6Q/bV4w?=
 =?us-ascii?Q?ZspWlFK2QZ2NJVnGD7Iq/TZXBMoBjoHnyrLfMfw1IFeBTMXTaHmNp5u9idDH?=
 =?us-ascii?Q?Ozz2RcdzizPmNBs8nS5cOd5ioozG0bN73/mcMgddo4uETzTqweFnJ3lzPceL?=
 =?us-ascii?Q?thBJ0zlDDtBMQIz8mp/xc8H7ufQuclQk7F+5TD22hgKedzrwVlU5BkitWjy1?=
 =?us-ascii?Q?9NXXw1ukXEtsVubrVhHsluse123PUa6dl8nHHlTTHBF9Nam2Tfcj4CvXt4la?=
 =?us-ascii?Q?mcQ2H0206OmPfyUUi0CTXTJVZubvHEKl5qfL3whAMfA0M+RdfCWQyO429UEY?=
 =?us-ascii?Q?gvqW1PRBcwnNAn6W693h8LoCrPZXX5mDDu730Zv3zuqVGgSY6fZ96wXvi1b3?=
 =?us-ascii?Q?T/BsN5w35LHc2WFgiWcPQu5wZ8UM0PZKW7M2ElpqZcwqQlC5BeYlXpyHYbgE?=
 =?us-ascii?Q?DNKG1P0aaA6t3KYCZy5MhBuht20wJyYmNwpp0W36gxkCs/b5TvpEf1FpweT/?=
 =?us-ascii?Q?fRoZNjkM8K+oiEjgg4vtw9j/aes6fw+q2hsFjuPGqkONRw58ToAxmu2pE3fw?=
 =?us-ascii?Q?ojZEdMNHE0loNKRX0Tm/shOhuF2RWGa8zZzXjJ96knnHrLoKtJUKXJMq3SZq?=
 =?us-ascii?Q?5RtW6G16EO11GhLOcpINDiWaiH6Pg/Nd/tHQTwr42G5cleb0VAou0AsiY73m?=
 =?us-ascii?Q?VxDxvFH+Q4iSKnLTWqoGTaSMxcbIg9i2QvoVzs8J15Gq9CO5Sbw0hSKpugMJ?=
 =?us-ascii?Q?l5o834iHjfEpLq813Wd6E1xu7E7X6ogC80E0ZF6dHJX1EZiexYNiA1FZuBYw?=
 =?us-ascii?Q?gXX0spsk0bPY4vgLlWU0FhcVQqfLYf/J6kN/iDvGt67pMWCZaixqioepRQUS?=
 =?us-ascii?Q?Qls0PuHtzbNCCzWQEwo1mH6+CvyaZl+pI+U2aru5JpN2YR2X1nH9Q0XkA03X?=
 =?us-ascii?Q?TXe99e3VdhrXGOd/MEIrzAr8HtjkDyExsokFh4yk8NNzD5It/rG9sl/4qw54?=
 =?us-ascii?Q?RAMKrCZ9pHbvIq3RvkuI91hO06AV/qb4+hUFytyUVjQwhRHCGd237yMdwv7z?=
 =?us-ascii?Q?MsYeWj2H+hCi/WIUXFLOQSvaTlO06z9d0Y1EB8ZAzWmCdMrrR1NMqndpfYya?=
 =?us-ascii?Q?D+naC1tV1vDvcWjgT/0F+z0D64UqkguVdDp/WH5dT6Gu06oPGNzll7MfLKr8?=
 =?us-ascii?Q?ZWr21Nw1//DDT2Bf06e1GfOiV5cUzsZU1FFHpgjSQpGZ6rS8xGfH7nQIL3s5?=
 =?us-ascii?Q?3xX8rGhFt6bYnIREpoHru4/XtZTrU7gFubgtF/nczFAFFhGw1SsCf1Dygg0y?=
 =?us-ascii?Q?9a6xacPIMHbxIW9JT6kRYZnCmCF+Wiz7ffJr356TYubS/N/N69qwx/rIZmbb?=
 =?us-ascii?Q?D5ex0ac973Mz0sz2QKpGfk+aH1Mq50VgVIaj1K4McK8DWnjdvsBsQmH4tT5u?=
 =?us-ascii?Q?6or/8/Ama+9yj7p1FfNFDdZfBs5EH1ih5Vq4GYu/WgCs+QGkihTyqn/78DMR?=
 =?us-ascii?Q?Kb/+dkw7avIBUYB4U1PW9MauYj8xHf2yQpEezdLNfyAKt9+oAQODYGMfoTo7?=
 =?us-ascii?Q?caUulphfeqRVEYBkpAIlcpRF6tauH7iNVmWrNer57nsTJxkFy0958fxFiAPJ?=
 =?us-ascii?Q?/MIjXUrOAyGZgJ8pg4En0in+cUB2Dp3zKAaLLEIWNj1z4fxMljmwevc9Afay?=
 =?us-ascii?Q?D8Z2z3Yl7O6ysc0/wuticXTgO7IzSV/Ogo9tdsXiUBjmBYJyEFzZtYoJNpf1?=
 =?us-ascii?Q?rmFaPqic72FD2h48pO/ih+nwXkR/ToJH+Uaz07Han29ut6ui3ZpF5lBQ/+hp?=
X-MS-Exchange-AntiSpam-MessageData-1: 9HGGF1nDt/lJwpwheXLR7TP8Sy+U7te//WU=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd25d2e3-31f2-4252-c9eb-08de7e7f81e7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 08:32:04.1854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0b4MXpEiadSkGXwEa4ZrRZgyxyoFbGQIOauHc9XTfJBSfchTdYqXNRlkdZbmnFDV3NDKV/RkS0561tn6Fkh4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12135
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

On Sun, Mar 08, 2026 at 10:06:13PM +0800, Lucien.Jheng wrote:
> Add a new PHY_COMMON_PROPS library that provides helper functions for
> PHY drivers to read standardized polarity properties from the device
> tree node:
> 
>   - phy_get_rx_polarity() / phy_get_tx_polarity()
>   - phy_get_manual_rx_polarity() / phy_get_manual_tx_polarity()
> 
> The dt-bindings/phy/phy.h header with PHY_POL_NORMAL, PHY_POL_INVERT,
> and PHY_POL_AUTO constants is provided via dts/upstream/include, which
> is already in the build include path.
> 
> Ported from Merge tag 'phy-for-7.0':
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy
> 
> Link: https://git.kernel.org/linus/e7556b59ba65179612bce3fa56bb53d1b4fb20db
> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
> ---
>  drivers/phy/Kconfig                  |   8 +
>  drivers/phy/Makefile                 |   1 +
>  drivers/phy/phy-common-props.c       | 286 +++++++++++++++++++++++++++
>  include/linux/phy/phy-common-props.h |  70 +++++++
>  4 files changed, 365 insertions(+)
>  create mode 100644 drivers/phy/phy-common-props.c
>  create mode 100644 include/linux/phy/phy-common-props.h

Thanks for doing this. Do you think you can also port the KUnit tests to
U-Boot's own "ut" test framework? Should be testable with the sandbox.

export KBUILD_OUTPUT=output-sandbox
make sandbox_defconfig NO_SDL=1
make -j 8 NO_SDL=1
$KBUILD_OUTPUT/u-boot -d $KBUILD_OUTPUT/arch/sandbox/dts/test.dtb
ut phy # or phy_common_props for the new code

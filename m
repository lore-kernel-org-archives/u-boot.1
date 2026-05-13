Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006BFCD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 10:00:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E98698469A;
	Wed, 13 May 2026 12:00:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BB75DPnR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D11288469F; Wed, 13 May 2026 12:00:20 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E3A880086
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 12:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E604WjSKFR8cUxI1BcPqzvkF5SBGnpqetgJE9vOqAUuWZGqqxUc8PDJtOpKUYSAHyMH9bEnw4Orapm3rnpySe6+Ys2sfSNmlyTfXkSVQYNiUMJ5aqQpYEF6m70OlR6H/t/zLYR2G47KiXw1IVu5L47xSdTE7+XU5lb7yFxT81cPpwjQbNEcbqhh+zG1BYbBoS2qGvBZ01U9XqFkzB3aZEzcCVKtWq9IctXHzgLFxX6pmpoXwa6ozbLfQS05ryFzcaSQgRn8k1f2Dz0to0yExgEIIartihYtrnCi4m1+slPLWDrBhWyQdp6Ma9OQ2nbm+9Tl+HbD3xY6G1XlNr1NMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JJ4eOxJpleTUcUQdg3s4p+2s92KFSILBlaIuVSZ63k=;
 b=BRfxod8FgLQOTR7TpJuFczAGzOEy8BuNe0AHCgBItR42xlVQ0mPxBNWXMKrPiOLGyIbjieWX7b1benhxR8c371Gtt05If/QvqTes1w4CXYSu9ZWGi29R1hIif9KfHeAlm3Zvn7EVgwCpwXDh+h/g4DJBAjXcO+Puh/9tfyVuS1Cdi/Khj80qmeUybqO/GDU8RRfirQDYRymug/1U7uoC4UOj83ViMR/BqET+hmsePlzAnoBWjib4/BF1qOv055JaJhKRbSNM6FfnLI9dtCrwpFopfIYK6HpRB9/pkhJhho8maVYfGdRF1ypsXzBDSMWh0PrA377/6xNHccPk787XYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JJ4eOxJpleTUcUQdg3s4p+2s92KFSILBlaIuVSZ63k=;
 b=BB75DPnR26XmYS4e0lfGXs3H7gko7gKTnl0I18o4Apynm5dRjah9L+oDqQM2ZZre6LMBaXGqgQsSg0Px/2SBdS22FwLAzdf1cxHk0aFrTfO8dwMAiMmaYlmped1gk1IVbUNaE4kViIwFokzul9KjIA7ndwduoMo0HZNg9r7adjDFoWCTVucoFka/lZ2xGWqlE0yunmXRwl3X0BRNns4VHgLEViXwk2ht4wRjTtTo8AI8V5qbpXZMAldRyzi/RIl7p1PnTE19o5KMExhTNu1vPaNQFiO8TvpG/Y2sGZXOdkCZUnoBcSTHFaew6YGgZu2oH3JdF/K2BUD9RLSbQ6bZ8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PAXPR04MB8476.eurprd04.prod.outlook.com (2603:10a6:102:1df::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 10:00:17 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 10:00:17 +0000
Date: Wed, 13 May 2026 18:03:06 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 12/14] power: domain: scmi: Staticize and constify driver
 ops
Message-ID: <agRMWoj3aj/xEpoa@shlinux89>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
 <20260508122247.512862-12-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508122247.512862-12-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: MA5P287CA0085.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::19) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PAXPR04MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: d377cf3d-d2bd-43c1-f9b8-08deb0d66f63
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: aiZR+9Rzix4SesK/GHPsq0MHBOmsrWj6cSsCtmBvNqPB1fD20MqefCkCfbV6ntAQfDas6KtL8BSftT1An26zbesJn3aSk6FoEOAit04SrcgjxqXnssQfA0U2tAs8XqIRa27HCY8UNNsjfpA4L2aJU25kpHz/+tKANIQeDPt6q/gAN7+Doo3H7vVAvLmKuzigEi68gHDAJccp4yeENfp2DxAqqH3ahpTY3SlQvLYLYGXVJh/JTyoslKd5J81AjANJ5aRYkmnOfb9V2ktEERp3BqEBegMSDBu6RCdwfHjspokEcH8RMZVMCCfFZm01HF/+f2l3twSqkRu6Qc8i+Uv5/8BCCQQiyHoBZxbwlWHg5Yt8V9PQURWUOTMrDxFvJMhwjB77IiXfnWwEUMNjHGv1Rk5mu/pdG3DTzTWCJJW/qVZIw8bG2fRUYRPrhcho4KCXWUhR3feWFtyx+gWSpajI6mWfYCLCrsZFSAksZGO2ksM5mZoGDGb8eYwoJTnEv0Uc5QjhE7JjyZcZTWJTctWKIha9EQa6TKDQ7u0+vxEKc/lK/9TR7+OwH+uyHdjl+LwrRSddvedtA+8aTjcpOwj13FsFrFWR8r/M69xh6+EEAr+WH9jADj9LbstDW6TxN5CihONYOmPy7vqec/uCu+DDtn5NfWvPtMuKzXL0vCX0aJYxy+uEPA393SIJdt0nJCe85ADkEdCPuSApy8rDhtezSiV/aVrAYCB4TH3v7UiSGz5uz+l8lIQmn2WLfSX+6PAb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014)(22082099003)(56012099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6APA+vekLYuR4Ko4Egrc9RkMZ2rRK6m7E2YnOyjhkRbDlyHBhhcyjezGSCVu?=
 =?us-ascii?Q?BLQyZdZffhdhQcGbLsjJvdQn1p02wcfsT5O2HeUkO7Z7qrzdI3voziAQcxmp?=
 =?us-ascii?Q?CD4BcnyUpcXEeckGanngpk4qXxhJMXFOgoGkNn6zkLlGF4KHRkkP6/n/NkNw?=
 =?us-ascii?Q?etn96eKKxRaaVUnVkDTWPF2vx3uHM1MZSR48hJ7NRctOwDLQAJ6p+PM0Ljwo?=
 =?us-ascii?Q?4BKmzW1qVZBPdgahZfH1U1AurIOgmEYVzj8O6HIrrvkIiEHitYvnZARqKBoU?=
 =?us-ascii?Q?Ho6YC9k0ngjApKkWWcjmQCVI6XQi+MBqR0X6vvTRLfGohBufxAm37hJ35YKP?=
 =?us-ascii?Q?GJGst9olRXQFHqBvrf9byElhUTotXkbE21k10COoMauIag9hjf0AGc6UT2vy?=
 =?us-ascii?Q?5zDlnNMi8vaP6LuCqpldVYIVJheIpBUWSWDgSrc0rnjCe43ZdBfQgqFuHj9f?=
 =?us-ascii?Q?beR3aBf6E25wiAyXcsC4ZaR9dtacjN9qIwLFI9NvigXVPnEBHKTQWU3z5n2h?=
 =?us-ascii?Q?yYe4fEH2K+v9GNYhW1LH/eAYCDAE8qDu4fRXkt937+Ky7Fz3gYX/SRJoIDlF?=
 =?us-ascii?Q?NWg2arEw8wYdKyNYJMp2iTe4KZpZqILTaccrVQPQSrd1XmpQUO2eki/mxp7S?=
 =?us-ascii?Q?6Vv7SAXrnTUy31QETCzQrMfo63VmP5EqhVlwxQqVMmRpy87k2C+dOEnCPxNg?=
 =?us-ascii?Q?xDZpY+LFiI4s8/NrXZ0ndJvdV8kt72fbr/KXxhfuIfgTg6uLyYw8PfJley2F?=
 =?us-ascii?Q?YenWGjOKhWI9fp55UmBZrTZWXmTICB3P4s9nect8+jki2gEPz/Gzkc6E7ThI?=
 =?us-ascii?Q?cM0xlX7yjY1yC4//YvM003/vZYvncpKZphES/lg5g0D672p8n1kp9RVbNa2/?=
 =?us-ascii?Q?LyBLYmnFIA4NKzNJRbr7RZOKEqmJjzayJM70sfi0Pbi0Uw/S28/TDbo1qMUS?=
 =?us-ascii?Q?RXAgzCCqeNBTrnYzgri4CUHxD+aPx9BVjBUj+/CCDclSBRa+QSGjQ1CvHEcq?=
 =?us-ascii?Q?f+LcyWfetLNvjEDtmIoF4gt4WaQa0f8WAm/djhQnxRX0D2D5eXoHYR+PfvFa?=
 =?us-ascii?Q?2er7jQA8Rw0gA63kyVG/gwc1dk2qpEs7Hab5RyGfnH1sffwvP9577fklnK6s?=
 =?us-ascii?Q?Vazv6KGPQ04QeK0AQE5nzabRYuv9DcyapI0axGzRGuKcxlaCaYMqIGIgRApt?=
 =?us-ascii?Q?C0QKaOpHEHGGtBsjA452FLM5HgJLDTPvlM2E+QmVLX2fyC7+xuFOsCM5N/wR?=
 =?us-ascii?Q?A5cLn0w4T5aMX3Bsvel8XHOyZ/OAnKGdkKOI/17cdFjmQOpWIqXharF9PXbO?=
 =?us-ascii?Q?uBfUQP14cIjrW+k11LlLG4e4xujTow30U4FeI/KboXgrPrwMSSaOhOUSezle?=
 =?us-ascii?Q?MLGZ8G08ziYeQCe7yABUBKQdVhxZXPOT+xiQhe9aITK9zMneYpE3M3QiN0t/?=
 =?us-ascii?Q?SilZ1UQKvCZc2FEf/FK0DdsKdTl8uw+FOrqKNaMOOhYDMyCwCzBXpjjLxZgT?=
 =?us-ascii?Q?TW1CnIF9uuwinV7hTALbe3/HECUJxZ7MNYW52+WXWX9+zQn3Uvd+bm6NSn6x?=
 =?us-ascii?Q?A41pAkFLOMOMbwnzbhIt36/Ul6qga0MWUgk9dJFV8oIdCCh9t0f5Kffg390j?=
 =?us-ascii?Q?dF4+nsbF8SvIcvn20yvcUKG4peExhV7zk0Ddp7CjJPk34G/bm0HbcbJ6eBMU?=
 =?us-ascii?Q?x/RUa2P7fI5FGObrbPtJwQEn+gTwB3wXg8Q8yMP7oN4qvuRZHPcXrALjkFDT?=
 =?us-ascii?Q?b/57qOA5Xw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d377cf3d-d2bd-43c1-f9b8-08deb0d66f63
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:00:17.2133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4azfpfsl1xUR3VpgkdgLbte6+YdYSXkS3oYBlatSxUv/TOfKRdh0w0Z+bjnxtvqPUN0gdMD7v/OBOqkhMo2jrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8476
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

On Fri, May 08, 2026 at 02:22:12PM +0200, Marek Vasut wrote:
>Set the ops structure as static const. The structure is not accessible
>from outside of this driver and is not going to be modified at runtime.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

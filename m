Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6FFFD45F8
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 21:54:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 814A483642;
	Wed, 25 Feb 2026 22:54:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="W4A/FO4Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C97C283AA9; Wed, 25 Feb 2026 22:54:56 +0100 (CET)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d405::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 960A282A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 22:54:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tianrui-wei@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BaC5NvqIN/Sq1igy+D9DNYqVt91d1U/qCUK/sVSDpfXccJWGXydJ6FzGMs0m8ulElEFVLoat3Yic63M7PLEGynnSzbbYEb0p1aSsDEzYXG95LIUUKmPcqB4Kbs+lTfuAI0QdMTqH6wbrCh0WiS1896gMq7HziiYFXAMWetLh+u0RrwPWasmrVo8FfTrAbjFf2wjjK1TAyju8oHMagrnjB5EwAX5mA7fVR1F/D3p9ERwy+mHI+3SJk8sOL5zQTmRMdh/6afvSEvMDvVbrlYC7/5GKzizQR793biiADZPD7uYmy+yOoLAvbeIWOdDtrEXFguULdfM5pc77+8+6Hly4og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIveqZL/fTsd+KXGsKdkase1/NVm8flmnsfjjkChusI=;
 b=JBCSC+2RGfGR2tr3aZBVa/towabwGu0FWD0qBp/wtIU0b3EAW0u9uZiiU/qDfjLuwa+AGiIsvHC5Ev2zDufVl/w0FBiE31sqcqy3EfC8jffZNIb2kDPDAIIVTbhQzJvSGlWRyNDffhaA1f7Koaq5acMqsT5jW7G+mIzClMltKzwKDHbWeFzCzkMhF6E8VPzQRQYG/N7V+6cqpHqu1K+YzeIiSuZAkpo9D0zNoGI8b/37yTI97uUsOV9hNLZvR6Mpqsbl2e5LeHTxkDG5A6w00e1KWDHH5/Oqq83CtABFcQWEixKEtpUkB8s9EV4/IMOC1OPNv9+eCha9BuXmRs2rKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIveqZL/fTsd+KXGsKdkase1/NVm8flmnsfjjkChusI=;
 b=W4A/FO4ZUcG40GgJuxqnXxCKN8YqqStzL5Zp+Tf87BJTklcKEqmkoRh96QKfEs1VRUa6ZMATyJqZ7gETDnUcsGgAq5vZbxfKaEb4sXoJ7CxfWU1vDDh2Gi/9BFTMbcFb5hH8W+h3I/0nrZ0MBzk322ergknPNBDS04iKWFZe6QLKrtD8ngoSg9TQ0y0caBdCFku1wd2I0hQQ8BGucNmVtXc4IIPhsqhB7gPpwPymyCpNA6WbwZqqmaa2hxn9ljGLAiOwhoSXTL1d0YOjuw6WaOkUbceIa+53A+7nTCAHKGRN/nlAoxV9YZY15LZeXapVzF/tZP/r3p3SVCZVA7wA+Q==
Received: from TYWPR01MB10820.jpnprd01.prod.outlook.com
 (2603:1096:400:2a4::13) by OSCPR01MB16476.jpnprd01.prod.outlook.com
 (2603:1096:604:434::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 21:54:51 +0000
Received: from TYWPR01MB10820.jpnprd01.prod.outlook.com
 ([fe80::41fc:7075:383:2d38]) by TYWPR01MB10820.jpnprd01.prod.outlook.com
 ([fe80::41fc:7075:383:2d38%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 21:54:50 +0000
X-ME-Sender: <xms:pG-faaYMeH_BR26Cl8vuZkyCz1MTxWEx0dTBw0MUm078XuTpDzaDbA>
 <xme:pG-faYNaEZoc5k2WjmVFM9uu7RlHTYDKpaAwinLXSu1isEOKL49p-XDuPcw-6t-9y
 n1Mts2oJhNCxbIhzPhP4qg2rbugIKTr_ujvVgOmIZ8VGM27kCR0_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeegvdegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvfhirghn
 rhhuihcuhggvihdfuceothhirghnrhhuihdqfigvihesohhuthhlohhokhdrtghomheqne
 cuggftrfgrthhtvghrnhepffdtgefhueeuteekveefjeduteevhfefgfekiedvieevkeej
 feduveegtefhfedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepthhirghnrhhuihifvghiodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
 thihqdduvddvheehieeigedtqddvjeeiieefgeekkedqthhirghnrhhuihdqfigviheppe
 houhhtlhhoohhkrdgtohhmsehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohep
 fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgvihhnrhhitghhrdhstghhuh
 gthhgrrhguthestggrnhhonhhitggrlhdrtghomhdprhgtphhtthhopehtrhhinhhisehk
 ohhnshhulhhkohdrtghomhdprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnh
 igrdguvg
X-ME-Proxy: <xmx:pG-faU3OC4jQP_JPHZpz-h51dlbV4hsLd6Z0OcNyhNVy1vWZyLOcFQ>
 <xmx:pG-faW2IJmYLRhx0XIweT7xrweXp7PAGcfcJfiW3Z1RgncFfcCG_8Q>
 <xmx:pG-faf9_19EH2JCLVPL5vmZu91AcQh8xjPNhRfRC28lS4baDIDMEbA>
 <xmx:pG-fab0aZiHqT8s6QGBhucu1g3Vvooji3Ui6qJMYt1-5b0UxGfl1KA>
 <xmx:pG-faU86ju4UmHW_n_X6baojby3viWL4cOxlI40NTq7jhSpp1jn9sQNM>
Feedback-ID: i253946e0:Fastmail
X-Mailer: MessagingEngine.com Webmail Interface
X-ThreadId: AX9eBu3zbqHB
Date: Wed, 25 Feb 2026 13:54:13 -0800
From: "Tianrui Wei" <tianrui-wei@outlook.com>
To: "Heinrich Schuchardt" <heinrich.schuchardt@canonical.com>
Cc: "Tom Rini" <trini@konsulko.com>, u-boot@lists.denx.de
Message-ID: <TYWPR01MB10820F0F078FB9032813A29E2F675A@TYWPR01MB10820.jpnprd01.prod.outlook.com>
In-Reply-To: <20260225121302.56052-1-heinrich.schuchardt@canonical.com>
References: <20260225121302.56052-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] openpiton: imply CONFIG_SPL_CPU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0379.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::24) To TYWPR01MB10820.jpnprd01.prod.outlook.com
 (2603:1096:400:2a4::13)
X-Microsoft-Original-Message-ID: <74eff709-9184-4f04-a293-73837f592f9e@app.fastmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWPR01MB10820:EE_|OSCPR01MB16476:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f8116e-33e4-4062-8126-08de74b87ea7
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5072599009|23021999003|8060799015|19110799012|15080799012|8022599003|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: t6NHX6MFhSpZu1OFQ8h2BkKdq4kbtf0WYcA2rvY06M9JOkcZekJHFWOz5/NMwOQiOG7gBBFT0xm3bQ80JMeYHwo1FMcmzSyzusiwSVRKSH6eCjy/T4eOL8jzPkRYX5s5R7rIKs5DjhB5eeSU9Y6UDwiO1jZ8FcPre2AWuqRm8I6NZ5XhI0L2ZaE8NuFQ3DlceN04zxahaQgUEFoJkPFB5fKtbDgXhe83rBBLeqp7mKZvAyk4cEfYxwP8r4oAo8mH55sJeICBNuphw2Odw05bD7LNJMF3Grc5FOD4hjfaqpSdIPax1FPX8uTHKptS1mseNs0Z9wP/D9SUl/+qRNDSD4VEEY4phNkZ8qrkcg73UDgZQQ6n0oLZKFrPfWWf2jDVbIRlcQ6ub0Nq88Obciz3FUXXmuH5YyJhAAvaNQhLQnaZPqSnEVy/09bhgzYlicPlcbiwjGe+C8w4WvLz9mZR5QjUpfkUSkdreJwNmdX8KMQifLHuYsz0mBkaVDJzlNFHjEdnZe3Lg/Qxw3gAERBm+ulkKVCCX6srI12dUU2fpSlRGBw/DxIltjVFNHKXWr4NrJXCrOqYSZtouqRDO4k7aUjXnrkI0MGDbUznj8BBYxg1iF2wUfg23C3XuonpuKzcYW1468FQovl+qRHt3ftNbv1amp6Fs+Gi3MKa2kEb3KgggX2DPAfTzJsV3nv+70UsFtbuT5cY9MZjy25BLdkjHXLWFS2fB7s5P2gZAVZXxT+Ii8g/B6WMfq6fxZpxLv0jUfikzvqippssvUjfmN5ejcl2Qjq+2VdgEtQVjY8+Xea5zstDaR86I2JdrKrcO6eCzMeHtr5craPJQ7eZYu9j+yIKeYNUpmnRF1KBqQOBdUFRWXg1j9Jo8PGJ5/p/YPEX
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VI68AaahlUzzy64eJJekzwRRwYFLCUZfzv4KewGbJ7oM9jAPHQwvbhR/NK4Z?=
 =?us-ascii?Q?XigeBfDrVJXRrlQRm/K2yNk8cIU8cXuGz8BwolRYFEzF4qBkUZiTCCF32nOx?=
 =?us-ascii?Q?XcCcGb9y+HyQiFIvdg4RyUg1S8YEguzakTcW2eg8DolXF0Rs4UEtO8l7416B?=
 =?us-ascii?Q?a9Gjm6PvrmdKVfzxbEpuPw0FnxXt7mqUK4dU0BHCwF3bWbZFPkk5n4btRK3d?=
 =?us-ascii?Q?HelPV/MPB/gpBQI8vbgyez3ceLz4J6LG4edbTK4WyjJRSaXjoKGpDJCe+FGE?=
 =?us-ascii?Q?wY2wVVY8QFwCC53m6EQoEniixLFDNSKsGRlDgZENN82JOkHv6gzSCO4GKEaO?=
 =?us-ascii?Q?Z2D/rOcrB85sIire+e9Cg6e+BtG2MvVS0cTxtZxPK2JWj8yQw83r+hYUrJRe?=
 =?us-ascii?Q?XjWUKS0ez4Z5a9G4a32iZYev4hDhonjL0e5WQVq88voxIxmwizMM63kQiAk9?=
 =?us-ascii?Q?t2RwTvbRPl/Wl3fxKAOjqQbAif7kPW8i0w3eme7wR/lBm1iHxRA8c65Z7B02?=
 =?us-ascii?Q?mK2e0lnclQ9PG1Vqvc7m1uKqAdtYbsgHJ09Ug7TMyJ0CCc3qZb0onIjn6Iod?=
 =?us-ascii?Q?IB7dCBRXJjINTgbt2PlOYUwHmcSjn/eSQeEdz8gyN0zeaJ8pbF60SabR10It?=
 =?us-ascii?Q?LKckpTMhwkrTKzQQQM1iOUMJEce9jsjD+wfbTvFz5JcV5aMS6FpQ/ImuVQC/?=
 =?us-ascii?Q?GYsFpRDzRWxdoYEC6C5Ct7Y/HiVP8Rq8WPwQ+3D6o5ReH+kn5VaLDkFBmjkA?=
 =?us-ascii?Q?B5D7JO7yr/xom542Y5HduZvLr7akPpTMj3VDgNZ5yECcukEC5pwEKKaml1Wz?=
 =?us-ascii?Q?9RIm4EwTG3DAoTKj82s2QR9OHoxgu85VicqBRmV4hX9vMHgL4nECvLYDowQd?=
 =?us-ascii?Q?ZKJ7umVobJfnrpSUgo7l1lu4icpz5fzXZFgjOh0ZTxeuxa8InswDTEBBFIkK?=
 =?us-ascii?Q?eejiMOt3NN1S1Ki2nHmYIPl0aTduu5rF7mvnuKpCSqxq7o+eqi4Jxgms/pMa?=
 =?us-ascii?Q?k1m3COgIgVWYVRFpAuqju1Ye2ijiEqHw66wQX6hl2OaQhY4NpOWqcUE/BrR0?=
 =?us-ascii?Q?cb94gnbicuuB4UCGXW4hLu5wTpXpnnvDZyFWxOAf4dRTpjAKGzbcPU02RfG0?=
 =?us-ascii?Q?A4572dc8pvmOGcsFpSPHo+FIFSFUoilUyj4m/nylX3MPYGW6dAW4/UXfJpCV?=
 =?us-ascii?Q?9V4M+GCdYO5YykXdJdcUgqxJwj42quMHzn4jcYZKkqdtVeIBO9Qeij3u5+pn?=
 =?us-ascii?Q?0o/wiYCh0DiAjDSsh9alt8wOgbq+uSpXtZ1liRuAmEnpMryDy/9NaquMMUaB?=
 =?us-ascii?Q?VeaxPoi1lpETpSqUCZxj8507HjOcqHFKU0sng5umX5qn4gl+BSa4BFP/JSMf?=
 =?us-ascii?Q?Iv2kbMQc78e4Z1TNRYAxUkS3/R+oWMmsD8SNkDdjnRt2UpSMTQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f8116e-33e4-4062-8126-08de74b87ea7
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10820.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 21:54:50.8349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16476
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

Reviewed-by: Tianrui Wei <tianrui-wei@outlook.com>

Thanks for the patch, Heinrich!

On Wed, Feb 25, 2026, at 4:13 AM, Heinrich Schuchardt wrote:
> There is no symbol CONFIG_SPL_CPU_SUPPORT.
> The intended symbol is called CONFIG_SPL_CPU.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  board/openpiton/riscv64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/board/openpiton/riscv64/Kconfig b/board/openpiton/riscv64/Kconfig
> index e4bd8903aab..b646aa8cbb2 100644
> --- a/board/openpiton/riscv64/Kconfig
> +++ b/board/openpiton/riscv64/Kconfig
> @@ -31,7 +31,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
>  	imply RISCV_TIMER
>  	imply SPL_RISCV_ACLINT
>  	imply CMD_CPU
> -	imply SPL_CPU_SUPPORT
> +	imply SPL_CPU
>  	imply SPL_SMP
>  	imply SPL_MMC
>  	imply SMP
> -- 
> 2.51.0

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8ABCD5BC0
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 13:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C48086B63;
	Tue, 19 Sep 2023 15:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="JvEIxvXu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FEE486A26; Tue, 19 Sep 2023 15:50:02 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2071f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaf::71f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B611986B31
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 15:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mm4SA9t/EggZ6xIfiT0Nwd1/+D95Ln/jzQd7nlzZ0uf8bV+KZYQ2lyaIejXHxkLPk/1mcNFw3GxaSu/2ValgXOYIPLzQcGzybsAI2MaemCpm0MJW58PP91/JaamkGyRpC+vhlxaI94LMuwgYI6BXStfNsxJFU0tql1sWBZ29H0gDMrXGlbG/scpB9lkxXZjiS47VZiSTW4OFGgmlSRpG0smWTfxFwkl/MoX/2Qn9pchOuFKLZLugr2V9tNhbxB9f26rVqOYg5H0lXtdfZNgT/0ipQYR94rvRcLcj+LNPk9zBlRwM1swemsezveVh2eNIQOIu6sGfA6FFcSLYNuTvKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2oTf1U7/wRtxwGgvulO4fvS5jm2KFKyZFFxlPEyx8I=;
 b=Mn1Uj4WrWUxH0aIxjnaYSDN8JcTI52fjNYgrPwZr2NDzog7VCFyh9xBaKjXlFDrNlkzZOLwSl76FG9RJjztcD4zTCzhMXAE+MQfvo9/tNR9i4jvp7qbUJsKDQnAjV57GS+CYT5mhbeBkEth+Qk+st+XC6LOaErxEp0bsp+/2V4Lp/s4s7XaGw7j6BUeylVjf1/UfBGJ6dK6qiiF8zH2RvFjISZFy7XMR4PVw1vmJhVotcp+0xlzkR14vBDj+JUKMdRDc8cIe+09nNkB85/fGaIcNhNczZMLfms4Sgp7ccaQRGeAF+5pr4GI7782o+b3o4su6y60TKcu+g1oEpPu/MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2oTf1U7/wRtxwGgvulO4fvS5jm2KFKyZFFxlPEyx8I=;
 b=JvEIxvXufiaQpx9I9ZVBIIokI7aNhmQlxzriwZHQ0ZTd7acdAdhWYVS/wO4aY9KKqK2P2gJE+3c3dtJ4Sw4sRNgCkS7+TnmiCbZsWINc2Di+Hlc9CzZK0o0fEvTXF9Hmk51xAoxi98TyLTOzEHPPP3fq5D/y18CTpD6nbcfiC7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV1PR10MB5938.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 13:49:57 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 13:49:57 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 uboot-imx@nxp.com, Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH resend 0/2] imx: spl_imx_romapi: simplify stream loading
Date: Tue, 19 Sep 2023 15:49:30 +0200
Message-Id: <20230919134932.134678-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0006.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::11) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV1PR10MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: b5488d4b-7af1-4a50-890c-08dbb9174f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RFTv7A7xIJ5XRqOrfSVyWfuAVyZNt6bAM31fLNFsSqapgwtLpIozVJ8rTz0maftdrRzVyt1uhRvUNU//CE6WyHKzx3ZKr7E9pEatWmJS/+mE9aDVDwupbBpNVwRuoqKR++eXMhOI5waKELul8cUK9HePsA9V6EUbp0GexUScXRjsBfeGVLkRe65ae+nov56U7+Sh05jivYrk74UOgiOL4ZNtweXE7QHgLLwaxK6pgmBbnKixdyBaU9lyVX+/11qSt3//jSVCaKHkv7exLXGlNgw3LMWB4fTaN7H3VLD+fPrQ3QUQn4d941FkMBu3rVbghKZw8qwd8bo3A/zLbNqgREB9sDV7FPmonjTlpt1FRgTEJqpDb3gdpp++G6aQXE5WfeJT9Ldlgp4UaqQatvZY90QRhvVhxcZ3rKT41vY1UU/+8qhvAZK++ksjL6G2s3IV1MRoiPByz4XGBaMGveCYcEJVefyCWVrQTQpT4vYPGOU6Z2NyEe5jDlYZqotCopG89x8o0V9O77S/G5iYF/9MwwThQWBJh7TGCnb2m1UAjqKb3bHoFx8el3VsR1k41AX0ptgaxY7Nx3KjE+wTMt8c00jXqoiK1goBXiTxMeaPqz4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(39850400004)(396003)(376002)(346002)(1800799009)(186009)(451199024)(26005)(2616005)(8976002)(8936002)(8676002)(107886003)(4326008)(1076003)(83380400001)(2906002)(36756003)(4744005)(44832011)(86362001)(52116002)(6506007)(6486002)(966005)(478600001)(5660300002)(6666004)(6916009)(316002)(54906003)(6512007)(66946007)(66476007)(38100700002)(41300700001)(66556008)(38350700002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2PYCAfV15nxiFv3nlhulsTExOmqm5c3LXBrsX5fpqJhq+4Tu8eThTSspbhKF?=
 =?us-ascii?Q?3s8yMFEViGqoQZ4naoVt7XOIXD2PkLPN2ys5ieD+O//7ceueqiI/0+5q32Vd?=
 =?us-ascii?Q?AMd6fcNFY4HlI9owwK8yzaaeBHrOo5HhccIsIP6K1rTCID5lhIieAQEg1Bip?=
 =?us-ascii?Q?PrvLL/RkEuOnbV5Tgf4mpIaHQhYhuCgFw4AIu4n3UiunFIEqgSNYv+6+mBY/?=
 =?us-ascii?Q?x+8psiisqWT1vYBvYxHHt/ig3Wvr1ifYYznsUzxMt/3AaalcqB3FDWbrV+Af?=
 =?us-ascii?Q?RZDIckVzgync1jZ7jBkn2vvZqf5nV9yGPNl/LuUpXXpl6+LmyyhvijdsJgoV?=
 =?us-ascii?Q?5tdpK+i7VecbTfxAp/eKuvfDSK7HVvYQDV36BUYFzftp2YMADe35CDhKc8WQ?=
 =?us-ascii?Q?tQjwsk+wj6ALpcD7+QWVThnyXRl04/FeLfEPVCDmC5fwavQeLqm/DIlF5PcL?=
 =?us-ascii?Q?PuVSkefa8oEtV0qc05sZhgdH9NUZQJZzfFM+fYQ7ZpQ6bBVKPsgNbc1vhcPk?=
 =?us-ascii?Q?VUnfvPlu9w437j9MUeCXOopYaCpd0tDyyuzp9XfpL8YCZsL9LbR4W7OcRsIE?=
 =?us-ascii?Q?il6UxzRzijpYZO3BOx/rnwbsfd/QLYdsFPdZwgNVDaBMcdQuZG3l0jybtHNa?=
 =?us-ascii?Q?GB/EcIDTXQm9Vk/v6TV00DsnyW9OmgVPy8qGZ8O3iFOVCg/4B8nGjNM1yfO1?=
 =?us-ascii?Q?dTJIrfEYfuoi7vFS4+15RHASHNTrVSKZOOSnBpH3gFXQsjfq8modTpd/PBAO?=
 =?us-ascii?Q?YgnFPi723mKbLgk1K5ZoPvWDIFJSzuaLRkC4CI/4du6fcEIZxvmrR3Pvwqnd?=
 =?us-ascii?Q?hb8W6RIFxJo+9GxKYTlWP+Pkhx0rXrd+yGrOxAuYLFatwFDHX9zVZBRmi9yT?=
 =?us-ascii?Q?noxyp2b5UZJbTg2+DbSi2LoQ5m6qq0ykU0oFcy6J7/91zIK6w/NPOzS9jGwT?=
 =?us-ascii?Q?Z3tR/3c19TmwGcl807vE2AXM3ACPkDi/BWbOEDrpLeDliS7QVyN9Ek0J9uf8?=
 =?us-ascii?Q?+qfGa+xo7hWv7wKx7r5/Nq72v01iINw+MRz64164SwcbMvaBUqkdY2hWiIIG?=
 =?us-ascii?Q?0D5byI64XFQqBrL4Iltn18Cd5ag/LzvnIiI1crT0hDhoQnTisdKvfDc0UVlF?=
 =?us-ascii?Q?gUoDbF2e1Sz0l0X4MQTmL29dLLHTxlFQEYkkHDy2zF10UopVG4Yw2je4TWlF?=
 =?us-ascii?Q?AmbqikQWpvXXBZeo5InJm+MmDhlUk9dZ+oUg26R8xPXbi2tZVXp770A7Imck?=
 =?us-ascii?Q?LtPzy7GCuPi0VRMld2cnce3vnIGrfHI3TZ38+h1i+dqpmogOJw1kTjy8YnU5?=
 =?us-ascii?Q?X7nFbIK3FMHgU4Bp91ldjyzn9J0EDNQEcr25VtA/tr8dYY6kqq1w0/ZI8FBG?=
 =?us-ascii?Q?pEqRIvquc+FDKVZWFa+fu5HLWwiWQ73W9uTgvm1/Qs4Seg1wW+s56Y/V1G7X?=
 =?us-ascii?Q?zmi5wtdddjp1hAXlsCbo0EFwrEuyEAOrh43Brkd4QUsdPTAo9Bq0jS0KtrTi?=
 =?us-ascii?Q?ECwGpnZUjwtMAItYhAAzNu/a63y4wtMvohSbxIthoyOyRAjiXbCaTU2IFmfr?=
 =?us-ascii?Q?v7S18wKdd2QGiCO23E0ywDOTAmltbk+BZOCFq8peF8DlhMjcLOuCKxH0lyqE?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b5488d4b-7af1-4a50-890c-08dbb9174f5a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 13:49:57.1478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnT3tXxB/ZflsamMXwY4DpGaMw1uPefWC1NhPiR7mvsJjlWitT8PNhq582VgpiUdlpNZptUtm4eynl0UWkQQ3yMODwdRdmVbijz71ZWJXJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5938
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

This is essentially a resend of something I sent four months ago
[1]. The patches themselves are unchanged, but the commit log for 1/2
is updated to reflect the change wrt. IMX_HAB.

Moreover, while they were previously "merely" a simplification, they
are now required for making usb loading with IMX_HAB actually work.

[1] https://lore.kernel.org/u-boot/20230523113651.292806-1-rasmus.villemoes@prevas.dk/

Rasmus Villemoes (2):
  imx: spl_imx_romapi: avoid tricky use of spl_load_simple_fit() to get
    full FIT size
  imx: spl_imx_romapi.c: remove dead code

 arch/arm/mach-imx/spl_imx_romapi.c | 75 +++++++++++++++++++++---------
 1 file changed, 52 insertions(+), 23 deletions(-)

-- 
2.37.2


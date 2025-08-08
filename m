Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC096C87FD2
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 10:04:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09607846A8;
	Fri,  8 Aug 2025 12:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="YETILxZn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5B9A84559; Fri,  8 Aug 2025 12:04:28 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEF2F846AA
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 12:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pf0zlzPMvG6tvWrlnwectSJmRD9P3WFF7YxcG+ChN7KhqzGiLXObGn2s+cL+7TXKezhnoPs44fZsM4A/DLkKioTACwA/csk6kNqlSNRnO9Xo7utQ1H3Y5gQS1A5AUR8CCDTubj9Xt9M8eTBn+ppzcp3OZfKv9irrkOrtgtT6cCmQbJoXdBKRt9RDNP0PXGJNZvoxDq35YdPrBS0G51urJ/JT2v35JZo4vTss5PoLgVNxmd5Unb03RP5rX+rhDwae3jnZQhXN0BDWYxogv5PJ2Xl3P8fX6kTr/zIcCYi5ZrA1rS4zpTYrYQ991/2SOhbeNNqnnDZ/Cb0Tk/qGbrwM+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRfsXf75DlxjS2TtGOEpj2g1wnM/XvcVIIz7SEqYNHM=;
 b=BgEmjSqSdjHYrluPj7lUSe9w2VRZn7Gk83nPt7KRwe9lBrxpe7HBL8FxPHu5mW27qsNHliGMhmdQhMzYPmtzJY0TaPmZVvGUQ69avoMYf+guyT3dblgnbKySvQZZiZOhtwP/p717LqsOGgIJFTKDCUf2THzn92Abb8ijqZJpwhLGEFHVEszmrgOLo49ZO5dr4XMt9WH6jUEDMZ7lkMmpQkHi5PL03nb7PhosbgDfRf0b+eL33V4mvW+razQ0KBu3bNOL2OEJcNmhn+l9eFNxUTdkgcFRwr/6jZLxXyz56bWEEiwspjnnGMMzg5g94S66JAq4rhUmy1t9Bmcnndka/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRfsXf75DlxjS2TtGOEpj2g1wnM/XvcVIIz7SEqYNHM=;
 b=YETILxZnQITMSMv5Od99RtTm+O/Vv1tCAr0DR79trk0JKzd3ZMUA/xRg+Qc0pswbXJ2Fp0ZyFkwcoIs8J8CIBQz3NeIR9lEH9sJLrBzL3TiCneUwU2hvxYcG1QdOOKrRggwirB/L4OniBpd/ro19S3p8mVOMROysO0NRFP12PUHbsC5GYXrQ3QSaIx3y80XgWlWM/UJ4vKkPDTEhlygVv3ijv8ntDyqFlFeKk6ISiSrtnwSu392wqhlTvWGcznQEJVWxctF7IeTYAimt38LRK3Nk56nwGmT3EJZ9wj+m0HlWh5JTCTl6iSYUkfEoFaQAHeM0hmSgSd8D3Zsb/9ktIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by PH0PR03MB7113.namprd03.prod.outlook.com (2603:10b6:510:298::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 8 Aug
 2025 10:04:22 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 10:04:22 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH 0/4] Enable USB 3.1 for Agilex5 SoCFPGA
Date: Fri,  8 Aug 2025 03:04:08 -0700
Message-Id: <20250808100412.9320-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0163.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::18) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|PH0PR03MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: aa572332-235e-4f50-15e9-08ddd662f265
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7MdnWT+KAGo/lQy88MI1+Sz6FosntQ2P2OTgRTVrgjjbanjltb7tbioPO9+q?=
 =?us-ascii?Q?F9ttMMsy/31UXypfl7pweaXHFi74jHzeOLgR38Sh1qRHxz4IUzEeOW+0VIDS?=
 =?us-ascii?Q?mYMVxaPvbd3PDLmg3Z/uW3jCnTw7u5WGx2varcctwrqwTV/IA5a9sP9XWZPi?=
 =?us-ascii?Q?Q5kXsc4mkqEUd2rZooBRCZ7g/b4AK+2mI1AnqGfy2xDrPloKisDk56YllPsQ?=
 =?us-ascii?Q?e8fuiaC9KNgY5u940m9crHsdd69UuP0EyTk5SpeQhZVZgi1DeWX8pgA5CdaW?=
 =?us-ascii?Q?QbSwZvk/kUL+zwRk41JghVRLT2ama6s4xAiq+ChMGSP/NxovcyfeeGRnTIUO?=
 =?us-ascii?Q?TfpqtopQN5B3T8LIi92qNpkNpNGFLcicn6iBwX2AffBF/zrZjFOStQDARvd1?=
 =?us-ascii?Q?5hBQyKuUmLPQRyYwkH5bUhvUqO/lBJMnvXgKrYRGY6sBwew4SpZZl+Ht0/fR?=
 =?us-ascii?Q?kUYY0l/3lIN6qysOTL+o49M3aomynykGXtNVuXjnyh/4/C9hbyfDYT6VnDEA?=
 =?us-ascii?Q?R5NYyPPAKCuCUrMO9dHP34jT/DzeBg7qcGctCI21VhJV944xYIob2NJ7ielD?=
 =?us-ascii?Q?k3SoYa0WtCHS5rbtQxMuZmsSIqOoscvLguNw4Uzz+2A1ZzQj5a3Fgw8BxCqR?=
 =?us-ascii?Q?aWguP0CeeQ/+15PX90Tf2AHojv9UhWKnfzTjHPMYoCX21Z9CjTlHXhjN0DnU?=
 =?us-ascii?Q?D827Ygquuvy/sqnJCAJ2HDboxH8LqST7xzjrj/4eHSuIPEsMb/J0ggI8qcRD?=
 =?us-ascii?Q?s6mbHJeMCSaaCRYkGPBImg2vSBwQ1Ql0Nk7FYTf/mbq6SeYaJYehJGKokTkt?=
 =?us-ascii?Q?1cCdAjvXkM+lqyq6/u9IYNF4PxTx/tkoor6GSTPOk3RiKTxTXZm2U/QY1GaV?=
 =?us-ascii?Q?Ll1zJ/NyyPOV+Bc5+fDoyOTZrrI4yFvIrcDonXF68yBvtjRDbv+LFI5nlR0L?=
 =?us-ascii?Q?xkz1yMY2KpHD4e7NiZn8W95rtY8UR5yPxCaLDF8vQuTRRt6pc0cFBPuytmIv?=
 =?us-ascii?Q?tYfXFqo0tHn6/iOlFPVq6ct5h/KEb13sWLgt7ac3lTfTI38ZAxo1TdXm2H4X?=
 =?us-ascii?Q?xboYkJ1SrHCPH4S48bwrgmNKl6VBYSrdCViob5d9lPAHOdu3tcRoipoRjpHc?=
 =?us-ascii?Q?Srz+hvyOkI+U5w24F80h0mZwAx/5jolwh538OuK6egIi4L4vs9bS0zae3yZY?=
 =?us-ascii?Q?wckN4estceOmZ1+Ym5SwkR0B+PpC6sq8teb0c0sIr08Ml/LMJ+kc+SoS0v4r?=
 =?us-ascii?Q?08xJHkkil/eyCnmYUvQQ8gJTvxY6dlFV1yoKbaKDf9ZwtHkbNq7gfCU97Yab?=
 =?us-ascii?Q?6DgH8Wu31Mv028z6Ec46EUQRfzchx0H/Zw/yfXEKBlf1m11VlQUolpWHvTA2?=
 =?us-ascii?Q?MuQSs7L96YYLMEdIUJCtMB7Kvjl/nPpDLdiruHyYicn4ULRl5z+wmjaA8kah?=
 =?us-ascii?Q?2OtrInv7nuU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?03nFdGiTfPOW5lG77P4Ttfwc6n5tsZWj1PcXqWLqf797qxxS7RmMiEINdvHa?=
 =?us-ascii?Q?R2xTcTfPk6SoNYou1A0a0oHe5gMfs75+09VNRhd3leAwSHeph6LesAvlyYjE?=
 =?us-ascii?Q?7omrehvuwwExrCisQKxYBYFuB+hFenUIJV+eExC+HjfCbn4fz8jhOR85NLbW?=
 =?us-ascii?Q?Fc2YLGpahse9cGc4JrFJh+qtAS/KxOon6mpDD9x7HLjrWv07aiL56VerH8Kd?=
 =?us-ascii?Q?/9nTNqczaNzou5/JVWoDXzJannpg+pH0GbhA0eZ1U/vGgjc8XvLc7LDVuDou?=
 =?us-ascii?Q?Ess1Gf1ILQSo2mg+FcAKsxWOb5WKMJq5a9ukqW6n7WrSMdwas117sn5dTms4?=
 =?us-ascii?Q?eXi0+72F4ngN9cFpNQ7pIwxwBYeADHzGPMnDB2YM9f3EI+cPnxKJUyP/w/vm?=
 =?us-ascii?Q?eCajSmZvExq0lyvU7DBOZYXVH02OLtj4Z3N4uJjECKvvO4ndoJaikd9U2FJk?=
 =?us-ascii?Q?IiTtikyYpFeETWaf2rl07Yj7ks2kcWZ/S6KX2bsfEM60D/rKOtXFkn5X8pBS?=
 =?us-ascii?Q?C8xjZtaQ9DjhdlAAexeKUqK+GchXIwnsbmuA/UL2ceWTjR11MJaS31PzNX8G?=
 =?us-ascii?Q?ixbg6L412ILKhbzPs7QVe8aalyEQiZTydR/KxhfmzCD7uGyAq0Dm1XO/km2m?=
 =?us-ascii?Q?idcNAjqbCJ+frAnOcmb6KvMO2KZ55K554tjxdhkzuz1nw9BGA9FIMfy73mpt?=
 =?us-ascii?Q?+8j5fMMyFVaiiIrHikOSOTfSjUE9y6QK46k54H5LkN7AUxPuWYynGrv80pu4?=
 =?us-ascii?Q?hVsbFhqYDd93KdZZoB4kf3tSrF5Ae5WD+c03Ag4f/7tCFRxeoYLJ1zJZyXWG?=
 =?us-ascii?Q?aZ7daC4KZ+IC9sXVOWjYGAJUr4daBSHbftottLi41xD6Bj2NOFx7ASnb0eL3?=
 =?us-ascii?Q?p2vUuY950NikW6CC9WYKNZo9oy6qWUKh4PguQPp/QsoaiTcpYxR3Do38ZZDd?=
 =?us-ascii?Q?vy1m6N8bd09rd2+B+WiYDc1S3C4Z+htD8O1KhA5KKw2ShWmNPhnN+lvvWX8d?=
 =?us-ascii?Q?tf9QZzZDpzhI8OXho4BOVYh52ciyxfSKmTupswDkdvLKbXSZ/1MCcFnEG4u/?=
 =?us-ascii?Q?/HfZq20ZE8RIyqfpevkMEapVLweWPlpFEnDIJ4pvqz6fAbrMhm9/8IoknEP4?=
 =?us-ascii?Q?3MgA9FSCgqgcwnr2f0bSEmdj0c751zPIZpcSSuidG9VUe9PPWdwdJGRXGz+c?=
 =?us-ascii?Q?txII2fn0MUMR7/wSGz0DCsdX+wH/WFM8kmKaRSkJ/ReFS+rdSW5oRCFaeYzP?=
 =?us-ascii?Q?Dr2Y2+d/YmQofK5nfRpmIjwQ5YaGwlcrDmRXthYYI5mVXFzxAOu+l3uga0Do?=
 =?us-ascii?Q?gO0t5DJ57lwt1huXZBKJM1fw+ipvuf1bheXy1bE0wrpG3ca1zQ+8R+CwhdZk?=
 =?us-ascii?Q?zNOsgcs+3ReRly5JZRbpNdUVp3XZR2NIxamOKJDcaJPyBhiAqq6dozYwHVR6?=
 =?us-ascii?Q?b4kpBTpUBpkNsVVnvuQ8JfqeMNmjlQ2vMFJBEZ7prGwA4edDQeGSNrnKcuC2?=
 =?us-ascii?Q?qUlPX/L5523eY6aXo4TWcwDFdlHAtyBYy3SWCJSaStr/NPQxFIjpEPOJabEc?=
 =?us-ascii?Q?oDr+8mlyLpbHwCkU47eK1DTsdlahFWYti7Kaf0qW6GPTK/xvFR9Q3EhzZJLl?=
 =?us-ascii?Q?W2VjN8bpgyD81JXUECMaGfM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa572332-235e-4f50-15e9-08ddd662f265
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 10:04:22.1137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0VwYEvXPHHKCvu29zQo542zJuccNPXhYPsVK8QRvKLpAVEtisav4cl19Lr8idjrnlJDAkCvZrkedVxLKcf8jqjkfsiQLXSwnDbm5FoHdYdfNVhvCUumZgvDSwU4JGyi5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB7113
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

Required configurations for USB 3.1 are enabled for Agilex5
boards. Testing has been successfully carried out on Agilex5
devkits.

Naresh Kumar Ravulapalli (4):
  arch: arm: dts: Enable USB3.1 for Agilex5
  configs: Enable USB DWC3 host drivers for Agilex5
  configs: Increase USB Hub debounce timeout in Agilex5
  arch: arm: socfpga: Configure USB3 System Manager registers

 arch/arm/dts/socfpga_agilex5_socdk.dts        |  5 ++++
 .../include/mach/system_manager_soc64.h       | 12 +++++++++
 arch/arm/mach-socfpga/system_manager_soc64.c  | 26 ++++++++++++++++++-
 configs/socfpga_agilex5_defconfig             |  3 +++
 4 files changed, 45 insertions(+), 1 deletion(-)

-- 
2.35.3


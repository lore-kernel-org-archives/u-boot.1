Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5A1C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 10:47:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 236D48766D;
	Wed,  3 Jan 2024 11:47:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="cQwr/bPW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5367C87120; Wed,  3 Jan 2024 11:47:26 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on070a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::70a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11D2087128
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 11:47:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNMqkTqQMK/3acMXX6Ufg6jpoRlZTacwN0T0PtzxwHDK7rd1nVWYJaCqAB/zAa4ihHos+eLgH7Z/35tUWggrAEB6ERVD/P99UG65TH6M5HDzXWa153WPsp9BHQUlklWxIM6wN7jpnMvljevIlXdO6TnPWDiXu3lEPD14WNRQFPKJQnDyuUZnNcP0bAVjHSAR6ZmZs15FQKao63R13nGdGXFSR0jNBcPN9vorizyFy7hopuOzci+aM/ioCOYy0q9y/GRXV3k+mfLDA+jn7XlcIJ6ZIROmHMmzmszinsKrXY6z6uLP/Pwxo6MmdVStEFwzwXfzFKdqjWVHKegDW1vSpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOBoR3XbANseumAHrr1xA6/j9QZI3dRzLu/BWBhSnac=;
 b=F0X6Nga9PXfHTRiteimo6cjLxFdmiO6cDwOtdxpnVmMP5UgzHh79Oo++/qE6o5aqDJaiG8Fa1PoBiMuJuD9bqTgft6AEmRPCkB4UQz8kZYMpnr+7TpSnBRtc9g0ohoOzVgOR7IsN6h8prqigVOQxrsilBh4b8P8mOxnuHlIJVhE9BO8vbnc6FIa2a6mEdSkMMLrIjXTbkBaF9i4+y2MnnwWKoqGXVpalV8pEnQsZfBAVk16As6p6yTzCyqdzx+ezG4opDe0kY54kzX7y5XajXp4aSDD0k8pNm/dZQrgTFxf39XoWXGuuWFiWLL8p2K8/ZTRY8lGS6w63vaZQBtPxXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOBoR3XbANseumAHrr1xA6/j9QZI3dRzLu/BWBhSnac=;
 b=cQwr/bPW6Pm1YrF3fUCxUti6whdu7NYMjsOCapSY/Q9f2aIhBdy3jmLA5gw+RusM2hfaZpVXwsK2yDgTovXtKrYW6DHGSG/Dawq85eW7NIGcMVpdNbbpYiqtvvcDCkgs3/fK+bhVeRE/92bg2k3YZB9VCStR7pp8HjhCedkwnJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS2PR10MB7575.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:546::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 10:47:21 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de%7]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 10:47:21 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 2/8] doc/usage/cmd/cp.rst: document that overlapping
 regions are supported
Date: Wed,  3 Jan 2024 11:47:04 +0100
Message-Id: <20240103104710.4185383-3-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20240103104710.4185383-1-rasmus.villemoes@prevas.dk>
References: <20240103104710.4185383-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0069.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::6)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS2PR10MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e4cbffc-b63f-4f0c-7dd5-08dc0c495cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: braWWJtYcqHF7LLEWB6B8MuSa0AkLxbsvF30vAzXcgzXnwB8j19o/O2CP+dnjAYdu/tG4Mmj1L1Gi9MgWngYLokua3ilNiNGJeQw3+VTX2R+rAid0Nut7qS016FgGp2Y9pfX5fqgIokXMoqopJxFWLwFgNTgqdJv/YlSssJFERTo325RcWwsT3hbYyZt0Shtq3zspjGsSDbLdB/zb/BCjzQ4/2NR1R/LQmPSQWUJ3BVrm8W4lo/YMyqhUVPnQrn0r7pTVVIBS2utQR+/D73Ti8OQ0bZ+IMW4+urGFeXSZXWEYH4S55n7SBEOcIlGvjYQ4JP804/sdpNjPb1rsmzwMFaG38uG68iJxV7nCdBvNfirpJNhlA3SsAfldgjCFvj/lTp7mmK6zEgtoCy81vdoKkusVMQLwTyt2KaJxhm8SD+1S6n4prlSYx/z2TRl90/LQ7gGP+JARUGbny4BBEYg5NJHnFKqUvRVorDlSZdZQzHXr1t0CMWBStghg7xe+gjBekg1arFHcGmEL3mYlmrA/7yGi3/GjQHUVHbKBzyA+4WcjCwNkqr9Xc36DvSDF22FKj9pwutcdOylqISWp9R286ZfpMy2T/MfHlxOe7cM1aCtfxRYA+2X2hTh6baDYNPR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(346002)(366004)(376002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(1076003)(26005)(2616005)(107886003)(66556008)(83380400001)(38100700002)(66946007)(36756003)(54906003)(6916009)(316002)(66476007)(6486002)(478600001)(86362001)(5660300002)(2906002)(4744005)(44832011)(8676002)(8976002)(8936002)(4326008)(38350700005)(41300700001)(6666004)(6506007)(6512007)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RIvbKbrywShVDXytOGnMmyGZzCrT+2l5K0xTs13wEj0iaPiKAYj+KrPqYFjR?=
 =?us-ascii?Q?0H1AxmiPAb10kcLbb8w2pKH+DcHC/OXFFjIQ8lwybDdxBTtddaITP2hQ99bp?=
 =?us-ascii?Q?ChlfTaUufTkSu+PDYfrcYkVuCZD0ZaJGGQUIMFKx2r+aV0YEa7L5JRGG1d4j?=
 =?us-ascii?Q?z1j4OeSya39KfSe4T8RlkCohY+R29B1XCz/hZDfn6Zjrl8EMfytQs65vKkrR?=
 =?us-ascii?Q?4OHRctCsYzd8F6+fnL3M40A8IBzjLUNkqYAIVL5t+Ukqx6KdYtqy5h5cpuZR?=
 =?us-ascii?Q?q4HYw1jJVZqQAm1vmrtHYp3lOH+l4rMZUray7XoIVyaEHiyyZsN07UG75xBr?=
 =?us-ascii?Q?0xayL7Z3zKLc9DjjrvXFcCEqwPXPIrJlmUYnozLmL5FIqlZe6PErnsXB3n9V?=
 =?us-ascii?Q?/JQQ9Q0BRbGAn1I7dOIRChyXaev1g7i2PxNSB23Ywm+vn991Bzpo6qmOqzar?=
 =?us-ascii?Q?3T5DNHiVI3FHa9j1zgnyOr3hLCfIS88UnV03pfcpovt91Z1DM6YX6c2Sz7Wh?=
 =?us-ascii?Q?RZd0zeARxtClYFrnY6iaEaIPQSAC7M568k6ee1gmuDa2L0X+z08HhRS0Ek7T?=
 =?us-ascii?Q?y1H3IwTRF9SKvNCXCOnrfay1KPXtsIwyk4TXjRHdYuFDvLzWfXh7XRYtbUmi?=
 =?us-ascii?Q?EXRexbnoQ2ItjnJrrOlnJSoRyDu9Z3D+rV9V2Qh7RZflWg2szGEjICaru6Ya?=
 =?us-ascii?Q?oOO0EcutYRpeLOdQO5H6SGq7pGQi4aPv8ZkpAyvACAeSGf9+c+74DVthc5jQ?=
 =?us-ascii?Q?UlPwpXkpGpNLQxt8HTL1vkwyFEuLLgIVxrvK6r1AThZXnsPMGwHG6mmWLyKF?=
 =?us-ascii?Q?isLLpUF85+nFE3XI34NYy1SkjNU8T33Rcu1RMQx8Nw16qrFwdQWHTTLkFznB?=
 =?us-ascii?Q?VcUBa1ruerxmxSrmxLPCbnccx8+T6bT1zYqPipfhKAL5IYlEMzX5iyOzfMFB?=
 =?us-ascii?Q?GAJjCvhMfMIj0zFPppHeHTWHoBj4jK2nfadrWivK+26nqbNBz25W0JbtWVA9?=
 =?us-ascii?Q?ds+bveDsH/4yeUhy/HIvcR5z0qv66JvFgKtLIuzgl3R+ETei6AKsXfb3LPZc?=
 =?us-ascii?Q?RSxzK64O08SiTiSGsGJwC52oduZJ7cT1K7jIrK0RcctuoxE9N1q7hpC0eaeG?=
 =?us-ascii?Q?6yB8a5b5Ab8RKsNw+tYj4pcpQEZ8t4xfoi0mtMSq/9tboXQCir1YHPwrTrGW?=
 =?us-ascii?Q?8DeyuAH1U2AJXj7rV2GTScS3oXoC7CZGd7RnsFBBEXKpQmPhyHyq5ixwQXhi?=
 =?us-ascii?Q?OYuln7KpShH6bHvklvTK/FCI9ePlJSL2JZNaGoSvOQB1ss242uQaeKp0V+fF?=
 =?us-ascii?Q?Q24QF6Zq1qShPkTyVxG9I1dONCFO2AR54+hM9b/F7PMuE6kBUJDbmJhjj6QL?=
 =?us-ascii?Q?SfGYzJ1KKshdQr9eb2k2iLDYlE8wyFv6uzjEqISrsWYZVnP74lS0GeIpyl/F?=
 =?us-ascii?Q?yMx6nobnGfnzWwCsOpyFR3Yv+cpI+QSpzUjsiKW7RKp1akc/tJEIk97sIjNB?=
 =?us-ascii?Q?Wk0fzkB7zTrYfGsKGOh5LPVc7hj2djLuBaDGDVF8BvbGXZP0uZmzQAc6Oxe4?=
 =?us-ascii?Q?gA+WtesF6u6AdmrL1tixX7TUZfrab4TX8qDxATdeoyvcwFLNVzJmI5Sbjdkd?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4cbffc-b63f-4f0c-7dd5-08dc0c495cfb
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 10:47:21.3570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWO6r4BecOfgMB8gAUFwSpV7mKIi4mNDkMkZ7aw5Mt+MD12HLopgodJqRx1Kj070Ns1q/eFdsf5e2V08m9vSCx0qxa8cDvrG8W9rqdA39Qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7575
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

Now that the cp command is changed to use memmove() internally, update
the documentation to explicitly state that overlapping regions are
allowed.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 doc/usage/cmd/cp.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/usage/cmd/cp.rst b/doc/usage/cmd/cp.rst
index 12a24e19fee..67360e30e41 100644
--- a/doc/usage/cmd/cp.rst
+++ b/doc/usage/cmd/cp.rst
@@ -19,7 +19,8 @@ Description
 
 The cp command is used to copy *count* chunks of memory from the *source*
 address to the *target* address. If the *target* address points to NOR flash,
-the flash is programmed.
+the flash is programmed. When the *target* address points at ordinary memory,
+memmove() is used, so the two regions may overlap.
 
 The number bytes in one chunk is defined by the suffix defaulting to 4 bytes:
 
-- 
2.40.1.1.g1c60b9335d


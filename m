Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E67EDEC03
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 04:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 353C583F80;
	Wed,  4 Mar 2026 05:22:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="kHnDm17d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CF5783F61; Wed,  4 Mar 2026 04:25:28 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7560E83E7F
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 04:25:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tp2uOSU2Uxiuv8+5RTszLSAt6vCHFXvQUgrxkCS1e7wMyifGWdKRZN3HaTnkWRU9EkRgaNgGQ2g+gH+2Nkz97IXVZjT8YgkE0e8LPxkJFvY8TpUiqEP6CcmytFZ+P3JNff+4cau8R5hbY3nBUT2SoD8XLGE6+1CG+MYRRzmNV6iwpFYFPv9pWT4ZB/jZdfOOx+7SGW1CKB4Ot5GQln0+/mXTOuimgB9N5aM2RYQBKt4t9MZDhll4wfYUSolejHzIRhlfCLS0ku5vsWdX7Mnby+5RZFCyOg9kWTK8JroAmIEoSj0kdNBHDupKV4jCB2eSvmCaPyB7/aCP3EOc8QeO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcUo6dtXGoc1Of83fjKtBqL6zpxJJj606O63+83iieg=;
 b=kKceD9IhTgy62tWoDg+PuoA3fRqvcw/T3Fs2J+UesCE9ySJg6dEnBdb2h/NOd9yrCF1BzpK9c0xcbCbypbfRvbraR8l871KakRHO7DQa+YjcWuXTLTXHUBJPjoqXvwhDYfPNdIfOAJkTniYybfz6HI0F4ruWtQ9qMBt7h2+sIwXfAOOR8XKnFyLj6uN/erMN/a5Koi7i62LQ2j0oMDVsn8v91Vl/UU2s0nc+utA504wvdlF1c/uT9IToMAeOQ/sp3fsqC4t9H5bXh/R/IMiWNiBb9oTRDndClTrcO7v9eeJ0yW+h5cHmgAfkRAGfteUhOYxxCVAHqtWDIJmQgfOd5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcUo6dtXGoc1Of83fjKtBqL6zpxJJj606O63+83iieg=;
 b=kHnDm17dpPxvGcvUUjWB2CBSDr9PKLrCVdXt7U77rvgH2t9twhH936ofuGsBYBvUxzb/IZGAI+aPM2jYJbiTk0IXMTPhFKrTnA9oimDXHFtYhIGcRhjl5gbY130xOAMphCwhWT2WnpO94JXVOFKyFdeII5hvykEa6sz9zxrHe7IuMDHfIl/Rm28KOsfJklaECVi7H9oUu5AhA6RcGhiPWpuBeixtDLvs8oJQ65vbKPaRXjxNdEzhjRxaOVxmPq81X6LF4QDrUNl4NNVnBNg5H9LS4UGqTJ2aMZDWaVbo2R0/nJlk3NXT+8szP49ViH0WbSYZNlwU2qW+Fq9mmxs5WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH0PR03MB6605.namprd03.prod.outlook.com (2603:10b6:510:b2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 03:25:21 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 03:25:21 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH 0/2] mtd: nand: raw: Cadence NAND cleanup
Date: Wed,  4 Mar 2026 11:24:39 +0800
Message-ID: <20260304032441.31558-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0127.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::12) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|PH0PR03MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba81238-3292-442e-5663-08de799daa39
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: D9Hqb+Dvp9ZEwUZw7sJWtJPbSQodmYvelYLPYJhfJcvCFJvll2cMU5Tf1HOj1oz+58BYI2vCaD+cr8mlbZtko/agzXpiK52qMDcW82DxuHyQhN0YWEtYE2oEzC+rBWpde2uIUqpfHatU3cuwZAaa3ZeBOeHdPvQflhjelbbnWpp5tQqysvZLxtuFRYiGt/Pu6JrpKZHa7qphOIH7h0X4RwFsbDfEtA+ebRXkg/fYzBtt9MDbKR+EUrWd/P+qBs/6DIOhsbhTJJf+Evw6p8isc/CipLqcp3GNIRICG864kEANJ3VIGPP74Ko5r0PUlCZL2GXkU7ycGhJQU1898ykVW1TcxOU7S6qTHcA/B3rwjjDxN57r5TAvdloUaQAOE+r8L/dugnQsi3g4kmP34Q5/KyZaxG2IkSDa0enMGV3yvn1uCa0fJ8CBMXtYLFiO1qtuW8nzneH2skMfxT4TusoZ2AASaRp80D45NXJaiJlFjJYEEN5LzlPKDkrF6NC9ShFHXS1gleTMYktzNVeDEI03uLWM4/qSDKFrI4LWVHi7o0lYjmptB6XjU2CNP4uyLDbRk40tLymzWGgrgJneyQi2DO4akgjJcbopYZ6reS0SBOY+EgpgAIP11X8xSm50xgKni0cXGZfNfucruDMEmFbHciH7rXW3H+siA7v+gCf+73QFkyxilHIcEQt7pBJ1IxUT091o8BulqpMaAv5QMt7WU61vKqhOsgkLcUlLmNYlaN0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bi+q8+zWRQN7U+INewdFpCNT6OjRNzjkO8+UTIC5eTg1xck1lpgo/mKK0jv5?=
 =?us-ascii?Q?GgnNTsYdnrA9ueaJbry6xc5BBxk4hZ1Bbm3tRyTjfb4Gdb6UmSgp3VrUUaXZ?=
 =?us-ascii?Q?JxxQPv0Ynapwtsbb/qqW5fEKOfCGPhdM3LzZ8JBPP6DX0E+exW3AFWiCgfAE?=
 =?us-ascii?Q?pWlhvNF/TP/0SVUP/AbMJu0EIGp3Q+jnqLQCTD/bnxN149LE/7RqbZzx+/Iz?=
 =?us-ascii?Q?JJdHatDyI03Ny1/Hoz4GgpqacwBeGvn+OaGOSVTfJ/avGSXoEgAOCBa+jphn?=
 =?us-ascii?Q?4FgsJazsqdPnfm3JT+uqLUk+KCahwVwzf08lUscXdCzuj2Wnox7Ur7VoJ1nk?=
 =?us-ascii?Q?l0xuUVqX0AkH2N2XO+LQIBxAF9LVhloYjIkz6Gd70bwIZNq7dH2J4/4vjBSJ?=
 =?us-ascii?Q?OWKoWCl+s8y0WfT/F+SZtDlnXaKyFI9xNvuYrVvKDrkVek8eNuqeYTWme14V?=
 =?us-ascii?Q?gCY/85rG9nml7Ja3TIN6mMSdIywAx3QztfiUUJ2MNcOUFPQUVEI77VQ5Ekmz?=
 =?us-ascii?Q?7AAw0oTgC+MRZgeuqv+LxZEKfw47uLwvnEz1/LugAOkNNn2qDWHiQc/bhyMI?=
 =?us-ascii?Q?Q1MSRGd3zCGdvDw1ltlJ0UhbkHiQmlxMJAUn/j3EUlbQgBAG2t4zfGnxwXn6?=
 =?us-ascii?Q?5Fkdhnd8+PZCAL/Di+qY/OYReTjrtn7LHqGDuW1bALvp9fXfhoX2JrFjOBmn?=
 =?us-ascii?Q?5y2FzVRaW6jEsd+5YyW8L4mmWl5HaCyDdp30uos0k9/kur2grBrZ/7KhLUcA?=
 =?us-ascii?Q?l9Clv+eNNntnGB9zWorRUVr5BRfaBQvQC7jwkzzKLSiYfcls9qnLlPFfW9U1?=
 =?us-ascii?Q?2y2rSPJ/4wbbL6i0AKz6p4V8B3UiRO3RzUxmfEyzcgjK5rTlq0d1g4+CfadH?=
 =?us-ascii?Q?FwOYrgY90psyqyIG6pKyb0wwNfvBW8+cgRITWjglqX5g/Ogcf/cjYit+NTb5?=
 =?us-ascii?Q?vTiVxmLqQ+3IbWWrDeUEYSqMRQoe5fg/Y2HhtjMx1mf4Y3xqLDNzEQ89b/jy?=
 =?us-ascii?Q?R98FX6te8Tvp2hzEIHqNKJQj8EnbyhU5+8q621KFqieYAq8/BxTeUPKuRmbx?=
 =?us-ascii?Q?80Enh3WKPiMpO5yzB/kt2pIfi50HBB9lTgRrmh9LEnEwabyM8BMiB4ED7zng?=
 =?us-ascii?Q?a6hybK0V2j6ai2Pn+EybrG00HO8sl0eykLJhtSXjah5vwQVqGimHj0PvmSg1?=
 =?us-ascii?Q?k39bie8sG50PKosz0wB0A2F2TW/YKeg41hoAMLa4N/IeyOs3l7BDFNfCEpDx?=
 =?us-ascii?Q?X24w+K3KxehIWEc7KKS2yheBAZLONPIri98/RZdTsnMRedSOMCWKFlGp4xA1?=
 =?us-ascii?Q?g+trQfhEVmq1RYsbVxdpiXEX/GKsp+2lVP2QJ8nETPmpd2vsKApr87QDDiva?=
 =?us-ascii?Q?hE6Hzzdd73uT1tVOCBMj7QnNQwzUUKCScRB4hDqZwCaLSHrJ8QEL93wo8jW8?=
 =?us-ascii?Q?9bfj8dz+yInDVjOLKgZxp/49LMeefloLPaR3o1j3iuIqd5wdzKXEDSWQCeH+?=
 =?us-ascii?Q?T5dqjacNBxaEfxqi21sYluW5E/4/ntMrfUqvk+a2cxQUFDVwq7WWz4NKdB/F?=
 =?us-ascii?Q?paZCyEuWcOCnNsiftOXH7eViaMOsFHX3JAIpPy4JUOuajT4wZW6i0lzL7E+p?=
 =?us-ascii?Q?tstwu4p8lr8YeoyWIPcbKYjAOfURtuwD0zme3SB84GraAehFe9UoDNCzrod3?=
 =?us-ascii?Q?p6C57TumyTxzUC7StezFsehlGYqT0991sqr3BQ+tMjaHLyt0XG2A/5/xlS6g?=
 =?us-ascii?Q?ZlGLv2OvPIlQeX0eHc6HxzoySKeVYrw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba81238-3292-442e-5663-08de799daa39
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 03:25:21.3409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myyq14sGhFYEyUe5LQD11/y9xm3euDclF8q/HIggO4UJliKkjl4TzyEbIBAY3r0YbICkGRbIqiaENHwXOQojRNqZpuSlfieTkvOhEKEQodM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6605
X-Mailman-Approved-At: Wed, 04 Mar 2026 05:22:07 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

This series cleans up Cadence NAND support by fixing Kconfig dependencies
for SPL and aligning the driver with the raw NAND MTD API.

Patch 1 cleans up SPL Cadence NAND Kconfig selects and dependencies.
Patch 2 switches the Cadence NAND code to use the generic raw NAND MTD
header instead of a legacy controller-specific header.

Dinesh Maniyam (2):
  mtd: nand: raw: Kconfig: clean up SPL Cadence NAND dependencies
  mtd: nand: raw: use raw NAND MTD header

 drivers/mtd/nand/raw/Kconfig       | 14 +++++++-------
 drivers/mtd/nand/raw/cadence_spl.c |  3 +--
 2 files changed, 8 insertions(+), 9 deletions(-)

-- 
2.19.0


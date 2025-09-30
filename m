Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C97CCA468
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 11:03:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3BA083526;
	Tue, 30 Sep 2025 13:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="q4vP3puz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D163832AD; Tue, 30 Sep 2025 13:03:18 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C78A2833E9
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 13:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5dTilSwpqiSbhoxA3bEVgido+gv9BEi2mrobfru0ZEuFqJ3TFydyrMW7Blb2rtHxzK2h2eV/gQ55Hy8BjpRsXFQqksq1TdXxv7dLq+cO/CKWBfJhWlsd14oYwy/E8Sd2Eh+VYVTlDCHxICaD6fed4ZWwcRsdbiAu1ij/PIXGABvIRi8W5kryfDOaFJeiH+nvMCS3dluwol3h169hXf3oPKvPdWBIQetSHONMbagCpxkLiyj9CJGB8t6iog7nvXBkKqzQa+2+v8lm1pN6TUZF2PTFQJ6aS6hmzAUkoKA6jyIwKcrYz/K8Yh142ga1Gj+VPQlDx2vuDAWv4npus2PZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9zyZKyTQaSgm1lMkwiSZ+72DosDPiiYpBkGakO4iSM=;
 b=X/8ICiD3KZS7kgUmeSi71pluNdZh7CvFyJ6OT76VcUMktHbgAtd8ShsD7qupfdQ6z3oBX2BnM9nWvih0bqyOD+ea3VTJ3aOVCHZ5VuezsbtofGMLEDCk5G1plMRAsG7LsjfG0TTzxhFzgaxDy6OQpjV1Qv609n89qwk//pTwxelo3ODBT8nft++Cp4WbV7H+CmE/dPTc0vyhOAOSPZnuFHm2EGZ4ltt3mKyid1cIi/tUOnolWfIPDF8WovznAwVi4wFraSG9GAGOPNSdmhbSXPjs5mafcLJdS8lJJ1HoDwHsiEA8h2g0SP1ZjaC6SEg4dLTatNvzS6HrFu+lgnQq8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9zyZKyTQaSgm1lMkwiSZ+72DosDPiiYpBkGakO4iSM=;
 b=q4vP3puzTJL6xFK+dON38xltom5YEyX/foQKCm0wqjCmjczLqkNFVYfsf3aDc085MvdVTQAgZ2ZUYY/seuheVeMwb0qNHIIMb8g17ljtLGtzFi7fL2gdx4TLHqxbxgueeXNz7+ovsaWZOzqbFcJ4cth9JztXJJRL0YRhSCb0FirtgfzKHrS5lv3ww6pQFtwvVM5KtDi7qStOOD6tKKQC5jk6+6L/xHCG1aIMTHMU5XsarZIypW7Da4qXBSCy3EWApIhoG6ZkZ9uYU/pG+w4YMRDxnPOM67gl8g9kpJ91PMVyLlTxksB26e2s+dIbmIrG9ihDUfUPsz5iIh7d7HLWcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB11605.eurprd08.prod.outlook.com (2603:10a6:150:2d6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 11:03:09 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 11:03:09 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v6 0/2] cmd: mtd: fix benchmarking
Date: Tue, 30 Sep 2025 14:03:00 +0300
Message-ID: <20250930110302.4031642-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0354.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB11605:EE_
X-MS-Office365-Filtering-Correlation-Id: db30f610-eae3-4a1f-e560-08de0010f0bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v4PL6aEl9+WHqHo8ISkYXhzqYEGma6t7DW1kKgIlv9dTFwKJ036nlTWbyHkj?=
 =?us-ascii?Q?q4RTJpwe9qM/YceeAg7FI0tP27CoSwcoYgI8ZYprj5Ijt8OebRlXin+sOz3j?=
 =?us-ascii?Q?PEElfcIxoU/B9zQ37KYuAhWqNY/oV8Pnl/ftkxYnQChK9IcxanbwxbUeyquv?=
 =?us-ascii?Q?d39WOunNn1HiOWD5Fs04SIQkkj7cgnVscgAmqhkn4C9ANR6rMgIg2FYw4lqh?=
 =?us-ascii?Q?YTQOi/ektbXfifCgyB1bJxzGDhosyGa8oiO18+BryGaYdL7C8F7IOzMifv0Z?=
 =?us-ascii?Q?8kOJQJBZnJfvmbAiplOPflDHcDxFNz/W+73sVoX5aOrA7ysaIxXEc5H4KDi3?=
 =?us-ascii?Q?FGOOFLdutueW9ZM2BfF1kjCv3KEb30kBPjevo9YV1p14FTYT/nC6birx84o7?=
 =?us-ascii?Q?bHBqdqqXxkxuZyoAksiWkGn6NiQi78PEQ6ABcYBUfjD6bOmMV5/zqy0DIhnX?=
 =?us-ascii?Q?rmEiaE1DpBgO+EiyhSA7x5dOdrICtsC1e3W6j1m7fqWJ+pQ9houkMAZXJquq?=
 =?us-ascii?Q?c+GBMJdVVNyiZex5iIYaNCajPWiH/8fLNhBuTrt7aSd52UEQlaG2VJL0Bfvp?=
 =?us-ascii?Q?1oWLxqWeUYGhzHmvMqiZQaiKTKxLdvTh54GKiIzovo9oNBjOMLpghvMdibRD?=
 =?us-ascii?Q?xt2PfvmUVA9hCJjpeWvDbFeC4RL4OiJBQwTFgyaJYRfAabf1gi142Fry/eRQ?=
 =?us-ascii?Q?5wLBFEgBvfkCs24nwFzpkYGbU1D2rFhshwTHBl9BHso42IEb8VJNHye0gA0n?=
 =?us-ascii?Q?AmAZbr8ZCNoWc2rrCaSrqjDeVwG5G9srVc2Bmi1k5kEMFcBgBNfy+66X9TJx?=
 =?us-ascii?Q?2turLr3z2W+I0VqYhnqW0O9+gvlk3NBr4GEFHAlk5tfVQJGQ2cLaCKnHI2ny?=
 =?us-ascii?Q?K7vrQAb4+zZJtZ2gCsJdEUtHdr3KVlmQIO02pScIEyBOEHEycSQwhIy76Vi5?=
 =?us-ascii?Q?teO6WMh0TMMFYerobqSu80d7Liu2OVF7pNFJ1fPAgOwLXliwwBRfoUXn14WD?=
 =?us-ascii?Q?epzXos5BxWzWe49WnKDIJ+fKVspU2kakhMMNPma9mwxrAU8ampcpJF3Pd7Tt?=
 =?us-ascii?Q?8gMZZoYVgHXNREvAuTer5UhkDV3huKXP7e5LTSCp67rTdew60S5VTNEvpTim?=
 =?us-ascii?Q?oxGeDzYDm4kHumvi72HDRW33HXbBeACL2T+K6meA5lctt6VRL4rI7KXw+ZIl?=
 =?us-ascii?Q?Wc4yy1VhOYT7SaYEEWBC3CXy0Y/Z3VOHD9aBgrZnK5BmIU9iM6PDG2fvKBIy?=
 =?us-ascii?Q?uWLcZlAysN4D+55pmFHqA08kbBncwSyYj27T9PjxbIsoFqJWoJSS0nkPxtFE?=
 =?us-ascii?Q?AL+OIxhlzMpGOi/gC4uL4PtgZHW7Fu7tplqgHO0nrx+wyTiZDxUv5lHivcbW?=
 =?us-ascii?Q?q4n2FifHut1hIW5XhGIJjqANyRZczrFpLsc/LI/asjw9HOqe37TF3Ha6fB10?=
 =?us-ascii?Q?QXiKvB/yBvxd+wGEh2Dji5k/o5LWGIIVhuPbc76Pk/77km0jS1xkKZmEl9qT?=
 =?us-ascii?Q?qtgSQVKvLm4JUZZySx8Fy3hB6wuFMLvgOsyg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CeCxXksLCxIkwAj3WZoElWfLXgOjQlbaHR0fBmAyx7TBhSRSMKtQvV5P8POb?=
 =?us-ascii?Q?Gq2zIXIXWljaX++kEG6oT1BCZPASNkJcjDv/OWaTltRK7+uUDGi+NHovYUF6?=
 =?us-ascii?Q?K6HG9Z62j83H78PnFmQel9yOZQPrvB50mz0P4J0lD/lVeK9tEYYgNjESO3OW?=
 =?us-ascii?Q?amPZy6YthIucaXyrjDec1l8RZC+FNW3t5GFTwWM+RiVv7FYFae/zx71lVb6u?=
 =?us-ascii?Q?Qx7GWDObCxsJvzWA8M8QXmufWTTMGM2miH5V0waOKclk2BaEZnCuSizibHdc?=
 =?us-ascii?Q?7o9zRNqS6ik0ntwi4pE3GBMKiCpuS6MKMiYBlih94UEwT6oY0/qwanRy9kwa?=
 =?us-ascii?Q?ssZ1wSysfxp+gDMb7+JH5HhB2SY8OgOdZ6QKrBnGJzlIJIsrV6RtTGjcNtMC?=
 =?us-ascii?Q?npEdYNyrPEEbkgZ7w8MyXXc459UHSquH574drIZjTtnhRapjRp2ok7mLC+pE?=
 =?us-ascii?Q?2cXb0Iy3BCPMc0CQGtpw1UmVnu4yvW0laPN8V09sL9E9+GCTWXeJgVyoTwZ5?=
 =?us-ascii?Q?flhKtMhkXmc64IgRi5UHDJXBmxfRWVPtUVaA+svUD64uPzuXLc94L3Go7nYn?=
 =?us-ascii?Q?jPlxw9GR2atgg3JQZHDN7u7CEj1f9PO4pHhvQnCXONtBdbC1i11VP/7dd9TB?=
 =?us-ascii?Q?rrZYV/0joPFsUfB1c87ZF649veBXA5vl5/DTHT0eT/GTDkyTagUUUxjDHM7S?=
 =?us-ascii?Q?rDIO+u7ueOZuihX/wJly1PBAaLUC0ZxGdq4qxfH/Kib2KkMVTX7A/GOmriN2?=
 =?us-ascii?Q?PzfKe3Cx9o2lmJ7xa0hSn5R+f1NNw6RVMeM0CwbaA3cg5XYlUUEBUPX/JLQf?=
 =?us-ascii?Q?Tw7MtCymQQhgoG1+kPLRjHzwcDC/8ytYFvXR75y9pFdSCVbDUSEilYGdZUvr?=
 =?us-ascii?Q?GA7k4jd+zPOH5iBiKLghAgvjBSoMdNFnarQqHA9CD60Nny7x0K5QuxmRKgrN?=
 =?us-ascii?Q?POte0M4oSr0OBTM0ZZL6W0wxkX0TzscGWv0dijLNQqaMp0+ynFn4qVTxWriY?=
 =?us-ascii?Q?ZJpdAU9RVjGN1VUqrGsRIVG7TQvWxoUoF8pIdiXRO2+dCuMpeVge6aQl+sBF?=
 =?us-ascii?Q?3+/J1Hc5pP6G6hRzlVexwmsAyYaRY1b2Y0jbuSZyhTh/gKiSHJCFAmlJwP8B?=
 =?us-ascii?Q?WuJkr+QyKhZSTy7daB9fjWfY9gOiq9a14gNJM4OK4A3fCdiPYR9E1aRY4vG6?=
 =?us-ascii?Q?iHsU7cnwcnDX9N3aeIfaDtxviah+kQK3TyGayfziRfn69cZvAuNJOPzcgfKj?=
 =?us-ascii?Q?h9irSyB+oJrgHR054TLA6O7bpv9y6jgTiUe7QKAmExn3JHxhPeBPVDOH0XVp?=
 =?us-ascii?Q?s3pakNSqdKq+ZmfwFmtNDe4xx41tE5yj9At9tKyMNjs/UFUvgOKIRpgEZtJ0?=
 =?us-ascii?Q?D/1+Jw38m8aUrAjW8k3fO3LEcyg3FPPwMKbe3ZjQD7IDl00qP5lbAEK7Wp0W?=
 =?us-ascii?Q?iWa8CikvED35XuZXBblAWWRjM+nOE4v+Y7iBjgy/OSLusN0FBhYJ4P1PdNuw?=
 =?us-ascii?Q?x6TiWjNhvmq5t2E+gKduaK4TScWxvcyU5+aNrsPGakA3G8TDijSBKbIKURPw?=
 =?us-ascii?Q?Yvm/KdnqmArlM2TFIfrU4PCgAKlNdNdOL8HPKjPUPmJtHsDP3syzIIWJlrr1?=
 =?us-ascii?Q?wkJikvvEQTzpkAiNDnR+oak=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: db30f610-eae3-4a1f-e560-08de0010f0bb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 11:03:09.4114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CKvzc4Rr+Ol1GBoNhBRdyt1gBr/tpwYJF/YHMeJoPQMtgKAKPdPX4a+WTgnbFRI3w7epIILB9TZM+xX0xEw2xumMefpsuDa9BDJtx0G11w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11605
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

The patch series fixes speed calculation for nand device case and
updates help to refer benchmark option presence.

Changes v2:
 * update commit message
 * 'Fixes:' tag was added
 * calculate speed a bit more precisely using a 64-bit math

Changes v3:
 * split on 2 patches
 * update help for 'mtd write' command as well
 * format help for 'mtd' command to align device names on the same collumn

Changes v4:
 * attemt to sent incorrect patches (sorry for this)

Changes v5:
 * really rebase on top of master branch

Changes v6:
 * rebased on top of "cmd: mtd: markbad/nand_write_test/nand_read_test" branch

Mikhail Kshevetskiy (2):
  cmd: mtd: fix speed measurement in the speed benchmark
  cmd: mtd: add benchmark option to the help

 cmd/mtd.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

-- 
2.51.0


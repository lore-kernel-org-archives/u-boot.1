Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB87C3ABC3
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 14:15:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABE1C829E7;
	Tue,  6 May 2025 16:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="U5Uq/IDT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76A7E82A3B; Tue,  6 May 2025 16:15:20 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::613])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4DE0800C1
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 16:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7O3SefavxOE4/EdSpG3NuyyN2BzO/WRPlyU6fElRmm51g5jXHhwssvvwhABB/CkbbzjOzaOTcf+Ulp6dF/yOLn//Nab+JNtxIEb7uN4d49iTX9M/bxNUPIa/ERa5VvuHSkmbjFpaNuB1MXcIVGo7JJamzM3eAYSnuOte9zwaE/8ZPXnTap4lkevzV8+aSSH6PAY5bnItdlFiKeBScP6sInp7yyrqi5cys2Msy4aY+5H+gPzNcefca5yvdMcB+DP0Ct7i+3pcPJhI5ptOysD8ukpgtyhhvBHQT4RiEQ9jFfwEe6lhXmPH2wK769SApoZ+JcQCCzngXvpEMzPCyb2Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPy6PlNj0E9/jxbmi+ypJoJjalBG7Bw2294jzLbxYdo=;
 b=frlpv0ok8fdUAOUmkTLYS1RWTDffc7ISwEwS1aMATH9TW+nVIKU9huufQQvsKesEA643cR8+qNMXocpvj9gStjO+GSagsF0XJEc3wG73ESIx1b6DMqhp8Qy2yDa59VpOqd7a2g4y/gmQPf0t4NKBi8zxWt7IWfWbb/73hnD06qp0T1BPllA+0j9/4W8vFLxUqLIjLD+F7dSxaJFMweoafQYI6RCx7sM/Krf4iPuaZdmCEW6L9hC6gxYyaNuy2wXO6Bi46Cg7VW1vAc3ap0L6vaOFjLa858VH+XR5YpXf/jgc5TDvmegy+cZ2UtfNhBemQkhaSTHGklRAjw/R+3xSNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPy6PlNj0E9/jxbmi+ypJoJjalBG7Bw2294jzLbxYdo=;
 b=U5Uq/IDT+uZ3up8Wm5WAAgDuYWsh3cA02FMYKXW0nUzfvBkmASjigcJXuaf+Yci45axPKu/WTjhFUjzLOy0IbmLQGXvYcjjF1UU0qNMFnx+Dork/ZOLCnGgnreE/4oMS+WeDgzcoQAbTfJJvzk4mu0bVp0hHJaQJHKk5Uk0HEyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ca::21)
 by DU0PR10MB7237.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Tue, 6 May
 2025 14:15:12 +0000
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bb5b:4bac:5471:b769]) by DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bb5b:4bac:5471:b769%4]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 14:15:12 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 00/11] regex patches
Date: Tue,  6 May 2025 16:10:24 +0200
Message-ID: <20250506141035.385756-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0105.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::14) To DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8248:EE_|DU0PR10MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 18539711-afbd-449c-4404-08dd8ca86a3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f3AfzwTs+ILZzi1ykpcCP6NQP5rms+bVtf9YP3okFDZUOTq69ymLb1kU+P7G?=
 =?us-ascii?Q?Y3cnGu5SIGkaltKXdvU4V4d106suwL7vKaswvN+UfF/rMgx+B3f6AAKlqGX4?=
 =?us-ascii?Q?ftGJINgbeVaqWJY/sgkPSW53oY94QrDwzSoxKCMIHFqnLvlYb3yhAH9vSMl5?=
 =?us-ascii?Q?DRwK2g1dpC+mFZLpzALWHLEafsOGp7pCiFKSsH4NE52DOse8YOfl6GYrvfw1?=
 =?us-ascii?Q?Sja+YiDhprkbCtAJSnKw4yB+SnFijnIPMXFh3dfd9Ack4W/ZkArgfL0Wt+Rj?=
 =?us-ascii?Q?fvM1vzWZVQl/vqGQyclXlvT6koWs3q6snllXpJ2QPVM95I8S2nn0s/TdlQYZ?=
 =?us-ascii?Q?sXn4TJ5qn+F58tSoHrTFdT92mH59nhd0V19Sj0BSQ5qd4xMsXqruvSNi33MM?=
 =?us-ascii?Q?niesQcRVqGoGhg3qjpHyx+7q4+JTE8+486t1hqTgZ8jxTFlwsSTRQJcWP0UQ?=
 =?us-ascii?Q?82xPNwP2Ws6+wCEDZRBFFeB3Tzb2oKJc8322mF5Q6PGz/Z5zdj+FMxY7b9Sm?=
 =?us-ascii?Q?2j62k+Wd5rjss9eAezL1/dPVw/7fK3TfQqQC06uO4iQTsriIIZWyc7Ae8kXW?=
 =?us-ascii?Q?N30/yDg4VbQtTn7+rkJQqNuX612uQxuo7ZRDzRSJCm3Xw7NxvHbn85m8cokC?=
 =?us-ascii?Q?vujPGbexRfkEoFSbviMqbZDrpwC0pN/9b6ind4Gq+evkctGsVQwxq6PIdDGg?=
 =?us-ascii?Q?mDYLZPft0TcFYm376UDnRsr/dN1zjnxrBPr2X1XXN609ey0pUPGqzqSORFVu?=
 =?us-ascii?Q?1GvN/y5YA0fYnIzsOYP1K8UT4Ql/teKCRULq8L5+YdeHXCf6epPWz3m7lMVS?=
 =?us-ascii?Q?2321MGUY/i7PppW688P/vsuy3SzH+kLdoK0mMqC2yreazr2d5qedoi2bUXGX?=
 =?us-ascii?Q?CAN1EvPNpToXOAtk8Z4/pcLLp5aEC2OvqxVqEX+oj5GqIvyQRFIMHJqQ3Wkr?=
 =?us-ascii?Q?+m7dZrhmIG1WRGDn5JrjvrlWxiLPG85yF6zlfZyPVRbxixLqCpSlPpgk49dT?=
 =?us-ascii?Q?YYx93wkEFqry41j4VZoZQ8K95Xkyc4dXSeQQv0xPOKDtF4cPfjxPcQ4z3NX2?=
 =?us-ascii?Q?c2K3nBsc82Ri2zLZtpY2Pba4oTL3PlU8pALPeOo1bmb7Z5ZbI0cemaAZLl0r?=
 =?us-ascii?Q?giE2KXnOyT1aGk+s+adpX3XoZwUvyM99KDzgspo9lf1g9OGL0y6VaeFrtpBo?=
 =?us-ascii?Q?F0e8dKbXIv8hAjfhnBuaAl5VLJsZnyQNNFex7cvbwep3Zv1nUUTdaMqtgZFj?=
 =?us-ascii?Q?Xw32xifgnTzFBs5JZkNbi1HkGh8rXVcjabmT73SyhpuYMvR2/TRQqnSRz8a/?=
 =?us-ascii?Q?I66gDiZarMyLlXXNl6iHTqstqGHRnf8LW5pfohAsdj0l2sHBX5kh0wFcJUO3?=
 =?us-ascii?Q?40ciK14QFcWflSnGu0YrUY4II4oOyrSHkbwj7B1zFaiI71JSEI5gQ8baVB26?=
 =?us-ascii?Q?oTpcoSgbPjuVGz9ksa72PRBXOE3u0H2rMyDTBLLpiQisAOEItVT5bQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nD3RoyEgW9iETCdpBFFnlrVNT7GgidxaaFwylm9f3R3+KO3YJAdK0EnV79z/?=
 =?us-ascii?Q?1ByTWJ3OxzbNLB8Jkx5so2G5CgaqCtuEbWhVaIdYA5Fxt9i4Cd6Xounds76/?=
 =?us-ascii?Q?0UfTO7Yu2SgQNqJsDqwYZtTjQvnVSKrE90utvs201GT+fnkl+4MfGSR0hRO7?=
 =?us-ascii?Q?ReKlmTVir1D5wOxXNfiP8U6bdfexIOwhaF9lV/2bX7CDGSEqI5hgdceHxksO?=
 =?us-ascii?Q?sICLdClbm3zvFicHQS76/0UXeQk5HbnD4PizpnRT9IsUf4ih0OTxUs6EZRFQ?=
 =?us-ascii?Q?f9vdunHb5xNk5dICvkijXoM05wjkK7WGGLKGGP/eOsw049eawiVOeb8/sLa3?=
 =?us-ascii?Q?apkY16vx3/nxedkQJUo7BHUIrcMhHMtHJpJH9LzlkPzQ/9HPsTE9FnKC4/Z9?=
 =?us-ascii?Q?Z7kTazzBkrdd3e9+pjdH57bmBWA6uxh/VTJlOMhhluYZ77D1GALe/VQzq5fv?=
 =?us-ascii?Q?uOowK152hJXogFyMBDB9K9efhhLqiqtFUnzvayaEMGcOutSCd19ada334NoF?=
 =?us-ascii?Q?JQU99GYj0A7TIzpG+PQyB4by7Uc2CwiKGR2LMHCYfqY7+Wqt0fdEYWxOxslB?=
 =?us-ascii?Q?NBT9S9pcyBSXRH8EexsKmh4GCXgdKPfAzFoJxN0DqUCqNP82F26g8QBWrSA6?=
 =?us-ascii?Q?6/Msnjsh1lTddE8knT/lhHh8v8Azgkq6AIakXj2doH8DQfuY7EzVMAt4+Bnd?=
 =?us-ascii?Q?Z+2uo+B7zBsKtFFkTydlx1KJ+kU5URgKuF08sFNeeiYr/G5YNtYa9u2q4VYS?=
 =?us-ascii?Q?tPQ3fREwc46cDUz3WEm7gCNmBAzpKbcEKEa7+oWQP/EtRo1Wpe87B/QR5gmJ?=
 =?us-ascii?Q?X2jy8UD4gWNtVd26SbEQ+HVV7C5hTIlmvOh3GdvF/BWVqcblNNZjq9q6mIEs?=
 =?us-ascii?Q?iYbZd5lKpNXt/BnKF5/ABBXlkbT0UfsLd//NEDbzXepMhdWNatuPaLrfBv4T?=
 =?us-ascii?Q?Io4oMt20nySaASRWrIRp0Go54TD3P7CgEJmdlQR+UbfQVBh2LCVo1EyVUVhN?=
 =?us-ascii?Q?fUcie20BY2ZxVxd0GTxLEV/PC2zH7Nc4TPq0FM/yb26vz0/StifVnsKP1zVz?=
 =?us-ascii?Q?BMTCDUDGPaJBFkKTCdD2JbkxRf5/qjzQXb+HkdpmaZoj0GmbcJvU9eBNFqS7?=
 =?us-ascii?Q?bgdMrbeYBtLJ/+OmidloxS49AIvivECyQAmfVSTCYibUz79lbGdnmK4O+OI+?=
 =?us-ascii?Q?7/Ku920cr74jQ5Fwv0ImmMEKZlIfUOS9VG12/H8+A7XTHf6yfXndfTrRujzf?=
 =?us-ascii?Q?FGpwJX6zqST8sRXAAtY8Aaj4JLZKy/5rg0Hfh+1ff+cEy4hHATW/GOe8yHWP?=
 =?us-ascii?Q?aeglCMg0g3H2KaQ/qXw9KL8k0j1VqeQoilNS00YAqshf403qw15LxMDx9stl?=
 =?us-ascii?Q?kttk1EG7dBa077N0g4Pb/yRJHmHRajxo4zr+kH+Hr8AXIop7gM+UuLjUnC0j?=
 =?us-ascii?Q?AY4UWT05e42uCgenGRsm+9fvEJf5pDQ0b8tkx6jsuz7PxTS0Tc8e6qtJkDQt?=
 =?us-ascii?Q?oHUVA9RPnoCqvKHQQUCQXfc0oJjXq1kYkLiJmclQdIoeskmKXmeKRdiNGR+y?=
 =?us-ascii?Q?PjCOnbqSc/GHvMh0l/4YZg9uZYNnEyh76tFibD8HpeNb+xx/BEBvhIWhR7ZQ?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 18539711-afbd-449c-4404-08dd8ca86a3d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:15:12.3559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtkxZr9WZJnRwcMTpTFrkWYL6FmoydwlO6kX91pgpiqhC/OfsevA6XIXlnvmsmtLq4BwuD2eZ63usMPUypuLtqn1jkoouTIM7nrZ/jVrekE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7237
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

This started as a rather simple patch, 1/11, adding the ability to
more conveniently do regex matching in shell.

But with that, it became very easy to see what the slre library can
and especially what it cannot do, and that way I found both outright
bugs and a "wow, doesn't it support that syntax" gotcha. I couldn't
find any tests ('git grep slre -- test/' was empty), so I added a
small test suite and tweaked slre.c.

Rasmus Villemoes (11):
  cmd: test: add support for =~ operator
  slre: add myself as maintainer
  test: slre: add tests for regex library
  slre: drop wrong "anchored" optimization
  test: slre: add more test cases
  test: slre: add some (negative) character class tests
  slre: refactor is_any_but()
  slre: fix matching of escape sequence used inside character class
  test: slre: add test cases for escape char in character class
  slre: implement support for ranges in character classes
  test: slre: add tests for character ranges

 MAINTAINERS       |  7 +++++
 cmd/test.c        | 19 ++++++++++++
 include/slre.h    |  1 -
 lib/slre.c        | 78 ++++++++++++++++++++++++++++++++---------------
 test/lib/Makefile |  1 +
 test/lib/slre.c   | 58 +++++++++++++++++++++++++++++++++++
 6 files changed, 138 insertions(+), 26 deletions(-)
 create mode 100644 test/lib/slre.c

-- 
2.49.0


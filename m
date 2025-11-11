Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C6ACCFA13
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 00:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6615E83AB8;
	Tue, 11 Nov 2025 01:10:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PDPqCiBi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC05983AA9; Tue, 11 Nov 2025 01:09:31 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F6BA83A94
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 01:09:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZkSj2/m4Q6c/LtCxo1u3ctQSuY5gYLvditYa/plEfVwfiF2DfkQ9pJi5PlEvPGnLCGBfdEjWTguK373HBXArxWmXbmBtQRB98jPM9JwriFxwqnFlFfDp8Ca+CO3om2J351U6K08Z06B3f1Lh23rRjrqGO+uc7KYvzjfx9iGopN4z11HBdd/VTRpq+OQCAn4YCcmP9+ceXeYJaBUCmbZnQ4gDzGhRY/q9144AoAVu9pAHen0E5OEz4qZhiDptGea/OD8HeYBcYZdsuvX78CAGtkfzOunlUyyzr8/cBycermkZJcN2Bb6lynOrCbX9196Eb90L/jxma+yfh19gkNu3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNXOy4SYc9GHsJHguj6iKCI4C/nmbtCM+JgvJFJPgHc=;
 b=UACFGNhQ/6c6LQTNs8ZRSOrSMKBYIf9X62wsrLFu+zc+ofj46Fm5oM/nYiS1EQRZssOWuaij4+iJo0NVJEHFOhYU8rQTN5ZUEXXACGnVkKn8s722kARwVvA+80qITrMOc41qunaCei0iRHsqRm2UwKokn+iKUaTbVmrHgxGclnjPd1+6UrVhplOEQRQuQc8DmzIdDmcqwzHQJX39XzXxTcNxmdGL87qfPXh7A6Cfy9Zi4TF93XNt2tILDJ4a4aEQyirBE9SaESIqPE+VlO7lAqcSqpVslVGjy/h4QtPjRNKJPTkjuKPC1iFFaSsMinZyJBU+bI5iFP7jIqznxes+Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNXOy4SYc9GHsJHguj6iKCI4C/nmbtCM+JgvJFJPgHc=;
 b=PDPqCiBiIoF4QF7Qup1qoEaTtKAR1YBvCb9F507v+joYg5TD48mQrjJLuUJ6D+ezEK51+wztUfQdiaE3X1UjdZ6hoE/eyPCGc42nUOpsyBYEheslorumM8K5aLdS1ml0bI7FU4InBhmVP5iN4IzWQ8bW2743nStAMF234jDM7l5dhxfhxD24TNxbzgSDYUZFpVv9sbuuJ4GxB0ljWI7XTOpobn/vsu/fe5xVaYRhbrjWnXL4jn74CLZBv5Z82O5/w02su0CPmmxXfiUow+fubeozb3dlvidgIxVsGxwSPCxF+dTIdMx6MH6sGLRs43NJ5NTN0WuDKBB14J0Sccttpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10192.eurprd04.prod.outlook.com (2603:10a6:800:229::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 00:09:26 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 00:09:26 +0000
Date: Tue, 11 Nov 2025 09:22:04 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] please pull scmi-master-2025-11-11
Message-ID: <aRKPvJEo6IbR3d0b@nxa18884-linux>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB10192:EE_
X-MS-Office365-Filtering-Correlation-Id: 15313fc5-0dad-47bc-9035-08de20b6931b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JYE6KitT5RlQ1Nq8yIHEKOl22EduYwkzbB+jCeY9WCGDT4O1/UXEZ6j9wIEB?=
 =?us-ascii?Q?LTA3jZdqsOkPNpqquecgfr2n9Sjx8yiJ9y83+hriKjxQVsKk4OV2B9dW+B3O?=
 =?us-ascii?Q?x6qLBzbyglzjx7ytjea+iBkSTsDf5snI6+FPcOJU4MnEuza72bgcQP8BTas9?=
 =?us-ascii?Q?9wiL84DKUkQKKqoS4eVptWdgIoQIZNQjsP/TfwMGoPYRtYC4hW/YDDUs9lSz?=
 =?us-ascii?Q?RMy4Kdsyk7hNCHd4uobP5JCv95MLrRDe532N70WJADpnFCXkrvTPVy38kk9k?=
 =?us-ascii?Q?kgf/Gzo9ZegEfzYwOgvpYrSsxudKUbJiCwXYwUHKanANMNPC4QUnXWP3wblX?=
 =?us-ascii?Q?GvhsG1RMCYESlEplZf9jDyi+WeOXwiud0nVk6Jqt/LRyIvRdZ6kzrl0prxv7?=
 =?us-ascii?Q?dMFZ9JXsFntY4kYgK4oZp7+JyNSvwp8aPQqqk2F5eidezZW+HsWQ7WqeIFpH?=
 =?us-ascii?Q?CWSjXCDlJfTqFi6wHbSm1ntd5hdBlkIPrRFOke4AbKKq8m6ruw2UKnb4JcVH?=
 =?us-ascii?Q?sn502GtLwUae/EtJ6zBrbj4fJ10wQJF48tiw6MURBon2r1Uub/pgBRyxfBO4?=
 =?us-ascii?Q?1c2je+2Wh7Usjuv8nCMgfrigzwuZq9RDCHgr3f5D06/j3Rzv/sc91MlPEHP3?=
 =?us-ascii?Q?MAUd6wMscoGhpHCk3ZvecIpjWaAyz+BUWvy3yuqXyrPiYBw5D+j4ZmeIxDJF?=
 =?us-ascii?Q?PzTLn+r8njKtQ6G+OCUcWJK6C52m1dWmDLj67YYutiIjmgWPV+XP4ZYVNTZR?=
 =?us-ascii?Q?UO9eU2plLpH2F8TYvfak2+HIv5Kr7Ld8ac3Yu/LiW2p8wrFRfRGgd1P2DSWF?=
 =?us-ascii?Q?JM/eNM6P1RMGOE/bAk3s0OLRaN2ych5EAlDNedYX5BJ3l2kZqwh0vm9Ji56R?=
 =?us-ascii?Q?Xyr0I75N7Nm7RltGSdxO8UXnbq9x8CWhjuBY6zJdF6949Et3CixTDyGWO+RN?=
 =?us-ascii?Q?jvnHsxuTMXfO1U/LfxUsqnA6V9wK2+advyQjjEBkj23H7eC7Y2gCL05/fuwY?=
 =?us-ascii?Q?ABZ30zzJziFwlA9yGW6JbLNX5eLjvQKqxt8tl1+mvmc7Ea0O0tWTUvDILgbQ?=
 =?us-ascii?Q?01pYjhB06WCx2+s3PkMEmhHd8rSjuzc5gvKs6dMCyw11iZGNGnqPj/0/SxCS?=
 =?us-ascii?Q?cv9u7f9+0RMG9MbAvNzF52U+vkMn+2JuW5HqbKlLPxV5SZ6pHmTuM/rPhIYo?=
 =?us-ascii?Q?Qp/kiElT/kdclLFotPXO8JPDL7XNzABHwmE98Vwi9GiBXlo/Ewmlabd09jLO?=
 =?us-ascii?Q?xIsupZ/JUCMm1GhD3xEkHsup154P9h18lnJZn4KaFsAsxFaa9qx3on+I+SSO?=
 =?us-ascii?Q?T6W2/cMvPf3dzDS5hLQ8TlnqrIRtmHeJSs8LwPNPX3n/hqIhryMCr/QT9rvD?=
 =?us-ascii?Q?UbjS5FvPt9InhxOoPaRlDWZ4G4rrCFIiUZRusRWgpTz+hVHnDQChwYdGXj3D?=
 =?us-ascii?Q?+0bl8DVn9XWyQUnukqcJKwbgDRV4Btqwv2xCpZlbFmSiSbCLEh5u+A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kjfX+9QXVIiuRvXDhVGB+r4rzOjSMaCR6BVWV4GYe0Xx1Gs+Hz1gW5v/uNdD?=
 =?us-ascii?Q?bCZDUVNN8u2ytkJA9SqeL9z/bq194slHvXs5AQoaXlOZFxpBvZYGyGJ57m38?=
 =?us-ascii?Q?JIvGB0yLwnCC/ekae5OcSPo9eIw6da+vD3rG2sh46uFG/S6kGWySGs06h9cO?=
 =?us-ascii?Q?LZc7UBaxvagZciFRH4HPbjGp9cM8FVOQYJOBTSy2E/pFjTz5DLK0pCoIxsYN?=
 =?us-ascii?Q?o1CLksU85U8NjvsEhlU6Q0HF+VZx0RmFsSlIFRcvWDwGMrCho9PuMXS1J0C6?=
 =?us-ascii?Q?Nep0FsTJvmeFd60USN0Dy3OcGCxrcGL/x67np3ZxOJa1crL2gLKnvfrhE89E?=
 =?us-ascii?Q?1RgjZxa9uxm0xHNo1dij5vj/fLO50JSEji3ymX5b3TKlv6nFGIi1tEEc7I+1?=
 =?us-ascii?Q?KMPx/OcSv/wGhnX86vw3RUckxST7KRuNUIlDn60zdYd2Ofe4UxHaqaysu/Q/?=
 =?us-ascii?Q?Vy4v/BT7uO1HSDMjfwwO+1GL127F6fJ1wg5PBDkLQNpt2eurWKVVhkEsc3zj?=
 =?us-ascii?Q?FuXax64jtS33fKwRKzoe/Kpk9JlNFgClETGlo+3pCD6FLre2aMqtsrkITpz8?=
 =?us-ascii?Q?X0adf4WGmZMEzWIOv6WnYRqht11BuIIrH2A5EePYizhohE6EWwjwNsDa/5Vr?=
 =?us-ascii?Q?6WKKOVWFeuXixILi5C9JfOq3RoMncYuyQ40iNdmD9MILPsvhRvan8tsVpPXd?=
 =?us-ascii?Q?SyB8/V7DIdahmfPwgG59TFtoiUpw9WiBqsYMDtmWZmRVFabkDUeBxK6gEnnW?=
 =?us-ascii?Q?urK3vmDSyMupdu38V2Xc8x3v0rmgzRKTjfLJ9+sOuYogdYduGeHGsVcp8Wrp?=
 =?us-ascii?Q?8S+YBE85uDtPoELK0efArOqsT+5wLYsCGOg5rwe+OtRHdYc/97JSrpDZTLCd?=
 =?us-ascii?Q?LisfYp6squuhk30cybZeT2CHgP9ul58dKlTdOX/3Di1+tr5Z9390orOqW8yG?=
 =?us-ascii?Q?KywLFTmqupHY9kKU8xAmGEf4qL63H3SWX+dkBrlMy1QkNVQH8lnYcJvX+2ai?=
 =?us-ascii?Q?zRm2IlrLDCn23N5ebUFJKKb5568e0EfC0FsmEaw41VNxMD/3kY/EqsLoKz9G?=
 =?us-ascii?Q?6GboKPAZ0DWehtguHKYf6McSQmn4LocsMidKwhqWW/Afn8I5vyhgH859CHTn?=
 =?us-ascii?Q?f2vf2p5d6DVpkReF+GMUms+Zg6kB4qyMbvNoGUq1GCr6r6MH19+lIsmKAeME?=
 =?us-ascii?Q?hksqFm59KM4MpX9i2JTMUOw7t1/ZWVql1dM+mLEMxBsgLwut44P0WK7GIj03?=
 =?us-ascii?Q?5ESRS8x/Lntw83frzMpByGUZ2rVNs6w+Nv1jYgxwAkXn7Kx3elpoXFgxsKsN?=
 =?us-ascii?Q?UwQ8s3ALsm01odKuFQ6NKgzoeESZDWGKFKmHoECXDr5xmHyNTK4Iwe7sPuQg?=
 =?us-ascii?Q?nJG4xTyuL6/FUqnfGVZsa1/ptRo+Gn94eLGeDtsrDIo8o7KWmDvbXWkwaysd?=
 =?us-ascii?Q?3xCkOb5mcw7jQRyQSXdHdiNd5xIuj+fYW8Y8+f95QlxAYYPHHaWVZEOQqHbB?=
 =?us-ascii?Q?wB78Rmrk2UUZhe3EXCGnXC+HNxCPuu5Y1uzr+Z/EpoGJdRMMJ6qxb2aCu7EH?=
 =?us-ascii?Q?HJ+07XZZhxo5PQfxZ6ll/3kyjWY1u9UBGTLZnDee?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15313fc5-0dad-47bc-9035-08de20b6931b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 00:09:26.1135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQ2sQmPLkol2bYN9frVIyEHSCK2y/VtqV8lkDr/IuZ1nzRavCboZqE+WCuWuanBenoS82NIatEvyWDzOY5R38Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10192
X-Mailman-Approved-At: Tue, 11 Nov 2025 01:10:21 +0100
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

Hi Tom,

Please pull scmi-master-2025-11-11

-------------------------------------------------------
- Support scmi v3.2 CONFIG_SET for clock protocol
- A patchset from Marek to optimize the scmi clk
  booting time
- Fix scmi clk set_parent in non-CCF case
- Drop mmu_set_region_dcache_behaviour in firmware scmi
-------------------------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/28272

Thanks,
Peng

The following changes since commit 6b27b6886945a9351fcea8c9acf9418844f46670:

  Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh (2025-11-08 09:03:54 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git tags/scmi-master-2025-11-11

for you to fetch changes up to 3547e315c188cdbb24312543d67d132b113eb01e:

  clk: scmi: Defer issue of SCMI_CLOCK_ATTRIBUTES (2025-11-10 20:57:49 +0800)

----------------------------------------------------------------
Kamlesh Gurudasani (1):
      clk: scmi: fix set_parent support when CCF is not being used

Marek Vasut (6):
      firmware: scmi: Fix up code comments
      firmware: scmi: Drop mmu_set_region_dcache_behaviour() misuse
      clk: scmi: Bulk allocate all sub-driver instance data
      clk: scmi: Factor out clock control flags resolution
      clk: scmi: Postpone clock name resolution
      clk: scmi: Defer issue of SCMI_CLOCK_ATTRIBUTES

Vinh Nguyen (1):
      firmware: scmi: Add clock v3.2 CONFIG_SET support

 arch/arm/mach-imx/imx9/scmi/clock_scmi.c   |   2 +-
 drivers/clk/clk_scmi.c                     | 160 +++++++++++++++++------------
 drivers/firmware/scmi/sandbox-scmi_agent.c |   4 +-
 drivers/firmware/scmi/smt.c                |  14 ---
 include/scmi_protocols.h                   |  37 +++++--
 5 files changed, 125 insertions(+), 92 deletions(-)

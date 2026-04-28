Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A08EFF886F
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 04:27:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F0F784099;
	Tue, 28 Apr 2026 06:27:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="QlMHERYr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D17383693; Tue, 28 Apr 2026 05:11:14 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF99A84178
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tze.yee.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3lmDOF3Qrm5hSoQkl0DSjWhFE6WiBuEITJoJNeRxe5/+MPOcfJ2YmLLjRTLnJs0NakCvS6ms7apIAUHXi+kn8TUt1LuqcGqYSjOSZwBdIU0rTWu2+XyzcRtp3Ha3CaaMxIKQXrVcofKas8PfIQ1nVwIr8NVn0SlDICzEDWqSTv1w5pKWB86dDwvsRWR8u9BtuizSXN+PVMxAEs1wSdzInvGDXyTY6xJihT8uirN7F7Yw/WGxGX+NxifaO0FN8Zty8sgS0G7GAQemUpijFo/rtBHGMk0Zk3VU+lL6bswKEnbl65rMBacOihQqyYUL75UwVQ7vIeulZzhcCBZEeNRKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/inOtOj72pP1P0/Ia5P3aPAdY4ra8B4X8ae1c+NnNhc=;
 b=kjyqZBgoXdJUd4vfECtpaxeeEtp6yHSN8dxHpQN6FrCen0R2e5LDqZhGcua39bx8M54lBcnU+MnoKfhyYDQhGgzrhnH5BT4yhXyGEGlHI2IHu7uLYfzYMMwCzXnnFztWrujitZWUcJuHYCBcobHWgRMLDBr6tb06fkQhbnvVJbfHzzUxnym/m9fUPdIHFlWPdkvPNE8bRGS+m3D+rA8MLBLOZSFyvlzxloo0QUcaWMB5N3eZzTNvBDQ+amZv9w4IOvOE5aa3oDgmrxU91FMEOUr/k+g71gVzmHo6vZbPos8m4yBXzv3PuOs1Kip2UlcVxfRims4691Uv4SYA9fl1Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/inOtOj72pP1P0/Ia5P3aPAdY4ra8B4X8ae1c+NnNhc=;
 b=QlMHERYrHVHvV4yQ4NTPwL/upod+od/+v9Ut+INIOU2dGsR7w7NGXGVxYLbopsPJFk/cmXxWo9b4o7N5R3Iv8wb6bwZCxc6AsawbjfJyPqdRbNK133mPwgPagq69kCw536MuH6PmK6PPgwM1CiUSvr5XbmLUNRjmE+YVxKgM80jmooIQB2sVWK7LzhVdrLUGVxZ8NVi2tphqbero9nQgq1pJAI0Wrzv8RJsbJWsWF/T1jtqDsygBPtPH0XOQZDsNQ4QVbgjMuv3UGC/pJIUl8BTsG4x23upwz5rTTy9KGyxlp+msr5CS7THBiWuRGO9nk1XAGcaUuar3d3e6Lo9Q5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SA1PR03MB6467.namprd03.prod.outlook.com (2603:10b6:806:1c2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 02:53:35 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%4]) with mapi id 15.20.9818.032; Tue, 28 Apr 2026
 02:53:35 +0000
From: tze.yee.ng@altera.com
To: u-boot@lists.denx.de
Cc: Tze Yee Ng <tze.yee.ng@altera.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>, alif.zakuan.yuslaimi@altera.com,
 Boon Khai Ng <boon.khai.ng@altera.com>
Subject: [PATCH v2 0/2] arm: dts: socfpga: agilex5: Improve MMC/SD device tree
 organization
Date: Mon, 27 Apr 2026 19:53:29 -0700
Message-ID: <cover.1777344421.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0045.namprd02.prod.outlook.com
 (2603:10b6:a03:54::22) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SA1PR03MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c45b348-f33c-4d1e-27c6-08dea4d15724
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|55112099003; 
X-Microsoft-Antispam-Message-Info: W9nml55KxPRxui7tCN/rrskQr2IZerX6rBVOcS8Qd1wesEtvlDzodAR75aOqZRhSpp6YCIa1Wn8kVOUz6KelyHdLqLyioTIgsz0/Hrk8LuO9Nr6y4uQITL2wOoXcCLHLrnz3rKgeiwDLDKgc99NG2EF5FLrfbl8svl+S0J/6RskOEzP16vlG6375u7AFSUVkAqgIDOnTTT3+1I8T+b+FRa8uATnmSLeFAckN9BLEMZIBPRh8FFB1NUMHDGN0xgYxJ5yQvoy7W+SANlOHTDvypykwO85ZQAlphA8A0TyYbHc275fSpe4oT3tn4sA4HBhLbeR3xxFfCkEGDnf+7oaCH40T4yvHpciTvTx1IzZqAK3H8OcASoQVl0/QXhvPK8PJfx7Id1PkTEhjRUGkmjVMrW0jdO54STLJRqMn9EtBFQFT0bg7dembNKUSIUlA47Gt6Rxk3y6wcISa8/7e1hDjmmk9rpcawYhPaC3FyGeC/2wzrUs+q7pUrR2VaxXTwBpCEVSkQhdBfcFZg9kbE4Dit7oXto9r76qOCPj41GoWX9pWgpY0mKYuAYDsOKyS3xHo3qQ/MgXZDJ9VxFKfqLO/umDXMb9iiVfslnSb52yiVEUnZVbZkYVMJ0A8mwv35MtadDYdj26IA0oys+5Dv5Dh/5VosQrBMVuBCO3SgolRcZ6kYZT4U8rQdzTyNtS/46ri/6NrVxRTSaY6WxNQEQzpzSsRvA8wUanvdrlokGyYLs4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UMaG4YhanMH7PTJDXQIu8uBNlRwcxn9DfIuyyGenilZ1k6hEmL6lfftVZOiG?=
 =?us-ascii?Q?WUy6/XV68S58GtnDGjZ/gGoj1WZ6bvlFmNAV2euSdVL2WiIelk5V20dHaHkZ?=
 =?us-ascii?Q?hXhEyG2W8XTvyawR0LkGSob3IKqMF5NALRfEILWV1pBBoGxzHzFmnnx3hvFC?=
 =?us-ascii?Q?kz4hDbTVGxP+vjnhevg0dV6eVadn0RjxygI40KGwXk/BV8veHDouj0m8DOs/?=
 =?us-ascii?Q?OO5/Rfs4uqLcrIQvF2ot34/3o4zwB2W6XWx2JZoRpsmvxFTFdVkRPiPEl2wQ?=
 =?us-ascii?Q?KhCrKkr01nlSEnhzVNIFWP+tNrWGSNRRvFcZzef2Xxhf9DibehZbvQDPSlRD?=
 =?us-ascii?Q?tcLFhbZRhhmPP6d3lvrnHuIkEtP/hTNay6WYPheo9/vVINvnKf3b//3/kRT+?=
 =?us-ascii?Q?A39+ip+/W6/FT0J+GgPci5dwlwPFjJdtNImyLXjbJXzYlWxdC1h/CgaQhSCa?=
 =?us-ascii?Q?u2J8CX9aInoiKc1nFKyXC/mTEoCJed8ItLQryFmJlVlqL9aFcjwr0QQTLlAQ?=
 =?us-ascii?Q?4hjUEH2Vz58LhcNIfV/MlqWgd8Oa2rnRqYXtd2PpgkivhEFbdlz5LCO+CeMc?=
 =?us-ascii?Q?wR+mCWd0VrkP8vUG7eH9Tk1ezJp7drLFTbXqUla2suzsN/2y2D5QxYP3ugSA?=
 =?us-ascii?Q?/nRWVkwwJQkYmUud/iJsSg1WrrR48EfIB442yv+gECSHsx7GQCdlbeYNuOtr?=
 =?us-ascii?Q?2yl+gYJCkYZ13EL1V+Mj/jowTICcgxnTzVE9T6yI/p+p8EiwJhdhTv/3ygzD?=
 =?us-ascii?Q?oOqyixc9xgzUJT4DaXhg7gbgdoazyKg1jUByEurwHn7ssweaGATQqyAxInOB?=
 =?us-ascii?Q?gI3VLaL4RSgKs1INnmbxApHAv8DK061CgZR3J/3iS9kpFCNskYuvGuMmjngR?=
 =?us-ascii?Q?k9syNweXfctlBiwxVapt8bLmG5awDsnJVi9+JD2vmC5DQrNE1Cn2beCS2Ran?=
 =?us-ascii?Q?aTHH1yaBY7NZ++L0uc0irJZBn1QsJ+fyN2HihSGwwxAV/pSHPD0GcDSwzG2y?=
 =?us-ascii?Q?zn3dihino4FkqR5sy8NsdvemDM4HFpV7OEAmBafcWZD7n91/USJ3XbXIoBdA?=
 =?us-ascii?Q?F9eU5+wymxe1PoUZiOgDOAu4N60C4uKaDEfl0hdpubdX/TNFZEtU2txf+3Cu?=
 =?us-ascii?Q?CbbbdEGLjge7dXi4h5Np7IS/SdP4hFa/LSMgrCnHRCIXmgSJBbjCglPior/v?=
 =?us-ascii?Q?dMALIymGpfouIZUVyvvn16YdNvvTuzBFuSGXZ9DalfO7BAuP2oI3R2jq5mBk?=
 =?us-ascii?Q?F1GNkE41vNk7j3od7VwZFWfQEgbU/ZYuqpGjggqSjq7o0hOb9TrPmryIsME+?=
 =?us-ascii?Q?vMp74o+RlhxsLNL0seVaV5L1w6EJLU4MJuUYXwEXM7fFWOI9yr8HD2toVqMx?=
 =?us-ascii?Q?g8KqZ491U0KSMLCs7ZiLyLC7t9foEeAKohHZrRZlcOsGqVXJqgfKEhd6CxzZ?=
 =?us-ascii?Q?luAQpM/FlruiMChdu+3w+uFKPvVbh/K5m2AxskYa9zJ7yKSB4qyGX/XXflPM?=
 =?us-ascii?Q?5h5U7AmUxEO6cyTTXtZ2sxhqWgb38MyiPJtdtt5+ZL9cUQ7aCjFv6Ov2Tpym?=
 =?us-ascii?Q?PKtXv2v8Rd2+PcVtj3c70o94LmTOzi4EQ3PsC7GIAUuL2YIVsrbqU1NroeMX?=
 =?us-ascii?Q?RaWo/NRDqj1M+cYBQmFhBQA7IYOdiVVKpgZI+cGkzGZ2hOGcje2J1NKzBUaM?=
 =?us-ascii?Q?cRwhY4970YlLy7c5EB1vfefxa9QOsDTTA/v8BuXpPx8PFuWh0dmY4j7gIyV8?=
 =?us-ascii?Q?Ei6KtZ2vJA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c45b348-f33c-4d1e-27c6-08dea4d15724
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 02:53:35.1807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHPe0P9qmmsRnzKJa/BiDMapuqaoLf+Vt81ng608j07yuMuUNKo5f1m99YmZBWTCBYtvXPRiHaa8eNQdR07icA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6467
X-Mailman-Approved-At: Tue, 28 Apr 2026 06:27:12 +0200
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

From: Tze Yee Ng <tze.yee.ng@altera.com>

This patch series refactors the MMC/SD device tree configuration for
Agilex5 SOCDK to improve maintainability and correctness.

The first patch reorganizes the configuration by moving board-specific
MMC properties from the common u-boot.dtsi to the board-specific dts
file, keeping only truly common configurations in the shared dtsi.

The second patch addresses a configuration issue where the eMMC device
tree was incorrectly inheriting SD card-specific properties. It removes
the SD UHS speed mode properties (sd-uhs-sdr50, sd-uhs-sdr104) that are
not applicable to eMMC and properly configures the capabilities mask to
enable 8-bit embedded device support.

Changes in v2:
- Fix commit title and description in both patch 1 and patch 2.
- Remove the SD UHS speed mode properties (sd-uhs-sdr50, sd-uhs-sdr104) that are
  not applicable to eMMC from dtsi.

tzeyeeng (2):
  arm: dts: socfpga: agilex5: Move board-specific mmc properties to
    socdk dts
  arm: dts: socfpga: Enable 8-bit embedded device support in Agilex5
    eMMC device tree

 arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 3 ---
 arch/arm/dts/socfpga_agilex5_socdk.dts         | 6 ++++++
 arch/arm/dts/socfpga_agilex5_socdk_emmc.dts    | 5 ++---
 3 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.43.7


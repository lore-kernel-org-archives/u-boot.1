Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54C6C87FD1
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 05:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D10F839A5;
	Wed,  6 Aug 2025 07:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Yjq2sG/y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C66383968; Wed,  6 Aug 2025 05:22:43 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85FF783950
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 05:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fq9sn+BZ0/s+nGjneEUC/mAP2GDBC9YKCfaY/yd6uH3ElZ1ZjmOalUAcryFvvgXlaO813AXidhG7F5tROcAhlwQJ/v1wDrPEfatTa+Aa7cXeGVFM3EK61OpU5p50ggRYVDHLRmdcgpCbn3DhVFhvdD/eS2IY0p7MIy2/FjldFmA+eqCm3y0qzWP5YeOxnjlxcC1QWGzrkwYG1qfNb6zvZbTp2eUTmMcjSWRjZqXx1n+0UCYxpjE/H7ZHLHgIFijcWf22mpqPF/r9IvZGigPJFQAyhnQiSLl7pXwUvJekgGBagYd2UoBxZEbYrYx3CYDUEw4eiET4duF0Qqzld5AOKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tl+DGz0x//a2dmaj1Abl+t6XPHMqLhVo8jCNnK0hKjc=;
 b=N96pRlV2wsx1onNUN2v8Gk1PUSLN0vQp0c5Za++grO5+FPfnF9b209cXIyTzeDo//+UYt4gtREjul1Kb0ZlmiWxQToIw9lyDZkIkSfgdsnZjlDRWjXD/qpFP4YVotE1eEpliEOr4YA5++oO3gfQpUv22OHq0SVNJmv4PM3+0b92s9HUr/rq50KVioCRmXuj5X+dPSQQ3I+4a8ShGOCD0yr3fmpZnOsFn2nTnbc7/4RDheyTRWYqPOkVHHiHDfkroPxS4BqC4X0+N/KsV5xSJ4wY1XG0vVvCjNJkx7Xc0KUfArZ0n7V3szxHkv2KD+ZRlSYTJekfzTxNWWbnYzY/N2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tl+DGz0x//a2dmaj1Abl+t6XPHMqLhVo8jCNnK0hKjc=;
 b=Yjq2sG/y93kOwYxy879vAPdh4of6PbnqX4lPOS2fKAozVQiYGS59JFkHlS1omeYlVSEN+eEZRlSFKGDf/3uSILz99LP0FXd/v/GVf06k5vU9B2x3riFzb69Vuf2DoPqCts7h7f+plq7Ky584XwXZSVhKnhPGoqq6Hx4GnDx+EJzlf2NjpfeNgYX/TZCE8ZrXeSdHsCP6+Hx/ZferqTPosv+dbn7CWynYm7dcrKnslhlafQx902HVKKVNMGKZETYJ923pFjSrvcinaUtLnlPFs6eECBnRJScI/46zQung9YEjpu7+aKbxQmgC+yErQh8D25ihe9CdUM7r/Ok08CrfBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by MW4PR03MB6346.namprd03.prod.outlook.com (2603:10b6:303:11d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Wed, 6 Aug
 2025 03:22:35 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4%6]) with mapi id 15.20.8989.018; Wed, 6 Aug 2025
 03:22:34 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mahesh Rao <mahesh.rao@altera.com>
Subject: [PATCH v1 0/3] socfpga: Agilex5: Fix dcache usage in SPL and SMC
 mailbox flow
Date: Wed,  6 Aug 2025 11:22:03 +0800
Message-Id: <20250806032206.16688-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0027.prod.exchangelabs.com (2603:10b6:a02:80::40)
 To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|MW4PR03MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c6486c3-7265-479a-dac8-08ddd4987c37
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kVU1hk/AqhDlFJFCIxsOv0DP4954SK2KlUYEF/FfsPGFIfMJhxK048pitxtv?=
 =?us-ascii?Q?1xwAt7Qq4Uw/HRsUU2y/YQpCiTx1ZuxWgrJ89O9qoV1nxFkHBfmXMSSSLqI6?=
 =?us-ascii?Q?MVFIGq1vlDRvCq5X3/5a2id7SvEUzfAek52RE2QUo+QOSEsQrZ7+Gk3mzlvv?=
 =?us-ascii?Q?MuIQw2Gex24dwcqyJ6YcAL6xCzXmtvWpCS7zBs94OAHbGiQ7Fa00y688Uk1+?=
 =?us-ascii?Q?6s+As8FOTjVIqdglkneiMlxLet1PnH41dVE/v/IDOwzC9QugpbJrTShcRz5k?=
 =?us-ascii?Q?jlSooDwxA6yGqk/VoTj7Als3gxC2to8ZdtmhSj41yJ/ydPj5tcxt/UBGNuo8?=
 =?us-ascii?Q?CrPW3UvaWhYxhVa2MugTEsYmEzvP57pQv2NWKZl5ZEfAM5QV1ojoPoa1aFBE?=
 =?us-ascii?Q?JDC1Xa+r808xJcL2dpPdKsayC7ZawFoGMX8sTSMKU0b39LJwEWykdWHJ7yqx?=
 =?us-ascii?Q?Z5+uQqD1eE+9d1G6/ekM53iGju8O135TeYK5q8CBJohP4vOGgmH8WTISmWT5?=
 =?us-ascii?Q?ic4t2NnYub4pUtCzj0YA5iDqbd6GII//L1YHrGXbWdbHF1FiOy2hdP6pA5UU?=
 =?us-ascii?Q?aQzbP2roIppxhC6a6xAioDXXCaIiZp824dymSUobJxDKT3zrVK2kXVxHN6+N?=
 =?us-ascii?Q?hio60sBJkbNNp7CnhOlpIH4yxaxAzXqhAqnbODMi4uiz2VajKCBq3ORkcvZy?=
 =?us-ascii?Q?+6E/62N+QSA6PdINoYQW6rvhXVCTUCnX24cEDUv0IuT/sPp8RWRJLqJPWsLm?=
 =?us-ascii?Q?pRLdG5+UHAlYCnd0lNLE72pRQsGZxee75c7V19gRoW3vI64/RIReZkJAlAE9?=
 =?us-ascii?Q?9reOLhmWQMskWtdRYxMS9km3qXTgPQpnSJfYekqrQq1ZmceWTmuSbp6B4wgT?=
 =?us-ascii?Q?gMvQWY72z1l0CuU1qGIvwkqDtCGy6n5T/88W6DfPc2vhB82s2Cnf0HtDqCh0?=
 =?us-ascii?Q?gNWEshWh0Tg1UhTOTNTTlv7jlPFvvhlt9OL2FYPeo/VuzhrwQECUiwBXu3o/?=
 =?us-ascii?Q?os3yYJTUHC7ivRrCD+0dHhj4+kir11M6dx07J8Goes+siwF2nhbhuMX81Pcp?=
 =?us-ascii?Q?pTpen1bGJfb9kK00dIQAaKybB6gYF7jCXPDuCzdcXeMFmVoxe5Xu3sGMhiRH?=
 =?us-ascii?Q?OSxy52hxw1PmnMuqcz+DGHpkm/rSSmty1K1IXasAEeaAampJ7ePIbYGoja10?=
 =?us-ascii?Q?unrishoRGb4ny/pEbzuJ0AO3sJwEBRYCCW+mKx4xBpZwEzojyTqO6PWoCu9K?=
 =?us-ascii?Q?Yz5SztpBnqMaeu4Y9DXYw07gldDmD1TTeftjYzAOPlai1s/3ajpEBrpIfbqc?=
 =?us-ascii?Q?xMkMgosuq8nXGfaEdQN8OauKkaQeX/Q0WDhhofieeXofmPJQ/6du73ByvX7R?=
 =?us-ascii?Q?YMC5xIMKpzMC3PdmIhmqKA47gpBwpXpNMYI+s6y57Daw5CQRYQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mAYsrugm47LcMKFUvk7A+OLR9ZdYBBWquk5WTaFM0R7B3kOQDpp3uWnzRqcr?=
 =?us-ascii?Q?KkJseUlgxuI0mqM/eBwctAcsQ5C7SE0BIlHbVoe/rBYxsSA7U8CIt404TuZU?=
 =?us-ascii?Q?eNoBtqr4qBkuSTv8usfhf0uYd5gfu7gi2tAWaXIc2FazdyqNTvY4x0sYX5ga?=
 =?us-ascii?Q?PZsjww1Qe4Hc9aA2Lkhmn5tz23B15LqQ190TRgkI8WcC5lmfOvRQsG0M97jZ?=
 =?us-ascii?Q?cxoEiWBzuYbnLpGkyYwPY30gx3fcnG20sLJxMaRbb/6VCNAlKG+3+RSfO9JT?=
 =?us-ascii?Q?OGc5p/zCxvvwKVQ0lFT77utjLfZXS7K/xH0o5foxXd4TxGlBFhUhQBdpyTD2?=
 =?us-ascii?Q?CLiN+uKIWsE8eTrB/SiSiHl13NyVh7TrO3zwUPkVLAEhvdd/JYBM6oNdIMZA?=
 =?us-ascii?Q?Gei7RrAWTjjqqtq0wNIS+CueXXDL6EOUWrIRZ9mEoQB3Vi4exPeiRcRH8NC8?=
 =?us-ascii?Q?Eht7O3R7P2mXRkhwz/5ertTOKfrXzeMk5AR2O4qjQss3sdxtrKhxzdy1Z/pS?=
 =?us-ascii?Q?qabxkrXr0goLlnBrhpdn19+/QbbrG7hlOxGkvQrWI9Yji/TzhDxi9cIKMdAT?=
 =?us-ascii?Q?JrW9ItfirOncB5n6IPxf7tEnPAyKG2KmRapxTarRtx/F2Ti9yNFLpBEpQDSJ?=
 =?us-ascii?Q?Khyo3x+IgKOKR8R/gFJa+HLHYrhxDLRzBVjZ1k6DEAafWiM8PzNpLWOvwU16?=
 =?us-ascii?Q?UhzRd2ta48+e0n8LUVvVxNAc8eElBPEYAvaOCLw0+ANXoGNhSrgeZzuF9UcY?=
 =?us-ascii?Q?e8R8oXOxlM5NKTMQF27LdobZpdazrzXki9W15omFoDs1UtkMYLdZS0G+ifsV?=
 =?us-ascii?Q?7Fho/0QOAYG6u0jK2hMM0NgFq1I7upsuhsrExBM4diu5z1vtEQmEXxHKMAIO?=
 =?us-ascii?Q?KU0FSTVn8Os4LNLSjVMYjh9oCFb1FmcJEs2BQJvU09h8P0FbBKbty/dhqLRi?=
 =?us-ascii?Q?auZt2RTexskING/SzkQbx4OGAKE+ApZOSEHDMfFXvJYv0o1j1aTTEelxgPRP?=
 =?us-ascii?Q?0Nxpu73h+EHkYyk5HoPM2PiG2kWnv5LW1Qf3UIWuZJoRz1cycvCXouDcljNn?=
 =?us-ascii?Q?drRjT6lV9+USqEdGRIeUm+XmAYexeAb1q67B1etPk3c0aAT5izZQJe2RwCGy?=
 =?us-ascii?Q?ClfMa8KidE0RSFuD5BEudh1ABVeBFUuF+jlBdp2BfiKWZq5ku3ecG47c6aik?=
 =?us-ascii?Q?lKHddFVG9ti6RzeiGmcUImDoULc54e1X3m7ZpsyNIWpp7hQZ5lpdANKiMnZ6?=
 =?us-ascii?Q?3JpM2j7YpTQ34vBd9+CUNa5J2M0HeHrMNIN6iyXuVoDX56e22Dlc01l5hSmc?=
 =?us-ascii?Q?ZIOPhtgkp6aqKnTX3xCHnhJ3fuRmv0amIa/sZpueNX6dK8DjnJ4lH6WHEZAa?=
 =?us-ascii?Q?heQDJX88GP90MFSxBiI8PXLInvbakS7Ih83lyqJ+wqWpGSpH0GAWjy3aZzsC?=
 =?us-ascii?Q?4lHazWRZgFp2znpfOwDAelbllLaOCc2HexPARziHAezYTi4aZMyRqpOwZTSv?=
 =?us-ascii?Q?Gi17/ODVOnHCNrG48bWlhoDYsQ2w7hkVVpXQFqjGxWvSdqpsbTWahQ2y2AKK?=
 =?us-ascii?Q?7C5amYCOlfiRFg5z0kqpOjwIkS4ykjvdikMt7S5oQHg48wun4i3ZxPoEbiQB?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6486c3-7265-479a-dac8-08ddd4987c37
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 03:22:34.6208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hypno8kIfK83R8H2kvYE0gbeRQpH75JjenkIHkCZ5r+a9iiYHC8rYig4NgN1Wsexs0X12TsX1Z8HFzJl1w3wMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6346
X-Mailman-Approved-At: Wed, 06 Aug 2025 07:25:39 +0200
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

Hi all,

Proposing the following fix to address data cache handling issues and missing
weak functions in the Agilex5 platform, particularly in the SPL build and SMC
mailbox communication path. It ensures correctness in cache operations,
resolves undefined symbol errors, and provides the necessary configuration
to disable data cache in SPL where required.

Patch Summary:
[1/3] arch: arm: mach-socfpga: smc: Add dcache flushing and invalidation
in smc_send_mailbox()

Ensures that the response buffer from the secure monitor call (SMC) is
properly invalidated in cache to avoid stale data access.

Updates pointer arithmetic by replacing u64 with uintptr_t to improve
portability and correctness.

[2/3] arch: arm: lib: cache_v8: agilex5: Add weak function in cache_v8

Adds weak implementations for dcache_disable, dcache_status, and
mmu_status to prevent undefined symbol errors during SPL
build when data cache is not enabled.

These stubs are used by other SPL components like  QSPI driver logic.

[3/3] configs: agilex5: Enable config SPL_SYS_DCACHE_OFF

Disables SPL data cache explicitly via CONFIG_SPL_SYS_DCACHE_OFF
to align with the above changes and prevent inconsistencies during early boot.

This patchset has been tested on Agilex5 and resolves the SPL build
issues related to missing symbols, while also improving runtime
robustness in SMC-based communication.

Let me know if there are any concerns or feedback. Thank you!

Boon Khai Ng (3):
  arch: arm: mach-socfpga: smc: Add dcache flushing and invalidation in
    smc_send_mailbox()
  arch: arm: lib: cache_v8: agilex5: Add weak function in cache_v8
  configs: agilex5: Enable config SPL_SYS_DCACHE_OFF

 arch/arm/lib/cache.c              | 17 +++++++++++++++++
 arch/arm/mach-socfpga/smc_api.c   |  1 +
 configs/socfpga_agilex5_defconfig |  1 +
 3 files changed, 19 insertions(+)

-- 
2.35.3


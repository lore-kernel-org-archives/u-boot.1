Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037F6C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 11:16:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E90682B66;
	Thu, 15 May 2025 13:16:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="p3XEKZdl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20CB482B20; Thu, 15 May 2025 13:16:08 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20705.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::705])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3102682B45
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 13:16:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVyh/u1KXyRJy5b1GfQJVPYUDege1BbYUcddYQPfJDuR5GVyBDL1e3wBTp0c06pdJ4xxsOrJ1/hkmOZbDxJsOss7Ba7O41GBBX/JhB7FnTYvzlcqect6oQQk6V/cDlBqsfq8X/g/gT00aRuZVpYvw+mrVpY2qNa4zB8edWh6y+hXUFBfdvRDdagahXiwQcK5BSxYP/NLjZE2a7e9hfW6aXUv6gYcRksyu/Qogc5GbZCmaVGlwUYZTf5dISW5V3WhQ0De/U5bkQi+8sll7zsFzqXKbU3k0Qpm9draWt/jTa6KTuHyx52bOyTjZtJRjqIGkPF6oi11aNG10wcvxFMvjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z14vRO+YktDL6QsrWS/dfbzzIL0N/Du369iJMMhvzhA=;
 b=wEQtp0WzQj4v1FPBJbdpfSoSzkonxATkqBRfqKuNBhDNGf/jQbITnt36xqAV3i+qZEHs6dVhD+oN0jVQ73I4FPDaH/jlEEq6ypW0N5g9tiLVjU/yZuLxE/6ziKYjRTui9j5IMzunMCqNnHaUcyaW16q7li3Df1VOQlMEwvMNafniAvAGWL+JBsaZ+eNcM7XhCU+FiSknLsjlZHm9MKL7/Vdi3jn8TvS4FJHC2hQsV9pOzjFuLutz+D4ofH/uA0qtY97WSc4/wUdgojRKxX8aCsCh2TbH96Usx2SNah7wbOm9x6tiTjJcpOBBYRbgKcaoV8rXp89b4cQcrqpQ/SavRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z14vRO+YktDL6QsrWS/dfbzzIL0N/Du369iJMMhvzhA=;
 b=p3XEKZdljXdb9TbhmpPBdSK+7LHv3FTc+R4KGEvRgyKqKKVjvelEBnSN4k5B3G1Z04p3aB7rO4XtZfY5FOO1NmFzGAyhSfaSncFdTOHwHKhw8bU+Qe7w5rMXfWBCZpF0aWPZRMiEelAN8RaMbdsR1iCryEnasLd1YI0ueZLkEocxiblE1ZV7i0tjoR7Twe6XEP2IliNYdLCCHcOEgQMD/4zLC2/OIIFd8Q5oAksUaJA+CPsIMtbIXBF8Yxn91XQsLsgrYQo6EgDM0AUMwRh33glA9gJJaWbaVwpft5kNZy6pty9ELRJdxu6Q8lndHuA67Dk87xATPNkl2e8NRcusgQ==
Received: from AM0PR02CA0222.eurprd02.prod.outlook.com (2603:10a6:20b:28f::29)
 by DBAP195MB1116.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:1c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 11:16:03 +0000
Received: from AMS0EPF00000196.eurprd05.prod.outlook.com
 (2603:10a6:20b:28f:cafe::e2) by AM0PR02CA0222.outlook.office365.com
 (2603:10a6:20b:28f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.17 via Frontend Transport; Thu,
 15 May 2025 11:16:03 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF00000196.mail.protection.outlook.com (10.167.16.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 11:16:03 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 15 May
 2025 13:16:03 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 15 May
 2025 13:16:02 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <bb@ti.com>,
 <ilias.apalodimas@linaro.org>, <n-francis@ti.com>
Subject: [PATCH 0/2] Print Reset Reason for K3 based devices
Date: Thu, 15 May 2025 13:15:52 +0200
Message-ID: <20250515111554.2916254-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000196:EE_|DBAP195MB1116:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a5599a-9f47-4d41-02ad-08dd93a1e13b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EFfGkyw8OzT3KdhWkWNOdy0ZM7K6qEQhobaviPURErYpvHC+NEvD/jrG7zko?=
 =?us-ascii?Q?ikjPUYBi4U+fnvOg1peiImP5Bjmvc0lKNrzOgXHV2LFcKMhQdoYO/TkpvMvg?=
 =?us-ascii?Q?AU7gDA6vqDPPYe1/YVccWwOIAGajvr9t4juCSCqEG61d1rhpYIKPJlTlAI2p?=
 =?us-ascii?Q?Rkux6Vuo5DoNTD9zfJXUVhjNS82R2lEKCAR+oFHwvz+meuty2Q7cbPc7QecK?=
 =?us-ascii?Q?QuqFiCPw4FtvuoyHKyQDkaVzWfDOF0fP5CaZgeKWBh+ht4jz77VKGzZrpqnb?=
 =?us-ascii?Q?hR+55vj4b/qqOTOTcrKq+GsRKlIhLbiHiBwDYpNqxMuPKoCiYl5ApfmSQG7i?=
 =?us-ascii?Q?8OtGhiO3EdC/XtssLaxUrC3pif46fT1QG4ba+qq+ncEJfFdZHvGwG+qZ3fYf?=
 =?us-ascii?Q?ngB4MqYnt0LxQkAbskW0jKOz5k6RMdgnBl8tzoLBZ8YgokmkyZBM6pvzDSRu?=
 =?us-ascii?Q?YPnElCJWd+Vd48ctsFy5IKOd0HcIq2FWz9pgJ1xsM7Wl9L9rvHeQwAONCnZK?=
 =?us-ascii?Q?eNN+QJK4fZGz5tBQglaNnyT6EnP1sMrJPaNIF6JnqtHOS+3+R1avyfqpm1+7?=
 =?us-ascii?Q?d3HYYVz3mPcPTizHVpvrXQgahbyr65ydRDo2QMa4mikjZgY5xgORXDRH+wlT?=
 =?us-ascii?Q?Dks6LCE3/ZD6nbidAMLHqksVmCAahqpTvGYC0jiZ5JsIoB73FR3jfTvkNyxh?=
 =?us-ascii?Q?DR1M5Dj811z3bxFhaWgfsk01HCPtWu0Rd1IWnGWB2x2VslbxXWfIS6xg2VmM?=
 =?us-ascii?Q?SK1QyLLpNfe3uSInJ/0//6Vby7QERJwP0G5a7evie9VJpbLyx8mgR/s8DY96?=
 =?us-ascii?Q?TIUMSuv02fxTqLPN1W6GuuY0gBd924yVAdciKfHySVogF8H+b34+GCKq8aj5?=
 =?us-ascii?Q?My864s2lQLVw+uIquJlhoSn+MVpkacCv5TC1fY50mcLGCb4rtrGs8VSbJRgf?=
 =?us-ascii?Q?gITDSbL2E+jZErUKWG6nZpmWwnod9BRv8HSVAkpyxTfn9IMW4kA9EBl2wFhS?=
 =?us-ascii?Q?Qo8Pg6wqwGa8Aw7i93BbmoU60lA+JRpwTY7jzcLag9TYbOWxdMeqzyE6a4GY?=
 =?us-ascii?Q?e/a1O1evJ5tkazVcAWVwApZ5jCYm4Bxu8CJkrPAKSePs+xKbmSSvn7hKubkz?=
 =?us-ascii?Q?POaFZwEScT0DhNWT7o3C2aHxjF3IAcd+cNyBbGE8Olpl7ZCTr4pIcez/a1H9?=
 =?us-ascii?Q?axVHRHSCVtsKikFf7UQmBGFHecHLlXJZqdsJxYsoqqWFMSUiXYn2iSQhk2vi?=
 =?us-ascii?Q?8Xxk+UHYA1Z9SkJ+Nv16KR6AHBbCr1i/vaWaODaBmAl41Ed+nipM/iyYzf7U?=
 =?us-ascii?Q?uXBeoEN0oY2FxPtqMsGPeZtYiVymqRXnqAFEV1YVIANdJXxsjk30Gmd8xMfY?=
 =?us-ascii?Q?hzJzleKxMRxcDEtkMTEgYp3JgqTU+s2PY0BoSBGg3TE6u0Yq+HZkM0bxiIMj?=
 =?us-ascii?Q?XXHwLHENaA1Pph/HlZWJPCYtzkHLtQuv8BCIWceuOY60frHlUyC9Ah3x5mXN?=
 =?us-ascii?Q?l79SGq2AX7SX3F/4Jj1HmQGHEpnq5Kao5yV3?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 11:16:03.3784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a5599a-9f47-4d41-02ad-08dd93a1e13b
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000196.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB1116
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

Although AM62x, AM62Ax, AM64x, and AM62Px share the same register for
reset reason, not all TRMs document this consistently. To avoid relying
on undocumented behavior, introduce SoC-specific implementations for
now. If TI confirms all SoCs share the same register, this can be moved to
common.c for reuse.

It will be mostly copy&paste for the mentioned devices.

Also, I am not sure how this Register operates exactly. I noticed that
two bits can be set at once, so I started to check for set bits instead
of having a switch/case logic.

Wadim Egorov (2):
  arm: mach-k3: Detect and print reset reason
  arm: mach-k3: am62x: Implement get_reset_reason()

 arch/arm/mach-k3/am62x/boot.c                 | 40 +++++++++++++++++++
 arch/arm/mach-k3/common.c                     | 10 +++++
 arch/arm/mach-k3/include/mach/am62_hardware.h | 19 +++++++++
 arch/arm/mach-k3/include/mach/hardware.h      |  1 +
 4 files changed, 70 insertions(+)

-- 
2.34.1


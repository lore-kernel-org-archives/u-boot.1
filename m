Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F234FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:40:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC0CD846A3;
	Tue, 28 Apr 2026 09:38:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="XkiMUyBI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8468483A91; Tue, 28 Apr 2026 09:00:54 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ADE683BC4
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 09:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3DmrQN3I27FfAIihcnuGODpyWJVG04SQkLS4R6pNCfl+ku9S6dPz+ETaDkuChhwEGt4iv7FqS9Y/XcHVQ/vM9tIf6u934rZiS2LmKswkD7XGzP60ogwmhg6Uig/4fFVhEs0WUHKOkXHK8uLeppojSYh7CDrgrEZMX5ZdI4AWpH1rfMGo6F577s8ujQvlqvua+s2LoroJrS687YOQ0GN8jFvni9WmGOJxYYFatAkyJ1CxKebb6GbthyJ6YQ98l5Rx9n6OIBf+ifG/+WsL+6y44MhUFhXvpWYJcX+kEOrKFP17EzjJseZymwddW8HCut3SB618livJLt3jvzP110Zag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgPfifoMJlBg23e8E5glbqZdNu38Y2j4Q2vz0kQokuQ=;
 b=k9RVrbjtTz8s2IS5+WShUHLXL2sQeT+/PEDJOUtlqh8l650+NMptyg6tHu/kpHizcB7e7d4+zaYNeMSI06Gb1fRR5ru2wBENTUUBODcvu8MRvw5aruR6XuzpyOrT0qmnWWflMzUW1FesPdzKyHDCEkuiz0fYRCMits5QFF8WoZ/paN89wxUK1tRuECHmxSTE/a8iezBKkBpY78j+1q5t59Jy1UShZbjuDWs124a0ZwDQ+WmcwVSSIUyM5GIzG+6aGk97eqt8mIf8mcSF0Y6fgnLR0hlPIxlZBV2zYs/eFc+ntcFuinKgV6xkoSm+ScCcXA2V47FppS+FzsGnZIVOsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgPfifoMJlBg23e8E5glbqZdNu38Y2j4Q2vz0kQokuQ=;
 b=XkiMUyBI6lAsC07iQwByglz1EHMdMT1kTJjJoka6g9LHJkZB+xOzQexVKBKN3Z73ClPSMXhhUz+IuBmO3hzKjVLz6nM5l04IC14LXc2POnvNeE8SBJIXAXE5ITWb6Y4sORfYHwiOQITyXIOq58s5lnXuqsQ/I1Yw5bG3WYjLtVeziE426Zws+l7sSTZEWmFrfMs/1VzGpWo2QNTtbgoIjsNYZpJaB4KPhxFqx6/MZIZ/jbe+oh6HIH0msfrpR+Dgx3tAyN2VJhoZj8+qouJGSQIYVk2zTa8sVbfgRhPiii0C8fryoVgk/hI3RMwZwKBhsgTDfc3Wt1+J88Gg6O1RjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by MW5PR03MB6960.namprd03.prod.outlook.com (2603:10b6:303:1ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 07:00:46 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 07:00:46 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v2 4/8] configs: socfpga: n5x: enable required configs for DDR
 retention
Date: Tue, 28 Apr 2026 15:00:13 +0800
Message-ID: <20260428070017.16807-5-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428070017.16807-1-chen.huei.lok@altera.com>
References: <20260428070017.16807-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0083.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::24) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|MW5PR03MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca64f2f-18b1-4964-8e1e-08dea4f3def4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: iVi7z35rZPu3y2iOX5vXwfU/bXh1wRigk5FWrSqqZgn3rVxJlrFWsmMrTUL2xwZWLVZIoxTkhUkZtYk8XkVAy7TIl8JMTUcJh/cC07uwyF9HCs7REN0Pv228uQa+Sqg+jenOj6QmulVY7VFFfleeVDNWuYvFg6WmvbwrGIr24/3n633erKlYJV1roFhsXt+pkLb76RNCdYJW67rEqq/LCHoA5/O5B9AlIkvYqRzyb9R7HzckezfxzFFnRwwoqfT7VIpqX9ArDzjTKWRZypQq2FV+8ETipSmb1jZ4CgRfAscPcwsCNMyntthRWDQN6wnnBNt3OjZc8cmaDCgG2+10RamWPuoa6h6uFZqpWBh3kPxeESoNiORjNg+R9LbAeplnju8lPByg3/2sVClOg4I0dySZxEV4Zv4y1IE3xQSo9Gu5euXbLcVLEDaoJfz9HfYrH8K/Kae1I6l9l/7/8BGy4AXVeIxk9UWgkSiCQTN/cexTC0YUMiNHpILWV7CAxN6hiM9kGgncDyJ1WLgItftC8FsttfYRyysDJHvqH0J1L3U8QGcU722W/XEWrQmTtLrXAGs5lMiW/QB+o/y1RqASwn7TMT46yJK0DModHX7tklr/IaH2Ic/g37eYrIjx6D5qBZyDBLEIHw3OgMtiZGZ1O+w6LXevn6zi6KqfqmEORaUdwvFjpjcL6/rH2vUaQ78geZXSjNi7xO1jmIdqi62cm2Wgin/SjVU0ux7sjU9IZN8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oDUGHSvV3RVbQDiZtVj4/CL3RXhEj8JgFe6kev5taJ4Nf8mxDdJPCKbuVKiE?=
 =?us-ascii?Q?kbAI98u6T6hDLCKQcxW2jhb65hE694kiwXJQPOrL8NKQKXeS/dFc8ug1AJfh?=
 =?us-ascii?Q?LY8S/PjYdfZxeqko4oLt+ZMfIDTPRvs1P83XS4WD/NaMutsLWac7kWRUNRLs?=
 =?us-ascii?Q?vQX1wc+k1y5oKCrUpiG2Ux2Nepuowf+UJFCoFHgx1yVFNeh74bqftT9yo0Qs?=
 =?us-ascii?Q?WrKvZYrwoDA66jA/EMClHEkGOYjV+6Oi6wrlXwwDUFcq0m+cdT/VZp3DqNtd?=
 =?us-ascii?Q?L0iOoYygh7QGkw9kjAPwcckxg/CPWjR6r2iSO/dj4zc512ccIIgXXzUfIOAL?=
 =?us-ascii?Q?h9CvdnQptcyRlP7qknYJRupBfEeo0omOx+d0+/xrnbiUFcNNLGzwiUFFQ2DJ?=
 =?us-ascii?Q?o1/doVaYFHsq9KkCBwUoE/V/rvax/I7XU/cSizHuGWgpIHfgIqEuDCjMBzhS?=
 =?us-ascii?Q?a97TSwd5x454fArr1hpVlosjt/iolgnC2yweeITI+66VhVMYzp/bNd8SPySC?=
 =?us-ascii?Q?YSUaP79BdXLPZHxg9KctiAY4sfNjRQIS5545KEFA0DAj8xN/YiunJfGHkwYN?=
 =?us-ascii?Q?Tesis/UAo8RHGuWPrwYHPS4Tml9A4+bOjAbL4a/X/J01/I3usxyESeGHW79k?=
 =?us-ascii?Q?DEWMp8tY989LQW7oFI+BScqZDkWdPHTjXADJyYPaARE1bYGbIDBzRJvcbJTs?=
 =?us-ascii?Q?Q0KJPH010M27bgD8fYr1mSJJeP+pPUDsyDXv1PwEtqBPUY0fd1kKTW1p/vm0?=
 =?us-ascii?Q?9JtrNbISrlhrwLBnCDfNJFhYdfVlA5C2L34VDJVDjHx8PrZJGOamP4GvtAba?=
 =?us-ascii?Q?EEiS1sRIxOaSiyKqGf2m1+CVXYrP25IX61JOmcU/NuitG6wz9q1pzUIM6sMt?=
 =?us-ascii?Q?8Tfc+zsnMbyj/GhSptjqmIR4VVJVEx79AXrUPT2lvnX22ScRRTnV2d5hC3Aw?=
 =?us-ascii?Q?cp6OMxwhr7Y7ZOrkmJGk1tVNUhkjYHvXd0V9Q4AiqC4rWwIErcKBBMKJm8wl?=
 =?us-ascii?Q?76ljwbicwdaJVbjHYJrUBfLW9ibnPzB/abSpzkMtf4bjk3L7yjGiHsWvxpBQ?=
 =?us-ascii?Q?NW5nFL3v09VS2WaoM9M6KRUU8R/P/TE1f0fgf+0hNgWEFWQWbvkGoP7nok03?=
 =?us-ascii?Q?0sbcFrt4LHvSyrNuqsK8Y+0emTp2NfMOeO0ymHpNZRZXuv4RlobPbCI6poL8?=
 =?us-ascii?Q?TLs1xHrGbJM7OY/HNr+zW+YXfQiV/mABXsNDIwy51qSMN6dmO7d6eiH1hcnL?=
 =?us-ascii?Q?6kFsZncFEo8gLlcUC0Wkm/6cJ6lyhS9H1zmYh+HmvkiXNfBLXiflYER5h5iJ?=
 =?us-ascii?Q?B9FR60K3f4m7JbiAEmxCiSbCe3SwENjHvS/ZMATairrWcRU6u+rzD0EiQFwD?=
 =?us-ascii?Q?aqYhB06qnxPjAPQz4Jno3LMMYoMRLWPAtUlEOr+Af53gNIG0YwHpXKinEAZC?=
 =?us-ascii?Q?weoAmC7PCWd1B2dXENSjs4c81yP86VHezC0kIac30rjt7vSvPJOokhPnceGd?=
 =?us-ascii?Q?ePNaaDBVlRpxrBCZGjJiXdlFQfbO+MGKyecr89g7la3DI/ck8GoCgYTfTF2/?=
 =?us-ascii?Q?SLs007pEstKUhTFloK/HmD3i/yh2i2PfrBsv96j/zmND+jNdp4zN0U64ktyg?=
 =?us-ascii?Q?ge3OWkKJOlrQdlKCBBwGWj15WJ19v07LFcC70aSCqSWBQzBv5FFnLd8PPRBn?=
 =?us-ascii?Q?nQ4N9mxc/nRUECqywUTMfe98X4Sv/fxVAknFcJaNZqhwYmd8D9QQuPror2u1?=
 =?us-ascii?Q?Qg/S/Q1H40z68otFYYDMlAns5YlGQL0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca64f2f-18b1-4964-8e1e-08dea4f3def4
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 07:00:46.1022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36xYKR37WGIWuQUIuKvEgvPsL3E3GuuQNiajfKXTZThink4XtmDRpLE/Mh57gmVEZ0bdIpnT1zFOroJIQP61iphfdVXMbRybbqZPvByOPgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6960
X-Mailman-Approved-At: Tue, 28 Apr 2026 09:38:07 +0200
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

Enable required configs to support DDR retention. Including generic
firmware loader for loading backup calibration data, and SHA384/512
checking.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 configs/socfpga_n5x_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index b6df9946ef3..273e74c6499 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -90,4 +90,8 @@ CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_PANIC_HANG=y
 CONFIG_SPL_CRC32=y
+CONFIG_SHA512_ALGO=y
+CONFIG_SHA384=y
+CONFIG_FS_LOADER=y
+CONFIG_SPL_ENV_SUPPORT=y
 # CONFIG_TOOLS_MKEFICAPSULE is not set
-- 
2.43.7


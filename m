Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE894F8FA66
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:26:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C62888419C;
	Tue, 21 Apr 2026 14:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KJ1F5s/4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84A94842E6; Tue, 21 Apr 2026 14:25:56 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65DB683A91
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iagP6jPsC0WaGkThMaj8IiF2QmIbkf2sZNYVkGIZJair6zGBuHiC/xad4Sm6ClTrE3exs1u3E2lJyHHP7OX6wR7T3FCyD/uY4QOvk/Gx6uGMUk2f+nMUN8LZuAJEHHHxmeSsMl+VYk7tDG6Uo+l4oFnShf1j7wnOs+RLbP87B6PnXeN5sZB5sJNIX1zb51JbOb11EC9F1rDiNGwqDg9xuPI87qBZjaFQIHS1BnTsv1R9tKjTFZG38s3GlAXSUJBbpQny0GDIy4yEA2lyeYQ0ofiRLwTS/wrkZzh6ioRbfV1P3XzXOnFd2zBNjRqCbxXTpTMGM6J+6k3EDXHi2fDklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LFitiloXYhlj0WqUyr0RQXucTwZVRmGDvQtbwGcm9A=;
 b=GAvG8VY7vBLpyA+F9rws8y1daQcXNEQwarNMfkDvRXn3ARmlkbacvbGrtmrlWMJF9BVsijoNE2mLZafJxNUZw7mw7Z+OYlMCNznN/eQkuz/IT6AjAsW83y6r4cma+2FYOuIOkFQdfPC5QVpEvnc78qV82EVV1FlLMUZLIcp9uWnMkQdzm1+E0zCjT+ynhZniyYTcbBuOkOfXTI8j6mDx7K4kqOEGM5Hsh+9H43lkrkDt2QVkpHI4cRqpwIv8EvApK9hAxMWjLFe0cFKtIiVR+U3yw3hUUYR5U0A+kqjKpVhIJUwsXJYMHn3MH52of566gAkQ6EhopjZzR12NIeMYGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LFitiloXYhlj0WqUyr0RQXucTwZVRmGDvQtbwGcm9A=;
 b=KJ1F5s/4GHV0XBr9+1KV3DbXRrOUfuNp8PL81mZoNmVUKXEDq6WKzWYZ3MZ90nXWHADPHcqVuCgdFHHYZEWjKnDDGeoUdvd389dzWe5Z4anlYYGDFvxbq2sTjCRigJzxSTY63LW/kCjzDH0DnAd5QX/t0lc/YOfz/r/fIHeyeEarjpV6QotkCIjPc6ykzxP01QFWDbryWCkE07e+yvhcHXzEIo55feyuGC8iuTn4fJDYVulFMRg10XuoAViKKJqlXjCHSfhacUAsGVghCqEijg6ngwdlZzlg+TuVX/DY6c6McfRGpEjAc/R8Xa8ocQgDuoISCgtfqUCcK0uJYon0vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9349.eurprd04.prod.outlook.com (2603:10a6:102:2b8::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 12:25:51 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 12:25:51 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 21 Apr 2026 21:41:21 +0800
Subject: [PATCH 09/15] board: nxp: common: fix PFUZE100 DM build and unify
 DM/non-DM handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-imx8mq-dm-pmic-v1-9-0e2b490542b1@nxp.com>
References: <20260421-imx8mq-dm-pmic-v1-0-0e2b490542b1@nxp.com>
In-Reply-To: <20260421-imx8mq-dm-pmic-v1-0-0e2b490542b1@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 kernel@puri.sm
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>, 
 Ye Li <ye.li@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>, 
 "Lukas F. Hartmann" <lukas@mntre.com>, Patrick Wildt <patrick@blueri.se>, 
 Marek Vasut <marex@denx.de>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Ilko Iliev <iliev@ronetix.at>, Angus Ainslie <angus@akkea.ca>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MAXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: 782f51bd-4c2b-427b-d040-08de9fa12026
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|52116014|7416014|376014|1800799024|38350700014|56012099003|18002099003|22082099003|18092099006;
X-Microsoft-Antispam-Message-Info: Ed5dUrZ9vwl8dotoTzYqiKvZUFXVexYyoELHjkZzbcTK9Civ1qw1Hb4IPLr0NJcyFM4/XUdnhtbH4chWx832Z79iNgqK5PGfYFGNYpLvpO0nD4SPLL9Lzn2MT6GP998Ya2SckNHo2SaXp5nRXWnyAaB9JaPWBdwi6mFQHRgNnbeA7RQ0nWxWuugVz/3k9ePmvDTB6PUOUjfoyRkX88ZPEGKzLFNSExuZQLfAYYnUh+nZolELtsCwWnrWJdnLfm8Cxm+KSaiqSSh8Z4TSb5MaT/ku8RAH0E+NfhF7+6dq15NrNYJwJjwaOgzk2DTkSCPUoOL0QFz06+ty23i9+/W4xjfr3BwOEn0K/yOlVmMsPE5fyvyLABfFrA4GLB5V5DBxyT61wUY4Sru6Ej4BZWxGi76c645R+ElR5u6TfusF3CEsQWt+Pnvc9Pq+4fbZsrQg4oeytaqrdMPNlpQwgZrx8ESs/h+5IVIF4cIfS8jx3uG4w3m8wtfo9ldKO8o8YHF0l1CMhWGYRY7SZftR3fcwiKsfFeMSboGc0M1o4A9fdD+Rgc838G/QCHsXB5+v6X9UNyeCftTmHxKobUQY8449AQxPKILH78BLAyUrMDzyT7tBRKazRmJz4dI3iTiAxC/zTPAyjzeEoNhLPqpsadz86Fe+VvB08QZk7uJnH1qyg0Yo/W6yl2uAnKZxfOHHw3OVnQLdF8B+FYiMPJQRcsSX2P1S9lU7uy6DliYDBUUFGVz6L/xS5jGvQSzjjCMkA4wh2LymnM3cHoJjsh6SdwqDMidu5/mLQpyKOg2zuVYpxMw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014)(56012099003)(18002099003)(22082099003)(18092099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXAwVTZ3L2dtYy80WTRubDR5QlcyVHdrWWRFa2VMRW9qT05OdFFnZmVpU29r?=
 =?utf-8?B?VUkwRnd3UmIwTnpicFU4YUE5akp0SWdhc3lLb2ttdHNHTHVsaGxJSzVpWkJT?=
 =?utf-8?B?OVhzTGtNTStkcWZjZVhaRENObFMwcFl3ZWxVZnNWZ2JkYlFQa3hvN3VpMWdH?=
 =?utf-8?B?TmJuU2hPOXVWMmJDWFdwVVVsOWVXenh4R0F3cnkzYSswUDE4K2YyZVRtWHk4?=
 =?utf-8?B?bVNyQ2hHNEpSYmV0UXZwMnlCM2ExSWZIc3FYTzN1eG4yRzJ6VzVTSWVsZjJJ?=
 =?utf-8?B?Q0licERaMUdTM2dTVCtEaGU3OWtXMTI1VjlnMW11Ym9tWE1UUkF5bXBKQzBy?=
 =?utf-8?B?N0IrM1JKUDkxeXdJVUpGNGhYZU5RZ05teFhDUzd4SGtvU3hpazlmSmVvamZV?=
 =?utf-8?B?MnprSjRJUWJUOXJGRlNEbXBqTDRQTXo5aG5DY1dkbnIvL1J0ZlozUmRTaGIz?=
 =?utf-8?B?SUM4bnc2SmtJZHIwL0Z6OHFBRFJ0V3NIZFN2di9pejRiRU1rWnNzNEptaThq?=
 =?utf-8?B?YnppUk1OeU5PZ3RLaUs3dTMwaGdyUDNsdDQrd1pOUURnMmhIbHdXamxEWE9Y?=
 =?utf-8?B?YWMrZ2Y4SHdjZFowRENZcXpTdk5sZ1gzb2k0SHNkSVJCc3FYU0srR25xKytw?=
 =?utf-8?B?UUxlekRDU2Z4OHhSQ1lsQWhpQlZzMDVJbHNaVnV1Wjk0c1VrVUtzeWk2ckhS?=
 =?utf-8?B?QUVZVnhJR24vOUczT211Z3FQVE05TEZzY1lCek44Rk5Na0VUcnlqR2pqNjJJ?=
 =?utf-8?B?R1NSWGdzQlFhZlZiNWN2b0RteFNORXZnWjVRbWxLMlQxN2YyQkdxZlpOaHVr?=
 =?utf-8?B?dGY2Mm9WMFQyUStHTS9XWncxVVkrbGZsZjVvTU1zcHFtZzRkbGlmZGFkd0sr?=
 =?utf-8?B?WUNsKy9QaHNVT3diRFVJczJqQXpWeVdRVTV1LzJlMUcrNWFxZmpEOVVNL1lk?=
 =?utf-8?B?d3ZnSFl2dW0zczB3cHAvV1plT1hCVHpTYXJ0WnN5U1lWa3E4anVzWGJsZ0xN?=
 =?utf-8?B?Yzl5SUI4TXdqZnV4MGFDcWlTTTh0S1RSU2RJeDZVVGRhUXNHWGk4WjJ6RGJJ?=
 =?utf-8?B?SFJXZFl5amhydTgyZ2lEY2h4Qnc3Y3VSUGJhQVdzU0dIVGw5TkhjQzIwK1Vx?=
 =?utf-8?B?VkFqWVRNa0dsZmVNSzdrd0NjNnBCQTJmRXd5ZWUrV1J2c1BuVWFqcmdvSjc4?=
 =?utf-8?B?MHhJOW0xMWNZYStVQnVkQ3dUd3lNOHY5MTBLaXk0OGJMSWVZZThoTFVrSi94?=
 =?utf-8?B?eWdvYmVNRjNJSEd3a3ZFM25IRysyWUxVS3ZFMHBlUzg2QmJMNDVKZ1ltWW5m?=
 =?utf-8?B?aURVZEFYTkNzVW11ZEQ3RWRhVml0MURjY1prenhPQlRSaFJOdTlRYU9ZSjEv?=
 =?utf-8?B?YkdnMDlQK3dnUDNXNUZwRTM2R094aVNEbzVFNWlUSWQ2Yzd0cE51Q09tOTFX?=
 =?utf-8?B?a0dYU1ZHcDJRQkR5NjQwU0FHUUNyL05VOG5QRW5zU0dweG1CL2JsYUtoTy9T?=
 =?utf-8?B?NWM3Y0c2RW9QR3V5cjVhMUJ1RkFpdU1JVUl3NXA0M3JudEhZbGtQK0t6azUw?=
 =?utf-8?B?ai9ycnQ3UWJ1K2VOYjJkaHd0MzZST241YmwranpSMWdSbEI1anlhSnhjb0FW?=
 =?utf-8?B?VlZHM2p5c1JzalRLenpzUVlUQjJVelI1Y1hWZXhrQmVpbWRLdU1HYXA5Nkh3?=
 =?utf-8?B?b1ZKT3JYMGtQMm1xM0FGcjc5WUZmTGpVTVYyQkR5UW9RUTRHVFZ0ZnBTdmVw?=
 =?utf-8?B?OS8xRGZQelovdDhIdFptR3doOGNGd1NSQTVRaVFiOXF0OG43ZE1zeEN3c29O?=
 =?utf-8?B?SmoxNDlVdTFWWldCNzdIdVZFVGlzcWdic0Y4alFCNzU3Y2sweW5NS0FoWmJ6?=
 =?utf-8?B?Wnh6bXZ5a3ZidVhCQmEvd09leDJWbElCcmJMT1czTlAzS2dwNzRMR0NONnV3?=
 =?utf-8?B?T21RL0FBMVBjc2RFeEQwTmhwamViOW83N24wMTQ4Y2VQSE1PQWVWKzBBYjM1?=
 =?utf-8?B?cFNpZmhSNVZNZDNPMUt4c1Q5SVEzQWdvVDFnVDllbU1pQTJXc2tlRVI3TXJQ?=
 =?utf-8?B?SVBBTUxST3JDZjBKS2tQWGNWMDd0Y0xMNHFrMU9VVXNLU0krTTd4eGY3bEFn?=
 =?utf-8?B?TzFVRjN1WGhBcURFQ3NsdE9YMFpSTnFCeGtGSWJ2TlF1NnJjd1Rqa0ludWFO?=
 =?utf-8?B?bUcyNXVIN3ZCVWFQYlQvSGJtUXJoczlmVWhIY3R4MEVPZ0dMOTk4ZE5VNzhD?=
 =?utf-8?B?YnlKWFlUdmVyK1F6bFB1aHZjYmFxV2h1SGwzcDc0NGtPWllvUkFVOXd3WDc1?=
 =?utf-8?B?MzNhMkNqdXh0RlZ2UFJDNmljT2FqVXR0QWlPK2orMmZIN2UzVWw2QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 782f51bd-4c2b-427b-d040-08de9fa12026
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 12:25:51.4865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pi92BodvOU9u+GAAa77ghGt73+jww0Cn1AWt/9jPPdMcoER5rrPTb4pmGJoAn5YD4OLrC2UBZXc+1otidW2Iow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9349
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

From: Peng Fan <peng.fan@nxp.com>

Switch PFUZE100 object linkage to be phase-aware and fix build issues
when using driver model PMIC support.

The PFUZE100 helper code is reworked to:
- Build pfuze.o only when CONFIG_(SPL_)DM_PMIC_PFUZE100 is enabled
- Use CONFIG_IS_ENABLED(DM_PMIC_PFUZE100) for proper DM/non-DM selection
- Align function signatures and implementations with DM PMIC APIs
- Use udevice-based pmic access for DM and legacy pmic for non-DM
- Avoid mixing struct pmic and struct udevice in the same build
  configuration

No functional change intended beyond fixing DM support and build
consistency.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/common/Makefile |  2 +-
 board/nxp/common/pfuze.c  | 96 +++++++++++++++++++++++------------------------
 board/nxp/common/pfuze.h  |  2 +-
 3 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/board/nxp/common/Makefile b/board/nxp/common/Makefile
index ed102ae7bf7..dafd3717948 100644
--- a/board/nxp/common/Makefile
+++ b/board/nxp/common/Makefile
@@ -57,7 +57,7 @@ obj-$(CONFIG_TARGET_P5040DS)		+= ics307_clk.o
 ifeq ($(CONFIG_$(PHASE_)POWER_LEGACY),y)
 obj-$(CONFIG_POWER_PFUZE100)	+= pfuze.o
 endif
-obj-$(CONFIG_DM_PMIC_PFUZE100)	+= pfuze.o
+obj-$(CONFIG_$(PHASE_)DM_PMIC_PFUZE100)	+= pfuze.o
 obj-$(CONFIG_POWER_MC34VR500)	+= mc34vr500.o
 ifneq (,$(filter $(SOC), imx8m imx8ulp imx9))
 obj-y				+= mmc.o
diff --git a/board/nxp/common/pfuze.c b/board/nxp/common/pfuze.c
index 0d7a94fd232..179cc605da0 100644
--- a/board/nxp/common/pfuze.c
+++ b/board/nxp/common/pfuze.c
@@ -7,14 +7,14 @@
 #include <power/pmic.h>
 #include <power/pfuze100_pmic.h>
 
-#ifndef CONFIG_DM_PMIC_PFUZE100
-int pfuze_mode_init(struct pmic *p, u32 mode)
+#if CONFIG_IS_ENABLED(DM_PMIC_PFUZE100)
+int pfuze_mode_init(struct udevice *dev, u32 mode)
 {
 	unsigned char offset, i, switch_num;
 	u32 id;
 	int ret;
 
-	pmic_reg_read(p, PFUZE100_DEVICEID, &id);
+	id = pmic_reg_read(dev, PFUZE100_DEVICEID);
 	id = id & 0xf;
 
 	if (id == 0) {
@@ -28,14 +28,14 @@ int pfuze_mode_init(struct pmic *p, u32 mode)
 		return -EINVAL;
 	}
 
-	ret = pmic_reg_write(p, PFUZE100_SW1ABMODE, mode);
+	ret = pmic_reg_write(dev, PFUZE100_SW1ABMODE, mode);
 	if (ret < 0) {
 		printf("Set SW1AB mode error!\n");
 		return ret;
 	}
 
 	for (i = 0; i < switch_num - 1; i++) {
-		ret = pmic_reg_write(p, offset + i * SWITCH_SIZE, mode);
+		ret = pmic_reg_write(dev, offset + i * SWITCH_SIZE, mode);
 		if (ret < 0) {
 			printf("Set switch 0x%x mode error!\n",
 			       offset + i * SWITCH_SIZE);
@@ -46,58 +46,54 @@ int pfuze_mode_init(struct pmic *p, u32 mode)
 	return ret;
 }
 
-struct pmic *pfuze_common_init(unsigned char i2cbus)
+struct udevice *pfuze_common_init(void)
 {
-	struct pmic *p;
+	struct udevice *dev;
 	int ret;
-	unsigned int reg;
-
-	ret = power_pfuze100_init(i2cbus);
-	if (ret)
-		return NULL;
+	unsigned int reg, dev_id, rev_id;
 
-	p = pmic_get("PFUZE100");
-	ret = pmic_probe(p);
-	if (ret)
+	ret = pmic_get("pfuze100@8", &dev);
+	if (ret == -ENODEV)
 		return NULL;
 
-	pmic_reg_read(p, PFUZE100_DEVICEID, &reg);
-	printf("PMIC:  PFUZE100 ID=0x%02x\n", reg);
+	dev_id = pmic_reg_read(dev, PFUZE100_DEVICEID);
+	rev_id = pmic_reg_read(dev, PFUZE100_REVID);
+	printf("PMIC: PFUZE100! DEV_ID=0x%x REV_ID=0x%x\n", dev_id, rev_id);
 
 	/* Set SW1AB stanby volage to 0.975V */
-	pmic_reg_read(p, PFUZE100_SW1ABSTBY, &reg);
+	reg = pmic_reg_read(dev, PFUZE100_SW1ABSTBY);
 	reg &= ~SW1x_STBY_MASK;
 	reg |= SW1x_0_975V;
-	pmic_reg_write(p, PFUZE100_SW1ABSTBY, reg);
+	pmic_reg_write(dev, PFUZE100_SW1ABSTBY, reg);
 
 	/* Set SW1AB/VDDARM step ramp up time from 16us to 4us/25mV */
-	pmic_reg_read(p, PFUZE100_SW1ABCONF, &reg);
+	reg = pmic_reg_read(dev, PFUZE100_SW1ABCONF);
 	reg &= ~SW1xCONF_DVSSPEED_MASK;
 	reg |= SW1xCONF_DVSSPEED_4US;
-	pmic_reg_write(p, PFUZE100_SW1ABCONF, reg);
+	pmic_reg_write(dev, PFUZE100_SW1ABCONF, reg);
 
 	/* Set SW1C standby voltage to 0.975V */
-	pmic_reg_read(p, PFUZE100_SW1CSTBY, &reg);
+	reg = pmic_reg_read(dev, PFUZE100_SW1CSTBY);
 	reg &= ~SW1x_STBY_MASK;
 	reg |= SW1x_0_975V;
-	pmic_reg_write(p, PFUZE100_SW1CSTBY, reg);
+	pmic_reg_write(dev, PFUZE100_SW1CSTBY, reg);
 
 	/* Set SW1C/VDDSOC step ramp up time from 16us to 4us/25mV */
-	pmic_reg_read(p, PFUZE100_SW1CCONF, &reg);
+	reg = pmic_reg_read(dev, PFUZE100_SW1CCONF);
 	reg &= ~SW1xCONF_DVSSPEED_MASK;
 	reg |= SW1xCONF_DVSSPEED_4US;
-	pmic_reg_write(p, PFUZE100_SW1CCONF, reg);
+	pmic_reg_write(dev, PFUZE100_SW1CCONF, reg);
 
-	return p;
+	return dev;
 }
-#elif defined(CONFIG_DM_PMIC)
-int pfuze_mode_init(struct udevice *dev, u32 mode)
+#else
+int pfuze_mode_init(struct pmic *p, u32 mode)
 {
 	unsigned char offset, i, switch_num;
 	u32 id;
 	int ret;
 
-	id = pmic_reg_read(dev, PFUZE100_DEVICEID);
+	pmic_reg_read(p, PFUZE100_DEVICEID, &id);
 	id = id & 0xf;
 
 	if (id == 0) {
@@ -111,14 +107,14 @@ int pfuze_mode_init(struct udevice *dev, u32 mode)
 		return -EINVAL;
 	}
 
-	ret = pmic_reg_write(dev, PFUZE100_SW1ABMODE, mode);
+	ret = pmic_reg_write(p, PFUZE100_SW1ABMODE, mode);
 	if (ret < 0) {
 		printf("Set SW1AB mode error!\n");
 		return ret;
 	}
 
 	for (i = 0; i < switch_num - 1; i++) {
-		ret = pmic_reg_write(dev, offset + i * SWITCH_SIZE, mode);
+		ret = pmic_reg_write(p, offset + i * SWITCH_SIZE, mode);
 		if (ret < 0) {
 			printf("Set switch 0x%x mode error!\n",
 			       offset + i * SWITCH_SIZE);
@@ -129,44 +125,48 @@ int pfuze_mode_init(struct udevice *dev, u32 mode)
 	return ret;
 }
 
-struct udevice *pfuze_common_init(void)
+struct pmic *pfuze_common_init(unsigned char i2cbus)
 {
-	struct udevice *dev;
+	struct pmic *p;
 	int ret;
-	unsigned int reg, dev_id, rev_id;
+	unsigned int reg;
 
-	ret = pmic_get("pfuze100@8", &dev);
-	if (ret == -ENODEV)
+	ret = power_pfuze100_init(i2cbus);
+	if (ret)
 		return NULL;
 
-	dev_id = pmic_reg_read(dev, PFUZE100_DEVICEID);
-	rev_id = pmic_reg_read(dev, PFUZE100_REVID);
-	printf("PMIC: PFUZE100! DEV_ID=0x%x REV_ID=0x%x\n", dev_id, rev_id);
+	p = pmic_get("PFUZE100");
+	ret = pmic_probe(p);
+	if (ret)
+		return NULL;
+
+	pmic_reg_read(p, PFUZE100_DEVICEID, &reg);
+	printf("PMIC:  PFUZE100 ID=0x%02x\n", reg);
 
 	/* Set SW1AB stanby volage to 0.975V */
-	reg = pmic_reg_read(dev, PFUZE100_SW1ABSTBY);
+	pmic_reg_read(p, PFUZE100_SW1ABSTBY, &reg);
 	reg &= ~SW1x_STBY_MASK;
 	reg |= SW1x_0_975V;
-	pmic_reg_write(dev, PFUZE100_SW1ABSTBY, reg);
+	pmic_reg_write(p, PFUZE100_SW1ABSTBY, reg);
 
 	/* Set SW1AB/VDDARM step ramp up time from 16us to 4us/25mV */
-	reg = pmic_reg_read(dev, PFUZE100_SW1ABCONF);
+	pmic_reg_read(p, PFUZE100_SW1ABCONF, &reg);
 	reg &= ~SW1xCONF_DVSSPEED_MASK;
 	reg |= SW1xCONF_DVSSPEED_4US;
-	pmic_reg_write(dev, PFUZE100_SW1ABCONF, reg);
+	pmic_reg_write(p, PFUZE100_SW1ABCONF, reg);
 
 	/* Set SW1C standby voltage to 0.975V */
-	reg = pmic_reg_read(dev, PFUZE100_SW1CSTBY);
+	pmic_reg_read(p, PFUZE100_SW1CSTBY, &reg);
 	reg &= ~SW1x_STBY_MASK;
 	reg |= SW1x_0_975V;
-	pmic_reg_write(dev, PFUZE100_SW1CSTBY, reg);
+	pmic_reg_write(p, PFUZE100_SW1CSTBY, reg);
 
 	/* Set SW1C/VDDSOC step ramp up time from 16us to 4us/25mV */
-	reg = pmic_reg_read(dev, PFUZE100_SW1CCONF);
+	pmic_reg_read(p, PFUZE100_SW1CCONF, &reg);
 	reg &= ~SW1xCONF_DVSSPEED_MASK;
 	reg |= SW1xCONF_DVSSPEED_4US;
-	pmic_reg_write(dev, PFUZE100_SW1CCONF, reg);
+	pmic_reg_write(p, PFUZE100_SW1CCONF, reg);
 
-	return dev;
+	return p;
 }
 #endif
diff --git a/board/nxp/common/pfuze.h b/board/nxp/common/pfuze.h
index 45b49afaeb7..da89853bd20 100644
--- a/board/nxp/common/pfuze.h
+++ b/board/nxp/common/pfuze.h
@@ -6,7 +6,7 @@
 #ifndef __PFUZE_BOARD_HELPER__
 #define __PFUZE_BOARD_HELPER__
 
-#ifdef CONFIG_DM_PMIC_PFUZE100
+#if CONFIG_IS_ENABLED(DM_PMIC_PFUZE100)
 struct udevice *pfuze_common_init(void);
 int pfuze_mode_init(struct udevice *dev, u32 mode);
 #else

-- 
2.51.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F835CA0ED1
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 07:13:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76DA583A24;
	Fri, 15 Aug 2025 09:13:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="GTruamfq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2079D83A92; Fri, 15 Aug 2025 09:13:25 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20710.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::710])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 191F5839AF
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 09:13:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apcfr7kca9C/hLodSzKwsxW3KYytQS3Ohh8Ns8ynIJ4VtSGmi+OXCuUKkqAZBZJYwzkIbShR7h/C3p3klVprXbo4dhguVIKwES1260aqNnLgawxHm31+IQ2hu0vDlE6cIToWgrnj5LSqlOCOAL4NHmKG/CoAQ+UptAzZzHRNSxYM1JUG57GN9Ens4Yx2A/C0keAOI3HQiRPL9v/rSRoNNI7MhF1UaIOPlBvvnhJhYtfrykEh/madlcRSlEuuWCzoXtcZE6e0z+rDY5a5kQB2Sn5QvnUg4IbPFsPLF1FJJKFKRl1Z2MPCJHb8JrDJeqaAAhZhcCUF6KvRk3IWnwtEWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y60bLMrKwLmoZj+lRuz1h1In4IjtCc+U27W248dpFGM=;
 b=PySdQ6j2pT34ogGVWv+PlwJpFN0De+cl1Zd6zhUaQH995efvE3YqbZT4Zptjp3XqF7wCsjLDGx5rjKKc5pPAhVjljxpN5D6DQSCKPOCyGRQYnK0vbGMOUKr9PQr+E2XUTU9A4jluZlsgj6lDp1IbYYnloWSAlQE2fLoOKro0PvV7Hc/gi1LGWlTVJw953LJPoA/DLnHCApCuX4C0xBtmqPQTFquR2jIdwXJzM8HJptOcKZCZrpUGLG7u32bMYweWFF/vrO0QxLfCE+qOc/bO33AeCkgWhPmFuO95690ei8mAIeScXEv2ZH6iKBNCeOM8kxZJclsyNuVZhTWitoPr7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y60bLMrKwLmoZj+lRuz1h1In4IjtCc+U27W248dpFGM=;
 b=GTruamfqZVESQEX4R9WWMNQ20gIdl2L2NCUYZOAikBpbcShdnc/Ir3W9FKgNQFmNftBgLK/n/bjVZJ3nqCXSvU/hjhAHg/p2fT+AGX28h/i7ed1XIvuaDaTbfTm/ocZnKr/x9Ui9d6RhhkLEFcWGEpSYJuV3c/UpmuNItSqjcHV8dIEqiO3VGRF8CEwNbRMRlPk+ATJEF+xn7PK7ul/ykAma2vEiIka7XcW02YYCfwYJxgBp09tURpMmZTGJZSqH0zSoWuAlbwohahetbjHYODsY3l8k6bPoyt74Ax7yp5gy8cBANkqIOaAD/yMn0yI2tZbiEowZe2zM1X+PMjZp8g==
Received: from DB7PR05CA0027.eurprd05.prod.outlook.com (2603:10a6:10:36::40)
 by VI0P195MB2485.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:247::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 07:13:18 +0000
Received: from DU2PEPF00028D09.eurprd03.prod.outlook.com
 (2603:10a6:10:36:cafe::22) by DB7PR05CA0027.outlook.office365.com
 (2603:10a6:10:36::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 07:13:18 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF00028D09.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 07:13:18 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 15 Aug
 2025 09:13:18 +0200
Received: from [127.0.1.1] (172.25.39.83) by Florix.phytec.de (172.25.0.13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 15 Aug
 2025 09:13:17 +0200
From: Martin Schwan <m.schwan@phytec.de>
Date: Fri, 15 Aug 2025 09:12:56 +0200
Subject: [PATCH] bootstd: rauc: Do not select BOOTMETH_GLOBAL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250815-wip-bootmeth-rauc-no-config-global-v1-1-4de26389bdb2@phytec.de>
X-B4-Tracking: v=1; b=H4sIAPfdnmgC/x3NQQqDMBBA0avIrDuQCKL1KtJFMk7igM1Iom1Bv
 HuDy7f5/4TCWbjA2JyQ+SNFNFXYRwO0uBQZZa6G1rSdGWyHX9nQq+5v3hfM7iBMiqQpSMS4qnc
 reuL+STb0ZrZQQ1vmIL97Mr2u6w9EntKedAAAAA==
X-Change-ID: 20250815-wip-bootmeth-rauc-no-config-global-bce79c1f70d1
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Wadim Egorov <w.egorov@phytec.de>
X-Mailer: b4 0.14.2
X-Originating-IP: [172.25.39.83]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D09:EE_|VI0P195MB2485:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ef63a53-393a-4972-206e-08dddbcb35e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUk2anJhOXFIT1kzeVVlV0UwTVhuNkFsQ1lkZmRkZjVNSlpvN1Jab0pVSlBz?=
 =?utf-8?B?dUhpQi9zU0h4bzRRb3FXVmxPM2hNUmtBVXNBUEdIWnlIaFNXSkVWM3ozU0JP?=
 =?utf-8?B?eXBMU012TWRXUVAzOGVQY1ZaMFBScm1MOEdlcDQzOXRGYk9wb0VleVdyQmlU?=
 =?utf-8?B?ZEhRSTQrMWd5TW9PUGFhWW40T1ltMUdVTTNKbGdOdURIRllSeTJWMnVFcDg1?=
 =?utf-8?B?Vkh1KytvZG5iMzlHSEVmUDgzK1VoS0ZzL2FESXpmNGpDWlJsbGdPTzRPSEVD?=
 =?utf-8?B?bVVRYVQwVVVGdjlpc2FIb0syWFduanhWQ2YvQzJNTVJUZDlrenJkN0lHd0py?=
 =?utf-8?B?cWhURElHa2tiM2tBRnFZVmlUcFFuYVVjbU1iMGN3SjZ0QzJQUEVxNWtPTzdt?=
 =?utf-8?B?YUpXQkxvbEVMLzU1MnVhZEVhRlZjNmdRcVBFbURrZFJtZzFTREhsbTh1MkVY?=
 =?utf-8?B?WE5ERjU1TXhXOVp5dzRldlZ0SU9oZG1OWXNCRUtLYlZiY29FY2ZKZDVQd3Qv?=
 =?utf-8?B?bzlDSWhJVnJKUmkwVi8xVEp2RTVhU1FKSXN6WjVVTUlzZ3NvTFJDMGZFTkxV?=
 =?utf-8?B?QmVwOHhMcjZaQWFtSTdBYjlaLyswcFV6eTVhcFo5U2dlY05yOEhmdWFvS2V1?=
 =?utf-8?B?VDZycFkvMGIvbkZkRm9pMjVhb2ZuNmM1ZEExeW5xVk52Y1ptWjFHQUpTTTZz?=
 =?utf-8?B?Z3dzbGhKTlIzZmNHYU9vanRXL1J4UUw1NkVOR0o3bmU0c1FLa0I5TjM2bEV5?=
 =?utf-8?B?bU5mN2pMZ1E2Z1FNdUhwbU9rdUlSQmdpZUpxQjFmSlE4ZUZjcXp0eThTaU5C?=
 =?utf-8?B?aWErMEpYV21WVVIzL0VOQ0lNTlN0Q051RXQxQzhNN1N5bktXanRCSTFwK0VL?=
 =?utf-8?B?VXl6cXB1ak1nMkZ4V0s4R3hGNFpoRVZjaGdlTGFPSkVNVnk3d3ZZZy94QzVU?=
 =?utf-8?B?eFhnYTM3NDUrRy9ycE5rcEt2aVF0aE5iKzltMEFJTUhtWm42S09ucEtpQnRv?=
 =?utf-8?B?WnhLRVNYRlo5WTg0R0VVcGVSUTUreFV3NlBheld5bERjVFd1MlNaaUVNcmNT?=
 =?utf-8?B?ODBJNSs4cndWM2orUHhTZnp2NmdQZDc5NEdLYjVOSUhEY3NCQkNZYnlOM3BM?=
 =?utf-8?B?em9saVlVUGc2dklpVXVvWDkvVVhkZ0t5R0MvTUVvTjRkTU5VZFd3Q25VcW9P?=
 =?utf-8?B?b3BBYUxPWkx1cmgvbk5hUDlZekNJUnpwUjhvb2MwREFiVGJlejA4UXVRSjc2?=
 =?utf-8?B?WU5jeFV5TTFJWDZYUnppMWFGbzYyRldpWnRHbkU5YUQybnZMNi9SRWRzejJY?=
 =?utf-8?B?ZDdLT3NUTzhkUm5EdzJBekNyRkxhak9kckJ5SDZGQlE0QTYwZUtLbzVDcHVv?=
 =?utf-8?B?MnkxZkZXQVpwZjVRSU1VR1R2WjE0eWxYZ1BBK0JnTWNwakFPcWJmNjdWc3Fq?=
 =?utf-8?B?SzlMU2RkWFFOeWlPUFFYZCtCRFJsSzA4QkplZVFjcXpEV0VoNFlvSTlEZHlO?=
 =?utf-8?B?MU1iaHRBbS8xWHZCdC83SC84RVFnNVk1cnJ6bzBucElqUGpwbkpxYnA5UXlC?=
 =?utf-8?B?Kzd2SWlpUk5XVGJuRUJqbzJsWnlNTEk1dG9IeFdPd3Y3ampHUmJQd2loanE1?=
 =?utf-8?B?TU5mQWhDaDFoUXo4dkFNUE5Xcmt4aWltdWFJSlVJbXRDNlNUNHJZTm52QVQx?=
 =?utf-8?B?SHFTQTBXYmRSb21PeGVwRStwcFZydzk0L1ZWR0JQa2tSSEFoUUl0elREbzF6?=
 =?utf-8?B?VW1FZ1NlNUlZOHgyU0JmMCtXQkFEMjl4UTBqNXBHQjh3aFNDVUxtQUQ5RjRH?=
 =?utf-8?B?TkJXNENZUDVDQ1YveUZEQjRVVU03VURoZEpsZStaWFNHVHBhdG1hRzRaS3Ux?=
 =?utf-8?B?amJsclplTnhuY284dXJaa0R1YUtRLzFja1J1OHdxQXhUcHNxYTI5VWJKNkZ0?=
 =?utf-8?B?ZUVZLzgrMlp6SjRVbHNTNEFiSldJZDhJaXFBaE9UUHhoQ3FEN091Q0FPM1kr?=
 =?utf-8?B?Q0RUY2JQaE96OWlQNzRDeFhCZ3BvRm1RTmVEQU1OdU9ZRm5jSUl1U0ErWmFk?=
 =?utf-8?Q?n2Me+M?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 07:13:18.5009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef63a53-393a-4972-206e-08dddbcb35e8
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D09.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P195MB2485
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

Since the bootmeth "rauc" is not a global boot method, do not select the
corresponding BOOTMETH_GLOBAL option.

Signed-off-by: Martin Schwan <m.schwan@phytec.de>
---
 boot/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 54ef7052c5c7b9d8ad8587c7aac6ef3ebfe74993..2993cd7f9ba891d7929cc916563fdf4679d82591 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -869,7 +869,6 @@ config EXPO
 config BOOTMETH_RAUC
 	bool "Bootdev support for RAUC A/B systems"
 	depends on CMDLINE
-	select BOOTMETH_GLOBAL
 	select HUSH_PARSER
 	help
 	  Enables support for booting RAUC A/B systems from MMC devices. This

---
base-commit: 0c558bbad9e7581808b358091d1fd979f860e8ac
change-id: 20250815-wip-bootmeth-rauc-no-config-global-bce79c1f70d1

Best regards,
-- 
Martin Schwan <m.schwan@phytec.de>


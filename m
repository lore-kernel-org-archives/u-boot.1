Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D7EC5DF70
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 07:44:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5871F608EA;
	Tue, 18 Aug 2026 07:44:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2At5d3NYMKov; Tue, 18 Aug 2026 07:44:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 87699608D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787039047;
	bh=gVCrvYBWQ4/xuJuaE0eL4FwUg0lXcApprowVcvVxqrI=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WyGKTddgvn41MMAaINVuK9NB5BZBfwUCdANdBGJPqvLwkGtV3/0wB/BzwhsrpuFC4
	 +VJjeajXthpCrY9PqzwJHD7TDbLzTq9B4dkclzGsTR5ui7muPbKGjZ3oSJkEHbQQ6Q
	 ZsVXNS7k9CUMdmzDantQ+YK3dmFAsdttkx5XgFN5KyfjEZOmOXcfptyKftZbbbZkR0
	 xGae1uOWRLvkLCxbraQuGHO281plccAj1WZu5yVxTVp8V6ANMw745RgbB0vhwbwoFp
	 wNAQPgdr5Kg/YRO1tBRufotq2qsvp+XLrlP5ZbYi7rCfc3dCXYO7wihOxDwasdm0Sc
	 HaZgUr5oS6j5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87699608D2;
	Tue, 18 Aug 2026 07:44:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 319F42EF
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:43:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 23D6F40103
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:43:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xe9oFaHOFbkh for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 07:43:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AE66C4005F
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AE66C4005F
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=aqYKLiVW
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AE66C4005F
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:43:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IlN/WlgUF46i3vlZUSFrX6bTmmhmGkU5+/eRHnTUhzhjhZOydwXzzb0qF9TWCVpDuNfcN03WhNprXdPTXZ37dgfs0h4BXjVDVBPgjgDEKq9sNEEWpwbsDye3ELBcGByh5QLdZnWAkkPVc1GWyfn/Xo43a4kHMovMyPq2RMS8qPE5qnid6yq7t7cmfAMJmYbTjU+3wKxYtt0XjYiCextgy2egVhRBD4bXS+JhxuRWSw/a9DDD7xtmfo54KvBXTdi9X+jr0f8h5ELAlbfAJjvJtQmftkDrsm30Ph3kgWMbzSAQf7W3E3Aw34k5uocQ5qgc0pdCZRraVVitrNbbgOpm2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVCrvYBWQ4/xuJuaE0eL4FwUg0lXcApprowVcvVxqrI=;
 b=V004++39lSRGs54WECn9SHWN3laWlahzBLKTcCIkOa9NGAlMpN221obagKQZlx2BXW6oxj6AppZKjiCCtfFVjnAuMhvMcVMocL9omQVlhX6JFdcKCCN3VxFM33//O2MEoeIwZy3Tf8Nlopiuu0TmJ1PI/N4/lNp81e2n6dF/wAOSIejAiuPQQuFIpauDlQykuBYKSrrzdM4wIvAhWYK3ZeYp6y3plwRDjJjd5O/sB1XgUl7z1De8Kg0kiUpYut8Xsp3qNz/7uk/xK7EMC0T/HzlMzIV6vw7YLB1iD83cSw0U7z18GdPWoff04OW6td+51UYy138wSdKvjQQj1MrbQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVCrvYBWQ4/xuJuaE0eL4FwUg0lXcApprowVcvVxqrI=;
 b=aqYKLiVWLwI/TkWf+CdJjse8Pss+81Zekj/Yaua5AJ71FO+JgSPMTxyHrwVKcXeg/pYEDph755h3z6rGKOktlHk+hGH+NKlZhEZrqwun7ms2uBtNrdJpAjKlpyt9B8Q316h2us7k/Z/LbpiGExmgjpzWWIH79cphIcmlyVvDS5jFatDMnKQ+VQWTWdUQeVGz43faUChtTMG0UHNKsWbEyb9MMvipTcIoN5oEEoJFruo8hHmE7YPKRkfeDWGavtRFLSD5Ri8OnOI9X5UywWHzfwbYu2r7b3bvPdgdTHzSrsWtHB8Jr23HbRGl2geHvVlgt3zMnqsEkdPWmdRo4x3PMw==
Received: from AM0PR02CA0155.eurprd02.prod.outlook.com (2603:10a6:20b:28d::22)
 by GV1PR07MB10814.eurprd07.prod.outlook.com (2603:10a6:150:282::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 07:43:45 +0000
Received: from DB5PEPF00014B8B.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d:cafe::5a) by AM0PR02CA0155.outlook.office365.com
 (2603:10a6:20b:28d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 07:43:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.6.101 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.6.101; helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB5PEPF00014B8B.mail.protection.outlook.com (10.167.8.199) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Tue, 18 Aug 2026 07:43:45 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id D70451C003D;
 Tue, 18 Aug 2026 10:43:44 +0300 (EEST)
From: Juuso Rinta <juuso.rinta@nokia.com>
Subject: [PATCH v3 0/6] watchdog: report effective timeout
Date: Tue, 18 Aug 2026 10:43:24 +0300
Message-Id: <20260818-rinta-watchdog-gettime-v3-0-423f5caf526d@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABwNhGoC/3WNyw6CMBBFf4V0bU2Z8qor/8O4KDDAaGhNW1FD+
 Hd5bNiwPMm954zMoyP07BKNzOFAnqyZQZ4iVnXatMipnpmBgEwkkHNHJmj+0aHqatvyFkOgHnm
 mEVDoPFOFZPP55bCh7yq+3Tf27/KBVVhsy6IjH6z7reUhXnZbJI/FUWSIueBKqwKaUskmUVdjn
 6TPle3ZEhlgpwE41MCskQohUakQaSL3mmma/gn3jyEVAQAA
X-Change-ID: 20260427-rinta-watchdog-gettime-6ae2e0a76983
To: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>, 
 Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787039024; l=4918;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=j2glHR8LuIaeJJY2rp1GUBdlpPc9OjhpKe5WeXaQRGY=;
 b=Bn07A3cWxVSqkzi7Ssre67MVzYF/U9JaYgounJg79UL/q0g/xZXaWA2nj9fzO+529vMOswQAI
 VPYP1TyxyFFD8SBUS7jYH4s2dKI0cTq8QuyGkFq9YI+lDNd0vmqC1cC
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8B:EE_|GV1PR07MB10814:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c2194cf-d3fa-41de-f3be-08defcfc6ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|10067099003|56012099006|3023799007|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: Gjsj83zMI0QD0yiLZa6hkmvSf4NxvomXPs1CBONgWF9++z5J94TsHRaUzujFZKIx6ArHq4e9XDstBKU8TzXVQevxI3Bm56k+CuogJ5Am8KXVrpFPBryuSbpRgcwNFJejuXc4vwnqbEc06MtUAsPWE4AusJWtvPQqK5hratc2gdLmouCVK07i97SHMtbMua39QiK8mga+wdkC8GViyVXCsh/DT9feGQAbxoGmXixBziKQx/b55GrpAviYAUkZfqeJ5Up/vru9hRHTK0/l1tds306eimmyagnJvKta98PBroaCH4PjWjaNYk3z1/judW+xZhDaev2vc17I6g1aFOjZ0upAFIG5u+sGi+Q/ndjScZ5cOhkCxsIcqLpamuxY86aM2IV7hGPB/Dm2snLmRzNqsCcIhg2T8tZeuQ3rXsikxRL+5FxdxnFx06TUIJRwQH5kRAyYcb801Hn0gltFzsHdZ+8ooz0LpWU+yv3In9pmZjr309posXndvE5x4bg7GcdRw7KZImZ8EmnbULfRfHvJIK6/hq5H63HvFnXxTefbAQnKRRnQetFYzaCNlIIv/7Ywqlos6xhE2g1EFkgsUQe4B2ol1qQbTCcp71fzQHJ2B2jmYZXOlD1Ib5gOXsiJjBaBh3EuCDiRVuHuwwzuOX7/k2bS07XTIJJOVZLKLaMg5BA=
X-Forefront-Antispam-Report: CIP:131.228.6.101; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fr712usmtp1.zeu.alcatel-lucent.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(10067099003)(56012099006)(3023799007)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1Rk/oO76ZFFXrXVmteabVSHR7oTF/Xw79D61/5qYXrBK6oOnkM0XpZv3w0sJgU64YLUMCcslFNI+y67IkUQByTiUz5M393U6sgQfcBhnlBkcRmsQEd9JWfz5b6IIGEG26o0ukp51PMR4f9TBsYc3KxhiFh9Z+m9TYsbgoqWkyOmgeM1MIOjlkuS1Xu+AUz+kG3YIpal/UukyJ2WiCnkL2NC6QDMPu9xXBBT1Q7RoeUFqXop3am4QeUkzMh9yGjR1NCBdKy7gDCSmnbClW0oaGF2zfqefI4Cq+4Znt+cgbkASWU5KVRsnYh1K9IV5Suo5/YlvnTakLh5AUAvvbfaMmU/vSMl+RZSdBt9rNDE5t01YmYAXe+r2Z6rYB7uzUv6NgpDu+gknqhFepX7ZjPvr20hsf3kRmQJHdyI3O5T6+u7ccN/3jRQAXZ4XMTh+ay+4
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 07:43:45.3381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2194cf-d3fa-41de-f3be-08defcfc6ed2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.6.101];
 Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B8B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR07MB10814
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

This series provides a fix for the wdt_start() function, which can
print incorrect timeout values in cases where the function is
called with a timeout value greater than the hardware-supported
maximum. The current implementation prints the requested value, so,
for example, the console may show that the watchdog timeout is set to
60 seconds when it is in practice clamped to 10 seconds by the device.

The series introduces the max_timeout_ms value into the per-device
uclass-plat data. By default, this value is initialized to 0, and
drivers should write the hardware-limited max_timeout_ms value into
the plat-data typically during probing.

If the driver has reported a max_timeout_ms value, wdt_start() clamps
the requested timeout_ms value before calling ops->start(). The default
value 0 is considered "limitless", i.e. on drivers that do not set the
value, the prints and the functionality are unaffected by this series.

The series implements this support in sbsa_gwdt, octeontx_wdt and
sandbox_wdt drivers.

This fix improves the overall correctness of the console output and
can be helpful in debugging cases, since the console prints reflect the
real timeout on the device when the driver supports the feature.
If it is unsupported on the device, the print remains as it was before.

Patch summary:
- Patch 1: Cleanup wdt_start() as a preparation for patch 2. Rename existing
str to svc_str, replace memset with svc_str[0] = '\0' and use sizeof(svc_str)
in the snprintf instead of the hardcoded magic number.
- Patch 2: Add per_device_plat_auto to the wdt uclass and a max_timeout_ms
field in a new wdt_uc_plat struct. wdt_start() uses the field to clamp the
requested timeout and report the effective (clamped) timeout when the originally
requested value is greater than the reported maximum value.
- Patch 3: Set max_timeout_ms in sbsa_gwdt_probe()
- Patch 4: Set max_timeout_ms in octeontx_wdt_probe()
- Patch 5: Set max_timeout_ms in sandbox_wdt_probe()
- Patch 6: Add a DM test for clamped and unclamped cases.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
Changes in v3:
- Split the wdt_start() str -> svc_str cleanup into its own patch
- Clamp timeout_ms in wdt_start() before ops->start() when the driver
has set max_timeout_ms
- octeontx_wdt_probe(): calculate max_timeout_ms with the same u64 division
as octeontx_wdt_start()
- Drop the extra clamp in sandbox_wdt_start()
- Tests match a fixed start line instead of reconstructing it, and
cover the sub-second clamp case
- Link to v2: https://patch.msgid.link/20260722-rinta-watchdog-gettime-v2-0-39e249500543@nokia.com

Changes in v2:
- Reworked approach. Dropped the get_timeout operation and switched to
per-device uclass-plat data (max_timeout_ms) for reporting effective
timeout in wdt_start().
- Added struct wdt_uc_plat and .per_device_plat_auto in the WDT uclass.
max_timeout_ms = 0 is treated as no driver-reported limit.
- Dropped the wdt gettimeout subcommand changes from v1.
- Updated sbsa_gwdt, octeontx_wdt and sandbox_wdt drivers to set 
max_timeout_ms in probe.
- Extended sandbox_wdt for testability by adding an emulated max timeout
and clamp path.
- Reworked DM tests to cover unclamped and clamped startup print paths, as
well as max_timeout_ms set/not-set behavior
- Minor cleanup in wdt_start() string handling
- Link to v1: https://patch.msgid.link/20260710-rinta-watchdog-gettime-v1-0-9a982fb93f49@nokia.com

To: u-boot@lists.denx.de
To: u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Yao Zi <me@ziyao.cc>
Cc: Juuso Rinta <juuso.rinta@nokia.com>
Cc: Antonio Borneo <antonio.borneo@foss.st.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Simon Glass <sjg@chromium.org>

---
Juuso Rinta (6):
      watchdog: wdt-uclass: rename str to svc_str in wdt_start()
      watchdog: wdt-uclass: report effective timeout in start print
      watchdog: sbsa_gwdt: set max_timeout_ms in probe
      watchdog: octeontx_wdt: set max_timeout_ms in probe
      watchdog: sandbox_wdt: set max_timeout_ms in probe
      test: wdt: add a test for max_timeout_ms

 arch/sandbox/include/asm/state.h |  2 ++
 drivers/watchdog/octeontx_wdt.c  | 16 ++++++++++++++
 drivers/watchdog/sandbox_wdt.c   | 11 ++++++++++
 drivers/watchdog/sbsa_gwdt.c     | 12 ++++++++++
 drivers/watchdog/wdt-uclass.c    | 30 ++++++++++++++++++++-----
 include/wdt.h                    | 11 ++++++++++
 test/dm/wdt.c                    | 47 ++++++++++++++++++++++++++++++++++++----
 7 files changed, 120 insertions(+), 9 deletions(-)
---
base-commit: 1b8283bd3220e898d338fb98929f0b06ed63da84
change-id: 20260427-rinta-watchdog-gettime-6ae2e0a76983

Best regards,
--  
Juuso Rinta <juuso.rinta@nokia.com>


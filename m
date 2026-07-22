Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B653C44532
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 10:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8791C408A8;
	Wed, 22 Jul 2026 10:58:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kdHGzq8f4FNN; Wed, 22 Jul 2026 10:58:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1DD884088B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784717918;
	bh=FWXliaD3JI/i4nK4Tm8mrpZS1vZMNm5QSFfjyIKfXWc=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=paQor3hnhZ/lABA71gYHgn29o1Y4qVeoKj6hE3Ppmmc/5k6Flli+2wbM+fUSkWmmv
	 UqvcNex5LU/ZyWpSAptM4wK0hX2A7CYQUW0RbO24scqPaWW/mJJasfiD9+hshtNDcj
	 VruJuTmmW0aujNB1q4t0RxvAbvbEz0wHWQOztEZRfkgSTIN2CTpDR58LcHPXrJNrEz
	 /tQaAGxmRWg/ocX3qm2TOKyKeEVCfgdGfAU/oaSDTuYrMg+eDaxg2B/ztpTWO5N6vI
	 W7VrO6eFcD9ZWCxJ+Smv3Jtxp0qYzWcPbznJeZ2U4SzSoKQZ3RtisH9OSIcTgWhYqS
	 fj3QDbXaL1rxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DD884088B;
	Wed, 22 Jul 2026 10:58:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C68642A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:58:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5E6B0607D4
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:58:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1ShYMWLattQp for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 10:58:28 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E94DE607DC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E94DE607DC
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E94DE607DC
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:58:27 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AE328495B; Wed, 22 Jul 2026 12:58:26 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EDBF849BC
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 12:58:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wt7jedAbpd0g0OCCHlpWqwAtfu4XN5tqY+fUN3P6BpbIHRMBx7U+AD+ap/Euk30Anqeovd+U9g5BEc8bnOv5rhkc/m7sOCZ4Mv1zCqtOh37ZCbB/rrwNIaFVbgxlnHS6UMHoG5ywPo3ZXbyUWd+yiIhm92gIn9c7fiJPtDfJAQDfn27BhsBkYY52dytJvHzOP44fS5gtzoSkeD48S82T2GxmN2WVV7jybF2ejkouyYmeTq6FmNEFhq7pnC6QQUHsMZG2YPBNSyacA7x8Tisgqzu+rW9S7qYyNfMyjnL81Ld/gqNkNVlCSjl0LYfhI2ideBgxsHR5r1SNZ3NefgCPJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWXliaD3JI/i4nK4Tm8mrpZS1vZMNm5QSFfjyIKfXWc=;
 b=EweQ1e9mGvyv0/aGZ4xNoM/XQllOCiKmkSEeQQkJFbUrqDG/1QVxNphzjk75FpFOkoeDwZ4NF5Fue9HMLnVQkhZuA6aCIGcqGmWfGkQxBHQETY7Qx6KllSf1KGeXXa68XyZrWlJm20b5dlVQcOuKP8rJVJyzlIJCKRmrxWGfPmKTJmSJHxiydf3hKAumvJfg4fThGKTulPadTk8vm6yM+Up5SrGuXXnSfWO1VhZZQ9STnZ3f4wp21V61s1bU1biuIDzYk7681Qrq6BeJ/3TNGNTc7sTR1I3zu1LoEVZWZz+87lnZp5/1SkQXc+C80Gep16f237+CoO1jnt/EW92S/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.84) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
Received: from AS9PR01CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:542::21) by VI0PR07MB10150.eurprd07.prod.outlook.com
 (2603:10a6:800:25b::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 10:58:19 +0000
Received: from AMS1EPF00000090.eurprd05.prod.outlook.com
 (2603:10a6:20b:542:cafe::39) by AS9PR01CA0043.outlook.office365.com
 (2603:10a6:20b:542::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 10:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.84)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.84 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.84; helo=fihe01smtplvp01.emea.nsn-net.net; pr=C
Received: from fihe01smtplvp01.emea.nsn-net.net (131.228.2.84) by
 AMS1EPF00000090.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Wed, 22 Jul 2026 10:58:18 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe01smtplvp01.emea.nsn-net.net (Postfix) with ESMTP id 97E7080000B1;
 Wed, 22 Jul 2026 13:58:18 +0300 (EEST)
Subject: [PATCH v2 0/5] watchdog: report effective timeout
Date: Wed, 22 Jul 2026 13:57:58 +0300
Message-Id: <20260722-rinta-watchdog-gettime-v2-0-39e249500543@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADaiYGoC/3WNyw6CMBBFf4XM2ppSCFBX/odhMZQBRkNr2ooaw
 r/LY+3yJPeeM0MgzxTgkszgaeLAzq6gTgmYAW1PgtuVQUlVyFyVwrONKN4YzdC6XvQUI48kCiR
 FEstCVxms56enjj+7+FYfHF7NnUzcbNti4BCd/+7lKd12R6RM5b/IlAopNOpKdY3OulxfrXswn
 o0boV6W5Qffz8wbzgAAAA==
X-Change-ID: 20260427-rinta-watchdog-gettime-6ae2e0a76983
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>, 
 Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784717898; l=4085;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=eJD4MoOFeH0lyEf8oV0BqWszhecDmDe7Km+Z3aGpqS8=;
 b=HaE/5Y5P6QFZSwy7JVCMgikKkvFNSwf4eQCrrT3pLVN8UO8IW/re65euLrMat74tsT9/Fm7Ul
 qOn4rI6RFFFCCY7416GuWjWWOQd/Dj6v0JdT8iEeMT753NXHd388W+X
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000090:EE_|VI0PR07MB10150:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d621954-760c-4939-19cf-08dee7e023b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|13003099007|56012099006|11063799006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: drxOL8aWU+2b45jx8CM2A3dmGZ4Vkw7NjUuZ8cGsydkxWtA+xOmmVCv8lUh9Q86EAQ2uTVph/D3LZCoIAQhMmP4mtplIKkK/xnvgvJA2wd54PafVbnn9DwhlE4Nd7HItIUIPdKKrWIclriR0u/BBnU9iReNFVwhuv1ZV+aUYmnYbKWgoIydtkBlnuxHLrRRB4pogSV7hH2f9F0ojE1n+nR/aEEdVTJuZNSwaI6VH7M/Hz0qzLK1vk+5TYLavcMggi1GeAQacpGgVIckN5UPO3+mNMLqQni5LPZKfMwgiMLI4PZHnjRFBXU+tw35DTjvx3MjX7GC3jSNK0z88fSkX7ENKZb3YgGmRCt4RjOmje3/F1EQpWOTAMj6FKbXBUAwPfcjkII0S2kSFCAzbP4vhkQyOMFjbNnT1WbvTyWDZDzAb4KuNroHL8btBUBDV5giXzuLwMhHDKoQgUN2MmGeRgaxTd0Me2LYrpNAafh2/xL4qR61J85mZzJ7aFMp8/6tDR1PkR6G9qZLN2AzpyM0NkCgfxdVdgOl7Xlx3DuXB9k9+knp9eF93ECUkLVVV948QqqvUlAwBUemaM1hguA0rwIXGgHSD80Ug6pkH7wJ12M9eqa+RJcwTrPfDTWvcLTdN74Rs4afI50GUsEJx66Z7K2m4ykX1u81arKKFmwSEc4s=
X-Forefront-Antispam-Report: CIP:131.228.2.84; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe01smtplvp01.emea.nsn-net.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(13003099007)(56012099006)(11063799006)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gi1oPjvNoHZMN3npEMlMnC4WyuCQrQ2dQslXGqg+otmIiVFWdgtSDYwZgYVOwdNB5M03zTunqUqXmJLA3H0+yAn9eCGp5t3kjaXOG7H8v5R0sm/r6YX0NNo+treRTWFvQimqDLhHMi4m/TZ4wgRW1k6CLLhSUhHaoyHfiTzCcOExRayZLWT85wcY9CXb8qUFHmnCtmhOUrP82mcbiSfP8vENz2yNRDx47LsEx9XjzjDJ4sonFKPAaXFubxf1xq52JF341KxAftop1wrlYYtJQTB31nuPap2a17zUNygRdtkUa9oNH3Y58Myv3TBHgFXY3jTiBDRT9f4/gplxbZmSeGKmJygoqB+V2FcatYTghBwEiU3xgMzoLgroj4wQIp+TuIe8x1vC2+xnrUJcxxx8VBMV5a1TCsuYH9eBpNk9VOEiv4KcpHcnqEkq4pPNYi+E
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 10:58:18.9802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d621954-760c-4939-19cf-08dee7e023b3
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.84];
 Helo=[fihe01smtplvp01.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS1EPF00000090.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB10150
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWXliaD3JI/i4nK4Tm8mrpZS1vZMNm5QSFfjyIKfXWc=;
 b=V2C8YpUsFPqH6RMd6iEBeDglAgdDnxDQPxsXA05ZaPcuH1FKZTmEkwAs4zwcR55xLyyqy8d6TkoFgZwMk84ONIRYYalWi/Sc8mB+voIp9IgJi/edq98wZzYStWs5vMxVvZ/10vev0IJVxQ5c4QXq5FjyBLzEFrMfdQ/p+Gm09fQFhPER3pF3bmEfT2ol1fWrCNMR0BhuhfYgDKUBJoma0Rvkg9xOI2oDnpwKuQloDCnqkKpfIeekgPHhp0sdBuieZP/8SUNR19qpCkDMZrx/HKdRfDgrV1LE+Q5Sw8r9hL+uMuYlC60xJYgD59MFUV9KYEeoIruo8b/wyzAbPLOpEg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=nokia.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=V2C8YpUs
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=nokia.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=juuso.rinta@nokia.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=nokia.com header.i=@nokia.com header.b="V2C8YpUs"; 
 dkim-atps=neutral
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
From: Juuso Rinta via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Juuso Rinta <juuso.rinta@nokia.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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

The hardware still performs the actual clamping; max_timeout_ms only
lets the uclass report the effective value in the start-path print.
The default value 0 is considered "limitless", i.e. on drivers that
do not set the value, the prints are unaffected by this series.

The series implements this support in sbsa_gwdt, octeontx_wdt and
sandbox_wdt drivers.

This fix improves the overall correctness of the console output and
can be helpful in debugging cases, since the console prints reflect the
real timeout on the device when the driver supports the feature.
If it is unsupported on the device, the print remains as it was before.

Patch summary:
- Patch 1: Add per_device_plat_auto to the wdt uclass and a max_timeout_ms
field in a new wdt_uc_plat struct. wdt_start() uses it to report the effective
(clamped) timeout when the originally requested value is greater than the reported
maximum value.
- Patch 2: Set max_timeout_ms in sbsa_gwdt_probe()
- Patch 3: Set max_timeout_ms in octeontx_wdt_probe()
- Patch 4: Set max_timeout_ms in sandbox_wdt_probe() and
add clamp to sandbox_wdt_start() so the path is testable.
- Patch 5: Add a DM test for clamped and unclamped cases.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
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
Juuso Rinta (5):
      watchdog: wdt-uclass: report effective timeout in start print
      watchdog: sbsa_gwdt: set max_timeout_ms in probe
      watchdog: octeontx_wdt: set max_timeout_ms in probe
      watchdog: sandbox_wdt: set max_timeout_ms in probe
      test: wdt: add a test for max_timeout_ms

 arch/sandbox/include/asm/state.h |  2 ++
 drivers/watchdog/octeontx_wdt.c  | 17 ++++++++++++++
 drivers/watchdog/sandbox_wdt.c   | 15 ++++++++++++
 drivers/watchdog/sbsa_gwdt.c     | 12 ++++++++++
 drivers/watchdog/wdt-uclass.c    | 34 ++++++++++++++++++++++++----
 include/wdt.h                    | 11 +++++++++
 test/dm/wdt.c                    | 49 ++++++++++++++++++++++++++++++++++++++--
 7 files changed, 133 insertions(+), 7 deletions(-)
---
base-commit: 1b8283bd3220e898d338fb98929f0b06ed63da84
change-id: 20260427-rinta-watchdog-gettime-6ae2e0a76983

Best regards,
--  
Juuso Rinta <juuso.rinta@nokia.com>


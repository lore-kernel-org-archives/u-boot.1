Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF721061B0A
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 15:33:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8272583F69;
	Mon, 30 Mar 2026 17:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="rKUjiG9E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0FF484010; Mon, 30 Mar 2026 16:33:42 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 085FA83D17
 for <u-boot+nodisclaimer@lists.denx.de>; Mon, 30 Mar 2026 16:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPFBSWBKxd1343aab6drG64uwReAJ/YSPkiSqjgiSfToLMk45xTXQpBfAlE07CF4Lvw4dh+5aCHbkOlTSMPQ+tATJGwxxbvTSiA5PmH+ExLhR72oaCjb+yWJGVHP6fdAJOIrTqybhw4VTrrTjeIi+3LuMaEytN9IPcajMFrZQueXf6WRyFVRZ3Edq/yOrEktgxAcys5jRsGDCMif1xz6G4yEl9lszkjkQsZGuHtnjOWuXjkgQc2yxKn8pYWRB4Z13r30OSCIWXfGiyvOmYR9OzwrFP9okUqCfH2lje5+nnvNyJY8dXssOSgeOMPxHLIPFyh5miaRMB5cBWimcPrJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJy2cn5RPVR96W4HKb2r6IC0Fx3+pPXhbHfqx3y+dOI=;
 b=ihBtFn5qqk2qNN60LvyvFIybTxekYnP8YYmUF2gFvEHi+Md43A5dRSGwkWknpx+8JcLafSwN3biyQGFqWe79DhNBYa8kZJZvYN1aOCHGpElReVBUvxOZD1ulgaYtL7xygBu3A5ja7SBic021uO0cduQk4+1aHV/esk12Ce5BsjAD8uJwE/sk2W3R4Orx+l9ZY2pGPN345zQOf8vYmLLto70f29lJEGHv0dTyG1Y90XtfaaUzwedkYvUqjKYli0H/nrUZVSH+N8FgZSSfLBeFtEz+23soq5xVaYxCAYvZhydXKEuWuhATrn13zyGEkvqlCNSBPNV2hiejLuiZTPnL2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJy2cn5RPVR96W4HKb2r6IC0Fx3+pPXhbHfqx3y+dOI=;
 b=rKUjiG9ENDf0xxyiH82QoAJ8ivlP1ENA8u5ayWU8jps5zSmJCNw+6WPMFjvN6g31DLvNHgLXwEmnEfkuNsZJRpgWo++2AB5jdPU41ldsXYVnoBtp82LTtP3h4NtzClxFaVt9j0ffPzVGCWMBtL1WN/82796p3492wYtSM+PFg4xmqHYtUDMRgnMKIzAnYSWsYLZeEhkJL2hWKLLV+oRiNJdYvXO5F8PQWVWVTH3EGUYqz7IW43s6ikhgK3v/XaSyZX8j83sgbvFb+Zb5Q5j5XrGIKqU0xb1bPfi0evsO8POK8oMMPZF7Ct7+gICv9115tBhgTcxhuMJ2nNhdW941TA==
Received: from MR1P264CA0096.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3f::10)
 by PA3PPF0CBB2C00E.FRAP264.PROD.OUTLOOK.COM (2603:10a6:108:1::60e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 14:33:37 +0000
Received: from MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f:cafe::d7) by MR1P264CA0096.outlook.office365.com
 (2603:10a6:501:3f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:33:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D57.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Mon, 30 Mar 2026 14:33:37 +0000
Received: from sah2lpt245.. (unknown [192.168.72.191])
 by proxy.softathome.com (Postfix) with ESMTPSA id 9A8251FF74;
 Mon, 30 Mar 2026 16:33:36 +0200 (CEST)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot+nodisclaimer@lists.denx.de
Cc: sjg+nodisclaimer@chromium.org, Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 0/1] u_boot_pylib: disable standalone module detection
Date: Mon, 30 Mar 2026 16:33:29 +0200
Message-ID: <20260330143330.1048622-1-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D57:EE_|PA3PPF0CBB2C00E:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: afc350c1-3bd0-47a1-ef95-08de8e695459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: dOItdlzje1Igluq8nDTw52hm/ohvu5OoqozMa6lqT+yuTF5SmBZnTuczN34DY8pscSnV9jfFpvLua0cvqeriwEAQukJzdNm11aE158NPdxS9BK5DKznU8m/HSjL4nSoUubRQEQ0u14iptzfIyM/whs0CoRtVc5YlNwqI1inMNOPMfubb03Pf1P+jBmI/63tA00jOpe2IgkF32j6Apqmt22wOqr9LaookUoIWr2K3afCEKZzWh9aa+N+lXxv+kJuhDGuPtT7hxDE/jbb9k8E1NX/UWH9q9bSgZaAqNY7McCfGkwdDh7hLw4vqspp+RMcvm8DMD2JVS4IExPLXz0gYHGhTSQfrqx3Gwi70j5F3ZRhYhiDST5Ty77lI9EVSkpCK3wgRc3uu7u9fs5HGzI0e4GmsZuKneOyV3sFRfEIelOnUewfcyyjIVqE1FK0+yiIrbxo5KHoGyZNixS1FRZqZw+QeSuy90eImcoE4QvWvqXsFVaKInRQof/CgUxRz7735Cdd78jcsIZHgXlwM4qGd2PiS0+XgFf+pxfFGwxANjn4HyTEwexccqBoJXFexE2aCRJQ5GgbKYYHnZtztEp8+5csGy4GcK/X5ebaPWVs8PPm1vQlDVDOW2VpHNc8V3nVOj5rVMQ4wulCSpPY0/9Pg7cCdpBCaZG8cz/8joQJJvIQDrbUoQJzB0x1811hc9YJia2w4zjDJ1Wg5J1HFdF+mM6poN0R8Z33MN4zNffFbQrc=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(13003099007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: psnSS4IyBAmPDHMEwbTQlqKeIv8eH975MU6M2UcofLRwrBcVPjt5bl4CBzG4BjGAYxT+j5XRRzwMPHLQGU8ZAqH4HhkdY/F0IWJXfoclPraXAYk0/19qgSUuccJuWQ1VG1+DJcTmrfirWrX8h+b68BPQPaI5JWa32ZKn0QFoFHwB6yRd5RONarMFcYvy18L8g6GpyCnCbSBqhD2+CJpIV5dDKLk+76BqnL9HitY/t3NCvM0DTx9bZMp/LjjVf1gO5rSNieExq3M5lPkOiLHpBp9poBaOCmWW/DdKDi7i5LQKXXRlMqe/wgP/d7kgLKuzVJajY1gIywRCfpCT+6Sd0Ss6AERPsObAmKcgCFFVlon0ZS5okNUnwd42/79U+C8VFHq9cQiwgn2NcAcskndSw7AmhpimYrnwKuOkfyuVNeSmsJSVou4Vfy7Rvi5Y/bMn
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:33:37.0407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afc350c1-3bd0-47a1-ef95-08de8e695459
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PPF0CBB2C00E
X-Mailman-Approved-At: Mon, 30 Mar 2026 17:33:14 +0200
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

Do not try to detect standalone python modules at the top level, so setuptools
stops searching for: command, terminal, ... as independent modules and instead
relies on package discovery.

Steps to reproduce the issue without the patch:

git clone https://source.denx.de/u-boot/u-boot.git
cd u-boot
python3 -m venv myenv
source myenv/bin/activate
pip3 install tools/u_boot_pylib/
...
error: Multiple top-level modules discovered in a flat-layout: ['command', 'terminal', 'test_util', 'tout', 'cros_subprocess', 'tools', 'gitutil'].

Paul HENRYS:
  tools: u_boot_pylib: disable standalone module detection

 tools/u_boot_pylib/pyproject.toml | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.43.0


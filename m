Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6C7CD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 08:20:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DFB08469D;
	Thu, 28 May 2026 10:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="UmobIegF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84B3B84862; Thu, 28 May 2026 10:19:28 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85999846AE
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijYpTvBcALR7iIP/wG7RawWSYLJlbls8MWhaWVm9WkvOyvQGXPg8Z/uP7J/nhnDWKCJAOwS2iJAZdM1yaKcpHc0v48ToksaV27BB7F+zRGrgTJTP2K6Zk3EnZ1vjOGL7TVCmBbuZ6FV0wEGW/J/pFxB0yLEetNV6ci/YWfz0yIf8GjsuVWuuF/BiO6b0n6T9HtTMVHy+ndZy5+kaAx8ikdrY1ZiOvvoejDAJyA/pPQd7yc2RwDetGstOoOZmtEf6dOXnmfYGKleqxxh2tfIlOEltJJE6Okj/5n49SUjv5oftlXdEJfP2SNmHEio+0qmKwL2VgfvP1ME9xZ7snm2O0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/ckDvEjxvsuhqHNy6mJ8pCHU8FMErE27VOMVM+3kB8=;
 b=bnUWfRadNwx6uJkAOLkaMRx6eqUjnC0PWt5acM4+xrKs1f9t7dVim6jVl7ltSXZK4XZcJ8ULBr5kSTAGRgShFP+T3L5HO6h8fIi0E9c4YxzwfUxcML5hCZ+5SvXkjQeUk+lh9/RRVshqqaus1P2uVfSvkKJY7HGAopmBiSuU2o+ojtwlamfsm6bOUSTmmL+i0NGOGORqbuZa8s0Qg2K7rSWCWJHQH11F8+aMdIHIvVn8FzQX0yDoAvPBXwFNUZrKpyoVpi9xAKAf0WIkMdmAg5EmuYUxH96BBwsHAPDuTo5IOPOEij2F0aapdSNRGN9NMYtVXethph+ymKgCCdYFVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/ckDvEjxvsuhqHNy6mJ8pCHU8FMErE27VOMVM+3kB8=;
 b=UmobIegFDDTmsX8BXaq23TGbj6vDcPfW2u21lnOOET05jcoq37IlFYgauhm3RRkZAbKhgUTZy9a8lYqCugAyqCVT/VOAHphUY4Jmok7CbDk0WM9rQMel8Ji+HlPaO62uBwR80YBCv4ERm7hKdgMXXFUw2EHQGaU70qbzBNc5G2rfwqL5w80HTe9L5s2deDYs7SbYst19ZkbeuujEbHfyIGrSKMrbLIMAfC74rTS3CDSrBx7POfSaihe2xUwD+9ktKzVMkpE0Vt6/wqWjpCUg7wpou2CkiCJZU19v5hViBuQY/Q6KQE2uySqudWifZx0NqhPZiHtq02vsRKPNc8JA2w==
Received: from PA7P264CA0107.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34c::14)
 by PAPP264MB7333.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:547::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 08:19:19 +0000
Received: from PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34c:cafe::1) by PA7P264CA0107.outlook.office365.com
 (2603:10a6:102:34c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 08:19:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B9.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 08:19:19 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 5123A20737;
 Thu, 28 May 2026 10:19:19 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 09/15] tools: fit_image_setup_sig: set required_keynode to
 -1
Date: Thu, 28 May 2026 10:19:10 +0200
Message-ID: <20260528081916.11355-10-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528081916.11355-1-philippe.reynes@softathome.com>
References: <20260528081916.11355-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B9:EE_|PAPP264MB7333:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: eae20c6d-13c9-42f8-0364-08debc91d0f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|22082099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: OOqtR4yrV1Bu8xTiimHiIZZ7TsUhNs/xcbVT3tpq6t7gCr21drCph+OGZ/f9FGWW6AaWY2bGHj2XTvmmqa9TM6DxHjN90/kOa3UViPQLzwtIQvAxcPuVUnCtL1+8MMRCQgrv4KVNUiStyRQHT/yLwagBZ24haDLvmQC4Npv06ME0rMVtf/XFro3cBuRj1p29PQvh56JMiiQ6jD5gK0AqLAQC23C6yXkPdKxwVfCZ0Y4ea20N4o2RytwOdHj6m9RghlIFik7ns2AQX4EWNjp1bu/Fz5KT1PblDWbsXu2z8Q8xTAtHhBYR2Kgh2AEaM7g6soBCi2Kb9EqHGdYAtNssFfUM2UmZkz7xbhjgCgyHntUjSEbveVNeIZ9vlchhWMhg6aRdl57C8S/BC/KnWIZ72Ohbv5Sy2y0VBj+TOb1wh+vFY7IrGFsjBzGHfhq9ndCH8Z+qrL6Vt282R+UK/4aSOUBVtfPpsXzEONvG71iux9M677gcqodjtjwut6dv1Qpe5mz3nLO7SzHSqw4zxv2Tto7L7NqxVh5j2EXtn01xjGhSfDH2kB9EvQB48Sii2e287NaP8IVHRwUxp9LcsrKzGKpyQnS0ieZALfpofrUusw+cBa3wTJ7rHfpbGN6g7nbrMvUjsCE5kFRRDsgF0SC3LQqvecB4YbexvWXkcofW2EcfKerjjxIKOSQ0MrSXP4bzW6hrM5rnQ3L7brjdYXZaVk9YlM17xweegBvgRPI4bW4=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(22082099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ao55lFi8rS+53OqQqHECLQK0WkQdkgVJleP75Tt7YDs/lu3PB1z56tKwfdk6F5hy7F28Js2t5Oeroc9pI9v1xRbOYsHrgx7JgqRTiemvIM4pPX8pdmNBE7RTVDM4JKcskWTq1DOVyvEOKUKGJNlFJdFtZaFXjV1JLbCc9xlncZ4/zA0snaAo1yhjeGGvf/4TrlR/qUZZWo4MIoeQaQ9IJA7SADER7YRJFbA8ABrhKfscmSz/Ij/z1rUb2XxI5oSfXit8lZ/jQ0GdV8fbqR4Pz7RJhzaKwhlzS9dIzkBWmOZLaLHsox3yi6322D3i7dch71hRaZCpnlFzRZLNE6hQlZ75qzIA41Mx7/gjXh6S0sMuc8eRbYw8Nw7i2wDYHZpwyL8K8U4h7psrYKJiZQkdFXCbbmn3Ddgf1YaDuYV9dnfodde/FzY487LelAueRXvn
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:19:19.4663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eae20c6d-13c9-42f8-0364-08debc91d0f5
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAPP264MB7333
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

When initializing info about a signature, set required_keynode
to -1 instead of 0, as 0 is a valid keynode offset.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v5:
- initial version
v6:
- no change
v7:
- change info->required_keynode > 0 to info->required_keynode >= 0
  in ecdsa_verify_hash

 lib/ecdsa/ecdsa-verify.c | 2 +-
 tools/image-host.c       | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
index e58b8892b98..22279a7cc84 100644
--- a/lib/ecdsa/ecdsa-verify.c
+++ b/lib/ecdsa/ecdsa-verify.c
@@ -111,7 +111,7 @@ static int ecdsa_verify_hash(struct udevice *dev,
 	if (!ops || !ops->verify)
 		return -ENODEV;
 
-	if (info->required_keynode > 0) {
+	if (info->required_keynode >= 0) {
 		ret = fdt_get_key(&key, info->fdt_blob, info->required_keynode);
 		if (ret < 0)
 			return ret;
diff --git a/tools/image-host.c b/tools/image-host.c
index 8b550af0dc1..f5681d6c1f9 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -198,6 +198,7 @@ static int fit_image_setup_sig(struct image_sign_info *info,
 	info->checksum = image_get_checksum_algo(algo_name);
 	info->crypto = image_get_crypto_algo(algo_name);
 	info->padding = image_get_padding_algo(padding_name);
+	info->required_keynode = -1;
 	info->require_keys = require_keys;
 	info->engine_id = engine_id;
 	if (!info->checksum || !info->crypto) {
-- 
2.43.0


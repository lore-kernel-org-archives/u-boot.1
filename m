Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26660F8DFE9
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 08:31:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80C6B841C2;
	Fri, 17 Apr 2026 10:31:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="vR8feRcj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C08384223; Fri, 17 Apr 2026 10:31:15 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F88283FC0
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 10:31:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yan.wang@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLjkNwDwjkhgiz/J0+Y/q0ogDUrVaydsoQaDn/34OiSqJljkP8htc5b/QEqoXJ4taQR7g6lpikCkhPClBFVE758GM/yBRYL+NWVE66kdaVQ1i5ILCA559Wt09PEknW4EgM/jBvJOXerlYACk2ka548zGOLO38ULwjn+Db2BiwSxCpydJ9kzIhmfAfvwVr5364bY29/X49doLA5PwmkgOnPcpV+/6k78ZfBqAQxqovClh9X4pjCjhE1P7sG2cwzIsEQWHHT9H4VGlXnbtigfSYbd1URt7vYYC3epvgB05yRMRw2YrEctSTLbxdawlgZFDhlIX9To3FYDFuxClh4YspQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsBqWcYXwKJx428prvnkstnUPax5GNu73qj7cHCwSus=;
 b=XVoklcScU3lWH9/LG81d/PFGmtc5fhRmADJEf/Y+pZg/epVfKrCvODOGfJvu5ZBQKxk4YqZx0bzDZRmydciYAfiI2flTyYol/IC4XwXIJeZv6JF0E2mO7hV6hZyGJhfFakrDJJa8IRNbXpyNKV62sFVt0PGymZcUlKL8AibNTJvw2oVIgjj98IHz1lTPnLHw1auAoAeLVU8oHE95iorRPwiy0E6JIcivcscgJ6uokOPmXOth5uAxd1cy0AprS3O/0W7LqIIWp6+KTfckGkQSlkWxIgMSfphAPdC8AyCb5Q1t7tYdi2I+rVzHt0duQePSLKRix1pGgIH5B/DaNRHYKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsBqWcYXwKJx428prvnkstnUPax5GNu73qj7cHCwSus=;
 b=vR8feRcjCmuzy7iRPxKVSjHptJ6YNyKdM2/dZb22jcypNVFlfwBbUXtjQCHbNRU99roGMfXX4JQjp0Kfb65CtHjuqDGuK+i2vP5G0e8GSwRU6tkvgsdci0Cn+giDrtziJT04a38FCDFg7uOEFuiCecX39gJyhMed8vaFUcmxfBgnQiKlcjm+Wi2FFvovsxiBSNPt3hFSDHc24MviNN6iFOf7SaeFrOux3LxuV0onRskkoFgYPZJ8LGv7wuq1it0MXGlldBQGP15shMF05/aJCg9dS/ZlOkUxzBQNGlVAnO3uhjy6MRgfJHypWbQouO1GBuNSMUjbXQMDJzW4hhpThg==
Received: from PA7P264CA0264.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:375::9)
 by PASP264MB5236.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:436::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 08:31:10 +0000
Received: from PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:375:cafe::d4) by PA7P264CA0264.outlook.office365.com
 (2603:10a6:102:375::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 08:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FB.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 17 Apr 2026 08:31:10 +0000
Received: from sah1lpt719.softathome.com (unknown [192.168.72.213])
 by proxy.softathome.com (Postfix) with ESMTPSA id 7DAF520934;
 Fri, 17 Apr 2026 10:31:10 +0200 (CEST)
From: Yan WANG <yan.wang@softathome.com>
To: trini@konsulko.com,
	sjg@chromium.org,
	alpernebiyasak@gmail.com
Cc: paul.henrys_ext@softathome.com, u-boot@lists.denx.de,
 Yan WANG <yan.wang@softathome.com>
Subject: [PATCH v7 0/3] binman: Fix preload signing with encrypted FIT
Date: Fri, 17 Apr 2026 10:30:47 +0200
Message-Id: <20260417083050.499955-1-yan.wang@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260414131558.538656-3-yan.wang@softathome.com>
References: <20260414131558.538656-3-yan.wang@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FB:EE_|PASP264MB5236:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 96d6f61a-8a8f-4f46-8f22-08de9c5badf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: O+d33PHNbH8oNC23IDNYb+xjtS9UZHGg0f9Q4z1JG0rMbLX7oLZ9J4naEkO1HfH+mvqT1OBGu/zjMg8+OamXdRAoznczO8krdQ8hY3NTmJt/HEVuQLApb09ExFbxAqIHulRYpir1sb6VKZBfWj+pTfqppTcFEciog64OotCOMOSZxkk/HW4wxJ5OrEl52er8e8YAevpRc4kL1bfHVoDLJvD1W3s92koeM4Wn269sivYMJdmJD9NjLv1hDoD9U0fxBGPN7+9YHrN/zPtXqXo/AkhCbulpo1bhJ6RxVFpEET0TkTakqxPwjCv0pvVG7lYFnXSvCgOs916jTPghMHD6m0BHzo5daczuxs3uTlWfUw8CBGvqGfzgHXSVHNw+Y/HLVmU4prZcHaPPs/gpyaIWgC3zG5zpdcmCJXZyv15svx6QgvRbMSPRQ2wzJKwvdKRM7YvgOy2/PBqOJKBRf4rgch0TmbpjTA6MkwHCr3hhNoBa2EjeYMq2gX4N1LMoNHipTWWWAaSJr0J+L7qt8m2ETAZu4XyJVwJz1VQPpXPqY4fMThDjsJ9Zm/29brbykFA3zMw29cf1KznG+6XdJqzGAfwq5zvMhYHqmnHtZCBY6FbKMVIKfrb0y57eV259pYmWSIi3bFmpPw7VvaQTnmKLQdrJP1C4xW936wV95e8y6F6zgGN78rwKUo69dVRV64thrPpJpPxs4Nsz/U8d1oIxllPo29VT20KiF0FV7NB007iwBJmHDv3OHTeJE+SBLK09oEjAp6DYXGEF9+gl3ynViw==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JUPUSmC+9jl5Vew2S0wB72tofn+SqC2loxxniUOaK2VlAFgrUgxlXd9WKUMSOtnTw262vCqC/stluAnuf0hp0VV5mRCQvFWqFc4l8oLh5O+s6lI04JsInj1rN8waoOxiLD8iSCFKqcuaMzmwpSPyYy+9C62BsQ294FDqcJ3ufbgau2yiVj/beDepVyZA8X0RDbhzKlWlB5wI9I5ANtFG0QJDzZxdovOXv5iCEXKU5jyZO8DooeNH/wKnsdMml1bf9wdGa+AWhH/23EZNCaOt5X87ZWvKO11GV1OCcZGcJylRozAzCWmb7wGhT9oEP+/+/5y0zW7l/7a0898lOd2Ce1+rYzvfkpcAU4Q5xI/bHrqAk0hbF4nODrAEtTAhgTWyBGW1lLMwKBbcNu8eaJYsp6E9jr5wDw7tK7/1+MThNHFfz1KA+vJXWyI70LTweu2C
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 08:31:10.6897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d6f61a-8a8f-4f46-8f22-08de9c5badf1
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5236
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

This series improves the reliability and efficiency of binman preload
header generation and test it against an encrypted FIT image signed with
a preload header.

When a preload header references other entries (e.g. an encrypted FIT)
through the collection etype, the referenced entries may be rebuilt
multiple times during binman processing. This becomes problematic when
the referenced entry produces non-deterministic output, such as FIT
encryption using random IVs or timestamps, since rebuilding the entry
changes the data.

This series ensures that referenced entries are built only once and that
preload signing is performed after all data is collected. It also avoids
unnecessary repacking or repeated signing operations by the preload.

The changes include:
  * generate preload header placeholders in ObtainContents() and sign
    data only once in ProcessContentsUpdate()
  * mark referenced entries as build_done in the collection etype to
    avoid rebuilding data
  * add a functional test for signing an encrypted FIT with a preload
    header

Changes in v7:
  - use mark_build_done() to recursively mark child entries

Paul HENRYS (2):
  binman: Generate preload header and sign data only once
  tools: binman: Test signing an encrypted FIT with a preload header

yan wang (1):
  binman: collection: Set build_done on referenced entries

 tools/binman/etype/collection.py              |  9 ++-
 tools/binman/etype/pre_load.py                |  9 +--
 tools/binman/etype/section.py                 |  5 +-
 tools/binman/ftest.py                         | 21 +++++++
 .../test/security/pre_load_fit_encrypted.dts  | 63 +++++++++++++++++++
 5 files changed, 97 insertions(+), 10 deletions(-)
 create mode 100644 tools/binman/test/security/pre_load_fit_encrypted.dts

-- 
2.25.1


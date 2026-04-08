Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34C010F994B
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 15:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0032884105;
	Wed,  8 Apr 2026 17:02:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="g2z4RHQQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1BEC838BB; Wed,  8 Apr 2026 17:02:18 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA5868404A
 for <u-boot+nodisclaimer@lists.denx.de>; Wed,  8 Apr 2026 17:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKaMpxKhPPk9+V1EHlfj5Yd0WipTqkSX6VgvGhk+l8CpvO8gOA0/c4cjFJiRThyDtsExLXNE+SdzFWZ5cI8l7m9nhUZwI9u2PlYbYOqZ5SkGdQBYVyfmzYkkEqtcWp3aEv1UmfzuI1dhfFljyW4UtAfEf/brej+1ftExRaCgncQ/v3+PooOBtfMd1J5khSXGYdi611CbrbZiIFAxCsTFFFoA91EIhQKEQfPpjEicav2edMhmghKv9cGuOA66ShJxDLgLX3E+5rBUHVtqA5MEYwfaGfBbkrhEBWwkuer+774eEh9i6zCzuF6AuX2rhLrQBh2Ox5f5jwFKHlBfC4oRGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lk3x76EIUr+rgwJp7DbqOoj3Hfiy7fHwPZxxwO78mmI=;
 b=I+qqNfgPOHXqk74E0ggZxFLgOiGpsiGfHwQjc+6WXV/iEXJs9vI0FZET4uyRq5yP2Ahu5arRA987jDx9pRfhHqMpexiJe9XdUZrwsBJZC2EDfDZCFyTspKQxmwHRAWVrlBjpKxcY4WGGRqAI7al6G/Mkn/jyJ33kG0OAlarLqw+pgaN0wv1R3ACK0OBFRKwcQC76Qen0zZKYibe2M1XU7ecjR2RfjCLrIYl6qs/oXDo7LnQf2bKwMimauOKm9DzY5NcNtDZEHzTEJGndJZK3mdmG8u5f0G1NC9Lr9vhGH0K8P5+k0iNRuwXVl3W9uDas9HQSeAlIbHUpjYZzojvGEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lk3x76EIUr+rgwJp7DbqOoj3Hfiy7fHwPZxxwO78mmI=;
 b=g2z4RHQQwSw7IZLFZAM0aWToZ3IMqfW+NV5ZGKhsJriuOhL8iZFIXpqvmSXdBbWl789m6SlBt4D0gT98fv3O9FuG85HcHZx28DZXJcFIB7b16W4RrpP9duN5fJW2XopT+PH6srToo5nd67e6FE14x1O9uqbZRmKh+yM5irx8tMrw0x1PQR2aI16xb1LFcmkESDfx0T5SK06vgLs++i+sq5rfTEp/Dl/Sx7Em4Q506B8LRccXkyMHvo40PCinAEpK38+XfNFaK2j9jsmY+rUtZdwCVSLODOIlJYJFXoaRDqfzb1C1riZHJDFRLRETYXj5IrXx56Bwie8TBr4jm41Deg==
Received: from PR3P191CA0018.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:54::23)
 by PASP264MB5267.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:43b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 15:02:13 +0000
Received: from PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:54:cafe::95) by PR3P191CA0018.outlook.office365.com
 (2603:10a6:102:54::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.35 via Frontend Transport; Wed,
 8 Apr 2026 15:02:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089BA.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Wed, 8 Apr 2026 15:02:13 +0000
Received: from sah2lpt245.. (unknown [192.168.72.183])
 by proxy.softathome.com (Postfix) with ESMTPSA id A3FFF20014;
 Wed,  8 Apr 2026 17:02:08 +0200 (CEST)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot+nodisclaimer@lists.denx.de
Cc: sjg+nodisclaimer@chromium.org, trini+nodisclaimer@konsulko.com,
 alpernebiyasak+nodisclaimer@gmail.com,
 philippe.reynes+nodisclaimer@softathome.com,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v5 0/3] binman: Fix preload signing with encrypted FIT
Date: Wed,  8 Apr 2026 17:01:58 +0200
Message-ID: <20260408150201.217942-1-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403075528.1150196-3-paul.henrys_ext@softathome.com>
References: <20260403075528.1150196-3-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BA:EE_|PASP264MB5267:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 74a8c5a9-a512-4de9-41b6-08de957fd15a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MEePNnnr6zWbEuv/97LgVuc1Uvg8//VqUF7+fmTj/vGfl/Ng/jQ17fZh6TcfPyZH+FOvP0/8myBB1xG+aVtDvpQhe3BYER5MiFv3qFan7+CeaR+8OwOw+FHuAMY+kFqARTyaN/YAq5EYF0SljOrVnNXQfr4MBT7ora0jhMaP07+H2pfqjDzd1fUkCmPKOzyjaQfhwPxreZPFUDe56Cy3e5eHRRVHXcms5xWBAiCll/Zv+UIO2iLks5e3tyC0FbwKEKwqwPHDgQBup0m/Uv4WR4BUnHCj9reAzf0AHZ+2QWqr5MM4mTfHyj60w+C3gJmw5OG+O7qI1KLUkTrVNoB3tLvaToIZRrAWM0TMvOqkkd27RKPwUmqaIo0esRSTAzmQcktzI0ndObXOzUuDqsUhQFzDv/OOxuPF9yYiPnm+SqCBarIz0EgqaoJAx+CRTMGkT1QMCseFAe5537xsUcVWL550AetGRHA0FwBoELxvWkgQrKQzN1vzX+ftTAQhS6GuizC9xQN61kfa/4PNj+tBPXuj71sJostjYF5nrJ6C15017EBB2qA03NLILWiai6S5rxyfjTFL7m8DRTNniohiJeVEK2sIYafNn0FchA5rRT62NSDEsYqV6nywgcxZ2CLGdejnlWgyowX/vn2ACzTQoM9KArvJ0isgAD1XBNeE57eUbtOErnfAws0KrueuImL6KcgosiJjIFVoDKgPtAhzSeclEWpZ1v24aO4PrYFYShgnTEjiWWdE1ZR4/Rm3CcrEX2jfRiHJE4vjNsqHZB8RbA==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DsLjJkvOOsdKGBHdIhkSIdAHOy9mBdAW3Zc93HUiB9rpIkvNwUFnkBxIYovXoINArYT6bequLrbV1kx9kLrLQJ90iwYhEdksNPJEmM+bT9/nUJ7F2mWNvOOMiMp0FkTMSZczxuHxO1y8gwojSa2fNW6yV1vbFn6XWWuVIiEP6lWtyf/Yt5+Y0QbHliK3TB1A47WiV4DMUMf5qn2SBKns2fre1D1EZ7rU+7kApmei0jNo1R1p80McEvAGGTGKXqggAeL76/xQuFGJcYdtSHQyUDmB/4xa8jJIAGXAQzZUq2bU2YWsLdyWrMubxS5Wcul154lduit+Jny29uOnk3lXACU6WIJax2GW2EWtJMgpJPBQEuKwQEteOHYPmQu3cHzW3dG5vnS7m20+DTtWM1y/uaClAUpKI9hk6tUO4Zp3H7D//01YzgQnfyeH/P+jpASi
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 15:02:13.6376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a8c5a9-a512-4de9-41b6-08de957fd15a
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5267
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

Changes in v5:
- Generate preload placeholder in ObtainContents() to avoid unnecessary
  repacking
- Move functional test patch to the end of the series

Paul HENRYS (2):
  binman: Generate preload header and sign data only once
  tools: binman: Test signing an encrypted FIT with a preload header

Yan Wang (1):
  binman: collection: Set build_done on referenced entries

 tools/binman/etype/collection.py              |  8 ++-
 tools/binman/etype/pre_load.py                |  9 +--
 tools/binman/etype/section.py                 |  5 +-
 tools/binman/ftest.py                         | 21 +++++++
 .../test/security/pre_load_fit_encrypted.dts  | 63 +++++++++++++++++++
 5 files changed, 96 insertions(+), 10 deletions(-)
 create mode 100644 tools/binman/test/security/pre_load_fit_encrypted.dts

-- 
2.43.0


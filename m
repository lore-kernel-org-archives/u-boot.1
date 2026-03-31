Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EFDFF60D9
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 08:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 650248408D;
	Tue, 31 Mar 2026 10:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="iZEHVdQb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9492884020; Tue, 31 Mar 2026 10:06:56 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A45584011
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 31 Mar 2026 10:06:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XW9jEwldsJ39+BSEsLAQXiy1W8g5rtfRWaVud6RdaV/wBDnQ/WmayEU5O/VypD/0teX8iCVo+pLz0HD4ojqCbSAQ7lBlTJRlfBB5ufw1haKHRjTkBboflQAwWY6izJXBHd39XC1Vt59v6H5nOSYnheWSXzLloirH7FJSsZxP5Lt4UkYjxEPf70YbaXlw9Zs6tvojcDuyir7mKYcSndKs7U7wr9P+65vcxBcJRxM1ZG3piiuhgqB3dsZha/1hIv6gnC6wqgusBNAMHYxR03xvPeROuZB1jp9Qjtr+tHx+Cm1N25G1fKaAGKTm+SqqFkHeMp3Rap6S9Gnw7tMET6bQww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqfoTbrOEFftoJY3Orc1dbWRv/k4XXsMUCzE8pCzOqM=;
 b=b5O0KkmMiOfZ/nOkW+Hgj+hThfbQ4jd+s0FD07q5xrwVJPipnL1SUOjsqvfeaNb3XAy+SA13NnPA/AtvwOr26u3aMYhR1SUDgXcJ23JKkYFbUFcvUgCy6/cR3RE9+v9DiHC4YLVRE8EXvIn5JsNCbf79Dspsuv2D2m5Ai/tvE32w8l7xGJIVI1CmthybIgnSGDkqIsBLorUxmTeugrR8i9tX7sZBfdaMHvygbUCrHMC663PPWCVfHOkTxvOjufsjSh4nTjSyXNmbQXTD3fnjdIGqu4HIrNzKx9cKwrjoHfclNqmtBIf+pVcyEE/hFvoha7YnPgQmfme55kcoPLuUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqfoTbrOEFftoJY3Orc1dbWRv/k4XXsMUCzE8pCzOqM=;
 b=iZEHVdQb2QK3JRk47GEif4whIJTfU0MzQHKJJ8daTrKfXXF89/p7WewmxvdZX3BiC8gIaSlr9NboXneaZH+CJbWr4ZmnWPqiGZIRCeDy1BzxolAndSOcassi335Uwr3OqDVYjhrTU+hzTvPRDk4YEk82WDTtHesD6u2efdM3zmzL4F//w28oIQ8NmPBWSCd3a7/LjS15xDwFl1zIGXGewHIzzRW2O1rnUmSzPaQgGG3//rZYdnn8VQ5vFfS+7KU2kFmC6cnN/bSOL6u5ry5Pyc3nXUNpuaIUFfDiqAU7AyUXsI0LYjvhFH9zFaozYVnFZf6ZstKszBKMYSLVTbvOrQ==
Received: from MR1P264CA0180.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:58::13)
 by PARP264MB5692.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:4c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 31 Mar
 2026 08:06:48 +0000
Received: from MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58:cafe::f6) by MR1P264CA0180.outlook.office365.com
 (2603:10a6:501:58::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 08:06:44 +0000
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
 via Frontend Transport; Tue, 31 Mar 2026 08:06:47 +0000
Received: from sah2lpt245.. (unknown [192.168.72.99])
 by proxy.softathome.com (Postfix) with ESMTPSA id 6A62A20389;
 Tue, 31 Mar 2026 10:06:47 +0200 (CEST)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot+nodisclaimer@lists.denx.de
Cc: sjg+nodisclaimer@chromium.org, Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v2 1/1] tools: u_boot_pylib: ensure all Python modules are
 installed
Date: Tue, 31 Mar 2026 10:06:36 +0200
Message-ID: <20260331080636.380507-2-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331080636.380507-1-paul.henrys_ext@softathome.com>
References: <20260331080636.380507-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D57:EE_|PARP264MB5692:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 80c4ee45-cab7-4db6-da74-08de8efc74f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|13003099007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: IggeEayy2N2AWmD+qv3xmtj1Rxqlc4uCFO+9t17cYhW8+liClxKHaBU68PrF0XX8Z8ffccBemZOrGsyjSw7yo4htn+b0+Ks9O/KnVy7RiSxCLLaZEmv5FoyX2yocvIIG1u6zE5dOvWgQY65iYK94e30UbY5kPQBE3k+tg8uk6xPzYofyFCOfx6A1EKepqZjTNwbNYh3jvt2ti4p8ORq+cpEzS6GK1nJXt+EvrxDry6BI6DiSGIEakycMGjlivB/O8LLjlMX8DtYeWGCWNQS91A2TjgYRpzJv/3DRodbfI0g0uJ1br6ncaSzxh7tqwaTG+JWRiQKxmj5N0EnnCx23RjpckcYVmLMFf9tvTRmTqRk5zn46JaNG6/DTJ54b5lfs8Mo7oAgRS4nmG892aLzTLLAvw7vWpZISMO7GpJahuDxXdgOjWwx9mva/1ZIibc6WjtbwAOWRKQpj8TKFwNM/MlUjJEN/BNuHU1CAbEbxUEFgvO5pOvG5u0ooTYLrk4iaLh812bFWCmHj3yEhlT1C4r5uRAgPwIR6HvEKh/8q3HgcwovXegjY9NDYuuP0KNMCF5GOXHAaWHjHBpDOlGJyYiFitKAR0v8Faw2SodLnfpbcqmBUh18PvBgCkNzImWYUk/ODleXIJx3vTvz68gvpXTP6Fo5uyRYx4UR4h9l3qpUM1Iac7/f3Xg4G4XWla4zOPiGXHw8zkCBI8rcSsFxaSg==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(13003099007)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8368Lq72RtKKD+dO4rKWb8/iBXywl55PJU1UteZfZRYoJN4O51DVhucqoIKwJH56jWhnEN+5sQKw23dMhqtqwdyqzAZAKgjSxz46zQzuwwSgntMFkQaAEkp+zzNfW0QgbZzws5n8s8xSoOYxgs78AcKM2F9AUs2L3hjwasohG9YJwSmJLy4/L055tz06ckVjkEt4R80OIqUAhVVwc8YF50E8B6RS+cQgt/Phd06Q153O0N88e5AB1hgOInANGmciad7FEeQE8pxF6iJuXHxUPISOKvkcKZ4ozVxdVRCDMN+AMvQL09iGb2UB1nftfoXzF3jeJxz0Aj7ugGpCcbteTMjq+q/fdxNStjHyjSyN7I3vvUQ5Kd4/8lw/Mx2nKmHEiSsogIehFAAbs9XJHT60ehsuAlSdGXkBebXGcfF+qBIFdlGQWaCQ9MkJlKzF0lOL
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 08:06:47.7975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c4ee45-cab7-4db6-da74-08de8efc74f9
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB5692
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

Add setuptools package configuration to pyproject.toml so that
u_boot_pylib is installed as a proper Python package without changing
the existing flat directory structure and making sure all modules are
installed.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
 tools/u_boot_pylib/pyproject.toml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/u_boot_pylib/pyproject.toml b/tools/u_boot_pylib/pyproject.toml
index a860d134551..ed04d956b4e 100644
--- a/tools/u_boot_pylib/pyproject.toml
+++ b/tools/u_boot_pylib/pyproject.toml
@@ -21,5 +21,11 @@ classifiers = [
 "Homepage" = "https://docs.u-boot.org"
 "Bug Tracker" = "https://source.denx.de/groups/u-boot/-/issues"
 
+[tool.setuptools]
+packages = ["u_boot_pylib"]
+
+[tool.setuptools.package-dir]
+u_boot_pylib = ""
+
 [tool.setuptools.package-data]
 u_boot_pylib = ["*.rst"]
-- 
2.43.0


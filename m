Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BE31061B0F
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 15:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B94A84020;
	Mon, 30 Mar 2026 17:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="LfE/WLej";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A11C83D17; Mon, 30 Mar 2026 16:33:43 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2BDE83F69
 for <u-boot+nodisclaimer@lists.denx.de>; Mon, 30 Mar 2026 16:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEEbB8Qjq464DDWGw7796VIlilnpSS4o5miv7eXzc/Q8B0nCJ037TO2ygQhKm/DPxAhABlpd/m6nNR/pLsOQXanUdkHU6+kvcS4x929xdSTJ4fUiMTBuCiEZ1Rkp7fvm7/KLGRjeYzHGxuMDp84V+brQyZnn8yv0uDjRK4i8WIp+SgAQI8+UB5PNsK7/1t7LhNDwgPej9dHgC8kl23xCjWPHe6x6r0ZWMGOTpBs73Jo7/sGDPntPsDORvI2JMdbt8jgjNblfDdeClN/ialgzTsc68EGdorgngulR8SpOHaGjuAfp1iCd0w4bxU3ZAhAcLJJIzzOq8hQjEeyay0lnlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSOGyYgEs1nNRZcwTAwLr50Tk7Te2DezYeXotUqtXvk=;
 b=EZqm82QLRHer2fFSYT662rCZgqg+LQAoXIsUYuRmqXlFB0l3o/XxeZtxtBWxbSNFnRzpBRnZdu+ZhFgd4m5f5AY/tgZ0/8gR1rpztb1agi25e6TV2xidNb5yUBuajWdZNx1IBrvVrfoR2c6UjTnnaGZGH3iyHZO0BtLOfr5qSQt416JwdgnLoNhzhZ9vnWjGOh4vRzsATkIWjaXS15RRIfe1MAJRwtwo6zFcqhrTf3xGE59QcaizeDvMeNq8NJ2oQwrOeQvkqQdqna7tpf+kqs7OJqSFNuxBy2x7YZKgl3HP0zTzd4mP0Qe9AKNCQhnM6i0SEBxjR8y8IZGfVqvraA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSOGyYgEs1nNRZcwTAwLr50Tk7Te2DezYeXotUqtXvk=;
 b=LfE/WLejdr4cgjmMZeivegb1AP3Ak4aJff+ANJlwbijCn5IbNJkVRKhnxvx6Zon3HxWgE7HI4WjxRmcRHUe8dT7hSRKrc+aWetCTUle03i2NHF+zzEEbRw9lt8+RlwQbZP6O9GstCy0Esk1paz6YH8iAwdVjKlinJJ8RFz8ctMK+K/fXRaKgW12RC27c/BU0vgTLPAmbfMpZTl7QyZZMeZ7g+e0SpR0h3EqjAnYMh6fHrEsozu7lxuvyLb0Xv0F0MDflLVJ18EXJDO3GZ0nKtQxUKIbZY6EqvVb4Ov4rVgQzjzA5BCsd8kQQLttdgxA+voaHlY+GMfi5x3yKNc0zMA==
Received: from PR1P264CA0098.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cf::7)
 by MR0P264MB5161.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 14:33:37 +0000
Received: from PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cf:cafe::c3) by PR1P264CA0098.outlook.office365.com
 (2603:10a6:102:2cf::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:33:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089BB.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Mon, 30 Mar 2026 14:33:37 +0000
Received: from sah2lpt245.. (unknown [192.168.72.191])
 by proxy.softathome.com (Postfix) with ESMTPSA id E89CD200C2;
 Mon, 30 Mar 2026 16:33:36 +0200 (CEST)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot+nodisclaimer@lists.denx.de
Cc: sjg+nodisclaimer@chromium.org, Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 1/1] tools: u_boot_pylib: disable standalone module detection
Date: Mon, 30 Mar 2026 16:33:30 +0200
Message-ID: <20260330143330.1048622-2-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330143330.1048622-1-paul.henrys_ext@softathome.com>
References: <20260330143330.1048622-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BB:EE_|MR0P264MB5161:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bc766311-e2e1-4a86-e497-08de8e695475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: HKegV/Mph2J7VDGiMemrltNEwh6+z8OHas+NC848cRXjP2neXdJGev+5pOCkMs2O4UQXYx5O5DlMpib1/+kf4YH8rUmvLeFvqpCPGzabOEijZGsgZ8Daswo/MpoOef2EBHwd2FOKO6fif9NLLIPTMnbDzEB/5oGJ8wagEghPm8mptb5eM+dapEQQCjzsR7oZNY7F0mFrIB6btjYE1OS9N8j+SdccHSOBEI35svMOKdHFEKx4XVgAhLiKZAggvwKPCvg90/JrQN8UULTWV9bL9PZB/dCZyZLqESDzZQV2Sst5O/uC2KMw973WbtO3by7Zb1TcIpu/RWQ93c1M0UHbvIdsxf8abbcuXdLwyWF+VUgGDrcy5TK5hqXYwygX3XDqxQ1+hSd1nVxlX66eAzi07DLGFDSXZ35mxaF4Hzvd638lvPQoW+mV1xU7fiYBLhstpGbQgs5iYHg+X+7gOnCiYajTnwabxHST7CeeHY1XSN7ZDajY5DLxPO554scWV0t2zzizdt1iMXF7a0e/QXj+oPPAznoH/rifFbiTqJ4RkZDrrJiptGXNODRmBkpziiM+/gy48L0NSyXA3FlG2cdYy0zC0iDYK0G7+ElVtmyxv28WYhYLwGyoQFYd/84j6gXo2kqHHnjhNgGD6UnBiDlBOu87vVwpni8UB+LUbAZgxeQUjzcD7GrgMb2CEEP/yXFGfM1c9bCj/SlI/p9GhwSAoA==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: za+J4lprKm4cvEVsLFOH4dEt1rnlUlEmP8qbAZF4z2sacfUC4CXTEa5FuQaPUw9QYw75DqQINd1d4qJ4+BJHtr+6eNbcjDi9IV0XVnbKwm3p2+gH2GLpGrz1mZgdxp9FiXG/ZYu1t/Ccs/xw7lGJRs5wACvbN2Kz3O8b638/S0hZXe6ufIVjnxf2ZhPh4JUs3sWiRm9G+hRhyf3lMnKJYpSyNY96eix0u8l8wbf6dVBpigkFUmi/fDPtZFm/StgNaiJXXxazMA1t0YQzCHYjfYAHtOKiIPesD7skE4zY5pQNe/xsMYHa+5cBQGltti9W4LbA406D63zhcx3dixA1jx9ECkrRMaHb1bryqrIEgLBnZTPTYt9R0rCm7QuRRddi+f4KRMvpGxhoSsBcAkUEyW8BASd+F8AYb5xfY9bRTl79Hu7aZ+5B3vEfdxz+Fw8t
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:33:37.2429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc766311-e2e1-4a86-e497-08de8e695475
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB5161
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

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
 tools/u_boot_pylib/pyproject.toml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/u_boot_pylib/pyproject.toml b/tools/u_boot_pylib/pyproject.toml
index a860d134551..22b364583a0 100644
--- a/tools/u_boot_pylib/pyproject.toml
+++ b/tools/u_boot_pylib/pyproject.toml
@@ -21,5 +21,8 @@ classifiers = [
 "Homepage" = "https://docs.u-boot.org"
 "Bug Tracker" = "https://source.denx.de/groups/u-boot/-/issues"
 
+[tool.setuptools]
+py-modules = []
+
 [tool.setuptools.package-data]
 u_boot_pylib = ["*.rst"]
-- 
2.43.0


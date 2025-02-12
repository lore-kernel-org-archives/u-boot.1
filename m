Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AA6C02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 09:31:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B090580C98;
	Wed, 12 Feb 2025 10:31:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="oHnFcOFG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC5DC807C0; Wed, 12 Feb 2025 10:31:37 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB3F080842
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 10:31:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lcj9ZFkhs3P78bhx89eqCKuaopJsOIzFHDvluoAJnDdElpJ+p6tlpRdgbDWknclDRMqwYPdnBpxB/16vkM9r4LRRZZDKr2D3BUW/V65wGEWmcIDQwMY5Aha9gIf826wDVzEuFmh1LMAG37tJzvaPjkl9svKMcSndfejr5wovAAPQSuP7ZW4S5ywQP1684Tu6s+xJojCHxPYZfAOM8kO/2fmY+5E1cqMZQwHPP1UyDsjH8f99xqV4hvERL0Nvtt0e05Ad0zsnRctjBMZp4G4WyXVS8eLNKxhgMmC5Ol2mnmPds0gX63UYOl2/I80tuoZE74lnrXW/NMSTKwa4ovzVUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aChP0gOubdt3woYUIVcBkx6hWgX7+EKmf6e7cpUzcBo=;
 b=lj8tRZZZELPOl7dBPNCqKaueleEPfquIVfLY3IazKdIZ5yHOT0svH6GLaRi6tJ9vFUlzn4ra4tuk2dzNvdc/hr5riNWFtxH+8wznSAaJKGDIpQq5D/X7ueoDvLkX4EZAPlv7fwUkpkLLeLSWZW3g8DWQlHPvQd87w4Yqxo0FSJ4LmEowoY0G4hBJaRVPMhOnzWwv9+aGxBCgBZC0fLVoMa8NavCrWhUcI84tThqcA7cPBHgFgJOSNPzdeUUbaQnOjh7rrBo0R2VOknN/l0UnECt8qnR822FYjjXAdn8a0Cyvx10IlfM7xXrNmY71vxTt/a4NWmJeqLeAPQc4BDTSUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aChP0gOubdt3woYUIVcBkx6hWgX7+EKmf6e7cpUzcBo=;
 b=oHnFcOFGTt5D/40z2M3tME3OT4aKRTg5LleQaksKwxJBcc9l6xC9Is95Qsq9qj1gPqOyzENgHfuHBvM6GMJ3ObNwNppylI4bu70T2H2M/ZTIXqTOZIK6hiqo6T9g4dTUc60uKAiL664ZAT9fPEEkiQfQDUxBzF+5hFHtVlwV7gq8Ag9Dcj2Us3YAgbSgzuhCF6PI/KB43Gjh149dyf4QXaCkxy4vmsgA4M32i15DXsbMu26pV6SEauZ+2stPXHwN3pPZEmpE4GKIYTcpPAE50ZPgV3iPxgS1mwasFHjWh3BdtZOBafja4qdAEYygLqqkd5/h3atY8Aih5awTS+YvHg==
Received: from PR1P264CA0014.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19e::19)
 by PARP264MB5549.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3ec::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 09:31:34 +0000
Received: from PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e:cafe::8a) by PR1P264CA0014.outlook.office365.com
 (2603:10a6:102:19e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 09:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019230.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.10
 via Frontend Transport; Wed, 12 Feb 2025 09:31:34 +0000
Received: from sah2lpt245.. (unknown [192.168.72.253])
 by proxy.softathome.com (Postfix) with ESMTPSA id 6C4ED200E9;
 Wed, 12 Feb 2025 10:31:34 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: paul.henrysd+nodisclaimer@gmail.com, sjg@chromium.org,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 5/6] configs: Enable the pre-load signature in
 tools-only_defconfig
Date: Wed, 12 Feb 2025 10:31:25 +0100
Message-ID: <20250212093126.3722186-6-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212093126.3722186-1-paul.henrys_ext@softathome.com>
References: <20250212093126.3722186-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019230:EE_|PARP264MB5549:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e68a0901-393d-43ad-f11a-08dd4b480ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FEw5zUZxPDJAejng+HmYxhcBDlFpcw5NFlAvVkE8bvtf2WIluKZzeofL+8wb?=
 =?us-ascii?Q?cb6o5cZaVBp7lVXuYo2nAzritPK4GrlwXa2Za5644RerAJuhbFhJLh6FsF/S?=
 =?us-ascii?Q?xPT/oTuFdzT8Zzoz1Si7pLdE5H7O0B4vmMfLeC/SXzzv3UCERlxCETRuISwT?=
 =?us-ascii?Q?Q2Z/JsePGIqwSlNjUIP444LzDyOmtYhH520Z0YI66ulsxKWmRJHTtrYDHSLY?=
 =?us-ascii?Q?OBLtBHGBZAdzXfjsfj+IupTHpaTGEdWm0pa9+Tq19kbVJpy8HuPew4mk/4xz?=
 =?us-ascii?Q?HqEFQEcY/x0OV8STkyl92l6WE8DPwq+AbdHyOv21+AmSX8aYr3LB9z6mPlHD?=
 =?us-ascii?Q?0+T7AtKw/3jJlZdzVPsRne/dFnIuvyNhneU3rZw0KJ94CpiBxlAyfjCLKAOf?=
 =?us-ascii?Q?f/HfynyVL8FKdYaCBHxwUx2otAfH/b6ytztHuPguNBu+dcmuVUIG6YQ3EGzy?=
 =?us-ascii?Q?lIGGfwd8kwpCjvymTGsIK7CZPH956mljIKcImTC0I+B7D8f0dGh0I+GYpdrN?=
 =?us-ascii?Q?ZnJlMbAmz96+FC9720qtx1OK2H2HJ94p2KrsivvmNvx/vFayZynGAWddIIq1?=
 =?us-ascii?Q?Krc8vuUxxKDIv0PxD8uFH1wkXQjm9xDuSfJQZNcVYbg2L+LVAgNDI7SjxBqB?=
 =?us-ascii?Q?52sYEofJxGmenwv7c90ILbNqk0xwTJ+uSyejjZ9GVb2HCjlHHlhGCzfnNReJ?=
 =?us-ascii?Q?hv51Riwz8642+e+VV7pLlW+MyahAO271az/UO91lDH6q/ZsdVgLbx+8hSX4L?=
 =?us-ascii?Q?K6FGqdIpQZzYGqhkCGEMiaZGDZd3qe050A7neZmfGjjj8T2oQVVgAOA4TKrM?=
 =?us-ascii?Q?hoz2yekO/59lqbyoP/I1fLGu8ieXLDGLX7kkF0LPmX6JAwN0LftxY6QCYnLj?=
 =?us-ascii?Q?Y2lywsFZitVVV86nZHa6LKwqnai8zmLwPa0gLbzWyul7eaFAoyCANZ5i1Bs3?=
 =?us-ascii?Q?eqB79WhJX8HCaRPUeZytuFEIlPOs4JaG/HjW5Rb9Gjk7skMvXPzK6lqG7ET9?=
 =?us-ascii?Q?oHW48pQ5jSTgSMO1BOJvduPwkPCrvjzdygN6F5HPmJzI01SCRwQQe571GMgs?=
 =?us-ascii?Q?TUzdNcw0kbE0zwFWkDXPsQw39pyIBjJpuCQh3P6nsJMiRZzdCp43hRmnLIsl?=
 =?us-ascii?Q?LnWtK3GDWUK3t0/0H0kDU09YKjZubJTfQ1ElNQq++dPwwrQNXUsqRPz/kIYX?=
 =?us-ascii?Q?2joxLrMfJaz5DZyTIf6a/ruX3b/OT1zdFAlLU6sHWUfw6wZvfPSu4PxP+Okc?=
 =?us-ascii?Q?UjQNA4KghitE6XWyGr533rH04gssZe09xqq+Vqm6xQpT8jj86pFxl7zNSB7b?=
 =?us-ascii?Q?GgIRQ2suSCwKHQ+NkNIjMTqQG3hk4wawErzZ6zQQyxlp4meSCMtWh5EqkLiu?=
 =?us-ascii?Q?Xou4QDjc4kOehjtlNJpX3kQ5Qh6VtAPL9RfLUiX3Y42lzv+FL7+hF+bVAWav?=
 =?us-ascii?Q?MGlkWsSR8Cqf+kApczFptrwvH4wZe9iSG4IRO4YO6fu294S/1lNvd3tymtV0?=
 =?us-ascii?Q?w82DS81zWxDx0ew=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 09:31:34.7465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e68a0901-393d-43ad-f11a-08dd4b480ad4
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB5549
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

pre-load related config options are enabled to have support of it in host
tools.

'CONFIG_FIT_SIGNATURE=y' is being automatically removed since it is
selected by CONFIG_IMAGE_PRE_LOAD_SIG.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
 configs/tools-only_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/tools-only_defconfig b/configs/tools-only_defconfig
index cecd26175d1..e64bb768440 100644
--- a/configs/tools-only_defconfig
+++ b/configs/tools-only_defconfig
@@ -9,10 +9,11 @@ CONFIG_EFI_LOADER=n
 CONFIG_ANDROID_BOOT_IMAGE=y
 CONFIG_TIMESTAMP=y
 CONFIG_FIT=y
-CONFIG_FIT_SIGNATURE=y
 CONFIG_BOOTSTD_FULL=n
 CONFIG_BOOTMETH_CROS=n
 CONFIG_BOOTMETH_VBE=n
+CONFIG_IMAGE_PRE_LOAD=y
+CONFIG_IMAGE_PRE_LOAD_SIG=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run distro_bootcmd"
 CONFIG_CMD_BOOTD=n
-- 
2.43.0


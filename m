Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9E3C02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 09:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64CC480842;
	Wed, 12 Feb 2025 10:31:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="MShwu9qI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13FFA80C96; Wed, 12 Feb 2025 10:31:37 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 052DD807C0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 10:31:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHldRNjTl+vRiftWycC97a4+gpEhewPl6iB7L3XizRLgwOaAjCe1m1l1lITj5EFt7GzmzpKEO8CtcG2V/TLjnnT/LQCfGAxNw7ILkbloMDYZlAWzv9VWI+P+coqqQj6ut5o025mskx56Nu0BswL+8HmtprNB5hpkdZeD9vyvxQjiqpyfvmKCL1jTAk/I4OnBtwsNs0ohbp1D8eb6QxA63GfN5uzM6a6nQKFF1oCb69cmw3LHkjWWUswgqdiTB8kEtm81254PCDQXDUbbP3Znpz4AgVUAr5AKoLOpKX2QAEyjavMGBgKYzHNkXUsEqdpw4+aufD1yH73usPU3iGFLdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u06T/Bx3Ve20Vgvb3K/XBfeYd6fpaBYpKpTG5Hhu8Ho=;
 b=wl1TQcjMNPqoto9ajrWulJqef7U4lmG261zeTMEuV7TljOCWLGoA4U7Qf2viQbGlcDWG8Z/QfQva4IeeF0DK0yarBed9oJtxIMeiVurh+HGU7t95RY5rHc7zc5M7hK22LjwMV523AoUDlLBvvuByMu9THaidvrEUP2oEGXadlFi70uuP1jKDcpKGYHJZFjjg/m5sS7aSMaORM5rf2ZNdtSXwhTWiL3r8mMsb7b169xP4MsXsFtRTY99TyVAzyjPP015ULM9omxdHh7cyMDHwHt9sos3Cmkr2syYI0o9W0xc3yEJYfFIB2gm9z2pyUcRLtxPtsrqPkRNksoPOoDl7yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u06T/Bx3Ve20Vgvb3K/XBfeYd6fpaBYpKpTG5Hhu8Ho=;
 b=MShwu9qIG2Ge7E55UvMRxE9m148Ar7UET2IZpWyZW6cUC91tIW5luv6VwFLoyAjBnGhR1K8apCOb11ZGkcX36Zcievq32RT0uc21/44JDVm1o6gijXzS/ly/k7oXe2GI7oGf6zf+cPnUg1EcQwGhE7QazGZaQjoC6igiaETjoP4sHda9TSNq2qcJ0hv+GU8te8VcD2xkw9/HMn1iQSr6Ram0AX6Zu14Ptd9k3Oib6gs9S9lMXIBr/c3XJeoMPa2OhOkiRhFWmPAfddgeZiMkd3NbAJzXm0jBRKdsRnEKzEgJfvaDOcx+yrGlDdDXJ7vtxU7Voqk5iLIj9SDVb3S5SA==
Received: from PR1P264CA0101.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cf::9)
 by PATP264MB5436.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3f8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 09:31:33 +0000
Received: from PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cf:cafe::5b) by PR1P264CA0101.outlook.office365.com
 (2603:10a6:102:2cf::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 09:31:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3F9.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.10
 via Frontend Transport; Wed, 12 Feb 2025 09:31:33 +0000
Received: from sah2lpt245.. (unknown [192.168.72.253])
 by proxy.softathome.com (Postfix) with ESMTPSA id 52F4A200E9;
 Wed, 12 Feb 2025 10:31:33 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: paul.henrysd+nodisclaimer@gmail.com, sjg@chromium.org,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 2/6] image: Add an inline declaration of unmap_sysmem()
Date: Wed, 12 Feb 2025 10:31:22 +0100
Message-ID: <20250212093126.3722186-3-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212093126.3722186-1-paul.henrys_ext@softathome.com>
References: <20250212093126.3722186-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3F9:EE_|PATP264MB5436:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4e694e0f-cc48-47aa-85ba-08dd4b480a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rTyYdsH5ZD83fqF5YtzVx9w7rutMHPPKvmSAImFkVXWPZskL5/dARLdEcy9U?=
 =?us-ascii?Q?zazY6TymeuRlpFhqQzeazBMmxNetdltRZOt4phUQeMNHmYNYZZdNEPVWveHT?=
 =?us-ascii?Q?jq+c9uKHSQqzP86J83TIRe1yH1tUVx6dbNUK2ilVSO6SIdGhIt/GITuJZ0Us?=
 =?us-ascii?Q?WAF3yi5J2d8tGa190x85zaSKGDm0YVxPVG4iLD9+XLXK7mQ9MzQmiyxf04Lp?=
 =?us-ascii?Q?MrTKFf1aepGd1ZPG5baYgbA6el0B7CDt3BE/P5s0YJ8ZKjo0rCzYsUjJ2TP2?=
 =?us-ascii?Q?3xrzVJJ/8sGtVXtj2rViujlHeLYm2ybNuDcwekJFIgmAQ//pFgo2soqVw/bx?=
 =?us-ascii?Q?MD+6Q3GdB+yUl3C0juGdO6VAJlCXNfYuqnC6RRUK2iB96Fbp5MhQ9riZlBlD?=
 =?us-ascii?Q?FXeZJu/fb9IFVfCkL+FN30gFCCuWHL8XqXs0opUgp6NfCBHZbLQcFOs1tWlm?=
 =?us-ascii?Q?wjH1hpIH9xLlWvjDapvC13td16Ql/LR50cBXl5jQR2TEkTkSoDypcsOh7xoU?=
 =?us-ascii?Q?gbiV8IOdLlN5ddZR6a5TG/tO/hH2LVLNpJ7W3kz5r2ACQtIYslzRNaYzhMjS?=
 =?us-ascii?Q?+oQx0/US/aKNiwbZBSUqt9a2PCd54jIG2O5D+rCktmfZdmCt+//Xxa0WpQMI?=
 =?us-ascii?Q?5Qf3f/As39HF8gdvtKSf+z9UTSuI0gcsJO6Csevq4XEepc2OCrp8GC3MiO6Y?=
 =?us-ascii?Q?QXWUzCa1op8wvZ0UpQeI/9B9Ne7DEcu0+orJb9EFJhHRobHUKUcyLb3tLI7s?=
 =?us-ascii?Q?m0zmXDp4YSiJO7RhmXJlvs/JiUdNLP3rjPqBsc6BR2m5Hq3iAKEJc53y9d0h?=
 =?us-ascii?Q?E2DYnZgj3yMA1SVfMtcYr49jMR/GnMV0DalZsWwILtlfXw8cOJ2NUmGAEHj0?=
 =?us-ascii?Q?VBtOJrBRtKqMOIyWqZk53Bn+gZaQqzbLfeczPa2FO7VocH1bqCQsvuMlcWIM?=
 =?us-ascii?Q?OcoMa1PQLtquPAlO67WcK6D2/tapV1oqQ5iJn3sezTQLJeGXwah/P9dCbADL?=
 =?us-ascii?Q?91rPfhOYiqZkULemHWWRk9t0OOoYmv8OFskrPz9V5RfxEsrtR2lXcWfBjj2u?=
 =?us-ascii?Q?u8hqf+eNLVbMc0JdtkHBg8FxNT5tT32u4c1PK3vIsoDBxcPJiwnUxlaxpOum?=
 =?us-ascii?Q?pzpR0K+9mOuTu2YwZhMEbJLd03ZHEJgZejmDnAUKJONQq7Yf+lWveQ0aKnVs?=
 =?us-ascii?Q?kGP8ar+T5y5onYX2XnX7l9xc+zxR6efYgoyXeMwCWYPfWsnwcPDw1gMvGjUG?=
 =?us-ascii?Q?ApwJD4tq4TBG8D+BxtbPy8DSd5bzg4hdAtPr6huHrXAquDstx9Z2j8As68vh?=
 =?us-ascii?Q?VLfJBCnLSJiryzZKYqWOacbehK1DyBD1SFZJo093Lrjs3Qi70/5IJIwL1Ky/?=
 =?us-ascii?Q?jdL+NeLWPWNsBV9wBeUuTmHOVEAxE9FCiPNuCcKo0foCtvb/AnRswqRc0Cdy?=
 =?us-ascii?Q?qqKmXG6wIWFKU/0K9IfNuFGjn1Toa4nRDXYc12Ro4mXVzf+kesON1caH5sm2?=
 =?us-ascii?Q?1/0Z/NANWXLkM88=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 09:31:33.6609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e694e0f-cc48-47aa-85ba-08dd4b480a2a
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB5436
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

Add an empty inline declaration when compiling tools for a host where
unmap_sysmem() is not defined.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
 tools/mkimage.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/mkimage.h b/tools/mkimage.h
index 15741f250fd..5d6bcc9301a 100644
--- a/tools/mkimage.h
+++ b/tools/mkimage.h
@@ -37,6 +37,10 @@ static inline void *map_sysmem(ulong paddr, unsigned long len)
 	return (void *)(uintptr_t)paddr;
 }
 
+static inline void unmap_sysmem(const void *vaddr)
+{
+}
+
 static inline ulong map_to_sysmem(const void *ptr)
 {
 	return (ulong)(uintptr_t)ptr;
-- 
2.43.0


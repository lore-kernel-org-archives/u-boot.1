Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1CCC021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 21:21:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26A4680F91;
	Mon, 24 Feb 2025 22:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="MwggIm8f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1033D80F88; Mon, 24 Feb 2025 22:21:12 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1835880EC0
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 22:21:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNcetgtoVqLfBXZ/NR/8QtktwFDMjecmr2p4umbmv1v9i+uKU9hNdHHvI4tUlQ9PS3nQ2dKrLmYrmFNhSB7m2USzDLofZmZi/aTYU2fDEq1SvmGWbUI5K7pwQwrcFYOOyu5Kpvm7dDFuX7KkldmgXkZLCEfNO1Rk1Mjp5r29sG0KVshmhkFzFAUOL1QTifIAjlKliigg/32qU6WexuDo9dYGwf7L6+DoZzHGBXD+nhNbVndzX6yDkbPF6jlD2ZkNV7yhinD1j/xvLyboyZ5qJO4nMJuXhfMQ/nlXOhTI7p0tFKDWdwQqJH8KwWbuzcZF3YP93C9YieD3ANIIrpWrzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u06T/Bx3Ve20Vgvb3K/XBfeYd6fpaBYpKpTG5Hhu8Ho=;
 b=hoBjruDTohFKwCMIzkmsvCdwfx4t1ei18aqVtTPTSYpeT0V8DorJR1jkHqlgLr4gnE+r3JRyHs6dRtyMWz/UsvjoM7DCVf7UCNb6vEZUI0OrACAWIX5vDJJNVl4KvNTECd5QStGL6iKcdtj60rLRiuqdfDxDK/wnUigOZ7A0SqgECrrnQktrg1wVytSwAFR6aS6le3xXc7fqoQmSapfTQ87HvzK0v1PsiTwUYK3+NqPilirnictcLF++6pEltY21HhaaxpvLF8J5q4eMk0cBXSu+534ZGafGS1oPyJi49M5kSOqo5q0lHtyRiEtAguYOPpsCoCvCwpWeCxdJdX51Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u06T/Bx3Ve20Vgvb3K/XBfeYd6fpaBYpKpTG5Hhu8Ho=;
 b=MwggIm8fm+DB8D+a5efRUjrTuSesiM1sKnSE2oUvgDqyLTecaQU/dVNoQ9AQrGpdNhfnZaJ6iKGIp+5Ja8O+88rg38Z1Rx7YE76upzfERcItoHrLRg7UBWDwop3jm2Z4Bdn9U/Lny7CVDuWv2t6Nl41nN6nSYw39rnqOxM5Qd76RNO7MI01yyL7QhAeEhRBiPzV24+iRulc3FftUnFCC04fqaEzaeuPx208oXhdCE02VFJjbucH8uhFVj4XV8FVyLchMu83ycmc7QC+LHvaA158ni67gJHTASHWwW6ZdUpvck7qPcQQoJSm3J/DFsLXbs4XsbRZWDUAlHHrC+GbQKA==
Received: from PR1P264CA0182.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:344::8)
 by MR0P264MB4702.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 21:21:08 +0000
Received: from PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:344:cafe::1c) by PR1P264CA0182.outlook.office365.com
 (2603:10a6:102:344::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Mon,
 24 Feb 2025 21:21:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089BB.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.16
 via Frontend Transport; Mon, 24 Feb 2025 21:21:07 +0000
Received: from sah2lpt245.. (unknown [192.168.72.99])
 by proxy.softathome.com (Postfix) with ESMTPSA id CC853209B3;
 Mon, 24 Feb 2025 22:21:06 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, paul.henrysd+nodisclaimer@gmail.com,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v2 2/6] image: Add an inline declaration of unmap_sysmem()
Date: Mon, 24 Feb 2025 22:20:51 +0100
Message-ID: <20250224212055.2992852-2-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224212055.2992852-1-paul.henrys_ext@softathome.com>
References: <20250224212055.2992852-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BB:EE_|MR0P264MB4702:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0048eb3e-8fe1-4c4b-426f-08dd55192749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HBQ806mrZ67GqTM36bxbi075Lhvuwf4O7k6oPtpfkOWZu1OJO45kCHVWOBrn?=
 =?us-ascii?Q?LlMmrmKgyqWIEDJgPb03hn5EVGBrVpYmyIs5hqTYjY1ZaOFfzjnUvE+7yF40?=
 =?us-ascii?Q?Mp87dtH7EefdHGbdoklxZmQhFO1mek91ej3lISStK2iIzsygem7oKkaWN4T4?=
 =?us-ascii?Q?+ayDvvDlDrIRigmyD4bVWZz/WwIHLcScyF4IzI7XVXc8nMuInz+YC+PTAus1?=
 =?us-ascii?Q?jqrNSVji0b0DdT/Jz6FHAEG+keexiNh60OxXyEKAoo7WNVRPkUIev4NvP8LW?=
 =?us-ascii?Q?cMOZGbKNQnavbFgGNBN7J5z6bVFQjE/Y0RPOWKDufyE1Yupktx5gqKV0K6Gu?=
 =?us-ascii?Q?5hENiZ1N63w3s5xEmAaRIw8Lsq1x4OSaURAlM5xPocKO0OYSiVuq94GmUfUT?=
 =?us-ascii?Q?xi9Lo3pZtEXD24u6pnO7hAGORTxPYKGNj04aARuJqffU383wDz7L4xe69mPJ?=
 =?us-ascii?Q?8n+ltsadelw36Hqxjo3JjgFTO+ETjv6+xvStMI48A23L79u9qUTR8qGbPYBi?=
 =?us-ascii?Q?NGY3GVm+KnUYKiYAySx8ps+PbJMcWIZXgzkGKiQvHkJsKpsEGaYrlna++jm6?=
 =?us-ascii?Q?uZRfzhnAhuK2ZPt8LW2YG21yaceOSKN1B90HmO0FqMt2XMbu4msYQ+83JVAF?=
 =?us-ascii?Q?KhAU3v4mUeAHefZZAe18IWhi3r9Rsq0Q2kdCORWf8ym7bKKHm7me5vJXUnLL?=
 =?us-ascii?Q?YZPlARe5zPckend9IP0E9QwgGNZDOaUzAqdJOPmzQhxXXlCyke5oz0h3cJ2b?=
 =?us-ascii?Q?pjY96PEEfZ5TJ1rKGR5G4ScTcFthHHirhrElQLbE0cseqV05Ttv9q//LRsB/?=
 =?us-ascii?Q?E6Niwqoh3wkXHF5sEavbdBJfp6f6J/daikbW1Jyz8haVyMtEL3jAx6LerKif?=
 =?us-ascii?Q?7SLphAEsRABjMG6rEH/IIGy2r88B7m/dI9JWRaR7otpEsyav1SoJs3Mf5sbZ?=
 =?us-ascii?Q?je0JqVX/PjLXY/OIFA0ggEF7iWyURgglkOyIqL0e6n6HIBVbgkmbuO3pWnlh?=
 =?us-ascii?Q?k3eVEXMQkiZ+LBLPAH8cfB2SKK0mSaO/QPpukB1FaiDtg7CWV2FtbGuxxSfj?=
 =?us-ascii?Q?Dth1Q8GCTzW3dvHI5Qphb9/5RgS1xQtmNmc7M/0wSKFFUXnEe+ajK/AYRCgw?=
 =?us-ascii?Q?lSNxsvycLiHqpI18vvs9h918O/JDQBN2M2NSmFhO2NI2el4PNfVuT1txxr0e?=
 =?us-ascii?Q?MqqnAagJvZZSzsuAG/Fkmuf3HN4CQ9blqKgAn/yBTZ4kfcPmegXdfyopGUeC?=
 =?us-ascii?Q?9mXg9jt/QTlN4jy/kjMDUMHe8LqRb/j9DPU3J3pmmwQawflo3ZvnCxohbgae?=
 =?us-ascii?Q?5CgxbUelX4CS13qGbPSApcAeJjY8pn4wUIXNK1n0Dbw3zCe5eIL8SpAsW5y3?=
 =?us-ascii?Q?kybWKvZDD7fbBVD4Ttu0/lf+iZbUWtd4KBRmflpPy6nVqQWX54TcPIf6/a03?=
 =?us-ascii?Q?+H8rUzMtTYtjJj2OVu1X4eKAut1aOXzxt1J8LCefcdMF7smVN4cyF/T1TVvL?=
 =?us-ascii?Q?IHiJrfsGXWxdqvk=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 21:21:07.7665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0048eb3e-8fe1-4c4b-426f-08dd55192749
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB4702
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


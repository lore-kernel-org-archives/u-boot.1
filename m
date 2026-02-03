Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A49FE87849
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 16:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CE3E83C14;
	Tue,  3 Feb 2026 17:49:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="X8idA2iW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 113F5839DF; Tue,  3 Feb 2026 17:49:43 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20D9183BC8
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 17:49:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWWbaXEcAug6MDfGCgF7ve3ogAgyrVJYmY7Mxzd/DadeVELSX1S9dQ5aWy6K2mrzqccWN8ZYTq0nn7+uYD75+32ASwRbyjZDYXiXSSIfP2RQeIakjOuaamBKOANnarEsye3h7SyiTMmfbHDuvH1JrbnMm1tBX9Fzqzi9TpfV8SX64Hbp/uTSMWjHumzDNDkMFEtpu/qczcTcW1yVKwd/cru2DuStWBWBdB76DhRgkudxsZZMoB6LRQ85Ta3/zyS286Jqm5W0TQjCXWoFjFqd4FsjhvJAiPvu2LhC60ckiucZ3YKKyokcwFSbNn5nlRFtrrrVjUF4KkRLE2AhC6WLuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBxG/7RXlxR2L23LLO5kFjKhWpsX7Rxa7Lamp1Rji+A=;
 b=Ihr72LXXa658RJUL9XO96zIgFQkrjUvklJUUcCkDU4WKOCp9GiBv2UQTTLhjny7KbV9KC6i7gqPoar/DKg09JSSV8JW7IVdz/h6SYP/9OUuBSk2SdAbaEcQ+Me+hLKTJcI8dNPRNiaNM7bznTVuDR9vBJtocvLdtMWqE7v93VZZBAIhzZvQODkPWqYgCDVbVMsIkmTS+EbKhAoK6SGFTG99FyzbeNnEFTZrtznqe/FkoySedtJL5EMj7dwMoCyJfxFbR+45n4kGrG4eJaZ1fjRig9a5u7yw+oBXfklnfedw7+QQParPpCN/r65heDWPGUNfWp1bMS6YwXwG37BrBxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBxG/7RXlxR2L23LLO5kFjKhWpsX7Rxa7Lamp1Rji+A=;
 b=X8idA2iWiUdaPRPax62GuRG1sSyWPxjPCrEeVpzLdc+vEZ0Pvw8Qax5SLFo5gWLcrhE3YrCLARW8rQeVtUDdUrNbLgayjcGTEs07VolfkcMemIjHLiQLH+QFzM/nbvFtQqAnTCfenbbiYfb48Qz72sy28terbwL6M3/LBwTdtDN6LHG1dvWJzkFnZ8lFOvg+aXHJ0Dub8d43aXeZH9idPvmnWDSoEWAkTB4KwB38jbr4M/AllqY+5VbX0AMkEkwB/JViOCd+IzUH4qrdb8pYHpSFaG9h6WJ5TkPBHpesKciHKvBkpDVVps64J9BiL4vDDZMZCp5NOgKHe75Rg3bTtw==
Received: from CWLP123CA0173.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19b::8)
 by DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:33f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 16:49:38 +0000
Received: from AM4PEPF00027A68.eurprd04.prod.outlook.com
 (2603:10a6:400:19b:cafe::22) by CWLP123CA0173.outlook.office365.com
 (2603:10a6:400:19b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 16:49:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM4PEPF00027A68.mail.protection.outlook.com (10.167.16.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 16:49:38 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 3 Feb
 2026 17:51:24 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 3 Feb
 2026 17:49:37 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Tue, 3 Feb 2026 17:49:26 +0100
Subject: [PATCH 6/7] ARM: dts: stm32: Add stm32mp215f-dk-u-boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260203-upstream_add_stm32mp21_support-v1-6-48ca3409cce1@foss.st.com>
References: <20260203-upstream_add_stm32mp21_support-v1-0-48ca3409cce1@foss.st.com>
In-Reply-To: <20260203-upstream_add_stm32mp21_support-v1-0-48ca3409cce1@foss.st.com>
To: <u-boot@lists.denx.de>, <uboot-stm32@st-md-mailman.stormreply.com>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Valentin Caron
 <valentin.caron@foss.st.com>, Nicolas Le Bayon <nicolas.le.bayon@st.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Marek Vasut <marek.vasut@mailbox.org>,
 Thomas Bourgoin <thomas.bourgoin@foss.st.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, Yann Gautier <yann.gautier@foss.st.com>, Simeon
 Marijon <simeon.marijon@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Cheick Traore <cheick.traore@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A68:EE_|DB9PR10MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 20cba8b3-365f-45fc-6004-08de63443809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmY0YjZNaGNNR1VTZVZlOEJ6Z3kyaTJ3Q1JoZEFLVmYyOThSVUwxV08rS2xX?=
 =?utf-8?B?amtGbHVrWE9hdW02NUl4bFVSeDlRQzlpQUNvVmsvWXBTWHJPc1pTTktNQjRH?=
 =?utf-8?B?VHJLRDIybEcxY2F6TkF6aXV5a1hQaU1WeVlSNXZ3RXdVdStmSDVacnNRbERC?=
 =?utf-8?B?K2NRL2xLSWV6ZDRFZUxPYXBDTFdURjZLVnhBOWxNbWpKVHNCd0RzQU5Fa0NV?=
 =?utf-8?B?TDE0QUkxcmZmS2s0bWVwdzU0VHRtR3ZsT3VHcjUyNmpPTndBVzJuVjFHcGhU?=
 =?utf-8?B?TFpPSTFOb1dFaWpuTjdnSzQrTzNodXYzTU1TNlYwUmFxTmFWOTlwYVRNTlMz?=
 =?utf-8?B?My9OamtRRWEzdWdDRjR4eUZ4YVVQMWllOFEzVkdhbHZtemF0bWlNSVhOczQ5?=
 =?utf-8?B?M1Y1VE5LS2tQVFNUQXhaUGQxMU9JYmM0MEpvRXVXRXdITEkwS3YxN2FiaVBa?=
 =?utf-8?B?TmllRjRDM1hlc0g2dEtJcHU5ODFmeUhjRzhQaHNoYzJoQjRDTkpUUVVTYWZi?=
 =?utf-8?B?WWU1N1pQQkZHbVBMMk5pT2tVekQ3bTlObENhYjhMaytIMUtKUWZRR0JiWTRH?=
 =?utf-8?B?TDkxYjRLVW1YWkJWNHF4bUtFYmlRenU5MytwUUxvKzZmRmIrUmFQeTNOOU9R?=
 =?utf-8?B?MGlVVEFRODlzYWpnWmk3L25MUHIzRFN3b2dvU3h2eUZiMzFFNDVsYlVOalVY?=
 =?utf-8?B?QkF2T1NEaDlhdm1lUmZUUmJlVjBPT0NsQnIyKy9oNm53cjZ3R25RQUtORU9E?=
 =?utf-8?B?RlRLVSt4bGtqNGc5UjFCUVNpZ3hBZDYzMDA1UEJtNlRnTWRUd2RkUHVjeDlJ?=
 =?utf-8?B?RHA2MnhuUkRCMkI2MXNlK29icEw1RmJJZGQzUSs3bEplbG5DNHMyOEc1TGZw?=
 =?utf-8?B?akpXZUxHbnZ3S3lnVktoNjdMY1ZTSzhQSnhsMGRLNlNDWXRRUjNwTmFiRk80?=
 =?utf-8?B?ZHlQazVjdEtHL3NQaWRuOEJMY0N5Qmwyb3hYdjhWVlNqNncyM3pxVGlmYkhk?=
 =?utf-8?B?MytIbGhZZ3ZMYjRpVUZyZEdhWFdNYm1YM0tOTHRiZkdGRVkrZWZNNTN4RXY1?=
 =?utf-8?B?WXZkd3QwU1h4cFM5T2o4NHB1QmY4aHJHd3l5dXNwblBZcEh0MGxqK1c1Z1Jh?=
 =?utf-8?B?WldqbFhMbE9ablZJemNsREFSNTN2ZCtWcWNsNWFZeUIvOUNHMzBKWWJOdjk2?=
 =?utf-8?B?bll5by90OG1jdUNSamlGV2xKdmNJN244ZEJhR05qTlJxOU00VDJZNzZBUmFL?=
 =?utf-8?B?WUs4U3gyZ1ZyQksyZlovRVNqVUcyR3NGQnZxZk9xazF3ditRTkhlQ3VtTytY?=
 =?utf-8?B?VE42dE5DQkN3cjh2dFo2eTZZaDJaNW1xR2ZFT3FtL0FNd1FmRVVoZDdCYXVD?=
 =?utf-8?B?dzZySmk0QlBYS2NHSUZmRTNaMmpzeDBWQjVYUG1RWFQ2V2NDQ2orZjdlQytl?=
 =?utf-8?B?eGZjcWRmbWFycitFMDY2RXIxOXp2TjErV0tvOEdNaTNTZkhaS0hqekd2YVNC?=
 =?utf-8?B?bkJsLytLSGRHTGJMTHpjdU9zVG4zbXhKNStpV3FVK3MxTDV2T2ZkbWdLSE12?=
 =?utf-8?B?d0ZMMloyaWpaSk05bkV2NWpPYUdnWVlFU1VaMi9QK3BFRHlUTFRlSVIyT2kz?=
 =?utf-8?B?QjZBc3NBc2F6Tm5EVFpiQ3Jha1JhSUhRVHJUZXBwZUwzMXdRN3NhZ1h3UVo2?=
 =?utf-8?B?alBGUVd3enNpNUJLQkNvNzhWVVo0LzZ1UHVTSkVPcFdMV3dVL0hubXhtL1Rs?=
 =?utf-8?B?UUlOb1d6QjN2UE9zUmNDVjBobG1pWWFiaFhMdHN5Q2dPQjlzbHAwSU5IUmN4?=
 =?utf-8?B?VnNWRjdsMm9idDBsaG5QdXYvWFVPTWVzVmR4Q21vSVBlSzh3RGhBS2o4NG1I?=
 =?utf-8?B?bWlPcG9pTnR5MXhPcTI0enN5ampZakVCSDNPQzQzaXVuaFRyNEUyM1YzblR1?=
 =?utf-8?B?Y1loOVA5UGFzZFROczFvdVIyR0ZjR1NIOVFtOCsxNkJWMnJnc1ZtTUhhS0Jo?=
 =?utf-8?B?bGhkMStZaDVmaGUyNWUvQUFFbkVaVkF6V3NqL1JqUk1CWUNDcTBSbmpHMVdr?=
 =?utf-8?B?TnR2L3B1cFJ0Z3JDV3RGazEzdEhWYmd0MDF1VVI1Wk03em8wczJnMTRwYytk?=
 =?utf-8?B?bVNrcEp4TkRaREVORlU3NmY5b25MOGY0azUzUWpSVlEralBsZWNESXEyL2t1?=
 =?utf-8?B?WmFrRXUxME9FY0lWYSt2c0tZL3JBZ3FmWWJYcWFZVFlSaWhMb3ZFOWwvdWZa?=
 =?utf-8?B?Mi90MG1Za1JoaGczTFJ4eUorcnNBPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NlgV8rIRb5tmRYLFa8B3vonfn0UBjLcvNZKGB6Q+/skTv3f1GGKo4MZVptBUlr4tdtM8cBjWNLAObJ2InfWXtVaDCU75uv8vOyqn9yIapaF1UZM0rv09V7ORZq5qBOVQHzt2l7Obi65LvrBZQ5/TpTa98BEF3m8PxqhGG5xvr5VakzRJVcGxsh+lgbMMyy0n40/BhpgFYi4a9kR1dzOLXNYvTOUo6BqHe74Rv7hedRbXSqLMHrngL+8uJ2zEfNY/a9/x1QcIKBpfChKtIJc4uhGTw5kgAs6RWZntiIKvcJRfpYIcNKbBNvRam9SsJt4pg6XfqFB9oler9WzXWDtKWWvRP48H6hYv5y7Z7VDoc46oPne89uvadV7tI7HlKNg5aOwAGsBe/Tb/cg5UfV8mSfKhLrfn5VrMcyPyRbJjVdaKHDAk9eEsFfG7+awMAw+z
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 16:49:38.1429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20cba8b3-365f-45fc-6004-08de63443809
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A68.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5211
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

Add U-Boot specific file for stm32mp215f-dk board

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/dts/stm32mp215f-dk-u-boot.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/dts/stm32mp215f-dk-u-boot.dtsi b/arch/arm/dts/stm32mp215f-dk-u-boot.dtsi
new file mode 100644
index 00000000000..e4b44af6df9
--- /dev/null
+++ b/arch/arm/dts/stm32mp215f-dk-u-boot.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
+/*
+ * Copyright (C) STMicroelectronics 2026 - All Rights Reserved
+ */
+
+/ {
+	config {
+		u-boot,boot-led = "led-blue";
+		u-boot,mmc-env-partition = "u-boot-env";
+	};
+};

-- 
2.43.0


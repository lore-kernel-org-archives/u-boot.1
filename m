Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E564DCAC59A
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 06:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C92B880B9B;
	Thu, 18 Sep 2025 08:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="TmykR+Iw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A945832BC; Thu, 18 Sep 2025 08:14:10 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20718.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::718])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 154638318E
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 08:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4tJhOxjpsC75rlpYE/rFxtPk9FfBZw9voTKaXCANp7okwAiwfHisLPREfI9Z5Hu/hLkNUMlW1kv6szG+1yjYYuk9cYLF4PiZD3Ondj9/BzL9VcNYBUHMFanhziHE2YU7CfbuuVc4XXGlPjlhNBkCyg7V+P0jiWEbjJfF0MvOxaNJS5Jt/USC9Ht5N8hKHygP53dv9QCa/pXWvr8t3LCaN+hPXIuYEzaZNVNRMP8mS//clyTS6uANkGcl+lRTtNcsh+E5w1DWjSzc39pHGZQKNHcFO3XaeWe1Q1nh3E+N567R7y4I/uYo6qtkV6mHXfp0X0MehKr1haLU80Vr6ZRJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nl6Yda3RCp68u7p3jTZO9AeT7evPAhmtTJxlK9exDsM=;
 b=iQpRrv+/RYUnbEohRvPXhIqBI1iPp+NDJAimxCAhsHmfpkfZTLyKPQlDwf0Ve7wvHF3O1dhLTdb3LYevpdIDn9NlX+TFFH0gN0ZrXdZKUaOKFRC7iWaOzcONx1PA5avZdqCMK3AV7uwZuJhNh+pTu9kPsMxSqHFYaKOybzDoXIdJNoCeTbZFoaL5L6HGqosJchMxcBJ3yRXX5+JCqHVigU3XhKp4jfLeYyEVN4JboPJDZaIp/RhvAi+8+Ftf/H59jMahpumQ7VupAvWi4fXjcH71yyYaUVv17bI5lljmiCnGXaSfJA0FvMAbnRSMr3raE2J88GpnNQAMQij7ITmGRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nl6Yda3RCp68u7p3jTZO9AeT7evPAhmtTJxlK9exDsM=;
 b=TmykR+Iw/WAtThZqMJ0+IUaVhYQ3vJCVwVFpRecpskVYNzEgTwTE1BABCPsY7ULtz3GQOgjvcqqx+wMi+hTBID3zD9haZT6LG28EU4Oc3hAuNMV3YrYcVBKCyIWQ4qE90yH/9VAG2dL5Hn//eD010zZoVSJ8oi1nqybYsMfH5wmEQhhfw3zK0kIShTlHvmYmL5oHwXrB3KYWk+ZQQyzulkRhGq8yjJW+5XKAYXayHvSNSGtIjYXO0YkqqCOwAgeQgfBKtyZ79bW/tpE+Y+xmVUXmIlZFkX32Kvtf8+lYl0XevkJaLyhGbIVIWXPXdDm9aIZ3yVYpKQCn0F3gSv1cGA==
Received: from DUZPR01CA0050.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::20) by GVXP195MB1784.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:150:1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 06:14:00 +0000
Received: from DU2PEPF0001E9C1.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::7d) by DUZPR01CA0050.outlook.office365.com
 (2603:10a6:10:469::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 06:14:20 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF0001E9C1.mail.protection.outlook.com (10.167.8.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 06:13:59 +0000
Received: from Postix.phytec.de (172.25.0.11) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Thu, 18 Sep
 2025 08:13:58 +0200
Received: from llp-moog.phytec.de (172.25.32.54) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 18 Sep
 2025 08:13:58 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Thu, 18 Sep 2025 08:13:56 +0200
Subject: [PATCH v5 2/3] doc: phytec: update imx8m docs for optee builds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250918-imx8m-optee-enable-v5-2-ecbe0b583b94@phytec.de>
References: <20250918-imx8m-optee-enable-v5-0-ecbe0b583b94@phytec.de>
In-Reply-To: <20250918-imx8m-optee-enable-v5-0-ecbe0b583b94@phytec.de>
To: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, "Teresa
 Remmet" <t.remmet@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <b.hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>, Jan Remmet
 <j.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758176038; l=6497;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=wDra8TgJdqWIyUrrE7EwV+OlVfS0BZmxb7agCqj2h2M=;
 b=uQlKWB27FKF1yLrLh+Xz+esP6PBE5ehx1AabtUQOzjjG2aP5UtjDNf0NFoxmYoNrZqKu5OtGC
 1fVHnrNnr4HA3J03i6g4x9By63BuE/moyli8so3by2zl9fN/9xEIw6/
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.54]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C1:EE_|GVXP195MB1784:EE_
X-MS-Office365-Filtering-Correlation-Id: 09203d7e-e2f8-4b28-fe3e-08ddf67a8ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a09mTnpzaTliWS9uaWVlOE5icDdaSUkreWhoMTE5MnV1TGFwb052YXBrcW5I?=
 =?utf-8?B?K2FmRUduUXFyYmEzVkNISGRrVDZzc0RHUFd1TWFwSXZLQzVHazluYXhpVmVH?=
 =?utf-8?B?Q1lqKzRXS2FzSExsK2RTbEVzaWxQZ2VvcER2VFVVMTA1c3Z3c1ZNSHlZY1Zw?=
 =?utf-8?B?TkhtMDdtVnkvek5tVmduZnJxSjgrL2lwbkNpZUozMUNrVXFURzRqQWwzSnVR?=
 =?utf-8?B?UWt2ZVgvVFA0UWQzaHpqeUpKYkIrZlkxRlFISmp2NnRCWUhkZWZ1M2Q4Z2FS?=
 =?utf-8?B?NDBDa3dybERmck1LSTZZclkzK0gwSDRlYzl5bTZUa3FWU1V5bFUwY05BUVU1?=
 =?utf-8?B?OVpRVk9JQ2I5YkJwTGErVk9qc1hXK3FXUzhhSzJ1QTRMYkRyM1UvbU5yMjc1?=
 =?utf-8?B?SnBYZ2YrUTcya3VwYzVTSjZRVTdWVWVhS3lKMldOY08wUThZUEQ0YVJEcTFE?=
 =?utf-8?B?eUVISGVvaXhadWltaHJhc1BHQzVhSUdCSWtHMVdSRW1iaGV5N1hmVFNNc0Yx?=
 =?utf-8?B?NmZwT0hjNHphYkFaOWJDMjZ6R0lnd2EyUGhzdVE1U05Wc3NmSXZhZFcxdlhw?=
 =?utf-8?B?K0sxOHRLR1ZCTld4SndKV3pwaTJHOVFXZ25Pbmg2ZHJTVHUxbGFGeGdHWUM0?=
 =?utf-8?B?VkF6dUNYdVlpMVhaaldOZFlUTkxOYXBHRVdJU2lYQmwzOGFwMnhUMUVGUHV6?=
 =?utf-8?B?MTlTV2pEZEttNWZYYlhaM29NVmlNakpOT1hwbnBGZFYrZWtObUYxK3FIdStN?=
 =?utf-8?B?Q2QxWGZneVVYUGtueElabmFYbWpnR1Q2bFB1NTgyTnhRenQxbmtjQTUxaWdV?=
 =?utf-8?B?U0YxSnUzR0Q4VGxtRUlyMnRHMUVwWGhlY2RUMS9CNCtrSFlvY3lMR2lVYVhQ?=
 =?utf-8?B?d2ZDMkRmUWRSUUVzbzJXVld4VmpGeDF1Qk10V1NyVitieFhqdFR1T1VncVB2?=
 =?utf-8?B?L3hHVXpiVEovVEJlcE4rTGpTdmhQbU9LWnkvNVZxL3ZXN3dpMVFFZnNETit0?=
 =?utf-8?B?ZnF4M0tQTTViWHEyRjFMYXV5WERWa1Z2WUJpL1NIWkxIUWpHRlBVZ3g4THNj?=
 =?utf-8?B?OW5kZDNuOFVKWStYcytjc1d1N09PMmg2aDRDRFJRQkxRQUo2emJJTkFPdWQr?=
 =?utf-8?B?YlU1ZWtvU04rR2l2V0wrVERsVDFhNzk5R1pEcEF1VCt4b1g1TUhOMG8rVHMy?=
 =?utf-8?B?d0w5MFJhR2lUendMYnBRVmtsaGJhaTQ4WGg5VmJiSzg2ZUhOUHNPZWEvNFpK?=
 =?utf-8?B?SW9RblpxQW1UVHNwVElYSC9kaWJENzZSYmtmbHFwS0gyMnJlNm5FNGN2clFm?=
 =?utf-8?B?UW53WkJXOFFNaGFtODZnMW5KM2NEZ2NIRGFBOUd3MG1vNjhFTjh2Qkg0dmp0?=
 =?utf-8?B?Mkw1SVR4ZzFjZXN1WFBmL1pXS1JNSmlBL2JreDhHWTJSemVLRTd5VkZSRWN5?=
 =?utf-8?B?VW44Z0orRnlBNTBHWmNvV3h6dWtpQW94ZUhRaExSbWpPdzhoMnkycStRYXY0?=
 =?utf-8?B?TUxTZ3N5YjNKajFIOXBzTElPdG4yWU9rb3BrWm0xWXR2Rkh2T1BnYi9FQitq?=
 =?utf-8?B?NEZRb2pZRnR3K3gyT0YvRzZsMEMwekN4SEhYWGdITlNYNlY1bDdGNm9CUVZD?=
 =?utf-8?B?V3hTcldrN0ZhUXFJRVJ5U2pvRElFcGJ1ZTM1eE5ncWwwbWVWVkdMMFVKS0lj?=
 =?utf-8?B?OUR6d1B5dVNVbDJUejliRXBUYi8vSWpwNi85WDJyU1BEcjBucXA3TnlwSk1h?=
 =?utf-8?B?ZHlOd2tybWJWVWxzNmVLdG9NRnVpY3VaWmFXT1RNZmx6cE9Eayt5QVVYbU1K?=
 =?utf-8?B?U3E1VjdZd1RSNHJMelllUHdFNlIyZnJkWXdud2hGVWNETHo3UGpjV3kyalhX?=
 =?utf-8?B?enpYWjRwRUFkZVpGYTllYmpjQmdxTDAzU0NVQ2FTUWx1Ym4vTW0xeGdub1Fs?=
 =?utf-8?B?SEFTTVh1N1ZmTlc5UE10RXNkQUtxK0oxajlqenBSRGxXWDZuZUVseTc4dzN4?=
 =?utf-8?B?Q0dLK1poMEFrY0dXUU5Dejh5ZHFRR3VGb3N3ZjZuaGRFWlpSSm1mRm1ZZGpF?=
 =?utf-8?B?c2gzSTNjR0NvRFRGSTJ4M3VySUk2b3V0MitBZz09?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 06:13:59.9446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09203d7e-e2f8-4b28-fe3e-08ddf67a8ee2
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP195MB1784
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

OP-TEE configs are enabled by default, change the doc to no longer
declare OP-TEE as optional. Also remove CFG_TEE_BENCHMARK as it is no
longer present in optee_os.
Further, phycore-imx8mm and imx8mm-phygate-tauri-l use different build
instructions, so dissolve the common file for building OP-TEE.

Reviewed-by: Teresa Remmet <t.remmet@phytec.de>
Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 board/phytec/phycore_imx8mm/MAINTAINERS     |  1 -
 doc/board/phytec/imx8mm-optee-build.rsti    | 14 --------------
 doc/board/phytec/imx8mm-phygate-tauri-l.rst | 18 ++++++++++++------
 doc/board/phytec/imx8mp-libra-fpsc.rst      |  1 -
 doc/board/phytec/phycore-imx8mm.rst         | 18 ++++++++++++------
 doc/board/phytec/phycore-imx8mp.rst         | 16 ++++++----------
 6 files changed, 30 insertions(+), 38 deletions(-)

diff --git a/board/phytec/phycore_imx8mm/MAINTAINERS b/board/phytec/phycore_imx8mm/MAINTAINERS
index 7631e1cb331b608335620d0db49104459f673d1d..58c5e2d0af9fe404a5995fecc96cdbaa5845f979 100644
--- a/board/phytec/phycore_imx8mm/MAINTAINERS
+++ b/board/phytec/phycore_imx8mm/MAINTAINERS
@@ -9,6 +9,5 @@ F:	configs/imx8mm-phygate-tauri-l_defconfig
 F:      configs/phycore-imx8mm_defconfig
 F:	doc/board/phytec/imx8mm-phygate-tauri-l.rst
 F:	doc/board/phytec/index.rst
-F:	doc/board/phytec/imx8mm-optee-build.rsti
 F:	doc/board/phytec/phycore_imx8mm.rst
 F:      include/configs/phycore_imx8mm.h
diff --git a/doc/board/phytec/imx8mm-optee-build.rsti b/doc/board/phytec/imx8mm-optee-build.rsti
deleted file mode 100644
index c83de5cc7cf4a0229cbd89f4c7d2bfd8448cb735..0000000000000000000000000000000000000000
--- a/doc/board/phytec/imx8mm-optee-build.rsti
+++ /dev/null
@@ -1,14 +0,0 @@
-Build the OP-TEE binary (optional)
-----------------------------------
-
-.. code-block:: bash
-
-   $ git clone https://github.com/OP-TEE/optee_os.git
-   $ cd optee_os
-   $ make CFG_TEE_BENCHMARK=n \
-     CROSS_COMPILE=aarch64-linux-gnu- \
-     O=out/arm \
-     PLATFORM=imx-mx8mmevk \
-     CFG_TZDRAM_START=0x56000000 \
-     CFG_DDR_SIZE=0x80000000 \
-     CFG_UART_BASE=UART3_BASE
diff --git a/doc/board/phytec/imx8mm-phygate-tauri-l.rst b/doc/board/phytec/imx8mm-phygate-tauri-l.rst
index 0d9e1024f8c5300e91a3a4c18b2babd5853a0824..bc58a141e4f1aec894b70c1dea2f01c28b3cce3c 100644
--- a/doc/board/phytec/imx8mm-phygate-tauri-l.rst
+++ b/doc/board/phytec/imx8mm-phygate-tauri-l.rst
@@ -9,7 +9,7 @@ Quick Start
 -----------
 
 - Build the ARM Trusted firmware binary
-- Build the OP-TEE binary (optional)
+- Build the OP-TEE binary
 - Get ddr firmware
 - Build U-Boot
 - Boot
@@ -23,12 +23,18 @@ Build the ARM Trusted firmware binary
    $ cd trusted-firmware-a
    $ export CROSS_COMPILE=aarch64-linux-gnu-
    $ export IMX_BOOT_UART_BASE=0x30880000
-   $ # with optee
-   $ make PLAT=imx8mm BL32_BASE=0x56000000 SPD=opteed bl31
-   $ # without optee
-   $ make PLAT=imx8mm bl31
+   $ make PLAT=imx8mm BL32_BASE=0xbe000000 SPD=opteed bl31
 
-.. include:: imx8mm-optee-build.rsti
+Build the OP-TEE binary
+-----------------------
+
+.. code-block:: bash
+
+   $ git clone https://github.com/OP-TEE/optee_os.git
+   $ cd optee_os
+   $ make CROSS_COMPILE=aarch64-linux-gnu- \
+          O=out/arm \
+          PLATFORM=imx-mx8mm_phygate_tauri_l
 
 Get the ddr firmware
 --------------------
diff --git a/doc/board/phytec/imx8mp-libra-fpsc.rst b/doc/board/phytec/imx8mp-libra-fpsc.rst
index 26752ac1882f99cf5ad22f8cbe0af77a6bd41d25..87b7a99ee710f7dd90fdcb7d62b9b451b895b8df 100644
--- a/doc/board/phytec/imx8mp-libra-fpsc.rst
+++ b/doc/board/phytec/imx8mp-libra-fpsc.rst
@@ -40,7 +40,6 @@ Build the OP-TEE binary
    $ cd optee_os
    $ make -j $(nproc) \
           CROSS_COMPILE=aarch64-linux-gnu- \
-          CFG_TEE_BENCHMARK=n \
           O=out/arm \
           PLATFORM=imx-mx8mp_libra_fpsc
 
diff --git a/doc/board/phytec/phycore-imx8mm.rst b/doc/board/phytec/phycore-imx8mm.rst
index 08f5949e02d8d2bfba71867d93c2b3ed8fdc67e2..f8fa420019cf994d602a30c61c62bdd16adb8929 100644
--- a/doc/board/phytec/phycore-imx8mm.rst
+++ b/doc/board/phytec/phycore-imx8mm.rst
@@ -9,7 +9,7 @@ Quick Start
 -----------
 
 - Build the ARM Trusted firmware binary
-- Build the OP-TEE binary (optional)
+- Build the OP-TEE binary
 - Get ddr firmware
 - Build U-Boot
 - Boot
@@ -23,12 +23,18 @@ Build the ARM Trusted firmware binary
    $ cd trusted-firmware-a
    $ export CROSS_COMPILE=aarch64-linux-gnu-
    $ export IMX_BOOT_UART_BASE=0x30880000
-   $ # with optee
-   $ make PLAT=imx8mm BL32_BASE=0x56000000 SPD=opteed bl31
-   $ # without optee
-   $ make PLAT=imx8mm bl31
+   $ make PLAT=imx8mm BL32_BASE=0x7e000000 SPD=opteed bl31
 
-.. include:: imx8mm-optee-build.rsti
+Build the OP-TEE binary
+-----------------------
+
+.. code-block:: bash
+
+   $ git clone https://github.com/OP-TEE/optee_os.git
+   $ cd optee_os
+   $ make CROSS_COMPILE=aarch64-linux-gnu- \
+          O=out/arm \
+          PLATFORM=imx-mx8mm_phyboard_polis
 
 Get the ddr firmware
 --------------------
diff --git a/doc/board/phytec/phycore-imx8mp.rst b/doc/board/phytec/phycore-imx8mp.rst
index 50be99126537a2dc5323bd49c1513b196182c5f3..df087072062a0b8ca2179fecaead4fa3d0b9eff4 100644
--- a/doc/board/phytec/phycore-imx8mp.rst
+++ b/doc/board/phytec/phycore-imx8mp.rst
@@ -9,7 +9,7 @@ Quick Start
 -----------
 
 - Build the ARM Trusted firmware binary
-- Build the OP-TEE binary (optional)
+- Build the OP-TEE binary
 - Get ddr firmware
 - Build U-Boot
 - Boot
@@ -23,23 +23,19 @@ Build the ARM Trusted firmware binary
    $ cd trusted-firmware-a
    $ export CROSS_COMPILE=aarch64-linux-gnu-
    $ export IMX_BOOT_UART_BASE=0x30860000
-   $ # with optee
-   $ make PLAT=imx8mp SPD=opteed bl31
-   $ # without optee
-   $ make PLAT=imx8mp bl31
+   $ make PLAT=imx8mp BL32_BASE=0x7e000000 SPD=opteed bl31
 
-Build the OP-TEE binary (optional)
-----------------------------------
+Build the OP-TEE binary
+-----------------------
 
 .. code-block:: bash
 
    $ git clone https://github.com/OP-TEE/optee_os.git
    $ cd optee_os
-   $ make CFG_TEE_BENCHMARK=n \
-     CROSS_COMPILE=aarch64-linux-gnu- \
+   $ make CROSS_COMPILE=aarch64-linux-gnu- \
      O=out/arm \
      PLATFORM=imx-mx8mp_phyboard_pollux \
-     CFG_TZDRAM_START=0x56000000
+     CFG_TZDRAM_START=0x7e000000
 
 Get the ddr firmware
 --------------------

-- 
2.43.0


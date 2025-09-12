Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6573CAC582
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 10:06:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 394C983423;
	Fri, 12 Sep 2025 12:06:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SkJoTs0g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAB2E83423; Fri, 12 Sep 2025 12:05:59 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C52E783322
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 12:05:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J51ca7OzFRn0OMHRtftDp8FilqQCztWZFIWfLuc7ArqT5ctNp+uchh+qWZA9P/FnZTSjGbZaRCrD5prTWz6yys2rpFMcNm7IL81mEEQNdYwRwpoi+gEYaHymOHhnGvHKMW4g2gNvatGbZf1AkuSLOc4aoX3cifl/hyj+66nP+eGLOPLGrmasSqgwc8y9cRauzh8m4hwv5bEJequhqV5bjngpu2fdXEZL7vHilscsUDiT+qUIne49U0BRr4vN7szrDK17YqiIeuVJWoCPPfOvpnmrTAfY04MgQpBGNwiVO080SAZu+braPua8sSWiso98qHg6iCc8aQq8tB/X/zZTXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1YfR5sBm/fsTq4Faw5GdSIkVh+KNpuGsnhp5Ol+Y5c=;
 b=GswUv1TLCHuI6bjQ4lSu7Kttvj3l2+py3x1Sz7jsOU6j2087BecdKdXKCyRtzUR+/pc53FUW2DYFiNrNFXmIeXodkKKqKoLnO5osUMTUOEQ87p0aEXnOA/o5pgvPCMZ2OuCxJPGI0sfP95f/mD/vO9Qobvo9y5TzroUONKCuz+VVMqbYBfZN50GlsTPfNmKaZXTDtThTrs3vQXTlhZW9TiLSYfIeEUNzNeLBIbKCcqPxqo+qcHbvoFE60jSj/Zi65i4truavRBAVfBi3eJJzjZwnSwgK9+/9Z0RoXdbYWUXDmrb2gCQyW9ATA2XyTsclCPa1Z5Oh32OX8TuPMRSx+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1YfR5sBm/fsTq4Faw5GdSIkVh+KNpuGsnhp5Ol+Y5c=;
 b=SkJoTs0gMo1+wUtrucTCL8XjnYgXNR/6ga0uM9spafB7yaUlND9D3W21NVO25WoQ1b5EcEQnNh2YHuYD+oNJ8K2J2V8EWnOFyAV5SlC7ZQLqQbhEVtzpBhY7T6FbnwCRyvh5hy7ffjhDXQqZ0bhBzP+bRy6+uSdeBxvKM2jq4mc=
Received: from MN0P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::27)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:05:54 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:52e:cafe::4d) by MN0P220CA0023.outlook.office365.com
 (2603:10b6:208:52e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 10:05:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.0 via Frontend Transport; Fri, 12 Sep 2025 10:05:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:05:54 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:05:53 -0700
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 12 Sep 2025 03:05:51 -0700
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <ilias.apalodimas@linaro.org>
Subject: [PATCH v4 2/2] board: xilinx: update guid based on metadata
Date: Fri, 12 Sep 2025 15:35:39 +0530
Message-ID: <20250912100539.4127378-3-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250912100539.4127378-1-padmarao.begari@amd.com>
References: <20250912100539.4127378-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|MN2PR12MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: fd772ea2-8476-424f-9776-08ddf1e3f60b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q6DO3vDfLT/Rm10ym4IwMVV5umGnDJSl86HRHdhFmA9kjQm8wHZU6sw+Sls0?=
 =?us-ascii?Q?LPlD2Psap0t1/a1fWTSA99eHUQYWcr3ZAFl2IBgytRCgrf+NcD3YbooWPYYs?=
 =?us-ascii?Q?q0ogRfv8W6pKocHmkjJHm7l8c75/JbeZHA7fFdUJH+131eitgJGD4j6nvOK+?=
 =?us-ascii?Q?AlY8i9NxBYww3kh50DZzANa8meMbBXccC0J6yesgd7H4d9Gw+5rS5mwFTaOA?=
 =?us-ascii?Q?CRNrgmqDCurWha5fSL8W9k+4ej4/6pelES6yYp6c6oMlvDKh4/XmRiJ1uHYW?=
 =?us-ascii?Q?1CTrtMpmlcBmiKShJWs7PLEoKkqmSHEVEITuH3M9W1CjWs+ggohoSdyjVUKB?=
 =?us-ascii?Q?J1SyWuN6BO23g5x/2+2TI7IVYUXwuHp5tMBZYXGpJQS7hP4DprPk1hO+q4Sl?=
 =?us-ascii?Q?OVOi7W/rr/ZvrK2TTL7RJVt1RJJX33j9JvuxLhroZGG5V/wTZXZSCXeXWy+w?=
 =?us-ascii?Q?XZkavfoval9lWcohUdFoz6DiCJCVlnhe2FpOOwC+6+7+TYvaTeOX719M7dT7?=
 =?us-ascii?Q?jk4OcKMi+AJ9xriLOVj8HqSQm4o/x+iLopMDEeeYKzMuhCbkcnY0/XeLAOvQ?=
 =?us-ascii?Q?I3tURqUWHj4Cm6zlPFLtsQ+XeoDE/C7PliHRlCxlQUgo468+Slm7UDNb5TTL?=
 =?us-ascii?Q?4nALuYnkW4WYUwfbCdpwseADz7N/iylfDwkc4wbTHhsOjWYj157Idc8CL0mM?=
 =?us-ascii?Q?uSO8lHOouDN/xPH8wpEzy6Wgt62O8V5H/TDH1RIQUwi6oeg1RWwE4a7bz6iP?=
 =?us-ascii?Q?22JxWyUuhxn3jDm75kUYz7pj3rnIsVo1XdHE7gqej1RqsyH7XjEATKFzWcEN?=
 =?us-ascii?Q?lGTSl2t12SjcAUy0sSGlzAxh6Auu5qkKhlZHWM779vekc7q4QHyLhz110Lzl?=
 =?us-ascii?Q?reqcckAmFZM1EEzRWmoPeZ/DsDQh2Fb6DJ5b/6hnSxHcAOOJgFNFzBvycEjf?=
 =?us-ascii?Q?+onxfQksSReJLOHljVQkk4klHKSjarL3RqkpxtgOhH9nU12GkQOyLqeI5c44?=
 =?us-ascii?Q?emg/Y1Joy1NwE5Iywgmz2xvJZPIDJ6DG2sB5Ee7yqJZyLJ3j8U12Rx1Od2/V?=
 =?us-ascii?Q?hAjKnlyzB7cwKncENOHrNr9sl8POp9XarRJLXJu/w+XUYBbwPlowHO3e/Leb?=
 =?us-ascii?Q?jjTkHN+P2GXPx8TTP02xgcptcbM2OZMw6f7K9nBxVu/TgVV5TV0fDpWQVuey?=
 =?us-ascii?Q?z9351Oewk2zF3V3SpsjbzP57JAU4x/pU7hMVedevPF4K7HE5+5uRDMxz/0Bp?=
 =?us-ascii?Q?ZGwK2kZCJJJtcDJaqP0/v5/XyU2SPFbwRkWMtGw5ivdT4UNhgIabrLojkhLL?=
 =?us-ascii?Q?v6e08cOiiG+IZzd1HiXK1f+xNt5M4+FZSh1p72yWxI9G80jkfZjKKMN9YYxU?=
 =?us-ascii?Q?/OKXFyNav9m4b5nP5apX14vcRWufW3pFVyFxxKYOS3VwHuAQYckr0i3DEtvG?=
 =?us-ascii?Q?ptPKIOG2C7wFeQ9N+DFb/ik2tfGnCc250nsxvDm6LVRxTk3JnDTCm7xO2rrr?=
 =?us-ascii?Q?ER9ahakYbnk9gvalZswmvqSrhcqAgosOUx1w?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:05:54.3877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd772ea2-8476-424f-9776-08ddf1e3f60b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061
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

The generated GUID applies to all Xilinx platforms but is not
specific to any individual board. For FWU multi bank update,
use the image UUID (GUID) from the FWU metadata structure
rather than embedding a generated GUID into the U-Boot build.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 board/xilinx/common/board.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index ceb58da6d3c..26facb6daea 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -9,6 +9,7 @@
 #include <efi.h>
 #include <efi_loader.h>
 #include <env.h>
+#include <fwu.h>
 #include <image.h>
 #include <init.h>
 #include <jffs2/load_kernel.h>
@@ -743,3 +744,29 @@ __weak int board_rng_seed(struct abuf *buf)
 	return 0;
 }
 #endif
+
+#if defined(CONFIG_FWU_MULTI_BANK_UPDATE)
+int fwu_platform_hook(struct udevice *dev, struct fwu_data *data)
+{
+	/* Note: The FWU metadata is an unsecure piece of data, as
+	 * highlighted by the spec, and there is no way to ascertain
+	 * that it has not been tampered with in a malicious manner.
+	 * U-Boot OTOH can be part of a trusted boot chain, where the
+	 * U-Boot image has been verified before being booted. So,
+	 * although this does remove issues that might crop up with
+	 * manual mismatches, still need to consider the fact that
+	 * the FWU mdata is not a secure piece of data.
+
+	 * And this is a not real problem with Xilinx platforms because
+	 * actually it is only providing reference stack.
+	 */
+
+	struct fwu_image_entry *img_entry = &data->fwu_images[0];
+
+	/* Copy image type GUID */
+	memcpy(&fw_images[0].image_type_id, &img_entry->image_type_guid, 16);
+
+	return 0;
+}
+
+#endif
-- 
2.44.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB60C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 21:21:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C602280FC9;
	Mon, 24 Feb 2025 22:21:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="eK/ATSWY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 507A080F98; Mon, 24 Feb 2025 22:21:14 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ABAE80EC0
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 22:21:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1qbdkXU4hwC3rgpPE1a5jstuM4qN1FR3daoMblEhDfRHHiFX++OXFA07y0+zSAtOrLHbqp4YGWTuK9ojZTzeYG9rBuD94Y3PSSWW83OVrht6hVVO+9d64hESEwKisyEoAcPjLpgmu5a6wen0rLZFXZztfjK7zkHlA2FbYumhLzN+Sz1zxesqRZg1WIJWsN1ijSJA2j7KuQV3lI2ZTSfexQ7qkYLBh8V329gqA7mj2xijiYe2aqgj0mti1bdtdszPi4e2kYaFgNyCYyvqjpR/FCKbvLA+i7pwFuH/oFwdlO8swxcpYDOf48KtfF7rEjmilh47AYqyMv6Q9c47zMJVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qEIozGbDBzihvGz3IcA6YBqJnhy+El3TeuWysxRTIA=;
 b=jPCleiCUZdRSQOO9bnN4ct5NFdx4+7IvXFLJ1YWuc/kfwEiKUTIrI7pzHDxIk8xPFtP+ZAKgaT+2OUWxJtK8ymO62zZRuSOFRVEn8HS+nzTz9oEFvahM23XVm0O4c4LKJPwyHCpqajLh5zUs8UfWdoOeNs+Nbqc+NZtkkIy8yDsM3xI67ufi1YPCSiO7UViD5ZKcOP6KykpdBCqONmx8aIRRIgnhMBC8wh8SFVXFOHWc0Ukt3DgiM4bsmnjDtU9VqpG5apI6EGiofFawjYgbT/yvksyYEulYhkrGS6pv19voH0ijWPIzVKVRD3PRLmYnvoXWje5UiNRdT9i9l7v3LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qEIozGbDBzihvGz3IcA6YBqJnhy+El3TeuWysxRTIA=;
 b=eK/ATSWYSGHaITYJ7/HznTx9aEXrd3KXM7T+wWU+Rzrr1c0SdJ8bpgCXSpeSXvr6r2ybbIFQ+N784ht5qqRMRRsfsawuY750IUe+XY/mxNt467UTbdF4UMmzIuXgNaJUiWHkKffQ4RTCAg3H9w2NvkyhcvjoD9yF8RuCwn0qKIIghnAlm1hBuZzHxSIavS5ekroT7air5mprs3JjWNj4mCd8t39sDUnPZV9NODc/ViJs5uGypMGIUhnJpcIERIq/3d1n91wFaMWFWiABwIAATG+fqEcQgglDH9qnXcvOOke6ilIuQIhCl26ngPAAFETwmzTyl3spfynRePLVexo8IA==
Received: from GV0P278CA0036.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:28::23)
 by MRYP264MB6334.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:6d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 21:21:09 +0000
Received: from PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:710:28:cafe::83) by GV0P278CA0036.outlook.office365.com
 (2603:10a6:710:28::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Mon,
 24 Feb 2025 21:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019233.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.16
 via Frontend Transport; Mon, 24 Feb 2025 21:21:09 +0000
Received: from sah2lpt245.. (unknown [192.168.72.99])
 by proxy.softathome.com (Postfix) with ESMTPSA id 0934420206;
 Mon, 24 Feb 2025 22:21:07 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, paul.henrysd+nodisclaimer@gmail.com,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v2 3/6] boot: Add support of the pre-load signature for host
 tools
Date: Mon, 24 Feb 2025 22:20:52 +0100
Message-ID: <20250224212055.2992852-3-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224212055.2992852-1-paul.henrys_ext@softathome.com>
References: <20250224212055.2992852-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019233:EE_|MRYP264MB6334:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6df53065-c17c-4df5-8b48-08dd55192827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GdG30BCxvJpQ48m8vFjsX02RH5Y0+iT8DlXftZKyZ4/m67V8apCfiAZ71lix?=
 =?us-ascii?Q?QRX6A0Us85c/6sxu+Cp+tCRsB7UYhRp6g5sloRJTdHhsYngHFb7cnyJiE389?=
 =?us-ascii?Q?GiuFMiXBgHrOQB0G0ySyolsilOWujDqHkp1k0nQi0h/90qJ3ylPv4tKPTgr3?=
 =?us-ascii?Q?lfRcpvV05fWOuaN95NlgUT/fUcFAE6ltpRat86Fr7HvcFAIIpHevhQ9hVHRm?=
 =?us-ascii?Q?B9AukZYyh0afaMAzpV/L16lHfdtR6AtzeOF+9QjCqajIXB2tc5oeKRijPWJd?=
 =?us-ascii?Q?m0/rm8W7JiohqX6V2IYlZOYPCDoGgSUarBVqI2bv4qatPHJMMrPJhvsZfi5E?=
 =?us-ascii?Q?DgDamipGP0yseOVNdqhcFkYQHZFdOZXJy3//Zs+0h7mZOd95GWIp0E8gRJm8?=
 =?us-ascii?Q?rS+w6SCsqTTN7ZL3b9DAYHL33xbyqZr02OInpTIJ7FPgCWQ1W6aGH7uCta+U?=
 =?us-ascii?Q?kMx2Y5Aw57VdR8/EFR8O8U9ZdyO5qdRhs5kaww/gGWtfqBBMGD1aSQa3OZew?=
 =?us-ascii?Q?qQzQk74gdkJ/60Qmb+pjxck14Txfg/xlI48xbJ5yqFyUR7Qrg2IZ+8uKnWAx?=
 =?us-ascii?Q?uXwY0P4f1djkcS49J08Y3C0PlnjIM/HJNTsRXPtSCwZ91Jo9j+3Rl70V/whQ?=
 =?us-ascii?Q?iQk8ArsbuwDv+2AP57NppGYSMmrDQrCLOT/apLR+ly6oegEeeEbDYaa7x/+p?=
 =?us-ascii?Q?a4tzIirYZG4mJaeSPvW82BA8/as7VDJIKjQKi58LM7X0ICnZDxZuXYoRrA+o?=
 =?us-ascii?Q?fF4tnhn5CUkxbSfyZYT3A5G9ynEYMHMZOK8wRNiMd2Js9NTAF+VkazOSkwaS?=
 =?us-ascii?Q?l9lcpEp6a+Oq1O5aQwGtJjh0hHFY8Vo0AyGXQapKeBmgSNQqQ4l2zVyPdaE5?=
 =?us-ascii?Q?x/dZ/uzMcPcOoEjVcRlXYZ2+QNbIJyfWH1MiqLZK+fYeSDpdPkQfOsyXooFB?=
 =?us-ascii?Q?4CsskF1aa1PTVSN+bBRZz2HgmyjgbPgm+lxDh8QsSU3WJ86D7X80UsZNvyZZ?=
 =?us-ascii?Q?RtFmPNsJT+PsDkayWn3wGIqbYGJmmViyhlbJDkSzbesWgkDJGBOlQfPQZd91?=
 =?us-ascii?Q?Hl3w+r3BkMKlu8wiIDSq6nrDNz3CuFbicBUKGCAFBKxpCJ7UpRhePZtbzRue?=
 =?us-ascii?Q?lh0sScAw4R4kbrjAkWJrNV6BLTxF+KQdjpPjZoUkz14C0lVic2oNZitpMJ//?=
 =?us-ascii?Q?46YRdYwg4SQvcuXpSP2fcY7SgdMXVw6/2SM1YImc35eChOCCQKWZbKOyngSQ?=
 =?us-ascii?Q?jWYH8hHCsIVl0srxx+SSlLZdHmWrOSTV1EsCAGsyCH3MC+odBorZEjeKWVzW?=
 =?us-ascii?Q?ecio58ds4y3L9rCrIzZpx86xXjgudgEQpFlWlzESaH/PpyCrr08uqtP3eqza?=
 =?us-ascii?Q?9428xCkQ55H/KMmfoXQeKBpebulR0B7M8GPB0q9+UOKmSeH1gv/c1Uo7uNuP?=
 =?us-ascii?Q?hcqggXx/rA3iJRhptKVzRmPVvIZ5PAtK9amzNgjw6LQ77I2VKys2imQJmAhf?=
 =?us-ascii?Q?9ZGktGeoYdZxyAk=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 21:21:09.2233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df53065-c17c-4df5-8b48-08dd55192827
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRYP264MB6334
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

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
 boot/image-pre-load.c | 57 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/boot/image-pre-load.c b/boot/image-pre-load.c
index cc19017404c..adf3b341a20 100644
--- a/boot/image-pre-load.c
+++ b/boot/image-pre-load.c
@@ -3,13 +3,24 @@
  * Copyright (C) 2021 Philippe Reynes <philippe.reynes@softathome.com>
  */
 
+#ifdef USE_HOSTCC
+#include "mkimage.h"
+#else
 #include <asm/global_data.h>
-DECLARE_GLOBAL_DATA_PTR;
-#include <image.h>
 #include <mapmem.h>
+DECLARE_GLOBAL_DATA_PTR;
+#endif /* !USE_HOSTCC*/
 
+#include <image.h>
 #include <u-boot/sha256.h>
 
+#ifdef USE_HOSTCC
+/* Define compat stuff for use in tools. */
+typedef uint8_t u8;
+typedef uint16_t u16;
+typedef uint32_t u32;
+#endif
+
 /*
  * Offset of the image
  *
@@ -17,6 +28,47 @@ DECLARE_GLOBAL_DATA_PTR;
  */
 ulong image_load_offset;
 
+#ifdef USE_HOSTCC
+/* Host tools use these implementations to setup information related to the
+ * pre-load signatures
+ */
+static struct image_sig_info *host_info;
+
+#define log_info(fmt, args...)	printf(fmt, ##args)
+#define log_err(fmt, args...)	printf(fmt, ##args)
+
+void image_pre_load_sig_set_info(struct image_sig_info *info)
+{
+	host_info = info;
+}
+
+/*
+ * This function sets a pointer to information for the signature check.
+ * It expects that host_info has been initially provision by the host
+ * application.
+ *
+ * return:
+ * < 0 => an error has occurred
+ *   0 => OK
+ */
+static int image_pre_load_sig_setup(struct image_sig_info *info)
+{
+	if (!info) {
+		log_err("ERROR: info is NULL\n");
+		return -EINVAL;
+	}
+
+	if (!host_info) {
+		log_err("ERROR: host_info is NULL\n");
+		log_err("ERROR: Set it with image_pre_load_sig_set_info()\n");
+		return -EINVAL;
+	}
+
+	memcpy(info, host_info, sizeof(struct image_sig_info));
+
+	return 0;
+}
+#else
 /*
  * This function gathers information about the signature check
  * that could be done before launching the image.
@@ -106,6 +158,7 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
  out:
 	return ret;
 }
+#endif /* !USE_HOSTCC */
 
 static int image_pre_load_sig_get_magic(ulong addr, u32 *magic)
 {
-- 
2.43.0


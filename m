Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29EACD5BD1
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 08:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EDF88489D;
	Thu, 28 May 2026 10:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="PvsxhCDm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A225680087; Thu, 28 May 2026 10:19:30 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F92284825
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvZNEvIOPZTB6vilYe2VGR3LYjl5sSOd+0o/Rjvht/n7yx1aw+7yAatAC8/wFuhtx9IAAsHgUejk2hHGthI709NgsYZIQm/w1DEUfuTCGyIHmicGCGeQQI2fhlD2FmGbAK/LPu1b17oFDTJA04k0QTOv1X4XAjkcnDhlx9dVSJolkGhuaRJl+b0BBVYVvbLGjsTnTWzIWmBccUsPldZTLEOWvQLJ3yFV9NXBjSuJocTDdize2z4eEx/z1wUkaaX9Hschvwl5bnaFhhacpEw+/GtS2e2YaOZGvzP2NXJKnJ16sYTHL00u5qYp0u2eHij/kdm86E0ZIhiSbgOBeJpbDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2CwATjjiKZdvIP/e1IDWkdewLv53RUKfOBl243Z7Xs=;
 b=XvkU/j82xeJAkWPKg0WJChFIare2A70mK9+IOdk6N4CkqQg8aSK//DZB+WRpl2wEfstaRrwxbqr2pQZW59KogMB/A5UQY/80bxYOkJhXishm9TB/k4gO9ykFjKHjNQ7TZUiPEOO5Ud4H+NGf3z52FOVzv6vvpvEmjII95XQAa6FhF5XlqiCpCzw0Y6M2+pF1MQkTkpPcQCvLDlAhCDf8vNw20DDjCqu5MOpv4TLW+BDq1bmylgPX9Fw34a3bCiSaQRZL4K1+NTTZaHpp7XSI3eR9bhzapw0rYvQLhf+iyJcQr9uD+/yiv/x3YSYXuorpVWpTqRH6iOit8KgY0/2ByQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2CwATjjiKZdvIP/e1IDWkdewLv53RUKfOBl243Z7Xs=;
 b=PvsxhCDmKOip4imDl+pSzriSegaQApfP8EbWqkf8XBHObgOqX/a4KVd+j/Pcn5KhGLJIzuFROLUEV0d9bzXywmw38yqbuWN5ZZzmR+w8eawZa8brM/q2bK/LuIv5S+tAvgp3oOPWkdN9ZhVZzR/aG5710erTw3lny4en2KN6vsTunVdAnGrdwF0wC/YiGCU+2gkPCqOfVxC1WbnVNKxGsPHKXar0OePJPqeHYhVqkyZlmaCmm4uK1qXdew5IFBwBgVr8G2mGSVFiyK846n9uJXjf3aw740aRqUVWEsEeqShj3y+sobf2SuU2QWP2HLVWn0ECTdf2bZBNUx8UxMhemA==
Received: from MR1P264CA0011.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:2e::16)
 by PARP264MB4894.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 08:19:20 +0000
Received: from MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e:cafe::d) by MR1P264CA0011.outlook.office365.com
 (2603:10a6:501:2e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 08:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D58.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 08:19:19 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id B4DAB209C3;
 Thu, 28 May 2026 10:19:19 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 13/15] tools: preload_check_sign: add support of ecdsa
Date: Thu, 28 May 2026 10:19:14 +0200
Message-ID: <20260528081916.11355-14-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528081916.11355-1-philippe.reynes@softathome.com>
References: <20260528081916.11355-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D58:EE_|PARP264MB4894:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7f3b5f3e-a77d-47bb-f6ea-08debc91d142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: X/TW41pE9TRZH+FQxJwf5nnox2TPzMAY2/Ye+dVmrkJcISrWinR6FRoVaZaLDp4LfzRYTNl9TwkblO3curyZ5+Un/PMQ2wvkEihu86qNYGl2MWBC5xtVR2YaWN2nJiIDXwhK6DpX5gtdQeld8kjXbByTClKumgoApT76YfN4YMCab7G8eOcJOVZPjtYDFYkFCcmrMh/R+HRNKWw0KteDiui/+1bKr5g9sBo4FXQLEa7GiLEJsW/D6ygYaB3zivXldlQcEBdU6HdPa8Z3NPFhpod4zKeLJY5qJMxQk4szmkQxPn2Ah0oVOkWPxM80OSgMQ2/PqvN8I/Bbc5+pVVSTw14yC8Th6Qme+4AYMl8aIwRCXBB1V7MFO4anTpfdL3c4azvuJarLGVCHkjOtqDHdbJOdIGw0QLx1fvCCuYrear2nEkl6BwCmUNJPDnmai72tJXl0WnJoHRY+Ts0t72rghPIl5eJKGdLvVCpYsQH/k5iQ3uVHZinSo29dFKLhJGJ4JgzfeTqOpj1rliRmbQyRPvmflw5vt5CDNy45DkTdMDJ+QC0qLmMm2pOCV/IsJkGimvbTGT1qfgctF/Yts1giXzQL1BFo5qwfaNEqXET0LvtF/6a9ornOHPqXhnwHr1Iw1wosKlZRheDN1K7BVFmXACjKm3ArkFtLA3ZpyDz63Gz01OT4tqPoclge+TJ3lVD3yYFyO5hz/4VnGEqIxOC6iJYCcG3jS9yJCFc5dAxpmpQ=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(22082099003)(18002099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: APLzdZ2Jm/R0Ot0Smk3thpG4dMuNjuztNRof7nQODbzWkwD7nu0C93a/wvssCM5rQ80ua8jioqClKBY7vRL13zSdcxMDE7xYOLz85BWMHU0JeGMHEYqPS/vQlmOUnyJMLOsFCEExUpHSdCGH8elRtK6w1EHXXrfNJdz7tN78RkKQJwzD/oM+p0lSpfn10Fv0sy3Vsl0+sMqm+sa32/Ye5+DrsJIzaTzjziF1001C/zAKI4YdgQl1WtAhpEpO0lL6pP6j3UI1Uj297wktmOQCCidczNDE19KZVk208Wm/Oao1WDozcOheShX28JUXtNPugQXmVf8lItTfhYZdJHl/WQoWuQUvZ4q6rIPHQIyXAGRrSx6beiwuRglU1cerotkuIDI1WOROd1GDvXb5lxAoT5hw8W0JQw4Y7gVbNjhZ4gI2pcodKagUalr5suNUXY/+
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:19:19.9613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3b5f3e-a77d-47bb-f6ea-08debc91d142
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB4894
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

right now, the tool preload_check_sign may only
checks an image with a pre-load header with rsa.
We add the support of pre-load header with ecdsa.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version
v4:
- free key to avoid mem leak
- fix error management (set ret before goto out)
v5:
- add include ec.h, evp.h, err.h and image.h
v6:
- no change
v7:
- no change

 tools/preload_check_sign.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/preload_check_sign.c b/tools/preload_check_sign.c
index ebead459273..d94f0509e74 100644
--- a/tools/preload_check_sign.c
+++ b/tools/preload_check_sign.c
@@ -8,9 +8,13 @@
  * complete file. The tool preload_check_sign allows to verify and authenticate
  * a file starting with a preload header.
  */
+
+#define OPENSSL_API_COMPAT 0x10101000L
+
 #include <stdio.h>
 #include <unistd.h>
 #include <openssl/pem.h>
+#include <openssl/ec.h>
 #include <openssl/evp.h>
 #include <openssl/err.h>
 #include <image.h>
@@ -144,6 +148,32 @@ int main(int argc, char **argv)
 	info.sig_info.key      = info.key;
 	info.sig_info.keylen   = info.key_len;
 
+	/* For ecdsa key, we have to update some values */
+	if (EVP_PKEY_id(pkey) == EVP_PKEY_EC) {
+		EC_KEY *ecdsa_key;
+		const EC_GROUP *group;
+
+		ecdsa_key = EVP_PKEY_get1_EC_KEY(pkey);
+		if (!ecdsa_key) {
+			fprintf(stderr, "Can not extract ECDSA key\n");
+			ret = EXIT_FAILURE;
+			goto out;
+		}
+
+		group = EC_KEY_get0_group(ecdsa_key);
+		if (!group) {
+			fprintf(stderr, "Can not extract ECDSA group\n");
+			EC_KEY_free(ecdsa_key);
+			ret = EXIT_FAILURE;
+			goto out;
+		}
+
+		info.sig_info.keyfile  = keyfile;
+		info.sig_size          = (EC_GROUP_order_bits(group) + 7) / 8 * 2;
+
+		EC_KEY_free(ecdsa_key);
+	}
+
 	/* Check the signature */
 	image_pre_load_sig_set_info(&info);
 	ret = image_pre_load_sig((ulong)buffer);
-- 
2.43.0


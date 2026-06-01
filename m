Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E933FCD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 13:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54A4084975;
	Mon,  1 Jun 2026 15:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="DROrHYWb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 653BA8494B; Mon,  1 Jun 2026 15:43:26 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6061A84971
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtA5lpyDl6HDJASdkiojJIasAfQGx139SMBqjmyW3PhJ5hRsFjxUOLS1KTs+o2mfYb0Af8qsTSY3AO7D5YY8mVX5AaEIGcW7KKsohgOOqAMpF7/RvdT7w68rorIBn84j3YH5CL7mGoV8IHrIoHZKAmDyaLhUJseMB9NA73M70SHdsiFgquMBP5DNdwDzUskgltdkIYvLZzXWIkbIKgE7bBv8EZBSF310mqFxwn3+BrixhirrUY9lAQTGF9h94zSk4jPxCxQHo4nA65U3iQRB9H0SzXHip7MoZELRs+JmYL4Js/vV0ioGUSWOSELcKlzMo7zBz3cdyIAcEmHA42T64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rp8CJ8XykhMRiqn3qozzmNYEfKw0umuikQMlzdfTik=;
 b=nzpVOMNTv7mDo3nAEt4tGlS98ra5cTtgn0CJT0FbRVrizGn+LLv40tcsEqB/MRreNjcaAuXQ5LpcoagBFw7viTP2xVLANwt3f0/lOAvGG88bcVYyPl13QLPWu7NeoqhdvKo0nSu8XzcH8XjwXTzVFjNVEam4nydWnRezCM+WRBvurbITOjAu14B10XJ1y+1ElcNI5sCoECxr2osLE2Ez0NtJb+kFpQj2Vr30CKW9VXFoDF5yViomdKuztdiPKuQKWLg8TU922QbW1mhXXq5g/WXfvAqBcJOrTiEFLQhX4jAjHTOMBehPcZXvwj83cSgVEECKpZGbpv8wn1c59PZsXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rp8CJ8XykhMRiqn3qozzmNYEfKw0umuikQMlzdfTik=;
 b=DROrHYWb31KOkPYq/rk3a1nmgKtveHnjybF7DOe+nCU9xmJC18OXP4ZMUSLcBIjTVRo7Die3SgIPXr3qJAZLy1PCtBnj/Qb0hQOhhcYCh+EUnBxHFGYL3Hugxy8Afvg1q4DLB/wl5zzZNU/nSAVpoNYnD442Qeuv0/XqPXjBhXgxzsZYWqOMZ3WOFC+qAKGsvFcVmmjQLbUIz2V8jsxJ5+MdcEFB6FU16dRmby8vy38FKNSMrqNXFyv5ODJgv00r5gyKNEst6i8mdurJnM0/6YD0TlrpAFN+g1CkzaEjpi0/4DF08+uQZy1cfXdHu3DK8hc2C1n4AXGTFn6+9LEyKQ==
Received: from PAZP264CA0124.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1ef::21)
 by PARP264MB5978.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:4a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 13:43:16 +0000
Received: from PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1ef:cafe::86) by PAZP264CA0124.outlook.office365.com
 (2603:10a6:102:1ef::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 13:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FB.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Mon, 1 Jun 2026 13:43:16 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.66.192])
 by proxy.softathome.com (Postfix) with ESMTPSA id 987C821472;
 Mon,  1 Jun 2026 15:43:15 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v8 13/15] tools: preload_check_sign: add support of ecdsa
Date: Mon,  1 Jun 2026 15:43:08 +0200
Message-ID: <20260601134310.2452454-14-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601134310.2452454-1-philippe.reynes@softathome.com>
References: <20260601134310.2452454-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FB:EE_|PARP264MB5978:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 60df7b0f-791c-43e4-c6db-08debfe3bbee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wCGFtVNtCLfMt2b218tOWZCntuHq/TzsLxAsAkgKKssV5iNAgu+8TE6VriETuYYfACoqQ59b4dEwluagAEhdHtJntC5gM8oFtg5YjuV8xViIvcVkeDPLCCIejmxqfbNGUCXYznybiq7wMvRtpTwvURC6mkGtO74eieXLn2letY1bX5WSJcbSsaIx0HaqrHqZD8T7qEL5Epe4OrJ6UYWOuPaaKgJpR4xT8hDKVPSEB1SZR6ORpVNcsoxMMKROOlOLo9Ukjl7cxDuXJnqXZ3oBMAnBlFtq6cWZurRR+dWwsxnB+abEtEIT6gxoWV9L8g/lTkD0Tv3a7XCtJXQ3mhHRMn4kRBV3jIsOJ0g4p77hbT1T4coKt9SdeXAELIRHoA60vP/FOJWLyC0l/s2k+3ycYWyBtNMXiVhH2mDnWHBpXSVWsU5scjbAbO82xqiz3MiIMjgY4GuXSCb7oSI9lCJzHmE8j7f6z8ElXT7KIKgA7LCoHEKvSv/X0e1ibqQI28l4Cf0kDnMLB54XCeRNg+uRMV9LKtoJT7/V0sCZjcjexscQZ3zJrf+rcrdZhDntrjok+FlOVbvMjXFQSkis2FjFdUJnN5E70+TJMyqFi8N1v+a+11XvmIjuk0FsePhhQlWpuaNCP/jh6hlDg48fmxS0NfE3v05HY+yyc+uMT2elyZmYO/p6lpEHNGhEIcuSCowqC/vjmkRt8KaDy0Ni283alwLjJCt0szCndNLc56qXhmg=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TfdOc/nxA1sTgfsZlVoprPJgHXiLluG1jT2LpsRQ5tKFU1QAplrETK5vOcjOI5QGJU09UoKzFfbVO3WDd67V+m+29ZLRI6fQRFIhVJvzOC2yhg7kkc+wgWFxY8tFIQvTlJshbHgMiuhoh+ktE/R7bfnznJeCFzmIZGlH+3qbxJYenf5p+rDShHoL4OzoSiQc5V9ag9q2aM9krfIxWtv3NL4BnE98Bxrt4pA7ezh95+u66+qasElF5GZNL3oz/VZ7a9z8AUtcwr6i+7S0wSJvsL8UmEpIjI3TkkQ0KBpyGD6vjagWe+UvyddJrJCg+7B0vUEARIRJmMpvpuEJzhyrNSKeOiq7uWu6o3qL5cd4MnGpDq2ni+ldDV7UApuE32/Bi20hdtU2aJwH/W/Q4TTpgK/cxBkbDtBHbO7qiqnLAH/9fDv1mD1TbcaGKAvvMhbk
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:43:16.4103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60df7b0f-791c-43e4-c6db-08debfe3bbee
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB5978
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
v8:
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


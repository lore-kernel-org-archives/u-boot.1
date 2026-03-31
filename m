Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5576FF60FF
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 10:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C983584129;
	Tue, 31 Mar 2026 12:01:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="nuOy30ce";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90C9584068; Tue, 31 Mar 2026 12:01:05 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC85B8407E
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 12:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8jMWWXdg4W1jEXgXHfyE/fBDCVShJVm1MaXXaUjC6xMMBpiKCdMGq/HNsFK5qI5EB6l/tQqeaAj9gB3fXotARX9BHoFerXnW4hIk/TnmVgJ0OO1ioMVejvmEjPqm3D22iljEX+frsuqsjQPkAA898Qfw2LjGbJEm8hT5Z0zvLN2MqO4dy+M5dBtsGS4W2n+SbPRBnypjikz2Td+HZi1COQOjmchGvoHeXxN0TPWv9JpIUcFZcJAaoWJEXyJp0R6N+xR4GlLy0RXNxFzSt4dPmCA1QaPbKiYHpQf4ZlNNKq142wXRPn7WNYTrE9rUbZ4EGkVKYSN/fby9Jbx+HhNxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70B44O2nNvyII3S9vkd/sgvBdlqzIRtqQnQHdHJh/9M=;
 b=thKduPFlH4e/9odM2VUJN5m/7HwpN6pR3zBzZSPTcsiOwQt4LHYoLlmNFpz3RpML5H0Cgq4nLAQzxR09/nP/GDlIIfcUmdLsj0q1OFzZRYWZtZGSew8aFtbA1fnRIwZhqlgVzbC+R7P85+nXZNxHcdzXf1CeS6FhehIZ75J+6hBpz8c4WTXvXhYpYM2iP+aibBnIwvu28lgux7L8deY88EwhOQ59cK3Gxqxave4cMWoCruDdJ+FcgOWBuUAbX8WRTh+q+c0SCNyZz2JM74nBPM24pn9R6HvhH8AjMsEvaiqbd9evnkdu1ZZ3+9bCswNVl1uwdmeCygp37EG59iBBEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70B44O2nNvyII3S9vkd/sgvBdlqzIRtqQnQHdHJh/9M=;
 b=nuOy30cexD4d0DfkEussqlgZCa87gH9ErlhdHMVR9FfyiWlma6BX0iJWyGBnZqFj6aCEZh+TbIPWV3BLWPavokgLRWZxqvOjLdy6RlCwtPXysHi/2waBm/9ESyYJJtEd00MDAWXYNKrlOs3HK8PdwnXH2NRL9Aub4iOTucHdDhPHM2QQ58ayAhwVLqu3RVE9y7X2LEbx8Lq4Xnzaj/ZSmBdyR4TaPzJLEqXGhWmw1OtXFiBqbSrKPfyb/wNNM4CgMiiAk5n+o7nQhcwPzAzKjZF/8/PKYgfRyQCFQLYmqe57WtFi5pYyxaQ4NZOptKMOio66ZlxtmrDXUBuC35zMVw==
Received: from PR1P264CA0003.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19e::8)
 by PR0P264MB3030.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 10:00:53 +0000
Received: from PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e:cafe::e7) by PR1P264CA0003.outlook.office365.com
 (2603:10a6:102:19e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 10:00:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019233.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Tue, 31 Mar 2026 10:00:53 +0000
Received: from sah1lpt726.home (unknown [192.168.72.39])
 by proxy.softathome.com (Postfix) with ESMTPSA id 6A81320C30;
 Tue, 31 Mar 2026 12:00:53 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v3 13/15] tools: preload_check_sign: add support of ecdsa
Date: Tue, 31 Mar 2026 12:00:45 +0200
Message-ID: <20260331100047.34618-14-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331100047.34618-1-philippe.reynes@softathome.com>
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019233:EE_|PR0P264MB3030:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0b01fd74-b273-4b9d-3f80-08de8f0c655a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: O3k3QJ7SVlk2b8zEg/Y2MC7F8bhddUwYNRzcpnFPcyyouH3YdDZsumvRJh/Ua4bP2p1IWWY3FKeNZgzjeOoa+7TaR5y4m4PQ+OG63KruLAhCWbuEH4R5UZORfcu59ue5xln0BEF1/iVUH2Vidh86y/2kqP9XoxuiEmeJ5MUeIlE1lmsrjDWtFEKQcGw3ERYYGFz6U5O/++z92bGBZBmDPB+jUZEyCOeSVkvTvG9OBL1ZhuJksLQXdT5uCOyhHBToj50+GrzDdu+I+HXc/S2DZHfU/1yAEQMUTmNeu61gvAt2TxwBJk+VC3UyQMP5Jkg2bKbgSpOoaQFO+kEbMRHovXgEChPYS5sEj8f7sprNueQBTtlPwyr/R+9WIV5eI7WJgrE0Zwqbd7d7VSzibra0BjvTCHb6ezm7xUZG3AlfjPEvNWUFGP527nXtI9Ww9GwEiDKHvYbXKPxDzRbVbgY2VaEb+2UEhqFLd+rRi+bHOaoa0PGQmbRS1HLiVEpxpI386qWD/CeAeK5YNqo8yHQ2qvC5J8myjq34+zZ8WF7wkBI1QCMGyMukH8V3IwMkzMSybvLUzD+z8e9M4Ep38LEyInpdTx26JORhfQ6QimnU8cBLXJSVFTCl10XafUYCCxQ58p40hDKoBWYtCHVIX1Ugn8OQpwbsd3hmflT1kdvJFuxDP0wDS7Txl73uhHJFjt2PnFHpq6YFpQsAPoWnxGzivpQuO8bnPvnPAsdh0P9frufPryUiusi7Wx6XrfzGf21AT8QyZmetKn9m5Pg9l3Eeeg==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TzDgImVYG46qlPTALlBu9C1RK6qFekyPL6sMKJ74YgAxMmv+xU/dN1+t7zbSdjOnxxNfs49qqBi1lQ4NP1H+QaQy1+Rq8z0+kWd6VwNeBTKHMvCSZL7nGYbHnxkZo3E9O5K4IGO9aPIJhwdpr/9ISBFZJ4SksXY4HnZdnMfwYfcMgvdbuXWmH90H/+eQPn//BEF+BgnYmWicg102mJYRs0yXzXTXYLKeOAAj+rNFWNayeJuaQqmNkJcKWlM5R6o5jJ5tJEqaBQ9brWd+qikUry6c5/5PQnwejQPwPi3YQROg80bPXe7biraeFDZTLRlFj9OgzR/n2L0Q/FndD26kNEMbrunGVDQR9FzY9FACGCaU/bOnzGuTs7m8QdclyX145UMrhZRojLD9dWBE8AZxNKokKPb9BRec9vISClgdOISpHEPQtSQ/WJ+8G1QLcNQo
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:00:53.5488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b01fd74-b273-4b9d-3f80-08de8f0c655a
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3030
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

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version

 tools/preload_check_sign.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/preload_check_sign.c b/tools/preload_check_sign.c
index ebead459273..6601072be77 100644
--- a/tools/preload_check_sign.c
+++ b/tools/preload_check_sign.c
@@ -8,6 +8,9 @@
  * complete file. The tool preload_check_sign allows to verify and authenticate
  * a file starting with a preload header.
  */
+
+#define OPENSSL_API_COMPAT 0x10101000L
+
 #include <stdio.h>
 #include <unistd.h>
 #include <openssl/pem.h>
@@ -144,6 +147,27 @@ int main(int argc, char **argv)
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
+			goto out;
+		}
+
+		group = EC_KEY_get0_group(ecdsa_key);
+		if (!group) {
+			fprintf(stderr, "Can not extract ECDSA group\n");
+			goto out;
+		}
+
+		info.sig_info.keyfile  = keyfile;
+		info.sig_size          = (EC_GROUP_order_bits(group) + 7) / 8 * 2;
+	}
+
 	/* Check the signature */
 	image_pre_load_sig_set_info(&info);
 	ret = image_pre_load_sig((ulong)buffer);
-- 
2.43.0


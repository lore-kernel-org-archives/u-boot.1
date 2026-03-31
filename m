Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B0DFF60FF
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 10:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E3488413A;
	Tue, 31 Mar 2026 12:01:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="reC21V/w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9874883F5B; Tue, 31 Mar 2026 12:01:06 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC84E84056
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 12:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1o4Z9+NalH8RIwaPfq/WGt0WdHOGxYAzgK6BbqCPPliLRzSpxT9rlAixSMEML8RlXR8+6KZ7BXicCyauD9KsVOGUXHybNr40fF+JrzuI2MFDtV7kson1raXBaDTYDSF7RdpKhSugAbft/o34XUxGyeU4cg8PmjloOe87WC4dKWDebcUZjey/G/m3qnD+1NcFBsT6tjoGdDP54Dqq9XtsYrRyIILsL9xXShxscxqiI1rVC16ixuTS8P+mpGOOQGD1mrhfhfpZR16uSrUm+fXyN7Vroxt/CXtZ6q9zH/aknbUsT4tuuNcrIf0F674Z4VSZ8wImBeb39iXnK4Ghr0t9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ygi0FvturcMHWK5eYmQOLVq4+wpaAwakRYNZSzM3gQ=;
 b=po5MKHbpvOHdz4sabOjGpTVLgAHY+QIHRCquYopDsa7WJQ5yGLBkG+XnW21vmiQvDKQOu/4IMhOFHTC+uQjeo9+N2uM7bhRY3eG/xGKUhXRpHDRC58xHdNjqL4q+5Q/oLpdHCBqwHq2ZzhNnC5cWRboXOrmy5gAOOizW8fMvj6/Urr+Izpqwacp6nPBBErVmBVxMkW2J8I3W/KIy1HvXr6gIYTDythCTYWBel5Vt2tbDaZUnYbOrj5tZezy+khMVDFTmqbwSNH0yPDt+/mGbqrsCHN4uaO3mZcSsIgumwn9G+FCDX719ePEI+CHwvsgiJJknumniXyu+3mR8N0Ex1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ygi0FvturcMHWK5eYmQOLVq4+wpaAwakRYNZSzM3gQ=;
 b=reC21V/wbRjWi6QhRNmFwnREKy+Hs/qlgNSvxvcYQCCAeDh+mf+abzKqUjz0qH0GfL5iui3QdABjc9TMWwVE20mapB1xX3z/wy6a4HIQ2y/LC7DOFYvpj/f9XEEoFiL1a8CcE9kO9VfnW5huO5+heQp+ei+PI2DfdIDo9cTTKpmC255zw1eIxrwrS8KuEiyzFqRX4OHR3dzaetWnBgruzU/M/pwrtDwEBEsUjieQfxREuJm6hKOwE2V6w03UBdBX7QNrf8GnQ2liNu1DWFPUL2oBoxvQyly2Jm5x+fcurkiBRJ/GDEIzrehSoyVVUHG3qvj70ujVZT8QEWiFQzPnOg==
Received: from GV0P278CA0033.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:28::20)
 by MRYP264MB6622.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 10:00:53 +0000
Received: from PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:710:28:cafe::ee) by GV0P278CA0033.outlook.office365.com
 (2603:10a6:710:28::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 10:00:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3F9.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Tue, 31 Mar 2026 10:00:53 +0000
Received: from sah1lpt726.home (unknown [192.168.72.39])
 by proxy.softathome.com (Postfix) with ESMTPSA id D576420933;
 Tue, 31 Mar 2026 12:00:52 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v3 06/15] test: dm: ecdsa.c: clean this test as software ecdsa
 is now implemented
Date: Tue, 31 Mar 2026 12:00:38 +0200
Message-ID: <20260331100047.34618-7-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331100047.34618-1-philippe.reynes@softathome.com>
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3F9:EE_|MRYP264MB6622:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ed8a91db-bc6e-4481-b9d7-08de8f0c6516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8+NFYUESy0tVsUOeLEjHDlMSzo5NFuti6tA1R1Nb0OmvIr6JNIUp0ug8wRxV6ugBsZOBBGBqtcwx+iea+2qOMEjiTzxmLgiKx+cB7ZTRukaZ5+J23NIEogJViBscyD4mwoxUcxbh43bqfPtchjro4HiphOw9HJCYJHfYcPPwXGD8AQFZ0SRwtNrFweZDiLafFopDL84anz+fs82i3BbZ33OgYPMy+reUgMctUDvr1wNR38c248eBKgLXHNVIYBrECIqkmjoQlrPD1uEFHKWhUMS2elR75tNsELsLrKj4+9alFat73r8a1l6Yddd2lhNH0HHgvQt2gBRRpcNJ1XCEiVdKFp8o/w1SyzmH/bUNlwTEBSyCyj5zVuGOaueTYYB7gH3oUujFdtk5dHowWGIt86mOjdEhobkfSJTaoX0fkzVr4LUqJ+2gQTI7Sa+0WA/1+88hVC5COcq/FmovWClU1HT/TqIvcqxgoWzeN9dUNoFARg/MR2NOtfYreMq0CEc9mub20HyAN9Zq74o00z8/OMUfB1eXRIIqp+xr6BfpYPqDf3NudEfRJYAruebqqq3qIJo2GjpFyk3fdKvBJKC9SJpXp1NQxqdQzD/z/KVu8VrtKOw+Mk7mRiwQha6QribmWuXHmbFhBdnzfDlt1T8peQLxIEbz+tTuSoHRtZgT+OqEr1IIPEg/BTZd3/QMcNR4Eh4CDJrVzeXo4c9CbXlipMlViwBgSxZtPJU5pj4JUgu1P+pmmm4kWxj2K+kuzsKvR+s0AHn7r1gzVNTC90TRxQ==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SLKCyBWG+/86t1oOUtent6Ug6oL9EInN6zUbA3V08UiR/37TMuHTjaEpiqq5OSXc9XZRXZsVjnYYMuaXLGHIY1fxOiR6XQidheAO3qfNBwo6i7BQrK2UaC2IwV/c+LQ7OpK23pQ4KH3399HKaVIyZuYCP0frxUI94g7fIS2bgGim/S6u+ko7tVNvtHquDW0ucxCfpPY9kdEOdmHYgu7vnYdg60A6oDBtBDyranUQKxOTjX3fEwI4+KLLo48VUPYRf0bnQBf8hTrgHnGgYlnuvIAQ9r2naLwJAhcIZ+ZKzQMBP+lhiGtqKX4DR7rmswQUP7/NKMoo67ttia5Iz+eAsA6PlC6AuKXxeWBlMGx26nMrL4aH1R+Gec/xbG/RBJv8zjqBc7LbsKdiAQ9xMwdEyAL5R039Fy12JTD0NvoDxY0T0T/JOvFqYnhnQggm2dfB
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:00:53.1065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8a91db-bc6e-4481-b9d7-08de8f0c6516
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRYP264MB6622
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

The test ecdsa was done when ecdsa was only supported by hardware.
So it wasn't possible to test ecdsa on sandbox, and there is a test
to check that ecdsa is not supported on sandbox.
Now, there is a software implementation of ecdsa. So we remove
this outdated test.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- initial version
v3:
- no change

 test/dm/ecdsa.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
index d7eac7115f7..074b4b25576 100644
--- a/test/dm/ecdsa.c
+++ b/test/dm/ecdsa.c
@@ -9,29 +9,15 @@
 /*
  * Basic test of the ECDSA uclass and ecdsa_verify()
  *
- * ECDSA implementations in u-boot are hardware-dependent. Until we have a
- * software implementation that can be compiled into the sandbox, all we can
- * test is the uclass support.
- *
- * The uclass_get() test is redundant since ecdsa_verify() would also fail. We
- * run both functions in order to isolate the cause more clearly. i.e. is
- * ecdsa_verify() failing because the UCLASS is absent/broken?
+ * ECDSA software implementation is tested in another test,
+ * so we only check that the class UCLASS_ECDSA may be reached.
  */
 static int dm_test_ecdsa_verify(struct unit_test_state *uts)
 {
 	struct uclass *ucp;
 
-	struct checksum_algo algo = {
-		.checksum_len = 256,
-	};
-
-	struct image_sign_info info = {
-		.checksum = &algo,
-	};
-
 	ut_assertok(uclass_get(UCLASS_ECDSA, &ucp));
 	ut_assertnonnull(ucp);
-	ut_asserteq(-ENODEV, ecdsa_verify(&info, NULL, 0, NULL, 0));
 
 	return 0;
 }
-- 
2.43.0


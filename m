Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8ECAF94CB0
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 21:11:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43C9784366;
	Tue, 21 Apr 2026 23:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="EXZ5qXZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E242839D5; Tue, 21 Apr 2026 23:10:19 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D07E98429E
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 23:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWUELoyRVTvOjn6046+rkAF/od/qk8YBLDHECkK5AFqRM46uhUN2eWuNMJgf5O8gBkOQAc1SVDj4ddJILCvLxbUIXI6cYU+QufisRneppV9jkhJqRoW0cJKdsLT5RC3GBZdSpx/ZCYDXz3OeTj0eM8yNrXj4OIe3j1gV/7kVmR7Uiu/v3HGRhJuloGzDVMZqgaZEozLrDUYOLegkdeOAYAyTs5XwUDiOo2pbN5RcffA3A96CCAJOpNUilQ3zu4PEL/NuQqhCdqAg1sxkyIBGvJGUplbv8MIwoEfDJz3U8XaFtPVJqfuAuFoBRdYFKkVve6aec+5F9wQlRjityx7orA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxQjTm9TohyVkMDfkVgQzYNnyWmqmfMYEnoQXCk0vwQ=;
 b=J+/roPlNuE/OnzpuXQB4awJx9BF1hzKkKcBCoD1PqAF1ZLd1DFBdKshIXRKSTKHN0oCCm6tCTnE5YCQxEQ3Ha7frW5Lco1jghv4vx6DEwDpcOUIzlLGx93nq1QcFQwhwqd0S1tU/eCJU7oz0GSlOB+PExY7307rEyxohyPtn6NT/BkGasISEFQW4n2T3sZZG0JjddiKUZ8+J4vRA73dr/hrUi52WAify+zDGOJ6oLB5m1xNxAwIXmng7F5RfwWJP1BfWsDBgfo78ZuiVFSko6g3p+VaW9pgUffO4/kJjKtUB1j9oegaTvti0sKA3eNIz0iEoLiZ3PBaR5QWqkYU8GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxQjTm9TohyVkMDfkVgQzYNnyWmqmfMYEnoQXCk0vwQ=;
 b=EXZ5qXZT7HEtRxtHvnFwz0E56O9Za2YJ3LI7Y5Ra/UrcYrJY9kIMzFwKzCcaC9UFPKkwfMmld9ldbkbeLdij8rUq9XHIlEu3JUD7BEaK5G4lI0qz/m/lK7JO3AaCYfcko90m5kwzzrDLkpFLeX5gXKsYd8Sd1SkTtMrUI2uKOj2XlEWFUlO27aQTBGtp3g4EURMGehkKfSSWgGEbZYKV1+doD7OUPLDa42yksb91g/joSimT80hm4aDLq1Rt3WQSF/S9SrIff15aewyM7AJ6HkYAbXoDVtKqVgwgmg7QIOoqI6JByUvSnUxVjcZdelVHavEy0wl7fqWr1h8lK8rVLg==
Received: from PA7P264CA0038.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34b::14)
 by PAZP264MB2447.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 21:09:57 +0000
Received: from PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b:cafe::43) by PA7P264CA0038.outlook.office365.com
 (2603:10a6:102:34b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 21:09:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089BA.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Tue, 21 Apr 2026 21:09:57 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 541E920EC2;
 Tue, 21 Apr 2026 23:09:57 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v5 06/15] test: dm: ecdsa.c: clean this test as software ecdsa
 is now implemented
Date: Tue, 21 Apr 2026 23:09:45 +0200
Message-ID: <20260421210954.1170437-7-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421210954.1170437-1-philippe.reynes@softathome.com>
References: <20260421210954.1170437-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BA:EE_|PAZP264MB2447:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0a208658-3a65-48d9-79ec-08de9fea57b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: g0h9aWGZwqaPGMGTnFrhwryd8FkuMYgPizKN0Uby8m4Rz/cDCG13+I+yFTo8rG9Wiwol01U5h7RuFbsAAhzrHUXNLTgOWu8vKyZMcg0zJtPaCnoNVLijB97VVPKcUgPZclQWxnpsqThNuV8MT0tArkkRppFmautBb8NMh5YLOn56cYUdY/J4T40VP577BK/DM66iRBpmKT8UAeyCYLaRF9KF7YweT6b793IeGXfZ44TqG3K519ZawvwHjDz/lTvRaPBtDh6Rgrw/jE+HOkfi4No/LHP5ZSviE60Dlse8NEvecTYsV7R0G3LjW0PxCKYGEum7vYMjJ8iEc9diJGHIy4Q/RWZU3rhyUwsNYwfgPgtY3+AXWPXWXGvBvuLPeB6EKNH6H/lfl3YTjorAlC2NkL0nK17HQleLhDMftJTUuD+r+UI50OoBfiXwr7qiYF30yEdN9FM49/MKQG8Bi8kZIEQldnkdFe/AGL1uvH8gAOsKVjR9YjW4fJn/c65p/G+O2MHXigJDaixbsI87lAa6xq8fFQiZauiOsolz81HDEKSf7QSB//fAOsMLqgzhkhoJTt58xluIyinDd7v4PUgBUv3jEaDqJdN+RyhMf5bN1OKg/YLSvfVAbNSvb9opDioBUwhSfvmkdyVRf6iQ8W9d/xqrrrWuAhMRWfQxFXTO1GntfTCKXDMC3USv1Nr7Cx7ISDFnwQ2q+9Mh7FQ3n9UI8hZdsy0Gcm8Z0prkZ0k2343hHleRdbsfwKWb3dUEIRUHAlQLS8lK2RfUoygo3+/g5A==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dWzoAR4d0BT0kyLgjVbJ1VFl9ehNvQNV7IknFUVITQQS8Xioxh1YBib/N3kkJKNK1QBTePLILl5+67X1OgGXXrcS1gWZC5npMezsE6dtqdeNRIjOB8HvrF9TTWViI/3DOqGi3QyYSGHaeWPa0RKZdjoq/SHNHywy+vSc4DQStNBs/+fyMJ+NP57WH69uF+K+TqpIseZVqG9xo8Usdrch4rD9QGcjKc+weEuDUJihQvvvEUqgHe+3Ep06Q/GIxiXKu+FdHx0VL2L/eTQazKMl+OCLkDhzXxPM/eKhzQ5+38j/jGXdJCTwx7pOF4MyqatNbTShA1+ruYRT0l8sBGUDW37AzjY7MQGl0xVQbZKzcCc042928uTXxbbKBnsG8KpLIMkIfDpEKBKX7SQCNsE4VqaDdaGxYoPWcdJZyQPYDA5LJMdEYns0KJ3nIhrZP6cw
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 21:09:57.5848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a208658-3a65-48d9-79ec-08de9fea57b6
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2447
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
v4:
- add a test that use ecdsa_verify
v5:
- change secp256r1 to ecdsa256
- check that checksum and crypto are not null

 test/dm/ecdsa.c | 107 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 97 insertions(+), 10 deletions(-)

diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
index d7eac7115f7..1e9d5148400 100644
--- a/test/dm/ecdsa.c
+++ b/test/dm/ecdsa.c
@@ -3,36 +3,123 @@
 #include <crypto/ecdsa-uclass.h>
 #include <dm.h>
 #include <dm/test.h>
+#include <malloc.h>
 #include <test/ut.h>
 #include <u-boot/ecdsa.h>
 
+#define CHECK(op) ({							\
+		int err = op;						\
+		if (err < 0) {						\
+			printf("%s: %s: %s\n", __func__, #op,		\
+			       fdt_strerror(err));			\
+			return err;					\
+		}							\
+									\
+		err;							\
+	})
+
+static int set_fdt_ecdsa_point(char *fdt, char *name, const char *data, size_t len)
+{
+	char *value = NULL;
+	int ret = 0;
+
+	if (!fdt || !name || !data) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	value = malloc(len / 2);
+	if (!value) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = hex2bin(value, data, len / 2);
+	if (ret)
+		goto out;
+
+	ret = fdt_property(fdt, name, value, len / 2);
+	if (ret)
+		goto out;
+
+ out:
+	free(value);
+	return ret;
+}
+
+static int create_fdt_with_ecdsa_key(char *fdt, size_t size,
+				     const char *name, const char *curve,
+				     const char *x, const char *y)
+{
+	CHECK(fdt_create(fdt, size));
+	CHECK(fdt_finish_reservemap(fdt));
+	CHECK(fdt_begin_node(fdt, ""));
+	CHECK(fdt_begin_node(fdt, "signature"));
+	CHECK(fdt_begin_node(fdt, name));
+	CHECK(fdt_property_string(fdt, "algo", "sha256,ecdsa256"));
+	CHECK(set_fdt_ecdsa_point(fdt, "ecdsa,y-point", y, strlen(y)));
+	CHECK(set_fdt_ecdsa_point(fdt, "ecdsa,x-point", x, strlen(x)));
+	CHECK(fdt_property_string(fdt, "ecdsa,curve", curve));
+	CHECK(fdt_property_string(fdt, "key-name-hint", name));
+	CHECK(fdt_end_node(fdt)); /* name */
+	CHECK(fdt_end_node(fdt)); /* "signature" */
+	CHECK(fdt_end_node(fdt)); /* "" */
+	CHECK(fdt_finish(fdt));
+	CHECK(fdt_pack(fdt));
+
+	return 0;
+}
+
 /*
  * Basic test of the ECDSA uclass and ecdsa_verify()
  *
- * ECDSA implementations in u-boot are hardware-dependent. Until we have a
- * software implementation that can be compiled into the sandbox, all we can
- * test is the uclass support.
+ * ECDSA software implementation is tested in another test,
+ * so we only check that the class UCLASS_ECDSA may be used.
  *
- * The uclass_get() test is redundant since ecdsa_verify() would also fail. We
- * run both functions in order to isolate the cause more clearly. i.e. is
- * ecdsa_verify() failing because the UCLASS is absent/broken?
+ * The data used in this test come from RFC6979
  */
 static int dm_test_ecdsa_verify(struct unit_test_state *uts)
 {
 	struct uclass *ucp;
+	const char *full_name = "sha256,ecdsa256";
+	const char *name = "key-ecdsa-256";
+	const char *curve = "prime256v1";
+	const char *x = "60FED4BA255A9D31C961EB74C6356D68C049B8923B61FA6CE669622E60F29FB6";
+	const char *y = "7903FE1008B8BC99A41AE9E95628BC64F2F1B20C2D7E9F5177A3C294D4462299";
+	const char *r = "EFD48B2AACB6A8FD1140DD9CD45E81D69D2C877B56AAF991C34D0EA84EAF3716";
+	const char *s = "F7CB1C942D657C41D436C7A1B6E29F65F3E900DBB9AFF4064DC4AB2F843ACDA8";
+	uint8_t sig[64];
+	size_t fdt_size = 512;
+	char fdt[512];
 
-	struct checksum_algo algo = {
-		.checksum_len = 256,
+	struct image_region region[] = {
+		{
+			.data = "sample",
+			.size = strlen("sample"),
+		},
 	};
 
 	struct image_sign_info info = {
-		.checksum = &algo,
+		.checksum = image_get_checksum_algo(full_name),
+		.crypto = image_get_crypto_algo(full_name),
+		.fdt_blob = fdt,
 	};
 
+	ut_assertnonnull(info.checksum);
+	ut_assertnonnull(info.crypto);
+
+	/* create a fdt with the public key */
+	ut_asserteq(0, create_fdt_with_ecdsa_key(fdt, fdt_size, name, curve, x, y));
+
+	/* prepare the signature */
+	ut_asserteq(0, hex2bin(sig +  0, r, strlen(r) / 2));
+	ut_asserteq(0, hex2bin(sig + 32, s, strlen(s) / 2));
+
 	ut_assertok(uclass_get(UCLASS_ECDSA, &ucp));
 	ut_assertnonnull(ucp);
-	ut_asserteq(-ENODEV, ecdsa_verify(&info, NULL, 0, NULL, 0));
+	ut_asserteq(0, ecdsa_verify(&info, region, 1, sig, sizeof(sig)));
 
 	return 0;
 }
+
 DM_TEST(dm_test_ecdsa_verify, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.43.0


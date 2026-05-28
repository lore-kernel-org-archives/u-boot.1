Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0267ACD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 08:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE7018488B;
	Thu, 28 May 2026 10:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="GyGXFiyv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8028A80087; Thu, 28 May 2026 10:19:30 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A985E84702
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XS0dglPC/2bgRlGp8s2fOCUIHdtZTQgv4HojY6rLIFqD3jnJeyQnDWQJc0T8hyoTnC2aeV3LZVqsXZKsXV+e1BKoJ8wdBbXQ441sZWBdlNIaQgxg9lPPyxxmKmU+1VPoPQGM5we5RNiLwB1PVGjpuKshLDeIeApVDZQuL0RbdUXjIcYdb/4fXpTQxg+a7fFumJbjsuFwOz2n6lRPXgHrj9veu7UvygMXxrXza3DzpjWO3mQnbVXmPmTSN9e0wpB7rf6sa5yUSlFYH9uv4ERcRYA2gH+HbfY6dyxStN+V6thSCloh8NQE5oERyMI1yfUQOcwcc7GoACW34tLynJpXjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hXjcKQmKAWh4XaimJiu8dPN85hlIeD1cnuaw7ITPPQ=;
 b=CJnA4lL6snbae2tNcBal0WeJN1UW2mDgfrRXbkxWtDTidUNzc7/uP1dnF6V9G4qiJKJc75d2KqULSNp3BI5BVcVkINS8OxzCwQCoY5VJ5TapESAHJy2Z1dw98y1iWO5/FVC2kF7A0gingtoNSQPAWIXs8Jgt2ooY3q89oZHOut5ZSmDClEasFeezF/fEQOEkKCtQGctuy6mJDepEBLdk/4Dk09RSnUcLqrQ9JQqKt/Zxq9XUr3V49WIFETCeDqML/TnCTw+5vk8D61XgJy7gwTaiw91gjWze/LaGj3hWPHCpGGEtWDWJlcAPrAzxd1xIE6M8lvB7uxE/n9lAXbmPLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hXjcKQmKAWh4XaimJiu8dPN85hlIeD1cnuaw7ITPPQ=;
 b=GyGXFiyvKbnQQ+2287INP/cpY5VT34Ph77UxiGatR/TlBLXWA9n/mEkf/mTrBivSloUtaVcmejb7y5jkVmxH7ZTLfWJt57Zn7j2T9hwUANG7hchjbjQcsxwOz6V4mqjrMUf44rOmJuFa668GSnnQ07Q8msnauyyU4JI9SkdBxbR4qcHbsGreWwEJ/0PTbE9TywNC96mMv8pSH8IUMP6gYHSlQCwgAB1cHJihKCEEIgquNVYEBj31s3rys2ToEDdpAvHujRNXfBqhZ10WWrsNRJZjJb98wQiLQXaSRXfnViJQS1oUApSGQ43z+p3Abd4OFSnbGvbL46MXO3dSZvdvNg==
Received: from MR1P264CA0161.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:55::9) by
 MR1P264MB3332.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:21::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.14; Thu, 28 May 2026 08:19:19 +0000
Received: from MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55:cafe::56) by MR1P264CA0161.outlook.office365.com
 (2603:10a6:501:55::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 08:19:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D59.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 08:19:19 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 09CE720E34;
 Thu, 28 May 2026 10:19:19 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v7 06/15] test: dm: ecdsa.c: clean this test as software ecdsa
 is now implemented
Date: Thu, 28 May 2026 10:19:07 +0200
Message-ID: <20260528081916.11355-7-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528081916.11355-1-philippe.reynes@softathome.com>
References: <20260528081916.11355-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D59:EE_|MR1P264MB3332:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2dc86d43-ea6c-48f7-9a81-08debc91d0e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QEN6UwOyE6BwjbCkCMqukdwInWXth2zOXIYaBz66uAl/OsQ5/M4YPQ+Ph0CY60HNzWHwnAcLaxy+ehmln1l2vKTM4y6ptAicYbXm4A/hGGyM3wF3cePpVjrLvv0C8Yv1S3nocrOo/WgpZkGLZj1xTjWvXSS8kvwphHBw0G/7DhTeVVpxN8Z+LuVz6GxmNK6vfNqMD2BXa1qCizlbh90pdynulT9VKEUbrtp17CdA8UN983bdDiRk+4UW8GPcD/hlKJIaNvKszWfkrgWhtefRwva9djGwPSPonb4qGaBcNvYDWyW0Io2hRim4XLEQx8L/bDSobc6F30ugn66/+/3b1OE7MpsoMOrV7WQgfu8nICWqqWBMHrH3og4+kV+tmzpz+EmeHaAVldU+TYjXXEGXED8oJnfYE7j4zZUTHAXEB+HZ0MWOEfv8V9tqNrwSjCPnMgXvrqj2n/5E5G5x7VVKdye9BXm9HFuMMxbcTPVRCbsylnXjtJj31HGTD/MaD8ehTv77N7dFFw0z9N0IfMwuUwVXDiQiBzpx5M8XEVwnoVglvwrNsOgrqa2nlmzuvdAkPXcs8BKDxVq7Wlt4jupk6VXaGXpkDAxz4CLBzHOnIe4s8cNix5MDS73+Zojl6zUd7ZgWeuwoHLEDjRc6SqGUScU3EBZ51kd+AOasa1LN9IR4VbLFSymcAe1wPXVOggMs6T/12euYrSmbgoTe2gahGHULL01IYzNbQ9YxoIfTlqk=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 369+/NbViLdKii4OYMOrSgfo+IcLohZk9xPnL3124bTJcN6US2Q0fdnblRO55MU6amguWFwigR0loQi2pTKBzeCn9GA3sx6XN8+SioNWJb7eobMseNIVlRPcjnLXU55IoiVxj2OokePC2mKrPwcKdcobBedf30i7Ecn0YNuhHk3b1zdMnkkRyDHbwO2qvwu7VO0r7/XZYfm8nL0vgPOMBwb6JP9wwatb+Fuq49nFC+vaqq19WuO8JYJVEQgcwfOCz4aSSPXqBcLPMSGBICPCAZxoZb/VIJLeBsnf5bZSGUVoAVO5FrvoA9IWsXNITfB6G7DNa3W/rtKeEOe3M2gPwKhA2S775PyPIjeY2m5q0aKb01WLkEJkmiz/yutrglRou9DqT5+jYXBX4KOzAw81Yk/wNk71fIPFgLyLfvRBgna+eQAPWxFk60JwgXOuffzt
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:19:19.3282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc86d43-ea6c-48f7-9a81-08debc91d0e2
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3332
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
Now, there is a software implementation of ecdsa. So we add a test
to verify that ecdsa_verify may be used on sandbox.

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
v6:
- update commit message
- remove fdt_strerror in macro CHECK
- return ENOMEM when malloc fails
- add a define FDT_MAX_SIZE to avoid hardcoded value
v7:
- change uint8_t to u8
- set required_keynode to -1

 test/dm/ecdsa.c | 109 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 99 insertions(+), 10 deletions(-)

diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
index d7eac7115f7..df41a4f7c9f 100644
--- a/test/dm/ecdsa.c
+++ b/test/dm/ecdsa.c
@@ -3,36 +3,125 @@
 #include <crypto/ecdsa-uclass.h>
 #include <dm.h>
 #include <dm/test.h>
+#include <malloc.h>
 #include <test/ut.h>
 #include <u-boot/ecdsa.h>
 
+#define FDT_MAX_SIZE		512
+
+#define CHECK(op) ({								\
+		int err = op;							\
+		if (err < 0) {							\
+			printf("%s: function %s returns an error (%d)\n",	\
+			       __func__, #op, err);				\
+			return err;						\
+		}								\
+										\
+		err;								\
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
+		ret = -ENOMEM;
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
+	u8 sig[64];
+	char fdt[FDT_MAX_SIZE];
 
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
+		.required_keynode = -1,
+		.fdt_blob = fdt,
 	};
 
+	ut_assertnonnull(info.checksum);
+	ut_assertnonnull(info.crypto);
+
+	/* create a fdt with the public key */
+	ut_asserteq(0, create_fdt_with_ecdsa_key(fdt, sizeof(fdt), name, curve, x, y));
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


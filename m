Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAFBF4369A
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 13:03:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C08984329;
	Fri, 17 Apr 2026 15:02:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="GFVKLi2y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2590784262; Fri, 17 Apr 2026 15:02:20 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21BF0842C9
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 15:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZZc8Vt6AugSzqLQB+kcu8cXD2NcMf9mkWeT8MkN+GmJlU4rRWBLC1U6fcPQts1DEp+NNzTK2GhiWrk2k3qtM3qHpEj8eu2UiX8keb7dDzf1H3OZX+mt/eI0an3vFn7khuloQl3Hd7DEeVKvSiZcamrYKGK31FwUu2IwifSTPDs7P5KS6Vww5YEdmwhQ+LGBWjRQuIKFV2bUgshd7Uedcb/R3pKP5WYzcSpvymvetmErBGX9dRxyrFb+YXsm9nPLN6Mh47299fGLW0qAdH+DkDgQOk5oFLs6idaQThvf4YuUq1G1obinKCHEw/aj8l8P/X4Rnqk1Pc50oxnx8zdF8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+dsiUpY+xIMy3dX2yySZrgzLjxTheVc9mEpOl9n1zM=;
 b=Y26/KE5x6WLx+b8aA6pwSxft6xmhQ1ylkQzjDfaYyMXM5gHeRHa4ujmxvh7q++0hn/pegbJ/S0JVuKA1HdccagcnJHRsLVoUOifs8VVmmLqsNTeUMrAJRF90qDM1moeJxIFth8dlM2ohi+JUBf/DWEaLKiMKtufIe84pBiBXykrEfPfPG9KNHRnz8kjzNozkkemTHbhPre8RGqlauD+hZVJ9UD7ebBYJcyEOZmFlxzY5HbMEvCg8bfZiCkMszQG/Z0Gs5TUr+pwhofO64nGcSeB/aDd7JkTpuVXzatupxoj9uhA5gIPnSqT8WI8QEABIGW5UeIfkE/uXpvoKsMe5eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+dsiUpY+xIMy3dX2yySZrgzLjxTheVc9mEpOl9n1zM=;
 b=GFVKLi2yrkDJ9ta7K3hcAg+RP++//YiKE631QIDrSrnJIiPsRKn64Xa0kQIqke/T02lsKjXNnj8X0HWkgc+ovJkt5AsuGklN1diW+jFxoXc9zpYxR1dggUswmcvZg+1+MudpFsDYOvHL1WQNap7I22wBmCdkBcthNh+S9sNHcSdNWGWw6blpjWa1lHyn/F65kQ+MR4YIBEunT09bPi0E1PJUtEjoJcYrN+yekX9UQ9feJUSd1hpEG9U2PltrJDjWnJrm9EPCItFynzHcq4gbNMoBZQ/xvUO+bxM32FFnkFVxhnWaYgr2TRXGrSpnoo7a1g3IYqdankQw3DOkwDPgLw==
Received: from PR1P264CA0126.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cd::20)
 by MR1PPFAFCFF2AA2.FRAP264.PROD.OUTLOOK.COM (2603:10a6:508:1::2ca)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.45; Fri, 17 Apr
 2026 13:02:10 +0000
Received: from PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd:cafe::77) by PR1P264CA0126.outlook.office365.com
 (2603:10a6:102:2cd::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 13:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FB.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 17 Apr 2026 13:02:10 +0000
Received: from sah1lpt726.home (unknown [192.168.72.39])
 by proxy.softathome.com (Postfix) with ESMTPSA id 0BB0120EC3;
 Fri, 17 Apr 2026 15:02:10 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v4 06/14] test: dm: ecdsa.c: clean this test as software ecdsa
 is now implemented
Date: Fri, 17 Apr 2026 15:01:56 +0200
Message-ID: <20260417130204.49896-7-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417130204.49896-1-philippe.reynes@softathome.com>
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FB:EE_|MR1PPFAFCFF2AA2:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9d7c551f-0949-45b4-8b90-08de9c81896c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1tPEB3FU5aCvIW/DN1tOelydB6VkgFLi3rHR1RkNt5Cgd+xTD8SKycLAc09WPjk0P7P4ne33ztijbvW/gfH+qVXnPfEPN1otnm+6u2mUEmhvf151VhzclTW64rSOky4vbG9f/75vo91nl3zp+9dWU/PgFPtn84dN/DhBhto6ARBTqWOVriMuBxLgMjE6hwA4Osxjvy1h9KPecKKYva6aeKPxJ4p2KwA3oqiE+JJmWi+vFZd0ioDrbv0r9KrxDxq3g2MCBYaoUHKi6kbikm21Rd0IeAYMBNX1AfD9mVMwiB3rLZ5zSfzDfO7qWc2lNB01EjUrxN5HwmKak1VWSQ3yp2pxq7HSdWWZ1UMiwXUJm+fKOyXBc1ukNz59fRS2AGh3tOIQosreyF86sh/M4gLTZYBuoBQIRPy58KUiWSHmZlK09UGOon8MfHI+1q+lNZI8USqB88KfKlGgze5UTjnQ/UUlp1J0uC451t3AXvjUbtci+UaaUkroXd20f8zUbfkMmjijEE/ITGavG1dH4HStRLCH774WdowoEVFYjyoZLb165v11rKDE5o0uERIlUse7YeNpYNPKwgFCmr8AgNoalVARjUlrlKSsuIhJQ7ftctXbyKigqmrrh/jNuzD9xa18noLUerzD7voFs2vv5oYehJlCyNM2E8knKDpBvX+3ZUb88S/frclqHxOMlslYNEpbuwxcnPrHMCp7YSHknxpVmKdC5bBHbAGTrT/auQZWvGPH1siLsp8VVl/3e24FEuqpTWVdXz2wweCbxtlCnaQ1Bg==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8KPs05HQ9tWipqTMG9rqbcEPKA7io9A6z5MWcQhMbMijQXPGCfHHzHuaDxuaTS8jPz90+ATW+SehvZcp8H2GwhRcc3ejsZl7YmkoSHpPO75+mVT4R4Om9ZMswzZJIGYj7A7d0bgsmHSNNaTJNWPVGJWjgivbtI9aofg1XrMrv3yWi3YKqHrKVIr7ajgUyW1hDlwkPAqH+OHZTa2ipyaWlDikKR/uNKqBlB7sGoiOeQYxAXaCwRrbRBZ2gy1ioHKpHgxdCdLmJDM1LULN6z1R+AiDDGWeNxwaPGvxCvm150wmwsilz/dc6drbA1OcVcuuy9WyRJUuXkcQV66fg8sFvsE2BpGlmmE7QUawLm/rCTVXVT2ZbjeGpu6P/q+CLvsnBk/UD8xbmYjAaE7itarovRTzt8RhASINNvuV+xEl2cqewQ5iHuYh4Vlmxy5vWtAh
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 13:02:10.3404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7c551f-0949-45b4-8b90-08de9c81896c
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1PPFAFCFF2AA2
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


 test/dm/ecdsa.c | 104 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 94 insertions(+), 10 deletions(-)

diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
index d7eac7115f7..946d5ab1d81 100644
--- a/test/dm/ecdsa.c
+++ b/test/dm/ecdsa.c
@@ -3,36 +3,120 @@
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
+	const char *full_name = "sha256,secp256r1";
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


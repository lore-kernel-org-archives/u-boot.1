Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CD9CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 13:53:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2F1184862;
	Mon, 25 May 2026 15:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="JQ/VelPX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0DCA84837; Mon, 25 May 2026 15:52:50 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADA54846A5
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSMushEuB4D4bdrQUxlVn6W2gTWtnCIOTRpvfQ9YYT8mi3PI4Nr0GGVOSAQsQ4D2oTIbtPXtkFP8CcHJ9qZ0GKvN0bH7W9HNfBMM/ZLW80yTRHTpN1HqHQgWhxwlptlWtRxcci74Aud3VVFndroi6R4eayGryAWOfBXhChe3+U9lOWfx/sNSIm8IJ3Qjo98HT93GallhHYltwGXBsFmm2bTpMoD4kc7ki+4THkDSyFWwzuM5QkIUUFGv9eBoeSYq9jIY14QpRnmknTMoHXqT5ZPVRrvK6dclEqjGKMzveXBHo2C38PJN/kMcF4pB7JcwA7vF7+82OQ0iEEisdBJUsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkDjzrFnl4TPiP1d13lZl5ERSe0qXRiPwhL2rYyT0SU=;
 b=iIRZWVVh8drq3wszUzTGbLPvjTYYYooO4oQJIn72vkUvMdm2YVca2tFky7aPr4q8+rKwfqnQGbhS0tqv3DN2GDWMAFec9F0P2kEGt08oiF/7etfeoADZBKODCpKGKgtMydBbJaOZSf4cLJ+t4A2Q9Rgrzlch9AMRJcDO4O7RsB8US94lcEJ+k8i63f/+zZ69kcibTgNtic68/q5dQDK8fLAUCfvynEWKO5S+8VtbX/eWRXjliDjYhSqm1hOWk9KkTfwhClV+qCZh4K/HEySDFR/AJZnzXBSJalK1CRFSM15hyPBJeKasgBU0Fgu2vD+MfQxM9WTdUnW8eeN7BUYROg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkDjzrFnl4TPiP1d13lZl5ERSe0qXRiPwhL2rYyT0SU=;
 b=JQ/VelPXehQjcrPW4xx9nPxqzE5CA5FJcU49Xoe3eysSOXq7VXWlzOSFK7SPBVyrH1Ij25fLB4yRIHVwa/gcRzdMEldkU+kiXJWco4n94ZZknhCAA0qnhImTrB9IZ19SvljNgXyKMgOGW3S+tOPVTbyyuMkcT/zirbt3WoDuHUARKldOKynFSNB+jeB37PhhD3L6aNh6r88KnWg9fVI05giDk/LYtrSHZDxnKLMlDDlK9NRQ/AKBdOLkrZ9nnl5bc4Rb81mZdilxTnTZAwhQH6HuaaDUy35RTecASqzy1l7hEHmkL9nZeOgc4kfUTjZEPQ6WHzK5B+otQJNWS3mL/A==
Received: from MR1P264CA0103.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:50::28)
 by PASP264MB7007.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:540::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 13:52:45 +0000
Received: from MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50:cafe::4c) by MR1P264CA0103.outlook.office365.com
 (2603:10a6:501:50::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 13:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D5A.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Mon, 25 May 2026 13:52:45 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 5EC2220AA4;
 Mon, 25 May 2026 15:52:45 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v6 06/15] test: dm: ecdsa.c: clean this test as software ecdsa
 is now implemented
Date: Mon, 25 May 2026 15:52:32 +0200
Message-ID: <20260525135241.88348-7-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525135241.88348-1-philippe.reynes@softathome.com>
References: <20260525135241.88348-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D5A:EE_|PASP264MB7007:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 87480837-0306-4b2a-5b48-08deba64e667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|22082099003|18002099003|56012099003|6133799003;
X-Microsoft-Antispam-Message-Info: NfHfKot+AQph1+TAA9bH4bs1iIMCEL612UqUnopf4i+LWh6sCS5BNErY/HVhBP+WhMyTm++fDLgOvCfUXTVAeUb6k2Qt15p6uSJa1Y3iUYBcsPLLdrwEk0BjniCbc+A5sLahSU/GOVQWPEbvhpSifyfkoUkiGkmUU1gPW3k2MWB/QjmT3IFXlc9Q+B5RNFMQOZtQWUoT90XZzDSO3yidYWQKMcjsM3olm2BawVJdJUqNRc9RO2fGyjIb2k7EPl0ltyMjl+TtgDbUTRK0x70J9MCatHsybIqFoCdh3PvFBJRvKtzNwujtpwHxmdseJ9+Ob3HAZW2kubtnoe9kiOniR+zPpFmg69cHBwGO35GaB/0ZtNQOEAhrojetKHfofB8NRbdAUnsf7pzRaX4Yvk5xRJg359s3TKGzz+P0W5zDByf54ooh5n0tyhrm/+Srj5BWFn2aAkuJn76+bzbwbk71b8XeXj1zPilSxn5o9NL6v4Lk5T7EW3PvIjcn2L9NL29ymJM+Y8M4STdI0b3j5hN+6terU3F9Vr8pMqwxuq3tK7yuaMm9xL6+LLGaDxqk3zx9+oTXdFZ8HidnQKOlGn4O0lurcsaJtR/pnuqHWWsK01fldanGJU7pD6LxYQQ3mKobiRLqtOk3CnBZdd/Am0uFR91jUNkg8ccNVNH6orrM4QxF+uKW9bzNQy/4RB5+643tOcMzJJI4p+tLZkjVEcW9gApUj3t3ObVPO+YItUB2qt8=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WSJF62rypPcXTkbYN5mS8lJO8gmQlGMlVOXMCps7xVnepa/5iUQ3uq/HvygKjPongxPmeV98BnZGXk5a/7XXhw6kLHLRlpDrgjmsDWTFocvCR0d/Nfe4D4g8aGX8pzUK4Oxh7i78P+6aktKiVu/2/ddUtkxRK42PtzDbY4azILYmBRQCneutKd8kBdPnxmJ6PugvyeEBvQuVd3Mp9j4JVN8fApkM+/9T7v5AOtPkWCB/vvJ6wVFt5nXr+2HdYJ24cvJf3VlRg1JQFG7B8JO+9c3A8bK0/l4TgK0gKsQ0Q0BvwwDnQ0EhBjXcE72AXqcI2FZR2wkJ3ZqROjDrQsZs6tZPttIIrNXhNyy8R5YO2bJHK+KKrIqy3E5mnxNGh4I6LqDr3mBY5796QUBTsLsO0Htb7HUr7PUW2RHqoUgzY+JdgSzkIm9tL3fOhh3Xf27P
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:52:45.7564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87480837-0306-4b2a-5b48-08deba64e667
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB7007
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

 test/dm/ecdsa.c | 108 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 98 insertions(+), 10 deletions(-)

diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
index d7eac7115f7..04c0f83e929 100644
--- a/test/dm/ecdsa.c
+++ b/test/dm/ecdsa.c
@@ -3,36 +3,124 @@
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
+	uint8_t sig[64];
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


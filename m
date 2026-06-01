Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B5ACD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 13:44:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5AE484912;
	Mon,  1 Jun 2026 15:43:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="OQo/vaDN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 713138490B; Mon,  1 Jun 2026 15:43:22 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1956F848FD
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbORFPwBPIe2ofQiNO/1mKwq9o20HfoFwA+oUEyollN6BC09En68j++EZeSgacNVp26BT0tfUO9XAA3tGbK02Jjcm5ZNB8s1R/Nv7Qj/lz3Kzq+bcasql0V+SAoi+J+gihZsVALxLBh84EFMq9OvkaUbqQA5Dz5i5c7ArAr/0vjSN93R+V0KTvNlyuUahFIggIgz6DutAqVV8fiN2rKSsZWekoVd0LM9s0qBf7Bk5DklB7w9kKILj5f8AD9fJXI6PePlEjY7wZXfugi8kVS5AREvAzTjO8ZwbgSLrX9tAD3BQdbMBDxfTXE5IU0TgLHafW8mVj868E/VAW9/twosRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwHvGMQs93SCy+JJzKvGhQonAOq64tFP0fgPk1OfDNc=;
 b=SM0yImXS26skzkeN/JRj/JdzNcOZUwcN9wpet/CUPTXLfCF6ok5+SDfMHICXumLM2iLssUH9hvZlL3fi16234IA/vHDj/tsIsXiAQQa5mL/aAe8Ourjjh1HlIAL9um9cZ1Mb7MwrItYBfxbs0P9THAtMd9hNYD+JhY9/w02RsjVXFcjMLpTSaS0k7tdMIxJogb2/p/Cj/9/Hf+oeqARcX5AbpnTl8v6M88myJt8tG4DJBG+oMchxU/Df+vwxvYKVYtt1Pce21g8PiYIYkKicIbrcKers0pDSVrfwIlIzaM/SMYG2elFLG+6K1azoojbWDXNszN8gmIy2blq4udfXBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwHvGMQs93SCy+JJzKvGhQonAOq64tFP0fgPk1OfDNc=;
 b=OQo/vaDN8zYdlULX/lhDvM/Tl5kmTHxxZ+joZuH2vruJtFHqDA6PFhsVc/BAGXiJCOHyegASA9ZzIJkCTMw6o7YjMFR0p65QDqk732a3HhY2VEYQq3sVMALM6Nd9X1Df/upMwoXK/z8fGXiMAiHEnnQhu68UzhzB8F0p+HGXXvw5I1fTSOMAzGmSl8TY8J1FJHQbnYvvINFh0GltnJYYg8bPDrPBJyjBWwsoGfcbFa8/ASpjmMVX6Tl1aQEZ/DYCC1WKinKGp9DWcNj3g47bfAV5jYCwaGba/6ETCfTyOqX6+PcxcLKr+GMN+NxlbOR93M5GK+glVwTLTRFKHeBNwQ==
Received: from PA7P264CA0458.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:398::15)
 by PR0P264MB2679.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 13:43:16 +0000
Received: from PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:398:cafe::8c) by PA7P264CA0458.outlook.office365.com
 (2603:10a6:102:398::15) with Microsoft SMTP Server (version=TLS1_3,
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
 PA1PEPF000CC3FA.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Mon, 1 Jun 2026 13:43:15 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.66.192])
 by proxy.softathome.com (Postfix) with ESMTPSA id 75501213D0;
 Mon,  1 Jun 2026 15:43:15 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v8 06/15] test: dm: ecdsa.c: clean this test as software ecdsa
 is now implemented
Date: Mon,  1 Jun 2026 15:43:01 +0200
Message-ID: <20260601134310.2452454-7-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601134310.2452454-1-philippe.reynes@softathome.com>
References: <20260601134310.2452454-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FA:EE_|PR0P264MB2679:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0b275494-71e1-4b1c-007e-08debfe3bb9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|22082099003|18002099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: mms9XHFPa+rnSBO/0HNHejMuqyEHryeS7kA6FBA6FWDvidUs3unQ42eJsQSYGXw6753OS/ItInJ6JXNzR/GAXZ+GLUp3VZ2PUgYNGamKarVIZUcOsfiU6jwKJU06RybmDszlYmcru7zyws55HufMvOAYYnAAIWEUrFsI0y0LSsmFMnL0mDEQId+FvRG1qKJ98VGmpM41GV9kfdQiZjAOmo1mSTBeqAhX5w4SSvdpsASy7lR1EB7WF7YkyoNxd6a16m/bG3+94OjiQI82WdtIeZNa57BNoKYfj+aG2yP9Ml8g9EExhCuXFNJ0KkyQnpVugFjDAP9MS53nGqGK4zhsboCFLGwCOTpdAHVZf8D7okvuVZzoNfAUFL1QjpqbMiaIsE06ozpktB0gMEeoNQsgKhWTReSG9JyHiFjNxh9XhysTEuFqhoBir5q023eLmdYPdXPWRJJubUJ/09cM2xoHLNqPr0O2aKm5vkY3rNEQI+agAQ9fWVbCT+bTg2symUgLHwtbNXJYW4V0lGnOjKB5BOA0H1kVnhwSKI08DZ4GCe30m5yApUAPpEL8QIQPHAoxn5RqqVRZZ+8tS6xhKZYv/bI1WfJwi24nFlyVTRiznsbtxjg7WUmhrEva8oxmAQJxZcqpsSWQmjBkAB2RCbYvWcXOKS5QskKIbF+g2qxgOvhkhG82tcwbTmzfzB9J6585i0uXIAsr9Ukz8JTEz1uthr+ZmaZ8wKG27p7MCaIxXKg=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(18002099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: J+BpVZsXMJmGpMI0vqvPGWla+pzsE3AWAtqvNN0cuXekPD7YeacI80lxlRBk/xiMmbxOwwlISHuUYcov4Ix2NWGVgx7OuAelfqLc49ruGd1GB0Oqk+7EawkV5nwIhIM7BMVZ9nZXcN4sumClJ9LfP94vHMbOqCMr4M+ryCg5qyTwUA6OSRl8bMA+BMCRp0aKeQ1QlwJIaRPiXfxs369A83/8db5RKPVRzxCa07DytdzeEQkPi4X/te0PLwi4lVZ26mwy/jB5AdccUJqqKif35LrRASHHigTLt50OlIWYkIuOeokuRmNCftP7pw8BeQpxRWe6ku1Ba+yeEgZ+GyckeX4Sx6MzuiaddiWgdOzCSobzBektyqqdsLs9ZYteI0GaRLb/ItY3vQgnN3tuBqjr1C3tPvmll0jHznxsdKRPQJ+8pau1jIIsPw49fuSFdWLJ
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:43:15.8828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b275494-71e1-4b1c-007e-08debfe3bb9d
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2679
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
v8:
- remove macro CHECK with a goto inside
- use lowercase for hex data
- code cleanup

 test/dm/ecdsa.c | 107 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 97 insertions(+), 10 deletions(-)

diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
index d7eac7115f7..261ca3f9f73 100644
--- a/test/dm/ecdsa.c
+++ b/test/dm/ecdsa.c
@@ -3,36 +3,123 @@
 #include <crypto/ecdsa-uclass.h>
 #include <dm.h>
 #include <dm/test.h>
+#include <malloc.h>
 #include <test/ut.h>
 #include <u-boot/ecdsa.h>
 
+#define FDT_MAX_SIZE		512
+
+static int set_fdt_ecdsa_point(char *fdt, const char *name, const char *data)
+{
+	char *value = NULL;
+	size_t len;
+	int ret = 0;
+
+	if (!fdt || !name || !data) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	len = strlen(data) / 2;
+	if (!len) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	value = malloc(len);
+	if (!value) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = hex2bin(value, data, len);
+	if (ret)
+		goto out;
+
+	ret = fdt_property(fdt, name, value, len);
+	if (ret)
+		goto out;
+
+out:
+	free(value);
+	return ret;
+}
+
+static int create_fdt_with_ecdsa_key(struct unit_test_state *uts,
+				     char *fdt, size_t size,
+				     const char *name, const char *curve,
+				     const char *x, const char *y)
+{
+	ut_assertok(fdt_create(fdt, size));
+	ut_assertok(fdt_finish_reservemap(fdt));
+	ut_assertok(fdt_begin_node(fdt, ""));
+	ut_assertok(fdt_begin_node(fdt, "signature"));
+	ut_assertok(fdt_begin_node(fdt, name));
+	ut_assertok(fdt_property_string(fdt, "algo", "sha256,ecdsa256"));
+	ut_assertok(set_fdt_ecdsa_point(fdt, "ecdsa,y-point", y));
+	ut_assertok(set_fdt_ecdsa_point(fdt, "ecdsa,x-point", x));
+	ut_assertok(fdt_property_string(fdt, "ecdsa,curve", curve));
+	ut_assertok(fdt_property_string(fdt, "key-name-hint", name));
+	ut_assertok(fdt_end_node(fdt)); /* name */
+	ut_assertok(fdt_end_node(fdt)); /* "signature" */
+	ut_assertok(fdt_end_node(fdt)); /* "" */
+	ut_assertok(fdt_finish(fdt));
+	ut_assertok(fdt_pack(fdt));
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
+ * so we only check that the UCLASS_ECDSA uclass may be used.
  *
- * The uclass_get() test is redundant since ecdsa_verify() would also fail. We
- * run both functions in order to isolate the cause more clearly. i.e. is
- * ecdsa_verify() failing because the UCLASS is absent/broken?
+ * The data used in this test come from RFC6979 and use the
+ * sample with curve NIST P-256, hash sha256 and text "sample".
  */
 static int dm_test_ecdsa_verify(struct unit_test_state *uts)
 {
 	struct uclass *ucp;
+	const char *full_name = "sha256,ecdsa256";
+	const char *name = "key-ecdsa-256";
+	const char *curve = "prime256v1";
+	const char *x = "60fed4ba255a9d31c961eb74c6356d68c049b8923b61fa6ce669622e60f29fb6";
+	const char *y = "7903fe1008b8bc99a41ae9e95628bc64f2f1b20c2d7e9f5177a3c294d4462299";
+	const char *r = "efd48b2aacb6a8fd1140dd9cd45e81d69d2c877b56aaf991c34d0ea84eaf3716";
+	const char *s = "f7cb1c942d657c41d436c7a1b6e29f65f3e900dbb9aff4064dc4ab2f843acda8";
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
+	ut_assertok(create_fdt_with_ecdsa_key(uts, fdt, sizeof(fdt), name, curve, x, y));
+
+	/* prepare the signature */
+	ut_assertok(hex2bin(sig + 0, r, strlen(r) / 2));
+	ut_assertok(hex2bin(sig + 32, s, strlen(s) / 2));
+
 	ut_assertok(uclass_get(UCLASS_ECDSA, &ucp));
 	ut_assertnonnull(ucp);
-	ut_asserteq(-ENODEV, ecdsa_verify(&info, NULL, 0, NULL, 0));
+	ut_assertok(ecdsa_verify(&info, region, 1, sig, sizeof(sig)));
 
 	return 0;
 }
+
 DM_TEST(dm_test_ecdsa_verify, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.43.0


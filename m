Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA517E77172
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 17:55:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B25C89744;
	Wed,  4 Dec 2024 18:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="j/L6uzQZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D91A89736; Wed,  4 Dec 2024 18:54:47 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB55189468
 for <u-boot+nodisclaimer@lists.denx.de>; Wed,  4 Dec 2024 18:54:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+TkdR61xzt72zbEL3eS/hsNyhgS22W1OMpcd1lk4OxgXKxzx8kwk84mUtpVuXR8ITG8bNb6t3gbrGpaebQySIO/ADY+Or/WNd7+UxFVHK86PmvKvLQXWrO1mUmLm0p1IuQ6WjqjNRIeY5Vwq/f73XwWNHGBqKNs1SPi7ZlLehVochQEznGpNXz1uwN95QPgAF4tCDK7x5C7p/dkKropUA3GOSrwo2RteHwD5fLV6/dVYVT+0hyIHL0/ZmDfh3AksFaCzpH+wgWIvQ1FmOI1bZ1qhcZS3AP3qNluaKrWa5fyjv0N5W+iit3Z9qWqzyrRlrVutI9jgFaTqDnSH8vdfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14FquzRJiFRUy32c0+PEkcOUrLJ5wFWMJ9n4EAWQLQo=;
 b=PAu8Pks196Ustxo3XqFXUMm/tkKcfmB2BsgeNopLdNG6QlptU/5fj4kw88J6Vk8soYA8mjh6kxIfXkkb1RI3fOZz/3aG4HdnDJTXkAz08g1ALDFFYmaDuQ7qwDVMhipCCbh7vY+7CMH2SUgzvioTmzlVtjxyC+okKc//VCiSjQ7hj5AXlcmXveegCFhToVHcrX1HhxvILw/P4vRRafN426Y5v7lKLNOzRpzwvtiF+H8mmM7rmzj5T3C0hTzdguot3zecOwWLhBwBRxM7Lt8ii6AEKL8AvzdOp9/qhKm0PhiEmTWjvIzcAH8gGHeR9OuKEQjFp8rU+YyLYbCPhY9ubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14FquzRJiFRUy32c0+PEkcOUrLJ5wFWMJ9n4EAWQLQo=;
 b=j/L6uzQZaDwsrNXuSzQ2rlGk4dmq12uNQkxaBxTxtRIxuk+56gt6pwfd4lPu6ofyPB0k8xKxgdtzQ0JdfS6Xl2Q1ffFKhrFrzdzHYbOo9IoEj3eM/iog4s5P/AIWzKWCvbMgX1QwBcboX9u2f+A7kkJ+2GJQv+eCYlGvvNfu4CUA5DbVBYCtcgtnfshTaCtZShHaCX2hREh2a2O/xm9j+X5B2Khw0txgGDKjbYLVkgf73KE25ErUMjUnBQ9ZIoOWRmsHsSv25jt6zMDbh0T21WGPoj/jYp8ttoJW0ly0/mvpYA1lkYNoFN8PpgEFdwa2jM/TTFUNm4KR+BgAK5RnIg==
Received: from PR1P264CA0086.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:345::12)
 by PR0P264MB2517.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 17:54:41 +0000
Received: from PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:345:cafe::9) by PR1P264CA0086.outlook.office365.com
 (2603:10a6:102:345::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Wed, 4
 Dec 2024 17:54:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FA.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Wed, 4 Dec 2024 17:54:40 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.75.209])
 by proxy.softathome.com (Postfix) with ESMTPSA id 7F5B02019E;
 Wed,  4 Dec 2024 18:54:40 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v2 2/5] lib: sha256: add feature sha256_hmac
Date: Wed,  4 Dec 2024 18:54:34 +0100
Message-Id: <20241204175437.185449-3-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241204175437.185449-1-philippe.reynes@softathome.com>
References: <20241204175437.185449-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FA:EE_|PR0P264MB2517:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b8f2f40c-c5bc-47ef-417c-08dd148cba15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LjoZMk5/fbowR4y76uzcpCXFzPr6bpzBOlO0mU8Xq8wplhftcO/u9ljX4IBj?=
 =?us-ascii?Q?q4fOk7wQ9Mp65tsdFnjRzlrfvJCi3pwxmcsox7eAZ+4HbpFAYcjcV9trE2G0?=
 =?us-ascii?Q?/KAoR+8o4TarkEkvhYYGOoUydQZNE09euVxriiQpA0ElcvcdnqPicHDlaL2A?=
 =?us-ascii?Q?zPGZLLc/6aAv2cuny1zEWPq3ODDF6UjZRrJ/C4dYNTyHNwWotrzCmkWLZXrG?=
 =?us-ascii?Q?xnoRz5I9/WTbqRL4cq4unjQX66DEAo+yIPA9pveagYj0VN7QhVff2tztZOGz?=
 =?us-ascii?Q?vlcm3/iEGr/lZyuaz0d45OXRihe5cpOdo+/TbjSIXf93/MQY/LFyGSU7Kgrq?=
 =?us-ascii?Q?8RqZW4+QiIQ7WxZJxx+6A1JXuqPRDhG5P8VvZfUT74ncgb8ZNdtrWdlgu4lw?=
 =?us-ascii?Q?q5KoKPhniy6YVIBpn3lgRFeVlG9QyciAeVKYbnkUeN5VeI09C8RHRQvjycm9?=
 =?us-ascii?Q?wUXBRHXnlYw2fOK/Y351h8QTfXGlgfMd+evMVvxvfi010MNV1z/maSJKoEI9?=
 =?us-ascii?Q?sep+08DICfvcEsjKaUf2ChcWoDBrkfZWWHeQTYTgmbEY1BhwBGBbZssNVUrI?=
 =?us-ascii?Q?dlULxPFtkNIfqiNFFtkJeRQpZwZ6+THFJp11ezn86qhosQhyW0G6aAbRLXex?=
 =?us-ascii?Q?h47mcJaIQfg/tN4vtQYtC8uDp0bCEBUCX76T3lkY6MqES7e4c17V+jfzrqYf?=
 =?us-ascii?Q?Xp71zOBZ4zBIUccV5mfyArk5TnV5wr10jnot9y2mPv5ZltWdSeEPvUKNP0kb?=
 =?us-ascii?Q?LiHYGaAW/YIPAc0rEb3Cd2mKGhs8QuXBgZQZAEN67NTWBIP40/Z+xMaFAxpb?=
 =?us-ascii?Q?37WKvi7SeAyPbHExH72EU5dnMo+5Y5oaNDfCfsasbnAi7sa5RQZorWQQONEQ?=
 =?us-ascii?Q?C8YQ05YjyDUh9HE3ZdYZU/G9Sp1NMhXiKce82yQnckwfksxwyfB4fOoLBAxD?=
 =?us-ascii?Q?nkWmI/pJ2E+ml2ANbEK5MnejcGgIJ0emg+lD8XFZM6IFETNrAnXdvo2Pn9TS?=
 =?us-ascii?Q?O0NuxJBL7TuDmqxjEprw1infuF3l1EaISWzWCj7yEolej3MiB+i5cG/ohoOJ?=
 =?us-ascii?Q?IrDVLs8IwcRStgyvUvGskZRlwLoxxOigBafHO1hyqUeVatiVil7r8RianZFS?=
 =?us-ascii?Q?5BrwVts1sx7aqEf5ok6UkFRCGtxSMB5bqkzw4ratm2EdLyN/OwHUw2LvVMHa?=
 =?us-ascii?Q?vilE7Jyo880ONUxgtxswGBH2XqAsGouwQShK922UFT/6xbwLK64Sdga0jg6G?=
 =?us-ascii?Q?tSVEuYV8PCsp8QYQGJO1vLQ393F5FbweFddDtYmgR8knl2wYbeE0Hvo5BC9h?=
 =?us-ascii?Q?DPTmgbSZmGa0rJ9m+HmuQIk1iOuiIcf4F/nvWedKVpGb0qjtaaqXJd3eNXc0?=
 =?us-ascii?Q?v0qTsOkNGNV0z3YjbMjaohktPjU7K2tpH+zYiw8DKz3zs/M5HA4bkwzM1JO0?=
 =?us-ascii?Q?69TUpp6E6gWWdcZ6V0nOdWUhqYYd9k57?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 17:54:40.5941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f2f40c-c5bc-47ef-417c-08dd148cba15
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2517
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

Adds the support of the hmac based on sha256.
This implementation is based on rfc2104.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 include/u-boot/sha256.h |  4 ++++
 lib/mbedtls/sha256.c    | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
index b58d5b58d39..77dbcd4553a 100644
--- a/include/u-boot/sha256.h
+++ b/include/u-boot/sha256.h
@@ -44,4 +44,8 @@ void sha256_finish(sha256_context * ctx, uint8_t digest[SHA256_SUM_LEN]);
 void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
 		unsigned char *output, unsigned int chunk_sz);
 
+void sha256_hmac(const unsigned char *key, int keylen,
+		 const unsigned char *input, unsigned int ilen,
+		 unsigned char *output);
+
 #endif /* _SHA256_H */
diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
index 24aa58fa674..1b9fc1a8503 100644
--- a/lib/mbedtls/sha256.c
+++ b/lib/mbedtls/sha256.c
@@ -8,6 +8,7 @@
 #ifndef USE_HOSTCC
 #include <cyclic.h>
 #endif /* USE_HOSTCC */
+#include <string.h>
 #include <u-boot/sha256.h>
 
 const u8 sha256_der_prefix[SHA256_DER_LEN] = {
@@ -60,3 +61,40 @@ void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
 
 	sha256_finish(&ctx, output);
 }
+
+void sha256_hmac(const unsigned char *key, int keylen,
+		 const unsigned char *input, unsigned int ilen,
+		 unsigned char *output)
+{
+	int i;
+	sha256_context ctx;
+	unsigned char k_ipad[64];
+	unsigned char k_opad[64];
+	unsigned char tmpbuf[32];
+
+	memset(k_ipad, 0x36, 64);
+	memset(k_opad, 0x5C, 64);
+
+	for (i = 0; i < keylen; i++) {
+		if (i >= 64)
+			break;
+
+		k_ipad[i] ^= key[i];
+		k_opad[i] ^= key[i];
+	}
+
+	sha256_starts(&ctx);
+	sha256_update(&ctx, k_ipad, sizeof(k_ipad));
+	sha256_update(&ctx, input, ilen);
+	sha256_finish(&ctx, tmpbuf);
+
+	sha256_starts(&ctx);
+	sha256_update(&ctx, k_opad, sizeof(k_opad));
+	sha256_update(&ctx, tmpbuf, sizeof(tmpbuf));
+	sha256_finish(&ctx, output);
+
+	memset(k_ipad, 0, sizeof(k_ipad));
+	memset(k_opad, 0, sizeof(k_opad));
+	memset(tmpbuf, 0, sizeof(tmpbuf));
+	memset(&ctx, 0, sizeof(sha256_context));
+}
-- 
2.25.1


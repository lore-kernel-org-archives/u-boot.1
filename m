Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780DCE77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 21:37:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3A7880328;
	Tue, 17 Dec 2024 22:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="vwu0KMl3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B0CE80303; Tue, 17 Dec 2024 22:36:24 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 716DE80269
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 22:36:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQdPL2+DI+YE5G/6F3nvCdw0eXTBgUsYXYkc0bPnAHmuAZZJtyP8mkgX1ByzBfpXtrPbg+aCHy1wgD+Df518CtgPvHPRBW7JfF+JpynI/pQBcdRgyPdPIkIxJ4TqEuWiynOcClE67F9cpu3ZtI1aJ5H96h7CSwLy3NPipKyHr4TCmqS6/mKLW7RJLoi2Hp8iBQ6Xm3rB6DZ6V/urdCufRrg8pebc4QQ4ZfXI9IdB5f1tmMRg3B0MTRZq9vWqQPWX78zGDgyWu+Ro9XnDWZNuMwB6oLI/72vcohN3IqHIVNhVWMU0bNekhnsuMzBy+/ii4eyJf39J8luJoTaIAn10DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXc/MpTrN29jEpQtlDotgArZ0lXRnhRtYegNscWFn4M=;
 b=gifelnz5yNyIiKWNNhKVql1PhbqBgY8QIxhVp18qt8R1zNgXs5K0I8NmXovStIIdDmI83tOkwl+YGfnn8It3l0xwfzEEPjiIza8pHgAgG3G5eqXjHMWylwyekgWVeXRoPzGrOpm9Po7bC9bCtKGQ0W5LP3UG3XvvD+Xtk25G4JkBM4Ud6mDAijKzx6d3veOfM6xxU3mqBZWj/RgggUc13A9fsp307+V0vponhmtPSSkiTwnUrIjN73wNQLAzmUFEeHmqNFZE7r1SMjTjCiTuuYHRZya4Epu0rhw2Dy8g6ScUKVer+TU95rhYzZIpVolZ4jUUXP8IWFXBsjEnl3POKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXc/MpTrN29jEpQtlDotgArZ0lXRnhRtYegNscWFn4M=;
 b=vwu0KMl3rNwUairsH7q1Ib5A+e+s0CvY10xh/iLRA1m5Clp4nuP0wrpsxuVbuAlVZHu0PBvOYbLEHREArklzLkRlBaLBR5DklKc+TSoHqIyLzNdRh5YTaIwfkzWD1DWvacETbb7PtOhvtwRUfsj/fz6xsUVucV6QbaO5fpKcC8VBWIQu55KDN5NUQVBzI/r99XGDUv0j8mT+WRK+cvDfEYCAQMLVkfhWBtFX4Pyak0XepElk7MS/gZEXL1+odQYQj1lc+8vq79BBiRP1kDnx2NFmIsmscjkOf9cRIBeIvjtAqIo9nx4fzvUi11EY/9jHDJmCCSEZelNVREv9tKNlIQ==
Received: from PR1P264CA0198.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34d::9)
 by PATP264MB4967.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 21:36:17 +0000
Received: from PA2PEPF00019232.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34d:cafe::3c) by PR1P264CA0198.outlook.office365.com
 (2603:10a6:102:34d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Tue,
 17 Dec 2024 21:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019232.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Tue, 17 Dec 2024 21:36:16 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id C890C203F1;
 Tue, 17 Dec 2024 22:36:16 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v6 7/9] lib: mbedtls: sha256: add support of key derivation
Date: Tue, 17 Dec 2024 22:36:11 +0100
Message-Id: <20241217213613.286813-8-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241217213613.286813-1-philippe.reynes@softathome.com>
References: <20241217213613.286813-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019232:EE_|PATP264MB4967:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6c36fd3c-ac6b-4484-f976-08dd1ee2d6b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CeWVrxpDnerUvNk2YLSgVGnjC5Chw+u6k5ECtMLxCPxAQZ31X+lh2i7bvCO1?=
 =?us-ascii?Q?EvxWUJP3L1sfnGwCldhmW7a0yHbh9sr/c+BUW5GJb9lnIs9QU5wV/uMX9YGB?=
 =?us-ascii?Q?docHi5EswmQKavzFI4slcTfDAF66vD2cw/E/cyebfC2LAFy1rlLunnzfDuNz?=
 =?us-ascii?Q?iJnWrTMwCuOLIKeNgrG4WPTzA5RJ6bWUBE1WUaI3j2gzsXocUaa4vaO1glg/?=
 =?us-ascii?Q?DyLSbJkPD8Cs9NNxePhX+x15BKVPzXC5fJ46LBIQbzB23j+h6Fj66Xp2D2K+?=
 =?us-ascii?Q?fUfoyCO12bpYLQ976SE5sr5qjtHC0O+mUbaDXD+ARnt1z1CNrGrK+6ah55gX?=
 =?us-ascii?Q?gtk+QAf3UyPS24ReuUVuFri88bXKxqADWVucuJb1tCU8O5jmbG1mP5rta0Bt?=
 =?us-ascii?Q?fQzLlx+IE2WSRLp9KHnpvfrCf9N71SjfsgpI9h0flF5MMlz1QU12Ksl/bn4l?=
 =?us-ascii?Q?wOPzCjzjg7WvUNfBBw6V/fM36JDT6TK9JXlgFNSDsw3rzbDPx/SmFBt+yLA7?=
 =?us-ascii?Q?ojkoJajFcQmfO3gR3u4F5j47KS4njR7jCvGXszgnZgjAxus4f12RK/88ajgy?=
 =?us-ascii?Q?OVCDqZuBSNpwgrWExXAXJmCIiKfO3xnCz7y6/c990v4MGwPxY1drDy68cVYa?=
 =?us-ascii?Q?FlNtkL7gqCPyO6e4N3yuFg3GHHCokqZZ5Uy0H9sclEToLmSJfJghu3GBqV4y?=
 =?us-ascii?Q?BogzkdPsZLiNNX4ks7NHZad+PTyiC1WE1nCIWd7rUx7UZ6QiehX1ChC9oXyV?=
 =?us-ascii?Q?d9mpTIpu1OhHcI+77X/JpBymtlwIDWZGiqZiKForjSmfpI2AXtEBg7Hleu9N?=
 =?us-ascii?Q?K4XduQWp4XcYCIremY7glUsEAC6/RMHRGb0bV/LVz2O2Ehrhp5w2+RjTNZF0?=
 =?us-ascii?Q?XtsScmaZw/DMn5HMDRW4H6q5+EMBG778KIoQsmbOo77JfyBWy1zyzxwKkrCY?=
 =?us-ascii?Q?uBY0dfFY8YVfCAMCTCjcUTnfEqBxLR7TxPWc6P3ndwh3J1w5ZfxxVYnKURD+?=
 =?us-ascii?Q?zW/W4Vg2WZhJeSLCCzRBoTcMA+iwlcyWV/g+76YhMuD5Dq6tTHJ9wZYO3MnB?=
 =?us-ascii?Q?+316w+8kO6blCzVlpeuJBH6gt8YnHyVnUVa4eZsG5Z5uC9jHgjYIiw0euU6Y?=
 =?us-ascii?Q?cruU8v52ZyvrlC+L+BpGZrQrqsj5wAsde7+3kdfVaQo8HMolFJmOIrYkANxf?=
 =?us-ascii?Q?cVwi4Cl1W/y3V9zgqqUJk7OHkOC1n15GnUWhYHBV3vP967hTG/CIrkEXgKTj?=
 =?us-ascii?Q?vDRHxQ2d0XDbE2IQQE/5efLbiTEbZb/gcC8rDmvbx3NxmxdF5GHFw/0TH3e4?=
 =?us-ascii?Q?us4lrmXua6bGaRpyRAQd7/gl5pTEjw1t2L8RdWDQAeJEffh83yEvz/euMUfk?=
 =?us-ascii?Q?2OaQxrt3HmLUffHGN87BI2K1B3t9ReZxPytNlqnPcvnGNvG0CL2gISmR9vZX?=
 =?us-ascii?Q?2SQ+t89mQ86DjhFaBzSN+Zx7kLNW5F/egTv0knJ9J8MwYSTkehDdajBV9cQe?=
 =?us-ascii?Q?3zHVG1AG7KvjAm8=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 21:36:16.9570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c36fd3c-ac6b-4484-f976-08dd1ee2d6b3
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019232.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB4967
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

Adds the support of key derivation using the scheme hkdf.
This scheme is defined in rfc5869.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 include/u-boot/sha256.h | 20 ++++++++++++++++++++
 lib/mbedtls/sha256.c    | 23 +++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
index 99cf78e204c..d7a3403270b 100644
--- a/include/u-boot/sha256.h
+++ b/include/u-boot/sha256.h
@@ -1,6 +1,8 @@
 #ifndef _SHA256_H
 #define _SHA256_H
 
+#include <linux/compiler_attributes.h>
+#include <linux/errno.h>
 #include <linux/kconfig.h>
 #include <linux/types.h>
 
@@ -49,4 +51,22 @@ int sha256_hmac(const unsigned char *key, int keylen,
 		const unsigned char *input, unsigned int ilen,
 		unsigned char *output);
 
+#if CONFIG_IS_ENABLED(HKDF_MBEDTLS)
+int sha256_hkdf(const unsigned char *salt, int saltlen,
+		const unsigned char *ikm, int ikmlen,
+		const unsigned char *info, int infolen,
+		unsigned char *output, int outputlen);
+#else
+static inline int sha256_hkdf(const unsigned char __always_unused *salt,
+			      int __always_unused saltlen,
+			      const unsigned char __always_unused *ikm,
+			      int __always_unused ikmlen,
+			      const unsigned char __always_unused *info,
+			      int __always_unused infolen,
+			      unsigned char __always_unused *output,
+			      int __always_unused outputlen) {
+	return -EOPNOTSUPP;
+}
+#endif
+
 #endif /* _SHA256_H */
diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
index 7d456a82017..59edcb517df 100644
--- a/lib/mbedtls/sha256.c
+++ b/lib/mbedtls/sha256.c
@@ -12,6 +12,10 @@
 
 #include <mbedtls/md.h>
 
+#if CONFIG_IS_ENABLED(HKDF_MBEDTLS)
+#include <mbedtls/hkdf.h>
+#endif
+
 const u8 sha256_der_prefix[SHA256_DER_LEN] = {
 	0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
 	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05,
@@ -48,3 +52,22 @@ int sha256_hmac(const unsigned char *key, int keylen,
 
 	return mbedtls_md_hmac(md, key, keylen, input, ilen, output);
 }
+
+#if CONFIG_IS_ENABLED(HKDF_MBEDTLS)
+int sha256_hkdf(const unsigned char *salt, int saltlen,
+		const unsigned char *ikm, int ikmlen,
+		const unsigned char *info, int infolen,
+		unsigned char *output, int outputlen)
+{
+	const mbedtls_md_info_t *md;
+
+	md = mbedtls_md_info_from_type(MBEDTLS_MD_SHA256);
+	if (!md)
+		return MBEDTLS_ERR_MD_FEATURE_UNAVAILABLE;
+
+	return mbedtls_hkdf(md, salt, saltlen,
+			    ikm, ikmlen,
+			    info, infolen,
+			    output, outputlen);
+}
+#endif
-- 
2.25.1


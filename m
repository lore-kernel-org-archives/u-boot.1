Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFFBE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 13:37:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34C168021C;
	Thu, 12 Dec 2024 14:37:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="fkpG3ALn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD18F80214; Thu, 12 Dec 2024 14:37:19 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86FD78021A
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 12 Dec 2024 14:37:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0Eg69ap2SYiSttWNi8/XK3xViCyoWSNgNfrYcR9GNQyIwi+kR3bjUdBDNS+/oc9ardGb6gubX8/CsN7lQ2oMxVmNT71l9r3T/EBmBd5lkxde7oyXbBXcDd2wNztlVpW8TQFYuuT+bq+Ey0GclQIMeA6lNsr0uGXousMYeeqINWKFW33ymQvZac4nYxwT2NdGotGjSZ3hGDyyDq772PmBS8L3D9YrP0NPncmLYkNIctMb7SjjWoDRjW2sJc++AZ1oS1haQwaFM0TzMXXIpqKeJ068QwlvOdmYwtYpi6th4Y850BpGiJjFfCV26AYK6UF1hMT0BCP8YZ1b9Kq2cudKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TkQllC7T6cNGWdDqLe8BceFShxpitvMYTqtoX4/P9U=;
 b=mjII17N+w88yM5CHCwI9n9O9PfKhvo7oH+swSgL+qMZBmUC/CCLiRcuaXy4nbR6eTXI7yVSMn91HuLM0QSByhod3lt1vwVCa8TVbWmHFHDVFmEQnMKR/7VBZtayINlxnRC2KvNJ5wIbKIo0lQUJswXtto9t846LTv1yP6I+SmY285Ie0OFh0cLOXOG6w0rrjnSJa3HeAukB1zQefEfc66bSX2vhKA2VGyaEODM+bKW/pfoUZvP2TcyX888zUlWO7Nqj4zsivoffr5h7FF1pdDvLPaJBIkSPnSiuUmZhp7+az87hAJAJLl7UX6nEYeIT2tRKtkUV87KGs+/ioQpdYZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TkQllC7T6cNGWdDqLe8BceFShxpitvMYTqtoX4/P9U=;
 b=fkpG3ALnGZGd+qm5RK//cvXbOScMbFPsZL+P9+jZWRRCuApVhaGLK51uYI3KQfjGtvZnz6CGADXkkhWcrdpsV3edpmMimeEHlAjYgblCm0KGhLZW57dwuRYjX2nGylKGfMlrYEDD0ciiyaRmFjdYBhqSOOqD6mMQ+bngpBtpmU0/LZZzurEvYYIUK5wp1TdMZ6fmtkaNBxYNld9XEJERfegQmNM4G2Y7q/l11mNm9vxT8VWvZo//lfulpcQXHujS/7HFJe35QsLZE5RC+iyLcjNJmAHMSBcB2uHwvzAhrtc9T0eqtvdHI2ikEJExs9jI5qwfI1MzumTFTaVyr5Ohfw==
Received: from PAYP264CA0017.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11e::22)
 by MR1P264MB3540.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:2b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 13:37:14 +0000
Received: from PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11e:cafe::46) by PAYP264CA0017.outlook.office365.com
 (2603:10a6:102:11e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 13:37:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B8.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Thu, 12 Dec 2024 13:37:13 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 8F04520599;
 Thu, 12 Dec 2024 14:37:13 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v4 7/8] lib: mbedtls: sha256: add support of key derivation
Date: Thu, 12 Dec 2024 14:37:09 +0100
Message-Id: <20241212133710.172404-8-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241212133710.172404-1-philippe.reynes@softathome.com>
References: <20241212133710.172404-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B8:EE_|MR1P264MB3540:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 03d14a00-29a9-4bf0-17d1-08dd1ab21662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IR2euAlF2ar8DINxA03sLrsRp0qqGuTWbq4rNTPmRkBmRtZ6GylaHguDpPta?=
 =?us-ascii?Q?vPilIGf25AMkHOS4v+kD20cayupeCoX0I+Qix5GLi8z6fHSk3BE85sTXxeGx?=
 =?us-ascii?Q?2v18MGT2JqW1Wuec2Nqq2UnPQSmVgTe9kHuaBSZngbYhc4Ig1+HgCoZ+mkgx?=
 =?us-ascii?Q?0PJxt+eNnGlNHhOo0Bm94JyUsoFHAs4eJw9XDwKKas4AW7hs+uHiZOoX7hNP?=
 =?us-ascii?Q?r6IqyczgfQ9qmchT1aaD9v66zYbLlMChGWoi+18k6uvpWdGSlLrR8drvZ9Yw?=
 =?us-ascii?Q?q65rT5SuxUYZMOfPZ72FbDyJw5ydkgjWZ2f6qo3v2gSf53ayhL7LDwDE7Bul?=
 =?us-ascii?Q?AqrAaRtt1/OaWLKHy+8yndXjC4jJ6+8Gmpe7tP4L95dXOdzPz8pmuHn7Ok+T?=
 =?us-ascii?Q?D4ndaDTsMPcFwBCo5nhbPtdk5PgIBR2H/2N4lwzBDmm3YgVH3ShnKKkk8sCU?=
 =?us-ascii?Q?gLmzYuTtOZKWKWQgwS9PslzZgHW2W7qU58zyIcbO4P2DkNdCmASu2I4uCJ8P?=
 =?us-ascii?Q?6yzp/aX8w6o7VHk1oki8Y9y4bePbgtXt3uwiKfzUMGsuUEHyN8hfpbLKbYSS?=
 =?us-ascii?Q?sE+d7pUgIkMTB3UbhLhCRXVZJwx1QSNr0wv+RGgDeaCcC+Z1gtqlMsGW4KNl?=
 =?us-ascii?Q?0euQI1kpxw1wCGZucR+FzHH5/rhYFKwZIe3WZ7CUmMVfrUpNhu5Lc3gb29XE?=
 =?us-ascii?Q?ONCg2sD45oZyGP7fp+iS7C+LHuDGTZoduDMiXk6w7NmrqwQqtO/UtdYttLKh?=
 =?us-ascii?Q?Pnj95x3ZmXMbyagJkFchZCwOM+w0+NW4icVC9jiHqBGJgBFQmgz3wG1DW/jt?=
 =?us-ascii?Q?UinbnFAuZ80+B76WlJfBy/WOD5WMFwJ1EDv3SwnyODRc+Uq9keW+mNviXFaP?=
 =?us-ascii?Q?LLkc4mAslgFnVsvzOqLLpJAYdCZfRv/FA6/wLziOWhd9aC3vAtQQR0wfPzoz?=
 =?us-ascii?Q?YI8Y3faI6YVZflqDo0A1dbrk4zvT48itFg6l8ny0OR+MwJj3RQn3Y57RYrJB?=
 =?us-ascii?Q?NP3kUCIBVDuAPWt0iG3gkglghJtboPSDS2GMLkxq3RvhGY7OY/qijzbB4JXi?=
 =?us-ascii?Q?rog5eVQNfGV57V2LslprtqctcCWMKhyAyZkc0fHPiHPJDrSzYQnRtQNBINas?=
 =?us-ascii?Q?OC6e1HtUB71/wCOxPMq4BtN/40nyx3TNXuuvo/ZO1bobz7Gzuenp24N613H9?=
 =?us-ascii?Q?CInOZFtu6HciYlw82V6l2YQ75myzEk2L9UH7aqxhi+LBd0jbMOd+oAi3e4EK?=
 =?us-ascii?Q?GwPQRZnDZyU2rFGptG1R7bDK8GZVuUZHjhssi6YVW4pN1expKGBhMLMr4DYk?=
 =?us-ascii?Q?dZpiNfQBe/8+I71YrjaXH1ZO7X6bWrLVdMNr/R31yFqfsVQdiHRpbwuGlHTI?=
 =?us-ascii?Q?PAmsFC1tvGZAqhzexi9lhEs9Q0UO/fTxyKh2BFxGZTNdwZlq4h8n4wtGZi4Y?=
 =?us-ascii?Q?ys72AV/xe0CxnR8totjfHaDPJNU4ss/a?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 13:37:13.8037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d14a00-29a9-4bf0-17d1-08dd1ab21662
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3540
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
 lib/mbedtls/sha256.c    | 22 ++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
index 2f12275b703..f21173305a6 100644
--- a/include/u-boot/sha256.h
+++ b/include/u-boot/sha256.h
@@ -1,6 +1,8 @@
 #ifndef _SHA256_H
 #define _SHA256_H
 
+#include <linux/compiler_attributes.h>
+#include <linux/errno.h>
 #include <linux/kconfig.h>
 #include <linux/types.h>
 
@@ -49,4 +51,22 @@ void sha256_hmac(const unsigned char *key, int keylen,
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
index 2128e598834..b8bc43b612e 100644
--- a/lib/mbedtls/sha256.c
+++ b/lib/mbedtls/sha256.c
@@ -10,6 +10,11 @@
 #endif /* USE_HOSTCC */
 #include <u-boot/sha256.h>
 
+#if CONFIG_IS_ENABLED(HKDF_MBEDTLS)
+#include <mbedtls/md.h>
+#include <mbedtls/hkdf.h>
+#endif
+
 const u8 sha256_der_prefix[SHA256_DER_LEN] = {
 	0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
 	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05,
@@ -33,3 +38,20 @@ void sha256_finish(sha256_context *ctx, uint8_t digest[SHA256_SUM_LEN])
 	mbedtls_sha256_finish(ctx, digest);
 	mbedtls_sha256_free(ctx);
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
+
+	return mbedtls_hkdf(md, salt, saltlen,
+			    ikm, ikmlen,
+			    info, infolen,
+			    output, outputlen);
+}
+#endif
-- 
2.25.1


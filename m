Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5396E7716A
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 08:33:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 474AF80323;
	Tue, 17 Dec 2024 09:32:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="bNYDs4ov";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B94C180214; Tue, 17 Dec 2024 09:32:25 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30C5080241
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 09:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7KPywYITKGNCAKKhkhP1+K6oks1fvCSwMmXcLbPZ+e6Y/c9nub4WyiQ71UwWh5s7mGLj4728XQyM2LoVWBgVKudFVuVSiGzrvST9P/qhXxl+gNDfXznJT20mFm4pvJ0YGEJgjnysLMei0meLL99CroWDKoEQ1DritB2H2sz5LywpoNPhNa8Sf5mMarTv/laaL4ehcdCz5TlUkLjw1BFnk5ma8g0kSp410G7AtKtuTF6qVTSrNz+f0VoJvTojKyjPtpq2Xxi1PExxL1n7VIAyW6xFfHCbG1/tQqHWzPuKi0RTFs0rODE0jRlBPzO4uacBcPA5i5tRe6mzUi7qx71+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlvAmUO9IzAWCCRm4HAcrdboS9jKL/4azhkIWdUtE8w=;
 b=Sdicz4JupuU+o3f/TQqkHUZ4Z/NjKIBpgdAhzqwNO2FCa8xQYl16zxdBXaUp0X79woHC5TwbDb2Q2T/PRtnwm6NQYQSuV0XKk6encCQf8CS+a+6TaOY5f8RAz42Ep5yf8pk3M79KmGubytp3zKGiIMemsFMb7DnjaV5JxKK0yqc5CUkuHwWG3rzrNi+zrcLCP33HhiBX6CjhmNcJCw6dCVR78bfsIkOiZ5DWvrs0UnaY9gjRJfYnhBZ3tLFRrmnZQwwLrrSTpAwr20FUxW2+kPZM2lcQDtEbRNxv0UcM8QhXUo492sk0Rp7BmN9ZpLzgYl9TCQWxVlOCYy9kRXxqPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlvAmUO9IzAWCCRm4HAcrdboS9jKL/4azhkIWdUtE8w=;
 b=bNYDs4ovS5tW+O9UPaMxW2UgzZ6fwL9JZEEwkWiMOOeVqaNi/+5dl3/gHDnbL2DOLSYKYCL8GgPUOlMzy0v+jjgA/2JPBsitoMl6H1EXmvTfze9J7ygT+r4Z4KxN3ABK/EjlcxWS1z8hx63l8n1nYItnJD0oeBNdWWHJGpJoQOjLzt3XRrQwd5f960dtFLjAtLK/yNWkfQ/Mbc5DglWVaOXxbULHy+WPG++pAkffRQZR/nnoYFynRPg4m3FiEQBptfwpVpeLtk47bzQcrhIi0HqgqaveTVH0EPcu49kmgB3jXGLtCKuXEBn8VzASJ8ghyQjGa8SW91QWxxqzVM1tvQ==
Received: from MRXP264CA0030.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:14::18)
 by PASP264MB4661.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:435::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.23; Tue, 17 Dec
 2024 08:32:17 +0000
Received: from MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14:cafe::8) by MRXP264CA0030.outlook.office365.com
 (2603:10a6:500:14::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.19 via Frontend Transport; Tue,
 17 Dec 2024 08:32:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D5A.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Tue, 17 Dec 2024 08:32:17 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id CF66D20345;
 Tue, 17 Dec 2024 09:32:16 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v5 3/9] mbedtls: enable support of hkdf
Date: Tue, 17 Dec 2024 09:32:06 +0100
Message-Id: <20241217083212.70330-4-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241217083212.70330-1-philippe.reynes@softathome.com>
References: <20241217083212.70330-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D5A:EE_|PASP264MB4661:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 896377d4-b01d-446e-a52b-08dd1e7550c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JL6pfrR6iO3BIITpMYzKFrCcCPM9A/T8/VoKx0iRExnTHVROSn3LOHuXvBke?=
 =?us-ascii?Q?lEbAb7b00nd/bBeTP6vt2lrzbIru7qYt2JD2Bq5yDo7LC2UcvvDfx/pUvPj5?=
 =?us-ascii?Q?26NEbTjyQFWXlh93NZCO19AmJd8TfEkvauimyR4V1kZ7hZvfj2UX7l/NR30Y?=
 =?us-ascii?Q?7T4b4yfwwotgbTXctTwyQBeI9hkW8t9xnApcK0dLkSlBMUpNQjAkmbhCpzUL?=
 =?us-ascii?Q?hfcOihutgIcLyLCDhn6Qv3sjLaZEYPIS7IsMOpAiYfQTBu1TTiSrVEvB9Pds?=
 =?us-ascii?Q?mZDaA6nunIVHPeinrk4quWoOb/i7ei8sftcYij/9/Zj+ToYyjIf1Y9cg31U5?=
 =?us-ascii?Q?Aloyyz3wvN8G7vRFEeQ1h83P/mw7rlpqsJhclLzktuXrOlIKRSCnlwoq+x/Z?=
 =?us-ascii?Q?JwRNfV0QC2BvHRyVFerCoEs05XmvTYaKb4qFn5MLrHQ6NEuPMq5j3aMO7qnT?=
 =?us-ascii?Q?QIVd5ESTfxJnOfXcco+jErLREmEHxPVIsiQR0nucWSs7vEswOn6AM/Msqhyd?=
 =?us-ascii?Q?wGgaVHEfYO5AHHx1U/K5Lq8HZqMKRyJJ8qc+NUzMrUV+md7TBiBdSIAcwZMD?=
 =?us-ascii?Q?oD9nqM2R5AfIi1LPVUetiJeEMPLkG/yuG7pQkDNOlhe/bqzZp0FvhjyieT7Z?=
 =?us-ascii?Q?v/T9I1tiL1Hgg3YBgvoUMgs/tyNeZKp5bcAaw8Ly9rCwT+BrCh2uoa0Cey4d?=
 =?us-ascii?Q?NB0lvqeAhG1UfX0xswChL7CWmFJ2X0zZCx1Af8gGYRLSprf/Uw+qC1ymvmB+?=
 =?us-ascii?Q?Uj13ijUJuF9xlVg6/CL9ZdkOpyf7vBbGYrhhmMbKDH/U6l1nD607rZzfsTtN?=
 =?us-ascii?Q?2vhDrr+GE3CSwRYuRHyyoP2bieL26PP021Wz6rFhSbNluEcuGr8gIoTM4wKM?=
 =?us-ascii?Q?QlZg21U2m86kjgBGi49CGpQxkHdShTVHyE/aYvI2AJHHhYUKPi1CDVIJl8I6?=
 =?us-ascii?Q?MSnyhLvDit3gZ6LOisRK5yEjLxFZdjIErE+fXNaIhNPimPbDx83exOg5xyeX?=
 =?us-ascii?Q?G+jYItfTwLDEkjjklYCp4FROqrSbFmhx+HxUFObw+ooaVXwoa0DSn4PdGHtN?=
 =?us-ascii?Q?ufZcxUS1cSaALpF2K0qZaOxj4BqOYigx8ehrOWzppj1b7yhhjwWZEkEGrntA?=
 =?us-ascii?Q?3nonRp7S56oq97T+uBAsB7wlE394z7r71ofCh5VaKKRbtD8seD1Eac1XWp5K?=
 =?us-ascii?Q?lv9L0HYa9z99m954FnbX7E7G5+rTkrvcWZcohM7phT38JWNy916QT4y70nFr?=
 =?us-ascii?Q?hTU7qzMT0/GAEsGV2L/pYeySaw2W0OCW0qdrIlO7Tw1srwMhPUwDkkcOLXJV?=
 =?us-ascii?Q?MLHZPYMlg9GpxTEDC/nOlTzOcHDJQoq1SvEuNwxuumxAjA7AjCgJbADNxXix?=
 =?us-ascii?Q?UpdjTvK48+kDskjUSgS7rWbSM+YY+NvbkYb+WiLoYKuQmp4Bow9mXSQFQegl?=
 =?us-ascii?Q?TeDQLJLYZJrP6sQicKFS1wdd1g2T2w9JGpi1po1b/ubFE/zB7d5hgzckaq8I?=
 =?us-ascii?Q?PBJqMtIFSWuY5XM=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 08:32:17.0874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 896377d4-b01d-446e-a52b-08dd1e7550c8
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB4661
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

Adds the support of key derivation using
the scheme hkdf.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 lib/mbedtls/Kconfig              | 14 ++++++++++++++
 lib/mbedtls/Makefile             |  2 ++
 lib/mbedtls/mbedtls_def_config.h |  4 ++++
 3 files changed, 20 insertions(+)

diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 78167ffa252..aa82336ef14 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -297,6 +297,13 @@ config MD5_MBEDTLS
 	  This option enables support of hashing using MD5 algorithm
 	  with MbedTLS crypto library.
 
+config HKDF_MBEDTLS
+	bool "Enable HKDF support with MbedTLS crypto library"
+	depends on MBEDTLS_LIB_CRYPTO
+	help
+	  This option enables support of key derivation using HKDF algorithm
+	  with MbedTLS crypto library.
+
 if SPL
 
 config SPL_SHA1_MBEDTLS
@@ -335,6 +342,13 @@ config SPL_MD5_MBEDTLS
 	  This option enables support of hashing using MD5 algorithm
 	  with MbedTLS crypto library.
 
+config SPL_HKDF_MBEDTLS
+	bool "Enable HKDF support in SPL with MbedTLS crypto library"
+	depends on MBEDTLS_LIB_CRYPTO
+	help
+	  This option enables support of key derivation using HKDF algorithm
+	  with MbedTLS crypto library.
+
 endif # SPL
 
 endif # MBEDTLS_LIB_CRYPTO
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index ce0a61e4054..e66c2018d97 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -33,6 +33,8 @@ mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/sha256.o
 mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/sha512.o
+mbedtls_lib_crypto-$(CONFIG_$(SPL_)HKDF_MBEDTLS) += \
+	$(MBEDTLS_LIB_DIR)/hkdf.o
 
 # MbedTLS X509 library
 obj-$(CONFIG_MBEDTLS_LIB_X509) += mbedtls_lib_x509.o
diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
index 1d2314e90e4..fd440c392f9 100644
--- a/lib/mbedtls/mbedtls_def_config.h
+++ b/lib/mbedtls/mbedtls_def_config.h
@@ -56,6 +56,10 @@
 #endif
 #endif
 
+#if CONFIG_IS_ENABLED(HKDF_MBEDTLS)
+#define MBEDTLS_HKDF_C
+#endif
+
 #if defined CONFIG_MBEDTLS_LIB_X509
 
 #if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER)
-- 
2.25.1


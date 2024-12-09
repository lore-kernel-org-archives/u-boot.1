Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3A7E77173
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 09:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2C4589665;
	Mon,  9 Dec 2024 10:42:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="uFLb0cer";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C7E08961E; Mon,  9 Dec 2024 10:42:09 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D6C689607
 for <u-boot+nodisclaimer@lists.denx.de>; Mon,  9 Dec 2024 10:42:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/cpw063esZLFyOF5NxQLVD7C/4D4xgKax9xXhdXnMEHUJ53I7piNoBHA65FDpXsQk7WtK/SC3t+/nmQvh59xtCDgj1h8ECIZs/2X/grIM2RAtDZCquAG5MpY7D/PQWlVwiGm12vkt75zsLfZea6DOgpwVNHq3tM8NOIL867DhrcWFmUQI958vglsgUWTRHRxn7GomOYpT0ukz7JsoRvhlnuDMO3fJ6c+X07QamZ//XgLvnFPCHnryC4G8D9Ym+JqY/zkp8nmN4DI5HqVeoLiBjDEsrDtA20S1uZIB2yDzKw+cgRJrDoea5RyBGxfwt5iDWyk07kOJxzSQG4fPl+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roOlTR+gb04LPYNMLCJ4j7QZd6snuFqqeyLfsEXyHUc=;
 b=A0RtFPfLpsTrls1RKqOZPlZRWCsXjU0JPmBx15BmGTobZt2cX/5IL31QIkIk8woCuLhaX/1lFAnoO7fjgY93uA6jtfYXy3lR0lZOjPHjfwtHujX7k1988cO2uX9+9vGCMl9Ev+98z6rpu5RJAV60utj7mM58n1MhjpoYx7KW1et6ctfBatW9Bwn6EJPpD/OCrvxi93LwvMY4ircgdH4Rz7s+QGuZNzb/G6Tnepu50ifB9KceB4SwartXVZZD3p0FOsCBaDpQqtqbZK6HyaNllAhA57G+Ece0eGt29I5OTbO3ythFKcmOsEsRfs2dCpP0BLhJtCFexodjM4t6T3zNEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roOlTR+gb04LPYNMLCJ4j7QZd6snuFqqeyLfsEXyHUc=;
 b=uFLb0cerTILBW6ixcO1JCXjb5ZfemtqTwAaEutno+QpHo0CR+UHRYAYRCeNMd1PCtpBZrSl3pJI+9wKbesPdxU1yut6MmW2gAdETt+RiOOpl6hdh9NZZPRi4Agk1dKDiCpMwVJlZk68MUDsmTV8B6beqTHAECuPlek050q4wbHWnAk9fVZ4Q+0uwZNBwOR33ouVYQ+wTiDnD2pCOP5ls08GVSN0EgScJduJrsltGT8XmDBFondGMItLjnQDU7zBGfstzJiumubTtQjkyvML52X36bid2J1mHGsvgFA4u7+y0MPE1EqM8voK2xa8VNWlx0q7bjm58f5sXPUdIybMfAw==
Received: from MR1P264CA0124.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:50::35)
 by PR1P264MB2278.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 09:42:02 +0000
Received: from MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50:cafe::56) by MR1P264CA0124.outlook.office365.com
 (2603:10a6:501:50::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Mon,
 9 Dec 2024 09:42:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D5A.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Mon, 9 Dec 2024 09:42:01 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 9C94920345;
 Mon,  9 Dec 2024 10:42:01 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: raymond.mao+nodisclaimer@linaro.org,
	sjg+nodisclaimer@chromium.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v3 4/5] lib: mbedtls: sha256: add support of key derivation
Date: Mon,  9 Dec 2024 10:41:58 +0100
Message-Id: <20241209094159.8355-5-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241209094159.8355-1-philippe.reynes@softathome.com>
References: <20241209094159.8355-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D5A:EE_|PR1P264MB2278:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e19959fe-e753-4e79-81c7-08dd1835bbc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tVFZACESftls2kE3kCaCaYzPiRgYTOKxXETuGxpjA1I1+jxCwC3U1DUnaGKG?=
 =?us-ascii?Q?EwqX+tWC1almgUZ3sXxmopHrcyUiJA26UK+5MVCsKvuJZad9HIrKupJY9dop?=
 =?us-ascii?Q?gObQsyfizECRA+JIykRFnNbXISPSCNKw6zM9pjyEcnseqlS1y8mN1+C4ndPJ?=
 =?us-ascii?Q?ttYDFjSpG3YIIcsZS9s4354xlSaO3MC/A7tUgAnYwpVcJ+MS0338Hs6ywvG1?=
 =?us-ascii?Q?v6u94G8dt6q1975uAlI3jr6CMOwuXHoprY78gMJ2js1WxTvoPIumMt/Wqu4a?=
 =?us-ascii?Q?MQHLa6QKWXw0Ojx6pNrOHGp4r1jgyLepqoSPoV4TCwrgvTdQXsc9J6iXmEx0?=
 =?us-ascii?Q?gy5fyFoQwxYpsPE1i0Ubo364RAePFKVkjz29freB+6yV48WyvUx/slxG9iAi?=
 =?us-ascii?Q?UBtrRqkQLIjqVqHHLN9eXwSSMP33YRl9/aElpHh/j9vkHUokBporUdpnLZym?=
 =?us-ascii?Q?6oN4LKaLmeDyJ1PjVprxx5Crmc7wzVQmfek2/JKD7WkPAN9c94Vlh08+a2BK?=
 =?us-ascii?Q?JBSoyMGuQH8lJQC9wS/+uI/VX7h+jOnGZnLW0zNVbZHAduPNN6SOmaTGybfk?=
 =?us-ascii?Q?ewtufUa3j+EyxZITv0579Wu8c1rCmm2vXau0uycg7BG63s6xyRzOcPYClcPd?=
 =?us-ascii?Q?iIMVvKjtd1KiWPkaLjQD0UuWwCMT1/aAP9VBEdNnpLT8qR1HRz25xyIbvP1F?=
 =?us-ascii?Q?ZTm431J1OddbsOdmK+94uzIXhoGoq/TXGALg7kYY1Cuw4Tt02icBgu0sR/fi?=
 =?us-ascii?Q?mrEMqRet5R4Fax1rX0BIP1mKiNSkwldA03iceGZkSIMVhUTPUkimcNVS397F?=
 =?us-ascii?Q?UUEvTzzaoHDqWAJG53v77O+fk2tnx/WT0D60Oc3mBcUkKmnd4sic4Bsqh2Z8?=
 =?us-ascii?Q?FSqzvhs4067QW92Qtydu5R05+NS0BUa7rawafp++elvyEaH2//79DTIgBk6b?=
 =?us-ascii?Q?H77jA/ySBODrTXbCHHbsE+xPsMB4pOKbhr5wjXOU7B42ixq0g2JhZEaTCEMr?=
 =?us-ascii?Q?bCBuZux935o5ycvXf3vIEETMEaxiDiLGVs4DtIgXhQr2PMRqr9JDVk9CBKHb?=
 =?us-ascii?Q?+8UXwORp1YzR6mQtQbmTCFsitlrhQJZ/Gjgtv3YjK3r2naPUXrKrJHM5IVPq?=
 =?us-ascii?Q?41Mhuf/RUYGfj53xwWUObOI+bG2k79wtk3jTewMVUJjgaOoZDLbFsbvWvAKx?=
 =?us-ascii?Q?0uOJ0DUAgfKSaMVR9pFYAiYO43gBSrPkPqqmXx0AdH8M5lsDBncywf6yZxez?=
 =?us-ascii?Q?VcVaA2TAazzfDxk678MYLYcuwsLO3fLm2QyPXhaLY6AsA63eU6Dvil60VrtP?=
 =?us-ascii?Q?QcPgVwUNQxuue21TXAbKLk42R/AZbVXV2tM5lFdCFXQAFdc41QJnhwHfAV94?=
 =?us-ascii?Q?Hg25CWqkWEO2v5Hc71Y2DpdE2jSRd2yXmxFnYsNnOG9UHCZSD9E3JT+TSCtF?=
 =?us-ascii?Q?PZI7NBTVmHdxHZU32agq3Y32L1l+0hRg?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 09:42:01.8575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e19959fe-e753-4e79-81c7-08dd1835bbc9
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2278
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
 include/u-boot/sha256.h |  7 +++++++
 lib/mbedtls/sha256.c    | 22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
index 2f12275b703..5643efcb85c 100644
--- a/include/u-boot/sha256.h
+++ b/include/u-boot/sha256.h
@@ -49,4 +49,11 @@ void sha256_hmac(const unsigned char *key, int keylen,
 		 const unsigned char *input, unsigned int ilen,
 		 unsigned char *output);
 
+#if defined(CONFIG_HKDF_MBEDTLS)
+int sha256_hkdf(const unsigned char *salt, int saltlen,
+		const unsigned char *ikm, int ikmlen,
+		const unsigned char *info, int infolen,
+		unsigned char *output, int outputlen);
+#endif
+
 #endif /* _SHA256_H */
diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
index 1b9fc1a8503..6e9659d31bb 100644
--- a/lib/mbedtls/sha256.c
+++ b/lib/mbedtls/sha256.c
@@ -11,6 +11,11 @@
 #include <string.h>
 #include <u-boot/sha256.h>
 
+#if CONFIG_IS_ENABLED(HKDF_MBEDTLS)
+#include <mbedtls/md.h>
+#include <mbedtls/hkdf.h>
+#endif
+
 const u8 sha256_der_prefix[SHA256_DER_LEN] = {
 	0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
 	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05,
@@ -98,3 +103,20 @@ void sha256_hmac(const unsigned char *key, int keylen,
 	memset(tmpbuf, 0, sizeof(tmpbuf));
 	memset(&ctx, 0, sizeof(sha256_context));
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


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB20C61DBD
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 04:28:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4CCA40840;
	Fri, 28 Aug 2026 04:28:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xhljFPfPk0eN; Fri, 28 Aug 2026 04:28:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787891331;
	bh=m5B3DKuZfmw4BS1zupVa7GSS3rzR85U+ckO8cHigIZg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KqVsYd+Q+CUjeTKdrsbz3ZrHtIBC+O40imDmec26YxMavRNSCc902tUwOmZhfC4np
	 QnSHEoyxF6FywIEZ0VYV8rNgY7tPEIANsT7Ub034TT+noyMK25goZ0FmFy+wiPeNwE
	 HQl6NWCSi0hSmmvXgIznAZMgQAIymEFG74O8wAjcgYKRKEf65R92RCvSYEvp1zNzh+
	 /wK8G/MTi8lSusFAMfcp2XXD4vxnzHV9KSOzMHUQ6Rks9+1ZUuAxm/EmUe/EByWryi
	 TgM0LOh5v3AFO4P5PhD0f4Oupv/s4FjIUgJ8sfOh+WmKqQRwW0vDV5OP8+4pExbKQz
	 anGhI/AoDr2BQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9205340825;
	Fri, 28 Aug 2026 04:28:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B9AC7CBC
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 04:28:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A02F740176
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 04:28:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BCIT96iqdAUD for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 04:28:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::1;
 helo=ph8pr06cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=FK0dp7f0
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A39B840111
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 04:28:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuOzOPUmXieCei1XfDKxpIV3ZzpXQu5sLPBM5yfTGhdaqI9uYenUI9d48XIJHoGFfuJHjdHq9K1URg2S5Q78Z+4fhx4zLqe33iq5GcWY+geIgq1OffviI+LgsXdjWwejrjfHntRGrVM6mSjdk9ZTeReUm/xPIVakQ+46bfsfmXt/ebKBUe+CsTgJ9PUpBZRiA+zmgVa6S3xxyj8KF9eipt9aXCTHOIKcG+dFtBhwmQvBxYqLnoykPf+3ciQOIp6ETUXFovzVcmfzx/pMzYKDioXYCaSbqRRz3idoF6BFQIpfhN6LwVKLQtyTK27+eWDzc9qectYfrncOC6s5OUiFXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5B3DKuZfmw4BS1zupVa7GSS3rzR85U+ckO8cHigIZg=;
 b=qkBbpfSca3VWBbp05tO5XZPZvP8QSBAVIxyQYGEJazi4ZpjNAwBDYvjfUFmkcYVmMSAajcTr8Ueqcvowv/7PQPVErknKBAcpHVrwMdUO+ugMR12NkLJihzltLatNhdOzn9R6isFYmYXyq2RG7uP17LwV5Ck4pfQqdnbPHFQTzdsVjx2PmKzy+si2rJYDPcpONZzzhJ4jqKppOnLQxveTa/ngCrkGfi9VRQq5gI2cO1myz5/H8VuyLjH6PuBHqpOG7EHpikkKSJ68QNn/yc0wxTiYUE8uK4Kf7MB/50v18zzV2cAwG5El6llMNo/EgO5uH0kvUI2yUI7uoPCNHXMK4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5B3DKuZfmw4BS1zupVa7GSS3rzR85U+ckO8cHigIZg=;
 b=FK0dp7f0HCETgDMhT4LmIukPVrfZKByuoq2r+GToitahP/ovc20BSuZNxlf2tMFVx00j9I4c5UCUOI6JEKYvM3NsLrin/5eHWpgSIT5M+e+47l5oHslTHfWb8UqGa9TRyy1GR6klQUYArtjmj+NMFb2jNPFwKrdQI7qnnZzxQfk=
Received: from MW3PR05CA0005.namprd05.prod.outlook.com (2603:10b6:303:2b::10)
 by MN0PR12MB6032.namprd12.prod.outlook.com (2603:10b6:208:3cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 28 Aug
 2026 04:28:44 +0000
Received: from CO1PEPF00012E81.namprd03.prod.outlook.com
 (2603:10b6:303:2b:cafe::6e) by MW3PR05CA0005.outlook.office365.com
 (2603:10b6:303:2b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8 via Frontend Transport; Fri, 28
 Aug 2026 04:28:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E81.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 04:28:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 23:28:42 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 23:28:41 -0500
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 27 Aug 2026 23:28:40 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/2] lib: display_options: add snprint_size()
Date: Fri, 28 Aug 2026 09:57:57 +0530
Message-ID: <20260828042828.3421664-2-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260828042828.3421664-1-padmarao.begari@amd.com>
References: <20260828042828.3421664-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E81:EE_|MN0PR12MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: 15fd056c-9f4f-4276-d461-08df04bcd80f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|10067099003|11063799006|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mC+cgLyAXHAwmfjmYyHI7HpDUwKM9ElQedAWO9HMi9C+DPjdsU2LbXvJ9TkUaLbrW8oZAEN6DfdQwA2m+gosnbxH9HxLmaI15hBizN7EPKSSmK59iSBNAikAC+nTN0m4mNfhV8JdgY2d0If1p2ecogL3bbiZ8hLVOHnUcbu8j6bIUQSro9sB+7aNpnEhGSTiU2cAKoUxXevWO0/Sbhl2iUKrkJZwYqRMbAmbqMuA7tbCeNawhOpL6Vsc3UdAve7Za+r8Gzx9rQR4Dw+ZtMXPMxTBJdVRp9ogK6rUXyMrrSC3i6+x6GcNF5364fUSAWauKkcu1fsnrL9kTJ4UdKt8abKpDRKMnKUg5jRzCmRQO4M14REjga+s8GbvQcZoiA7TUNkPTl+XZI/GqvoraIXKRsa9c/2Wm4mBxhUtgamiryUDOtE06T5UIXVra3akP6oHXwqsTQk1/MhalB2poDBynhhfsAUw9YYJiiRLWCpov3ZxRJh8Q/Gd0G4GAWumfhlhWAkMbpLpwS5GY1i/yzId74pT0btm+py6fLsTVqyFNdJ8unkd4a87Vd0DxHbXheKcj+saerrfZAcnCK893EejBSHM5Gv+NJped9CJwCr8XDlKqw5Gh2ZzPjEGMjzjwBcm/21wHeNk7cahNRyhryr6nDoWKgWr/CbPnLCWXxoKG04/y6Jb9WhFsSxEvaXx5RQYToQF8kzaDMZfXXWlxWcUtQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tRIayxS0XavyONTdQ/XjY8hosk27M6V73bGajRfUda9Azc0FZn8SgmCXRExdfHbeMRsNEFV4g775o6oUKkFzSrVp2w8wfBB71KkV2b9YPR06mJMsPkoIA2Gvmt2eTOkOpVi9ZnUAzenlJKPSh1LT/HxVzINqLlcPLYZ+VqGjsmjmnyuru76pUMwK9VQ5yB0Yxe/hVwRffajhOhnRxgq7OaRBkwKi4rrLrcGTXrQyn9VcGEBx6NtSDwdlpX4XZkyxMVF4u7qo5pgV1n+zQh9dW8GCGvwbsoATBiDBzRbDNwtRKbbwDKypaCNQM/iqzF69on6/I4fV0573pwITxvN7KEDiVOlU1XlzlMYIX4LYWDUCh7CW71DcXv1pBHOA4gl5ZbiqzjgiZRo+7m5nsypJzAwCcla3XsxktL90w3yaO6S0s0HghG7rGY0GPbTb1G2Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 04:28:43.3794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fd056c-9f4f-4276-d461-08df04bcd80f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E81.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6032
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

print_size() formats a size with a binary unit, but can only write
it to the console. Move the formatting into a new snprint_size()
helper which writes to a buffer and let print_size() use it, so that
callers which build up a string, e.g. a boot menu entry, can present
sizes the same way as the console output does.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
Changes in v2:
- New patch, replaces the open-coded unit selection of the v1 patch.
---
 include/display_options.h | 18 ++++++++++++++++++
 lib/display_options.c     | 22 ++++++++++++++--------
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/include/display_options.h b/include/display_options.h
index 66e59607737..2baf6859917 100644
--- a/include/display_options.h
+++ b/include/display_options.h
@@ -11,6 +11,24 @@
 
 #include <linux/types.h>
 
+/* Maximum length of a string produced by snprint_size(), including the NUL */
+#define SIZE_STR_LEN	32
+
+/**
+ * snprint_size() - Write a size with a unit to a buffer
+ *
+ * Format sizes as "xxx KiB", "xxx.y KiB", "xxx MiB", "xxx.y MiB",
+ * xxx GiB, xxx.y GiB, etc as needed. Sizes below 1 KiB are formatted as
+ * "xxx Bytes".
+ *
+ * @buf:	Buffer to write to
+ * @bufsize:	Size of @buf in bytes
+ * @size:	Size to format
+ * Return:	number of characters which would be written if @buf were large
+ *		enough, not counting the terminating NUL (as with snprintf())
+ */
+int snprint_size(char *buf, size_t bufsize, uint64_t size);
+
 /**
  * print_size() - Print a size with a suffix
  *
diff --git a/lib/display_options.c b/lib/display_options.c
index 2c15cc5b5c4..287eb247061 100644
--- a/lib/display_options.c
+++ b/lib/display_options.c
@@ -93,7 +93,7 @@ void print_freq(uint64_t freq, const char *s)
 	printf(" %cHz%s", c, s);
 }
 
-void print_size(uint64_t size, const char *s)
+int snprint_size(char *buf, size_t bufsize, uint64_t size)
 {
 	unsigned long m = 0, n;
 	uint64_t f;
@@ -115,8 +115,7 @@ void print_size(uint64_t size, const char *s)
 		 * We have just checked that the size is small enought to fit
 		 * unsigned int safely.
 		 */
-		printf("%u Bytes%s", (unsigned int)size, s);
-		return;
+		return snprintf(buf, bufsize, "%u Bytes", (unsigned int)size);
 	}
 
 	n = size >> d;
@@ -138,11 +137,18 @@ void print_size(uint64_t size, const char *s)
 		}
 	}
 
-	printf ("%lu", n);
-	if (m) {
-		printf (".%ld", m);
-	}
-	printf (" %ciB%s", c, s);
+	if (m)
+		return snprintf(buf, bufsize, "%lu.%ld %ciB", n, m, c);
+
+	return snprintf(buf, bufsize, "%lu %ciB", n, c);
+}
+
+void print_size(uint64_t size, const char *s)
+{
+	char buf[SIZE_STR_LEN];
+
+	snprint_size(buf, sizeof(buf), size);
+	printf("%s%s", buf, s);
 }
 
 #define MAX_LINE_LENGTH_BYTES		64
-- 
2.34.1


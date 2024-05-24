Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CE2C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 11:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B059188442;
	Fri, 24 May 2024 13:23:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="uHXgUv+a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9139E8865F; Fri, 24 May 2024 13:23:32 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 784A2885B7
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 13:23:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyT5joAaX7GIotJNZFjQdDw6Eq3Bw8u13132iXTA/Nw9dLvfkuUgD8dDQM8t635g8JXBaNoBHQvu4QbjeNK8gSBuBI21IaFsGbl2J8IZFOwlO6/hS5iEMaf1NjkYZSztORyzWyNvN1V5h4iRZotXQpGIDFkWNXGIwq80wqa2mB2g5VQArMQrF7+XQ2RhOOjNqD7ktYJt34mRPpgtkOVUu2/zJVaMFIAYxDVBAipxvcfLYagtzjAcBbr043xrVGb8TRp081OYQVzb9NxLysbidBNAZrrGeDDWYWAsLUlkGRQqprFEjOm8/Mc0g1LBEp8UeLqqbmnHWM+G0f6ALsHlLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEwgTJSptyXqklQpy6vVwhKQYl4CGYDSLTuAMPWoCRk=;
 b=J55QN6UNdBsuk10gkU8SA8r+QZ2aFdntqGHogK18n9bCXnKSuU5Ia2wOwdQqxsPmmm3FtVmf3gJNol9Kn2bHRY/afE2mPENAiHXDsabO1qbKlIhNYYjLv3yEZvs2SR+jo1tD2tG0W2dADkxz+SzHuAcdQvOCpXTDP77PwLbWcDZ7/yA3yfKfvLzmhauAwhoDo/5lNTHHZ7ooFmIacP+DICVTk0V16kGvhdwvIUAx7/ml/LU/S1B6ZDd5hZgmfDSXdC1hDLN24LALNkn9odIup9drVlrZT8chqiqqcL6t+XbhApMIXd3GXl9Qwx3fGqwOOVdgdw4lNRkmiJOja6iLJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEwgTJSptyXqklQpy6vVwhKQYl4CGYDSLTuAMPWoCRk=;
 b=uHXgUv+aBSmFRI+4AA6st9vJCZE6BjYbpNk9EIj+4GLRnOD/YkJgCiZzw0T43UUXsWu4c+z3dJ895wXpZi6+qGL0saeUay6plXnVK8GYYKTz/hfpr+aZSONuad9+Kp7PFu+CmuR4xmXk4doCpExmLIOcF+rMTXIl8A0mGKxXlG3tdYdRim4usG8Ex0PrlqcIZ15+UswjBo58wydMflrN1y65KkdJSq49xdBik+kYk0hkIxTSsSomKc648hJd05R/9EKkdtiCQl+ZW6gZ3WPNsIjmalzXT7sgJLiTsRQJ0a8OXhgriCwmk4mxpRR9uFver3BjBV+hMmiUh2J3xLbU7w==
Received: from MR2P264CA0118.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:33::34)
 by PR0P264MB2567.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 11:23:27 +0000
Received: from MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:33:cafe::e4) by MR2P264CA0118.outlook.office365.com
 (2603:10a6:500:33::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Fri, 24 May 2024 11:23:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D57.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7611.14
 via Frontend Transport; Fri, 24 May 2024 11:23:27 +0000
Received: from sahess08-ThinkPad-T580.softathome.com (unknown [192.168.72.220])
 by proxy.softathome.com (Postfix) with ESMTPSA id 9F2A920080;
 Fri, 24 May 2024 13:23:26 +0200 (CEST)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 1/3] aes: Allow to store randomly generated IV in the FIT
Date: Fri, 24 May 2024 13:23:18 +0200
Message-Id: <20240524112320.103304-2-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240524112320.103304-1-paul.henrys_ext@softathome.com>
References: <20240524112320.103304-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D57:EE_|PR0P264MB2567:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 391a8bb8-03e0-4232-cfe9-08dc7be3eea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5hH0Ydtez1ulbJBr3h1327XhTiI37bxmBnG4fxOeospR0z+h86NijwJreJCz?=
 =?us-ascii?Q?UsMfVFEX8tofftf6MIuWeNMFw1gYZ9OfMwh7SYlCYvyP8PAXZ02Y84nbwOu1?=
 =?us-ascii?Q?5H5vbyXgXB7qN9nHW4s67Wvb2Ofk4E/ppFih33iUA+MUBjtJV/mCTCSaJCxB?=
 =?us-ascii?Q?ERzVsUgqIJdeW/KRKq4vSz++MMDOLxALLZBb5J1pyD5JXqlAnGmWdgnfzy4R?=
 =?us-ascii?Q?gevNrO6XceOyCY34ArGfu63mmVhHLaN4JzNUY65GW7QmMOgmfcJqOtRN17hR?=
 =?us-ascii?Q?yvXu7tWuSMCg/4XMlBYpIEKoDRUgAocqhQsURPw+r1sT14jiTZT7PVTJVZKW?=
 =?us-ascii?Q?c80FBXkMO6hqMcoWiwMkKsr+HP7HxK5Rja/LLlXIOha3CgQbwGY3PpmKsdxR?=
 =?us-ascii?Q?sC0RZAGXj7MXZSf9OVfFI/0We4ufvHL6F3AO2dIfCh4Tg1gGN+EsQF71WjcE?=
 =?us-ascii?Q?5ZMMKqG8i9hQPYgumfzpo3PjKnH2Aj0+bXPb1jHAAK2LumYyHiQk1VYjlISe?=
 =?us-ascii?Q?M4vEvTE0ivriqZ53IpDUUpa3wqIZVt6kukhRfTVUqOMK/5cCDUOhYyFzndhp?=
 =?us-ascii?Q?pz+x6FTnjftERTYpH99l8kMi3H7uQ2wcEwQkUYhQBwun+02QyL++8XBPoZc7?=
 =?us-ascii?Q?fKpb/Qgek8KT3hMITNK3jK0GomO3k3Se4U1qQHyOeV631LH1/7vYQD8QQjEM?=
 =?us-ascii?Q?pRIK7J+OFCTEZeoWDhPy0Eqtfcq4YxA7BP7lpzooYNKop7ZcrCZePdRr+HV5?=
 =?us-ascii?Q?CUuFa97A74y0Xn6FRc7IlnxgnRI9tT2v188IO99bwlwoht8J8VmoqSXy2T91?=
 =?us-ascii?Q?eZnmIV/lbSZ4DpJO+Nm0PSzC8QQsz0WLgXBu1U6/tqZzfP9mqIq1nCUF4c9K?=
 =?us-ascii?Q?YTRtpdByiu1y92N+U8G0dxI49SpeFWxOjpjaLJCjf695fR21VsiTZo+RW7l4?=
 =?us-ascii?Q?LsYjmYlyPEA8kJZwnhVaAYCOjBDian3iwmVrcfqjUBwqfvr2hAspYbMoY/Ui?=
 =?us-ascii?Q?LV6MjtEr0zMDpKB5ka5ea0L6/jQxQnxuI1j/0pkr79jwyZQeEgu9J3c82U4e?=
 =?us-ascii?Q?jjceAg233ZgoYrs3vfLSHGWiI1BFLRm1u6zsST15d6E/nPOpdQpjVDYaJDHT?=
 =?us-ascii?Q?XSwzapudAeSYA2tg61fbDR/o599AVRrs+dhXF2BXOrI8Jo3KBpbRxDUnHAVQ?=
 =?us-ascii?Q?tXGc8j/xaK+QC/KkxOi+wD74k/1SLQzV7shoFzDTT9gJWQD/LOfSgzhhrch4?=
 =?us-ascii?Q?Y5BMBx+vYedqn1/LAsmTWSi9rb6w1dHx3e77TdMgRXYroY0T408vPRi84Lkz?=
 =?us-ascii?Q?/McxeoleFU2vkUS7ui+JGCNPMsiptgg7kmv3hfEtQp7XtBUnKO0xAcA9I5AW?=
 =?us-ascii?Q?TNccFK1OsWXKp0+h5UGK/Jc+Q4Q/?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 11:23:27.0517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 391a8bb8-03e0-4232-cfe9-08dc7be3eea1
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2567
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

When the initialisation vector is randomly generated, its value shall be
stored in the FIT together with the encrypted data. The changes allow to
store the IV in the FIT also in the case where the key is not stored in
the DTB but retrieved somewhere else at runtime.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
 lib/aes/aes-encrypt.c | 7 +++++++
 tools/image-host.c    | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/aes/aes-encrypt.c b/lib/aes/aes-encrypt.c
index e74e35eaa28..90e1407b4f0 100644
--- a/lib/aes/aes-encrypt.c
+++ b/lib/aes/aes-encrypt.c
@@ -84,6 +84,13 @@ int image_aes_add_cipher_data(struct image_cipher_info *info, void *keydest,
 	char name[128];
 	int ret = 0;
 
+	if (!keydest && !info->ivname) {
+		/* At least, store the IV in the FIT image */
+		ret = fdt_setprop(fit, node_noffset, "iv",
+				  info->iv, info->cipher->iv_len);
+		goto done;
+	}
+
 	/* Either create or overwrite the named cipher node */
 	parent = fdt_subnode_offset(keydest, 0, FIT_CIPHER_NODENAME);
 	if (parent == -FDT_ERR_NOTFOUND) {
diff --git a/tools/image-host.c b/tools/image-host.c
index 7bfc0cb6b18..03173dec5f9 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -535,7 +535,7 @@ fit_image_process_cipher(const char *keydir, void *keydest, void *fit,
 	 * size values
 	 * And, if needed, write the iv in the FIT file
 	 */
-	if (keydest) {
+	if (keydest || (!keydest && !info.ivname)) {
 		ret = info.cipher->add_cipher_data(&info, keydest, fit, node_noffset);
 		if (ret) {
 			fprintf(stderr,
-- 
2.25.1


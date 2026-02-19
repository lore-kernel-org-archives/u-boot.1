Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0E3E9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:26:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 801EE83E1E;
	Thu, 19 Feb 2026 14:26:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="iKVmcwX5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E31EC83DC9; Thu, 19 Feb 2026 14:26:14 +0100 (CET)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA02F83AC5
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:26:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOt2oa0JOe1EtcsA7+67X3EfRYZtmJ/r+sAUTbDwrBqoNX/n5elMsq354oc0PZ0XrFTH3AzXDHM8+LAmAbUcfbdZtbdu6PAY4Uhyb7Da4C+hIcAypArzs4kgu5THHpXJrCI7g4UFbZzRLmD3rhee6IJqaGPs/MEcp6NrzJktU2wN94kRZHAoOE46J/Qf7srX/S2HXtAPKaG4VK76ktshAl0huadrG3/er1313oLFkbai3lZeK6ac0kX4eQUrMogbxCjGR10psr3+MG1VmnhP4moVhWbjIyiy72vJ3MJM9wDc8Ein5XjTw8OKIupEbQOsL5dKEC51YezsplWiFEfhrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxxEFaRN1/McFSN3TJseBr7AlQ6BaKSlNMJkpfHxHl8=;
 b=ArTQ6dEuZ4lLqvDrv4jCrkzdPLx9Ccm1HlLwrEYt9NYMZbO8U1q3ARiaMHV6LtTU1ZRSqi/P74OmwONLA/tpTdcOZx5UpTepo9dyKixqJjNn6ov9zsdgE4KfXuuRIZmt+lICeGGERAAbf8Q1mZltuOGAXKoOaqOQC8O/fT8q6naooXj+s+TCN9hZk+ki06yUzyIY3VJvwSFiJW3N4d4hiHDUVFwuIjhhAFiMPhgQ/it19UZ+m2bYs7PhzD0eTLH5bNUzLNgV6cuaUuqVYqLKE8aPkCJAwYGWle8w1rJaJNOp9yG08dreKw819+dv4bxmrcJnZaDmOZOOizZ3Hei5pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=gmail.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxxEFaRN1/McFSN3TJseBr7AlQ6BaKSlNMJkpfHxHl8=;
 b=iKVmcwX51tkVeu6xVp8mOoa7e9t5BnBzK5IdDdex165ya7edBozwiYMZBmvvGVQZOf5v1WKVY3gqloaAy8hIYiqYfhqd/XwqJAlFq5b2zFOPipl299wkwBy4G87R/yCnPztII3fShqC1f8m7sxil6gvcMsvMfQCDtixKrJtKSbrwY+fshtHDLk1YEmxfwpXovFINJ9ucc5p6Bq80krAyr023NUxHJFCSBZEQ+8uWvsicM6idijoLcsafcTwjtepvXD7g2bSemF3Yzumsu3Fl/tKqY/jcvxaLQ3lTVlScZakJ7Pml+mASwYeWOMewJaXMWbY+YdZhCdCssxykGNFwgw==
Received: from PR1P264CA0128.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2ce::14)
 by PASP264MB6917.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:541::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 13:26:10 +0000
Received: from PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ce:cafe::e4) by PR1P264CA0128.outlook.office365.com
 (2603:10a6:102:2ce::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 13:26:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089BB.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Thu, 19 Feb 2026 13:26:10 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 0D3B82042F;
 Thu, 19 Feb 2026 14:26:10 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [RFC PATCH v2 6/9] test: dm: ecdsa.c: clean this test as software
 ecdsa is now implemented
Date: Thu, 19 Feb 2026 14:25:49 +0100
Message-ID: <20260219132552.1499698-7-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219132552.1499698-1-philippe.reynes@softathome.com>
References: <20260219132552.1499698-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BB:EE_|PASP264MB6917:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e54dca66-19f8-46ec-49c7-08de6fba7231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NH1BGPUB2xkJvsN9ipUa7nD5VEyQ1H875rDVyYX24sO3YATiswN4BvfeiTVd?=
 =?us-ascii?Q?Fs6mGZG/YGXd+Gc9yXIc5Dtt5uivQ/Qcncl26Tb0qbbgFJCVZnGmdHc94W5o?=
 =?us-ascii?Q?Sl+9F/VptAT9MIPruu04OpM74S5Wjc8pjcNtHTnPT1E2axTn2/wSLseSrmKM?=
 =?us-ascii?Q?k8h+/BXtXBb3pL8FgKrpSpf0hC6C1pZq3hvd6fPj6fw+I0nim8rQk6+pJQBD?=
 =?us-ascii?Q?Q85Vg7FpFTNQKLhuk/+iTtpEUWU4sLzENdTB9YdFydfP5Ifb/QSZIhhudaN5?=
 =?us-ascii?Q?LNlpzq6uUT7eDYBB5U9a8yy14O4nPewH9G79Fradfabet9Wt4hiLaqBojJRb?=
 =?us-ascii?Q?k3SiLpCd5o+5hrC5hDFA0thRsoSnqdBdtiEwUn5DKtBmbEypoUCMjHd9fwn7?=
 =?us-ascii?Q?TEZpRZ/rfe0cl0qNsP3fKkFg+xZUDJdc/9sd3TwXwTQYY2nFGTIC6EnL58l8?=
 =?us-ascii?Q?Xdw+iYSMMCc/1azT7v2SDT3Z8b+8ho2t41CnzT7o+a90Ci1LBqCA/r9Doxz+?=
 =?us-ascii?Q?cku31bkV3RGMPkks6Ze0grXcmWxh+pB7BvUmxgtOBAZ15BiukGOfF+Dc4F3S?=
 =?us-ascii?Q?9kJ2M4UgsIRkn2X7Czxl9Kzr1PJm8WDhS23tCcVJj9tgR2PKKVMuch2OcBpp?=
 =?us-ascii?Q?f/jLE20MYbZHg3Z3SjxqfVkOz84ScRI1rbTQ4hhzCdOIxXL5MxwY5xDRUOMH?=
 =?us-ascii?Q?IQnAkO/Lv6aWV7lFNv/tRPBzsyL6l8MUw0FAjlvKIiUz28RECXosGWz9a/80?=
 =?us-ascii?Q?4rZUq4nw7W79Z6oK5V+bZYWVfDtDn1AAmDCVupEpt83l2yiSnC5e/cbtHbBB?=
 =?us-ascii?Q?2eVWAX2YJ0ccHpteuHRfVkns5cCsCSoWZNSJMEMKSFiaDC9mfSSt6iz54nKs?=
 =?us-ascii?Q?TudXXpGvLsrNSiomJJEM6pKSI1PnawF+OsVqKZGEvfwWBo+iQcRIH33F7roz?=
 =?us-ascii?Q?hfrmLnDpXn7lak75WiGvEvbq/7wSpPP9mTm0nTXqY9xLOUIe0EMMIhTM/K5Y?=
 =?us-ascii?Q?fTikAFkyAK+hWKQlwzozJI0Nij3MpC4UbwpzqV6+L7vCk1UT91+4jhV8jnV2?=
 =?us-ascii?Q?Lp5jalQ/YVFDNm1nyFfCp1t8kIRTSdG0cUBbZ3xSEMTTElBve1Ap7SlA9seu?=
 =?us-ascii?Q?+RFQCqC7/uDXd+PIYaPFU4GshC5fQP8a5FeIUZq1Ku+Jb8PyCzsV+7GKSCEf?=
 =?us-ascii?Q?DnYO06ReceyrxQFBH9yX6aU2pN3X4Cz+wCHARqT238fEFnksBUmp15/sJ/fK?=
 =?us-ascii?Q?RnfcXMr/ORXe5LDLz2DLMK1PNBxxDmWlTi8Kt7uSMKlvL7D7oslpeH5hkSA0?=
 =?us-ascii?Q?UVVY3AzPzlt9lsb7PnfaZ5/JzAwVT9tGFqNWwiNwRt3YEniHnTliSzPF8FJA?=
 =?us-ascii?Q?Bzfo1bLHiJtyrQNwQCqZe6NEpRlhR6IhOdjm++uD89NgnG/6+vzh2Kaw4Xlb?=
 =?us-ascii?Q?vyXH1OIgqZe3i50pm2+Jvn+0kbqJq247Lnlpl0FkgDHDslfkbOF2HoiwrLSE?=
 =?us-ascii?Q?nsUgBZ/9YdS+gUniHM3pu6TpHVqN2b781qWKXmEfgZdGiBVglkznVIGlQW0h?=
 =?us-ascii?Q?7NrkAP+SNszXmKZi+d5USfknAgGUeWwyQe3V9wxInIdZSfH4421b5nQf99LW?=
 =?us-ascii?Q?hKOAvxx17BpktZ/PD7KsgRaZFkJktYMtrVLUSF4eloNKRuLYfPMPSsO0RxxK?=
 =?us-ascii?Q?U2BUzA=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zB+gIaATJyAHW5LlHoZhF0nkhuQcJjexjkCa2nmE5HQnLCaln/MySxZOn9slJ7Mdfv0huKXndckan1hg6w4UAQMbGPZd4kARAWQii4EkMToR0L0ASLcqPmGFYVF79vnTp2ucodsrPvZecpxkZO65I7+aji628Kk6TgF0ohq+ycXUyqzCUsVDJmkzl0wDkKJbInopwhHbtzVrNV0LSm9ypdOC+2bTFH9QGtt3QMg0F4nNZ1SID5X2q/ZaWegKd4LiqMCmIcdXyFAw265ksss3c2h8SVlgqT7ftS8jAbhOEaYYgthaig8HPNc9fYLIAwinPd8EwDK8hQcc1Gtz7dGEdjcGBcmrQbnEYcvNPEl5a45B+1Z7bXWGIzrbIc4Ax2G6TGsyuAlyIkY1xevuMAqVcMsWu/fkfRl7VNqVC+2UI/LQV4RK2F4KdF2c0TFP1Ax/
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 13:26:10.3169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e54dca66-19f8-46ec-49c7-08de6fba7231
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB6917
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

 test/dm/ecdsa.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
index d7eac7115f7..074b4b25576 100644
--- a/test/dm/ecdsa.c
+++ b/test/dm/ecdsa.c
@@ -9,29 +9,15 @@
 /*
  * Basic test of the ECDSA uclass and ecdsa_verify()
  *
- * ECDSA implementations in u-boot are hardware-dependent. Until we have a
- * software implementation that can be compiled into the sandbox, all we can
- * test is the uclass support.
- *
- * The uclass_get() test is redundant since ecdsa_verify() would also fail. We
- * run both functions in order to isolate the cause more clearly. i.e. is
- * ecdsa_verify() failing because the UCLASS is absent/broken?
+ * ECDSA software implementation is tested in another test,
+ * so we only check that the class UCLASS_ECDSA may be reached.
  */
 static int dm_test_ecdsa_verify(struct unit_test_state *uts)
 {
 	struct uclass *ucp;
 
-	struct checksum_algo algo = {
-		.checksum_len = 256,
-	};
-
-	struct image_sign_info info = {
-		.checksum = &algo,
-	};
-
 	ut_assertok(uclass_get(UCLASS_ECDSA, &ucp));
 	ut_assertnonnull(ucp);
-	ut_asserteq(-ENODEV, ecdsa_verify(&info, NULL, 0, NULL, 0));
 
 	return 0;
 }
-- 
2.43.0


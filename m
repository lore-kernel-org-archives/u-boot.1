Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5553C3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 13:35:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8FE688902;
	Mon,  5 Aug 2024 15:35:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="ePI+HfWw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD9DD88906; Mon,  5 Aug 2024 15:35:32 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B81C1888F8
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 15:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOjpK0xRynIO3DbJjRcmgC7qjXS8FSZ6cd/smGtkIs+QG3//O/Wm5xLaYHx09flIgod/J17HmwVS6g4U6y64ngMJ3QCI/2zO0Xv9v3Qw7/uz5auVxDxBquRhYnLPWJc6jf60+40xANcMrLzPJTeu4c+cGNSVJgZoiGBRLskYknJv4t0z1TmL+SW7690n1ByEL8q81C4gVnQRf7NUF694XrkdUA0krOw8OsBmHUarW7N50flWLDYmTxETOiv7T91uhtIbgz8XOsWCQWqyWoxd+kkYDxfv78Ydk84dozyNgp5L/ERcX7HOSLmn8eC/q+nf73O5ncwp3FuNE8Ytcma9Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LrkXb+pqXex61N3lWw4YHih2PiouQmXKzh0G4sv99o=;
 b=yfh1xtbv6WeckpTEjFTmF5wOd2OA/47+VslBiYhKUYRiZNqjIiuXoHK3GyO9GCQyBrA/yIyHfYFtsD8o8A+QTwK8y5WfmmYBSNhZVsdMLh/6BbR7i3cea/A3BfU20GRNbodSCqXjQcFyMB0EVDHp8309u+pxyzK+4M2xPZw46+lhZAyke79pJeis5Rj+xVyp+QV4swppQzT2gOo8E4EdYubSIfNsEVtIKgBNs4Pmx8XDVxjxRXf2ZrWmAl40ctPHn/5SqXU2CUaYNKtaKLQ+X+fkH3A55D2/tYU8hU3RROdSJoAePwNoHlLg0rDC2Bqwl5Ub/HQrWOXmeAAL9V92KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LrkXb+pqXex61N3lWw4YHih2PiouQmXKzh0G4sv99o=;
 b=ePI+HfWwI/ZP57QDyv2AchxLqPiU968n2CG4DgmPoH6SZ5Z1Wnjrdpu9CpcrTruSzEQjZZhOPrfNluUMqaJDlugXAU5aCWEsq5IWoXKpc1bnAtkaRaJSPnN1f4/RdgPuNXhwxHxTjEKya5YIKLquGtF50qym6w6J3FBzV8lX7OfyvfTRfMESstc8GxOqwcFb1me2HbuOo40vHQvnDoGGIx9rREBkip29npeeGUb4bVgBoqB9BkGugyT/27PswAZyVPVkHpxZZlmpMG7/oerZ4hILCWi8dJ/OUmWzhYlwbvGlMtPcg9QwDa+sr+d3sBV2uD8Qxp1OuZDHrYKarKIfxw==
Received: from MRXP264CA0048.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:14::36)
 by MR1P264MB2417.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:32::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Mon, 5 Aug
 2024 13:35:28 +0000
Received: from MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14:cafe::95) by MRXP264CA0048.outlook.office365.com
 (2603:10a6:500:14::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Mon, 5 Aug 2024 13:35:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D57.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7849.8
 via Frontend Transport; Mon, 5 Aug 2024 13:35:27 +0000
Received: from sahess08-ThinkPad-T580.home (unknown [192.168.18.10])
 by proxy.softathome.com (Postfix) with ESMTPSA id A0C2320070;
 Mon,  5 Aug 2024 15:35:27 +0200 (CEST)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org,
	Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v2 1/3] aes: Allow to store randomly generated IV in the FIT
Date: Mon,  5 Aug 2024 15:35:18 +0200
Message-Id: <20240805133520.1745316-1-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D57:EE_|MR1P264MB2417:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e79707d5-84a7-46c5-f0ec-08dcb55377fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6wGommEanFr7nUJm2smtyLaOS/ogEhnsud/Yj4RQAb1L/Qz4eDzMPoOLYfQU?=
 =?us-ascii?Q?tISJMsm913CYqmAJsOFSgvf0fBYAv0o1A3tvHibfwekjMvjxQy5MG44hqGjV?=
 =?us-ascii?Q?tccXqq2LIi1I81f2B9g1COeQXoYGAnpKPPtZOoaVwq1prk/MRFpJ2WEI5o2M?=
 =?us-ascii?Q?jMA5A08HkdENLAUR4oLayD8SjS6D9AJyAA4P5kKvic50jhmwGB5QRp+XrEPN?=
 =?us-ascii?Q?YRd7tn/az7yG9Aicyp0f9sLadgfyYGJJLgbZRo6W80dIIIBouZGb4fmgSPrQ?=
 =?us-ascii?Q?7srNubKDiB0QtUmqM1rlv0lbf5ABjysMol9tSjW2abDqib92dcQ2bO5FO4nV?=
 =?us-ascii?Q?6+gguXN8oC0G2QM4mTUEG38ZiiXlu3Fcyq/JOF+dAjFRlZpA+E3Yb+T8wu8j?=
 =?us-ascii?Q?9ehAVAOXC9QIt3+IC18Zwm6oHlqJtLuWI7qbrcO6dXSbnpzzN6BJiWTHxMwG?=
 =?us-ascii?Q?BCbTG7YayTRIHYP4pCQ+CSmVfLaMohVkFlbKHFNiqtZ4Ho/a5aLduT19w8Qp?=
 =?us-ascii?Q?OJ80sKVcB9CufErqLCLtw6HRUn6/xU+awd2iHyZTReOZLfGBUsnxqFCahzL5?=
 =?us-ascii?Q?MC9ZDMytDPSczha7eKKbxiSAxPZCrF8XBpb931QxJIPZii3Otbln3cpUaxGv?=
 =?us-ascii?Q?n+gHMFdVhQTKpmNGBFvYHJmAMuu2N213NPEFpDt1/wqi+Zq+DRl7kXDIcIJr?=
 =?us-ascii?Q?w9k/C6N5+zDpu4alOdx8gYgmgIopuxFHHHt6keaNc5beiO0z6XX5bH9Q+FK0?=
 =?us-ascii?Q?JCUzMtdZ91NkSSs6cJmuzSbZC2oVMszC658pg4NkgxIFtLrvpsyQyhm5jF2z?=
 =?us-ascii?Q?nAhDUpYkx1grBM5wPc2ACHZrmtkuDTrDFACtU6ArzShz+Td8Aa3qxz0nURrY?=
 =?us-ascii?Q?vBL0yKivEWT2pRoEHqvnXWwsU6iDRyusuCy9kCPaO6hcnxZt5Ng9IMuHKXTg?=
 =?us-ascii?Q?qEMLnfE+GFg4T/2BVSQxfpkM0kuhIdpJlpKKoqO5F6wFF2V+ZT5V+WmwsTDb?=
 =?us-ascii?Q?Ez246WpXBb5YFXcbwp4BcjumN3WrMz/0gFh1tKzCadtHKTdhJPFVmSbNrQrA?=
 =?us-ascii?Q?UJzrMHGy4GhJkimf3ZNznTzoXPR2wZ2+SuTtqftMxpsCf9PYshfl/Z0ZKyTf?=
 =?us-ascii?Q?JwmI8RkQ07SG05f3g8URFKwTlX4un4FJs1AtA9fBx9X5yY3aojcForQjidyY?=
 =?us-ascii?Q?/calbs2TDEhatG1OUsOjjHch3ahGkLXw6ku/Y3WMfVut5Oz7E23x7brHKrPY?=
 =?us-ascii?Q?+bFl6Rc3htTmUY28fw4/wV+q0zGiDlpoYeDZf6y/fQQZX+mE9QpPvqJdWEqg?=
 =?us-ascii?Q?hSTCbaioyYuF6TIX86VLJpvkI0YHkoFjrBf8LWX6odzjqKkozF0nTEWXhBQC?=
 =?us-ascii?Q?PiuQCC9CRNxzh7Xb6qMS24N+XyQFJDuDgZC7SIKnYdZGDRIbNxmXIgWRlVuN?=
 =?us-ascii?Q?pdnV+zINsQGkIhF+km8AHvea0nA+USG1?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 13:35:27.8965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e79707d5-84a7-46c5-f0ec-08dcb55377fc
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2417
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
index 49ce7436bb9..3424b8d9a1d 100644
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


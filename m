Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B07AD58D72
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 17:47:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2515989A64;
	Mon, 25 Nov 2024 18:47:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="vGOOiGff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95BC889A5F; Mon, 25 Nov 2024 18:47:32 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 145B689A5B
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 18:47:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ym1+dd6HEwG22xqzsrnNNEzvZyZpxQfx7mgxC6UOkBGQ8jgGd4G3jwsAhM8aeXstr3N0RHiCzHgXqLQRMihjWKfrrKKXVX3fThdyFjyJFCJ12FgUe9NJTePn0iL6MYcsldH5kvOMAWucpIDnGKrN1mC4I270c3nrXn0J8CFKXHd4IHGFs7u817GmoxXPZCgO1DP7OghyDX4sbl5Q44hgdKlamH/X8bFKjW/TSSPFGZA88sjAWYUsPKDznF+GxrL9R7Dal4Cn2O0lkwhZPwV90Y49L1dg89IRfS/dfrEe+JErdXz9gqyV7AIcjfi0hbKhSFDXuSI/i+DfJpxRYH9aDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6owsM3RpiG8ht4mwG8zAGBGSh7Ed/oDTTVJGBJaixU=;
 b=baK6rugiVTn/92QY5GrPGUZGXX33ZgUvgKkezkw9Hi5HtFHYxwxxBftrhhkDCC4ZsEBsqRiCS92OkKvEvGqKZMUmiB0vrlhhUvYuvExa1BGNB9KNjc5XrQk68EcVa4SzZvZYGLjkqra1uBAut3O5vRMhhs2SteUInMKAQfAGRvE0PhqKaSU3DMktC+qGc2VA9LRbA0536w/zwgeCWuOVl5Cfe7cq7No0cfA+FyyYLvToSonGQOwixlm41eo4jRp+Bd5bOjzN73bKo79MiquRWvQVFn/VD9o0VS/6zzR2F7E6aPkyU+ICy+ekdhKzLx9CX9ZN9uuP4Xd+47uOz2SWaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6owsM3RpiG8ht4mwG8zAGBGSh7Ed/oDTTVJGBJaixU=;
 b=vGOOiGff+Dh6Qi1oIMoNmagsuopjSRQwBH18fm1vMjrsIPCTEcKpAvVTVwrA9TMWte0wD0TbloH1UpZEzbc4Pg0oWsVMKjxn+G2MJRXQm/JOcaAJrm3gnj8Q66MoBQ3zRZEghbc79kcD6gOXTy5bl9Q/7GGACq6m8Aa0qAnTh4IoCea++OCnQ72lEXxpfZkeJa0W7WepcK++UovgUgTm7S6sGS+UrjU2eOg1dCGPkNPhT/PxrrJmrCf8Dkai9ikq49p0/MRb+WiIe7JYRplWztxNebhzPiPiV+uyYMpgvH2goql7/pIUqq/4yC1h4knPzpKERY8PI+NvfjhVQmLc1A==
Received: from GVAP278CA0013.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:20::23)
 by MRZP264MB1528.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 17:47:24 +0000
Received: from PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:710:20:cafe::cb) by GVAP278CA0013.outlook.office365.com
 (2603:10a6:710:20::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.19 via Frontend Transport; Mon,
 25 Nov 2024 17:47:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FC.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12
 via Frontend Transport; Mon, 25 Nov 2024 17:47:24 +0000
Received: from sah2lpt245.. (unknown [192.168.72.99])
 by proxy.softathome.com (Postfix) with ESMTPSA id A69771FDA8;
 Mon, 25 Nov 2024 18:47:23 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: paul.henrysd+nodisclaimer@gmail.com, sjg@chromium.org, al.kochet@gmail.com,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v4 1/3] aes: Allow to store randomly generated IV in the FIT
Date: Mon, 25 Nov 2024 18:47:15 +0100
Message-ID: <20241125174717.1181452-1-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FC:EE_|MRZP264MB1528:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d44c4429-d0ef-4ae0-c3d5-08dd0d79382b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9MffKuVPmzfPXBbTYk819vj52S6peXZfKWXavd7mvVezeX0+YTGU49OXkjfz?=
 =?us-ascii?Q?CUee2vBQHTuq15VpM2ihy3D+TOLqdXgxY0yoRv5j7sq1krIK2VMOkY8roFyc?=
 =?us-ascii?Q?HVmeWnR5M3VlRJpuO/0/z3gU9hADUReThVKY5A74F6cza8CuNMQt+9p5fcY+?=
 =?us-ascii?Q?FUdyraJZvx5yDLxKHSR55FpQ6oNpnl4qF57ZnrYoRsx7/zQpxLXeLEUHZaRd?=
 =?us-ascii?Q?liIm7ut+HUve7+cNsTTAqI1Ag/h1YJHN2LTg/w4bycWIWEQwd37dmXWw4ATt?=
 =?us-ascii?Q?REMKoGCS3Y//rEOjpkVCQYB/FWmJs4XZAeA9w3SjTq74TvTm+E3os8rKynF6?=
 =?us-ascii?Q?w7zxto1WimH4kuuxG/idzVfKLxxvUjX5zLzHNMdF7AX+4GsBxfbJe8uC/QqZ?=
 =?us-ascii?Q?RyN1g8/Fuh1zNro3tRnrabeqvPO25ogQaDkE3uXmxT0dQCmc6ph+2vlN1pm4?=
 =?us-ascii?Q?/gKGyV7b8533boQ0mgW8NTlbEvUkYygwSl+6LE1n2XtLAepT0YurOA9IY4HP?=
 =?us-ascii?Q?JLhzRzqlR+CfVu/TKhh4cvm0sbCmBTiGRL91FMcvKp/bPuDkW9vy5bS2s4Rq?=
 =?us-ascii?Q?ermUnZ8VYaLPoToggkJA0zVsVweVQB6zd6CRysvqPgAW4dMQM2viWbK9tDyD?=
 =?us-ascii?Q?S7Z6E2Dgy2VZieIuRXbY72U4+QXIIsHa8aKDTQDxEKLtTfOPyiibROswEyH0?=
 =?us-ascii?Q?wSmJ+/DOPGEc3KmhtOGaGPgs5CJMjTXLhJc5garypi/pclH5+ZCJvfUpcPfu?=
 =?us-ascii?Q?fZcM1eHxECC9rBaq4cQh2BuapMG/DaGSTX+2OFSHt8eXSUB2I5Cy1BjKod5U?=
 =?us-ascii?Q?l5TBD/t2+eQG5NKiCcKXwZZ7cRo1QY4G+kduuxGDzqAM0kBibIZA49ZkDamv?=
 =?us-ascii?Q?c2JfTNgXnPTfhiWZomzcBKwTIbr3vSKnB/LkTdQtP+yjT7+Eqaw+QvTtdLbN?=
 =?us-ascii?Q?2c0hPEsbBGXSxZMjiZKjifXHCveqYXmtCytqQKn6RxSHBohegMyI7uvBQ9AU?=
 =?us-ascii?Q?U4YzuobW6salE9nX6Ukok1Q4buakASdeWrBoj1OJU5cGAgQcvQYm/S0Nvv4c?=
 =?us-ascii?Q?+aPl4IsNO/nIZIvQxCXykn/6xGC8fqWVAfnkHk92ZaOaVpsSXX4ZxS0deFKi?=
 =?us-ascii?Q?wf8s3MmWhMhmFrI54ZibV5CfFN41Qckc88ayeIt91qSwIgNTzdj3SU03W1Z2?=
 =?us-ascii?Q?ONRWtKU/Tv1vwPNfW9769qq8WM0pQTQ8S7XCxTlyDOyivSzg/6k+5Gi3i8Zf?=
 =?us-ascii?Q?XY94nqVN+B3+Cn6Hr2YeEm7mgENwpxUJRmI2l8HrPPfxoIOpTwu5RPUI/HD0?=
 =?us-ascii?Q?/nXpY3pym9Q43HAtPRNZBuUJzUD75FnG/QFf39CBiy+bEZv0mSxb+xlSxP0H?=
 =?us-ascii?Q?p7eodI9/ohtXbOT3otrqng5dtlhazMOKlqB3Ko2OS02OUGtpLdNUEoeAg31k?=
 =?us-ascii?Q?9U65lV1BuldLItdl7hkny9hX7V60Tc3o?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 17:47:24.0605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d44c4429-d0ef-4ae0-c3d5-08dd0d79382b
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1528
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
Changes for v4:
- Add a function comment for add_cipher_data()

 include/image.h       | 15 +++++++++++++++
 lib/aes/aes-encrypt.c |  7 +++++++
 tools/image-host.c    |  2 +-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/image.h b/include/image.h
index c52fced9b4..b9aef33826 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1788,6 +1788,21 @@ struct cipher_algo {
 		       const unsigned char *data, int data_len,
 		       unsigned char **cipher, int *cipher_len);
 
+	/**
+	 * add_cipher_data() - Add cipher data to the FIT and device tree
+	 *
+	 * This is used to add the ciphered data to the FIT and other cipher
+	 * related information (key and initialization vector) to a device tree.
+	 *
+	 * @info: Pointer to image cipher information.
+	 * @keydest: Pointer to a device tree where the key and IV can be
+	 *           stored. keydest can be NULL when the key is retrieved at
+	 *           runtime by another mean.
+	 * @fit: Pointer to the FIT image.
+	 * @node_noffset: Offset where the cipher information are stored in the
+	 *                FIT.
+	 * return: 0 on success, a negative error code otherwise.
+	 */
 	int (*add_cipher_data)(struct image_cipher_info *info,
 			       void *keydest, void *fit, int node_noffset);
 
diff --git a/lib/aes/aes-encrypt.c b/lib/aes/aes-encrypt.c
index e74e35eaa2..90e1407b4f 100644
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
index 5e01b853c5..16389bd488 100644
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
2.43.0


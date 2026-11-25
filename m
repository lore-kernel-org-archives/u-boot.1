Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D06606A332
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 07:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hw5e3Y2d;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4hOYS4ny
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFA5080BE0;
	Wed, 25 Nov 2026 07:08:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z51i-dvhGdyL; Wed, 25 Nov 2026 07:08:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 18B9580B12
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795590533;
	b=j0VilukTTiENkSiCE55eCQTXrNYXSc0FqKW0I9PO4pctIIxMvrv1OoR6u6x0WcPgtr9s
	 p+/VtXaCyH/cdtN5qeGNrVPRrA9EbWI+rBjsTIb/YN2ZScCExA9ZuOrvSypibgcpczGZs
	 udJfoqI+41B/QK+Y23owMKiRm7cDkvS4T81n72omOYMfj2m3jlcE9kKJnpgb6VLM431Tz
	 Jl12uGfhETZpykJcU870aw37FnMNT0V+DOoJc59Ibdzu/tj657pXyCcFNIyMKY3lzIJql
	 kp26N70itEGNYc+X4hbMoYThz+JebkQR/66p+82wV8V51bT5OCPGRq1VJRA4eevBf1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795590533;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lVo1xlWex4bHu/+fV0wSHjAD/WLA5xbml7Jysz22hSA=;
	b=iWyGdHJ948mk0PZWCPvf6tch2qZZ0BhsnBWZuj1duYP/gi1hORzg1NZaTa7LJZhn9hHn
	 hryIwSWEtUtREN4Sx3dDiliMORSI16CNY7jGetm2XDx4yyObn0HawdZNhXNpos/iWzOEo
	 50LStfbHBOimWYvwib8ZtrmmWVCO3zWTEfUCO0zwkph0E9nzHqHfs1MPu86YBQNKgZ3CU
	 uVE15d6BKuTyqP6Lzcqlv7Y91rVQLC9S4jKKUEbmc3BkLACsSf+f1Sq0xccZ07j0FR30I
	 3tc4dfG+5s/1o2lokIzfgX8xOuX+tx4eUanEzkuPfXpU0I6Ap/SagPz6xanNqXyWLzw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795590533;
	bh=lVo1xlWex4bHu/+fV0wSHjAD/WLA5xbml7Jysz22hSA=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hw5e3Y2dp2nVx3IyzBYOmSFcrJfDyjlFb7pP9JxDEbC0TWu8vxBrpIkvSGTnft5oK
	 y7GgV7OV0RSFyWWhF6Mj2YZS5W/sXZbO74RCgm5iyIYMZs5+vPBN2u22utcQNdcQCE
	 6l3HuDLWvS5a1AlnTS+pJycsl5WXbxV5bbty1M/GwmperAMDlz6umYZ2NccqtgEgzT
	 4LW6/S7ybpHVx+bgHpi3aWnjZHn8ixcv2x4Gy7htUsJUiU3lSQKmeGE8Fz4Vyw3/gT
	 A6BguZ3veZ9g433Nz22DWS5oA3yOunAex9wxeTkaCvLOuyjOFxm11504S/MFTHAcwZ
	 XAAHjdNwFlT0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18B9580B12;
	Wed, 25 Nov 2026 07:08:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 87A0F1C9
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 07:08:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6CB3840608
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 07:08:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aGSuVM51aktt for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 07:08:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0188B40603
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=4hOYS4ny
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0188B40603
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 07:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVo1xlWex4bHu/+fV0wSHjAD/WLA5xbml7Jysz22hSA=;
 b=4hOYS4nyXikFZlH/7dMbMSxyFwezNNkTUaowPQTY8JIbdjKHrUX+KaZZjD7CQEaI3LCNh63UUUnVX/6YX3wn9ivGGyeR6ycKBzKVCM774Q+FfOmAkoWWCo4v5bWJUpCQSJxOVGgS/7Kmx2jkTO/YvRxBr9FTZw9iHmLuDIJDKRQ=
Received: from CY5PR15CA0171.namprd15.prod.outlook.com (2603:10b6:930:81::17)
 by PH7PR12MB6419.namprd12.prod.outlook.com (2603:10b6:510:1fd::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 07:06:40 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:930:81:cafe::3) by CY5PR15CA0171.outlook.office365.com
 (2603:10b6:930:81::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 07:06:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 07:06:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 01:06:39 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 01:06:38 -0600
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 01:06:36 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>,
 <ilias.apalodimas@linaro.org>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Sughosh Ganu
 <sughosh.ganu@arm.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v2] rng: tpm_rng: start TPM when probing the RNG device
Date: Wed, 25 Nov 2026 12:35:45 +0530
Message-ID: <20261125070629.4108935-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|PH7PR12MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d34e75-6955-47d5-e213-08df4ac2a6f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|18002099003|3023799007|13003099007|261026140227099003|10067099003|11063799006|56012099006|5023799004|261026121527099003|261021121427099003|261022105027099003|261102123227099003|261021123027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: Gh1ogj0Q2OJWdDVM7BRtNFywJ2YxvP86ynOw4Ch0zoVWcGZLkedeOijA6Gx7bxJeyRA+PoigGQSHt+P/jvJ8H0oMk2YgjTCbah1BYRWIGFsZ/qSKGGpgXjhxmRuHef+vgMzCKWrb1SDUbGD0UUhP6s4R3waa6erGZi9D3r9OJal+8iHFdv8Ivw3qzN6ys5EELf+e5sERtu4MqjYsuOy2d0hrwOw3TzAeX07O7ZvNwFdSpPXWRTow9hEPrJz0LZOuVx85ypuivfqd9fAH9IQXh6AWlDBE0J5yBAvhddWj526/WrHHzYgO8jAXaJi43Pxmvja1tZ50V70Ahi3DcIaX8wonj9jWUIHTvqJ9CjBa0h+XIu231A3VeRDp8PO3jc4HyxttEt8qZ3gZePMYKTgn6J0d793cJCj1JhqW3fWTNeLn3kVD1nuPeQ9jcu/HbEiXq/iRWKIJm4kr2o7E+kgRzAgsZiqjdzK5cJaK7TpS+rFS1q9XSxfCE8tYHPfFzlUcJGXde1SdrVMh12p7S119XmNXTaqGN0s9GX7EghCVDLNI+G1CsbqGYUC4xL1PIdWApp8THvhyzo0hEuntyVn9WRYYLLC+3SxNSetl6cYkvDd2P7D6a3l69qrwlB4aOdW28ywZP7zstrQMGUrE31gxIWuAFDtdNOvHrD5rz2/RtPU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(18002099003)(3023799007)(13003099007)(261026140227099003)(10067099003)(11063799006)(56012099006)(5023799004)(261026121527099003)(261021121427099003)(261022105027099003)(261102123227099003)(261021123027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BwmMmuMgFGis/lVmP1dW5aJ/a/aO51mtNJFDyMg4uFNea3vueyUFFSXNyOO70Rl2+5v2dmRV1enz79ggi9Tn3wNdsvKwV6dJ1B7UW1EsGvLI1CrU4j9W8mpIkNBdcTfl5LBTSpDkABQvkFt8d4NhJayPqvSMs3lPowAzM2gER3YOGmlI/K1+qzhut/X0GwCfbRFUK7Gchw6TJbAMvBM7Vlm4BVsFqSAwoZy3fuQ6N+lTSZSOh4sMIePrVuBExAsiL6BlUD1pJc2J5EoE5W8ZYAScL46lBaWelRIoMenQBTyzAVocW90PXlaF7OOlvUZu+Edu7cu/flWm7NHrzgmWsfqLgSNhZ4PjlZsGwOFV47lAZhRy+O5HeQW5JOueKnS0gPqgQvk3bdaV29SSbh1F8WAtAFWvPBcejqvDRyQrIikjZQsBOqlO8hte3VyUCXRo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 07:06:39.4961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d34e75-6955-47d5-e213-08df4ac2a6f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6419
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The tpm-rng device is bound as a child of the TPM device from the TPM
uclass post_probe hook, so its existence only guarantees that the TPM
driver has been probed. The TPM itself is not started until some other
user calls tpm_auto_start(), e.g. the EFI TCG2 protocol or the
'tpm2 autostart' command.

On boot paths that do not do that, such as booti/bootm where
fdt_chosen() calls fdt_kaslrseed(), the RNG read is sent to a TPM that
has not been started and fails:

  tpm-rng tpm-rng: dm_rng_read failed: -1

Fix this by starting the parent TPM from the tpm-rng probe callback.
The RNG device is probed on first use, so the TPM is only started when
its RNG is actually needed, and only once rather than on every read.

Fixes: e67ffb5aa5ab ("tpm: rng: Add driver model interface for TPM RNG device")
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
Changes in v2:
- Start the TPM once from the tpm-rng probe callback instead of on
  every read, as suggested by Ilias. tpm_auto_start() runs a full
  TPM self-test, which should not be repeated for each RNG read.
- Update the subject to match the new approach.
- Reword the commit message. The TPM does not fail to probe, as I
  wrongly said in my v1 reply: tpm-rng is only bound after a
  successful TPM probe. The problem is that nothing starts the TPM on
  non-EFI boot paths such as booti/bootm (fdt_chosen() ->
  fdt_kaslrseed()). With EFI_TCG2_PROTOCOL, efi_tcg2_register()
  already starts the TPM before the FDT is installed.
- Drop the systemd-boot and fdt_fixup_kaslr references.

v1: https://lore.kernel.org/all/20260609101039.584994-1-padmarao.begari@amd.com/
---
 drivers/rng/tpm_rng.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/rng/tpm_rng.c b/drivers/rng/tpm_rng.c
index 1a5e9e2e4b4..a03d6539fbd 100644
--- a/drivers/rng/tpm_rng.c
+++ b/drivers/rng/tpm_rng.c
@@ -4,6 +4,7 @@
  */
 
 #include <dm.h>
+#include <log.h>
 #include <rng.h>
 #include <tpm_api.h>
 
@@ -12,6 +13,21 @@ static int rng_tpm_random_read(struct udevice *dev, void *data, size_t count)
 	return tpm_get_random(dev_get_parent(dev), data, count);
 }
 
+static int rng_tpm_probe(struct udevice *dev)
+{
+	u32 rc;
+
+	/*
+	 * The parent TPM may be probed but not yet opened and started,
+	 * which is needed before it can service TPM2_GetRandom.
+	 */
+	rc = tpm_auto_start(dev_get_parent(dev));
+	if (rc)
+		return log_msg_ret("start", -EIO);
+
+	return 0;
+}
+
 static const struct dm_rng_ops tpm_rng_ops = {
 	.read = rng_tpm_random_read,
 };
@@ -20,4 +36,5 @@ U_BOOT_DRIVER(tpm_rng) = {
 	.name	= "tpm-rng",
 	.id	= UCLASS_RNG,
 	.ops	= &tpm_rng_ops,
+	.probe	= rng_tpm_probe,
 };
-- 
2.34.1


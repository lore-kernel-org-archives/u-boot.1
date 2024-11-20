Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B53D60D17
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 10:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E80AA895BD;
	Wed, 20 Nov 2024 11:09:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="Hc35ZL1C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 167AD89673; Wed, 20 Nov 2024 11:09:34 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0003688F6C
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 11:09:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmlXC3jcXDmYy7YV/FZs4d0m962HP6e5HzTOMbhg8SU/CxlBOHDgHT+41wDRPEhwLbZLAna0r7NdMgFWuluH5Nj7+bPRc1kIrTDMW+PGBKhkG8FjRCBao4VC3OGOd5gTeQM7OtQO2iI9W6bSt39V44muOzhi50sjJfq7korGv/AzuZ/Ggk/X8vr/Oa7PwyGhdGchJKsG8D1SA7xuTRJuHn0ikj24GWk7KnEr8Z+S1gvpXn55T4hfc4o2YoaOyeLkXN33KPntuamwekuCuEO84Dw1kVazBrBRTfLEFpZ4SoeeSTeX268RTHazYNeZ+M6dUv6yU3llHMGc1jyZSXw1pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvyOBk0MKtV6JDp1aK1qr0NqPqCCqdxjFC0Uu2NpOZo=;
 b=VsUoPXvKaiYkbq3vTNmuG/Zo8onCREP7V+/Uhynxl6t/876fr8nWSgpRKVJ79hUZ1flyojhgoB6xTODaeRuu5M+rsSeU/iQh0HcazfbAhI/axitzGChJqfWMG1IcB6NvUVo97Tgs3kRdeMaUhrKX537QFPagdip8zxY4S73uCejURO77htQl1maUrXTjlTtEAMorcys8ZsWo4HS/RgJAqy9e1RymJdwjrCHnmXISdWaV4XwOk4HfqTxuBNH6y8MdJGWnmWdRi34uasD8zbw3mFNtgDFSg1oPuNaSDsGsqIT6nwqI5FCxANW+VZpjpxuBhdRCTzIsRUPBS1JFVogSyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvyOBk0MKtV6JDp1aK1qr0NqPqCCqdxjFC0Uu2NpOZo=;
 b=Hc35ZL1C6aHp6lEN3vfSrPbeXbOLBKtenLHFPue83uknNMCLPfXCrIWuBB8+jVAhYtPBbISEFHEJUTbLOnMBy8AEeAlqyj8iZ7AnMHXX7AjaP7qnZmB8wIFHIIarJ3iUx0e2a6Tei/V0gwv+AU5GO8yh3qMXwANp4BXIxZzkbVT0aivuyGvvOOf85ONTKjwNIk9ld/vdZd2BktfJCgnc4h57Q9XJuC8ZyVrDss23nlw5IEoo5ImgWKwKfviUaYnsGXvtF+grh7vnwUgK1zZc8dmYtjcQ37XRDEu8s2gYZ84S1yHRssdQW7M6aUi7TIIuo3qneLpZJ1/3juke6GtTbA==
Received: from PR1P264CA0086.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:345::12)
 by PARP264MB4854.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:430::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Wed, 20 Nov
 2024 10:09:29 +0000
Received: from PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:345:cafe::48) by PR1P264CA0086.outlook.office365.com
 (2603:10a6:102:345::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.25 via Frontend
 Transport; Wed, 20 Nov 2024 10:09:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3F9.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.16
 via Frontend Transport; Wed, 20 Nov 2024 10:09:28 +0000
Received: from sah2lpt245.. (unknown [192.168.72.220])
 by proxy.softathome.com (Postfix) with ESMTPSA id 8185A1FE72;
 Wed, 20 Nov 2024 11:09:28 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, al.kochet@gmail.com, paul.henrysd@gmail.com,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v3 1/3] aes: Allow to store randomly generated IV in the FIT
Date: Wed, 20 Nov 2024 11:09:09 +0100
Message-ID: <20241120100911.885418-1-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3F9:EE_|PARP264MB4854:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 50c5042b-7f01-41b2-215b-08dd094b6bb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y4NRAZfoGYA8IPmrZ6uiy7QSAgcoYLHShtYP1mwVE7UQEOxZBnKJhkaD//LF?=
 =?us-ascii?Q?U29uAEo+RCbQC+jCjA/fVEQc5u0jYXwKlaOpp5rWeLHCz2PmCGZHqJAFt7Eg?=
 =?us-ascii?Q?wXsYr2y6bZdjidt7/mjD1qSc+Wq9wh3NZWSYUgP7LJK1MQajvWQcPDDne6cl?=
 =?us-ascii?Q?cVq+x+kRLchufxQZ3jqCnRP8dWk/3VM+jXAkXTLEGFNNit0NiH3JLpiCoES4?=
 =?us-ascii?Q?N5rA9/DDpzvm4IvIp70+WXoar+g9XozcKRIreQsysnuSL3Re+eW4T5peiQ8T?=
 =?us-ascii?Q?nUMWHJ0znsZdgaJXO7fdZsCcI4VoC31UnpSXp3gKo2btjJJdBLBluLDoV8CJ?=
 =?us-ascii?Q?3AaApP0aLqTeD5le5FUe+AYnhaz7WujUlTWNTT7HsUZ7wAbV9ObzUc+E8evc?=
 =?us-ascii?Q?UBsascF8juS7XS+im7pSLwlN5TbxVKae2jPQfuwOGBARphujLuO4TGoXt9iA?=
 =?us-ascii?Q?TZdM6W6D8/jEuzGMCz7xBu+Nz8bbvknfUufrPIgBy0cWK4yrjitZCCQLuKBT?=
 =?us-ascii?Q?NRo763g42MrIkzT5gHEDSiqdmXNci0zAmtCGrHWu9fqrH+JlgVi69NwPX/8M?=
 =?us-ascii?Q?5BbBN5my/LRr94fuNEdfaJygWDgSsCMtr43inL/60vLKXRqkSP1+gJ6OHfCf?=
 =?us-ascii?Q?4miD2zC/qT9PiYG7Xs3o1eTE+WBA3JJUN8hLg6VON4iatLq1GgMR+PYxyWOR?=
 =?us-ascii?Q?MgJzBsMRd9YaX0hF+KA40xN/A/DzjwMZED1whXkScDOhent7VcOqBv9FD3iH?=
 =?us-ascii?Q?uYwWTbylVu7qo1vBCmj/5ehEHiz07t3b0Wa16No9S/Fve5C/Zzwoap+wIqII?=
 =?us-ascii?Q?CM9/VRaKVpv/bLbRCCiSu93RoSQ5xHjsA8GWD3Ww2ET5/4VPoGztcp9xEjkk?=
 =?us-ascii?Q?BjCJwzXlU8JNmIlPxiIXlItOJgOskqH8ajFBN3K4et6ZaTNDuSMQDJrcNTC0?=
 =?us-ascii?Q?f4YpLxBnn02qzCtx2x6cTySmvot3WlY2D73VUBsfTblMkfHqK4DxAUZo/5D0?=
 =?us-ascii?Q?NjwBVUAOP0hPTGEZ0TV6RT9GM2v9hVWUVnMFCRBdl7VK+yAchDTq5Bvon1Ij?=
 =?us-ascii?Q?s7g+SPQ3XUIbpstMr4UuGzcO8mndOePYXN9HS9zhoIfTeaxhlOp/+Bn3fV7d?=
 =?us-ascii?Q?GNMIBgRTdj/M5aKdzzN0a63EsHao4DjOrwHKFFQyWDDPWB5PP2eINp5l2ru5?=
 =?us-ascii?Q?PXCQiGo3jgZNRIOKiItwvXEbSl7y4xXp/kyGbrfifwh28L8njBHCfrfGs6Wm?=
 =?us-ascii?Q?YccMLR4LFQS5onWMXPJtDVdyN2eHOpr9y91DLAMIk8bl9p5fmKRjOi8jFzOO?=
 =?us-ascii?Q?SQXeTNuhNZSIMGMqglMBaMZ+E8l18UshPLE/+lJpij3rxQ7uqx3T7w0ZvCLL?=
 =?us-ascii?Q?L9cHQFtWD+giAySCQMf5b1qKSIi3GHcAdZ9IrCHSQgjiB6ZFzA=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 10:09:28.9977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c5042b-7f01-41b2-215b-08dd094b6bb1
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB4854
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


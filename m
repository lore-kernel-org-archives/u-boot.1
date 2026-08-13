Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2962C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 19:53:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49A81813C6;
	Thu, 13 Aug 2026 19:53:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mm2Nj-nRLECn; Thu, 13 Aug 2026 19:53:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F2C90813A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786650781;
	bh=LYLgyJ07hi+NVcELlOIwEMW98KI1La1aOaB99HBP9Is=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MNO0aZ6Irkqof74OWogz+yUpZnrmO6RicqkJjNqdXFF0SFjFqkQ3syU6z+yAUVePs
	 v3ZPpWVp/xesqDSSdbHyHJI24vZ4qILxxVU7EQfZR0TDXlB7icPy3UC9nVER6ExFdu
	 +PbH50md6yWrz+H3zhVxX5f0NCTw5PN7LDdjgGFFCMktcL45uKqAtn+UAwySTGtp1R
	 WnwdMsIV6U8BviPfJxxp0tulVugF4ynBh5xrZ88QMMjiOI3MF2sFe7237WWPw333FP
	 DqEmupmbiYjhiIyw3T1Yeq+1aDZ205GVF+uxFVn/xToYNPU9Fpm4xVlmaa7qXGX8e4
	 s/MpXKKfAR5lA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F2C90813A9;
	Thu, 13 Aug 2026 19:53:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0500A194
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:52:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EAC25409C8
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:52:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E3NHgg1P1EUq for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 19:52:57 +0000 (UTC)
X-Greylist: delayed 15383 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 13 Aug 2026 19:52:57 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A377D40147
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=icloud.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A377D40147
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256
 header.s=1a1hai header.b=uUVwyp9f
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:b747:3000:200::45; helo=outbound.mr.icloud.com;
 envelope-from=valentinliu@icloud.com; receiver=<UNKNOWN> 
Received: from outbound.mr.icloud.com (mr-2001g-snip6-8.eps.apple.com
 [IPv6:2a01:b747:3000:200::45])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A377D40147
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:52:57 +0000 (UTC)
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-0 (Postfix) with ESMTPS id
 6C22618001A2; Thu, 13 Aug 2026 19:44:54 +0000 (UTC)
X-ICL-RepId: 019ffca7-f88e-755a-91f1-1c29c331b30e
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ9IHV8FWhxEC1YBWQ9LVxQEDlIBUgVGGVcUWhh3AlEcVg1XQ1QEX1BfHA4EVAddBV1WUAJaS0ATBE4TBVIHXU1WDUcPWB5cFBcVQUNeCF4fTBwdDlgGEgBNCg42BlkFXglWA0MFNhIUXUVaDlsERxQXG1wAFwZbFAREAV0FXQJICEsCVANfBkYXSQdYBlwLXQhVRQxbDlwEUBZfBEIrWxNVF0YJGQhdHQdYRxRHDg8ZWhRcGFM=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 t=1786650296; x=1789242296; bh=LYLgyJ07hi+NVcELlOIwEMW98KI1La1aOaB99HBP9Is=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=uUVwyp9fUB2QuBpiSCKv9DvWobcGKjRQ9D31GIiS6VsQd1oYSgMsUwp20syQwUjt+0gghMHefXQCdgSVc0iJHzuZ9ZuUR4UBsPU2ZGP30VSxFsP7530UKyGP6/fIf1I4EuJsSFAT0ToSQ8eOsCuB5qVMfceKfcnDadYi6Q1rqzsoLQGbY00uUXFMJiQMSGwRkHb1Up5Ij+kptZAJGzcRFOB61RlXTRZ9Er/I9wY1binmkZoKZAXM25fwdIQt5s5SLy94jxr8aYX+VGl0nyC9CHxrycyRUkHQslOv2t+JBGhYHuhFZ9UHxj611IG2VQdEpcuWA13A+MINehWhSa1Uwg==
Received: from DESKTOP-GUOEOAE.lan (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-0 (Postfix) with ESMTPSA id
 E9B811800DDB; Thu, 13 Aug 2026 19:44:51 +0000 (UTC)
From: Valentin Liu <valentinliu@icloud.com>
To: u-boot@lists.u-boot-project.org,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Valentin Liu <valentinliu@icloud.com>
Subject: [PATCH v2] boot: android: Add support for the bootflow of Android 13+
Date: Fri, 14 Aug 2026 03:44:46 +0800
Message-ID: <20260813194446.145179-1-valentinliu@icloud.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDE0MyBTYWx0ZWRfXzxsAlp53Kqwn
 dUD3Kd++TxwNFCRt6ZRk8LiyrseVcaELgJ/qlf9SCZvBNMM6MQSM6/85rj0eZpimcUcCQ76ZW0M
 CCuBMY3mTkpF6yjxcSEg/AWNdgdT6nzY+M88D4HowwiP0QPRz2JSoY5ejNiCf3OB/kZsD3NCEmu
 HwldaB8+e7uOFLv2kKGTxGZ4qURSjrQYYTNJhVDppEnbYs74BCJskIQ80lhKg27/36ijJWupj32
 6NBYvKtgbsSqfpq3F5EZ6HKjEA14RsEwqdxp3+z+DqHIRKe3CE9Je1z2O9nJpLPibBOIDWXODg7
 nXX2RYVN7tSJ9/RKjiL7i2224C+y+PSUsdzg4rU7KSCrLNt5/emk2L56ssL1WM=
X-Authority-Info-Out: v=2.4 cv=S8jUAYsP c=1 sm=1 tr=0 ts=6a7e1eb7
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=LQAHsTbMm04A:10 a=VkNPw1HP01LnGYTKEx00:22 a=n8i27M1mAAAA:8 a=v3ZZPjhaAAAA:8
 a=IpJZQVW2AAAA:8 a=pGLkceISAAAA:8 a=EGU2brQIq94NsyqP7LYA:9
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: C50HqTR7lw53awco1CmTwlGQeSUeCSXi
X-Proofpoint-GUID: C50HqTR7lw53awco1CmTwlGQeSUeCSXi
X-JNJ: AAAAAAABV2Ow1/86HnpB+agd2kjHrp4hpDXGYn1MbJEa20FrgAvu5wIlM7fspSFZ7QdoKIdxPDjzb8XICIdgLnG5rVXJfej+BrxFpkFRmvj6L7LYwuwP+JcbaM5MFZVSoEv0s/M+9lT1IQ5uaKjMWf/x/PCXogt+ObfSAyipFi2KdODMRW1pN1iOB3OgNKtbfvE3TL+FXFJzaMOFkjOX7BVjUYiMe6QjfoD9lj3lCyOZOJpuGTbpJn+URuGGC6bSswDjMBSrmybPG3iRNalcOtKP5NjAwUNFwoU10oBxlJ5igyDA3ZIByF/vhkh3k4LatBby7TLZAgi4TAHS7T4F257mEZT3EffkgJwsCYkB/1GqXpMBRVGDebNcbi9rdyh3mjiBVyCOmDHvEvW5emjQSx0yOvVTPRALcG37RVoeL2uYNIv9KKFTJgMTsYFwAuSKknuqwgNnzWahkVv1khEJ0EQP62VbhwCBJWPcgDfuYy69WNr49A16RmTC5ydKHLHG68ozLV3FLSa8IvgJGH0SrvcOccuwMQX53MkNgLfLGHR0M9+/y9W7wrHGWWcl45nPjm1sWxbvL/CtK5+SORP7mGQXeM5A7SlHjMXPvRc5pFOunXRwHz4WXloY2YSeQpB1Y8l9WNhIakCCYapgCBENsjBat9+YVgtZPWh2vk/NhAaMyGmtyH+d1m1sBHqO3GFjGX2mPs0cQC5/jp/1K2R0vs0NmWPtvhAkuskUVwdqdvapmIPq7DvlclB1K3+eFQbtctLnLeGyReMML4kck2MI/WAvMQp49adMNjy/nIb2Hn2C18O47oUegtlMJRfHMnj4omfDh5pi2dUP5Dn9vRV1BsHvPtjAx/dlxe6HWlSVuVS0utAUQy6hRuUSoWnip0Y3e7J9CxKqkmfg/WfCviBlDlm083rMjzP8uQ8Vgsvt4nKbGIMkHSKFhGlWG7I1vfuoUty/GVbRhgOr7qIaBVEg4AFgPm/VKna
 ccnODdH6qcumKgSqRCyyLAI3q7GD9Ddm9erc8sYT4LbPEaCgtbZwNFzJhCi7/zrSlPTMKcRfNgdx5+92o8z941vUqg283/tL2x7tk6ig6Loz/K865uws9EJhIRCEVoNa3A2iJk6xIVpl/tHCqxCsR/Ly8gCTzWre0+bhK2oVP5evU9udwUk0po3yvQ+G2HaXf7Rn9FlrXsJnsl65g7kbSiVk+Fr4nAwgj8SXIcslpOqyF5R+zwTbas84f792Za5R7se/qYfVtAWOAy1wM76XbejxvGrox+cRd2QRgSw==
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The devices launching Android 13+ were using a new partition
named init_boot to store generic ramdisk.

In the new bootflow, kernel still be stored in boot image,
however, the First Stage files in ramdisk were moved to
init_boot image. We should load it to memory and verify it
so that the kernel can execute init program to continue booting.

Link: https://source.android.com/docs/core/architecture/partitions/generic-boot
Signed-off-by: Valentin Liu <valentinliu@icloud.com>
---
 boot/bootmeth_android.c          | 65 ++++++++++++++++++++++++++++++-
 boot/image-android.c             | 67 ++++++++++++++++++++++++++++++++
 cmd/abootimg.c                   |  6 +++
 doc/develop/bootstd/overview.rst |  3 ++
 include/android_image.h          |  1 +
 include/image.h                  | 59 ++++++++++++++++++++++++++++
 6 files changed, 200 insertions(+), 1 deletion(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index ec255b072af..c11ef849c56 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2024 BayLibre, SAS
  * Written by Mattijs Korpershoek <mkorpershoek@baylibre.com>
+ * Copyright (c) 2026 Valentin Liu <valentinliu@icloud.com>
  */
 #define LOG_CATEGORY UCLASS_BOOTSTD
 
@@ -29,6 +30,7 @@
 #define BCB_FIELD_COMMAND_SZ 32
 #define BCB_PART_NAME "misc"
 #define BOOT_PART_NAME "boot"
+#define INIT_BOOT_PART_NAME "init_boot"
 #define VENDOR_BOOT_PART_NAME "vendor_boot"
 #define SLOT_LEN 2
 
@@ -47,6 +49,7 @@ struct android_priv {
 	char *slot;
 	u32 header_version;
 	u32 boot_img_size;
+	u32 init_boot_img_size;
 	u32 vendor_boot_img_size;
 };
 
@@ -113,6 +116,51 @@ static int scan_boot_part(struct udevice *blk, struct android_priv *priv)
 	return 0;
 }
 
+static int scan_init_boot_part(struct udevice *blk, struct android_priv *priv)
+{
+	struct blk_desc *desc = dev_get_uclass_plat(blk);
+	struct disk_partition partition;
+	char partname[PART_NAME_LEN];
+	ulong num_blks, bufsz;
+	char *buf;
+	int ret;
+
+	if (priv->slot)
+		sprintf(partname, INIT_BOOT_PART_NAME "_%s", priv->slot);
+	else
+		sprintf(partname, INIT_BOOT_PART_NAME);
+
+	ret = part_get_info_by_name(desc, partname, &partition);
+	if (ret < 0)
+		return log_msg_ret("part info", ret);
+
+	num_blks = DIV_ROUND_UP(sizeof(struct andr_boot_img_hdr_v3), desc->blksz);
+	bufsz = num_blks * desc->blksz;
+	buf = malloc(bufsz);
+	if (!buf)
+		return log_msg_ret("buf", -ENOMEM);
+
+	ret = blk_read(blk, partition.start, num_blks, buf);
+	if (ret != num_blks) {
+		free(buf);
+		return log_msg_ret("part read", -EIO);
+	}
+
+	if (!is_android_init_boot_image_header(buf)) {
+		free(buf);
+		return log_msg_ret("header", -ENOENT);
+	}
+
+	if (!android_image_get_init_bootimg_size(buf, &priv->init_boot_img_size)) {
+		free(buf);
+		return log_msg_ret("get init bootimg size", -EINVAL);
+	}
+
+	free(buf);
+
+	return 0;
+}
+
 static int scan_vendor_boot_part(struct udevice *blk, struct android_priv *priv)
 {
 	struct blk_desc *desc = dev_get_uclass_plat(blk);
@@ -292,6 +340,13 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 	}
 
 	if (priv->header_version >= 3) {
+		if (priv->header_version >= 4) {
+			ret = scan_init_boot_part(bflow->blk, priv);
+			if (ret < 0) {
+				log_debug("scan init_boot failed: err=%d\n", ret);
+				goto free_priv;
+			}
+		}
 		ret = scan_vendor_boot_part(bflow->blk, priv);
 		if (ret < 0) {
 			log_debug("scan vendor_boot failed: err=%d\n", ret);
@@ -425,7 +480,7 @@ static int run_avb_verification(struct bootflow *bflow)
 {
 	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
 	struct android_priv *priv = bflow->bootmeth_priv;
-	const char * const requested_partitions[] = {"boot", "vendor_boot", NULL};
+	const char * const requested_partitions[] = {"boot", "init_boot", "vendor_boot", NULL};
 	struct AvbOps *avb_ops;
 	AvbSlotVerifyResult result;
 	AvbSlotVerifyData *out_data = NULL;
@@ -556,6 +611,7 @@ static int boot_android_normal(struct bootflow *bflow)
 	struct android_priv *priv = bflow->bootmeth_priv;
 	int ret;
 	ulong loadaddr = env_get_hex("loadaddr", 0);
+	ulong iloadaddr = env_get_hex("init_boot_comp_addr_r", 0);
 	ulong vloadaddr = env_get_hex("vendor_boot_comp_addr_r", 0);
 
 	ret = run_avb_verification(bflow);
@@ -573,6 +629,13 @@ static int boot_android_normal(struct bootflow *bflow)
 		return log_msg_ret("read boot", ret);
 
 	if (priv->header_version >= 3) {
+		if (priv->header_version >= 4) {
+			ret = read_slotted_partition(desc, "init_boot", priv->slot,
+						     priv->init_boot_img_size, iloadaddr);
+			if (ret < 0)
+				return log_msg_ret("read init_boot", ret);
+			set_ainit_bootimg_addr(iloadaddr);
+		}
 		ret = read_slotted_partition(desc, "vendor_boot", priv->slot,
 					     priv->vendor_boot_img_size, vloadaddr);
 		if (ret < 0)
diff --git a/boot/image-android.c b/boot/image-android.c
index 7740cae8cb6..05eb7e9b6be 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (c) 2011 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
+ * Copyright (c) 2026 Valentin Liu <valentinliu@icloud.com>
  */
 
 #include <env.h>
@@ -130,6 +131,28 @@ static void android_boot_image_v3_v4_parse_hdr(const struct andr_boot_img_hdr_v3
 	data->boot_img_total_size = end - map_to_sysmem(hdr);
 }
 
+static void android_init_boot_image_v4_parse_hdr(const struct andr_boot_img_hdr_v3 *hdr,
+						 struct andr_image_data *data)
+{
+	ulong end;
+
+	/*
+	 * The header takes a full page, the remaining components are aligned
+	 * on page boundary.
+	 */
+	end = (ulong)hdr;
+	end += ANDR_GKI_PAGE_SIZE;
+	end += ALIGN(hdr->kernel_size, ANDR_GKI_PAGE_SIZE);
+	data->ramdisk_ptr = end;
+	data->ramdisk_size = hdr->ramdisk_size;
+	data->boot_ramdisk_size = hdr->ramdisk_size;
+	end += ALIGN(hdr->ramdisk_size, ANDR_GKI_PAGE_SIZE);
+
+	end += ALIGN(hdr->signature_size, ANDR_GKI_PAGE_SIZE);
+
+	data->init_boot_img_total_size = end - (ulong)hdr;
+}
+
 static void android_vendor_boot_image_v3_v4_parse_hdr(const struct andr_vnd_boot_img_hdr
 						      *hdr, struct andr_image_data *data,
 						      bool write_trailer)
@@ -263,6 +286,27 @@ bool android_image_get_bootimg_size(const void *hdr, u32 *boot_img_size)
 	return true;
 }
 
+bool android_image_get_init_bootimg_size(const void *hdr, u32 *init_boot_img_size)
+{
+	struct andr_image_data data;
+
+	if (!hdr || !init_boot_img_size) {
+		printf("hdr or init_boot_img_size can't be NULL\n");
+		return false;
+	}
+
+	if (!is_android_init_boot_image_header(hdr)) {
+		printf("Incorrect init boot image header\n");
+		return false;
+	}
+
+	android_init_boot_image_v4_parse_hdr(hdr, &data);
+
+	*init_boot_img_size = data.init_boot_img_total_size;
+
+	return true;
+}
+
 bool android_image_get_vendor_bootimg_size(const void *hdr, u32 *vendor_boot_img_size)
 {
 	struct andr_image_data data;
@@ -326,6 +370,24 @@ bool android_image_get_data(const void *boot_hdr, const void *vendor_boot_hdr,
 	return true;
 }
 
+bool android_image_get_data_v4(const void *boot_hdr, const void *vendor_boot_hdr,
+			       const void *init_boot_hdr, struct andr_image_data *data)
+{
+	if (!android_image_get_data(boot_hdr, vendor_boot_hdr, data)) {
+		printf("An error happened while calling android_image_get_data().\n");
+		return false;
+	}
+
+	if (!is_android_init_boot_image_header(init_boot_hdr)) {
+		printf("Incorrect init boot image header\n");
+		return false;
+	}
+
+	android_init_boot_image_v4_parse_hdr(init_boot_hdr, data);
+
+	return true;
+}
+
 static ulong android_image_get_kernel_addr(struct andr_image_data *img_data,
 					   ulong comp)
 {
@@ -466,6 +528,11 @@ bool is_android_vendor_boot_image_header(const void *vendor_boot_img)
 	return !memcmp(VENDOR_BOOT_MAGIC, vendor_boot_img, ANDR_VENDOR_BOOT_MAGIC_SIZE);
 }
 
+bool is_android_init_boot_image_header(const void *init_boot_img)
+{
+	return !memcmp(ANDR_BOOT_MAGIC, init_boot_img, ANDR_BOOT_MAGIC_SIZE);
+}
+
 bool is_android_boot_image_header(const void *hdr)
 {
 	return !memcmp(ANDR_BOOT_MAGIC, hdr, ANDR_BOOT_MAGIC_SIZE);
diff --git a/cmd/abootimg.c b/cmd/abootimg.c
index eae3e643b60..b32872bba7f 100644
--- a/cmd/abootimg.c
+++ b/cmd/abootimg.c
@@ -2,6 +2,7 @@
 /*
  * (C) Copyright 2020
  * Sam Protsenko <joe.skb7@gmail.com>
+ * Copyright (c) 2026 Valentin Liu <valentinliu@icloud.com>
  */
 
 #include <android_image.h>
@@ -33,6 +34,11 @@ ulong get_ainit_bootimg_addr(void)
 	return _ainit_bootimg_addr;
 }
 
+void set_ainit_bootimg_addr(ulong addr)
+{
+	_ainit_bootimg_addr = addr;
+}
+
 ulong get_avendor_bootimg_addr(void)
 {
 	return _avendor_bootimg_addr;
diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index ec9fafa0fa0..f1306ae0a8f 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -293,6 +293,9 @@ script_offset_f
 script_size_f
     Size of the script to load, e.g. 0x2000
 
+init_boot_comp_addr_r
+    Address to which to load the init_boot Android image, e.g. 0xd0000000
+
 vendor_boot_comp_addr_r
     Address to which to load the vendor_boot Android image, e.g. 0xe0000000
 
diff --git a/include/android_image.h b/include/android_image.h
index a2d80499ba3..134b5ed74d6 100644
--- a/include/android_image.h
+++ b/include/android_image.h
@@ -357,6 +357,7 @@ struct andr_image_data {
 	ulong tags_addr;  /* physical addr for kernel tags */
 	u32 header_version;  /* version of the boot image header */
 	u32 boot_img_total_size;  /* boot image size */
+	u32 init_boot_img_total_size;  /* init boot image size */
 	u32 vendor_boot_img_total_size;  /* vendor boot image size */
 };
 
diff --git a/include/image.h b/include/image.h
index 6edcb1995bf..b323b5f880e 100644
--- a/include/image.h
+++ b/include/image.h
@@ -2015,6 +2015,30 @@ struct andr_image_data;
  */
 bool android_image_get_bootimg_size(const void *hdr, u32 *boot_img_size);
 
+/**
+ * android_image_get_init_bootimg_size() - Extract size of Android init_boot image
+ *
+ * This is used to extract the size of an Android init_boot image
+ * from init_boot image header.
+ *
+ * @hdr: Pointer to init_boot image header
+ * @init_boot_img_size: On exit returns the size in bytes of the init_boot image
+ * Return: true if succeeded, false otherwise
+ */
+bool android_image_get_bootimg_size(const void *hdr, u32 *init_boot_img_size);
+
+/**
+ * android_image_get_init_bootimg_size() - Extract size of Android init_boot image
+ *
+ * This is used to extract the size of an Android init_boot image
+ * from init_boot image header.
+ *
+ * @hdr: Pointer to init_boot image header
+ * @init_boot_img_size: On exit returns the size in bytes of the init_boot image
+ * Return: true if succeeded, false otherwise
+ */
+bool android_image_get_init_bootimg_size(const void *hdr, u32 *init_boot_img_size);
+
 /**
  * android_image_get_vendor_bootimg_size() - Extract size of Android vendor-boot image
  *
@@ -2041,6 +2065,23 @@ bool android_image_get_vendor_bootimg_size(const void *hdr, u32 *vendor_boot_img
 bool android_image_get_data(const void *boot_hdr, const void *vendor_boot_hdr,
 			    struct andr_image_data *data);
 
+/**
+ * android_image_get_data_v4() - Parse Android header version 4 boot images
+ *
+ * This is used to parse boot, vendor-boot and init boot header into
+ * andr_image_data generic structure.
+ * The Android 13 and newer has splited parameters from boot and
+ * vendor_boot images to the init_boot image.
+ *
+ * @boot_hdr: Pointer to boot image header
+ * @vendor_boot_hdr: Pointer to vendor boot image header
+ * @init_boot_hdr: Pointer to init boot image header
+ * @data: Pointer to generic boot format structure
+ * Return: true if succeeded, false otherwise
+ */
+bool android_image_get_data_v4(const void *boot_hdr, const void *vendor_boot_hdr,
+			       const void *init_boot_hdr, struct andr_image_data *data);
+
 struct andr_boot_img_hdr_v0;
 
 /**
@@ -2167,6 +2208,17 @@ bool android_image_print_dtb_contents(ulong hdr_addr);
  */
 bool is_android_boot_image_header(const void *hdr);
 
+/**
+ * is_android_init_boot_image_header() - Check the magic of init boot image
+ *
+ * This checks the header of Android init boot image and verifies the
+ * magic is "ANDROID!" (same with the boot image)
+ *
+ * @init_boot_img: Pointer to boot image
+ * Return: non-zero if the magic is correct, zero otherwise
+ */
+bool is_android_init_boot_image_header(const void *init_boot_img);
+
 /**
  * is_android_vendor_boot_image_header() - Check the magic of vendor boot image
  *
@@ -2199,6 +2251,13 @@ void set_abootimg_addr(ulong addr);
  */
 ulong get_ainit_bootimg_addr(void);
 
+/**
+ * set_ainit_bootimg_addr() - Set Android init boot image address
+ *
+ * Return: no returned results
+ */
+void set_ainit_bootimg_addr(ulong addr);
+
 /**
  * get_avendor_bootimg_addr() - Get Android vendor boot image address
  *
-- 
2.53.0


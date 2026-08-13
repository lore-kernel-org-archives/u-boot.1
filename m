Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5B8C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 20:07:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7544C813EA;
	Thu, 13 Aug 2026 20:07:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NWxPg5G7YW-G; Thu, 13 Aug 2026 20:07:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 15E59813CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786651657;
	bh=aYRifLfmUcFJBV90dDO3eXC0BbF6xCfEpHhjLs6RD4E=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0isB0KzhnHfrPlPWnTxiBtfjBGDbEX6xPZFYxHYZ8Y46rm9cK193g03nbMAtipT4D
	 gOdM3VqvlQQ9A1XhVIcHIu+hLXOaw1R5/z+CgJ0eyTfkO7UqwdgCcCz22CkyHgwsYT
	 WaPSyguGBo9cvvEgwRUXIYl/woxkdQUOPyB33uejhoCzpi2ijce9/QCP1vc/FguGUv
	 sf/3GHvoE+jee3XTuQVQzsViz1BEJuh9NXx0Qcg9alAwvuiJAjB+hWX0kMWP6eOHVk
	 7dIhw7c9o8a/aEEsZqvQklIvmbVD2dNIcB5gh/VNa3lm7n5rEIx3kvjhn3B54DOs0Y
	 iHOq117tiYJSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15E59813CA;
	Thu, 13 Aug 2026 20:07:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DAF74194
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 20:07:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CCE36606D0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 20:07:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Et0_XT3dDRPm for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 20:07:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:b747:3000:200::23; helo=outbound.mr.icloud.com;
 envelope-from=valentinliu@icloud.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 60333606D5
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=icloud.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 60333606D5
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256
 header.s=1a1hai header.b=HMAuJhfk
Received: from outbound.mr.icloud.com (mr-2001d-snip6-4.eps.apple.com
 [IPv6:2a01:b747:3000:200::23])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 60333606D5
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 20:07:34 +0000 (UTC)
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPS id
 4153F18009CC; Thu, 13 Aug 2026 20:07:32 +0000 (UTC)
X-ICL-RepId: 019ffcbc-b082-7b9e-8bce-9922d001d4af
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ9IHV8FWhxEC1YBWQ9LVxQEDlIBUgVGGVcUWhh3AlEcVg1XQ1QEX1BfHA4EVAddBV1WUAJaS0ATBE4TBVIHXU1WDUcPWB5cFBcVQUNeCF4fTBwdDlgGEgBNCg42BlkFXglWA0MFNhIUXUVaDlsERxQXG1wAFwZbFAREAV0FXQJICEsBXQdcAEUXSQZcBVIGXQhVRQxbDlwEUBZfBEIrWxNVF0YJGQhdHQdYRxRHDg8ZWhRcGFM=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 t=1786651653; x=1789243653; bh=aYRifLfmUcFJBV90dDO3eXC0BbF6xCfEpHhjLs6RD4E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=HMAuJhfkqNqzSg5HT+HuKx7Fj14fSz3+6OTWD9Rk528L+MfxH6utifPuQ3fH6nhlNx3sTQRnhhMP+C0Ie8LejXHJZy+1iPe/UVfI6Uxwz8NH/BSNp/gZXg0hiKmUuwFbQnF/n6YcB1CbG0aunJX0P1ZUCFvRw2klaJVr/Sc9FRSlZBYODkYYeeBVB4XtEYcV0gwFTzDluMJ+EdlmeFC7AdH3QfZd95IngVW5Q2zlOGb5VrqGYutZHtOj6JJUNPjdn8G5TMQzRUIehnSJg8h30cZaQMMwFup1I5fCOpdWGxqXKPUUL58JIYfbofTxIaO3cKDCaCyMFtMTMKamkQF0jA==
Received: from DESKTOP-GUOEOAE.lan (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPSA id
 99F7018009A0; Thu, 13 Aug 2026 20:07:29 +0000 (UTC)
From: Valentin Liu <valentinliu@icloud.com>
To: u-boot@lists.u-boot-project.org,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Valentin Liu <valentinliu@icloud.com>
Subject: [PATCH v3] boot: android: Add support for the bootflow of Android 13+
Date: Fri, 14 Aug 2026 04:07:24 +0800
Message-ID: <20260813200725.151294-1-valentinliu@icloud.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDE0NiBTYWx0ZWRfX4Qbsmx4gUYUI
 jbZtigTO0q/hxfRKo+wVtEgiBHdBp61A7+tlfGLSCfgyWxRNOlLrPIHvE0htnonz4leKQeqVH0F
 iFQ2iijwuOf9Lv4ytrauoZV9VsIA/3NclEyLfxcMjkym/hyG1KfVQL8zKH2zZIPNkLDVzpOcdkf
 fu9gDchUBjtmfw3lgJvGsWX6JhvH/Ob0tDmjQ0dofTSNVDAqY8qx902YN2v4krz3G2zYw+OR4J8
 FiPBkPrfMSi3shrAxcax6YgIaEAr2jZt1ysb9tLl4X/viqi0kGbz5+1fbnSz1JStYLpFOZO/VCd
 8y71GDzwADP9JpZRsi8PvPumyZESdlHqfINp90Qa8DbWaZRJZPYHV7Ranr5FeM=
X-Authority-Info-Out: v=2.4 cv=QMJlhwLL c=1 sm=1 tr=0 ts=6a7e2404
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=LQAHsTbMm04A:10 a=VkNPw1HP01LnGYTKEx00:22 a=n8i27M1mAAAA:8 a=v3ZZPjhaAAAA:8
 a=IpJZQVW2AAAA:8 a=pGLkceISAAAA:8 a=6y2KtKeVSjoUg3iUfdsA:9
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: zla3bfj-17nsDCbeyLXIUhGoamTwzj68
X-Proofpoint-ORIG-GUID: zla3bfj-17nsDCbeyLXIUhGoamTwzj68
X-JNJ: AAAAAAAB6vxlpKTmpd7/y/s4c5a6mSVac7P4+lbj8bnqk2xqOIbG1dhKAlohpV6cTGkyU8aAVWy6UY8Y9x4ZvFhHHAsBhjmIp91qulABQifFiMi+0MsMdBLOXmlx0XmAplV84+gO3LejV27t4zqMVdZTeSR/afvquD8Ag0A0dNv1BNWQRo1t2HPs5nogPvzob9BZJd1BQs5kTGAWD2wCwRkf34GobuCVK7uy6RMu6O8gbOZqa+AnjIJTg8MUucWO2TujIbYMsiwP9V2LNwQSXIp9biOZesmdWMpYm2CZfff0WOLm3Umih7oDweDfHDHgROKYv/1144Pj66PRW9+anrRKyp5w5UZqU08sUNMRRN7swHJwZG+mR91T9/Qp7DrsEovAJdCcQ85cc06Bg27acl2FtxsOQkS3Cyg5heV6qUpbJJGwzEDcfsVVAV69i3+Sq4YTdRWoPNDy08/WGTW5mP0Yn7lK0eNYrK/0n/1QLl6seEEUM4JJswF1zIHnCcd+Edm6du4KBLP8SymX3LTu0yRKbFfG+QodA4l7a2UI1Nizq4seE7MEgE9BcusS/tOwD+HG9mlc/Fg2ANynF6jMVfKQvEhhcbWcbKU/BJjjzpZ23iGf6HwHT8EtwPFV1D7ZvzdW4s1qJ9uDCoNJ0zM8KMj1ufazezG2+yScx0cvz5eHmLqBP7ekMWCY++VkYUhpUEc86XwqEsGEnlaoutjcgdSsbQyq+rHyisStp7ENsFHjf4/U/vvMGsROab1jZBC6iH5dcRDLlS4PxSETOfDY5OxgJEn3miHFp7MCzrwFLXNVEhXtsTr6u0PY9/j+M75bHHqS7Bg19b+R2Q1YRGgmgnAoF2JVsC3lLJVk2ZmVKCg8BO9Fz8HtEU4ssItEeWQ65Tg0rirYPtUW+2queEN0tchhbeLFD72x4jYiK2m8RKRpY7w16LV+4eRhhG1zMjdlnIQgKDQ2eDyHQWSaNUGmuurGuyDVMsn
 inJwjsnVvnEqGXdeTDCJ+6k6Kkj1a88qoDqLv8cKr3tlISCgWqE3QYstAbJTWiQotbRLIyAJ6Ruzbc/o9VBZbQovj7oiiOS6FQgzK+9Du5tU1G8NabWZtOeYPNz6SFxZ9l8PyrT96EXY9UnYaO+4bn4Ie+bT6Wvzw51iTSvkzMd1u2PKa+71aWms4CTV01iH3ozWJ/kFi9u2L+r0Z9hs+vO7u/PpQeZf/SPuViBI9m9rOhdtmIwiATFO700kMajn3LmBAIx6rJoJOSVAeIPngYtofUjF6FdRUitiY
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
Changes for v2:
- Resend without functional changes (mistakenly bumped version).
Changes for v3:
- Allow booting device with boot header version 4 without an init_boot partition.
- Refactor AVB verification logic to verify the boot partition first
  (to prevent downgrade attacks), then dynamically target the AVB
  requested_partitions based on header_version.
- Coding style cleanup.

 boot/bootmeth_android.c          | 134 +++++++++++++++++++++++++++++--
 boot/image-android.c             |  67 ++++++++++++++++
 cmd/abootimg.c                   |   6 ++
 doc/develop/bootstd/overview.rst |   3 +
 include/android_image.h          |   1 +
 include/image.h                  |  59 ++++++++++++++
 6 files changed, 265 insertions(+), 5 deletions(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index ec255b072af..aacb7712892 100644
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
@@ -291,6 +339,17 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 		goto free_priv;
 	}
 
+	if (priv->header_version >= 4) {
+		ret = scan_init_boot_part(bflow->blk, priv);
+		if (ret < 0) {
+			/*
+			 * Android 12 devices do not have the init_boot partition.
+			 * Some devices upgraded to Android 13 or later from
+			 * earlier Android versions may also not have one.
+			 */
+			log_debug("scan init_boot failed: err=%d\n", ret);
+		}
+	}
 	if (priv->header_version >= 3) {
 		ret = scan_vendor_boot_part(bflow->blk, priv);
 		if (ret < 0) {
@@ -421,11 +480,31 @@ static int avb_append_commandline(struct bootflow *bflow, char *cmdline)
 	return 0;
 }
 
-static int run_avb_verification(struct bootflow *bflow)
+/**
+ * run_avb_verification() - Run the Android Verified Boot (AVB) verification process
+ *
+ * Performs AVB slot verification via libavb. When @boot_partition_only is
+ * true, only the "boot" partition is verified; otherwise the full set of
+ * partitions required for the current slot (e.g. vbmeta, boot, system,
+ * vendor, etc.) is verified.
+ *
+ * @bflow: bootflow describing the target being booted
+ * @boot_partition_only: verify only the "boot" partition instead of the
+ *                        full AVB partition chain
+ *
+ * Return: 0 on success, a negative error code if verification fails
+ */
+static int run_avb_verification(struct bootflow *bflow,
+				const bool boot_partition_only)
 {
 	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
 	struct android_priv *priv = bflow->bootmeth_priv;
-	const char * const requested_partitions[] = {"boot", "vendor_boot", NULL};
+	static const char * const boot_only_partitions[] = {"boot", NULL};
+	static const char * const v3_hdr_partitions[] = {"boot", "vendor_boot", NULL};
+	static const char * const v4_hdr_partitions[] = {
+		"boot", "init_boot", "vendor_boot", NULL
+	};
+	const char * const *requested_partitions;
 	struct AvbOps *avb_ops;
 	AvbSlotVerifyResult result;
 	AvbSlotVerifyData *out_data = NULL;
@@ -435,6 +514,22 @@ static int run_avb_verification(struct bootflow *bflow)
 	bool unlocked = false;
 	int ret;
 
+	if (boot_partition_only) {
+		requested_partitions = boot_only_partitions;
+	} else {
+		if (priv->header_version >= 4) {
+			ret = scan_init_boot_part(bflow->blk, priv);
+			if (ret == 0)
+				requested_partitions = v4_hdr_partitions;
+			else
+				requested_partitions = v3_hdr_partitions;
+		} else if (priv->header_version >= 3) {
+			requested_partitions = v3_hdr_partitions;
+		} else {
+			requested_partitions = boot_only_partitions;
+		}
+	}
+
 	avb_ops = avb_ops_alloc(desc->devnum);
 	if (!avb_ops)
 		return log_msg_ret("avb ops", -ENOMEM);
@@ -504,9 +599,11 @@ static int run_avb_verification(struct bootflow *bflow)
 	return ret;
 }
 #else
-static int run_avb_verification(struct bootflow *bflow)
+static int run_avb_verification(struct bootflow *bflow,
+				const bool boot_partition_only)
 {
 	int ret;
+	(void)boot_partition_only;
 
 	/* When AVB is unsupported, pass ORANGE state  */
 	ret = bootflow_cmdline_set_arg(bflow,
@@ -556,11 +653,13 @@ static int boot_android_normal(struct bootflow *bflow)
 	struct android_priv *priv = bflow->bootmeth_priv;
 	int ret;
 	ulong loadaddr = env_get_hex("loadaddr", 0);
+	ulong iloadaddr = env_get_hex("init_boot_comp_addr_r", 0);
 	ulong vloadaddr = env_get_hex("vendor_boot_comp_addr_r", 0);
 
-	ret = run_avb_verification(bflow);
+	/* Check the boot partition first to prevent downgrade attacks. */
+	ret = run_avb_verification(bflow, true);
 	if (ret < 0)
-		return log_msg_ret("avb", ret);
+		return log_msg_ret("boot avb", ret);
 
 	/* Read slot once more to decrement counter from BCB */
 	ret = android_read_slot_from_bcb(bflow, true);
@@ -572,6 +671,31 @@ static int boot_android_normal(struct bootflow *bflow)
 	if (ret < 0)
 		return log_msg_ret("read boot", ret);
 
+	ret = run_avb_verification(bflow, false);
+	if (ret < 0)
+		return log_msg_ret("avb", ret);
+
+	if (priv->header_version >= 4) {
+		ret = scan_init_boot_part(bflow->blk, priv);
+		if (ret == 0) {
+			ret = read_slotted_partition(desc, "init_boot", priv->slot,
+						     priv->init_boot_img_size,
+						     iloadaddr);
+			if (ret < 0)
+				return log_msg_ret("read init_boot", ret);
+			set_ainit_bootimg_addr(iloadaddr);
+		} else if (ret == -1) {
+			/*
+			 * Android 12 devices do not have the init_boot partition.
+			 * Some devices upgraded to Android 13 or later from
+			 * earlier Android versions may also not have one.
+			 */
+			log_debug("init_boot partition is not found");
+		} else if (ret < -1) {
+			log_debug("scan init_boot failed: err=%d\n", ret);
+			return log_msg_ret("read init_boot", ret);
+		}
+	}
 	if (priv->header_version >= 3) {
 		ret = read_slotted_partition(desc, "vendor_boot", priv->slot,
 					     priv->vendor_boot_img_size, vloadaddr);
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


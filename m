Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A23C5DF82
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 17:53:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3A24406C4;
	Tue, 18 Aug 2026 17:53:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NhJtrrRRYqub; Tue, 18 Aug 2026 17:53:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7F513408AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787075598;
	bh=G4+37VisOPN0UVfNOtX8utPpQNnyiO0cXQrUa7rCBdE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yoeDl29tMiNjIH3kRJTp3LoDZR5xEpfC7l4ihoJRMUSprk84cgxOisdtlw9ErcZaz
	 aQ/3qCkyi5XcR1Pmo1qniFlmlWSDqSK/v5PKoHK21nP9Uf/aFzkU3mxRHUap4bItG/
	 dYaZ7sUhKLErsZR3YOEKcDW4aa2+BwQDwT9AJmlVxHXnAW6xPxjOXaHEnT6Nx+cwgZ
	 LOgHAjrfzZhr8LgwXJN8nM9YNX8gy45RGJcBiJsF6NFG+TMlOAQWGms6/tnTY4UHmS
	 5uPqzP2ZOrvbq7b/jxhdP76hzEzceJ+I+ELn7R/rlhaXEgeHLmWDBsvMWcPtXpsZrO
	 UoBS1Owj4KXtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F513408AC;
	Tue, 18 Aug 2026 17:53:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 079492B2
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 17:53:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 05491406C4
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 17:53:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fcuKkQUTbx7c for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 17:53:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:b747:3000:204::65; helo=outbound.mr.icloud.com;
 envelope-from=valentinliu@icloud.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CE55140692
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=icloud.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CE55140692
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256
 header.s=1a1hai header.b=00CeHdYd
Received: from outbound.mr.icloud.com (mr-2006j-snip6-11.eps.apple.com
 [IPv6:2a01:b747:3000:204::65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CE55140692
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 17:53:15 +0000 (UTC)
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPS id
 DFF271800186; Tue, 18 Aug 2026 17:53:13 +0000 (UTC)
X-ICL-RepId: 01a01601-869d-7f71-8e55-c9bbbd8f8f4f
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ9IHV8FWhxEC1YBWQ9LVxQEDlIBUgVGGVcUWhh3AlEcVg1XQ1QEX1BfHA4EVAddBV1WUAJaS0ATBEkCTV8OXh8EF0YZVQRHHl1WXh8ZAlEcVg1XQ1QEX1BJDEFQbFoARxdIHV0ZWW9QXRwOBFQHXQVdVlACWktfGV1FD18HWQRAAUkLXABeAUAIVgtcD1wBSRRJHhtWB1ceTRFdAV4echlaFFwYU0VRH1RGExlOG1dNUBtfAkIP
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 t=1787075595; x=1789667595; bh=G4+37VisOPN0UVfNOtX8utPpQNnyiO0cXQrUa7rCBdE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=00CeHdYd4jbLOnkw48ii6ARmn7tblmozLfAln3r9VwBOC/M9x8QX/FeNyZIbG7wwvCTxNoxEY6Kd0PWjrdv3XJUkfCQxgO02MIjg9Jn0bv8OjLBL19LkIiLDnmrextiNYjB1b1gBOtNsNCBCSru+oUg2X+CHYv7SrrtOgpQyxFvpaBkMUOBt1mnAHGVc901Aj3tT0dQoWV0OLSyuGUOqlkJbMWM3BNSJTyVVXAJQOGRMh7FpGOWfh777s+pq5ifZ+KCT6Badli3gbfWmyjv+CL4gKtzIsGSHNXdt7VQXDNLr+oaBVrhjShCBjpZt4240xBF1Fh+wmtkX2dmzMwqcmg==
Received: from DESKTOP-GUOEOAE (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPSA id
 45AA9180019F; Tue, 18 Aug 2026 17:53:10 +0000 (UTC)
From: Valentin Liu <valentinliu@icloud.com>
To: u-boot@lists.u-boot-project.org
Cc: mkorpershoek@kernel.org, sjg@chromium.org, trini@konsulko.com,
 igor.opaniuk@gmail.com, alchark@flipper.net, quentin.schulz@cherry.de,
 marek.vasut+renesas@mailbox.org, daniel@makrotopia.org, rs@ti.com,
 Valentin Liu <valentinliu@icloud.com>
Subject: [PATCH v1 1/2] boot: android: Add Android 13+ bootflow support to
 bootmeth.
Date: Wed, 19 Aug 2026 01:53:00 +0800
Message-ID: <20260818175301.818739-1-valentinliu@icloud.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEzMiBTYWx0ZWRfXyBjFjvx0Cvtt
 YiT/SNYsNldZoht/2q8taquMlK2M4OJghoGIvrdPcpMcH2ET5SG8iCc55TCQ5x715aybGWKqiTM
 WHD8H2qe2K01ICXVozNrqRcpmqQhAB5RYPMPHlNJkzqEpVhXUzaqim5YyMUwGgoZO/ILfmngnmp
 UByML2CLAnTsESOWTuAqjoRMbEUFeuXVkyJXMfBC1cfSJVhdS29aomD65U5h0kmuVeB9liBQTpm
 blJLD4xNclpJSU1bI6y4E3wUjJLE2ORJnumwqySkTrIP0YW5Cr2Oq/Rqmu2bFh0jkqMTx6MC546
 LLMx/YbynTe52shTLjUU45BJCxGPVOzvPo4YjAU2TS6Elnej+TJYqhKHKtuRtU=
X-Authority-Info-Out: v=2.4 cv=Z9nh3XRA c=1 sm=1 tr=0 ts=6a849c0a
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=LQAHsTbMm04A:10 a=VkNPw1HP01LnGYTKEx00:22 a=n8i27M1mAAAA:8 a=v3ZZPjhaAAAA:8
 a=QNzDDl8frt45hZyITpMA:9
X-Proofpoint-GUID: bDeZ1hrGFAPqWNEsEwPIjVkAFUU7zWs2
X-Proofpoint-ORIG-GUID: bDeZ1hrGFAPqWNEsEwPIjVkAFUU7zWs2
X-JNJ: AAAAAAABZ9K54i9QIaSFKcx/ctWm9tGd/yLvp3XGfKGgw6GQXKf5phr1WyGgcx9fh69q6WBl0L8No7iSX63RLFs0b1f0GhNYLBoBC66Uefyy/IpaiNlnRtFXqZTAAf1MQPioueVShi2Sj0QpD4BhjqkT4f7Pg/y9Oig7ImW5BtRUU/GikI+aQzULPqPEiMSdoJWWvuNcZTJjSYujaYKt9oqRbLUfojK4iYNhEoiLHlqXkwWik8GgU8xf2p2UOAMBYrZTirz5wUp2tX68a20m8GL4cROBrbpw14G7jHG3gRScYkIcfbugRzZK1HKSEPSEcErgPHkP8R/ggzFppjWvhZoFJ7lv4A7LCWB4+zGNbm4zY0NMMC2idFu0XOKhdtdP98e7QnSM9d/1TWiBl+xQ3Dci/jj8hwGbUWtQsiLLX5piaqj23edKc98yjZ/TJsI7LRLuHXzYfsYmvXqhfruD76iH9VdRIhQTKALvdxn75adIK8A/pUe2sKkAowQUbwLmRK6lbaEMDNdmyI/ULYMcxDK5z9oufZZb8pr1AHQmJANDa49dFZJAZes7MuErMixbJ6BPQWnfYb0Sj7sMbpNS4avhhFfx0J/TjEnRPsEzoDbbhgRXMbfKaIA+qXCXt2cwghP1YBYk5TdWYpWO/EkRvxUM3DkWP57GeJt2at8de/Qf+M+tClnmDZIzGCWMm5ZCFCGb4rPEQyeAa/8gVHg+fvdxUXUYPNrQYoO2oTsSwqsH/9NutsuWUqlktfoV5igkp2SYn/UemIrLxKAZEhoIexE2i700KswP6s90bJRoqCgl2SNdnKfJdeFH25pYkAx06HVNRx7caucBB8twh+Ek8bwm2SwZZDUKpAdDlmZdr3SQuGZWpuYFUvdqOJ+f2u3jCO27NRubUdmPG2j7J43jUQcqmTuFOgFVFmRwFVyyHXmt2Crf5sp4whYsOyGxgftjINS1Q8K57Pezl+6AM+vw+RB9/GEjnVe
 gL6MjRc+Ktvqjps0o6rW1wwTCjbTOFrVbAx7FtErTL41bYCs3bMf0mGf1dV3evt3bNbi4U3GZG0OkQdyK/nAQvtGhqOznDiFPqwaiFo0krvnQ5sHxkgYfosNe8Lx+8Z6CZGI/MmjpC7NWXybEybyb8N8los9cEmsAL4juLaV3JrbZNsPDY9Wn5s2ZWPaRco6Dq1wmQaFXYx2qoMIOnbjIVbTP4RZ2/8XkQOJ5NoxuC18i8S0OJFc8FVfDNXOCeXfu0K15LdLVW5iAG38F4wEzYT/TIW/c262YBgahyIejD1BFNyS9YrBcKcT73+fuqnh6p4q8sB2uWIclisPW+AuGJPIPy6umLh+VIqqpiqGltcHH3wNCDBk+y4ne63oz5gU8GRHtsWA87lgFQX0NzIB+WqPKOujB8GiH3L5+KCOUue3Fh4y5HS0i4qKZbCgp9w==
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

The devices launching Android 13+ were using a new partition
named init_boot to store generic ramdisk.

In the new bootflow, kernel still be stored in boot image,
however, the First Stage files in ramdisk were moved to
init_boot image. We should load it to memory and verify it
so that the kernel can execute init program to continue booting.

Currently, we have supported loading the init_boot image by
abootimg command, but we still need bring this ability to
bootmeth, so that booting Android 13+ will be more easily.
Bootmeth will be able to recognize the new partition layout,
and boot Android normally.

Link: https://source.android.com/docs/core/architecture/partitions/generic-boot
Signed-off-by: Valentin Liu <valentinliu@icloud.com>
---
 boot/bootmeth_android.c          | 67 ++++++++++++++++++++++++++++++++
 boot/image-android.c             | 16 ++++++++
 cmd/abootimg.c                   |  5 +++
 doc/develop/bootstd/overview.rst |  3 ++
 include/android_image.h          |  1 +
 include/image.h                  | 35 +++++++++++++++++
 6 files changed, 127 insertions(+)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index ec255b072af..904640d360b 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -29,6 +29,7 @@
 #define BCB_FIELD_COMMAND_SZ 32
 #define BCB_PART_NAME "misc"
 #define BOOT_PART_NAME "boot"
+#define INIT_BOOT_PART_NAME "init_boot"
 #define VENDOR_BOOT_PART_NAME "vendor_boot"
 #define SLOT_LEN 2
 
@@ -47,6 +48,7 @@ struct android_priv {
 	char *slot;
 	u32 header_version;
 	u32 boot_img_size;
+	u32 init_boot_img_size;
 	u32 vendor_boot_img_size;
 };
 
@@ -113,6 +115,51 @@ static int scan_boot_part(struct udevice *blk, struct android_priv *priv)
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
+	if (!is_android_boot_image_header(buf)) {
+		free(buf);
+		return log_msg_ret("header", -ENOENT);
+	}
+
+	if (!android_image_get_bootimg_size(buf, &priv->init_boot_img_size)) {
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
@@ -291,6 +338,17 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
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
@@ -556,6 +614,7 @@ static int boot_android_normal(struct bootflow *bflow)
 	struct android_priv *priv = bflow->bootmeth_priv;
 	int ret;
 	ulong loadaddr = env_get_hex("loadaddr", 0);
+	ulong iloadaddr = env_get_hex("init_boot_comp_addr_r", 0);
 	ulong vloadaddr = env_get_hex("vendor_boot_comp_addr_r", 0);
 
 	ret = run_avb_verification(bflow);
@@ -572,6 +631,14 @@ static int boot_android_normal(struct bootflow *bflow)
 	if (ret < 0)
 		return log_msg_ret("read boot", ret);
 
+	if (priv->header_version >= 4 && priv->init_boot_img_size > 0) {
+		ret = read_slotted_partition(desc, "init_boot", priv->slot,
+					     priv->init_boot_img_size,
+					     iloadaddr);
+		if (ret < 0)
+			return log_msg_ret("read init_boot", ret);
+		set_ainit_bootimg_addr(iloadaddr);
+	}
 	if (priv->header_version >= 3) {
 		ret = read_slotted_partition(desc, "vendor_boot", priv->slot,
 					     priv->vendor_boot_img_size, vloadaddr);
diff --git a/boot/image-android.c b/boot/image-android.c
index 7740cae8cb6..3f5634b469f 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -326,6 +326,22 @@ bool android_image_get_data(const void *boot_hdr, const void *vendor_boot_hdr,
 	return true;
 }
 
+bool android_image_get_data_v4(const void *boot_hdr, const void *vendor_boot_hdr,
+			       const void *init_boot_hdr, struct andr_image_data *data)
+{
+	if (!android_image_get_data(boot_hdr, vendor_boot_hdr, data))
+		return false;
+
+	if (!is_android_boot_image_header(init_boot_hdr)) {
+		printf("Incorrect init boot image header\n");
+		return false;
+	}
+
+	android_boot_image_v3_v4_parse_hdr(init_boot_hdr, data);
+
+	return true;
+}
+
 static ulong android_image_get_kernel_addr(struct andr_image_data *img_data,
 					   ulong comp)
 {
diff --git a/cmd/abootimg.c b/cmd/abootimg.c
index eae3e643b60..e8e6b8f5ced 100644
--- a/cmd/abootimg.c
+++ b/cmd/abootimg.c
@@ -33,6 +33,11 @@ ulong get_ainit_bootimg_addr(void)
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
index 6edcb1995bf..1c725fc2601 100644
--- a/include/image.h
+++ b/include/image.h
@@ -2041,6 +2041,23 @@ bool android_image_get_vendor_bootimg_size(const void *hdr, u32 *vendor_boot_img
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
@@ -2167,6 +2184,17 @@ bool android_image_print_dtb_contents(ulong hdr_addr);
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
@@ -2199,6 +2227,13 @@ void set_abootimg_addr(ulong addr);
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


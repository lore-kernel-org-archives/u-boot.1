Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3D1606A31F
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Or6PrA35;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=djd5n9oB
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFB6F607B8;
	Sun, 15 Nov 2026 16:02:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lp7KeMYMa0pg; Sun, 15 Nov 2026 16:02:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 794756077E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794758570;
	b=JM+UkkiSPYC+7pvJWv8+u0ew7jA/VV7jxEeD/jDvQWfVkGhQtkfP/Xj+n7++Lw7g5Y4Y
	 h7OWmBChD5izyU1n4bye62mPQTRAF2Ve6X6jMdjqJiBgE3mxdaiPfe4NfqTamecz+PIjJ
	 kS+L02MEWysuTEO6zWeC0l8Sl2vTgXv28pBy6qZ81hxj+ydAwAO6GH0ML3dfk5pC7ejc3
	 2evQW+M2klbdGy+Ar8zqzCcrVQTvMLZrNjIxfcT/tzb2560pymo2kuYNftuCeenXFsZFq
	 iM2g75FGyMteLe+fiZQ7ODkL7/f4159WUuXYpwXuXskuCmR12cKn4uGAUhcRzZ+wbeA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794758570;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=l9ZEmvV2tYPpkN/TyIMoAyRBQRn/JbX0RlyxVOkp8X8=;
	b=OnnKnWVmOiKyaxi+IrBs6gK8RvS1bnkReJNpzoTEGqK5EjF3/nQtZzhPSJ1vr7aRNBGm
	 3cAyMOrtU1b4BPOrPGRv8jjdGcvc4SO6QPRqePFSM7/kXb4/XZ9uU1a+gRg29GMSwDL2l
	 5wqvoMZNb73CMQ9fsf47QcI+4nMLMPEIuYdpR6D6N06/XzoaF7h4ZSBTqiN1H1pYOVd9q
	 PFcOZUX/2UYAHw2U5Y75++6ulX25rvrgDELSSD0WVqW4E2LVmW3aZSAjBy0C5U6j5jyg0
	 UrQzod3SaDm6J0GGDX25X8adEB834K5D1SUkjlyI9Dmpjuk2D33BmvC36fnTDKp2u9Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794758570;
	bh=l9ZEmvV2tYPpkN/TyIMoAyRBQRn/JbX0RlyxVOkp8X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Or6PrA35+SnAiCDAEuUEihP1xdZcceL00XcigGyn+HKBw2sc/je7dyA+SQZ2JJm9O
	 mCJQpAnZYkiqfoEsZ6XjG0+gJkrq0IkS/LDi+dGU7u5F0V9plZLgmg+syTvdEbh2hY
	 LEZ0Vymn5dTn14QweXajhSIJET4k/iedhphqMm+g5mHL7D0l5mXvZH4Tf6iuGn0iYl
	 qE6qsOpdvS+PGvaoKu73yVqJFz5xA3oak/vQ3KgncXrDrloctBgZzni9WmNPtN3ZcP
	 QpJBh7B0bO75bwUf/vk0yojHHLL2z2EJkE3qAjQIt6rfl34tZTUYAF9gXV0l2tqidb
	 GYTOSXm3axSRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 794756077E;
	Sun, 15 Nov 2026 16:02:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 21E64169
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 14:32:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0842F80F67
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 14:32:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id efx8-Q0PT26e for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 14:32:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6926C80A65
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=djd5n9oB
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6926C80A65
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 14:32:04 +0000 (UTC)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5F5323F32D
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 14:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1794753122;
 bh=l9ZEmvV2tYPpkN/TyIMoAyRBQRn/JbX0RlyxVOkp8X8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=djd5n9oB6z808HYV6KynIPetHcunhl9qfZ8YwaFIbhxRaKQK0Fb2IhD+xEq7xCudn
 fbZ1qFEXGI5sCALl5UwHpVYr+aLmCIpbIJXyRS52yMPB1KFAy7btNg9pamFpr/GXxt
 Gsja1uJVfaQbSsZcHhpZl2MAaNPRDGY3QjN0Pr9ziyKnQPsF6oDI0NNKdLkPitpbcX
 /3Ay4vi5ucMxpG7Ei50GMFxR0ZdVOC0eVvpbnSZdjoC6ylq+O9XPrVnGX0PvMHli+T
 d7zykTCYKJc+Ns1zF6Al18DSTCU7BVORVsnIywlaEVQU9Za9Z+t1IB9fy5k/qbTtbD
 Tl2W8MkVofC9tv+x694577k/ZxY1q2y6k2UxFG6r351MtOlZAVySZhRbNeGaAplMMl
 j1VczBakNS/uzX04GndVVqAI6uJcvtErKZ7CRXgGpWHbv9cx0JaDpUk/dJ977VBd/+
 /Fo5jrNhfnj7//O+dI7fnN/0J4gazvZzmVqd7849/yvvAQVHzdDj02VEKWD66kpIw5
 93fq7+AQTl7RwMc3dq+vc3OxNwWa+yt0UXsMJ/525haUBnbCRLyyaZHQWLtIo7FSUh
 46gyvP+FZjc5swvUesai1aGGFymfwEJ4sz7+GompcaXbMImNNECJoyYk4Jbh3bbJc7
 QabTlgmyDzCCiC4vMkisUgMI=
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cd6969473a4so1240438a12.0
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794753121; x=1795357921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l9ZEmvV2tYPpkN/TyIMoAyRBQRn/JbX0RlyxVOkp8X8=;
 b=l0KC9kNO2Ggj4sq5GZhkvjJ9j7uqvGeEtWiLfPFCwnW57L6mXp3F5y8Y1O4k8l1wGE
 fZygaVd86e7ecPTlt8njBjvbKaljcM6PRzqDoQoVwQNj4NtsO0FGrhEzDkGORMphJbW7
 tJ3KpyVzPtJMxFPcL0op2llO98hbFX4pj4lR8cZEMayhiXOrS/adIXfMEb5LbK/6RnY9
 DcT1TWLxNqQlhcwhyLlLMLuEPCuxIEUYyQB6/GgsmP3/SXQvtA75ilbs+0EqDVcWtehD
 muPCKMhvWXdszNxJ4QpFL5foOQt5P9ACmou6aAIhNpJfGuTZssLLaVd0TysOCaEGxzeS
 Mmsg==
X-Gm-Message-State: APuU4Z+UF5854yV9vO+2q+l8IOnYg5I53sr6UuJ96Xbnv0U3eU+lBAXT
 gQsgy8GHDmmJWg5cbZgembF81oDzo/To6At0Y/xKkLInArdWw6J8Cn+3oKZNLSMa9NyOxICt8c8
 8F1CQmqZEI7eZymPzmnz+AMueKECfX0Cyc3lgH5qtQkvaOhk2w3UAT4Noq2fsWBjiE+3tgCCrDq
 3S7wSZBWDtdB7g7PIWPQ==
X-Gm-Gg: AYBFou1NThOaBPGhsBGSngn4wgN8UZ3hWpjzQUkGryF8U7T3bNO6DbJXk3qVMEJytLF
 zOuwEr9RCeinbxBIlN64CSu0MKLXvMySmuKa8xk5zTrG8LDQV3KItV/KLIwiNQ5O+CxpDjkam7e
 nNNgBqMRlSvLBErN4mSnsJacUxrN6T03EWBr40DFi765J9yXPwtxY7Mpu+UEbQw8tXOCl9uRxhg
 QYp/QbwkWCL6BO/v3McWnyClo9F5IGdyI25dKLQcRw6MyJTruv2P4iDOgJjRSzHVmKha2EQCwKC
 8/xePEZDmh6CtEzr58IX9kgMvO3c10CDKBFi9w/hRPinkiog+IbNHL+nsAJu7yE465OjL7qtRi3
 OsnX2S1P7G8RpLCNhFnMsgOu7D5bWMfDfZ4b/hy5NQniIZxjATDIlAjux3b+ueev7Pz+Fye5MSQ
 sCuumeJAANuwHLT9HuMKy1orC7YqmoswtO+wzQl2gSu50=
X-Received: by 2002:a17:90b:1d46:b0:3ac:7613:1ec3 with SMTP id
 98e67ed59e1d1-3b1b0a3eaaemr6924264a91.37.1794753120656; 
 Sun, 15 Nov 2026 06:32:00 -0800 (PST)
X-Received: by 2002:a17:90b:1d46:b0:3ac:7613:1ec3 with SMTP id
 98e67ed59e1d1-3b1b0a3eaaemr6924250a91.37.1794753120302; 
 Sun, 15 Nov 2026 06:32:00 -0800 (PST)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1bfb607e7sm4297670a91.3.2026.11.15.06.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 06:31:58 -0800 (PST)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>, openwrt-devel@lists.openwrt.org
Subject: [PATCH v1 2/2] test: boot: imagemap: reject an oversized data-size
Date: Sun, 15 Nov 2026 14:31:14 +0000
Message-ID: <20261115143134.25791-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115143134.25791-1-aristo.chen@canonical.com>
References: <20261115143134.25791-1-aristo.chen@canonical.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 15 Nov 2026 16:02:45 +0000
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

Build a FIT with an external-data ramdisk whose data-size is far beyond
CONFIG_SYS_BOOTM_LEN and any plausible load region, load it through the
imagemap storage path with verification on, and confirm fit_image_load()
returns -EFBIG. Count how often the mock reader is entered and assert it
is zero, so the oversized image is rejected before any read reaches the
device rather than after a failed transfer. Without the preceding bound
the read is attempted and fails with -EIO.

The test needs the FIT loader, which IMAGEMAP does not depend on, so it
is skipped when FIT is disabled.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/boot/imagemap.c | 133 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/test/boot/imagemap.c b/test/boot/imagemap.c
index 2c6f23fb4f0..f8de8e6e357 100644
--- a/test/boot/imagemap.c
+++ b/test/boot/imagemap.c
@@ -7,6 +7,8 @@
 
 #include <dm.h>
 #include <blk.h>
+#include <bootstage.h>
+#include <image.h>
 #include <imagemap.h>
 #include <mtd.h>
 #include <part.h>
@@ -21,6 +23,7 @@
 #include <dm/lists.h>
 #include <dm/root.h>
 #include <dm/uclass-internal.h>
+#include <linux/libfdt.h>
 #include <test/test.h>
 #include <test/ut.h>
 
@@ -35,6 +38,7 @@
  *
  * @image:	pointer to synthetic image data in RAM
  * @image_size:	size of the synthetic image
+ * @attempts:	number of times .read() was entered, including rejected ones
  * @read_count:	number of times .read() was called
  * @last_off:	offset from the most recent .read() call
  * @last_size:	size from the most recent .read() call
@@ -42,6 +46,7 @@
 struct mock_priv {
 	const void *image;
 	size_t image_size;
+	int attempts;
 	int read_count;
 	loff_t last_off;
 	ulong last_size;
@@ -52,6 +57,8 @@ static ulong mock_reader(struct spl_load_info *info, ulong sector,
 {
 	struct mock_priv *p = info->priv;
 
+	p->attempts++;
+
 	if (sector + count > p->image_size)
 		return 0;
 
@@ -611,6 +618,132 @@ static int imagemap_test_blocklen(struct unit_test_state *uts)
 
 IMAGEMAP_TEST(imagemap_test_blocklen, UTF_DM);
 
+/*
+ * build_fit_ext_datasz() - build a FIT with one external-data ramdisk image
+ *
+ * The ramdisk uses external data (data-offset 0, so the payload would start at
+ * the aligned end of the FDT) and declares @data_size for it. No hash is
+ * needed: the bound check under test runs before any verification.
+ *
+ * @buf:	output buffer for the FIT
+ * @bufsz:	size of @buf
+ * @load:	sub-image load address
+ * @data_size:	the data-size property value
+ * Return: 0 on success, negative FDT error otherwise
+ */
+static int build_fit_ext_datasz(void *buf, size_t bufsz, u32 load,
+				u32 data_size)
+{
+	int images, img, confs, conf, ret;
+	fdt32_t v;
+
+	ret = fdt_create_empty_tree(buf, bufsz);
+	if (ret)
+		return ret;
+
+	/* fit_check_format() requires description and timestamp. */
+	ret = fdt_setprop_string(buf, 0, FIT_DESC_PROP, "data-size bound");
+	if (ret)
+		return ret;
+	v = cpu_to_fdt32(0);
+	ret = fdt_setprop(buf, 0, FIT_TIMESTAMP_PROP, &v, sizeof(v));
+	if (ret)
+		return ret;
+
+	images = fdt_add_subnode(buf, 0, "images");
+	if (images < 0)
+		return images;
+	img = fdt_add_subnode(buf, images, "ramdisk");
+	if (img < 0)
+		return img;
+	ret = fdt_setprop_string(buf, img, FIT_TYPE_PROP, "ramdisk");
+	if (ret)
+		return ret;
+	ret = fdt_setprop_string(buf, img, FIT_ARCH_PROP, "sandbox");
+	if (ret)
+		return ret;
+	ret = fdt_setprop_string(buf, img, FIT_OS_PROP, "linux");
+	if (ret)
+		return ret;
+	ret = fdt_setprop_string(buf, img, FIT_COMP_PROP, "none");
+	if (ret)
+		return ret;
+	v = cpu_to_fdt32(load);
+	ret = fdt_setprop(buf, img, FIT_LOAD_PROP, &v, sizeof(v));
+	if (ret)
+		return ret;
+	v = cpu_to_fdt32(0);
+	ret = fdt_setprop(buf, img, FIT_DATA_OFFSET_PROP, &v, sizeof(v));
+	if (ret)
+		return ret;
+	v = cpu_to_fdt32(data_size);
+	ret = fdt_setprop(buf, img, FIT_DATA_SIZE_PROP, &v, sizeof(v));
+	if (ret)
+		return ret;
+
+	confs = fdt_add_subnode(buf, 0, "configurations");
+	if (confs < 0)
+		return confs;
+	ret = fdt_setprop_string(buf, confs, FIT_DEFAULT_PROP, "conf-1");
+	if (ret)
+		return ret;
+	conf = fdt_add_subnode(buf, confs, "conf-1");
+	if (conf < 0)
+		return conf;
+	ret = fdt_setprop_string(buf, conf, FIT_RAMDISK_PROP, "ramdisk");
+	if (ret)
+		return ret;
+
+	return fdt_pack(buf);
+}
+
+/*
+ * A FIT's data-size is not covered by the configuration signature, so it is
+ * untrusted input. On the imagemap storage path the payload is read to the
+ * load address before fit_image_select() verifies it, so fit_image_load()
+ * must reject a data-size larger than CONFIG_SYS_BOOTM_LEN rather than read
+ * that many bytes off the device.
+ */
+static int imagemap_test_fit_oversize_datasz(struct unit_test_state *uts)
+{
+	struct udevice *dev, *saved_im;
+	u8 fitbuf[1024];
+	ulong load = 0x02000000, data = 0, len = 0;
+	int saved_verify, ret, attempts;
+
+	/* fit_image_load() is only built with FIT, which IMAGEMAP does not need */
+	if (!CONFIG_IS_ENABLED(FIT))
+		return -EAGAIN;
+
+	/* data-size far beyond CONFIG_SYS_BOOTM_LEN and any load region. */
+	ut_assertok(build_fit_ext_datasz(fitbuf, sizeof(fitbuf), load,
+					 0x40000000));
+	ut_assertok(create_mock_loader(fitbuf, sizeof(fitbuf), &dev));
+
+	saved_im = bootm_imagemap(&images);
+	saved_verify = images.verify;
+	bootm_set_imagemap(&images, dev);
+	images.verify = 1;
+	ret = fit_image_load(&images, map_to_sysmem(fitbuf), NULL, NULL,
+			     IH_ARCH_SANDBOX, IH_TYPE_RAMDISK,
+			     BOOTSTAGE_ID_FIT_RD_START,
+			     FIT_LOAD_OPTIONAL_NON_ZERO, &data, &len);
+	bootm_set_imagemap(&images, saved_im);
+	images.verify = saved_verify;
+
+	attempts = get_mock_priv(dev)->attempts;
+	imagemap_cleanup(dev);
+
+	/* Rejected before the device read, not after a hash failure. */
+	ut_asserteq(-EFBIG, ret);
+	/* and the reject happened before any read reached the device. */
+	ut_asserteq(0, attempts);
+
+	return 0;
+}
+
+IMAGEMAP_TEST(imagemap_test_fit_oversize_datasz, UTF_DM);
+
 #if CONFIG_IS_ENABLED(MTD_BLOCK)
 /*
  * End-to-end: read a known pattern back from a bare (non-NAND) MTD
-- 
2.43.0


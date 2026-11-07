Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EB1606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CcwnbOA1;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Minq5hPj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8808381331;
	Sat,  7 Nov 2026 16:05:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j5cG-e0E4l1n; Sat,  7 Nov 2026 16:05:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8AADD8132D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794067500;
	b=q9EMRQPnpd8qNTz5rgQXAooG5Sl9m8qeHPrR60tjxYlo8GcvJmNC3I72ZbDI4Vos7FLp
	 bdhJ74PSP52b2sKx62LBVVuTewOczQu7QH+bBaunA+hgb4BcK8ulc/0iqe3r6+Kcv7vFo
	 iZLfFyz54ETTDtEPoVNq9LKckkOd5wP5yyeXFvf4xqgbvZxzLjEDGeH/xJW5Dqdw0PB0W
	 k0wfMZc1CaNRBRS3rNNkmjluGxhuIq8H0NzWlcBPPhqmY+kjGguV8CZSJc8E8VbwqaIeZ
	 TdhA9B+g98LWC0eapUDklV4HSKb6l30gTlpjCzcniadLYQEfFYn56QI5mxYoke+I2dA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794067500;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AJB5HNXD3c4MjjBEUFR8JOGLGpP8yAIws5JP5bLD9bM=;
	b=Mot0B9/RQSqfZBoiGb1njLbkwWNKscOzL3XIsulo5JKEy+2lquwsWQrdVV4bOE8p/ouH
	 K9c76/LpJ3nWGxO/eetx0eHSZFrD0xdyHDwBI3xZMhyLZQcqsTloocfDDGG4k5eejOAFn
	 ucH6Z3egXBEZyJXSge7/PnJknBwULeVzVylKx2TT5mphfF1x05Iu51gODuwhGBPw1GPvj
	 xZfQTwa23OsWKmDzW6ov8ydFfT+CRm03tWP1WAaQAJAQjkA6fWLfzeu906aaQuyTZTJDr
	 79/OWKfYDm9AOjqrNO3H4+Biy0cE1QkTqmlAdeADgCqpIupVt/Vitf3fWzyWwlIeeuA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794067500;
	bh=AJB5HNXD3c4MjjBEUFR8JOGLGpP8yAIws5JP5bLD9bM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CcwnbOA1cqSL5+/JBkK1SNusbMDXrDzyc/qN7yrtCWLKDOSdsrkw/+GiOiD6pmVPW
	 UvspIqkhdGgz2iA1wR4qEQqDgkouOwFifxbGJy2CsNjyUmTHTELjpwAMaxWnpWGu8I
	 6sCN53Tul8z6ZiyDfdA5UjxxioJ48rtoNh2YYcjT8xRxoS0OGmFlk3LJQXo4K5zHQC
	 qgmty/fSJ5YP63yraTkdcldPJ5AqDFJEcTgzY8LtQyqS82Rw9c2Yv0DeeTEzwCRuP/
	 1B6rOCEmSaoqrBLcAvLjqfFjn/BcE3PuJy2/kuDsoM0vujgfivdQecROAKqZxotZxM
	 AFSLDyDHKAroA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8AADD8132D;
	Sat,  7 Nov 2026 16:05:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B9C081C6
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 16:04:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AA25F406DA
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 16:04:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cozybcVF7dPp for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 16:04:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3218E40791
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=220.197.31.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.4;
 helo=m16.mail.163.com; envelope-from=hyyoxhk@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=163.com header.i=@163.com
 header.a=rsa-sha256 header.s=s110527 header.b=Minq5hPj
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3218E40791
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 16:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=AJ
 B5HNXD3c4MjjBEUFR8JOGLGpP8yAIws5JP5bLD9bM=; b=Minq5hPjH3x6JdO2wT
 3G6NaorXSC/fjzF8NwvipjO9xV3VgGL0EwxZWaQZupFH2kH0ue23EDHMO6s7Ro5l
 4Q4Lj2SooHsEOivvXW94QtZB3m0kGhOU9rDSr64kzYy8pf9h1yN1H4RW+vMd9e8a
 qQad3TlpX4txv1+G51kW44SlE=
Received: from nh50.. (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wA3FCH3S+9q+f2SFw--.1483S3; 
 Sun, 08 Nov 2026 00:04:08 +0800 (CST)
From: He Yong <hyyoxhk@163.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, trini@konsulko.com, alchark@flipper.net,
 daniel@makrotopia.org, jbx6244@gmail.com, quentin.schulz@cherry.de
Subject: [PATCH v4 1/5] image: Bound FIT script checks by the image size
Date: Sun,  8 Nov 2026 00:04:02 +0800
Message-ID: <20261107160406.3943071-2-hyyoxhk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107160406.3943071-1-hyyoxhk@163.com>
References: <20261107160406.3943071-1-hyyoxhk@163.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wA3FCH3S+9q+f2SFw--.1483S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxKrWkZw1DuFW3ArW3KF1xKrg_yoW3tFy7pa
 ykWa1ag398CF1fZwn3XF1rur1S9rn5JFy5K3yfCa45AFs8XrZ5XF43CFy5Xa17Wr4DAw15
 Gr90vFWDCr1DGrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzyIUUUUUU=
X-CM-SenderInfo: pk1105lkn6il2tof0z/xtbC8hinemrvS-guZwAA3I
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

FIT verification can follow malformed metadata or external-data offsets
beyond a buffer whose size is known to the caller.

Pass the known buffer size to fit_check_format() so FIT_FULL_CHECK
validates the complete structure against the actual buffer. Reject
external data in all subimages of known-size FITs before verification,
even when verify is disabled. Keep these checks in the shared parser so
filesystem and raw-partition scripts receive the same protection. Leave
unknown-size FIT handling unchanged.

Add C regression coverage with verification enabled and disabled, plus
source coverage. Clear verify even when a test helper assertion fails.

Signed-off-by: He Yong <hyyoxhk@163.com>
---
 boot/image-board.c |  57 +++++++++++++++++++++-
 test/boot/image.c  | 118 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+), 1 deletion(-)

diff --git a/boot/image-board.c b/boot/image-board.c
index 7602f5bfaaa..c406e13e721 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -978,6 +978,46 @@ static const char *get_default_image(const void *fit)
 	return fdt_getprop(fit, images_noffset, FIT_DEFAULT_PROP, NULL);
 }
 
+/* Check that [data, data + len) lies within [buf, buf + size) */
+static bool fit_data_in_buf(const void *buf, int size, const void *data,
+			    size_t len)
+{
+	ulong off;
+
+	if ((ulong)data < (ulong)buf)
+		return false;
+	off = (ulong)data - (ulong)buf;
+
+	return off <= (uint)size && len <= (uint)size - off;
+}
+
+/*
+ * Check that the data of every FIT subimage lies within the known-size
+ * buffer. Images with in-buffer external data (e.g. 'mkimage -E') are fine.
+ */
+static int fit_check_data_bounds(const void *fit, const void *buf, int size)
+{
+	const void *data;
+	size_t len;
+	int images, node;
+
+	images = fdt_path_offset(fit, FIT_IMAGES_PATH);
+	if (images < 0)
+		return -ENOENT;
+
+	fdt_for_each_subnode(node, fit, images) {
+		if (fit_image_get_data(fit, node, &data, &len))
+			continue;	/* no data; checked later if selected */
+		if (!fit_data_in_buf(buf, size, data, len)) {
+			printf("FIT image '%s' data is outside the image\n",
+			       fit_get_name(fit, node, NULL));
+			return -EFBIG;
+		}
+	}
+
+	return 0;
+}
+
 int image_locate_script(void *buf, int size, const char *fit_uname,
 			const char *confname, char **datap, uint *lenp)
 {
@@ -1043,11 +1083,26 @@ int image_locate_script(void *buf, int size, const char *fit_uname,
 			goto exit_image_format;
 		} else {
 			fit_hdr = buf;
-			if (fit_check_format(fit_hdr, IMAGE_SIZE_INVAL)) {
+
+			/* Known size: make sure the FDT itself fits in the buffer,
+			 * even when FIT_FULL_CHECK is disabled
+			 */
+			if (size && ((uint)size < sizeof(struct fdt_header) ||
+				     fdt_totalsize(fit_hdr) > (uint)size)) {
 				puts("Bad FIT image format\n");
 				return 1;
 			}
 
+			if (fit_check_format(fit_hdr,
+					     size ? size : IMAGE_SIZE_INVAL)) {
+				puts("Bad FIT image format\n");
+				return 1;
+			}
+
+			/* Do this before any verification reads image data */
+			if (size && fit_check_data_bounds(fit_hdr, buf, size))
+				return 1;
+
 			if (!fit_uname) {
 				/* If confname is empty, use the default */
 				if (confname && *confname)
diff --git a/test/boot/image.c b/test/boot/image.c
index 2c6d9dcbc22..17b1a4055da 100644
--- a/test/boot/image.c
+++ b/test/boot/image.c
@@ -6,7 +6,11 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
+#include <command.h>
+#include <env.h>
 #include <image.h>
+#include <mapmem.h>
+#include <u-boot/crc.h>
 #include <test/ut.h>
 #include <linux/libfdt.h>
 #include "bootstd_common.h"
@@ -100,3 +104,117 @@ static int test_image_phase(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(test_image_phase, 0);
+
+/* Known-size FITs must be structurally valid and contain all their data. */
+static int check_fit_script_bounds(struct unit_test_state *uts)
+{
+	static const char script[] = "true";
+	static const char * const external_props[] = {
+		FIT_DATA_OFFSET_PROP, FIT_DATA_POSITION_PROP,
+	};
+	char fit[1024] __aligned(8), bad[1024] __aligned(8);
+	const void *expected;
+	char *data;
+	uint len;
+	int images, node, confs, conf, hash, size, i;
+
+	ut_assertok(fdt_create_empty_tree(fit, sizeof(fit)));
+	ut_assertok(fdt_setprop_string(fit, 0, FIT_DESC_PROP, "Script test"));
+	ut_assertok(fdt_setprop_u32(fit, 0, FIT_TIMESTAMP_PROP, 0));
+	images = fdt_add_subnode(fit, 0, "images");
+	ut_assert(images >= 0);
+	ut_assertok(fdt_setprop_string(fit, images, FIT_DEFAULT_PROP, "script"));
+	node = fdt_add_subnode(fit, images, "script");
+	ut_assert(node >= 0);
+	ut_assertok(fdt_setprop_string(fit, node, FIT_TYPE_PROP, "script"));
+	ut_assertok(fdt_setprop(fit, node, FIT_DATA_PROP, script, sizeof(script)));
+	hash = fdt_add_subnode(fit, node, "hash");
+	ut_assert(hash >= 0);
+	ut_assertok(fdt_setprop_string(fit, hash, FIT_ALGO_PROP, "crc32"));
+	ut_assertok(fdt_setprop_u32(fit, hash, FIT_VALUE_PROP,
+				    crc32(0, (const u8 *)script, sizeof(script))));
+	confs = fdt_add_subnode(fit, 0, "configurations");
+	ut_assert(confs >= 0);
+	ut_assertok(fdt_setprop_string(fit, confs, FIT_DEFAULT_PROP, "conf"));
+	conf = fdt_add_subnode(fit, confs, "conf");
+	ut_assert(conf >= 0);
+	ut_assertok(fdt_setprop_string(fit, conf, FIT_SCRIPT_PROP, "script"));
+	ut_assertok(fdt_pack(fit));
+	size = fdt_totalsize(fit);
+	node = fdt_path_offset(fit, "/images/script");
+	ut_assert(node >= 0);
+	expected = fdt_getprop(fit, node, FIT_DATA_PROP, NULL);
+	ut_assertnonnull(expected);
+
+	/* Exercise configuration lookup, direct image lookup and source. */
+	ut_assertok(image_locate_script(fit, size, NULL, NULL, &data, &len));
+	ut_asserteq(sizeof(script), len);
+	ut_asserteq_ptr(expected, data);
+	ut_assertok(image_locate_script(fit, size, "script", NULL, &data, &len));
+	ut_assertok(cmd_source_script(map_to_sysmem(fit), NULL, NULL));
+
+	/* Structural validation follows fit_check_format() configuration. */
+	if (CONFIG_IS_ENABLED(FIT_FULL_CHECK)) {
+		ut_asserteq(1, image_locate_script(fit, sizeof(struct fdt_header) - 1,
+						   NULL, NULL, &data, &len));
+		ut_asserteq(1, image_locate_script(fit, sizeof(struct fdt_header),
+						   NULL, NULL, &data, &len));
+		ut_asserteq(1, image_locate_script(fit, size - 1, NULL, NULL,
+						   &data, &len));
+
+		memcpy(bad, fit, size);
+		fdt_set_totalsize(bad, sizeof(bad) + 1);
+		ut_asserteq(1, image_locate_script(bad, sizeof(bad), NULL, NULL,
+						   &data, &len));
+
+		/* A valid header does not imply a valid structure block. */
+		memcpy(bad, fit, size);
+		*(fdt32_t *)(bad + fdt_off_dt_struct(bad)) = cpu_to_fdt32(0xffffffff);
+		ut_assertok(fdt_check_header(bad));
+		ut_asserteq(1, image_locate_script(bad, size, NULL, NULL, &data, &len));
+	}
+
+	for (i = 0; i < ARRAY_SIZE(external_props); i++) {
+		ut_assertok(fdt_open_into(fit, bad, sizeof(bad)));
+		node = fdt_path_offset(bad, "/images/script");
+		ut_assert(node >= 0);
+		ut_assertok(fdt_delprop(bad, node, FIT_DATA_PROP));
+		ut_assertok(fdt_setprop_u32(bad, node, external_props[i],
+					    0xfffffffc));
+		ut_assertok(fdt_setprop_u32(bad, node, FIT_DATA_SIZE_PROP,
+					    sizeof(script)));
+		ut_asserteq(1, image_locate_script(bad, sizeof(bad), NULL,
+						   NULL, &data, &len));
+
+		/* Reject external data even in an unselected image. */
+		ut_assertok(fdt_open_into(fit, bad, sizeof(bad)));
+		images = fdt_path_offset(bad, FIT_IMAGES_PATH);
+		ut_assert(images >= 0);
+		node = fdt_add_subnode(bad, images, "external");
+		ut_assert(node >= 0);
+		ut_assertok(fdt_setprop_u32(bad, node, external_props[i],
+					    0xfffffffc));
+		ut_asserteq(1, image_locate_script(bad, sizeof(bad), NULL,
+						   NULL, &data, &len));
+	}
+
+	return 0;
+}
+
+static int image_fit_script_bounds(struct unit_test_state *uts)
+{
+	int ret, verify;
+
+	if (!IS_ENABLED(CONFIG_FIT))
+		return -EAGAIN;
+
+	for (verify = 0; verify < 2; verify++) {
+		ut_assertok(env_set("verify", verify ? "yes" : "no"));
+		ret = check_fit_script_bounds(uts);
+		ut_assertok(env_set("verify", NULL));
+		ut_assertok(ret);
+	}
+
+	return 0;
+}
+BOOTSTD_TEST(image_fit_script_bounds, 0);
-- 
2.43.0


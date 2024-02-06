Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C79C48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 22:32:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F34A87CA6;
	Tue,  6 Feb 2024 23:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86AAA87CDB; Tue,  6 Feb 2024 23:32:09 +0100 (CET)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
 [209.85.208.182])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6008087CB8
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 23:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-2d0a29b05bdso44071fa.0
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 14:32:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707258726; x=1707863526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WWfkiCLzw8oa+aaSCsiKciREX/zGDRIFXOlH2tDyYfM=;
 b=I4DrhwWqxC+gN6PTw9puNzqtx/GShM6fXYzSX/zmE6pC4EFVLu4kyB+K7eReKAbPhr
 JzTHq0mPoiZ5tGMVw8t+58lC7BOtHh73jG1BPzHGq4Y6DiliJRQvi9vZvmH8UOMINXoJ
 oLJnnkQo6Kijm7JUPZTb3AUta5ns8D6Z84xLNK2emhNTBTG1iw0gfv8FX/xEWMoG2yg/
 vrsgEnNmjHbBwMLP7Jp1LhornPjGjdlI2lu1o/fUFl0subZOH0Ykm6TvMKTO9aOs+rtX
 WK7Bww29Es3gM/73xfJJLALqL4hm7kXGnFc96HIMIjKsId7DgKfv23rQauZJo5bn+n3N
 YUOg==
X-Gm-Message-State: AOJu0Yw3J9/QLsDRSYadzx31X0ulG0bnScpa/wZ5daf6s7Re5Q/Lms4I
 f5MXEXovkoOQcbs9Z5eSvWAhSahtqOGkmOk1J2JMph6MhzaV739yxuglUv4V8v6FzA==
X-Google-Smtp-Source: AGHT+IEQVCdSRdHgxE6jUFDSWdyomG23yv6IeFLjMfcmMGTqqW+Hbub5nwuCn9NiqVeyd03XR2IQ0A==
X-Received: by 2002:a2e:91cb:0:b0:2d0:41df:70b7 with SMTP id
 u11-20020a2e91cb000000b002d041df70b7mr2888640ljg.1.1707258725763; 
 Tue, 06 Feb 2024 14:32:05 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUfirh8GDDwn5Jv7omDlCiJN32qNC4SPkLNfOVbKTd21rtqUUgC/RbxrcHR7D0EkFeQ27ZrNCJ3BGvvy2G5Zie7igq9r3+sv+W8ZhqnSbCQDFXClAR2itRZ6Sk=
Received: from localhost ([109.108.76.111]) by smtp.gmail.com with ESMTPSA id
 u27-20020a2eb81b000000b002d0a5ae203fsm398385ljo.10.2024.02.06.14.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 14:32:04 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 4/7] cmd: avb: rework prints
Date: Tue,  6 Feb 2024 23:31:50 +0100
Message-Id: <20240206223153.3060433-5-igor.opaniuk@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206223153.3060433-1-igor.opaniuk@foundries.io>
References: <20240206223153.3060433-1-igor.opaniuk@foundries.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Igor Opaniuk <igor.opaniuk@gmail.com>

Introduce AVB_OPS_CHECK macro for checking AvbOps before using
it to avoid code duplication.
Simplify and add more context for prints where it's needed.

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

 cmd/avb.c | 156 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 80 insertions(+), 76 deletions(-)

diff --git a/cmd/avb.c b/cmd/avb.c
index ce8b63873f2..ae0012c0e79 100644
--- a/cmd/avb.c
+++ b/cmd/avb.c
@@ -11,6 +11,14 @@
 #include <mmc.h>
 
 #define AVB_BOOTARGS	"avb_bootargs"
+
+#define AVB_OPS_CHECK(avb_ops) do { \
+	if (!(avb_ops)) { \
+		printf("AVB is not initialized, please run 'avb init <id>'\n"); \
+		return CMD_RET_FAILURE; \
+	} \
+} while (false)
+
 static struct AvbOps *avb_ops;
 
 int do_avb_init(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
@@ -28,8 +36,10 @@ int do_avb_init(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	avb_ops = avb_ops_alloc(mmc_dev);
 	if (avb_ops)
 		return CMD_RET_SUCCESS;
+	else
+		printf("Can't allocate AvbOps");
 
-	printf("Failed to initialize avb2\n");
+	printf("Failed to initialize AVB\n");
 
 	return CMD_RET_FAILURE;
 }
@@ -41,11 +51,9 @@ int do_avb_read_part(struct cmd_tbl *cmdtp, int flag, int argc,
 	s64 offset;
 	size_t bytes, bytes_read = 0;
 	void *buffer;
+	int ret;
 
-	if (!avb_ops) {
-		printf("AVB 2.0 is not initialized, please run 'avb init'\n");
-		return CMD_RET_USAGE;
-	}
+	AVB_OPS_CHECK(avb_ops);
 
 	if (argc != 5)
 		return CMD_RET_USAGE;
@@ -55,14 +63,15 @@ int do_avb_read_part(struct cmd_tbl *cmdtp, int flag, int argc,
 	bytes = hextoul(argv[3], NULL);
 	buffer = (void *)hextoul(argv[4], NULL);
 
-	if (avb_ops->read_from_partition(avb_ops, part, offset, bytes,
-					 buffer, &bytes_read) ==
-					 AVB_IO_RESULT_OK) {
+	ret = avb_ops->read_from_partition(avb_ops, part, offset,
+					   bytes, buffer, &bytes_read);
+	if (ret == AVB_IO_RESULT_OK) {
 		printf("Read %zu bytes\n", bytes_read);
 		return CMD_RET_SUCCESS;
 	}
 
-	printf("Failed to read from partition\n");
+	printf("Failed to read from partition '%s', err = %d\n",
+	       part, ret);
 
 	return CMD_RET_FAILURE;
 }
@@ -74,11 +83,9 @@ int do_avb_read_part_hex(struct cmd_tbl *cmdtp, int flag, int argc,
 	s64 offset;
 	size_t bytes, bytes_read = 0;
 	char *buffer;
+	int ret;
 
-	if (!avb_ops) {
-		printf("AVB 2.0 is not initialized, please run 'avb init'\n");
-		return CMD_RET_USAGE;
-	}
+	AVB_OPS_CHECK(avb_ops);
 
 	if (argc != 4)
 		return CMD_RET_USAGE;
@@ -94,8 +101,9 @@ int do_avb_read_part_hex(struct cmd_tbl *cmdtp, int flag, int argc,
 	}
 	memset(buffer, 0, bytes);
 
-	if (avb_ops->read_from_partition(avb_ops, part, offset, bytes, buffer,
-					 &bytes_read) == AVB_IO_RESULT_OK) {
+	ret = avb_ops->read_from_partition(avb_ops, part, offset,
+					   bytes, buffer, &bytes_read);
+	if (ret == AVB_IO_RESULT_OK) {
 		printf("Requested %zu, read %zu bytes\n", bytes, bytes_read);
 		printf("Data: ");
 		for (int i = 0; i < bytes_read; i++)
@@ -107,7 +115,8 @@ int do_avb_read_part_hex(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_SUCCESS;
 	}
 
-	printf("Failed to read from partition\n");
+	printf("Failed to read from partition '%s', err = %d\n",
+	       part, ret);
 
 	free(buffer);
 	return CMD_RET_FAILURE;
@@ -120,11 +129,9 @@ int do_avb_write_part(struct cmd_tbl *cmdtp, int flag, int argc,
 	s64 offset;
 	size_t bytes;
 	void *buffer;
+	int ret;
 
-	if (!avb_ops) {
-		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
-		return CMD_RET_FAILURE;
-	}
+	AVB_OPS_CHECK(avb_ops);
 
 	if (argc != 5)
 		return CMD_RET_USAGE;
@@ -134,13 +141,15 @@ int do_avb_write_part(struct cmd_tbl *cmdtp, int flag, int argc,
 	bytes = hextoul(argv[3], NULL);
 	buffer = (void *)hextoul(argv[4], NULL);
 
-	if (avb_ops->write_to_partition(avb_ops, part, offset, bytes, buffer) ==
-	    AVB_IO_RESULT_OK) {
+	ret = avb_ops->write_to_partition(avb_ops, part, offset,
+					  bytes, buffer);
+	if (ret == AVB_IO_RESULT_OK) {
 		printf("Wrote %zu bytes\n", bytes);
 		return CMD_RET_SUCCESS;
 	}
 
-	printf("Failed to write in partition\n");
+	printf("Failed to write in partition '%s', err = %d\n",
+	       part, ret);
 
 	return CMD_RET_FAILURE;
 }
@@ -150,24 +159,23 @@ int do_avb_read_rb(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	size_t index;
 	u64 rb_idx;
+	int ret;
 
-	if (!avb_ops) {
-		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
-		return CMD_RET_FAILURE;
-	}
+	AVB_OPS_CHECK(avb_ops);
 
 	if (argc != 2)
 		return CMD_RET_USAGE;
 
 	index = (size_t)hextoul(argv[1], NULL);
 
-	if (avb_ops->read_rollback_index(avb_ops, index, &rb_idx) ==
-	    AVB_IO_RESULT_OK) {
+	ret = avb_ops->read_rollback_index(avb_ops, index, &rb_idx);
+	if (ret == AVB_IO_RESULT_OK) {
 		printf("Rollback index: %llx\n", rb_idx);
 		return CMD_RET_SUCCESS;
 	}
 
-	printf("Failed to read rollback index\n");
+	printf("Failed to read rollback index id = %zu, err = %d\n",
+	       index, ret);
 
 	return CMD_RET_FAILURE;
 }
@@ -177,11 +185,9 @@ int do_avb_write_rb(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	size_t index;
 	u64 rb_idx;
+	int ret;
 
-	if (!avb_ops) {
-		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
-		return CMD_RET_FAILURE;
-	}
+	AVB_OPS_CHECK(avb_ops);
 
 	if (argc != 3)
 		return CMD_RET_USAGE;
@@ -189,11 +195,12 @@ int do_avb_write_rb(struct cmd_tbl *cmdtp, int flag, int argc,
 	index = (size_t)hextoul(argv[1], NULL);
 	rb_idx = hextoul(argv[2], NULL);
 
-	if (avb_ops->write_rollback_index(avb_ops, index, rb_idx) ==
-	    AVB_IO_RESULT_OK)
+	ret = avb_ops->write_rollback_index(avb_ops, index, rb_idx);
+	if (ret == AVB_IO_RESULT_OK)
 		return CMD_RET_SUCCESS;
 
-	printf("Failed to write rollback index\n");
+	printf("Failed to write rollback index id = %zu, err = %d\n",
+	       index, ret);
 
 	return CMD_RET_FAILURE;
 }
@@ -203,25 +210,25 @@ int do_avb_get_uuid(struct cmd_tbl *cmdtp, int flag,
 {
 	const char *part;
 	char buffer[UUID_STR_LEN + 1];
+	int ret;
 
-	if (!avb_ops) {
-		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
-		return CMD_RET_FAILURE;
-	}
+	AVB_OPS_CHECK(avb_ops);
 
 	if (argc != 2)
 		return CMD_RET_USAGE;
 
 	part = argv[1];
 
-	if (avb_ops->get_unique_guid_for_partition(avb_ops, part, buffer,
-						   UUID_STR_LEN + 1) ==
-						   AVB_IO_RESULT_OK) {
+	ret = avb_ops->get_unique_guid_for_partition(avb_ops, part,
+						     buffer,
+						     UUID_STR_LEN + 1);
+	if (ret == AVB_IO_RESULT_OK) {
 		printf("'%s' UUID: %s\n", part, buffer);
 		return CMD_RET_SUCCESS;
 	}
 
-	printf("Failed to read UUID\n");
+	printf("Failed to read partition '%s' UUID, err = %d\n",
+	       part, ret);
 
 	return CMD_RET_FAILURE;
 }
@@ -235,14 +242,12 @@ int do_avb_verify_part(struct cmd_tbl *cmdtp, int flag,
 	char *cmdline;
 	char *extra_args;
 	char *slot_suffix = "";
+	int ret;
 
 	bool unlocked = false;
 	int res = CMD_RET_FAILURE;
 
-	if (!avb_ops) {
-		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
-		return CMD_RET_FAILURE;
-	}
+	AVB_OPS_CHECK(avb_ops);
 
 	if (argc < 1 || argc > 2)
 		return CMD_RET_USAGE;
@@ -253,9 +258,10 @@ int do_avb_verify_part(struct cmd_tbl *cmdtp, int flag,
 	printf("## Android Verified Boot 2.0 version %s\n",
 	       avb_version_string());
 
-	if (avb_ops->read_is_device_unlocked(avb_ops, &unlocked) !=
-	    AVB_IO_RESULT_OK) {
-		printf("Can't determine device lock state.\n");
+	ret = avb_ops->read_is_device_unlocked(avb_ops, &unlocked);
+	if (ret != AVB_IO_RESULT_OK) {
+		printf("Can't determine device lock state, err = %d\n",
+		       ret);
 		return CMD_RET_FAILURE;
 	}
 
@@ -302,10 +308,10 @@ int do_avb_verify_part(struct cmd_tbl *cmdtp, int flag,
 		printf("Corrupted dm-verity metadata detected\n");
 		break;
 	case AVB_SLOT_VERIFY_RESULT_ERROR_UNSUPPORTED_VERSION:
-		printf("Unsupported version avbtool was used\n");
+		printf("Unsupported version of avbtool was used\n");
 		break;
 	case AVB_SLOT_VERIFY_RESULT_ERROR_ROLLBACK_INDEX:
-		printf("Checking rollback index failed\n");
+		printf("Rollback index check failed\n");
 		break;
 	case AVB_SLOT_VERIFY_RESULT_ERROR_PUBLIC_KEY_REJECTED:
 		printf("Public key was rejected\n");
@@ -324,24 +330,23 @@ int do_avb_is_unlocked(struct cmd_tbl *cmdtp, int flag,
 		       int argc, char *const argv[])
 {
 	bool unlock;
+	int ret;
 
-	if (!avb_ops) {
-		printf("AVB not initialized, run 'avb init' first\n");
-		return CMD_RET_FAILURE;
-	}
+	AVB_OPS_CHECK(avb_ops);
 
 	if (argc != 1) {
 		printf("--%s(-1)\n", __func__);
 		return CMD_RET_USAGE;
 	}
 
-	if (avb_ops->read_is_device_unlocked(avb_ops, &unlock) ==
-	    AVB_IO_RESULT_OK) {
+	ret = avb_ops->read_is_device_unlocked(avb_ops, &unlock);
+	if (ret == AVB_IO_RESULT_OK) {
 		printf("Unlocked = %d\n", unlock);
 		return CMD_RET_SUCCESS;
 	}
 
-	printf("Can't determine device lock state.\n");
+	printf("Can't determine device lock state, err = %d\n",
+	       ret);
 
 	return CMD_RET_FAILURE;
 }
@@ -354,11 +359,9 @@ int do_avb_read_pvalue(struct cmd_tbl *cmdtp, int flag, int argc,
 	size_t bytes_read;
 	void *buffer;
 	char *endp;
+	int ret;
 
-	if (!avb_ops) {
-		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
-		return CMD_RET_FAILURE;
-	}
+	AVB_OPS_CHECK(avb_ops);
 
 	if (argc != 3)
 		return CMD_RET_USAGE;
@@ -372,15 +375,16 @@ int do_avb_read_pvalue(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (!buffer)
 		return CMD_RET_FAILURE;
 
-	if (avb_ops->read_persistent_value(avb_ops, name, bytes, buffer,
-					   &bytes_read) == AVB_IO_RESULT_OK) {
+	ret = avb_ops->read_persistent_value(avb_ops, name, bytes,
+					     buffer, &bytes_read);
+	if (ret == AVB_IO_RESULT_OK) {
 		printf("Read %zu bytes, value = %s\n", bytes_read,
 		       (char *)buffer);
 		free(buffer);
 		return CMD_RET_SUCCESS;
 	}
 
-	printf("Failed to read persistent value\n");
+	printf("Failed to read persistent value, err = %d\n", ret);
 
 	free(buffer);
 
@@ -392,11 +396,9 @@ int do_avb_write_pvalue(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	const char *name;
 	const char *value;
+	int ret;
 
-	if (!avb_ops) {
-		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
-		return CMD_RET_FAILURE;
-	}
+	AVB_OPS_CHECK(avb_ops);
 
 	if (argc != 3)
 		return CMD_RET_USAGE;
@@ -404,14 +406,16 @@ int do_avb_write_pvalue(struct cmd_tbl *cmdtp, int flag, int argc,
 	name = argv[1];
 	value = argv[2];
 
-	if (avb_ops->write_persistent_value(avb_ops, name, strlen(value) + 1,
-					    (const uint8_t *)value) ==
-	    AVB_IO_RESULT_OK) {
+	ret = avb_ops->write_persistent_value(avb_ops, name,
+					      strlen(value) + 1,
+					      (const uint8_t *)value);
+	if (ret == AVB_IO_RESULT_OK) {
 		printf("Wrote %zu bytes\n", strlen(value) + 1);
 		return CMD_RET_SUCCESS;
 	}
 
-	printf("Failed to write persistent value\n");
+	printf("Failed to write persistent value `%s` = `%s`, err = %d\n",
+	       name, value, ret);
 
 	return CMD_RET_FAILURE;
 }
-- 
2.34.1


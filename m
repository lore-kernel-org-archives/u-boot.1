Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922D1C4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 19:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F94087E95;
	Fri,  9 Feb 2024 20:21:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="a7VH8aKP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C9D687E87; Fri,  9 Feb 2024 20:21:05 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B05787E87
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 20:21:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a39e31e1aa9so160060666b.0
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 11:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707506462; x=1708111262; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=veThWOrlXHjv4EEsHOPFhE1Mwq2MyiRzm9NmIFrNp8Q=;
 b=a7VH8aKPK0SiGzWdUNfsPpN0FSHLbjU1JDgOHEEx3MRp16ctihsXhSoEPXA1kXVGla
 wbr+KTVVLR1ENNkCI+0fvVbvGNhCGR+GgXfd2Cp4EJrH/hfluOM4zktLEGn3I3nNM+TI
 1karm9Ti5qjaYd1mYlCmhcl1ujM7u9L7iLzdKTxON0DNqpBwdRxVpQIKtku3ci5sRUZD
 o13NB3j+h/qyIjGARPfWSZ/AbgaYDkHofNSxvs8dB7aqV5dokXCPpicd4KKUQWnJdFr4
 NJmJa2TMlcxzBRe1dzRqXSslEIpa+dejJd5ITNyO/FSHr2tVpMt0VVe0hzbu3pnjF3MO
 IOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707506462; x=1708111262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=veThWOrlXHjv4EEsHOPFhE1Mwq2MyiRzm9NmIFrNp8Q=;
 b=aig7CwGZ8C161EG8JnWi9K14sx1h69Uxl0WeKg56NvbvyGN7JehfJ/TYBYU6WnFvQM
 JuyB9kn+u+6nUH2IhLHSw17VI2EIEouWizXgxfkR/+V7ZvB2tusJUcVPMWtPNMBJyHxj
 t3YaApqC9K02QsgPioRMkQYAQ+T1JHoPB/2D4LGmpN+e1PhgpNWr1SAyXKbP5LAF1dK+
 k1z0hCn6UUf//BaocMMQ1d0PML3kYTetYgfKwq1gLqG8NvoZ25t8IIR7QUVoJ2tmA/cr
 UWGxzNNDITA8/sf7Yk/UfO6E2u7b3VuIgpC2OCGIQQ+jt7hkMUz379Fqb525AE3hINyJ
 WWPQ==
X-Gm-Message-State: AOJu0YwiMN+B8NiryLW/Idhlt76vZTXvLrtgPx9neqYKVyjLRT3pFzXd
 +Jofz8EzYo74s1M7MtGDi5l71oyq+4TlBwZTbqFa0exhGLJQ6evlV6ZT5ncPItl+Nen21iSI2r/
 D/Lk=
X-Google-Smtp-Source: AGHT+IELVnyzrjEnu/29Gnal11yv7Jdew3umGm7UiLZ2o3BolZuV2uuaCn+jkfjZWno7ku8cYLdzlg==
X-Received: by 2002:a17:906:f854:b0:a38:3282:baf0 with SMTP id
 ks20-20020a170906f85400b00a383282baf0mr12691ejb.75.1707506462270; 
 Fri, 09 Feb 2024 11:21:02 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWFJr8Ymxpekq/kWqIq4kdyXCnlqZ8UhzckR+zNAcvz8bdSVhaZ95MEwk7LNduBPmP6OF5ICDpkmDyxLx58xMnrSn8yBx54E4XT0FefzK0+bhbKCysMZZYBE3o=
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 vu7-20020a170907a64700b00a371a1b40c1sm1039833ejc.23.2024.02.09.11.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 11:21:01 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 4/7] cmd: avb: rework prints
Date: Fri,  9 Feb 2024 20:20:42 +0100
Message-Id: <20240209192045.3961832-5-igor.opaniuk@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209192045.3961832-1-igor.opaniuk@foundries.io>
References: <20240209192045.3961832-1-igor.opaniuk@foundries.io>
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

Simplify and add more context for prints where it's needed.

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

Changes in v2:
- Drop AVB_OPS_CHECK macro and leave previous check

 cmd/avb.c | 123 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 75 insertions(+), 48 deletions(-)

diff --git a/cmd/avb.c b/cmd/avb.c
index ce8b63873f2..62a3ee18e7f 100644
--- a/cmd/avb.c
+++ b/cmd/avb.c
@@ -11,6 +11,7 @@
 #include <mmc.h>
 
 #define AVB_BOOTARGS	"avb_bootargs"
+
 static struct AvbOps *avb_ops;
 
 int do_avb_init(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
@@ -28,8 +29,10 @@ int do_avb_init(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	avb_ops = avb_ops_alloc(mmc_dev);
 	if (avb_ops)
 		return CMD_RET_SUCCESS;
+	else
+		printf("Can't allocate AvbOps");
 
-	printf("Failed to initialize avb2\n");
+	printf("Failed to initialize AVB\n");
 
 	return CMD_RET_FAILURE;
 }
@@ -41,10 +44,11 @@ int do_avb_read_part(struct cmd_tbl *cmdtp, int flag, int argc,
 	s64 offset;
 	size_t bytes, bytes_read = 0;
 	void *buffer;
+	int ret;
 
 	if (!avb_ops) {
-		printf("AVB 2.0 is not initialized, please run 'avb init'\n");
-		return CMD_RET_USAGE;
+		printf("AVB is not initialized, please run 'avb init <id>'\n");
+		return CMD_RET_FAILURE;
 	}
 
 	if (argc != 5)
@@ -55,14 +59,15 @@ int do_avb_read_part(struct cmd_tbl *cmdtp, int flag, int argc,
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
@@ -74,10 +79,11 @@ int do_avb_read_part_hex(struct cmd_tbl *cmdtp, int flag, int argc,
 	s64 offset;
 	size_t bytes, bytes_read = 0;
 	char *buffer;
+	int ret;
 
 	if (!avb_ops) {
-		printf("AVB 2.0 is not initialized, please run 'avb init'\n");
-		return CMD_RET_USAGE;
+		printf("AVB is not initialized, please run 'avb init <id>'\n");
+		return CMD_RET_FAILURE;
 	}
 
 	if (argc != 4)
@@ -94,8 +100,9 @@ int do_avb_read_part_hex(struct cmd_tbl *cmdtp, int flag, int argc,
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
@@ -107,7 +114,8 @@ int do_avb_read_part_hex(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_SUCCESS;
 	}
 
-	printf("Failed to read from partition\n");
+	printf("Failed to read from partition '%s', err = %d\n",
+	       part, ret);
 
 	free(buffer);
 	return CMD_RET_FAILURE;
@@ -120,9 +128,10 @@ int do_avb_write_part(struct cmd_tbl *cmdtp, int flag, int argc,
 	s64 offset;
 	size_t bytes;
 	void *buffer;
+	int ret;
 
 	if (!avb_ops) {
-		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
+		printf("AVB is not initialized, please run 'avb init <id>'\n");
 		return CMD_RET_FAILURE;
 	}
 
@@ -134,13 +143,15 @@ int do_avb_write_part(struct cmd_tbl *cmdtp, int flag, int argc,
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
@@ -150,9 +161,10 @@ int do_avb_read_rb(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	size_t index;
 	u64 rb_idx;
+	int ret;
 
 	if (!avb_ops) {
-		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
+		printf("AVB is not initialized, please run 'avb init <id>'\n");
 		return CMD_RET_FAILURE;
 	}
 
@@ -161,13 +173,14 @@ int do_avb_read_rb(struct cmd_tbl *cmdtp, int flag, int argc,
 
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
@@ -177,9 +190,10 @@ int do_avb_write_rb(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	size_t index;
 	u64 rb_idx;
+	int ret;
 
 	if (!avb_ops) {
-		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
+		printf("AVB is not initialized, please run 'avb init <id>'\n");
 		return CMD_RET_FAILURE;
 	}
 
@@ -189,11 +203,12 @@ int do_avb_write_rb(struct cmd_tbl *cmdtp, int flag, int argc,
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
@@ -203,9 +218,10 @@ int do_avb_get_uuid(struct cmd_tbl *cmdtp, int flag,
 {
 	const char *part;
 	char buffer[UUID_STR_LEN + 1];
+	int ret;
 
 	if (!avb_ops) {
-		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
+		printf("AVB is not initialized, please run 'avb init <id>'\n");
 		return CMD_RET_FAILURE;
 	}
 
@@ -214,14 +230,16 @@ int do_avb_get_uuid(struct cmd_tbl *cmdtp, int flag,
 
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
@@ -235,12 +253,13 @@ int do_avb_verify_part(struct cmd_tbl *cmdtp, int flag,
 	char *cmdline;
 	char *extra_args;
 	char *slot_suffix = "";
+	int ret;
 
 	bool unlocked = false;
 	int res = CMD_RET_FAILURE;
 
 	if (!avb_ops) {
-		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
+		printf("AVB is not initialized, please run 'avb init <id>'\n");
 		return CMD_RET_FAILURE;
 	}
 
@@ -253,9 +272,10 @@ int do_avb_verify_part(struct cmd_tbl *cmdtp, int flag,
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
 
@@ -302,10 +322,10 @@ int do_avb_verify_part(struct cmd_tbl *cmdtp, int flag,
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
@@ -324,9 +344,10 @@ int do_avb_is_unlocked(struct cmd_tbl *cmdtp, int flag,
 		       int argc, char *const argv[])
 {
 	bool unlock;
+	int ret;
 
 	if (!avb_ops) {
-		printf("AVB not initialized, run 'avb init' first\n");
+		printf("AVB is not initialized, please run 'avb init <id>'\n");
 		return CMD_RET_FAILURE;
 	}
 
@@ -335,13 +356,14 @@ int do_avb_is_unlocked(struct cmd_tbl *cmdtp, int flag,
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
@@ -354,9 +376,10 @@ int do_avb_read_pvalue(struct cmd_tbl *cmdtp, int flag, int argc,
 	size_t bytes_read;
 	void *buffer;
 	char *endp;
+	int ret;
 
 	if (!avb_ops) {
-		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
+		printf("AVB is not initialized, please run 'avb init <id>'\n");
 		return CMD_RET_FAILURE;
 	}
 
@@ -372,15 +395,16 @@ int do_avb_read_pvalue(struct cmd_tbl *cmdtp, int flag, int argc,
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
 
@@ -392,9 +416,10 @@ int do_avb_write_pvalue(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	const char *name;
 	const char *value;
+	int ret;
 
 	if (!avb_ops) {
-		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
+		printf("AVB is not initialized, please run 'avb init <id>'\n");
 		return CMD_RET_FAILURE;
 	}
 
@@ -404,14 +429,16 @@ int do_avb_write_pvalue(struct cmd_tbl *cmdtp, int flag, int argc,
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


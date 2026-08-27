Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F3DC61DC2
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 13:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E3F7607A5;
	Thu, 27 Aug 2026 13:00:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nZr9Wf_rpi4p; Thu, 27 Aug 2026 13:00:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787835631;
	bh=2jTtLinbOSr3KLGM/UYWJ9AaTLB+g6+xgY/YBkkJmN8=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OE6m0Gb8d3cQ+JxsmlWw+/OYMx0WjSWLSs+8LU698jRAD5wWtluewUnSLKsbsEsTr
	 CNxfFlExhIEVfwzcmNK1vSngcHTXWK18zcc0+OfSZDRLFDUb3y16PAHn0jJwJ/YctG
	 tomb0exc+0MEDS600QnruszlGYPWVYagk8LqbzPWeSUaZ268jhIqyxxL5GIkWn7Wfk
	 tyE97CD8Mcbyp4jIbeV8HfHQ6bzXSkv8AtihUCUqqcr+a8SKMUaJBQwwq03w2Rwdp3
	 3IvzIKca0mc2jYCb6EeTVZbiDuaUlOKXdB28tKFnhBxFUNBYjxvuEkN51bTQjanHYQ
	 +lCrKu7u4Xf4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 529306079F;
	Thu, 27 Aug 2026 13:00:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5505A334
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 13:00:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 472A26079F
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 13:00:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6W5WabYMRi2W for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 13:00:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=JsJQIVwV
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DD18F6077F
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 13:00:28 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-499b2981a7bso7854225e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 06:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787835626; x=1788440426;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2jTtLinbOSr3KLGM/UYWJ9AaTLB+g6+xgY/YBkkJmN8=;
 b=JsJQIVwVdIReHoaWMEBsm7DTj3kkBLKgqTlINHQ7mhi68yjpPH4FAkzxk6D/Hr6uXt
 IS+hllf/CgZ5tB6Bnpxktz80ca7WP2CESVmae1gRMAiIWglZ2TqiuiX3XDK2AJRPFvQw
 OHKW4fxRvhX7ZvoFaK3kyAARaP7fuLLYbIYXhCc9NPHQ6Ps7hNH6Mqs6ug2ug18gKI5h
 060sVXBPHWP0F6F+tB1aAFJFPvlN+M8yNTNwuWOMJi2oTz8xFRRwtvJCheM3Y02U6zYa
 9uOJd8tTRZRLOhGBM1JUbsf5c7lqgci0Ex6pRHNDTQ7rWNb8A125u1VNeUDPH6BmtfJ0
 bBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787835626; x=1788440426;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2jTtLinbOSr3KLGM/UYWJ9AaTLB+g6+xgY/YBkkJmN8=;
 b=VPbNoHGL6wQBnabeiXrOc67CU4pWXKYYzi1wqnvnK6olvDIrpAhje1+QIbBzGhEfUB
 R3YmXhhGPHJyzycv+AaO1x/tMnCqVoQFbO7S5aYuWEZIn+z8RGMXUW4bq1cH3qZftmYn
 JHrgOT1GWFF40TthpzaGzKPaKsWZyh0CDH/2rgH/hz/i1HdUV5f2IiHi5zYZxXjgevk5
 9CoYc++3W1pC7nFxTFxKeDyvafxpJRK6XXfDh4yjBCM6WNCpt8byXaY7sH72dJtyHcBd
 m4ajil7bgn79z/pV8NEQ1qAcq3P2kUaGcOCdwPPQH6Voi39zI0iWFxFWCsX/QJhxhQ5F
 7C2Q==
X-Gm-Message-State: AFuF++kCNwNxFQHcKUpXdE84Ed9w4p5ym6ZgnHhJKZPs1JCqvEYxRZsz
 crgJRQbIodcW/GUdqv80Rz4hAWjQYlUIOo2yO/+jspcDhld8uzmOZpzjDE+j6qg7H/Q=
X-Gm-Gg: AR+sD12+i92TOuI3gWkOBYBpIFexHsjW8Ta3HwhVJEetiJgsg7oTzkf7sPXzWwO7OWE
 1C18OwX+DIp+mjbhc9FixhaoZZbV8zlKZn6JNOWs0QOaD0mpYcXkftatMFgmjDW4gVoiB6rhCss
 CUgJaxlcKTFW9xkEdZNYluIGKfU1n4jbEfu0jdmV8uJCbb2Z/9IAW7wkbbkTvqnpPItDicGqmPQ
 iLPtG02utdyNfS45CZ4EBs2QOSoHiFNJymg5arl9O0KUNbLdcnEIa4Tsbg2cpPXhuoBqiOhgDak
 egrJmrtKNt7D9r3gJRdjXRPihsXf3lAktzZ1vudePIbgGv0jCvB09UXufAsXE1liZrOCOg8kEDQ
 BMVkXUr9BySvCHXX1F3frg8vNSmgJ24da8y8WEpSpul/qYXNDnRCIp0BjMFguF5AuGMtlXQTlk1
 RrhcNlXV7eNJ2oLKCvAJyfTWcE2HeoMnd9zy3bU1C9PtUXQTksU0AV5tN9qs3YOvCgYN/lJnV5r
 PdmhyHfbor8iwb5TjrkqmKvf5U1G8iBWdGVmQwQ
X-Received: by 2002:a05:600c:c0da:b0:499:83f1:398 with SMTP id
 5b1f17b1804b1-499dc820705mr164049005e9.9.1787835626282; 
 Thu, 27 Aug 2026 06:00:26 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499fa55f4f3sm56051545e9.0.2026.08.27.06.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 06:00:25 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 27 Aug 2026 17:00:12 +0400
Subject: [PATCH] test: lib/uuid: Fix endianness for dynamic GUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-uuid-be-v1-1-9dc3b12cd691@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBSE4avIW2tSTbTiKmLRMngWSKsiEXdXL
 L/kn7kowDMC1dlFHgcHXpeEIs+om+wyQnCfTEoqLStlRIzcCwdRal0aGGsrCUr15jHw+T017e8
 Q3Yxuf+d03w+DeYdIawAAAA==
X-Change-ID: 20260827-uuid-be-56657e7aa80e
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5828; i=alchark@flipper.net;
 h=from:subject:message-id; bh=PI0zAyRfmwTeAMwMq2ZIg+YjTufqZzHawEvIEt+zBi8=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRNMHnxrv2xmNLM6ufmqqePMXWuUzk/i+3mOoE9wbfLJ
 qXLSDnO6JjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCq3/xgZNg66e2tlumJSsvubDwVbrc4KvIAf9r24LXHZj38NvHOh34mhn+WR9/
 ennFnWrzJp6VhX0L3eSXUzwqLEJPzns016+jxg8VMAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

If LIB_UUID is enabled on a big-endian board, such as when it is pulled
in by EFI_PARTITION, its tests will fail due to the dynamic capsule GUIDs
computed by lib_test_dynamic_uuid() using native endianness for the UTF-16
image name, instead of little-endian:

  malta # ut lib lib_test_dynamic_uuid
  Test: dynamic_uuid: uuid.c
  test/lib/uuid.c:114, lib_test_dynamic_uuid_case(): expected_uuid = uuid_str: Expected "985f2937-7c2e-5e9a-8a5e-8e063312964b", got "829f5cb0-1a07-5718-8774-4514bda82c39"
  Test 'dynamic_uuid' failed 1 times
  Tests run: 1, 2 ms, average: 2 ms, failures: 1
  exit not allowed from main input shell.
  malta #

Add explicit endianness conversion to the test and to other similar
callers of gen_v5_guid() to make sure they work uniformly regardless of
the host or target endianness.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
This was uncovered [1] while adding tests for GPT partition labels on big
endian boards, which pulls in PARTITION_UUIDS, which in turn pulls in
LIB_UUID and its tests. Turns out no BE board in CI ever enabled LIB_UUID,
so this went unnoticed to date.

The immediate users of this code other than the test suite are EFI capsule
updates, which is unlikely to be relevant for anything big endian (given
that UEFI is little endian), but the test suite itself seems to be a good
reason to get this fixed.

No functional change on little endian either way.

[1] https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelines/1101
---
 include/u-boot/uuid.h         |  5 +++++
 lib/efi_loader/efi_firmware.c | 19 ++++++++++++++++++-
 test/lib/uuid.c               | 15 ++++++++++++++-
 tools/mkeficapsule.c          |  3 ++-
 4 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/include/u-boot/uuid.h b/include/u-boot/uuid.h
index 7f8414dc906c..acdf3a85a6cb 100644
--- a/include/u-boot/uuid.h
+++ b/include/u-boot/uuid.h
@@ -149,6 +149,11 @@ struct efi_guid;
 /**
  * gen_v5_guid() - generate little endian v5 GUID from namespace and other seed data.
  *
+ * The seed data is hashed as raw bytes, so any of it that is not a byte string
+ * has to be supplied in a fixed byte order for the result to be reproducible.
+ * UTF-16 seed data, such as a firmware image name, must therefore be passed
+ * little-endian, which is the byte order the UEFI specification uses for it.
+ *
  * @namespace:   pointer to UUID namespace salt
  * @guid:        pointer to allocated GUID output
  * @...:         NULL terminated list of seed data as pairs of pointers
diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index b41969c70fde..7f3b2da3ef89 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -279,15 +279,32 @@ static efi_status_t efi_gen_capsule_guids(void)
 	}
 
 	for (i = 0; i < update_info.num_images; i++) {
+		size_t len, j;
+		u16 *name_le;
+
 		if (!fw_array[i].fw_name) {
 			log_err("fw_name is not defined. Not generating capsule GUIDs\n");
 			return EFI_INVALID_PARAMETER;
 		}
+
+		/*
+		 * The name is hashed as UTF-16LE, so that a big-endian board
+		 * arrives at the same GUID as mkeficapsule running on a
+		 * little-endian build host.
+		 */
+		len = u16_strlen(fw_array[i].fw_name);
+		name_le = calloc(len, sizeof(*name_le));
+		if (!name_le)
+			return EFI_OUT_OF_RESOURCES;
+		for (j = 0; j < len; j++)
+			name_le[j] = cpu_to_le16(fw_array[i].fw_name[j]);
+
 		gen_v5_guid(&namespace,
 			    &fw_array[i].image_type_id,
 			    compatible, strlen(compatible),
-			    fw_array[i].fw_name, u16_strlen(fw_array[i].fw_name) * sizeof(uint16_t),
+			    name_le, len * sizeof(*name_le),
 			    NULL);
+		free(name_le);
 
 		log_debug("Image %ls UUID %pUl\n", fw_array[i].fw_name,
 			  &fw_array[i].image_type_id);
diff --git a/test/lib/uuid.c b/test/lib/uuid.c
index d00e9563a472..1c66021af3ed 100644
--- a/test/lib/uuid.c
+++ b/test/lib/uuid.c
@@ -10,6 +10,7 @@
 
 #include <charset.h>
 #include <u-boot/uuid.h>
+#include <asm/byteorder.h>
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
@@ -102,12 +103,24 @@ static int lib_test_dynamic_uuid_case(struct unit_test_state *uts,
 	for (j = 0; data->images[j]; j++) {
 		const char *expected_uuid = data->expected_uuids[j];
 		const u16 *image = data->images[j];
+		u16 image_le[64];
 		efi_guid_t uuid;
 		char uuid_str[37];
+		size_t len, k;
+
+		/*
+		 * u"..." is native-endian, but the name is hashed as UTF-16LE
+		 * so that the GUID does not depend on the endianness of the
+		 * board or of the host running mkeficapsule.
+		 */
+		len = u16_strlen(image);
+		ut_assert(len <= ARRAY_SIZE(image_le));
+		for (k = 0; k < len; k++)
+			image_le[k] = cpu_to_le16(image[k]);
 
 		gen_v5_guid(&namespace, &uuid,
 			    data->compatible, strlen(data->compatible),
-			    image, u16_strlen(image) * sizeof(uint16_t),
+			    image_le, len * sizeof(*image_le),
 			    NULL);
 		uuid_bin_to_str((unsigned char *)&uuid, uuid_str, UUID_STR_FORMAT_GUID);
 
diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index ec640c57e8a5..55a58f07d56e 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -1004,8 +1004,9 @@ static int genguid(int argc, char **argv)
 			return -1;
 		}
 
+		/* The name is hashed as UTF-16LE, whatever this host is */
 		for (int i = 0; i < namelen; i++)
-			fw_image[i] = (uint16_t)argv[idx][i];
+			fw_image[i] = cpu_to_le16((uint16_t)argv[idx][i]);
 
 		gen_v5_guid((struct uuid *)&namespace, &image_type_id,
 			    compatible, strlen(compatible),

---
base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
change-id: 20260827-uuid-be-56657e7aa80e

Best regards,
--  
Alexey Charkov <alchark@flipper.net>


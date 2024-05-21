Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBACDC25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 07:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0013988714;
	Tue, 21 May 2024 09:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lBwVNEPI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BEC08870D; Tue, 21 May 2024 09:13:47 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 361F687FA1
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 09:13:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2216B62023;
 Tue, 21 May 2024 07:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC6DC4AF07;
 Tue, 21 May 2024 07:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716275623;
 bh=1zJMs5UINm8+SccMtIC6Y10WB1G7s2Jqg9gnzuyAzgg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lBwVNEPIouAHe1NSKv7Oj9kwbhPeawuHFIDY8N7wVNFuFVmf7VX1TEujPm+99BCkX
 l1OsOzv6mpRCSt4dHSP9slsdA3jFZnQELgRw04U6X4Brhakty5EQJ08iEriMG7DNQi
 nYjVJt+kfq2DZB+sEzuT108W0dOvys6Kvz8DS0aHJXxGaItx2tRgg2aNgNdnoUUIFz
 HhyBbgmvNPSOk0P8r7PjzkNr9suVYGDKw9jnJ/UOxhF8xQGpUeMm06XKjNXNtk4jKL
 UAqmY0GaJBGMBCKQ3TELvr//LqPPDHEwAGrutjeFPe6u/pcRLLhHnCu9yu4xWuOYfO
 r3cI0VkcTUMUA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Stefan Roese <sr@denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nikita Kiryanov <nikita@compulab.co.il>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 02/11] common: eeprom_layout: Split field finding code from
 the field update function
Date: Tue, 21 May 2024 09:13:26 +0200
Message-ID: <20240521071335.4193-3-kabel@kernel.org>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240521071335.4193-1-kabel@kernel.org>
References: <20240521071335.4193-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Split the eeprom layout field finding code from the
eeprom_layout_update_field() function in order to make it usable in
alternative implementations of update method.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 common/eeprom/eeprom_layout.c | 46 +++++++++++++++++++++++------------
 include/eeprom_layout.h       |  4 +++
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/common/eeprom/eeprom_layout.c b/common/eeprom/eeprom_layout.c
index 406db3f7d1..801e90d38d 100644
--- a/common/eeprom/eeprom_layout.c
+++ b/common/eeprom/eeprom_layout.c
@@ -56,6 +56,28 @@ static void eeprom_layout_print(const struct eeprom_layout *layout)
 		fields[i].print(&fields[i]);
 }
 
+/*
+ * eeprom_layout_find_field() - finds a layout field by name
+ * @layout:	A pointer to an existing struct layout.
+ * @field_name:	The name of the field to update.
+ * @warn:	Whether to print a warning if the field is not found.
+ *
+ * Returns: a pointer to the found field or NULL on failure.
+ */
+struct eeprom_field *eeprom_layout_find_field(struct eeprom_layout *layout,
+					      char *field_name, bool warn)
+{
+	for (int i = 0; i < layout->num_of_fields; i++)
+		if (layout->fields[i].name != RESERVED_FIELDS &&
+		    !strcmp(layout->fields[i].name, field_name))
+			return &layout->fields[i];
+
+	if (warn)
+		printf("No such field '%s'\n", field_name);
+
+	return NULL;
+}
+
 /*
  * eeprom_layout_update_field() - update a single field in the layout data.
  * @layout:	A pointer to an existing struct layout.
@@ -67,8 +89,8 @@ static void eeprom_layout_print(const struct eeprom_layout *layout)
 static int eeprom_layout_update_field(struct eeprom_layout *layout,
 				      char *field_name, char *new_data)
 {
-	int i, err;
-	struct eeprom_field *fields = layout->fields;
+	struct eeprom_field *field;
+	int err;
 
 	if (new_data == NULL)
 		return 0;
@@ -76,21 +98,15 @@ static int eeprom_layout_update_field(struct eeprom_layout *layout,
 	if (field_name == NULL)
 		return -1;
 
-	for (i = 0; i < layout->num_of_fields; i++) {
-		if (fields[i].name == RESERVED_FIELDS ||
-		    strcmp(fields[i].name, field_name))
-			continue;
-
-		err = fields[i].update(&fields[i], new_data);
-		if (err)
-			printf("Invalid data for field %s\n", field_name);
-
-		return err;
-	}
+	field = eeprom_layout_find_field(layout, field_name, true);
+	if (field == NULL)
+		return -1;
 
-	printf("No such field '%s'\n", field_name);
+	err = field->update(field, new_data);
+	if (err)
+		printf("Invalid data for field %s\n", field_name);
 
-	return -1;
+	return err;
 }
 
 /*
diff --git a/include/eeprom_layout.h b/include/eeprom_layout.h
index 730d963ab9..b1d6220595 100644
--- a/include/eeprom_layout.h
+++ b/include/eeprom_layout.h
@@ -9,6 +9,8 @@
 #ifndef _LAYOUT_
 #define _LAYOUT_
 
+#include <eeprom_field.h>
+
 #define RESERVED_FIELDS			NULL
 #define LAYOUT_VERSION_UNRECOGNIZED	-1
 #define LAYOUT_VERSION_AUTODETECT	-2
@@ -24,6 +26,8 @@ struct eeprom_layout {
 		      char *new_data);
 };
 
+struct eeprom_field *eeprom_layout_find_field(struct eeprom_layout *layout,
+					      char *field_name, bool warn);
 void eeprom_layout_setup(struct eeprom_layout *layout, unsigned char *buf,
 			 unsigned int buf_size, int layout_version);
 __weak void __eeprom_layout_assign(struct eeprom_layout *layout,
-- 
2.44.1


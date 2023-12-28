Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CA8C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 18:02:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7A7587B34;
	Thu, 28 Dec 2023 19:02:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d1OvTfSZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0C4F879D8; Thu, 28 Dec 2023 19:02:19 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF30E879E9
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 19:02:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50e80d14404so2237610e87.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 10:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703786537; x=1704391337; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pMEwMWXDCScaOa3K6EE4L+Xru4Rd4F3ZodzDeOg2oNQ=;
 b=d1OvTfSZ7mjCDe7fQY8Z/Dbwv9dgkAfOBQ4ZTTYuoFcSI70OZ+TdKzC7z6GdDwgBXs
 AnVMcod/4ZVkFx82XBsV/sQI3G2Pqae7c3FEaf60gKdu+z/u3159iONNjNyu8FE1PO/Y
 5jeMCdemgc6ypCpWCdqUXB1p+4dIdkENxqt5g/fcqsc8pldK2OIoduIf6CXFa828I4Cr
 Bakyj2Cdzzci4YJOpLQSRr/oK1wmDQqHAT+AMSe8kPZQ0u13rt65USkuqEPbrWGI45fX
 ev8PKV5SsiXxRboQ8Kt8fFstj/pnqN2OuZ6+N1stbKQOxDfp3jcx+vhlre4LujJwd9S4
 HkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703786537; x=1704391337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pMEwMWXDCScaOa3K6EE4L+Xru4Rd4F3ZodzDeOg2oNQ=;
 b=pzSZHLBDVInKfXbuofnL9DfoGc8KJNknp9Oju+tZqt55ld0kCniZ++UmUn67dt8R3l
 MBzRe16vwa9glOvci1Bhreq6qRtPKB2AA6DR0817ocoNW1jZCO7I1+4WYLLsLNf1AcFx
 G4z0I0XbVOu0sCR4CwawV90HIlmi9aD1NgjjG+s8fDunL9fzlMDjrW46eQPf9lCUmCtj
 0dKr/O5s+qwf1oHtEx4ST0TMK2Tb6xkf61Ng4nTwQKSb36T1DgznbmpPKb5PPDgKCU3P
 y3rj8s9GnP0BxHuX6YU0gQW6XbxPOdl27d5NdAM4Yx+hecPwyTs0t4uVpIgAeINkMpuy
 hmtA==
X-Gm-Message-State: AOJu0YzDIUhk+JewDbwGE1pZpm5P/NDxMFLsyg6Cil2H7yKdroHk5Lr+
 Y9aH/vKmLRC6TIDwpY65GRY=
X-Google-Smtp-Source: AGHT+IF28JQ/0er+H1rFcHkAzLQyPVgxtleNUoKUyoyOrvTEl9F5muAYg9EeAvDiKaUvZ/TMi5SvOw==
X-Received: by 2002:ac2:4da4:0:b0:50e:7bbf:f365 with SMTP id
 h4-20020ac24da4000000b0050e7bbff365mr3088542lfe.31.1703786536840; 
 Thu, 28 Dec 2023 10:02:16 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 s4-20020a056512314400b0050e6b04a5b2sm1955101lfi.251.2023.12.28.10.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 10:02:16 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, Heiko Schocher <hs@denx.de>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v6 2/6] fastboot: implement "getvar all"
Date: Thu, 28 Dec 2023 20:01:50 +0200
Message-Id: <20231228180154.50473-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228180154.50473-1-clamor95@gmail.com>
References: <20231228180154.50473-1-clamor95@gmail.com>
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

From: Ion Agorria <ion@agorria.com>

This commit implements "fastboot getvar all" listing
by iterating the existing dispatchers that don't require
parameters (as we pass NULL), uses fastboot multiresponse.

Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 doc/android/fastboot-protocol.rst |  3 ++
 drivers/fastboot/fb_command.c     |  3 ++
 drivers/fastboot/fb_getvar.c      | 77 +++++++++++++++++++++++++------
 include/fastboot-internal.h       |  7 +++
 4 files changed, 77 insertions(+), 13 deletions(-)

diff --git a/doc/android/fastboot-protocol.rst b/doc/android/fastboot-protocol.rst
index e8cbd7f24e..8bd6d7168f 100644
--- a/doc/android/fastboot-protocol.rst
+++ b/doc/android/fastboot-protocol.rst
@@ -173,6 +173,9 @@ The various currently defined names are::
                       bootloader requiring a signature before
                       it will install or boot images.
 
+  all                 Provides all info from commands above as
+                      they were called one by one
+
 Names starting with a lowercase character are reserved by this
 specification.  OEM-specific names should not start with lowercase
 characters.
diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index ab72d8c781..6f621df074 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -156,6 +156,9 @@ int fastboot_handle_command(char *cmd_string, char *response)
 void fastboot_multiresponse(int cmd, char *response)
 {
 	switch (cmd) {
+	case FASTBOOT_COMMAND_GETVAR:
+		fastboot_getvar_all(response);
+		break;
 	default:
 		fastboot_fail("Unknown multiresponse command", response);
 		break;
diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
index 8cb8ffa2c6..f65519c57b 100644
--- a/drivers/fastboot/fb_getvar.c
+++ b/drivers/fastboot/fb_getvar.c
@@ -29,53 +29,67 @@ static void getvar_is_userspace(char *var_parameter, char *response);
 
 static const struct {
 	const char *variable;
+	bool list;
 	void (*dispatch)(char *var_parameter, char *response);
 } getvar_dispatch[] = {
 	{
 		.variable = "version",
-		.dispatch = getvar_version
+		.dispatch = getvar_version,
+		.list = true,
 	}, {
 		.variable = "version-bootloader",
-		.dispatch = getvar_version_bootloader
+		.dispatch = getvar_version_bootloader,
+		.list = true
 	}, {
 		.variable = "downloadsize",
-		.dispatch = getvar_downloadsize
+		.dispatch = getvar_downloadsize,
+		.list = true
 	}, {
 		.variable = "max-download-size",
-		.dispatch = getvar_downloadsize
+		.dispatch = getvar_downloadsize,
+		.list = true
 	}, {
 		.variable = "serialno",
-		.dispatch = getvar_serialno
+		.dispatch = getvar_serialno,
+		.list = true
 	}, {
 		.variable = "version-baseband",
-		.dispatch = getvar_version_baseband
+		.dispatch = getvar_version_baseband,
+		.list = true
 	}, {
 		.variable = "product",
-		.dispatch = getvar_product
+		.dispatch = getvar_product,
+		.list = true
 	}, {
 		.variable = "platform",
-		.dispatch = getvar_platform
+		.dispatch = getvar_platform,
+		.list = true
 	}, {
 		.variable = "current-slot",
-		.dispatch = getvar_current_slot
+		.dispatch = getvar_current_slot,
+		.list = true
 #if IS_ENABLED(CONFIG_FASTBOOT_FLASH)
 	}, {
 		.variable = "has-slot",
-		.dispatch = getvar_has_slot
+		.dispatch = getvar_has_slot,
+		.list = false
 #endif
 #if IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC)
 	}, {
 		.variable = "partition-type",
-		.dispatch = getvar_partition_type
+		.dispatch = getvar_partition_type,
+		.list = false
 #endif
 #if IS_ENABLED(CONFIG_FASTBOOT_FLASH)
 	}, {
 		.variable = "partition-size",
-		.dispatch = getvar_partition_size
+		.dispatch = getvar_partition_size,
+		.list = false
 #endif
 	}, {
 		.variable = "is-userspace",
-		.dispatch = getvar_is_userspace
+		.dispatch = getvar_is_userspace,
+		.list = true
 	}
 };
 
@@ -237,6 +251,40 @@ static void getvar_is_userspace(char *var_parameter, char *response)
 	fastboot_okay("no", response);
 }
 
+static int current_all_dispatch;
+void fastboot_getvar_all(char *response)
+{
+	/*
+	 * Find a dispatch getvar that can be listed and send
+	 * it as INFO until we reach the end.
+	 */
+	while (current_all_dispatch < ARRAY_SIZE(getvar_dispatch)) {
+		if (!getvar_dispatch[current_all_dispatch].list) {
+			current_all_dispatch++;
+			continue;
+		}
+
+		char envstr[FASTBOOT_RESPONSE_LEN] = { 0 };
+
+		getvar_dispatch[current_all_dispatch].dispatch(NULL, envstr);
+
+		char *envstr_start = envstr;
+
+		if (!strncmp("OKAY", envstr, 4) || !strncmp("FAIL", envstr, 4))
+			envstr_start += 4;
+
+		fastboot_response("INFO", response, "%s: %s",
+				  getvar_dispatch[current_all_dispatch].variable,
+				  envstr_start);
+
+		current_all_dispatch++;
+		return;
+	}
+
+	fastboot_response("OKAY", response, NULL);
+	current_all_dispatch = 0;
+}
+
 /**
  * fastboot_getvar() - Writes variable indicated by cmd_parameter to response.
  *
@@ -254,6 +302,9 @@ void fastboot_getvar(char *cmd_parameter, char *response)
 {
 	if (!cmd_parameter) {
 		fastboot_fail("missing var", response);
+	} else if (!strncmp("all", cmd_parameter, 3) && strlen(cmd_parameter) == 3) {
+		current_all_dispatch = 0;
+		fastboot_response(FASTBOOT_MULTIRESPONSE_START, response, NULL);
 	} else {
 #define FASTBOOT_ENV_PREFIX	"fastboot."
 		int i;
diff --git a/include/fastboot-internal.h b/include/fastboot-internal.h
index bf2f2b3c89..610d4f9141 100644
--- a/include/fastboot-internal.h
+++ b/include/fastboot-internal.h
@@ -18,6 +18,13 @@ extern u32 fastboot_buf_size;
  */
 extern void (*fastboot_progress_callback)(const char *msg);
 
+/**
+ * fastboot_getvar_all() - Writes current variable being listed from "all" to response.
+ *
+ * @response: Pointer to fastboot response buffer
+ */
+void fastboot_getvar_all(char *response);
+
 /**
  * fastboot_getvar() - Writes variable indicated by cmd_parameter to response.
  *
-- 
2.40.1


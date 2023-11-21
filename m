Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B8CC61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 18:35:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 126E187616;
	Tue, 21 Nov 2023 19:35:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VKjLQkVZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FEE087253; Tue, 21 Nov 2023 19:35:38 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D95987448
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 19:35:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-507962561adso8625700e87.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 10:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700591735; x=1701196535; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pMEwMWXDCScaOa3K6EE4L+Xru4Rd4F3ZodzDeOg2oNQ=;
 b=VKjLQkVZoal6W0vN1L3PoV+gtlMImsvp9B3actHDB0x2IKNFB+v1a4SrUi4GqM1cv0
 BJKkYa+97wvpgKzjOYpQdZJrB2Vljimke19fnRr2WpeCaO4KfvaDPqXoeYNtoOczrygg
 uURzt9uLsl4eZ9eLqfyQzuR4N/wJ4GYOiZ0ToaJEdnsGxUMkhCcZdNgdHbS/8T8RRXsW
 dOWs0b6jBX+gU/E9YpCGJZrmr/5bm5uTV9AscWxJ8nGT9hlFD87ilyHvf+zMh11WetYf
 d5gNEQd5al1OIIw5L5BohqSemrHkie/jGzCf7ZvDCYOuH7bp9Pf579L775NgdivPPbeS
 QT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700591735; x=1701196535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pMEwMWXDCScaOa3K6EE4L+Xru4Rd4F3ZodzDeOg2oNQ=;
 b=TcKxXrw9cS89R3co3Tma4XypFETe3NMIGIkmB94evxNVW5nQxlYk1/K+pNUcB1Owiq
 Icmst4nkpY/CRFtjPpgGQhLOwynOWUabgWuIeOwOu7pY6ur0LpYLg7z4PVM/5Uv97qtN
 og/go5WEqn48oVmDZ3liOHQqSpDD+HhnFeHju1tM7byUj9tBD32uHhe1UMAlxKE6ogIp
 9qsdbq3aZngVKD+hvTSflL4wubcTdA+D+OUPlQpgTXZiMPfLz+SmScfwwbt8mpLr/KzZ
 +DXzxIpfHvZxw3R+k34PdmeFPIU79BJg/SpipPSiNHqaADqcbvmFnM77xII9F3qAgULm
 ojMg==
X-Gm-Message-State: AOJu0Ywa+fzhXH5bSIBdbdcRciq7GXNGe1+kkI7Oa9yOdOoLzTVugyU3
 Nyi/XKGat/LAuzcwdQRQlkk=
X-Google-Smtp-Source: AGHT+IGx32uLb9KJjmLVj1fcIuh0tEJ4aKwrzq22qHoSwerTvMiyxeDUxhS5K7ym1YrfdhehvveRfg==
X-Received: by 2002:ac2:4469:0:b0:4fe:1681:9377 with SMTP id
 y9-20020ac24469000000b004fe16819377mr58454lfl.44.1700591735319; 
 Tue, 21 Nov 2023 10:35:35 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 a22-20020ac25e76000000b0050089b26ea1sm1592862lfr.276.2023.11.21.10.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 10:35:34 -0800 (PST)
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
Subject: [PATCH v3 2/5] fastboot: implement "getvar all"
Date: Tue, 21 Nov 2023 20:35:07 +0200
Message-Id: <20231121183510.6451-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121183510.6451-1-clamor95@gmail.com>
References: <20231121183510.6451-1-clamor95@gmail.com>
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


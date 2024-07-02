Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEBCC3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 13:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7D2E88749;
	Tue,  2 Jul 2024 15:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZzS4gO1l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C402E8858B; Tue,  2 Jul 2024 15:30:56 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B87CC88748
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 15:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a7245453319so668874166b.1
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 06:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719927054; x=1720531854; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yjYV9PN0xWDSskdBgidOP6JWHJHFlMDPu72voIUQ+z8=;
 b=ZzS4gO1lETZuETgVgFEvAYZHCeYWPLit7WlUJmjZSOismzQBADKWtKtT4HHSIdCoK2
 X2eILzybDOfAGj3qxBmw1dR/tN+mM/k1iEkfNHkbirsOGYzMG3fU9wqwGwDu6qrXk/8J
 y/niYpfAQ5ZCO0wahFQW9AFcbbtgtgd9oJrAZzF7gPULEZ1yJbQeahGpOFSQe2s8Hl8/
 Jbi+MinAc4I3XH0SjX/zl1hY+CWjVRcbYrALqLBg8jib7akThk5cwfc/lHOncBOCtIer
 JHDN1ha8H5N+YBEazSoqdwOIye1M92yhA5jTiQblJYal18TmZx/SfXXXOfJ8zj1CuhpA
 PcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719927054; x=1720531854;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yjYV9PN0xWDSskdBgidOP6JWHJHFlMDPu72voIUQ+z8=;
 b=cQ2fzAeIO5egggHDURBk3RxX3ADw8cqjG9EeAYRhUVVjl9Eiwt6/JdLW0ppKnj0SeV
 327M+m3xnUpEAsJ892+01l5oTxV3P69uf92AXMvxss/74XjFjj/97boxP6hVxQxXXSWX
 Y6JPVYxrOsCdlRqDYeFG1X+fo3tUTYGYd2SgZtWkndtPJvWspcPqHo6ViC/DJHEk4/F6
 /ulngRpfB+tUCa9NKI4mpEWL+7yCqhFmgdTagu9+/IPYKwK44TnbLXylpxzPgE9hAMZO
 WCgniF+crB5kUCzTdzgCPm0BWSBqfuXFVYP0/H8GyficJDP66EK+yViOm+m4QfUJxhEr
 V+sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlP39+U59By/Uwa9Yg+GMJURZqPWr0REWa5s7BJwcfLGqZuEgWHMDatQSsS3AKgLafj5Q8JXsvCcTsl2T/ApTvGUObAQ==
X-Gm-Message-State: AOJu0YzwWcwSslGQ05JwmIjY/ubPTE0wfe6XnS9aCAbujJHJIT9dVr1m
 HyXKyNo2RovPsGxg+lem6Pm6fJESdn3OEDNb1aksO1l5/ykLcEbK/fa0pRq2V8M=
X-Google-Smtp-Source: AGHT+IEDyhbNvaBhTGWEgJhUZNoOmk2zM7nCH7rKzOKqXikUUQiYqQW3PebkqJsVvZtlHV1Ix5dVTQ==
X-Received: by 2002:a17:907:268e:b0:a6f:e03a:99d with SMTP id
 a640c23a62f3a-a72aebe5e2bmr1215315266b.0.1719927054245; 
 Tue, 02 Jul 2024 06:30:54 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7430367d55sm323796166b.87.2024.07.02.06.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 06:30:53 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 02 Jul 2024 15:30:48 +0200
Subject: [PATCH v4 08/10] tools: mkeficapsule: use u-boot UUID library
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-b4-dynamic-uuid-v4-8-a00c82d1f504@linaro.org>
References: <20240702-b4-dynamic-uuid-v4-0-a00c82d1f504@linaro.org>
In-Reply-To: <20240702-b4-dynamic-uuid-v4-0-a00c82d1f504@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3757;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=aiqd52H8SbFQqjf61URtk1GpaBu2VRarurf54E5zAHs=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmhAEC0BWBqp6szlDj7/JWWG3qPJL7oQYKrHQm/
 +gYuO+hXHKJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZoQBAgAKCRAFgzErGV9k
 tk0WD/0Ro1IE5xZ6NVPsTyYf94QdmNECpbd5oV9bUYluWECzdFrgvB22aFVNoA1jQ2ITom65s1b
 zNb6cCCTVv6nQXaOiimEbKTGuluTW/VOC+GgqtQYT2sqcJwJjGtCk+QvwOUYQ9iuZc1nItbyjnP
 MhXSbhWWA//AjOgClWrcsSHoNOIOcgBSS9a60C1cGBtnd6dtWOp0MZvPZZ+NuBXL4yq/+1Cc/2D
 /qeAWPelzMjRyfSleMaG+sgpUwEzAWPf7Ql9y58PHA062JY7WcAjykLrD3yfTuLTN3LlAYmTVHG
 d1vhSddsDHiGAcjHCRfwSREZKCwrETav5dk9ALA5oAEiiitNwgx0AEZqgZ+Ljfpx4f1BFQCWA45
 BTrpU8Yb/jqgioZ81pGASXROUZ/qz1+wz3H9ytHkmTHf+v24QmLXKCUWO7n2JSV/PcbuX82NF+X
 UkhRLitwBOKX/EEScRHE58wVfkc/T8nOsxHOnmiqlMnN1KVnO5bJtRa1Y3AWuhYkDxKXKkx43Qy
 zyKgRJGJJGU9Ob6xKTbV0KCtMbSh4h7gdphW3SkZLuNAwaNnlSDjIlNeU/NBoAkUD9SXmOL0mLi
 3J7DK/nglwDhkbO8Uyw9tFQErExFfh3vIPK7tUBk3MWCuliaG5HVXZ7p3CMgrM95Ym+b1gk47v2
 Xdk6idsitUDDHuw==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Replace the use of libuuid with U-Boot's own UUID library. This prepares
us to add support for generating v5 GUIDs.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 tools/Makefile       |  8 ++++----
 tools/mkeficapsule.c | 53 ++++++----------------------------------------------
 2 files changed, 10 insertions(+), 51 deletions(-)

diff --git a/tools/Makefile b/tools/Makefile
index 6a4280e3668f..ee08a9675df8 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -245,14 +245,14 @@ hostprogs-$(CONFIG_ASN1_COMPILER)	+= asn1_compiler
 HOSTCFLAGS_asn1_compiler.o = -idirafter $(srctree)/include
 
 HOSTCFLAGS_mkeficapsule.o += \
 	$(shell pkg-config --cflags gnutls 2> /dev/null || echo "")
-HOSTCFLAGS_mkeficapsule.o += \
-	$(shell pkg-config --cflags uuid 2> /dev/null || echo "")
 HOSTLDLIBS_mkeficapsule += \
 	$(shell pkg-config --libs gnutls 2> /dev/null || echo "-lgnutls")
-HOSTLDLIBS_mkeficapsule += \
-	$(shell pkg-config --libs uuid 2> /dev/null || echo "-luuid")
+mkeficapsule-objs := generated/lib/uuid.o \
+	generated/lib/sha1.o \
+	$(LIBFDT_OBJS) \
+	mkeficapsule.o
 hostprogs-$(CONFIG_TOOLS_MKEFICAPSULE) += mkeficapsule
 
 mkfwumdata-objs := mkfwumdata.o generated/lib/crc32.o
 HOSTLDLIBS_mkfwumdata += -luuid
diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index 6a261ff549dc..54fb4dee3ee5 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -14,14 +14,15 @@
 #include <linux/types.h>
 
 #include <sys/stat.h>
 #include <sys/types.h>
-#include <uuid/uuid.h>
 
 #include <gnutls/gnutls.h>
 #include <gnutls/pkcs7.h>
 #include <gnutls/abstract.h>
 
+#include <u-boot/uuid.h>
+
 #include "eficapsule.h"
 
 static const char *tool_name = "mkeficapsule";
 
@@ -573,39 +574,8 @@ err:
 
 	return ret;
 }
 
-/**
- * convert_uuid_to_guid() - convert UUID to GUID
- * @buf:	UUID binary
- *
- * UUID and GUID have the same data structure, but their binary
- * formats are different due to the endianness. See lib/uuid.c.
- * Since uuid_parse() can handle only UUID, this function must
- * be called to get correct data for GUID when parsing a string.
- *
- * The correct data will be returned in @buf.
- */
-void convert_uuid_to_guid(unsigned char *buf)
-{
-	unsigned char c;
-
-	c = buf[0];
-	buf[0] = buf[3];
-	buf[3] = c;
-	c = buf[1];
-	buf[1] = buf[2];
-	buf[2] = c;
-
-	c = buf[4];
-	buf[4] = buf[5];
-	buf[5] = c;
-
-	c = buf[6];
-	buf[6] = buf[7];
-	buf[7] = c;
-}
-
 static int create_empty_capsule(char *path, efi_guid_t *guid, bool fw_accept)
 {
 	struct efi_capsule_header header = { 0 };
 	FILE *f = NULL;
@@ -649,22 +619,12 @@ err:
 }
 
 static void print_guid(void *ptr)
 {
-	int i;
-	efi_guid_t *guid = ptr;
-	const uint8_t seq[] = {
-		3, 2, 1, 0, '-', 5, 4, '-', 7, 6,
-		'-', 8, 9, '-', 10, 11, 12, 13, 14, 15 };
+	static char buf[37] = { 0 };
 
-	for (i = 0; i < ARRAY_SIZE(seq); i++) {
-		if (seq[i] == '-')
-			putchar(seq[i]);
-		else
-			printf("%02X", guid->b[seq[i]]);
-	}
-
-	printf("\n");
+	uuid_bin_to_str(ptr, buf, UUID_STR_FORMAT_GUID|UUID_STR_UPPER_CASE);
+	printf("%s\n", buf);
 }
 
 static uint32_t dump_fmp_payload_header(
 	struct fmp_payload_header *fmp_payload_hdr)
@@ -902,13 +862,12 @@ int main(int argc, char **argv)
 				fprintf(stderr,
 					"Image type already specified\n");
 				exit(EXIT_FAILURE);
 			}
-			if (uuid_parse(optarg, uuid_buf)) {
+			if (uuid_str_to_bin(optarg, uuid_buf, UUID_STR_FORMAT_GUID)) {
 				fprintf(stderr, "Wrong guid format\n");
 				exit(EXIT_FAILURE);
 			}
-			convert_uuid_to_guid(uuid_buf);
 			guid = (efi_guid_t *)uuid_buf;
 			break;
 		case 'i':
 			index = strtoul(optarg, NULL, 0);

-- 
2.45.2


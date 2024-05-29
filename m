Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E829C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 14:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A8588864F;
	Wed, 29 May 2024 16:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yKohH2U0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 634FB8864A; Wed, 29 May 2024 16:49:09 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AA1B88615
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 16:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52b78c65cadso573338e87.0
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 07:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716994146; x=1717598946; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jT+QFXiAPflgYbqk5QzqNQ+b1J4NncefbGAThlZmb7Q=;
 b=yKohH2U0vDgkvoa8EFahYwUxCb/cP1P+a0ecf38cEr+BSH7CIPVSuyQX0Vg0Gyl8uT
 7V8xooPiYvyLITfKnOHE7+6XmEuCiVjwy1/caFkpkAVNkItf5CGdBlmNfe4ljH2entm1
 BnRquBSVWzYpcn9RyJcRvRpeLoS0x1QyIxdhba/WMvo4u0+pHMfMjK/UDY2Ljgfw4IGl
 712mzoXFZMCEtMZlNmRzNG+SLq0PaBclcbVl5pwzC4zAcbGpWX0BCL0kt24SMSeAVCfk
 23xb6TKp2/Kn+lpALnFIXWmMDTWITABa7J08QJkWwJ9L3WiT192JQSbMlTKCSFL3mAzp
 yUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716994146; x=1717598946;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jT+QFXiAPflgYbqk5QzqNQ+b1J4NncefbGAThlZmb7Q=;
 b=i0ZQHsTYfa/6a2lN6Jn7IWb8vAyu80JjMRjc/4Od1mxcTyCSxsbCSG50k4bvGJP5sK
 E23ekV2S3Kgu+g2cfQGhoY2bpZKvZaFme2DKIJNtcsbzArGl90od1guGtBkPcr+bLljh
 QKkN2ih/L1MvbN+c7aKSk7CcrD/G3OPU0vVbkrnn+0M9MMxZzAEIi36bmiTm5FeLpAwg
 w6r0ETh/++qpLhUtd19IDVnb55XEjje5BHN0jAyi39UKW42NB/x/5PBS7zVsU+QGgwyI
 C+qc4oAmq8nrbCwfwPgifnPwJ0ikimMvMhmgZykAkA9GkEAihApug4cGqelkVMNkrqxz
 lCfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoMSZNMO8k/pPzYVbDN20SEwKFCdFfKIy6LzNSNYwsIp/NbySMGGw9XE3VC/4pykz4xDm6sR+4eoi7oORIV4pyp6IydQ==
X-Gm-Message-State: AOJu0YxbA72S3D2kiC2WOHXKZmEWWqiRgvzCFSvXEMPNC4JggtCiwgOh
 R0BrMQEQbvyLt46GeF5NJk/JRpvtYZS6H8F7JJs3D5754LU3shS4pd4ioDonbiE=
X-Google-Smtp-Source: AGHT+IGEwGPdjVvHQVNV529KSFwri9ywnl1a5ambhlw7zNc1es+kbBvB3HxJ6Lb26em8lQbqDxsJUA==
X-Received: by 2002:a05:6512:110a:b0:529:a6f6:1b03 with SMTP id
 2adb3069b0e04-529a6f61b4dmr12311826e87.14.1716994146530; 
 Wed, 29 May 2024 07:49:06 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578638009b1sm6922029a12.17.2024.05.29.07.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 07:49:06 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 29 May 2024 16:48:55 +0200
Subject: [PATCH v2 6/7] tools: add genguid tool
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-b4-dynamic-uuid-v2-6-c26f31057bbe@linaro.org>
References: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
In-Reply-To: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5650;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=SeMzuQyQPTJuNY/VxRIKXgLIczQuxO4g2VA6NP7Bjj0=;
 b=kA0DAAgBBYMxKxlfZLYByyZiAGZXQFrIzfNFcSKldRAIpTECd3r9/8MAa08bETG7XfGfDLTIf
 4kCMwQAAQgAHRYhBLZRoUY8ar7QaQxVzQWDMSsZX2S2BQJmV0BaAAoJEAWDMSsZX2S2fG4P/AuQ
 OrfYfKn05YErIMPMkyMlwajzV7QE3WZUL3yPf5u+4HORS5Vu4tlYeUW/84zcI7q22YJKC84o6Sr
 HwFDEC3tZzlyyLqaFO/9SOckhIr9nZj0eS3vdAH4xYHaRTneiuzvgtRkYjzArtkhP2AP0rnkpgM
 XLm8El1CD4otCxi1GbfITT6aqJHda0c98Y5Rb0WZSri39JRIXiBQrBQj1yLnBGLEycmckt4wv8C
 5coG61VqfQS49uK5K/7ITrAhy9VN1NrSScjyR13hDxskJRTRjUP/t7IFad12w+bSYpE69wCvnRf
 eU3SEhabu0C4vLd5mfdSOUvb55EUa7Cyztt6FcLPK6Ep6JsEnrUI5X3hX77trOvc+hcYf/7IbRQ
 OZMmBv0zaEoH/bS86CEVULc1FoC04OD7ZFdc80+c60kBXgwAq+LDo/4RQHtcjSh22DtpNEg2ike
 7XbZ8GgXAs71vWLPBZYCTTw/cSyLFwW/faN48x16FK4ltQ6KKFBMNwp6yWnSIZcmuUDG1AlMRh1
 yR3oBtUmnPx96hZWr4nOi++fUdb7mIvG+wtzr7YNct6ErHR5df7pT5/6ZMib2EUbS22hrIjsdIb
 BHsi6Yn9yB3UpP3/GoNPBHn4fBrWEQxAYUVceEhYD20JtcocHvSBCNtgrRUOqgmKP2TCi9jflZp
 weY0s
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

Add a tool that can generate GUIDs that match those generated internally
by U-Boot for capsule update fw_images.

Dynamic UUIDs in U-Boot work by taking a namespace UUID and hashing it
with the board model, compatible, and fw_image name.

This tool accepts the same inputs and will produce the same GUID as
U-Boot would at runtime.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 tools/Makefile  |   3 ++
 tools/genguid.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 157 insertions(+)

diff --git a/tools/Makefile b/tools/Makefile
index 6a4280e3668f..7db7723793d5 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -253,8 +253,11 @@ HOSTLDLIBS_mkeficapsule += \
 HOSTLDLIBS_mkeficapsule += \
 	$(shell pkg-config --libs uuid 2> /dev/null || echo "-luuid")
 hostprogs-$(CONFIG_TOOLS_MKEFICAPSULE) += mkeficapsule
 
+genguid-objs := generated/lib/uuid.o generated/lib/sha1.o genguid.o
+hostprogs-$(CONFIG_TOOLS_MKEFICAPSULE) += genguid
+
 mkfwumdata-objs := mkfwumdata.o generated/lib/crc32.o
 HOSTLDLIBS_mkfwumdata += -luuid
 hostprogs-$(CONFIG_TOOLS_MKFWUMDATA) += mkfwumdata
 
diff --git a/tools/genguid.c b/tools/genguid.c
new file mode 100644
index 000000000000..dbac65d42623
--- /dev/null
+++ b/tools/genguid.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2024 Linaro Ltd.
+ *   Author: Caleb Connolly
+ */
+
+#include <getopt.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <linux/types.h>
+
+#include <uuid.h>
+
+static struct option options[] = {
+	{"dtb", required_argument, NULL, 'd'},
+	{"compat", required_argument, NULL, 'c'},
+	{"help", no_argument, NULL, 'h'},
+	{"verbose", no_argument, NULL, 'v'},
+	{"json", no_argument, NULL, 'j'},
+	{NULL, 0, NULL, 0},
+};
+
+static void usage(const char *progname)
+{
+	fprintf(stderr, "Usage: %s GUID [-v] -c COMPAT NAME...\n", progname);
+	fprintf(stderr,
+		"Generate a v5 GUID for one of more U-Boot fw_images the same way U-Boot does at runtime.\n");
+	fprintf(stderr,
+		"\nOptions:\n"
+		"  GUID                     namespace/salt GUID in 8-4-4-4-12 format\n"
+		"  -h, --help               display this help and exit\n"
+		"  -c, --compat=COMPAT      first compatible property in the board devicetree\n"
+		"  -v, --verbose            print debug messages\n"
+		"  -j, --json               output in JSON format\n"
+		"  NAME...                  one or more names of fw_images to generate GUIDs for\n"
+	);
+	fprintf(stderr, "\nExample:\n");
+	fprintf(stderr, "  %s 2a5aa852-b856-4d97-baa9-5c5f4421551f \\\n"
+			"\t-c \"qcom,qrb4210-rb2\" \\\n"
+			"\tQUALCOMM-UBOOT\n", progname);
+}
+
+size_t u16_strsize(const uint16_t *in)
+{
+	size_t i = 0, count = UINT16_MAX;
+
+	while (count-- && in[i])
+		i++;
+
+	return (i + 1) * sizeof(uint16_t);
+}
+
+int main(int argc, char **argv)
+{
+	struct uuid namespace;
+	char *namespace_str;
+	char uuid_str[37];
+	char **image_uuids;
+	char *compatible = NULL;
+	uint16_t **images_u16;
+	char **images;
+	int c, n_images;
+	bool debug = false, json = false;
+
+	if (argc < 2) {
+		usage(argv[0]);
+		return 1;
+	}
+
+	namespace_str = argv[1];
+
+	/* The first arg is the GUID so skip it */
+	while ((c = getopt_long(argc, argv, "c:hvj", options, NULL)) != -1) {
+		switch (c) {
+		case 'c':
+			compatible = strdup(optarg);
+			break;
+		case 'h':
+			usage(argv[0]);
+			return 0;
+		case 'v':
+			debug = true;
+			break;
+		case 'j':
+			json = true;
+			break;
+		default:
+			usage(argv[0]);
+			return 1;
+		}
+	}
+
+	if (!compatible) {
+		fprintf(stderr, "ERROR: Please specify the compatible property.\n\n");
+		usage(argv[0]);
+		return 1;
+	}
+
+	if (uuid_str_to_bin(namespace_str, (unsigned char *)&namespace, UUID_STR_FORMAT_GUID)) {
+		fprintf(stderr, "ERROR: Check that your UUID is formatted correctly.\n");
+		exit(EXIT_FAILURE);
+	}
+
+	/* This is probably not the best way to convert a string to a "u16" string */
+	n_images = argc - optind - 1;
+	images = argv + optind + 1;
+	images_u16 = calloc(n_images, sizeof(char *));
+	for (int i = 0; i < n_images; i++) {
+		images_u16[i] = calloc(1, strlen(images[i]) * 2 + 2);
+		for (int j = 0; j < strlen(images[i]); j++)
+			images_u16[i][j] = (uint16_t)images[i][j];
+	}
+
+	if (debug) {
+		fprintf(stderr, "GUID:         ");
+		uuid_bin_to_str((uint8_t *)&namespace, uuid_str, UUID_STR_FORMAT_GUID);
+		fprintf(stderr, "%s\n", uuid_str);
+		fprintf(stderr, "Compatible:  \"%s\"\n", compatible);
+		fprintf(stderr, "Images:      ");
+		for (int i = 0; i < n_images; i++)
+			fprintf(stderr, "\"%s\"%s", argv[optind + i + 1],
+				i == n_images - 1 ? "\n" : ", ");
+	}
+
+	image_uuids = calloc(n_images, sizeof(char *));
+	for (int i = 0; i < n_images; i++) {
+		struct uuid image_type_id;
+
+		gen_uuid_v5(&namespace, &image_type_id,
+			    compatible, strlen(compatible),
+			    images_u16[i], u16_strsize(images_u16[i]) - sizeof(uint16_t),
+			    NULL);
+
+		uuid_bin_to_str((uint8_t *)&image_type_id, uuid_str, UUID_STR_FORMAT_GUID);
+		image_uuids[i] = strdup(uuid_str);
+	}
+
+	if (json) {
+		printf("[\n");
+		for (int i = 0; i < n_images; i++)
+			printf("\t{\"name\": \"%s\", \"uuid\": \"%s\"}%s\n", images[i], image_uuids[i],
+			       i == n_images - 1 ? "" : ",");
+		printf("]\n");
+	} else {
+		for (int i = 0; i < n_images; i++)
+			printf("%-24s| %s\n", images[i], image_uuids[i]);
+	}
+
+	return 0;
+}
+

-- 
2.45.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1D8CA0EE4
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 12:36:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39B3888BFB;
	Fri, 30 Aug 2024 14:34:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MvRF8DZm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EC0E88C4C; Fri, 30 Aug 2024 14:34:47 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DBCA88C4C
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 14:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42bbd16fca8so4146935e9.0
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 05:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725021285; x=1725626085; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ev/6wfhw/Pybgv0hjqelWSIXspb7A0iHWxmEAj9+hYc=;
 b=MvRF8DZmyixjpIsnVvZag58n/1ru5Z69Ft+nShlWNpctKWoEOzkBvgiC/g6uLZQspq
 9wQh+xhuZd3Tg1I02ljcxjvRBJjgEKIh+vQ+s0Jc3O5AQOe12nTFeD+qagl1kT+Iw93R
 c5cGOrugcYQXCs7cKMZAW1L3xO6lP/pXQAOnXhQYwQR8o6eM/UMo1P4pN3VExYrRQFth
 SrWAH8Sd3m4xuWtDBUGrDM15084zuOI5blEytdAQXOZUKpBo1C6ZZxJE70+BFkzzrGuZ
 BeKP/2m/sNzZwF8yljJ43N/I7oPONd0pRdwozcPUlMsRwhKeKT5En3rZg3Cp+OM3YkOC
 8s+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725021285; x=1725626085;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ev/6wfhw/Pybgv0hjqelWSIXspb7A0iHWxmEAj9+hYc=;
 b=Dcfg0SYSlbX4ZAonCJOZ7qYFUXrQWM9h5HN+eWEfl9q8j2HsCu2Ac2+MlPGDVbcrMz
 u+Os9SHT/vIJIqgvzSuhY7gqL7XJI+HpW7PEoCKpL6ymXZI2PzjCBR/8dJlILzGHYU0/
 AJtHXhEGzJVEpSmOgx6rc8gElqfiXslJ77jmQjK6lFeEpi99W4DHvJ2BPRhJ3eWTsHw9
 mhvIUx8X/8x3164aKYk0s/cqbvTjYuMNBzbsmJ2LGsYX/AOkQk8Ejbi5hTbBhffG/baN
 g6KzOLYiSEP+y5eIfnzSdLT0PrbNhV9hyGTIttmICx48sS9JMy/w+jATmJZ6C7Na711r
 MrNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi7BfbJVTjyrcYYQmBAUBsKk26MvVa4kK30OZPj5Ve0GBleye/7RJLJXgNWXk7vqkrjY4KkqI=@lists.denx.de
X-Gm-Message-State: AOJu0YxZHPOP75CYI/xEr1nXf4i2ydCyOyOobb0IVoycnNabLUmTtRif
 dO9SiXlSlWEP50I+Q23nT7RA+RXei5oYQ+/lgYWPGPpeaDoWwPbfd1xHmAv1FLk=
X-Google-Smtp-Source: AGHT+IHtEKqZFiuBRK+kvF8kNLe7K+6UwCIz248YTdJieM4SRxHWKCT0sFpSSk6uhSps/pf8oObnKw==
X-Received: by 2002:a05:600c:1c83:b0:42b:a9b4:3f59 with SMTP id
 5b1f17b1804b1-42bb0293da3mr41309635e9.14.1725021284631; 
 Fri, 30 Aug 2024 05:34:44 -0700 (PDT)
Received: from [192.168.1.17] (host-80-47-105-51.as13285.net. [80.47.105.51])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b960ef94sm648207f8f.103.2024.08.30.05.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 05:34:44 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 30 Aug 2024 13:34:39 +0100
Subject: [PATCH v8 09/11] tools: mkeficapsule: support generating dynamic GUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-b4-dynamic-uuid-v8-9-79b31b199bee@linaro.org>
References: <20240830-b4-dynamic-uuid-v8-0-79b31b199bee@linaro.org>
In-Reply-To: <20240830-b4-dynamic-uuid-v8-0-79b31b199bee@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8380;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=J5ba0Lf0VOIvi4e4WDju/mENF1r21gmz7iDbfAGA9Ro=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBm0bxamiSHnMH+yYidM2y9D/ij2B8Q8R0hcuOkn
 DJES4ld4vuJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZtG8WgAKCRAFgzErGV9k
 toomD/9im/7U5rMLIwDUm0/ror/t4YN8ct0aSviO186U9xZvp/m7QgIfSijdGpQKN5ZUk7qJ6VA
 IUcBFcp8udpSDb/jxeUcG9xgvody0mlY7rHf6CZnmUgFnUsRdjj3veFPuN+kBmTkZWDw6IG2lmM
 p7o+Ehfvw9ESvUWVpRrjM9HbOVqzH07qnI89Rtyyo/tOOBMA6j/KElEWAnBdkm2jhhlTVQzb0lv
 5CIa9muG0ngAdN6gd9TRuIhe7IBKjOC7+9p85PTkULh8+A54ijEk8zqGgKGGU+Sl1popf5K6U4k
 y6xvvMzYo0ers/CdcbwHCKs09ek118uHAeItAs38avOR65RWfr9fy7De+QbBhopA3eP6cvcsEYP
 Zzl7NYdkl7cr4YM+eyA9dZfvodLEsrAqUltIWRFYswQVh7yDJbevSX/8AqMSHHtM0WY44sVlWmX
 CAHsGfJkBS7LQ7bn/0UYQNTTTEXpUi2EC3/b3PCPR1qCa+QwoJ46+OKC9AHOs93earzIXp/J9Qv
 tIA4jFhk8UvsbORoVg8/tL5Q2mRio4rI8BztRy1L2/S1CvCGev6i/vowvfm/zBdkeYf56BNenn4
 amuv3iSOAAnqcrJEFx5AIH6V49dd0Vt5yIZHPasgFs/WWjZxAIDfwRvtIpHzODTFyu5NK8M1Q7y
 N0Bge/mJ50XT3Nw==
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

Add support for generating GUIDs that match those generated internally
by U-Boot for capsule update fw_images when using dynamic UUIDs.

Dynamic UUIDs in U-Boot work by taking a namespace UUID and hashing it
with the board compatible and fw_image name. This feature just provides
a way to determine the UUIDs for a particular board without having to
actually boot U-Boot on it.

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 doc/mkeficapsule.1   |  23 ++++++++
 tools/mkeficapsule.c | 156 +++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 174 insertions(+), 5 deletions(-)

diff --git a/doc/mkeficapsule.1 b/doc/mkeficapsule.1
index c3d0f21488ad..a5545f7898a8 100644
--- a/doc/mkeficapsule.1
+++ b/doc/mkeficapsule.1
@@ -9,8 +9,11 @@ mkeficapsule \- Generate EFI capsule file for U-Boot
 .SH SYNOPSIS
 .B mkeficapsule
 .RI [ options ] " " [ image-blob ] " " capsule-file
 
+.B mkeficapsule
+.RI guidgen " " [ GUID ] " " DTB " " IMAGE_NAME...
+
 .SH "DESCRIPTION"
 The
 .B mkeficapsule
 command is used to create an EFI capsule file to be used by U-Boot for firmware
@@ -41,8 +44,12 @@ format is the same as used in the new uImage format and allows for
 multiple binary blobs in a single capsule file.
 This type of image file can be generated by
 .BR mkimage .
 
+mkeficapsule can also be used to simulate the dynamic GUID generation used to
+identify firmware images in capsule updates by providing the namespace guid, dtb
+for the board, and a list of firmware images.
+
 .SH "OPTIONS"
 
 .TP
 .BI "-g\fR,\fB --guid " guid-string
@@ -116,8 +123,24 @@ at every firmware update.
 .TP
 .B "-d\fR,\fB --dump_sig"
 Dump signature data into *.p7 file
 
+.SH "GUIDGEN OPTIONS"
+
+.TP
+.B "[GUID]"
+The namespace/salt GUID, by default this is EFI_CAPSULE_NAMESPACE_GUID.
+The format is:
+    xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
+
+.TP
+.B DTB
+The device tree blob file for the board.
+
+.TP
+.B IMAGE_NAME...
+The names of the firmware images to generate GUIDs for.
+
 .PP
 .SH FILES
 .TP
 .I /EFI/UpdateCapsule
diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index 68c97cfb9db4..7068c936c530 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -20,12 +20,16 @@
 #include <gnutls/pkcs7.h>
 #include <gnutls/abstract.h>
 
 #include <version.h>
+#include <libfdt.h>
 #include <u-boot/uuid.h>
 
 #include "eficapsule.h"
 
+// Matches CONFIG_EFI_CAPSULE_NAMESPACE_GUID
+#define DEFAULT_NAMESPACE_GUID "8c9f137e-91dc-427b-b2d6-b420faebaf2a"
+
 static const char *tool_name = "mkeficapsule";
 
 efi_guid_t efi_guid_fm_capsule = EFI_FIRMWARE_MANAGEMENT_CAPSULE_ID_GUID;
 efi_guid_t efi_guid_cert_type_pkcs7 = EFI_CERT_TYPE_PKCS7_GUID;
@@ -54,11 +58,22 @@ static struct option options[] = {
 	{"help", no_argument, NULL, 'h'},
 	{NULL, 0, NULL, 0},
 };
 
-static void print_usage(void)
+static void print_usage_guidgen(void)
 {
-	fprintf(stderr, "Usage: %s [options] <image blob> <output file>\n"
+	fprintf(stderr, "%s guidgen [GUID] DTB IMAGE_NAME...\n"
+		"Options:\n"
+
+		"\tGUID                        Namespace GUID (default: %s)\n"
+		"\tDTB                         Device Tree Blob\n"
+		"\tIMAGE_NAME...               One or more names of fw_images to generate GUIDs for\n",
+		tool_name, DEFAULT_NAMESPACE_GUID);
+}
+
+static void print_usage_mkeficapsule(void)
+{
+	fprintf(stderr, "Usage:\n\n%s [options] <image blob> <output file>\n"
 		"Options:\n"
 
 		"\t-g, --guid <guid string>    guid for image blob type\n"
 		"\t-i, --index <index>         update image index\n"
@@ -72,10 +87,11 @@ static void print_usage(void)
 		"\t-R, --fw-revert  firmware revert capsule, takes no GUID, no image blob\n"
 		"\t-o, --capoemflag Capsule OEM Flag, an integer between 0x0000 and 0xffff\n"
 		"\t-D, --dump-capsule          dump the contents of the capsule headers\n"
 		"\t-V, --version               show version number\n"
-		"\t-h, --help                  print a help message\n",
+		"\t-h, --help                  print a help message\n\n",
 		tool_name);
+	print_usage_guidgen();
 }
 
 /**
  * auth_context - authentication context
@@ -818,8 +834,131 @@ static void dump_capsule_contents(char *capsule_file)
 		exit(EXIT_FAILURE);
 	}
 }
 
+static struct fdt_header *load_dtb(const char *path)
+{
+	struct fdt_header *dtb;
+	ssize_t dtb_size;
+	FILE *f;
+
+	/* Open and parse DTB */
+	f = fopen(path, "r");
+	if (!f) {
+		fprintf(stderr, "Cannot open %s\n", path);
+		return NULL;
+	}
+
+	if (fseek(f, 0, SEEK_END)) {
+		fprintf(stderr, "Cannot seek to the end of %s: %s\n",
+			path, strerror(errno));
+		return NULL;
+	}
+
+	dtb_size = ftell(f);
+	if (dtb_size < 0) {
+		fprintf(stderr, "Cannot ftell %s: %s\n",
+			path, strerror(errno));
+		return NULL;
+	}
+
+	fseek(f, 0, SEEK_SET);
+
+	dtb = malloc(dtb_size);
+	if (!dtb) {
+		fprintf(stderr, "Can't allocated %ld\n", dtb_size);
+		return NULL;
+	}
+
+	if (fread(dtb, dtb_size, 1, f) != 1) {
+		fprintf(stderr, "Can't read %ld bytes from %s\n",
+			dtb_size, path);
+		free(dtb);
+		return NULL;
+	}
+
+	fclose(f);
+
+	return dtb;
+}
+
+#define MAX_IMAGE_NAME_LEN 128
+static int genguid(int argc, char **argv)
+{
+	int idx = 2, ret;
+	unsigned char namespace[16];
+	struct efi_guid image_type_id;
+	const char *dtb_path;
+	struct fdt_header *dtb;
+	const char *compatible;
+	int compatlen, namelen;
+	uint16_t fw_image[MAX_IMAGE_NAME_LEN];
+
+	if (argc < 2) {
+		fprintf(stderr, "Usage: ");
+		print_usage_guidgen();
+		return -1;
+	}
+
+	if (uuid_str_to_bin(argv[1], namespace, UUID_STR_FORMAT_GUID)) {
+		uuid_str_to_bin(DEFAULT_NAMESPACE_GUID, namespace, UUID_STR_FORMAT_GUID);
+		dtb_path = argv[1];
+	} else {
+		dtb_path = argv[2];
+		idx = 3;
+	}
+
+	if (idx == argc) {
+		fprintf(stderr, "Usage: ");
+		print_usage_guidgen();
+		return -1;
+	}
+
+	dtb = load_dtb(dtb_path);
+	if (!dtb)
+		return -1;
+
+	ret = fdt_check_header(dtb);
+	if (ret) {
+		fprintf(stderr, "Invalid DTB header: %d\n", ret);
+		return -1;
+	}
+
+	compatible = fdt_getprop(dtb, 0, "compatible", &compatlen);
+	if (!compatible) {
+		fprintf(stderr, "No compatible string found in DTB\n");
+		return -1;
+	}
+	if (strnlen(compatible, compatlen) >= compatlen) {
+		fprintf(stderr, "Compatible string not null-terminated\n");
+		return -1;
+	}
+
+	printf("Generating GUIDs for %s with namespace %s:\n",
+	       compatible, DEFAULT_NAMESPACE_GUID);
+	for (; idx < argc; idx++) {
+		memset(fw_image, 0, sizeof(fw_image));
+		namelen = strlen(argv[idx]);
+		if (namelen > MAX_IMAGE_NAME_LEN) {
+			fprintf(stderr, "Image name too long: %s\n", argv[idx]);
+			return -1;
+		}
+
+		for (int i = 0; i < namelen; i++)
+			fw_image[i] = (uint16_t)argv[idx][i];
+
+		gen_v5_guid((struct uuid *)&namespace, &image_type_id,
+			    compatible, strlen(compatible),
+			    fw_image, namelen * sizeof(uint16_t),
+			    NULL);
+
+		printf("%s: ", argv[idx]);
+		print_guid(&image_type_id);
+	}
+
+	return 0;
+}
+
 /**
  * main - main entry function of mkeficapsule
  * @argc:	Number of arguments
  * @argv:	Array of pointers to arguments
@@ -842,8 +981,15 @@ int main(int argc, char **argv)
 	char *privkey_file, *cert_file;
 	int c, idx;
 	struct fmp_payload_header_params fmp_ph_params = { 0 };
 
+	/* Generate dynamic GUIDs */
+	if (argc > 1 && !strcmp(argv[1], "guidgen")) {
+		if (genguid(argc - 1, argv + 1))
+			exit(EXIT_FAILURE);
+		exit(EXIT_SUCCESS);
+	}
+
 	guid = NULL;
 	index = 0;
 	instance = 0;
 	mcount = 0;
@@ -933,9 +1079,9 @@ int main(int argc, char **argv)
 		case 'V':
 			printf("mkeficapsule version %s\n", PLAIN_VERSION);
 			exit(EXIT_SUCCESS);
 		default:
-			print_usage();
+			print_usage_mkeficapsule();
 			exit(EXIT_FAILURE);
 		}
 	}
 
@@ -956,9 +1102,9 @@ int main(int argc, char **argv)
 	    (capsule_type != CAPSULE_NORMAL_BLOB &&
 	    ((argc != optind + 1) ||
 	     ((capsule_type == CAPSULE_ACCEPT) && !guid) ||
 	     ((capsule_type == CAPSULE_REVERT) && guid)))) {
-		print_usage();
+		print_usage_mkeficapsule();
 		exit(EXIT_FAILURE);
 	}
 
 	if (capsule_type != CAPSULE_NORMAL_BLOB) {

-- 
2.46.0


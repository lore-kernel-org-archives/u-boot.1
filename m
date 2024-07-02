Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5C6C30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 13:32:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26A4F8871B;
	Tue,  2 Jul 2024 15:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fUKEN9Vh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41CE188754; Tue,  2 Jul 2024 15:30:59 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F71D8858B
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 15:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso436783966b.0
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 06:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719927056; x=1720531856; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YV2NcFeEzAsvTLEphuDLuL3Tf5clYpOsZQGdEfQjYwA=;
 b=fUKEN9VhXLaYAnzzPqh3o4Yq2N72gCKtzI2brIEWHlv3FzorBHqe6iwJ24tqEHuhjY
 jrqQu9uSvQeDhbA7OYIH+QufsdkMQ0dHcPtrZPA7MVRWTVgVGJn8PlfZQ30FxxgIsWmJ
 hcKRH+GQeCzgeDxAzxlSV/9pgliYgs1zmuLYqcwsD9y/N3h2juZgmBHcO/naFBYASWn8
 nu0rE/CylKC/H8IdGzfQfcu71y55V8imqBx5ZfxgDojBME+SRm9LXIcxaD1a+MjjVBYK
 9pyrhs94kAbbmG2ItVq+OMLX0PlOg6g494zsEK0zKUpdY7OsDFvDG1tgP1xG6fiyw3zn
 2/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719927056; x=1720531856;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YV2NcFeEzAsvTLEphuDLuL3Tf5clYpOsZQGdEfQjYwA=;
 b=MPiAqwCdPg6Ek6fJ4NvskmPO5r4jII2wsfbvoPxMciI1xQSJ+LMRwUkMbtolWRNecO
 Q+5i7Xik1Xa605OcwjpbefNza5jOtVQ4iqDtF0gdEwpgfVHULRgk+A1FBIUsSWH7pvvJ
 F82gsl6e4R5CmTfIGs50bxTiZbHi5r/aYV+H3I+o6mOobAepn7Y/UeKK+w+BXE4h7MDu
 bxTC+KafHjH7Dko8arQuzoANeYtLXyorJMIRBlF6qPCtFP3foHTSgAQJ7VV6ANCxIK0V
 128frkiiBteQU1BSFzc7Xo8Wo/gqLu7wPMNHyikDgV2LVnHYhHGGCc54/hvGu2AAlUKQ
 b/nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUitqpUDj4RvVmYCGkwkqnlvBiGYqm9K2l8a6Enkz2pjnrHaCRwlLQztKds2ccdR0DmvjR2RWJFRcShgp1Gl5T+M3l9mA==
X-Gm-Message-State: AOJu0YwXiFxhQPqoOP85YAbtAGXpSsHu0fIA6Ps7yKf1kshWA4c5QBB2
 ncopChQt/raqM82ZJvrc276w6fhfmuEobmLUfkWDvav+IrUp5NJJoHx333QYa1CziIAjApfM1AE
 A
X-Google-Smtp-Source: AGHT+IFFZE9JatapO0QYf5RxmyQoJq5o51blT+wfIoocMMUJPylvzTdBhtrtIl27kTHgLOrCyy+fMQ==
X-Received: by 2002:a17:906:4ace:b0:a72:8597:39b3 with SMTP id
 a640c23a62f3a-a751440ddaamr425093866b.18.1719927055491; 
 Tue, 02 Jul 2024 06:30:55 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7430367d55sm323796166b.87.2024.07.02.06.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 06:30:54 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 02 Jul 2024 15:30:49 +0200
Subject: [PATCH v4 09/10] tools: mkeficapsule: support generating dynamic GUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-b4-dynamic-uuid-v4-9-a00c82d1f504@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9203;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=gWVLxgIabVWBwmAZZUHjaH19Cdy5AihUq2j6AQC2WYE=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmhAEDN6E+KUZm4a9CShIMVxg5dnNJA8uWKCeB4
 h8HokQ3y9mJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZoQBAwAKCRAFgzErGV9k
 tjNAD/9Sfby3Cw+NUDI37PK+6iegKzp+c7Nl0CjQXy/VxkGcrHpU4+eLJXHwGu670whZfPLquv0
 1FhTJyczmXdyGGzfCImh3LOyEGNGNwKNZxqFNmwWrUPw6lMkR4kNAAkq2upW4weLhd7m7z2wIBx
 F6IWSSwCgXkE0RYnY1Anm/9Q7sxXZwb3brT2OMgpoFxYl7g03xC7OWBG6Xq3MBjH4v6ADas/u3C
 xXANCqqklKkY3sxa3TZsehaVK0gzbhuuawGWiJcCs5zOghfaru7knj+kWkelBn4P3WZ/k/kMOPK
 nkYXTBKSAddJSwZ93rrjf8WqGo+HdoJxpBb6lfnjRyCgdzXcVUA6I/Cv52XJyEE9Kot3eCutORw
 jMsJzUQKMh0rtrwZiu0RQcFEY8MqXwABExBJhEdjsRGqX/h8+f0reqB783Wb8x/gdP9rY50XI5S
 N85Gw7aF7hti+i1eTus6KP0NJN6czH6P1J/6z2qLWMkVVLZItbfXFZhu9AAqBlV/XugabRvwwkc
 2BYVOrJesPYeKQjNRMcMA3W4sppF0605uJIRV42lql0Az5xcb8luLwRNpHrZo/B1mhFfVgiQkUu
 6Jfm+4F4SjBkXqROBaB1ZC4aUsDRttl/xduo6ksrb9GF5kvYxJVIMOx9l2cgl2d/uvCx2ACL2LL
 k/yLFai/9idxnjA==
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
with the board compatible and fw_image name.

This tool accepts the same inputs and will produce the same GUID as
U-Boot would at runtime.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 doc/mkeficapsule.1   |  23 ++++++++
 tools/Makefile       |   3 +
 tools/mkeficapsule.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 178 insertions(+), 5 deletions(-)

diff --git a/doc/mkeficapsule.1 b/doc/mkeficapsule.1
index c4c2057d5c7a..bf735295effa 100644
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
@@ -112,8 +119,24 @@ at every firmware update.
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
diff --git a/tools/Makefile b/tools/Makefile
index ee08a9675df8..7d1b29943471 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -253,8 +253,11 @@ mkeficapsule-objs := generated/lib/uuid.o \
 	$(LIBFDT_OBJS) \
 	mkeficapsule.o
 hostprogs-$(CONFIG_TOOLS_MKEFICAPSULE) += mkeficapsule
 
+genguid-objs := generated/lib/uuid.o generated/lib/sha1.o genguid.o
+hostprogs-$(CONFIG_TOOLS_GENGUID) += genguid
+
 mkfwumdata-objs := mkfwumdata.o generated/lib/crc32.o
 HOSTLDLIBS_mkfwumdata += -luuid
 hostprogs-$(CONFIG_TOOLS_MKFWUMDATA) += mkfwumdata
 
diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index 54fb4dee3ee5..593380e4236a 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -19,12 +19,16 @@
 #include <gnutls/gnutls.h>
 #include <gnutls/pkcs7.h>
 #include <gnutls/abstract.h>
 
+#include <libfdt.h>
 #include <u-boot/uuid.h>
 
 #include "eficapsule.h"
 
+// Matches CONFIG_EFI_CAPSULE_NAMESPACE_GUID
+#define DEFAULT_NAMESPACE_GUID "8c9f137e-91dc-427b-b2d6-b420faebaf2a"
+
 static const char *tool_name = "mkeficapsule";
 
 efi_guid_t efi_guid_fm_capsule = EFI_FIRMWARE_MANAGEMENT_CAPSULE_ID_GUID;
 efi_guid_t efi_guid_cert_type_pkcs7 = EFI_CERT_TYPE_PKCS7_GUID;
@@ -38,8 +42,9 @@ enum {
 } capsule_type;
 
 static struct option options[] = {
 	{"guid", required_argument, NULL, 'g'},
+	{"dtb", required_argument, NULL, 'd'},
 	{"index", required_argument, NULL, 'i'},
 	{"instance", required_argument, NULL, 'I'},
 	{"fw-version", required_argument, NULL, 'v'},
 	{"private-key", required_argument, NULL, 'p'},
@@ -53,11 +58,23 @@ static struct option options[] = {
 	{"help", no_argument, NULL, 'h'},
 	{NULL, 0, NULL, 0},
 };
 
-static void print_usage(void)
+
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
+	fprintf(stderr, "Usage: \n\n%s [options] <image blob> <output file>\n"
 		"Options:\n"
 
 		"\t-g, --guid <guid string>    guid for image blob type\n"
 		"\t-i, --index <index>         update image index\n"
@@ -70,10 +87,11 @@ static void print_usage(void)
 		"\t-A, --fw-accept  firmware accept capsule, requires GUID, no image blob\n"
 		"\t-R, --fw-revert  firmware revert capsule, takes no GUID, no image blob\n"
 		"\t-o, --capoemflag Capsule OEM Flag, an integer between 0x0000 and 0xffff\n"
 		"\t-D, --dump-capsule          dump the contents of the capsule headers\n"
-		"\t-h, --help                  print a help message\n",
+		"\t-h, --help                  print a help message\n\n",
 		tool_name);
+	print_usage_guidgen();
 }
 
 /**
  * auth_context - authentication context
@@ -816,8 +834,130 @@ static void dump_capsule_contents(char *capsule_file)
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
+	if ((ret = fdt_check_header(dtb))) {
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
@@ -840,8 +980,15 @@ int main(int argc, char **argv)
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
@@ -928,9 +1075,9 @@ int main(int argc, char **argv)
 		case 'D':
 			capsule_dump = true;
 			break;
 		default:
-			print_usage();
+			print_usage_mkeficapsule();
 			exit(EXIT_SUCCESS);
 		}
 	}
 
@@ -951,9 +1098,9 @@ int main(int argc, char **argv)
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
2.45.2


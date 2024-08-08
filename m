Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616F0C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 16:23:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D9AA88C28;
	Thu,  8 Aug 2024 18:22:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TUzn4M6l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BA9D88C11; Thu,  8 Aug 2024 18:22:07 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 130EB88BC6
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 18:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2f035ae1083so11685581fa.3
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 09:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723134124; x=1723738924; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NdgpS2fGbKq3qCEqgboAL3IJ+7tYWgj1dTT5gC8wErI=;
 b=TUzn4M6lsTfbhxbB5Gu+C/oby/HSLc+PeesBYT9JX3i9DFnOdBUR/Vu6iFveTervYS
 G55pVSp4Km5Z8MaHoMqwaZWA4CQXR3ba5i4bpBw8dpY4p8dFqRODqiUGsjEbsKxBwxQV
 XYUN082OEgYQDZHFSE7hxEZ7V+JFb7SZ3UmGsTDi3M378GwEg+2rI1j752rpEOFzad9C
 Al2UvuqJ/W4r1f5uK4ki1WrtMCpCiEs+8GHd/YQfReEq+HC9yYZWgZ/ejWKUXdfLF67O
 dISdMEO8iLzFxsFxxVuzDborTn2hVTMqMViDzdZcs0aSo5LjHfbvcH+Io/ZJARPKct6V
 XKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723134124; x=1723738924;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NdgpS2fGbKq3qCEqgboAL3IJ+7tYWgj1dTT5gC8wErI=;
 b=JCgOpWokTEbMaos/RZjGmU6rOQeYwz8XNlhocjzRZ5aI+PHwJuymtXm+10K+jCLkH0
 OaV/S6Ctlo28ruS7BUr/nlb8GzNim1ejk344JYrTUd9wYm0j+4o6wDLiHe95HJ0smecj
 0KgZCB3oU2zksg8oDnkGf182cqVjeB7wymcNHQwu3+Qu65LicBgEIMvYlPpDjPPVvboB
 B6Xs8+9sSlwMUJyxX3Ma6+sqE8PkI27orMnXw1RzqJ53ohHHL69wDleXZtaAbheOnqfx
 LsK68lmurT+eXL6Rai0P2KhXfVYFyputA+w5BlBWJg3SAb4mI4d0ORuSPX/Tj/GpgQG3
 bSQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgcmJZVrXtRNaUyOXkfueUu/vkZa8im3wTULP59rVKHyjH/gnDxoxd8z2zoX2MTFHMa5+PY1J0S28uL5IjzmsIHp2EMQ==
X-Gm-Message-State: AOJu0YzDPKTC/XF+l9ygmNyK8L4f1nlfoMJ+9uYb2GOKJZUN64KiLHR0
 4lvJcboZmW2C8x5Skq631mrJdQi/wIGw6mfA3xJIgpi+qeqA+c8QFMPkaB8Aw8k=
X-Google-Smtp-Source: AGHT+IFvcLM0TCNAKryHjNFGBwe1TgEI3KaDfkll/RwkP13hHk7yUqlXc0peEuddcAXEtV8DMbtr3g==
X-Received: by 2002:a05:6512:a8c:b0:52c:dbee:bdb0 with SMTP id
 2adb3069b0e04-530e5896f05mr1525548e87.59.1723134124204; 
 Thu, 08 Aug 2024 09:22:04 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bbb2e5c8fbsm812351a12.79.2024.08.08.09.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 09:22:03 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 08 Aug 2024 18:21:56 +0200
Subject: [PATCH v6 09/11] tools: mkeficapsule: support generating dynamic GUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-b4-dynamic-uuid-v6-9-9332e7237119@linaro.org>
References: <20240808-b4-dynamic-uuid-v6-0-9332e7237119@linaro.org>
In-Reply-To: <20240808-b4-dynamic-uuid-v6-0-9332e7237119@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8305;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=1ZmbfsFZL7+YgnLzHPJx2Z7jaIpmmM85jwfL28p3NJ8=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtPCffsECSl2xuyXg3rtZX3YIEVEBsqcZGMisP
 9OAiWgbuzaJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrTwnwAKCRAFgzErGV9k
 tkTsEACA0hPFmZa3IUkOYcQYt3gcWIZGKzLtSub9DHZGzN9FBT98YVRcyyOECbvxOte60hit65l
 sWVYWVwTdmI2sLYade+WOfIYHkIzRBLLKgxWM6ObYhTmJi15eUm7vfurPpjSm8oqCy3aB3cJAE9
 ErsCCDLMMQDa1NK6ygC/oT0mu7kiHk3TSCZT1SG9xR4MEOQ5jan4W+bPmrLexabcDcoDY/+ZedP
 clzwc9QptxzRTBWhRs42reyZy887Hc+3UT7yQPT9VfzJJj/4OtrpUlAlCGCWkqV491xw+oVOaUI
 D0NuzreLzlegZeZyGPk17261ObFA/5ddMp3t5HzsLzFKpeiEl4yV4be2Gt11P3l92OnVTNKE8yw
 RqJejGVH+R/IK7y+hegIp4Zkp9U2SPbSvJ0AJDIA7DtskVJno/I+KBrbgw9vp6PexjcWCTskB1z
 4Lj+G67xizbaqbz+rT+oKJNxpM7JGUw32vN946SKU/fGLo4Uw95Dhwi/gJG5h9OKe3E/mmpLPXe
 SizUSMLeMFTrs9txapW+jzPXUSolgFtjyoBCR9HORtAJnnm49HKxwsZcLm39tyZ1G7K3qT6TWyF
 xTfPQ9AktZTZNSu6dUNxQ3D5grvOijeyp81EPZeaMfv03VxSgNhJ4EV+K5Xg/ftSvSGDQYOceP7
 Z+jOoFN9zkUWeDg==
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 doc/mkeficapsule.1   |  23 ++++++++
 tools/mkeficapsule.c | 156 +++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 174 insertions(+), 5 deletions(-)

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
diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index 54fb4dee3ee5..8dfc09ffaf4f 100644
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
@@ -53,11 +57,23 @@ static struct option options[] = {
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
@@ -70,10 +86,11 @@ static void print_usage(void)
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
@@ -816,8 +833,130 @@ static void dump_capsule_contents(char *capsule_file)
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
@@ -840,8 +979,15 @@ int main(int argc, char **argv)
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
@@ -928,9 +1074,9 @@ int main(int argc, char **argv)
 		case 'D':
 			capsule_dump = true;
 			break;
 		default:
-			print_usage();
+			print_usage_mkeficapsule();
 			exit(EXIT_SUCCESS);
 		}
 	}
 
@@ -951,9 +1097,9 @@ int main(int argc, char **argv)
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


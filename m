Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCBFAC3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 12:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 648D688C08;
	Fri, 19 Jul 2024 14:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mRJCw6c7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28E1C88BC7; Fri, 19 Jul 2024 14:44:05 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A05888BD0
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 14:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52ea7bdde68so1745696e87.0
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 05:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721393037; x=1721997837; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=llK4xT0In7ILZ11aux3dptSqD1KXjlG7HnszAqFZZgU=;
 b=mRJCw6c7Vk+2Md0eK9L/MH3H2UPkV7CUvtflOoTgejhMV+D3ULQVFux0ad7yWoByiz
 aqLCALmSQfnD7Ek2vv7NRgZTVbScu+osQBbB3SGsocn1Amjp8lcH/Zh6938XdD4AJro5
 fxwopA2oIh0TgJY9d33L1vfKccaTwrpNvnSbgaHNLWdYU2cU+VKPxrCoEpcLm9C2mNLy
 kR63ds45hL8l/9RiLyTayvUWDY1eYzVy/LZxSRvwsfpUmdu8tge7bMOlQokdbDvIVSC5
 gY9QRotz9bNRKq9HtB2jm9tCbZT3ooGfCnSDyOtiIUMoWjLKvHcfStzjVA55Svj1Fw6E
 lkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721393037; x=1721997837;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=llK4xT0In7ILZ11aux3dptSqD1KXjlG7HnszAqFZZgU=;
 b=ou8Q8bs85O/TZ6cfIcSg0Beqc9ficZvcIMT8+Y9tzVlh6cry+sG0bxyEkgyP3VFvZi
 Xlejicz/K0muOyKH8ZsKU8WRDKU4TidfbVSFq8TWy+uTl6QnDgVB119Fl2AyhLDkp+cO
 Mj/DkvDmHgv9dVI4CjQtLtjSh50jkBmwA11c2lJxGR4Uf6UdeujzeEDjWLgEEM22K0uO
 3yuQHw/z2YJbe8Lw4fiosaGLZYSmWeacxZ1D34YLO4s4aNPy5iRdBzblz+1y4A64D0PM
 OcLEXkxqP+sX2SETb7Os33MVP0vLjT0qEBMWK0KKuFamBIKIMP1s6oD2wwJOblD4VTcV
 WUuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNTW6thndF2bA9q+KIDBvOe2lW43pefEV28+QeTtbRI1/wONcHuWDwT1amJgmD10s3c/1QTfKslB/qu7x/HFbcu93NRg==
X-Gm-Message-State: AOJu0YxLY3+VxbWoTI8p6ivqYwzFC7a72w+7iWsneE7SMR1E5ugppu+C
 a01gTwYWvzEWtzFEOfFhTTFow4t1RrVhd5TW7PEP2Qpe9IM4Da4CpNfpc+WCWF0=
X-Google-Smtp-Source: AGHT+IFa1/0DBq0be1bLAU5tbX+q3nNtBH0blC6lzacXcU7wA26IUiLcdSWjT3zd7jXyAMdfQWcPfA==
X-Received: by 2002:a05:6512:33d1:b0:52e:bdd4:610c with SMTP id
 2adb3069b0e04-52ee546ca4fmr5358976e87.63.1721393037293; 
 Fri, 19 Jul 2024 05:43:57 -0700 (PDT)
Received: from [192.168.2.172] ([90.187.152.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c785e97sm28577466b.39.2024.07.19.05.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 05:43:56 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 19 Jul 2024 14:43:49 +0200
Subject: [PATCH v5 09/11] tools: mkeficapsule: support generating dynamic GUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-b4-dynamic-uuid-v5-9-8a83de3fe3dc@linaro.org>
References: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
In-Reply-To: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
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
 bh=1C+uaiSfAQ8Egf4zk38nISU8F2OuZnqGH4xxBkBr6jI=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmml+BgwnsgZ82w6oBx0ryJce7YsHt0O8pJSFmv
 X+i817eiEiJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZppfgQAKCRAFgzErGV9k
 tlWfD/9ljiN3aIDa4xOczzk0TnsdQUrmdeVvj7Lrr0DJnCBerhnOctca1a2QIxvQzaGDnR3j86Y
 GlrP7j2o653hd2qqtG6iIA8ucX4t/P8YmSOhF7guev/bzuw4BoWQyW9xZvb3kSexfZIbuRPydPP
 B010zTe0oH8mWF7kbSYJgU4BIzYDeknn8QAoOFIJN2n7uzPKB2jokzVo0FRsl/8bJcUkc6oT77z
 SwagvrSDNQyaepb8fBAoDtghQEIP8ZRRECk1ZnjVritSIkZSkhW4rbtqky2bqaSosiQqOIsmDGI
 Vw0fx/EkZuLbpSqYMOrFgkP+Ha64oPVQiKX6vBOYWcuxwjgmkm22i0U1q8r8HJiRVrdlmPVqwLy
 7SXNBGh6cQy+fefaXgj/iy8qyiSfCt1pgrvSwkdyuZPhR1nr3+VWQCYItC3EfWzSRg649JDhmzj
 guqMbLaiKDm+BeuCbwZkbVJbACfs5mpjHuxIft9oMhvDhGc7THZHvL2P9Ehcb7s0hTaVY3qCgHD
 hnRN/1xWn4nszyv30bBQTWQft0GabVaQPW1al8YYurf38KasKGiv+OZerm0HTmy9EVfEIUQcOsD
 FMyi8Al5bW8RJ9R7iBthMToLnU3lKWvM/I/AteEybmYQHcJle2RySkUa6BujvjRMtKrDXzPtey1
 BFJo1Ec+99nWwgQ==
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
2.45.2


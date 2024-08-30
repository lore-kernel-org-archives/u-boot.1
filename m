Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E047BCA0FE1
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 12:36:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D17B988C78;
	Fri, 30 Aug 2024 14:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o+mLPlRo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5584B88C01; Fri, 30 Aug 2024 14:34:46 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EC4C88BB8
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 14:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37186c2278bso1537174f8f.1
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 05:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725021284; x=1725626084; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l5r79sQC+0jVmVErM6RlNVJOcMhMKvSSp+nwTJsGWy0=;
 b=o+mLPlRoeueThdYPwiDUXXki/vRXdh++TL2auAE3uvkkMmjE46HS0pISthmoh6UEei
 RGIXFA2HnDHvXAkvY0K++bTD4FEhumlCgpvEtRvpH7Z2qunVu5+UVNvMcyn/eqNKafYO
 I45iS8agrVo9ovwITae9or7vODfkD475Onm2MKaGpIAnu4gEb9yhvIYlhzTDO5SfN7oc
 Xk6AVMv2TkMsEpZ43kEUEcrl/ir8ScsgQbSnJ7AmSl0HwC2gnaDdP70XWp+6GB8PcfHq
 wadc1Vq+tM6UBumdq0iyt+3ZNrowMeoByn22BJ5KPAk+MY/qN0S1Fq2nPtGcDYJHnZsy
 wx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725021284; x=1725626084;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l5r79sQC+0jVmVErM6RlNVJOcMhMKvSSp+nwTJsGWy0=;
 b=Xa5VPQaBen/3WC8Ug5I3fG94eI5qoZ7q4VT+u3w/ekALbGiZvdMCaNVfHwH3T8Jufr
 LwN3WoXuNPtgPDeNchojCH/hxipuqgXmkOmcSx3sAeevy+LBUrHAswBCAn+cEMCBAwy1
 vAEDUu482RZGzAo3JPavmQ8i1/LYRrQDFwgfsu6GFuvxvXWbXTYO8Qhq/2gv/9vxjIs/
 wa1t9H7d2zDYHM97Nro7LrjSOFlbP85yN0qDOnRh1XFoE0UZeSobXGxebxYx8ue8YsAM
 khvpzTYrCAIpQa6L8V7a4Xxs3daWd2hsJuDH2WjGSEL75gVpVYXY7/VTSsBDN+Qrlbsz
 8hvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVywtXYYPQJpD+kIugwZruxpYdcT1CfisO65TP+OHnClIE28tvvGDNfkwl+8RFuVo49jK46M0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw62qg0xTwutpnnLwiCDJnpUIpcXauwNtOcs+xeOLdQGFunXnDx
 N5VNqgPMUncf6zdWSVcChfKarqowmCZs1hYZHlHPlJdeBihodNTWknjsFpF6VVM=
X-Google-Smtp-Source: AGHT+IFyAcFj0BHZdJokS2lNdFvwnBMZ+LuHGDl85NTSR2wf1dwJCSZkrmcxrRXejWoKFzJpPy5sUA==
X-Received: by 2002:a5d:6086:0:b0:36d:255e:39b0 with SMTP id
 ffacd0b85a97d-374a918b936mr1308906f8f.14.1725021283693; 
 Fri, 30 Aug 2024 05:34:43 -0700 (PDT)
Received: from [192.168.1.17] (host-80-47-105-51.as13285.net. [80.47.105.51])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b960ef94sm648207f8f.103.2024.08.30.05.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 05:34:43 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 30 Aug 2024 13:34:38 +0100
Subject: [PATCH v8 08/11] tools: mkeficapsule: use u-boot UUID library
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-b4-dynamic-uuid-v8-8-79b31b199bee@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3778;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=1D9v/krX71PoDrNJAoDEEw+mk5TrkItnnYCaNhfNd1o=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBm0bxZvp4NvuiPNNs3lBPsNH3iZGZepes3gQ2pb
 TnoIEeqeV6JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZtG8WQAKCRAFgzErGV9k
 tvpwD/90FfDh3w7UwRIHYNngDYMUs9ytHf2AyXLphDpWUZeNtDCW3kWqDF6hj54mvlFDNv4W1j4
 xe6QNMep2dgg31a3sAGWN14JBHhZGEDTKT190YiU5ahz4aLlPWEVgPkIZkoZyj2ISWlfndYmAMt
 YqIMNqmggB6P25flRA3l29LLdodKjT/t7FMpbGdzzWuRD/AhRObTWjeL4J7aOL8zWGCRCX5hnsW
 z51Gfm5g6zY//20OvIROklx15vzEzIhI1DGntkpHEIFsypw56DUG/LgJspFtwY2NY14YoWuCxHx
 C4Qyf4BbpcBHF1nbd4mcAKmmjYBP11AoORE4FZ620L+GMwB7fY8ydgoBv4RMpNntV7RaGLQrlLu
 czERzT0CerI34tl7jl2w9gegqHAob0GmVnMVQqPHVlmgCSnb9sGaAALFFaxRdQ7R/rzUvjeWa5c
 aCK8/4Yv7te6pPGdORbr2Yd7fdjQOH+CC8gLGGeckztPEoplGGkJxYQTN6MD+LWyKG9QgMTwty/
 zwaysC50Aw1d8njFgwpdTrddEvbpC3dekGWf7xjvdpu/TjFwg/7UiZL9pL1/mDTOeQVk38mK2JD
 +nWYv51RYjaicsYG0pVHMp8D7YCmFBRTPEjdmi63Gv31sp5qd38Rza8YcPaM6QMcEwUbHGTuDJJ
 si8Sdnb382d659w==
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
 tools/mkeficapsule.c | 52 +++++-----------------------------------------------
 2 files changed, 9 insertions(+), 51 deletions(-)

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
index f28008a0829f..68c97cfb9db4 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -14,15 +14,15 @@
 #include <linux/types.h>
 
 #include <sys/stat.h>
 #include <sys/types.h>
-#include <uuid/uuid.h>
 
 #include <gnutls/gnutls.h>
 #include <gnutls/pkcs7.h>
 #include <gnutls/abstract.h>
 
 #include <version.h>
+#include <u-boot/uuid.h>
 
 #include "eficapsule.h"
 
 static const char *tool_name = "mkeficapsule";
@@ -576,39 +576,8 @@ err:
 
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
@@ -652,22 +621,12 @@ err:
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
+	uuid_bin_to_str(ptr, buf, UUID_STR_FORMAT_GUID | UUID_STR_UPPER_CASE);
+	printf("%s\n", buf);
 }
 
 static uint32_t dump_fmp_payload_header(
 	struct fmp_payload_header *fmp_payload_hdr)
@@ -905,13 +864,12 @@ int main(int argc, char **argv)
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
2.46.0


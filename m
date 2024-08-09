Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C77C52D7B
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:58:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5668688C08;
	Fri,  9 Aug 2024 02:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H3WHusfD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B75888B63; Fri,  9 Aug 2024 02:56:42 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C7C288C18
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 02:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a7aa4bf4d1eso190646566b.0
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 17:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723164999; x=1723769799; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pf4OM0prvvLF0aiOGIs6XUHN+PigrIYz1lUmOKvqkEw=;
 b=H3WHusfDX15028GGsgZnuxoQM7xYuu+bEuHQ2+0Zo66ZQWWu9a+pg9nImJ7z2mAxNT
 nfWGd/Rl9avXgU2mp85DC78OoNaTyLuzSTzS4yJf17BBhd3mOXAQUHJ8lA93upiam+mY
 30l2191NU8vCUG3UkVHzVzwQJUeLfyHQaHZLUSqTszF6x5Foq1ThqvgrRHtK9ivup3x1
 HM0WohWp7e5Tuq/0chpXrTsHRU0CkYvKuWkaUlciHkzWWpjd5Ig62watcLsp1yUFw1hv
 3kkTrtE+FQD3XG8Eu1jkNJ1GY1iuziqf6VxcqeL8dAfdEZQsi6rmxLEV2cn81xE/3SYo
 2bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723164999; x=1723769799;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pf4OM0prvvLF0aiOGIs6XUHN+PigrIYz1lUmOKvqkEw=;
 b=KHXQ0d+k4ubvAMhJySywF1tzHyUdAul/ET6XASV3SUHh4+8eJc/2VXL3KUa/fKJLv/
 QF+jUOs8dT5lF0f30ioPJsYYvO6Zvd67Ps6uTqJM0s7rNqubFcaoxPPqXDRkl+ABqUYk
 TEBFDCIqK+NdvtmKrVaPOaNaM70fy523+MyEtpE75Mtjk4vPCrVydev0+6CHizyLBUoe
 t1+//9gqdmRT70V4azAcmYLZY6B1durQyugV0a16W/nNf7becwBMEXz8iiRtYo64Zos+
 AuwsopvMbLVcsY3PrIR3tfn8qUxiYR1bCqYX4DLTSVxdOBBCY5aFWoNPzNm6MJ6i9XKs
 pAjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbKjGRwiSU6r7w+9ou2roEWEPeB6/hyk8tsDr1vHpp/R0CM+oOyNpg2TTT2JyQvRulE5b+ZTEIl3GhusahkSsInvtVMw==
X-Gm-Message-State: AOJu0YzJvkWurh1oY2jGActrfGKNAXQY/gonOrH7HLddpj4hmij4/d9d
 NIxL/hB2boMMxFdysV6LeuPMqbr7OMIBR1t0O5vPjr2da+17X0qZeaPSWk0jN7U=
X-Google-Smtp-Source: AGHT+IEqWFCpzra+/vMDWo8Mav4YSTfzVI9J0EBgAaC9rXCFFlAeNJHwFXxJYTRTYW5XYZq5ryk2lg==
X-Received: by 2002:a17:906:bc0e:b0:a7d:9f92:9107 with SMTP id
 a640c23a62f3a-a80aa6d36abmr3166b.58.1723164999470; 
 Thu, 08 Aug 2024 17:56:39 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e80e54sm790680266b.167.2024.08.08.17.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 17:56:39 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 02:56:27 +0200
Subject: [PATCH v7 08/11] tools: mkeficapsule: use u-boot UUID library
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-dynamic-uuid-v7-8-8c44ab1f06a5@linaro.org>
References: <20240809-b4-dynamic-uuid-v7-0-8c44ab1f06a5@linaro.org>
In-Reply-To: <20240809-b4-dynamic-uuid-v7-0-8c44ab1f06a5@linaro.org>
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
 bh=yvRcazKV9vl3+Pgpl3lDlzl/yfWSKc7gLZywA+IlSTY=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtWk96o035BaXaW0jJNSImoU7k3Nc5SkndyUkW
 kB+0mdLfAOJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVpPQAKCRAFgzErGV9k
 tuGSD/9QcSgife5SaVe1WiMfRdKbPrfKRMWrVbFIMoiKL0giTZ93Xl6H+PmefK3UpMhLhhjAHD8
 ikEjn2kotEGo4cNfsPLe0kE9K95FXVPM16ff1wM1DggNNZFr/BqhHKB7cs4E2gc4Yq1PGT0mye/
 Uuhp8mqTLnnHvpldrAZCn8wXIW9a9e5CpMh0RIuQGNiW15VnEcp7wJ+Pv6A82JsQweFPPRPZdqu
 +Qwhg0imZSHJysW0/7dDG1t2FYtuoA4GEG5ZL+zJYOXHPdZLbHoaL4xmXPv6LFF2JJyIcVFz2Gm
 HcLtPdk+LJMf0WX39muH/9tcliyxUZBINSPhks7qIAtiLMh2k7ofjGuLMw7Id6ebEwACdHsKy2O
 IfM34NPJVlvKr/lK9EvsG6q/1tIVN5v73kq/nKs1JAZlCyXEnUZ6qEkQynRv+oxNeIjRQbgGO8Y
 LPt7xYTRfjhie6Nn1q+IU+K72JnxA3yQDsnnCAvK1M7uUwZTMLxPpf+VjNGNW/7kuL9VOU61GPW
 e7t4i/HyMVJt9Sh7wP6fZ+hjnR+mQW95cwaOO2lfc/QZPGMgceqEdCiaULGJg2lsaZKfJFMwf3S
 ygw+KJaOKw6XhpOlwTExKa08eKItE368Az7GtxL/vcnIqzWO7P/XHj+WrKQ6zJzAP4wlxvsyj7P
 qYBJaWE5X+vq0WA==
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
2.46.0


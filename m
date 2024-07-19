Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22797C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 12:45:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06D4988C02;
	Fri, 19 Jul 2024 14:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qLR5aozV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1793E88BF0; Fri, 19 Jul 2024 14:44:03 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF8F088BCF
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 14:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52e9fe05354so1968930e87.1
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 05:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721393036; x=1721997836; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yjYV9PN0xWDSskdBgidOP6JWHJHFlMDPu72voIUQ+z8=;
 b=qLR5aozV4wb1n08Wg342EamYjf2UZ98b7+uGqnInE11mjYBWY6aOaS2y3kEW6y/4qs
 Wwbo7z+mljU/gcDr0XZl0fd6d78Bn3rWNueph7c1rDR3iImGxgySQ5OM9u3U2Xfj5Fxx
 JxPlApFyjeXoc6avdooFhLm4ckVOCQCthjTVT0Vq1hfJ7Y4RLG/XtDk4SSPPsdDDxts/
 4R7U3H6nrKuLv2MxkIIha5YrR+1Y9YIFwNELiDCbeJXx/8cyqIKX5/uf3EOn6/a0B9jK
 KGVNrft82YYMQU701/zjj0XN7hb8QNZP8wyEJezdSYHJQ0CCEAg4XPBjpe+RrQRgYz0G
 U+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721393036; x=1721997836;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yjYV9PN0xWDSskdBgidOP6JWHJHFlMDPu72voIUQ+z8=;
 b=gm67eOeEMIX2qceG491hA0WOBpEt+xDmdxBTNsLkJ0/UgUvSjP+VBZ4mG3Nwg2uYx0
 /pClZ3xGjWtT+Tzk8pCgHRflPO6KfLwa2XMIWtzxs1+wI8p6Iqzhl2zWbrpnyQXP31r5
 uIY0IyjjBfqMkleSQSSOueAIWx9Jl5mwUhWhUNaG+xMvPCI8MXmBzakVnHPueXoWbBNc
 AGHMLBtL/2n+HycIApe2/uSEHftR9PS0hIH4D9PproDuDCSmV7ncnX3nzOXqmqlFvsp/
 pJmftpBGmbE/bjXHss1p69R0Qu1/lPozW8QNgLI/aWacMc6uQ8Dd9zcnGD9meNbjlOsY
 PoyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX+sntJzT2+yymYpKdoVqebtzGI7+8jOulWvnbQND8xbGdlezWcw+nyLkib6nw4YaYWYoeUX9CH3b316KRQ5xPyzGBPg==
X-Gm-Message-State: AOJu0YzgsPuuWU0NrcB1fLKve4gufER+mpGxSjDsDyFcJtLY+COGZ3BL
 J0sMrFeJX08juK2nDptEGSvCd0cvjiUhqeDe/W9pwqhbptSPBM9hVeFU6mrMmDs=
X-Google-Smtp-Source: AGHT+IFbH3tCGuxgRXTpOe3EQX3xUub9VdVsOP3PlWURantCaYazrDVs1ojyfqZS30pD2U3/Wd3AoQ==
X-Received: by 2002:ac2:4c43:0:b0:52c:90b6:170f with SMTP id
 2adb3069b0e04-52ee53cc000mr5495418e87.29.1721393036151; 
 Fri, 19 Jul 2024 05:43:56 -0700 (PDT)
Received: from [192.168.2.172] ([90.187.152.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c785e97sm28577466b.39.2024.07.19.05.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 05:43:55 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 19 Jul 2024 14:43:48 +0200
Subject: [PATCH v5 08/11] tools: mkeficapsule: use u-boot UUID library
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-b4-dynamic-uuid-v5-8-8a83de3fe3dc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3757;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=aiqd52H8SbFQqjf61URtk1GpaBu2VRarurf54E5zAHs=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmml+BXGPX0nJP+CqlK5L7lIP5BJoxykz/OcyMq
 xVTDB7I5/+JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZppfgQAKCRAFgzErGV9k
 tg1hD/90LXXrmDe29iXgNxk9C+XFwAW0dCK8Nc76fpC1kSE4B39n4i0C6KFMjWDkFoWpmMZXYS1
 Wmbqrb6jwVUlYp1B2Wj7Tz8mmnXog/pYq8ani6Tjgr6NYqn2hTYb8Vtx2VDvOYQLUFaVHrsnvYk
 iI2QVMEAphhPRhfu7dgnQHF0ZY/7weShhJXTr253XbiEQfKzwdmePecJMCP0KHWC21BHld0/IYc
 d3IpAO9Qb6hWWF14z5Rw9bRXbNRlAsqf7WkZEsd0zXu7PrC66sSQbVRZrDd6RtSBZLz4SJ4HbLZ
 QRtCebGIXCKsESGhdrTLGzqFQjQxcg/5JuJIQlbwPa+Coni2UUIRjs+4p0kSaHvYw2RD7iXnaUv
 e7MSyB5CDsePFTwfFyXOBFTzTnd3cTVWM2ZwSEX/kUW44fMsqIPxEIShKz2MMEWuNaxK9QrMO+S
 E47kuHKWpnOejrVIX4mCIbexNeOM0NAUOUARobg8jKYK4Rchl6ym9VMWk2+pbl5AqDsXwV7N3Nx
 1kN0OHXUYLvY8iNhilvX6JS4Gh5Cll9pKQmZl99FQUG2IjXHYNh01Jvv0Jx0jSLRkMW+FLNOIZV
 IjdWhFGgzwUgJroalscqkFUiJA5/M7GA4XZ8wDD/y9TlzPNiLhUqoiS5AomC0vgrXVIIWOmlAtE
 O25esJgSyEpLdXg==
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


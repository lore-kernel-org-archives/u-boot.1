Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B90C52D7B
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 16:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B38F88C1B;
	Thu,  8 Aug 2024 18:22:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YkELBb/v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B85FE88BE0; Thu,  8 Aug 2024 18:22:05 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFE9C874AC
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 18:22:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52f01b8738dso1042714e87.1
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 09:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723134123; x=1723738923; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pf4OM0prvvLF0aiOGIs6XUHN+PigrIYz1lUmOKvqkEw=;
 b=YkELBb/vsNkUQovqLMMXIgGvd5/cCxZrMNRbSLIX3Yr7KtLI4yCN0vdyXwLU+cLBtj
 DOINazuHGd1xGQciwohVtl2vyg+XXpKqdtYgzKc9OGE7bGG3Idze/jaCgjy7KoWQwJh1
 Bfp+OlwquUi6eWhRTvOyeeaQdcF0KXEfq/GVayG4igYx16dvAWKhd7jnldXRUqI/BYlb
 6goSBhi8/QUY83F6rMurN7i/u11w2/Mj52BGMOwiXO3842Dq6ld4Sy/KhIiR77bHCbl7
 BsLN3U2zPW9YYOGOTSpEX8iYCb2xXPcp2vxUClfO2qAU7FMUjBnCq3eCGf3A1/y/rAae
 OCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723134123; x=1723738923;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pf4OM0prvvLF0aiOGIs6XUHN+PigrIYz1lUmOKvqkEw=;
 b=gO5eVLFKE7WUTGpq4MtykSKQL/+Wh4d1SPZIqiFbzd8Of88N9pwDMbMcBayuWNhey0
 yJJY4U757jUOMuZKIpPBHWLrvtaNMa6jxmcvFtHRuLhVVrBlYZNq1Viv5uiJf+uNvQyi
 NuBKtJv20/RAuX+D4UFQHAVui6oaLCJP9gdmyepEvFempapMabM+qIO7pGnpVaJtav7M
 n32CMMg/wVhp8IkiLHJYrwgU5eMYYuAdBpQ4ova52SACl8fekJL7Cr7w50LshyXr+YEW
 C0gBuPiXn7pOmccLJUjkeA4KgJWoekNuRXKwjGdScMZGuDJQwQ2Hu42S8g5hN/tCBehN
 JNuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCR5wd8cuM4NAP84L4iBTqni589knkSUpvpmqhDc7NHBt/ZY0qthiwyjcsX1uVusjm5Id8mBegMa8CgXerr2u8fQX42g==
X-Gm-Message-State: AOJu0YxyojxzU2EYC/E3H2G6ohXUiMwtNSA3U4EAjq1IpGCF8ZXdsH/5
 +iOM4U3AklVSgRsbXMGtoWEM1PuYzWS+tXt0pcY4Y2L6KxSBUNKkuamt28vCgYY=
X-Google-Smtp-Source: AGHT+IHiHm66DgOiweG+6Sp7G8SSDT+Izdl9tS41msjjjTIcpZyB7d4bvTSoNHtdB9MNEyCGeEJQOA==
X-Received: by 2002:a05:6512:1149:b0:530:ac0a:15e8 with SMTP id
 2adb3069b0e04-530e5817bc8mr1747030e87.11.1723134122860; 
 Thu, 08 Aug 2024 09:22:02 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bbb2e5c8fbsm812351a12.79.2024.08.08.09.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 09:22:02 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 08 Aug 2024 18:21:55 +0200
Subject: [PATCH v6 08/11] tools: mkeficapsule: use u-boot UUID library
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-b4-dynamic-uuid-v6-8-9332e7237119@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3757;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=yvRcazKV9vl3+Pgpl3lDlzl/yfWSKc7gLZywA+IlSTY=;
 b=kA0DAAgBBYMxKxlfZLYByyZiAGa08J+i/ecmnH04m2MVRC/VbzZVtTvmdASiqEQ8p4HluILde
 4kCMwQAAQgAHRYhBLZRoUY8ar7QaQxVzQWDMSsZX2S2BQJmtPCfAAoJEAWDMSsZX2S29vcQAKWd
 xX24s6ZgOqKmUW3S3XNk3Nz9koj65cVcQHcXsDU8r/pzvCPMzGTAZCIVJKrNgL4zXpP/zXTh94m
 4VUOVC8RbiLsemfIGNkvcXPRjyQvLdb6xD0fLACiwRCo6uIvjmGbJDWMAH2NLOFMLM+yCv+0gSo
 U+AG4vltPUCYCOY9+hOSVSZO76WGS0H4PZrPvipoZH+NCFGEuboWA9gCMKC9GIMguMF/QDMJS1Y
 +jMIYtfv1NGUoREZvAkXU5kpMwY0usoV6yRLSIKwh7ZWqmME/KY+yiCkCV7foLkiSx9M98XiXmP
 hqhxQCJ5GbBHpgRvN6kkp+ROk3mkAq/bD/z4S5pWiL8urVSBCnP9App8oCOVRaPo/hgX4GjJL4y
 W2a1/8ck3mpRYsAbN7HJvmYdUjmYQpikMX04pYeTqTGFYw1Y8+Mvb1264moelEvpKXvgCEhTIeK
 pBFOOWc6NhgCCWGDmP6ALTciYeVQDKF6C+s2k4ec/fOXBPHGiL543xcAJRlAdR2NkP72v59t2PP
 FkBjncYiHMpNiDpiSZ/B8IWrt8FTMFIzmakXs42zDWmKGGDkxBI3CCSfHl5DvbGPqLrMBjVb/lt
 FZo21KarO8GF666M9HQZbDj6K9vHa7I9ARaihqiDtXKg7rUUKnKa/hWvQoiOy6M2/BbwSbCX00H
 wJE5z
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


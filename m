Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DD5C5478C
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 15:05:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3AF287DEB;
	Sat,  2 Mar 2024 16:05:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lxl+Zp08";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DC6887DB3; Sat,  2 Mar 2024 16:05:56 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6209387E1B
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 16:05:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33d90b322b0so507249f8f.0
 for <u-boot@lists.denx.de>; Sat, 02 Mar 2024 07:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709391953; x=1709996753; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ErV11XeeQq5onKgDeXrDrTwF4MKqNSC7ct0O5VVNuGA=;
 b=Lxl+Zp087FL3cdKJg9jcXHuNV0Z2nv1S2m5IJHyWy/zAjrsVSDa6KYdDwSgIfxVQ/X
 Cmfr0wBVZ05r08K8V5cFqQwrT/SWhUs8W3B7e3TdThWR+mvedGlKfH1l2tZ0Ew5QOCfW
 HtlKwLbxyOxV/7Pl3wOk04Zoba3dSehZEYk5dc6ZM52U33HUxZolbtTJOFZKJNYayP0t
 W188rt22y8yVQNhn7bxzT1zaK1lYxGZBqJeBOBR8Oodx/gfL+uGeTd+I9ZkcoWFN0aJh
 hnaaEfH7xQme1P8wanXUB/Y996BahBZ9Nz2JzSVxDA++Nz6/Xzpt/XK3ibD0ahsPMZ3C
 BFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709391953; x=1709996753;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ErV11XeeQq5onKgDeXrDrTwF4MKqNSC7ct0O5VVNuGA=;
 b=WiytxFkiwxQcEEDtFgSxGVs41H8GvJERKdZCkT3grD397VpA9WfOqrmRTuDNxnRkQ7
 9dNfjKaWiWUpc7pHBsoc0sawJtqHs4pc6LIGzrIK7qkrofUKpLvJNzxMbc2y5Xow0+xI
 pD9oHWWxcEamU+yXOBzApODlY3Ml4j7CRTXEtcpYM9wGI5aDKVBlkTuFdXnR/cw9jaa+
 wFK+mCtHCC8xYoGciXYKSx3C9SHrGs3jxjjqiAF5mNx7W+F5OyNVIsCMgrhcXDi5Qe4F
 Vr9cTN3RuxaT98D4PKwIP/reAiiWKs17Py+VQLjS2vxMtpdeDLMAbtBmvFZd3z5wPbVK
 kJag==
X-Gm-Message-State: AOJu0Yx6uuRSdazHwy+VnqzHYxDOdS+eKDFzJBSlB/JrF5hWJ4wbfEyc
 0GYQ4tje3Bs3Uh3kNSVyR7ghfWJLZd+ntBcxWXIQa0iO2ttG9EazJ1Yc7aBU
X-Google-Smtp-Source: AGHT+IHASgOXFsvMHysVd2BjzqRQ1rurCrI7IdNwyVGjJoFP4qmpCYGY4B/KPxSEUVQFIwR/k/i0sQ==
X-Received: by 2002:a05:600c:1907:b0:412:b802:787a with SMTP id
 j7-20020a05600c190700b00412b802787amr3694691wmq.4.1709391952671; 
 Sat, 02 Mar 2024 07:05:52 -0800 (PST)
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 26-20020a05600c021a00b004128c73beffsm11740139wmi.34.2024.03.02.07.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Mar 2024 07:05:51 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng@tinylab.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilya Lukin <4.shket@gmail.com>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Roger Knecht <rknecht@pm.me>, Sean Edmond <seanedmond@microsoft.com>,
 Sergei Antonov <saproj@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2] cmd: md5sum: use hash_command
Date: Sat,  2 Mar 2024 16:05:48 +0100
Message-Id: <20240302150548.574383-1-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Drop old implementation and use hash_command() instead, as
how it's currently done for crc32 and sha1sum cmds.

Test:
=> md5sum 0x60000000 0x200
md5 for 60000000 ... 600001ff ==> e6bbbe95f5b41996f4a9b9af7bbd4050

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

Changes in v2:
- Addressed build issues on some platforms

 cmd/Kconfig   |   1 +
 cmd/md5sum.c  | 150 ++++----------------------------------------------
 common/hash.c |   8 ++-
 3 files changed, 16 insertions(+), 143 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index a86b5705174..622e96ad756 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -825,6 +825,7 @@ config LOOPW
 config CMD_MD5SUM
 	bool "md5sum"
 	select MD5
+	select HASH
 	help
 	  Compute MD5 checksum.
 
diff --git a/cmd/md5sum.c b/cmd/md5sum.c
index 0f0e1d3dd68..ded3f9e1831 100644
--- a/cmd/md5sum.c
+++ b/cmd/md5sum.c
@@ -7,166 +7,36 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <image.h>
+#include <hash.h>
 #include <mapmem.h>
 #include <u-boot/md5.h>
 #include <asm/io.h>
 
-/*
- * Store the resulting sum to an address or variable
- */
-static void store_result(const u8 *sum, const char *dest)
-{
-	unsigned int i;
-
-	if (*dest == '*') {
-		u8 *ptr;
-
-		ptr = (u8 *)hextoul(dest + 1, NULL);
-		for (i = 0; i < 16; i++)
-			*ptr++ = sum[i];
-	} else {
-		char str_output[33];
-		char *str_ptr = str_output;
-
-		for (i = 0; i < 16; i++) {
-			sprintf(str_ptr, "%02x", sum[i]);
-			str_ptr += 2;
-		}
-		env_set(dest, str_output);
-	}
-}
-
-#ifdef CONFIG_MD5SUM_VERIFY
-static int parse_verify_sum(char *verify_str, u8 *vsum)
-{
-	if (*verify_str == '*') {
-		u8 *ptr;
-
-		ptr = (u8 *)hextoul(verify_str + 1, NULL);
-		memcpy(vsum, ptr, 16);
-	} else {
-		unsigned int i;
-		char *vsum_str;
-
-		if (strlen(verify_str) == 32)
-			vsum_str = verify_str;
-		else {
-			vsum_str = env_get(verify_str);
-			if (vsum_str == NULL || strlen(vsum_str) != 32)
-				return 1;
-		}
-
-		for (i = 0; i < 16; i++) {
-			char *nullp = vsum_str + (i + 1) * 2;
-			char end = *nullp;
-
-			*nullp = '\0';
-			*(u8 *)(vsum + i) =
-				hextoul(vsum_str + (i * 2), NULL);
-			*nullp = end;
-		}
-	}
-	return 0;
-}
-
-int do_md5sum(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+static int do_md5sum(struct cmd_tbl *cmdtp, int flag, int argc,
+		     char *const argv[])
 {
-	ulong addr, len;
-	unsigned int i;
-	u8 output[16];
-	u8 vsum[16];
-	int verify = 0;
+	int flags = HASH_FLAG_ENV;
 	int ac;
-	char * const *av;
-	void *buf;
+	char *const *av;
 
 	if (argc < 3)
 		return CMD_RET_USAGE;
 
 	av = argv + 1;
 	ac = argc - 1;
-	if (strcmp(*av, "-v") == 0) {
-		verify = 1;
+	if (IS_ENABLED(CONFIG_MD5SUM_VERIFY) && strcmp(*av, "-v") == 0) {
+		flags |= HASH_FLAG_VERIFY;
 		av++;
 		ac--;
-		if (ac < 3)
-			return CMD_RET_USAGE;
 	}
 
-	addr = hextoul(*av++, NULL);
-	len = hextoul(*av++, NULL);
-
-	buf = map_sysmem(addr, len);
-	md5_wd(buf, len, output, CHUNKSZ_MD5);
-	unmap_sysmem(buf);
-
-	if (!verify) {
-		printf("md5 for %08lx ... %08lx ==> ", addr, addr + len - 1);
-		for (i = 0; i < 16; i++)
-			printf("%02x", output[i]);
-		printf("\n");
-
-		if (ac > 2)
-			store_result(output, *av);
-	} else {
-		char *verify_str = *av++;
-
-		if (parse_verify_sum(verify_str, vsum)) {
-			printf("ERROR: %s does not contain a valid md5 sum\n",
-				verify_str);
-			return 1;
-		}
-		if (memcmp(output, vsum, 16) != 0) {
-			printf("md5 for %08lx ... %08lx ==> ", addr,
-				addr + len - 1);
-			for (i = 0; i < 16; i++)
-				printf("%02x", output[i]);
-			printf(" != ");
-			for (i = 0; i < 16; i++)
-				printf("%02x", vsum[i]);
-			printf(" ** ERROR **\n");
-			return 1;
-		}
-	}
-
-	return 0;
-}
-#else
-static int do_md5sum(struct cmd_tbl *cmdtp, int flag, int argc,
-		     char *const argv[])
-{
-	unsigned long addr, len;
-	unsigned int i;
-	u8 output[16];
-	void *buf;
-
-	if (argc < 3)
-		return CMD_RET_USAGE;
-
-	addr = hextoul(argv[1], NULL);
-	len = hextoul(argv[2], NULL);
-
-	buf = map_sysmem(addr, len);
-	md5_wd(buf, len, output, CHUNKSZ_MD5);
-	unmap_sysmem(buf);
-
-	printf("md5 for %08lx ... %08lx ==> ", addr, addr + len - 1);
-	for (i = 0; i < 16; i++)
-		printf("%02x", output[i]);
-	printf("\n");
-
-	if (argc > 3)
-		store_result(output, argv[3]);
-
-	return 0;
+	return hash_command("md5", flags, cmdtp, flag, ac, av);
 }
-#endif
 
-#ifdef CONFIG_MD5SUM_VERIFY
+#if IS_ENABLED(CONFIG_MD5SUM_VERIFY)
 U_BOOT_CMD(
 	md5sum,	5,	1,	do_md5sum,
 	"compute MD5 message digest",
@@ -182,4 +52,4 @@ U_BOOT_CMD(
 	"address count [[*]sum]\n"
 		"    - compute MD5 message digest [save to sum]"
 );
-#endif
+#endif /* IS_ENABLED(CONFIG_MD5SUM_VERIFY) */
diff --git a/common/hash.c b/common/hash.c
index e837c56d443..3d6b84de473 100644
--- a/common/hash.c
+++ b/common/hash.c
@@ -321,7 +321,8 @@ static struct hash_algo hash_algo[] = {
 /* Try to minimize code size for boards that don't want much hashing */
 #if CONFIG_IS_ENABLED(SHA256) || IS_ENABLED(CONFIG_CMD_SHA1SUM) || \
 	CONFIG_IS_ENABLED(CRC32_VERIFY) || IS_ENABLED(CONFIG_CMD_HASH) || \
-	CONFIG_IS_ENABLED(SHA384) || CONFIG_IS_ENABLED(SHA512)
+	CONFIG_IS_ENABLED(SHA384) || CONFIG_IS_ENABLED(SHA512) || \
+	IS_ENABLED(CONFIG_CMD_MD5SUM)
 #define multi_hash()	1
 #else
 #define multi_hash()	0
@@ -404,7 +405,8 @@ int hash_block(const char *algo_name, const void *data, unsigned int len,
 }
 
 #if !defined(CONFIG_SPL_BUILD) && (defined(CONFIG_CMD_HASH) || \
-	defined(CONFIG_CMD_SHA1SUM) || defined(CONFIG_CMD_CRC32))
+	defined(CONFIG_CMD_SHA1SUM) || defined(CONFIG_CMD_CRC32)) || \
+	defined(CONFIG_CMD_MD5SUM)
 /**
  * store_result: Store the resulting sum to an address or variable
  *
@@ -565,7 +567,7 @@ int hash_command(const char *algo_name, int flags, struct cmd_tbl *cmdtp,
 
 		/* Try to avoid code bloat when verify is not needed */
 #if defined(CONFIG_CRC32_VERIFY) || defined(CONFIG_SHA1SUM_VERIFY) || \
-	defined(CONFIG_HASH_VERIFY)
+	defined(CONFIG_MD5SUM_VERIFY) || defined(CONFIG_HASH_VERIFY)
 		if (flags & HASH_FLAG_VERIFY) {
 #else
 		if (0) {
-- 
2.34.1


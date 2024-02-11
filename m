Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E41C4829A
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 18:56:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02D8F87B71;
	Sun, 11 Feb 2024 19:56:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="NuONnjRf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6636687BAE; Sun, 11 Feb 2024 19:56:28 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 502468798F
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 19:56:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-511490772f6so3097898e87.2
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 10:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707677784; x=1708282584; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hGgmuh29HNn4neUPaJ5Fo2BtNYk7u8EvqUQ1Xc+uJ6w=;
 b=NuONnjRfhtdHVb+SJTQrGPq19sdNmA76uNXfqBxtaWsz63aMOe+1owdO5BU7VKp6+6
 ZLnslPxJcDW9/mdU/e8KHij5Pi/E5SyTW2ExeWcYpxFPQXEq+KshcONIGtjp2j08Qoxh
 yYrZO4ua42u/7DGYGyBcESTe7CX/7nh3WCf2TS3iWndnW1H/Ogw4mooWknbCMwxLDIdb
 nbdLWd38c7cyIeNHDzbNxDBVrZYedS+4+tS3kMxggutuez4rK6Nq/rK5iAjLu09L8QJ0
 RxaVD/Hui8oTHMQSzy2SrhAk1LUZKS4JS1ZObKH+MHY/1kLA+fKzFebxOQsh5h3qvP44
 NQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707677784; x=1708282584;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hGgmuh29HNn4neUPaJ5Fo2BtNYk7u8EvqUQ1Xc+uJ6w=;
 b=o1r3ijqHdBXukEK7iARJ3G4p/RzQHmB+V0RJf/TMs7MUoZ+teaCscdT1p7QWOKDsGg
 O60T+wDsqZCIkIsRSwYGiv8f1ELh5ptHfr5VA2HlbCINjXPFyu1RQmSfsNb1WTo7ribv
 iDiED7hFhOSZ2PIIwzDwk123d+40cT9fqgD57S01rMKPr2P7O4/XujgpHWjVIVvvprgl
 Qgfdv2yB9JT17DuwZe0t47wRyhP3L7nXICdMl2692s9evkvhnxMd7FNVyAKauNCn9gDf
 4Gkn6UrzhBrlrWBHcUof1KxrSieZYfSXmI96Xg69r5ht1EE3gLQE+UEY7RPuCH3f575w
 DXEg==
X-Gm-Message-State: AOJu0YzPlmmn1EuGeuFe7kMbQEeVpmSjYt5alVGKU2Yc1TYHJsEpOfPd
 ok/nqCCDeBaUZfmgusicpxbdrJ/V7huHNwn8x/UdIM/lQBphD0p0OnWay+JvgYkx3CwXSYR97ML
 dX7w=
X-Google-Smtp-Source: AGHT+IEx6Qso8colB0Inxw9x40n4WdThDtNUxm7WwVACVBlSjDcwB5cR9MlGDlDvwhzU+ozRd2X2jQ==
X-Received: by 2002:ac2:5f69:0:b0:511:878b:805 with SMTP id
 c9-20020ac25f69000000b00511878b0805mr1581574lfc.9.1707677784605; 
 Sun, 11 Feb 2024 10:56:24 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVonRijauojIfXaiq/+fi20U//jJC7o9fjG7t2r84qviEFLrqwU8VKk1qbdCoeFcXWn6jymmzPor9gERyfbaL82CxbhpIC0
Received: from localhost ([109.108.76.111]) by smtp.gmail.com with ESMTPSA id
 bi19-20020a0565120e9300b0051180fe5eeasm550836lfb.71.2024.02.11.10.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Feb 2024 10:56:23 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Igor Opaniuk <igor.opaniuk@gmail.com>
Subject: [PATCH v1] cmd: md5sum: use hash_command
Date: Sun, 11 Feb 2024 19:56:16 +0100
Message-Id: <20240211185616.1041356-1-igor.opaniuk@foundries.io>
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

From: Igor Opaniuk <igor.opaniuk@gmail.com>

Drop old implementation and use hash_command() instead, as
how it's currently done for crc32 and sha1sum cmds.

Test:
=> md5sum 0x60000000 0x200
md5 for 60000000 ... 600001ff ==> e6bbbe95f5b41996f4a9b9af7bbd4050

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

 cmd/md5sum.c | 149 ++++-----------------------------------------------
 1 file changed, 9 insertions(+), 140 deletions(-)

diff --git a/cmd/md5sum.c b/cmd/md5sum.c
index 0f0e1d3dd68..618265e8d50 100644
--- a/cmd/md5sum.c
+++ b/cmd/md5sum.c
@@ -7,7 +7,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <image.h>
@@ -15,158 +14,28 @@
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
@@ -182,4 +51,4 @@ U_BOOT_CMD(
 	"address count [[*]sum]\n"
 		"    - compute MD5 message digest [save to sum]"
 );
-#endif
+#endif /* IS_ENABLED(CONFIG_MD5SUM_VERIFY) */
-- 
2.34.1


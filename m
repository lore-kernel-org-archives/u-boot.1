Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB40C25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 19:19:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C16488223;
	Sun, 19 May 2024 21:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dSl8yeYI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FAF788093; Sun, 19 May 2024 21:19:09 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34C52881AD
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 21:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r.stratiienko@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4200ee78f35so10841935e9.1
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 12:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716146346; x=1716751146; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/LtYE/uyJSryc1LuiiQaiZ7aBfis5NZs0wCq7CWQV1I=;
 b=dSl8yeYIJ7D22zL5pDb7sjffoqkq2xJ/42dMRr9j1rxmxXyCuefqv3YwMvzh4JN/ke
 3zrpgID5ov22HJBWpDR5ycMJKOVtYyXMbTekJl56kBTcmnDOyMK1BAObVzyk0lJNfK4c
 RvQsKCiB4aAmHuV+VsknjWAQYXLxxOcfhlh35iW1Er/UtCkbY49DJkpK1QdKqyZ4q0HL
 c4/SYPmRiqy8upuzzlmVfRVWcsYAnXrvVjITU1hjYG6894xCmJqqUMdI7cDlRWBQFpPx
 ZzJRbT9MG/d0q4gh2iwUa0xmH5AhJpfZDB2wMt3KpmdWGEACBCgi/dg63yQg1syqIbjA
 TH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716146346; x=1716751146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/LtYE/uyJSryc1LuiiQaiZ7aBfis5NZs0wCq7CWQV1I=;
 b=dyEJ64WwJ75wDxuSLpShddPgCxb8KeASs2r/0y/6poExdhWrSCoi+e2eTNDPAlIPAU
 2kBqx/FfpTPPLCbTlUkyXGkV+ysRRv3e2gJI/CTh1r6jUG0/hFe8BOgBR30va9/uRBU/
 eKZaI3kOzQkmKtLbSLNQsnzWbzBT5u8rB+GquKdx+Duj9N4aMXd0n66z+vheS3FqW+yd
 b8Eo75hwU1LFoGLfq1JvXOAQr7B4Ez2zjctCrY8UWklskfm1TTREypUSbealzRgnB5Bo
 qLf44yYsJpNK8VdhDwgNtgh9wcjS9mbjW4j8Ng0YgHSomtgydENk2A02P3ZTnIka2zK0
 zdCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqkWSBb4YO6qmMAAED7Lh2Jr40ZxZoNFy+4zjNGnju4HxmVTqLEinqtXwLgUTnNwaD+cC4rb5KN9b/8uLKhbfQ5R1MSQ==
X-Gm-Message-State: AOJu0YxK+HPIC3cLJFnrnPQe2xvi3rW6hmXvB+Cx4Iu59lhSv5j0z3bX
 9xNpKVryb2+SATsMBErRWBfBtQoiWpIxmLMlomxMnn+dXSITXKs+cZZscA==
X-Google-Smtp-Source: AGHT+IFARbAtMLw1RtewiOySuDfO+DqYNkV/psb6RpxGLea61NBiNVczXBMD6m8KIssfvc6/sQV6Uw==
X-Received: by 2002:a05:600c:2295:b0:420:ec6d:26c8 with SMTP id
 5b1f17b1804b1-420ec6d2925mr13627035e9.12.1716146346675; 
 Sun, 19 May 2024 12:19:06 -0700 (PDT)
Received: from roman-envy-fast.. ([46.172.77.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b89583dsm27411682f8f.33.2024.05.19.12.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 May 2024 12:19:06 -0700 (PDT)
From: Roman Stratiienko <r.stratiienko@gmail.com>
To: r.stratiienko@gmail.com, mkorpershoek@baylibre.com, igor.opaniuk@gmail.com,
 dsimic@manjaro.org, sjg@chromium.org, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de, eajames@linux.ibm.com, marek.vasut+renesas@mailbox.org,
 paulerwan.rio@gmail.com, u-boot@lists.denx.de
Subject: [PATCH 1/3] abootcmd: Add load subcommand
Date: Sun, 19 May 2024 19:18:54 +0000
Message-Id: <20240519191856.2582174-2-r.stratiienko@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240519191856.2582174-1-r.stratiienko@gmail.com>
References: <20240519191856.2582174-1-r.stratiienko@gmail.com>
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

What it does:
1. Allocates the memory in HEAP to fit the partition
2. Loads partition into memory. In the following patch of this series,
   loading will be optimized to avoid loading an empty space.
3. Sets buffer start and buffer size value into environment variables
   abootimg_<partition>_ptr and abootimg_<partition>_size, respectively.
    and duplicate them as
   abootimg_<partition>_<slot>_ptr and abootimg_<partition>_<slot>_size.
   The latter two are needed to access by the AVB get_preloaded_partition.
   (see the next patch).

Before this command, the boot script developer was responsible for
allocating the memory manually by choosing the start and the end,
which is far from good.

Usage example:

    abootcmd load mmc 0 boot a

Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
---
 cmd/abootimg.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/cmd/abootimg.c b/cmd/abootimg.c
index a5321bab6a..808c9c4941 100644
--- a/cmd/abootimg.c
+++ b/cmd/abootimg.c
@@ -8,7 +8,9 @@
 #include <common.h>
 #include <command.h>
 #include <image.h>
+#include <malloc.h>
 #include <mapmem.h>
+#include <part.h>
 
 #define abootimg_addr() \
 	(_abootimg_addr == -1 ? image_load_addr : _abootimg_addr)
@@ -259,10 +261,81 @@ static int do_abootimg_dump(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
+static int do_abootimg_load(struct cmd_tbl *cmdtp, int flag, int argc,
+			    char *const argv[])
+{
+	int time_start = get_timer(0);
+	struct blk_desc *desc;
+	struct disk_partition info;
+	char buf[512] = { 0 };
+	void *addr;
+	int ret;
+
+	if (argc < 4)
+		return CMD_RET_USAGE;
+	if (argc > 5)
+		return CMD_RET_USAGE;
+
+	ret = blk_get_device_by_str(argv[1], argv[2], &desc);
+	if (ret < 0) {
+		printf("Error: Failed to get device %s %s\n", argv[1], argv[2]);
+		return CMD_RET_FAILURE;
+	}
+
+	if (argc == 5)
+		sprintf(buf, "%s_%s", argv[3], argv[4]);
+	else
+		sprintf(buf, "%s", argv[3]);
+
+	ret = part_get_info_by_name(desc, buf, &info);
+	if (ret < 0) {
+		printf("Error: Failed to get partition %s\n", buf);
+		return CMD_RET_FAILURE;
+	}
+
+	addr = (void *)memalign(4096, info.size * info.blksz);
+	if (!addr) {
+		printf("Error: Failed to allocate memory\n");
+		return CMD_RET_FAILURE;
+	}
+
+	ret = blk_dread(desc, info.start, info.size, addr);
+	if (ret < 0) {
+		printf("Error: Failed to read partition %s\n", buf);
+		goto fail;
+	}
+
+	sprintf(buf, "abootimg_%s_ptr", argv[3]);
+	env_set_hex(buf, (ulong)addr);
+
+	sprintf(buf, "abootimg_%s_size", argv[3]);
+	env_set_hex(buf, info.size * info.blksz);
+
+	if (argc == 5) {
+		sprintf(buf, "abootimg_%s_%s_ptr", argv[3], argv[4]);
+		env_set_hex(buf, (ulong)addr);
+
+		sprintf(buf, "abootimg_%s_%s_size", argv[3], argv[4]);
+		env_set_hex(buf, info.size * info.blksz);
+	}
+
+	int time_end = get_timer(0);
+
+	printf("Loaded '%s' partition to address 0x%p (size: 0x%x) in %lu ms\n",
+	       argv[3], addr, info.size * info.blksz, time_end - time_start);
+
+	return CMD_RET_SUCCESS;
+
+fail:
+	free(addr);
+	return CMD_RET_FAILURE;
+}
+
 static struct cmd_tbl cmd_abootimg_sub[] = {
 	U_BOOT_CMD_MKENT(addr, 4, 1, do_abootimg_addr, "", ""),
 	U_BOOT_CMD_MKENT(dump, 2, 1, do_abootimg_dump, "", ""),
 	U_BOOT_CMD_MKENT(get, 5, 1, do_abootimg_get, "", ""),
+	U_BOOT_CMD_MKENT(load, 5, 1, do_abootimg_load, "", ""),
 };
 
 static int do_abootimg(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -305,5 +378,14 @@ U_BOOT_CMD(
 	"    - get address and size (hex) of DT blob in the image by index\n"
 	"      <num>: index number of desired DT blob in DTB area\n"
 	"      [addr_var]: variable name to contain DT blob address\n"
-	"      [size_var]: variable name to contain DT blob size"
+	"      [size_var]: variable name to contain DT blob size\n"
+	"abootimg load interface dev partition [slot_name]\n"
+	"    - load boot image from device partition\n"
+	"      memory is allocated in heap\n"
+	"      address is stored in $abootimg_<partition>_ptr\n"
+	"      size is stored in $abootimg_<partition>_size\n"
+	"      interface: interface type (e.g. mmc, usb)\n"
+	"      dev: device number (e.g. 0, 1)\n"
+	"      partition: partition number (e.g. boot, dtb)\n"
+	"      slot_suffix: slot name (e.g. a, b)"
 );
-- 
2.40.1


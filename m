Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9D6E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 16:29:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAA2989773;
	Mon,  9 Dec 2024 17:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J96HZ5ts";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83E6D8975B; Mon,  9 Dec 2024 17:29:06 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FA7489490
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 17:29:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-8419d05aa66so320048439f.0
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 08:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733761742; x=1734366542; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Qs9SIcBbKfDvKMs0ZXh24kVL/iebd0l81OadHoXBWc=;
 b=J96HZ5tsb5MCAAyqQTtBFdd5qaFxhy0nNT3nzkU4ta7SbOERWSoEAFpID+sJxNFO55
 dhSUTSWLzt0T5YSfLSZG6YROVEQnX/xPspHOe1ZuBGBBWSiia3zS2OMSA6DYSoQw4eBS
 Xgt/JAlFDzBXiUBWUlf2M52457AIle/s8nwTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733761742; x=1734366542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Qs9SIcBbKfDvKMs0ZXh24kVL/iebd0l81OadHoXBWc=;
 b=RO472Mn+1U3BCbY/t8tRypmC0tuOg1Vnb9TdKqRfyWUI9nIwmZ/3SaqhOD8t0BRUnd
 UUBpR+M7ol9tqYZ/zzBSrYbDd5hQyhpxA2lCbl9oesxzuEiLqJf/6s+hAmiJrXtkDovY
 8wDLM75EQQuJyjyrV2+bZb2aAuTyRJx1OAP0BjjcQY69LcH77fq5hTEoJZor4nDteXO+
 +Q9t8HA4bYFAEdhxUoMU99a9HgZZnt8lCmH7/CpwizRSDMXFwLNsC2h6eaPpm4HH6eyS
 2sgD5Oud9Ltx49pyFhZG8AJEU69BJes0wFoAaRiVRgu1/hDwDoFYwYu2Bt6WXMVYqb8k
 T+5w==
X-Gm-Message-State: AOJu0Yx1z9nNtKTNLMHthpXqpJtczcKg4jw1/7Ll+rT6Qhs8WRieqyiw
 PJrir+AUMPVLNpz4hHLVdjqJE/+4PABF571RbQTo1vSBXqIPCjgfZJNl32UrsQq2sA/Wm4SfLbQ
 =
X-Gm-Gg: ASbGncsccMqq3mJlc8VTywUEWjW/DWEN+DPZ+wdmS/YCakmfgiIGgVru61Kh1WGeTSK
 KUdP7WiIrsD4m1Sger+qtDK3ON4j1JYu0w+KUgH9wFeCoo6OqwziDPKVE7jraaxBFmfQJTdMx9v
 LJor85vu1S1zNQWRR6+1QwU+3rFdULIOaSrw08pdhDQ8lBaJenpq+P4eSkuC7vwPcfyehWW+hV1
 YC+nMZGvrOX0HfkjAUG55UWjYx3LNFsjSpoqtEBL/MyKnfJ7RKcwVUC4VnsxGJefmc6k/k3JKaE
 L+sefpBUnBY=
X-Google-Smtp-Source: AGHT+IHmcQjL0It5VZ58jd7T8VFjSf+1REDmpBYlbQy+Qc8exKxhGlwNN9UJka5qldX1cMf26VjI7A==
X-Received: by 2002:a05:6602:14cb:b0:843:ec8f:c84a with SMTP id
 ca18e2360f4ac-8447e244110mr1580343639f.6.1733761742431; 
 Mon, 09 Dec 2024 08:29:02 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-844737bc549sm272432339f.2.2024.12.09.08.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 08:29:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Matthew Garrett <mgarrett@aurora.tech>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/8] addr_find: Use a simple lmb allocation
Date: Mon,  9 Dec 2024 09:27:59 -0700
Message-Id: <20241209162801.288363-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209162801.288363-1-sjg@chromium.org>
References: <20241209162801.288363-1-sjg@chromium.org>
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

There should be no need to parse the LMB tables manually. Use the
allocation-function provided instead. Adjust the argument checks while
we are here.

Also enable this command for sandbox and the EFI app, so it is built in
CI.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/Kconfig     |  1 +
 cmd/addr_find.c | 40 +++++++++++++---------------------------
 2 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c8ca55194c0..d4da504bea4 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -130,6 +130,7 @@ config CMD_ACPI
 
 config CMD_ADDR_FIND
         bool "addr_find"
+        default y if SANDBOX || EFI_APP
 	help
 	  This command searches for an unused region of address space
 	  sufficiently large to hold a file. If successful, it sets the
diff --git a/cmd/addr_find.c b/cmd/addr_find.c
index b187337d885..2c20b959031 100644
--- a/cmd/addr_find.c
+++ b/cmd/addr_find.c
@@ -16,12 +16,13 @@ DECLARE_GLOBAL_DATA_PTR;
 
 int do_addr_find(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	struct lmb_region *mem, *reserved;
 	const char *filename;
-	struct lmb lmb;
+	phys_addr_t start;
 	loff_t size;
 	int ret;
-	int i, j;
+
+	if (argc < 3)
+		return CMD_RET_USAGE;
 
 	if (!gd->fdt_blob) {
 		log_err("No FDT setup\n");
@@ -49,36 +50,21 @@ int do_addr_find(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		return CMD_RET_FAILURE;
 	}
 
-	lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
-	mem = &lmb.memory;
-	reserved = &lmb.reserved;
-
-	for (i = 0; i < mem->cnt; i++) {
-		unsigned long long start, end;
+	start = lmb_alloc(size, SZ_2M);
+	if ((long)start < 0) {
+		log_err("Failed to find enough RAM for 0x%llx bytes\n", size);
 
-		start = mem->region[i].base;
-		end = mem->region[i].base + mem->region[i].size - 1;
-		if ((start + size) > end)
-			continue;
-		for (j = 0; j < reserved->cnt; j++) {
-			if ((reserved->region[j].base + reserved->region[j].size) < start)
-				continue;
-			if ((start + size) > reserved->region[j].base)
-				start = reserved->region[j].base + reserved->region[j].size;
-		}
-		if ((start + size) <= end) {
-			env_set_hex("loadaddr", start);
-			debug("Set loadaddr to 0x%llx\n", start);
-			return CMD_RET_SUCCESS;
-		}
+		return CMD_RET_FAILURE;
 	}
 
-	log_err("Failed to find enough RAM for 0x%llx bytes\n", size);
-	return CMD_RET_FAILURE;
+	env_set_hex("loadaddr", start);
+	debug("Set loadaddr to %llx\n", (u64)start);
+
+	return 0;
 }
 
 U_BOOT_CMD(
-	addr_find, 7, 1, do_addr_find,
+	addr_find, 4, 1, do_addr_find,
 	"find a load address suitable for a file",
 	"<interface> [<dev[:part]>] <filename>\n"
 	"- find a consecutive region of memory sufficiently large to hold\n"
-- 
2.34.1


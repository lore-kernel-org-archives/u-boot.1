Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85ACC48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 18:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F3A087E78;
	Mon, 12 Feb 2024 19:41:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jUXJayFq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3191887E78; Mon, 12 Feb 2024 19:41:24 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3471D877D3
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 19:41:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5116b017503so101892e87.1
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 10:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707763281; x=1708368081; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KnXtRqtYIHFo4QSvtMM5piobZ/CxKkbxNdfmlmFR7yc=;
 b=jUXJayFq3hmK1cJLNqcLoKoZBJihrOyFzUxpLhC1XXAsXxHZYdk6s0lNeUeLo+DLtI
 iQnWsIET/hoMuLvNfPpG1kSiFz4RSwCVFcdpkLB9rXEo8nWXwczLbqp60IkDx0czJVme
 a3/tZ6/xefzBBdwy9meZZJcSqXIcq9SpKyhG79cGWCha9dwe4BdJMG51VSa1fSHTQqQF
 KRiglYHo6utGc39e66q/UKFRnC6JA2y7lXM1jSjHjl96U6F9XjYF+0BvC5CNwHBbCd4O
 usKq7y22uGAldohe78qqdl2bYEDMxWARCoeaoNAFOTEr+v1xT1Av+tK2/G0G+ymPzkgc
 EJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707763281; x=1708368081;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KnXtRqtYIHFo4QSvtMM5piobZ/CxKkbxNdfmlmFR7yc=;
 b=T/SKDsg5ppUQvgRAOQbP5REsz7BRJWsH9oVIvvFB9Cs3N8ybx7DsjVFkuv4EBO12cO
 cPjZtd6UL3P2I3rnV3gmcLZZuDNF1FFAartOm60o/Ok33Ue54YwcXVYjOdKpz2ez0diL
 S/v8ow6sx0WMepusRgMsppUi10UYiV+HPsn+ZdcQQZ7je60bY5AX/+daowPRJEOTj9Jc
 +L0roROlFr1nFMUsjSnf9zsyZsUQXUjckE7hOM7k60QKG6A3Q8SkbOxm4I35uTnrHjlN
 tA/h8DV1PmNy29SnSm1VfoHUr+DEqK+m22dylOgiDZqNevthmgBhT33Hdusfoh6EuKps
 7jfw==
X-Gm-Message-State: AOJu0YwwFJm7xf3J/Akv2VDSKxBjGsCkkzAde7QU/d6NiFnKKKnH3NH4
 iEQnA7nKx8pGDIuZK9VQ10STOjgOXFd7UBTy1oIQM1KlcTysyH8Tyi+Wm4fcqz4=
X-Google-Smtp-Source: AGHT+IGs5wF9+pil0ejT3rVwiExbHDScuM8hpEj7NZxHAnhy/lywWzWGE5t9NGohEnXzp8TLhOoTqg==
X-Received: by 2002:a05:6512:3daa:b0:511:3a32:4e4f with SMTP id
 k42-20020a0565123daa00b005113a324e4fmr5632922lfv.18.1707763280891; 
 Mon, 12 Feb 2024 10:41:20 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXjHqhZ5gJDLAu5T2J4IpNBRlvdr0HL2cqM/v0jKIsu6QmHLS+ptbdkTZFn8zR9rVZwDkfyjQe9Cu70mmL3a1qGRHI=
Received: from localhost.localdomain (109-252-14-208.nat.spd-mgts.ru.
 [109.252.14.208]) by smtp.gmail.com with ESMTPSA id
 u8-20020ac24c28000000b0051186a82fc1sm764714lfq.171.2024.02.12.10.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 10:41:20 -0800 (PST)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: u-boot@lists.denx.de
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] cmd: add FDT setup for bootelf by flag
Date: Mon, 12 Feb 2024 21:41:17 +0300
Message-Id: <20240212184117.25641-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
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

Added the ability to use FDT for ELF applications, required to run some OS. To make FDT setup, you need to set the elf_needed_fdt environment variable to a value like y or yes.

Signed-off-by: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>

Cc: Tom Rini <trini@konsulko.com>
---

 cmd/elf.c     | 14 ++++++++++++++
 env/common.c  |  5 +++++
 include/env.h |  7 +++++++
 3 files changed, 26 insertions(+)

diff --git a/cmd/elf.c b/cmd/elf.c
index b7b9f506a5..1ee86c03de 100644
--- a/cmd/elf.c
+++ b/cmd/elf.c
@@ -38,6 +38,8 @@ static unsigned long do_bootelf_exec(ulong (*entry)(int, char * const[]),
 /* Interpreter command to boot an arbitrary ELF image from memory */
 int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
+	struct bootm_headers img = {0};
+	unsigned long fdt_addr; /* Address of the FDT */
 	unsigned long addr; /* Address of the ELF image */
 	unsigned long rc; /* Return value from user code */
 	char *sload = NULL;
@@ -68,6 +70,18 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	else
 		addr = load_elf_image_shdr(addr);
 
+	if (env_get_elf_need_fdt()) {
+		if (argc >= 1 && strict_strtoul(argv[0], 16, &fdt_addr) != -EINVAL) {
+			printf("Got FDT at 0x%08lx ...\n", fdt_addr);
+
+			if (image_setup_libfdt(&img, (void *)fdt_addr, NULL)) {
+				printf("ERROR: Failed to process device tree\n");
+				return 1;
+			}
+		}
+	}
+
+
 	if (!env_get_autostart())
 		return rcode;
 
diff --git a/env/common.c b/env/common.c
index 48a565107c..8cd8558c3f 100644
--- a/env/common.c
+++ b/env/common.c
@@ -346,6 +346,11 @@ bool env_get_autostart(void)
 	return env_get_yesno("autostart") == 1;
 }
 
+bool env_get_elf_need_fdt(void)
+{
+	return env_get_yesno("elf_need_fdt") == 1;
+}
+
 /*
  * Look up the variable from the default environment
  */
diff --git a/include/env.h b/include/env.h
index d2a5954ded..384c312d2e 100644
--- a/include/env.h
+++ b/include/env.h
@@ -148,6 +148,13 @@ int env_get_yesno(const char *var);
  */
 bool env_get_autostart(void);
 
+/**
+ * env_get_elf_need_fdt() - Check if FDT is needed for ELF image
+ *
+ * Return: true if the "elf_need_fdt" env var exists and is set to "yes"
+ */
+bool env_get_elf_need_fdt(void);
+
 /**
  * env_set() - set an environment variable
  *
-- 
2.39.2


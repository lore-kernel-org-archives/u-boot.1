Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD19C48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 13:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD7B987EBE;
	Mon, 12 Feb 2024 14:19:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j6VEhtzj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 371CD87C77; Sun, 11 Feb 2024 21:42:56 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3961E878A1
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 21:42:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5116588189aso4584436e87.1
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 12:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707684172; x=1708288972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tqI/b86K1BGyyYGqMZEyvDrduknETmz2kqpZEnmlS9o=;
 b=j6VEhtzjDxjERf1uSXT9M9/3lse/8grGEwKNkR2btNmAr2ihznvALYsWE3LnKs5sdT
 NOo0ZaAk4F1c5b32iTWFMrutzUV8ueDzIp40dUlGTIswVqt5NoFA6BHBbCZxbBfct6mp
 QGXY3Kmdvwnr0wfuW0KjLa/qrP5/WP62ooc+RkBb6FmkdRcAt06Pp7Ya2yP6OdkEqUCC
 vgDJnZir21jPC4x1G/wz5pU+vWmDFFHGIiIIB3i7aKpYEdBy580d/jxdtLQh7CfWRVEF
 bncNHvN1qkJFmYxh3PVpd+TNpYIVgSm+dSKlUydfptKpPMRTT1SPynRjR5FFudN31hg9
 +Cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707684172; x=1708288972;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tqI/b86K1BGyyYGqMZEyvDrduknETmz2kqpZEnmlS9o=;
 b=oj+2x1cJHC9iiw8JRBF1NZ/YeFgPZje4ah4qTny0uh0Q/8pE/mjkRBwhXZ9/9Tyovd
 BdseN72bsfublxhBie8sIb98WgzctLD/wWlHFSoFSf4eE8RdQIBg/Rpq6hLFuxjRclyA
 mmj4jFNEXS/QWi7yCI2UC+YIuzvudes1wTijUcdVN07a+H6j+Um9ExUqtUc+3sjDC+Pw
 lEwTkctuUtJukG+5ldpP6sM9ZmV+1qV1aSgmiX0sWCu7lRaDlpzo0OBOl2Q3w4GcYYzb
 SMfUEsZXsKNCH7hDb81/UmoqZzXYpCMctCSqwPSqRpO6JegXAalC5Kmq2HH4uRybhmEI
 SiSw==
X-Gm-Message-State: AOJu0Ywrpf3HOx9DVePj8RHbnWsjAl7dg240nauRCOkt9TS6deKMPKIs
 Fz37sUch2Az1Di0QOsUdxWu0YtrlePK6CsTuj/PAWVDGBRF6uiUdIWEQjjBV
X-Google-Smtp-Source: AGHT+IGS9Z+9EvBK7clYw1rdONEMNqFUkQaCUBdTePOPVvE6mNLTbmoiXq/Ew1oGUzXRtLT7cWk7WA==
X-Received: by 2002:ac2:44dc:0:b0:511:6077:c99c with SMTP id
 d28-20020ac244dc000000b005116077c99cmr2910631lfm.30.1707684171543; 
 Sun, 11 Feb 2024 12:42:51 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUQq7D//uwCbVvani2zbqltcjJBsu8eeZhaWxI2TIIs+37OX75bZpT9+MtL0/1I1HbNGeH2oesyXCphaiiAsnbCCUk=
Received: from localhost.localdomain (109-252-14-208.nat.spd-mgts.ru.
 [109.252.14.208]) by smtp.gmail.com with ESMTPSA id
 u1-20020a056512128100b005117583a519sm615607lfs.180.2024.02.11.12.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Feb 2024 12:42:51 -0800 (PST)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: u-boot@lists.denx.de
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] command: add FDT setup for bootelf by flag
Date: Sun, 11 Feb 2024 23:42:48 +0300
Message-Id: <20240211204248.273295-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Feb 2024 14:19:09 +0100
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
index b7b9f506a5..4d365771eb 100644
--- a/cmd/elf.c
+++ b/cmd/elf.c
@@ -38,6 +38,8 @@ static unsigned long do_bootelf_exec(ulong (*entry)(int, char * const[]),
 /* Interpreter command to boot an arbitrary ELF image from memory */
 int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
+	unsigned long fdt_addr;
+	struct bootm_headers img = { 0 };
 	unsigned long addr; /* Address of the ELF image */
 	unsigned long rc; /* Return value from user code */
 	char *sload = NULL;
@@ -68,6 +70,18 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	else
 		addr = load_elf_image_shdr(addr);
 
+	if (!env_get_elf_need_fdt()) {
+		if (argc >= 1 && strict_strtoul(argv[0], 16, &fdt_addr) != -EINVAL) {
+			printf("Got FDT at 0x%08lx ...\n", fdt_addr);
+
+			if (image_setup_libfdt(&img, (void *)fdt_addr, 0, NULL)) {
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


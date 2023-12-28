Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C528C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 09:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85DB9879F1;
	Thu, 28 Dec 2023 10:03:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RKYkHqMX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DE93879DC; Thu, 28 Dec 2023 10:03:07 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64993879C8
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 10:03:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ccc34a9f90so29425861fa.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 01:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703754183; x=1704358983; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jaHvsjtpDzK9FBYE5jfrGcsPZoyhsAlq6tHypH1CgXs=;
 b=RKYkHqMXhX3qMObTCWt9ntoEHc55H/JU5i89x3ZXrwpoYK6y4Wu6wiEl3rMnZwD3MI
 7Cyc1PJ7a/wjsjXpHwHG+Mol2R0/IBbMusD1MhUFECxBhAvV7eVHUHhI4ss99K9Z3rIz
 yhYrVE1fsKYc7ARonLrrxQGqCVH5lBKdMG1suRqJuzJI/emWWTdWnQySM8fgNBfK2XOX
 1+cWlfQH380SfIrSUrikONTjjXDih/P56rsYrUkur10F3xaHHxqR9zgKgNImoInl++u5
 VubFq8abo5X1v9kFqT4TAvYkkbwWN4QKNo92mPBAJ+fIqNQgLytD6lEfA/oLHf/6+z/P
 KfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703754183; x=1704358983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jaHvsjtpDzK9FBYE5jfrGcsPZoyhsAlq6tHypH1CgXs=;
 b=XFK2hxtoL9fsLOasbTJqsF+2c8K7dyNAWOraeThT0gSQDKAsBsFlLFie7xx9hVFetm
 S7sHvm+TS+LxAzdQZpUmJbYpdJu6e/u5Cdv4IWst+FtMDM+CBA2P3e3fKv3USwtIfOVB
 q/AeYwDRk/I4spMC1MHtE63ntngRsHkcBQf0P3KuJMutsyImJ/bYgf3N19W+gwA/r+0Z
 w5kquZbHraJFjJZdTcD8SdGyt948Jm20lwiNb2dlopJHPj44MnwanwTIfMdTAyNxHYfy
 HKYCnBlPmHtlBfAyNM0fJAODF8L8rOgeOK4PrAzIkiz6P9z2N/ddzTzXJEurudHqgVlL
 aFcQ==
X-Gm-Message-State: AOJu0YxQT3vmKUIErm88wvEq/6HkdKM4l/6KqHJBbhDrIiD2uomFpVV1
 cNtTqAxBmdAZfnWbIW7681A=
X-Google-Smtp-Source: AGHT+IGwTYVGEQxAdjWsR9d33Yrmb+b8sKl2+4ogyQb5M1xUu/fC3rHw6IBYH32fc6xiDXL+h9xawg==
X-Received: by 2002:a2e:9dd8:0:b0:2cc:8bd4:b860 with SMTP id
 x24-20020a2e9dd8000000b002cc8bd4b860mr4327993ljj.85.1703754183625; 
 Thu, 28 Dec 2023 01:03:03 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 n18-20020a2ebd12000000b002ccabe13852sm2475708ljq.85.2023.12.28.01.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 01:03:03 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, Heiko Schocher <hs@denx.de>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v5 4/5] lib: membuff: fix readline not returning line in case
 of overflow
Date: Thu, 28 Dec 2023 11:02:39 +0200
Message-Id: <20231228090240.18011-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228090240.18011-1-clamor95@gmail.com>
References: <20231228090240.18011-1-clamor95@gmail.com>
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

From: Ion Agorria <ion@agorria.com>

If line overflows readline it will not be returned, fix this behavior,
make it optional and documented properly.

Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 boot/bootmeth_extlinux.c | 2 +-
 common/console.c         | 2 +-
 include/membuff.h        | 5 +++--
 lib/membuff.c            | 4 ++--
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index aa2a4591eb..ae0ad1d53e 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -82,7 +82,7 @@ static int extlinux_fill_info(struct bootflow *bflow)
 	log_debug("parsing bflow file size %x\n", bflow->size);
 	membuff_init(&mb, bflow->buf, bflow->size);
 	membuff_putraw(&mb, bflow->size, true, &data);
-	while (len = membuff_readline(&mb, line, sizeof(line) - 1, ' '), len) {
+	while (len = membuff_readline(&mb, line, sizeof(line) - 1, ' ', true), len) {
 		char *tok, *p = line;
 
 		tok = strsep(&p, " ");
diff --git a/common/console.c b/common/console.c
index 833da61733..bc3401d5a4 100644
--- a/common/console.c
+++ b/common/console.c
@@ -849,7 +849,7 @@ bool console_record_overflow(void)
 int console_record_readline(char *str, int maxlen)
 {
 	return membuff_readline((struct membuff *)&gd->console_out, str,
-				maxlen, '\0');
+				maxlen, '\0', false);
 }
 
 int console_record_avail(void)
diff --git a/include/membuff.h b/include/membuff.h
index 21051b0c54..4eba626ce1 100644
--- a/include/membuff.h
+++ b/include/membuff.h
@@ -192,10 +192,11 @@ int membuff_free(struct membuff *mb);
  * @mb: membuff to adjust
  * @str: Place to put the line
  * @maxlen: Maximum line length (excluding terminator)
+ * @must_fit: If true then str is empty if line doesn't fit
  * Return: number of bytes read (including terminator) if a line has been
- *	   read, 0 if nothing was there
+ *	   read, 0 if nothing was there or line didn't fit when must_fit is set
  */
-int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch);
+int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch, bool must_fit);
 
 /**
  * membuff_extend_by() - expand a membuff
diff --git a/lib/membuff.c b/lib/membuff.c
index 3c6c0ae125..b242a38ff1 100644
--- a/lib/membuff.c
+++ b/lib/membuff.c
@@ -287,7 +287,7 @@ int membuff_free(struct membuff *mb)
 			(mb->end - mb->start) - 1 - membuff_avail(mb);
 }
 
-int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch)
+int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch, bool must_fit)
 {
 	int len;  /* number of bytes read (!= string length) */
 	char *s, *end;
@@ -309,7 +309,7 @@ int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch)
 	}
 
 	/* couldn't get the whole string */
-	if (!ok) {
+	if (!ok && must_fit) {
 		if (maxlen)
 			*orig = '\0';
 		return 0;
-- 
2.40.1


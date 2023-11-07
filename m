Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB61FC4167D
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 12:43:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEF8B8743F;
	Tue,  7 Nov 2023 13:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nZ+YWhVL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 717AC87448; Tue,  7 Nov 2023 13:43:09 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 565848743F
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 13:43:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5435336ab0bso9678337a12.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 04:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699360987; x=1699965787; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fLmHwipGg8wR07EMwguuraU2PWbbtdT7OIRNLjU7Lic=;
 b=nZ+YWhVL1cQBVDUTH7g2Pbs5GowPQYIw0vgL7t2i2C+D7VyTuRdv/6/8pYjqsMR8XE
 HC/uPdjb5hxNeRsv2rDYUZ+a9/sjaPlCqaQSWTUde9C+xOZE1EyK+kXZeVYkpHdBjpjP
 4Lyv/E4AjcHxcKAGfdHjdVYYwC5uBjjiriVPK6hFJrZqi0CQXZoLDux0Ehvulh2wXW02
 h63YCLKTULzeqGUHBzwq7ZeQ1v76+IyxauU09oPVKNcvrBloS7hd0JRz0K5E9kM+txRM
 xgdewMUqrToyg5X0ghjLWH4sAduZdA3XBfJEHG5/p5kFWmeef+8TLRIuFhnHufuED4op
 ia9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699360987; x=1699965787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fLmHwipGg8wR07EMwguuraU2PWbbtdT7OIRNLjU7Lic=;
 b=UbXDmOoWc5jmY+GgqZxEonvIQtypm9e3jNI2JXInJx3O3782qmqKfKJ0Pi2Tza8leE
 +ATSMavr2XWukUXJ9lbkdcDT+LgZuqEAfY3Thdhrn7f+byVYmxT30MJcDgZyQgkLWuaq
 oybl/CFcRXWwucx+5IgIJ4IBxn8H/Ai+Yva3D+193OSkF15NaX4m83F6SRgzAOebGSdl
 zclkRWvpCPMhUdj9sYeHIDIBnZ0c2+jmXn5HEt3Dxl31NL4/SZ/qsrp40ti7hM3+pUuB
 TkFl5zLpMUhwciNh5RhdLT9iMuOz7nGQtQ2ygJ6rlAgpEE9u6+3zIgh8rOqZhxnvShI2
 6LGQ==
X-Gm-Message-State: AOJu0YwKIarJcLmnhIwLHSYsWJdNDgnUgfbErFzu67Kfg2R5SPDS7P++
 SRENwLHDNkMMbKvrXtdVwtQ=
X-Google-Smtp-Source: AGHT+IE+TiyKgBSwRtd0+VyXhbv+Iz/TO6/ncknEmNjBh8pqokeXnXV40FBvv2byUjscUWjPWVIabw==
X-Received: by 2002:a50:bb09:0:b0:542:d69d:d075 with SMTP id
 y9-20020a50bb09000000b00542d69dd075mr21351188ede.6.1699360986669; 
 Tue, 07 Nov 2023 04:43:06 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 u16-20020a509510000000b0053e89721d4esm5481831eda.68.2023.11.07.04.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 04:43:06 -0800 (PST)
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
Subject: [PATCH v1 4/5] lib: membuff: fix readline not returning line in case
 of overflow
Date: Tue,  7 Nov 2023 14:42:40 +0200
Message-Id: <20231107124241.35432-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231107124241.35432-1-clamor95@gmail.com>
References: <20231107124241.35432-1-clamor95@gmail.com>
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
index 8a869b137e..cd56035171 100644
--- a/common/console.c
+++ b/common/console.c
@@ -846,7 +846,7 @@ bool console_record_overflow(void)
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
index 36dc43a523..964e504d5b 100644
--- a/lib/membuff.c
+++ b/lib/membuff.c
@@ -288,7 +288,7 @@ int membuff_free(struct membuff *mb)
 			(mb->end - mb->start) - 1 - membuff_avail(mb);
 }
 
-int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch)
+int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch, bool must_fit)
 {
 	int len;  /* number of bytes read (!= string length) */
 	char *s, *end;
@@ -310,7 +310,7 @@ int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch)
 	}
 
 	/* couldn't get the whole string */
-	if (!ok) {
+	if (!ok && must_fit) {
 		if (maxlen)
 			*orig = '\0';
 		return 0;
-- 
2.40.1


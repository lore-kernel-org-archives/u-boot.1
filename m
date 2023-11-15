Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F77C2BB3F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 15:39:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59B7F8745E;
	Wed, 15 Nov 2023 16:39:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EbqYJ4QC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C58168744C; Wed, 15 Nov 2023 16:39:05 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E74DA87446
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 16:39:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9d242846194so1017582566b.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 07:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700062743; x=1700667543; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fLmHwipGg8wR07EMwguuraU2PWbbtdT7OIRNLjU7Lic=;
 b=EbqYJ4QCBxkz9s3EZGVw/N08UY2KfzV2Iy4CDY2rSF7aRwiz9abJk4Jo1AM+fQ2H6y
 rUMfBmyCYZoOpNQ5p+xsYLevsVozW9drueHon7VlgdzU5joSJ1PKQCfZcd/b+f/RsK3g
 b2D5LYU6nFakz+hza/j70yIPim30gEaTPQCP3S/7g/tIUKZ1jfqpw7Gq/zTUz5kmwa3X
 wSO1nH/fBmvX71NTmwu4Sb6rPjl/y4HUb9kjmXjB46vRwohS+L5vAgnlu8AZF2w/+erf
 LVH3rX5rH1dlJfVOq5sS5w93aEvLI+cu6Tz2c/0E128Fjn0I+C1xDLvngTUpGu/3DV/8
 vUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700062743; x=1700667543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fLmHwipGg8wR07EMwguuraU2PWbbtdT7OIRNLjU7Lic=;
 b=mdZhAArwYUk/plAIjuUHUj9iUzFImy2d5RVaTmIR8hJKA9ZtLxBy99uZdEi38dWXwK
 /mlyFWTmqGawv4SfN9K08nXzT6d9VjqwluOfd0GiMb9ORVhYoZ8jCbr8z/6SnlrId6o1
 pO3SgE5tEZwuaSmn8sYRmlfV3DNo5pc9NP1LLf2eOOGfO4wUZSd6R2mE8EolsDwqYdLz
 LteKUVqw9BHIivDYtQaVxFCE5Xo9eWMAPlq7Vs3aA0uT3zsYgCQkVEuD5ksPbNnsc69Y
 eqEv8ekV/RcLcciwp4bf01haFlqO4dLSd4N6o6TTa56pkSZDEe0FdLARBZDtJZ4rbL7a
 8buA==
X-Gm-Message-State: AOJu0YzV5PMBqcQAfLAZ9NXjwN5vzh9iNEa5VUaAY4EbI6wvKxYQzWNJ
 daTMQnx6uRIT+TCiCYTEVGo=
X-Google-Smtp-Source: AGHT+IFJfWgt6u5e8Ni8Z4jGpHtf2RWSXj83yeKwU69h/+g07Rm3pSWFLhF2UPeBbR7oMGInQ/zpug==
X-Received: by 2002:a17:906:a44e:b0:9e4:6b68:fbef with SMTP id
 cb14-20020a170906a44e00b009e46b68fbefmr8708282ejb.60.1700062743453; 
 Wed, 15 Nov 2023 07:39:03 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 u10-20020a170906408a00b009e5d30422ebsm7234033ejj.101.2023.11.15.07.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 07:39:03 -0800 (PST)
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
Subject: [PATCH v2 4/5] lib: membuff: fix readline not returning line in case
 of overflow
Date: Wed, 15 Nov 2023 17:38:35 +0200
Message-Id: <20231115153836.16537-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231115153836.16537-1-clamor95@gmail.com>
References: <20231115153836.16537-1-clamor95@gmail.com>
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


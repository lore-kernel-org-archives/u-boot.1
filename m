Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF97C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 18:36:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C80C875FD;
	Tue, 21 Nov 2023 19:35:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BBL5PcR/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C25DB868BF; Tue, 21 Nov 2023 19:35:40 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8AB087258
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 19:35:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50aaaf6e58fso4136963e87.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 10:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700591738; x=1701196538; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/DMnQEvkP2mdilMfdlaNkpYT76OCkE/EAzWrxlZDr8=;
 b=BBL5PcR/qLh6vX85207D+u5+9b462tWPueyJKiaDOZoiq+0zEcPtXqVvUh1ZDe/zef
 9hyKRTZZ/Kt7xI6Ic0mFzgQ9o2/j9Jad7QMX8fR6l763A9aiRtnBvfuGGvmhLJ3fFhTN
 HwcT4fKyHg8mIwGA9BoTa7/vAv+Rz1ov/ykCpO8IvkRPs28x9Vgk0NNz4J19mE1idF6J
 CuYIc4MyuhgRIyHKPeiLMMT1VJX3OAkH6/QKQ9g/Y4/8MxBfPvhr8vAZPd1qmY8ryOg6
 hdvmMnzufwFYGx28IAxLRyqQexEC9nZBoqEoeq9HnH1ie4vgYdubxogRH3E8xw+4YL9P
 eQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700591738; x=1701196538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h/DMnQEvkP2mdilMfdlaNkpYT76OCkE/EAzWrxlZDr8=;
 b=j9XVTWc8QtVVpmbA/ZtsMd12igfXSf+9FMmPxLKMsoJP7pohv3LLB00LgrNxQ+sAKK
 xIkOJOrIFocxtYhSFDHB/2wT9bbB7kxzK95/Zo9DQ9CY/CG/FNcjr50iytbl3bwqiz0A
 XnCirfwfywcnUJpR2xSSxWhdOyxJVKvlgcnRVOe1l5pzrgGiD5/xZhx+n6lIdTFetgA3
 RHufhVqoHURzmGGKBDDlXESejOddCooeUT0/nqhC//ERG9j5PYePRWyyWKm/UpTuXz8y
 Hm4FEHyOnH6EXW/gSyo8el68zd21B0ZDitnpHi8V5LUNyXMFSNmxyA330CHGayn+3oFl
 VIbw==
X-Gm-Message-State: AOJu0Yykwlcj+kfa0iaSxWPcVLNZBPCiGBqxD+tJOZvR0CZtjLHuHUOi
 V2bYSYbxiPFLG8sJ2zzZJR0=
X-Google-Smtp-Source: AGHT+IFAOiPCvG0khbv5vmEdXjDCSIJx0xQ/1vMtxkM3oAd5uTmVkeOeZjYLc09A5C0cdpeWuwWjGQ==
X-Received: by 2002:a05:6512:3d8a:b0:50a:a6d2:b5cd with SMTP id
 k10-20020a0565123d8a00b0050aa6d2b5cdmr49395lfv.53.1700591737878; 
 Tue, 21 Nov 2023 10:35:37 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 a22-20020ac25e76000000b0050089b26ea1sm1592862lfr.276.2023.11.21.10.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 10:35:37 -0800 (PST)
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
Subject: [PATCH v3 4/5] lib: membuff: fix readline not returning line in case
 of overflow
Date: Tue, 21 Nov 2023 20:35:09 +0200
Message-Id: <20231121183510.6451-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121183510.6451-1-clamor95@gmail.com>
References: <20231121183510.6451-1-clamor95@gmail.com>
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


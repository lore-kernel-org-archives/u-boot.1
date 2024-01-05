Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8637C3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 07:23:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F97D877AC;
	Fri,  5 Jan 2024 08:22:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gAp09nUH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D50178793B; Fri,  5 Jan 2024 08:22:43 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 245FE8793B
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 08:22:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-556c3f0d6c5so1569699a12.2
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 23:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704439360; x=1705044160; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jhRsT3QaeHTYMTDPAyb6t52Hz6N4o/Q4q1p457fk69c=;
 b=gAp09nUHxc4PadFkiOUAZhF7hoOcA8VZNkTCUOXu89WVzrQ9/3jai9SOpmjD1V4Xw8
 E1k8eq6f5Zp4kzs8d5+17JrJ8vO9qnaQvW4oR5Cypa/uS1BgRQB5jL/uw6L/0U6w47Xn
 WDakMMFkWJOAOkq1K5JzgzcpzdNaYiYrmutkRLBNzV6lMQCutkCfdeAtNI//Lb7yyaWS
 JABtdcaGK093v42GLndl7t0D7drbAPPoFnZNoNSteowMFYTj25o/m4HfH/nnkZtNTLMh
 0XLIdS9PI2W/241XPZUZHnx+CDrY1IL0tlOnkUpypMnnOIbt8tJbgBmt2EwP2jX8qgUC
 udwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704439360; x=1705044160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jhRsT3QaeHTYMTDPAyb6t52Hz6N4o/Q4q1p457fk69c=;
 b=HC+E8ZGLdr3fGHyHVsVf5PkSanGK4Ip8O1WxpwETkovx8xyZ6pIarrp8YfPkGiY/Fo
 Su1anTKK8bTBK8JDAVT5aSW0ybE3WGkXL8S6OYDiPd3jE6bnj/4DRpMyietdSXTpB9Ku
 ZIiY9cZcS//FFlkM9aJWvGKuxVr7/R88vz0WXVG/NUK5al1Oq9ygZE5SonGN/cjtm0yA
 Wmrl7v7RnGLO+E3vKRCoJsGef2CT2jAvCJazR6wcCs2MRHIksF9NY4F8/a4WqW1URz6I
 KaIkYESXin0N39T6QVW0k1dt+FLw4u6GQNZIhHFxY18wFnyPniEW6Vgr+FEMb/Yd2AH7
 66Gg==
X-Gm-Message-State: AOJu0YyAgqPPALfYaArWH10zkk15TxGVsJJQxhcr3sZBOmyJaUdKWLRI
 XZV1+FB4W+4QP99AnrxMK2w=
X-Google-Smtp-Source: AGHT+IFhcvQnGpxWCDRXm0Pd2jgKB6eatME/6xKAeP47mX5b2uR2vdg+gfyBF72ko7tRMS1JldgEUg==
X-Received: by 2002:a50:b411:0:b0:557:34a4:6be9 with SMTP id
 b17-20020a50b411000000b0055734a46be9mr67570edh.83.1704439360543; 
 Thu, 04 Jan 2024 23:22:40 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 dd5-20020a056402312500b0055627eeb8b9sm636471edb.32.2024.01.04.23.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 23:22:40 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, Heiko Schocher <hs@denx.de>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v7 5/7] lib: membuff: fix readline not returning line in case
 of overflow
Date: Fri,  5 Jan 2024 09:22:10 +0200
Message-Id: <20240105072212.6615-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240105072212.6615-1-clamor95@gmail.com>
References: <20240105072212.6615-1-clamor95@gmail.com>
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
index e6d7ebe935..cad65891fc 100644
--- a/common/console.c
+++ b/common/console.c
@@ -848,7 +848,7 @@ int console_record_readline(char *str, int maxlen)
 		return -ENOSPC;
 
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


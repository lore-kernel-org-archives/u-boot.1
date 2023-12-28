Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9834CC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 18:03:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2618287A4B;
	Thu, 28 Dec 2023 19:02:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WuJxDc6J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E26087B40; Thu, 28 Dec 2023 19:02:24 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBC2E87B3F
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 19:02:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50e7b9cca2fso3255834e87.3
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 10:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703786541; x=1704391341; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jhRsT3QaeHTYMTDPAyb6t52Hz6N4o/Q4q1p457fk69c=;
 b=WuJxDc6JhmpicPm2czpQENLBMBhfBytoou7VGdRqRve6zEI8YsI3BJZzKthDDM1xJW
 6xgNsKxQYCXEGv6MMXZPmp+nTYkLviotNA6LAqkk0BlAqv9aFntLiVtByc4wiQ80V5m3
 ZUf3ccb0hiMt0QkRMw8S0GT7rdIrdgPAA3LSunjKHYfHJsubcsxBxrim6mNAPZceaA2d
 vOgYKiY7jQcSSvmcjtgkula5ZVCwzHDAQLl2RmmBm/6aTYDeul97VlQ5+A+NT5UGhHEG
 Bu9CLZbFML/fwL7mVr9ocPtw8BJAmiarnls3XFy+ak4CKwKyg0ZB6pRLzc6Gpw/lGzcX
 kK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703786541; x=1704391341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jhRsT3QaeHTYMTDPAyb6t52Hz6N4o/Q4q1p457fk69c=;
 b=EZrLs9zefG/QKJSsJnq/MNaf59zMy/LvChEZq2WdMExQYeWLUeba63LABM6A6FmQ6t
 PsQ3Rbe5qWEK1SKTnu+6hwo5ImRlP0UFLohq58po+TD0ZWDZACQNat+vYUEZnBBP0BAk
 UgqdiGw2ef+bSWuIWxdU0IWQIBfyl7dt6JpzsXqNgYsCwOrJMbO2bqop5SGyW+oH51Eg
 OnAERQV2CkuxUIOUviG0xtYlEIlsyOC9WbN9D0GfudQVBcx5F+Pj7Si9AG8rT/KcX75J
 dIsEq1zTDs5Z+jd7KwEf0A6nKgi4WhW59Nus1eOXiZ4m3zIS2inrK9Aa7Ok7EJk2hXl2
 UhZQ==
X-Gm-Message-State: AOJu0YxjS+FnoVK3If0KHsxD8FvQYOA6Aw7ZkgPSZYX5fRd7Avt8HThY
 9A8/pHLDl7ckox2jb7vR0e0=
X-Google-Smtp-Source: AGHT+IEim89/3x65E9uSIfxfmDZ5VFiHF6JUaE17TnjTX4hnwxRjCkSjzXNhM39yfk2bCjcVA+NKVg==
X-Received: by 2002:a05:6512:e98:b0:50e:7b20:3df3 with SMTP id
 bi24-20020a0565120e9800b0050e7b203df3mr2916894lfb.76.1703786541007; 
 Thu, 28 Dec 2023 10:02:21 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 s4-20020a056512314400b0050e6b04a5b2sm1955101lfi.251.2023.12.28.10.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 10:02:20 -0800 (PST)
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
Subject: [PATCH v6 5/6] lib: membuff: fix readline not returning line in case
 of overflow
Date: Thu, 28 Dec 2023 20:01:53 +0200
Message-Id: <20231228180154.50473-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228180154.50473-1-clamor95@gmail.com>
References: <20231228180154.50473-1-clamor95@gmail.com>
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


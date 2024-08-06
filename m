Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C63C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8739588AB8;
	Tue,  6 Aug 2024 14:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NknRuaub";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 012AC88A82; Tue,  6 Aug 2024 14:59:45 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1043D88A56
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3737dc4a669so1983775ab.0
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949175; x=1723553975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ua6e5kbrEag2e5cghMYSydEZEroalpBd0JJyYQh+jjk=;
 b=NknRuaubUQ+Ee8ElWImMgtXQ/Rjd1IFGOo0perP9cz7gTxACWrMhWE8SP9ljZheyt7
 fHJyVSqRj05fRJExk5hitQzntU0wst5M/iQUjOqIg6ozuXCvBEwVOdTAy+Z5jayPWeqr
 pWc5XQblAv6q6s+cXkR4Yw7BF1Lf5HF9MLY5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949175; x=1723553975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ua6e5kbrEag2e5cghMYSydEZEroalpBd0JJyYQh+jjk=;
 b=u2WuAOEI8WpI7oiqpzVLb51v86g7SloplGx5ZKloA8r3rKmINBeuqyQ5b9U65he8Ia
 0mQoj2gbrmugOhpkGYrAPDnaiFsET3edkPrN9KZnqvHNpQ0sQbdPk9kVB/9c/sJe9DeQ
 aV92BMWGjczN1woVCfMydSpxnecneCPwXCAR4TsGRXKKFHvE5YiLdvwNj/wormcHdpQc
 sJnEbhyfm884IllqBm5ObtWF9p79doKc7PLbt2LToa6p2lIGU5vV6/AMPG/M8TnqjKsp
 6HueRizgY0Nb0ZHjvFJooBqZsWzjpUPxlmfpFYYHxfyjFkxQkMOU4BkZUcVL9JiWy3v/
 8l6w==
X-Gm-Message-State: AOJu0YzrajmTtqcFgM8AYgEwYp/koQIYma2paLvHwttFqwNq1hXmywid
 pln3Sr8Ligy6dbhwcccYvTqKIny68ajKv6TQHGrj/Any+X3ZbQLzex9Kkryr2Xt+EIgVjcL6K2Q
 =
X-Google-Smtp-Source: AGHT+IFDAh1D1n+8qIN/yThNMLArD9UP+IgGBb6TIF3h7ESQ7uLoaHuZZXuJw5Gbo9xSLp37oHuppQ==
X-Received: by 2002:a05:6e02:1b04:b0:398:a2e0:18dc with SMTP id
 e9e14a558f8ab-39b1fc251f7mr196912425ab.17.1722949175113; 
 Tue, 06 Aug 2024 05:59:35 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 19/39] read: Use map_sysmem() with buffers in the read
 command
Date: Tue,  6 Aug 2024 06:58:30 -0600
Message-Id: <20240806125850.2316956-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125850.2316956-1-sjg@chromium.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
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

The current implementation casts an address to a pointer. Make it more
sandbox-friendly by using map_sysmem().

Rename the variable to 'ptr' since it is a pointer, not an address.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/read.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/cmd/read.c b/cmd/read.c
index af54bd17654..8e21f004423 100644
--- a/cmd/read.c
+++ b/cmd/read.c
@@ -20,7 +20,7 @@ do_rw(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	struct disk_partition part_info;
 	ulong offset, limit;
 	uint blk, cnt, res;
-	void *addr;
+	void *ptr;
 	int part;
 
 	if (argc != 6) {
@@ -33,7 +33,7 @@ do_rw(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (part < 0)
 		return 1;
 
-	addr = map_sysmem(hextoul(argv[3], NULL), 0);
+	ptr = map_sysmem(hextoul(argv[3], NULL), 0);
 	blk = hextoul(argv[4], NULL);
 	cnt = hextoul(argv[5], NULL);
 
@@ -48,13 +48,15 @@ do_rw(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 	if (cnt + blk > limit) {
 		printf("%s out of range\n", cmdtp->name);
+		unmap_sysmem(ptr);
 		return 1;
 	}
 
 	if (IS_ENABLED(CONFIG_CMD_WRITE) && !strcmp(cmdtp->name, "write"))
-		res = blk_dwrite(dev_desc, offset + blk, cnt, addr);
+		res = blk_dwrite(dev_desc, offset + blk, cnt, ptr);
 	else
-		res = blk_dread(dev_desc, offset + blk, cnt, addr);
+		res = blk_dread(dev_desc, offset + blk, cnt, ptr);
+	unmap_sysmem(ptr);
 
 	if (res != cnt) {
 		printf("%s error\n", cmdtp->name);
-- 
2.34.1


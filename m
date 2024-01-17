Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E16C47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 10:56:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ED5287B50;
	Wed, 17 Jan 2024 11:56:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ov3UF9Up";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C74387B4B; Wed, 17 Jan 2024 11:56:31 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 832AC87B4B
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 11:56:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50e78f1f41fso11585309e87.2
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 02:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705488986; x=1706093786; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x9X6026JBfiegV/hgDAF4kbA3ZOVBqbeSgn11BjN6Qk=;
 b=Ov3UF9Up32o+4udq5elcS2me0Y6zJTP3NdEkyA1HwVSfbqaojlpG5N+lXkKESLdFQ7
 bOHaoXmu1jEK27he/YHVD12hb1M+X3yKzD5C+Isu/SZAIgNgkv4jHPMQJAtdo1iL14tS
 su2CsbNdlWaBmvoO526Y+brQ0y4WmebERQN56EwIlZNW65VDPUdHo4ErqI28zb21Nc5m
 gFQ6dgkF30Cb6JP7Q5WWjsXNU9TbpF4Pb/MYq034LC0DkvdeXgbSwpTjpePQqOgwXKnB
 ybWoxdev7eR9hLBttXg75wDkF05+b/62HUoRlNw4ig18u9zuKUUyytaVq99zEnwfvXYM
 OyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705488986; x=1706093786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x9X6026JBfiegV/hgDAF4kbA3ZOVBqbeSgn11BjN6Qk=;
 b=nSnh5VrcgryymQtlX5Whc0f7fRZ4hXxzJJHXU7PWmM+LISSj2J50bvUgqIPdOJQBmk
 lalJLGpOQV6Ie5IexCeRhCmvXzKIDoTc9U6kLc695rIhmRGqH+8dvn1f4OqfRpOIEppb
 TEHXQQUfbTvDpqga6M3kNKYp0AxeueuzTk4d0K5emAJm8snusTY7ZRlxTjB+HxG9qOZL
 xYe7MAzF9IS6Cqe4P70FvDVobbwu5b9EHtlx3EC+/9hmwL9CvxSv0gSgFQFl6rV2Cr3h
 Znf9y7d+KrAsU7XJTW3WEQp9ra6+gDQ9pmVEXtz86JNk4UqTJN6X3YLo44QWrq63V4qI
 s6qw==
X-Gm-Message-State: AOJu0YzfrobWhUB9w0JKPo3yq1Vxd8K1seUoWdG2TbhbWYIbsa11+mCb
 V9RQDKY0ytzgLyXHpS+qPJg=
X-Google-Smtp-Source: AGHT+IFqox+hrfE+FgixDTGLfc7Z5Pprn3Db37bYLxBaOJaCs/lJ7EtS4jfAkMGUcFmpDLLhxsMcCA==
X-Received: by 2002:a05:6512:131d:b0:50e:eab4:2952 with SMTP id
 x29-20020a056512131d00b0050eeab42952mr3740491lfu.58.1705488985533; 
 Wed, 17 Jan 2024 02:56:25 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 wr8-20020a170907700800b00a2e08b24ea3sm2967838ejb.174.2024.01.17.02.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 02:56:25 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 1/1] cmd: bootmenu: rename U-Boot console to Exit
Date: Wed, 17 Jan 2024 12:55:46 +0200
Message-Id: <20240117105546.7282-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117105546.7282-1-clamor95@gmail.com>
References: <20240117105546.7282-1-clamor95@gmail.com>
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

It seems that the U-Boot console entry of the bootmenu has lost
its original meaning. Now, even if it is chosen, the probability
that you will enter the actual U-Boot console is quite low.
Boot env, bootflow, bootcommand script may appear, but not the
actual console. Hence, let's remove ambiguity and name this
entry by what it actually does: 'Exit' the bootmenu.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 cmd/bootmenu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/cmd/bootmenu.c b/cmd/bootmenu.c
index 987b16889f..78184fccab 100644
--- a/cmd/bootmenu.c
+++ b/cmd/bootmenu.c
@@ -119,7 +119,7 @@ static char *bootmenu_choice_entry(void *data)
 				iter = iter->next;
 			return iter->key;
 		case BKEY_QUIT:
-			/* Quit by choosing the last entry - U-Boot console */
+			/* Quit by choosing the last entry */
 			iter = menu->first;
 			while (iter->next)
 				iter = iter->next;
@@ -361,15 +361,15 @@ static struct bootmenu_data *bootmenu_create(int delay)
 	}
 #endif
 
-	/* Add U-Boot console entry at the end */
+	/* Add Exit entry at the end */
 	if (i <= MAX_COUNT - 1) {
 		entry = malloc(sizeof(struct bootmenu_entry));
 		if (!entry)
 			goto cleanup;
 
-		/* Add Quit entry if entering U-Boot console is disabled */
+		/* Add Quit entry if exiting bootmenu is disabled */
 		if (!IS_ENABLED(CONFIG_BOOTMENU_DISABLE_UBOOT_CONSOLE))
-			entry->title = strdup("U-Boot console");
+			entry->title = strdup("Exit");
 		else
 			entry->title = strdup("Quit");
 
@@ -532,7 +532,7 @@ static enum bootmenu_ret bootmenu_show(int delay)
 		title = strdup(iter->title);
 		command = strdup(iter->command);
 
-		/* last entry is U-Boot console or Quit */
+		/* last entry exits bootmenu */
 		if (iter->num == iter->menu->count - 1) {
 			ret = BOOTMENU_RET_QUIT;
 			goto cleanup;
-- 
2.40.1


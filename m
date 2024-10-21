Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A6CD0E6C9
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 08:20:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A15F89308;
	Mon, 21 Oct 2024 10:19:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gTOdLYdX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4908D892E1; Mon, 21 Oct 2024 10:19:45 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C394892F9
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 10:19:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a99f1fd20c4so565217166b.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 01:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729498782; x=1730103582; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hw7jyRZ+ZJ4oaUxS7wf2ulK8ilu6KkApRP1x6BDg3BU=;
 b=gTOdLYdX5IVNvLazwN+ZfgUfQx/iVFkSEv2pj7vDGjbqajhs4YilSnew393QbJOCBG
 6gSvKW10Eu6RjlvbpPMEdOktxGtgH6jWCnl+oxXgieBD/PVMB9loZY9Ra8aV+ItrkkXS
 guUz6ndd7SH2dvApDIixFNcxeZg9AJO8iwcx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729498782; x=1730103582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hw7jyRZ+ZJ4oaUxS7wf2ulK8ilu6KkApRP1x6BDg3BU=;
 b=NyqiZiGf8lxGAk0Tq6Nq7b3of8LIEKl/gB+LNZBxCThowWO4eANcu75Hz+SyGqErwR
 AxeeF6qBRrfCaBb6BZSxQg7jB/iH76qi9PH3Vc25h9gJSgO006LnO7BcNDnT8VdQ1Pmg
 yAq821cMaUTWbQwOk/05ubUGpUoSb6C4cZMH8KaJC6uB8rpH0T325bKV5KBSw7xpFOeO
 VjGpfBNNjbcV1v2PVGOEjdEH5zVF3KozPuu7BdTnreQYQEQjGA/4D0xU934Q3lUch0gx
 POahwfSRLLVEaOOHYoFet6nGONk8cQOVw5T8+dBYmwUn2HBZLthgUfspEzK66EGLR5/s
 3liw==
X-Gm-Message-State: AOJu0YwszamfAR5Agt7iCiL07JrctEM0NQdsCx/fxCk5QWG6QdREf8py
 bktsj1Ib5Pd0vV3DEkISiiAJZlddfkxuqgzrW7V9MOjK3Qk+sjvruAa9rV41ecEkwDPphOB+Anq
 DbY+p
X-Google-Smtp-Source: AGHT+IEnyALyHxoUexHAfM4rZXOfIY2kfDnYIfZlW7bRDoKMOMRpWCpFgt/phXd8Pi2Z8fXVUOBlcA==
X-Received: by 2002:a17:906:f5a0:b0:a9a:1253:4d81 with SMTP id
 a640c23a62f3a-a9a69c98b16mr1073144166b.47.1729498782573; 
 Mon, 21 Oct 2024 01:19:42 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912f6520sm176057766b.73.2024.10.21.01.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 01:19:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH v4 4/8] bootstage: Allow counting memory without strings
Date: Mon, 21 Oct 2024 10:19:28 +0200
Message-ID: <20241021081934.289473-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021081934.289473-1-sjg@chromium.org>
References: <20241021081934.289473-1-sjg@chromium.org>
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

The bootstage array includes pointers to strings but not the strings
themselves. The strings are added when stashing, but including them in
the size calculation gives an inflated view of the amount of space used
by the array.

Update this function so it can return the amount of memory used by the
bootstage structures themselves, without the strings which they point
to.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/board_f.c    |  2 +-
 common/bootstage.c  | 16 +++++++++-------
 include/bootstage.h |  5 +++--
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index a87411ee350..98dc2591e1d 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -582,7 +582,7 @@ static int reserve_fdt(void)
 static int reserve_bootstage(void)
 {
 #ifdef CONFIG_BOOTSTAGE
-	int size = bootstage_get_size();
+	int size = bootstage_get_size(true);
 
 	gd->start_addr_sp = reserve_stack_aligned(size);
 	gd->boardf->new_bootstage = map_sysmem(gd->start_addr_sp, size);
diff --git a/common/bootstage.c b/common/bootstage.c
index dd6aed7c2fd..c7bb204501a 100644
--- a/common/bootstage.c
+++ b/common/bootstage.c
@@ -520,17 +520,19 @@ int _bootstage_unstash_default(void)
 }
 #endif
 
-int bootstage_get_size(void)
+int bootstage_get_size(bool add_strings)
 {
-	struct bootstage_data *data = gd->bootstage;
-	struct bootstage_record *rec;
 	int size;
-	int i;
 
 	size = sizeof(struct bootstage_data);
-	for (rec = data->record, i = 0; i < data->rec_count;
-	     i++, rec++)
-		size += strlen(rec->name) + 1;
+	if (add_strings) {
+		struct bootstage_data *data = gd->bootstage;
+		struct bootstage_record *rec;
+		int i;
+
+		for (rec = data->record, i = 0; i < data->rec_count; i++, rec++)
+			size += strlen(rec->name) + 1;
+	}
 
 	return size;
 }
diff --git a/include/bootstage.h b/include/bootstage.h
index 57792648c49..3300ca0248a 100644
--- a/include/bootstage.h
+++ b/include/bootstage.h
@@ -371,9 +371,10 @@ int bootstage_unstash(const void *base, int size);
 /**
  * bootstage_get_size() - Get the size of the bootstage data
  *
+ * @add_strings: true to add the size of attached strings (for stashing)
  * Return: size of boostage data in bytes
  */
-int bootstage_get_size(void);
+int bootstage_get_size(bool add_strings);
 
 /**
  * bootstage_init() - Prepare bootstage for use
@@ -444,7 +445,7 @@ static inline int bootstage_unstash(const void *base, int size)
 	return 0;	/* Pretend to succeed */
 }
 
-static inline int bootstage_get_size(void)
+static inline int bootstage_get_size(bool add_strings)
 {
 	return 0;
 }
-- 
2.43.0


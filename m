Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6199CF042B
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33C4588FF6;
	Wed,  9 Oct 2024 03:50:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IV8e/QdI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0339C89010; Wed,  9 Oct 2024 03:50:39 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6743E88FDA
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a397d670baso812455ab.0
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438635; x=1729043435; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zzhb6TfPkgvx+nFbw3Pcj4JDCr6Qe38BT3Oqa8EGhXI=;
 b=IV8e/QdIU5yrUze2ja+njW+gp/FG3H74IjS541xz/qnNEDWRqwE3NFOKXVHtg/KBO3
 iFra3Xu0eMM/n+/O5t6CKhQldmB0MNR9UuyoXxmSTE8rXHgOhRY0prX8SNQCkN1TccxM
 eKB22YUWenMKP5MsapH8DVKRXwgkbgMObd3ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438635; x=1729043435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zzhb6TfPkgvx+nFbw3Pcj4JDCr6Qe38BT3Oqa8EGhXI=;
 b=tpeeGoUYnO+bFwbyTfS/vAEBAPAHsUYfrDcfI30EzQz9hseR26UEKDoDVZ1KhIgQv8
 b1VmbpXKu+CGSOkTJiXl8y73mk7ss2cFOKXzZegTOLkDqVWFJRirpUXesNGeTSVSO7/N
 2FuZy3PPmdUJanPTGx8jn+IKsCTX7qnF9XreztqpBGXRdrtjPeXE79Af/IwRHwskvlFH
 8w2bWS5Pj9znZnrFN662XyVtFBjAnPP6iUGKcOfv+GYBXheam0DCYwaKaYDdVjsMQvHW
 YRWcMFUYrHZSPCDGjMqbU1rI/u2AorQgp5t2IXU9y55Orh84SH50bRT1lLAGM5OmeHId
 xG3Q==
X-Gm-Message-State: AOJu0Yz9cKVVD+Gbb304STU6sO0Ct53USvZOQpJMZE6kss/VLemFj1Q0
 Ae1x5icqB9y6ctQn+eGGOeYmRpR1hmAMTSpN4H2IvKckzyTAm0D7JPqEYNzBgEicJKFWDtGimof
 Zfw==
X-Google-Smtp-Source: AGHT+IEMlz3m+BAULxIISyj51bjHMlrChBCxYIl39yvRKlMJXTzd/38XgxgSFUJ9DBm9N1RoCUZz4A==
X-Received: by 2002:a05:6e02:1d17:b0:3a0:be93:e8d5 with SMTP id
 e9e14a558f8ab-3a397cecdaemr6843995ab.11.1728438634992; 
 Tue, 08 Oct 2024 18:50:34 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a37a868967sm20677585ab.67.2024.10.08.18.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 18:50:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>, Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH 5/6] bootstage: Allow counting memory without strings
Date: Tue,  8 Oct 2024 19:50:17 -0600
Message-ID: <20241009015020.25817-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009015020.25817-1-sjg@chromium.org>
References: <20241009015020.25817-1-sjg@chromium.org>
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

 common/board_f.c    |  2 +-
 common/bootstage.c  | 16 +++++++++-------
 include/bootstage.h |  5 +++--
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 2e04a47b546..bf4252784a4 100644
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
index 49acc9078a6..b1506120f9d 100644
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


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9026ED216A2
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 13:33:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AAF5888BE;
	Tue, 15 Oct 2024 15:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FNv4mAWP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D77A28837D; Tue, 15 Oct 2024 15:33:17 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3D4F88770
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 15:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-83a9317f93dso10803139f.3
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728999194; x=1729603994; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NP1G0ykEyLjM8jqeNgbZDV28Sv5JVYcBgXWUbVmnPdg=;
 b=FNv4mAWP6/Si9gw/3bgDNI61Rp2v26Sko9eCcPI2oNEEgOIfwudV2pBVAQk2hRtSqh
 OZt1e3qN3b1IKzHNJVguGS7fW1STenCPXOfTEPFDhDn02fpRfKznXaupjiIS21WTLwLG
 IkVj9rMB1EMsX6zPiTpnssER25uWz6J0+eY4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728999194; x=1729603994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NP1G0ykEyLjM8jqeNgbZDV28Sv5JVYcBgXWUbVmnPdg=;
 b=M5GSiiYbrUmwa3joVHmRnKDmK0rEb4U5aJX+0KfHrarAfOMPAjEnfJrwymMLSRyOw3
 ddL2Qsbai2p7kH7CYdlHBfIWxa0MtQmzbntE+so4ocidP0sG7X8qUSI3OBOxYUkIItla
 rCRiqYQ6orDqzz2Lv5t7vqW06EcrrGqXXfDM0IMceFiMlMVoW+wVTXw6gZFvcTMFEaUy
 F0l3ibtsBcmIK4kRqOoJ6GhN7GUtwXVlMtFrW2jO6y7Z7EcIMOsQxQUsbGLbm0nu23/G
 OYzT5jjVl6QA++V1ALVCnRCj4LahhcTY+xkl9zcT0SUFFZBAsiVnoNZxSRmbkVWbs9QC
 KoJA==
X-Gm-Message-State: AOJu0Yy0+R3jCH2luttOwBTARVBYQz4hT2fOy+PWdSCRG2xDAOp0LdSl
 kgmy92mQ4yr977+7fWw+VO2aLpTg5X3qra815McjtOF8YwJFFV5gQHvCTRFP8Selugum+JzIMOC
 Hiw==
X-Google-Smtp-Source: AGHT+IHbOocnUWFeW4GKf9dlrJ72495sOxRa9e/yt40TOGA+ZFr1WHxeNUaMM6BeHc+HRdbDzy1Bew==
X-Received: by 2002:a05:6602:2dc3:b0:82a:34da:72f7 with SMTP id
 ca18e2360f4ac-83a64db8b35mr728083239f.16.1728999194151; 
 Tue, 15 Oct 2024 06:33:14 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83a8b28bed6sm29794939f.8.2024.10.15.06.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:33:13 -0700 (PDT)
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
Subject: [PATCH v3 5/7] bootstage: Allow counting memory without strings
Date: Tue, 15 Oct 2024 07:33:02 -0600
Message-Id: <20241015133304.2874735-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015133304.2874735-1-sjg@chromium.org>
References: <20241015133304.2874735-1-sjg@chromium.org>
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
2.34.1


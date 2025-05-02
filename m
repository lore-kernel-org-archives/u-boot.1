Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D0DCC3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:52:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E53F82AFC;
	Fri,  2 May 2025 16:48:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QRKy0Bi4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F91C82B41; Fri,  2 May 2025 16:48:37 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDA5381F7E
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-861b1f04b99so85497339f.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197310; x=1746802110; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AdCEmmt3u14ZlWYLVYoYEia1uPgd+pq/eLsk7Q0nNSM=;
 b=QRKy0Bi4mZpzdUyjIMAlSAEtHzMHK683DAKQe9zST73fcFit088H4dbcnCIAy53XCo
 eB+MBUONqS7vT/XwYoi601KvC93FW4y0Ocw4G5TInNuvWNa1+WzV2FpGuO0wuxEoWYhy
 L7wX7Rxy7AGFe51w/0lA+QUAaAgTXNluSAtKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197310; x=1746802110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AdCEmmt3u14ZlWYLVYoYEia1uPgd+pq/eLsk7Q0nNSM=;
 b=EMkIFl4VO7/GF8VtB3wCAFGl/1sLoq5G7ECh0dgRBhXWshCdFolAF/MgJR+RXtQKfG
 kCqaC+JVg+9Q/uXUVp5BoAvPie/rh5ueM64Cyd3LKiwfJipvKN/W2I+HOkfJotOerxFB
 eRL6ZXcCS4PHG7oPbnl399Pe9sS6zy+ctpm0qbjFgBg35mMAJCDw2ak5x4p3J7XV+TFH
 RN/eyqs/VrPk5YMuGn34B3FTL09JUcrz+E4elpYjzAH0MPLCuSqlrXnx3ZjyMvDlJ1bT
 T8z0Co0xKJQDmHDOxcohjSss4ZpshLlNTCBeZKGQ8dzN3x0NfF6QxvR7yMoPMRSqodtX
 kMyg==
X-Gm-Message-State: AOJu0Yw9/t79XPSgMACm58NunOuOnPhk0KjPRFb4JpW13683twrymlyV
 cExftxgMzxtw9mfj3YwCbWW5nFLrsej47MhAgNkNURy2blYff/D9YZYa6ILlkxTvjSvvQjlV960
 =
X-Gm-Gg: ASbGnct5DQu4MLQpQYYacHmmN4TxFypPmz3TJtPnq3wp/aKEFtJbqUt0zT4CSTdDvxF
 lk7t2Mgbc8ll417QD9hTtoF5zin2ZozfZI4Qb+woVn5Wp8Ey2aTCySedb0JE1kTOAXwOLEACFO+
 AQHYGXccRlvcqPOeVAeQf/Z0b0/dQwzMsuDablHSkaxqXa4GCzEaNyjjcKex1dSF3Xjmo6ae0tk
 2EIrw7Pry1mDKIdSShJgs+xRz0nicC9b+TvXCDxE8fh3xWl/2R9KsYsLwORwJw3+gXcPdL2VYKt
 UjD1/jRqCkxSLMSihvKbnD/YYTcWOrirNjqDpHc++8MIFZxrdzHPzy0X8Gh6P9W2wYD+cTRm509
 ssg==
X-Google-Smtp-Source: AGHT+IEJhWzu5CFLNpVqFdDP5pS9hkEz5cduJFSfrpD8LnF36wzNyhHbpvuFE1hZfZgqn6jUI08+Pg==
X-Received: by 2002:a05:6602:3e9a:b0:85b:3fda:7dbf with SMTP id
 ca18e2360f4ac-866b34901f3mr391401239f.9.1746197310382; 
 Fri, 02 May 2025 07:48:30 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:48:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 34/60] expo: Use an abuf to hold strings
Date: Fri,  2 May 2025 08:46:32 -0600
Message-ID: <20250502144718.313633-35-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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

It is more convenient to put strings in an abuf so they can easily be
resized. Adjust the struct accordingly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/expo.c    | 4 ++--
 include/expo.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/boot/expo.c b/boot/expo.c
index 301bbfa5f9a..debdb60022b 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -86,7 +86,7 @@ int expo_str(struct expo *exp, const char *name, uint id, const char *str)
 		return log_msg_ret("obj", -ENOMEM);
 
 	estr->id = resolve_id(exp, id);
-	estr->str = str;
+	abuf_init_const(&estr->buf, str, strlen(str) + 1);
 	list_add_tail(&estr->sibling, &exp->str_head);
 
 	return estr->id;
@@ -98,7 +98,7 @@ const char *expo_get_str(struct expo *exp, uint id)
 
 	list_for_each_entry(estr, &exp->str_head, sibling) {
 		if (estr->id == id)
-			return estr->str;
+			return estr->buf.data;
 	}
 
 	return NULL;
diff --git a/include/expo.h b/include/expo.h
index 84dc77f771e..b6de0310071 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -134,12 +134,12 @@ struct expo {
  * struct expo_string - a string that can be used in an expo
  *
  * @id: ID number of the string
- * @str: String
+ * @buf: String (contains nul terminator)
  * @sibling: Node to link this object to its siblings
  */
 struct expo_string {
 	uint id;
-	const char *str;
+	struct abuf buf;
 	struct list_head sibling;
 };
 
-- 
2.43.0


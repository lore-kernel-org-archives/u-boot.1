Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D59FC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 15:59:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB7FA871DE;
	Sun, 12 Nov 2023 16:58:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZtATA2KU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9058487136; Sun, 12 Nov 2023 16:58:28 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C2EF86F8E
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 16:58:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7a98fdeaac7so160767139f.1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 07:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699804702; x=1700409502; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wXGZ+mjYsKoyO3HW9UTaUamKgeeMsnVUGOglMBck3Sk=;
 b=ZtATA2KULfcCDyKrVMnb7gtddXJ39lJ0Y/WPkmPAz6HHVYK1pmR+y5UmuEN5YPsk+D
 iLkfghJVcOjBJhdzl68suXFc7DZrRtNWbl72gW3Z6HVLWo9AsmwcfbDAod2Gp7xN65r/
 PZr28+ofpUcv3TbX1uMjnsSoI5bgkOUvfqnaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699804702; x=1700409502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wXGZ+mjYsKoyO3HW9UTaUamKgeeMsnVUGOglMBck3Sk=;
 b=M2qHrhhwSY/AjV7brgIeJqFW6ErD7TtsCjKuqZW7mvD0wS/NQu5JHTtENmFvIWm+wf
 tw08zTbvXwJ/bvSaj4rl7VKiwrBwETW/lb25rVwnhfsL3N8AFmSOUgDxhMwri7qBIT73
 MxVx9PV+XrnlWzpJtE+qLMquv9Xc9eMbzztsWASnrUSf0vG4lC8e7MCz9YvKmzLsvY2K
 9RCZFGfioNMq/590e9P2+5BWer9gx/bNYMV+o9c5fxcAVJCzCM2NJcuFD129nDj3D/Lw
 hS4QtUqvROb4gK/DZk+vQlqO7bb8m3YiKuJ3OlqFHmCjlnSy/ysEDU4kpqjgjF2APnto
 1O3g==
X-Gm-Message-State: AOJu0YwGSHKlWGak4n4ipVW2HXk8TGxivXzkhqFpxoiYtlzAy4KR3yXL
 UmxzqQxtMXO7LJJeW5fkniSriA1UUeuvsv0WVfm+Dg==
X-Google-Smtp-Source: AGHT+IGuaMh204b5b1EEKch85dphrdHrUrd90hm9CbwvYVbIiD/rhmf3IT5aT/Ab9NmxDPByzt6VMQ==
X-Received: by 2002:a5e:c80b:0:b0:7b0:1bbf:b050 with SMTP id
 y11-20020a5ec80b000000b007b01bbfb050mr4309037iol.1.1699804702558; 
 Sun, 12 Nov 2023 07:58:22 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a056638348b00b0042b37dda71asm1065843jal.136.2023.11.12.07.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 07:58:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/4] efi: Correct display of table GUIDs
Date: Sun, 12 Nov 2023 08:58:04 -0700
Message-ID: <20231112155808.135585-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112155808.135585-1-sjg@chromium.org>
References: <20231112155808.135585-1-sjg@chromium.org>
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

The printf() %pU option decodes GUIDs so it is not necessary to do this
first. Drop the incorrect code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/efi_common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/cmd/efi_common.c b/cmd/efi_common.c
index f4056096cd3f..1aa2351fcdfd 100644
--- a/cmd/efi_common.c
+++ b/cmd/efi_common.c
@@ -17,10 +17,8 @@ void efi_show_tables(struct efi_system_table *systab)
 
 	for (i = 0; i < systab->nr_tables; i++) {
 		struct efi_configuration_table *tab = &systab->tables[i];
-		char guid_str[37];
 
-		uuid_bin_to_str(tab->guid.b, guid_str, 1);
-		printf("%p  %pUl  %s\n", tab->table, guid_str,
+		printf("%p  %pUl  %s\n", tab->table, tab->guid.b,
 		       uuid_guid_get_str(tab->guid.b) ?: "(unknown)");
 	}
 }
-- 
2.42.0.869.gea05f2083d-goog


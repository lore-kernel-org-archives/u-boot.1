Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8B7C3DA61
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 10:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 179A988440;
	Sun, 21 Jul 2024 12:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DwBB0PwO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E04AD88297; Sun, 21 Jul 2024 12:10:00 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31E618827D
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 12:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4266eda81c5so27289585e9.0
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 03:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721556597; x=1722161397; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=spZHfR6nUyJdkwY/1j0TIIYOp3ly9C8+WGByeLEyfm4=;
 b=DwBB0PwOY8mkJEZrBYLWoIcu83l+xcRiBLT8ADO7WAhVZMHLzrJAfyUsL6KFIUrXq0
 RRY3iKN7cjIc9+3idJDfDret+oiv6rw1EAiCElzU+qltd+E7rG5H1YHCpPn4Le2xXHzG
 pPReFoJkKA1uCcNQ81xgvL+h13VSHZFYjgETQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721556597; x=1722161397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=spZHfR6nUyJdkwY/1j0TIIYOp3ly9C8+WGByeLEyfm4=;
 b=CJ/rLRL1dGgVHGm+ACrvK+x2YV1n4Hyfg45kAU3wqZnYD760niVWEodx4GjiWeI8pg
 4xIja7V+OrGRvOkE3bAoSIzDekVKG5eDdqHMGFLibCdsYVmaVjhT+n8pIqFdzsNQwLfA
 R4Q3XNHGc5a8yBddiakseVMuaqcysTGeqh8XlG+qOB9rQidxT50VPmUOLr+t07fdTjUk
 /NgNvIHHmncrdQ83e3HDp877aw+54Bkt1cbvhj9bN0aNm38mj+IzFgw3mj5pTcO61Eug
 5smm2TTuiJmsC5TTf/O7TOysj5YlYAz2aelyLE/H++bsWcPQnQQ4DLR3eApK1k5a3ujr
 w5Lg==
X-Gm-Message-State: AOJu0Yz6eWilX0XUBUEYIjSIxSlMlEa2FzzINqOoqqGw86uTU0STdCFs
 qd2P8d7tc4WjwOj/INg6ZM+F4y55VhztDRYoNJVdkE8lzSTQI72460dVGLZ1RfzFezqLO7/iIFU
 =
X-Google-Smtp-Source: AGHT+IFUG5aYYKfZucVvSwORv0PTAJVc7p3hGEt7vlu7EHvxWyyv5UrExcdHSa9MrorS0fKMwCzqnw==
X-Received: by 2002:a05:600c:5250:b0:426:62c5:4731 with SMTP id
 5b1f17b1804b1-427dc55bbe6mr34508085e9.29.1721556597220; 
 Sun, 21 Jul 2024 03:09:57 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69013fasm85096265e9.12.2024.07.21.03.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 03:09:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 08/21] sandbox: Set up global_data earlier
Date: Sun, 21 Jul 2024 11:09:26 +0100
Message-Id: <20240721100940.3202027-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721100940.3202027-1-sjg@chromium.org>
References: <20240721100940.3202027-1-sjg@chromium.org>
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

It is possible for U-Boot functions such as printf() to be called
within state_init(). This can end up checking gd->flags (e.g. in putc())
before global_data is set up.

Move the setup earlier to avoid this. This fixes the suppression of some
debug output in memory allocation (when enabled).

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/cpu/start.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/cpu/start.c b/arch/sandbox/cpu/start.c
index dce80416529..0920ed55965 100644
--- a/arch/sandbox/cpu/start.c
+++ b/arch/sandbox/cpu/start.c
@@ -483,6 +483,9 @@ int sandbox_main(int argc, char *argv[])
 
 	text_base = os_find_text_base();
 
+	memset(&data, '\0', sizeof(data));
+	gd = &data;
+
 	/*
 	 * This must be the first invocation of os_malloc() to have
 	 * state->ram_buf in the low 4 GiB.
@@ -501,8 +504,6 @@ int sandbox_main(int argc, char *argv[])
 		os_exit(1);
 	memcpy(os_argv, argv, size);
 
-	memset(&data, '\0', sizeof(data));
-	gd = &data;
 	gd->arch.text_base = text_base;
 
 	state = state_get_current();
-- 
2.34.1


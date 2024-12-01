Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126E2D49776
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CBF489718;
	Sun,  1 Dec 2024 16:28:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LVkTzwkU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1426A8914D; Sun,  1 Dec 2024 16:28:34 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 289EC895B1
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:28:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3a777fd574bso12590855ab.1
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066906; x=1733671706; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OK6BVB/zrKgFQRIoVG4HZsXvxHAkWPaelfh4X4dXF0A=;
 b=LVkTzwkUkVe6NE5UlUbCkoYDcyPCzxWFdMb9ykNVQf//1odMDmrQE0b36GpA9lGR9h
 2WOIWN9XsYcsBxw+P6TYj6ofSv4/01ZgZgRx00llLCEUZNxT2xZunYuXwkC3PN2Gzzw1
 eDTvCZ8Z4ikBNlyRGvcs0uLPwtyj4ekagJKpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066906; x=1733671706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OK6BVB/zrKgFQRIoVG4HZsXvxHAkWPaelfh4X4dXF0A=;
 b=X6H/qoPyU28Jf2mNvGDSXA8plX0e3COBTIj44Bo+ze37ndE0qCpWRcClKNqCxUjfpm
 iSOhPwwY9LTvRQxauoTXHae5meYKAhnfujsrPjdSG9JTGAE3pWkqulMcOQ3P9NxpvZ5C
 PCH2kzXssBwFYdrlV11lrUsK7fzEZtwdUfmNjKv0MdsAz7SixWztyXuzq7jf4ULmlj4J
 bvwhfRA2HOvWNE6hf8PPrSmF9VM8nbWGR47PvU0HjRheicETonTK5IIoC4dutqPEp96E
 LeL2/1mctJwR/1ll5V5rFIca1+Dbs55Apx3qIcyvIZU2B+VADx+ARIUF6E2dOyq/6upl
 7O1Q==
X-Gm-Message-State: AOJu0YxpMRuMS1xrcN1jVPfveVPL3qFpr80IxELO4IuA90308dlmJgXA
 1WsdEn7HpkxeBSG75jsggOUYNVjV35xZ/smUxEmiAVjtqWqyODdXZ52vID7OprYkHYCk9ziHxO8
 =
X-Gm-Gg: ASbGncsLTPiRTd17MqbCmH96B26jnN3xtgGGCXdwo2FTt/x+Yh+rvm4Z86agKomY5wI
 YmG0gPTpbMTEwrGRCHO4S+Q15GuTuRZ0I7iA4nYXaZOH5h9C0D+wJMRLNTZ2BDJHISoqtrCGR4x
 2bK7DDlkatm0b8C9iJZ8dGXvtQjLpliiPK3r0O0oONI4OloEBqAyODdlAYVox5nQ7O2qOVUbLnU
 xSjHJG4skP3XukvpE0w647dr+N3Q7gYvVq7Yv2jvQdf
X-Google-Smtp-Source: AGHT+IHqOb/jyT0A12KBc1GBn+EXF4yQvAsgyXeTVn9R2ZCcyL7wKymzwNNDV6moNVS0EO8kC1kdLQ==
X-Received: by 2002:a05:6e02:3193:b0:3a7:d7dd:e709 with SMTP id
 e9e14a558f8ab-3a7d7dde903mr104765665ab.7.1733066906323; 
 Sun, 01 Dec 2024 07:28:26 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e230dcb33esm1690307173.57.2024.12.01.07.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:28:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH v5 3/9] board_f: Correct stack reservation
Date: Sun,  1 Dec 2024 08:28:05 -0700
Message-ID: <20241201152815.1668093-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201152815.1668093-1-sjg@chromium.org>
References: <20241201152815.1668093-1-sjg@chromium.org>
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

The reserve_stack_aligned() function already ensures that the resulting
address is aligned to a 16-byte boundary. The comment seems to suggest
that 16 is passed reserve_stack_aligned() to make it aligned.

Change the value to 0, since the stack can start at the current address,
if it is suitably aligned already.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/board_f.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/board_f.c b/common/board_f.c
index 98dc2591e1d..677e37d93c0 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -601,7 +601,7 @@ __weak int arch_reserve_stacks(void)
 static int reserve_stacks(void)
 {
 	/* make stack pointer 16-byte aligned */
-	gd->start_addr_sp = reserve_stack_aligned(16);
+	gd->start_addr_sp = reserve_stack_aligned(0);
 
 	/*
 	 * let the architecture-specific code tailor gd->start_addr_sp and
-- 
2.43.0


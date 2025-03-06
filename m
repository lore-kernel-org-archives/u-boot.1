Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1BBC282EC
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:26:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 708BD8122F;
	Thu,  6 Mar 2025 01:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JcQ1jJiR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2EF78122F; Thu,  6 Mar 2025 01:26:29 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAE5480F9E
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:26:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-85ae3310966so3017239f.0
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220785; x=1741825585; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r6y6MChlS4/f+lbxhKQSKH3kE47VzYM96cW07Bn7q4A=;
 b=JcQ1jJiRYQeezIVA2VxtTlNKftOK2FZSx9Djk37NISS6yMPptT1nn6G6s+omh4iCUY
 d6R54lwpseXVS4ohAT3lk8G5vxGg26o6rq5uvc3+8QdPGdtLGANcW2vOwmB+rzzVa6p7
 A7uP+ot7b6JwULMnLTu2EdDk/hknGPZX+vbBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220785; x=1741825585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r6y6MChlS4/f+lbxhKQSKH3kE47VzYM96cW07Bn7q4A=;
 b=dQ5XP8eAGyFS8pwdY707Dfe4jPPqwxKTmfd+eKEBfWJLxpGLN/y1hBhWOxKvdJM93p
 p56TT4Y3mFhqMjWRHoi9DDA7mhed2Qth2uEDhsTOWZQQYNfdRO1bcySgdEWAvgVmVOQ6
 GDyB5lUZvZUAbi7cqEvEVH25oZEsTmKfFUC+21i2ovT8uR5pUe3Q9C5HZJ5wmqpvYw/q
 ymb4sJb3bfQxkyV61L7IaMVc/jwayVmSviY5mtbdlrzVg2myWBiujrEkBzrqqrakVslQ
 8+uwVnvqLRVJ/1UBjmrAAxFHrF+gF9aKWgB66drELRk8eBzOmUWl06OBjAYiRFgZ/ufq
 gH+w==
X-Gm-Message-State: AOJu0YwZKHfTyfcD/hA/Mqq1cfDpXd7zrZZkj/AKhTJL8RhiADdzUM3O
 scohLIARVTV7aFn+rmzi+RESc6ILpoV2QSj2xPvayTwjNKdrzX3FHBTQzCndEy7gflFjYGntoVg
 =
X-Gm-Gg: ASbGnctPPu8Rech4htMw77WV0wIzd4vCR9Q70rR6S1o3u/K0HGUf8C0b8HyjWZMC7Lb
 9xICZZBV9Kdi7w/lSwokxoXLtuPGZieesAoUixQMFuLb/zRa+xbcs8VSAPamcpp7UGTnEqrJ64X
 L8FZd9ax2P2H+OqjR1fefGN4OQ6pGu+zaU8twgvD08fW9LCYro3GhaY0ynD4yTrxSYS70xTeEIJ
 Cn6E0txxEFtrqdQEpccqTXzCZI6GQk7Y0ARliMU11zarfHtFLcRNuEv6JSdMyooFViMCkeSxFIR
 +cWhJF9m1YrZU/L0YZ0PVUJkZnvOKmi05gfadU2ogroHJ1LDd5cFDl4GqfpBJ1Ee2f8XKsfZCV+
 izvv6Hw==
X-Google-Smtp-Source: AGHT+IECfMMp2raASfeKzbK20+rciUpAm6id5/f+8x9L1tQhQhCjLaNZYYt54iNOBBHAmrfEv+YyRw==
X-Received: by 2002:a05:6602:728e:b0:85a:fcac:2f57 with SMTP id
 ca18e2360f4ac-85aff9d24demr877901039f.4.1741220784627; 
 Wed, 05 Mar 2025 16:26:24 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:26:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v5 01/29] x86: Make do_zboot_states() static
Date: Wed,  5 Mar 2025 17:24:55 -0700
Message-ID: <20250306002533.2380866-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306002533.2380866-1-sjg@chromium.org>
References: <20250306002533.2380866-1-sjg@chromium.org>
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

This function is only called within zboot.c so make the function
private.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/x86/zboot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index 94e602b8a5b..3035172352a 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -119,8 +119,8 @@ U_BOOT_SUBCMDS(zboot,
 	U_BOOT_CMD_MKENT(dump, 2, 1, do_zboot_dump, "", ""),
 )
 
-int do_zboot_states(struct cmd_tbl *cmdtp, int flag, int argc,
-		    char *const argv[], int state_mask)
+static int do_zboot_states(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char *const argv[], int state_mask)
 {
 	int ret = 0;
 
-- 
2.43.0


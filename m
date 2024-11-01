Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C89E6B244
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 11:50:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E26AD892DA;
	Fri,  1 Nov 2024 12:50:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OS1pU4B7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 773A289287; Fri,  1 Nov 2024 12:50:39 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2444892B5
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 12:50:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9932aa108cso279450666b.2
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 04:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730461834; x=1731066634; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1A5/GShwAv8OPvokjXq514pcruUol5ddbkfjZG4CRog=;
 b=OS1pU4B7PTWJ/ROb9s+sAYo6dBC/Uqs00/IrrTn+pzqUrspRIUWNmFfP1EgxE+YEEX
 MefV9aG+ZFtQ9ze7Fb8Ks+12qvel1oX8EhQax+3JjOw4PnisUu9dMzrW3gVkRUQ4y/l+
 77uP5ejCe5Se1z3j/eYH/6PaBzoIOZxh3Ph1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730461834; x=1731066634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1A5/GShwAv8OPvokjXq514pcruUol5ddbkfjZG4CRog=;
 b=QcilM16nDZIAD034yTEz0IyE/0lPLsbAz/NxRF7jwnbhSMo6MA1S5/n/7kbxng73Gf
 a7Rxeo3UPkC4QqB3tRnKm7uIubl98RTvjZPMgPJtu4sqAWuXgsvSTSeYfT56u+BjDcrN
 xetIkLsLaim3Gx4SMf7S0lxRY22FZMmoDHAANFGhKQ+evABX6oSPrfojhKJvLIjEJXie
 EFYYchl7VQJQLz3nYqkA6wKC4R9MZ/BqTSaxmC/rsnipX8w1vTM7e6MigMTVSj/5GirY
 dZu1VGYqF/VgR0AcexFk02ADfeVebWpdlelu53gt1OBemjx/0BowYBO14i3p4CutIjAl
 mrXA==
X-Gm-Message-State: AOJu0YxWl3uozK6fo9wg0sT3XB6AfgglaUuJNCPtIxhijoWlWKN0ORiz
 JmlpkFd88xIdVNVj5s2xyPeW5UGA7cyxmwCkFLJx9fFDLgjrjyRmOsm6S6dvc1h6Z55C9kNNlrk
 4xQ==
X-Google-Smtp-Source: AGHT+IGI0G8r9ABoxqYmgSwUWYBdTJZDuCXEmwqeUmtyGL/CKFg063rlxVbE1TX09UBx2cgDOtHDcw==
X-Received: by 2002:a17:907:1c04:b0:a9a:423:3278 with SMTP id
 a640c23a62f3a-a9e50b948c5mr575307666b.49.1730461834272; 
 Fri, 01 Nov 2024 04:50:34 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e564cc430sm171616566b.88.2024.11.01.04.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 04:50:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Svyatoslav <clamor95@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH v2 1/3] common: Drop check for DM in initf_dm()
Date: Fri,  1 Nov 2024 12:50:24 +0100
Message-ID: <20241101115028.214678-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101115028.214678-1-sjg@chromium.org>
References: <20241101115028.214678-1-sjg@chromium.org>
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

This is enabled by all boards, so drop the condition.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 common/board_f.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 98dc2591e1d..1e1aa08530a 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -811,9 +811,11 @@ static int initf_bootstage(void)
 
 static int initf_dm(void)
 {
-#if defined(CONFIG_DM) && CONFIG_IS_ENABLED(SYS_MALLOC_F)
 	int ret;
 
+	if (!CONFIG_IS_ENABLED(SYS_MALLOC_F))
+		return 0;
+
 	bootstage_start(BOOTSTAGE_ID_ACCUM_DM_F, "dm_f");
 	ret = dm_init_and_scan(true);
 	bootstage_accum(BOOTSTAGE_ID_ACCUM_DM_F);
@@ -825,7 +827,6 @@ static int initf_dm(void)
 		if (ret)
 			return ret;
 	}
-#endif
 
 	return 0;
 }
-- 
2.43.0


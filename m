Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A47D711B8
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 15:37:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 414E7895A8;
	Wed, 20 Nov 2024 16:37:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GlHAsEIm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E088F895A8; Wed, 20 Nov 2024 16:36:58 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9DF087042
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 16:36:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-83aae6aba1aso146440439f.2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 07:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732117013; x=1732721813; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mqcjJ0tpyaSbF/ZIvCBUwQzySJfYLSTis4eQBY3Fikg=;
 b=GlHAsEImmrSGAgDX+5DZ9TQ/EA7ZUA6sGOZMQjr4KFpXhJMYJZEHvwY76HLfHRKjzn
 11Tv7BrN5JX18C5lPAzlPwicJk4TcvvMy64AjMwjE/iP2zXg8MJSaCUQ89ZeOYFb3CLt
 Gb4Fw1QarmVUvj/9M/XKMazWkTrG1bBlHmFKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732117013; x=1732721813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mqcjJ0tpyaSbF/ZIvCBUwQzySJfYLSTis4eQBY3Fikg=;
 b=hP/5Sk7LbCejPkSuIe8OWqUifW77SHzv+S7/qHs/m/5xWGtxIkyxu2GZxQ+lCxLDMC
 2ZaxbP00ER/UKyx7eEviI2zRQI9601/mWlqFa1Z3yTnl4FJAbptzJJ12nSTnJLhym6sN
 BtQUAfVwBZZkgYvp2wh1LdG6lSBrOlIEGnQ7RT63LRZYMcx9Cv/Y42VZDxtnM6Uoxccr
 yVNeOeD6M6h6zqE61v23ZCB6GW9AmMpw9hAi4mTIFiYkB6IKHIoyiUZoJL9dhyZ2Ohyn
 keWt9+WXV6sYm+gJGHnlpt/XqIdc9CTHPoYeYQWPEJA3nNywuwhUHkolr7mk9plkpgjr
 Nr9w==
X-Gm-Message-State: AOJu0YzR9HEIULa9vpEwMfxsywynz/57NBZrQCYFISZNsWcgcQN9+6N1
 2+eFiMyslGj6BZ1aLlb9525yog1LZ7m3dXCIASMYTaQYMWoWCHMh/Hc297E+kMIXC3diCSDRa0g
 =
X-Google-Smtp-Source: AGHT+IEyfXG7bQVBfzPKN42MVJm1gIv/jGUJjpmYQ1Wc13i3S4OeY2ybRn9dCXQM5AJMLP196SC1Cw==
X-Received: by 2002:a05:6602:1550:b0:835:4931:b110 with SMTP id
 ca18e2360f4ac-83eb5fa1e65mr447452339f.5.1732117013154; 
 Wed, 20 Nov 2024 07:36:53 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e6df8cccfsm288747139f.6.2024.11.20.07.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 07:36:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Svyatoslav <clamor95@gmail.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH v3 1/3] common: Drop check for DM in initf_dm()
Date: Wed, 20 Nov 2024 08:36:39 -0700
Message-Id: <20241120153642.861633-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120153642.861633-1-sjg@chromium.org>
References: <20241120153642.861633-1-sjg@chromium.org>
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
2.34.1


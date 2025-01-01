Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0A2E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D755806E5;
	Wed,  1 Jan 2025 23:16:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EZUqCgbg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AB958062B; Wed,  1 Jan 2025 23:16:54 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9F6980628
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:16:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21644aca3a0so61005285ad.3
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769810; x=1736374610; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GTtiQkaQkEUl8+duYpde75lYj68wFjzHvxq/HBTaBMM=;
 b=EZUqCgbgedxOmDclxoaRwlA/ZBLiMspLjRZDCWD+ndgWaqjUmoHrdMnue2UoISECoq
 c+V2syX25rHvtczRVcs08z9/r8MqmasceIxM0FhI3VWJL5CU/gXg5vnXEcxfoaIgxtvF
 8YtADX64eaEJM7l4E61bJHef2hoX6JLYtj27o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769810; x=1736374610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GTtiQkaQkEUl8+duYpde75lYj68wFjzHvxq/HBTaBMM=;
 b=QMDiFw62cP4J/yvinoJoIaXtuScdvGNZWOiIObLd9TaiYHrPAz6qxrSQGqMhCyaFno
 Eu26m4tVODn9Qep2WDiSQhhy9eWAq6h/gn48x/C8K7y/ptxI8TZ5HxrkVlePPhpk0Tzd
 mnHio0e2CUum74TwyN2Nnbbvwx2ZqOnma5+nCQfHgEL3yNaZ8tEWL/gZ9Olz2589uYK3
 aHky+U/8kC1zvM2diIwPnl0ZJ/m0XKoFVqy+wq5nnJ0r3yWofZMcU2hBMTD9/r9G+N3M
 2MQkAlFDZao19iBBMTjQAXjQ0ske4ZnyDyZftyZOLXnZlkAQgnTybfBOTVI6ScmQaC+x
 2kAQ==
X-Gm-Message-State: AOJu0YxIFKXNplJkAAN1jdNhUon0w554sRDAwU8queAOi/EivxzSxrzk
 BE+HdgalO2XpnShlkvtcqbaCMYlD28TuaIeIE3eRqEAJsOPyYV+tupvjpUL0jndIIDW8xJCsYgo
 =
X-Gm-Gg: ASbGnctx6xZ7/P7EA/se8l3rJgM5CQrdTPwZLwkPiWMAQ3tddRiJNMXpePmBHiMsDqN
 9Nljnw1iIDJybntsNGc8NdOtlPnO+7vjjNyDGfRvbzZOJeyRnZC+spFjbDvaZMVRKvyq8mddMNr
 BRL/h07HDLR3iB+pqAG0iJcW7r/EQ5cG3HszNUxSX505J71d/46gXs8w/U1HUaCynxo3MtizMKZ
 HcVvM01jxvmsiLYrHOcHFkxJMsk4Bc2flDNfUCf20iOe0uX/xGGn8I=
X-Google-Smtp-Source: AGHT+IEMJX36Bt7UBUxTfH2Y5ZyvsZcs/2iMVJXF1cUNwD2hjTzS2VoGNspzpw7HHaPVzqFqVYDfqA==
X-Received: by 2002:a05:6a00:140e:b0:727:3cd0:122f with SMTP id
 d2e1a72fcca58-72abdd8c667mr55987478b3a.9.1735769809969; 
 Wed, 01 Jan 2025 14:16:49 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:16:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 35/67] upl: Drop the argument to spl_write_upl_handoff()
Date: Thu,  2 Jan 2025 11:09:21 +1300
Message-ID: <20250101221003.1944600-36-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

This argument is not used so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl.c     | 2 +-
 common/spl/spl_upl.c | 2 +-
 include/spl.h        | 3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 1ceb63daf31..46360ec4408 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -809,7 +809,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 			       "SPL hand-off write failed (err=%d)\n", ret);
 	}
 	if (CONFIG_IS_ENABLED(UPL_OUT) && (gd->flags & GD_FLG_UPL)) {
-		ret = spl_write_upl_handoff(&spl_image);
+		ret = spl_write_upl_handoff();
 		if (ret) {
 			printf(PHASE_PROMPT
 			       "UPL hand-off write failed (err=%d)\n", ret);
diff --git a/common/spl/spl_upl.c b/common/spl/spl_upl.c
index 5c68e4ab283..32c8ea62ef3 100644
--- a/common/spl/spl_upl.c
+++ b/common/spl/spl_upl.c
@@ -51,7 +51,7 @@ int _upl_add_image(int node, ulong load_addr, ulong size, const char *desc)
 	return 0;
 }
 
-int spl_write_upl_handoff(struct spl_image_info *spl_image)
+int spl_write_upl_handoff(void)
 {
 	struct upl *upl = &s_upl;
 	struct abuf buf;
diff --git a/include/spl.h b/include/spl.h
index 269e36bb441..137deb18d5e 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -1101,10 +1101,9 @@ static inline bool spl_decompression_enabled(void)
 /**
  * spl_write_upl_handoff() - Write a Universal Payload hand-off structure
  *
- * @spl_image: Information about the image being booted
  * Return: 0 if OK, -ve on error
  */
-int spl_write_upl_handoff(struct spl_image_info *spl_image);
+int spl_write_upl_handoff(void);
 
 /**
  * spl_upl_init() - Get UPL ready for information to be added
-- 
2.43.0


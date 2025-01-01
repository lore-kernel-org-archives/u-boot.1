Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF3FE7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:24:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33E3C8062B;
	Wed,  1 Jan 2025 23:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z3d8wAWb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6132C80379; Wed,  1 Jan 2025 23:23:06 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1266780601
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:23:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21631789fcdso109627265ad.1
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735770182; x=1736374982; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qVNxa4avbZBQWxgxMtxaOsT9XkWaWzuqo84/QYXqQuw=;
 b=Z3d8wAWba0gDEYKicdtAFwpVbCwUmoR5qABfxtPTiNH/5jb69Yu/EIEhLKeA7LAaF+
 OpdsTuEyUeJD8aYQ5YIXfh1VNZpRyGGdrg3QkVjw6yqzGBo0P/fNHMZ/PKxrN/Q8HPKe
 GGA8hbETn3VTCo6gagvYctzYaf7G4NHRWd3Xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735770182; x=1736374982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qVNxa4avbZBQWxgxMtxaOsT9XkWaWzuqo84/QYXqQuw=;
 b=l3wL+xD4eKbWMUXSKeKeS1NaVTOPffKn7BW0lX2HUtZSYUjuX9SxHAEbY40EkhkMj1
 70P4jZT9UJohmNjobzkwmAhAiQm70TaX1nZgh8UV2NLfB7A4DEmGoGy5kwmScPl1I/qN
 +j5KcCTbA6moyIsqgzwH2cV8fpjsC3JymwZ1KIw3W85sOfv/6tcJmf1kdRaDhwtO6zof
 qghq/tLFp6r8USjrQZpQt4DESMkf85r+v1e1BEU95unBcDBni30p0wJ0UCB8UVn/s92n
 3/bH2oyNRmCf7ruJkN/6bZnQtvJKT7kHMPZAypgXEHsgA3/n9phFsKwKH8hVLJpuCxB5
 8Jcw==
X-Gm-Message-State: AOJu0Yw5PLxzY7I6Jnv//q/edpT0hXxQrhqIsLPRCN4fNX2qBLf8ZWM+
 9M0IciWciHi++VWOTskezrA5+A2umDgoXDsbQSUf9gSlhS9vxjWpJgMxs/bTHnoST58aDIq/8z4
 =
X-Gm-Gg: ASbGnctvM3diZ25jySCthxmNpBxIePzvjBghER99n17sSvwOOcT5HVxDaa72TdY3CLP
 YQ9BG8FII8KuSecxfaRqsQMTDbMKPbDrMFyaYcfAR4ujn5UniPFtx02EfR3YDtRRnNYxoYoIXgg
 XmPgP3qvfbQ+BJ4tURGbcidZ8ZHOrJ4pUBM6auCpgIOfjp+z+vef6AHgy+SJrXveIcxKaUept+C
 XngpDwBHA+c08weeaMjWWXZNV7xCk9wXNKbAtm6/rNxP3PlOFLBHWM=
X-Google-Smtp-Source: AGHT+IHwHX++L/s1tr9/w6vmZUAQPS+zysAoEsC2oA11GXFatLBuVNUGHYB7gNZLz5JrSgc/0DR+wA==
X-Received: by 2002:a05:6a00:4399:b0:725:e957:1de6 with SMTP id
 d2e1a72fcca58-72abdbdd3d9mr57865991b3a.13.1735770182039; 
 Wed, 01 Jan 2025 14:23:02 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:23:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 57/67] upl: Correct use of sizeof()
Date: Thu,  2 Jan 2025 11:09:43 +1300
Message-ID: <20250101221003.1944600-58-sjg@chromium.org>
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

The write_mem_node() function uses sizeof(64) when sizeof(u64) is
intended. This can cause an error due to the buffer-space being
exhausted.

Correct this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/upl_write.c b/boot/upl_write.c
index ec1f5daac92..773c03ad1c6 100644
--- a/boot/upl_write.c
+++ b/boot/upl_write.c
@@ -336,7 +336,7 @@ static int write_mem_node(const struct upl *upl, ofnode parent,
 			  const struct alist *mem, const char *leaf,
 			  ofnode *nodep)
 {
-	char buf[mem->count * sizeof(64) * 2];
+	char buf[mem->count * sizeof(u64) * 2];
 	const struct memregion *first;
 	char name[26];
 	ofnode node;
-- 
2.43.0


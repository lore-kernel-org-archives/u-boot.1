Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6369BD3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:29:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD7BF8926E;
	Fri, 18 Oct 2024 01:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SSxvujRF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28E1389254; Fri, 18 Oct 2024 01:25:11 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C557B89253
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a3b8964134so5708555ab.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207506; x=1729812306; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lsa8GArWUTRtFNQUvVUE4PDMt3ynmlkfxYP03fbE1to=;
 b=SSxvujRFbwyxUia2H3KRhjcOPtLoLIPsUs0wK1bNn10g0eaBmlYEX6227vfV1PN3aM
 LO/RhGDq+QxnQgXxeigw1sf8irpvdPEvts6Hjao4AMws/vyRZuONBMbYVZmN6QqfPOIU
 vucvfZaqJItO3gtUozwYBzvYUXeeJNQLYnczw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207506; x=1729812306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lsa8GArWUTRtFNQUvVUE4PDMt3ynmlkfxYP03fbE1to=;
 b=jdrMiWYaOQQgX79Y72FOzasHjQL3Cd538rPkYvDSiZUkaWaQAxbBmJLDG6gtX72/Ox
 kr5NlfWicj/dYhJzoT50vqZb4OO3+epd0CzXQQRYFabAcZ2KrRB7Ktb8123hhAM8YKxB
 OVwigyO9YqOEGieU9Bs1n0crBCuYHyiHqzJY7mYTlpspzFBbQK/eWoqYzwa4zf5czHje
 3A1xkezRUsgQzmJwfnZYTEZ9bERQvszH8yXQY2ocWlkinTm9NSwkPpCPt8z14e5tDLT9
 hPaQEuxZa3GolJZnR9NkV4uB3Dxbya8tB5XdfCn4Bdtw9qhxpcaDSCls/DsWvJfIRM7I
 0j6w==
X-Gm-Message-State: AOJu0YyRO3rHmZw5OixS3wkObRB4WSGqPwcdfvRLaAhAOLqZio4cY98q
 AbR5ECKeXYSFiRLU/Cc+4rXs2t92iTrMTn59TYkj/6uA1+eXf8oBi1H7uVefS1dnI8jTYyGpZGA
 =
X-Google-Smtp-Source: AGHT+IHs4YZYMhJl+pSaalEiMIBJjsKAWkRya+693utGVXT5qCxtZu5m7eowGM2BwwRoZh3iNIK9Dw==
X-Received: by 2002:a05:6e02:2169:b0:3a3:b527:e809 with SMTP id
 e9e14a558f8ab-3a3f406326amr3837305ab.14.1729207506170; 
 Thu, 17 Oct 2024 16:25:06 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:25:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 25/34] boot: pxe: Drop the duplicate comment on get_pxe_file()
Date: Thu, 17 Oct 2024 17:24:04 -0600
Message-Id: <20241017232413.724808-26-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232413.724808-1-sjg@chromium.org>
References: <20241017232413.724808-1-sjg@chromium.org>
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

This function is exported, so document it in the header file. Drop the
duplicate comment in the C file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/pxe_utils.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index d6a4b2cb859..4fd26524286 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -133,16 +133,6 @@ static int get_relfile(struct pxe_context *ctx, const char *file_path,
 	return 1;
 }
 
-/**
- * get_pxe_file() - read a file
- *
- * The file is read and nul-terminated
- *
- * @ctx: PXE context
- * @file_path: File path to read (relative to the PXE file)
- * @file_addr: Address to load file to
- * Returns 1 for success, or < 0 on error
- */
 int get_pxe_file(struct pxe_context *ctx, const char *file_path,
 		 ulong file_addr)
 {
-- 
2.34.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB19AD0E6F9
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BB6D89327;
	Mon, 21 Oct 2024 13:39:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VyDGz5nK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67E9788FA7; Mon, 21 Oct 2024 13:39:15 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AB088904B
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:39:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9a2cdc6f0cso600358266b.2
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729510751; x=1730115551; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=85Q4p/tg2lVNRIQ8pw3ubemw3XvvPUoiOZa3bsJDBGs=;
 b=VyDGz5nKZnktwwImKreN/I1F2sBZy9aXai0D9DqnNYzCXX+R0aRNgsZ00QynesgWhe
 SInSk2RmO8SZmX4QpDGUOEOk4qovN8SQh+w2Zxh/y7b6cf8QJjXijbdBUfgWsjuHhVkI
 aqYDOnSJMbhBKWRUP7F5JbBMUfcqpbnR91uz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510751; x=1730115551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=85Q4p/tg2lVNRIQ8pw3ubemw3XvvPUoiOZa3bsJDBGs=;
 b=qvXjuLqtXD29GyEdy/2EZzthG8ZDouo6O2mrgMsUZMI+aMr1qsuadUoSI9YBr2fIa1
 xn6wSl+PBUH5OvF7uNmj2IBo62vwyvTbN29nzR6kVopFHG4dv8ltH86HjciYe8Y8vE8M
 zn/8twtJlz7hXkD5QuEfhaXaBGA5zVSZzXxgDJ1c81uSCH6jH0ztQqnIaVe7/V1tTywB
 9GjlVa67DXrxzQJGjw7rvwS0t9nUeCCbHBVEsfJFOhKwjQe7yU7BTXnvlPZKa6/xg7nD
 lBMGYgd7RXJkwuE79JX9xymWStzZ2XeUSa46XG+YOwhgO86N3p2LZUfIQtIpriLRgvt6
 FMJg==
X-Gm-Message-State: AOJu0YxW2xmgUv6dSyCKjgvPofSxnmjM4r90uOErXfa1+ehDhAjHz54u
 N2JEIH1OyP7FRnRUecLHXwmaNIYKwv7+8/NwTaPpMrCft6iLOiYaLKPE/thQP7u/HpwAjphnNep
 XxsiV
X-Google-Smtp-Source: AGHT+IGeIjhBQKuLudVWTXMEM2RnlGlcjGPDeK9XYoML0ApX8ZKJDMxtIC5QSaGAyafUe63JovJU0A==
X-Received: by 2002:a17:907:60d1:b0:a9a:597:8cca with SMTP id
 a640c23a62f3a-a9a69c99b93mr1225479766b.45.1729510750861; 
 Mon, 21 Oct 2024 04:39:10 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91571ea5sm191604366b.160.2024.10.21.04.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 04:39:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 22/25] ide: Drop unused status_led.h header file
Date: Mon, 21 Oct 2024 13:38:30 +0200
Message-ID: <20241021113839.318572-23-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021113839.318572-1-sjg@chromium.org>
References: <20241021113839.318572-1-sjg@chromium.org>
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

This header file is not used, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/ide.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/cmd/ide.c b/cmd/ide.c
index 036489fda97..be3078ae88b 100644
--- a/cmd/ide.c
+++ b/cmd/ide.c
@@ -22,10 +22,6 @@
 #include <ide.h>
 #include <ata.h>
 
-#ifdef CONFIG_LED_STATUS
-# include <status_led.h>
-#endif
-
 /* Current I/O Device	*/
 static int curr_device;
 
-- 
2.43.0


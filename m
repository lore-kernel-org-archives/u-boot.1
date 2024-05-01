Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49534C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:55:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72BF088B73;
	Wed,  1 May 2024 04:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fk9qOXi4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A5C588B43; Wed,  1 May 2024 04:44:30 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E55D388B3E
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-69b4043b7b3so36828066d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531466; x=1715136266; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BkeFDwxKNzwx90p3CrGLjv5IQZHoFXagADva7LbQt8Y=;
 b=fk9qOXi4We6F0MDZZXpUfo0kl2qFPUCxw3VMAJ7NvnC2TsdWmuzLNuQblLXaNo+bqg
 fMjQfLjlzweSdH67MQxn8V+dJU15ji87PBr+ejvinrWS1RJV6w4F8HjJTbgbLDrOloe/
 s3sLwyn7b25SDVZM4bKDbh3shuHfw/9DR64Bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531466; x=1715136266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BkeFDwxKNzwx90p3CrGLjv5IQZHoFXagADva7LbQt8Y=;
 b=qe87TGoAl8cQTvVekrFIbSgWETs0yzUWygzSi/AQtqcTp9t7uaL5tuo6GW3MapL4vr
 TN8LxWARsZMTZUwGCCCTJWXfFVmX+7u0xASFJ5CsilGfRxTILU6eP9HWGp9qV8jBBXEE
 IgWNha+gZhwbF2bAE/9p+mvsLGVExbXOx7ebJ2E7re3+dlKnvijTE/6VK6Kr3AnDeRmt
 tztus6ZzD61GPkOidR/Hcw0YdjHAbCok1kA+XDCkcBrB8eDTjDjP5QDZw5cQMXDFw30Y
 w2vN//RH397XX5BXqzIfB/q56UQfYwJs1kWZhhCwSXucorRGfmq9vmP3Zzo9K0ZICk9F
 dT8w==
X-Gm-Message-State: AOJu0Yygv203c44AURWwk/Z+/nkz6hWMirF5FWR6s/sjVUAVKTV6qi7P
 q40PPwx78X770VcoOSd8zPY9leLzVbgX5nLSKkQxJeV4H0ZUNJJ1I192log+BbWtm6ABw3umk2t
 vlBQ1wQ==
X-Google-Smtp-Source: AGHT+IGiF9jJm6XzX2xJARigoIVF8plYrIgJpG8Tcgj7vXBT/HQnsQxFa4gzO3NvUb8mTgatQ2M3kQ==
X-Received: by 2002:a05:6214:c46:b0:69b:5576:49e7 with SMTP id
 r6-20020a0562140c4600b0069b557649e7mr1297913qvj.45.1714531466680; 
 Tue, 30 Apr 2024 19:44:26 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Daniel Gorsulowski <daniel.gorsulowski@esd.eu>
Subject: [PATCH 059/149] board: esd: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 20:41:46 -0600
Message-Id: <20240501024316.1767971-59-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Daniel Gorsulowski <daniel.gorsulowski@esd.eu>
---
 board/esd/meesc/meesc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/esd/meesc/meesc.c b/board/esd/meesc/meesc.c
index 9e3621042241..dce69abdfd1d 100644
--- a/board/esd/meesc/meesc.c
+++ b/board/esd/meesc/meesc.c
@@ -9,7 +9,7 @@
  * esd electronic system design gmbh <www.esd.eu>
  */
 
-#include <common.h>
+#include <config.h>
 #include <env.h>
 #include <init.h>
 #include <net.h>
-- 
2.34.1


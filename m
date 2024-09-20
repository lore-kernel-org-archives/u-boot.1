Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C13CF58D1
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 06:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0A668934E;
	Fri, 20 Sep 2024 08:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mFH8udrB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC3128934E; Fri, 20 Sep 2024 08:03:19 +0200 (CEST)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C550F890EC
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:03:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x643.google.com with SMTP id
 a640c23a62f3a-a8d4093722bso225665466b.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 23:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726812197; x=1727416997; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GpGPzOOCYQ/vCo6VwUV8dBYiESDG7tZZGy/7UH0RUWU=;
 b=mFH8udrBY2AGWAzMLTXSr3RqronHiqh1II6aQgUL61cVpsWsW/rPhJHPeJ0js7gxix
 IfR6QGFRaGC5oP4QxTkFLtNwywFXJugpt3hvSrrgUogvrzgSe2OMfcrR3kefJNPO5CVC
 JpXm0eEZG1qpIC7TJN3dfUeYV6BuCAFzoHMb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726812197; x=1727416997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GpGPzOOCYQ/vCo6VwUV8dBYiESDG7tZZGy/7UH0RUWU=;
 b=OtiUoyeovkdR4TJsA78g20n3gXd8KSZYy86voj4SJrUOObal2QOXWrHmWQkohzd94T
 hOCR0ovnkP62du64QKH8DQHY/RtWZb8H3CJVdolck0Lq9ke/J3R4/ymRAutYDxL/Q1Vc
 sK8pldH2OcoMctDkaEprmoXNHyO4NpGXwPq4a2Aj6t1NZbg4tvOGcjMwlNiOtOpJ8JhE
 nExhwz4lGO5E7uBCDlZA75HeojjT/plgl+IL/YivSs0MhbESf7WgI80MF+o/hm91Z8O0
 yJq0Q+I7Ms9xKqBUYo0oBvVjBp1FiAYa35AX/eokDgKkl/hTXMdsDTnjTnhtfS9cA8/X
 V0qA==
X-Gm-Message-State: AOJu0YyBb3kYZmKFb6cKC/6n1VKVXgrGcZ5xMw24DVYQK4gKJUYOjc9c
 mn8kcTNj10LySOj0cBE8CiKHdUi1QePI668fJgLZHncsEb5haqxaBYBZ9YF1zwjYRlJaABHc167
 Z8dxJLFs=
X-Google-Smtp-Source: AGHT+IEljbTXPUFjcnhfSZ+8qlxAis3HsdUYrXVxAUP+m4fC8UwsQS6iHMc4Ff0Q9yaWZm/7gjFSGA==
X-Received: by 2002:a17:907:c894:b0:a8a:822e:44c6 with SMTP id
 a640c23a62f3a-a90d55e1025mr132588966b.4.1726812197023; 
 Thu, 19 Sep 2024 23:03:17 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df750sm796420666b.160.2024.09.19.23.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 23:03:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 17/19] test: Add a section for closing the connection
Date: Fri, 20 Sep 2024 08:01:52 +0200
Message-ID: <20240920060158.106612-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920060158.106612-1-sjg@chromium.org>
References: <20240920060158.106612-1-sjg@chromium.org>
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

This can take a while and involve multiple steps (e.g. turning the board
back off). Add a section for it and show the output.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_base.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index f610fa9a6f8..b279d95dea0 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -183,7 +183,10 @@ class ConsoleBase(object):
         """
 
         if self.p:
-            self.p.close()
+            self.log.start_section('Stopping U-Boot')
+            close_type = self.p.close()
+            self.log.info(f'Close type: {close_type}')
+            self.log.end_section('Stopping U-Boot')
         self.logstream.close()
 
     def set_lab_mode(self):
-- 
2.43.0


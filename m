Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F4EE677E8
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 19:38:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A56589102;
	Sat,  2 Nov 2024 20:37:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HGfR6l4Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E4C8890DF; Sat,  2 Nov 2024 20:37:35 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 351CB89110
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 20:37:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cbe90c7c95so22548996d6.1
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 12:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730576251; x=1731181051; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=we6v1hQgn2dwF+/BfxJEAgxuiuKVQYhJp6sBEr7K1gk=;
 b=HGfR6l4QGxuGLjVK5UHUKMbCYNrIzKp+tK5Z62FgXFXnhXOc3sOg/NePp8vZ+Jt1uu
 tN1R7BPY+kvPwpujzMwssH/J7raY6A2bDw/Iplo9pMLw3bXLbBB4cG5h4vn1iyU3NvkO
 ZEKj6186VHQFcx6k2IGAZwQAUFdr5U52eJLTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730576251; x=1731181051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=we6v1hQgn2dwF+/BfxJEAgxuiuKVQYhJp6sBEr7K1gk=;
 b=SMGZBabF7cJBJUKtrqi0LOlh9d/W+AfepTVfOwBp3oR6fBd9JnsJMXRR94GOcAgE9z
 VQct0fTEkiI7bz8TSAVrmWE/7+WAb7U8I7rEhD0YGgSkLBlx2ZlOdSzqxYY9TbFs2N3N
 kU+rAp0CILmqAeU17wSy+S0+H1ESdqp891vTind++zd+f89BYrP9d1UdZct8K55BZqjm
 xYvRuACgxvqk4qX0CQG1/5xmUdKJqGWlbkWvN7mUeFPQC+ZmOtLcKFwME98HMpEP7ngG
 RwK5ilYIgRDnJ5f7OVmKeKFCq7wWw32ZjSP7R6WS10h+VnAQb16XL9lwwggTWUMe5vb7
 m7cw==
X-Gm-Message-State: AOJu0Ywa+x4yfnJX1aMoC2NCosWP+tHGfKp7UmAuYRL1sXOLGbTre/Dg
 8NXcFyhG9Q0iBEoJCozGxw5ThPtyjwRiBlSnK6L3mkKaJPHn80MdYZTbfw9fpJzJxM6RDZJenWn
 RHj9V
X-Google-Smtp-Source: AGHT+IGDyhl3/7ANIQPleVSXm+lpPwE99LzEzTZdBz6M1Gw+E/A/e3IufvEJRgcSe+IqanyeG8pNQg==
X-Received: by 2002:a05:6214:5401:b0:6c5:1fe5:f84c with SMTP id
 6a1803df08f44-6d35c132068mr136010496d6.20.1730576251584; 
 Sat, 02 Nov 2024 12:37:31 -0700 (PDT)
Received: from chromium.org ([165.225.8.161]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353f9dfeasm32324976d6.14.2024.11.02.12.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 12:37:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 04/20] compression: test: Move test into lib
Date: Sat,  2 Nov 2024 13:36:49 -0600
Message-ID: <20241102193715.432529-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102193715.432529-1-sjg@chromium.org>
References: <20241102193715.432529-1-sjg@chromium.org>
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

This test doesn't belong at the top level. Move it into the lib/
directory, since that is where compression is implemented.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/Makefile                | 1 -
 test/lib/Makefile            | 3 +++
 test/{ => lib}/compression.c | 0
 3 files changed, 3 insertions(+), 1 deletion(-)
 rename test/{ => lib}/compression.c (100%)

diff --git a/test/Makefile b/test/Makefile
index 5d62b5c3357..ff621344a03 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -10,7 +10,6 @@ endif
 obj-$(CONFIG_$(XPL_)CMDLINE) += cmd/
 obj-$(CONFIG_$(XPL_)CMDLINE) += cmd_ut.o
 obj-$(CONFIG_$(XPL_)CMDLINE) += command_ut.o
-obj-$(CONFIG_$(XPL_)UT_COMPRESSION) += compression.o
 obj-y += dm/
 obj-$(CONFIG_FUZZ) += fuzz/
 ifndef CONFIG_SANDBOX_VPL
diff --git a/test/lib/Makefile b/test/lib/Makefile
index a54387a058e..ce22780eed8 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -2,6 +2,9 @@
 #
 # (C) Copyright 2018
 # Mario Six, Guntermann & Drunck GmbH, mario.six@gdsys.cc
+
+obj-$(CONFIG_$(XPL_)UT_COMPRESSION) += compression.o
+
 ifeq ($(CONFIG_XPL_BUILD),)
 obj-y += cmd_ut_lib.o
 obj-y += abuf.o
diff --git a/test/compression.c b/test/lib/compression.c
similarity index 100%
rename from test/compression.c
rename to test/lib/compression.c
-- 
2.43.0


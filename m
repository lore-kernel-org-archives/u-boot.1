Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6194FD10C0B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A93AE890F8;
	Mon, 28 Oct 2024 13:41:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hzqirQD+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1C15890E7; Mon, 28 Oct 2024 13:41:46 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 192CC89099
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:41:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9aa8895facso690022566b.2
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119303; x=1730724103; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/J0HVMaWx0G/dXH/zzshguECbDtEAfphEPAV17Xbqnk=;
 b=hzqirQD+X7Ms3P2BM9EDf4m0Ciu8y337B0LIesaHC4jnxAHdvTOwXyTktjcGoqtjuD
 9pUnYRZDXcqFDt44wlDAyJzpyUaBaD8zFotOfl1409ySVyYuMy8QdcIG17TaHSIMe6oQ
 33QczAElDINISIHPe906k+dWxRyolQ0ZbyNkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119303; x=1730724103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/J0HVMaWx0G/dXH/zzshguECbDtEAfphEPAV17Xbqnk=;
 b=uIUS+rJaa/PmPBKmtG1KzuzKv/n174VqirGlQ6XeHWYTtwYxfGhJEx3qIGhVHWNMXn
 kmAgw/St9f6Ho+cXVUfXKVKa12Ltp2mANghdkhtcy6Jx0UH0OplghbHBznOBJ0ZxrOnb
 nqiQV4QTbaPu2aVmGrFDHIjl1x1NnlwDINj8jiqEumjTtA/ykapFBn5/m/Z0CRaFKXhH
 V+ug99+oZlzI8uIxNyeniwElSOPArtbreoXDyIqWNXXrc16CoufUXJzCePQ7+bbAOh5I
 P1SnoUMpA2q5q1EmS/QHOAHzMYuOIuicLyPB+HLgsKL9s+u8CTG/RRCK6kieYufuv7iL
 vL3A==
X-Gm-Message-State: AOJu0YwQ47xBXlJdSiqKcjdmspbhDOlouzHCuZ8bXmMr+F9OkSm56yx7
 cVrmGeFytl1O9aJlw08PFIJ7I0abrwKEmvwPBLLtiEk3qq8tIOjZSLkP7fOKgck0YzoQs57ZR1z
 gQw==
X-Google-Smtp-Source: AGHT+IEC6JgQRH9ZNER6COB8/eLGIvmJkwBt6inW9nVKQTxkqo7mCP+tV+TS4kT9pTnFNxkOTBi9pA==
X-Received: by 2002:a17:907:9446:b0:a99:f619:d365 with SMTP id
 a640c23a62f3a-a9de5f6e257mr666512266b.30.1730119303555; 
 Mon, 28 Oct 2024 05:41:43 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30c7ae0bsm375313766b.156.2024.10.28.05.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:41:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/21] compression: test: Move test into lib
Date: Mon, 28 Oct 2024 13:41:10 +0100
Message-ID: <20241028124130.32072-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124130.32072-1-sjg@chromium.org>
References: <20241028124130.32072-1-sjg@chromium.org>
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

 test/Makefile                | 1 -
 test/lib/Makefile            | 3 +++
 test/{ => lib}/compression.c | 0
 3 files changed, 3 insertions(+), 1 deletion(-)
 rename test/{ => lib}/compression.c (100%)

diff --git a/test/Makefile b/test/Makefile
index 2beff431899..fcd73f0b472 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -8,7 +8,6 @@ obj-$(CONFIG_$(XPL_)CMDLINE) += bootm.o
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


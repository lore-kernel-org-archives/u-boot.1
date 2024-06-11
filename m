Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7522BC27C78
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 18:51:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B6A8886C3;
	Tue, 11 Jun 2024 20:51:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I9/ZNrJ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 815C888655; Tue, 11 Jun 2024 20:51:00 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3429C886F0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 20:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3758fa1cc8eso5935305ab.3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718131857; x=1718736657; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gzphbr2pP9g3BOAlvOazn7ALDC2a4CbPCa3cxBNHEaI=;
 b=I9/ZNrJ0yOT0juGsO7Wkwa8Ip6kI+AaST08rrVqESeFLib+npLPm5tCu8JGXk+f3LT
 6aGkHgNeua4/ruOtihqg5usHaZz8J/qXM/GF0oxBsrS4gILQCfgINP8nbxvYTbUb3fq7
 iOixc0iPMyer5nJR3VqMWsQ18Ql85XCXB9p3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718131857; x=1718736657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gzphbr2pP9g3BOAlvOazn7ALDC2a4CbPCa3cxBNHEaI=;
 b=XohMqEN5h3r5zfLf0ovoNCi/OqHHsC+LVu8ao1Oi16gJ7N2cgpV8+wBuPZkiXn41AO
 Cpd7dh3900ICmrl3mlDz66h6Rm0TPWKqO1//Mq8pWR0twB+D1bbCBvGyRIsW+9aQ0WfR
 rSCy6XxJ+aLOzktLowRhYaN4yrO7qR4fAPjtwCHuwZbDWbWOrLxJHJkp2pr5/f7wqWDB
 Drn/mK3RUevsXL8FOGCi3wP4i7V/tn6IScZH9sNqXVtpwqnQ+kDeh5j1GhH0m/4GAPtB
 gWruyLk+HX86+QrafXkc1C9E+nuiGHvzuLe6oLVX8JGG0r2nyhInlpHx0jd3+w1VoKZS
 Mvkw==
X-Gm-Message-State: AOJu0Yw5lWai/dK7RXH/7X0p14Y5wGWCZ2ccJ7gcXobemyUdAV5Zlwbi
 m/klOislBuOZI0vdijSwt89fv2BR3WcK73suzOAD0t4GVQjQcp51GnE03SFq3Fu2hRtgZcOTASN
 6LQ==
X-Google-Smtp-Source: AGHT+IGH+5mDSIsp9f2AJmL3Ys0h29hGEzLMfIzWmrpFoMEhNN9GCskrxfP6BjF/V6DlY6ArzDWWag==
X-Received: by 2002:a05:6602:1545:b0:7eb:6e1e:8882 with SMTP id
 ca18e2360f4ac-7eb6e1e8b5bmr1369866939f.13.1718131856809; 
 Tue, 11 Jun 2024 11:50:56 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-37594285ca5sm19645715ab.42.2024.06.11.11.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 11:50:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bo Gan <ganboing@gmail.com>, Eugene Uriev <eugeneuriev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Shengyu Qu <wiagn233@outlook.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/4] malloc: Support testing with realloc()
Date: Tue, 11 Jun 2024 12:50:48 -0600
Message-Id: <20240611185051.2223452-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611185051.2223452-1-sjg@chromium.org>
References: <20240611185051.2223452-1-sjg@chromium.org>
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

At present in tests it is possible to cause an out-of-memory condition
with malloc() but not realloc(). Add support to realloc() too, so code
which uses that function can be tested.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/dlmalloc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/common/dlmalloc.c b/common/dlmalloc.c
index 9549c59f358..65b130fabcd 100644
--- a/common/dlmalloc.c
+++ b/common/dlmalloc.c
@@ -1758,6 +1758,10 @@ Void_t* rEALLOc_impl(oldmem, bytes) Void_t* oldmem; size_t bytes;
 		panic("pre-reloc realloc() is not supported");
 	}
 #endif
+  if (CONFIG_IS_ENABLED(UNIT_TEST) && malloc_testing) {
+    if (--malloc_max_allocs < 0)
+      return NULL;
+  }
 
   newp    = oldp    = mem2chunk(oldmem);
   newsize = oldsize = chunksize(oldp);
-- 
2.34.1


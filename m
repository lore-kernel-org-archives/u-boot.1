Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418FCCAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 21:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5BEB8380F;
	Wed,  1 Oct 2025 23:30:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JvWOP5x9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7966D836D3; Wed,  1 Oct 2025 23:30:02 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4144B83741
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 23:30:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-424d3c1256fso1579595ab.1
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 14:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759354198; x=1759958998; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VrH/GcFvxMUnvTTOY+6TpBvkpgBUSgnlgQ1RsvbBDOA=;
 b=JvWOP5x9KPaQDuiFBD7DRavCRGou/+LyRvE0p+ZPS8HnTrv5bNI2M4ZDZFofypL9vF
 flgm/pL4RCJRQeIriuKt328vUc9BlNKOdUK2PoGV8R8MdUKJTtBfcpjfLdjTrPJ5aujF
 rnRho6CPMRg5+5v25N/+fgpk/RX+j7htFjX84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759354198; x=1759958998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VrH/GcFvxMUnvTTOY+6TpBvkpgBUSgnlgQ1RsvbBDOA=;
 b=NDXco+HSepy2BbqS3EtAczeX4Mzj336ji883xt/zi5Wgn7ucywrV5y07HSGDv9g3rR
 CCqkvnhSMbxwvMzOnHtBe0oWKYMvFQcOFk9W1Oao3Tseyc4NEXB68gIoluPEK8rKX6Bt
 z8FCW+sAgSzlN6IZDrfwEsBxyYLLS4qa039QJJL7e18gcSseKdJ6SH9wA9BpXkoRUjb0
 4jDfVaP3pQyAT6hTs+SfQID0McODIYkSpnBeNKvK7ZKrU8osr7BUKpP1wIewG6ZCJVgN
 YLc+leKPJvJeGoPC7MnKNmoUJjFvD1ZrbOjdHLHcz4K4Y+aT41f1/U6ZUDxnw5LGeHpX
 /VIw==
X-Gm-Message-State: AOJu0Yy1k5mN+0ILbPUtk/gti8V6SivcZLvagH4J9HuG+jbqajchxZ0B
 6vvaH+ot/WBcJaF2FvQV8xLkcw82/7GSIuBIk3BJ79tMFyEjECDDxFGyPTzef15puoZ33u1cfi0
 tyBxJE4ec
X-Gm-Gg: ASbGncti6FwVC3xxGPTE5EjTNT0k+H+WG1jcJlnnv+SKy7Thl1DEM7wEVtj2vC3xlWu
 aBnkdzI2nzYow65K8rUMzU64iNfypU266on0xMKVEITsKtj7ya35nV9iUddFOfZmik135Bz3/ck
 D37tNu2DWqG2G/zISeZC2d+gL7zMg20YSt6umgrT+T5w7hzuovLYfNtJYPRKj6LTr/Oe8nSLbiy
 npT/bCl3jEK9hr73FLM1q1NbGfLMAEVhJk+Gb6Qe30P2FXlDLxQkSi8XUDr3q1CVZt126w//ISz
 rrzvzH5r3Yc5ivt9Er5BL7QTt9bDjSGfpDrKlCMcBOkLSLFDedTlTI4bkEYWQzYv3Dz+Y8pnL1s
 OxN26TGj93gsdC9osGTV7PGqu/IxOR3kNmPwmcv59
X-Google-Smtp-Source: AGHT+IFri8xz2xlBNoMbnW9IkYrk1z6M7cv6PzouxOVxyTtJrwg2Rtm/fCX3w6ze58VqtDF5uztB9w==
X-Received: by 2002:a05:6e02:3104:b0:424:4bc:4b33 with SMTP id
 e9e14a558f8ab-42d8b1a4771mr15990955ab.1.1759354198400; 
 Wed, 01 Oct 2025 14:29:58 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ec09429sm202844173.55.2025.10.01.14.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 14:29:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 15/17] boot: Run global bootmeths after all bootdevs are
 exhausted
Date: Wed,  1 Oct 2025 15:26:40 -0600
Message-ID: <20251001212649.3263574-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001212649.3263574-1-sjg@chromium.org>
References: <20251001212649.3263574-1-sjg@chromium.org>
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

When there are no more bootdevs we should still go through the global
bootmeths, since some may not have yet been used, if their priority has
not yet come up.

Add a final check for this at the end of the iterator.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 1070ed542ce..a57272b7100 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -417,6 +417,18 @@ static int iter_incr(struct bootflow_iter *iter)
 			return 0;
 		}
 
+		/* if this was the final global bootmeth check, we are done */
+		if (iter->cur_prio == BOOTDEVP_COUNT) {
+			log_debug("-> done global bootmeths\n");
+
+			/* print the same message as bootflow_iter_set_dev() */
+			if ((iter->flags & (BOOTFLOWIF_SHOW |
+					    BOOTFLOWIF_SINGLE_DEV)) ==
+					    BOOTFLOWIF_SHOW)
+				printf("No more bootdevs\n");
+			return BF_NO_MORE_DEVICES;
+		}
+
 		/*
 		 * Don't move to the next dev as we haven't tried this
 		 * one yet!
@@ -528,6 +540,17 @@ static int iter_incr(struct bootflow_iter *iter)
 			ret = prepare_bootdev(iter, dev, method_flags, true);
 	}
 
+	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && ret) {
+		log_debug("no more bootdevs, trying global\n");
+
+		/* allow global bootmeths with any priority */
+		iter->cur_prio = BOOTDEVP_COUNT;
+		if (!next_glob_bootmeth(iter)) {
+			log_debug("-> next method '%s'\n", iter->method->name);
+			return 0;
+		}
+	}
+
 	/* if there are no more bootdevs, give up */
 	if (ret) {
 		log_debug("-> no more bootdevs\n");
-- 
2.43.0


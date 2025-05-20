Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE95C3ABDA
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 05:24:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4006F82CF5;
	Tue, 20 May 2025 07:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GafPnXC9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B5E182CF4; Tue, 20 May 2025 07:22:45 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FFB282BD9
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so53957495e9.1
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 22:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747718563; x=1748323363; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P3VccfpBjmUTArAx3UopilQt/lVGZQhEuWcUfxFYEHI=;
 b=GafPnXC9td8Pq3IY+xYzper6mxuuzNCidsLVbM6EtvmcM84nTjGEpq8GFLwlEu3l30
 trFT40UZBDLYhjzXHzJhYGU/1MCweMSHWUysR0/SdWDxEQTUGHJ4x1IE/ACBTDjsRxHf
 Xwf66i2B7mxRnoDH1/AedIyjpYryRZUTqDNvtCgZkp6gkQpg4MHD/LkB7uxdxoW+0teK
 /DhdzwS/CI1UngWFJ8E3coWF6sDaxfMioXl/n2DEZlPMzZLtFIDf4GltK539dXfuXpFC
 +R5ajyqRwUv3K1lFDhDEc3OL6ECoOatTJgKaej5EwupnR4gSxvbrJ1BEd+yx5DoYIN0y
 WDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747718563; x=1748323363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P3VccfpBjmUTArAx3UopilQt/lVGZQhEuWcUfxFYEHI=;
 b=scWWsL02V+qtk/q1N/FnnidJ586XlCWVFKSS0cDK2BorauuqfhyfHyn810GA5/UJ7H
 n8TLA67XynTErsjFWsBvxn2NfIVTf4Md8ZloOdDr+l6dNJaQ+nNmt83WPfz4H2uOza0E
 YPEzVkI5O9IY1E2jlkFw+4Lq/SyokeB72TJkSFLMgVfUfSpUVp1wb5eOjSGKSL+AQaBi
 MSEdgYSDIT52HPnFW6628mV13A+ETqUmYKl/F9ZSj3HQRVBdGLkw/1CN/+JgbU4xrrBN
 W/s9/FmUWse0eiwyqrC43CPZysmN9i+FmOZGruMvnAR9+J8VYp/X2Yfrhn/U1aGhV+QQ
 3pRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtfwjnsjBAoRyB/Ur3829+ry5yTyUums9pczaz+eTucF1RXaU41OiWXxI1R9j9a84W00CI76c=@lists.denx.de
X-Gm-Message-State: AOJu0YyKsseWhxGP8SDG1LD0hvjlqIP4DK5DOr8zGvo9xppyS9xjCiAJ
 /QiEqc8KQs3UXn5HsWndQMkEorYnJ9GwlYRSxpG8j13rZbvICCjanrQt0VXZPy11Z9k=
X-Gm-Gg: ASbGncsBSNW6Q3T5efpJg/UfI2u1ox7y3jsEx4ljTog3sAZ/p/OMfICbMXw1O27Bd4T
 D9u9XN+gJfbWqezzuNLKMs4ZV5nfSgUbHpD7202qI3q2p/T3ES4pds/xu0gBMHx/xGHjbYvaS0z
 Za1gyJ8BeOIGe1ThY6CQy9FJ4WWbqD3OBBIpWjdGn6macqfnfBWUkk5ou3H4xRavcbYxLjc2RFW
 6cUSGU++qppH7D0lsSz+m3iNvrMz8WhRle6Tyep4SqRsYF/tmy4aGOS9ageZ5t3o6d460rhFuWL
 pBF24EJzuMSZvQh50lL6lghkj3KUqyA97FCC4gE1r4XH9kpxTSCBkVOlpusfY8KJKV9sUvrZ2vA
 =
X-Google-Smtp-Source: AGHT+IFqq4/VQsPukpsfsZbK2FHa8rnuOUKWBCFnmFj1BHQ2yu+EpbHmjssizcMgmyGjuUX+ieLHBQ==
X-Received: by 2002:a05:6000:186c:b0:3a3:6a3f:bc85 with SMTP id
 ffacd0b85a97d-3a36a3fbee8mr6971237f8f.25.1747718563021; 
 Mon, 19 May 2025 22:22:43 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889e6sm15100762f8f.71.2025.05.19.22.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 22:22:42 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: [PATCH 18/24] kbuild: refactor quiet_modtag
Date: Tue, 20 May 2025 08:21:29 +0300
Message-ID: <20250520052153.307194-19-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
References: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
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

Backport from kernel
commit 45c4372d00 ("kbuild: refactor quiet_modtag")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 scripts/Makefile.build | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 29446298041f..ed58bcab291e 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -113,18 +113,13 @@ modkern_cflags =                                          \
 	$(if $(part-of-module),                           \
 		$(KBUILD_CFLAGS_MODULE) $(CFLAGS_MODULE), \
 		$(KBUILD_CFLAGS_KERNEL) $(CFLAGS_KERNEL))
-quiet_modtag := $(empty)   $(empty)
+quiet_modtag = $(if $(part-of-module),[M],   )
 
 $(real-objs-m)        : part-of-module := y
 $(real-objs-m:.o=.i)  : part-of-module := y
 $(real-objs-m:.o=.s)  : part-of-module := y
 $(real-objs-m:.o=.lst): part-of-module := y
 
-$(real-objs-m)        : quiet_modtag := [M]
-$(real-objs-m:.o=.i)  : quiet_modtag := [M]
-$(real-objs-m:.o=.s)  : quiet_modtag := [M]
-$(real-objs-m:.o=.lst): quiet_modtag := [M]
-
 # Default for not multi-part modules
 modname = $(basetarget)
 
-- 
2.49.0


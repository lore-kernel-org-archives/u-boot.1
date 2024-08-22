Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B67FC52D6F
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 02:59:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F4B788EAF;
	Thu, 22 Aug 2024 04:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hpoi7xBJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBF3388C87; Thu, 22 Aug 2024 04:56:56 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C0C488E83
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 04:56:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-8252bc7b00bso13583239f.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 19:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724295411; x=1724900211; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P3HVmecpAcWUSprJ1UET/bULvC4KM3/4jLbvghsozKM=;
 b=Hpoi7xBJwBjUjnY5itgeES5YsGkPTbPz+tCL7nDvJ2+5yyz6sp+iSaSsZlUglf0C4Q
 AHbHpj3ccli2AtJKII/tWMhcn/5M6bY4sJXSIBAjxkkr1tt7waxaHzViDrGSTJV2n3Co
 1ZjfscWU0OU2RsJJUiuCTpfJaH4WkNt9AXwPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724295411; x=1724900211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P3HVmecpAcWUSprJ1UET/bULvC4KM3/4jLbvghsozKM=;
 b=rVkq7ci5fABeu+h7om1Una9RSD/bk0wZVmjb53e793+dGP+lfbR/n2bLjFJBtJmF1o
 oSXHgtg93JU7A/K9YfVLz3k6Er/a1hU9pxf7vz8awTejBQ5b3GD5F1f50Zyd3QIg9fB3
 TdAmCmrTQKb5Mes+MA95RagIvnKc/isCFTYh5aRkPusyTKpjngDt6z0UcG+OHaD0yzap
 4rsx7plLqhuccOl9FKlNc35Kw6iAjev9DQ+galvgSP1uauuFtHhsT/4eWIPLT342Y5WN
 NL3fSiMoKkJ5K98fskOANrIZhpSmWK0ULC33P0nPRJA92ZgDYkzzdT1XTZJcKH/mJEQP
 F7hg==
X-Gm-Message-State: AOJu0Yx63HIdnftU5mngAixdHx+SwwXzkwJ/P6AwicwstF+D4UYJswZB
 3GqrbKwtjVd/vyvbNv4jeIlSWejTCsJA7dwUeZqSEsJPGjRDca5pMmEx2WEiiPaI2sNJIsG5QUc
 =
X-Google-Smtp-Source: AGHT+IGuV4Maci5m5QQTaQcp5sHJm9u4A03cguTdaLslkDnDAaITauCmODxneLErb4+Xh9E5pH+PVQ==
X-Received: by 2002:a05:6602:1544:b0:81f:aad8:be08 with SMTP id
 ca18e2360f4ac-825a5a0912cmr56633739f.15.1724295410753; 
 Wed, 21 Aug 2024 19:56:50 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f200a0sm209403173.27.2024.08.21.19.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 19:56:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 15/19] test: Fix mulptiplex_log typo
Date: Wed, 21 Aug 2024 20:56:27 -0600
Message-Id: <20240822025631.1838434-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822025631.1838434-1-sjg@chromium.org>
References: <20240822025631.1838434-1-sjg@chromium.org>
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

Fix a typo in a comment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_base.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index e2e78179555..f610fa9a6f8 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -123,7 +123,7 @@ class ConsoleBase(object):
         Can only usefully be called by sub-classes.
 
         Args:
-            log: A mulptiplex_log.Logfile object, to which the U-Boot output
+            log: A multiplexed_log.Logfile object, to which the U-Boot output
                 will be logged.
             config: A configuration data structure, as built by conftest.py.
             max_fifo_fill: The maximum number of characters to send to U-Boot
-- 
2.34.1


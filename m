Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF123C2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 13:41:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBFFA88677;
	Mon,  1 Jul 2024 15:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N5h+DOi6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3203D8867A; Mon,  1 Jul 2024 15:41:09 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D79D8866B
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 15:41:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ec5fad1984so41845031fa.0
 for <u-boot@lists.denx.de>; Mon, 01 Jul 2024 06:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719841266; x=1720446066; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VKEh7HUBwLXeRoaIGUOuL4GKkBdtzGSnm3Sf95BXqJc=;
 b=N5h+DOi62sQzdXWywUwz/aIN0mhkXG9vvPk0SmyPvKjEaDHFUYOxhaFcgPyk8roMX2
 I88AHdujIBPl6mtffe737RJ06iW47cT3TWm4QHSXKSB0/iFL8tP7wNjN3xrReOb3rH1m
 fchfOkrvSTnga/iv/ex7WkIFkmktd3xhTLc30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719841266; x=1720446066;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VKEh7HUBwLXeRoaIGUOuL4GKkBdtzGSnm3Sf95BXqJc=;
 b=gzrslfJi4Y1VwVZwHy7oeYA+CsttN6yxFw26/1zNZq5ayhrQ3rjtuO2BcMzULbsAoE
 H+Zx26EllmEikZ9wPrRhzthdxlNB7bYpwgD69l3PwBMrQD1J+DtPn6XplQL2VaQOwGjI
 lM+wJoJJ5xZHlNRHkZ+oxbytUpnEBeHDhTlu1l2CICU83cKX8KgB9/kAThLRiVltE2OX
 rio4GCxJs3x/B571xrKSrqEhCkAiNYWlz8Pe4zlbUXEJErXT2YzZJkWzfpRCJD6rSO98
 Xt6cZ1YuzqjUpmucJey/7NuZcifukvmVgxhMsce0Z0WnavJIxDMEVcQzDRXIdxJ/dEGP
 zW4g==
X-Gm-Message-State: AOJu0YzXTZBbH80t0E45h3UCNjb0zQZRdDDAfkUQAFD4GfkF7UkSbTpB
 gsTc0dHx8h2oA9aO2jNK9EYJJQw9buXAklNuTWxI0XlBUM58rXhYzDMUT/J7tMAanqC+KoLSjE0
 =
X-Google-Smtp-Source: AGHT+IESF1XSsaugTAZmF+UkrAdLSTmO+bJieMUdSUP3PnBS4TfN9rTEDE29YasnSwItHN9TxOJREg==
X-Received: by 2002:a2e:300c:0:b0:2ec:4f01:2c0f with SMTP id
 38308e7fff4ca-2ee5e3bf062mr45288051fa.26.1719841266062; 
 Mon, 01 Jul 2024 06:41:06 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b097bd6sm156866445e9.30.2024.07.01.06.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 06:41:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] binman: Update cbfstool
Date: Mon,  1 Jul 2024 14:41:02 +0100
Message-Id: <20240701134102.1465810-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

Update to a newer version of this tool, from December 2023. This runs OK
with the current binman tests.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/btool/cbfstool.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/btool/cbfstool.py b/tools/binman/btool/cbfstool.py
index 29be2d8a2b5..b7c64b90ffa 100644
--- a/tools/binman/btool/cbfstool.py
+++ b/tools/binman/btool/cbfstool.py
@@ -215,5 +215,5 @@ class Bintoolcbfstool(bintool.Bintool):
         if method != bintool.FETCH_BIN:
             return None
         fname, tmpdir = self.fetch_from_drive(
-            '1IOnE0Qvy97d-0WOCwF64xBGpKSY2sMtJ')
+            '1KPR41-fKHPqlMCVsfMl2xJcyUgTT_6YI')
         return fname, tmpdir
-- 
2.34.1


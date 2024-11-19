Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E3DD6C2BA
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 00:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6734D89601;
	Wed, 20 Nov 2024 01:27:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X6y10ah8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DCD588FDE; Tue, 19 Nov 2024 23:29:03 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80F4388BFC
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 23:28:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-382498034b8so246827f8f.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732055336; x=1732660136; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OCzSlbdXFYnNxuKoxR0sT8fnRqnitdGwDs9OztjiR5c=;
 b=X6y10ah82QLc+rnJXxH0YPU+cSFv5fpWXblKy5qMXL7iVlDS5vQIbGtdb1nzp5Ac8a
 h18XDQM/2U3nz5kA3hh0em9s/fHe+nDwvGerhKs/32NF0rkCDoEcqMTmcXj78iFoVkEX
 jGOlW6QnlywX6O3Y4TajEqJiUg/Ur0KuKpKGT+TtKpkcTG7qOEXTk7i2KUdDmi7SS0tE
 v7u8TMgN4YL4BUVIfW1RslzAFIvC5AgFA72cIvH7hTunPlAzfUDrRvnvCCEjqh0uspul
 +BONHd0t2BzhhlpMwWXvEbi5kz7CXVA7jZfP94WXDyGr4HOaA7M7EcvV7DYsHzoyGwk6
 3+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732055336; x=1732660136;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OCzSlbdXFYnNxuKoxR0sT8fnRqnitdGwDs9OztjiR5c=;
 b=nnYXStKtbdUeqTPG2yUQnEAUMcFkjX3NVdW8CC9ecpqTSEioJ9IVJszd/qY/xqGtmh
 5+GyQWHsUTeScMLAiO/0Trth48Qc3sqNo9JSrkg2QDHWHUA/XgbJH+KBwRnj6x4imLIO
 XX1vbKBzLW/aFpjWydCG+45PpPzM8w8MK/nI8//Oo69qv/myMMRNGIxsHtQNKiePECYW
 ImbGvwjcbPoF2xZA9JVxjRXeH1I8xZ8WrdmgFcEsl5sAF0/ir57PjVxfmuCRjJ/gLc1x
 Bk7TbrvYb9vhrKmcG4L0Jmj9/Zskka5Bo+sgm7Xy1zy3goN79pifG8maoAePgy8dLMq1
 2SNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQETf7zkxe+F4I5zZALkWHc8JYALFQBMQCU7chpk0hbwL82dRKWbcr38gMdOqPXifmaNo9p1Q=@lists.denx.de
X-Gm-Message-State: AOJu0YxJ/95Ka8y7g/ivbIQZdW8OfBdIb2mJz89H7cBA3BfyOC1ewF5R
 pkAj7b756ihbLrceGLETVZiSYrESa2WhgjiP0AWASiWzmirOKTSH
X-Gm-Gg: ASbGncuX3tOlmGDLJYQ3Xy5+9DmIpEj0d4BtF5AgBCyqJgNI80g6V4IbH5QadCHGYK+
 z2zQhkryKvFk2iT6CGHSlfwDmIFgNG6cOF9NSbIJjLY2mxylZ7GSi2z27Y98yyMUI96ZWN+Gu9D
 +Z1+NfvHQciZvfMMdYZkasyQQk97zjH4mFunq+eOagGhcUwfa7FvPrpAj10VDVktqwNlMQElC/O
 yfYI7XUf9/0hrp4rcjn+BRwWARwigZH6tGeZBzzx0he7l/65cxCod8GXAYTp5f81YH7QvwFQPZf
 HNUUqle/cvsdtVsa5D8D0Ysky2pW
X-Google-Smtp-Source: AGHT+IEFRCH1JA3bq6lwfZzyiKjm3qh2Sm2SZ01K6sMQNpxjjUMCeK9wDYk+6lEeMl9NfOpmchklBg==
X-Received: by 2002:a05:600c:4fcf:b0:42c:aeee:e604 with SMTP id
 5b1f17b1804b1-4334f030467mr2107385e9.8.1732055335754; 
 Tue, 19 Nov 2024 14:28:55 -0800 (PST)
Received: from d71e1d1a2016.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac1fb7asm208058655e9.42.2024.11.19.14.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 14:28:55 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: sjg@chromium.org, trini@konsulko.com, alpernebiyasak@gmail.com,
 ada@thorsis.com, xypron.glpk@gmx.de
Cc: mkorpershoek@baylibre.com, dario.binacchi@amarulasolutions.com,
 pbrobinson@gmail.com, n-francis@ti.com, afd@ti.com, al.kochet@gmail.com,
 u-boot@lists.denx.de, l.rubusch@gmail.com
Subject: [PATCH v1 0/3] doc: orthographic delights
Date: Tue, 19 Nov 2024 22:28:34 +0000
Message-Id: <20241119222837.27550-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 Nov 2024 01:27:55 +0100
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

Fix some typos and wording in various files. As asked by Simon, several
patches per file. The commits are extracted from my other patch set.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
Lothar Rubusch (3):
  doc: develop: Fix typos and wording in binman/binman.rst
  doc: develop: Fix typos and wording in gdb.rst
  doc: develop: Fix typos and wording in binman/entries.rst

 doc/develop/gdb.rst      |  14 +--
 tools/binman/binman.rst  | 238 +++++++++++++++++++--------------------
 tools/binman/entries.rst | 104 ++++++++---------
 3 files changed, 178 insertions(+), 178 deletions(-)

-- 
2.39.2


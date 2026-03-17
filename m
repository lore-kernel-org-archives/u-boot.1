Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081D0FB5EA0
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 01:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E495184285;
	Tue, 17 Mar 2026 02:24:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R++RNkRq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9550F83FED; Tue, 17 Mar 2026 02:24:51 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92B7A842C4
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 02:24:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d76a331ebbso3349165a34.0
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 18:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773710686; x=1774315486; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y3+jwIGwUrXDoHPBNUl9StB/cj0ZBjx/S3KKJrBK+k8=;
 b=R++RNkRqH9rjRYm87IolD0ypI/SsWim6fNjwLTq3L94Jmrx/m1jV7VCD9iysCETY/P
 /8DkldTezkenVODcYo0pUBWYbdXVKsTTS/Qe1bgxVGJXKUIqaLkIkTsRLrprb9P3YIkH
 lt1rn9Vhk8Q3LlZmJP0LsMWkzGg9gIUBRPxGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773710686; x=1774315486;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y3+jwIGwUrXDoHPBNUl9StB/cj0ZBjx/S3KKJrBK+k8=;
 b=ntbJF2VABXLmFb8madL5Qkwvz9mNuY3GRAq3cuq7mbMtWeuV4LYRWtXBCTqy6zXIjR
 S8SaMf9aX+/ZT0/iZDCCkKVLRjDbBA8C3AE5cl+0VH7y9PmKaACat8m3lhCBJVYlrz1d
 8j95TApke8HNYvb8+eTC+nLmahrs5jNFfbbeyvrW29qS7zMykfLHtpMFMvTm6ZieHb/h
 rXQzv2oJXcOiGsZM3HqkYmSIBJpYEYnLe+E2H8T0ksLgHLx37BbU/XAahonPmGCB8YNr
 Asu0m9HVL26NG8jWqdAXGZMkpSGlztdyQTVJqu0tplLy8ZwingjAeu4UIjQoRLP3aV0p
 iG9g==
X-Gm-Message-State: AOJu0YxBcY7vLU67X9rq3X0jniFFqazmcskN48RkscxyCYesR+iDFZ3f
 8o7BVcv1SB+mPMPOfIsnuk2CGxWWOI3P8GeyDRVkZioJk7SK6yyTPvnloilPe0w9LQ2EZH92BpT
 hTDIhtPE=
X-Gm-Gg: ATEYQzz8EMVtAM7Q2rLjPdfJ8b87Bx43PvM/usMhkFlHDbbvG085kOoUHLVBfxVut5O
 RboOlHiAQ2yLrRvD3sS8gjApStPWcaorRcLhMZ6wDdMs6y0EFjUdofZcK+l/7q52PyAudSpnAzc
 hgfMret3jzCpIgy3rI4WjglndMe8L4V23U/d5+hkApvyzvkdRse2zYhYpL1dR0dHygkyEfN37EC
 tjMVApYxAp8CaBWfTbmALWhr3J6Uqd4Lu1zFhktwKOyz5K0IpOy/mXH1m+XPJqwqHEFfFdBXruG
 TOuomML5k429LRfwC2qDHhLqjme8beJqmLFOF/3qLaxydkGKwLK4k3+sIIbZZ+g1UCwbt28pcHT
 xs97te2D3eejaXRHpbuvWzGAjpELCWe+Hdz+kSC+r8yb5PTftOYGpdOPg3gO2j0dYBgKy2k2cXl
 uOoMFTvwk7Jg5MIQdtURTe35+IBe9ptIo4ZGKByL2tLHvBtQb5C5OYCgnbc0I6u20MOiz/21jR5
 IUeLjIoXHb2WdTbEnP1Vta56xmYCBBRypWZNz7d8/wbu62+Frc=
X-Received: by 2002:a05:6830:4986:b0:7d7:496f:c001 with SMTP id
 46e09a7af769-7d7825796c8mr9675233a34.29.1773710686287; 
 Mon, 16 Mar 2026 18:24:46 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ac898d6sm13328399a34.9.2026.03.16.18.24.45
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 18:24:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] timer: Correct dependencies for SPL_TIMER
Date: Mon, 16 Mar 2026 19:24:44 -0600
Message-ID: <20260317012445.4162614-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

As exposed by "make randconfig", we have an issue with the dependencies
for SPL_TIMER. This depends not just on SPL but also SPL_DM to function,
so add that.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/timer/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
index a84a0dc05396..24c141c60ae9 100644
--- a/drivers/timer/Kconfig
+++ b/drivers/timer/Kconfig
@@ -11,7 +11,7 @@ config TIMER
 
 config SPL_TIMER
 	bool "Enable driver model for timer drivers in SPL"
-	depends on TIMER && SPL
+	depends on TIMER && SPL && SPL_DM
 	help
 	  Enable support for timer drivers in SPL. These can be used to get
 	  a timer value when in SPL, or perhaps for implementing a delay
-- 
2.43.0


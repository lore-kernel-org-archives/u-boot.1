Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E085C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:35:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D0B3885F4;
	Sun, 23 Jun 2024 22:32:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Em33EVXE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DD4F885E4; Sun, 23 Jun 2024 22:32:34 +0200 (CEST)
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1361F884BE
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x143.google.com with SMTP id
 e9e14a558f8ab-3762c172d9aso12775425ab.2
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174751; x=1719779551; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P3HVmecpAcWUSprJ1UET/bULvC4KM3/4jLbvghsozKM=;
 b=Em33EVXElIKW/UMn75KkVKfoxtxMcZgenEyK4FCqK8Gzn2R2CKxtR+efjA7lVOtgrX
 CnzmlJAsHQslTsok9Qy3RNC7b9TYXBEloMAiwtkfj5NtRl4tyBe1grNa0ShTzEJezVqQ
 1IdN+RshcslZBpz109XMx0mONZ4NYDDw0BFSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174751; x=1719779551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P3HVmecpAcWUSprJ1UET/bULvC4KM3/4jLbvghsozKM=;
 b=xIHzDONde3zMS02pc4DXg9tLSHNYk/2wBuhoJndbPnZp2X7YdrII9A8y/HDTb8nmrQ
 w69KARYe85EipAhXYpf4iTyq7cYwEf/N4HhQ/m+nBa45mA06iBU1nq5xva8AbP+udoLO
 tZzHxwAJBqAsQNSYyRtZ+7p7pDfT6yQGjxSEhKV+ZXI0+l2M+li5VAAxCx3v5waBMq3U
 7wJZx1DBP8UBO9BWIZqjzROGxbIs9lRyLGUGM+mwcpg7DqhusZB5QTtwyRHffRV3ixUy
 nCQHpNhwBalPCAmNzcQgBaih/cNgXYYn0hIO0p7Acd3RXOrZuA2IBrmO1/AWUzfGZDwG
 CxMA==
X-Gm-Message-State: AOJu0Yy2VYBVYNuS1NjG82eN9UfAfvXbbN2wgm0FliJlVJyASKjIvbyr
 FIKYlwUdyBLpvOxVrNBtyJqUTfSrE9Eq9Z9sWn608JcFS/K9CpyCEY1KafOevnkuLMTAmEC85JJ
 DLg3G
X-Google-Smtp-Source: AGHT+IEL2orHrNiaMb8mI9Egnwgkl8plbQcU2zjsWpTSxCHUDEOK5rYjXSbAHIRv+XIdxXa7IsVS7w==
X-Received: by 2002:a05:6e02:18ce:b0:375:da97:f205 with SMTP id
 e9e14a558f8ab-3763f6fa7c5mr41765905ab.26.1719174750764; 
 Sun, 23 Jun 2024 13:32:30 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3763374634asm12016765ab.52.2024.06.23.13.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:32:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Love Kumar <love.kumar@amd.com>
Subject: [PATCH v3 15/19] test: Fix mulptiplex_log typo
Date: Sun, 23 Jun 2024 14:32:09 -0600
Message-Id: <20240623203213.1571666-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623203213.1571666-1-sjg@chromium.org>
References: <20240623203213.1571666-1-sjg@chromium.org>
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


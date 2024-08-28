Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57BAC7114C
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 22:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C79B288B08;
	Thu, 29 Aug 2024 00:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lEZWj+7R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6DF588B08; Thu, 29 Aug 2024 00:09:10 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4361888A25
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:09:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-39e6a32ae15so6690705ab.3
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 15:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724882942; x=1725487742; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P3HVmecpAcWUSprJ1UET/bULvC4KM3/4jLbvghsozKM=;
 b=lEZWj+7RBL61q0zKTdtjZ1IXXnj84uHMA68oN3UPCSrNsbwlW12xM+maa/weoxB0xC
 /mMk+q+kxbd8dQtFSCpd7oF1nUXuhSG7rQ66lGm+tSQKBm7je5MyaxXnJ7ZSOhOveq0p
 57dZtP3mpz7TYLS6mwWBv0YB3DVJkeNmxqE1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724882942; x=1725487742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P3HVmecpAcWUSprJ1UET/bULvC4KM3/4jLbvghsozKM=;
 b=WplcAoR+XqFVd1THSWd0ZdzU9IUh0gQL3wftckEK4R5duDz0PdY2W3kxIRsXfD5ni2
 a4Fgu/8ttoGUQJtU9rTd/kosoY60jSGqjRtxSerkMEhEAK87n54MAHOplAJTqUi9IjOs
 tHLVF6nZc2RkG2/b3x3xCk85bxP4uw0bv6TjeUXs7v7Xz31R86nZfqQRe/DdboYxQ2PF
 gCoDbax99FAdN0wzgkB+Q7zMFVEy//obw8E69Wi2gMMKrGUb7LSTQQ3hxrvQtoM6wcNi
 uhbJtJm1TLcnVniQfIp7D0wfqjw1S8ob9mxmT9in5aKv+4JlsYjfXHf9aqwFBl3ncZV9
 ld2w==
X-Gm-Message-State: AOJu0Yxi/JwvS+DTs9cfzTugV51at6bW1Jne5DIyqSYNxg4XzuAm4oac
 MvCJDRz9wDrWbO1Ldx7PMMiRGgMiZvkg4/utwYf+mdllscObKfvmpFIZCdT2wMtf77MFsosF8gM
 =
X-Google-Smtp-Source: AGHT+IFvVfdkp4UlQxkUJ6IqIJgdLPz7BD4aSt4ORrqf8azHdiyL/0IR7vfDPunaUpiUGJpnvjSwlQ==
X-Received: by 2002:a05:6e02:17cc:b0:39b:3c0c:c3a6 with SMTP id
 e9e14a558f8ab-39f3784c70dmr12300695ab.22.1724882941818; 
 Wed, 28 Aug 2024 15:09:01 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f38e683c1sm838105ab.19.2024.08.28.15.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 15:09:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 15/20] test: Fix mulptiplex_log typo
Date: Wed, 28 Aug 2024 16:08:41 -0600
Message-Id: <20240828220846.1205813-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828220846.1205813-1-sjg@chromium.org>
References: <20240828220846.1205813-1-sjg@chromium.org>
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


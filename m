Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6385ECEDDA9
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 01:53:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24F4B88F27;
	Thu, 10 Oct 2024 03:52:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mfBn7lux";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA99788EE3; Thu, 10 Oct 2024 03:52:03 +0200 (CEST)
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D59588F27
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 03:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x143.google.com with SMTP id
 e9e14a558f8ab-3a39ffe34f8so1426295ab.1
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 18:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728525120; x=1729129920; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ik+GEHRfDR5uWvRrY+eIoHoGq5hcyAJ7pLXkM0M703E=;
 b=mfBn7luxiAWyZEA7bj1RmM6CxHOqFk3WuJrZhRlZsD9kFtwlbwDxZg1QmoF7cFM9AM
 5k00PZX43hLwAl8EDsLM8kSHHlqtUu3+S2oS8ShSu4Nlac6kFE65Yz4NOuT0/Hc267yO
 bq+zlZt8zAlWirwifKMLeiKDXFbuUeqRx9EBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728525120; x=1729129920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ik+GEHRfDR5uWvRrY+eIoHoGq5hcyAJ7pLXkM0M703E=;
 b=ubNRUH/qDi9RHyAZ338dVqL+6A4rjuRMCsu1zKOUJIRdhhuwlyOKWXk+lJsSxEI80P
 WB2u8/t0EkGKB5uj/voZ7NN3NJvHA9ghpF8AUN500w9w0yQ7It51ljQyyAjzH6JXBhHR
 R15E0bw30IETu+yNUQV+D/LNwLwEYa8KOffOTiUIiVQu2vJU85k49mq4J9yT/XBcWX7S
 KjhOt/wySQwcPOGgLDO8evPci0QGVYbYxCOunLWWR2BSH9w2TPPVBWQbXhV3ZYk/4k5l
 hBaj3jc7mL94ccE39Xjonsbxa3+FQi/tEHu20q68NybMru0z6S2qhnFDbQ2Y7trsJrSp
 Ft+A==
X-Gm-Message-State: AOJu0YzJBgw32i/L3si9Z+4StlNAkx8BLI2wm9/Y7zJMJ66qutbmLBgw
 9xPpT/5zh216lPMGUGHL5CL+x4mCCAruaUq2qNlq8ra2y/ZZ4B+1Wf5hHUOQv4TchSOmLn44aCk
 GMBjb
X-Google-Smtp-Source: AGHT+IEG3xbrwVMoxtXOHH68K8wRzxP0LeZ4K0YTFEGJuOyRN7jXJwkqZinl0qgZKza8Edz25Q3rPQ==
X-Received: by 2002:a05:6e02:1805:b0:39f:5def:a23d with SMTP id
 e9e14a558f8ab-3a3a70a4785mr12217135ab.5.1728525119700; 
 Wed, 09 Oct 2024 18:51:59 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbadaa947fsm61870173.126.2024.10.09.18.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 18:51:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 09/11] test: Add a section for closing the connection
Date: Wed,  9 Oct 2024 19:51:43 -0600
Message-Id: <20241010015145.1977999-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010015145.1977999-1-sjg@chromium.org>
References: <20241010015145.1977999-1-sjg@chromium.org>
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

This can take a while and involve multiple steps (e.g. turning the board
back off). Add a section for it and show the output.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_base.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index 42c81b2d13f..fa9cd57b04b 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -183,7 +183,10 @@ class ConsoleBase(object):
         """
 
         if self.p:
-            self.p.close()
+            self.log.start_section('Stopping U-Boot')
+            close_type = self.p.close()
+            self.log.info(f'Close type: {close_type}')
+            self.log.end_section('Stopping U-Boot')
         self.logstream.close()
 
     def set_lab_mode(self):
-- 
2.34.1


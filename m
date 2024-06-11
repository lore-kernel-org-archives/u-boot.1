Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EF1C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:09:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B94B8883D;
	Tue, 11 Jun 2024 22:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qaz2oB9p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0AA988817; Tue, 11 Jun 2024 22:02:49 +0200 (CEST)
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B68BC887E1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x141.google.com with SMTP id
 e9e14a558f8ab-375932c94f0so7405115ab.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136166; x=1718740966; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xu2S9arxpK63uzshlHxPPtzmeco72Yo91f7DTE+pThw=;
 b=Qaz2oB9pL3/gP4yccdgz/XBNwM7hmg1r2kbDnY0fygRalfHQSZMi8vIHYQUVUThrkn
 cA05UaxAkzOHt++KgmaApQPVXNl13eiQZTjqZLnub8HHnLLBreLl6iNL6YqpKV73NKRc
 ddymFPJ686TTt2kCUU03ku4digOkKl8Nz+oKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136166; x=1718740966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xu2S9arxpK63uzshlHxPPtzmeco72Yo91f7DTE+pThw=;
 b=l9B8R6ZAzHFYSSVFLHXavpMflH+kWwLJ2yIvw3Gd2RLQIq2c4HrmlX3zTneAzp6v3f
 Bs/HNrAM2FwBS3I5v3rCd3U5ZXhU/TR02fGZ1eWlQdUmMCgrCnXPWKk/rVVLEF9d91ID
 LhNgUJj5IWf/SAQNZYzoXAtY0mHw0ohxQZq7UVEM/IAq3oG6qtdPyPTjDbzVdAX03COE
 g7ok1vStORkxy7ySXv7Pt6ZHtE0Ies2gxUxbpqOv42tXHPB58e2g89NVY0GkV21rsM02
 +NsDGg0unseLGxbEWePAf6M0XmMKOua2rfxZD1bOz6qhrrbP+3SID52KgKEhVAJT7XuY
 rbvQ==
X-Gm-Message-State: AOJu0YybGjMT/oAEFdyJh0QknJRULu50tMuyrD/4dK93dukkTDg6AWsZ
 KHKyGh0JG8mgxQWHLhNEc4ITScW1shhsmtMs8RAw3D07cseR6jy58+jSeiO61KSVKsIPG26UiqO
 wn5cb
X-Google-Smtp-Source: AGHT+IEb7KazQ2qJthA772RQJpANC1aeZQHKjdJdqPp0tPwvQpr7gpOhl3/uQfkgisDOIJvgnJu+zg==
X-Received: by 2002:a92:c047:0:b0:375:86c9:9ec9 with SMTP id
 e9e14a558f8ab-37586c9a260mr115011875ab.11.1718136166460; 
 Tue, 11 Jun 2024 13:02:46 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 41/42] test: Add a section for closing the connection
Date: Tue, 11 Jun 2024 14:01:55 -0600
Message-Id: <20240611200156.2245525-42-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
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

 test/py/u_boot_console_base.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index 1b00821c5e9..95096fc123c 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -157,7 +157,10 @@ class ConsoleBase(object):
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


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAD4C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:06:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AF1F887C1;
	Tue, 11 Jun 2024 22:02:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RdcLck5G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CEF9887CA; Tue, 11 Jun 2024 22:02:37 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBB6F887C1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-374a342cf47so18683185ab.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136153; x=1718740953; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ab92cG+vAGgLwXnrxG/TMlEX8bfg48nqM7Ek2Jfns+A=;
 b=RdcLck5Givwi1gHfjX1NScxtiav/+Gkrin/pwQn0nwnnB37GUuA8QhFPe4r0EXwyog
 Tu4g5Tcq9921PMtf6a8YDRcZboBzx+2UJbQAl3UlR3qUWa+NChOAcZDXFEC/r4407FAc
 IlAJGlvq7kJ5irhgC437DSxBN5siYfXbfDBwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136153; x=1718740953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ab92cG+vAGgLwXnrxG/TMlEX8bfg48nqM7Ek2Jfns+A=;
 b=tvXGcqhAgo+XZ0sG3EOGWbBCFhvWKztYt5ctRemoUASCkbzASJ8djMRBGA/+zvLYQW
 BLXMBPoOwOaiepvkqsY0MePBOtYTdQDI6Ux4mMESlwccfVnNWa8TTs9CQRx5NXHmquCn
 Mv0Nk9NIMVo3SVFnu5PbubdXn+g3cdztDnH+kh3rnvE0brRI6+jxF+VIrLCs4RJqJPIL
 9q5Kkr2ovnk9cRm7XRP5BZfBIzx6/CQp6Lq3WkST+G1QSBhD6lzllv3Aaw7ypDZFYqFT
 boS762L6Wful07IGvmmshRIq8qeiZdfoJX7qRAv/Bq9YuqWOuuEZw3L3vY1ysnxX/vpE
 Mh4Q==
X-Gm-Message-State: AOJu0YzBJpqxKyoxHB2FaWl+6NayIjfiK0aLfjbMs1UzfgPUugNMXBtc
 K4yMx6W/hueuxHaJj1yWx2km2oOtRAvbutxwn6FNbtrdBVzE80780Z2AQB9fETqZhOniNYJl0tt
 Ldw==
X-Google-Smtp-Source: AGHT+IF7VcJIg2VAjDfcoV7SX6G/r0m3DQ+0QBhZQ8hMqSuNlqkcGogo7628/CLpz/CQpzgqHWmzkg==
X-Received: by 2002:a05:6e02:148a:b0:375:be2b:3a4e with SMTP id
 e9e14a558f8ab-375be2b3bdfmr28267045ab.5.1718136153580; 
 Tue, 11 Jun 2024 13:02:33 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 24/42] log: Allow tests to pass with CONFIG_LOGF_FUNC_PAD set
Date: Tue, 11 Jun 2024 14:01:38 -0600
Message-Id: <20240611200156.2245525-25-sjg@chromium.org>
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

This setting pads out the function names. Adjust the test to handle
this, since some boards use it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/test_log.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/test/py/tests/test_log.py b/test/py/tests/test_log.py
index 140dcb9aa2b..79808674bbe 100644
--- a/test/py/tests/test_log.py
+++ b/test/py/tests/test_log.py
@@ -27,13 +27,16 @@ def test_log_format(u_boot_console):
 
     cons = u_boot_console
     with cons.log.section('format'):
-        run_with_format('all', 'NOTICE.arch,file.c:123-func() msg')
+        pad = int(u_boot_console.config.buildconfig.get('config_logf_func_pad'))
+        padding = ' ' * (pad - len('func'))
+
+        run_with_format('all', f'NOTICE.arch,file.c:123-{padding}func() msg')
         output = cons.run_command('log format')
         assert output == 'Log format: clFLfm'
 
-        run_with_format('fm', 'func() msg')
-        run_with_format('clfm', 'NOTICE.arch,func() msg')
-        run_with_format('FLfm', 'file.c:123-func() msg')
+        run_with_format('fm', f'{padding}func() msg')
+        run_with_format('clfm', f'NOTICE.arch,{padding}func() msg')
+        run_with_format('FLfm', f'file.c:123-{padding}func() msg')
         run_with_format('lm', 'NOTICE. msg')
         run_with_format('m', 'msg')
 
-- 
2.34.1


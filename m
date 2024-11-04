Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B504BD1CA07
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 22:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB32088F77;
	Mon,  4 Nov 2024 23:46:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jtJVozdu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 532B288FB3; Mon,  4 Nov 2024 23:46:07 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C5EF88D29
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 23:46:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-83ab21c26f1so194425639f.2
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 14:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730760363; x=1731365163; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZmqnV/5HSMWKLhKn/yargIhguvHVv/OIpOcWoJLGpCA=;
 b=jtJVozduwVRzRmnt7oNUi5yY6lKfc2iJAbI2JaPZBUASm7+c7McBmsofP5SB8sJ/+J
 PR1JV+YU7ERXMt5jCMAvUZK/0gNi3mmVcp1DcbZYyui62dY0fIgPkDpgCIyA5hLfDPbW
 gLZyOPeeocxU2GacIQ7wsKsLCepf+C1ClcwlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730760363; x=1731365163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZmqnV/5HSMWKLhKn/yargIhguvHVv/OIpOcWoJLGpCA=;
 b=PJgb4BY9yw903fDVdFThlp05bM+yKROK+KZ6VsPn+iIxq2dc+IOzdiV9En9bva25Qk
 RkXu7KIq6geQnEFCGi/UwE4CAEXn3hAgKgsWWE5WJkTD94spYuc0L7oJqOI7/m8Yc2r7
 CcNw62Ya3XKsjkGpSQjoidtGvsMEhpP8TEI4fRdecAD+y8JNcfj2unrmlGRbDnYTNRCq
 gT7OzWxd//qRborgtjInqxQvR+MzXBsXe5LqkDti3hhvKMS2qYh3xmY3OhaC2bgxps6U
 +1892rONx9oEuyAeMpm0PJcLtHmBYhpXn0t3sz5ljwTujfLdkapTaCxnjvAyGCsQhVci
 0T/A==
X-Gm-Message-State: AOJu0YwClbxmh3Ky/8vBH46AF3RMMlkFGE1V73D8+UCOdHpcCkwFyxzj
 d60l4brFSYm0uvtXYXl0fVTz5Zp1hP2dPGgqAvxD/fjb+4tY7w/dWhGlm6yOtrJIJcCaNPzT4fA
 =
X-Google-Smtp-Source: AGHT+IGL3zKayOJwhX6KjQ2hcFDiXyfwbZNO8/63gQncp6bjngFOqYxjmvvgtOYFhn4BcUYf72n6Iw==
X-Received: by 2002:a05:6e02:1d91:b0:3a6:b783:3c06 with SMTP id
 e9e14a558f8ab-3a6b7833e0amr107655385ab.19.1730760363387; 
 Mon, 04 Nov 2024 14:46:03 -0800 (PST)
Received: from chromium.org ([50.235.115.130])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6a97b009csm25535945ab.4.2024.11.04.14.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 14:46:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v8 02/11] test: Release board after tests complete
Date: Mon,  4 Nov 2024 15:45:29 -0700
Message-ID: <20241104224550.677442-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104224550.677442-1-sjg@chromium.org>
References: <20241104224550.677442-1-sjg@chromium.org>
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

When a board is finished with, the lab may want to power it off, or
perform some other function. Add a new script which is called when tests
are complete.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_exec_attach.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/test/py/u_boot_console_exec_attach.py b/test/py/u_boot_console_exec_attach.py
index 8dd8cc1230c..5f4916b7da2 100644
--- a/test/py/u_boot_console_exec_attach.py
+++ b/test/py/u_boot_console_exec_attach.py
@@ -70,3 +70,13 @@ class ConsoleExecAttach(ConsoleBase):
             raise
 
         return s
+
+    def close(self):
+        super().close()
+
+        self.log.action('Releasing board')
+        args = [self.config.board_type, self.config.board_identity]
+        cmd = ['u-boot-test-release'] + args
+        runner = self.log.get_runner(cmd[0], sys.stdout)
+        runner.run(cmd)
+        runner.close()
-- 
2.43.0


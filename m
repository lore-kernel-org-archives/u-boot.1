Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA0EC2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE9DC884C8;
	Sun, 23 Jun 2024 22:32:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="le6YJT+2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E86F188582; Sun, 23 Jun 2024 22:32:25 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC84E8852D
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-376208fbe7bso14929265ab.3
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174742; x=1719779542; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLCrRj6pAlFRGjImJoweM//OdBLyyEKrzNSfFlyshSE=;
 b=le6YJT+2o9OvwxCOrwrdvdEhOWyb2W1D3p5a7inkh7IzTu5aQVpi8TTXhiK5TnwNRH
 ow16NnNK9C3CycCWUUJevsq/4M2tcAz4u/gvR309FFstvel0Q3JVKotn9q+7xbpJhMtd
 VRVqEHiH55qS4GkbAWLHeMvJCiU2nU268Xs58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174742; x=1719779542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nLCrRj6pAlFRGjImJoweM//OdBLyyEKrzNSfFlyshSE=;
 b=P0j2KO59dc4DCuoMTm2gCXqsJ8O3jyD4VXrEe7XzGjWRHp/k982tGa/sk6Kx4t1L0F
 irzT3sPnu6asIo95J4DUfdIdUorqQz0YX5dofYD8bLsJ0wWohThOgQLTkuzkJkl5MrE+
 VbkMLt9kl/zrc3CqxINgjZrbd9jb4iExYiMDZxmiD0T/zYmw3Q8w4bCo60Wu8V1k3Xum
 hQzuMaKuKqoLur8eDXEoLBpEouvBBuVv05Wth5IkUBnEdOLd3+g29j9dXpmuwxPy0FAg
 bcTlZfHsen5T3QmjBFyuQbGYzcETfbmgkqJz/jGxaIsHUou4pzCzWVq2dnAlFTOJ1Bo+
 w/wg==
X-Gm-Message-State: AOJu0YxhlNWDnKSurmPIIA9kpurGFpBNDifedC9kM8dVg0L18kZQICbj
 c7z0w8wL2L1BYwGTGVwXsr00gzNlQHvSiXmbuMQ5hU9acWkoUaf9Sz8oE0Sf4acVEIMO8c5OFk0
 krg==
X-Google-Smtp-Source: AGHT+IHAzbY8gRQJEsEGO5LdS71pZTw+Ex0AR7VgqJsIkdE8RGfxUUpIDRFO4RXI2ynMxbSZYAWwtw==
X-Received: by 2002:a92:cd8b:0:b0:374:b07f:6dbf with SMTP id
 e9e14a558f8ab-3763df4d286mr41330535ab.1.1719174742501; 
 Sun, 23 Jun 2024 13:32:22 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3763374634asm12016765ab.52.2024.06.23.13.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:32:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 04/19] test: Release board after tests complete
Date: Sun, 23 Jun 2024 14:31:58 -0600
Message-Id: <20240623203213.1571666-5-sjg@chromium.org>
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

When a board is finished with, the lab may want to power it off, or
perform some other function. Add a new script which is called when tests
are complete.

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
2.34.1


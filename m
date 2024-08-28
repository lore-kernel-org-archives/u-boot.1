Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B0DC7113C
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 22:09:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B48EF888C1;
	Thu, 29 Aug 2024 00:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kdC4QHlq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF53688907; Thu, 29 Aug 2024 00:08:57 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56A4A87EF7
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:08:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-39d2cea1239so26695545ab.3
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 15:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724882931; x=1725487731; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9juF+I+9ovyAkMk+tiDodeaUhfhyT4QIvN8cdNOkH8k=;
 b=kdC4QHlqTGaa6AoiXfKEdzOC78gah7i3eIdIdtlbV9qJBBDk3mXv4cssha6fR+3uDp
 Rttdz5q9Yqmq+GjcSuNeox8g+VSxvAWduVghSewkrJpw3sU0JN4bDPixYLFF006tdPs7
 P8EaT8X2qZOt/DLu9/D15iuGlfcKTzRgE79GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724882931; x=1725487731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9juF+I+9ovyAkMk+tiDodeaUhfhyT4QIvN8cdNOkH8k=;
 b=T7E/hl5YFRK3bGst9Hk8Qg0UhGlHdTuFM4BV8057qzJxFIfBkmceQNq2cUUwuQWDkA
 cz1Y15eeLIOFhuZeEqsMA79Kxa2EFEV3C1tOy6zLYy9ScPjvDiaM+j2DfSVGDwBgbrQV
 tsBQOfHT1ZQTuwtu5bpEL7lCBeFyO1iSDzZjd0M/XoREk1F8eDf9zfswdi1F8PGSmPXm
 ZKxkFq13gfmgcOpxKkxElXLbcMDhl+uvny097t0egx3Oftcpemj7YP7up3xhaYsLn0VO
 9I1+y/mZ/cZkd4p0yi3r8DeV0XhrTvsRSSTXkv6YRCtDbV1zqWpXQaU+bl3649ai+f/M
 PLRg==
X-Gm-Message-State: AOJu0Yw5HxT3AZJp4nB7tDQOFtTdLeO6bQG2xzF4173qzbBP0f1rtklg
 RDSJLXeFDyk6s0zeRP3j+FM7G5OhrqETKZT0NEEhn7KjpuJLX8AViTc3txK8zLgNhWlX8moqt9g
 =
X-Google-Smtp-Source: AGHT+IFjAKbeR50LpoTjBjw5/e0FitUn21fa44BfxGHtZBY5IT+IsPsRwGNHMnNDwiOX9MV4e7Bm5A==
X-Received: by 2002:a05:6e02:13ae:b0:39a:eb57:dc7 with SMTP id
 e9e14a558f8ab-39f377cb45amr13240175ab.1.1724882930998; 
 Wed, 28 Aug 2024 15:08:50 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f38e683c1sm838105ab.19.2024.08.28.15.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 15:08:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 01/20] test: Allow signaling that U-Boot is ready
Date: Wed, 28 Aug 2024 16:08:27 -0600
Message-Id: <20240828220846.1205813-2-sjg@chromium.org>
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

When Labgrid is used, it can get U-Boot ready for running tests. It
prints a message when it has done so.

Add logic to detect this message and accept it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_base.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index 76a550d45a1..882d04cd1e9 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -22,6 +22,7 @@ pattern_stop_autoboot_prompt = re.compile('Hit any key to stop autoboot: ')
 pattern_unknown_command = re.compile('Unknown command \'.*\' - try \'help\'')
 pattern_error_notification = re.compile('## Error: ')
 pattern_error_please_reset = re.compile('### ERROR ### Please RESET the board ###')
+pattern_ready_prompt = re.compile('U-Boot is ready')
 
 PAT_ID = 0
 PAT_RE = 1
@@ -196,15 +197,15 @@ class ConsoleBase(object):
                                     self.bad_pattern_ids[m - 1])
             self.u_boot_version_string = self.p.after
             while True:
-                m = self.p.expect([self.prompt_compiled,
+                m = self.p.expect([self.prompt_compiled, pattern_ready_prompt,
                     pattern_stop_autoboot_prompt] + self.bad_patterns)
-                if m == 0:
+                if m == 0 or m == 1:
                     break
-                if m == 1:
+                if m == 2:
                     self.p.send(' ')
                     continue
                 raise Exception('Bad pattern found on console: ' +
-                                self.bad_pattern_ids[m - 2])
+                                self.bad_pattern_ids[m - 3])
 
         except Exception as ex:
             self.log.error(str(ex))
-- 
2.34.1


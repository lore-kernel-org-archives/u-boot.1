Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A8ACEDDA9
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 01:52:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C82088D38;
	Thu, 10 Oct 2024 03:51:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D0Y27VXX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCFEA88DD4; Thu, 10 Oct 2024 03:51:55 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA9F188D38
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 03:51:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a34ccc6a9aso1949755ab.1
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 18:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728525112; x=1729129912; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p6cxD5QIl7lRaBt8O+QSNI/HUpK5UyhEqFmiPLUD/dI=;
 b=D0Y27VXXavojk1IU3nn6gH7AF2WfRdXQNd1y3LTVtJrrlvXIhG0H4LIUQKxCAG8FKa
 PGwLk4kGNHlUkqeQlV4bmbl8NbW0rJedofBv2tuYOxRHtDcCqi7YLfepwsBQXNkEMtpd
 hwsbYwPdj9iTCW9Ej0zcChTBf+OpuTM9M9mm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728525112; x=1729129912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p6cxD5QIl7lRaBt8O+QSNI/HUpK5UyhEqFmiPLUD/dI=;
 b=GBpMkJFU45QYdFpN30BkynyvWgvr3LzF6Qtm1VqwQoBUSGqDiVS7eoEild+7mrVzs7
 LxSyT7bLZ4sJ8FwncYjTOWQS81v2zeQrMMX7Seo7Ee6IRmcwUYxSlzfxX+XHVHEFSoE0
 b2D2+AzEzV8ESVnrq8njx6xFUuAfjk62v182ZEJKO7YJXVDUIKWIe5u49WulWmpaW7tu
 wgv3rPIGrC0x05UZXtQ1gYg2C3IncpbNGUBDQWaG4gvm2EPDw1IjTbiWwYfWM2B2sHZt
 gxLpzgcovku7/bnK9CYTIHuHhPtUF6BxKNVidB2+rGvPJEMKTimO7wPwF9mXQD65BH8z
 eoPg==
X-Gm-Message-State: AOJu0YzcIr1LGf6RL9HYM6b7HYXD3xAZPsb1FQJBnoCyS0ki5I1HVVab
 Rsmxo48g7ACrfSZj3S8lx2xn2PVpzz7Sgh06tea+MKnJq77ExUnJWOgNQTsouxGnir4k+1SUKMN
 srg==
X-Google-Smtp-Source: AGHT+IGN7SqCtfsdd4emFIzhv/dTNfZITjIjlHi6wjlZXL7fzcwbWNQpMEk5KLA+KT0nzbAOoZiFSw==
X-Received: by 2002:a92:b74a:0:b0:3a3:ae58:2ef1 with SMTP id
 e9e14a558f8ab-3a3ae583016mr5482985ab.2.1728525112306; 
 Wed, 09 Oct 2024 18:51:52 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbadaa947fsm61870173.126.2024.10.09.18.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 18:51:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 01/11] test: Allow signaling that U-Boot is ready
Date: Wed,  9 Oct 2024 19:51:35 -0600
Message-Id: <20241010015145.1977999-2-sjg@chromium.org>
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

When Labgrid is used, it can get U-Boot ready for running tests. It
prints a message when it has done so.

Add logic to detect this message and accept it.

Note that this does not change pytest, which still (also) looks for the
U-Boot banner. This change merely makes it possible for pytest to
believe Labgrid when it says that the board is ready for use.

In several cases, the board starts up and Labgrid receives some initial
output, then pytest starts and misses some of that output, because it
came in while Labgrid had the console open. Then pytest fails because
it doesn't see the expected banners.

With this change, Labgrid handles getting U-Boot to a prompt, in a
fully reliable manner. Then pytest starts up and can simply start
running its tests.

But, again, this does not prevent pytest from handling a banner if one
is provided (e.g. if not using the Labgrid integration).

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v7:
- Rebase on testb series
- Expand commit message

 test/py/u_boot_console_base.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index d8d0bdf9fd4..965832a4989 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -23,6 +23,7 @@ pattern_stop_autoboot_prompt = re.compile('Hit any key to stop autoboot: ')
 pattern_unknown_command = re.compile('Unknown command \'.*\' - try \'help\'')
 pattern_error_notification = re.compile('## Error: ')
 pattern_error_please_reset = re.compile('### ERROR ### Please RESET the board ###')
+pattern_ready_prompt = re.compile('U-Boot is ready')
 
 PAT_ID = 0
 PAT_RE = 1
@@ -200,15 +201,15 @@ class ConsoleBase(object):
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
                 raise BootFail('Bad pattern found on console: ' +
-                                self.bad_pattern_ids[m - 2])
+                                self.bad_pattern_ids[m - 3])
 
         finally:
             self.log.timestamp()
-- 
2.34.1


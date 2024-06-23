Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA32C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABAD68855B;
	Sun, 23 Jun 2024 22:32:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XpGB0V97";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D80328854A; Sun, 23 Jun 2024 22:32:23 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C566387D07
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:32:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3738690172eso15389735ab.1
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174740; x=1719779540; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9juF+I+9ovyAkMk+tiDodeaUhfhyT4QIvN8cdNOkH8k=;
 b=XpGB0V97Uxz7X2vpKufVUPTOAyIruRxXMhALKedN9Qg99mhAKx1Cz7XlzsncFj9BDI
 ZOr1WE/07svPURLW+MYApWuCzP7FHqqHXNNAamQYvGOT9luES+yiYBUqyxjW9YMHLmUe
 VfmzKvvx6vDlMcH8tBwpPL7/tjM3Ctkb81IdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174740; x=1719779540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9juF+I+9ovyAkMk+tiDodeaUhfhyT4QIvN8cdNOkH8k=;
 b=UJoJBSSgGjT3bEHJ9druqPnikKKaHj9jfrKEXnla7UUhnNU7w53uEi4z/D84FZgr39
 f7cs6KThwbL7mhILu+wk26BBmDBDg4aIi188XAVg8TrZB2OCQB7nH3aUy7YAn4/qx1GM
 SJRIboNDEpq9CMT8wt/qh9iUUObAVrqZUJgjgKH97B88cMAHh9wo7H6vc5jB+WUcjBva
 OwgCjBEqWH99JEgRhWy10XIe1q/MMCaKEaLE/KCwOeVS4sVIN72w8y4asfF+pe3U0IA7
 WSMNwkDiTqGCWn5v7MwumrOrKu0Dw5qN1GbB+A40r4wjaAQ20OuyUsfMeFPVwsvmkHcF
 b6HA==
X-Gm-Message-State: AOJu0Yweb6eqFTZGGFvl2QjbIr5K/0knsMq5yBLigvaDSnGMzLSSzL2B
 5Qr5ITgleYhtSEhEhCpBHFhes/l9O2m4CZSoLKyvOPlxpedmCNp+Xr7ghNQQMXNB3h9gJKAWE+w
 BRg==
X-Google-Smtp-Source: AGHT+IEdQKvbxxe4DPm4I6JPt2Q3TznIa13wyEzrhU+D7HtB2+i5hxMj+XFJ32fk8I6yR6Fu9nqaaA==
X-Received: by 2002:a92:c24c:0:b0:375:ac51:9c5e with SMTP id
 e9e14a558f8ab-3763dfb0050mr45396345ab.15.1719174740432; 
 Sun, 23 Jun 2024 13:32:20 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3763374634asm12016765ab.52.2024.06.23.13.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:32:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Love Kumar <love.kumar@amd.com>
Subject: [PATCH v3 01/19] test: Allow signaling that U-Boot is ready
Date: Sun, 23 Jun 2024 14:31:55 -0600
Message-Id: <20240623203213.1571666-2-sjg@chromium.org>
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


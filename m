Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E334CEDDB1
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 01:53:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08F8488F2A;
	Thu, 10 Oct 2024 03:52:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V56ho2qi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F8D988FB5; Thu, 10 Oct 2024 03:52:01 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3053788F95
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 03:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-831e62bfa98so17825239f.1
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 18:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728525118; x=1729129918; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZIloWi3xAFqTUKgN3BVeaBy+vuVeMO0tCQQmE+ZfZzw=;
 b=V56ho2qig4iqIFX6rV2CUZd0L2oUOMKTpyetrqgyBefMweKeHVWtCYna/eJ8Om4s9u
 LDGiGlq0799PI10V5GdlJebGnNFA/OFgD5AFn/2bQF1cXEkgi7kgLsSELJHW4sVSodQE
 Vj+YxllIjmObohtVZKZbfBb9tDPW2Ey4hPgOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728525118; x=1729129918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZIloWi3xAFqTUKgN3BVeaBy+vuVeMO0tCQQmE+ZfZzw=;
 b=fVwSxXg19hG4pcrFVFwyG5RMUTrEnZXzceyKFSZ7h3qBhr+cRyc/fXfvknPR14WY0l
 K1bil5NDu9fyoIwEfMJj97UiCBVz7e/WD29H0kr8Kfhby3sLkS08ZtDbFU0lMh1bykAn
 xk7ORn1QOA0f8LLeacTxKtJ40XOeSM1HL+b3YQ7FzLSfebol7oW5HnesJZ3lV0F8UgM+
 2xSJQm2ghSXWGkoZmlLBWdQdDMEI/n/22p0DF7SqhmaXgajGcMwWSZg/6Xnf1uS12Gt8
 qxwuycJo7TZAP501MQ8uChP6+HjNDnqmwmLbfMl4scLwDFhTH686mCX7yZSREZFG2O20
 kOoA==
X-Gm-Message-State: AOJu0YxoUdDZd3YIsZ4Et+FHivofKzRBdmfinjLheAMdQ17LC5YuDDPq
 jht7MGUwUFEVnNZgsoGITc4DNf11vnNJ7OTGOmF3F9H7rEbNSD9GHWEtrDdU2QH65f7ZT+OMzOu
 N3w==
X-Google-Smtp-Source: AGHT+IFAbwIPW1GduTTeNFhx7/8LEvFRKJuYjkNGzravyNr70SY9ged3Dk4lY0cvCJRlCkywZP52CQ==
X-Received: by 2002:a05:6602:26ca:b0:82a:545b:113f with SMTP id
 ca18e2360f4ac-8353d5256abmr601467539f.12.1728525117670; 
 Wed, 09 Oct 2024 18:51:57 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbadaa947fsm61870173.126.2024.10.09.18.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 18:51:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 07/11] test: Avoid double echo when starting up
Date: Wed,  9 Oct 2024 19:51:41 -0600
Message-Id: <20241010015145.1977999-8-sjg@chromium.org>
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

There is a very annoying bug at present where the terminal echos part
of the first command sent to the board. This happens because the
terminal is still set to echo for a period until Labgrid starts up and
can change this.

Fix this by disabling echo (and other terminal features) as soon as the
spawn happens.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v6)

Changes in v6:
- Rebase without an earlier patch

Changes in v2:
- Only disable echo if a terminal is detected

 test/py/u_boot_spawn.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/test/py/u_boot_spawn.py b/test/py/u_boot_spawn.py
index 24d369035e5..f2398098a00 100644
--- a/test/py/u_boot_spawn.py
+++ b/test/py/u_boot_spawn.py
@@ -11,6 +11,8 @@ import pty
 import pytest
 import signal
 import select
+import sys
+import termios
 import time
 import traceback
 
@@ -115,11 +117,23 @@ class Spawn:
             finally:
                 os._exit(255)
 
+        old = None
         try:
+            if os.isatty(sys.stdout.fileno()):
+                new = termios.tcgetattr(self.fd)
+                old = new
+                new[3] = new[3] & ~(termios.ICANON | termios.ISIG)
+                new[3] = new[3] & ~termios.ECHO
+                new[6][termios.VMIN] = 0
+                new[6][termios.VTIME] = 0
+                termios.tcsetattr(self.fd, termios.TCSANOW, new)
+
             self.poll = select.poll()
             self.poll.register(self.fd, select.POLLIN | select.POLLPRI | select.POLLERR |
                                select.POLLHUP | select.POLLNVAL)
         except:
+            if old:
+                termios.tcsetattr(self.fd, termios.TCSANOW, old)
             self.close()
             raise
 
-- 
2.34.1


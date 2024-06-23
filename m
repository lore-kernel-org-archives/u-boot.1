Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5929EC27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:35:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22FD587D07;
	Sun, 23 Jun 2024 22:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WdIqTlLB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D14F8857A; Sun, 23 Jun 2024 22:32:32 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0C91885C4
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-376211b3a4fso13287735ab.1
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174748; x=1719779548; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zhS7YGIvlqDApfFfR1YMMtanbPJfmh0+EdY7fYYKfOg=;
 b=WdIqTlLB1OOIjRIXYPRfMqFPuydYsfv+TCi6julxrJNaYO+93bbTFTOMyYvUoQqllq
 I2ioyzeRnh+/4FmUBKo724BzHUx/augqDAqSeAcQYmnhpKJvF/ZpIK38BE+sEdyy3976
 c/rwFkenT4L8XQcL6+o63OOr5puaJ0ksBxFKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174748; x=1719779548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zhS7YGIvlqDApfFfR1YMMtanbPJfmh0+EdY7fYYKfOg=;
 b=naBtkjtyvfzLuPf47Wm9jlaRVO68l0r12t8Vq8WktHYfcqDkUnAeLwiYNRPLR901Gm
 PCGNzetrHxiKylivzj6Do0ss25reWYbxLNceFBk7+jUcVH9DZCl5fCwPau/rHRtRa/RM
 jADzzGklZKBzXBtu8nCbkmpSCqqDKBo3gRVam906Ai2IQq5gDSqexmNHB4WVrK5Qswwx
 jKfvAhFrRGXFnbzrztIMvKvBl7vPlQ8a+g58C221KRv1/K8UaSUmnWJtoTQiGIRD/WIk
 kR8thBXXiwLheUT8OZJZn65YveE18gw+ZGLTwB6bL5TWYNVoXpQB89+JxX4XCiULiWyI
 kYMg==
X-Gm-Message-State: AOJu0YzhtQbkWy2ncqp0gjVPJVrd9kqQcr7JdhjJcmPyaHjudXIHuf9I
 9KxZ4XueXJqLJytHStRD3pqjSzDOHR1Ozaysz8A+NP3EMxE4FICFtwUmIpJ182kKGUqjO+GzOdX
 fOA==
X-Google-Smtp-Source: AGHT+IH7FVTu835GdP4NljDxtdjxKfPpwYnqG8K8IYyThitfGBCZ9gcbDqc+d8/UpNzkWnKz53oHiQ==
X-Received: by 2002:a05:6e02:1529:b0:376:41c5:d620 with SMTP id
 e9e14a558f8ab-37641c5d787mr8066815ab.22.1719174748484; 
 Sun, 23 Jun 2024 13:32:28 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3763374634asm12016765ab.52.2024.06.23.13.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:32:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Love Kumar <love.kumar@amd.com>
Subject: [PATCH v3 12/19] test: Tidy up remaining exceptions
Date: Sun, 23 Jun 2024 14:32:06 -0600
Message-Id: <20240623203213.1571666-13-sjg@chromium.org>
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

Use the new handle_exception() function from ConsoleBase also.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_base.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index fa87952694d..9474fa87ec9 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -14,7 +14,7 @@ import pytest
 import re
 import sys
 import u_boot_spawn
-from u_boot_spawn import BootFail, Timeout, Unexpected
+from u_boot_spawn import BootFail, Timeout, Unexpected, handle_exception
 
 # Regexes for text we expect U-Boot to send to the console.
 pattern_u_boot_spl_signon = re.compile('(U-Boot SPL \\d{4}\\.\\d{2}[^\r\n]*\\))')
@@ -294,12 +294,12 @@ class ConsoleBase(object):
             # indentation.
             return self.p.before.strip('\r\n')
         except Timeout as exc:
-            self.log.error(str(exc))
-            self.cleanup_spawn()
+            handle_exception(self.config, self, self.log, exc, 'Lab failure',
+                             True)
             raise
-        except BootFail as ex:
-            self.log.error(str(ex))
-            self.cleanup_spawn()
+        except BootFail as exc:
+            handle_exception(self.config, self, self.log, exc, 'Boot fail',
+                             True, self.get_spawn_output())
             raise
         finally:
             self.log.timestamp()
-- 
2.34.1


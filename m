Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74780CED611
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 00:30:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E82988EC4;
	Thu, 10 Oct 2024 02:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IVolrPJW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 826D388AE4; Thu, 10 Oct 2024 02:29:28 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BE0588E80
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 02:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-716a5b9ee6fso202615a34.2
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 17:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728520165; x=1729124965; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tcv32IEi77X4GciAosv4MRQADdZOGsDwSEyP0UGHeYc=;
 b=IVolrPJWdukqNPBFw2rKC6Rd1fkPCesI6Rvx7mA/S3wEpsc1uqPTO4Mu9gMjUM2HGQ
 oF/mOVh0HXrVN821QNrc6Q7MFA/tOJztmce9Ux2ktHv2STPYrZgbYZM+4UdcfFEW9B3v
 /BeO1To+1oeZeimCOBpVehsc+J1SOBBfVkx+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728520165; x=1729124965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tcv32IEi77X4GciAosv4MRQADdZOGsDwSEyP0UGHeYc=;
 b=maOYEhkCgeIUfJmKvCYlSrJ+yVw+bnPfk347GR5yu/8yDbeO4luByoMiyahkQJu8xn
 WrtDEsO4ylE0v1e4FNTDK5jZk77jOq3x+Yffp32E8kPHz1t4DRFmzpjx4Mj8NhQ/3NwD
 OCxatgEQF/N3NBxQuPOXdglK2abW6jmZY3/dJlq6HyGn+VLxmwzm+hha47Kg2cBqfNvQ
 ZCsYQLjn5knFQZGRka+nDbYlSvTYo+U/fCBVSYtgmkQUugrgTgP23PNzTS7WDbtw34B9
 ttkdCY/wwfz7Ylk/bTlkHvoYVhzugG5YSf+Xw8lysfjHOnwFP9l1Wgk7FwyZ9zVyxRoO
 HUfA==
X-Gm-Message-State: AOJu0YwhKdtuxuuI37mObNyMJc8QnlAlxtlEg67WtkHo9ZECInK6OAXQ
 pTFPzke8iGvyF+KmUFt/FGaCmAGfHCM/e+XacQYmVtXEzeWdXtJKVvopdMcxZwjkO1geMZxtdDB
 caA==
X-Google-Smtp-Source: AGHT+IEii0gdWFAy0V4ANpyKd3epC+NLPPNaTWtumL1WvugWqyo4KUwO17Bvp9rj+Z/0I4B98XfZeg==
X-Received: by 2002:a05:6830:910:b0:715:5016:99ef with SMTP id
 46e09a7af769-716a4214e56mr2671328a34.23.1728520164992; 
 Wed, 09 Oct 2024 17:29:24 -0700 (PDT)
Received: from chromium.org (c-73-153-3-119.hsd1.co.comcast.net.
 [73.153.3.119]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-717cfed7536sm9073a34.2.2024.10.09.17.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 17:29:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Love Kumar <love.kumar@amd.com>
Subject: [PATCH v7 7/8] test: Tidy up remaining exceptions
Date: Wed,  9 Oct 2024 18:29:04 -0600
Message-ID: <20241010002907.19383-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010002907.19383-1-sjg@chromium.org>
References: <20241010002907.19383-1-sjg@chromium.org>
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
index 0be6c760206..aebe0dac099 100644
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
@@ -293,12 +293,12 @@ class ConsoleBase(object):
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
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71506EEAA7A
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 00:25:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F193286A3F;
	Fri, 15 Sep 2023 02:23:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FTTDyfav";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7147869D8; Fri, 15 Sep 2023 02:23:03 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D307186A09
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:23:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7927952ca67so55346539f.2
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737380; x=1695342180; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=apKCBndqlX9P38Sn48A5uwrGWsyu0uv5bszbKxfqyGY=;
 b=FTTDyfavQwcUOHHl9LvW6n7qdgyb0IxXFN/Vw/FQqtRlX0p2Ll3WHxr3IwN4Z0CzLj
 ZPBuNlHeuGpqHxqImFmcRst67arDeUAZHcDHeaIMmcCi8ZFzbYIvjFouMNthIPgFtLO/
 VuyciKIDUfb4aOpDsUCUkpBwUi18kW6UzWQEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737380; x=1695342180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=apKCBndqlX9P38Sn48A5uwrGWsyu0uv5bszbKxfqyGY=;
 b=v7K2wRh95nBvuF3CW3OLHjRQ2uEeADF4K22XPn00EGjSoKwdhGiJBqHEV5XSTEQrh2
 zFSut1sE4xONENLlcqxj8snY0IWv6szzEI4oWHJmiG6BZsihJ5Xqpq5rTD5HkyjKBJmR
 2pjDnx8aPczdXZTlOxRtTzuJCddSzRIQQ6pc+pEh8ME4/K4ZIHZhRGUR3FejZImEzYys
 uvCorEaCf4BLzetd1wWE+XmbyFOraPAq+Uj5RIL//ShEwldd33zsjvHKDT0YZqn8+rQE
 3cCzKiDwIbOqKCMUZ8UWbpTdg3ynaXrm4YfQPXjq6vUbgzozzm4DdbLs+0ZMK3Xuh7/7
 7K8A==
X-Gm-Message-State: AOJu0YxFM/+SZv6pJYgweUHNaWrX+gd65CKCZw0IeF6vjbP3qEULPNYc
 TZH640gjsq/u8QIzUigHD88kQT5HGoOTKzJNq50=
X-Google-Smtp-Source: AGHT+IEx7+EdCdp97i0C6RBkdTubQuSfU4T+z0/TVr6jiYlu6EAL/TqxD4/v6Gig8Ob+FwIr6fX/VA==
X-Received: by 2002:a5d:8e13:0:b0:792:96e5:962 with SMTP id
 e19-20020a5d8e13000000b0079296e50962mr65736iod.6.1694737380508; 
 Thu, 14 Sep 2023 17:23:00 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i23-20020a5e8517000000b007836e9ff198sm744796ioj.55.2023.09.14.17.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:23:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 17/27] moveconfig: Only show output when there is a reason
Date: Thu, 14 Sep 2023 18:22:19 -0600
Message-ID: <20230915002236.798760-18-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230915002236.798760-1-sjg@chromium.org>
References: <20230915002236.798760-1-sjg@chromium.org>
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

There is no point in listing a board if everything went well. It makes it
harder to see the failures, particularly on a fast machine.

Supress output unless something actually happened.

Drop the 'Syncing by savedefconfig' since this is selected by the -s and
is the same for all boards in this mode.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 727a5d6df864..568386f7b9d0 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -551,7 +551,6 @@ class Slot:
         if not self.args.force_sync:
             self.finish(True)
             return
-        self.log += 'Syncing by savedefconfig (forced by option)...\n'
 
         cmd = list(self.make_cmd)
         cmd.append('savedefconfig')
@@ -581,12 +580,13 @@ class Slot:
                    successfully, or False when it fails.
         """
         # output at least 30 characters to hide the "* defconfigs out of *".
-        log = self.defconfig.ljust(30) + '\n'
+        if self.log:
+            log = self.defconfig.ljust(30) + '\n'
 
-        log += '\n'.join([ '    ' + s for s in self.log.split('\n') ])
-        # Some threads are running in parallel.
-        # Print log atomically to not mix up logs from different threads.
-        print(log, file=(sys.stdout if success else sys.stderr))
+            log += '\n'.join([ '    ' + s for s in self.log.split('\n') ])
+            # Some threads are running in parallel.
+            # Print log atomically to not mix up logs from different threads.
+            print(log, file=(sys.stdout if success else sys.stderr))
 
         if not success:
             if self.args.exit_on_error:
-- 
2.42.0.459.ge4e396fd5e-goog


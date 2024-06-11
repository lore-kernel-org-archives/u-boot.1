Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6EDC27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F77F887E2;
	Tue, 11 Jun 2024 22:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mBrspzp2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E4CE887C2; Tue, 11 Jun 2024 22:02:35 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2123888717
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-37588517095so19782485ab.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136152; x=1718740952; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=25PMBjQA8NgI3xIumRB4sJ3DyECLP6DF31sohVNFl8M=;
 b=mBrspzp2PT409bz+2lLt4d62FSrD8rmDQVt6U1mG2GnkRiiM6cSt78CXNALRUyDfFu
 7CcSmTgn+jXJpuV2XQOCUFp1o7gFHWFbTwYQMQJDL7MqooYFdy3rJFtmh39PuMFe0mJR
 W+yUDtwyPRtmQYwtu8wsAqJieN7hzNWaKdeMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136152; x=1718740952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=25PMBjQA8NgI3xIumRB4sJ3DyECLP6DF31sohVNFl8M=;
 b=b9/jkvQeUt7zUXinhPeqEDvgxmuw6ZPwtmOD2NFSkMjqZG1D2gT0eRzlyxzDnrck5E
 DCc3+GyAcVYOnTEKih0SyE6ICXxBVkLJ4JEBEWF5iRv7cPEf9RkN6WLyLkbUAJkQGFva
 O9Gdbnfv/NBXt9ZKvIZOOZ0EnTcX8GR+wQ77jxDQ5+xU8NgZrkCW/bzG0iw04/Zd5lIr
 PavxKYYxbTjd2KAeun5BmRItXE19EbCpzZL6tHV5S0DJsGYayn/lzvuetK3xwFG2LFtF
 jt4VSkgkPr8P6rvtsrFC+z0HU4ky0qflgyHVaFJuI2dkykjWz7Sbep5mI+sMr9+rZ0ie
 S9Ew==
X-Gm-Message-State: AOJu0YwH6lRC4bYAcqExupRqN5fvPb+GQfdIK2oOFM8Jg9rVxSARbY0X
 AAn2IkzbgMS+pxrws4qXNyE40FZt9/axC1S3iN/LFlBbiNHfhs8V15xba8j1lj4U3JLai71T76K
 Dzw==
X-Google-Smtp-Source: AGHT+IEoay25ZSwA/9O9AfBCIInQZhOPEnXjSBhwxCU8TZBkvo8Klx8v1FD3s7oV/l6We5hdHXXeJQ==
X-Received: by 2002:a05:6e02:1c26:b0:375:b095:808c with SMTP id
 e9e14a558f8ab-375b095838cmr49662175ab.16.1718136151851; 
 Tue, 11 Jun 2024 13:02:31 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 22/42] test: Pass stderr to stdout
Date: Tue, 11 Jun 2024 14:01:36 -0600
Message-Id: <20240611200156.2245525-23-sjg@chromium.org>
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

Some tests may output things to stderr. Ensure that this output is not
dropped, by redirecting it to stdout

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/u_boot_spawn.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/py/u_boot_spawn.py b/test/py/u_boot_spawn.py
index 7c48d96210e..7421da49aa9 100644
--- a/test/py/u_boot_spawn.py
+++ b/test/py/u_boot_spawn.py
@@ -10,6 +10,7 @@ import re
 import pty
 import signal
 import select
+import sys
 import time
 import traceback
 
@@ -57,6 +58,7 @@ class Spawn:
                 signal.signal(signal.SIGHUP, signal.SIG_DFL)
                 if cwd:
                     os.chdir(cwd)
+                sys.stderr = sys.stdout
                 os.execvp(args[0], args)
             except:
                 print('CHILD EXECEPTION:')
-- 
2.34.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5A2C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:33:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D1778851C;
	Sun, 23 Jun 2024 22:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YKZOYZ1W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 575E188599; Sun, 23 Jun 2024 22:32:25 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ECE18837A
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-375daa47685so16517975ab.0
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174742; x=1719779542; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i8DaFGF5/hEwxIGAsIVSejGtNXaa0RJWKjQAwyotlPc=;
 b=YKZOYZ1WSUqTeAFLJS/Zcmpro+eB7JchtKPCKmX0pJPDHVT+fE1pXhJ2ClN4/MB/i9
 yhCW6tB2CVYONU6nL+mk4JwqGS8Neuwd9MdRkvd6uEd4GibwBEIfnR/bRhYhu4SkoFmE
 nBM4ypzd7Vnpk1/hHaOOl6P710zw4zyeWbK9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174742; x=1719779542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i8DaFGF5/hEwxIGAsIVSejGtNXaa0RJWKjQAwyotlPc=;
 b=FSSMNMxXzIHpFLgIzF/lj6nwspgeIkdgQVyMhMKUYupRsiaFPb+nG1mmHF06tVtmns
 peLQRAcX2o9OYkazqzl773YU0AstKddAcxT81OIc9G/FqGq8qMQ1QaLBxNe8g8HLrkEj
 6Mg8y7pRXeuGS2qLmVSfbyoIQx5npZ10P7FH9X75y/etapWgk3ndZ+WWv6srFC9Om4Pw
 yWyeAEmP7F6tCPCCnLfBTv0+DImp+JcqU06t7RmHmiHTGmzON0qw97wklCfH4qhRV69d
 TySl7jiuPmVmWCzoSm6U8mjdCEI/VUrtqYM1WCk4m7eLfjoYjfuwUt+1R5sUeNLv9JNf
 FquQ==
X-Gm-Message-State: AOJu0YxUb0YPd+ruVVSkS6tmHSEN0jSB5SNi9DP9A/mlTpUMGhvECQjQ
 Go2oRV6cEDBaoJIEXDtet8pKLQZYAKYjuRMyej7QQHRbduDAJ9h7/+Q9Ov14RBcA3naVhy5VtWX
 zOg==
X-Google-Smtp-Source: AGHT+IHUTVXVXBBToyaX0J1ghd/HqMr7ZZbllOqofUV7H51tr3YQ53OVLcuqjZ55QqoCCnXJ+BwfSA==
X-Received: by 2002:a92:c242:0:b0:374:a412:3da1 with SMTP id
 e9e14a558f8ab-3763f69621fmr38208655ab.20.1719174741841; 
 Sun, 23 Jun 2024 13:32:21 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3763374634asm12016765ab.52.2024.06.23.13.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:32:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 03/19] test: Pass stderr to stdout
Date: Sun, 23 Jun 2024 14:31:57 -0600
Message-Id: <20240623203213.1571666-4-sjg@chromium.org>
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

Some tests may output things to stderr. Ensure that this output is not
dropped, by redirecting it to stdout

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_spawn.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/py/u_boot_spawn.py b/test/py/u_boot_spawn.py
index 97e95e07c80..81a09a9d639 100644
--- a/test/py/u_boot_spawn.py
+++ b/test/py/u_boot_spawn.py
@@ -10,6 +10,7 @@ import re
 import pty
 import signal
 import select
+import sys
 import time
 import traceback
 
@@ -59,6 +60,7 @@ class Spawn:
                 signal.signal(signal.SIGHUP, signal.SIG_DFL)
                 if cwd:
                     os.chdir(cwd)
+                sys.stderr = sys.stdout
                 os.execvp(args[0], args)
             except:
                 print('CHILD EXECEPTION:')
-- 
2.34.1


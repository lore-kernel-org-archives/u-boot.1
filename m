Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEAEE748E9
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 10:01:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C7AB870B9;
	Sun,  1 Oct 2023 12:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FU3XWffL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFD1B870A7; Sun,  1 Oct 2023 12:00:49 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE9DC86EFF
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 12:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3247d69ed2cso4932129f8f.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 03:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696154447; x=1696759247; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Msrb6/nmtExFC8B0sHWpf3s96bn/pi+WsRWwEFGprnc=;
 b=FU3XWffLsbXqURjK33l0e2u+/UoZi2QRwLxhZ/cgzfHSvV2O+DL2wi0/+tUdxFSgh8
 NdK6S9kMr4Kr8F8MOOq61gfbjiQ1ESfj6k2yre90oJCxxL3pGZm69/44nPBg3RZdhNC5
 6mmlMJF596L1KkRBmjdZb9RfiMK00QH+vYKltsj1g+c2+f9JI5o01ro686tkWGPGqAqK
 rqnIKM0zZmQsCck3v+Zza/SAl5UcPlmc8Xml5L958tWzJV0VAjtRFqKOxA3i4ZzWE9UA
 EjZz7u9jzHcJIHxhuuSLfc28K8TRsewDMtLjxTlyOvDdukyqs60VQBxUxLRYoJwx50vv
 066g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696154447; x=1696759247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Msrb6/nmtExFC8B0sHWpf3s96bn/pi+WsRWwEFGprnc=;
 b=BijlbutQ0+OlsqVXia1lLXBT4Bem4p4UTU0vLmeCg47YnPN+JfGB3edg8Ogu8OTUVX
 Z9j7A4NIho+RxP16vUGC9FPvrbYmyfEUPgEblV3gu0rYfSoI+3doDJ95SlHECMNqrL7/
 IIRV4o90QFSSirO9BiQ3K0W4Z0Z/O0h2QoCnvr87mi2DcgRS2klXaMWXpSGg6dVqd/w9
 10oi7FIqHwVldtcegfjMkewqem/7iJqTkb2vewwGky4mtCxbZgpfSYYF7dj21Nf7H6hS
 zJgyQ8yHL+9r8ll82ExMCElL0fSFk1QfeIMNM+afXzLZhWQn5Dtl9mKN7dHtmkxppE9j
 YK4g==
X-Gm-Message-State: AOJu0YzWRCX0zrdvt028+ljL13OCyu3p9PWc2wrrJ5vae9Yb0LTPQH6t
 fqC/QyeNdjNNWZGL9frwYDwsOmIcmrKMohBM
X-Google-Smtp-Source: AGHT+IEF7lG0B0Yu9jM9wVVcfVnI/RJlEGgjpdF8AZErXXc5bMbOEH0Y8ZdxTYujfmLK1QzNZZK3UA==
X-Received: by 2002:adf:de0a:0:b0:31f:fb5d:96da with SMTP id
 b10-20020adfde0a000000b0031ffb5d96damr7372499wrm.64.1696154446954; 
 Sun, 01 Oct 2023 03:00:46 -0700 (PDT)
Received: from fedora.. (cust-west-par-46-193-56-152.cust.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 g18-20020a5d5552000000b00326f5d0ce0asm3087135wrw.21.2023.10.01.03.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 03:00:46 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de, Y.Moog@phytec.de,
 Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v4 3/8] scripts/gen_compile_commands.py: fix docstring
Date: Sun,  1 Oct 2023 12:00:31 +0200
Message-ID: <20231001100036.34936-4-jmcosta944@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231001100036.34936-1-jmcosta944@gmail.com>
References: <20231001100036.34936-1-jmcosta944@gmail.com>
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

The referred tool is now in U-Boot. Replace "the Linux kernel" by
"U-Boot" to make the docstring coherent.

Signed-off-by: Joao Marcos Costa <jmcosta944@gmail.com>
---
 scripts/gen_compile_commands.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
index 0227522959..63d036a773 100755
--- a/scripts/gen_compile_commands.py
+++ b/scripts/gen_compile_commands.py
@@ -5,7 +5,7 @@
 #
 # Author: Tom Roeder <tmroeder@google.com>
 #
-"""A tool for generating compile_commands.json in the Linux kernel."""
+"""A tool for generating compile_commands.json in U-Boot."""
 
 import argparse
 import json
-- 
2.41.0


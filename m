Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0FDC001DB
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 14:54:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E029686828;
	Sat,  2 Sep 2023 16:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FaJ4vhMA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D382A867C3; Sat,  2 Sep 2023 16:53:27 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAB6386801
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 16:53:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-400a087b0bfso321825e9.2
 for <u-boot@lists.denx.de>; Sat, 02 Sep 2023 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693666403; x=1694271203; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nquaMTUkKEj9f0VDmD18sTp9HY+/Vhfo0qP8M2hbUps=;
 b=FaJ4vhMAV9mLVwZDy01Rm3kAL/M6bB9VYbRfW8amH/XHioZ3Rd8ppQcDL5bXLkWBXn
 fQV1EROpLqxeeG8TCDuOcEMtHkAvVwC1meB2xZZnaqAQ1merhej0Mmdu1M3jz3Ol3lr+
 /3/869YxFskbIMFQSESDIoHojfjsiM6jPo/+p55qPAGaVs9/3x6pgTkbCE0/lg1YW/5k
 XUq2urfsafnpa2bMlh+zfnLWmuI3wnwf7gMgWdseo3pqjQlzx75MEzwQA8p531LMdFFI
 zHZqklJCdvNTT9U8wUZ+aF0BvXLmV50nY1k8nAywrzYE9HN0kLVatPp4pkndV8595JDO
 VhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693666403; x=1694271203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nquaMTUkKEj9f0VDmD18sTp9HY+/Vhfo0qP8M2hbUps=;
 b=LUs3s+AMemp4PqW5kFQrHO+0DPdqJ6vltzlvHTwVPwQ32j6hbsDl5/yujJHTKHfCvW
 Rnz/m+669Ori+3i5nKLIdHhdHfvorpu4kMDtVYucQWQCzTkV/8gQrGLmmZcH+XP4RbIL
 V3NhCRoHGH6xRTk3r/N+LOOvipg+Y0RWcb7Jpc5In6oMzFDzNpi/mFmq9dRk4IWblMQP
 m02Y3etoo2hqVAYbS7XLlxniQzWgYIlBK7lj+CREbCsUW/Y2+Z3yz2doV23Esr807gg/
 GGN1Ep0cvjEZvHmXj/rxfJJFKpQDcSoJ9qpNmBUTklvvVEZhuYULulLUVmFmvEGcJWnL
 dihQ==
X-Gm-Message-State: AOJu0YyJOnGuM0s+5fdG1wUq9gCdqx4CN4e0ued/M2o4fJBQ+RxonZXl
 bdblmaSgPWRNtoIhJlmmf4ZpOvPg9hCGBntY
X-Google-Smtp-Source: AGHT+IGdTjMjTn5h3h4D+4QUdMuluoVNsTNniWr+n46OMZSXVvtVnzrGTlcHwJxOGXCgU6ZSyd4TAA==
X-Received: by 2002:a5d:638d:0:b0:317:6d9d:1250 with SMTP id
 p13-20020a5d638d000000b003176d9d1250mr3866514wru.61.1693666403082; 
 Sat, 02 Sep 2023 07:53:23 -0700 (PDT)
Received: from fedora.. (cust-west-par-46-193-56-152.cust.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 cc11-20020a5d5c0b000000b0031f34a395e7sm2385449wrb.45.2023.09.02.07.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 07:53:22 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, antoningodard@pm.me,
 Y.Moog@phytec.de, Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v3 4/7] scripts/gen_compile_commands.py: add acknowledgments
Date: Sat,  2 Sep 2023 16:53:07 +0200
Message-ID: <20230902145310.107054-5-jmcosta944@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902145310.107054-1-jmcosta944@gmail.com>
References: <20230902145310.107054-1-jmcosta944@gmail.com>
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

Add acknowledgments for porting and modifying the script. Of course, the
license, author, and copyright notice remain the same as in the original
script.

Signed-off-by: Joao Marcos Costa <jmcosta944@gmail.com>
---
 scripts/gen_compile_commands.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
index 63d036a773..1a9c49b34a 100755
--- a/scripts/gen_compile_commands.py
+++ b/scripts/gen_compile_commands.py
@@ -4,6 +4,7 @@
 # Copyright (C) Google LLC, 2018
 #
 # Author: Tom Roeder <tmroeder@google.com>
+# Ported and modified for U-Boot by Joao Marcos Costa <jmcosta944@gmail.com>
 #
 """A tool for generating compile_commands.json in U-Boot."""
 
-- 
2.41.0


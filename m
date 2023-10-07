Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1102EE95A63
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 14:57:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B4B486504;
	Sat,  7 Oct 2023 16:57:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PHP0k/pe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8511986CF4; Sat,  7 Oct 2023 12:55:12 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3615F86C58
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 12:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-690d2441b95so2288114b3a.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 03:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696676108; x=1697280908; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=kxdxz6OGqZKE+8FOO5OPEMg/p0B10957RZYpzNUchVA=;
 b=PHP0k/pevvYRShbSRp7TOrFQMRi9FPgJJSpufogDtvhxppxK3pDfDWke/IJTkwQ3eR
 1hIjugw15LIfamOPsvAsYRV0vbJxpwI8wliyCqQofDjfpbHSptpwmUpLs28gcmMxw4r2
 9O6b3mNUD056j1ANmEzUGDTFl9kmO3HY7fOZ1ZeyBpUqmMJOTVcsd4SH0CjBZ8hacCPZ
 HvqZc8QaYl3TvcrbUMnotEhNMgXypHcNo9hKTMtd7rB9pm92YL0pKg6tvR6P7yD+rqIn
 1w26l/gMYx38FWyCDH5FL/JWSW90zi39FrUUuhLAaGx7yrqchVZqWSX/Y5+qm0d6uZfA
 aGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696676108; x=1697280908;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kxdxz6OGqZKE+8FOO5OPEMg/p0B10957RZYpzNUchVA=;
 b=bIafpMEZjLldT7scgOISO7dfXlxySRdwFWAZYxhcPNLZqjNZQwM773rrMUq34jyI1e
 vwYHkJDoxGuhwgeJU6MsKvE5vj30ttxmDU7qJ3JFFsZtgiBRs1FDbCFGetC/tEjF03rg
 4b5Z6EhE7GSrrarthEK7Grpv28wL8G8TKVxEe0CeXvOmcLjVT7BChxsJSU2d3eDQhByX
 kuFmeWl4LF8zMCuD56TM//i0Ua6+AxbeBjU6t99YWxe7rFjiPS+rDifK6LzAixCYe1mI
 prpFYf3MuLqT6rghE1IHK0m/2ec4/lObNAzUJ2wV/Qho/F+3M4TyMNuaowamz+7rJY6Y
 4xuQ==
X-Gm-Message-State: AOJu0Yypp7JAC9h14gKnn8MAyAvboXoLi6wB1Fz/5j1qNGnN4pq/5C1e
 U4i6zcUqTqDQbLRmd6bYzao=
X-Google-Smtp-Source: AGHT+IHvADkNMVLUPXoN4THrI5yjwbJBSoMtZUOpg6MrXW8KQnrqoq/Q84YTiRzPgSeYTHPNHR2hFA==
X-Received: by 2002:a05:6a20:3d0d:b0:151:35ad:f331 with SMTP id
 y13-20020a056a203d0d00b0015135adf331mr11933891pzi.14.1696676108275; 
 Sat, 07 Oct 2023 03:55:08 -0700 (PDT)
Received: from ownia.localdomain ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 s12-20020a63770c000000b005854f6a6ef7sm4825300pgc.23.2023.10.07.03.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 03:55:07 -0700 (PDT)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Weizhao Ouyang <o451686892@gmail.com>, Stefan Roese <sr@denx.de>,
 u-boot@lists.denx.de
Subject: [PATCH] cyclic: doc: Update documentation for
 CONFIG_CYCLIC_MAX_CPU_TIME_US
Date: Sat,  7 Oct 2023 10:52:36 +0000
Message-Id: <20231007105236.155361-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Oct 2023 16:57:15 +0200
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

Cyclic now just print a warning once instead of disabling the cyclic
function when the cyclic function upon exceeding CPU time usage.

Fixes: ddc8d36a7455 ("cyclic: Don't disable cylic function upon exceeding CPU time")
Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
 doc/develop/cyclic.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/develop/cyclic.rst b/doc/develop/cyclic.rst
index 43bedacb9f..be70a54f67 100644
--- a/doc/develop/cyclic.rst
+++ b/doc/develop/cyclic.rst
@@ -11,8 +11,8 @@ on a high frequent polling (e.g. UART rx char ready check) might be
 delayed too much. To detect cyclic functions with a too long execution
 time, the Kconfig option `CONFIG_CYCLIC_MAX_CPU_TIME_US` is introduced,
 which configures the max allowed time for such a cyclic function. If it's
-execution time exceeds this time, this cyclic function will get removed
-from the cyclic list.
+execution time exceeds this time, cyclic will print a warning once to show
+this potential problem to the user.
 
 Registering a cyclic function
 -----------------------------
-- 
2.39.2


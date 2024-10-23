Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0954D2E015
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 05:28:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD252891E9;
	Wed, 23 Oct 2024 07:28:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rvopJERM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5558188A1B; Wed, 23 Oct 2024 07:28:05 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77B638926A
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 07:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c96df52c52so8118347a12.1
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 22:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729661281; x=1730266081; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y1G++O62XMHNN/prcEGeG/JKE+dQY2jYrv2te7Zezwk=;
 b=rvopJERMkmDUan6fVpNc+1f/RplAjlfWVfqSkgtnHvzAkgIEnfW5W6rPZ03oi6NHOY
 PeRPjtze0Ru8pqW4vwDOUbmf6rOEgCu1dS5wBhBO9mggOfOOpkLszcC+XEUiD+4/9o/D
 9GoHMBtMMd+mhUqN44sJbtY1xg4ybcsqnpZAa2cdLp3bsKUskF0UtgKQ86kxaZMEi+Lu
 kOgpVYg+tY0qTuvOPPY2zplPvTRJmY6z8rtQ0kLkZCYhiejgTAMwCazpqd3nosjXGRiu
 2MiFoPia3GB3R6ldI7Uyaoovnwn7PifDdamixAXkk1eHITHRV0m5a8F6HKz+1IVup4eF
 Y2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729661281; x=1730266081;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y1G++O62XMHNN/prcEGeG/JKE+dQY2jYrv2te7Zezwk=;
 b=Z7O4ZDkBsf1Rae9/3y1/D2vWr1WxFE8N9EpYemDtBAuaT/CQ3Xip4FEyWsmz6EJtYw
 7ny4mknQKBcLRzc8RKW8lyR+VAQBP1ciiLg36Fft+AUZm/KYpgmEJCrbltLYYc7e4lR6
 zgP9xgtBc4x5nSMt0W2VTu6njAI/V42N08QzofgNOMfnYjnS/Ms1CHajteQX47UIpx5z
 2UV+pVnGB5ZoTNCfYc7R5Jcxo9wFWgMZVMCEXEz8AACg0NU2B8luW+tvnHGo7xOctQ70
 qx9f1jasJ1HNjmc0r/yNQnNgqnfJ7Zx+JhkpJ/DuqnPWXQE02BI4gNmhUnAIWQ7HiB3q
 vSqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdBoc4uemZr5pYlPg+Ks+JrWEjWkDe7BAA1sv9f4IXhew+HJ4MeDVmCJrDrLlfpTr/A3G/ecg=@lists.denx.de
X-Gm-Message-State: AOJu0YxopcK13r75aVWVjQR5vy9pUe3WOt8hmZ991fveObp8Dm2w6pp4
 9x8t9tH1js2ZhS5Wh7gZbytBWzFKgKlUD/J70cgQlbt2uRIVAXwOaqCzLsItsl0=
X-Google-Smtp-Source: AGHT+IEYhBKSV+mEzk/moq+o+dbpyNd2YAakGYYL8SklqAd6/FGtxuhwqbxMtB3S9540RDdHw9W9ZQ==
X-Received: by 2002:a17:907:9496:b0:a99:46dd:f397 with SMTP id
 a640c23a62f3a-a9abf96f1f5mr103826566b.64.1729661280812; 
 Tue, 22 Oct 2024 22:28:00 -0700 (PDT)
Received: from localhost.localdomain (ppp176092143132.access.hol.gr.
 [176.92.143.132]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a915724fdsm420423766b.166.2024.10.22.22.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 22:27:59 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Artur Rojek <artur@conclusive.pl>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH] board_r: Remove duplicate headers
Date: Wed, 23 Oct 2024 08:27:50 +0300
Message-ID: <20241023052750.1067020-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

efi_loader.h is included twice. Remove one and move the other in
alphabetical order

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 common/board_r.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index e5f33f40643b..61b15d01c25f 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -32,6 +32,7 @@
 #include <command.h>
 #include <console.h>
 #include <dm.h>
+#include <efi_loader.h>
 #include <env.h>
 #include <env_internal.h>
 #include <fdtdec.h>
@@ -63,10 +64,8 @@
 #include <dm/ofnode.h>
 #include <linux/compiler.h>
 #include <linux/err.h>
-#include <efi_loader.h>
 #include <wdt.h>
 #include <asm-generic/gpio.h>
-#include <efi_loader.h>
 #include <relocate.h>
 
 DECLARE_GLOBAL_DATA_PTR;
-- 
2.45.2


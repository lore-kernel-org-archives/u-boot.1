Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05D4C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 13:56:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5793382D32;
	Thu, 17 Apr 2025 15:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nzGavX+C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3B6382F5A; Thu, 17 Apr 2025 15:56:20 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8439082D18
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 15:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2c873231e7bso438510fac.3
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 06:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744898177; x=1745502977; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9T4PkAz772+50Otk88itAJMvWo1vLjesXEIcMKgs7uE=;
 b=nzGavX+Cc5+9ie56TF2kx3MLya2UrI4LT81l5kozSJYaPxhkXzw9vpOKmJMy/ZD+eB
 4xHxntAVvhz5rICwlUVSIEJAYPQAT38nj6aLVuc2BC2tJiVjyvL8dk7fP+6SzU4rJzPT
 dikCWmKvKEtB680bDndSVEXqtaAWny7wqdJw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744898177; x=1745502977;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9T4PkAz772+50Otk88itAJMvWo1vLjesXEIcMKgs7uE=;
 b=P0w3jFc97+SjlaemF9PEEhN7N4W22Nx49EtpRujezykCA9i8jciM7ET1qWB5Ecyk4K
 wFGaoKl/0iFYZyJJrxoWH/xaCqqWjmNFPVDhS2Zof25rRg/ACfsvGc9bxC9vbWcfKujf
 ah6cx7JczeADjQepslOy/vRtNdzreYD/p7ci4HQVghbWxR74OGKItVI6KYcSHau84Yct
 qZzDn5Jy5CC7OQOpHwl0Ioz3/blTyjBpgFbLNUbRPZ01ed5/quB0INS292IrqjYjBaol
 L2lk8nP5gVpOY9df8fOy7ehGpgakdlD8vGmec6iU8BHFMW0epCWLLYX/DTIEb36z8KkL
 1jzw==
X-Gm-Message-State: AOJu0YyKbw2neIdz9WUUvE0RxaDIR106XicPN/2XvYNPvBltQA2G40bU
 LUb5TF29gzCY397bTPVFosKrzLPH0TbYawph+g90GO3E8t7cntRpM2wE53aBtvfzp//9HMTubKd
 e
X-Gm-Gg: ASbGncvfTNOx9vIndPwKF2FNjEA7Omp7DZsETwiYv1VZ+za7OahDQ75CNLz8/m6yB0I
 6+GiZoLnWOOyahsS1DyM6IGbpp6qZFsgP24cJ63meYl+sJhxQIWHzt6qoD+fbAJPPyfF2SQdPtF
 83z6lM+Xe8pdg6dp4Y6XIblVysqAdujsp7+COs4yP653w2uNFCGmKl1TJnkI8yL+R4x8suTG7F8
 xJcXTGKAP/MufcDfkdRtoZGKNe1qvHmAdG+nFq5LfPeObD/lxJAa1CGMfAhI3VU06AMYm0OUvSv
 evKytSkh7EZMBYBP4XhUA4cvU+xsVqFArFdJegEAYDymQPwBVqy5zzFQZUQB/07HWoRKHvQup4v
 Uh96z
X-Google-Smtp-Source: AGHT+IEG6OUc00o3hLmZvayXuzfW9PuqYlpPlNMm907nd7Ze7uoDHtyp15Vgk9shOBLFjlj7UyoL+g==
X-Received: by 2002:a05:6870:164a:b0:2c2:3ea8:eb3d with SMTP id
 586e51a60fabf-2d4d2d4f452mr3748244fac.33.1744898177230; 
 Thu, 17 Apr 2025 06:56:17 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e73d5235csm3216793a34.4.2025.04.17.06.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 06:56:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] cros_ec_sandbox.c: Drop spi.h include
Date: Thu, 17 Apr 2025 07:56:15 -0600
Message-ID: <20250417135615.2974560-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

As this driver needs to use the special sandbox <asm/malloc.h> header
rather than normal malloc, it must be careful of the includes it brings
in. It does not need <spi.h> for anything, so drop it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 drivers/misc/cros_ec_sandbox.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/cros_ec_sandbox.c b/drivers/misc/cros_ec_sandbox.c
index 1cad51d474de..3ac690a37336 100644
--- a/drivers/misc/cros_ec_sandbox.c
+++ b/drivers/misc/cros_ec_sandbox.c
@@ -15,7 +15,6 @@
 #include <log.h>
 #include <os.h>
 #include <u-boot/sha256.h>
-#include <spi.h>
 #include <time.h>
 #include <asm/malloc.h>
 #include <asm/state.h>
-- 
2.43.0


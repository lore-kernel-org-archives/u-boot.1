Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8C1C7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62BD78309E;
	Wed,  2 Jul 2025 03:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hu4i9+mT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 988C1830A0; Wed,  2 Jul 2025 03:05:54 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88B1B82E86
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:05:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2eb5cbe41e1so4444309fac.0
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418351; x=1752023151; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=pQ7mv4RW1T7XSQtg2LtDmHmW8SsCPwDU7c607IXERQg=;
 b=hu4i9+mTXzhVBt1jRwLy84XZLb0cy+Jr3ZdgU8emk8UkKcqyuJYfiZOS5UKXuXOo6v
 5xHPGKVJbuTNaWU+HsG68uWm9saLnJ0ifYYunBc+vxVCzFybGI3jmfHJijpkkMXs+ZI4
 TJo/S1ZIniqGcBoHjfrztbK8UsqDhBDpBoGdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418351; x=1752023151;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pQ7mv4RW1T7XSQtg2LtDmHmW8SsCPwDU7c607IXERQg=;
 b=Ar/LfKQkS9JQGh7AcsUOXTJh9qcnkRVBegQVTTsMURcHB4pzPPX924aMfJXkCympE/
 2FxxYNgaCeSHKkOtol3y/kGaycUv1Fr0omwGVvDHhBLN/Tqp9Gnknr8ZYNUwFbrd4U2Y
 n0lHuZ7jhEdz8LXccWqcF/hS+zfLE4MqW0a3emUaxxKdy597maO2yR0RP6lbEuitNTKO
 5E7SHXHnCM0hjiN/tgVAGr/fm1+Sg99q0AAntAmhJDfNfQAFTL1L4bmz+mU6Mgzx5djl
 ZmK/DCHAgGPK2DDEb3S/xe5dk5bl+yPCw1D/ZAKlFdjRRvDQidwTrIA9BQrbnKKTctYB
 9BiQ==
X-Gm-Message-State: AOJu0Yy5jGGguiBVO06FXVnM3cCYvM//hQ9aWPxsJJnyM5VxPJkUY+Nh
 KYrDzualrRtJbWcU7NSwIuptY3Y7M6DoPXJqOJLb59S/UBzZQdl6mF/LCeWf+MmCZBL6FFyQjP2
 vgRg0pqo=
X-Gm-Gg: ASbGncvBKsEpxi4vGDp48WKpySO5OWMRgRPzSt0p3ha+FotznrhCNoM45nmcy/inoaG
 P2x55qOw6TOLbKYlrrRfd4erqOHUqBAjgB/gxnwSEWneINqPHOdrvJ5znv8b1c05TAk6EHwI4kb
 Ziej9h2ndOFOHrQoHAFS7mzLTdXxr1cg5LPfy5whQpvcUmk3pgbD848+zd/ofL0JgPoSS0d4Fgu
 cGzACznuvgVyoa6MVj/mAyt20n9npQVToeFVEVK8QTv8DG0F6xMeYsSBkLafA0B7NGIBQ8voA4K
 RTuBYlxTgTbDnT+tIASgknXBIiBfT9wv/sm6PZt22MYHynIRSH4hhTKrgfOWEKMw2CwwGja29B1
 mZSXCMZSc6VvPtBboCFKaSK8=
X-Google-Smtp-Source: AGHT+IFVlpPAX9nF5eTpY/WHYPQ07teOLdd7wOkNviiBSfd81Hrp2k6oc/xvwh6KJ3o+b3vfm+iSuA==
X-Received: by 2002:a05:6871:cd07:b0:2c1:e9a3:3ab3 with SMTP id
 586e51a60fabf-2f5a8b819b7mr843643fac.33.1751418351193; 
 Tue, 01 Jul 2025 18:05:51 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4eb261fsm3614258fac.8.2025.07.01.18.05.50
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:05:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] i2c: Add missing <linux/delay.h> to iproc_i2c.c
Date: Tue,  1 Jul 2025 19:05:49 -0600
Message-ID: <20250702010549.19289-1-trini@konsulko.com>
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

This driver makes delay function calls while relying on an indirection
inclusion of <linux/delay.h>. Add the missing include directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/i2c/iproc_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/iproc_i2c.c b/drivers/i2c/iproc_i2c.c
index 6570f64fe774..8f94dfe117e0 100644
--- a/drivers/i2c/iproc_i2c.c
+++ b/drivers/i2c/iproc_i2c.c
@@ -8,6 +8,7 @@
 #include <asm/io.h>
 #include <config.h>
 #include <dm.h>
+#include <linux/delay.h>
 #include <linux/printk.h>
 #include "errno.h"
 #include <i2c.h>
-- 
2.43.0


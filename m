Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA2FC83F17
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 19:45:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A306E834AD;
	Wed, 23 Jul 2025 21:45:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sPn449PJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9AB38353A; Wed, 23 Jul 2025 21:45:04 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C095F83297
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 21:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-73e65c09828so107353a34.3
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 12:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753299901; x=1753904701; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=D/qzIF0JSuBzqmz13wH1k1MpsVe5FRlE7OMX1fbO2gc=;
 b=sPn449PJZSjP/jPITW5Irc9bekJYXmy+O0EcAihvQ65gRLusMA4b3Ez3Oqy6+EQRJ2
 k7UIMhF6mBS+ax8Pd/y02r4Vt6GmQz4dmwNWuN/tLzUNDONB+nAavr541v2wnmIlCI/e
 sSR3aPsi9EJbsdyA1wl4uZmLZvjWkCpAZxQuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753299901; x=1753904701;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D/qzIF0JSuBzqmz13wH1k1MpsVe5FRlE7OMX1fbO2gc=;
 b=DR6dpzUdF/cvr5dnGrHcNptuQJ7KIj1Y/l5B8ifmKIgUtWEDvdp3kOaVOf2eRyKVSA
 x/9iq6BSY9FbCaR70VfqQCSp4iij9mqegi/m6affHfhotI6G2Otht5U7LtLTvS0GTQmS
 cpzebAAugHy2/nn1KJe81/C0Si9B3gMGNnVxXfTd35OZkQ8UOOEeKNH8GXmCnkTJyDbL
 WpYEMAEcotT/sQLvT8maH9QMS65C/88z2KvviA9PJtTtVzISPkaPShCTjam9u9Ew/xNw
 FHgR2F+s8CBSeHqR2Cy1S6spPsJ+TWR8xBlLiopJZ7uu1ieiCwRyIt1TtpPHrP4eaElC
 64Nw==
X-Gm-Message-State: AOJu0YxS9f04y4mtCPL7Fjvf+G8JvZtO4vEO4yTlu3gT4K/X58TO5LFW
 ujS9E3ojVLgg7Z1yd+HjqsXt0v9gusqo6NYE2j4bOy8KGIWNegeVSw1byVrm2GvmrsnWk8AUoth
 qpfXJUtQ=
X-Gm-Gg: ASbGnctvHOZefqAV94X9gakAXkIm6p6t9uQe5AUdyjgYzZGJI6nZNbBNueNHTaJT7nO
 682zE9230W02B1z/MIaPnl9p9Qpg25AkPthcXSsOt+Tnr1gNR/5NyC/zXg4ErUFYeOqAvPyosXd
 yvXmYaI3XQAUZ3aH6NGeoonwMXjHIgK2FBdmzrVZgwBLeB6iog81xxSPnK18IvKIvHIR7myzqTe
 RN/bEuG0Ezeq2DjcLeKA0u+n/uL8lNbvt1+xTaapNUiJCYLwzi7zz1wtbtfeFWGZhpIZLckKHtA
 FdngWAn/Sc2ifuVjCOtV/q+mA5g1CALVvbr3CDgJhzFXkZw2sVttvEDqqd2AeYpYGf1XdV1ZrKQ
 aoSst2rKt45FGW6von/w0a4xUnDrZ6/nC4lYZXVL00owp6veIOBywNI3djeZ0aDeqpHrpXg==
X-Google-Smtp-Source: AGHT+IEcVBLCJm+J/0yjqGJirGfFICR7qAgD/rq+buyYLzBOr48HsuT7Y1CxDgkM5osvFK8tuSgG7w==
X-Received: by 2002:a05:6830:2695:b0:72b:9d2d:804 with SMTP id
 46e09a7af769-74088bc2c25mr3221720a34.26.1753299901377; 
 Wed, 23 Jul 2025 12:45:01 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e8367f410sm3893589a34.24.2025.07.23.12.44.59
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 12:45:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] patman: Update test for Anatolij's new email address
Date: Wed, 23 Jul 2025 13:44:59 -0600
Message-ID: <20250723194459.224015-1-trini@konsulko.com>
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

This test was failing due to matching on Anatolij's old email address.
Switch to the new one.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/patman/test_cseries.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/patman/test_cseries.py b/tools/patman/test_cseries.py
index e58f2f683332..4c211c8ee896 100644
--- a/tools/patman/test_cseries.py
+++ b/tools/patman/test_cseries.py
@@ -3278,7 +3278,7 @@ Date:   .*
         self.assertIn('bootm.c:1: check: Avoid CamelCase: <Fix>',
                       err.getvalue())
         self.assertIn(
-            'Cc:  Anatolij Gustschin <agust@denx.de>', out.getvalue())
+            'Cc:  Anatolij Gustschin <ag.dev.uboot@gmail.com>', out.getvalue())
 
         self.assertTrue(os.path.exists(os.path.join(
             self.tmpdir, '0001-video-Some-video-improvements.patch')))
-- 
2.43.0


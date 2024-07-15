Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69732C3DA5E
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 18:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA78588855;
	Mon, 15 Jul 2024 20:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ugWxETs4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F7868881F; Mon, 15 Jul 2024 20:45:34 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3C6488855
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 20:45:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3c9cc681ee7so2402892b6e.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 11:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721069130; x=1721673930; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=rFAVExot4oGR0wAm3dTdPAtYzzNmC2L19wWcGo49PUY=;
 b=ugWxETs4GJFqAT2QuBIdn2mi9leN53Rqmdl0qvJ7LKHqZ6i/EZd74FVhJvbFF3v6Mx
 WADPt5kBrfO8X8dSVEFAcHJevfHelUvPakMwHu3tKlOdo//Ysa6dp3xRko29bbPv+DoQ
 YN18PAFTamgXJ6ouL9RWdh2Yz+fPYq0VwUFEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721069130; x=1721673930;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rFAVExot4oGR0wAm3dTdPAtYzzNmC2L19wWcGo49PUY=;
 b=hDcY0r3LpyxWhjLkCW4NtjkEAaqtgS5+EMkfjQzbKdwYE0WBe6sbqhBlkJb5wiwb3O
 Qv+WDYIADJeOPMesEHQhnNz9mKv1QHcpHuUUIchesTli6daZuTYWVKbEZuYx2KqzxIlM
 7qe/UsZD99w7Xa9BA3yuxX3bKKXxnDAi61d/Pn7xklGSHQZeKPZb5qNUBKHjl9OSJLem
 34alUuuKDgc77Lh81WDcPH2vkaJpoeZcNyFBw0G9s0HxeLFVxSMhzuZ8esTUHzX9DyYC
 VY9IP3rg0N5Cfia1t7kLCSjmzx3OgJQvl6rnLpmXDhWvjReeJRIwMMu2v9ESDCi9oo1L
 Z7uw==
X-Gm-Message-State: AOJu0YwuQCEkSO35QmwbVW+pflzo8dVHtV+ruYhyDQDObbzZn05ivkVY
 uOApv4ffOyZG2E8fs1uPyHymLrfjU6c1pWZwRCl4LG0DRXgCGThFlkj+qxk6bwnTa24AFCwMpoE
 H
X-Google-Smtp-Source: AGHT+IHCabXU9Wm7SMGkWYBhP2ydrO+VZKE2n9GazaIcqP0yBMq8jwUqZ1n8xWcDJDCupNzXkJgAwA==
X-Received: by 2002:a05:6808:301f:b0:3d5:66d7:feb8 with SMTP id
 5614622812f47-3dac5b97436mr390447b6e.10.1721069128691; 
 Mon, 15 Jul 2024 11:45:28 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-189-203-103-45.totalplay.net. [189.203.103.45])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dab3dbfb18sm882789b6e.1.2024.07.15.11.45.28
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 11:45:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] test/py/requirements.txt: Bump setuptools to 70.0.0
Date: Mon, 15 Jul 2024 12:45:27 -0600
Message-Id: <20240715184527.560645-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

There is some potential security issue resolved by upgrading to the
latest here.

Reported-by: GitHub dependabot
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/py/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index c1dd636931f7..757b4d70d170 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -21,7 +21,7 @@ pytest-xdist==2.5.0
 python-mimeparse==1.6.0
 python-subunit==1.3.0
 requests==2.32.2
-setuptools==65.5.1
+setuptools==70.0.0
 six==1.16.0
 testtools==2.3.0
 traceback2==1.4.0
-- 
2.34.1


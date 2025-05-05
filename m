Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FC3C3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 20:51:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4C6282102;
	Mon,  5 May 2025 22:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TeeZx5tt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 378448210A; Mon,  5 May 2025 22:50:59 +0200 (CEST)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDB26820EB
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 22:50:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-875b8e006f8so1200920241.0
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 13:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746478255; x=1747083055; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z73howeQrKBvG7ZEYKpkbXgsZzXVtK2CKotA19tpsOI=;
 b=TeeZx5tt/8uQECPCFie0IuvLHB2iTDzJYsQuQU3mTAoW8PKGpJ5K4bgPJ2BYePh2Ma
 S2Z+8dhk6p8ZAcsdcJ8PekZIMbuX6kFE//OEHeCqBgateS+PANjZhOL2D5gMhMbtQHKm
 FYMRgw37spOBrneA+CvfgDjZWQdeWbekDgCFE/4F1L8JYYPGwMOATuP0DNmyYN21bV/j
 nY0i18zWhgxMpTZHu+cN2k95lrOKzr4floK2cfXM84Im4DRDEu4FXDWln8kMj1O8Du1F
 sCBFa2Mi6hQGvb3AFYzzWgQlFygtSt2oeSIVYWW+auiVvrFZSEkNNCJpz7lArAGv2gw7
 CfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746478255; x=1747083055;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z73howeQrKBvG7ZEYKpkbXgsZzXVtK2CKotA19tpsOI=;
 b=lEmeKJX6BTybYlsrVq6r8A92JfEL1o8+s88dTOqfN5LsBdEeekiFVMR1iA13uxWZAk
 3WL76zKyO/gV6X6gTX0NSm9q0UDm/lvde93pGTJ1/vP6pnBP7Fthx6KZZW1W7Ju9jMjw
 uL6gmuvV7NX0B8VSzYOIuVFWNuZmqIJhQsYKU+km7QEWGmzXnw8ak9wGn5+xvK2b7rRq
 qaiQ1ALYt+lE0Ybnsgtpa0pJHdblQES6/TAj1FNkVESsc4+IBSPTkeTwD+wEYKlpJd8o
 3gmfLGpLiLV8ftz8cAEd7nCkZxfYRzAbrjbVL8axK7iymSEhB40Rg4CfXaN5MTsHOc+j
 kRAQ==
X-Gm-Message-State: AOJu0YyUqE9wKBRYuD6h5e5vnTa4jyDfTetQbKBkV+rWaY/inbBKbxRB
 ovsT7sHmu+heJNEEqYiAJL63Jd+9eQY4J1ZiA7Ox25Zt9GE9pRk1Yl9S4w1V1vr6JieG8dgBAzI
 H
X-Gm-Gg: ASbGncsdyhMyAL+rs8Hwz5JU7nP4xpIQ1cQ1qsaNO0QhRV5bdPwtHJBHp87nQADStNJ
 GwNkwfuo2CQe7sYI+D8zwVu0j6se6Wyt4Mgl64x7jJ4WostRLFxhoxQS1RvCrNofk30EpAyWPnB
 EXKvEMldBmhBIGGH7YP1ae+Y6odQyk8VyBTmMfECPb+GtoDR28KZbH8eN7goTGSNk2Vuo+B8tzK
 kKulqNI5/EpbaBYLFJkY9Y8AnijiO8WaVjv1K5ynJaA5YiTcT7AbHiFXXl80AYRFY2kuqypqX58
 zt3eAlRA83DzngtGC+o8rvcfm1Ot9ubVbjey0R/tKA4sLHGBo+4VvDbEeJkOryKJR5WgUuE=
X-Google-Smtp-Source: AGHT+IHaz/uuSz0CfIrvE6YrZ8sECz7SJZVjMbsTBflADuFaxGp6eJbsCFjDi/HoAVtKcmdsb7iKnQ==
X-Received: by 2002:a05:6102:f83:b0:4c1:8c7d:44ce with SMTP id
 ada2fe7eead31-4dafb4a9f18mr7872200137.1.1746478255532; 
 Mon, 05 May 2025 13:50:55 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e.. ([190.171.102.101])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-52ae41ef652sm1671423e0c.43.2025.05.05.13.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:50:55 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] test: Add setuptools to test requirements.txt
Date: Mon,  5 May 2025 14:50:51 -0600
Message-ID: <20250505205052.347616-1-javier.tia@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

It solves the following error:

❯ ./test/py/test.py --bd sandbox --build
+make O=/u-boot/build-sandbox -s sandbox_defconfig
+make O=/u-boot/build-sandbox -s -j32
Traceback (most recent call last):
  File "/u-boot/build-sandbox/../scripts/dtc/pylibfdt/setup.py", line 23, in <module>
    from setuptools import setup, Extension
ModuleNotFoundError: No module named 'setuptools

Signed-off-by: Javier Tia <javier.tia@linaro.org>
---
 test/py/requirements.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index 804a427b351..5be94a44912 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -3,3 +3,4 @@ pycryptodomex==3.21.0
 pytest==6.2.5
 pytest-xdist==2.5.0
 FATtools==1.0.42
+setuptools==80.3.1
-- 
2.49.0


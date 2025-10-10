Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9B5CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 20:24:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47BA183F91;
	Fri, 10 Oct 2025 22:24:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iGqvRkCA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABBD083FA7; Fri, 10 Oct 2025 21:31:49 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CE4C83F8C
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 21:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mattianarducci1@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b07d4d24d09so455038066b.2
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 12:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760124707; x=1760729507; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=3CBarQ7Dy8Dp2Z4Xghwkx14xeYJWHf1FxOxrcIH3nMs=;
 b=iGqvRkCAmzeVISTSJ701AgQfahgG0MC09UMAJZRn3aZDyUQdbbaykAsH1JxTb60PU2
 VtA/scsZhnhw/Efb3nJA0KPdQ+BVJosFmnLUOZy02A+NNE0peJG5vpifW7qRh/+C7HYt
 3k6B31zpWWGqKkSlJOVSOx9IwobAru52miEb17ou6tFx5EnR3ppF89675KrR8x2mpQ2Z
 HrHYmg9oIgmftzHeXYKLEtKcQmFlXz7noUrPQ+qKxK/xmPLLL3GkKQUoihKf4+fp9Lov
 8ASImmgXZeM7a+wqChdLGp+eOtzqqvNIYA89za1BBJ1iH1ilaxPIYcgIXQJrXJm7chIc
 1g5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760124707; x=1760729507;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3CBarQ7Dy8Dp2Z4Xghwkx14xeYJWHf1FxOxrcIH3nMs=;
 b=AI6Llf+yZ8VjjsUrTQlbMdpRFXfm98bIUB8Xe47EcMD07bEoJUij+j+ohX+s1TZq1n
 kHOIh/+YYqoeJkD/ajEB7WuIrxS2IqwIUjKWAlObu7Yj10+O+7Qh8+/bTf7A5pULIdjS
 uPlW0/5Q3TWOnn/Ue20EPHwvQvazQuqQhTZV90Swi/AiSvcFK5LGgFaFjHUK0uiorrxx
 DE7woyyOvHEvII4uJasdwT9IkElR/mM8bIdUZ+/Yfw7v8zCSkSNGF1T2LPPq09cLU2TQ
 nZrYg2MMQSbyxa1G7RrnWtp59mAjeJMKpI/HMVsPp/ncyWfxKi6LzTofVWaZeYSLtpvx
 AesA==
X-Gm-Message-State: AOJu0Yy81aFU31iqy7yHMgAUghvDmGLtcprkxbw1TYncBSKTXs33lq2v
 y2Xsb0YSpdKRub5Q99PC1V6gNMyS4j+7NrAQIW61GZ3xE6rFdE305ErQvCXDO3t7
X-Gm-Gg: ASbGncu3XVOJfG1ao8JuAaG8xj1/k+Gpu2dQK+6d79fXVZe930MjNMKQcwWR+v302cz
 qbDx0zeTd30WW7+yoztHmvD6Ihv6z0vlkLRMUSvlm1FTde5EsMUrmDHDJIbz+UXA/ePEZLphQNf
 IebLhZ8F1pOmSBT7e/one5RWZvr5PxW1y3130p735bRRP0WyOa63ZrfkSJcXtGcJBZLtbPR8b/C
 Qx787T+RX4q+xt6GDyvoEtHXMzrShCvxR19wJQP6K/8tcns2D04RHoVDW1J/h8zfN8aVpbVumX3
 aujUdZteskavLgyR5fJN3zDglFZW2nagjquTDxvEUBhNC1ndgTi9RtngtNrdkiAfiG8CVbSkcvK
 YDCnKSSIlBcNmchR0KCn6mYgOGD7iy/gxPbZryZbfescFYrF/vrPdQwBI
X-Google-Smtp-Source: AGHT+IEDG7f07lpmgcSM9YYVBvYGqFLXBieRsLKC8KY3ehxOEuH6xKDQ+WTv51CBeyF+4ZK8+IfI9w==
X-Received: by 2002:a17:906:f599:b0:b18:63b8:c508 with SMTP id
 a640c23a62f3a-b50ac5d079cmr1190155866b.44.1760124706732; 
 Fri, 10 Oct 2025 12:31:46 -0700 (PDT)
Received: from localhost ([78.208.26.115]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d951ceb4sm296588666b.72.2025.10.10.12.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 12:31:46 -0700 (PDT)
From: Mattia Narducci <mattianarducci1@gmail.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] doc: environment: fix links to Linux kernel documentation
Date: Fri, 10 Oct 2025 21:31:45 +0200
Message-ID: <1937375.tdWV9SEqCh@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Mailman-Approved-At: Fri, 10 Oct 2025 22:24:14 +0200
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

Architecture-specific documentation in the Linux kernel was moved to
the arch/ subdirectory.

Signed-off-by: Mattia Narducci <mattianarducci1@gmail.com>
---
 doc/usage/environment.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
index 3764f65c221..5553a629e42 100644
--- a/doc/usage/environment.rst
+++ b/doc/usage/environment.rst
@@ -587,5 +587,5 @@ Implementation
 
 See :doc:`../develop/environment` for internal development details.
 
-.. _`Booting ARM Linux`: https://www.kernel.org/doc/html/latest/arm/booting.html
-.. _`Booting AArch64 Linux`: https://www.kernel.org/doc/html/latest/arm64/booting.html
+.. _`Booting ARM Linux`: https://www.kernel.org/doc/html/latest/arch/arm/booting.html
+.. _`Booting AArch64 Linux`: https://www.kernel.org/doc/html/latest/arch/arm64/booting.html
-- 
2.51.0



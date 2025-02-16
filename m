Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5A3C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 11:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2FDC80F12;
	Sun, 16 Feb 2025 12:23:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fvzh0kql";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07DE480F18; Sun, 16 Feb 2025 12:23:51 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 069A28056A
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:23:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-30797730cbdso36423521fa.3
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 03:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739705028; x=1740309828; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L0NvbNR5Ka9CjrDN7x0sPzziWmromiiroCEUEcKIsjM=;
 b=fvzh0kqlLY5VLJNsshKCf7A/rqYxHH5iMO9aZ7/M6S/FmTb31/ER6CuIBXQVXd5t9d
 40IRHg6DIOd5jgJyt1dQv6cvnCSOHd+KHzd6ig4V860n/wpP7BzgEClETkj4Z859s+nR
 cPpia91s7TCbckTbsVylulAWwkHrad766VkLPoYLDhqHC534qUPL0yZPKXK5alqfbKd+
 BOc2eJgvwiHCGRnajlTTbc+/CnYn9TWE2VywIRmP7mRRJeQuMkFyzb/1KctR5iEijJpJ
 T+nUuc6RXE4X5C5jzVoMaFP8FNr/QpOqGjfKgNTsS50+WvsQxTc0rb/ja9lzSmqO0OW3
 jfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739705028; x=1740309828;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L0NvbNR5Ka9CjrDN7x0sPzziWmromiiroCEUEcKIsjM=;
 b=bYHfnhTcTUhXkR5m5wjNyd4JeN4vXNGNUvnTkluJz9TLa4aNW/PUAUzlwQ4qwB+RXd
 r8YEidagJdsjYgF2hriresDCL8aUijGhAHzCFxVX62K9RlrKl5Nw3ZSmUcxMMXal36FL
 GH8fyYSW0lYWAHzjSgPItxOMOp9a8WIkapnCMNDyYw58HVrexPLEZAt824BnQYwtZFkA
 vOavW1h+18Ba9RyzX25mgGLimqt/H+8ZpbaaOmzxvM6Texrprz6RsstRVeyovGSsH1nB
 cCN5o7nqdu8t8bL0tacBmpYp4Wn6eYX1SJ+nNixe9/P5vvYRedk+tl1FlLbh79m8A+Rt
 tQPQ==
X-Gm-Message-State: AOJu0YyutBcn+/tbB6HFCkK3ArX4dYgS4PtxvZbLLg45DAub6TuEhLus
 kdkEpfTXjzcq4SoTYsmEaLvxFaWDz9bz0sZ+qkaVHPX6cWTawowl
X-Gm-Gg: ASbGncsKK5zjEpoN76zwFqoB+l1vrTwmkXLsz2tRHslx1nAH5P4ffSP/Y3Oq44xnYen
 04MXS1u/VYGDtg0VFBq0k9AX8PfD+EayTiyWrZJEaahII6lt/LXKmnA1Iap4joyxQgFslL2iAfR
 WI1SDLId0GOrFh71gLwUbzSUQvVAsmrnJWbvTP0Iwg0gzk5v6DIN6X2fTnJRgXjkAEizYg9uiW9
 5vQ8t3Zjsynx4UgOhfzoixlY8js0/ABeibS0ocjGceGLdorKjHeXWmcMNcwy7BnAnUaCHb60/Ck
 fV1lfvo=
X-Google-Smtp-Source: AGHT+IEyt6/x5DDKLW6csXUisldQBA1rt6X7oZ1L7nGmRpo6/dqxxV+fVD7BlUrl9n7kU7nLjxDVjg==
X-Received: by 2002:a2e:300c:0:b0:308:eb58:6571 with SMTP id
 38308e7fff4ca-30927b1b2e8mr17838861fa.26.1739705027966; 
 Sun, 16 Feb 2025 03:23:47 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-309100c528asm11976111fa.22.2025.02.16.03.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 03:23:47 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/2] core: ofnode: add of_graph parsing helpers
Date: Sun, 16 Feb 2025 13:23:25 +0200
Message-ID: <20250216112327.59090-1-clamor95@gmail.com>
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

Add a mostly complete list of ofnode analogs of of_graph
parsing helpers.

---
Changes in v2:
- added tests
---

Svyatoslav Ryhel (2):
  core: ofnode: add of_graph parsing helpers
  test: dm: add ofnode_graph tests

 arch/sandbox/dts/test.dts   |  53 +++++++++
 drivers/core/Makefile       |   2 +-
 drivers/core/ofnode_graph.c | 217 ++++++++++++++++++++++++++++++++++++
 include/dm/ofnode_graph.h   |  90 +++++++++++++++
 test/dm/ofnode.c            |  54 +++++++++
 5 files changed, 415 insertions(+), 1 deletion(-)
 create mode 100644 drivers/core/ofnode_graph.c
 create mode 100644 include/dm/ofnode_graph.h

-- 
2.43.0


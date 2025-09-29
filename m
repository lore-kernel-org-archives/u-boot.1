Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C67CAC5BC
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 15:52:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CA25832AD;
	Mon, 29 Sep 2025 17:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S29xTOg9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F80F832C8; Mon, 29 Sep 2025 17:52:06 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 047EF82A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 17:52:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alex.bennee@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso30400705e9.2
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 08:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759161123; x=1759765923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hZBlXfCeyXtS1jVz8opDjUQaqopokHiC1gYyOB8GScE=;
 b=S29xTOg9U7Ee7YFvLWciPcVct7wH67uBvvH3yl7mLBozncCJiA3CuRjXYECviNOhin
 z+VraEsm0xZpi+QmNh7eR/MDdrVcW27d4dZj1DExstK3Pg1S+sD3G7y1LSsOITrHyhes
 Z+ZjSSeLm4EKnDyoMYWqO53HLMgMaZPebkMPFeNJDOM31DTy2HoV7vFPmluU/ruzDvHH
 kUN8/62lItzcsP1CaESQQ4DNbifBV+0W0iCajEeqqR1H6nBgQ4U2esjW9UzitKTqT4A+
 HcG115q+VNCjM7uVyz+0WirG4VdfRyWDLjMXPf6jApWqJO1ok9oOd3luQ76+wJcALTNK
 HCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759161123; x=1759765923;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hZBlXfCeyXtS1jVz8opDjUQaqopokHiC1gYyOB8GScE=;
 b=UjLeP+cYsSD708kQawRTkTFuqFlbMbIUbsDACvwJHBNAdhSG4g+ZEdjyz+JPtCvMUb
 X2IfgjY7UcYKOUat4Yiu/ruYTqaMVh47V/VwypFhswwb9D5BlcNBdF9pzGplu44eDkX1
 FQoIW/PtPacZqe8qeoTiAXaH2gM+MWJyNPE/r3y1qew3oPW+z1cb5SDsUINerMBrqJTm
 sjqH9MuIk0aUlcxwLmmPNYzyw8nKJ08Rm5Ve8cV9wFV1pDg+0GgKjGaORj2VvWcI/iTt
 DtvT6INkGhQ8AVFN0pFyhwwkD/FkEF2logkat7vK04Cz5SUWpwz9c+nFU1vPePGdkysB
 cPgg==
X-Gm-Message-State: AOJu0YyW71a/+MMxWJnaxoWStDwAIolzl4GhgLkJNQYtld4APF+TocoR
 DaaOjJ8ghJbrQfGwYdGyJ9vU/n0fKXMM4LBBwFW8lm2lpL+q0c0VAmr9+A0lA2FzfyI=
X-Gm-Gg: ASbGncujbT/kFL6bonG809CnF9GYcXYgFjL6cA6EARPv/bepC3iVwDdurQRxM+Tg/ab
 jX9TgSpoxuW6Xi/i4XSq/TLi976bLo38XDqr6NLmO5EG2ASGJXv4kM2kWiLfIHKwYQw+BDigU0u
 YygKG5SYy+7DzcSzjNo6VADDc6SAj1kKAv64C+zbK03MzQ/kYuDktb9HSnXZnq6yuj54qRMkLoR
 vzKhHKCaBh4/bnkDa9oPdI5MqEki/dveK1p/r7KkaqJ8wc5B6z0wCqt+qTe8ZNwMYwApJ80tA4e
 dpXPaYWdz1aZuMsYqie7pwliq7v5aF6+bRnIpl71qGM7gaJneC2UcJ1S01bvsawULZE7tZtFF5a
 gu1QoTq90rULduAgx331Pd38=
X-Google-Smtp-Source: AGHT+IGUXcJ+wxKMq/E/5+FvwWCqP7nb8p0iGQLvc5+Yxo/Dg8+4kpUKOE1B2P2IAQa4gz1DI1JMCg==
X-Received: by 2002:a05:600c:3226:b0:45f:2922:2aef with SMTP id
 5b1f17b1804b1-46e32a0e227mr103864665e9.28.1759161123420; 
 Mon, 29 Sep 2025 08:52:03 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab4897bsm229807485e9.17.2025.09.29.08.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 08:52:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 046FA5F83A;
 Mon, 29 Sep 2025 16:52:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: u-boot@lists.denx.de
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH] link principle license to COPYING
Date: Mon, 29 Sep 2025 16:51:42 +0100
Message-ID: <20250929155142.1647606-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Some license scanners are particularly dumb and when combined with
automatic license scanning for FLOSS accreditation on forges cause
problems on renewal. As GPL 2.0 applies to the core code link the main
licence text to COPYING to keep everything happy.

This caused issues for the QEMU project recently as we mirror (two!)
copies of u-boot in our project.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 COPYING | 1 +
 1 file changed, 1 insertion(+)
 create mode 120000 COPYING

diff --git a/COPYING b/COPYING
new file mode 120000
index 00000000000..1ed3ba6a13c
--- /dev/null
+++ b/COPYING
@@ -0,0 +1 @@
+Licenses/gpl-2.0.txt
\ No newline at end of file
-- 
2.47.3


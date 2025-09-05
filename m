Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17696CA0FED
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 12:44:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E8A18382F;
	Fri,  5 Sep 2025 14:44:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WC3kxnEw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5966B838D2; Fri,  5 Sep 2025 12:45:55 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25DC3838A0
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 12:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sidharthseela@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b476c67c5easo1338228a12.0
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 03:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757069151; x=1757673951; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7anAxm4rtKq44mz8T1ErWPH1Q1n2a/Wepfuy+kOPpxg=;
 b=WC3kxnEwQyZoViY1Yes5K7kMZy8gNfSM0AumHEZmUJt9nH/qbTU5qDP75PXr8Bele4
 71ZxyGA4EXLHdsQBKIZvDpefgaheO0N7A9MRtyqGbWwhi0kXoRHAeVm2wBOQcAM5bldZ
 LlVodrky72Xk2Z6/+OjV9duL1hWXgYSeiEH8MHoOxyFcdbnFsU3U1lU1SzOZmxnpewki
 VFCvqU9EsfIDxQ8LxtEVRv3snUCTLgdQ3J2y+AlJjBPPM0cGcV7o6en1dUEBPF6OYdov
 MT0VyvrfKMzOvc2kRNWGzkZbTTWXQtGrQe0EJhj58xxEYEpa/5k+UeCYzjutICANTCmb
 JM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757069151; x=1757673951;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7anAxm4rtKq44mz8T1ErWPH1Q1n2a/Wepfuy+kOPpxg=;
 b=ebx5C76TAfgQQHhN9MIWdMerZI3AQOhIm0t47IjzdqB0fJ9Px3KHsLcaIkaJjcmKYQ
 6yweTWrOAOG0DOFqBJ/wRl+DaqcBC4FH+r7uwGWv0tzdf1TJsTbeFnVyNZ0QaaI4Ih/d
 oFUtPQsjE6hPX/YZytNkEElWSxhpP3/JLvk9P9OBrz4IcqjNvVhwn2RVznSa1uH9leBb
 CDRBr2Qlf82FwLHUkUFQtX+nlL2Vve/IPoYiY4ppxHoTJjql0LzAxAyqOy+LiTc87o6b
 1QbHUWaQStNJonVuPml04SwleJOvn2pFGs8XdtnL5ktEamS79//xKAPrXUqVK030nZZU
 9++Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu7RvEgjjWMwGsrnCJRfEtapnLT+CM7pqJERheCCQ+gk8//6ojT0SELBuDdLAEXuyM/hJR4E4=@lists.denx.de
X-Gm-Message-State: AOJu0YwVQKQo2FfaYDkV6jXoB8fFw5gWKGJGkY5zhAY3qr9zOl1ohMHM
 xpzW5517qTJKP/LQ/y8ghsJDNQc8yprilRxrhcBi/ZpByrvfsrigLMgN
X-Gm-Gg: ASbGncscb35vRyLR68F9DMQruv0Le5kwFDDyErP1HxWz1kKHTZO9G0bEDOq+TURmC0p
 +MiKnNmoiq7F01EXjhwdCLMCMJ0cHRQ+sJPLJPmsq0BzkzR9TB4BhMZJCbigWUM4uyxZnjptltA
 cWzb4MhL3IHbnMEiq8XjQB7Bu05d61Iz/yrsTmcJW+ZVXcy0no2OA0ZOOBs+GKcFPFYIS62GHPY
 4I8NaYi/SjtILiNXve7T/u5v02cEht13QWyP3aKgO5LX1KQ4dhEhUyM2FX1wmiPSciC0ShoFSyV
 paEJtYxpkeoihORx2FgCDuBfvy9K79Svmc7bAb2stEup1XOoVi2fXEdcZ3hwUeiPqvSZCM4fQqP
 C1XUd7vE5lYMGTJNKz4qinedgMaZ0FVlC7hwKRIA=
X-Google-Smtp-Source: AGHT+IHrrdxJKJ2PSld4E5EyR2NHFvws8kG82OfJSz1/DpV/duV64MJMIv337ZbKoEJ5/GYt5D32lQ==
X-Received: by 2002:a17:902:ce89:b0:24b:270e:56d4 with SMTP id
 d9443c01a7336-24cedc6f3fcmr43916255ad.4.1757069151536; 
 Fri, 05 Sep 2025 03:45:51 -0700 (PDT)
Received: from y740.local ([2401:4900:1f31:83f7:459f:1fbf:fde9:f614])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24b11833a47sm101988465ad.53.2025.09.05.03.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 03:45:51 -0700 (PDT)
From: Sidharth Seela <sidharthseela@gmail.com>
To: trini@konsulko.com
Cc: kory.maincent@bootlin.com, sjg@chromium.org, ilias.apalodimas@linaro.org,
 jerome.forissier@linaro.org, u-boot@lists.denx.de,
 Sidharth Seela <sidharthseela@gmail.com>
Subject: [PATCH v1] board: ti: am33xx: Fix serial_getc comparision in
 spl_start_uboot()
Date: Fri,  5 Sep 2025 16:15:34 +0530
Message-ID: <20250905104534.382508-1-sidharthseela@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 05 Sep 2025 14:44:10 +0200
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

Fixes issue of uninterruptible SPL boot to OS, in falcon mode.
Correct order of logical AND operation is (serial_tstc() && ( serial_getc() ==
'c')), which fixes (serial_tstc() && serial_getc == 'c').

Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
Cc: Tom Rini <trini@konsulko.com> 
---

diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
index 4ada8b534c1..1fb7d165d0b 100644
--- a/board/ti/am335x/board.c
+++ b/board/ti/am335x/board.c
@@ -252,7 +252,7 @@ int spl_start_uboot(void)
 {
 #ifdef CONFIG_SPL_SERIAL
 	/* break into full u-boot on 'c' */
-	if (serial_tstc() && serial_getc() == 'c')
+	if (serial_tstc() && (serial_getc() == 'c'))
 		return 1;
 #endif
 
-- 
2.47.2


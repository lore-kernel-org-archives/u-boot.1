Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163451099B37
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 20:55:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13D0F840E0;
	Fri, 20 Mar 2026 21:53:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JCRJ+X96";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F68984082; Fri, 20 Mar 2026 21:53:47 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 349038394E
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 21:53:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-467161c4a1cso797542b6e.3
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774040024; x=1774644824; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/Hbx5boyeiAb9y+RN02uKkwvOSbd4cAozs8K7BF+9Ss=;
 b=JCRJ+X96QcdLBf1i9cnqZ8SoVwM1wbROKiRMoUR0arQ0uKr3y73bksrj4gjQg2tId0
 PtDwND0yubqqcaaXEW1qz+ncIryl+BtxM6j2Qxm+4fWZCmIUXeyGP+BQd8AJ1qakp88B
 YBX+/roEQ438uuY3dqapW/w0IFwp1+LLbCpvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774040024; x=1774644824;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Hbx5boyeiAb9y+RN02uKkwvOSbd4cAozs8K7BF+9Ss=;
 b=o0QqCPNpjgx5aHOHeO2RZDvqgBZ3bWraPv2NTCVatAlIfDPsegvEIFE3k7brG895iG
 WvQ4fVg/vK+cf80Eq0TNq8VMjMPCBJT333fUPH4UmAheK7F85jXbPmR4ssf2ncHlJxbV
 aGGz5tM2RHkmFac3Eh1e15CCPwikV+yfIziTAeX8XTzm8wtyo/0KW67iCar9GYrvc+9A
 OU1oG0dzfySglWYmlZRi4iKIiO05Xz/7+Y7QE4t9dBCrKpnNZItlXczZvZqb0CqMFJi8
 hWywC2dO/+TSuTAgEUy3Gfrkv5Kd982ghXLUN8GBRL2MVs3iJ7r9RIStqUFnuSFwQR1X
 YHzA==
X-Gm-Message-State: AOJu0YwiNg5XbUeY3KU21yxj7/kljLbh/j7sCVgxIU9CISNVzrF0XSdp
 HceRTRmQ0RgtnVxDpkro5Jhyf8DEyrpWCaH1aA8J8e12smtqsW1Py5tQVUoAjP7Q5rHOj51GxI1
 xV8gtKnY=
X-Gm-Gg: ATEYQzyukJJz8/BnmovJ6vOsXVYm5xZ6QJ1bL2AhXALTQJdKWOsj6fqqzFxjJq9SP7U
 WCJh7EPNOHnmHoML/1gMXQaQfR2Ede4d1SRNBZriLn63OvNBcL9MlUy06Pg2zR9qd3xowPQnQxl
 EDKC7xxGIZLAiiOjnUU7RDh784P82UJvhk9nv6+I0M+22VutYwPUWfuJ/hADzexvctl3jt1HcdZ
 VEfOlHptnJHGh6hBY/lbbcfKFgCdSQe6kBmag3qTkGXMpi0aoszDw2ufJci8EpGN0dK08TdlQB8
 0VABJIKcljZSbm0zcctjDB9fOyIROQUz6ayM29Mj9EkGW/X0R3cUeZTa7eVKgcfhKztQKIhWVIq
 u9tma3SD8/u6fEjeC42LXAc/D3rMENK9q8L8gJREE1+vNE7H9BCCuxzcFSRLHWX4z3roE2vWBp3
 4W0nkNZ21QB3pc5B8xjnaHqzz9eNJCBB3oPE8E75ldABaIwXLWOsElh3L8NkcDFj2Wt+R+byx0i
 kDV4waX+NYlU913oseP3jDvyiV4oH8OO8Ha2d0Of/V+op6L5qQ=
X-Received: by 2002:a05:6808:2d0e:b0:45f:8be:d983 with SMTP id
 5614622812f47-467e5d4194fmr2154452b6e.12.1774040023710; 
 Fri, 20 Mar 2026 13:53:43 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-467e7a96c3asm2124066b6e.0.2026.03.20.13.53.43
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 13:53:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] loads: Add LMB as a dependency
Date: Fri, 20 Mar 2026 14:53:42 -0600
Message-ID: <20260320205342.3789018-1-trini@konsulko.com>
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

As this command calls lmb_alloc_mem directly it must depend on LMB being
enabled.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 cmd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 4077cdce1069..e96b76cc8a86 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1411,6 +1411,7 @@ config CMD_LOADM
 
 config CMD_LOADS
 	bool "loads - Load a file over serial in S-Record format"
+	depends on LMB
 	default y
 	help
 	  Load an S-Record file over serial line
-- 
2.43.0


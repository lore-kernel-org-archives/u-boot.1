Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD39C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 21:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9310683D40;
	Mon,  4 Aug 2025 23:50:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H2f96xjV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 347F183DD8; Mon,  4 Aug 2025 23:50:14 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4B5383B1B
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 23:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-87999c368e9so328957839f.0
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 14:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754344210; x=1754949010; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=lPwAKw7NAAY+WkyX2I4E4cX6PVZdwHcAxrSChM0z/g0=;
 b=H2f96xjVUTL+SHQJ8fEoIGksk7JktY5KAOSjuc+EC/g8xRsH78Q3sxr/axbW3J7uif
 51R2BZ2quy8MSFkoF2baZnFRKm8B+eT2qeLU8TWoJTggKvFKIp0iX/pfG1Pedp4+aA26
 HEg+qCIkNk/g39A9Y65PxrK/ys0an3Xy9HuY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754344210; x=1754949010;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lPwAKw7NAAY+WkyX2I4E4cX6PVZdwHcAxrSChM0z/g0=;
 b=AyA7nF+SLvQv6WqsXhlUlV3kIVxq1/hmC3z77TXxxiKCLWYwAURMxQKdtCb6YK9KHb
 phm9/LZnWnRBr7zePRZ1toM9ONWpbQyH+yLfyKyw91XYsMnIzj1qegvVhsEpmRo5fb6a
 C88H2/HmSIudbBgMOKB7Hirug0vOE/KXOCLroPwkkaZi07w9qeZGquyKjJRS378NXKK4
 Pa9SHBrQf/WlO6tRETiWBDE3CokMJcULyuTpgivu4PT8K4WpFRbH0GysBclOZS+AD+jJ
 K3MBRlUh70cpDJDveaFag7HiG2YngcTnwlUOFqYg8NNixgU7sTE0Mqw5nNzSmS+ewxHi
 lKjg==
X-Gm-Message-State: AOJu0YwmFakA90IM5FlXiyaDn5BZcHAYu+OuTJCJRR8Gqkr8G44Bpup5
 v+u3kaZ+dXyH3QWzbbJcH5lDm/xcBx1AX4M9rTmcw8h0xpY53SuimzCla3Ojz9SnUHY7Z04j9+Y
 0wrHft3Q=
X-Gm-Gg: ASbGncsks7BzC32v9bM1F37o2ByEg1U0GmdAYcW9CeRuBIT+cUxedzeiHbvyub0js72
 +7WkWXPYb1mmuB01veMB3zrjE+DzjUBjFokPLUGQcBNU2/BwnBucJzx4C/sWxsIjt5xzc5/ChYS
 xMkVTw4RbEJM8j69wt+YftQB1/Gmh/dp1EdLWb8uv327gjidZOlcr3q26skLC8M+gpLYkorglOB
 OoK/lFkoe7D281gB1X22zE+ASAkaD8WPdejvrQrJP99LYVBzNLhObuM1CTFbwVQdxc6qG76wIUw
 c4vM2DHiqc+kpNXDb5g426cHr1Gvz4lR8HtzPF/AY+TsFu3SpGsSXcpx0sD4gle334Qw7IKQbAC
 AvhRJHTDbV113pg0ZPw3j531H9gFB9a9hQw7mg8X27qE7xCqAYAtbncl4XHyqznIeQRRH
X-Google-Smtp-Source: AGHT+IFMtjQgpgsD0Vahw2QUjfhfsJUOkNRX8SRsnycbBzIfhCGcBnHInlC6k8S60slWtrSM74l/jg==
X-Received: by 2002:a05:6602:3c2:b0:879:c9db:cbf0 with SMTP id
 ca18e2360f4ac-8816831d73cmr2273742339f.2.1754344210229; 
 Mon, 04 Aug 2025 14:50:10 -0700 (PDT)
Received: from localhost.localdomain (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-88156bcdb1dsm303461039f.14.2025.08.04.14.50.09
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 14:50:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] sandbox: Add an additional dummy sync macro
Date: Mon,  4 Aug 2025 15:50:08 -0600
Message-ID: <20250804215008.1411974-1-trini@konsulko.com>
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

There are some drivers which call a "dmb" for a type of sync. Add that
as well to sandbox.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/sandbox/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sandbox/include/asm/io.h b/arch/sandbox/include/asm/io.h
index 72953828f96a..cd3f5d6fd401 100644
--- a/arch/sandbox/include/asm/io.h
+++ b/arch/sandbox/include/asm/io.h
@@ -14,6 +14,7 @@ static inline void sync(void)
 
 #define mb()	sync()
 #define dmb()	sync()
+#define wmb()	sync()
 
 enum sandboxio_size_t {
 	SB_SIZE_8,
-- 
2.43.0


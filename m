Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2A1C02188
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 00:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E51A81875;
	Tue, 28 Jan 2025 01:30:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WNHI+Kyu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 711BB8187B; Tue, 28 Jan 2025 01:30:20 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBDA381870
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 01:30:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michaelsunn101@gmail.com
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3cda56e1dffso14992365ab.1
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 16:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738024216; x=1738629016; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zamSqw6MoVug5NQ4G++iOUyja4wz6nFach+US7B+rL8=;
 b=WNHI+KyuiZojwm5z9OMu9k3EYbg2CcRWhop6AterPqlViJCX1UVgjTKhZjsegc9DkB
 Aau6jkwL4GFTqWXItb2+VyMVdO4HM+v1REdghEfh/aEkgYvB1arcqYqyih5VbWyJ2oM/
 A96zcxQk+mpQxBUf2KZMt4dA+1akkqMFW/pEUiHsYM4NnULu/VABT9L6S/QtnMiXmJfG
 5fCeLCsNp9kYpIOk3uqJ+1XB6wPDsjeBB3kz0kGYHnSlVNL9QZLp389KxL6a4ZcMR9yZ
 KVAAGaTGSPiq9yUvsGZVjir2dup6W/OvjHWIIdj4JjzTbP5gVWPUfwJ8u5w3DYWABYH8
 zj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738024216; x=1738629016;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zamSqw6MoVug5NQ4G++iOUyja4wz6nFach+US7B+rL8=;
 b=F7ZiXWs+gGM9LfjjdT0aE3ysl/Hk7QUJkD7OJGrgO/qjq1WFeIWW14EMyvsrxoWVCw
 HYlaxpwIIWYLizkNWwaERO/pnHOemXDPAR134V9aUXWQ1sLyL92lgS14weJW7PaMxV1B
 VzzIdjHX/LFDmVwiwDiY5KRlIQQNHyqEfrgbJ56e3iO2ueNYvIHHBw3vwg82XUp5kA0E
 siPraFOuSYD7A/ny/D4RAqJmLYUWYO+nIspTjkKpEXasw4q/yMStUmFIYtr3Yy/zeQRU
 IUc165LibGXOpK3rTyxRJuuihbWldoKJmVmnLH3czRvEjFjB6HV9voaNG2wYAmVgPa1b
 uEuA==
X-Gm-Message-State: AOJu0Yx3WrAkxX9fQNCBwgesPVy+CvSj36yYheSbKH6kGM+7cj6NzCPm
 s7sLP+QTMTqPbWaBS4OzKALPlUJtBi0TLclVdBoJTMyait9KmGE3rWoAuB0=
X-Gm-Gg: ASbGncsBuHpuAykpFmWbu68sRJ/cGNmOHwRUWlTQZMNcvrXQVgm+rhb7ba8DsONw/tT
 ev8By9VQhH5v8opd+aT2UsFQDGj2FZaCpd2jEvq/Z5DzYN28ZAEDFfV9gEVcWoflTpZsqsIOL6C
 Ye2d+v3QZtj0EbyHWHFnzCvCAO3+hD9L30bwCMgj7DIIaNUSu85ih5KDqFMEdkdPoBbUdF0sobn
 la+tmvmRaQhzufSusUwl0HMAMpgycUa0GIWAlSbqqwNB3K1MK5dObOo4h00hrO72RTDnvjWsWwE
 3hwDARa4RPNNJv9k96e5EhLIZVt+a2Sv
X-Google-Smtp-Source: AGHT+IGVBfPRXVeQipxqq62CTYh/BwjEZIxRtmt+RZc4G59kzOqP7fJZDmAblnr/79p3jvRDq+CI5w==
X-Received: by 2002:a92:cd89:0:b0:3cf:c743:3750 with SMTP id
 e9e14a558f8ab-3cfc7433868mr149542645ab.2.1738024215993; 
 Mon, 27 Jan 2025 16:30:15 -0800 (PST)
Received: from valinor-2.taildfe5c2.ts.net
 ([2604:2b40:2185:31:7b1b:4ebd:7d46:b4bd])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3cfc740f5bfsm28820565ab.8.2025.01.27.16.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 16:30:15 -0800 (PST)
From: Michael Ferolito <michaelsunn101@gmail.com>
To: u-boot@lists.denx.de
Cc: Michael Ferolito <michaelsunn101@gmail.com>, Marek Vasut <marex@denx.de>,
 Heiko Schocher <hs@denx.de>, Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH v2] USB: Fix NULLPTR dereference when serial# is unset
Date: Mon, 27 Jan 2025 18:30:10 -0600
Message-ID: <20250128003010.971175-1-michaelsunn101@gmail.com>
X-Mailer: git-send-email 2.48.1
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

The current behaviour of this function will dereference a null pointer
if the serial# environment variable is unset. This was discovered on a
board where U-Boot did not have access to the first 256MB of ram,
resulting in a board crash.
In the event that U-Boot has full access to memory, it will still read
from address 0, which is probably not optimal.
This simple check is enough to fix it

Signed-off-by: Michael Ferolito <michaelsunn101@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Heiko Schocher <hs@denx.de>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/usb/gadget/g_dnl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/g_dnl.c b/drivers/usb/gadget/g_dnl.c
index 631969b340..f2540eb6de 100644
--- a/drivers/usb/gadget/g_dnl.c
+++ b/drivers/usb/gadget/g_dnl.c
@@ -207,7 +207,8 @@ void g_dnl_clear_detach(void)
 static int on_serialno(const char *name, const char *value, enum env_op op,
 		int flags)
 {
-	g_dnl_set_serialnumber((char *)value);
+	if (value)
+		g_dnl_set_serialnumber((char *)value);
 	return 0;
 }
 U_BOOT_ENV_CALLBACK(serialno, on_serialno);
-- 
2.48.1


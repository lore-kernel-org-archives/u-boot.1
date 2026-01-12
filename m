Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AFCCF45AE
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 17:05:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3238F83759;
	Mon, 12 Jan 2026 18:05:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UuwPjNEl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB0508382A; Mon, 12 Jan 2026 18:05:20 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9D0483693
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 18:05:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-45391956bfcso4903433b6e.3
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 09:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768237513; x=1768842313; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VqnLse+JUAkdNRfgYVNPFltZFXpAwp3soN6j14idYHU=;
 b=UuwPjNElkDOgnywYlJ1KDbesUinSfj+PK19MDWwuIac0J/bDXbTAp1tT7GWzs40Dnc
 tfSWUID4NmrTTeqgbKFxZa8vCn0trlU8PnHp9zIlsrMsVZmZgUUEfOik2gOQTQp6r/uj
 yuUVnp5TgfK9yhDItDkQzANa/l6lbPagd+n4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768237513; x=1768842313;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VqnLse+JUAkdNRfgYVNPFltZFXpAwp3soN6j14idYHU=;
 b=RgQx3yqgUiKnSVvLLBl9VQqJaYUWNVUyEKaAXIn6s1Lj//egZmvK3Vygp4Tt+hLVU2
 wp0ip77wLwVH1nKD3mCSEbRLNOWrLME4iH9wxSseMT6izaMWd7BmtRymalG7a3K4wh+R
 0RlDNfP3nHrgSrYGnNGQoOK3Ae+xjLT1acHs2jn45RZsNgb1eWt5NXl2shNLJfZHpZMW
 t0cLGzuMkBZkMkvJoPghVKMBeFFogcS/88ztYECYNLSeTrA1x7dXtfvSxyMJzFRzmiGs
 zp3ZpC5QS6VrpexRjW+deXu+JZd/omTNwQ8Z5+H22KEq3QJLY88ZyII9Be7LrSNj8a/L
 974Q==
X-Gm-Message-State: AOJu0YxONcl4tryQp1diN+Q8Veds9vy/KECqEKj+70tL7rzGjTe5J7Wr
 +Mypdd/lX+Ih9JaOQrZzXd5P8PIpXFhKkrHvOmgTVnKfafLs9B7Bc9JKRrLV7zAiQB/KVB6tBv3
 1Ej3V00M=
X-Gm-Gg: AY/fxX7Ivo5Lvyj+uHyrsgYKryEroxHoXoWe7v7HObT751Gj5pUZAbdjDC3PhqFpTYa
 ClAsZWzWdXThpTKRSdLiGV6SpzsgOVd0wGEwrnKquainynJdZPYgTRnZIhdHLP9QVvKC8Y4b2iX
 0uVH1qbLs/9184lOGRxqxSN5TSOKtEZ6nY//m0ZT2YxYOdKgqo0jGA06RUnOQ1RBpTlYU0oIweU
 Pe+KVELSNYVlyeupy6hxll8jwGmjXxR9oNDQQFWHMlgE+Yc2OOEjRsVw+KD4NlDoQJCtBkj+SQP
 C/uunDPYcxvXiYpjdZ7SyBIdjC4fXA303qks/4TuejHITKcIRvGiz7YZvFk3UxigQY2WRZMFNBC
 Pr1Qw12JS+8On8suMhTo3GdlzO3u1RyqDo9CjF8SIcWyUI9eBcInvkzx20XsE0K54AcRek+2XmP
 RooM+gYB/vgdW7e79OpyJZ3CT1yfsXwx9LNVU0TqP0wi5uUrZwMOVP/82S1WWEjES7PA/+4TxHy
 RrlCAQGvlpST28Uc9bAXqhGetrKTCj0l1lC6a7StQ==
X-Google-Smtp-Source: AGHT+IHAXnFlH3QGF/sdK9yZt+kHl6NGKs2oTTEpIBFRTDIEZjNoRvUm+wj007z++j8OCjgDBoOkMQ==
X-Received: by 2002:a05:6808:6786:b0:450:c776:876f with SMTP id
 5614622812f47-45a6becc112mr7857061b6e.54.1768237513398; 
 Mon, 12 Jan 2026 09:05:13 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce478ee883sm13994685a34.28.2026.01.12.09.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 09:05:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Martin Husemann <martin@netbsd.org>
Subject: [PATCH] bootm: Remove BOOTM_NETBSD from defaults
Date: Mon, 12 Jan 2026 11:05:11 -0600
Message-ID: <20260112170511.1856525-1-trini@konsulko.com>
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

After talking with someone from the NetBSD project, platforms that do
not boot with a device tree (and so would be using our BOOTM_NETBSD
support) a very few in number. So we can remove this option from being
enabled by default and save a little space in most places with platforms
that need it still being able to re-enable it, if needed. Ideally, in a
few years we can instead just remove the code entirely.

Link: https://lore.kernel.org/r/aWKQOW_ajq0DsbYA@big-apple.aprisoft.de/
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 cmd/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index b71ac554c0bf..e227ad2c532f 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -399,11 +399,11 @@ config BOOTM_LINUX
 	  or booti or bootz.
 
 config BOOTM_NETBSD
-	bool "Support booting NetBSD (non-EFI) loader images"
+	bool "Support booting NetBSD (legacy, non-EFI) loader images"
 	depends on CMD_BOOTM
-	default y
 	help
-	  Support booting NetBSD via the bootm command.
+	  Support booting NetBSD via the bootm command. This is for NetBSD
+	  images that are neither EFI nor using a device tree.
 
 config BOOTM_OPENRTOS
 	bool "Support booting OPENRTOS / FreeRTOS images"
-- 
2.43.0


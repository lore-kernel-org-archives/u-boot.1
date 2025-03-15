Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DEBC282EC
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 01:28:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68A5E820DE;
	Sat, 15 Mar 2025 02:28:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RzPp8aFF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35056820F8; Sat, 15 Mar 2025 02:28:46 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3AB88210A
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 02:28:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6dd1962a75bso20105126d6.3
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 18:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742002121; x=1742606921; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z+XbxxleVm7Pt2yppXj8/qh+eML92lN3mVN5oCqY81M=;
 b=RzPp8aFFtjcvw53grEzxsDahxEYQ2oGC1XX1Bd87+3iOzscbvgfObnA+9d1X5+VbUC
 dyaUouoIIyYLEAJaZ/TK6F2jEA4bkkZTunqHfr5j8IuQK4tJJvwLTqjmF/H3BmH9b2BZ
 bVK48eKppK+c4NhtrJz/ToqwOhFAR1+vaLpxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742002121; x=1742606921;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z+XbxxleVm7Pt2yppXj8/qh+eML92lN3mVN5oCqY81M=;
 b=nBk0aGy056+ombaRtkhW+zeD1ZOgmytHHTJjMPhfDdungC05JqIINmVSxjTH0wBNEh
 QHNEARAJGT1Jv3U0QpEw2Oi4LBp7db7phT7w3UanGy9H1pQ4dsAwM1YbegauRrZudOwG
 ACzVZj2OyR3tzrM1VsqeNiM0ddkV/ahFPyPHhPoi1LT8Yqkyhr+jSZqf2feaAoXnnHh9
 GP8qrhSEOwKdanqDUXwhDUuGBUZmHMYipMyjnV5kWMl/obMDVIzlfRwTBhrq9d7U0s3r
 LFvQCt8yhDS4GF8P2XC9XEnVur/QgJS2nPkiXY0XFTsUaLEKpT+R76H4rDdbOXmHeHLy
 CdcQ==
X-Gm-Message-State: AOJu0YxHFS5SoQFt47t+4A5QqtdCoWrTK88h8QzC8iZoaj8fV/09Wh7p
 0y8a/5BHj/GPnTZ4w7Clh1tFx0HHIkplfpO2sqqZbQzqSU9fOUS0FLNf9te4ZHmuN14qedFk5PH
 q
X-Gm-Gg: ASbGnctu0qCTI75MDJRyfa66zxe7T+N2MAOHUr6HC2VEtsBg0/NtFFdYwVdKQeT5N3V
 tf6ug+L9aS7WwfEq2UmiOBnrU5+UTnQPHcmbepbG9a2sSD2ZqUEAR3t35p0/Q4WXDQiZvh2ASUk
 9if9RIhQgFaYx4/lp0H4QGFHJhftiSFPnIUf3QlmdHNK5ZPtZYi2rNWgE+k4M3cLa7/59/cdrp4
 rGfOSBewAzmwxF6xpAa9k/11GluGNZsDYE0sbHoZgxr9Cq0N6yD2JxieB7OlcIDT36cnReePgg0
 Bhibx7aDVoj7W6VeH48jVwgCrc5KTRgaka5SGAJD/AFcx1k7ll90+5otpLY=
X-Google-Smtp-Source: AGHT+IEqWvO4Pwp43JFzAdSi4z0Pq99PahLi8XzMbe1n/3ChdGibIPgJfM9Bl1ib5pHJOxnJAWq16A==
X-Received: by 2002:a05:6214:d49:b0:6e8:8b11:b6cd with SMTP id
 6a1803df08f44-6eaeaae39d9mr60295686d6.35.1742002121488; 
 Fri, 14 Mar 2025 18:28:41 -0700 (PDT)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade24de1asm30330276d6.56.2025.03.14.18.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 18:28:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Tianrui Wei <tianrui-wei@outlook.com>
Subject: [PATCH] openpiton: riscv64: Drop unnecessary 'imply SPL_RISCV_MMODE'
Date: Fri, 14 Mar 2025 19:28:38 -0600
Message-ID: <20250315012838.399290-1-trini@konsulko.com>
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

As the code is today, we get a warning about "select" statements on
"choice" options not doing anything. In this case, the option
SPL_RISCV_MMODE is the default.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tianrui Wei <tianrui-wei@outlook.com>
---
 board/openpiton/riscv64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/openpiton/riscv64/Kconfig b/board/openpiton/riscv64/Kconfig
index 21da1dc346dd..e4bd8903aab9 100644
--- a/board/openpiton/riscv64/Kconfig
+++ b/board/openpiton/riscv64/Kconfig
@@ -35,6 +35,5 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply SPL_SMP
 	imply SPL_MMC
 	imply SMP
-	imply SPL_RISCV_MMODE
 
 endif
-- 
2.43.0


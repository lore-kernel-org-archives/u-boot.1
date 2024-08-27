Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEE9C54734
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 14:22:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BF8A88A53;
	Tue, 27 Aug 2024 16:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="wQXgPVUH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F321C88A3E; Tue, 27 Aug 2024 16:22:04 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBB7C88A31
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 16:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a868b8bb0feso609689466b.0
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 07:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1724768521; x=1725373321;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0DsZp0FqywBD05El5OUOdQ41OJoLnoijk2gzwk4JJbQ=;
 b=wQXgPVUHgGI//cN0AXSHGaisZaRobS6ZJyRi1k2bKvjpVOOiVYfAQklr4RcwJ3Waza
 dLFRk2QhgOIwhigFhE+tWyaiksXdQaWhRHpQarst8TTkkQv6/jhW+GadF8yDZ9V7hyYn
 EQ5MfrdPSXx//Rt5mykNcrWTssFLyhwsPVzInMCTl7VvIvpT/ugLam+AyqVlKXD7MHkJ
 HuQWg1B7ulAbqc86JDiMAOQmPsjb+StRvFy2h4Zwq4kWP/J+uACZLKQ+yx0kg0Gn6xsM
 mYashLC5bAHLTG35c4VXJj9VGHQz1BnNyXxiE56YhJCGQFAKpk9rPnm1sBU5jbuYDo5x
 41zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724768521; x=1725373321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0DsZp0FqywBD05El5OUOdQ41OJoLnoijk2gzwk4JJbQ=;
 b=ONshtqJoZR+RTw1H/ycQUB469yHd3tc+XiM+hdHk32bZjqc+FAXG9p7X+8qklNpW+w
 drXh9hiwrD5Ilqp0HNEzMx5P+fqSw1frNRJOG8v4pn0i7o34w+usnUAj3gBnhxrRsjCn
 r8UbiTPZNc4mu17LpZ4GEXvsDLyTTmgMyIEvzoXgMCIcIkR7W3hvF48CLmFo5zWM1CHt
 jEfLn5ziBrINdzvmL9DnpvbcZFDlJOSZh35yNA8nbM5Zh/45m7bNWGYhopqzA5Ue9Dlo
 H9l8oeOMUuq+VWZ5ITRFgq74XpZ7U7nS2AIO8A61N1L5qmPB+0MmmfDzDVzDT0SKxUbH
 zTug==
X-Gm-Message-State: AOJu0Yz5oEIrLzXv2FrZM/H3SfJCjd469S2csvEN44B153SEl+5WeHdA
 TLBvMCODm8YFW7iNsQXSxFB9qsZPTqV8guQeVqNAH0JrckxK+jXQkwG4nd2oL89JjiTNCLclei6
 T
X-Google-Smtp-Source: AGHT+IHLRzNd70xzFkZtSwFzCkw0bydESqfBgY8hn14jLj8ryE2nN0KrxotiXXKKfiI5jQ855fwguA==
X-Received: by 2002:a17:907:2cc6:b0:a86:b727:3f27 with SMTP id
 a640c23a62f3a-a86e3c1d00emr213601666b.52.1724768521332; 
 Tue, 27 Aug 2024 07:22:01 -0700 (PDT)
Received: from localhost.localdomain ([91.90.172.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e594e809sm114854366b.219.2024.08.27.07.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 07:22:01 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, quentin.schulz@cherry.de,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH 3/4] rockchip: Kconfig: PX30: Weaken dependency TPL/SPL serial
Date: Tue, 27 Aug 2024 16:20:57 +0200
Message-ID: <20240827142058.594556-4-lukasz.czechowski@thaumatec.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827142058.594556-1-lukasz.czechowski@thaumatec.com>
References: <20240827142058.594556-1-lukasz.czechowski@thaumatec.com>
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

Allow to disable serial console in TPL and SPL. Weak dependency
to SPL_SERIAL and TPL_SERIAL is also used in other Rockchip boards.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 arch/arm/mach-rockchip/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index fc1b638ff01..47a6275d45f 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -11,8 +11,8 @@ config ROCKCHIP_PX30
 	select TPL_TINY_FRAMEWORK if TPL
 	select TPL_NEEDS_SEPARATE_STACK if TPL
 	imply SPL_SEPARATE_BSS
-	select SPL_SERIAL
-	select TPL_SERIAL
+	imply SPL_SERIAL
+	imply TPL_SERIAL
 	select DEBUG_UART_BOARD_INIT
 	imply ROCKCHIP_COMMON_BOARD
 	imply SPL_ROCKCHIP_COMMON_BOARD
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE78CCD1A3
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 13:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61FA088C10;
	Wed, 18 Sep 2024 15:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="A57vUSTV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1440188C6F; Wed, 18 Sep 2024 15:03:43 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E8A388BEF
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 15:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8a7903cb7dso433191966b.3
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 06:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1726664620; x=1727269420;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hQJL+4s3ShF0e6LkxYyPSXum1bmqe8k1LZ9ow4crmr0=;
 b=A57vUSTVevwdoI6kjM6/ORWxJg+Qbo94kUKGdBwtI2BRInT2i1ZVI6CN41BwDNBXkr
 5srf6NUIHjf6Qdvi0IiiHeh5NLIp64ldp5yC2LusEYJ7D/iADvr+8HZa3QBr3hzlebX9
 vN5qbNAOxpv/woVlJmXQxm8DywK26MYUc4p/DpTMGsSfJXHIGwwExvpXEaW2+8i81+Sw
 0GqC0gZ+MU4pocE0/zZ9OYgPw6oQhWAoZPwibtHlyBdYVaZgmX8xwqU2rbqnyaiit7Q4
 AHR1WyiyObyaVMG32aoiv+Up9IYcppGOahzUXsd69QIkWq2Eg2/uFhxqNLNT7E5AMu3v
 ZqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726664620; x=1727269420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hQJL+4s3ShF0e6LkxYyPSXum1bmqe8k1LZ9ow4crmr0=;
 b=I/kZt2ttcA8TLzt81k4WQGr7UaaWlxHacmBafAuktaWW+/OCu4/1oRI8t60aEO4qbX
 eTc5Qur6q0P4Y76fRtjMukd4b6nRMuej4t4EYAfJrZ8ESbuabnsJZr3kgWci8s2GsXQt
 DJDsULiT1/C8qM0j4ryzk7GEx/l5f2LMXCbxIs5DgOgR3yF7xlAexhFaMTO0XE/KnFy3
 1HzzWtlUZ/oNWZMuxewDN85CsgxUXbTy1OCcQYcI5Kf7y6hpfUa5ZJjORMuVnZj5RdQ9
 KJa0ycL3S9KyCa3xLLiRcddC31TrsGCekcmXITQl1E/aOxnUpBlp1FihjUJOJIFJNgg/
 ni0g==
X-Gm-Message-State: AOJu0Yy0Bah7O2qjhchgBhdfuYkh7N4ZNIyqSgB520zaKszfrHVorJGJ
 0EfzwuP4T3ruv8fG1h4OSPnrpqkO2uwBvlNL+OLF+Ki1UuU9T6f/iOv5ih8PtZJrsCYyMvy0Ciy
 2
X-Google-Smtp-Source: AGHT+IGCJfwIlrooTOlzjHxsaUlvq9Qvm59/3jYz4DgrcqZmLvxHuu+V0NCEmk0vZTb0J/J7rkNd9g==
X-Received: by 2002:a05:6402:51d4:b0:5c3:c296:1bc9 with SMTP id
 4fb4d7f45d1cf-5c41e2aede9mr22509187a12.29.1726664620343; 
 Wed, 18 Sep 2024 06:03:40 -0700 (PDT)
Received: from localhost.localdomain (83-238-227-197.dynamic.inetia.pl.
 [83.238.227.197]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bb495a8sm4885576a12.11.2024.09.18.06.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 06:03:40 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, quentin.schulz@cherry.de,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH v3 3/4] rockchip: px30: Weaken dependency TPL/SPL serial
Date: Wed, 18 Sep 2024 15:01:54 +0200
Message-ID: <20240918130155.299353-4-lukasz.czechowski@thaumatec.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240918130155.299353-1-lukasz.czechowski@thaumatec.com>
References: <20240918130155.299353-1-lukasz.czechowski@thaumatec.com>
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

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
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


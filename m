Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DC0C83038
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE8F382CFA;
	Wed,  2 Jul 2025 03:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oY32ZiII";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D44CD82103; Wed,  2 Jul 2025 03:03:52 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BE7E82103
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2ea65f5a0easo3583779fac.1
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418229; x=1752023029; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vLLkDxTsLF4zAak5n6Yv2mK+8XaV7ZCK8sbNzmbc7Fs=;
 b=oY32ZiIIZ0TgDy+mnirHVNJsvovUmxLpseWzzgS76pA8C+oDbZLvfhw0R40m8OQiP4
 r0om7SJ+FmKapdTj7+tjTf5IPxQFgPZRoPR7O6cQHP0MW/9TFXYXOW2YMKWJa59oul5a
 sflXwfBExezIzQSo/BuSsY1bHJuhnFjaPftgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418229; x=1752023029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vLLkDxTsLF4zAak5n6Yv2mK+8XaV7ZCK8sbNzmbc7Fs=;
 b=Sibi1BACYEY8wAav8jXWpZtLGHgM3dJF4dMkRjUjAcOUnCq8nW3kffRKYC409g8zvu
 sXDywZ4PqMUd1PYkPijbJquI081oZXV2t2KxlZSd1hwZXf6oCX/PsG5bLJnU0AU1bkxE
 WkmRP3gzkwm6TR1ltxM6vuHKL2I1idcaMWd0u4kn149rlmqyj7Apkgm5Ovf76dd61wwW
 ZhZas9iiZEaW2EXiDSINQze7R3asoMpogfTcoHefEuWeQVoJBptmvsS71gVK65yofLI3
 tPfwxaPlLaK+tk3t3jIaWkuhnW5wTQqQ6w9oKqFTvS+2MCy5IwbhXVpeMwR+RbEktiXc
 fi6A==
X-Gm-Message-State: AOJu0Yww0wARmZQB5BXIrokOKT0qHUOlgb8i9p8BW+Bbvgxhh/OfPvFK
 GSlBppFrsgjp7O+p915fVlC1l1KtiVzeD4wc3U5ZmCkd37e9Jyemb/6VjZ2zlkqTbZyWHnLKteo
 ERkI10rs=
X-Gm-Gg: ASbGnct1DH2XUXowXqI/NZOSnVSMJf4nwuUlz9ALrhCqKMFMrukmWZfsagfwp2mvLdw
 lfuUZ1dNKrwR2rl4lLf3dh3TmCpmR9geJfd7Vgm2csUU5lwUdJDwXBid7G5D1xv8/CxTy8Eh80u
 C77M04Qa9ojJ6UJ8j+0kwlrsrwOrEd4fby6l2UOckFoDFIIispiLtVr3vQsEpCqcRFfzBymbRnD
 Tz6yt5cTxPnvqSvgtRXTPV6LWXcjGROQonFvIheoRO+aOG+jX9brV74kl76RhvYQoDW2pY0KlpJ
 xq0k303hGiQF6Ya73et95KQygphNIO1ND6LV0VCXjxTnmYyqGdaBUWYFlgkO6/NE2tR3iOQcK0J
 2YCII2jDb5dKQhNh+PrY34Nw=
X-Google-Smtp-Source: AGHT+IGcp0ARR/9Sxx67Ibvgl1h3NKBL6IL+i0T5Lv1mFCDsn97u9gQPNn+wobK6oQnagTvTsO015A==
X-Received: by 2002:a05:6870:ac95:b0:2c2:4d73:ec43 with SMTP id
 586e51a60fabf-2f66491a310mr556162fac.15.1751418229327; 
 Tue, 01 Jul 2025 18:03:49 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ef29absm3578201fac.14.2025.07.01.18.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:03:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Kever Yang <kever.yang@rock-chips.com>,
	Marek Vasut <marex@denx.de>
Subject: [PATCH 2/2] usb: gadget: rockchip: Fix spacing around the Kconfig
 option
Date: Tue,  1 Jul 2025 19:03:46 -0600
Message-ID: <20250702010346.18716-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702010346.18716-1-trini@konsulko.com>
References: <20250702010346.18716-1-trini@konsulko.com>
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

This Kconfig option used spaces and not tabs for indentation. Switch to
tabs.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Marek Vasut <marex@denx.de>
---
 drivers/usb/gadget/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index b0decd7b2512..6201663317be 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -201,13 +201,13 @@ config USB_FUNCTION_MASS_STORAGE
 	  the eMMC/SD card content to HOST PC so it can be mounted.
 
 config USB_FUNCTION_ROCKUSB
-        bool "Enable USB rockusb gadget"
+	bool "Enable USB rockusb gadget"
 	depends on ARCH_ROCKCHIP
-        help
-          Rockusb protocol is widely used by Rockchip SoC based devices. It can
-          read/write info, image to/from devices. This enables the USB part of
-          the rockusb gadget.for more detail about Rockusb protocol, please see
-          doc/README.rockusb
+	help
+	  Rockusb protocol is widely used by Rockchip SoC based devices. It can
+	  read/write info, image to/from devices. This enables the USB part of
+	  the rockusb gadget.for more detail about Rockusb protocol, please see
+	  doc/README.rockusb
 
 config USB_FUNCTION_SDP
 	bool "Enable USB SDP (Serial Download Protocol)"
-- 
2.43.0


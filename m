Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D11BD68BCE
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 16:54:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17E2689165;
	Fri, 15 Nov 2024 17:54:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SQ6SqY15";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C17EB8910E; Fri, 15 Nov 2024 17:54:09 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E33E890DA
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 17:54:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-46353bd879aso6387251cf.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 08:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731689646; x=1732294446; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YgrEsU+eT5SQvOdR017bPZNdFhrv5gN7YW+JoJklqts=;
 b=SQ6SqY157V6U6GJ8TZE+63qMS3FyxSjSalKlGLwOmHCYKb/odfhBHVZDZlXu5DRhBW
 fxmSgYdJU/NmYwgPc5/n65XWLvQaH+mx6ki3tGmG/JlozK4gRRwqyr0PkylTg1GTKBBE
 wVifMWHka1JnwBY4vzYfGWHQjVbPsCznunw98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731689646; x=1732294446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YgrEsU+eT5SQvOdR017bPZNdFhrv5gN7YW+JoJklqts=;
 b=i6vTnt1PJJAds13FMOnL5uojD3knWp8F+zJqpvTFo3q/yvh+lx34H4Jtg+k8g38G7E
 l54iF38HtK6o/9yvjorxHwdJiWvD6bb8G2AONsoIZsr226VJkjxmSDn1eswLCG65WWQJ
 L1xeczWO7LqBXf4FnXVuArXKrWNtqHtZ/c6RfOXTMm8atAMtcbXy+aeAMvt82dNuG+/4
 BNKpb1ceNQ7qtD6n2PrM6gcIdnvqRwc6F77sL0f/XNSJwOhADeLyGDWidA0ZST+m/uGq
 u8lRZd/imYTFu2NHQP+TP7glu8DEHw0/fk0Z/9O0uvvvbKoOeAid5C2yg/VDhQ/yvxZj
 losg==
X-Gm-Message-State: AOJu0Yz8L/aBpF2hn0CSBv2Kwx/mMI0YhgNbUHl/wGM3snWaohW3XLon
 XF8CZE2gtkkcA3snu3C5w7Vr5NyrsckxOPiSXmNB82HdKoh8IMfqs4/SL1J8nLoG9U4jb8fySCP
 xy20=
X-Google-Smtp-Source: AGHT+IH7sbFuYgG3SCzOCpYQv8EpoZJFk/n0sspmSaetmHYsWNXIAjt8ikAsOo85wyGaaxJ2MlZCig==
X-Received: by 2002:a05:622a:22a4:b0:461:c52:d36 with SMTP id
 d75a77b69052e-46363de7e46mr50681321cf.7.1731689646199; 
 Fri, 15 Nov 2024 08:54:06 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635a9f20c7sm20784831cf.23.2024.11.15.08.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 08:54:05 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/3] arm: sunxi: Use "imply" for USB without further guards
Date: Fri, 15 Nov 2024 10:53:59 -0600
Message-ID: <20241115165400.2486914-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115165400.2486914-1-trini@konsulko.com>
References: <20241115165400.2486914-1-trini@konsulko.com>
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

Given that ARCH_SUNXI already implies that USB_GADGET should be enable,
we should also imply USB being enabled.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Is this a tiny bit of a cheat to avoid patch 1/8 of Simon's bootstd
series? Yes, a little. But it's also correct I believe.

Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7282c4123b08..3ebda07b00c1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1177,7 +1177,6 @@ config ARCH_SUNXI
 	select SUNXI_GPIO
 	select SYS_NS16550
 	select SYS_THUMB_BUILD if !ARM64
-	select USB if DISTRO_DEFAULTS
 	select USB_KEYBOARD if DISTRO_DEFAULTS && USB_HOST
 	select USB_STORAGE if DISTRO_DEFAULTS && USB_HOST
 	select SPL_USE_TINY_PRINTF if SPL
@@ -1203,6 +1202,7 @@ config ARCH_SUNXI
 	imply SYSRESET
 	imply SYSRESET_WATCHDOG
 	imply SYSRESET_WATCHDOG_AUTO
+	imply USB
 	imply USB_GADGET
 	imply WDT
 
-- 
2.43.0


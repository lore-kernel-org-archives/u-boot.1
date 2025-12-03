Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF68BD1BDE0
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 21:03:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A3DF83EDE;
	Wed,  3 Dec 2025 22:03:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UR4qB/Cv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFFA383F24; Wed,  3 Dec 2025 22:03:46 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85E8783E7F
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 22:03:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4ee28771052so273271cf.1
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 13:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764795823; x=1765400623; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sjJuB7M5RYVSFcxEezXSMwus17GumfiIlActMQ/ZiM0=;
 b=UR4qB/Cvld/hzC0upEKWu2VIR1sWlkcfKOlI8PLz7Dmk9QX1mo92SquvYyz86y+cun
 19+PSBe0Mc3EkdIOuq40A6LJXEUoARaOZFQFkn9HbFCsewloujgXlEUvn3vf26ynPIMb
 VfCrbz1uIkJeJZv4kHknP91Pw2OaDFhNWnIi/m1EwyWTYDcha2rSunCQT83megLh+4cb
 9/2YozbU1zLCpDyyDFtlGZk94VkfgdsV7gLHtpwC71Sn3aYUgNiTz+ZLaAwY9DDziCBR
 mCeOa5P2Q8wAgKvcofL3i9KOoocPJMUgdzeyNJsWc01CCQCP3L43nwh2A56II6fTy5K8
 TUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764795823; x=1765400623;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sjJuB7M5RYVSFcxEezXSMwus17GumfiIlActMQ/ZiM0=;
 b=eyxeqmbigONv4DnUCIyS6uNfpxziWCk2M/AvHEkfSrvxHdoahaMX2elBA5ezO2wVBF
 8MHX6uXBdYJ3/1IFINA0mhhFji/P+2zVcUtZTeRnF16tRZh9ylT15zqqsv1HV7lMyMEB
 kWQYAc1IdjLFNUVXBxC4jSFx9ckRfKg5C2NOQj0FBV0Ax8ldn0KsajtRohCNBNhlBI2C
 RhyjCYPKwn5jZ8CMLwAkfeIKiHefFKj8iqNd5oQYDjse7oqJF1dDD3iVl4MYXtLFrz5v
 yAYj4LFqk+SsnLOxZ1tUE/jhfiRwDz3EvmlVg5+9yrD8kyf5mJy1xVVtFgAcmQ80w3Jf
 qPFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5NMKGKqseTVSA15bfb9JvUU3BNO0QoqFPVGOLXjMQnUB9x/H/r1RVYikDbHlbJR7AnoCf6XM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9c2N/ynY2Oe59XV2/MVlfkALiPpi+YMjcf1bVHYWrPbyiL4OA
 DI1GZpPIF/uELKJ2TP7sFG9mv41WvGFnLfw4stZcdVy8UHSaTREOMjSv
X-Gm-Gg: ASbGncsVYBrmbaQTdQpiKxIC0dwUwCOSNEDn0RqNdL6yck7LkZW+IbcTqA9ih6O/WNY
 e1aHY9KoRp/ClcTe/ZeD6wuwdNj8kb68QkBfE9D2oew0m/CzOlzKXNL8M2XkmgHN4Z4a9g5KvGE
 BlWyJFCetIkXZ7Yp+n3E/oY/1ry5LiuT3eJ0ZwxBzAXM6ANVd7gnZG8PO08Vnpcq27JWsNYQBw7
 ZjtgvQdgZ/KcB6m8HOooDXkHCccXvo2l5tpEpaR/ZH/9aEXzF6KIDH1DS0rYD/mK9gTC1k8NUpG
 xLnf034XIE0oNZmIEjn2JILnTtXnBvLqjoeuLLMSPwWgNSgRTs9CRza7si0FVlsOM600VGl3pSr
 FjT+V3G9hYhakIomnVaJstJjY+WFTEZNX1mgthPd8ARLn4or2LOS7q3MVIno9OI9o51CPpkEF/8
 XsF0iSBsnedo6nMPkbuA9wsYNMNhpGji703gSdVCqAiBAiYTSfu1ysFg==
X-Google-Smtp-Source: AGHT+IEiYCiNe2RHcWthyLIX4M0KrtU8OpzXQFGSTPeKwxirG0wjOYBSsh2dfX0wB4L2H+TpaUbHGA==
X-Received: by 2002:a05:6214:c26:b0:880:52f6:775e with SMTP id
 6a1803df08f44-888195b8c68mr42401836d6.6.1764795823205; 
 Wed, 03 Dec 2025 13:03:43 -0800 (PST)
Received: from localhost (pool-108-45-131-215.washdc.fios.verizon.net.
 [108.45.131.215]) by smtp.gmail.com with UTF8SMTPSA id
 6a1803df08f44-886524aeb17sm135744186d6.1.2025.12.03.13.03.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 13:03:42 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>
Subject: [PATCH] clk: Remove myself as a maintainer
Date: Wed,  3 Dec 2025 16:03:35 -0500
Message-Id: <20251203210335.1946142-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
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

Unfortunately I don't really have time to review clock patches. When I
initially started maintaining this subsystem I had more free time than I do
now. But I also found it hard to motivate myself to review patches.  Many
clock patches add support for new SoCs and they are time consuming to
review properly. You effectively have to spend a few hours reading the
reference manual (if it's public!) and reviewing drivers is no small feat
either. This is made more difficult since clocking is often very different
between SoCs and it can be difficult to determine whether something is a
bug in the driver or a workaround for some hardware behavior. I mostly
don't care about any given SoC unless I'm hacking on it so I ended up with
a ton (more than 7000) of unreviewed patches piling up in my inbox. I'd
love to be more active, but I have a day job and I usually want to work on
something more interesting when I get home. I still think the clock
subsystem is a major mess but I don't care enough to fix it :l

The subsystem itself should probably get orphaned since AFAICT all patches
go through the mach/arch maintainer or to Tom.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b43dae882b3..cddeca734ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1039,7 +1039,6 @@ F:	drivers/mtd/jedec_flash.c
 
 CLOCK
 M:	Lukasz Majewski <lukma@denx.de>
-M:	Sean Anderson <seanga2@gmail.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-clk.git
 F:	drivers/clk/
-- 
2.37.1

base-commit: 69c8ea98a713f88f4a6ffad9df2a72b1a767f629
branch: clk_maintainer

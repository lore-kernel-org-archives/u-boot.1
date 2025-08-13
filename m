Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A292CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 20:55:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB435836CE;
	Wed, 13 Aug 2025 22:55:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R03hbk8k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6861E8365E; Wed, 13 Aug 2025 22:55:18 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48280836B4
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 22:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-435de6c8fe8so161524b6e.1
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 13:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755118515; x=1755723315; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kMKsLqnS7pxl/akSwVG2HwBx4IPDgxvOqGHgZF0/Pl0=;
 b=R03hbk8kgAHSFyJr0vQIPeWwkKJBrKs2TY4tJMCPzm+pPSURsHXmo54qo+dy7kUOid
 ayaxBKJlFtGHFY7ewjPDEGhHEj0Y2Ul8gt8Bfz2HWbB048cw++CqDP6PyyXTyD7AyOQ5
 XJOOY4FLXGaI5BOwNKmuazn2VgvYKAx/UJ9Ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755118515; x=1755723315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kMKsLqnS7pxl/akSwVG2HwBx4IPDgxvOqGHgZF0/Pl0=;
 b=XTL+9wXrLn3HXi3k4jQBqviBf1Nkhl6p+9udllGCsxS98kgfTSV7tcdRpiqv7tvtvp
 Wu05Q0f7MjXioeDr8BQuJpZwVrUTjw3GK1yY7+XFTMTnCKSlCVuvktfa4LPoG8amtynh
 GdW9xDldPeVTXSEUHwRHrpln/Kp+3w5meXNjxOX/v15J2JNIIqFZhU+BhAwha8VGBDMo
 aDwz5gIn+IBZPge6l5uWfq0N9VzFduH/oVQuploGz9KoxHjXxtOwiXAJq+lfpq3ARoNB
 0RMDQdAHQNDkRsm5aodBg2ciqXtwuyConxlV4WI4mCY9g57PM2qbzWhmSwCWQiQBFcWs
 DmHg==
X-Gm-Message-State: AOJu0Yy/YQeWGkNNL7i9bBCPiqOJqJd8Fh6ZgDK1afOc4hVEVMyX3whF
 fGE93va9JYXo3qPR/ESN3MY7KE3uX9hKJ5jArZA5sgBWZpaifwP9nenQAVOnHazuEEm3zL7qj93
 Z1pT/44A=
X-Gm-Gg: ASbGncvOteHHeP4/ozjgP0i1KVyHuTvFzxb52/Wzyy3no2NFfi5K1vaQVVyaICzM/kX
 GwEl58kRNipmAYZHuIIeqkO8jCE0AnLBsrA8YyymAZg7OdBBUTLFb1aRwZF+MVINyHd8v0pio/I
 etPRi2YtbL9N93qSvIBs/1eFl73vD6L7db2ch9TeNtBYSAzhGsrYm9gXlIh+Z+ZAXGDg9REZpEs
 L6vL70odwHm7dm1kYX/qU5pcjXWbbK1udOczHvtXI9lt7PQuuYypmlzb0qiFG36zHi8112Zqclw
 9XrhTTz6dPtkqLW/azS7gdwpoaVkIqU4kAGy8FZokuetdPQDXyduG9OEKrp/LxUwaZsSsDi/EDc
 ftnUlClBipYWM/+WuU2snFTGg5Unfl9WHQ8GIn6BxtPClE7hLDVkL+Ev6K2/9g6dXp6bPdg==
X-Google-Smtp-Source: AGHT+IF7oiGygOVFnFYSKLrLm8Q0EzW0t6JnpvlitqDSCsF1bbLyeK/d0SAXeW+spd/xBa2jYo0rfw==
X-Received: by 2002:a05:6808:4442:b0:435:72ab:27f2 with SMTP id
 5614622812f47-435df718c52mr418928b6e.13.1755118514961; 
 Wed, 13 Aug 2025 13:55:14 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-435ce8a91e3sm778597b6e.30.2025.08.13.13.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 13:55:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marius Dinu <m95d+git@psihoexpert.ro>
Subject: [PATCH 2/2] timer: Mark this as incompatible with SYS_ARCH_TIMER
Date: Wed, 13 Aug 2025 14:55:11 -0600
Message-ID: <20250813205511.3420638-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813205511.3420638-1-trini@konsulko.com>
References: <20250813205511.3420638-1-trini@konsulko.com>
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

The timers implemented under SYS_ARCH_TIMER are not part of the TIMER
framework and thus cannot be enabled at the same time. Express this
dependency in Kconfig and add a note to the help of SYS_ARCH_TIMER.

Reported-by: Marius Dinu <m95d+git@psihoexpert.ro>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Marius, I ended up reworking things a bit (and also found part 1/2 of
this series) but please let me know if you feel this should retain your
Author and such instead. Thanks!
---
 arch/arm/Kconfig      | 1 +
 drivers/timer/Kconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 73b4aad28b50..0dba2e2c8567 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -452,6 +452,7 @@ config SYS_ARCH_TIMER
 	  interface to a timer source on an SoC.
 	  It is mandatory for ARMv8 implementation and widely available
 	  on ARMv7 systems.
+	  This timer driver is incompatible with the DM timer framework.
 
 config ARM_SMCCC
 	bool "Support for ARM SMC Calling Convention (SMCCC)"
diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
index cb6fc0e7fda8..2ab4d971dffa 100644
--- a/drivers/timer/Kconfig
+++ b/drivers/timer/Kconfig
@@ -2,6 +2,7 @@ menu "Timer Support"
 
 config TIMER
 	bool "Enable driver model for timer drivers"
+	depends on !SYS_ARCH_TIMER
 	depends on DM
 	help
 	  Enable driver model for timer access. It uses the same API as
-- 
2.43.0

